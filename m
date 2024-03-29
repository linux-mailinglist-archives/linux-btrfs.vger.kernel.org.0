Return-Path: <linux-btrfs+bounces-3763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C52891B43
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDBF1C218A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1B3170A34;
	Fri, 29 Mar 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuskFNkU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3E1703D7;
	Fri, 29 Mar 2024 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715672; cv=none; b=oO0mqufckftHG8nlFwBni1cQFtjl7L2Yqqm3KGu0/ZcSYmD8UCN6x2to/tcI9cVLUF+F8a6iK/qbeKXJXH2cRiWLy6NBFskqXiImauMCMM3Zkb/ReDag2D9CGTYdbsabT6LG4pL6N1mgK19P7Zxzk1ZzvRBtTdXoEaKMCWIdlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715672; c=relaxed/simple;
	bh=5Qjb/MVqlMzeA2IER1lNJqRtiGaHZ9qaPFlpU5csCZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b97tTkVYjlvoQD3M79b2pmAr8nhgGBWS7lsEVpJJcZ78jesg89hTTHt7bmLNG9OR6K+Ik18I52CWO4v1D6cv4QjSlu7PBH/oVwI5gkZV8KfU+/Lmjt6CecQT4ks29l9EQ8b3Zoy+1tS4C7w5JDa4/91f9kF6n4VBbw3xnxeuPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuskFNkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C6C433F1;
	Fri, 29 Mar 2024 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715672;
	bh=5Qjb/MVqlMzeA2IER1lNJqRtiGaHZ9qaPFlpU5csCZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuskFNkUFUlwQu/RE2ZZiNRjkLf5c6lHvBTb74LgtTWHJ012qiiRndz+CfmxND3ij
	 acikXs/C8SspLzLOSmKUEivCDbfAUB3L01duk78cyofuYpSw5ez9EjHnpIYVFuQcQz
	 cNw0R0yzTGaXOCW1DM4PZhltKJYYq0YWDvn9sFpcPcNgXjmjBOsK3n1EmlXBAEQcit
	 NdCOIRXmzJ7C8i9NU66n0K64cVhIwB+q0x1D6M4B42308sm6+du5bx//O0WnusqGjH
	 KYTEOjhA1Bi1MICzFqeqyJak/4X+MvLZ9qzb8elSIIkE+JpU1hI0j9FCQwqYITFXOG
	 c0zb1UdpfI6dg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 14/17] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:33:53 -0400
Message-ID: <20240329123405.3086155-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


