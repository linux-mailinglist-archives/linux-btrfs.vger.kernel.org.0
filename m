Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086676FC567
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjEILwX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjEILwW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974B0272C;
        Tue,  9 May 2023 04:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E70A64609;
        Tue,  9 May 2023 11:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978B4C4339E;
        Tue,  9 May 2023 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633138;
        bh=MC+jOs+6VoxVr7l586jqD+39W5L0aUB6jvJe32sErRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LA5H+E9iIOi5VorTePiGxVdtuQbEZMHpftAGVMxwIghMaXVdWPepUs5TIogHAk0b4
         eqhSDbtpir4kFVSm90hGi4TZgnc+VnYH60lXJBYd0bs+jxANTdYV0X2MJh56gKrwpj
         m8nFt0cUeZtXUcEC6K3hVlg2jkwU5b4PQZPZEs0WiO4RXL0aCUyDe6IWVgwH3FVvav
         wIL2X7ShKf9zyQ+xMH5JqRLsCU4cuKyMd13Q8Y6UfdswbpzKoeZMkbfdzriU1UXtpe
         k3JxaoGKsyoNTkjsnY9xGIvYbVb0x2Ntiqy6GMNQSr8dwh3T62S71tXg6a/qlety8m
         Nhbd79XjW9tig==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/3] common/btrfs: add helper to get the bytenr for a file extent item
Date:   Tue,  9 May 2023 12:52:04 +0100
Message-Id: <cf702a744eea3d163061afa789aecc5b2d2677b1.1683632565.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683632565.git.fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In upcoming changes there will be the need to find out the logical disk
address (bytenr) that a particular file extent item points to. This is
already implemented as local functions in the test btrfs/299, which is
a bit limited but works fine for that test. Some important or subtle
details why it works for this test:

1) It dumps all trees of the filesystem;

2) It relies on fsync'ing a file and then finding the desired file
   extent item in the log tree from the dump;

3) There's a single subvolume, so it always finds the correct file extent
   item. In case there were multiple subvolumes, it could pick the wrong
   file extent item in case we have inodes with the same number on
   multiple subvolumes (inode numbers are unique only within a subvolume,
   they are not unique across an entire filesystem).

So add a helper to get the bytenr associated to a file extent item to
common/btrfs and use it at btrfs/299 and the upcoming changes.

This helper will dump only the tree of the default subvolume, will sync
the filesystem to commit any open transaction and works only in case the
filesystem is using the scratch device. This is explicitly documented.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 23 +++++++++++++++++++++++
 tests/btrfs/299 | 18 +-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 344509ce..42777df2 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -624,3 +624,26 @@ _require_btrfs_send_v2()
 	[ $(cat /sys/fs/btrfs/features/send_stream_version) -gt 1 ] || \
 		_notrun "kernel does not support send stream v2"
 }
+
+# Get the bytenr associated to a file extent item at a given file offset.
+#
+# NOTE: At the moment this only works if the file is on a filesystem on top of
+#       the scratch device and the file is in the default subvolume (tree id 5).
+_btrfs_get_file_extent_item_bytenr()
+{
+	local file="$1"
+	local offset="$2"
+	local ino=$(stat -c "%i" "$file")
+	local file_extent_key="($ino EXTENT_DATA $offset)"
+
+	_require_btrfs_command inspect-internal dump-tree
+
+	# The tree dump command below works on committed roots, by reading from
+	# a device directly, so we have to sync the filesystem to commit any
+	# open transaction.
+	$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
+		grep -A4 "$file_extent_key" | grep "disk byte" | \
+		$AWK_PROG '{ print $5 }'
+}
diff --git a/tests/btrfs/299 b/tests/btrfs/299
index 8ed23ac5..2ac05957 100755
--- a/tests/btrfs/299
+++ b/tests/btrfs/299
@@ -22,25 +22,10 @@ _begin_fstest auto quick preallocrw
 _supported_fs btrfs
 _require_scratch
 _require_xfs_io_command "falloc" "-k"
-_require_btrfs_command inspect-internal dump-tree
 _require_btrfs_command inspect-internal logical-resolve
 _fixed_by_kernel_commit 560840afc3e6 \
 	"btrfs: fix resolving backrefs for inline extent followed by prealloc"
 
-dump_tree() {
-	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
-}
-
-get_extent_data() {
-	local ino=$1
-	dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
-}
-
-get_prealloc_offset() {
-	local ino=$1
-	get_extent_data $ino | grep "disk byte" | $AWK_PROG '{print $5}'
-}
-
 # This test needs to create conditions s.t. the special inode's inline extent
 # is the first item in a leaf. Therefore, fix a leaf size and add
 # items that are otherwise not necessary to reproduce the inline-prealloc
@@ -81,8 +66,7 @@ done
 
 # grab the prealloc offset from dump tree while it's still the only
 # extent data item for the inode
-ino=$(stat -c '%i' $f.evil)
-logical=$(get_prealloc_offset $ino)
+logical=$(_btrfs_get_file_extent_item_bytenr $f.evil 0)
 
 # do the "small write; fsync; small write" pattern which reproduces the desired
 # item pattern of an inline extent followed by a preallocated extent. The 23
-- 
2.35.1

