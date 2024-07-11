Return-Path: <linux-btrfs+bounces-6402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A627792F107
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DFAB23582
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECD19FA86;
	Thu, 11 Jul 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gnErCehR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWXFF4ZS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13B19FA6F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732784; cv=none; b=DhE0K8yBZ0whwYCTAazy84BM4iHHEtt8UAsUprjJOskbM8Cjw04IYo+VQLggxxD+1sbuDpFMnzYU8mBr+KgefuJvZfatd3FYAs8bRxlrpafZbOj9yxswTF00881Mk+4emWvhOdiR8VRlj7Nyr3OT6ZG/vTi5uaH8Uq+PLnlPojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732784; c=relaxed/simple;
	bh=Yrwjqn/xX5LPCbpW71XbqnzYQI6TRRtrlggGhdpXjOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEznbvOEMiS6KPRdivulTyySnhJtDXpZQmdKTJyyAGyYSDF5xWnU019oVwNL4MWMPn50u6OMPChnq9lg8IXPSuK3E4WLmGgVtyCJPmAmppscr1kR3lEUFhr6cteU6w184TV1CLyLCWFqVEfnUw3bX+8eJyB8F+sv+kFUJaaid6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gnErCehR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWXFF4ZS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D415F1388370;
	Thu, 11 Jul 2024 17:19:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 11 Jul 2024 17:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1720732781; x=
	1720819181; bh=VjwUK5XgXOH2JCtxQQ07tVl+/J/VlONkkOgEybl2zus=; b=g
	nErCehRfKP7Ar5GvNxdCg2UNhtfqxeQmOR2jVrBQO95QUfdAZI19evmT5JaCzNoQ
	WUFuvYnSYRaw+fwc6BcN0mHLtDeRiCnP+kB3HArQHC9RYZ6rpY6EBqaK9z+9qr92
	Vnszaq/FMLKsO44V/ckIc7Xsz1BeB5POp7QD/fy+PDcReL7JgeQbwBeHDRTx7cIe
	8ZQ81OEtGcdC5si8pXrZB8nbi+LmqNKx0mZSRx4t5SPJDqFeG2necgOFVo6pqlv6
	Mb8IGGEz3fsp2uS22T8cOoR51lzFNNdbTODomnSQ4E5nqLDyP4iCLZDRIbcxMeb9
	EUv0H4P30EiYY9BceLjkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1720732781; x=1720819181; bh=VjwUK5XgXOH2J
	CtxQQ07tVl+/J/VlONkkOgEybl2zus=; b=JWXFF4ZS8VN0hjjBNXYJucIqIWfcx
	HI1io5XfGlbqTCB670VoPjkPf1L+K92nMGVcOUzweB1vu+GcbmQ4ptE5WQcqlEwv
	G6OpUhSZPo+GkjwaSfxuEOf0PMula8GzzakpgYvrud2vb7hSZ4sSTzhCmPCd9mPU
	84IekJ+aOJ0HRcSwqZH06Et3s/TA3qtEeEVC96sUDl3M7QrSQwPO9wKUAFk53yB/
	qlEUPhC0Ssu4ee9OyijLGSSnId1CMLNJ0APiFAssMzd8lt8VVH2sGN4Wzi3Lg3AR
	RFJ+ETkIRUCPi78kbWiHk7vg3h10w8oMESScLCLGaZa3dg5JkxFSm18Cw==
X-ME-Sender: <xms:bEyQZqHg64wUjeUf_99vH8mWw-u-mCDBTtBtQDgkiJv7E7TNDpBZdw>
    <xme:bEyQZrVmoeY3QbB_aoHIUoVMvWW338NOtHMydlG9Hmnj7dvd8U100r7Yy8-HW1kIv
    4ilbTOVBlg2uzrWAas>
X-ME-Received: <xmr:bEyQZkKxO9F8ODF6-qmE5PTg8JTEK4t2Vvi2YaJ5nEDAZoBGp-cuYc4OlULDDUPPQmL3f9BsUGccAfbBxymQZ1N0yWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:bEyQZkExZ6HcblA7lgA0hhgSesGpMrvvcvt0czR96yAwEcTvG5NVHQ>
    <xmx:bEyQZgUjYHHl2RZCouuEwx6xLtPd-HYX6sR99_N6P6MNR0pqM-ivMA>
    <xmx:bEyQZnMD6MSHdWkAh9YVFRAGU3yte0NXnTY5y6q_f1yCr77e-Mrlfw>
    <xmx:bEyQZn1bhKRJGg6AzjdweQbk7rDQdCUJ-21gar9aY73qmpVYBJJfRQ>
    <xmx:bUyQZtirqDppgnL0eHwLhWwxTe1DE7A-RJQEhWEUQ9lo4Z4CEKByL5dX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:19:40 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 3/3] btrfs-progs: btrfstune: add ability to remove squotas
Date: Thu, 11 Jul 2024 14:18:24 -0700
Message-ID: <df9f78c02b2d6d1effb4fca36ce76606d2609045.1720732480.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720732480.git.boris@bur.io>
References: <cover.1720732480.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simple quotas is enabled, every new data extent gets a special
inline OWNER_REF item that identifies the owning subvolume. This makes
simple quotas backwards incompatible with kernels older than v6.7. Even
if you disable quotas on the filesystem, the OWNER_REF items are
sprinkled throughout the extent tree and older kernels are unable to
parse them.

However, it is relatively easy to simply walk the extent tree and remove
these inline ref items. This gives squota adopters the option to *fully*
disable squotas on their system and un-set the incompat bit. Add this
capability to btrfstune, which requires only a little tricky btrfs item
data shifting.

This functionality was tested with a new unit test, as well as a similar
but more thorough integration test in fstests

Signed-off-by: Boris Burkov <boris@bur.io>
---
 .../065-btrfstune-simple-quota/test.sh        |  33 ++++
 tune/main.c                                   |  16 +-
 tune/quota.c                                  | 160 ++++++++++++++++++
 tune/tune.h                                   |   1 +
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100755 tests/misc-tests/065-btrfstune-simple-quota/test.sh

diff --git a/tests/misc-tests/065-btrfstune-simple-quota/test.sh b/tests/misc-tests/065-btrfstune-simple-quota/test.sh
new file mode 100755
index 000000000..d7ccaf4e9
--- /dev/null
+++ b/tests/misc-tests/065-btrfstune-simple-quota/test.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+# Verify btrfstune for enabling and removing simple quotas
+
+source "$TEST_TOP/common" || exit
+source "$TEST_TOP/common.convert" || exit
+
+check_experimental_build
+setup_root_helper
+prepare_test_dev
+
+# Create the fs without simple quota
+run_check_mkfs_test_dev
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+# Enable simple quotas
+run_check $SUDO_HELPER "$TOP/btrfstune" --enable-simple-quota "$TEST_DEV"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file2 bs=1M count=1
+run_check_umount_test_dev
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
+
+# Populate new fs with simple quotas enabled
+run_check_mkfs_test_dev -O squota
+run_check_mount_test_dev
+populate_fs
+run_check_umount_test_dev
+# Remove simple quotas
+run_check $SUDO_HELPER "$TOP/btrfstune" --remove-simple-quota "$TEST_DEV"
+run_check_mount_test_dev
+run_check $SUDO_HELPER dd if=/dev/zero of="$TEST_MNT"/file3 bs=1M count=1
+run_check_umount_test_dev
+run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
diff --git a/tune/main.c b/tune/main.c
index cb93d2cb3..6ef8bbe2d 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -104,6 +104,7 @@ static const char * const tune_usage[] = {
 	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
 	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
 	OPTLINE("--enable-simple-quota", "enable simple quotas on the file system. (mkfs: squota)"),
+	OPTLINE("--remove-simple-quota", "remove simple quotas from the file system."),
 	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track block groups in "
 			"the separate block-group-tree instead of extent tree (sets the incompat bit)"),
 	OPTLINE("--convert-from-block-group-tree",
@@ -198,6 +199,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	int ret;
 	u64 super_flags = 0;
 	int quota = 0;
+	int remove_simple_quota = 0;
 	int fd = -1;
 	int oflags = O_RDWR;
 
@@ -209,7 +211,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
 		       GETOPT_VAL_ENABLE_SIMPLE_QUOTA,
-
+		       GETOPT_VAL_REMOVE_SIMPLE_QUOTA,
 		};
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
@@ -221,6 +223,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 				GETOPT_VAL_ENABLE_FREE_SPACE_TREE},
 			{ "enable-simple-quota", no_argument, NULL,
 				GETOPT_VAL_ENABLE_SIMPLE_QUOTA },
+			{ "remove-simple-quota", no_argument, NULL,
+				GETOPT_VAL_REMOVE_SIMPLE_QUOTA},
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
@@ -288,6 +292,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			quota = 1;
 			btrfstune_cmd_groups[QGROUP] = true;
 			break;
+		case GETOPT_VAL_REMOVE_SIMPLE_QUOTA:
+			remove_simple_quota = 1;
+			btrfstune_cmd_groups[QGROUP] = true;
+			break;
 #if EXPERIMENTAL
 		case GETOPT_VAL_CSUM:
 			btrfs_warn_experimental(
@@ -535,6 +543,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			goto out;
 	}
 
+	if (remove_simple_quota) {
+		ret = remove_squota(root->fs_info);
+		if (ret)
+			goto out;
+	}
+
 out:
 	if (ret < 0) {
 		fs_info->readonly = 1;
diff --git a/tune/quota.c b/tune/quota.c
index a14f45307..16b2b3fb6 100644
--- a/tune/quota.c
+++ b/tune/quota.c
@@ -6,6 +6,166 @@
 #include "common/messages.h"
 #include "tune/tune.h"
 
+static int remove_quota_tree(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+	struct btrfs_root *quota_root = fs_info->quota_root;
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_super_block *sb = fs_info->super_copy;
+	int super_flags = btrfs_super_incompat_flags(sb);
+	struct btrfs_trans_handle *trans;
+
+	trans = btrfs_start_transaction(quota_root, 0);
+	ret = btrfs_clear_tree(trans, quota_root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_delete_and_free_root(trans, quota_root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	fs_info->quota_root = NULL;
+	super_flags &= ~BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA;
+	btrfs_set_super_incompat_flags(sb, super_flags);
+	btrfs_commit_transaction(trans, tree_root);
+	return 0;
+}
+
+/*
+ * Given a pointer (ptr) into DATAi (i = slot), and an amount to shift,
+ * move all the data to the left (slots >= slot) of that ptr to the right by
+ * the shift amount. This overwrites the shift bytes after ptr, effectively
+ * removing them from the item data. We must update affected item sizes (only
+ * at slot) and offsets (slots >= slot).
+ *
+ * Leaf view, using '-' to show shift scale:
+ * Before:
+ * [ITEM0,...,ITEMi,...,ITEMn,-------,DATAn,...,[---DATAi---],...,DATA0]
+ * After:
+ * [ITEM0,...,ITEMi,...,ITEMn,--------,DATAn,...,[--DATAi---],...,DATA0]
+ *
+ * Zooming in on DATAi
+ * (ptr points at the start of the Ys, and shift is length of the Ys)
+ * Before:
+ * ...[DATAi+1][XXXXXXXXXXXXYYYYYYYYYYYYYYYYXXXXXXX][DATAi-1]...
+ * After:
+ * ...................[DATAi+1][XXXXXXXXXXXXXXXXXXX][DATAi-1]...
+ * Note that DATAi-1 and smaller are not affected.
+ */
+static void shift_leaf_data(struct btrfs_trans_handle *trans,
+			    struct extent_buffer *leaf, int slot,
+			    unsigned long ptr, u32 shift)
+{
+	u32 nr = btrfs_header_nritems(leaf);
+	u32 leaf_data_off = btrfs_item_ptr_offset(leaf, nr - 1);
+	u32 len = ptr - leaf_data_off;
+	u32 new_size = btrfs_item_size(leaf, slot) - shift;
+	for (int i = slot; i < nr; i++) {
+		u32 old_item_offset = btrfs_item_offset(leaf, i);
+		btrfs_set_item_offset(leaf, i, old_item_offset + shift);
+	}
+	memmove_extent_buffer(leaf, leaf_data_off + shift, leaf_data_off, len);
+	btrfs_set_item_size(leaf, slot, new_size);
+	btrfs_set_header_generation(leaf, trans->transid);
+	btrfs_mark_buffer_dirty(leaf);
+}
+
+/*
+ * Iterate over the extent tree and for each EXTENT_DATA item that has an inline
+ * ref of type OWNER_REF, shift that leaf to eliminate the owner ref.
+ *
+ * Note: we use a search_slot per leaf rather than find_next_leaf to get the
+ * needed CoW-ing and rebalancing for each leaf and its path up to the root.
+ */
+static int remove_owner_refs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *extent_root;
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct btrfs_path path = { 0 };
+	int slot;
+	int ret;
+
+	extent_root = btrfs_extent_root(fs_info, 0);
+
+	trans = btrfs_start_transaction(extent_root, 0);
+
+	key.objectid = 0;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = 0;
+
+search_slot:
+	ret = btrfs_search_slot(trans, extent_root, &key, &path, 1, 1);
+	if (ret < 0)
+		return ret;
+	leaf = path.nodes[0];
+	slot = path.slots[0];
+
+	while (1) {
+		struct btrfs_key found_key;
+		struct btrfs_extent_item *ei;
+		struct btrfs_extent_inline_ref *iref;
+		u8 type;
+		unsigned long ptr;
+		unsigned long item_end;
+
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(extent_root, &path);
+			if (ret < 0) {
+				break;
+			} else if (ret) {
+				ret = 0;
+				break;
+			}
+			leaf = path.nodes[0];
+			slot = path.slots[0];
+			btrfs_item_key_to_cpu(leaf, &key, slot);
+			btrfs_release_path(&path);
+			goto search_slot;
+		}
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+		if (found_key.type != BTRFS_EXTENT_ITEM_KEY)
+			goto next;
+		ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
+		ptr = (unsigned long)(ei + 1);
+		item_end = (unsigned long)ei + btrfs_item_size(leaf, slot);
+		/* No inline extent references; accessing type is invalid. */
+		if (ptr > item_end)
+			goto next;
+		iref = (struct btrfs_extent_inline_ref *)ptr;
+		type = btrfs_extent_inline_ref_type(leaf, iref);
+		if (type == BTRFS_EXTENT_OWNER_REF_KEY)
+			shift_leaf_data(trans, leaf, slot, ptr, sizeof(*iref));
+next:
+		slot++;
+	}
+	btrfs_release_path(&path);
+
+	ret = btrfs_commit_transaction(trans, extent_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+		return ret;
+	}
+	return 0;
+}
+
+int remove_squota(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = remove_owner_refs(fs_info);
+	if (ret)
+		return ret;
+
+	return remove_quota_tree(fs_info);
+}
+
 static int create_qgroup(struct btrfs_fs_info *fs_info,
 			 struct btrfs_trans_handle *trans,
 			 u64 qgroupid)
diff --git a/tune/tune.h b/tune/tune.h
index 397cfe4f3..a41ba78b7 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -33,5 +33,6 @@ int convert_to_extent_tree(struct btrfs_fs_info *fs_info);
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type);
 
 int enable_quota(struct btrfs_fs_info *fs_info, bool simple);
+int remove_squota(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.45.2


