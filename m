Return-Path: <linux-btrfs+bounces-2497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612085A1B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112DB283AB4
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC62C6AF;
	Mon, 19 Feb 2024 11:13:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE32C69F
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341222; cv=none; b=EltP9HCV+Qn6HB6O8u+Zg0QideMd+QJ5poHLXJKUupj/1wSORgX0mvu6vGvj/JGdb1C//tAjiZgDcoJCMe23VA/IV9L9SyHwh0rwo8U2ZacS52D3q6xMhzWZE9A7sbISmWLK5nq6wFLmQpZpKgdoA4/PR3UKWNMkEia9+3D58So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341222; c=relaxed/simple;
	bh=m56wd51GVvcsJ6uSucZRkzjyGbK99r7bMKd22ZPIVH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOpEWMeJXGHpkM3cLOlgTlw1SoC1Q8UG7wO3XRNzRSJR7/oggcqrqfQLvItDssD2zA+zCIEkICdsIK/jyabVd5JJ/pjVn4N67LgHL5dZTWPLTWasxa9YTcSYYOW1KEJj7slEpPJ5Pktfe/ANmO+KMlvElbP59JTIQzVsuDp52KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 550FF22300;
	Mon, 19 Feb 2024 11:13:39 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D579139C6;
	Mon, 19 Feb 2024 11:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id H9XfEuM302WjZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:39 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/10] btrfs: simplify conditions in btrfs_free_chunk_map()
Date: Mon, 19 Feb 2024 12:13:04 +0100
Message-ID: <cd9ae501762221ffca5408ffb59f1a3b990de14e.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 550FF22300
X-Spam-Flag: NO

The helper is simple enough for inlining, we can further simplify it by
removing the check for map pointer validity. After this patch all
callers always pass a valid pointer.

The changes to achieve this:

- in verify_one_dev_extent() return and don't jump to the out label
  that could potentially pass a NULL pointer to btrfs_free_chunk_map

- in btrfs_load_block_group_zone_info() add a label that specifically
  clears the map and does not go through label out that could encounter
  a NULL pointer in cache->physical_map

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 3 +--
 fs/btrfs/volumes.h | 2 +-
 fs/btrfs/zoned.c   | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 752144a31d79..55b91807aba4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7979,8 +7979,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu doesn't have corresponding chunk",
 			  physical_offset, devid);
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 
 	stripe_len = btrfs_calc_stripe_length(map);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 21d4de0e3f1f..ce1aa7684c74 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -566,7 +566,7 @@ struct btrfs_chunk_map {
 
 static inline void btrfs_free_chunk_map(struct btrfs_chunk_map *map)
 {
-	if (map && refcount_dec_and_test(&map->refs)) {
+	if (refcount_dec_and_test(&map->refs)) {
 		ASSERT(RB_EMPTY_NODE(&map->rb_node));
 		kfree(map);
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3317bebfca95..b9346ca82c47 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1564,7 +1564,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	cache->physical_map = btrfs_clone_chunk_map(map, GFP_NOFS);
 	if (!cache->physical_map) {
 		ret = -ENOMEM;
-		goto out;
+		goto out_free_map;
 	}
 
 	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
@@ -1677,6 +1677,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 	bitmap_free(active);
 	kfree(zone_info);
+out_free_map:
 	btrfs_free_chunk_map(map);
 
 	return ret;
-- 
2.42.1


