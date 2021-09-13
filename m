Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF90408E13
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbhIMNbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:31:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50768 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbhIMNSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D14E01FFE3;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsAJKteqlLKMOkdoCFuno6umiSEi4NJBq5klDXSkVNY=;
        b=noENZTHNBY+KdZHBOUNLMswb455mnqQrfa29YL4eLaEagQBVYYfErqh45ksV8+s+G+hrNw
        AVO4DYMGX3q0vryQRS4o9mUFkx0AszdQJ+BADveBgweFz1dHahjp/1PM/j6iW79MzAy/iZ
        VojJId7td6yjHoij4+eAEfgEpSRlkcM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F99013F12;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGJ9JGxPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:32 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 7/8] btrfs-progs: check/lowmem: Implement received info clearing for RW volumes
Date:   Mon, 13 Sep 2021 16:17:28 +0300
Message-Id: <20210913131729.37897-8-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is the counterpart to the original mode's implementation but for
lowmem. I've put the code under the  if (!check_all) branch because
otherwise the check is run multiple times - from check_chunks_and_extents_lowmem
and from actual fs_root check. By having it under the !check_all
condition in check_btrfs_root it ensures that the check is performed
only when checking the fs roots themselves.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/mode-lowmem.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 323e66bc4cb1..70cf164752ff 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5197,6 +5197,44 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 		ret = check_fs_first_inode(root);
 		if (ret < 0)
 			return FATAL_ERROR;
+
+		if (!((btrfs_root_flags(root_item) & BTRFS_ROOT_SUBVOL_RDONLY) ||
+					btrfs_is_empty_uuid(root_item->received_uuid))) {
+			printf("Subvolume id: %llu is RW and has a received uuid\n",
+					root->root_key.objectid);
+			if (repair) {
+				struct btrfs_trans_handle *trans = btrfs_start_transaction(root, 2);
+				if (IS_ERR(trans))
+					return PTR_ERR(trans);
+
+				ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
+						BTRFS_UUID_KEY_RECEIVED_SUBVOL, root->root_key.objectid);
+
+				if (ret && ret != -ENOENT) {
+					btrfs_abort_transaction(trans, ret);
+					return ret;
+				}
+
+				memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
+				btrfs_set_root_stransid(root_item, 0);
+				btrfs_set_root_rtransid(root_item, 0);
+				btrfs_set_stack_timespec_sec(&root_item->stime, 0);
+				btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
+				btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
+				btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
+
+				ret = btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
+						root_item);
+				if (ret < 0) {
+					btrfs_abort_transaction(trans, ret);
+					return ret;
+				}
+
+				btrfs_commit_transaction(trans, gfs_info->tree_root);
+				printf("Cleared received information for subvol: %llu\n",
+						root->root_key.objectid);
+			}
+		}
 	}
 
 
-- 
2.17.1

