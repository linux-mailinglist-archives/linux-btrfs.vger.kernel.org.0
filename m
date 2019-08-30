Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A22A35BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 13:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH3Lcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 07:32:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727926AbfH3Lcl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 07:32:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08D9CB049;
        Fri, 30 Aug 2019 11:32:39 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 06/12] btrfs-progs: simplify update_block_csum() in btrfs-sb-mod.c
Date:   Fri, 30 Aug 2019 13:32:28 +0200
Message-Id: <20190830113234.16615-7-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190830113234.16615-1-jthumshirn@suse.de>
References: <20190830113234.16615-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

update_block_csum() in btrfs-sb-mod.c is always called with the 'is_sb'
argument set to 1.

Get rid of the special case for is_sb == 0.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 btrfs-sb-mod.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index d9630f187d0f..9e64b34d2b8f 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -46,24 +46,17 @@ static int check_csum_superblock(void *sb)
 	return !memcmp(sb, &result, csum_size);
 }
 
-static void update_block_csum(void *block, int is_sb)
+static void update_block_csum(void *block)
 {
 	u8 result[csum_size];
 	struct btrfs_header *hdr;
 	u32 crc = ~(u32)0;
 	u16 csum_type = btrfs_super_csum_type(block);
 
-	if (is_sb) {
-		crc = btrfs_csum_data(csum_type,
-				      (char *)block + BTRFS_CSUM_SIZE,
-				      (u8 *)&crc,
-				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	} else {
-		crc = btrfs_csum_data(csum_type,
-				      (char *)block + BTRFS_CSUM_SIZE,
-				      (u8 *)&crc,
-				BLOCKSIZE - BTRFS_CSUM_SIZE);
-	}
+	crc = btrfs_csum_data(csum_type, (char *)block + BTRFS_CSUM_SIZE,
+			      (u8 *)&crc,
+			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+
 	btrfs_csum_final(csum_type, crc, result);
 	memset(block, 0, BTRFS_CSUM_SIZE);
 	hdr = (struct btrfs_header *)block;
@@ -354,7 +347,7 @@ int main(int argc, char **argv) {
 
 	if (changed) {
 		printf("Update csum\n");
-		update_block_csum(buf, 1);
+		update_block_csum(buf);
 		ret = pwrite(fd, buf, BLOCKSIZE, off);
 		if (ret <= 0) {
 			printf("pwrite error %d at offset %llu\n",
-- 
2.16.4

