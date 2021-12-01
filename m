Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99ED464672
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbhLAFWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:22:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346730AbhLAFV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 018751FD2F;
        Wed,  1 Dec 2021 05:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rf1NxhU4c5/yOnHNwAT9Uf2d3d2tjhJ4/y9hfGL/Jmk=;
        b=HJnaKyC6FUlOU0JySfWD3NQ16wzF4SGgbJfBgNDC0U0S3x7VDo+Zp8Ehqv7PHbOdur4pez
        dsp621Y2AtSGK+JHwEqF8YralPCwsGFATK+OnntfCNhHmvY8Rug4e2+9nXm8qlHWvPQmH/
        175DmgTOvi7Mw9pgLvq3zYpnBoIoPLw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06AF813425;
        Wed,  1 Dec 2021 05:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eAPfMawFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 17/17] btrfs: unexport btrfs_get_io_geometry()
Date:   Wed,  1 Dec 2021 13:17:56 +0800
Message-Id: <20211201051756.53742-18-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
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
index 35ba1ea95295..89d14531c2b3 100644
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
index b2dbf895b4e3..b37ee1e16d5b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -562,9 +562,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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

