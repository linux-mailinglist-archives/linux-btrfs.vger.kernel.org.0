Return-Path: <linux-btrfs+bounces-3787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3B892042
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1491BB31812
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB716DD08;
	Fri, 29 Mar 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTfSYPVr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1451B1996;
	Fri, 29 Mar 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716585; cv=none; b=CyPaNUNEoHOB2TI8BwnaCrqziZBgyX0lLHMjDJTridoAeQy76vlKFWMRJVS8kXjTji9bnfQkTp9hPXQ1rr696CGB98qwInqjt3HHzlboh8uqt2nqR2fbiU0xdzVCqd0MIxI4gQmFYGxZYbNS66AXhQkGV2cIsIY1N2a14ZBBQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716585; c=relaxed/simple;
	bh=5Qjb/MVqlMzeA2IER1lNJqRtiGaHZ9qaPFlpU5csCZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkv3/FWs8xxln0kLQyc0XcaJuZg0SHZ4AALqJnJULdDsIvBnt8zrb8oF/HbaMd6rPQVJdnG1grIj3M7RJd498JD3/jztsrVh209XABg+gSvGPw6pmlOkkHRcqPEf7lEfHf0YC8aCkcxJeDnWTsr0fv+T/Jpb/PEBM27nnbobfsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTfSYPVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD52C433F1;
	Fri, 29 Mar 2024 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716585;
	bh=5Qjb/MVqlMzeA2IER1lNJqRtiGaHZ9qaPFlpU5csCZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTfSYPVrc3UUP/dirWu2afqHt3j4uKgUzm3ZItttVp4N5AF8xI5JbD6HuOHYvLCTv
	 8vmtW1Hf1UPjjzzfD1n0J2FLYfV37YgFwYsG5XOhg4p8eXoRXBbEypA0DWhqNOMcbZ
	 BxiNYMSpFlFWXnOft7IixZazcFY5n28MfDrFtslLunrLx5ltPmwFEhDpUFnUU1H9RT
	 CSVQCPMIV8pTXewWHJZSEQn5TLnVABjmOVjXrLXZNC6YU8+/JTHQQB28xJK8/tdjN9
	 CogMfieBAxdaZieFAT4RIoawpYG3VLB4guuETKDR//gJnzdxwI75/+xyzd3Y80GiBi
	 GkemLSLR6v1Bg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 24/31] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:48:41 -0400
Message-ID: <20240329124903.3093161-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit 26b66d1d366a375745755ca7365f67110bbf6bd5 ]

The get_parent handler looks up a parent of a given dentry, this can be
either a subvolume or a directory. The search is set up with offset -1
but it's never expected to find such item, as it would break allowed
range of inode number or a root id. This means it's a corruption (ext4
also returns this error code).

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/export.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index bfa2bf44529c2..d908afa1f313c 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -161,8 +161,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		goto fail;
+	if (ret == 0) {
+		/*
+		 * Key with offset of -1 found, there would have to exist an
+		 * inode with such number or a root with such id.
+		 */
+		ret = -EUCLEAN;
+		goto fail;
+	}
 
-	BUG_ON(ret == 0); /* Key with offset of -1 found */
 	if (path->slots[0] == 0) {
 		ret = -ENOENT;
 		goto fail;
-- 
2.43.0


