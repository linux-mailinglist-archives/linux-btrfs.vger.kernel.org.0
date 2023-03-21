Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BA46C2FFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCULOv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCULOr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE36149DA
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16E8CB815BE
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59190C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397260;
        bh=GL2LAIGNbxHFtqbPtd7Q1PrEWzXb3gGQDrHLqta0Lyo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aqje9iARLXT8ORJzh2Q7fW+thUXEuvXqKRmdSy4CC6rT/hjpU9lhZpXmKmp0eri/N
         0i4EmdYfOvM0a6YvDSr7Vd5p+8Jl+BSH9CdGkJDcSTMORaIZx8Xe2fgxkdI8Mj25YH
         OhYZXofAgUKqdHApq5/z27Q1TdesiaLuYxUeBGclBCdh79dmxiE5BF/A8g20lfMCKO
         utUaOMolOIC7P+mhpT4DW3morl9ru7z3iwS10uXCV2NPDxJGRDr/WQS3EaZWdukEmP
         1vlj4cnLLP9EM0nVQK6Xo6NzDNiDt/MahZ89as+95mlzIvVyNtj5jSP+kHY+hw8qEV
         uc1j/fZgfPnrQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 18/24] btrfs: constify fs_info argument for the reclaim items calculation helpers
Date:   Tue, 21 Mar 2023 11:13:54 +0000
Message-Id: <70dff2b84bb04e277e8e62ae0709d08f44eeee60.1679326434.git.fdmanana@suse.com>
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

Now that btrfs_calc_insert_metadata_size() can take a const fs_info
argument, make the fs_info argument of calc_reclaim_items_nr() and of
calc_delayed_refs_nr() const as well.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f36b16ee0a02..a2e14c410416 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -537,7 +537,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	up_read(&info->groups_sem);
 }
 
-static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
+static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
 					u64 to_reclaim)
 {
 	u64 bytes;
@@ -550,7 +550,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 	return nr;
 }
 
-static inline u64 calc_delayed_refs_nr(struct btrfs_fs_info *fs_info,
+static inline u64 calc_delayed_refs_nr(const struct btrfs_fs_info *fs_info,
 				       u64 to_reclaim)
 {
 	u64 bytes;
-- 
2.34.1

