//
//  DaySummaryView.swift
//  BioAge
//
//  Created by Gabons on 22/07/25.
//
import SwiftUI
import SwiftData

struct DaySumView: View {
    @Environment(\.colorScheme) private var colorScheme

    @Namespace private var cardNS
    @State private var isExpanded = false

    @Query private var todaysMeals: [Meal]
    @Query private var todaysActivities: [Activity]

    init() {
        let calendar = Calendar.current
        let today = Date()
        let startOfToday = calendar.startOfDay(for: today)
        let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: startOfToday)!

        _todaysActivities = Query(
            filter: #Predicate<Activity> { activity in
                activity.dateAdded >= startOfToday && activity.dateAdded < startOfTomorrow
            },
            sort: [SortDescriptor(\Activity.dateAdded, order: .reverse)]
        )

        _todaysMeals = Query(
            filter: #Predicate<Meal> { meal in
                meal.dateAdded >= startOfToday && meal.dateAdded < startOfTomorrow
            },
            sort: [SortDescriptor(\Meal.dateAdded, order: .reverse)]
        )
    }

    private var burnedCalories: Int {
        todaysActivities.reduce(0) { $0 + $1.calories }
    }
    
    private var intakeCalories: Int {
        todaysMeals.reduce(0) { $0 + $1.calories }
    }
    
    private var netCalories: Int {
        intakeCalories - burnedCalories
    }
    
    private var totalNumberOfProteins: Int {
        todaysMeals.reduce(0){ $0 + $1.protein}
    }
    
    private var totalNumberOfCarbs: Int {
        todaysMeals.reduce(0){ $0 + $1.carbs}
    }
    
    private var totalNumberOfFats: Int {
        todaysMeals.reduce(0){ $0 + $1.fat}
    }
    
    private var totalNumberOfFibers: Int {
        todaysMeals.reduce(0){ $0 + $1.fiber}
    }

    private var cardAnimation: Animation {
        if #available(iOS 17.0, *) {
            return .snappy(duration: 0.35, extraBounce: 0.2)
        } else {
            return .spring(response: 0.35, dampingFraction: 0.86, blendDuration: 0.2)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
          
            HStack(spacing: 12) {
                Text("Today")
                    .font(.system(size: 24, weight: .bold))
                    .matchedGeometryEffect(id: "title", in: cardNS)

                Spacer()

                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: "chevron", in: cardNS)
                    .accessibilityHidden(true)
            }

            summaryRows

            if isExpanded {
                Divider()
                    .padding(.top, 2)
                    .transition(.opacity.combined(with: .move(edge: .top)))

                expandedContent
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: isExpanded ? 18 : 12, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .matchedGeometryEffect(id: "bg", in: cardNS)
        )
        .overlay(
            RoundedRectangle(cornerRadius: isExpanded ? 18 : 12, style: .continuous)
                .stroke(Color(.separator).opacity(colorScheme == .dark ? 0.6 : 0.2), lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(colorScheme == .dark ? 0.30 : 0.08),
            radius: isExpanded ? 10 : 6,
            x: 0,
            y: isExpanded ? 6 : 2
        )
        .contentShape(Rectangle()) // make entire card tappable
        .onTapGesture {
            withAnimation(cardAnimation) {
                isExpanded.toggle()
            }
        }
        .animation(cardAnimation, value: isExpanded)
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Day summary")
        .accessibilityValue(isExpanded ? "Expanded" : "Collapsed")
    }

    // MARK: - Subviews

    private var summaryRows: some View {
        VStack(spacing: 12) {
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
            
            VStack(spacing: 6) {
                HStack {
                    Text("🔥 Burned")
                    Spacer()
                    Text("\(burnedCalories) kcal")
                        .foregroundStyle(.secondary)
                        .contentTransition(.numericText())
                }
                ProgressView(value: Double(burnedCalories) / 500.0)
                    .tint(.orange)
                    .opacity(0.5)
            }
            
            VStack(spacing: 6) {
                HStack {
                    Text("🍽️ Intake")
                    Spacer()
                    Text("\(intakeCalories) kcal")
                        .foregroundStyle(.secondary)
                        .contentTransition(.numericText())
                }
                ProgressView(value: Double(intakeCalories) / 2000.0)
                    .tint(.green)
                    .opacity(0.5)
            }
        }
        .font(.system(size: 18, weight: .medium, design: .rounded))
        .matchedGeometryEffect(id: "summary", in: cardNS)
    }

    private var expandedContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("Net", systemImage: "equal")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Text("\(netCalories >= 0 ? "+" : "")\(netCalories) kcal")
                    .foregroundStyle(netCalories >= 0 ? .green : .red)
                    .contentTransition(.numericText())
                    .font(.system(size: 16, weight: .semibold))
            }
            
            // Overall daily progress
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Goal Progress")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                ProgressView(value: 0.65)
                    .tint(.blue)
            }
            
            Divider()
                .opacity(0.5)
            
            // Quick stats grid
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
                    Text("\(self.totalNumberOfProteins)")
                        .fontWeight(.medium)
                }
                GridRow {
                    Text("Total carbs")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(totalNumberOfCarbs)")
                        .fontWeight(.medium)
                }
                GridRow {
                    Text("Total fats")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(totalNumberOfFats)")
                        .fontWeight(.medium)
                }
                GridRow {
                    Text("Total fibers")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(totalNumberOfFibers)")
                        .fontWeight(.medium)
                }
            }
            .font(.system(size: 15))
            // other details should be there
            
            //TODO move macro breakdown and here, we wanna make a new layout just for macros
       
        }
        .padding(.top, 4)
        .matchedGeometryEffect(id: "details", in: cardNS)
    }
}
