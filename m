Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66B018A3A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCRUTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:19:00 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:14114 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCRUS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:18:59 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 1DD6F16B56
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:58 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9WjBN4ULnBiEf9Wjh8Yi; Wed, 18 Mar 2020 15:18:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+7MMq0skBd4GN0Wsv2CMytC6ZYdlLaM8PZ6eB8b5ojg=; b=CWXtIUuM7ivs4Lj1hmGmUWsJye
        EH889LR3hjsS+jvWN6CCGNlt4NAIxza/YoG95xHJIcFp6RUYtfO7nAx/mv9Omd31Kk7ljApjzyQZE
        /VLwsi9fA0qFnuWwnBZ8gRruHZm1rQNQV58bKtRBGSck/SQtnbXCmNCIzTCY57LEecqmMvnprXPlh
        NBgG7BIzDSOUVNoIUqdk/RaeHNwQBZ7QZa5BJP+aSnyqe/26UaG/kmimxKQh5G62gMWINAj9o1eKG
        4zLHCnVZi01IMMyC5GZv0Wqlsa1+ePfWsbMB7SqklO5e/BT/SS/45kRcs3QP5aLGYSfRli+tFrwg7
        qZh+c5QQ==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9V-000yAj-DC; Wed, 18 Mar 2020 17:18:57 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 08/11] btrfs-progs: mkfs: Introduce function to setup quota root and rescan
Date:   Wed, 18 Mar 2020 17:21:45 -0300
Message-Id: <20200318202148.14828-9-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9V-000yAj-DC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 29
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Introduce a new function, setup_quota_root(), which will create quota
root, and do an offline rescan to ensure all quota accounting numbers
are correct.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[ minor improvement in the fail path ]
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 mkfs/main.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 6d9b3265..1fb25a9d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -48,6 +48,7 @@
 #include "crypto/crc32c.h"
 #include "common/fsfeatures.h"
 #include "common/box.h"
+#include "check/qgroup-verify.h"
 
 static int verbose = 1;
 
@@ -832,6 +833,91 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int setup_quota_root(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_qgroup_status_item *qsi;
+	struct btrfs_root *quota_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int qgroup_repaired = 0;
+	int ret;
+
+	/* One to modify tree root, one for quota root */
+	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		error("failed to start transaction: %d (%s)",
+			ret, strerror(-ret));
+		return ret;
+	}
+	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
+	if (ret < 0) {
+		error("failed to create quota root: %d (%s)",
+			ret, strerror(-ret));
+		goto fail;
+	}
+	quota_root = fs_info->quota_root;
+
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_STATUS_KEY;
+	key.offset = 0;
+
+	btrfs_init_path(&path);
+	ret = btrfs_insert_empty_item(trans, quota_root, &path, &key,
+				      sizeof(*qsi));
+	if (ret < 0) {
+		error("failed to insert qgroup status item: %d (%s)",
+			ret, strerror(-ret));
+		goto fail;
+	}
+
+	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			     struct btrfs_qgroup_status_item);
+	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, 0);
+	btrfs_set_qgroup_status_rescan(path.nodes[0], qsi, 0);
+
+	/* Mark current status info inconsistent, and fix it later */
+	btrfs_set_qgroup_status_flags(path.nodes[0], qsi,
+			BTRFS_QGROUP_STATUS_FLAG_ON |
+			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
+	btrfs_release_path(&path);
+
+	/* Currently mkfs will only create one subvolume */
+	ret = insert_qgroup_items(trans, fs_info, BTRFS_FS_TREE_OBJECTID);
+	if (ret < 0) {
+		error("failed to insert qgroup items: %d (%s)",
+			ret, strerror(-ret));
+		goto fail;
+	}
+
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		error("failed to commit current transaction: %d (%s)",
+			ret, strerror(-ret));
+		return ret;
+	}
+
+	/*
+	 * Qgroup is setup but with wrong info, use qgroup-verify
+	 * infrastructure to repair them.
+	 * (Just acts as offline rescan)
+	 */
+	ret = qgroup_verify_all(fs_info);
+	if (ret < 0) {
+		error("qgroup rescan failed: %d (%s)", ret, strerror(-ret));
+		return ret;
+	}
+	ret = repair_qgroups(fs_info, &qgroup_repaired, true);
+	if (ret < 0)
+		error("failed to fill qgroup info: %d (%s)", ret,
+			strerror(-ret));
+	return ret;
+fail:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 int BOX_MAIN(mkfs)(int argc, char **argv)
 {
 	char *file;
-- 
2.25.0

