Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79617294860
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440876AbgJUG2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440875AbgJUG2c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2q8lfHQMsSCrANMA4TRMEc6S6kXPwGn1Fi0nngPG7M=;
        b=NLJfVCe9XXtQ1cvjpO4d0ZeOyMB83s05t2fckfBlesEO/BcKccL6lmGl3c6+qjnrd5Lsit
        l7hicidjws25KYFUZv6//kVlyfMjuoIbk7OybKLqYjDSS42QZQNnoL5OgcECt99kjgdm/4
        yyL22F+NcxCawiE44Gw8D0WJvHYvxNc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FA0AAC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 68/68] btrfs: support subpage read write for test
Date:   Wed, 21 Oct 2020 14:25:54 +0800
Message-Id: <20201021062554.68132-69-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 10 ----------
 fs/btrfs/super.c   |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2ac980f739dc..8b5f65e6c5fa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3335,16 +3335,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	/* For 4K sector size support, it's only read-only yet */
-	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
-		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
-			btrfs_err(fs_info,
-				"subpage sector size only support RO yet");
-			err = -EINVAL;
-			goto fail_alloc;
-		}
-	}
-
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 743a2fadf4ee..25967ecaaf0a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1922,13 +1922,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			ret = -EINVAL;
 			goto restore;
 		}
-		if (btrfs_is_subpage(fs_info)) {
-			btrfs_warn(fs_info,
-	"read-write mount is not yet allowed for sector size %u page size %lu",
-				   fs_info->sectorsize, PAGE_SIZE);
-			ret = -EINVAL;
-			goto restore;
-		}
 
 		ret = btrfs_cleanup_fs_roots(fs_info);
 		if (ret)
-- 
2.28.0

