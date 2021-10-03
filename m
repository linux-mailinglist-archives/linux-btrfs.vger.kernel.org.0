Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F084200A7
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Oct 2021 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhJCIIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Oct 2021 04:08:53 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:50126 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhJCIIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Oct 2021 04:08:52 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((LNX1044)) with ASMTP (SSL) id XKK00156;
        Sun, 03 Oct 2021 16:06:56 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2308.14; Sun, 3 Oct 2021 16:06:58 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] btrfs: zoned: Use kmemdup() to replace kmalloc + memcpy
Date:   Sun, 3 Oct 2021 16:06:56 +0800
Message-ID: <20211003080656.217151-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   20211003160656a3af2400dbd184062f23e01267357a2a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fix memdup.cocci warning:
fs/btrfs/zoned.c:1198:23-30: WARNING opportunity for kmemdup

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 fs/btrfs/zoned.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1433ee220c94..cfa25f5ede0d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1195,14 +1195,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	map = em->map_lookup;
 
-	cache->physical_map = kmalloc(map_lookup_size(map->num_stripes), GFP_NOFS);
+	cache->physical_map = kmemdup(map, map_lookup_size(map->num_stripes), GFP_NOFS);
 	if (!cache->physical_map) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	memcpy(cache->physical_map, map, map_lookup_size(map->num_stripes));
-
 	alloc_offsets = kcalloc(map->num_stripes, sizeof(*alloc_offsets), GFP_NOFS);
 	if (!alloc_offsets) {
 		ret = -ENOMEM;
-- 
2.27.0

