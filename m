Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC75CD79
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGBKYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:18 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:43516 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbfGBKYS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:18 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:11 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:39 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:39 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:38 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:38 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 08/14] btrfs-progs: image: Introduce helper to determine if
 a tree block is in the range of system chunks
Thread-Topic: [PATCH v2 08/14] btrfs-progs: image: Introduce helper to
 determine if a tree block is in the range of system chunks
Thread-Index: AQHVML36Lo4wjeTYvUO6pXWLWq6Vew==
Date:   Tue, 2 Jul 2019 10:07:38 +0000
Message-ID: <20190702100650.2746-9-wqu@suse.com>
References: <20190702100650.2746-1-wqu@suse.com>
In-Reply-To: <20190702100650.2746-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0007.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::17) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [240e:3a1:c40:c630::a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e2c208-2c49-4372-4af3-08d6fed51cad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284E41D552B343324FD56E1D6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ORaZy8iwq3u6SAi9U4qEbiNlSxbAPq1CqTcvOtqBdlkgQmT3tLHBtrJ+ZAryqcUrXuwhX0h36VLBrVGsz6yAqUr5jR+mrpXUhQh+L5pvtFHh/pxX+q9Z4wRfhBOqTtNx2m0LttZRMxHVDYO0t8v+54ba3P8fyOFzvrd7PApr5UtseyM9VGEQARx4j9iuGgoN9cVZIZsXoYr2NSX4bZzxuUc+BDp1eo8q2+Rq3wF+WyBU4PMp4OBM9ij2phUfENrfwFZnstXrypHyNY1arl79sKVNxOnBp7SsWy4CNd8fSiRbn+pwchlFPt0GKl2HizhcazZrSPX8J9qRvOP9NApG0UZtRcCJOq/HvBYnsmgk4GA3CJ974Y/wRpE1g/b/KsNM+4ozf1ECUOLRI6ZxiD1t0jdb9l7Z1kGJicz4ubINQLw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e2c208-2c49-4372-4af3-08d6fed51cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:38.8378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqu@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3284
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper function, is_in_sys_chunks(), to determine if an
item is in the range of system chunks.

Since btrfs-image will merge adjacent same type extents into one item,
this function is designed to return true for any bytes in system chunk
range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/image/main.c b/image/main.c
index 29587c0171b8..3493ebc4589e 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1723,6 +1723,54 @@ static int wait_for_worker(struct mdrestore_struct *mdres)
 	return ret;
 }
 
+/*
+ * Check if a range [start ,start + len] has ANY bytes covered by
+ * system chunks ranges.
+ */
+static bool is_in_sys_chunks(struct mdrestore_struct *mdres, u64 start,
+			     u64 len)
+{
+	struct rb_node *node = mdres->sys_chunks.root.rb_node;
+	struct cache_extent *entry;
+	struct cache_extent *next;
+	struct cache_extent *prev;
+
+	if (start > mdres->sys_chunk_end)
+		return false;
+
+	while (node) {
+		entry = rb_entry(node, struct cache_extent, rb_node);
+		if (start > entry->start) {
+			if (!node->rb_right)
+				break;
+			node = node->rb_right;
+		} else if (start < entry->start) {
+			if (!node->rb_left)
+				break;
+			node = node->rb_left;
+		} else {
+			/* already in a system chunk */
+			return true;
+		}
+	}
+	if (!node)
+		return false;
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	/* Now we have entry which is the nearst chunk around @start */
+	if (start > entry->start) {
+		prev = entry;
+		next = next_cache_extent(entry);
+	} else {
+		prev = prev_cache_extent(entry);
+		next = entry;
+	}
+	if (prev && prev->start + prev->size > start)
+		return true;
+	if (next && start + len > next->start)
+		return true;
+	return false;
+}
+
 static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 			    u64 bytenr, u64 item_bytenr, u32 bufsize,
 			    u64 cluster_bytenr)
-- 
2.22.0

