Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87355653EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiGDLmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiGDLmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 07:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6391
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 04:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D0FB60B1D
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D3EC341CE
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656934930;
        bh=DvI94eykOj9NCptTuh1CBEsLpjJ4QI+SmE2lhlYAH/E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NItNzzUvdgCCoVhogBo06kPH/IGE41akCE2ZSunxAQ2Tiee+5nzqzngGb2GWjDnkM
         FOu6T3F5gZtvnEW3tKj67cocSSXKRIxWv+RfHR7ISBbKKqiA1Cm1u55ZiRjWpfSCVc
         94Zzey0RShmwYoHlAP7ql0CTWV5i2Ovi1YyiUOKyHw4jmaxnhemPzvrQpPIk0JXHWU
         o6o+v3KCZbXylkMOSCjmQRu74O3LB6EcGHbUQVLWVceIImrtxqfv9BdUzMZI5OpU0n
         BZCplIaSPjMgC0gkPCtIAiFIaMbZPng29bJks0yABPv4lSWHAjtd37od4ZLf46eRTt
         08PgDiqYWN2Gw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: return -EAGAIN for NOWAIT dio reads/writes on compressed and inline extents
Date:   Mon,  4 Jul 2022 12:42:03 +0100
Message-Id: <b3864441547e49a69d45c7771aa8cc5e595d18fc.1656934419.git.fdmanana@suse.com>
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

When doing a direct IO read or write, we always return -ENOTBLK when we
find a compressed extent (or an inline extent) so that we fallback to
buffered IO. This however is not ideal in case we are in a NOWAIT context
(io_uring for example), because buffered IO can block and we currently
have no support for NOWAIT semantics for buffered IO, so if we need to
fallback to buffered IO we should first signal the caller that we may
need to block by returning -EAGAIN instead.

This behaviour can also result in short reads being returned to user
space, which although it's not incorrect and user space should be able
to deal with partial reads, it's somewhat surprising and even some popular
applications like QEMU (Link tag #1) and MariaDB (Link tag #2) don't
deal with short reads properly (or at all).

The short read case happens when we try to read from a range that has a
non-compressed and non-inline extent followed by a compressed extent.
After having read the first extent, when we find the compressed extent we
return -ENOTBLK from btrfs_dio_iomap_begin(), which results in iomap to
treat the request as a short read, returning 0 (success) and waiting for
previously submitted bios to complete (this happens at
fs/iomap/direct-io.c:__iomap_dio_rw()). After that, and while at
btrfs_file_read_iter(), we call filemap_read() to use buffered IO to
read the remaining data, and pass it the number of bytes we were able to
read with direct IO. Than at filemap_read() if we get a page fault error
when accessing the read buffer, we return a partial read instead of an
-EFAULT error, because the number of bytes previously read is greater
than zero.

So fix this by returning -EAGAIN for NOWAIT direct IO when we find a
compressed or an inline extent.

Reported-by: Dominique MARTINET <dominique.martinet@atmark-techno.com>
Link: https://lore.kernel.org/linux-btrfs/YrrFGO4A1jS0GI0G@atmark-techno.com/
Link: https://jira.mariadb.org/browse/MDEV-27900?focusedCommentId=216582&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-216582
Tested-by: Dominique MARTINET <dominique.martinet@atmark-techno.com>
CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7a54f964ff37..b86be4c3513d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7684,7 +7684,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
 	    em->block_start == EXTENT_MAP_INLINE) {
 		free_extent_map(em);
-		ret = -ENOTBLK;
+		/*
+		 * If we are in a NOWAIT context, return -EAGAIN in order to
+		 * fallback to buffered IO. This is not only because we can
+		 * block with buffered IO (no support for NOWAIT semantics at
+		 * the moment) but also to avoid returning short reads to user
+		 * space - this happens if we were able to read some data from
+		 * previous non-compressed extents and then when we fallback to
+		 * buffered IO, at btrfs_file_read_iter() by calling
+		 * filemap_read(), we fail to fault in pages for the read buffer,
+		 * in which case filemap_read() returns a short read (the number
+		 * of bytes previously read is > 0, so it does not return -EFAULT).
+		 */
+		ret = (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
 		goto unlock_err;
 	}
 
-- 
2.35.1

