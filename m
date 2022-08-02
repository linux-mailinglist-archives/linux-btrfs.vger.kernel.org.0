Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9258786A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiHBHxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 03:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiHBHxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 03:53:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC9B115E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 00:53:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8D92041E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659426783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQu9ud6zjxmJ7nlbCfxpk/VKVz4Rw2DvHS/t7uZqtQY=;
        b=ZSLUSEMdtXNH/t8CPRu1aOYpeQp3xQmtZfPq9yWga2el7lfgPxTIFi1qgboI9UPbGJa2Vj
        RIG9R2gjrhw5pwM2UZcxDQ9x7D7/ZBX4gavWRkRoNpSpqZBn8rcGr/tH+XNxJKhCJlintz
        VXRTYZOR5fGQFaDO1e28Jukb0h1KhMA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AF0B13A8E
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 07:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2GiBM97X6GKlOgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 07:53:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: use write_data_to_disk() to handle RAID56 in write_and_map_eb()
Date:   Tue,  2 Aug 2022 15:52:43 +0800
Message-Id: <8737d093b224c21253afc93d4f62c6ff70e0ed4a.1659426744.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1659426744.git.wqu@suse.com>
References: <cover.1659426744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function write_data_to_disk() can handle RAID56 writes without any
problem.

So just call write_data_to_disk() inside write_and_map_eb() instead of
manually doing the RAID56 write.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index a6e66aee7bf7..d276e52df060 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -452,39 +452,10 @@ struct extent_buffer* read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 int write_and_map_eb(struct btrfs_fs_info *fs_info, struct extent_buffer *eb)
 {
 	int ret;
-	u64 length;
 	u64 *raid_map = NULL;
 	struct btrfs_multi_bio *multi = NULL;
 
-	length = eb->len;
-	ret = btrfs_map_block(fs_info, WRITE, eb->start, &length,
-			      &multi, 0, &raid_map);
-	if (ret < 0) {
-		errno = -ret;
-		error("failed to map bytenr %llu length %u: %m",
-			eb->start, eb->len);
-		goto out;
-	}
-
-	/* RAID56 write back need RMW */
-	if (raid_map) {
-		ret = write_raid56_with_parity(fs_info, eb, multi,
-					       length, raid_map);
-		if (ret < 0) {
-			errno = -ret;
-			error(
-		"failed to write raid56 stripe for bytenr %llu length %llu: %m",
-				eb->start, length);
-		} else {
-			ret = 0;
-		}
-		goto out;
-	}
-
-	/*
-	 * For non-RAID56, we just writeback data to all mirrors using
-	 * write_data_to_disk().
-	 */
+	/* write_data_to_disk() will handle all mirrors and RAID56. */
 	ret = write_data_to_disk(fs_info, eb->data, eb->start, eb->len);
 	if (ret < 0) {
 		errno = -ret;
-- 
2.37.0

