Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478BA30F525
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhBDOhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 09:37:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236802AbhBDOg2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 09:36:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E26E664F42
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612449347;
        bh=o2Zbfg3AmIR5lKJyWdPA917CCFmQu1VnTtlloA0UTC0=;
        h=From:To:Subject:Date:From;
        b=ZG+zFIUGSDCZd8zKFtN778qsl/ecxRlNO7frUqvwaUahVhL95+qm3liqYxtxE4Ns0
         UCWTbCKI/sIC40i1+8mUnWhzrGhuY+u6hnT43jV0GYfuOx5/cvQvqVFd0w7kGwb3wX
         LPpX++Xr1adb2lRvoKRB1cV871R98N3rmU4dA/3sOQ7y06GJO5ujSp6WSTUbiH8tjL
         JhrNRGy7jOsimd2oPipHQbyM7PTZgjglF1IRV2jHTHCSfQb4YvX5mo6uvaHF1V53hz
         zUjJ/WANc8IAUKt14XJ51MHYS9lsPH1HWGBjnLBsLP4O71knSzhhJaqx2A2y+rv6o5
         rncv6hF8lCqWw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix extent buffer leak on failure to copy root
Date:   Thu,  4 Feb 2021 14:35:44 +0000
Message-Id: <aa032e11aa2b8667a28a93b90691d6f790711c62.1612449293.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_copy_root(), if the call to btrfs_inc_ref() fails we end up
returning without unlocking and releasing our reference on the extent
buffer named "cow" we previously allocated with btrfs_alloc_tree_block().

So fix that by unlocking the extent buffer and dropping our reference on
it before returning.

Fixes: be20aa9dbadc8c ("Btrfs: Add mount option to turn off data cow")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 95d9bae764ab..d56730a67885 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -222,6 +222,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	else
 		ret = btrfs_inc_ref(trans, root, cow, 0);
 	if (ret) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-- 
2.28.0

