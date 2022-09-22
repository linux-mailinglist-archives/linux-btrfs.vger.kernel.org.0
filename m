Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1B5E633D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 15:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiIVNJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiIVNJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 09:09:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FCAEBBE4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 06:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27EEA631BC
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 13:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19152C433D6;
        Thu, 22 Sep 2022 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663852130;
        bh=SxGTFmJE6Bwygb6QmH+UlN3z6qpSppqBTnlCA52GjH4=;
        h=From:To:Cc:Subject:Date:From;
        b=Pcx3ZiX0hAjOImYSf0kO8nsdY6766kJv07yG8Lv2SDj/yE8V/B7ipNzPqMtS0Y80x
         aUy5MwYrYZTaEzGL4Dvv/LpUa7YpSMWD/K1aeINHWmvVXuTA5u7TEqtaOMBS9fxBiC
         HpOOWRVBGeiik3Bwv2VFjoVjIGMVG7mAuotT9YSsMVsR/gtpE9p6bf70Xh06JwuXm+
         tRr5DwmIoh0zLojrXHURQITdsJ25DWTN91YX139x8KdTuMK8YC/oVHVQHbPS3OAeeh
         b35sQOYGXmdIdmH1Esb+9Awo7NAAGmtL/vdADVe72VRtMn1FCjFTN5Huxb+Oq79Tst
         sjjhp91Rh9bKQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: drop btrfs_write_inode prototype
Date:   Thu, 22 Sep 2022 09:08:48 -0400
Message-Id: <20220922130848.96937-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function no longer exists.

Fixes: 3c4276936f6f ("Btrfs: fix btrfs_write_inode vs delayed iput deadlock")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/ctree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index df8c99c99df9..94a825e62541 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3358,7 +3358,6 @@ void btrfs_split_delalloc_extent(struct inode *inode,
 void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
 void btrfs_evict_inode(struct inode *inode);
-int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
 void btrfs_destroy_inode(struct inode *inode);
 void btrfs_free_inode(struct inode *inode);
-- 
2.37.3

