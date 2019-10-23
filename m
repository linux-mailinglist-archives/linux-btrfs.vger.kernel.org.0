Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30243E138B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390056AbfJWICa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 04:02:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:46284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbfJWICa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 04:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 290C9BA70;
        Wed, 23 Oct 2019 08:02:28 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        ashnell@suse.de, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs-progs: build: add missing symbols from volumes.o to libbtrfs
Date:   Wed, 23 Oct 2019 10:02:26 +0200
Message-Id: <20191023080226.10826-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When using snapper a user reports that some symbols from volumes.[ch] are
missing from libbtrfs, eg. write_raid56_with_parity().

Link: https://github.com/openSUSE/snapper/issues/500
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 21bf2717a9e7..37a681c23f4e 100644
--- a/Makefile
+++ b/Makefile
@@ -152,11 +152,11 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o extent-cache.o extent_io.o \
 		   kernel-lib/crc32c.o common/messages.o \
-		   uuid-tree.o utils-lib.o common/rbtree-utils.o
+		   uuid-tree.o utils-lib.o common/rbtree-utils.o volumes.o
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
-	       extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
+	       extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h volumes.h
 libbtrfsutil_major := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_minor := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MINOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
 libbtrfsutil_patch := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_PATCH ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
-- 
2.16.4

