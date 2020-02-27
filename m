Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAB172920
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgB0UBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 15:01:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgB0UBG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F14AB190;
        Thu, 27 Feb 2020 20:01:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E6CADA83A; Thu, 27 Feb 2020 21:00:45 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: inline checksum name and driver definitions
Date:   Thu, 27 Feb 2020 21:00:45 +0100
Message-Id: <91753cb284a2dbce72e5b5b31b658e1c50ef084e.1582832619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582832619.git.dsterba@suse.com>
References: <cover.1582832619.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's an unnecessary indirection in the checksum definition table,
pointer and the string itself. The strings are short and the overall
size of one entry is now 24 bytes.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f948435e87df..bfedbbe2311f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -31,8 +31,8 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 
 static const struct btrfs_csums {
 	u16		size;
-	const char	*name;
-	const char	*driver;
+	const char	name[10];
+	const char	driver[12];
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
@@ -63,7 +63,8 @@ const char *btrfs_super_csum_name(u16 csum_type)
 const char *btrfs_super_csum_driver(u16 csum_type)
 {
 	/* csum type is validated at mount time */
-	return btrfs_csums[csum_type].driver ?:
+	return btrfs_csums[csum_type].driver[0] ?
+		btrfs_csums[csum_type].driver :
 		btrfs_csums[csum_type].name;
 }
 
-- 
2.25.0

