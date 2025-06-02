Return-Path: <linux-btrfs+bounces-14369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D2ACAC87
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E653400F17
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE2F202984;
	Mon,  2 Jun 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1fRfrwi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D42054E4
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860402; cv=none; b=AUhKMZ8cW9lgrxFejpXqY1BQ38KY0LvasDUtmeIAGYay9YkhaNfWp3pyN5C75lVsCHj2EafD+VL4F5ztCTrpxJ0QFiqI/F7BVmx+oqOxiJeKOhuymVDkjusMg9PPf+9gXH6dkhrF8LixFv2rQypkru86bbk4IrM9j+9acBm4QJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860402; c=relaxed/simple;
	bh=uE0L06kmG2yZhrsNCM+HZCMOWcrdXH2f1Ow1Rm7UOyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5KJn9bBHKcbm+fBjWTKvrkoNiIY/+5y4Ir+SMnAKrXX6DadNP6NvCx1zlGSgIDn+tyGmYnJo7DnrCxycV96MJ7hVKGoqLCz5L1OKeJZlec0pz5nplY/Fixc+ShdwyD9L1IBsJCMOrm3XuF7R9H7oTBcBmgsGI9zrSrcJwnqqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1fRfrwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A610C4CEF2
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860401;
	bh=uE0L06kmG2yZhrsNCM+HZCMOWcrdXH2f1Ow1Rm7UOyg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q1fRfrwiO0yNxv83Cb32tb248nNvv4m+nQV8L5jPgAQ9CLRf04EKArZKlF1mmtXcD
	 pZVMoPT5sh0ge5Jr98Ts9M7hLrDGNdO90D9UWGnXk2pANnXdoh1jJgyoT8aTrYhSkd
	 v+Wj5mICBzfwfmixJ+rDJn8ZCVW4lXp29nYacOtpHOaLah7AQVBk0NBslZ4kwGX8R6
	 JuLUdS491PfUiBqzsli4NRjl6tOf3DdjnHHa6I3sti46dX6c33YDm3adybiVIkJm0h
	 NeCQ8Lq1GxCSTo93E+MzczS6bjk0wYkIvT8AFmciASVRBV9LG1qKAN3ugLN7Q3Ds/z
	 S+AFNV5XxLF1Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/14] btrfs: allocate path earlier at btrfs_log_new_name()
Date: Mon,  2 Jun 2025 11:33:00 +0100
Message-ID: <3132c6b52f0f5a6a84c0c01480375cee49cab8ed.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of allocating the path after joining the log transaction, allocate
it before so that we're not delaying log commits for the rare cases where
the allocation takes a significant time (under memory pressure and all
slabs are full, there's the need to allocate a new page, etc).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cbdf9791ec5d..37da27acef95 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7543,6 +7543,14 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 					     &old_dentry->d_name, 0, &fname);
 		if (ret)
 			goto out;
+
+		path = btrfs_alloc_path();
+		if (!path) {
+			ret = -ENOMEM;
+			fscrypt_free_filename(&fname);
+			goto out;
+		}
+
 		/*
 		 * We have two inodes to update in the log, the old directory and
 		 * the inode that got renamed, so we must pin the log to prevent
@@ -7556,19 +7564,13 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		 * mark the log for a full commit.
 		 */
 		if (WARN_ON_ONCE(ret < 0)) {
+			btrfs_free_path(path);
 			fscrypt_free_filename(&fname);
 			goto out;
 		}
 
 		log_pinned = true;
 
-		path = btrfs_alloc_path();
-		if (!path) {
-			ret = -ENOMEM;
-			fscrypt_free_filename(&fname);
-			goto out;
-		}
-
 		/*
 		 * Other concurrent task might be logging the old directory,
 		 * as it can be triggered when logging other inode that had or
-- 
2.47.2


