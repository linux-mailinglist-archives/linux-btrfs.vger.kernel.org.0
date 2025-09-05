Return-Path: <linux-btrfs+bounces-16671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557BB45DA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EFB161640
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636531328F;
	Fri,  5 Sep 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohOUp3b8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFD313295
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088665; cv=none; b=bgn0W+uOYYliJzHQms9Klyl6ypZ0vfT47+eHoM3JJSVkWOiuvhHlOg/VidbpSrLhMj6+AujQWCzoyBR0GRMZgyZlDlbcR4HB/FiRjf/SvvkwVNRznXvSp0p1n7btynnuoLt/WeRxOloHPurqIT07FREi14O+7FGF3ol1VK5ae1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088665; c=relaxed/simple;
	bh=g+O8TQWXRj0C58ob/TJ3X+CRc1XHxIy9S3W801FCqtk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlymO49jiFFUj4zVqUWXeKvpLQI6gYnKUsAu2nGMzLtgOXKqWKZCqqxjwo6IyQogH9JfP2NICbgvVxNJLzhxsV+zQ+BfoFppY2MmamA8DtuqGnbeDP4Cca8Ko3lCynD9h3Ytfrucy1Xg78FdSzmCTGC2XWFJXkyuP9ZMMBgu1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohOUp3b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B95C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088664;
	bh=g+O8TQWXRj0C58ob/TJ3X+CRc1XHxIy9S3W801FCqtk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ohOUp3b8zixa9taJuhSfDS1fO2ral6GJTUOCTVQO0bUjH92iQ5CjieB7VCQe6xwbC
	 PMTMLVZu98qd6yftFJdqXL3/0w+5y67BKDEM60I44gzanf4dXZh7cKKeYsG0iXMevm
	 qMYAg+uCjM4/UDuvHEB7dZ3X3Mwu7yNBP8bCnWQi0W72T5zYTwMmuPc5zPkNjdCu31
	 dT6LDa6VJ6Ik0d2ThxBoTaa3l6/gm4gIAYxmyMvCvbwuL1j/TE4L42LOIQ82b9bhS7
	 2vkWVzxYlXc4Dr52U/VU2kjU3IkhTiyC4RjPLr3xbAPnGY8jOSe5g/p9ORcANM7Cz7
	 wmmuCZwHD4RXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 27/33] btrfs: remove redundant path release when overwriting item during log replay
Date: Fri,  5 Sep 2025 17:10:15 +0100
Message-ID: <f363f7eaac8e319771502edb27228b69a59c1e91.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At overwrite_item() we have a redundant btrfs_release_path() just before
failing with -ENOMEM, as the caller who passed in the path will free it
and therefore also release any refcounts and locks on the extent buffers
of the path. So remove it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 65b8858e82d1..66500ebdd35c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -471,7 +471,6 @@ static int overwrite_item(struct walk_control *wc, struct btrfs_path *path)
 		}
 		src_copy = kmalloc(item_size, GFP_NOFS);
 		if (!src_copy) {
-			btrfs_release_path(path);
 			btrfs_abort_transaction(trans, -ENOMEM);
 			return -ENOMEM;
 		}
-- 
2.47.2


