Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EF6242DBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLQ7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 12:59:53 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.252]:42259 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgHLQ7q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 12:59:46 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 295906394
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:19 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkdkxh8ALFNk5tkdkaVfX; Wed, 12 Aug 2020 11:37:19 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nz5hLOr319Knu6F+K422STnqvdJwNZ2qMiLxocCmbVE=; b=mzrj0UUI3UblmaA4gKwuta12/H
        hdQr2w/hAdlGmgxKkcxrOYhvy2ZWppKE0NdU2JAnxXJt8iU9n4IogFR4wR5IfqwBzHQuw73du3FQz
        1ELgIqLPy2Gr3FIiBN2YPCdaL7PLQU4pUVXn7F6nCl8XgjOfF9m0WrHkV3dpN1pxPLK3wMmVowsdl
        x7GPoehY1aTjjt451SHtE+UZwwYGaYJjxRcWHrsGBHqpRa2OX1oIMgGgfIKNRoUudUVcJt6x0Gdcm
        xQf1l1Jr4izzHkHZ7C8SYbV+99ZoIkI0OdAJGJrcNjYDOLbQ3QFz1pTXCvRF82ridU59c4G+Bv6qy
        jbkncHgg==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkc-004J9r-Fg; Wed, 12 Aug 2020 13:37:18 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 4/8] btrfs: super: Introduce btrfs_fc_validate
Date:   Wed, 12 Aug 2020 13:36:50 -0300
Message-Id: <20200812163654.17080-5-marcos@mpdesouza.com>
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
X-Exim-ID: 1k5tkc-004J9r-Fg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 14
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This function will be used in later patches in get_tree and in
remount to ensure that we don't mount btrfs using nologreplay with a
writable fs.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3425a77ecd57..88221d1d8bae 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1080,6 +1080,17 @@ static struct btrfs_flag_map btrfs_opt_map[Opt_err] = {
 	[Opt_ref_verify] = INIT_MAP(REF_VERIFY),
 };
 
+static int btrfs_fc_validate(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+
+	 /* Check for current option against current flag */
+	if (btrfs_test_opt(ctx, NOLOGREPLAY) && !(fc->sb_flags & SB_RDONLY))
+		return invalf(fc, "nologreplay must be used with ro mount option");
+
+	return 0;
+}
+
 static int btrfs_fc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	int opt;
-- 
2.28.0

