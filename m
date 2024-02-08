Return-Path: <linux-btrfs+bounces-2258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90984E9B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6601128ABAB
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86161481DA;
	Thu,  8 Feb 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="rAcSVtjQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487C03F9F2
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424253; cv=none; b=lNJ366jMMuApyRpHwYTyGZQGwrHq3xhrbzwgJQE9+Lg+J4iOqyrYuWLYbCo4Pt1rc2m1VBQBLanJB3m606kPUvTeyJ3gsy4KZHQ4yYxRnTKkjoGhVA/x6rMBzhQvPzz40Uro6tj04FsccYAwucXyuoDxUF09VXQhgChBQ5iLZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424253; c=relaxed/simple;
	bh=4u1qz0HRvOEw2Vbu1xcwtwUaVXvzoaqSlfcd4+ALgDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHtmyn6cvsVNCVoWk4D3wOWIaWOBuxax4eW2Eex+ki3aLjQe6OjXS60Y2PEpe3+7GjSco33Hi432eKJAG64+Aa3fNrMyDx4TO6kx8dmifK1B7N9euLLL3UaBknDtklJ0eO9lpm+sOT6RijNnCHpuoAmVQIqQCZkGxdRgn7riz9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=rAcSVtjQ; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVgoq; Thu, 08 Feb 2024 20:29:40 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 8/9] Killing dirstream: remove open_file_or_dir3 from du_add_file
Date: Thu,  8 Feb 2024 21:19:26 +0100
Message-ID: <2eec4ed3dd1574cbf17f2ecb1f91b159f8a90a34.1707423567.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707423567.git.kreijack@inwind.it>
References: <cover.1707423567.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1707424180; bh=HMX5Q+prtFhmDqdFdqsZLTZh9iXrSPToocenCVlATt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=rAcSVtjQEaT0n/2S2jrCa0rvXbxnyRysuDwcmxhqPwvKtV3+JzX2nvsBS7Ns3r9QQ
	 i7iHYEtd+6zZ98l3/tS8R0NzjtQYySX2n+LUQSHNJlAWw76n04JQBrmcW2+Bh2SZaw
	 EUaMXie45M5YLZlyioNLZo4ki/ulRTCht+e77ny0=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This patch replace the last reference to btrfs_open_file_or_dir3()
with btrfs_open_fd2().

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 cmds/filesystem-du.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 4982123d..cffeafd5 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -456,7 +456,7 @@ static int du_add_file(const char *filename, int dirfd,
 		ret = sprintf(pathp, "/%s", filename);
 	pathp += ret;
 
-	fd = open_file_or_dir3(path, &dirstream, O_RDONLY);
+	fd = btrfs_open_fd2(path, false, false, false);
 	if (fd < 0) {
 		ret = -errno;
 		goto out;
@@ -489,6 +489,12 @@ static int du_add_file(const char *filename, int dirfd,
 	} else if (S_ISDIR(st.st_mode)) {
 		struct rb_root *root = shared_extents;
 
+		dirstream = fdopendir(fd);
+		if (!dirstream) {
+			ret = -errno;
+			goto out_close;
+		}
+
 		/*
 		 * We collect shared extents in an rb_root, the top
 		 * level caller will not pass a root down, so use the
@@ -542,7 +548,15 @@ static int du_add_file(const char *filename, int dirfd,
 		*ret_shared = file_shared;
 
 out_close:
-	close_file_or_dir(fd, dirstream);
+	/*
+	 * if dirstream is not NULL, it is derived by fd, so it is enough
+	 * to close the former
+	 */
+	if (dirstream)
+		closedir(dirstream);
+	else
+		close(fd);
+
 out:
 	/* reset path to just before this element */
 	pathp = pathtmp;
-- 
2.43.0


