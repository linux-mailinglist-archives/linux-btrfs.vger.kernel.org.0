Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3E18A3DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCRUk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:40:27 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:27537 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUk1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:40:27 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 14CFC2BAA8
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:49 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9NjlN4TSl8qEf9NjKGQC; Wed, 18 Mar 2020 15:18:49 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TN77EJkOHwY+b8YCeSFh11cEXDqEu09+dDtG+P2xcrQ=; b=AksshsdKbgiVw8qdwZ/Hrw+dOO
        UT7WSDeV7SCPuzy0BU38AWeGQB9Hb0YZ88FPKR3EXMqkfyS6cZR0a1TUgdR7hMdQicNVOO0u2po1T
        0aV6zpQaLQku1lwF9b9UeQGZJnC+6u57/42nMq7eLykUrLdbjVTFuf36Rc4DVmXgoP/KRh+iDj7MF
        7sbE9CyPsPO0aZhrTJ6M6eTFh/Y9Ijtik8bOLJq9dYrj+LHePPHKWW6kdvyIXVwL2TrF0pHINtn5d
        oNMDPvTDrRnt0eeNQDukp79dRk3xoX85GVjW6pAESWQgdQQ+M4u0vQ5BWoZ8V+SlVGzpPCfwTaExs
        RmD0XRlA==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9M-000yAj-Gq; Wed, 18 Mar 2020 17:18:48 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 02/11] btrfs-progs: qgroup-verify: Also repair qgroup status version
Date:   Wed, 18 Mar 2020 17:21:39 -0300
Message-Id: <20200318202148.14828-3-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9M-000yAj-Gq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 8
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Current kernel only supports qgroup version 1.
Make qgroup-verify to follow this standard.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/qgroup-verify.c | 2 ++
 ctree.h               | 1 +
 2 files changed, 3 insertions(+)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 17c266d4..0509ecec 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1598,6 +1598,8 @@ static int repair_qgroup_status(struct btrfs_fs_info *info)
 	btrfs_set_qgroup_status_rescan(path.nodes[0], status_item, 0);
 	btrfs_set_qgroup_status_generation(path.nodes[0], status_item,
 					   trans->transid);
+	btrfs_set_qgroup_status_version(path.nodes[0], status_item,
+					BTRFS_QGROUP_STATUS_VERSION);
 
 	btrfs_mark_buffer_dirty(path.nodes[0]);
 
diff --git a/ctree.h b/ctree.h
index 36f62732..083bde3c 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1034,6 +1034,7 @@ struct btrfs_qgroup_status_item {
 	__le64 rescan;		/* progress during scanning */
 } __attribute__ ((__packed__));
 
+#define BTRFS_QGROUP_STATUS_VERSION		1
 struct btrfs_block_group_item {
 	__le64 used;
 	__le64 chunk_objectid;
-- 
2.25.0

