Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EEB477532
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhLPPAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 10:00:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49910 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhLPPAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 10:00:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBC861E43
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 15:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1079C36AE0
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639666836;
        bh=BK63VNenmu0BvmH9lBRMDIxFSDTqV5BR0vAOlfNwkjI=;
        h=From:To:Subject:Date:From;
        b=dZ3q4L4pkqEVLvjMwH7NYcd3AphfUMC2MSs6aWwfxJb/Xyjw4evcNUTdKeAEkivtI
         TSSl7w6hip0kbTyIRLtiPadmj+LZ31cwQ9gu3MbxwprSbwIUppzJHWr+CdoNMekUGF
         TnRYLGqCPZ6NTJjxrRy0Wvlqn4/Fs2GuAFaUb2bNsdICXGQ4jwN6wH54770SMDFKMB
         UshRy+9m5L1eiAheo22Id38/5n8oFLe9eyZQclj2azGltVj+of3rDfejNozaqlDwKe
         UAUFCq33TjYn/0KdWd9299V0WP9wpqK25+66Hb9mfj83CThVtG9Wz0lS7PZBGjAAac
         V/urEqQUAY0Pg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: respect the max size in the header when activating swap file
Date:   Thu, 16 Dec 2021 15:00:32 +0000
Message-Id: <639eadb028056b60364ba7461c5e20e5737229a2.1639666714.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

If we extended the size of a swapfile after its header was created (by the
mkswap utility) and then try to activate it, we will map the entire file
when activating the swap file, instead of limiting to the max size defined
in the swap file's header.

Currently test case generic/643 from fstests fails because we do not
respect that size limit defined in the swap file's header.

So fix this by not mapping file ranges beyond the max size defined in the
swap header.

This is the same type of bug that iomap used to have, and was fixed in
commit 36ca7943ac18ae ("mm/swap: consider max pages in
iomap_swapfile_add_extent").

Fixes: ed46ff3d423780 ("Btrfs: support swap files")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 97fd33d599eb..b17d14ec4d46 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10263,9 +10263,19 @@ static int btrfs_add_swap_extent(struct swap_info_struct *sis,
 				 struct btrfs_swap_info *bsi)
 {
 	unsigned long nr_pages;
+	unsigned long max_pages;
 	u64 first_ppage, first_ppage_reported, next_ppage;
 	int ret;
 
+	/*
+	 * Our swapfile may have had its size extended after the swap header was
+	 * written. In that case activating the swapfile should not go beyond
+	 * the max size set in the swap header.
+	 */
+	if (bsi->nr_pages >= sis->max)
+		return 0;
+
+	max_pages = sis->max - bsi->nr_pages;
 	first_ppage = ALIGN(bsi->block_start, PAGE_SIZE) >> PAGE_SHIFT;
 	next_ppage = ALIGN_DOWN(bsi->block_start + bsi->block_len,
 				PAGE_SIZE) >> PAGE_SHIFT;
@@ -10273,6 +10283,7 @@ static int btrfs_add_swap_extent(struct swap_info_struct *sis,
 	if (first_ppage >= next_ppage)
 		return 0;
 	nr_pages = next_ppage - first_ppage;
+	nr_pages = min(nr_pages, max_pages);
 
 	first_ppage_reported = first_ppage;
 	if (bsi->start == 0)
-- 
2.33.0

