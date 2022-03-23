Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5544C4E5638
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiCWQVT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245451AbiCWQVS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B797B115
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6953BB81F8B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD6DC340E8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052386;
        bh=R5Oyu4xoBIFQPejq2Fx+5VSpwAK/+sX+RvDU2bCoDZs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qG0Bng7QO/liUJ6GPJwqtcLvJ0L9s+UR2vVH85rdLp8/vw5AIA3x3rb+OQUZ/HLN1
         83OfhHyCGdtkG5WM+zUsl8nhF8dBr31n4Sc72OTZc+CvEpL9bUIAH9k/rO5yXZZib1
         GQgohkGnw4S2lptoxfyl64svnYkNs5WUckZI98J819/JBpOqUBXTMg8/MN0gUsNOjh
         V5Fvds2yO3XfgzwPM7hV6fhUKfKdHDSOikRGUwRzCiw2/JYcJ8v7e5sCNadW0YKujw
         UwKbI58WWsidaBLC/kw2bTyK5KJwGx4mxQbGxEpZ4lAtIX3AmiZWpOTi70q/Krwjua
         SXM38yAVgfibA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: avoid blocking when allocating context for nowait dio read/write
Date:   Wed, 23 Mar 2022 16:19:29 +0000
Message-Id: <451f57358e2a191a3ff605c79edba40a104e6487.1648051583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing a NOWAIT direct IO read/write, we allocate a context object
(struct btrfs_dio_data) with GFP_NOFS, which can result in blocking
waiting for memory allocation (GFP_NOFS is __GFP_RECLAIM | __GFP_IO).
This is undesirable for the NOWAIT semantics, so do the allocation with
GFP_NOWAIT if we are serving a NOWAIT request and if the allocation fails
return -EAGAIN, so that the caller can fallback to a blocking context and
retry with a non-blocking write.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a515ae491eb..ca1d03b5f510 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7593,9 +7593,15 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		}
 	}
 
-	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
-	if (!dio_data)
-		return -ENOMEM;
+	if (flags & IOMAP_NOWAIT) {
+		dio_data = kzalloc(sizeof(*dio_data), GFP_NOWAIT);
+		if (!dio_data)
+			return -EAGAIN;
+	} else {
+		dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
+		if (!dio_data)
+			return -ENOMEM;
+	}
 
 	iomap->private = dio_data;
 
-- 
2.33.0

