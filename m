Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7126723AE5B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHCUow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 16:44:52 -0400
Received: from gateway30.websitewelcome.com ([192.185.160.12]:29453 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgHCUov (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 16:44:51 -0400
X-Greylist: delayed 1496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 16:44:51 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 638F711ABF
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 14:55:15 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 2gYFk6cldLFNk2gYFkpzuK; Mon, 03 Aug 2020 14:55:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zh41+pHhukeyo985XQZ/PWjl2Roj5QB0Aix5z/H9Rks=; b=aoMX1JrXJsOTjCQKIMsG8KASeR
        xX3x+Qgm0tl477KSB3bcVPrONgiMC64icaBzuwserB19wNPtxu+JYku6CBbBH99+hOYAzxP62XHiR
        SQQdLmbEOnvN0MulVaX2Ki5IlW3Y1j1xydGVTZmDfZIhSHboTR2EpoAl60DVWPkQlv1IZtWWO5JMi
        4vcDLXC9L0fG9227ShTjw0gEaD0Odb0v/HHSfCqpsmBNTCMiZ+bK//4QOW+DAT57YutIERAiNZuHZ
        DyQ+Ce0YXqTIngvwDby6HWYGlHNYL+Hvmd/PbaGjBYMaLrhXViSl+ExrhWsT3B5vBiWx4kpzzJ+g6
        jdsjw6vQ==;
Received: from [179.185.209.90] (port=47548 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k2gYE-0025nW-Q1; Mon, 03 Aug 2020 16:55:15 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: super.c: Set compress_level=0 when using compress=lzo
Date:   Mon,  3 Aug 2020 16:55:01 -0300
Message-Id: <20200803195501.30528-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.209.90
X-Source-L: No
X-Exim-ID: 1k2gYE-0025nW-Q1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.209.90]:47548
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 2
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Currently a user can set mount "-o compress" which will set the
compression algorithm to zlib, and use the default compress level for
zlib (3):

relatime,compress=zlib:3,space_cache

If the user remounts the fs using "-o compress=lzo", then the old
compress_level is used:

relatime,compress=lzo:3,space_cache

But lzo does not exposes any tunable compress level. The same happens if we set
any compress argument with different level, even with zstd.

Fix this issue by resetting the compress_level when compress=lzo is specified.
With the fix applied, lzo is shown without compress level, even after remounting
from zlib or zstd:

relatime,compress=lzo,space_cache

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 I found this issue while testing mount options. Should we tag this fix for
 stable since the introduction of the compress_level, or is it no worthy?

 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a034ed52b5f6..dd2f05f9d6c6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -614,6 +614,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
 				compress_type = "lzo";
 				info->compress_type = BTRFS_COMPRESS_LZO;
+				/* lzo does not expose compression levels */
+				info->compress_level = 0;
 				btrfs_set_opt(info->mount_opt, COMPRESS);
 				btrfs_clear_opt(info->mount_opt, NODATACOW);
 				btrfs_clear_opt(info->mount_opt, NODATASUM);
-- 
2.27.0

