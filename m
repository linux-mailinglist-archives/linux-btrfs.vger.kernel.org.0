Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F515DF98
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391290AbgBNQJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 11:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391284AbgBNQJa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B5824682;
        Fri, 14 Feb 2020 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696569;
        bh=pLqWsJQGIs+4qcANymREjBjxFeOyl45gGvkYi5cjcRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xFutytQMFZ/g5c+pLm6dm5YdrJM6nD8mBWHCL2Mn76CnmJ6xPH1NUfygC5HJfrQH
         DbVHM1n7t6cMgFWKqZcjvm+73sBRg3nVwUVTRRsjUnCfKCYUnrII1unERWnlXWhI9Q
         X2LgaP2SzJGwbr/O2rsRcClfZCIGwJqb+iLVBri4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 359/459] btrfs: fix possible NULL-pointer dereference in integrity checks
Date:   Fri, 14 Feb 2020 11:00:09 -0500
Message-Id: <20200214160149.11681-359-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <jth@kernel.org>

[ Upstream commit 3dbd351df42109902fbcebf27104149226a4fcd9 ]

A user reports a possible NULL-pointer dereference in
btrfsic_process_superblock(). We are assigning state->fs_info to a local
fs_info variable and afterwards checking for the presence of state.

While we would BUG_ON() a NULL state anyways, we can also just remove
the local fs_info copy, as fs_info is only used once as the first
argument for btrfs_num_copies(). There we can just pass in
state->fs_info as well.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205003
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/check-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 0b52ab4cb9649..72c70f59fc605 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -629,7 +629,6 @@ static struct btrfsic_dev_state *btrfsic_dev_state_hashtable_lookup(dev_t dev,
 static int btrfsic_process_superblock(struct btrfsic_state *state,
 				      struct btrfs_fs_devices *fs_devices)
 {
-	struct btrfs_fs_info *fs_info = state->fs_info;
 	struct btrfs_super_block *selected_super;
 	struct list_head *dev_head = &fs_devices->devices;
 	struct btrfs_device *device;
@@ -700,7 +699,7 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 			break;
 		}
 
-		num_copies = btrfs_num_copies(fs_info, next_bytenr,
+		num_copies = btrfs_num_copies(state->fs_info, next_bytenr,
 					      state->metablock_size);
 		if (state->print_mask & BTRFSIC_PRINT_MASK_NUM_COPIES)
 			pr_info("num_copies(log_bytenr=%llu) = %d\n",
-- 
2.20.1

