Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83C7332EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfFCO7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729359AbfFCO7E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B82F5AF9A;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 08/13] btrfs: check for supported superblock checksum type before checksum validation
Date:   Mon,  3 Jun 2019 16:58:54 +0200
Message-Id: <20190603145859.7176-9-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have factorerd out the superblock checksum type validation, we
can check for supported superblock checksum types before doing the actual
validation of the superblock read from disk.

This leads the path to further simplifications of btrfs_check_super_csum()
later on.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v3:
- Pass csum_type to btrfs_supported_super_csum() (David)
- Use %u to print on-disk checksum type if we encounter an unsupported type (David)

Changes to v2:
- Print on-disk checksum type if we encounter an unsupported type (David)
---
 fs/btrfs/disk-io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2aba3dc33c5..b11091612074 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2821,6 +2821,16 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
+	if (!btrfs_supported_super_csum(btrfs_super_csum_type(
+				 (struct btrfs_super_block *) bh->b_data))) {
+		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
+			  btrfs_super_csum_type((struct btrfs_super_block *)
+						bh->b_data));
+		err = -EINVAL;
+		brelse(bh);
+		goto fail_alloc;
+	}
+
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
-- 
2.16.4

