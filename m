Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1F4AD1CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 07:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245030AbiBHGyO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 01:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbiBHGyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 01:54:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63635C0401EF
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 22:54:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16F4221100
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644303251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6N+kuQCB9Rs/72JKGerWLqzGz07W3ctoH2RgtSBvkXc=;
        b=LqIGNcArMjWzRULgxAOy+hZkArDQmSH86tzM5rjNSYo/AkbcQ3bA9o5HXm76Xvbj6Tvx23
        /lx/vYyet1f/XvNpp+ORCxHPKWuPOfYtu3+4QS/TV4uZaE+jQmCzGjZ9wxazQJskd6E4qa
        QlTMmwQHpAXNol1Z9XOZN6O6NNR4ezI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 620F313310
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Feb 2022 06:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QQA/CpITAmLFGgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Feb 2022 06:54:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: defrag: don't try to defrag extents which are under writeback
Date:   Tue,  8 Feb 2022 14:54:05 +0800
Message-Id: <72af431773a417658d8737f3acb39c1652f7e821.1644303096.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Once we start writeback (have called btrfs_run_delalloc_range()), we
allocate an extent, create an extent map point to that extent, with a
generation of (u64)-1, created the ordered extent and then clear the
DELALLOC bit from the range in the inode's io tree.

Such extent map can pass the first call of defrag_collect_targets(), as
its generation is (u64)-1, meets any possible minimal geneartion check.
And the range will not have DELALLOC bit, also passing the DELALLOC bit
check.

It will only be re-checked in the second call of
defrag_collect_targets(), which will wait for writeback.

But at that stage we have already spent our time waiting for some IO we
may or may not want to defrag.

Let's reject such extents early so we won't waste our time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
- Update the subject, commit message and comment.
  To replace the confusing phrase "be going to be written back" with
  "under writeback".

- Update the commit message to indicate it's not always going to be marked
  for defrag 
  The second defrag_collect_targets() call will determine its destiny.

- Update the commit message to show why we want to skip it early
  To save some time waiting for IO.
---
 fs/btrfs/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3a5ada561298..f08005b41deb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1383,6 +1383,10 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->generation < ctrl->newer_than)
 			goto next;
 
+		/* This em is goging to be written back, no need to defrag */
+		if (em->generation == (u64)-1)
+			goto next;
+
 		/*
 		 * Our start offset might be in the middle of an existing extent
 		 * map, so take that into account.
-- 
2.35.0

