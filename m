Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8FDAFE24
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfIKNz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 09:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:58250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbfIKNz4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 09:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F910C166;
        Wed, 11 Sep 2019 13:55:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: corrupt-block: Fix description of 'r' option
Date:   Wed, 11 Sep 2019 16:55:52 +0300
Message-Id: <20190911135552.22087-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 04be0e4b1962 ("btrfs-progs: corrupt-block: Correctlyi
handle -r when passing -I") the 'r' switch is used with both -I and -d
options. So remove the wrong clarificatoin that -r is used only with -d
option.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 btrfs-corrupt-block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index bbef0c02e5d1..716439a5ea7c 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -119,7 +119,7 @@ static void print_usage(int ret)
 	printf("\t-I <u64,u8,u64> Corrupt an item corresponding to the passed key triplet (must also specify the field to corrupt and root for the item)\n");
 	printf("\t-D <u64,u8,u64> Corrupt a dir item corresponding to the passed key triplet, must also specify a field\n");
 	printf("\t-d <u64,u8,u64> Delete item corresponding to passed key triplet\n");
-	printf("\t-r   Operate on this root (only works with -d)\n");
+	printf("\t-r   Operate on this root\n");
 	printf("\t-C   Delete a csum for the specified bytenr.  When used with -b it'll delete that many bytes, otherwise it's just sectorsize\n");
 	exit(ret);
 }
-- 
2.7.4

