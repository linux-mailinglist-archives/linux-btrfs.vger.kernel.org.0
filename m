Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685D2467D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgHQN5b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 09:57:31 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.91]:24111 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgHQN51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 09:57:27 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 0945159A41
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Aug 2020 08:57:25 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 7fdcko4oYdbRz7fddkk4Rh; Mon, 17 Aug 2020 08:57:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d+1NgkVuweNsuAZREJk1gJRUK3UfEBbhegnVIiXBoHM=; b=l01h0YazY2EZJiN6B0aqSJS8X4
        jnb54StorGbGW63JKg32ix94AbiMg0cD1kdcRKNhVbXUO3/m3DePvDfv2A8AuMquBd9BG3nATec7j
        UQlZoGZkKrSkdXmUgHlwBouuKOAUFL38b7qmRLYEaCOhwezxSkpm9ix9QTRKpp9GlflTUeeDSBZWb
        oDQVfsa1bGJvKJMy6fRMDg/KErF1y2Gzm5qcePQBy19xyddJ5qWh/h3ErvGhxe4py3q3CBxnvW926
        kH2DHaJNRS6PHAsq9/BABeNqYQN5GVkd/DLLrKXv3hsHaB3j1pZP1SnIbPOjG9Xk0cYhASPwGLnGP
        9N3Rjwdg==;
Received: from [179.185.212.93] (port=48306 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k7fdc-001mAk-Fw; Mon, 17 Aug 2020 10:57:24 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: block-group: Make read_block_group_item return void
Date:   Mon, 17 Aug 2020 10:56:10 -0300
Message-Id: <20200817135610.29338-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.212.93
X-Source-L: No
X-Exim-ID: 1k7fdc-001mAk-Fw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.212.93]:48306
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Since it's inclusion on 9afc66498a0b
("btrfs: block-group: refactor how we read one block group item") this
function always returned 0, so there is no need to check for the
returned value.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/block-group.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b49e23e10d0..3891a1f731ba 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1874,7 +1874,7 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-static int read_block_group_item(struct btrfs_block_group *cache,
+static void read_block_group_item(struct btrfs_block_group *cache,
 				 struct btrfs_path *path,
 				 const struct btrfs_key *key)
 {
@@ -1888,8 +1888,6 @@ static int read_block_group_item(struct btrfs_block_group *cache,
 			   sizeof(bgi));
 	cache->used = btrfs_stack_block_group_used(&bgi);
 	cache->flags = btrfs_stack_block_group_flags(&bgi);
-
-	return 0;
 }
 
 static int read_one_block_group(struct btrfs_fs_info *info,
@@ -1908,9 +1906,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (!cache)
 		return -ENOMEM;
 
-	ret = read_block_group_item(cache, path, key);
-	if (ret < 0)
-		goto error;
+	read_block_group_item(cache, path, key);
 
 	if (need_clear) {
 		/*
-- 
2.28.0

