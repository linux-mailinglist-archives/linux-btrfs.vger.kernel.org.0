Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7118BA84
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCSPIA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:08:00 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.119]:30116 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbgCSPIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:08:00 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id C4995A72B4
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 10:07:59 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ewm7jpswd1s2xEwm7jYJUl; Thu, 19 Mar 2020 10:07:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tR+EP+xci3Uwfa8x+ZQJeeUhSaDAWTKVQaqaYbkRaRI=; b=ta3r3oxiyyMli2htL3P/OYC+62
        TDJ9fQDwmau3GCJL0ZhckatMxOoOQNpbM6L6/tDcRnP6RNcavM3VHlGpvgGKkjMte3dy7G/7MWiCD
        AsmBhj6gh/EdNrE6+IZ3lw3Gbwaw4H+XlMVDxHk63EAtXZ66/LQW+eOanCchULLIMb/iTSUID9qMZ
        FL+olG+kAf7nkvsEjFdJQpb9/fg8FdKqHAyOxkAK3Uuak2LRHDEWV2hkaZiEDCCQiyMeTUgwBlisJ
        v+3jUKouFVcknXTANBWLnSF5HG5TKeiAOA5C8Pgre6A15SaGgM+XMkE8JDnPc+xc1iKFEGC9pBbGE
        MGQHkprA==;
Received: from [191.249.66.103] (port=60064 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEwm7-000DCD-8h; Thu, 19 Mar 2020 12:07:59 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: restore: Avoid SYMLINK messages
Date:   Thu, 19 Mar 2020 12:10:36 -0300
Message-Id: <20200319151036.11723-1-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEwm7-000DCD-8h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:60064
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 7
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Some scripts can still rely in this message, so make it available only
if --verbose was informed.

Fixes: #127

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/restore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 8eaafd60..73a464c3 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -898,7 +898,9 @@ static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
 			goto out;
 		}
 	}
-	printf("SYMLINK: '%s' => '%s'\n", path_name, symlink_target);
+
+	if (verbose)
+		printf("SYMLINK: '%s' => '%s'\n", path_name, symlink_target);
 
 	ret = 0;
 	if (!restore_metadata)
-- 
2.25.0

