Return-Path: <linux-btrfs+bounces-1252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F110F8249B0
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E511F24752
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE01E52B;
	Thu,  4 Jan 2024 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="wBdxgeiW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (michael.mail.tiscali.it [213.205.33.246])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AE1E503
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by michael.mail.tiscali.it with 
	id WkiA2B00k04l9eU01kiA2V; Thu, 04 Jan 2024 20:42:10 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] btrfs fi us: wrong values in case of raid5 and not root
Date: Thu,  4 Jan 2024 21:41:42 +0100
Message-ID: <e8659631b0481defe32fcde435432da630af6789.1704400902.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1704400930; bh=Zx2EcHDLepMoxmBVhj9OqtIlt4ngtxiGL44fQ/gFsv8=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=wBdxgeiWjHm+zY/ho9znp4K7ZsrQY38QM+cQgan9G/632mzHzlZ6R1plBTC2NdlBH
	 YFmvuFtwKh6Wd073MqVQ7FhbTA3zTmzHyLg8mfs5zjyn+0VlURHC/91MieMUPskPI9
	 Weus3n17AfudRcM9YRu8UuKWjxpQCwfx1ES4GvVE=

From: Goffredo Baroncelli <kreijack@inwind.it>

In case of a raid5/6 filesystem 'btrfs fi us' returns wrong values
without the root capabilities.

$ sudo btrfs fi us /tmp/raid5fs  # as root
Overall:
    Device size:                   3.00GiB
    Device allocated:              1.51GiB		<--- OK
    Device unallocated:            1.49GiB		<--- OK
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        769.03MiB		<--- OK
    Free (estimated):              1.32GiB      (min: 1.32GiB) <-OK
    Free (statfs, df):             1.32GiB
    Data ratio:                       1.50		<--- OK
    Metadata ratio:                   1.50		<--- OK
    Global reserve:                5.50MiB      (used: 0.00B)
    Multiple profiles:                  no
[...]

$ btrfs fi us /tmp/raid5fs      # as user
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
Overall:
    Device size:                   3.00GiB
    Device allocated:                0.00B		<--- WRONG
    Device unallocated:            3.00GiB		<--- WRONG
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                            0.00B		<--- WRONG
    Free (estimated):                0.00B      (min: 8.00EiB) <- WRONG
    Free (statfs, df):             1.32GiB
    Data ratio:                       0.00		<--- WRONG
    Metadata ratio:                   0.00		<--- WRONG
    Global reserve:                5.50MiB      (used: 0.00B)
    Multiple profiles:                  no
[...]

The reason is that the BTRFS_IOC_SPACE_INFO ioctl doesn't return enough
info. To bypass it a scan of the chunks is required when a raid5/6
profile is present.

To avoid providing wrong information, in case of a raid5/6 filesystem
without the root capabilities the "btrfs fi us" is not executed at all
and a warning with a suggestion to run it as root is printed.

$ ./btrfs fi us /tmp/t/
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
WARNING: due to the presence of a raid5/raid6 profile, we cannots compute some values;
WARNING: run as root instead.
$

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem-usage.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 015c401e..9ba03d46 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -478,6 +478,8 @@ static int print_filesystem_usage_overall(int fd, const struct array *chunkinfos
 	bool mixed = false;
 	struct statvfs statvfs_buf;
 	struct btrfs_ioctl_feature_flags feature_flags;
+	bool raid56 = false;
+	bool unreliable_allocated = false;
 
 	sargs = load_space_info(fd, path);
 	if (!sargs) {
@@ -518,8 +520,10 @@ static int print_filesystem_usage_overall(int fd, const struct array *chunkinfos
 		 * computed separately. Setting ratio to 0 will not account
 		 * the chunks in this loop.
 		 */
-		if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 			ratio = 0;
+			raid56 = true;
+		}
 
 		if (ratio > max_data_ratio)
 			max_data_ratio = ratio;
@@ -610,6 +614,20 @@ static int print_filesystem_usage_overall(int fd, const struct array *chunkinfos
 		ret = 0;
 	}
 
+	/*
+	 * if we don't have any chunk information (e.g. due to missing
+	 * privileges) and is present a raid56 profile, the computation
+	 * of 'unallocated', "data/metadata ratio", "free estimated" are
+	 * wrong.
+	 */
+	unreliable_allocated = raid56 && chunkinfos->length == 0;
+	if (unreliable_allocated) {
+		warning("due to the presence of a raid5/raid6 profile, we cannots compute some values;");
+		warning("run as root instead.");
+		ret = 1;
+		goto exit;
+	}
+
 	pr_verbose(LOG_DEFAULT, "Overall:\n");
 
 	pr_verbose(LOG_DEFAULT, "    Device size:\t\t%*s\n", width,
-- 
2.43.0


