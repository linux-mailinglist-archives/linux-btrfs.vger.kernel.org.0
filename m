Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CB19C5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfEJLQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:16:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbfEJLPy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E5C4AF95
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 10/17] btrfs: check for supported superblock checksum type before checksum validation
Date:   Fri, 10 May 2019 13:15:40 +0200
Message-Id: <20190510111547.15310-11-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check for supported superblock checksum type before doing the actual
checksum validation of the superblock read from disk.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/disk-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab13282d91d2..74937effaed4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2822,6 +2822,14 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
+	if (!btrfs_supported_super_csum((struct btrfs_super_block *)
+					bh->b_data)) {
+		btrfs_err(fs_info, "unsupported checksum algorithm");
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

