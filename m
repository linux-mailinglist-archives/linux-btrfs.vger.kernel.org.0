Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A556319E48D
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgDDKcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 06:32:23 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:58897 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbgDDKcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 06:32:19 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id Kg63jDxJE6Q7RKg64jI6Vl; Sat, 04 Apr 2020 12:32:16 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585996337; bh=X9BqhunZ47MjClTm0UgGSPVbGskvlnmCKfCU9w/DWss=;
        h=From;
        b=TcX90m2b/ryIf+BzY3c/IST0KtA1L6sIig2ucB669AJTk3M7rhm4oFSyKMuQiBMlx
         +meceqGV3KkYKb/l9AA3RgTOoQK23BS0DG80ELzx7YIQt3dwwX1vAz4Ab+Cx4vnqeS
         VHYb0oJ1jTSbNOzX6VihmszraVcWrwRdfjJqLqR4jNbqhQxVP3bFoaSpeow1TjraoH
         bES8WgKqeH/1R3IU7v5uMKTovUbm1oPW1Fl9GSENEYW2cKmEWYEjvfPTJeKAty8Zsz
         skl/KPZogx5KMaC3mnBUQeAVbx+pyh6JBlF5xd+4L/PTehN5DIDlfXalGmeqdyJeCb
         TaO/uexz5zhgg==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=QjIyc2Qvnuyww2qCVJEA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/5] btrfs-progs: Add code for checking mixed profile  function
Date:   Sat,  4 Apr 2020 12:32:08 +0200
Message-Id: <20200404103212.40986-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200404103212.40986-1-kreijack@libero.it>
References: <20200404103212.40986-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKdd+esTeTN1C6k7X/myqPWbWe6+kX1Hj+B7yA5/cGAS/y098Pi5sAxP2Ivr+Mw8PWGotyjzcFi18TquKi0VV1LGpgwLI3p7KRWWBldwOSeChSby4yvj
 rs9lg2SBauptvJwvxaNBSJH6p1ZQqPdfoBycG5pG+LJBctlNXaTj0SLp5JJH2TPp55NKuMnFpN5CM/ktX88YiNjkSG7Sf9wpkUr+SUH47bRLQUeed7DLZ1EM
 A6ur/S/C7uAAz1PJm66H3J9JehzM7LaxHxCOV0tqb5U+G5TkUol4zKdz7+RHiCAYsECykkMhLbjcuGbypK1EdkRBvzDGsIQFaKP94DKbOjs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add code to show a warning if a mixed profiles filesystem is detected.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 common/utils.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/utils.h |  11 +++
 2 files changed, 199 insertions(+)

diff --git a/common/utils.c b/common/utils.c
index a7761683..5c9ff562 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1710,3 +1710,191 @@ void print_all_devices(struct list_head *devices)
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
+static void sprint_profiles(char **ptr, u64 profiles)
+{
+	int i;
+	int first = true;
+	int l = 1;
+
+	*ptr = NULL;
+
+	for (i = 0 ; i < BTRFS_NR_RAID_TYPES ; i++)
+		l += strlen(btrfs_raid_array[i].raid_name) + 2;
+
+	*ptr = malloc(l);
+	if (!*ptr)
+		return;
+	**ptr = 0;
+
+	for (i = 0 ; i < BTRFS_NR_RAID_TYPES ; i++) {
+		if (!(btrfs_raid_array[i].bg_flag & profiles))
+			continue;
+
+		if (!first)
+			strcat(*ptr, ", ");
+		strcat(*ptr, btrfs_raid_array[i].raid_name);
+		first = false;
+	}
+	if (profiles & BTRFS_AVAIL_ALLOC_BIT_SINGLE) {
+		if (!first)
+			strcat(*ptr, ", ");
+		strcat(*ptr, btrfs_raid_array[BTRFS_RAID_SINGLE].raid_name);
+	}
+}
+
+int btrfs_string_check_for_mixed_profiles_by_fd(int fd, char **data_ret,
+							char **metadata_ret,
+							char **mixed_ret,
+							char **system_ret)
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
+	if (data_ret) {
+		if (bit_count(data_profiles) > 1)
+			sprint_profiles(data_ret, data_profiles);
+		else
+			*data_ret = NULL;
+	}
+	if (metadata_ret) {
+		if (bit_count(metadata_profiles) > 1)
+			sprint_profiles(metadata_ret, metadata_profiles);
+		else
+			*metadata_ret = NULL;
+	}
+	if (mixed_ret) {
+		if (bit_count(mixed_profiles) > 1)
+			sprint_profiles(mixed_ret, mixed_profiles);
+		else
+			*mixed_ret = NULL;
+	}
+	if (system_ret) {
+		if (bit_count(system_profiles) > 1)
+			sprint_profiles(system_ret, system_profiles);
+		else
+			*system_ret = NULL;
+	}
+
+	return 1;
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
+	int first = true;
+	char *data_prof, *mixed_prof, *metadata_prof, *system_prof;
+
+	ret = btrfs_string_check_for_mixed_profiles_by_fd(fd, &data_prof,
+			&metadata_prof, &mixed_prof, &system_prof);
+
+	if (ret != 1)
+		return ret;
+
+	fprintf(stderr,
+		"WARNING: Multiple profiles detected.  See 'man btrfs(5)'.\n");
+	fprintf(stderr, "WARNING: ");
+	if (data_prof) {
+		fprintf(stderr, "data -> [%s]", data_prof);
+		first = false;
+	}
+	if (metadata_prof) {
+		if (!first)
+			fprintf(stderr, ", ");
+		fprintf(stderr, "metadata -> [%s]", metadata_prof);
+		first = false;
+	}
+	if (mixed_prof) {
+		if (!first)
+			fprintf(stderr, ", ");
+		fprintf(stderr, "data+metadata -> [%s]", mixed_prof);
+		first = false;
+	}
+	if (system_prof) {
+		if (!first)
+			fprintf(stderr, ", ");
+		fprintf(stderr, "system -> [%s]", system_prof);
+		first = false;
+	}
+
+	fprintf(stderr, "\n");
+
+	if (data_prof)
+		free(data_prof);
+	if (metadata_prof)
+		free(metadata_prof);
+	if (mixed_prof)
+		free(mixed_prof);
+	if (system_prof)
+		free(system_prof);
+
+	return 1;
+}
diff --git a/common/utils.h b/common/utils.h
index 5c1afda9..c4e6e935 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -137,4 +137,15 @@ u64 rand_u64(void);
 unsigned int rand_range(unsigned int upper);
 void init_rand_seed(u64 seed);
 
+int btrfs_string_check_for_mixed_profiles_by_fd(int fd, char **data_ret,
+							char **metadata_ret,
+							char **mixed_ret,
+							char **system_ret);
+static inline int btrfs_test_for_mixed_profiles_by_fd(int fd)
+{
+	return btrfs_string_check_for_mixed_profiles_by_fd(fd, 0L, 0L, 0L, 0L);
+}
+int btrfs_check_for_mixed_profiles_by_path(char *path);
+int btrfs_check_for_mixed_profiles_by_fd(int fd);
+
 #endif
-- 
2.26.0

