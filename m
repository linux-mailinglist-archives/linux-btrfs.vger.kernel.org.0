Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B73E5CD78
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGBKYP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:15 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:50094 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfGBKYO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:14 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:10 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:36 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:36 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:35 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:35 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 07/14] btrfs-progs: image: Allow restore to record system
 chunk ranges for later usage
Thread-Topic: [PATCH v2 07/14] btrfs-progs: image: Allow restore to record
 system chunk ranges for later usage
Thread-Index: AQHVML34XA0IRdsIS0+mXWL+6Fe7eg==
Date:   Tue, 2 Jul 2019 10:07:35 +0000
Message-ID: <20190702100650.2746-8-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: 0f47adde-7a22-4d99-7d57-08d6fed51a94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284D8EE57484FA53278A96BD6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qz4etUb6unG7rmsC58wQcBM7xWplxXAlB112drxf9GoIyuzDJFBL0cPoEeTSSMzr11oX729yQWusTleSp4fBWQcn8tz/G78OKPSrAWVhhcIq68thcvFrJZG10+ya9wVI20k554aDDXHNuiBNWyvXPwf/FrDQMdIhJQfPMHPx7fKYc0UHOhNRWb3vuVU94PbV/XkI201ZKRcX7nCOADXuQnSt0YGQimsET9Bif6HN+WOtzcwbE7ujMHgmOehiERDBzP9Mc4E0ZhERCyWyFtiFwXoWnpaqdK4gcYYduaPnydTeB6a+YmDdHdQlnrw+kr3Vc1LMMIbYIJWKsV3FzXCPUg0K2hmVuHT3fggqnxqcqGP3rbpwHdD8gObDTGz6cHD4LX0zV0YasQdEudAjEWLO1ukSBcB8Q9QXHACf+liX+Gc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f47adde-7a22-4d99-7d57-08d6fed51a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:35.3138
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

Currently we are doing a pretty slow search for system chunks before
restoring real data.
The current behavior is to search all clusters for chunk tree root
first, then search all clusters again and again for every chunk tree
block.

This causes recursive calls and pretty slow start up, the only good news
is since chunk tree are normally small, we don't need to iterate too
many times, thus overall it's acceptable.

To address such bad behavior, we could take usage of system chunk array
in the super block.
By recording all system chunks ranges, we could easily determine if an
extent belongs to chunk tree, thus do one loop simple linear search for
chunk tree leaves.

This patch only introduces the code base for later patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/image/main.c b/image/main.c
index 04d914d14a66..29587c0171b8 100644
--- a/image/main.c
+++ b/image/main.c
@@ -35,6 +35,7 @@
 #include "utils.h"
 #include "volumes.h"
 #include "extent_io.h"
+#include "extent-cache.h"
 #include "help.h"
 #include "image/metadump.h"
 #include "image/sanitize.h"
@@ -112,6 +113,11 @@ struct mdrestore_struct {
 	pthread_mutex_t mutex;
 	pthread_cond_t cond;
 
+	/*
+	 * Records system chunk ranges, so restore can use this to determine
+	 * if an item is in chunk tree range.
+	 */
+	struct cache_tree sys_chunks;
 	struct rb_root chunk_tree;
 	struct rb_root physical_tree;
 	struct list_head list;
@@ -121,6 +127,8 @@ struct mdrestore_struct {
 	u64 devid;
 	u64 alloced_chunks;
 	u64 last_physical_offset;
+	/* An quicker checker for if a item is in sys chunk range */
+	u64 sys_chunk_end;
 	u8 uuid[BTRFS_UUID_SIZE];
 	u8 fsid[BTRFS_FSID_SIZE];
 
@@ -1487,6 +1495,7 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 		rb_erase(&entry->p, &mdres->physical_tree);
 		free(entry);
 	}
+	free_extent_cache_tree(&mdres->sys_chunks);
 	pthread_mutex_lock(&mdres->mutex);
 	mdres->done = 1;
 	pthread_cond_broadcast(&mdres->cond);
@@ -1550,6 +1559,7 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 	pthread_mutex_init(&mdres->mutex, NULL);
 	INIT_LIST_HEAD(&mdres->list);
 	INIT_LIST_HEAD(&mdres->overlapping_chunks);
+	cache_tree_init(&mdres->sys_chunks);
 	mdres->in = in;
 	mdres->out = out;
 	mdres->old_restore = old_restore;
@@ -1968,6 +1978,92 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	return ret;
 }
 
+/*
+ * Add system chunks in super blocks into mdres->sys_chunks, so later
+ * we can determine if an item is a chunk tree block.
+ */
+static int add_sys_array(struct mdrestore_struct *mdres,
+			 struct btrfs_super_block *sb)
+{
+	struct btrfs_disk_key *disk_key;
+	struct btrfs_key key;
+	struct btrfs_chunk *chunk;
+	struct cache_extent *cache;
+	u32 cur_offset;
+	u32 len = 0;
+	u32 array_size;
+	u8 *array_ptr;
+	int ret;
+
+	array_size = btrfs_super_sys_array_size(sb);
+	array_ptr = sb->sys_chunk_array;
+	cur_offset = 0;
+
+	while (cur_offset < array_size) {
+		u32 num_stripes;
+
+		disk_key = (struct btrfs_disk_key *)array_ptr;
+		len = sizeof(*disk_key);
+		if (cur_offset + len > array_size)
+			goto out_short_read;
+		btrfs_disk_key_to_cpu(&key, disk_key);
+
+		array_ptr += len;
+		cur_offset += len;
+
+		if (key.type == BTRFS_CHUNK_ITEM_KEY) {
+			chunk = (struct btrfs_chunk *)array_ptr;
+
+			/*
+			 * At least one btrfs_chunk with one stripe must be
+			 * present, exact stripe count check comes afterwards
+			 */
+			len = btrfs_chunk_item_size(1);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+			num_stripes = btrfs_stack_chunk_num_stripes(chunk);
+			if (!num_stripes) {
+				printk(
+	    "ERROR: invalid number of stripes %u in sys_array at offset %u\n",
+					num_stripes, cur_offset);
+				ret = -EIO;
+				break;
+			}
+			len = btrfs_chunk_item_size(num_stripes);
+			if (cur_offset + len > array_size)
+				goto out_short_read;
+			if (btrfs_stack_chunk_type(chunk) &
+			    BTRFS_BLOCK_GROUP_SYSTEM) {
+				ret = add_merge_cache_extent(&mdres->sys_chunks,
+					key.offset,
+					btrfs_stack_chunk_length(chunk));
+				if (ret < 0)
+					break;
+			}
+		} else {
+			error("unexpected item type %u in sys_array offset %u",
+			      key.type, cur_offset);
+			ret = -EUCLEAN;
+			break;
+		}
+		array_ptr += len;
+		cur_offset += len;
+	}
+
+	/* Get the last system chunk end as a quicker check */
+	cache = last_cache_extent(&mdres->sys_chunks);
+	if (!cache) {
+		error("no system chunk found in super block");
+		return -EUCLEAN;
+	}
+	mdres->sys_chunk_end = cache->start + cache->size - 1;
+	return ret;
+out_short_read:
+	error("sys_array too short to read %u bytes at offset %u\n",
+		len, cur_offset);
+	return -EUCLEAN;
+}
+
 static int build_chunk_tree(struct mdrestore_struct *mdres,
 			    struct meta_cluster *cluster)
 {
@@ -2060,6 +2156,13 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		error("invalid superblock");
 		return ret;
 	}
+	ret = add_sys_array(mdres, super);
+	if (ret < 0) {
+		error("failed to read system chunk array");
+		free(buffer);
+		pthread_mutex_unlock(&mdres->mutex);
+		return ret;
+	}
 	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
-- 
2.22.0

