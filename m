Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1259D2C25
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfJJOJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 10:09:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbfJJOJy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 10:09:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D771AC11;
        Thu, 10 Oct 2019 14:09:53 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs-progs: unbreak btrfs-sb-mod compilation
Date:   Thu, 10 Oct 2019 16:09:49 +0200
Message-Id: <20191010140949.6590-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix compiler warnings and errors in btrfs-sb-mod due to incorrect
conversion with the checksum updates.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 348991b39451..ad143ca05aa6 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -36,7 +36,7 @@ static int check_csum_superblock(void *sb)
 	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_type = btrfs_super_csum_type(sb);
 
-	btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(csum_type, (unsigned char *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
@@ -48,7 +48,7 @@ static void update_block_csum(void *block)
 	struct btrfs_header *hdr;
 	u16 csum_type = btrfs_super_csum_type(block);
 
-	btrfs_csum_data(csum_type, (char *)block + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(csum_type, (unsigned char *)block + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	memset(block, 0, BTRFS_CSUM_SIZE);
@@ -283,7 +283,7 @@ int main(int argc, char **argv) {
 	}
 
 	/* verify superblock */
-	csum_size = btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32];
+	csum_size = btrfs_csum_type_size(BTRFS_CSUM_TYPE_CRC32);
 	off = BTRFS_SUPER_INFO_OFFSET;
 
 	ret = pread(fd, buf, BLOCKSIZE, off);
-- 
2.16.4

