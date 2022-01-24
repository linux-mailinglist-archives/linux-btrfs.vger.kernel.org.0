Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9410D4978FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 07:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiAXGev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 01:34:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiAXGej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 01:34:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEF2021127;
        Mon, 24 Jan 2022 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643006077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TiLsjVrVZkzRPe9ZSyRqLM0YIosvfmcP3JCacrdRbDg=;
        b=re4fgCMJX/TdOBYUj9Lhesj+4b6XhSXFAHsOtuTQifPKSB0ZAV38lztn8hifojVXIJPBAq
        4wroC89StO5fSjGjGWX7I8l0iRenCYNkWqBux/LAE2vp7kDbSDy71hFlFFebhygO5aCCh1
        /VgwvdAfRiiYC4+A4hisR2DEqwHwnz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20F291331A;
        Mon, 24 Jan 2022 06:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j1tlN3xI7mFAdgAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 24 Jan 2022 06:34:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH RFC] btrfs: defrag: abort the whole cluster if there is any hole in the range
Date:   Mon, 24 Jan 2022 14:34:19 +0800
Message-Id: <20220124063419.40114-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several reports that autodefrag is causing more IO in v5.16,
caused by the recent refactor of defrag (mostly to support subpage
defrag).

With the recent debug helpers, I also locally reproduced it using
the following script:

	mount $dev $mnt -o autodefrag

	start_trace
	$fsstress -w -n 2000 -p 1 -d $mnt -s 1642319517
	sync
	btrfs ins dump-tree -t 256 $dev > /tmp/dump_tree
	echo "=== autodefrag ==="
	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
	echo 0 > /sys/fs/btrfs/$uuid/debug/cleaner_trigger
	sleep 3
	sync
	echo "======"
	grep . -IR /sys/fs/btrfs/$uuid/debug/io_accounting
	umount $mnt
	end_trace

Btrfs indeeds causes more IO for autodefrag, with all the fixes
submitted, it still causes 18% of total IO to autodefrag.

[CAUSE]
There is a hidden bug in the original defrag code in
cluster_pages_for_defrag():

        while (search_start < page_end) {
                struct extent_map *em;

                em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, search_start,
                                      page_end - search_start);
                if (IS_ERR(em)) {
                        ret = PTR_ERR(em);
                        goto out_unlock_range;
                }
                if (em->block_start >= EXTENT_MAP_LAST_BYTE) {
                        free_extent_map(em);
                        /* Ok, 0 means we did not defrag anything */
                        ret = 0;
                        goto out_unlock_range;
                }
                search_start = extent_map_end(em);
                free_extent_map(em);
	}

@search_start is the defrag range start, and @page_end is the defrag
range end (exclusive).
This while() loop is called before marking the pages for defrag.

The Ok comment is the root case.

With my test seed, root 256 inode 287 is the most obvious example, there
is a cluster of file extents starting at file offset 118784, and they
are completely sane to be merged:

        item 59 key (287 EXTENT_DATA 118784) itemoff 6211 itemsize 53
                generation 85 type 1 (regular)
                extent data disk byte 339034112 nr 8192
                extent data offset 0 nr 8192 ram 8192
        item 60 key (287 EXTENT_DATA 126976) itemoff 6158 itemsize 53
                generation 85 type 1 (regular)
                extent data disk byte 299954176 nr 4096
                extent data offset 0 nr 4096 ram 4096
        item 61 key (287 EXTENT_DATA 131072) itemoff 6105 itemsize 53
                generation 85 type 1 (regular)
                extent data disk byte 339042304 nr 4096
                extent data offset 0 nr 4096 ram 4096
        item 62 key (287 EXTENT_DATA 135168) itemoff 6052 itemsize 53
                generation 85 type 1 (regular)
                extent data disk byte 303423488 nr 4096
                extent data offset 0 nr 4096 ram 4096
        item 63 key (287 EXTENT_DATA 139264) itemoff 5999 itemsize 53
                generation 85 type 1 (regular)
                extent data disk byte 339046400 nr 106496
                extent data offset 0 nr 106496 ram 106496

Then comes a hole at offset 245760, and the file is way larger than
245760.

The old kernel will call cluster_pages_for_defrag() with start == 118784
and len == 256K.

Then into the mentioned while loop, finding the hole at 245760 and
rejecting the whole 256K cluster.

This also means, the old behavior will only defrag the whole cluster,
which is normally in 256K size (can be smaller at file end though).

[?FIX?]
I'm not convinced the old behavior is correct.

But since my refactor introduced a behavior change, and end users are
already complaining, then it's a regression, we should revert to the old
behavior by rejecting the cluster if there is anything preventing the
whole cluster to be defragged.

However the refactored code can not completely emulate the behavior, as
now cluster is split only by bytenr, no more extents skip will affect
the cluster split.

This results a more strict condition for full-cluster-only defrag.

As a result, for the mentioned fsstress seed, it only caused around 1%
for autodefrag IO, compared to 8.5% of older kernel.

Cc: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I'm not sure what is the correct behavior.

The whole cluster rejection is introduced by commit 7f458a3873ae ("btrfs: fix
race when defragmenting leads to unnecessary IO"), which is fine for old
kernels.

But the refactored code provides a way to still do the defrag, without
defragging holes. (But still has its own regressions)

If the refactored defrag (with regression fixed) and commit 7f458a3873ae
are submitted to the mail list at the same time, I guess it's no doubt we
would choose the refactored code, as it won't cause extra IO for
holes, while can still defrag as hard as possible.

But since v5.11 which has commit 7f458a3873ae, the autodefrag IO is
already reduced, I'm not sure if it's OK to increase the IO back to the old
level.
---
 fs/btrfs/ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dfa81b377e89..17d5e35a42fe 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1456,6 +1456,17 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	if (ret < 0)
 		goto out;
 
+	if (list_empty(&target_list))
+		goto out;
+	entry = list_entry(target_list.next, struct defrag_target_range, list);
+
+	/*
+	 * To emulate the old kernel behavior, if the cluster has any hole or
+	 * other things to prevent defrag, then abort the whole cluster.
+	 */
+	if (entry->len != len)
+		goto out;
+
 	list_for_each_entry(entry, &target_list, list) {
 		u32 range_len = entry->len;
 
-- 
2.34.1

