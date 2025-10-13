Return-Path: <linux-btrfs+bounces-17702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DECBD2E82
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 14:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E34F18FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E726E714;
	Mon, 13 Oct 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDYgSTLf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CC26E6F8
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357140; cv=none; b=rRHOIpE345FckgYgjnPYL+QMO8/f4gLJKk8iamRtJ4ZSf7JNtI+HMabXwFkveTSEsA35DqZRWxcns71lnoZlMAwJgiepL2DD2jUU+EONlkGYC0B4LRWo72yn2o1qY+27pE88R7chkB2AWaFzas/rQBTik+5OL2gahCwLL5KEym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357140; c=relaxed/simple;
	bh=d1mGCLke9uwCHShzeEzz5C1zDs8POXruTNAaWhvARoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY74NHdRK6ur4scveEq8ej86/tV+dbv5GbcwGTEl85g66F9n2zEz87Vzd4phzQmHSGQuTi5hbHM0botNCz6Y2z/uRJjGDCap0knVwrIH9qZZnQrxiCYSXqK8OmETGTFhk+r1ZPta2SuC0yFLld0G+fIqPs/cnDyCigfXhZ5XPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDYgSTLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA836C4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357140;
	bh=d1mGCLke9uwCHShzeEzz5C1zDs8POXruTNAaWhvARoQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VDYgSTLfoVxsiX0tr7SDw/rbGUQS12RTqQiu+2e7FT4NQ1biDEXx4sWR6et6UKmH+
	 wXH+tqtEtvBMKcBFVaZopes51jhpvHT0jY0os1dy9YpRFnqjXUZe8t0E3K1ESG1KWl
	 5OTY4jm5vCMOxBn76SnqW+oG4rP2OFGqEfYBLU2WjvSc4C9HGgb6i9rR1B1Xo0Hg7Z
	 u0AQkPSfgYMRpu03AI7Hpy+ea7z+mydDgS24qmRHWmgMk5TPhnM6WR0NKg0W9IXVwd
	 L8i3Nu5JOhJLvJsc6KtZQHcsVzVkbqh5IOOf9MIM+FUM+GYLH1rlousqqEoadoHbtm
	 1NjZs7EF4vgtg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: add unlikely to unexpected error case in extent_writepages()
Date: Mon, 13 Oct 2025 13:05:29 +0100
Message-ID: <7bffa1a8631f3dada0ad49265968f56c155c91cb.1760356778.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760356778.git.fdmanana@suse.com>
References: <cover.1760356778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't expect to hit errors and log the error message, so add the
unlikely annotation to make it clear and to hint the compiler that it may
reorganize code to be more efficient.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1cb73f55af20..870584dde575 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1874,7 +1874,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 				  folio_size(folio), bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
-	if (ret < 0)
+	if (unlikely(ret < 0))
 		btrfs_err_rl(fs_info,
 "failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
 			     btrfs_root_id(inode->root), btrfs_ino(inode),
-- 
2.47.2


