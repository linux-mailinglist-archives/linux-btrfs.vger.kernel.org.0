Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7951931AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYUKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 16:10:50 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:52186 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbgCYUKt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 16:10:49 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id HCMOjh5MEjfNYHCMQjKIfh; Wed, 25 Mar 2020 21:10:46 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585167046; bh=YIjE1eCyiG7QzggbWK4TDni1mYOZ3BuIOiQPQi+wiYk=;
        h=From;
        b=NF61Vws30MPPmV20JknwVGRUiYNncCK5WaG4PPCtW6RCvf9cOrHvYRJru2FbTn1eM
         pj7m777s2wg7DBZCeMeboXZ36B+q9jRykYokX5F0jZgF98CJI4vdcCJXlWxldMjtkl
         XUmLFReWvVvtRtIgGeowi9udHEslYCJGOGFdw0Bhpm/S9QozBhvgslkeLC1XXguY/J
         LuzG3ZWkkUbbu6qfUq4Yjk/k/m7d4yVjkQL839wVSX+nnwQT7ZYau4HmmM66SSvBQ7
         0Dc+YO76QHDyPaCCDagmrdasWKEH+yGJO0S7K7TcYMSTZs9SN2o3TpPyPfGipr25mU
         XxtBUY1+SMM5A==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=vSNmOmVH6_Tz5GIeFn8A:9
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] btrfs-progs: Add btrfs_check_for_mixed_profiles_by_* function
Date:   Wed, 25 Mar 2020 21:10:41 +0100
Message-Id: <20200325201042.190332-4-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325201042.190332-1-kreijack@libero.it>
References: <20200325201042.190332-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGkYcP/Y0c4qDFI5CyhfgKhAV9x4PrkfrfGxzSAkIbUt7yhQbguy7KdkSX9Lfi9dlZZlWkPGO4CWTvZoJ7dRC800nf3ZrGgrHItlj0Hn4XOtc7wuUh+P
 QdDKcPBN8Y4bJLHIfN+NZ9efykl50U0PIxwuBzVfTLRM5AeEr15cQ8/G7KaZNZiGVIfAY5EDMsDSlrZTpw/utLY1AgBzUYBy24j080Wz7AiQuJaxg3Rqg4jt
 FnlI9KkkOaiqfjgBkZKHrA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Show a warning if a mixed profiles filesystem
is detected.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 common/utils.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/utils.h |   3 ++
 2 files changed, 129 insertions(+)

diff --git a/common/utils.c b/common/utils.c
index 4ce36836..e7cd66eb 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1710,3 +1710,129 @@ void print_all_devices(struct list_head *devices)
 		print_device_info(dev, "\t");
 	printf("\n");
 }
+
+static int bit_count(u64 x)
+{
+	int ret = 0;
+
+	while (x) {
+		if (x & 1)
+			ret++;
+		x >>= 1;
+	}
+	return ret;
+}
+
+static void print_profiles(FILE *out, u64 profiles)
+{
+	int i;
+	int first = true;
+
+	for (i = 0 ; i < BTRFS_NR_RAID_TYPES ; i++) {
+		if (!(btrfs_raid_array[i].bg_flag & profiles))
+			continue;
+
+		if (!first)
+			fprintf(out, ", ");
+		fprintf(out, "%s", btrfs_raid_array[i].raid_name);
+		first = false;
+	}
+	if (profiles & BTRFS_AVAIL_ALLOC_BIT_SINGLE) {
+		if (!first)
+			fprintf(out, ", ");
+		fprintf(out, "%s",
+			btrfs_raid_array[BTRFS_RAID_SINGLE].raid_name);
+	}
+}
+
+int btrfs_check_for_mixed_profiles_by_path(char *path)
+{
+	int fd;
+	int ret;
+	DIR *dirstream;
+
+	fd = btrfs_open_dir(path, &dirstream, 0);
+	if (fd < 0)
+		return -1;
+	closedir(dirstream);
+
+	ret = btrfs_check_for_mixed_profiles_by_fd(fd);
+	close(fd);
+
+	return ret;
+}
+
+int btrfs_check_for_mixed_profiles_by_fd(int fd)
+{
+	int ret;
+	int i;
+	struct btrfs_ioctl_space_args *sargs;
+	u64 data_profiles = 0;
+	u64 metadata_profiles = 0;
+	u64 system_profiles = 0;
+	u64 mixed_profiles = 0;
+	static const u64 mixed_profile_fl = BTRFS_BLOCK_GROUP_METADATA |
+		BTRFS_BLOCK_GROUP_DATA;
+
+	ret = get_df(fd, &sargs);
+	if (ret < 0)
+		return -1;
+
+	for (i = 0 ; i < sargs->total_spaces ; i++) {
+		u64 flags = sargs->spaces[i].flags;
+
+		if (!(flags & BTRFS_BLOCK_GROUP_PROFILE_MASK))
+			flags |= BTRFS_AVAIL_ALLOC_BIT_SINGLE;
+
+		if ((flags & mixed_profile_fl) == mixed_profile_fl)
+			mixed_profiles |= flags;
+		else if (flags & BTRFS_BLOCK_GROUP_DATA)
+			data_profiles |= flags;
+		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+			metadata_profiles |= flags;
+		else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			system_profiles |= flags;
+	}
+	free(sargs);
+
+	data_profiles &= BTRFS_EXTENDED_PROFILE_MASK;
+	system_profiles &= BTRFS_EXTENDED_PROFILE_MASK;
+	mixed_profiles &= BTRFS_EXTENDED_PROFILE_MASK;
+	metadata_profiles &= BTRFS_EXTENDED_PROFILE_MASK;
+
+	if ((bit_count(data_profiles) <= 1) &&
+	    (bit_count(metadata_profiles) <= 1) &&
+	    (bit_count(system_profiles) <= 1) &&
+	    (bit_count(mixed_profiles) <= 1))
+		return 0;
+
+	fprintf(stderr, "WARNING: ------------------------------------------------------\n");
+	fprintf(stderr, "WARNING: Detection of multiple profiles for a block group type:\n");
+	fprintf(stderr, "WARNING:\n");
+	if (bit_count(data_profiles) > 1) {
+		fprintf(stderr, "WARNING: * DATA ->          [");
+		print_profiles(stderr, data_profiles);
+		fprintf(stderr, "]\n");
+	}
+	if (bit_count(metadata_profiles) > 1) {
+		fprintf(stderr, "WARNING: * METADATA ->      [");
+		print_profiles(stderr, metadata_profiles);
+		fprintf(stderr, "]\n");
+	}
+	if (bit_count(mixed_profiles) > 1) {
+		fprintf(stderr, "WARNING: * DATA+METADATA -> [");
+		print_profiles(stderr, mixed_profiles);
+		fprintf(stderr, "]\n");
+	}
+	if (bit_count(system_profiles) > 1) {
+		fprintf(stderr, "WARNING: * SYSTEM ->        [");
+		print_profiles(stderr, system_profiles);
+		fprintf(stderr, "]\n");
+	}
+	fprintf(stderr, "WARNING:\n");
+	fprintf(stderr, "WARNING: Please consider using 'btrfs balance ...' commands set\n");
+	fprintf(stderr, "WARNING: to solve this issue.\n");
+	fprintf(stderr, "WARNING: ------------------------------------------------------\n");
+
+	return 1;
+}
diff --git a/common/utils.h b/common/utils.h
index 5c1afda9..662c9e38 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -137,4 +137,7 @@ u64 rand_u64(void);
 unsigned int rand_range(unsigned int upper);
 void init_rand_seed(u64 seed);
 
+int btrfs_check_for_mixed_profiles_by_path(char *path);
+int btrfs_check_for_mixed_profiles_by_fd(int fd);
+
 #endif
-- 
2.26.0.rc2

