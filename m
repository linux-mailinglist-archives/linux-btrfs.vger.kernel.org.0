Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB62E70E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgL2Na3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 08:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:37380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgL2Na2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 08:30:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609248582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=73Y5yheeP89olqDuL5wpS2rBzQ0tWIU77+1TJi8oRUw=;
        b=qY5jggzgqY5Myj/giHZnnUOaYnR279ogYiRjlY9CNec3BGNb2xfr2OVfGpTPrFhQZonIvr
        TZJavLmckV4zGcSThZTwwP6nIfrzdbq1pw9PNOtvT4keFbq5fg9J85G7K0JkTEEDty+1wF
        UxA6lEWAmcCpSb/Pq/4ipz9AIUNnFis=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 052BAACF1;
        Tue, 29 Dec 2020 13:29:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Lesimple?= <stephane_btrfs2@lesimple.fr>
Subject: [PATCH] btrfs: relocation: fix wrong file extent type check to avoid false -ENOENT error
Date:   Tue, 29 Dec 2020 21:29:34 +0800
Message-Id: <20201229132934.117325-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several bug reports about recent kernel unable to relocate
certain data block groups.

Sometimes the error just go away, but there is one reporter who can
reproduce it reliably.

The dmesg would look like:
[  438.260483] BTRFS info (device dm-10): balance: start -dvrange=34625344765952..34625344765953
[  438.269018] BTRFS info (device dm-10): relocating block group 34625344765952 flags data|raid1
[  450.439609] BTRFS info (device dm-10): found 167 extents, stage: move data extents
[  463.501781] BTRFS info (device dm-10): balance: ended with status: -2

[CAUSE]
The -ENOENT error is returned from the following chall chain:

add_data_references()
|- delete_v1_space_cache();
   |- if (!found)
         return -ENOENT;

The variable @found is set to true if we find a data extent whose
disk bytenr matches parameter @data_bytes.

With extra debug, the offending tree block looks like this:
  leaf bytenr = 42676709441536, data_bytenr = 34626327621632

                ctime 1567904822.739884119 (2019-09-08 03:07:02)
                mtime 0.0 (1970-01-01 01:00:00)
                otime 0.0 (1970-01-01 01:00:00)
        item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
                generation 1517381 type 2 (prealloc)
                prealloc data disk byte 34626327621632 nr 262144 <<<
                prealloc data offset 0 nr 262144
        item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize 439
                generation 2618893 root_dirid 256 bytenr 42677048360960 level 3 refs 1
                lastsnap 2618893 byte_limit 0 bytes_used 5557338112 flags 0x0(none)
                uuid d0d4361f-d231-6d40-8901-fe506e4b2b53

Although item 27 has disk bytenr 34626327621632, which matches the
data_bytenr, its type is prealloc, not reg.
This makes the existing code skip that item, and return -ENOENT.

[FIX]
The code is modified in commit  19b546d7a1b2 ("btrfs: relocation: Use
btrfs_find_all_leafs to locate data extent parent tree leaves"), before
that commit, we use something like
"if (type == BTRFS_FILE_EXTENT_INLINE) continue;".

But in that offending commit, we use (type == BTRFS_FILE_EXTENT_REG),
ignoring BTRFS_FILE_EXTENT_PREALLOC.

Fix it by also checking BTRFS_FILE_EXTENT_PREALLOC.

Reported-by: Stéphane Lesimple <stephane_btrfs2@lesimple.fr>
Fixes: 19b546d7a1b2 ("btrfs: relocation: Use btrfs_find_all_leafs to locate data extent parent tree leaves")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..df63ef64c5c0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2975,11 +2975,16 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 		return 0;
 
 	for (i = 0; i < btrfs_header_nritems(leaf); i++) {
+		u8 type;
+
 		btrfs_item_key_to_cpu(leaf, &key, i);
 		if (key.type != BTRFS_EXTENT_DATA_KEY)
 			continue;
 		ei = btrfs_item_ptr(leaf, i, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_REG &&
+		type = btrfs_file_extent_type(leaf, ei);
+
+		if ((type == BTRFS_FILE_EXTENT_REG ||
+		     type == BTRFS_FILE_EXTENT_PREALLOC) &&
 		    btrfs_file_extent_disk_bytenr(leaf, ei) == data_bytenr) {
 			found = true;
 			space_cache_ino = key.objectid;
-- 
2.29.2

