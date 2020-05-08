Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB21CA7CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEHKCK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 06:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgEHKCK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 06:02:10 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0191215A4
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588932130;
        bh=R8O+gozIr0KF5z7FHeWVFYjL/xTrznTdna/7KbyRtE4=;
        h=From:To:Subject:Date:From;
        b=0uBNbnlyiH7ioeBIIZ4/0PH3ytSi3749H8T0Efk9mNdDP/ws0WlDfjqznUihcX3Aj
         c7zZpDM9mzBZePq4QYwEvlXmRy/qeU5qhtc5gn0YmNjveqR5t7Y6IuQ+Q7xSPqV8KO
         HaM/OxTFAjDjDYJ5j+vudhNbLBB6xK6zKoVaId+k=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] Btrfs: scrub, only lookup for ccums if we are dealing with a data extent
Date:   Fri,  8 May 2020 11:02:07 +0100
Message-Id: <20200508100207.8684-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When scrubbing a stripe, whenever we find an extent we lookup for its
checksums in the checksum tree. However we do it even for metadata extents
which don't have checksum items stored in the checksum tree, that is
only for data extents.

So make the lookup for checksums only if we are processing with a data
extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/scrub.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2486f58d8205..c3b670858f8a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3343,13 +3343,16 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 						   &extent_dev,
 						   &extent_mirror_num);
 
-			ret = btrfs_lookup_csums_range(csum_root,
-						       extent_logical,
-						       extent_logical +
-						       extent_len - 1,
-						       &sctx->csum_list, 1);
-			if (ret)
-				goto out;
+			if (flags & BTRFS_EXTENT_FLAG_DATA) {
+				ret = btrfs_lookup_csums_range(csum_root,
+							       extent_logical,
+							       extent_logical +
+							       extent_len - 1,
+							       &sctx->csum_list,
+							       1);
+				if (ret)
+					goto out;
+			}
 
 			ret = scrub_extent(sctx, map, extent_logical, extent_len,
 					   extent_physical, extent_dev, flags,
-- 
2.11.0

