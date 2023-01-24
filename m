Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939F67A33A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjAXTjd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 14:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjAXTjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 14:39:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532F51414
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 11:38:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BFCB61FDBF;
        Tue, 24 Jan 2023 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674589083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=851P831goZMl7EHZErfsRK4vs/k5kGzUIlHPo0ZGQNY=;
        b=MwFc3hEESbLvW0Q5olng2YicQ2ZGnbpxiVwR163pK4dwRGKQJftgujECNUCzYEL7apxbMG
        CXNecj5VtmChwsgY8vstYDd6qSkV8n4dRaW7FCkZpR+YWpNIPl4nSGu2LYvme4D+/HsHJz
        EU1zDrkGELrw3TUqRMj3EcSIMHLo2m4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A741F2C141;
        Tue, 24 Jan 2023 19:38:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18CF6DA7E1; Tue, 24 Jan 2023 20:32:23 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: send: limit number of clones and allocated memory size
Date:   Tue, 24 Jan 2023 20:32:10 +0100
Message-Id: <20230124193210.14636-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The arg->clone_sources_count is u64 and can trigger a warning when a
huge value is passed from user space and a huge array is allocated.
Limit the allocated memory to 8MiB (can be increased if needed), which
in turn limits the number of clone sources to 8M / sizeof(struct
clone_root) = 8M / 40 = 209715.  Real world number of clones is from
tens to hundreds, so this is future proof.

Reported-by: syzbot+4376a9a073770c173269@syzkaller.appspotmail.com
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 42aec556d83e..c3146ce84156 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8070,10 +8070,10 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	/*
 	 * Check that we don't overflow at later allocations, we request
 	 * clone_sources_count + 1 items, and compare to unsigned long inside
-	 * access_ok.
+	 * access_ok. Also set an upper limit for allocation size so this can't
+	 * easily exhaust memory. Max number of clone sources is about 200K.
 	 */
-	if (arg->clone_sources_count >
-	    ULONG_MAX / sizeof(struct clone_root) - 1) {
+	if (arg->clone_sources_count > SZ_8M / sizeof(struct clone_root)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.37.3

