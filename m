Return-Path: <linux-btrfs+bounces-16826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C73B5823F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4230F4C0EE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578F27E05A;
	Mon, 15 Sep 2025 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMXmw9a5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFF27B336
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954239; cv=none; b=gtF3HrWPi+zyxTkSol8Z5D98bwD3hum2AbQbtaSawBM3eRXAgPGQAZqA9EaBo+DHa65IgpMHGlQD7kGDj2IFRFXkZLsLo3WAj4vmHt7AbsgiiouL+Pp0GReDbSqS5OLCfqwP9u/LMNC5AWU5UITZGqP6zgZtup5OBMoqZI2KQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954239; c=relaxed/simple;
	bh=+kMAmnol93zGwxnq3zCleD7drZeJcRYUQxNqSkqaw/w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APHFVMrG9Uf7kK9+H5rlyCXyvdpIAADwh5BiVg3eZhhBmWjUyzYK0wLv8k8Rojy7U/mO7hGflB3Z5SfEPw6NZj2/mRJ2FAgDp9TuyC6yNWB/j7vBhchiNf3Jp1jlgBS1oHneDc4t4GHhcf2naC8HUhBeIYjH0uqnnMda2Uww1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMXmw9a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3376C4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954238;
	bh=+kMAmnol93zGwxnq3zCleD7drZeJcRYUQxNqSkqaw/w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PMXmw9a5g8kSMbO93GZN5+zBlzlAKmw3r4qskr2a04d+GG6S6n97GLFGqBowP3XPi
	 qpPY36qO98Wle9w+ELxQbSx//5fgh2UgCyybTZTWu3FvXjveLuVylQrxequ0VLwZY2
	 a6lFPpcN3wTRuldVNjoKU01rza1yM7c7oKMrJU5gsHO00Fn4ejXtVuiy8j8rXM8LX7
	 oaZqid4HFNu7U0SzC4/7QEsAVFk9asSfIYl172zNf8Q6BpRFw74pj3MqXrkGWHtOF7
	 dJ8YplQfsbzy4YrmRu5dmuoxV/FcPs6GVf+wGSl9aDCC+VHCQ5EXZ6PX7e6lxNveMP
	 gACBA0k9YOvmA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: print-tree: print missing fields for inode items
Date: Mon, 15 Sep 2025 17:37:03 +0100
Message-ID: <0f7959c707d34ad09c07ca94580d9f1b1b3d8e08.1757952682.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757952682.git.fdmanana@suse.com>
References: <cover.1757952682.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are not dumping a lot of fields for an inode item which are useful for
debugging whenever we dump a leaf (log replay failure for example), so add
them and make it as close as possible to the print tree implementation in
btrfs-progs (things like converting timespecs to human readable dates and
converting flags to strings are missing since they are not so practical to
do in the kernel).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/print-tree.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 74e38da9bd39..ce89974f8fd4 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -227,6 +227,36 @@ static void print_eb_refs_lock(const struct extent_buffer *eb)
 #endif
 }
 
+static void print_timespec(const struct extent_buffer *eb,
+			   struct btrfs_timespec *timespec,
+			   const char *prefix, const char *suffix)
+{
+	const u64 secs = btrfs_timespec_sec(eb, timespec);
+	const u32 nsecs = btrfs_timespec_nsec(eb, timespec);
+
+	pr_info("%s%llu.%u%s", prefix, secs, nsecs, suffix);
+}
+
+static void print_inode_item(const struct extent_buffer *eb, int i)
+{
+	struct btrfs_inode_item *ii = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
+
+	pr_info("\t\tinode generation %llu transid %llu size %llu nbytes %llu\n",
+		btrfs_inode_generation(eb, ii), btrfs_inode_transid(eb, ii),
+		btrfs_inode_size(eb, ii), btrfs_inode_nbytes(eb, ii));
+	pr_info("\t\tblock group %llu mode %o links %u uid %u gid %u\n",
+		btrfs_inode_block_group(eb, ii), btrfs_inode_mode(eb, ii),
+		btrfs_inode_nlink(eb, ii), btrfs_inode_uid(eb, ii),
+		btrfs_inode_gid(eb, ii));
+	pr_info("\t\trdev %llu sequence %llu flags 0x%llx\n",
+		btrfs_inode_rdev(eb, ii), btrfs_inode_sequence(eb, ii),
+		btrfs_inode_flags(eb, ii));
+	print_timespec(eb, &ii->atime, "\t\tatime ", "\n");
+	print_timespec(eb, &ii->ctime, "\t\tctime ", "\n");
+	print_timespec(eb, &ii->mtime, "\t\tmtime ", "\n");
+	print_timespec(eb, &ii->otime, "\t\totime ", "\n");
+}
+
 void btrfs_print_leaf(const struct extent_buffer *l)
 {
 	struct btrfs_fs_info *fs_info;
@@ -234,7 +264,6 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 	u32 type, nr;
 	struct btrfs_root_item *ri;
 	struct btrfs_dir_item *di;
-	struct btrfs_inode_item *ii;
 	struct btrfs_block_group_item *bi;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_extent_data_ref *dref;
@@ -262,11 +291,7 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			btrfs_item_offset(l, i), btrfs_item_size(l, i));
 		switch (type) {
 		case BTRFS_INODE_ITEM_KEY:
-			ii = btrfs_item_ptr(l, i, struct btrfs_inode_item);
-			pr_info("\t\tinode generation %llu size %llu mode %o\n",
-			       btrfs_inode_generation(l, ii),
-			       btrfs_inode_size(l, ii),
-			       btrfs_inode_mode(l, ii));
+			print_inode_item(l, i);
 			break;
 		case BTRFS_DIR_ITEM_KEY:
 			di = btrfs_item_ptr(l, i, struct btrfs_dir_item);
-- 
2.47.2


