Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12075CD7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 12:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBKYV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 2 Jul 2019 06:24:21 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:36308 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfGBKYV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 06:24:21 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Tue,  2 Jul 2019 10:24:13 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 10:07:44 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 10:07:43 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3284.namprd18.prod.outlook.com (10.255.137.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 10:07:42 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::45a9:4750:5868:9bbe%5]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 10:07:42 +0000
From:   WenRuo Qu <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     WenRuo Qu <wqu@suse.com>
Subject: [PATCH v2 09/14] btrfs-progs: image: Rework how we search chunk tree
 blocks
Thread-Topic: [PATCH v2 09/14] btrfs-progs: image: Rework how we search chunk
 tree blocks
Thread-Index: AQHVML38kDOYWiJrREelV+jLfK6t4A==
Date:   Tue, 2 Jul 2019 10:07:42 +0000
Message-ID: <20190702100650.2746-10-wqu@suse.com>
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
x-ms-office365-filtering-correlation-id: e8ac88c6-7c3d-4591-0745-08d6fed51ec5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3284;
x-ms-traffictypediagnostic: BY5PR18MB3284:
x-microsoft-antispam-prvs: <BY5PR18MB3284810E3E0D31D897E74C1CD6F80@BY5PR18MB3284.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(189003)(199004)(6116002)(476003)(36756003)(50226002)(68736007)(486006)(1076003)(6486002)(2501003)(2616005)(478600001)(8676002)(66476007)(66556008)(73956011)(66946007)(256004)(64756008)(66446008)(14444005)(30864003)(2906002)(2351001)(102836004)(86362001)(53936002)(7736002)(6436002)(386003)(6506007)(186003)(71190400001)(5640700003)(6916009)(46003)(71200400001)(107886003)(5660300002)(305945005)(316002)(14454004)(6512007)(99286004)(8936002)(25786009)(4326008)(11346002)(76176011)(52116002)(446003)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3284;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iruNZkeGIYDBG3c7a1UGzXDU4AYf2v1welMZTbQUHpjwfVogQtJVnyI2NBXZORpzwxKhaaqthp3t0J1Ct0O/t9c7MIiPUUiAhfAKndbVXIuF5/Oym/D2N3tWPI9THCNyo8NKjD1BSqdd7nYrKU2bPMtGf5LurVBCIbItoqVJUM0POJiwL5lZdU8QrFdYGJzrNXuhYc+X5LqcL1mTBju8/ItV6QK+bKlhV8gdj6QRwt46oYNXyQcteYGAJyhJx7IBJTQGEGnmGZb3QnVOo5pg2mCOGLvH4cHeYe5+eZxWWjatAhELGVu4t+SEd/qhJeFYMLU5U/uuJ469C/yCA9vclXmPia/qZiTPJUV82wi2qIa5FRau77KeuuuHfaSB+f6ByBe8wbHXVbTUgKyYNgTfEY+3sPu6eKzmTI4paZipyws=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac88c6-7c3d-4591-0745-08d6fed51ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 10:07:42.7835
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

Before this patch, we were using a very inefficient way to search
chunks:

We iterate through all clusters to find the chunk root tree block first,
then re-iterate all clusters again to find every child tree blocks.

Every time we need to iterate all clusters just to find a chunk tree
block.
This is obviously inefficient, specially when chunk tree get larger.
So the original author leaves a comment on it:
  /* If you have to ask you aren't worthy */
  static int search_for_chunk_blocks()

This patch will change the behavior so that we will only iterate all
clusters once.

The idea behind the optimization is, since we have the superblock
restored first, we could use the CHUNK_ITEMs in
super_block::sys_chunk_array to build a SYSTEM chunk mapping.

Then when we start to iterate through all items, we can easily skip
unrelated items at different level:
- At cluster level
  If a cluster starts beyond last system chunk map, it must not contain
  any chunk tree blocks (as chunk tree blocks only lives inside system
  chunks)

- At item level
  If one item has no intersection with any system chunk map, then it
  must not contain any tree blocks.

By this, we can iterate through all clusters just once, and find out all
CHUNK_ITEMs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 214 +++++++++++++++++++++++++++------------------------
 1 file changed, 115 insertions(+), 99 deletions(-)

diff --git a/image/main.c b/image/main.c
index 3493ebc4589e..fc5806e4e4bc 100644
--- a/image/main.c
+++ b/image/main.c
@@ -142,8 +142,6 @@ struct mdrestore_struct {
 	struct btrfs_fs_info *info;
 };
 
-static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
-				   u64 search, u64 cluster_bytenr);
 static struct extent_buffer *alloc_dummy_eb(u64 bytenr, u32 size);
 
 static void csum_block(u8 *buf, size_t len)
@@ -1771,67 +1769,17 @@ static bool is_in_sys_chunks(struct mdrestore_struct *mdres, u64 start,
 	return false;
 }
 
-static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
-			    u64 bytenr, u64 item_bytenr, u32 bufsize,
-			    u64 cluster_bytenr)
+static int read_chunk_tree_block(struct mdrestore_struct *mdres,
+				 struct extent_buffer *eb)
 {
-	struct extent_buffer *eb;
-	int ret = 0;
 	int i;
 
-	eb = alloc_dummy_eb(bytenr, mdres->nodesize);
-	if (!eb) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	while (item_bytenr != bytenr) {
-		buffer += mdres->nodesize;
-		item_bytenr += mdres->nodesize;
-	}
-
-	memcpy(eb->data, buffer, mdres->nodesize);
-	if (btrfs_header_bytenr(eb) != bytenr) {
-		error("eb bytenr does not match found bytenr: %llu != %llu",
-				(unsigned long long)btrfs_header_bytenr(eb),
-				(unsigned long long)bytenr);
-		ret = -EIO;
-		goto out;
-	}
-
-	if (memcmp(mdres->fsid, eb->data + offsetof(struct btrfs_header, fsid),
-		   BTRFS_FSID_SIZE)) {
-		error("filesystem metadata UUID of eb %llu does not match",
-				(unsigned long long)bytenr);
-		ret = -EIO;
-		goto out;
-	}
-
-	if (btrfs_header_owner(eb) != BTRFS_CHUNK_TREE_OBJECTID) {
-		error("wrong eb %llu owner %llu",
-				(unsigned long long)bytenr,
-				(unsigned long long)btrfs_header_owner(eb));
-		ret = -EIO;
-		goto out;
-	}
-
 	for (i = 0; i < btrfs_header_nritems(eb); i++) {
 		struct btrfs_chunk *chunk;
 		struct fs_chunk *fs_chunk;
 		struct btrfs_key key;
 		u64 type;
 
-		if (btrfs_header_level(eb)) {
-			u64 blockptr = btrfs_node_blockptr(eb, i);
-
-			ret = search_for_chunk_blocks(mdres, blockptr,
-						      cluster_bytenr);
-			if (ret)
-				break;
-			continue;
-		}
-
-		/* Yay a leaf!  We loves leafs! */
 		btrfs_item_key_to_cpu(eb, &key, i);
 		if (key.type != BTRFS_CHUNK_ITEM_KEY)
 			continue;
@@ -1839,8 +1787,7 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		fs_chunk = malloc(sizeof(struct fs_chunk));
 		if (!fs_chunk) {
 			error("not enough memory to allocate chunk");
-			ret = -ENOMEM;
-			break;
+			return -ENOMEM;
 		}
 		memset(fs_chunk, 0, sizeof(*fs_chunk));
 		chunk = btrfs_item_ptr(eb, i, struct btrfs_chunk);
@@ -1849,19 +1796,18 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		fs_chunk->physical = btrfs_stripe_offset_nr(eb, chunk, 0);
 		fs_chunk->bytes = btrfs_chunk_length(eb, chunk);
 		INIT_LIST_HEAD(&fs_chunk->list);
+
 		if (tree_search(&mdres->physical_tree, &fs_chunk->p,
 				physical_cmp, 1) != NULL)
 			list_add(&fs_chunk->list, &mdres->overlapping_chunks);
 		else
 			tree_insert(&mdres->physical_tree, &fs_chunk->p,
 				    physical_cmp);
-
 		type = btrfs_chunk_type(eb, chunk);
 		if (type & BTRFS_BLOCK_GROUP_DUP) {
 			fs_chunk->physical_dup =
 					btrfs_stripe_offset_nr(eb, chunk, 1);
 		}
-
 		if (fs_chunk->physical_dup + fs_chunk->bytes >
 		    mdres->last_physical_offset)
 			mdres->last_physical_offset = fs_chunk->physical_dup +
@@ -1876,19 +1822,80 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 			mdres->alloced_chunks += fs_chunk->bytes;
 		tree_insert(&mdres->chunk_tree, &fs_chunk->l, chunk_cmp);
 	}
-out:
+	return 0;
+}
+
+static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
+			    u64 item_bytenr, u32 bufsize,
+			    u64 cluster_bytenr)
+{
+	struct extent_buffer *eb;
+	u32 nodesize = mdres->nodesize;
+	u64 bytenr;
+	size_t cur_offset;
+	int ret = 0;
+
+	eb = alloc_dummy_eb(0, mdres->nodesize);
+	if (!eb)
+		return -ENOMEM;
+
+	for (cur_offset = 0; cur_offset < bufsize; cur_offset += nodesize) {
+		bytenr = item_bytenr + cur_offset;
+		if (!is_in_sys_chunks(mdres, bytenr, nodesize))
+			continue;
+		memcpy(eb->data, buffer + cur_offset, nodesize);
+		if (btrfs_header_bytenr(eb) != bytenr) {
+			error(
+			"eb bytenr does not match found bytenr: %llu != %llu",
+				(unsigned long long)btrfs_header_bytenr(eb),
+				(unsigned long long)bytenr);
+			ret = -EUCLEAN;
+			break;
+		}
+		if (memcmp(mdres->fsid, eb->data +
+			   offsetof(struct btrfs_header, fsid),
+		    BTRFS_FSID_SIZE)) {
+			error(
+			"filesystem metadata UUID of eb %llu does not match",
+				bytenr);
+			ret = -EUCLEAN;
+			break;
+		}
+		if (btrfs_header_owner(eb) != BTRFS_CHUNK_TREE_OBJECTID) {
+			error("wrong eb %llu owner %llu",
+				(unsigned long long)bytenr,
+				(unsigned long long)btrfs_header_owner(eb));
+			ret = -EUCLEAN;
+			break;
+		}
+		/*
+		 * No need to search node, as we will iterate all tree blocks
+		 * in chunk tree, only need to bother leaves.
+		 */
+		if (btrfs_header_level(eb))
+			continue;
+		ret = read_chunk_tree_block(mdres, eb);
+		if (ret < 0)
+			break;
+	}
 	free(eb);
 	return ret;
 }
 
-/* If you have to ask you aren't worthy */
-static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
-				   u64 search, u64 cluster_bytenr)
+/*
+ * This function will try to find all chunk items in the dump image.
+ *
+ * This function will iterate all clusters, and find any item inside
+ * system chunk ranges.
+ * For such item, it will try to read them as tree blocks, and find
+ * CHUNK_ITEMs, add them to @mdres.
+ */
+static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 {
 	struct meta_cluster *cluster;
 	struct meta_cluster_header *header;
 	struct meta_cluster_item *item;
-	u64 current_cluster = cluster_bytenr, bytenr;
+	u64 current_cluster = 0, bytenr;
 	u64 item_bytenr;
 	u32 bufsize, nritems, i;
 	u32 max_size = current_version->max_pending_size * 2;
@@ -1919,30 +1926,27 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	}
 
 	bytenr = current_cluster;
+	/* Main loop, iterating all clusters */
 	while (1) {
 		if (fseek(mdres->in, current_cluster, SEEK_SET)) {
 			error("seek failed: %m");
 			ret = -EIO;
-			break;
+			goto out;
 		}
 
 		ret = fread(cluster, BLOCK_SIZE, 1, mdres->in);
 		if (ret == 0) {
-			if (cluster_bytenr != 0) {
-				cluster_bytenr = 0;
-				current_cluster = 0;
-				bytenr = 0;
-				continue;
-			}
+			if (feof(mdres->in))
+				goto out;
 			error(
 	"unknown state after reading cluster at %llu, probably corrupted data",
-					cluster_bytenr);
+					current_cluster);
 			ret = -EIO;
-			break;
+			goto out;
 		} else if (ret < 0) {
 			error("unable to read image at %llu: %m",
-					(unsigned long long)cluster_bytenr);
-			break;
+					current_cluster);
+			goto out;
 		}
 		ret = 0;
 
@@ -1951,11 +1955,17 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 		    le64_to_cpu(header->bytenr) != current_cluster) {
 			error("bad header in metadump image");
 			ret = -EIO;
-			break;
+			goto out;
 		}
 
+		/* We're already over the system chunk end, no need to search*/
+		if (current_cluster > mdres->sys_chunk_end)
+			goto out;
+
 		bytenr += BLOCK_SIZE;
 		nritems = le32_to_cpu(header->nritems);
+
+		/* Search items for tree blocks in sys chunks */
 		for (i = 0; i < nritems; i++) {
 			size_t size;
 
@@ -1963,11 +1973,23 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 			bufsize = le32_to_cpu(item->size);
 			item_bytenr = le64_to_cpu(item->bytenr);
 
-			if (bufsize > max_size) {
-				error("item %u too big: %u > %u", i, bufsize,
-						max_size);
-				ret = -EIO;
-				break;
+			/*
+			 * Only data extent/free space cache can be that big,
+			 * adjacent tree blocks won't be able to be merged
+			 * beyond max_size.
+			 * Also, we can skip super block.
+			 */
+			if (bufsize > max_size ||
+			    !is_in_sys_chunks(mdres, item_bytenr, bufsize) ||
+			    item_bytenr == BTRFS_SUPER_INFO_OFFSET) {
+				ret = fseek(mdres->in, bufsize, SEEK_CUR);
+				if (ret < 0) {
+					error("failed to seek: %m");
+					ret = -errno;
+					goto out;
+				}
+				bytenr += bufsize;
+				continue;
 			}
 
 			if (mdres->compress_method == COMPRESS_ZLIB) {
@@ -1975,7 +1997,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 				if (ret != 1) {
 					error("read error: %m");
 					ret = -EIO;
-					break;
+					goto out;
 				}
 
 				size = max_size;
@@ -1986,40 +2008,36 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 					error("decompression failed with %d",
 							ret);
 					ret = -EIO;
-					break;
+					goto out;
 				}
 			} else {
 				ret = fread(buffer, bufsize, 1, mdres->in);
 				if (ret != 1) {
 					error("read error: %m");
 					ret = -EIO;
-					break;
+					goto out;
 				}
 				size = bufsize;
 			}
 			ret = 0;
 
-			if (item_bytenr <= search &&
-			    item_bytenr + size > search) {
-				ret = read_chunk_block(mdres, buffer, search,
-						       item_bytenr, size,
-						       current_cluster);
-				if (!ret)
-					ret = 1;
-				break;
+			ret = read_chunk_block(mdres, buffer,
+					       item_bytenr, size,
+					       current_cluster);
+			if (ret < 0) {
+				error(
+	"failed to search tree blocks in item bytenr %llu size %lu",
+					item_bytenr, size);
+				goto out;
 			}
 			bytenr += bufsize;
 		}
-		if (ret) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
 		if (bytenr & BLOCK_MASK)
 			bytenr += BLOCK_SIZE - (bytenr & BLOCK_MASK);
 		current_cluster = bytenr;
 	}
 
+out:
 	free(tmp);
 	free(buffer);
 	free(cluster);
@@ -2118,7 +2136,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	struct btrfs_super_block *super;
 	struct meta_cluster_header *header;
 	struct meta_cluster_item *item = NULL;
-	u64 chunk_root_bytenr = 0;
 	u32 i, nritems;
 	u64 bytenr = 0;
 	u8 *buffer;
@@ -2211,7 +2228,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		pthread_mutex_unlock(&mdres->mutex);
 		return ret;
 	}
-	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
 	    BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
@@ -2224,7 +2240,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	free(buffer);
 	pthread_mutex_unlock(&mdres->mutex);
 
-	return search_for_chunk_blocks(mdres, chunk_root_bytenr, 0);
+	return search_for_chunk_blocks(mdres);
 }
 
 static int range_contains_super(u64 physical, u64 bytes)
-- 
2.22.0

