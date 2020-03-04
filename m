Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018D21794DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbgCDQSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38932 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbgCDQSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id e13so1772539qts.6
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gMDYNEH7Lg0r+b8JZcPw/d/uiHJ5zj3M3VFjD7L47cs=;
        b=C6sFCe1wLw8IspNo3VxcDw5D94hsGmjT7F+lUtvXT9PXQpa7TECoeiPNAE/ZBi0ib7
         fwb3hZGXMpjFR7rjSQspGMLuwoqdBz7k03/pCx8H0wzVHdoELu+CZBlhw1Us7tFg1Cgk
         yaiMg8Q6DBmxv+lPFen8NWCRYXKZfNPti9tbN8wc+AV5OU/3qkobfPoc09tbxnjYGAeU
         GZxpJ3xGldFwcPf4e39kJAxSatcrjeVdMhyPjO6TEe+WbMIf1pQ9NazDdIl/S9YUA4OH
         izHxU2xLrLVVXy4hvmxzgCujuteUbModxtLutZOyhzCiok/4pZ2a6RVZa1nfktlje6bj
         WRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMDYNEH7Lg0r+b8JZcPw/d/uiHJ5zj3M3VFjD7L47cs=;
        b=M9nZz4/9B3juxs3r5BoFwX7qdDlTvvtS3yHe8PowgVioMCpnI1lL3nJfVq4a5iMPol
         Le+sqJVlxgU91ovHsXhjc0Dscary6BrS0rrT+da+hwcJntm1LC8uJLownH5Tw+l6Mqa6
         AoPHtM/GH17aqRW7ZGgp2cAXwEm+ZCtb+TQFJBzSZtbtoO0gaErZIKshsaT3zJsehPuT
         DwEgTiYomHWFiW7QFfnztCwBRnoRnjXm5ByolKnSm5AXR/Uzg30dMM3tI4P8AZg9mj4V
         GZ9q6hDNReF26oVZsz004vTnGhyndgKiA5/ed2Q91d34w28IqXP3UOESLVNfr+L3cZbB
         w6IQ==
X-Gm-Message-State: ANhLgQ2NxLBpefVE6s6tw2Xwb5R0GAK3LZg3LBLer1nIG/8z3r89uhol
        V2Va85QELTkRrlxs40igU/ppASPt2mY=
X-Google-Smtp-Source: ADFU+vvcr1GEjxtPjfvbrjQsb8pnfqWQQg+z+l6nHJEXwklyaXYSGE7snmKA+KHDCMz2D1pL+7K2Zw==
X-Received: by 2002:ac8:4f43:: with SMTP id i3mr3203406qtw.186.1583338719715;
        Wed, 04 Mar 2020 08:18:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z2sm1141284qtn.23.2020.03.04.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: free the reloc_control in a consistent way
Date:   Wed,  4 Mar 2020 11:18:26 -0500
Message-Id: <20200304161830.2360-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while processing the reloc roots we could leak roots
that were added to rc->reloc_roots before we hit the error.  We could
have also not removed the reloct tree mapping from our rb_tree, so clean
up any remaining nodes in the reloc root rb_tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c496f8ed8c7e..f6237d885fe0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4387,6 +4387,20 @@ static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
 	return rc;
 }
 
+static void free_reloc_control(struct reloc_control *rc)
+{
+	struct rb_node *rb_node;
+	struct mapping_node *node;
+
+	free_reloc_roots(&rc->reloc_roots);
+	while ((rb_node = rb_first(&rc->reloc_root_tree.rb_root))) {
+		node = rb_entry(rb_node, struct mapping_node, rb_node);
+		rb_erase(rb_node, &rc->reloc_root_tree.rb_root);
+		kfree(node);
+	}
+	kfree(rc);
+}
+
 /*
  * Print the block group being relocated
  */
@@ -4531,7 +4545,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		btrfs_dec_block_group_ro(rc->block_group);
 	iput(rc->data_inode);
 	btrfs_put_block_group(rc->block_group);
-	kfree(rc);
+	free_reloc_control(rc);
 	return err;
 }
 
@@ -4708,7 +4722,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 out_unset:
 	unset_reloc_control(rc);
 out_free:
-	kfree(rc);
+	free_reloc_control(rc);
 out:
 	if (!list_empty(&reloc_roots))
 		free_reloc_roots(&reloc_roots);
-- 
2.24.1

