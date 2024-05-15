Return-Path: <linux-btrfs+bounces-5027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D4C8C6C76
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A97FB24369
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACF15AD90;
	Wed, 15 May 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7hYkcQ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE3A15A4B7
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799115; cv=none; b=a3bv1xTXd5k8i2J94RpFmYMrQWMYzlm94uo1UiSIow7xWoNR43DOmOOHvl6CYfnvhV4W2745iONCAvqOnkYjCLN9zXOJVAHs1CLqwbNz4iStIzCPFOj9Lq2qU0G3OS8GOX8ESLZ/nmKWUMSu/loiOhZ8Eo/z5L4wR2RLmSvm5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799115; c=relaxed/simple;
	bh=4zK+IpcPKpYF+yHNcXDhGWwgyzwxE7EFXM0HCLOHhLc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQmQksmUIHB2MhQCtQlsxFrcWATgNR5PvEXPftv+qTYhtQjqAvBlUxcRzJ0APGXzlbBmGlAuBeBWb8rh3cSS7RsBxIonIOBUQ7UYO7qx7L2cwiEgfepX/DILw7svsoIld0r/wOUR1jNf08c5swrd8MpCA/iLYvyP9w+se8GuoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7hYkcQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B8FC4AF0C
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799114;
	bh=4zK+IpcPKpYF+yHNcXDhGWwgyzwxE7EFXM0HCLOHhLc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G7hYkcQ9YvEThCv3aPyhBvxiNTTs4zsHt+2nCLqh45cTCHOYJ6eqQ9NEopzxnF3Oj
	 6fwL8iKjUeDJJ9i7Qwi1J+URFYUwFhz3I2QgllbGdLNijtNnQAmnG8AabEyHhN6SKE
	 RaEdre9sMAUVcuiAo7hrzaj4xvH67q4wsob/yssvgjZaSNw91I+Skw51yVh9BJBpzE
	 pTiUlJD47JARBT89elxpNGgJcJxHC0uiEDzBSkTat2APGmGUCAIlRZSiH+X446T77g
	 IpDi+Rdxq/uuCsyjTB8fhEQES9vC4msztrLyHrVktaVH2T+LzPB/PBrq0ObWD96wzq
	 SLSvGSIDVbfIQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: make btrfs_finish_ordered_extent() return void
Date: Wed, 15 May 2024 19:51:47 +0100
Message-Id: <0fc7eb82d2d89b607d663de4fadc031c54aab002.1715798440.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715798440.git.fdmanana@suse.com>
References: <cover.1715798440.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_finish_ordered_extent() returns a boolean indicating if
the ordered extent was added to the work queue for completion, but none
of its callers cares about it, so make it return void.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 3 +--
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 3a3f21da6eb7..3766804decb8 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -374,7 +374,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 	btrfs_queue_work(wq, &ordered->work);
 }
 
-bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct page *page, u64 file_offset, u64 len,
 				 bool uptodate)
 {
@@ -417,7 +417,6 @@ bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 
 	if (ret)
 		btrfs_queue_ordered_fn(ordered);
-	return ret;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index b6f6c6b91732..bef22179e7c5 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -162,7 +162,7 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent);
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
-bool btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
+void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 				 struct page *page, u64 file_offset, u64 len,
 				 bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
-- 
2.43.0


