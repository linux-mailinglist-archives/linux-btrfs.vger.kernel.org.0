Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C796B490CA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiAQQlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 11:41:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40434 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbiAQQlf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 11:41:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1653B61119
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B4CC36AE7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642437694;
        bh=xrO6bARZ7NSfNTR74jEME2HNDJlo+AwWtDiGAwFGvTY=;
        h=From:To:Subject:Date:From;
        b=VvmA5frPHTqDGIXqJ5R+fevjZMJeD41b+HzXX3+2TXj5NPeRbBXJcg91HX+J93O7p
         7E5RrdW0gS5ooZsoIfrDtw+GF7osRsqNAs9qbNunOtp6IZ7RAFkLdTssVvKySrFnS/
         5jJeTHhxyPgxP1wKI48n65h4sLytcXu0NlKXbim++T8+C8BbhduZSbHjqcti6nNhj2
         8OjP/u3MfSPFDCwKff7bN0G88kSOEz/7Sb3JOv1Es+WH4F1dwrZTB9jN4N7+JIT9/n
         qFanwKuFSmEVg9WIg71KLp6uDWHs7uZdJZQfnjMt/z2N9D5jxNBCYKxfvgRhybzwyh
         YpIKsh8bFk1cQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: allow defrag to be interruptible
Date:   Mon, 17 Jan 2022 16:41:31 +0000
Message-Id: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During defrag, at btrfs_defrag_file(), we have this loop that iterates
over a file range in steps no larger than 256K subranges. If the range
is too long, there's no way to interrupt it. So make the loop check in
each iteration if there's a fatal signal pending, and if there is, break
and return -EINTR to userspace.

This is motivated by a recent bug on 5.16 where defragging a 1 byte file
resulted in iterating from file range 0 to (u64)-1, as hitting the bug
triggered a too long loop, basically requiring one to reboot the machine.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6ad2bc2e5af3..954dc8259b1b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1546,6 +1546,11 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		/* The cluster size 256K should always be page aligned */
 		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
 		/* We want the cluster end at page boundary when possible */
 		cluster_end = (((cur >> PAGE_SHIFT) +
 			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
-- 
2.33.0

