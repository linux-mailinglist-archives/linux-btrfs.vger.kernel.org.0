Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588A5D1459
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbfJIQnt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 12:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfJIQnt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 12:43:49 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 332F821929
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2019 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570639428;
        bh=6IZu/yWdWOBMnzLN8v3g20gmhMity+DI65o8ju+ljXU=;
        h=From:To:Subject:Date:From;
        b=JBFM4HXtPlAYftUPavcCTmsIBV2a3e/1lzkoufqBm+JaQRArj4yjy3QGm1Odj6S2y
         ysN/Ufl8atVMO8slENzVMeacWO0fJDp2I339GBX00h0JiV8rOccbmLTkf6bvbwdPnk
         d80EXCKsvO3Ks8y6m/tKXs+PWtDQFomEcDByiveQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: add missing extents release on file extent cluster relocation error
Date:   Wed,  9 Oct 2019 17:43:45 +0100
Message-Id: <20191009164345.23713-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we error out when finding a page at relocate_file_extent_cluster(), we
need to release the outstanding extents counter on the relocation inode,
set by the previous call to btrfs_delalloc_reserve_metadata(), otherwise
the inode's block reserve size can never decrease to zero and metadata
space is leaked. Therefore add a call to btrfs_delalloc_release_extents()
in case we can't find the target page.

Fixes: 8b62f87bad9cf0 ("Btrfs: rework outstanding_extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 00504657b602..88dbc0127793 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3277,6 +3277,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 			if (!page) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							PAGE_SIZE, true);
+				btrfs_delalloc_release_extents(BTRFS_I(inode),
+							       PAGE_SIZE, true);
 				ret = -ENOMEM;
 				goto out;
 			}
-- 
2.11.0

