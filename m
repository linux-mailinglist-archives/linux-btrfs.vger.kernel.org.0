Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFC24C273
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgHTPqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgHTPqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFFC061343
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so1927129qkf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1glSk4pqUsuJHT+0yty918l6NsgFw+/BC0hXl0whkuk=;
        b=VwkuJ03bp7igbCov7D2kvyp3uCa+1iucSZNktPQzA7RXx1q6zfMwhz4QypglRuTcOa
         WlDhAgyyO3tlzSX0FZDKCLcRs3VvrwqPs16WI5jFThDAFG0L1VpBVmGKm5YWkEJSwZ5F
         eQPlOqE9vUnJnaktVG839LyyrOpHfpm9xrADrJLPZt1lnhaDJ7qP+Ze4ThNfH1mrjAA7
         sHznHjKAw5GdpypgBnM6BhuD6V9ueYojRgoCTMP/W25hMgSy4TE4yTVFvrUEvT9CMFLn
         Bp8cesJdIObURRULseRJ/t4DHMkFjbVOI7MkgRrfyPoOUTPYkgSms1egFJlDGMP5Ni88
         n8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1glSk4pqUsuJHT+0yty918l6NsgFw+/BC0hXl0whkuk=;
        b=ghV4TGF6FwZRcfA72x3UUGwCTAlmwyFufStyiiNO31/xkNc8xfzoqFQrKXkRY2XHAB
         2WH3LPzW9YUn69DPY2AzN7HyWDkVo6iekOmw1KbZPNsyGRXgZJPdlT1MDG83dVNUA2GB
         UUtrU1CyisvYVcJsFTO2f6b6Vsk9/bKjaEDqFhpU5ljTbOA3NbGwLtdwpu/Q/eIQj0w0
         0a8Ght0hN57GAkJ3tlGHMpWP4ecmFYJ4yuCO1s+asmDevFiBBTj4vQdPa09aJhLAXS5N
         y1xNbEZe2H/UyOo1EZL6URSsvinSCLECGXfBQLzgcYo0XLKkaR58UyyqHZDt0ATSCgw/
         dEjQ==
X-Gm-Message-State: AOAM531AUiuEqaSym2FmC0jhbK0aeBeqaN9HGZn8LUyrJakqhr3HVC9b
        lnW3G7fDErLJzhVFQsc55DOTJor9DusjmO05
X-Google-Smtp-Source: ABdhPJxYl1bANDaqPucU89vD9dTO2fRZVOXtJHsebyBaS9y+au38dXUhR8bvoCGoIJkH6FlFxKcm0Q==
X-Received: by 2002:a05:620a:52f:: with SMTP id h15mr3015698qkh.156.1597938391077;
        Thu, 20 Aug 2020 08:46:31 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g61sm3304634qtd.65.2020.08.20.08.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/12] btrfs: introduce BTRFS_NESTING_NEW_ROOT for adding new roots
Date:   Thu, 20 Aug 2020 11:46:07 -0400
Message-Id: <d5e2eb50d01b4d7047fe38c4b0a5b266e9257100.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The way we add new roots is confusing from a locking perspective for
lockdep.  We generally have the rule that we lock things in order from
highest level to lowest, but in the case of adding a new level to the
tree we actually allocate a new block for the root, which makes the
locking go in reverse.  A similar issue exists for snapshotting, we cow
the original root for the root of a new tree, however they're at the
same level.  Address this by using BTRFS_NESTING_NEW_ROOT for these
operations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   |  5 +++--
 fs/btrfs/locking.h | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4b62acac31b6..a67d3e28e0fc 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -198,7 +198,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		btrfs_node_key(buf, &disk_key, 0);
 
 	cow = btrfs_alloc_tree_block(trans, root, 0, new_root_objectid,
-			&disk_key, level, buf->start, 0, BTRFS_NESTING_NORMAL);
+				     &disk_key, level, buf->start, 0,
+				     BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(cow))
 		return PTR_ERR(cow);
 
@@ -3343,7 +3344,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	c = alloc_tree_block_no_bg_flush(trans, root, 0, &lower_key, level,
 					 root->node->start, 0,
-					 BTRFS_NESTING_NORMAL);
+					 BTRFS_NESTING_NEW_ROOT);
 	if (IS_ERR(c))
 		return PTR_ERR(c);
 
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 3b5a948bf74f..e74ae478b778 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -16,6 +16,11 @@
 #define BTRFS_WRITE_LOCK_BLOCKING 3
 #define BTRFS_READ_LOCK_BLOCKING 4
 
+/*
+ * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
+ * the time of this patch is 8, which is how many we're using here.  Keep this
+ * in mind if you decide you want to add another subclass.
+ */
 enum btrfs_lock_nesting {
 	BTRFS_NESTING_NORMAL,
 
@@ -56,6 +61,15 @@ enum btrfs_lock_nesting {
 	 */
 	BTRFS_NESTING_SPLIT,
 
+	/*
+	 * When promoting a new block to a root we need to have a special
+	 * subclass so we don't confuse lockdep, as it will appear that we are
+	 * locking a higher level node before a lower level one.  Copying also
+	 * has this problem as it appears we're locking the same block again
+	 * when we make a snapshot of an existing root.
+	 */
+	BTRFS_NESTING_NEW_ROOT,
+
 	/*
 	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
-- 
2.24.1

