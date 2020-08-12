Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A561242DC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLRCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:02:17 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:13420 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgHLRCP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:02:15 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id D6C9E142358C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:21 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkfk2dkhBD8b5tkfkant7; Wed, 12 Aug 2020 11:37:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ib1dxV5xpxWZvM9JalwRoCb+oYMm/ykxexGTVa+GOv4=; b=Dpc0HZ2DJFLWVc7IQFK45+kd+1
        OgA+FIyp1MnxggbhkxAXx2Sp5evySVLwREfn7v1rHMAzbW8SGgRqVLElknpirK3JQkjI4/cOwKJ0g
        qibYz/9L53KWThdBa4nM30IW+7pvneP2vYjP+i59HokxTH5CgJZYRWTr+CQuJx5CIALPCtsWTEVQc
        iwc6tuF9pRIufehdWomNRR0cTG/u3nzK7KGCut4fI3oqB4TxmW80geWD64v2u561w5J4bVAuSk6Fc
        0t3Bbwrpo/UlBUYFI89auw/m7dFp3hmJVcv72dIupmWgaxZFNiyPE1hxKzycRKaCdDhIqQ6RrXP/X
        XBLIc87g==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkf-004J9r-3p; Wed, 12 Aug 2020 13:37:21 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 6/8] btrfs: super: Introduce btrfs_mount_root_fc
Date:   Wed, 12 Aug 2020 13:36:52 -0300
Message-Id: <20200812163654.17080-7-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812163654.17080-1-marcos@mpdesouza.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.221.211
X-Source-L: No
X-Exim-ID: 1k5tkf-004J9r-3p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 20
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function will be used by the following patches to mount the root fs
before mounting a subvolume.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/super.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6b70fb73a1ea..5bbf4b947125 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2419,6 +2419,47 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	return ERR_PTR(error);
 }
 
+/*
+ * Duplicate the current fc and prepare for mounting the root.
+ * btrfs_get_tree will be called recursively, but then will check for the
+ * ctx->root being set and call btrfs_root_get_tree.
+ */
+static int btrfs_mount_root_fc(struct fs_context *fc, unsigned int rdonly)
+{
+	struct btrfs_fs_context *ctx, *root_ctx;
+	struct fs_context *root_fc;
+	struct vfsmount *root_mnt;
+	int ret;
+
+	root_fc = vfs_dup_fs_context(fc);
+	if (IS_ERR(root_fc))
+		return PTR_ERR(root_fc);
+
+	root_fc->sb_flags &= ~SB_RDONLY;
+	root_fc->sb_flags |= rdonly | SB_NOSEC;
+	root_ctx = root_fc->fs_private;
+	root_ctx->root_mnt = NULL;
+	root_ctx->root = true;
+
+	/*
+	 * fc_mount will call btrfs_get_tree again, and by checking ctx->root
+	 * being true it'll call btrfs_root_get_tree to avoid infinite recursion.
+	 */
+	root_mnt = fc_mount(root_fc);
+	if (IS_ERR(root_mnt)) {
+		ret = PTR_ERR(root_mnt);
+		goto error_fc;
+	}
+
+	ctx = fc->fs_private;
+	ctx->root_mnt = root_mnt;
+	ret = 0;
+
+error_fc:
+	put_fs_context(root_fc);
+	return ret;
+}
+
 /*
  * Mount function which is called by VFS layer.
  *
-- 
2.28.0

