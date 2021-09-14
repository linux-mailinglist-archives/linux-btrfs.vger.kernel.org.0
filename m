Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D140AA3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhINJHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 05:07:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhINJHT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 05:07:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9A1E220CD;
        Tue, 14 Sep 2021 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631610361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUluzSs8xnZRQzd03XT0GEmckWZ1FkkvgzG3aGSKi9Q=;
        b=fSQIrDewXkhER+ss6Yr3xcfxR2E+MFcclCVvzDB1rArIq/v8XJeYpYzWOmIIUSiUW4mORO
        xmRBKrY/KPk2bF6RUpZu9AGGjGlcJMkJfLyWeDYjeGipw55x97qLyUVSg0K3ijmWTkcJk2
        z699WazQKCCmA/tbxioze9fTTM0CbbY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A598F13D3F;
        Tue, 14 Sep 2021 09:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDDSJfllQGH5NwAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 14 Sep 2021 09:06:01 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 6/8] btrfs-progs: Implement helper to remove received information of RW subvol
Date:   Tue, 14 Sep 2021 12:05:56 +0300
Message-Id: <20210914090558.79411-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914090558.79411-1-nborisov@suse.com>
References: <20210914090558.79411-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/mode-common.c | 40 ++++++++++++++++++++++++++++++++++++++++
 check/mode-common.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/check/mode-common.c b/check/mode-common.c
index 0059672c6402..7a5313280f3f 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1301,3 +1301,43 @@ int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+int repair_received_subvol(struct btrfs_root *root)
+{
+	struct btrfs_root_item *root_item = &root->root_item;
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_start_transaction(root, 2);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
+			BTRFS_UUID_KEY_RECEIVED_SUBVOL, root->root_key.objectid);
+
+	if (ret && ret != -ENOENT) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
+	btrfs_set_root_stransid(root_item, 0);
+	btrfs_set_root_rtransid(root_item, 0);
+	btrfs_set_stack_timespec_sec(&root_item->stime, 0);
+	btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
+	btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
+	btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
+
+	ret = btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
+			root_item);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
+	if (!ret)
+		printf("Cleared received information for subvol: %llu\n",
+				root->root_key.objectid);
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index cdfb10d58cde..f1ec5dca0199 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -130,6 +130,7 @@ int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		struct btrfs_path *path, u64 ino, u32 mode);
 int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path);
 int check_repair_free_space_inode(struct btrfs_path *path);
+int repair_received_subvol(struct btrfs_root *root);
 
 /*
  * Check if the inode mode @imode is valid
-- 
2.17.1

