Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F89207839
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404788AbgFXQD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:29 -0400
Received: from lists.nic.cz ([217.31.204.67]:47952 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404680AbgFXQD1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:27 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id F06561409CE;
        Wed, 24 Jun 2020 18:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014603; bh=bnOhtqnZZRfgF/wHU08aaDRzIogcnqodYTr25MMjnf8=;
        h=From:To:Date;
        b=nc6mnnEpW6Yneh4GjJ/MZUtprlGe1iO9dDFWOqCntTZhyG88N1s+Y9Vrf37CwXKuV
         mnZz07x66hpVsDEvnMxb5a62d8xs2L1L5gNSYL+/7hMikTV4YST1eTC8uilL8b/Uy6
         7UYt86whedJ+Sadqz7nVXQ3WdCmixqFR+Nb1hSl0=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 09/30] fs: btrfs: Crossport read_tree_block() from btrfs-progs
Date:   Wed, 24 Jun 2020 18:02:55 +0200
Message-Id: <20200624160316.5001-10-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

This is the one of the basic stone function for btrfs, which:
- Resolves the chunk mappings
- Reads data from disk
- Does various sanity check

With read_tree_block(), we can finally crossport needed btrfs btree
operations to U-Boot.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/ctree.c   | 188 +++++++++++++++++++++++-
 fs/btrfs/ctree.h   |  50 ++++++-
 fs/btrfs/disk-io.c | 348 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h |  18 ++-
 fs/btrfs/inode.c   |   6 +-
 5 files changed, 602 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1d8f7e168f..d97e195e5e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -42,7 +42,7 @@ u16 btrfs_csum_type_size(u16 csum_type)
 	return btrfs_csums[csum_type].size;
 }
 
-int btrfs_comp_keys(struct btrfs_key *a, struct btrfs_key *b)
+int __btrfs_comp_keys(struct btrfs_key *a, struct btrfs_key *b)
 {
 	if (a->objectid > b->objectid)
 		return 1;
@@ -82,7 +82,7 @@ static int generic_bin_search(void *addr, int item_size, struct btrfs_key *key,
 		mid = (low + high) / 2;
 
 		tmp = (struct btrfs_key *) ((u8 *) addr + mid*item_size);
-		ret = btrfs_comp_keys(tmp, key);
+		ret = __btrfs_comp_keys(tmp, key);
 
 		if (ret < 0) {
 			low = mid + 1;
@@ -321,3 +321,187 @@ int btrfs_next_slot(struct btrfs_path *p)
 	p->slots[0]++;
 	return 0;
 }
+
+int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2)
+{
+	if (k1->objectid > k2->objectid)
+		return 1;
+	if (k1->objectid < k2->objectid)
+		return -1;
+	if (k1->type > k2->type)
+		return 1;
+	if (k1->type < k2->type)
+		return -1;
+	if (k1->offset > k2->offset)
+		return 1;
+	if (k1->offset < k2->offset)
+		return -1;
+	return 0;
+}
+
+static int btrfs_comp_keys(struct btrfs_disk_key *disk,
+			     const struct btrfs_key *k2)
+{
+	struct btrfs_key k1;
+
+	btrfs_disk_key_to_cpu(&k1, disk);
+	return btrfs_comp_cpu_keys(&k1, k2);
+}
+
+enum btrfs_tree_block_status
+btrfs_check_node(struct btrfs_fs_info *fs_info,
+		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
+{
+	int i;
+	struct btrfs_key cpukey;
+	struct btrfs_disk_key key;
+	u32 nritems = btrfs_header_nritems(buf);
+	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+
+	if (nritems == 0 || nritems > BTRFS_NODEPTRS_PER_BLOCK(fs_info))
+		goto fail;
+
+	ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
+	if (parent_key && parent_key->type) {
+		btrfs_node_key(buf, &key, 0);
+		if (memcmp(parent_key, &key, sizeof(key)))
+			goto fail;
+	}
+	ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
+	for (i = 0; nritems > 1 && i < nritems - 2; i++) {
+		btrfs_node_key(buf, &key, i);
+		btrfs_node_key_to_cpu(buf, &cpukey, i + 1);
+		if (btrfs_comp_keys(&key, &cpukey) >= 0)
+			goto fail;
+	}
+	return BTRFS_TREE_BLOCK_CLEAN;
+fail:
+	return ret;
+}
+
+enum btrfs_tree_block_status
+btrfs_check_leaf(struct btrfs_fs_info *fs_info,
+		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf)
+{
+	int i;
+	struct btrfs_key cpukey;
+	struct btrfs_disk_key key;
+	u32 nritems = btrfs_header_nritems(buf);
+	enum btrfs_tree_block_status ret = BTRFS_TREE_BLOCK_INVALID_NRITEMS;
+
+	if (nritems * sizeof(struct btrfs_item) > buf->len)  {
+		fprintf(stderr, "invalid number of items %llu\n",
+			(unsigned long long)buf->start);
+		goto fail;
+	}
+
+	if (btrfs_header_level(buf) != 0) {
+		ret = BTRFS_TREE_BLOCK_INVALID_LEVEL;
+		fprintf(stderr, "leaf is not a leaf %llu\n",
+		       (unsigned long long)btrfs_header_bytenr(buf));
+		goto fail;
+	}
+	if (btrfs_leaf_free_space(buf) < 0) {
+		ret = BTRFS_TREE_BLOCK_INVALID_FREE_SPACE;
+		fprintf(stderr, "leaf free space incorrect %llu %d\n",
+			(unsigned long long)btrfs_header_bytenr(buf),
+			btrfs_leaf_free_space(buf));
+		goto fail;
+	}
+
+	if (nritems == 0)
+		return BTRFS_TREE_BLOCK_CLEAN;
+
+	btrfs_item_key(buf, &key, 0);
+	if (parent_key && parent_key->type &&
+	    memcmp(parent_key, &key, sizeof(key))) {
+		ret = BTRFS_TREE_BLOCK_INVALID_PARENT_KEY;
+		fprintf(stderr, "leaf parent key incorrect %llu\n",
+		       (unsigned long long)btrfs_header_bytenr(buf));
+		goto fail;
+	}
+	for (i = 0; nritems > 1 && i < nritems - 1; i++) {
+		btrfs_item_key(buf, &key, i);
+		btrfs_item_key_to_cpu(buf, &cpukey, i + 1);
+		if (btrfs_comp_keys(&key, &cpukey) >= 0) {
+			ret = BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
+			fprintf(stderr, "bad key ordering %d %d\n", i, i+1);
+			goto fail;
+		}
+		if (btrfs_item_offset_nr(buf, i) !=
+			btrfs_item_end_nr(buf, i + 1)) {
+			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+			fprintf(stderr, "incorrect offsets %u %u\n",
+				btrfs_item_offset_nr(buf, i),
+				btrfs_item_end_nr(buf, i + 1));
+			goto fail;
+		}
+		if (i == 0 && btrfs_item_end_nr(buf, i) !=
+		    BTRFS_LEAF_DATA_SIZE(fs_info)) {
+			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+			fprintf(stderr, "bad item end %u wanted %u\n",
+				btrfs_item_end_nr(buf, i),
+				(unsigned)BTRFS_LEAF_DATA_SIZE(fs_info));
+			goto fail;
+		}
+	}
+
+	for (i = 0; i < nritems; i++) {
+		if (btrfs_item_end_nr(buf, i) >
+				BTRFS_LEAF_DATA_SIZE(fs_info)) {
+			btrfs_item_key(buf, &key, 0);
+			ret = BTRFS_TREE_BLOCK_INVALID_OFFSETS;
+			fprintf(stderr, "slot end outside of leaf %llu > %llu\n",
+				(unsigned long long)btrfs_item_end_nr(buf, i),
+				(unsigned long long)BTRFS_LEAF_DATA_SIZE(
+					fs_info));
+			goto fail;
+		}
+	}
+
+	return BTRFS_TREE_BLOCK_CLEAN;
+fail:
+	return ret;
+}
+
+/*
+ * how many bytes are required to store the items in a leaf.  start
+ * and nr indicate which items in the leaf to check.  This totals up the
+ * space used both by the item structs and the item data
+ */
+static int leaf_space_used(struct extent_buffer *l, int start, int nr)
+{
+	int data_len;
+	int nritems = btrfs_header_nritems(l);
+	int end = min(nritems, start + nr) - 1;
+
+	if (!nr)
+		return 0;
+	data_len = btrfs_item_end_nr(l, start);
+	data_len = data_len - btrfs_item_offset_nr(l, end);
+	data_len += sizeof(struct btrfs_item) * nr;
+	WARN_ON(data_len < 0);
+	return data_len;
+}
+
+/*
+ * The space between the end of the leaf items and
+ * the start of the leaf data.  IOW, how much room
+ * the leaf has left for both items and data
+ */
+int btrfs_leaf_free_space(struct extent_buffer *leaf)
+{
+	int nritems = btrfs_header_nritems(leaf);
+	u32 leaf_data_size;
+	int ret;
+
+	BUG_ON(leaf->fs_info && leaf->fs_info->nodesize != leaf->len);
+	leaf_data_size = __BTRFS_LEAF_DATA_SIZE(leaf->len);
+	ret = leaf_data_size - leaf_space_used(leaf, 0 ,nritems);
+	if (ret < 0) {
+		printk("leaf free space ret %d, leaf data size %u, used %d nritems %d\n",
+		       ret, leaf_data_size, leaf_space_used(leaf, 0, nritems),
+		       nritems);
+	}
+	return ret;
+}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c746d3fd45..7f024c0145 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -59,6 +59,16 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
+enum btrfs_tree_block_status {
+	BTRFS_TREE_BLOCK_CLEAN,
+	BTRFS_TREE_BLOCK_INVALID_NRITEMS,
+	BTRFS_TREE_BLOCK_INVALID_PARENT_KEY,
+	BTRFS_TREE_BLOCK_BAD_KEY_ORDER,
+	BTRFS_TREE_BLOCK_INVALID_LEVEL,
+	BTRFS_TREE_BLOCK_INVALID_FREE_SPACE,
+	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
+};
+
 struct btrfs_device;
 struct btrfs_fs_devices;
 struct btrfs_fs_info {
@@ -88,6 +98,35 @@ struct btrfs_fs_info {
 	u32 stripesize;
 };
 
+static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
+}
+
+static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
+}
+
+static inline u32 BTRFS_NODEPTRS_PER_EXTENT_BUFFER(const struct extent_buffer *eb)
+{
+	BUG_ON(eb->fs_info && eb->fs_info->nodesize != eb->len);
+	return __BTRFS_LEAF_DATA_SIZE(eb->len) / sizeof(struct btrfs_key_ptr);
+}
+
+#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
+	(offsetof(struct btrfs_file_extent_item, disk_bytenr))
+static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) -
+		BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
+}
+
 /*
  * File system states
  */
@@ -1149,7 +1188,7 @@ struct btrfs_root {
 	u64 root_dirid;
 };
 
-int btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
+int __btrfs_comp_keys(struct btrfs_key *, struct btrfs_key *);
 int btrfs_comp_keys_type(struct btrfs_key *, struct btrfs_key *);
 int btrfs_bin_search(union btrfs_tree_node *, struct btrfs_key *, int *);
 void btrfs_free_path(struct btrfs_path *);
@@ -1209,4 +1248,13 @@ const char *btrfs_super_csum_name(u16 csum_type);
 u16 btrfs_csum_type_size(u16 csum_type);
 size_t btrfs_super_num_csums(void);
 
+/* ctree.c */
+int btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
+enum btrfs_tree_block_status
+btrfs_check_node(struct btrfs_fs_info *fs_info,
+		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
+enum btrfs_tree_block_status
+btrfs_check_leaf(struct btrfs_fs_info *fs_info,
+		 struct btrfs_disk_key *parent_key, struct extent_buffer *buf);
+int btrfs_leaf_free_space(struct extent_buffer *leaf);
 #endif /* __BTRFS_CTREE_H__ */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index edebf741fd..65b4020ebe 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -7,8 +7,113 @@
 #include "disk-io.h"
 #include "ctree.h"
 #include "btrfs.h"
+#include "volumes.h"
+#include "extent-io.h"
 #include "crypto/hash.h"
 
+/* specified errno for check_tree_block */
+#define BTRFS_BAD_BYTENR		(-1)
+#define BTRFS_BAD_FSID			(-2)
+#define BTRFS_BAD_LEVEL			(-3)
+#define BTRFS_BAD_NRITEMS		(-4)
+
+/* Calculate max possible nritems for a leaf/node */
+static u32 max_nritems(u8 level, u32 nodesize)
+{
+
+	if (level == 0)
+		return ((nodesize - sizeof(struct btrfs_header)) /
+			sizeof(struct btrfs_item));
+	return ((nodesize - sizeof(struct btrfs_header)) /
+		sizeof(struct btrfs_key_ptr));
+}
+
+static int check_tree_block(struct btrfs_fs_info *fs_info,
+			    struct extent_buffer *buf)
+{
+
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	u32 nodesize = fs_info->nodesize;
+	bool fsid_match = false;
+	int ret = BTRFS_BAD_FSID;
+
+	if (buf->start != btrfs_header_bytenr(buf))
+		return BTRFS_BAD_BYTENR;
+	if (btrfs_header_level(buf) >= BTRFS_MAX_LEVEL)
+		return BTRFS_BAD_LEVEL;
+	if (btrfs_header_nritems(buf) > max_nritems(btrfs_header_level(buf),
+						    nodesize))
+		return BTRFS_BAD_NRITEMS;
+
+	/* Only leaf can be empty */
+	if (btrfs_header_nritems(buf) == 0 &&
+	    btrfs_header_level(buf) != 0)
+		return BTRFS_BAD_NRITEMS;
+
+	while (fs_devices) {
+		/*
+		 * Checking the incompat flag is only valid for the current
+		 * fs. For seed devices it's forbidden to have their uuid
+		 * changed so reading ->fsid in this case is fine
+		 */
+		if (fs_devices == fs_info->fs_devices &&
+		    btrfs_fs_incompat(fs_info, METADATA_UUID))
+			fsid_match = !memcmp_extent_buffer(buf,
+						   fs_devices->metadata_uuid,
+						   btrfs_header_fsid(),
+						   BTRFS_FSID_SIZE);
+		else
+			fsid_match = !memcmp_extent_buffer(buf,
+						    fs_devices->fsid,
+						    btrfs_header_fsid(),
+						    BTRFS_FSID_SIZE);
+
+
+		if (fsid_match) {
+			ret = 0;
+			break;
+		}
+		fs_devices = fs_devices->seed;
+	}
+	return ret;
+}
+
+static void print_tree_block_error(struct btrfs_fs_info *fs_info,
+				struct extent_buffer *eb,
+				int err)
+{
+	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = {'\0'};
+	char found_uuid[BTRFS_UUID_UNPARSED_SIZE] = {'\0'};
+	u8 buf[BTRFS_UUID_SIZE];
+
+	if (!err)
+		return;
+
+	fprintf(stderr, "bad tree block %llu, ", eb->start);
+	switch (err) {
+	case BTRFS_BAD_FSID:
+		read_extent_buffer(eb, buf, btrfs_header_fsid(),
+				   BTRFS_UUID_SIZE);
+		uuid_unparse(buf, found_uuid);
+		uuid_unparse(fs_info->fs_devices->metadata_uuid, fs_uuid);
+		fprintf(stderr, "fsid mismatch, want=%s, have=%s\n",
+			fs_uuid, found_uuid);
+		break;
+	case BTRFS_BAD_BYTENR:
+		fprintf(stderr, "bytenr mismatch, want=%llu, have=%llu\n",
+			eb->start, btrfs_header_bytenr(eb));
+		break;
+	case BTRFS_BAD_LEVEL:
+		fprintf(stderr, "bad level, %u > %d\n",
+			btrfs_header_level(eb), BTRFS_MAX_LEVEL);
+		break;
+	case BTRFS_BAD_NRITEMS:
+		fprintf(stderr, "invalid nr_items: %u\n",
+			btrfs_header_nritems(eb));
+		break;
+	}
+}
+
 int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 {
 	memset(out, 0, BTRFS_CSUM_SIZE);
@@ -233,3 +338,246 @@ int btrfs_read_superblock(void)
 
 	return 0;
 }
+
+static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
+				  int verify, int silent, u16 csum_type)
+{
+	u8 result[BTRFS_CSUM_SIZE];
+	u32 len;
+
+	len = buf->len - BTRFS_CSUM_SIZE;
+	btrfs_csum_data(csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE,
+			result, len);
+
+	if (verify) {
+		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
+			/* FIXME: format */
+			if (!silent)
+				printk("checksum verify failed on %llu found %08X wanted %08X\n",
+				       (unsigned long long)buf->start,
+				       result[0],
+				       buf->data[0]);
+			return 1;
+		}
+	} else {
+		write_extent_buffer(buf, result, 0, csum_size);
+	}
+	return 0;
+}
+
+int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify,
+			 u16 csum_type)
+{
+	return __csum_tree_block_size(buf, csum_size, verify, 0, csum_type);
+}
+
+static int csum_tree_block(struct btrfs_fs_info *fs_info,
+			   struct extent_buffer *buf, int verify)
+{
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+
+	return csum_tree_block_size(buf, csum_size, verify, csum_type);
+}
+
+struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
+					    u64 bytenr, u32 blocksize)
+{
+	return find_extent_buffer(&fs_info->extent_cache,
+				  bytenr, blocksize);
+}
+
+struct extent_buffer* btrfs_find_create_tree_block(
+		struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	return alloc_extent_buffer(fs_info, bytenr, fs_info->nodesize);
+}
+
+static int verify_parent_transid(struct extent_io_tree *io_tree,
+				 struct extent_buffer *eb, u64 parent_transid,
+				 int ignore)
+{
+	int ret;
+
+	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
+		return 0;
+
+	if (extent_buffer_uptodate(eb) &&
+	    btrfs_header_generation(eb) == parent_transid) {
+		ret = 0;
+		goto out;
+	}
+	printk("parent transid verify failed on %llu wanted %llu found %llu\n",
+	       (unsigned long long)eb->start,
+	       (unsigned long long)parent_transid,
+	       (unsigned long long)btrfs_header_generation(eb));
+	if (ignore) {
+		eb->flags |= EXTENT_BAD_TRANSID;
+		printk("Ignoring transid failure\n");
+		return 0;
+	}
+
+	ret = 1;
+out:
+	clear_extent_buffer_uptodate(eb);
+	return ret;
+
+}
+
+int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
+{
+	int ret;
+
+	ret = extent_buffer_uptodate(buf);
+	if (!ret)
+		return ret;
+
+	ret = verify_parent_transid(&buf->fs_info->extent_cache, buf,
+				    parent_transid, 1);
+	return !ret;
+}
+
+int btrfs_set_buffer_uptodate(struct extent_buffer *eb)
+{
+	return set_extent_buffer_uptodate(eb);
+}
+
+int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror)
+{
+	unsigned long offset = 0;
+	struct btrfs_multi_bio *multi = NULL;
+	struct btrfs_device *device;
+	int ret = 0;
+	u64 read_len;
+	unsigned long bytes_left = eb->len;
+
+	while (bytes_left) {
+		read_len = bytes_left;
+		device = NULL;
+
+		ret = btrfs_map_block(info, READ, eb->start + offset,
+				      &read_len, &multi, mirror, NULL);
+		if (ret) {
+			printk("Couldn't map the block %Lu\n", eb->start + offset);
+			kfree(multi);
+			return -EIO;
+		}
+		device = multi->stripes[0].dev;
+
+		if (!device->desc || !device->part) {
+			kfree(multi);
+			return -EIO;
+		}
+
+		if (read_len > bytes_left)
+			read_len = bytes_left;
+
+		ret = read_extent_from_disk(device->desc, device->part,
+					    multi->stripes[0].physical, eb,
+					    offset, read_len);
+		kfree(multi);
+		multi = NULL;
+
+		if (ret)
+			return -EIO;
+		offset += read_len;
+		bytes_left -= read_len;
+	}
+	return 0;
+}
+
+struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
+		u64 parent_transid)
+{
+	int ret;
+	struct extent_buffer *eb;
+	u64 best_transid = 0;
+	u32 sectorsize = fs_info->sectorsize;
+	int mirror_num = 1;
+	int good_mirror = 0;
+	int candidate_mirror = 0;
+	int num_copies;
+	int ignore = 0;
+
+	/*
+	 * Don't even try to create tree block for unaligned tree block
+	 * bytenr.
+	 * Such unaligned tree block will free overlapping extent buffer,
+	 * causing use-after-free bugs for fuzzed images.
+	 */
+	if (bytenr < sectorsize || !IS_ALIGNED(bytenr, sectorsize)) {
+		error("tree block bytenr %llu is not aligned to sectorsize %u",
+		      bytenr, sectorsize);
+		return ERR_PTR(-EIO);
+	}
+
+	eb = btrfs_find_create_tree_block(fs_info, bytenr);
+	if (!eb)
+		return ERR_PTR(-ENOMEM);
+
+	if (btrfs_buffer_uptodate(eb, parent_transid))
+		return eb;
+
+	num_copies = btrfs_num_copies(fs_info, eb->start, eb->len);
+	while (1) {
+		ret = read_whole_eb(fs_info, eb, mirror_num);
+		if (ret == 0 && csum_tree_block(fs_info, eb, 1) == 0 &&
+		    check_tree_block(fs_info, eb) == 0 &&
+		    verify_parent_transid(&fs_info->extent_cache, eb,
+					  parent_transid, ignore) == 0) {
+			/*
+			 * check_tree_block() is less strict to allow btrfs
+			 * check to get raw eb with bad key order and fix it.
+			 * But we still need to try to get a good copy if
+			 * possible, or bad key order can go into tools like
+			 * btrfs ins dump-tree.
+			 */
+			if (btrfs_header_level(eb))
+				ret = btrfs_check_node(fs_info, NULL, eb);
+			else
+				ret = btrfs_check_leaf(fs_info, NULL, eb);
+			if (!ret || candidate_mirror == mirror_num) {
+				btrfs_set_buffer_uptodate(eb);
+				return eb;
+			}
+			if (candidate_mirror <= 0)
+				candidate_mirror = mirror_num;
+		}
+		if (ignore) {
+			if (candidate_mirror > 0) {
+				mirror_num = candidate_mirror;
+				continue;
+			}
+			if (check_tree_block(fs_info, eb))
+				print_tree_block_error(fs_info, eb,
+						check_tree_block(fs_info, eb));
+			else
+				fprintf(stderr, "Csum didn't match\n");
+			ret = -EIO;
+			break;
+		}
+		if (num_copies == 1) {
+			ignore = 1;
+			continue;
+		}
+		if (btrfs_header_generation(eb) > best_transid) {
+			best_transid = btrfs_header_generation(eb);
+			good_mirror = mirror_num;
+		}
+		mirror_num++;
+		if (mirror_num > num_copies) {
+			if (candidate_mirror > 0)
+				mirror_num = candidate_mirror;
+			else
+				mirror_num = good_mirror;
+			ignore = 1;
+			continue;
+		}
+	}
+	/*
+	 * We failed to read this tree block, it be should deleted right now
+	 * to avoid stale cache populate the cache.
+	 */
+	free_extent_buffer(eb);
+	return ERR_PTR(ret);
+}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 35b9293946..ca731a5245 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -10,9 +10,23 @@
 #define BTRFS_SUPER_INFO_OFFSET SZ_64K
 #define BTRFS_SUPER_INFO_SIZE	SZ_4K
 
-int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
+/* U-boot specific */
+int btrfs_read_superblock(void);
+
+/* From btrfs-progs */
+int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirror);
+struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
+		u64 parent_transid);
 
+struct extent_buffer* btrfs_find_create_tree_block(
+		struct btrfs_fs_info *fs_info, u64 bytenr);
+struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
+					    u64 bytenr, u32 blocksize);
 int btrfs_read_dev_super(struct blk_desc *desc, struct disk_partition *part,
 			 struct btrfs_super_block *sb);
-int btrfs_read_superblock(void);
+int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
+int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
+int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
+			 int verify, u16 csum_type);
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d88ae67217..55f431a289 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -65,7 +65,7 @@ int btrfs_lookup_inode(const struct btrfs_root *root,
 	if (btrfs_search_tree(&tmp_root, location, &path))
 		return res;
 
-	if (btrfs_comp_keys(location, btrfs_path_leaf_key(&path)))
+	if (__btrfs_comp_keys(location, btrfs_path_leaf_key(&path)))
 		goto out;
 
 	if (item) {
@@ -98,7 +98,7 @@ int btrfs_readlink(const struct btrfs_root *root, u64 inr, char *target)
 	if (btrfs_search_tree(root, &key, &path))
 		return -1;
 
-	if (btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)))
+	if (__btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)))
 		goto out;
 
 	extent = btrfs_path_item_ptr(&path, struct btrfs_file_extent_item);
@@ -333,7 +333,7 @@ u64 btrfs_file_read(const struct btrfs_root *root, u64 inr, u64 offset,
 	if (btrfs_search_tree(root, &key, &path))
 		return -1ULL;
 
-	if (btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)) < 0) {
+	if (__btrfs_comp_keys(&key, btrfs_path_leaf_key(&path)) < 0) {
 		if (btrfs_prev_slot(&path))
 			goto out;
 
-- 
2.26.2

