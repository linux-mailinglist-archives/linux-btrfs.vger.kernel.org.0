Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D52D5653EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 13:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiGDLmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGDLmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 07:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027110B0
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 04:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF2E60B1F
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E88C3411E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656934930;
        bh=KBoz1o1dXdw43pFqErIx4yF26CNm+xlWUljXVW2JgFU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gcwq0V7wroCsnK6fKTDciIMHBjJ/n2s6WySDe51Sz4R/RIqGTgBkBUx1aQQM7WrGh
         SErOAo25me6Jt1NlEl7xTmMazrBk3jDYA6tdhbSaM6n6Jus2rPgr7ijC0HsrJQ7qD8
         1mOMUlfvWdkd4rMFyu0iANbvB6vBfPLbzWLdKEw4a9CTE6lbjJhQW88KyoKzkPg4C2
         1EB0sECx7irDttEGh5hMAfOVPNuHmpwNwzSFu58woEMRhj9rcrlFZLzqyCphkfsl8j
         LwiHStHz6sKlkM4tchb05RgCyiekLMqGcF3uz8yKL3AqaEqH34orIANNFTlZWL1lR+
         mml1ykFUC4SvQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: don't fallback to buffered IO for NOWAIT direct IO writes
Date:   Mon,  4 Jul 2022 12:42:04 +0100
Message-Id: <1a7080444b73f8ca1481a7786e52bdf405193be9.1656934419.git.fdmanana@suse.com>
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

Currently, for a direct IO write, if we need to fallback to buffered IO,
either the satisfy the whole write operation or just a part of it, we do
it in the current context even if it's a NOWAIT context. This is not ideal
because we currently don't have support for NOWAIT semantics in the
buffered IO path (we can block for several reasons), so we should instead
return -EAGAIN to the caller, so that it knows it should retry (the whole
operation or what's left of it) in a context where blocking is acceptable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index da41a0c371bc..9c8e3a668d70 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1971,11 +1971,25 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (is_sync_write)
 		iocb->ki_flags |= IOCB_DSYNC;
 
-	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
+	/*
+	 * If 'err' is -ENOTBLK or we have not written all data, then it means
+	 * we must fallback to buffered IO.
+	 */
 	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
 		goto out;
 
 buffered:
+	/*
+	 * If we are in a NOWAIT context, then return -EAGAIN to signal the caller
+	 * it must retry the operation in a context where blocking is acceptable,
+	 * since we currently don't have NOWAIT semantics support for buffered IO
+	 * and may block there for many reasons (reserving space for example).
+	 */
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		err = -EAGAIN;
+		goto out;
+	}
+
 	pos = iocb->ki_pos;
 	written_buffered = btrfs_buffered_write(iocb, from);
 	if (written_buffered < 0) {
-- 
2.35.1

