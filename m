Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A37242DC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLRCJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 13:02:09 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.222]:15196 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgHLRCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 13:02:08 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 871F5141D019
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:20 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkek2djIBD8b5tkekanrh; Wed, 12 Aug 2020 11:37:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vHbIM+Ja9pYEQy0JHmnFDv//pFqrdiLV1Cb3bZ9BJvo=; b=o2H1HLegYvQUz0CA36qVRT7MqA
        v/lssd2uAAMIz+xu93Q+kyMOqabwKyAcOoFGwwzvTZ+ABfG5rwlBHTEbFL03lbNax819J1M+90NRe
        RWK/VZaMiimRGcFBHgaIekN3GdgE/WebZ28Om/7U9oxlD2CB1WTD9YERNveKWc8wRm1rE7f928qQy
        8qq2yMtlklWs5yCebAqRnIgVFBBWy4nvo2UMsH0XcCovtGi405hDjrP5BwRH0MyO2C/z31g8/h3cy
        IwHQLlRCSO4R81k6Ug69s5aIwXe5EW7JKHcgr2WQf7VIQcfN8XtjWCKjfN/YBSFm1vEp8fCfkUceq
        cy0mucXQ==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkd-004J9r-PH; Wed, 12 Aug 2020 13:37:20 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 5/8] btrfs: super: Introduce btrfs_dup_fc
Date:   Wed, 12 Aug 2020 13:36:51 -0300
Message-Id: <20200812163654.17080-6-marcos@mpdesouza.com>
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
X-Exim-ID: 1k5tkd-004J9r-PH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 17
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function will be used in a future patch when mounting root filesystem
before mounting a subvolume.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/super.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 88221d1d8bae..6b70fb73a1ea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1091,6 +1091,56 @@ static int btrfs_fc_validate(struct fs_context *fc)
 	return 0;
 }
 
+static int btrfs_dup_fc(struct fs_context *fc, struct fs_context *src_fc)
+{
+	int i;
+	struct btrfs_fs_context *ctx, *src = src_fc->fs_private;
+
+	ctx = kmemdup(src, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->subvol_name = NULL;
+	ctx->devices = NULL;
+	ctx->root_mnt = NULL;
+
+	if (src->subvol_name) {
+		ctx->subvol_name = kstrdup(src->subvol_name, GFP_KERNEL);
+		if (!ctx->subvol_name)
+			goto nomem_ctx;
+	}
+
+	if (ctx->nr_devices) {
+		ctx->devices = kcalloc(ctx->nr_devices, sizeof(char *), GFP_KERNEL);
+		if (!ctx->devices)
+			goto nomem_sub;
+		for (i = 0; i < ctx->nr_devices; i++) {
+			ctx->devices[i] = kstrdup(src->devices[i], GFP_KERNEL);
+			if (!ctx->devices[i])
+				goto nomem_devs;
+		}
+	}
+
+	if (src_fc->source) {
+		fc->source = kstrdup(src_fc->source, GFP_KERNEL);
+		if (!fc->source)
+			goto nomem_devs;
+	}
+
+	fc->fs_private = ctx;
+	return 0;
+
+nomem_devs:
+	for (i = 0; i < ctx->nr_devices; i++)
+		kfree(ctx->devices[i]);
+	kfree(ctx->devices);
+nomem_sub:
+	kfree(ctx->subvol_name);
+nomem_ctx:
+	kfree(ctx);
+	return -ENOMEM;
+}
+
 static int btrfs_fc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	int opt;
@@ -2967,6 +3017,7 @@ static void btrfs_fc_free(struct fs_context *fc)
 }
 
 static const struct fs_context_operations btrfs_context_ops = {
+	.dup = btrfs_dup_fc,
 	.free = btrfs_fc_free,
 	.parse_param = btrfs_fc_parse_param,
 };
-- 
2.28.0

