Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88F2D9941
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391037AbgLNNuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 08:50:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbgLNNuY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 08:50:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607953776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMsCwV0VykE2fA80nvtp3cYAPgQjbSKF/uGlq06gH7k=;
        b=KAAnfzt4i+gf+PhHNTkAZ+ZzoE6M7D4kbeSeSXWCZJU2ue0Dq0vDiGE7dg+XPthambUXv4
        10FkTGmIf5RiV61fml3gwgETTW1C+xHIvvhCbJppbzLj5gAsDbVo+9AtSjPuuJ7jZoUuIP
        wTgWzKPn+NEt3KM5fNaV0m1blIeaKfE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A48C5ADC1;
        Mon, 14 Dec 2020 13:49:36 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.de, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs-prog: check: Add support for ino cache deletion
Date:   Mon, 14 Dec 2020 15:49:35 +0200
Message-Id: <20201214134935.95469-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203081742.3759528-2-nborisov@suse.com>
References: <20201203081742.3759528-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inode cache feature is going to be removed in kernel 5.11. After this
kernel version items left on disk by this feature will take some extra
space. Testing showed that the size is actually negligible but for
completeness' sake give ability to users to remove such left-overs.

This is achieved by iterating every fs root and removing respective
items as well as relevant csum extents since the ino cache used the csum
tree for csums.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2:
 * Addressed feedback by David:
  - Shortened some lines and properly aligned statements where applicable
  - Adhere to proper documentation format
  - Use proper error handling in case of error instead of BUG_ON()


 Documentation/btrfs-check.asciidoc |   3 +
 check/main.c                       | 177 ++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-check.asciidoc b/Documentation/btrfs-check.asciidoc
index 1dd2c386ad09..c80cee9bfa1e 100644
--- a/Documentation/btrfs-check.asciidoc
+++ b/Documentation/btrfs-check.asciidoc
@@ -93,6 +93,9 @@ the entire free space cache. This option, with 'v2' provides an alternative
 method of clearing the free space cache that doesn't require mounting the
 filesystem.

+--clear-ino-cache ::
+remove leftover items pertaining to the deprecated inode map feature
+

 DANGEROUS OPTIONS
 -----------------
diff --git a/check/main.c b/check/main.c
index 28a1da61b068..0486f793d3c3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9977,6 +9977,167 @@ static int validate_free_space_cache(struct btrfs_root *root)
 	return ret ? -EINVAL : 0;
 }

+int truncate_free_ino_items(struct btrfs_root *root)
+{
+	struct btrfs_path path;
+	struct btrfs_key key = { .objectid = BTRFS_FREE_INO_OBJECTID,
+		.type = (u8)-1, .offset = (u64)-1};
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 0);
+	if (IS_ERR(trans)) {
+		error("Unable to start ino removal transaction");
+		return PTR_ERR(trans);
+	}
+
+	while (1) {
+		struct extent_buffer *leaf;
+		struct btrfs_file_extent_item *fi;
+		struct btrfs_key found_key;
+		u8 found_type;
+
+		btrfs_init_path(&path);
+		ret = btrfs_search_slot(trans, root, &key, &path, -1, 1);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		} else if (ret > 0) {
+			ret = 0;
+			/* No more items, finished truncating */
+			if (path.slots[0] == 0) {
+				btrfs_release_path(&path);
+				goto out;
+			}
+			path.slots[0]--;
+		}
+		fi = NULL;
+		leaf = path.nodes[0];
+		btrfs_item_key_to_cpu(leaf, &found_key, path.slots[0]);
+		found_type = found_key.type;
+
+		/* ino cache also has free space bitmaps in the fs stree */
+		if (found_key.objectid != BTRFS_FREE_INO_OBJECTID &&
+		    found_key.objectid != BTRFS_FREE_SPACE_OBJECTID) {
+			btrfs_release_path(&path);
+			/* Now delete the FREE_SPACE_OBJECTID */
+			if (key.objectid == BTRFS_FREE_INO_OBJECTID) {
+				key.objectid = BTRFS_FREE_SPACE_OBJECTID;
+				continue;
+			}
+			break;
+		}
+
+		if (found_type == BTRFS_EXTENT_DATA_KEY) {
+			int extent_type;
+			u64 extent_disk_bytenr;
+			u64 extent_num_bytes;
+			u64 extent_offset;
+
+			fi = btrfs_item_ptr(leaf, path.slots[0],
+					    struct btrfs_file_extent_item);
+			extent_type = btrfs_file_extent_type(leaf, fi);
+			ASSERT(extent_type == BTRFS_FILE_EXTENT_REG);
+			extent_disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+			extent_num_bytes = btrfs_file_extent_disk_num_bytes (leaf, fi);
+			extent_offset = found_key.offset -
+				btrfs_file_extent_offset(leaf, fi);
+			ASSERT(extent_offset == 0);
+			ret = btrfs_free_extent(trans, root, extent_disk_bytenr,
+						extent_num_bytes, 0, root->objectid,
+						BTRFS_FREE_INO_OBJECTID, 0);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				btrfs_release_path(&path);
+				goto out;
+			}
+
+			ret = btrfs_del_csums(trans, extent_disk_bytenr,
+					      extent_num_bytes);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				btrfs_release_path(&path);
+				goto out;
+			}
+		}
+
+		ret = btrfs_del_item(trans, root, &path);
+		BUG_ON(ret);
+		btrfs_release_path(&path);
+	}
+
+	btrfs_commit_transaction(trans, root);
+out:
+	return ret;
+}
+
+int clear_ino_cache_items(void)
+{
+	int ret;
+	struct btrfs_path path;
+	struct btrfs_key key;
+
+	key.objectid = BTRFS_FS_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key, &path,	0, 0);
+	if (ret < 0)
+		return ret;
+
+	while(1) {
+		struct btrfs_key found_key;
+
+		btrfs_item_key_to_cpu(path.nodes[0], &found_key, path.slots[0]);
+		if (found_key.type == BTRFS_ROOT_ITEM_KEY &&
+		    is_fstree(found_key.objectid)) {
+			struct btrfs_root *root;
+
+			found_key.offset = (u64)-1;
+			root = btrfs_read_fs_root(gfs_info, &found_key);
+			if (IS_ERR(root))
+				goto next;
+			ret = truncate_free_ino_items(root);
+			if (ret)
+				goto out;
+			printf("Successfully cleaned up ino cache for root id: %lld\n",
+					root->objectid);
+		} else {
+			/* If we get a negative tree this means it's the last one */
+			if ((s64)found_key.objectid < 0 &&
+			    found_key.type == BTRFS_ROOT_ITEM_KEY)
+				goto out;
+		}
+
+		/*
+		 * Only fs roots contain an ino cache information - either
+		 * FS_TREE_OBJECTID or subvol id >= BTRFS_FIRST_FREE_OBJECTID
+		 */
+next:
+		if (key.objectid == BTRFS_FS_TREE_OBJECTID) {
+			key.objectid = BTRFS_FIRST_FREE_OBJECTID;
+			btrfs_release_path(&path);
+			ret = btrfs_search_slot(NULL, gfs_info->tree_root, &key,
+						&path,	0, 0);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = btrfs_next_item(gfs_info->tree_root, &path);
+			if (ret < 0) {
+				goto out;
+			} else if (ret > 0) {
+				ret = 0;
+				goto out;
+			}
+		}
+	}
+
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static const char * const cmd_check_usage[] = {
 	"btrfs check [options] <device>",
 	"Check structural integrity of a filesystem (unmounted).",
@@ -10006,6 +10167,7 @@ static const char * const cmd_check_usage[] = {
 	"       --init-csum-tree            create a new CRC tree",
 	"       --init-extent-tree          create a new extent tree",
 	"       --clear-space-cache v1|v2   clear space cache for v1 or v2",
+	"       --clear-ino-cache 	    clear ino cache leftover items",
 	"  check and reporting options:",
 	"       --check-data-csum           verify checksums of data blocks",
 	"       -Q|--qgroup-report          print a report on qgroup consistency",
@@ -10030,6 +10192,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int init_csum_tree = 0;
 	int readonly = 0;
 	int clear_space_cache = 0;
+	int clear_ino_cache = 0;
 	int qgroup_report = 0;
 	int qgroups_repaired = 0;
 	int qgroup_verify_ret;
@@ -10042,7 +10205,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
 			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
 			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
-			GETOPT_VAL_FORCE };
+			GETOPT_VAL_CLEAR_INO_CACHE, GETOPT_VAL_FORCE };
 		static const struct option long_options[] = {
 			{ "super", required_argument, NULL, 's' },
 			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
@@ -10064,6 +10227,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				GETOPT_VAL_MODE },
 			{ "clear-space-cache", required_argument, NULL,
 				GETOPT_VAL_CLEAR_SPACE_CACHE},
+			{ "clear-ino-cache", no_argument , NULL,
+				GETOPT_VAL_CLEAR_INO_CACHE},
 			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
 			{ NULL, 0, NULL, 0}
 		};
@@ -10149,6 +10314,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 				}
 				ctree_flags |= OPEN_CTREE_WRITES;
 				break;
+			case GETOPT_VAL_CLEAR_INO_CACHE:
+				clear_ino_cache = 1;
+				ctree_flags |= OPEN_CTREE_WRITES;
+				break;
 			case GETOPT_VAL_FORCE:
 				force = 1;
 				break;
@@ -10264,6 +10433,12 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		goto close_out;
 	}

+	if (clear_ino_cache) {
+		ret = clear_ino_cache_items();
+		err = ret;
+		goto close_out;
+	}
+
 	/*
 	 * repair mode will force us to commit transaction which
 	 * will make us fail to load log tree when mounting.
--
2.25.1

