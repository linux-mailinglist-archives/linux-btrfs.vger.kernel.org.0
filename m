Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCDB19C53
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEJLQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:16:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbfEJLPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D4ABAFA1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 14/17] btrfs: directly call into crypto framework for checsumming
Date:   Fri, 10 May 2019 13:15:44 +0200
Message-Id: <20190510111547.15310-15-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
framework for calculating the CRCs.

As we have our own crypto_shash structure in the fs_info now, we can
directly call into the crypto framework without going trough the wrapper.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fb0b06b7b9f6..0c9ac7b45ce8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -253,12 +253,36 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
 		    u32 seed, size_t len)
 {
-	return crc32c(seed, data, len);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	u32 *ctx = (u32 *)shash_desc_ctx(shash);
+	u32 retval;
+	int err;
+
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+	*ctx = seed;
+
+	err = crypto_shash_update(shash, data, len);
+	ASSERT(err);
+
+	retval = *ctx;
+	barrier_data(ctx);
+
+	return retval;
 }
 
 void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result)
 {
-	put_unaligned_le32(~crc, result);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	u32 *ctx = (u32 *)shash_desc_ctx(shash);
+	int err;
+
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+	*ctx = crc;
+
+	err = crypto_shash_final(shash, result);
+	ASSERT(err);
 }
 
 /*
-- 
2.16.4

