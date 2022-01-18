Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94653492765
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiARNng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 08:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiARNnf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 08:43:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED2C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 05:43:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E2861455
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 13:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88B0C00446
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642513414;
        bh=j2jeyZT7iP7LuuFdh03osijL1MNHwasB/XCtqjVhdbk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=neFg3+wDgUsvJuSKBBrlBptg1GgC6yvxrRCNQi2VclDgws9sqoBul69Iq4RqATbrP
         Uuw4EGxggYm2YXPm1wjXWgEkTZerR9SBCIEE+5D9qbLMb0+X3LjJx0Mdt/mB1kosQv
         OVnfSVVfwFN8JKozQq2xZYk4Xb+zBQf5EkuvTkkY4WM0/Z6ew24gPeDVQF7k4DqWpq
         mVNnKE843s3mXkO2uRX9bI9I7xXet/ctKo9KVCq7QAbrwHS9Lw+oNeE3vIwOWYqpsH
         EAOIrMncj8XGKt/MWqXqV/gVFlsgZTg8dBEU5NREq0fGlciB1p67v2rsgN2cJawoSb
         6KJ4Rc3wAWWSQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: allow defrag to be interruptible
Date:   Tue, 18 Jan 2022 13:43:31 +0000
Message-Id: <9a755aa9a3528e385c6dee47e536cd2fe539ab59.1642513202.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
References: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During defrag, at btrfs_defrag_file(), we have this loop that iterates
over a file range in steps no larger than 256K subranges. If the range
is too long, there's no way to interrupt it. So make the loop check in
each iteration if there's signal pending, and if there is, break and
return -AGAIN to userspace.

Before kernel 5.16, we used to allow defrag to be cancelled through a
signal, but that was lost with commit 7b508037d4cac3 ("btrfs: defrag:
use defrag_one_cluster() to implement btrfs_defrag_file()").

This change adds back the possibility to cancel a defrag with a signal
and keeps the same semantics, returning -EAGAIN to user space (and not
the usually more expected -EINTR).

This is also motivated by a recent bug on 5.16 where defragging a 1 byte
file resulted in iterating from file range 0 to (u64)-1, as hitting the
bug triggered a too long loop, basically requiring one to reboot the
machine, as it was not possible to cancel defrag.

Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

v2: Add Fixes tag, as it's actually a regression introduced in 5.16.
    Use the helper btrfs_defrag_cancelled() instead of fatal_signal_pending()
    and return -EAGAIN instead of -EINTR to userspace, as that is what used
    to be returned before 5.16.

 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6ad2bc2e5af3..6391be7409d8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1546,6 +1546,11 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		/* The cluster size 256K should always be page aligned */
 		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 
+		if (btrfs_defrag_cancelled(fs_info)) {
+			ret = -EAGAIN;
+			break;
+		}
+
 		/* We want the cluster end at page boundary when possible */
 		cluster_end = (((cur >> PAGE_SHIFT) +
 			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
-- 
2.33.0

