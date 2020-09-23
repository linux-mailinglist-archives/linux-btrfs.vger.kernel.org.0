Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27003275EDF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 19:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWRkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 13:40:47 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:31326 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726498AbgIWRkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 13:40:47 -0400
X-Greylist: delayed 1435 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 13:40:47 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 9CE5F193FF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 12:15:20 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id L8MSkR36jPiqfL8MSk5xiu; Wed, 23 Sep 2020 12:15:20 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ttIgXGEyxX2u9UUrhUVBi1dcTzIv7cHGeOtdPNPYFkQ=; b=HMDPK4kJUphvuld+Lixq9oYFpd
        VBIOPplkgEy1auDZcaTHdklhCIaF4SqE1iBOB3c8lRe2EoHe6gWxdt3L9Wp3lifcQpsqbfquLljS9
        Aj0pm8BuxB+zm561ELreKU1Ypl4zUIwjqIA3RsBrogq5Adi/0uWbxkDRHxEdWamWkKJXONVlp9MtO
        RTVymbT1a6/5Gjv4XuTEtvcB+RFbtIgbP4p/Eht8tR0WC53Yoog7kmyHUICeLkfOt32kq0mbbT6zo
        vkeSUJvjqSczTOSlzLqhBhZaCrjabU0wfifQ8c+1uvVrQ4X8ccr6V9cREQAqUWMJ4ej70MdX7XqUI
        gxg80Lqw==;
Received: from [179.185.209.227] (port=52864 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kL8MR-001Jyj-SU; Wed, 23 Sep 2020 14:15:20 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: convert: Mention which reserve_space call failed
Date:   Wed, 23 Sep 2020 14:14:05 -0300
Message-Id: <20200923171405.17456-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.209.227
X-Source-L: No
X-Exim-ID: 1kL8MR-001Jyj-SU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.209.227]:52864
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 3
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

btrfs-convert currently can't handle more fragmented block groups when
converting ext4 because the minimum size of a data chunk is 32Mb.

When converting an ext4 fs with more fragmented block group and the disk
almost full, we can end up hitting a ENOSPC problem [1] since smaller
block groups (10Mb for example) end up being extended to 32Mb, leaving
the free space tree smaller when converting it to btrfs.

This patch adds error messages telling which needed bytes couldn't be
allocated from the free space tree:

create btrfs filesystem:
        blocksize: 4096
        nodesize:  16384
        features:  extref, skinny-metadata (default)
        checksum:  crc32c
free space report:
        total:     1073741824
        free:      39124992 (3.64%)
ERROR: failed to reserve 33554432 bytes from free space for metadata chunk
ERROR: unable to create initial ctree: No space left on device

Link: https://github.com/kdave/btrfs-progs/issues/251

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 convert/common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 048629df..6392e7f4 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -812,8 +812,10 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	ret = reserve_free_space(free_space, BTRFS_STRIPE_LEN,
 				 &cfg->super_bytenr);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes from free space for temporary superblock", BTRFS_STRIPE_LEN);
 		goto out;
+	}
 
 	/*
 	 * Then reserve system chunk space
@@ -823,12 +825,16 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	ret = reserve_free_space(free_space, BTRFS_MKFS_SYSTEM_GROUP_SIZE,
 				 &sys_chunk_start);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes from free space for system chunk", BTRFS_MKFS_SYSTEM_GROUP_SIZE);
 		goto out;
+	}
 	ret = reserve_free_space(free_space, BTRFS_CONVERT_META_GROUP_SIZE,
 				 &meta_chunk_start);
-	if (ret < 0)
+	if (ret < 0) {
+		error("failed to reserve %d bytes from free space for metadata chunk", BTRFS_CONVERT_META_GROUP_SIZE);
 		goto out;
+	}
 
 	/*
 	 * Allocated meta/sys chunks will be mapped 1:1 with device offset.
-- 
2.28.0

