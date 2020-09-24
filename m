Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259962773B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIXOQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 10:16:10 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.87]:44483 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbgIXOQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 10:16:10 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 10:16:09 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id E5676D58BA
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:55:15 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id LRiNkSGsFLFNkLRiNkdUi5; Thu, 24 Sep 2020 08:55:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dxRBcTZKGNxKgluVgKqXR+0Zm7NcxtQozMjNfNCthbo=; b=XeeVMoA9LxOaosVRJKXVTTxX+E
        pIt97Y1i7/1AFXgzc/2mNcAJMNckl1mh/kVXO42HzAONM9Uy52a5ch8ApSoVeoclyigtHpWb3GYYQ
        1UgRUjCqcU0mfOJb6AvNQoDjjTatvMB5yE9dYwY/vZqmdCR++bQNG1oWFDGH67xTSnCaES7JiHLaC
        pegzxCD0iiG+FNZ152WQ1rAS49lR0vjb+X2xUN3tITgJcuTOphzeL9AUdbRDhL4UlEXcK4xlnpQlU
        nTA3DdOOQ7KYR0Z5S8I20Y0WLvitJKLNeuhLTqAimDGDiZ7qV8AWcE+sixqdtFCaKtbfprNenXLzI
        9M5ceZCQ==;
Received: from [179.183.202.67] (port=37758 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kLRiM-0032Dg-Q7; Thu, 24 Sep 2020 10:55:15 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        Neal Gompa <ngompa13@gmail.com>
Subject: [PATCH v2] btrfs-progs: convert: Show more info when reserve_space fails
Date:   Thu, 24 Sep 2020 10:55:02 -0300
Message-Id: <20200924135502.19560-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.183.202.67
X-Source-L: No
X-Exim-ID: 1kLRiM-0032Dg-Q7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.183.202.67]:37758
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 4
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

btrfs-convert currently can't handle more fragmented block groups when
converting ext4 because the minimum size of a data chunk is 32Mb.

When converting an ext4 fs with more fragmented block group with the disk
almost full, we can end up hitting a ENOSPC problem [1] since smaller
block groups (10Mb for example) end up being extended to 32Mb, leaving
the free space tree smaller when converting it to btrfs.

This patch adds error messages telling which needed bytes couldn't be
allocated from the free space tree and shows the largest portion available:

create btrfs filesystem:
        blocksize: 4096
        nodesize:  16384
        features:  extref, skinny-metadata (default)
        checksum:  crc32c
free space report:
        total:     1073741824
        free:      39124992 (3.64%)
ERROR: failed to reserve 33554432 bytes for metadata chunk, largest available: 33488896 bytes
ERROR: unable to create initial ctree: No space left on device

Link: https://github.com/kdave/btrfs-progs/issues/251

Reviewed-by: Neal Gompa <ngompa13@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Changes from v1:
 * Added reviewed-by tag from Neal and Qu
 * Add largest free space portion available to the error message (Qu)

 convert/common.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 048629df..e636896b 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -774,6 +774,20 @@ out:
 	return ret;
 }
 
+static u64 largest_free_space(struct cache_tree *free_space)
+{
+	struct cache_extent *cache;
+	u64 largest_free_space = 0;
+
+	for (cache = first_cache_extent(free_space); cache;
+	     cache = next_cache_extent(cache)) {
+		if (cache->size > largest_free_space)
+			largest_free_space = cache->size;
+	}
+
+	return largest_free_space;
+}
+
 /*
  * Improved version of make_btrfs().
  *
@@ -812,8 +826,12 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	ret = reserve_free_space(free_space, BTRFS_STRIPE_LEN,
 				 &cfg->super_bytenr);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes for temporary superblock, largest available: %llu bytes",
+				BTRFS_STRIPE_LEN,
+				largest_free_space(free_space));
 		goto out;
+	}
 
 	/*
 	 * Then reserve system chunk space
@@ -823,12 +841,20 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	ret = reserve_free_space(free_space, BTRFS_MKFS_SYSTEM_GROUP_SIZE,
 				 &sys_chunk_start);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes for system chunk, largest available: %llu bytes",
+				BTRFS_MKFS_SYSTEM_GROUP_SIZE,
+				largest_free_space(free_space));
 		goto out;
+	}
 	ret = reserve_free_space(free_space, BTRFS_CONVERT_META_GROUP_SIZE,
 				 &meta_chunk_start);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes for metadata chunk, largest available: %llu bytes",
+				BTRFS_CONVERT_META_GROUP_SIZE,
+				largest_free_space(free_space));
 		goto out;
+	}
 
 	/*
 	 * Allocated meta/sys chunks will be mapped 1:1 with device offset.
-- 
2.28.0

