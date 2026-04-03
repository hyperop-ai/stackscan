# Pain Point Taxonomy

## How to use this document

**This is a CHECKLIST, not a classification system.** Don't force-fit user pains into taxonomy nodes. Instead:

1. **Listen first.** Detect pain points naturally from the user's description. Use their language, not taxonomy labels.
2. **Then probe for coverage.** After the user has described their pains, walk through the TOP-LEVEL categories below and ask yourself: "Did we miss any common pain in this category that this type of business probably has?"
3. **Surface hidden pains.** For each category the user DIDN'T mention, consider whether a pain likely exists but wasn't stated. Present it as an inferred pain: "Most [industry] businesses also struggle with [pain]. Does this apply to you?"
4. **Drive search queries.** When searching for tools, use the taxonomy LEAF DESCRIPTIONS to generate specific, targeted search queries. The leaf text implies what to search for.

**Do NOT:**
- Assign rigid taxonomy codes to user pains
- Force a pain into a node that doesn't fit
- Present the taxonomy structure to the user (it's internal)

**DO:**
- Use it to ensure you didn't miss obvious pain points
- Use leaf descriptions to generate better search queries
- Create new leaves when you find pains not covered

**Grounding:** Structured based on the [APQC Process Classification Framework](https://www.apqc.org/process-classification-framework) (PCF v7.3.0), adapted for SMB operational realities. APQC covers 1500+ enterprise processes — this taxonomy distills the ~100 most relevant to businesses with 1-50 people. When extending, consult APQC Level 3-4 process groups.

---

## 1. Business Operations — Data Management

### 1.1 Manual Data Entry

- **Double entry across systems** — Same data typed into 2+ tools separately (e.g., order details into both spreadsheet and invoicing tool)
- **Copy-paste between tools** — Manual transfer of data via clipboard from one application to another
- **Manual form filling** — Repeated entry of similar data into forms, often with minor variations per record
- **Manual data formatting** — Reformatting data (dates, currencies, addresses) to match each tool's expected format
- **Transcription from physical media** — Typing data from paper documents, business cards, or handwritten notes into digital systems

### 1.2 Data Inconsistency

- **No single source of truth** — Multiple copies of the same data exist with no authoritative version; nobody knows which is current
- **Conflicting records across systems** — Same entity (customer, product, order) has different values in different tools
- **Stale data** — Data that was once correct but hasn't been updated to reflect changes (prices, contact info, inventory levels)
- **No data validation rules** — Anyone can enter any value with no format or range checks, leading to garbage data
- **Inconsistent naming conventions** — Same item entered differently across records (abbreviations, typos, casing) making search and aggregation unreliable

### 1.3 Data Silos

- **No integrations between tools** — Each tool operates independently; data doesn't flow between them without human intervention
- **CSV dependency** — The only way to move data between systems is export-to-CSV then import, which is fragile and lossy
- **Information trapped in email** — Critical business data (orders, approvals, client requests) lives only in email inboxes, unsearchable by tools
- **Information trapped in chat** — Decisions, specs, and action items buried in Slack/Teams/WhatsApp threads with no structured extraction
- **Spreadsheet as database** — A spreadsheet serves as the primary data store for critical business data, with no relational integrity or concurrent access

### 1.4 Reporting

- **Manual report creation** — Reports built by hand (copy data into slides/docs) rather than generated automatically
- **No dashboards** — No real-time or near-real-time view of key business metrics; must query data manually each time
- **Cross-tool aggregation** — Producing a single report requires pulling data from 3+ tools and merging manually
- **No historical trend visibility** — Can see current state but not how metrics changed over time; no time-series data retained
- **Report delivery is manual** — Reports exist but must be emailed or shared manually rather than auto-distributed on a schedule

---

## 2. Business Operations — Financial Operations

### 2.1 Invoicing

- **Manual invoice creation** — Each invoice is created by hand: entering line items, client details, and amounts from scratch or from another source
- **No auto-generation from orders** — Orders come in (via e-commerce, email, phone) but invoices must be created separately rather than generated automatically
- **Compliance gaps** — Invoices missing legally required fields (tax ID, sequential numbering, required mentions) for the jurisdiction
- **Late payment tracking** — No automated system to detect overdue invoices and send reminders; relies on manual follow-up
- **No recurring invoicing** — Repeat clients billed for the same amount require creating a new invoice each cycle instead of auto-recurring
- **Multi-currency gaps** — Cannot issue invoices in the client's currency, or does so manually with error-prone exchange rate lookups

### 2.2 Expense Tracking

- **No tool spend visibility** — Nobody knows the total monthly cost of all software subscriptions across the business
- **Duplicate subscriptions** — Multiple people paying for the same tool, or paying for tools no one uses anymore
- **No budget alerts** — Spending can exceed budgets with no warning; overruns discovered only at month-end reconciliation
- **Manual expense categorization** — Each expense manually tagged or categorized rather than auto-classified by rules or ML
- **Receipt management chaos** — Paper receipts in drawers, photos in camera rolls, PDFs in email — no single system for expense documentation

### 2.3 Pricing

- **No dynamic pricing** — Prices are static and changed manually; no rules for volume discounts, seasonal adjustments, or demand-based pricing
- **Discount tracking gaps** — Discounts given ad hoc with no record of which clients got what discount or the total impact on margins
- **No A/B price testing** — No ability to test different price points to optimize revenue; pricing set by gut feel
- **Price inconsistency across channels** — Different prices on website, marketplace, and in-person with no sync mechanism
- **No margin visibility** — Prices set without clear view of per-product or per-service cost basis and resulting margins

### 2.4 Payment Processing

- **Manual reconciliation** — Matching incoming payments to invoices done by hand in a spreadsheet or ledger
- **Limited payment methods** — Can only accept 1-2 payment methods; losing sales from customers who prefer others
- **No recurring billing** — Subscription or retainer clients require manual invoicing each cycle rather than automated charge
- **No payment-to-accounting sync** — Payments received must be manually entered into accounting software
- **Refund processing is manual** — Refunds require manual steps across payment provider, accounting, and inventory systems

---

## 3. Business Operations — Customer Operations

### 3.1 Acquisition

- **Manual lead tracking** — Leads tracked in a spreadsheet, sticky notes, or memory rather than a structured system
- **No CRM** — No centralized system for managing customer relationships, history, and pipeline
- **Manual outbound** — Every outreach email or call is composed individually with no templates, sequences, or automation
- **No lead scoring** — All leads treated equally; no system to prioritize high-intent or high-value prospects
- **No lead source attribution** — Cannot tell which marketing channel or referral source generated which leads
- **No pipeline visibility** — Cannot see at a glance how many deals are at each stage or forecast revenue

### 3.2 Onboarding

- **Manual welcome sequences** — Each new customer gets a hand-crafted welcome email or onboarding flow rather than an automated sequence
- **No self-service onboarding** — Customers cannot get started without direct hand-holding from the team
- **Slow time-to-value** — It takes days or weeks for new customers to get the value they signed up for due to setup friction
- **No onboarding checklist** — No structured process ensuring every new customer gets the same complete setup experience
- **Repeated manual setup** — Same configuration steps performed manually for each new customer with no templates or automation

### 3.3 Support

- **No help desk** — Support requests arrive via email, chat, phone, and social with no centralized ticketing or tracking
- **No knowledge base** — Common questions answered individually each time; no self-service FAQ or documentation for customers
- **No SLA tracking** — No measurement of response times or resolution times; no alerts when service levels slip
- **No ticket prioritization** — All support requests treated as equal priority regardless of severity or customer value
- **Support context lost** — Agent handling a ticket has no view of the customer's history, past tickets, or account details

### 3.4 Retention

- **No churn prediction** — No signals or scoring to identify customers at risk of leaving before they leave
- **No usage analytics** — Cannot see how customers are using the product/service or whether engagement is declining
- **No NPS or satisfaction tracking** — No systematic measurement of customer satisfaction; feedback is anecdotal
- **No re-engagement campaigns** — Inactive customers are not contacted; they silently churn without intervention
- **No customer health scoring** — No composite metric combining usage, support tickets, payment history, and engagement to flag at-risk accounts

### 3.5 Expansion

- **No upsell detection** — Cannot identify when a customer is ready for or would benefit from a higher tier or additional service
- **No cross-sell recommendations** — No system to suggest complementary products or services based on purchase history
- **No referral program** — Satisfied customers have no structured way to refer others; word-of-mouth is entirely organic
- **No expansion revenue tracking** — Cannot measure how much revenue comes from existing customers buying more vs new customers

---

## 4. Business Operations — Team Operations

### 4.1 Communication

- **Scattered channels** — Conversations split across email, chat, text, phone, and in-person with no single thread of record
- **No async culture** — Everything requires real-time discussion; decisions stall when someone is unavailable
- **Meeting overload** — Too many meetings that could be emails, async updates, or documented decisions
- **No decision log** — Decisions made in meetings or chat but not recorded; same decisions re-discussed weeks later
- **Internal communication gaps** — Information known to one person or team not shared with others who need it

### 4.2 Task Management

- **No project tracking** — No system to see what's in progress, what's blocked, and what's done across projects
- **No delegation system** — Tasks assigned verbally or via chat with no tracking of who owns what and when it's due
- **No priority framework** — Everything is urgent; no system to distinguish what truly matters from what just feels urgent
- **No workload visibility** — Cannot see who is overloaded and who has capacity; work distribution is uneven
- **No recurring task automation** — Regular tasks (weekly reports, monthly checks) tracked manually rather than auto-created on schedule

### 4.3 HR / People

- **Manual time tracking** — Hours tracked on paper, in spreadsheets, or not at all; error-prone and tedious
- **No onboarding workflow** — New hires have no structured checklist; setup (accounts, tools, training) is ad hoc and incomplete
- **No performance tracking** — No system for goals, reviews, or feedback; performance assessment is entirely subjective
- **No leave management system** — Time-off requests handled via email or chat with no calendar integration or balance tracking
- **Manual payroll preparation** — Payroll data (hours, bonuses, deductions) compiled manually from multiple sources each pay period
- **No org chart or role clarity** — Unclear who reports to whom or who owns which responsibilities

### 4.4 Documentation

- **No internal knowledge base** — No central place where team members can find how things work; everything lives in people's heads
- **Tribal knowledge dependency** — Critical processes known only to one person; if they leave, the knowledge is lost
- **Stale documentation** — Docs exist but haven't been updated in months or years; following them leads to wrong outcomes
- **No SOPs** — Standard operating procedures don't exist; every person does the same task differently
- **No version history** — Documents edited with no record of what changed, when, or by whom; previous versions unrecoverable

---

## 5. Business Operations — Marketing Operations

### 5.1 Content

- **Manual social posting** — Each social media post composed and published individually in each platform's native interface
- **No content calendar** — No planned schedule for content; posts happen ad hoc when someone has time or an idea
- **No SEO strategy** — Website content created without keyword research, meta tags, or search optimization
- **No content repurposing** — Each piece of content created from scratch; a blog post is never turned into social posts, email, or video
- **No content performance tracking** — Content published with no measurement of views, engagement, or conversion impact

### 5.2 Email Marketing

- **Manual campaign creation** — Each email campaign built from scratch with no templates or reusable components
- **No segmentation** — All customers receive the same emails regardless of behavior, purchase history, or preferences
- **No email automation** — No triggered sequences (welcome series, abandoned cart, post-purchase); every email sent manually
- **No A/B testing** — Subject lines, content, and send times never tested; email strategy based on assumptions
- **No deliverability monitoring** — No tracking of bounce rates, spam complaints, or inbox placement; emails may not arrive

### 5.3 Analytics

- **No attribution modeling** — Cannot determine which marketing channels or campaigns drive actual revenue
- **No funnel tracking** — Cannot see where prospects drop off between awareness, consideration, and purchase
- **No cohort analysis** — Cannot compare behavior of customers acquired in different periods or through different channels
- **No conversion tracking** — Website or store visits not connected to actual purchases; marketing ROI unknown
- **Vanity metrics only** — Tracking followers, likes, and page views but not metrics tied to revenue or business outcomes

### 5.4 Brand

- **No design system** — Visual identity (colors, fonts, layouts) not codified; every new asset is designed from scratch
- **No digital asset management** — Logos, photos, and marketing materials scattered across drives, email, and desktops
- **Inconsistent brand identity** — Different visual styles, tones, and messages across channels; no brand guidelines enforced
- **No brand monitoring** — No awareness of what customers or competitors say about the brand online
- **No template library** — Common assets (proposals, presentations, social posts) recreated each time instead of starting from templates

---

## 6. Business Operations — Technical Operations

### 6.1 Infrastructure

- **Manual deployments** — Code or configuration changes deployed by hand via FTP, SSH, or copy-paste rather than automated pipelines
- **No monitoring** — No alerts when systems go down, slow down, or run out of resources; issues discovered by users
- **No CI/CD pipeline** — Code changes not automatically tested or deployed; manual testing and release process
- **No disaster recovery plan** — No backups, no failover, no documented recovery process; a failure means extended downtime
- **No environment separation** — Development, staging, and production are the same system or don't exist; testing happens in production

### 6.2 Security

- **No access management** — Shared passwords, no role-based access, former employees still have credentials
- **No audit logs** — No record of who did what and when in business-critical systems
- **No vulnerability scanning** — No automated detection of security weaknesses in tools, websites, or infrastructure
- **No compliance framework** — Regulatory requirements (GDPR, PCI, industry-specific) not mapped to current practices
- **No data backup verification** — Backups may exist but are never tested; recovery could fail when needed
- **No incident response plan** — No documented process for handling security breaches or data leaks

### 6.3 Integrations

- **No API connectivity** — Tools that could be connected via API are not; data flows manually instead
- **Manual data transfers** — Scheduled or ad hoc manual export/import between systems that could be automated
- **No webhooks configured** — Events in one system (new order, new signup) don't trigger actions in other systems
- **No iPaaS platform** — No integration platform (Zapier, Make, n8n) to bridge tools without custom code
- **Custom integrations unmaintained** — Integrations built once and never updated; they break silently when APIs change
- **No integration monitoring** — Automated data flows exist but nobody is alerted when they fail or produce errors

---

## Using This Taxonomy

### During pain point detection

For each pain the user describes:
1. Classify it to the most specific leaf that fits
2. If no leaf fits, create one (see seed taxonomy note above)
3. Record the classification as: `category.subcategory.leaf` (e.g., `financial-operations.invoicing.no-auto-from-orders`)

### During search query generation

Each taxonomy level implies different search strategies:

- **Category level** (broad): `"best [category] software for [business type]"`
- **Subcategory level** (focused): `"[subcategory] tools" on G2/Capterra filtered by size and budget`
- **Leaf level** (precise): `"[exact pain] automation"`, `"[existing tool] + [leaf capability] integration"`

### Compound pains

When multiple leaves from different categories co-occur, also search for tools
that address them together: `"all-in-one [leaf A] and [leaf B] for [industry]"`.
Compound matches score higher than individual matches (fewer tools = less overhead).

### Coverage check

After classifying all user-reported pains, walk the top two levels of categories
the user DIDN'T mention. For each subcategory, ask: "Does this business plausibly
have this pain?" If yes and it wasn't mentioned, probe during intake clarification.

---

## APQC Cross-Reference

| Taxonomy Category | Primary APQC Process Group |
|---|---|
| Data Management | 8.0 — Manage Information Technology |
| Financial Operations | 9.0 — Manage Financial Resources |
| Customer Operations | 3.0 — Market and Sell Products/Services, 5.0 — Manage Customer Service |
| Team Operations | 7.0 — Manage Human Capital, 11.0 — Manage Business Resilience |
| Marketing Operations | 3.0 — Market and Sell Products/Services |
| Technical Operations | 8.0 — Manage Information Technology, 11.0 — Manage Business Resilience |

APQC processes not directly covered by this taxonomy (e.g., 4.0 Deliver Products/Services,
6.0 Develop and Manage Human Capital, 10.0 Acquire and Manage Resources) may surface
as new leaves during analysis. Extend the taxonomy accordingly.
