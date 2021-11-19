Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F08456A28
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Nov 2021 07:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhKSGWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 01:22:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSGWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 01:22:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6C077212BC
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Nov 2021 06:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637302791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ptlkIcThaO15Mjq/9nmunsjW0Z6lhUC/M60J1KfS1/o=;
        b=RgvTzuuOzIdYtmkZ6o0tmN+6iJxCn5YSJ6ogHDed8MJhFKEJOD3+N9qKMNomo1EFnf7X+T
        mkekS8JZzWj7bvv0gryNG7S4Nv/rlFQR5Id5v1ZzCkzo3RRj91D8pnT9Wltbp6VblWR5LT
        xqGir5YKhEYxYf76iXLrZbfFrOVY23s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C725113467
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Nov 2021 06:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MuaNJAZCl2GlMQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Nov 2021 06:19:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't bother stripe length if the profile is not stripe based
Date:   Fri, 19 Nov 2021 14:19:33 +0800
Message-Id: <20211119061933.13560-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When debugging calc_bio_boundaries(), I found that even for RAID1
metadata, we're following stripe length to calculate stripe boundary.

 # mkfs.btrfs -m raid1 -d raid1 /dev/test/scratch[12]
 # mount /dev/test/scratch /mnt/btrfs
 # xfs_io -f -c "pwrite 0 64K" /mnt/btrfs/file
 # umount

Above very basic operations will make calc_bio_boundaries() to report
the following result:

 submit_extent_page: r/i=1/1 file_offset=22036480 len_to_stripe_boundary=49152
 submit_extent_page: r/i=1/1 file_offset=30474240 len_to_stripe_boundary=65536
 ...
 submit_extent_page: r/i=1/1 file_offset=30523392 len_to_stripe_boundary=16384
 submit_extent_page: r/i=1/1 file_offset=30457856 len_to_stripe_boundary=16384
 submit_extent_page: r/i=5/257 file_offset=0 len_to_stripe_boundary=65536
 submit_extent_page: r/i=5/257 file_offset=65536 len_to_stripe_boundary=65536
 submit_extent_page: r/i=1/1 file_offset=30490624 len_to_stripe_boundary=49152
 submit_extent_page: r/i=1/1 file_offset=30507008 len_to_stripe_boundary=32768

Where "r/i" is the rootid and inode, 1/1 means they metadata.
The remaining names match the member used in kernel.

Even all data/metadata are using raid1, we're still following stripe
length.

[CAUSE]
This behavior is caused by a wrong condition in btrfs_get_io_geometry():

	if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
		/* Fill using stripe_len */
		len = min_t(u64, em->len - offset, max_len);
	} else {
		len = em->len - offset;
	}

This means, only for SINGLE we will not follow stripe_len.

However for profiles like RAID1*, DUP, they don't need to bother
stripe_len.

This can lead to unnecessry bio split for RAID1*/DUP profiles, and can
even be a blockage for future zoned RAID support.

[FIX]
Introduce one single-use macro, BTRFS_BLOCK_GROUP_STRIPE_MASK, and
change the condition to only calculate the length using stripe length
for stripe based profiles.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae1a4f2a8af6..3dc1de376966 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6296,6 +6296,10 @@ static bool need_full_stripe(enum btrfs_map_op op)
 	return (op == BTRFS_MAP_WRITE || op == BTRFS_MAP_GET_READ_MIRRORS);
 }
 
+
+#define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |\
+					 BTRFS_BLOCK_GROUP_RAID10 |\
+					 BTRFS_BLOCK_GROUP_RAID56_MASK)
 /*
  * Calculate the geometry of a particular (address, len) tuple. This
  * information is used to calculate how big a particular bio can get before it
@@ -6345,7 +6349,8 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	stripe_offset = offset - stripe_offset;
 	data_stripes = nr_data_stripes(map);
 
-	if (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+	/* Only stripe based profiles needs to check against stripe length. */
+	if (map->type & BTRFS_BLOCK_GROUP_STRIPE_MASK) {
 		u64 max_len = stripe_len - stripe_offset;
 
 		/*
-- 
2.33.1

