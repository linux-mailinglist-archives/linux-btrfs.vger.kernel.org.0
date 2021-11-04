Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB04444D2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhKDCBE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Nov 2021 22:01:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59536 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhKDCBD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Nov 2021 22:01:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82ADE218F7
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635991105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=mmNBBmprkLGbHBB2nQYJQVlNd07gdWe3b4a1ue+tRkM=;
        b=OmR98SAIrwQVqIF+ruK3wcJE+wGqMMbNXyxxCA/hQmLnM44BvH+6GT92bpjHbgFSCSEI/b
        IIO4UeYj74/9o7MfOwfnvJE8MfcIqfY4giS4IwmoplXEk57BsFAKhX4sTuH5fcsTWxqa9s
        aVdNMMjOPGieSh1K9bYoHZqOLZqJO30=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D749413D72
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 01:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0D8ZKEA+g2FsKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Nov 2021 01:58:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: Make "btrfs filesystem df" command to show upper case profile
Date:   Thu,  4 Nov 2021 09:58:07 +0800
Message-Id: <20211104015807.35774-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Since commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str
to use raid table"), fstests/btrfs/023 and btrfs/151 will always fail.

The failure of btrfs/151 explains the reason pretty well:

btrfs/151 1s ... - output mismatch
    --- tests/btrfs/151.out	2019-10-22 15:18:14.068965341 +0800
    +++ ~/xfstests-dev/results//btrfs/151.out.bad	2021-11-02 17:13:43.879999994 +0800
    @@ -1,2 +1,2 @@
     QA output created by 151
    -Data, RAID1
    +Data, raid1
    ...
    (Run 'diff -u ~/xfstests-dev/tests/btrfs/151.out ~/xfstests-dev/results//btrfs/151.out.bad'  to see the entire diff)

[CAUSE]
Commit dad03fac3bb8 ("btrfs-progs: switch btrfs_group_profile_str to use
raid table") will use btrfs_raid_array[index].raid_name, which is all
lower case.

[FIX]
There is no need to bring such output format change.

So here we split the btrfs_raid_attr::raid_name[] into upper_name[] and
lower_name[], and make upper and lower case helpers for callers to use.

Now there are several types of callers referring to lower_name and
upper_name:

- parse_bg_profile()
  It uses strcasecmp(), either case would be fine.

- btrfs_group_profile_str()
  Originally it uses upper case for all profiles except "single".
  Now unified to upper case.

- sprint_profiles()
  It uses lower case.

- bg_flags_to_str()
  It uses upper case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add new lower_name[] and upper_name[] for btrfs_raid_attr
  So we don't need temporary string buffer

- Review all commits unifying the output to check what's the original
  output format
---
 common/parse-utils.c       |  2 +-
 common/utils.c             | 10 +++++-----
 kernel-shared/print-tree.c |  7 +------
 kernel-shared/volumes.c    | 29 +++++++++++++++++++----------
 kernel-shared/volumes.h    |  3 ++-
 5 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/common/parse-utils.c b/common/parse-utils.c
index ad57b74a7b64..062cb6931d84 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -269,7 +269,7 @@ int parse_bg_profile(const char *profile, u64 *flags)
 	int i;
 
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
-		if (strcasecmp(btrfs_raid_array[i].raid_name, profile) == 0) {
+		if (strcasecmp(btrfs_raid_array[i].upper_name, profile) == 0) {
 			*flags |= btrfs_raid_array[i].bg_flag;
 			return 0;
 		}
diff --git a/common/utils.c b/common/utils.c
index aee0eedc15fc..9cc9b9fa19c1 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1032,10 +1032,10 @@ const char* btrfs_group_profile_str(u64 flag)
 
 	flag &= ~BTRFS_BLOCK_GROUP_TYPE_MASK;
 	if (flag & ~BTRFS_BLOCK_GROUP_PROFILE_MASK)
-		return "unknown";
+		return "UNKNOWN";
 
 	index = btrfs_bg_flags_to_raid_index(flag);
-	return btrfs_raid_array[index].raid_name;
+	return btrfs_raid_array[index].upper_name;
 }
 
 u64 div_factor(u64 num, int factor)
@@ -1260,14 +1260,14 @@ static char *sprint_profiles(u64 profiles)
 		return NULL;
 
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
-		maxlen += strlen(btrfs_raid_array[i].raid_name) + 2;
+		maxlen += strlen(btrfs_raid_array[i].lower_name) + 2;
 
 	ptr = calloc(1, maxlen);
 	if (!ptr)
 		return NULL;
 
 	if (profiles & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
-		strcat(ptr, btrfs_raid_array[BTRFS_RAID_SINGLE].raid_name);
+		strcat(ptr, btrfs_raid_array[BTRFS_RAID_SINGLE].lower_name);
 
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
 		if (!(btrfs_raid_array[i].bg_flag & profiles))
@@ -1275,7 +1275,7 @@ static char *sprint_profiles(u64 profiles)
 
 		if (ptr[0])
 			strcat(ptr, ", ");
-		strcat(ptr, btrfs_raid_array[i].raid_name);
+		strcat(ptr, btrfs_raid_array[i].lower_name);
 	}
 
 	return ptr;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 39655590272e..0cb1e68f6c79 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -188,18 +188,13 @@ static void bg_flags_to_str(u64 flags, char *ret)
 		snprintf(profile, BG_FLAG_STRING_LEN, "UNKNOWN.0x%llx",
 			 flags & BTRFS_BLOCK_GROUP_PROFILE_MASK);
 	} else {
-		int i;
-
 		/*
 		 * Special handing for SINGLE profile, we don't output "SINGLE"
 		 * for SINGLE profile, since there is no such bit for it.
 		 * Thus here we only fill @profile if it's not single.
 		 */
-		if (strncmp(name, "single", strlen("single")) != 0)
+		if (strncmp(name, "SINGLE", strlen("SINGLE")) != 0)
 			strncpy(profile, name, BG_FLAG_STRING_LEN);
-
-		for (i = 0; i < BG_FLAG_STRING_LEN && profile[i]; i++)
-			profile[i] = toupper(profile[i]);
 	}
 	if (profile[0]) {
 		strncat(ret, "|", BG_FLAG_STRING_LEN);
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 6c1e6f1018a3..24732d8ae6f0 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -42,7 +42,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 2,
 		.ncopies	= 2,
 		.nparity        = 0,
-		.raid_name	= "raid10",
+		.lower_name	= "raid10",
+		.upper_name	= "RAID10",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID10,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID10_MIN_NOT_MET,
 	},
@@ -55,7 +56,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 2,
 		.ncopies	= 2,
 		.nparity        = 0,
-		.raid_name	= "raid1",
+		.lower_name	= "raid1",
+		.upper_name	= "RAID1",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET,
 	},
@@ -68,7 +70,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 3,
 		.ncopies	= 3,
 		.nparity        = 0,
-		.raid_name	= "raid1c3",
+		.lower_name	= "raid1c3",
+		.upper_name	= "RAID1C3",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
 	},
@@ -81,7 +84,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 4,
 		.ncopies	= 4,
 		.nparity        = 0,
-		.raid_name	= "raid1c4",
+		.lower_name	= "raid1c4",
+		.upper_name	= "RAID1C4",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C4,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 	},
@@ -94,7 +98,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 1,
 		.ncopies	= 2,
 		.nparity        = 0,
-		.raid_name	= "dup",
+		.lower_name	= "dup",
+		.upper_name	= "DUP",
 		.bg_flag	= BTRFS_BLOCK_GROUP_DUP,
 		.mindev_error	= 0,
 	},
@@ -107,7 +112,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 1,
 		.ncopies	= 1,
 		.nparity        = 0,
-		.raid_name	= "raid0",
+		.lower_name	= "raid0",
+		.upper_name	= "RAID0",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID0,
 		.mindev_error	= 0,
 	},
@@ -120,7 +126,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 1,
 		.ncopies	= 1,
 		.nparity        = 0,
-		.raid_name	= "single",
+		.lower_name	= "single",
+		.upper_name	= "SINGLE",
 		.bg_flag	= 0,
 		.mindev_error	= 0,
 	},
@@ -133,7 +140,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 1,
 		.ncopies	= 1,
 		.nparity        = 1,
-		.raid_name	= "raid5",
+		.lower_name	= "raid5",
+		.upper_name	= "RAID5",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID5,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET,
 	},
@@ -146,7 +154,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.devs_increment	= 1,
 		.ncopies	= 1,
 		.nparity        = 2,
-		.raid_name	= "raid6",
+		.lower_name	= "raid6",
+		.upper_name	= "RAID6",
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID6,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
 	},
@@ -207,7 +216,7 @@ const char *btrfs_bg_type_to_raid_name(u64 flags)
 	if (index >= BTRFS_NR_RAID_TYPES)
 		return NULL;
 
-	return btrfs_raid_array[index].raid_name;
+	return btrfs_raid_array[index].upper_name;
 }
 
 int btrfs_bg_type_to_tolerated_failures(u64 flags)
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 4fedfc95d155..5cfe7e39f6b8 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -134,7 +134,8 @@ struct btrfs_raid_attr {
 	int nparity;		/* number of stripes worth of bytes to store
 				 * parity information */
 	int mindev_error;	/* error code if min devs requisite is unmet */
-	const char raid_name[8]; /* name of the raid */
+	const char lower_name[8]; /* name of the profile in lower case*/
+	const char upper_name[8]; /* name of the profile in upper case*/
 	u64 bg_flag;		/* block group flag of the raid */
 };
 
-- 
2.33.1

