Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0E3E4C0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 20:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhHIS0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 14:26:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhHIS0h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 14:26:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7C3D421F4A;
        Mon,  9 Aug 2021 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628533575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w068xXU+0kSWgD3bT5NKk3xNZRWUNVZsVEkHmVZRsDQ=;
        b=kLdtpCdIOo1UcL57DUOASCKQNQKjv+hcJL8a5wWhMoI1JlasjbLfJABttTJT7DJzrOoM5b
        lJsqXfRo98hOqlizJHPf2eStdFPqpYX0+TXoHLpP+GeuXn2o0q4rqBOJlUOeGmTmrFlowe
        US4dSDNImm3xRNVDYBGIe5af9qVNmjU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4274813BAE;
        Mon,  9 Aug 2021 18:26:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xf1vJENzEWFdaAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 09 Aug 2021 18:26:11 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: Drop the type check in init_alloc_chunk_ctl_policy_regular
Date:   Mon,  9 Aug 2021 15:26:13 -0300
Message-Id: <20210809182613.4466-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
Our documentation says that a DATA block group can have up to 1G of
size, or the at most 10% of the filesystem size. Currently, by default,
mkfs.btrfs is creating an initial DATA block group of 8M of size,
regardless of the filesystem size. It happens because we check for the
ctl->type in init_alloc_chunk_ctl_policy_regular to be one of the
BTRFS_BLOCK_GROUP_PROFILE_MASK bits, which is not the case for SINGLE
(default) DATA block group:

$ mkfs.btrfs -f /storage/btrfs.disk
btrfs-progs v4.19.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               39e3492f-41f2-4bd7-8c25-93032606b9fe
Node size:          16384
Sector size:        4096
Filesystem size:    55.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    55.00GiB  /storage/btrfs.disk

In this case, for single data profile, it should create a data block
group of 1G, since the filesystem if bigger than 50G.

[FIX]
Remove the check for BTRFS_BLOCK_GROUP_PROFILE_MASK in
init_alloc_chunk_ctl_policy_regular function. The ctl->stripe_size is
later on assigned to ctl.num_bytes, which is used by
btrfs_make_block_group to create the block group.

By removing the check we allow the code to always configure the correct
stripe_size regardless of the PROFILE, looking on the block group TYPE.

With the fix applied, it now created the BG correctly:

$ ./mkfs.btrfs -f /storage/btrfs.disk
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               5145e343-5639-462d-82ee-3eb75dc41c31
Node size:          16384
Sector size:        4096
Filesystem size:    55.00GiB
Block group profiles:
  Data:             single            1.00GiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, skinny-metadata
Runtime features:
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    55.00GiB  /storage/btrfs.disk

Using a disk >50G it creates a 1G single data block group. Another
example:

$ ./mkfs.btrfs -f /storage/btrfs2.disk
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               c0910857-e512-4e76-9efa-50a475aafc87
Node size:          16384
Sector size:        4096
Filesystem size:    5.00GiB
Block group profiles:
  Data:             single          512.00MiB
  Metadata:         DUP             256.00MiB
  System:           DUP               8.00MiB
SSD detected:       no
Zoned device:       no
Incompat features:  extref, skinny-metadata
Runtime features:
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     5.00GiB  /storage/btrfs2.disk

The code now created a single data block group of 512M, which is exactly
10% of the size of the filesystem, which is 5G in this case.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 This change mimics what the kernel currently does, which is set the stripe_size
 regardless of the profile. Any thoughts on it? Thanks!

 kernel-shared/volumes.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index aeeb25fe..3677dd7c 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1105,27 +1105,25 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 	u64 type = ctl->type;
 	u64 percent_max;
 
-	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
-			ctl->stripe_size = SZ_8M;
-			ctl->max_chunk_size = ctl->stripe_size * 2;
-			ctl->min_stripe_size = SZ_1M;
-			ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
-		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
-			ctl->stripe_size = SZ_1G;
-			ctl->max_chunk_size = 10 * ctl->stripe_size;
-			ctl->min_stripe_size = SZ_64M;
-			ctl->max_stripes = BTRFS_MAX_DEVS(info);
-		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-			/* For larger filesystems, use larger metadata chunks */
-			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-				ctl->max_chunk_size = SZ_1G;
-			else
-				ctl->max_chunk_size = SZ_256M;
-			ctl->stripe_size = ctl->max_chunk_size;
-			ctl->min_stripe_size = SZ_32M;
-			ctl->max_stripes = BTRFS_MAX_DEVS(info);
-		}
+	if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+		ctl->stripe_size = SZ_8M;
+		ctl->max_chunk_size = ctl->stripe_size * 2;
+		ctl->min_stripe_size = SZ_1M;
+		ctl->max_stripes = BTRFS_MAX_DEVS_SYS_CHUNK;
+	} else if (type & BTRFS_BLOCK_GROUP_DATA) {
+		ctl->stripe_size = SZ_1G;
+		ctl->max_chunk_size = 10 * ctl->stripe_size;
+		ctl->min_stripe_size = SZ_64M;
+		ctl->max_stripes = BTRFS_MAX_DEVS(info);
+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+		/* For larger filesystems, use larger metadata chunks */
+		if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
+			ctl->max_chunk_size = SZ_1G;
+		else
+			ctl->max_chunk_size = SZ_256M;
+		ctl->stripe_size = ctl->max_chunk_size;
+		ctl->min_stripe_size = SZ_32M;
+		ctl->max_stripes = BTRFS_MAX_DEVS(info);
 	}
 
 	/* We don't want a chunk larger than 10% of the FS */
-- 
2.31.1

