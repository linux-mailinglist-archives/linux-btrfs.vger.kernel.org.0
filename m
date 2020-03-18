Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB518A3A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCRUS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:18:57 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:41092 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCRUS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:18:57 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 8444810C3BC9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:56 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9UjBN2gLnBiEf9Ujh8Wy; Wed, 18 Mar 2020 15:18:56 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wX42d+FnfgrXr8XCTpCE5OubZ7NxM0U2yhf7d175Yzo=; b=IGFC7e+LGWnQ0eYjJ8N8F1B0gl
        /LS+eu9Hy36XQSOG+/4+uyfltBE2uHAV5warOPh3wmXMmUkPGOj5DywO6enh0eHYXUCmQawiqO+bn
        r4RCCtMerAakcTp8muPqEX5DU4QZGm8qMvQsUieDL3pdlcs9u7ycCIP76pvlbTEKtS7aJNPFO1WFi
        WPiNs74MO273fsRt/UJpWl+6JdsWcaxSCRf23S+LFOjiW3nTF3R7lVApY3jtuKDeq1sZ3oISS73Pd
        dVr0h9cX7KMPPebe2JQAtQKrrsJg0kjfdtnvB5C4cdRqnPcwbc7kF/1pXJN3i3HNjsyvQal4va7Gd
        YIHx0/OA==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9T-000yAj-RS; Wed, 18 Mar 2020 17:18:56 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 07/11] btrfs-progs: mkfs: Introduce function to insert qgroup info and limit items
Date:   Wed, 18 Mar 2020 17:21:44 -0300
Message-Id: <20200318202148.14828-8-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9T-000yAj-RS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 25
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Introduce a new function, insert_qgroup_items(), to insert qgroup info
item and qgroup limit item for later mkfs qgroup support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 316ea82e..6d9b3265 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -798,6 +798,40 @@ out:
 	return ret;
 }
 
+static int insert_qgroup_items(struct btrfs_trans_handle *trans,
+			       struct btrfs_fs_info *fs_info,
+			       u64 qgroupid)
+{
+	struct btrfs_path path;
+	struct btrfs_root *quota_root = fs_info->quota_root;
+	struct btrfs_key key;
+	int ret;
+
+	if (qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT) {
+		error("qgroup level other than 0 is not supported yet");
+		return -ENOTTY;
+	}
+
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_INFO_KEY;
+	key.offset = qgroupid;
+
+	btrfs_init_path(&path);
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(struct btrfs_qgroup_info_item));
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_LIMIT_KEY;
+	key.offset = qgroupid;
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(struct btrfs_qgroup_limit_item));
+	btrfs_release_path(&path);
+	return ret;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
-- 
2.25.0

