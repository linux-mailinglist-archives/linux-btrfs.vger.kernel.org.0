Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6603E74A05
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403825AbfGYJeZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52362 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403782AbfGYJeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89B2DAFF9
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 13/17] btrfs-progs: pass checksum type to btrfs_csum_data()
Date:   Thu, 25 Jul 2019 11:34:00 +0200
Message-Id: <bc87a2ee4f7da8bba97f006abc79ae4d612ad620.1564046972.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 932c2a0432ef..d9630f187d0f 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -35,11 +35,13 @@ static int check_csum_superblock(void *sb)
 {
 	u8 result[csum_size];
 	u32 crc = ~(u32)0;
+	u16 csum_type = btrfs_super_csum_type(sb);
 
-	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
+	crc = btrfs_csum_data(csum_type,
+			      (char *)sb + BTRFS_CSUM_SIZE,
 				(u8 *)&crc,
 				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(crc, result);
+	btrfs_csum_final(csum_type, crc, result);
 
 	return !memcmp(sb, &result, csum_size);
 }
@@ -49,17 +51,20 @@ static void update_block_csum(void *block, int is_sb)
 	u8 result[csum_size];
 	struct btrfs_header *hdr;
 	u32 crc = ~(u32)0;
+	u16 csum_type = btrfs_super_csum_type(block);
 
 	if (is_sb) {
-		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
+		crc = btrfs_csum_data(csum_type,
+				      (char *)block + BTRFS_CSUM_SIZE,
 				      (u8 *)&crc,
 				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	} else {
-		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
+		crc = btrfs_csum_data(csum_type,
+				      (char *)block + BTRFS_CSUM_SIZE,
 				      (u8 *)&crc,
 				BLOCKSIZE - BTRFS_CSUM_SIZE);
 	}
-	btrfs_csum_final(crc, result);
+	btrfs_csum_final(csum_type, crc, result);
 	memset(block, 0, BTRFS_CSUM_SIZE);
 	hdr = (struct btrfs_header *)block;
 	memcpy(&hdr->csum, result, csum_size);
-- 
2.16.4

