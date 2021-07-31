Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770F3DC487
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jul 2021 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhGaHmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Jul 2021 03:42:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaHmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Jul 2021 03:42:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 588FD2240F;
        Sat, 31 Jul 2021 07:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627717365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=49genXamuWPUfnqIYM9MpAmLFv/BVUjt+YD0HL9o2qg=;
        b=YXgbCwW6U0+G8TrtV35Fr6aHCJdg2W0iV/VxBzmOHTEHy2XLLL5jAwWtKiplKQvlmZny+d
        2DsOKzOJbcFcgnF3D+lgNJUEyQSCyNLjtlQXy0XdkziFjgH8XVss1msVJDQVNHEVVVkwVL
        rK/Uc6AorEsTOA3ourl3e4aQXLb7/uM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 15710136B6;
        Sat, 31 Jul 2021 07:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id kE3AMfP+BGFPPQAAGKfGzw
        (envelope-from <wqu@suse.com>); Sat, 31 Jul 2021 07:42:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs-progs: mkfs: set super_cache_generation to 0 if we're using free space tree
Date:   Sat, 31 Jul 2021 15:42:40 +0800
Message-Id: <20210731074240.206263-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[HICCUP]
There is a bug report that mkfs.btrfs -R free-space-tree still makes
kernel to try to cleanup the v1 space cache:

  # mkfs.btrfs -R free-space-tree -f /dev/test/scratch1
  # mount /dev/test/scratch1 /mnt/btrfs
  # dmesg | grep cleaning
  BTRFS info (device dm-6): cleaning free space cache v1

[CAUSE]
By default, mkfs.btrfs will set super cache generation to (u64)-1, which
will inform kernel that the v1 space cache is invalid, needs to
regenerate it.

But for free space cache tree, kernel will set super cache generation to
0, to indicate v1 space cache is not in use.

This means, even we enabled free space tree with all the RO compatible
bits and new tree, as long as super cache generation is not 0, kernel
still consider the fs has some invalid v1 space cache, and will try to
remove them.

[FIX]
This is not a big deal, but to make the "-R free-space-tree" to really
work as kernel, we also need to set super cache generation to 0.

Reported-by: Chris Murphy <lists@colorremedies.com>
Link: https://lore.kernel.org/linux-btrfs/CAJCQCtSvgzyOnxtrqQZZirSycEHp+g0eDH5c+Kw9mW=PgxuXmw@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/free-space-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 2edc7fc716f5..7f589dfef950 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1447,6 +1447,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE);
 	btrfs_set_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID);
+	btrfs_set_super_cache_generation(fs_info->super_copy, 0);
 
 	ret = btrfs_commit_transaction(trans, tree_root);
 	if (ret)
-- 
2.32.0

