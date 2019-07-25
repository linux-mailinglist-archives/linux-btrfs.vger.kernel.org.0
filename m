Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAE74A01
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbfGYJeW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403776AbfGYJeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40429AEAC
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 07/17] btrfs-progs: use btrfs_csum_data() in __csum_tree_block_size()
Date:   Thu, 25 Jul 2019 11:33:54 +0200
Message-Id: <cf0d71c9744a1841278fc08b0c294d4b1292cb8f.1564046972.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the btrfs_csum_data() wrapper in __csum_tree_block_size() instead of
directly calling crc32c().

This helps us when plumbing new checksum algorithms into the FS.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-io.c b/disk-io.c
index be44eead5cef..01314504a50a 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -156,7 +156,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	u32 crc = ~(u32)0;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	crc = crc32c(crc, buf->data + BTRFS_CSUM_SIZE, len);
+	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, crc, len);
 	btrfs_csum_final(crc, result);
 
 	if (verify) {
-- 
2.16.4

