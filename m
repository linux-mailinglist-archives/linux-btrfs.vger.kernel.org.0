Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF55653EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 13:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiGDLmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGDLmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 07:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2E10AF
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 04:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EB9F60B29
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580C2C341C7
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656934931;
        bh=36MkUOll9Ci/OQiJXnSZnI8zIZNSoA4ZN8JV+VyVNQo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ef1qbKnGmMnTvqV5scpIzXMLuFquRGa450bVu2PBQ0IS500ZYEmW6BvG6eCaQa442
         VHnxUyMrE5WjHsO8uZA+WU5KO7HaKi1Yw92f3PKS/NHlN3CgQqlXRDQhxPcI3bS61e
         js9oXIZ8amw6ATFyxwLuDDsTYqB4A/k1AW20Lc1f6sfvkKHzvoD9TWjk5SYed/t1Tk
         uMV7MB3V4xWpkUaxhdJxuPfTnigIx9alxE2jvi/uu9gZtzdFpHwM83HK1hi57a6IZO
         qJjL5LcEtyiT95CUTQYNg2QWQ+vXjAhr7+G+kuxzoTmIlEyf2+kE62UBDQyjubD4/V
         q6Jc0rKBY9QYw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: fault in pages for dio reads/writes in a more controlled way
Date:   Mon,  4 Jul 2022 12:42:05 +0100
Message-Id: <f01450d13f24e9a01436b60f5f2596ef650c790f.1656934419.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656934419.git.fdmanana@suse.com>
References: <cover.1656934419.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we need to fault in the pages of the iovector of a direct IO read or
write, we try to fault in all the remaining pages. While this works, it's
not ideal if there's a large number of remaining pages and the system is
under memory pressure. By the time we fault in some pages, some of the
previously faulted in pages may have been evicted due to memory pressure,
resulting in slower progress or falling back to buffered IO (which is fine
but it's not ideal).

So limit the number of pages we fault in. The amount is decided based on
what's left of the iovector and the threshold for dirty page rate limiting
(the nr_dirtied and nr_dirtied_pause fields of struct task_struct), and
it's borrowed from gfs2 (fs/gfs2/file.c:should_fault_in_pages()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 56 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9c8e3a668d70..1528b8edc7a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1846,6 +1846,33 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static size_t dio_fault_in_size(const struct kiocb *iocb,
+				const struct iov_iter *iov,
+				size_t prev_left)
+{
+	const size_t left = iov_iter_count(iov);
+	size_t size = PAGE_SIZE;
+
+	/*
+	 * If there's no progress since the last time we had to fault in pages,
+	 * then we fault in at most 1 page. Faulting in more than that may
+	 * result in making very slow progress or falling back to buffered IO,
+	 * because by the time we retry the DIO operation some of the first
+	 * remaining pages may have been evicted in order to fault in other pages
+	 * that follow them. That can happen when we are under memory pressure and
+	 * the iov represents a large buffer.
+	 */
+	if (left != prev_left) {
+		int dirty_tresh = current->nr_dirtied_pause - current->nr_dirtied;
+
+		size = max(dirty_tresh, 8) << PAGE_SHIFT;
+		size = min_t(size_t, SZ_1M, size);
+	}
+	size -= offset_in_page(iocb->ki_pos);
+
+	return min(left, size);
+}
+
 static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	const bool is_sync_write = (iocb->ki_flags & IOCB_DSYNC);
@@ -1956,7 +1983,9 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		if (left == prev_left) {
 			err = -ENOTBLK;
 		} else {
-			fault_in_iov_iter_readable(from, left);
+			const size_t size = dio_fault_in_size(iocb, from, prev_left);
+
+			fault_in_iov_iter_readable(from, size);
 			prev_left = left;
 			goto again;
 		}
@@ -3737,25 +3766,20 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 		read = ret;
 
 	if (iov_iter_count(to) > 0 && (ret == -EFAULT || ret > 0)) {
-		const size_t left = iov_iter_count(to);
+		if (iter_is_iovec(to)) {
+			const size_t left = iov_iter_count(to);
+			const size_t size = dio_fault_in_size(iocb, to, prev_left);
 
-		if (left == prev_left) {
-			/*
-			 * We didn't make any progress since the last attempt,
-			 * fallback to a buffered read for the remainder of the
-			 * range. This is just to avoid any possibility of looping
-			 * for too long.
-			 */
-			ret = read;
+			fault_in_iov_iter_writeable(to, size);
+			prev_left = left;
+			goto again;
 		} else {
 			/*
-			 * We made some progress since the last retry or this is
-			 * the first time we are retrying. Fault in as many pages
-			 * as possible and retry.
+			 * fault_in_iov_iter_writeable() only works for iovecs,
+			 * return with a partial read and fallback to buffered
+			 * IO for the rest of the range.
 			 */
-			fault_in_iov_iter_writeable(to, left);
-			prev_left = left;
-			goto again;
+			ret = read;
 		}
 	}
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
-- 
2.35.1

