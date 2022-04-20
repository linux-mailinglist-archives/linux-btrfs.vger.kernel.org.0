Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A5507D8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358553AbiDTAXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358530AbiDTAXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4488E2C651
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 082311F380
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w++lN50DaPxkOLKFJhP6rnJ6F3Ss7apXaiKwRd/U3c8=;
        b=FT/VmPVUsj+lDokfQDIvsEiLF1r6LncecVWbxiwVk1YR/qDiqhN/itN+75sIG1iV9pXjpz
        jrwZtYe+OeRmgvKTuO1elA7HkjVYaakv+CaEjAYXAs//xfiNrPDKC9MmHaAbk56qIHjmhq
        PtV4TM4OWG9LyfvdH3Z2dSyG5KeWtsY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DD3E139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MJwaBcdRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 05/10] btrfs-progs: extract btrfs_fs_devices structure allocation into a helper
Date:   Wed, 20 Apr 2022 08:19:54 +0800
Message-Id: <1af9f1d7c9c1fa1eb96482e4d1f975baf309554b.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper function, btrfs_alloc_fs_devices() will allocate and
initialize a btrfs_fs_devices structure.

This helper will be later used by seed sprout, as we will need to create
a new fs_devices for the sproted fs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/volumes.c | 38 +++++++++++++++++++++++++++-----------
 kernel-shared/volumes.h |  2 ++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 923e1a9378d5..fe4e61710951 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -331,6 +331,31 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 	return NULL;
 }
 
+struct btrfs_fs_devices *btrfs_alloc_fs_devices(const u8 *fsid,
+						const u8 *metadata_uuid)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
+	if (!fs_devices)
+		return NULL;
+
+	INIT_LIST_HEAD(&fs_devices->devices);
+	list_add(&fs_devices->list, &fs_uuids);
+	memcpy(fs_devices->fsid, fsid, BTRFS_FSID_SIZE);
+
+	if (metadata_uuid)
+		memcpy(fs_devices->metadata_uuid, metadata_uuid,
+		       BTRFS_FSID_SIZE);
+	else
+		memcpy(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE);
+
+	fs_devices->latest_trans = 0;
+	fs_devices->latest_devid = (u64)-1;
+	fs_devices->lowest_devid = (u64)-1;
+	return fs_devices;
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
@@ -348,22 +373,13 @@ static int device_list_add(const char *path,
 		fs_devices = find_fsid(disk_super->fsid, NULL);
 
 	if (!fs_devices) {
-		fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
+		fs_devices = btrfs_alloc_fs_devices(disk_super->fsid,
+				metadata_uuid ? disk_super->metadata_uuid : NULL);
 		if (!fs_devices)
 			return -ENOMEM;
-		INIT_LIST_HEAD(&fs_devices->devices);
-		list_add(&fs_devices->list, &fs_uuids);
-		memcpy(fs_devices->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
-		if (metadata_uuid)
-			memcpy(fs_devices->metadata_uuid,
-			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
-		else
-			memcpy(fs_devices->metadata_uuid, fs_devices->fsid,
-			       BTRFS_FSID_SIZE);
 
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
-		fs_devices->lowest_devid = (u64)-1;
 		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 		device = NULL;
 	} else {
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 2beae2d02fad..f9e564e4dc5e 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -276,6 +276,8 @@ int btrfs_insert_chunk_item(struct btrfs_trans_handle *trans,
 			    struct map_lookup *map);
 int btrfs_open_devices(struct btrfs_fs_info *fs_info,
 		       struct btrfs_fs_devices *fs_devices, int flags);
+struct btrfs_fs_devices *btrfs_alloc_fs_devices(const u8 *fsid,
+						const u8 *metadata_uuid);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_close_all_devices(void);
 int btrfs_insert_dev_extent(struct btrfs_trans_handle *trans,
-- 
2.35.1

