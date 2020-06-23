Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448A205B23
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbgFWSur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 14:50:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733182AbgFWSur (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 14:50:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA706AF73;
        Tue, 23 Jun 2020 18:50:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BD48DA79B; Tue, 23 Jun 2020 20:50:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: start deprecation of mount option inode_cache
Date:   Tue, 23 Jun 2020 20:50:32 +0200
Message-Id: <20200623185032.14983-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Estimated time of removal of the functionality is 5.11, the option will
be still parsed but not doing anything.

Reasons for deprecation and removal:

- very poor naming choice of the mount option, it's supposed to cache
  and reuse the inode _numbers_, but it sounds a some generic cache for
  inodes

- the only known usecase where this option would make sense is on a
  32bit architecture where inode numbers in one subvolume would be
  exhausted due to 32bit inode::i_ino

- the cache is stored on disk, consumes space, needs to be loaded and
  written back

- new inode number allocation is slower due to lookups into the cache
  (compared to a simple increment which is the default)

- uses the free-space-cache code that is going to be deprecated as well
  in the future

Known problems:

- since 2011, returning EEXIST when there's not enough space in a page
  to store all checksums, see commit 4b9465cb9e38 ("Btrfs: add mount -o
  inode_cache")

Remaining issues:

- if the option was enabled, new inodes created, the option disabled
  again, the cache is still stored on the devices and there's currently
  no way to remove it

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 98fe2a634c70..3f1abbeef66c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -827,6 +827,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			}
 			break;
 		case Opt_inode_cache:
+			btrfs_warn(info,
+	"the 'inode_cache' option is deprecated and will be stop working in 5.11");
 			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
 					   "enabling inode map caching");
 			break;
-- 
2.25.0

