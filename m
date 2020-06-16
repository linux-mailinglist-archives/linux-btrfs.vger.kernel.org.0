Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A8B1FBED8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgFPTTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:19:35 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.189]:38777 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728861AbgFPTTf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:19:35 -0400
X-Greylist: delayed 1494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 15:19:34 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id EA9E1AAE3C
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 13:54:38 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id lGjGjbUYThmVTlGjGjUKto; Tue, 16 Jun 2020 13:54:38 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6bLXqJTlNq7ltSub5qcYPDcqBcxF27JaXAfvaeRqYZA=; b=ioRsCWf/RBS/nX7Oa2d/j1Nb/Y
        1BsvVDrvBRQDGb9R6WoN1FGjUDhdbJr1QXSKbvrX9SLcHYUTrR2Zi6nKfUdIiaRO7UDQr4ScSuWMB
        cSjNp5eiRlm2mbdw7mG5ljn+fBPIQWA8oAU0cslXuqfO9B7lUUkEEwCwhqe2OmcHnLAwZTjve8rJd
        CcRYBeX0L6VWqTZ3Odv6e97Lw38Y/FbJLGGa96vyuK7GbB9wdOlfQBEA3k2aMHrXrRvVHYRgSUwiC
        4Ab+k6T0OY4TN8AKfagieHp5yxC/95dt2I8Zy/XCSNneKx9/8QEaCvtxoEBqhFArJORRi0kRBHa86
        nxf7pYTw==;
Received: from 179.187.207.239.dynamic.adsl.gvt.net.br ([179.187.207.239]:35126 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jlGjG-000M2x-FR; Tue, 16 Jun 2020 15:54:38 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Use fallthrough;
Date:   Tue, 16 Jun 2020 15:54:29 -0300
Message-Id: <20200616185429.1648-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.187.207.239
X-Source-L: No
X-Exim-ID: 1jlGjG-000M2x-FR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179.187.207.239.dynamic.adsl.gvt.net.br (hephaestus.suse.de) [179.187.207.239]:35126
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Convert /* Fallthrough */ comments to fallthrough;

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.c | 2 +-
 fs/btrfs/super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index de7ad39bcafd..70e49d8d4f6c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1196,7 +1196,7 @@ __tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct extent_buffer *eb,
 		switch (tm->op) {
 		case MOD_LOG_KEY_REMOVE_WHILE_FREEING:
 			BUG_ON(tm->slot < n);
-			/* Fallthrough */
+			fallthrough;
 		case MOD_LOG_KEY_REMOVE_WHILE_MOVING:
 		case MOD_LOG_KEY_REMOVE:
 			btrfs_set_node_key(eb, &tm->key, tm->slot);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 893fd7145724..a213b3f6a6ea 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -637,7 +637,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_compress_force:
 		case Opt_compress_force_type:
 			compress_force = true;
-			/* Fallthrough */
+			fallthrough;
 		case Opt_compress:
 		case Opt_compress_type:
 			saved_compress_type = btrfs_test_opt(info,
@@ -736,7 +736,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, NOSSD);
 			btrfs_clear_and_info(info, SSD,
 					     "not using ssd optimizations");
-			/* Fallthrough */
+			fallthrough;
 		case Opt_nossd_spread:
 			btrfs_clear_and_info(info, SSD_SPREAD,
 					     "not using spread ssd allocation scheme");
-- 
2.26.2

