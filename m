Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934BA229CC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGVQH1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 12:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgGVQH0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 12:07:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032DEC0619DC
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 09:07:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id u64so2445709qka.12
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LIIadGfjf5vap5O8GtVjZ/UJ287tTItNUfk15DlxM0=;
        b=V0U6K5sMainp1Nwb24wooUqLarXzpz0JfDi4vWCkVBikj21ezOimCZnjxzqqIfgNgr
         2de+supwE9fPM8D9Ugn2LB06HSBdxBii39zmbiakclz2zEoDrZhpVOVUq+2080EGwUoz
         TCWqF+FrIPXuMZIX/jvBdcgv5YhApPAH45i4lhMwhEIO0D3/tU5eF0yH4ry8pWDmBiI3
         AWQ7P4LBCXtASFAKU5E1hwjnTKmKRBhj+sDO/yAxHJiCyAfDIaL9WCsVxP7GoMD0D09L
         hegWhM4ZudHq4ALs3hacA8UUo+/tefaNBxvOu1bDWP/vX5XI1bYB62hNhjhZym4CyN8n
         qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LIIadGfjf5vap5O8GtVjZ/UJ287tTItNUfk15DlxM0=;
        b=T8Z7zyKLjalbhEz1rm0X95NW7B70kVfmQ5W/myebREpRCFt+oJXcBGUjl4xZWC3tFo
         rooq0KS5aUE2dXtbytqpIfz5E2kLLJZzTW+tt/YGyaxQRntUA2LaasOn+YZBnSbfHAZG
         jNyFF6NBqOaBdzXliBIHBjiIPcgy9eyWNSVWXQAUgxMwzNACRzIXReZClSnLEXtTFm/Q
         LwbrIF5JHln3tMl+xbDbiANuJpK4vbbWHx17Ue0fMcCpczexS8vqH7MBksOWXg3Nnkw8
         PSZOvs/Rj79Dq5Ixc8C6rP1W4poEz05gMqBR09RqB5+zKmppOhZu8wPLscC84QXXaOoe
         VLpA==
X-Gm-Message-State: AOAM530soG62zKOLZE1JUHG4paFyizsugpoakWeOmIQyakELJnhCwbf9
        plJvKdbPhhA8ztIr16aWB0FXhAsxWV3jxQ==
X-Google-Smtp-Source: ABdhPJwoC6WE3NzxDJ+oCy5h43Uo3ZYhkjPg20aiR8kwhXsnmwktx1w6b5z8jrxJnPI0gQNpjploaw==
X-Received: by 2002:a37:b987:: with SMTP id j129mr737887qkf.120.1595434044804;
        Wed, 22 Jul 2020 09:07:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t35sm69235qth.79.2020.07.22.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 09:07:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: free fs roots on failed mount
Date:   Wed, 22 Jul 2020 12:07:21 -0400
Message-Id: <20200722160722.8641-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing a weird problem with -o degraded, I noticed I was getting
leaked root errors

BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
BTRFS error (device loop0): open_ctree failed
BTRFS error (device loop0): leaked root -9-0 refcount 1

This is the DATA_RELOC root, which gets read before the other fs roots,
but is included in the fs roots radix tree, and thus gets freed by
btrfs_free_fs_roots.  Fix this by moving the call into fail_tree_roots:
in open_ctree.  With this fix we no longer leak that root on mount
failure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c850d7f44fbe..f1fdbdd44c02 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3421,7 +3421,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 fail_trans_kthread:
 	kthread_stop(fs_info->transaction_kthread);
 	btrfs_cleanup_transaction(fs_info);
-	btrfs_free_fs_roots(fs_info);
 fail_cleaner:
 	kthread_stop(fs_info->cleaner_kthread);
 
@@ -3441,6 +3440,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	btrfs_put_block_group_cache(fs_info);
 
 fail_tree_roots:
+	btrfs_free_fs_roots(fs_info);
 	free_root_pointers(fs_info, true);
 	invalidate_inode_pages2(fs_info->btree_inode->i_mapping);
 
-- 
2.24.1

