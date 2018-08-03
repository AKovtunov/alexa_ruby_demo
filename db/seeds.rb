3.times do |t|
  Project.create(
    title: "Title #{t}",
    budget: Random.rand(1000..10000),
    created_at: DateTime.now,
    updated_at: DateTime.now
  )
end

100.times do |t|
  acc = Account.create(
    full_name: "Worker #{t}",
    last_checked_date: DateTime.now.next_day( Random.rand(0..1) ),
    project_id: Project.order(Arel.sql("RANDOM()")).limit(1).first.id,
    role: ["manager", "developer", "designer", "admin", "director"][Random.rand(0..4)],

    created_at: DateTime.now,
    updated_at: DateTime.now
  )
  Invoice.create(
    price: Random.rand(500..3000),
    account_id: acc.id,
    closed: Random.rand(0..1),

    created_at: DateTime.now,
    updated_at: DateTime.now
  )
end

Project.find_each do |project|
  manager = Account.where(role: "manager").order(Arel.sql("RANDOM()")).limit(1).first
  project.update_attribute(:manager_id, manager.id)
end
