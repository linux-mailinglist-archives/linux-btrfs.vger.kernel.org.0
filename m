Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923703DA663
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhG2O2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 10:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237314AbhG2O2k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 10:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFDE160F4B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627568917;
        bh=iHwwGJwdHof5UXsDWEOKSy2L59AHFYiBBAgxcnGieNo=;
        h=From:To:Subject:Date:From;
        b=ktUMF2xTmMK+7nIzKiNG7OEu1b3BKRuQEYg2m+uCvAbINruSlW1ObVkh+1Vk/Up7R
         qTHoNCcHot4XGSrxQ3PFG6umYhSEoXxJ9fX1qni7IKWRFU8RPv3rV+Z7fzDWHEO+qU
         o3lZBzsLrn5SvvN7W5ePWQk35I5O/G5MR/clLugXlZ5GCrck3hCOyh0rm7bJBUcq5x
         Y+qgkaQWCSaYKEoxk/9Z4NiqmExCeKr77jcVTrr+2A+/3j0Zv+MA7VpQHbsnCK0J/H
         gvYSB8iclwM9A19AKP0yAOdwKPrzbotUd8Nm9NcL0YFFuzybHOEueIjeWbPWu5J7QV
         FnYWJi0By2DOQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove unnecessary NULL check for the new inode during rename exchange
Date:   Thu, 29 Jul 2021 15:28:34 +0100
Message-Id: <8dd8e8f3020a5bd13ae22a1f21b8328adc1f4636.1627568438.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At the very end of btrfs_rename_exchange(), in case an error happened, we
are checking if 'new_inode' is NULL, but that is not needed since during a
rename exchange, unlike regular renames, 'new_inode' can never be NULL,
and if it were, we would have a crash much earlier when we dereference it
multiple times.

So remove the check because it is not necessary and because it is causing
static checkers to emit a warning. I probably introduced the check by
copy-pasting similar code from btrfs_rename(), where 'new_inode' can be
NULL, in commit 86e8aa0e772cab ("Btrfs: unpin logs if rename exchange
operation fails").

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 59b35e12bb81..ef76bde10913 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9421,8 +9421,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		if (btrfs_inode_in_log(BTRFS_I(old_dir), fs_info->generation) ||
 		    btrfs_inode_in_log(BTRFS_I(new_dir), fs_info->generation) ||
 		    btrfs_inode_in_log(BTRFS_I(old_inode), fs_info->generation) ||
-		    (new_inode &&
-		     btrfs_inode_in_log(BTRFS_I(new_inode), fs_info->generation)))
+		    btrfs_inode_in_log(BTRFS_I(new_inode), fs_info->generation))
 			btrfs_set_log_full_commit(trans);
 
 		if (root_log_pinned) {
-- 
2.28.0

