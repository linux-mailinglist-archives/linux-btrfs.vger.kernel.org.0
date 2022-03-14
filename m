Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D704D7E2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiCNJJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiCNJJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75726577
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 597D71F388
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sb+EeigAs/k9ml+xW66PmrMRlQvffjcVfFoSHpjlxDc=;
        b=PLaeG5qPm53GN2YqTSaQj/gjU1jyrhpr+9raj2zqgMgUE3PvdqyyloTHcwRH88jmxmNb7M
        qpZ6YB5vCLjsPVXuE4op9QxSV67JWYIE4/y5wWh0CdK/wsjYWX/FxPMy/3e0C8El39sY3w
        hTXW0BJyEK6/lkweryF+fgmIJsB9jN0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD01C13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GD+pHfgFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 18/18] btrfs: unexport btrfs_get_io_geometry()
Date:   Mon, 14 Mar 2022 17:07:31 +0800
Message-Id: <00568c781d6331549523017f9addd97fc71a3584.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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
index 403aa371c11f..301491429e37 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6312,9 +6312,9 @@ static bool need_full_stripe(enum btrfs_map_op op)
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
@@ -6426,7 +6426,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
 
-	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
+	ret = get_io_geometry(fs_info, em, op, logical, &geom);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 410617cb7533..9259c1a4cf73 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -559,9 +559,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
2.35.1

