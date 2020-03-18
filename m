Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4A18A3A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRUSs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:18:48 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.46]:33925 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726733AbgCRUSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:18:47 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A94D2190F05
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:47 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9LjBMssLnBiEf9Ljh8N7; Wed, 18 Mar 2020 15:18:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7TJZ+sCVjJrSn+DU1CLSw/cotnXtVMUu6fJsYQSLKkM=; b=juMXASig38DQGMBdzjH+xzf32v
        KNlHqRldIlfxgS0gxH37t0QiUThIa1czT9j8olkTt3VBctWL99aIN+vcPzw8pukwUyUAQrBhueh6R
        Zz9zqtx6dDY2Lify9gMkagmRU9EP9wArD2alh0YErE3DvmcO7PWnL5Yzkws0Dm/KbLZpf3SIinHry
        IjzOmmHi+57YGu5vVqgh89RWnf846CEfmiLJ5DNOomRNvQL2WeyvpULDL9j2OlY1pkPxzT9duwiYO
        3/7TImJtxG1Wi84g5CHD9SX74vxgEX9XG1omy1DEAVq3RTcsxGem3Edc/feVUxkJvjDwqqDm4HunJ
        j38lIw7A==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9L-000yAj-3g; Wed, 18 Mar 2020 17:18:47 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 01/11] btrfs-progs: qgroup-verify: Avoid NULL pointer dereference for later silent qgroup repair
Date:   Wed, 18 Mar 2020 17:21:38 -0300
Message-Id: <20200318202148.14828-2-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9L-000yAj-3g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 5
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Commit 078e9a1cc973 ("btrfs-progs: check: enhanced progress indicator")
introduced @qgroup_item_count for progress indicator.

However since we will later introduce silent qgroup rescan
functionality, the @qgroup_item_count pointer can be NULL.

So check if @qgroup_item_count is NULL before accessing it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/qgroup-verify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index afe15acf..17c266d4 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -743,7 +743,8 @@ static int travel_tree(struct btrfs_fs_info *info, struct btrfs_root *root,
 	 */
 	nr = btrfs_header_nritems(eb);
 	for (i = 0; i < nr; i++) {
-		(*qgroup_item_count)++;
+		if (qgroup_item_count)
+			(*qgroup_item_count)++;
 		new_bytenr = btrfs_node_blockptr(eb, i);
 		new_num_bytes = info->nodesize;
 
-- 
2.25.0

