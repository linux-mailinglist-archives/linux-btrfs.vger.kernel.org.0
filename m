Return-Path: <linux-btrfs+bounces-3874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E57B896EA7
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A9F28A686
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B976146019;
	Wed,  3 Apr 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5n8JlSN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9214386F
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712145954; cv=none; b=r36V2jNarSK26EG4fiwpJZ04ryftL7QJzTz4z+t6U0A1VFuCBKm/45fdnlUgNdK+bGq3T7pxIgr7EEzyrZZBdNpYaQTIzMid7kQ4tWSyzy11n/4dgwfQQEKKd7REl6JlYBdqr9v/otQbw4j5xqUgd2xrcEAKpukOY+Q7Fg0ZGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712145954; c=relaxed/simple;
	bh=R6cO8tFReWCHcORZfhqj5uL3A2DtCPgjyytCp6edQSQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoKB8c8Fi3kqG92gK0pvbxC9w96KR07+vuST9DN5iy9k2YGbpjTlmQ9JjYTLc16TIe8mFJCWP0BCvTgMvXO8C5a4C4IlJNb99FaYjkxfbURXFaTiio6+e8eyOKBq7K2fPfucBzJgbU9MknMK0H67qvwV/m+cdn804dGnRaL6lM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5n8JlSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9671BC433F1
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712145954;
	bh=R6cO8tFReWCHcORZfhqj5uL3A2DtCPgjyytCp6edQSQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K5n8JlSNp7n6Sp6PiKQvKW7dXLn6FBU5QMFa/gRU07sqOMH5GmUnMBfPzItB3MZMd
	 sXf1QFolD3h/9tsW8fUVu53w2MV0WmT/JKwuF83XQsH9KPwT0skgMh8jFYVV9KCKC1
	 RMCMFP9gC3jj+jZAPNIX+ZgV8abZx5h5I3bYGwiX9TTHOrauNH+ne8sH/SichPMd/h
	 homVxp+14D1vBTwinxnQ9tZv5wnCYMYUmeXSoHfhvf6UXJKVTnCTlD3/6Y7Tj+1GYk
	 V9rbFNXgiejqfpUUkByo4bbW18TVNQ7FXB/Uc8ckWq7jC3ug2wA5ZsIY/yslgN1chU
	 v6HPHDyw3hURA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: remove list emptyness check at warn_about_uncommitted_trans()
Date: Wed,  3 Apr 2024 13:05:47 +0100
Message-Id: <2499553abf53fc8bfd112a0c16f07b225de01aba.1712145320.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712145320.git.fdmanana@suse.com>
References: <cover.1712145320.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At warn_about_uncommitted_trans(), there's no need to check if the list
is empty and return, because list_for_each_entry_safe() is safe to call
for an empty list, it simply does nothing. So remove the check.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a35c2c0bbc9..0474e9b6d302 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4182,9 +4182,6 @@ static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
 	struct btrfs_transaction *tmp;
 	bool found = false;
 
-	if (list_empty(&fs_info->trans_list))
-		return;
-
 	/*
 	 * This function is only called at the very end of close_ctree(),
 	 * thus no other running transaction, no need to take trans_lock.
-- 
2.43.0


