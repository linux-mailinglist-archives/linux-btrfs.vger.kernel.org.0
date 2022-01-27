Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5E49EB6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 20:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbiA0T5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 14:57:21 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54814 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245731AbiA0T5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 14:57:18 -0500
Received: from venice.bhome ([78.14.151.50])
        by santino.mail.tiscali.it with 
        id nvxE2600k15VSme01vxGrN; Thu, 27 Jan 2022 19:57:16 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/3] Rename dev_item.type in flags in the command output.
Date:   Thu, 27 Jan 2022 20:57:08 +0100
Message-Id: <86bac5161db5a240cdfbd30cde9d045da1237757.1643313144.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643313144.git.kreijack@inwind.it>
References: <cover.1643313144.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643313436; bh=sKSHtOFQNJU1lSsFJiLfOSQbX4y6LEZ21uSJ2mpGFxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=vYdumxMqlu0HaMmV2QCmC2KY/ZbVqAtZU4Orbjai+iwRo76jj4faqxC6m05zdCzSB
         pgzUiQnIGksRe/W1Y3wcPWjHNCAux3EuxYqAR7s2+tTxLqxJGfcm1Q1QVK4TMY7cCJ
         STE3pM0+WxPHdzJw1BbxI1uZgr7U4uTbs2BAbOvI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

As did in the kernel, rename the device->type to device->flags
in the printf() functions.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 kernel-shared/print-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9bb0bd42..3bab0709 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -293,7 +293,7 @@ static void print_dev_item(struct extent_buffer *eb,
 			   BTRFS_UUID_SIZE);
 	uuid_unparse(fsid, fsid_str);
 	printf("\t\tdevid %llu total_bytes %llu bytes_used %llu\n"
-	       "\t\tio_align %u io_width %u sector_size %u type %llu\n"
+	       "\t\tio_align %u io_width %u sector_size %u flags %llu\n"
 	       "\t\tgeneration %llu start_offset %llu dev_group %u\n"
 	       "\t\tseek_speed %hhu bandwidth %hhu\n"
 	       "\t\tuuid %s\n"
@@ -2051,7 +2051,7 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	printf("dev_item.fsid\t\t%s %s\n", buf,
 	       cmp_res ? "[match]" : "[DON'T MATCH]");
 
-	printf("dev_item.type\t\t%llu\n", (unsigned long long)
+	printf("dev_item.flags\t\t%llu\n", (unsigned long long)
 	       btrfs_stack_device_flags(&sb->dev_item));
 	printf("dev_item.total_bytes\t%llu\n", (unsigned long long)
 	       btrfs_stack_device_total_bytes(&sb->dev_item));
-- 
2.34.1

