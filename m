Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2703D148923
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392760AbgAXOdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45435 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392756AbgAXOdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so2148887qkl.12
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkPzl8Y/Ewdyep92I/H7EfOw2ybUpGJ8nQhdFCcNEfw=;
        b=jmPiZ2ylEXwh9xi288P72bwnKrXKB0jPSxI3c2ZjEUQW46t1LjVSCzEJ9bHFVjlYlM
         3zmX8u3BUqqNxDSWnM8z5MZH9QSGCWZ2GwOkQOGUE1waQDh7Bl0vXE+qAFAhjffCACmR
         tydW6aJEjYcUuKevPTiyOeKiT+/EmzdQvD4wHYnWJKMSxP5NxAGBdBKyvv+j0Q2nAaGv
         AffNPmDqFogC9Tepi8Q6RJ3MNibByGzBviiaAKT5o8PCapUuJysh9TsW4o+yrVdxhpQG
         6QdWm2zRHv1cqWSChrCNVQ28k5UVq2nmKGwNPEz8AoNXYu0+Xv+bWCWKd3KN/HjBcSYb
         H+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkPzl8Y/Ewdyep92I/H7EfOw2ybUpGJ8nQhdFCcNEfw=;
        b=Ph8NgmP01oRL8Z1EOgAvyCIViJsoZMJihNGDsGq8B8N7pNmaqohOl7yYNNhPloolUL
         0uccN0aCqjVMceWF3uCBg62nZhWLuWb0pE6ymWD48o6t4BoLbirME47VPWzrhwD5Pti+
         +xOQj/uRZb+Pzg/3/xzvYJIYKzmJQiqrcjvjr+EKd+nkrbyqje+fUPCqNOPE17pxld2A
         1O7woWO27wgMGLxLwBt77eeL/GIDZzV8IZvhTH5fpJ1DZfnM1XKTwb5ViioTPCWgye3T
         fLfpRJX+4IlyIDz69b8YE56zZqjxusmkozegM3IZeM08bR6UsqGovm52FQplMXe5atEI
         f3Kw==
X-Gm-Message-State: APjAAAWaXP+W9/pLU6+YlF8slOOzWDlqIlIzLR2Qfqn3AIi81RWbdPPV
        /zieLw6ahhBwvobPrrxUDYhJBA==
X-Google-Smtp-Source: APXvYqwhD5NkR+Ax1lU5/OF35B8LrzROsmR7o+O64RgzGI1odHhgcHY6AnOpWoHHBYMpmVPd0VzC8A==
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr2694882qki.67.1579876392383;
        Fri, 24 Jan 2020 06:33:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 135sm2566675qkl.68.2020.01.24.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 05/44] btrfs: make relocation use btrfs_read_tree_root()
Date:   Fri, 24 Jan 2020 09:32:22 -0500
Message-Id: <20200124143301.2186319-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation has it's special roots, we don't want to save these in the
root cache either, so swap it to use btrfs_read_tree_roo().  However the
reloc root does need REF_COWS set, so make sure we set it everywhere we
use this helper, as it no longer does the REF_COWS setting.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 995d4b8b1cfd..aa3aa8e0c0ea 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1447,8 +1447,9 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 	BUG_ON(ret);
 	kfree(root_item);
 
-	reloc_root = btrfs_read_fs_root(fs_info->tree_root, &root_key);
+	reloc_root = btrfs_read_tree_root(fs_info->tree_root, &root_key);
 	BUG_ON(IS_ERR(reloc_root));
+	set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 	reloc_root->last_trans = trans->transid;
 	return reloc_root;
 }
@@ -4537,12 +4538,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		    key.type != BTRFS_ROOT_ITEM_KEY)
 			break;
 
-		reloc_root = btrfs_read_fs_root(root, &key);
+		reloc_root = btrfs_read_tree_root(root, &key);
 		if (IS_ERR(reloc_root)) {
 			err = PTR_ERR(reloc_root);
 			goto out;
 		}
 
+		set_bit(BTRFS_ROOT_REF_COWS, &reloc_root->state);
 		list_add(&reloc_root->root_list, &reloc_roots);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-- 
2.24.1

