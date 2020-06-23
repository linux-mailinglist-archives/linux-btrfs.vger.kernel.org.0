Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0F20494D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 07:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgFWFsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 01:48:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgFWFsM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 01:48:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA8E4AD09
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jun 2020 05:48:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: convert/ext2: fix the pointer sign warning
Date:   Tue, 23 Jun 2020 13:48:03 +0800
Message-Id: <20200623054804.67175-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623054804.67175-1-wqu@suse.com>
References: <20200623054804.67175-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[WARNING]
When compiling btrfs-progs, there is one warning from convert ext2 code:
  convert/source-ext2.c: In function 'ext2_open_fs':
  convert/source-ext2.c:91:44: warning: pointer targets in passing argument 1 of 'strndup' differ in signedness [-Wpointer-sign]
     91 |  cctx->volume_name = strndup(ext2_fs->super->s_volume_name, 16);
        |                              ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
        |                                            |
        |                                            __u8 * {aka unsigned char *}
  In file included from ./kerncompat.h:25,
                   from convert/source-ext2.c:19:
  /usr/include/string.h:175:35: note: expected 'const char *' but argument is of type '__u8 *' {aka 'unsigned char *'}
    175 | extern char *strndup (const char *__string, size_t __n)
        |                       ~~~~~~~~~~~~^~~~~~~~

The toolchain involved is:
- GCC 10.1.0
- e2fsprogs 1.45.6

[CAUSE]
Obviously, in the offending e2fsprogs, the volume lable is using u8,
which is unsigned char, not char.

  /*078*/	__u8	s_volume_name[EXT2_LABEL_LEN];	/* volume name, no NUL? */

[FIX]
Just do a forced conversion to suppress the warning is enough.
I don't think we need to apply -Wnopointer-sign yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index f248249f..f11ef651 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -88,7 +88,7 @@ static int ext2_open_fs(struct btrfs_convert_context *cctx, const char *name)
 	cctx->blocksize = ext2_fs->blocksize;
 	cctx->block_count = ext2_fs->super->s_blocks_count;
 	cctx->total_bytes = ext2_fs->blocksize * ext2_fs->super->s_blocks_count;
-	cctx->volume_name = strndup(ext2_fs->super->s_volume_name, 16);
+	cctx->volume_name = strndup((char *)ext2_fs->super->s_volume_name, 16);
 	cctx->first_data_block = ext2_fs->super->s_first_data_block;
 	cctx->inodes_count = ext2_fs->super->s_inodes_count;
 	cctx->free_inodes_count = ext2_fs->super->s_free_inodes_count;
-- 
2.27.0

