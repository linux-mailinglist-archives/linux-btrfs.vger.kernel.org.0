Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB0242DC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHLRBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:01:35 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:49791 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgHLRBd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:01:33 -0400
X-Greylist: delayed 1454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 13:01:32 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id AFF4B1CE5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:16 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkakl2cVn9FW5tkakSgJj; Wed, 12 Aug 2020 11:37:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UqG29ATigcmuwfC9sOjNO8C0MQBzUDF2ZiYms3j4BtU=; b=g5D95w/KV9Eqg6tt1ZjQtKOfM/
        6ioKmAh+ijy/2nTgvt35zjbwhNqurvQeTQ4t3KnaQTflG9U8X/srL+NiPCKNWQotTxOvDDXha7grV
        vMdd2q4sLKhMibGsKNjrh7gzNjHL0w+SBino5UChFACTGQecm4lRy2fpy8foun5bdjt7kG43ATVLp
        36W85dne743S4Bwc+qzK0kcvamVRA1I94iGfH1hCAwfmBCp+BKXIRZpy3n07jEcHxdyoMdZJDNTfh
        N+pz6LQWWoGWwPDkt1khOEPk6z1T5q9qkJUndK08kFoNFwhS3i26G8D/zwFNa/YSRZq8BzZzRaXhb
        hS+R/wuA==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkZ-004J9r-Pd; Wed, 12 Aug 2020 13:37:16 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 2/8] btrfs: super: Introduce fs_context ops, init and free functions
Date:   Wed, 12 Aug 2020 13:36:48 -0300
Message-Id: <20200812163654.17080-3-marcos@mpdesouza.com>
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
X-Exim-ID: 1k5tkZ-004J9r-Pd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 8
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Create a btrfs_fs_context struct that will be used as fs_private between
the fs context calls, holding options to be later assigned to fs_info,
since we don't have a proper btrfs_fs_info at the parse_args phase.

fs_context is still not being used since the init function isn't being
assigned in btrfs_fs_type.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h | 27 +++++++++++++++++++++++++++
 fs/btrfs/super.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466f27a9..b7e3962a0941 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -28,6 +28,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/refcount.h>
 #include <linux/crc32c.h>
+#include "compression.h"
 #include "extent-io-tree.h"
 #include "extent_io.h"
 #include "extent_map.h"
@@ -35,6 +36,32 @@
 #include "block-rsv.h"
 #include "locking.h"
 
+struct btrfs_fs_context {
+	char **devices;
+	char *subvol_name;
+	u64 subvolid;
+
+	int nr_devices;
+	unsigned long mount_opt;
+	unsigned long mount_opt_explicity;
+	unsigned long pending_changes;
+	enum btrfs_compression_type	compress_type;
+	unsigned int			compress_level;
+
+	u64				max_inline;
+	u32				metadata_ratio;
+	u32				thread_pool_size;
+	u32				commit_interval;
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+	u32				check_integrity_print_mask;
+#endif
+
+	struct vfsmount *root_mnt;
+	bool root;
+	bool nospace_cache;
+	bool no_compress;
+};
+
 struct btrfs_trans_handle;
 struct btrfs_transaction;
 struct btrfs_pending_snapshot;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4e6654af90ea..fe19ffe962c6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2326,6 +2326,51 @@ static void btrfs_kill_super(struct super_block *sb)
 	btrfs_free_fs_info(fs_info);
 }
 
+static void btrfs_fc_free(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct btrfs_fs_info *info = fc->s_fs_info;
+
+	if (info)
+		btrfs_free_fs_info(info);
+	if (ctx) {
+		mntput(ctx->root_mnt);
+		if (ctx->devices) {
+			int i;
+
+			for (i = 0; i < ctx->nr_devices; i++)
+				kfree(ctx->devices[i]);
+			kfree(ctx->devices);
+		}
+		kfree(ctx->subvol_name);
+		kfree(ctx);
+	}
+}
+
+static const struct fs_context_operations btrfs_context_ops = {
+	.free = btrfs_fc_free,
+};
+
+static int btrfs_init_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* currently default options */
+	btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
+#ifdef CONFIG_BTRFS_FS_POSIX_ACL
+	fc->sb_flags |= SB_POSIXACL;
+#endif
+	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+
+	fc->fs_private = ctx;
+	fc->ops = &btrfs_context_ops;
+	return 0;
+}
+
 static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-- 
2.28.0

