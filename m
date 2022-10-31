Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BAD6134C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 12:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJaLos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 07:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJaLoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 07:44:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19577EE10
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 04:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6BEFB815F8
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF670C433B5
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216641;
        bh=/O2Ch7BDKKWkxkIpvY7qmaBlrSPlePt8vDVdnOFxXfI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A5UrnLv/2zNbjBHDmnAevrhSRdJ/wvujbbxp/t/Ab++PGi5XeAT0wOYpQ2Ab05fRq
         wmkyEm6lrScKPkchdSg4x1DlhOznVDL7VFOzqVgf3PdxSuqgrtz+vI9/5Ca/WheN26
         bXyNpdaFZ4hTfXSXjB4rNEF4mnA6QUAn8Jlmn56Y4bRrwg6aXcAPCWTTyP0CoK840g
         WDKKgyYtvlNiiGS1Rn2KNwL6L6yshsbi4QVi65R84VVQd+WaXSlKCYizEONXMBWG9F
         FHjHvGfQFMesaw6ccIg0JEefrLV3BbrrqvxKB7Rg907V/Q8zOVTYno0M21c9kdDVqi
         ol/pjlEfOkhuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: update stale comment for nowait direct IO writes
Date:   Mon, 31 Oct 2022 11:43:56 +0000
Message-Id: <bdd6a08c72a041d0515582322586dec25d76b042.1667215075.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667215075.git.fdmanana@suse.com>
References: <cover.1667215075.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If when doing a direct IO write we need to fallback to buffered IO, we
this comment at btrfs_direct_write() that says we can't directly fallback
to buffered IO if we have a NOWAIT iocb, because we have no support for
NOWAIT buffered writes. That is not true anymore, as support for NOWAIT
buffered writes was added recently in commit 926078b21db9 ("btrfs: enable
nowait async buffered writes").

However we still can't fallback to a buffered write in case we have a
NOWAIT iocb, because we'll need to flush delalloc and wait for it to
complete after doing the buffered write, and that can block for several
reasons, the main reason being waiting for IO to complete.

So update the comment to mention all that.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6e2889bc73d8..b7855f794ba6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1570,8 +1570,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	/*
 	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
 	 * it must retry the operation in a context where blocking is acceptable,
-	 * since we currently don't have NOWAIT semantics support for buffered IO
-	 * and may block there for many reasons (reserving space for example).
+	 * because even if we end up not blocking during the buffered IO attempt
+	 * below, we will block when flushing and waiting for the IO.
 	 */
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		err = -EAGAIN;
-- 
2.35.1

