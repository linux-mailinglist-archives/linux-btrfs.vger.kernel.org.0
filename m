Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E3758D20
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGSFaz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 01:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSFay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 01:30:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87333D2
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 22:30:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 349E221901
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689744649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn9Uo1pjgKdfxxn9FdavaFwL3D78/XCfAuyt45us0yM=;
        b=kQIo5bTBa8v7XZVrxfVyjjMDKw/2yOsoKS9QJRsek2c5uoy1ow1WMpxRRYYEZZeH375Y0c
        VoL1bezgqS58CboLEqaP33uDebco65mgQ+LgN+1Le3bVj3id1HLyv6gXlIdraVUwpKcPth
        Nsj8/Mtu/KRhklaIOWW3ktgSnYHK9w8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8752B138EE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gLoaFAh1t2R7JQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 05:30:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/4] btrfs: scrub: don't go ordered workqueue for dev-replace
Date:   Wed, 19 Jul 2023 13:30:24 +0800
Message-ID: <cd045bda35d2bd03f7f38e74e807cd1a44b9a1f0.1689744163.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689744163.git.wqu@suse.com>
References: <cover.1689744163.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The workqueue fs_info->scrub_worker would go ordered workqueue if it's a
device replace operation.

However the scrub is relying on multiple workers to do data csum
verification, and we always submit several read requests in a row.

Thus there is no need to use ordered workqueue just for dev-replace.
We have extra synchronization (the main thread will always
submit-and-wait for dev-replace writes) to handle it for zoned devices.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a3aff0296ba4..9cb1106bdc11 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2741,8 +2741,7 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 /*
  * get a reference count on fs_info->scrub_workers. start worker if necessary
  */
-static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
-						int is_dev_replace)
+static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 {
 	struct workqueue_struct *scrub_workers = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
@@ -2752,10 +2751,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	if (is_dev_replace)
-		scrub_workers = alloc_ordered_workqueue("btrfs-scrub", flags);
-	else
-		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
+	scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
 	if (!scrub_workers)
 		return -ENOMEM;
 
@@ -2807,7 +2803,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
 
-	ret = scrub_workers_get(fs_info, is_dev_replace);
+	ret = scrub_workers_get(fs_info);
 	if (ret)
 		goto out_free_ctx;
 
-- 
2.41.0

