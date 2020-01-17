Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C95140BB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgAQNwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:52:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46384 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:52:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id e25so10458128qtr.13
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UZW/S1P1ppwktjXCFmFiN05XwnSVXP/r7lDAIl1xTg0=;
        b=JIM34Z1lFKlMOD8xneHK9ZYp+nltSATtTYepd6igZ8m7UCXJ0zNy3qjy8fbWf7oKHS
         nCi+1IEid0+gaCqFaeURfo5K7YDr4n6vnTcRdOqEBnbwhKkiUbv4aErIT1IE4sE6kmYj
         n1TFH5sM0jAty/CtpIIeJgTKFKyie5RdR3yuDZdY2UitP146ouMggzMTv2UN49Rac0/S
         D96nOBy/KfUOTJgGFHVK+NXaPj8WiNexGrdGWQcAIACu93wJ3dP8z9cg1ILlp0FOG+ZU
         sNYvN8V/y3IecedWnKXpznTvsodiEEZPDkyAq6no2bCFCGkZz0dwLzZqX19Et5NBcfTy
         tAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZW/S1P1ppwktjXCFmFiN05XwnSVXP/r7lDAIl1xTg0=;
        b=VAnrhL29jhbwpONjT8loHNjRtqMzi458ixijrBPgGO982QE0T+npo2zV9bSOZdBh4Q
         vMUpmo6LoLGW3s+4/jQcPS3Fn553yutHNE+E21bydiLVTSQrn0MLYIA36YXEq2atH+Sa
         JxF/vuYQwBo2apaVXrqQ8ub/wt/u1o4HVO9C3SmB4IiTayvufFXkDF7y6XRJBdf6hL7w
         IbLH3lC+NqZqgGzT1jFmw2K5vsj9Ivuwx8/bkBZWhxTgLODsWJhUpQro01NMzzzTo9Ic
         Cdv43ibk709FRg27Lb0Ja2RJt0ywqcdjWRh407/TGbUeY0cBVmUU4TQsJWCqzruIv6jZ
         0YXw==
X-Gm-Message-State: APjAAAW2U+k/7VvAv4GnETW1TK6Nlvp3jkNhVDr1uhI6q2MKRHbomaFm
        cVt/WWQwZA5iIzuFC1rdOcz3jAbWXFLaRg==
X-Google-Smtp-Source: APXvYqxF0AZktdd22pvujTDlJcm3TWnjt8OrJwJBsRk3G/SQZSxlCAD8kKir4Gv8kLyIGl393rWdxw==
X-Received: by 2002:ac8:2d0d:: with SMTP id n13mr7875699qta.236.1579269163709;
        Fri, 17 Jan 2020 05:52:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t15sm11635986qkg.49.2020.01.17.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:52:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: move ino_cache_inode dropping
Date:   Fri, 17 Jan 2020 08:52:32 -0500
Message-Id: <20200117135238.41601-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117135238.41601-1-josef@toxicpanda.com>
References: <20200117135238.41601-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to make root life be controlled soley by refcounting, and
inodes will be one of the things that hold a ref on the root.  This
means we need to handle dropping the ino_cache_inode outside of the root
freeing logic, so move it into btrfs_drop_and_free_fs_root() so it is
cleaned up properly on unmount.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 5 ++++-
 fs/btrfs/transaction.c | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 514cd8725def..6f6742805729 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3905,12 +3905,15 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		__btrfs_remove_free_space_cache(root->free_ino_pinned);
 	if (root->free_ino_ctl)
 		__btrfs_remove_free_space_cache(root->free_ino_ctl);
+	if (root->ino_cache_inode) {
+		iput(root->ino_cache_inode);
+		root->ino_cache_inode = NULL;
+	}
 	btrfs_free_fs_root(root);
 }
 
 void btrfs_free_fs_root(struct btrfs_root *root)
 {
-	iput(root->ino_cache_inode);
 	WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
 	if (root->anon_dev)
 		free_anon_bdev(root->anon_dev);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e194d3e4e3a9..c1b34c8c9fd6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2424,6 +2424,10 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
 	btrfs_debug(fs_info, "cleaner removing %llu", root->root_key.objectid);
 
 	btrfs_kill_all_delayed_nodes(root);
+	if (root->ino_cache_inode) {
+		iput(root->ino_cache_inode);
+		root->ino_cache_inode = NULL;
+	}
 
 	if (btrfs_header_backref_rev(root->node) <
 			BTRFS_MIXED_BACKREF_REV)
-- 
2.24.1

