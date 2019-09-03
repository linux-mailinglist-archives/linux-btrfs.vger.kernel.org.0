Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E8A6C12
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfICPAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:00:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728854AbfICPAt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DBE2AD63;
        Tue,  3 Sep 2019 15:00:48 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 02/12] btrfs-progs: cache csum_type in recover_control
Date:   Tue,  3 Sep 2019 17:00:36 +0200
Message-Id: <20190903150046.14926-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903150046.14926-1-jthumshirn@suse.de>
References: <20190903150046.14926-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Cache the super-block's checksum type field in 'struct recover_control'.
This will be needed for further refactoring the checksum handling.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds/rescue-chunk-recover.c | 2 ++
 ctree.h                     | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index c9b268781159..1959a2047c17 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -47,6 +47,7 @@ struct recover_control {
 	int yes;
 
 	u16 csum_size;
+	u16 csum_type;
 	u32 sectorsize;
 	u32 nodesize;
 	u64 generation;
@@ -1530,6 +1531,7 @@ static int recover_prepare(struct recover_control *rc, const char *path)
 	rc->generation = btrfs_super_generation(sb);
 	rc->chunk_root_generation = btrfs_super_chunk_root_generation(sb);
 	rc->csum_size = btrfs_super_csum_size(sb);
+	rc->csum_type = btrfs_super_csum_type(sb);
 
 	/* if seed, the result of scanning below will be partial */
 	if (btrfs_super_flags(sb) & BTRFS_SUPER_FLAG_SEEDING) {
diff --git a/ctree.h b/ctree.h
index 0d12563b7261..870d9f4948de 100644
--- a/ctree.h
+++ b/ctree.h
@@ -165,7 +165,9 @@ struct btrfs_free_space_ctl;
 #define BTRFS_CSUM_SIZE 32
 
 /* csum types */
-#define BTRFS_CSUM_TYPE_CRC32	0
+enum btrfs_csum_type {
+	BTRFS_CSUM_TYPE_CRC32	= 0,
+};
 
 /* four bytes for CRC32 */
 static int btrfs_csum_sizes[] = { 4 };
-- 
2.16.4

