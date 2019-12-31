Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5611412D6C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 08:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLaHMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 02:12:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfLaHMb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 02:12:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72096AD12
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Dec 2019 07:12:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: check/original: Detect invalid extent generation
Date:   Tue, 31 Dec 2019 15:12:19 +0800
Message-Id: <20191231071220.32935-5-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
References: <20191231071220.32935-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Much like what we have done in lowmem mode, also detect and report
invalid extent generation in original mode.

Unlike lowmem mode, we have extent_record::generation, which is the
higher number of generations in EXTENT_ITEM, EXTENT_DATA or tree block
header, so there is no need to check generations in different locations.

For repair, we still need to depend on --init-extent-tree, as directly
modifying extent items can easily cause conflicts with delayed refs,
thus it should be avoided.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/check/main.c b/check/main.c
index 88b174ab..a9a236a4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4021,10 +4021,13 @@ static void free_extent_record_cache(struct cache_tree *extent_cache)
 static int maybe_free_extent_rec(struct cache_tree *extent_cache,
 				 struct extent_record *rec)
 {
+	u64 super_gen = btrfs_super_generation(global_info->super_copy);
+
 	if (rec->content_checked && rec->owner_ref_checked &&
 	    rec->extent_item_refs == rec->refs && rec->refs > 0 &&
 	    rec->num_duplicates == 0 && !all_backpointers_checked(rec, 0) &&
 	    !rec->bad_full_backref && !rec->crossing_stripes &&
+	    rec->generation <= super_gen + 1 &&
 	    !rec->wrong_chunk_type) {
 		remove_cache_extent(extent_cache, &rec->cache);
 		free_all_extent_backrefs(rec);
@@ -7857,6 +7860,7 @@ static int check_extent_refs(struct btrfs_root *root,
 {
 	struct extent_record *rec;
 	struct cache_extent *cache;
+	u64 super_gen = btrfs_super_generation(root->fs_info->super_copy);
 	int ret = 0;
 	int had_dups = 0;
 	int err = 0;
@@ -7939,6 +7943,13 @@ static int check_extent_refs(struct btrfs_root *root,
 			cur_err = 1;
 		}
 
+		if (rec->generation > super_gen + 1) {
+			error(
+	"invalid generation for extent %llu, have %llu expect (0, %llu]",
+				rec->start, rec->generation,
+				super_gen + 1);
+			cur_err = 1;
+		}
 		if (rec->refs != rec->extent_item_refs) {
 			fprintf(stderr, "ref mismatch on [%llu %llu] ",
 				(unsigned long long)rec->start,
-- 
2.24.1

