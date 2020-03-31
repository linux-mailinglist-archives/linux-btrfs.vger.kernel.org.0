Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653F3199EB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCaTK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:10:56 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:39284 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgCaTKy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:10:54 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id JMHijXV70jfNYJMHjj3qIg; Tue, 31 Mar 2020 21:10:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585681851; bh=oCAZ2eL/I/S+3h+iFU+9Scu4YhYHopcqXNDARGxW4eY=;
        h=From;
        b=pds9Jwv4BryH4exGtlCRPcQBRWFIUL8oIxPMfD4mJjIOE74N1H1LanfFlbTXEywFy
         28cDVEUbJNo6x5v3vIgr5G7he+LYoLpYty4Fvs5LtONZGg2vmVFZfJGqHReZtG/Ioy
         GUzau9W88wJ+mwuzQq/CD2eFawr7VOuyxdLOWJgU3qFtwesFKQ/hmEOkFqErKq5Svi
         3/9ewnASnZ5K2iApO5edKeOYFvUQBMhY+7jOMQ0rPqyh7kujmZuzWdBUNCb7F+UmOd
         06oQrZmj1FvI+2dRN3OCQkp1esVh3W0KGPc3w7Co5OPkBlp/DuqqSUFaYhmo1kvMIL
         26YkfcEZi5a9A==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=vSNmOmVH6_Tz5GIeFn8A:9
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] btrfs-progs: Add btrfs_check_for_mixed_profiles_by_* function
Date:   Tue, 31 Mar 2020 21:10:44 +0200
Message-Id: <20200331191045.8991-4-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331191045.8991-1-kreijack@libero.it>
References: <20200331191045.8991-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGNfLIHCkLZha9d5dLtr7lsKmMdrqTXWKjPExfzL24rKaiOhP05e2IuAS8mgYOBQ7n/WFTWzKxrs8waBs59DvmAOYl0UHtvoESmNGPjQQbe1Ct9ywePY
 cLjDv3yncj3M9CTr4Fnt06QQUtAUgp+oqHrlLNDVhAi2n5CQZTLaBYqNNx+HBp0wH5PLeOkL/D3SCMGfquR0QMF308wzWPbLVsXXTrS5GDT+YzW/HdlMcPrF
 Aj0OEcDmKJF7eKrmljdqxCa0FUZgSqsHX2Lja0lIaKUMElcIW733xuWE3etbT0otLV8Ar6e8zctT50v2X/QvOA==
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
index a7761683..e3f18709 100644
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
2.26.0

