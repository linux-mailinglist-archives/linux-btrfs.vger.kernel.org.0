Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB20BDF1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406629AbfIYNhp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406608AbfIYNhp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:37:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE449AFC6;
        Wed, 25 Sep 2019 13:37:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 2/7] btrfs-progs: add is_valid_csum_type() helper
Date:   Wed, 25 Sep 2019 15:37:23 +0200
Message-Id: <20190925133728.18027-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190925133728.18027-1-jthumshirn@suse.de>
References: <20190925133728.18027-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a helper to check if we have a valid csum type from the super block.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 cmds/inspect-dump-super.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 58bf82b0bbd3..272df1bfdc14 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -311,6 +311,16 @@ static void print_readable_super_flag(u64 flag)
 				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
 }
 
+static bool is_valid_csum_type(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void dump_superblock(struct btrfs_super_block *sb, int full)
 {
 	int i;
@@ -326,7 +336,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	csum_type = btrfs_super_csum_type(sb);
 	csum_size = BTRFS_CSUM_SIZE;
 	printf("csum_type\t\t%hu (", csum_type);
-	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
+	if (!is_valid_csum_type(csum_type)) {
 		printf("INVALID");
 	} else {
 		if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
@@ -342,8 +352,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	printf("csum\t\t\t0x");
 	for (i = 0, p = sb->csum; i < csum_size; i++)
 		printf("%02x", p[i]);
-	if (csum_type != BTRFS_CSUM_TYPE_CRC32 ||
-	    csum_size != btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32])
+	if (!is_valid_csum_type(csum_type))
 		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
 	else if (check_csum_sblock(sb, csum_size, csum_type))
 		printf(" [match]");
-- 
2.16.4

