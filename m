Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDE9E48D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 11:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfH0Jhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 05:37:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729254AbfH0Jhx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 05:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C247AF1F
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 09:37:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 2/4] btrfs: create structure to encode checksum type and length
Date:   Tue, 27 Aug 2019 11:37:48 +0200
Message-Id: <20190827093750.15310-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190827093750.15310-1-jthumshirn@suse.de>
References: <20190827093750.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Create a structure to encode the type and length for the known on-disk
checksums.

This makes it easier to add new checksums later.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v2:
- Really remove initializer macro *doh*

Changes to v1:
- Remove initializer macro (David)
---
 fs/btrfs/ctree.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d27b39858339..9806135c8310 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -82,9 +82,12 @@ struct btrfs_ref;
  */
 #define BTRFS_LINK_MAX 65535U
 
-/* four bytes for CRC32 */
-static const int btrfs_csum_sizes[] = { 4 };
-static const char *btrfs_csum_names[] = { "crc32c" };
+static const struct btrfs_csums {
+	u16		size;
+	const char	*name;
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
+};
 
 #define BTRFS_EMPTY_DIR_SIZE 0
 
@@ -2207,13 +2210,13 @@ static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
 	/*
 	 * csum type is validated at mount time
 	 */
-	return btrfs_csum_sizes[t];
+	return btrfs_csums[t].size;
 }
 
 static inline const char *btrfs_super_csum_name(u16 csum_type)
 {
 	/* csum type is validated at mount time */
-	return btrfs_csum_names[csum_type];
+	return btrfs_csums[csum_type].name;
 }
 
 /*
-- 
2.16.4

