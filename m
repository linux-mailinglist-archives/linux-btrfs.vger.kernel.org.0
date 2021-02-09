Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814FA31552F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhBIRgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 12:36:41 -0500
Received: from mail.nic.cz ([217.31.204.67]:34870 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232938AbhBIRfJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 12:35:09 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:8982:ed8c:62b1:c0c8])
        by mail.nic.cz (Postfix) with ESMTPSA id 80FD413FD0E;
        Tue,  9 Feb 2021 18:34:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1612892063; bh=EBMx+zpY74gnPIYMRVud8JLa1FxIsNwqSbrosdN1yH0=;
        h=From:To:Date;
        b=lsG7ifGg2tm2PJos9YY6D/nDjT0qr2ZEZtFz02ZjPFlTYCvYrPRCKqK7oGO6/hdp8
         Q7YINoMPLgYl0eIt4Ouq5uDDqLM+PhTKvU1tEP8WrM8xFpnGsxWlJhfq/vssFmdGfe
         p4ScNsQMckdbthgfvIx+qvV9o1zjQz7a0GeTbS4Y=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-btrfs@vger.kernel.org
Cc:     u-boot@lists.denx.de,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
Subject: [PATCH btrfs-progs] btrfs-progs: do not fail when offset of a ROOT_ITEM is not -1
Date:   Tue,  9 Feb 2021 18:34:06 +0100
Message-Id: <20210209173406.16691-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the btrfs_read_fs_root() function is searching a ROOT_ITEM with
location key offset other than -1, it currently fails via BUG_ON.

The offset can have other value than -1, though. This can happen for
example if a subvolume is renamed:

  $ btrfs subvolume create X && sync
  Create subvolume './X'
  $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: X$
        location key (270 ROOT_ITEM 18446744073709551615) type DIR
        transid 283 data_len 0 name_len 1
        name: X
  $ mv X Y && sync
  $ btrfs inspect-internal dump-tree /dev/root | grep -B 2 'name: Y$
        location key (270 ROOT_ITEM 0) type DIR
        transid 285 data_len 0 name_len 1
        name: Y

As can be seen the offset changed from -1ULL to 0.

Do not fail in this case.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>
---
 kernel-shared/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6f584986..ba8ffd8b 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -752,8 +752,7 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_fs_info *fs_info,
 		return fs_info->free_space_root ? fs_info->free_space_root :
 						ERR_PTR(-ENOENT);
 
-	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID ||
-	       location->offset != (u64)-1);
+	BUG_ON(location->objectid == BTRFS_TREE_RELOC_OBJECTID);
 
 	node = rb_search(&fs_info->fs_root_tree, (void *)&objectid,
 			 btrfs_fs_roots_compare_objectids, NULL);
-- 
2.26.2

