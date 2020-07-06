Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B08215A93
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 17:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgGFPVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 11:21:53 -0400
Received: from gateway30.websitewelcome.com ([192.185.168.15]:20005 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729197AbgGFPVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 11:21:53 -0400
X-Greylist: delayed 1307 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 11:21:53 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 831CE1623B
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 09:59:57 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id sSb6jAtyPQyTQsSb6jBnfz; Mon, 06 Jul 2020 09:59:57 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NTTQwd3YU5No2P/Mhy7cy/iX08Ngw8EzoUPzxyYK7yg=; b=FH9z66vMCfglWdtoFYpc2Lh8ZJ
        UiZO41oQp5dgSsZsNN/rgi8IRrwskgeXV7FRWt5n3/c6vZHyB+k+OwYrrm6H7tOj7LoBV4uTdB2s+
        7OGSRCWfgBTL7cYvqsTlW+AvuAlgP/U6hLE9ck/hs5ovy9klg1pannbdImE/WfczusTPXaArjjuda
        kJ2q7Zw7gYl+tLzdt8sgKUloXPLPQS2hV3n/P+M211UOiYMfLUqe5TIO8+W5cWHyufbHb5Yl8hr7U
        jDkV/rb8isLb6pd/zbYL0Y70E8o58Xh8BJYZIosPLu08n3gpvpI/Wl2NMDi1oo4Dk405nJscjaFEn
        c5WXc/BQ==;
Received: from 189.26.189.59.dynamic.adsl.gvt.net.br ([189.26.189.59]:46096 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jsSb5-003CkR-HZ; Mon, 06 Jul 2020 11:59:55 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: ctree: Add do {} while (0) in btrfs_{set|clear}_and_info
Date:   Mon,  6 Jul 2020 11:59:36 -0300
Message-Id: <20200706145936.13620-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 189.26.189.59
X-Source-L: No
X-Exim-ID: 1jsSb5-003CkR-HZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 189.26.189.59.dynamic.adsl.gvt.net.br (hephaestus.suse.de) [189.26.189.59]:46096
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Without this change it's not possible to use these macros and having an
if-else construction without using braces.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a256961c0dbe..cef0489a1523 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1278,18 +1278,18 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 					 BTRFS_MOUNT_##opt)
 
 #define btrfs_set_and_info(fs_info, opt, fmt, args...)			\
-{									\
+do {									\
 	if (!btrfs_test_opt(fs_info, opt))				\
 		btrfs_info(fs_info, fmt, ##args);			\
 	btrfs_set_opt(fs_info->mount_opt, opt);				\
-}
+} while (0)
 
 #define btrfs_clear_and_info(fs_info, opt, fmt, args...)		\
-{									\
+do {									\
 	if (btrfs_test_opt(fs_info, opt))				\
 		btrfs_info(fs_info, fmt, ##args);			\
 	btrfs_clear_opt(fs_info->mount_opt, opt);			\
-}
+} while (0)
 
 /*
  * Requests for changes that need to be done during transaction commit.
-- 
2.26.2

