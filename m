Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A16C3006
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCULPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCULOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C722E80F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EDB461B19
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B9C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397259;
        bh=hP4vJCnFaf1FuRGwyOqw6rJoqNo8QZk65iAqXetaKls=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RTf9kzw8PkYWBgop7dXW5kEiKSg1/olrFOijtLHj9BZq2x9m1dOT0wJvBY9l+q+GA
         /zX505SoRfMEc7HwOQJNbYedDk46t/vy+Wr/aS/mj/7gjbXVRlh6ewpTY7fuU38Dq2
         HKZ5SOtAMDeoM/sPTIRAeFhmFpI/tw3OGwuPB2yj9Y0v1bCpffJEdFhMfq5f4G7U9G
         Tar0yN3tXBIS0UpwcA8wx4nzo1uL8HCEr9mQ4VZztyYuh8sNR3NR8/oa5Zp5N3Aqc1
         2Tf8i9nT4OKpQmhp8FNIBhrZQFJGb/b4puzxscpQuDQKyCbZFjwqEyorjo/oZxbLGS
         ESCKaENp6cWKw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/24] btrfs: accurately calculate number of delayed refs when flushing
Date:   Tue, 21 Mar 2023 11:13:52 +0000
Message-Id: <0ae56ee41ac09f5e6dbc4d5732f4ede73f4995e7.1679326434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When flushing a limited number of delayed references (FLUSH_DELAYED_REFS_NR
state), we are assuming each delayed reference is holding a number of bytes
matching the needed space for inserting for a single metadata item (the
result of btrfs_calc_insert_metadata_size()). That is not correct when
using the free space tree, as in that case we have to multiply that value
by 2 since we need to touch the free space tree as well. This is the same
computation as we do at btrfs_update_delayed_refs_rsv() and at
btrfs_delayed_refs_rsv_release().

So correct the computation for the amount of delayed references we need to
flush in case we have the free space tree. This does not fix a functional
issue, instead it makes the flush code flush less delayed references, only
the minimum necessary to satisfy a ticket.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5eb161d96e35..f36b16ee0a02 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -550,6 +550,30 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 	return nr;
 }
 
+static inline u64 calc_delayed_refs_nr(struct btrfs_fs_info *fs_info,
+				       u64 to_reclaim)
+{
+	u64 bytes;
+	u64 nr;
+
+	bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		bytes *= 2;
+
+	nr = div64_u64(to_reclaim, bytes);
+	if (!nr)
+		nr = 1;
+	return nr;
+}
+
 #define EXTENT_SIZE_PER_ITEM	SZ_256K
 
 /*
@@ -727,7 +751,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		if (state == FLUSH_DELAYED_REFS_NR)
-			nr = calc_reclaim_items_nr(fs_info, num_bytes);
+			nr = calc_delayed_refs_nr(fs_info, num_bytes);
 		else
 			nr = 0;
 		btrfs_run_delayed_refs(trans, nr);
-- 
2.34.1

