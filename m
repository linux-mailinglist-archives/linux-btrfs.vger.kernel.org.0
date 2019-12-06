Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79FC115378
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLFOqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35671 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id s8so7378170qte.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SIQ/P7FQ7arouhkzuzw7ujgnmYAn8fc5SJbQDjIRoc8=;
        b=xXYBNmkrjhtPCCd7qQ9EuT/RyTK5mGFB0OETubmV/vpFiBR4qg7Oai9edk3UVw3+wX
         eKCMaqFa9dtEoZJ/VKuq/FU628uyyM/9L+asCeX3GlDM3aWQsMAJH3Lrx5BYJ5bja1Kd
         oB2ZP2OD7IPGrKG4A/VMVYCGufB83is2XvSXym2EF6RerJ8qKZnjjIBGO5d7qfzZMMeG
         7mKBXjWQhsHx2Rgmab2GE6VXey6yYjGC6JVI+fcomEObcLSm9oA3dbHZI7A9Stifl23Q
         b0jg7TcMQ45FM07YHev6sNGuUsn3Q69/VnRCFmeRd6jw0DgpLacRXiZ4XaDRcnMygGej
         gBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIQ/P7FQ7arouhkzuzw7ujgnmYAn8fc5SJbQDjIRoc8=;
        b=W9YxsboJQQDaIKc1N9lHVibJJ62fg6k4UgxIpKIAmHj2ixtJfKNl79KcGwng9opPGw
         V4Hb+eQeRkriOxXwrYrZt7uMhJUj6lHFz0+YBc38kKRhDXzDinosBmN06HP3dR2dxcpL
         Xgi0dcdx4kMR35eoxE8RBSyTDVl/Ug9cgFPPdNIGYQqe6f9ElbFL843ShjbtpsiYyY8z
         clawt2nzs01wjHrEel/ovz+/oRz09R/Zd2DDXXZlbnCjtSuGe7geJvfBsemB/E0PWMud
         AgmKc7F6Bp3yQDud2I6Zkms32M2m5yQe3ic+utonnSN/tt8wuHgmyCEhlZCEboe+9YGc
         llzQ==
X-Gm-Message-State: APjAAAXy6AU7fe38K/cuEGqoq1LV6SNxg0ba6spAuda00JZbfXH5arl+
        zx5CzmlJFy4cS4CIhZ4nYU/xa7+bzBGKXQ==
X-Google-Smtp-Source: APXvYqySOhB6bsGxRJL14qL4zfc7yEEZ6WaPGhECTv6RzAf3qUkWVYVBBPQQfWEucK5zf07UQ/fhVg==
X-Received: by 2002:ac8:c4f:: with SMTP id l15mr12951958qti.177.1575643569734;
        Fri, 06 Dec 2019 06:46:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d13sm5990070qkk.136.2019.12.06.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/44] btrfs: hold a ref on the root in fixup_tree_root_location
Date:   Fri,  6 Dec 2019 09:45:10 -0500
Message-Id: <20191206144538.168112-17-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking up the inode from an arbitrary tree means we need to hold a ref
on that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3dc9bc9530e2..5fa39ac23472 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5689,6 +5689,10 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 		err = PTR_ERR(new_root);
 		goto out;
 	}
+	if (!btrfs_grab_fs_root(new_root)) {
+		err = -ENOENT;
+		goto out;
+	}
 
 	*sub_root = new_root;
 	location->objectid = btrfs_root_dirid(&new_root->root_item);
@@ -5927,6 +5931,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	} else {
 		inode = btrfs_iget(dir->i_sb, &location, sub_root);
 	}
+	if (root != sub_root)
+		btrfs_put_fs_root(sub_root);
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
-- 
2.23.0

