Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2718A3E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCRUnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:43:33 -0400
Received: from gateway36.websitewelcome.com ([192.185.197.22]:37247 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:43:33 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 12DD44068AA84
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 14:34:51 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9OjFOVHAGTXEf9OjfWje; Wed, 18 Mar 2020 15:18:50 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sWC+8lph8mgYGTKQDTByg5CI4SVPQNA4LoSAKIu6yiI=; b=KNcxkZ9aps6TSuTk8oDfsQO4gm
        aCKLDgbxBwVReXsG+GQRxneRxNCHsMEWYyPzGANjeHKB+B8wpHeXzlmYKv+c0zPAn6blKhxXfpFNR
        ofCr01nwMJ9vxnM6qgXNdjgu/rQ27JmCdl/ezyl15qcmf0eTx3+sdxACVW3UAU6EBRg8NqkEzBUo2
        7Md6XIWHwVifaCxH1Zcp90BQ5pwgmUf/UjjnPCxXVpt1tRbHEfHriOuXXG2IcHPjW5kIMRAQTu97d
        FcbimFTbmcV1iHwvCf57w9OIjZfhSpmp+PC1Ob7RRConMyofL4wnTHE3tmyLBhx2vf+4Sq1S4XRIS
        gT1wmpKg==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9O-000yAj-0S; Wed, 18 Mar 2020 17:18:50 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 03/11] btrfs-progs: qgroup-verify: Use fs_info->readonly to check if we should repair qgroups
Date:   Wed, 18 Mar 2020 17:21:40 -0300
Message-Id: <20200318202148.14828-4-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9O-000yAj-0S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 11
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

In fact qgroup-verify is just kind of offline qgroup rescan, and later
mkfs qgroup support will reuse it.

So qgroup-verify doesn't really need to rely the global variable @repair
to check if it should repair qgroups.

Instead check fs_info->readonly to do the repair.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/qgroup-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0509ecec..b7b63095 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1617,7 +1617,7 @@ int repair_qgroups(struct btrfs_fs_info *info, int *repaired)
 
 	*repaired = 0;
 
-	if (!repair)
+	if (info->readonly)
 		return 0;
 
 	list_for_each_entry_safe(count, tmpcount, &bad_qgroups, bad_list) {
-- 
2.25.0

