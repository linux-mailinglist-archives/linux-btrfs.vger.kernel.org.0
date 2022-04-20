Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E3507D8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358569AbiDTAXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358554AbiDTAXN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1FA2C676
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A604A1F380
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9NraPPh7cljiaoLIwDvhHbrob+tO4OO7VJm2i7NrGM=;
        b=NBO5Yz/xahHseE8Ko9+rQq8yDp6pe+TTjBeTbwdWyUUVTy9UykOffBEGMIvWb+k83nBbmv
        eth4y6MrsZ5qiW3wxNi7gRcPnzkXKlxt1jKQ09JU5IJo4Bmfk+7gPjImnMVwZVzqsUakdX
        BxTnoEf4hjBVYnAL6zWeUqWX844EKB8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC00F139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGjrK8tRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 09/10] btrfs-progs: mkfs/sprout: introduce a helper to remove empty system chunks from seed device
Date:   Wed, 20 Apr 2022 08:19:58 +0800
Message-Id: <0bfae2b54049cb076c1443fd58ec065a9e84c1f2.1650413308.git.wqu@suse.com>
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

Even if an empty system chunk is still in sys_chunk_array, kernel will
reject the mount.

So here we introduce the helper to do the removal, by iterating through
all block groups, and remove the block group if it's a system chunk and
contains stripe which points to the seed device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/sprout.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mkfs/sprout.c b/mkfs/sprout.c
index 38d80d789084..049098872d3e 100644
--- a/mkfs/sprout.c
+++ b/mkfs/sprout.c
@@ -241,3 +241,56 @@ static int sprout_relocate_chunk_tree(struct btrfs_trans_handle *trans)
 	btrfs_release_path(&path);
 	return ret;
 }
+
+static int sprout_remove_seed_sys_chunk(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group *bg;
+	struct btrfs_device *seed_dev;
+	int ret;
+
+	/* We should have exacly one seed device */
+	ASSERT(fs_info->fs_devices->seed);
+	ASSERT(fs_info->fs_devices->seed->devices.next ==
+	       fs_info->fs_devices->seed->devices.prev);
+	seed_dev = list_entry(fs_info->fs_devices->seed->devices.next,
+			      struct btrfs_device, dev_list);
+	bg = btrfs_lookup_first_block_group(fs_info, 0);
+	while (bg) {
+		const u64 cur = bg->start + bg->length;
+
+		struct cache_extent *ce;
+		struct map_lookup *map;
+		bool delete = false;
+		int i;
+
+		if (!(bg->flags & BTRFS_BLOCK_GROUP_SYSTEM))
+			goto next;
+
+		ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
+					 bg->start);
+		if (!ce) {
+			/* No chunk map for an bg, a big problem */
+			error("no chunk map for block group at %llu", bg->start);
+			return -EUCLEAN;
+		}
+		map = container_of(ce, struct map_lookup, ce);
+
+		for (i = 0; i < map->num_stripes; i++) {
+			if (map->stripes[i].dev == seed_dev) {
+				delete = true;
+				break;
+			}
+		}
+		if (!delete)
+			goto next;
+
+		ret = btrfs_remove_block_group(trans, bg->start, bg->length);
+		if (ret < 0)
+			return ret;
+next:
+		/* Has to using @cur, as the current bg may has been deleted */
+		bg = btrfs_lookup_first_block_group(fs_info, cur);
+	}
+	return 0;
+}
-- 
2.35.1

