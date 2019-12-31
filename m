Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE612D6C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfLaHM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:46452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfLaHM2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F0DEB168
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs-progs: check: Initialize extent_record::generation member
Date:   Tue, 31 Dec 2019 15:12:16 +0800
Message-Id: <20191231071220.32935-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using `btrfs check --init-extent-tree`, there is a pretty high
chance that the result fs can't pass tree-checker:

  BTRFS critical (device dm-3): corrupt leaf: block=5390336 slot=149 extent bytenr=20115456 len=4096 invalid generation, have 16384 expect (0, 360]
  BTRFS error (device dm-3): block=5390336 read time tree block corruption detected
  BTRFS error (device dm-3): failed to read block groups: -5
  BTRFS error (device dm-3): open_ctree failed

[CAUSE]
The result fs has a pretty screwed up EXTENT_ITEMs for data extents:

        item 148 key (20111360 EXTENT_ITEM 4096) itemoff 8777 itemsize 53
                refs 1 gen 0 flags DATA
                extent data backref root FS_TREE objectid 841 offset 0 count 1
        item 149 key (20115456 EXTENT_ITEM 4096) itemoff 8724 itemsize 53
                refs 1 gen 16384 flags DATA
                extent data backref root FS_TREE objectid 906 offset 0 count 1

Kernel tree-checker will accept 0 generation, but that 16384 generation
is definitely going to trigger the alarm.

Looking into the code, it's add_extent_rec_nolookup() allocating a new
extent_rec, but not copying all members from parameter @tmpl, resulting
generation not properly initialized.

[FIX]
Just copy tmpl->generation in add_extent_rec_nolookup(). And since all
call sites have set all members of @tmpl to 0 before
add_extent_rec_nolookup(), we shouldn't get garbage values.

For the 0 generation problem, it will be solved in another patch.

Issue: 225 (Not the initial report, but extent tree rebuild result)
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check/main.c b/check/main.c
index 08dc9e66..2dbed091 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4605,6 +4605,7 @@ static int add_extent_rec_nolookup(struct cache_tree *extent_cache,
 	rec->refs = tmpl->refs;
 	rec->extent_item_refs = tmpl->extent_item_refs;
 	rec->parent_generation = tmpl->parent_generation;
+	rec->generation = tmpl->generation;
 	INIT_LIST_HEAD(&rec->backrefs);
 	INIT_LIST_HEAD(&rec->dups);
 	INIT_LIST_HEAD(&rec->list);
-- 
2.24.1

