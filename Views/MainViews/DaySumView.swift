import SwiftUI
import SwiftData

struct DaySumView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var viewModel = DaySumViewModel()
    @Namespace private var cardNS

    @Query private var todaysMeals: [Meal]
    @Query private var todaysActivities: [Activity]

    init() {
        let viewModel = DaySumViewModel()
        
        _todaysActivities = Query(
            filter: #Predicate<Activity> { activity in
                activity.dateAdded >= viewModel.startOfToday && activity.dateAdded < viewModel.startOfTomorrow
            },
            sort: [SortDescriptor(\Activity.dateAdded, order: .reverse)]
        )

        _todaysMeals = Query(
            filter: #Predicate<Meal> { meal in
                meal.dateAdded >= viewModel.startOfToday && meal.dateAdded < viewModel.startOfTomorrow
            },
            sort: [SortDescriptor(\Meal.dateAdded, order: .reverse)]
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            headerView
            summaryRows

            if viewModel.isExpanded {
                Divider()
                    .padding(.top, 2)
                    .transition(.opacity.combined(with: .move(edge: .top)))

                expandedContent
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(cardBackground)
        .overlay(cardBorder)
        .shadow(
            color: Color.black.opacity(colorScheme == .dark ? 0.30 : 0.08),
            radius: viewModel.isExpanded ? 10 : 6,
            x: 0,
            y: viewModel.isExpanded ? 6 : 2
        )
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(viewModel.cardAnimation) {
                viewModel.toggleExpansion()
            }
        }
        .animation(viewModel.cardAnimation, value: viewModel.isExpanded)
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Day summary")
        .accessibilityValue(viewModel.isExpanded ? "Expanded" : "Collapsed")
    }

    // MARK: - Subviews
    
    private var headerView: some View {
        HStack(spacing: 12) {
            Text("Today")
                .font(.system(size: 24, weight: .bold))
                .matchedGeometryEffect(id: "title", in: cardNS)

            Spacer()

            Image(systemName: viewModel.isExpanded ? "chevron.up" : "chevron.down")
                .font(.headline)
                .foregroundStyle(.secondary)
                .matchedGeometryEffect(id: "chevron", in: cardNS)
                .accessibilityHidden(true)
        }
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: viewModel.isExpanded ? 18 : 12, style: .continuous)
            .fill(Color(.secondarySystemBackground))
            .matchedGeometryEffect(id: "bg", in: cardNS)
    }
    
    private var cardBorder: some View {
        RoundedRectangle(cornerRadius: viewModel.isExpanded ? 18 : 12, style: .continuous)
            .stroke(Color(.separator).opacity(colorScheme == .dark ? 0.6 : 0.2), lineWidth: 1)
    }

    private var summaryRows: some View {
        VStack(spacing: 12) {
            sleepRow
            burnedCaloriesRow
            intakeCaloriesRow
        }
        .font(.system(size: 18, weight: .medium, design: .rounded))
        .matchedGeometryEffect(id: "summary", in: cardNS)
    }
    
    private var sleepRow: some View {
        VStack(spacing: 6) {
            HStack {
                Text("🌙 Sleep")
                Spacer()
                Text("7 hours")
                    .foregroundStyle(.secondary)
                    .contentTransition(.opacity)
            }
            ProgressView(value: 0.7)
                .tint(.blue)
                .opacity(0.5)
        }
    }
    
    private var burnedCaloriesRow: some View {
        VStack(spacing: 6) {
            HStack {
                Text("🔥 Burned")
                Spacer()
                Text("\(viewModel.burnedCalories(from: todaysActivities)) kcal")
                    .foregroundStyle(.secondary)
                    .contentTransition(.numericText())
            }
            ProgressView(value: viewModel.burnedCaloriesProgress(
                burnedCalories: viewModel.burnedCalories(from: todaysActivities)
            ))
            .tint(.orange)
            .opacity(0.5)
        }
    }
    
    private var intakeCaloriesRow: some View {
        VStack(spacing: 6) {
            HStack {
                Text("🍽️ Intake")
                Spacer()
                Text("\(viewModel.intakeCalories(from: todaysMeals)) kcal")
                    .foregroundStyle(.secondary)
                    .contentTransition(.numericText())
            }
            ProgressView(value: viewModel.intakeCaloriesProgress(
                intakeCalories: viewModel.intakeCalories(from: todaysMeals)
            ))
            .tint(.green)
            .opacity(0.5)
        }
    }

    private var expandedContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            netCaloriesView
            dailyProgressView
            
            Divider()
                .opacity(0.5)
            
            statisticsGrid
        }
        .padding(.top, 4)
        .matchedGeometryEffect(id: "details", in: cardNS)
    }
    
    private var netCaloriesView: some View {
        HStack {
            Label("Net", systemImage: "equal")
                .font(.system(size: 16, weight: .medium))
            Spacer()
            
            let netCals = viewModel.netCalories(from: todaysMeals, activities: todaysActivities)
            Text("\(netCals >= 0 ? "+" : "")\(netCals) kcal")
                .foregroundStyle(netCals >= 0 ? .green : .red)
                .contentTransition(.numericText())
                .font(.system(size: 16, weight: .semibold))
        }
    }
    
    private var dailyProgressView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Daily Goal Progress")
                .font(.caption)
                .foregroundStyle(.secondary)
            ProgressView(value: viewModel.dailyGoalProgress())
                .tint(.blue)
        }
    }
    
    private var statisticsGrid: some View {
        Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 10) {
            GridRow {
                Text("Meals today")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(todaysMeals.count)")
                    .fontWeight(.medium)
                    .contentTransition(.numericText())
            }
            GridRow {
                Text("Activities today")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(todaysActivities.count)")
                    .fontWeight(.medium)
                    .contentTransition(.numericText())
            }
            GridRow {
                Text("Total proteins")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(viewModel.totalProteins(from: todaysMeals))")
                    .fontWeight(.medium)
            }
            GridRow {
                Text("Total carbs")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(viewModel.totalCarbs(from: todaysMeals))")
                    .fontWeight(.medium)
            }
            GridRow {
                Text("Total fats")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(viewModel.totalFats(from: todaysMeals))")
                    .fontWeight(.medium)
            }
            GridRow {
                Text("Total fibers")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(viewModel.totalFibers(from: todaysMeals))")
                    .fontWeight(.medium)
            }
        }
        .font(.system(size: 15))
    }
}
