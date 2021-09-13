Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B36408C76
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhIMNTw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:19:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39380 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbhIMNSr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39DFD21FEE;
        Mon, 13 Sep 2021 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vv/gG8G89P6rFNPsnWEw6K7c21EAxPPukjRDdyBNNxA=;
        b=jPqaKyMZPZFAtb1N+2qHrQvRB3zl5yurJ1XRIjkkV++mu0S6bBqRmRvGFwd2+yL5TAaJW3
        461wzPc3MgtF7//e6uWiYq4uKA4yGtOiihEUn3MwtOk5KVlntfd+A0EmZCLjrXTSBY+8Kz
        MUN5NOVuLtAgymx2049YYxJJjl17n60=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BE1813AB4;
        Mon, 13 Sep 2021 13:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QHiDAGtPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:31 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/8] btrfs-progs: Add btrfs_is_empty_uuid
Date:   Mon, 13 Sep 2021 16:17:22 +0300
Message-Id: <20210913131729.37897-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This utility function is needed by the RO->RW snapshot detection code.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel-shared/ctree.h     |  2 ++
 kernel-shared/uuid-tree.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3cca60323e3d..f53436a7f38b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2860,6 +2860,8 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
 int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subvol_id_cpu);
 
+int btrfs_is_empty_uuid(u8 *uuid);
+
 static inline int is_fstree(u64 rootid)
 {
 	if (rootid == BTRFS_FS_TREE_OBJECTID ||
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 21115a4d2d09..51a7b5d9ff5d 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -109,3 +109,14 @@ int btrfs_lookup_uuid_received_subvol_item(int fd, const u8 *uuid,
 					  BTRFS_UUID_KEY_RECEIVED_SUBVOL,
 					  subvol_id);
 }
+
+int btrfs_is_empty_uuid(u8 *uuid)
+{
+	int i;
+
+	for (i = 0; i < BTRFS_UUID_SIZE; i++) {
+		if (uuid[i])
+			return 0;
+	}
+	return 1;
+}
-- 
2.17.1

