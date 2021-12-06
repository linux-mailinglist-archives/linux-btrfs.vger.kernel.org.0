Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FE2468F2F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhLFCdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54776 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhLFCdq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6601B2190C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qoTsttFOqm5Ra1hDC5glYCVygwcikdxENxP35HwHc8=;
        b=PBxeN03kGvmlju3Syxykh51pVG6Brlomgs4kj1SIxNVshHmi7TysICON4a4ba6TCbD+RoB
        GlRfUDl4ohqxtw3Cyl+uKj5CRSoU/lnxCgaakTIt8LWbKKW1wZPiYkfqz2hJ/EpR80Y0Ch
        PjqoYjz+YxI77clwCmxG+w3q8xwK/5c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B82AB13451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +L1gILh1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:30:16 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/17] btrfs: unexport btrfs_get_io_geometry()
Date:   Mon,  6 Dec 2021 10:29:37 +0800
Message-Id: <20211206022937.26465-18-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206022937.26465-1-wqu@suse.com>
References: <20211206022937.26465-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function provides a lighter weight version of btrfs_map_block(),
just to provide enough info without filling everything of
btrfs_map_block().

But that function is only used for stripe boundary calculation, and now
stripe boundary calculation is all handled inside btrfs_map_bio(), there
is no need to export it anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 fs/btrfs/volumes.h | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 301fc34320ed..61d281892449 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6320,9 +6320,9 @@ static bool need_full_stripe(enum btrfs_map_op op)
  * Returns < 0 in case a chunk for the given logical address cannot be found,
  * usually shouldn't happen unless @logical is corrupted, 0 otherwise.
  */
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom)
+static int get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
+			   enum btrfs_map_op op, u64 logical,
+			   struct btrfs_io_geometry *io_geom)
 {
 	struct map_lookup *map;
 	u64 len;
@@ -6434,7 +6434,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
+	ret = get_io_geometry(fs_info, em, op, logical, &geom);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 04c016a844f8..d5dbe7f946e0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -561,9 +561,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		     u64 logical, u64 *length,
 		     struct btrfs_io_context **bioc_ret);
-int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *map,
-			  enum btrfs_map_op op, u64 logical,
-			  struct btrfs_io_geometry *io_geom);
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info);
 int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
-- 
2.34.1

