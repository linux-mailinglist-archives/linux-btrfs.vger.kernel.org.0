Return-Path: <linux-btrfs+bounces-3766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE96891B78
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8087C1C26600
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35AF1741DE;
	Fri, 29 Mar 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtj/edoX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BE1741C0;
	Fri, 29 Mar 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715712; cv=none; b=Klm6JXahK7aYqpwREqjheg97M9QyKmx74FXwVPgcFEr3JjQYbNyKPy7inUEWrmBifOXNgEQmJGeKw9wImreVdnaG9ijCaV9LWgC94XAoaOul/jz5fMkTDfH7vaXujQiIMcWSfe2o190xRNI9R61z/A0daeZ9x1BsjJvIcHJdD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715712; c=relaxed/simple;
	bh=wjH2febHGZZt5K3X7H+ZU2AnIuDf0ekNxv1Un2cJadg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8nuhcisH6ilygZ/e7kMwdAXA1m/g2Kw4TTR2cjqp0u0G9I8E5iqQflUrEQC1DTYoJk7x45+tLliSRCk1r/Ly5oqLwibIdxJq9PVyHVJmCdGxoodq+IVwe934IGGnTTOC2FkCqS32mwVgHNiS2IlMVnzVHDmxdjQj267UUyJF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtj/edoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E49C43390;
	Fri, 29 Mar 2024 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715712;
	bh=wjH2febHGZZt5K3X7H+ZU2AnIuDf0ekNxv1Un2cJadg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mtj/edoXGUxHKecBuE7+584rnVTxh+bEGR6nr9XaQcPsPBrqlRKaGQHYjTwrlHOC1
	 NgFQMocjDMVRB9pErS2CN7M9d8pe0JdOaevmh/Mc1ASvG0T9U1kk6hOvCYkkQrYL+l
	 hxkVNrru8VplTqxmK9OSLnYkVwUMgqFO4tUH0ijPuFfOmO0R1qzYxEfj5CSEhkmDqj
	 wgRnVGBqvs7nOLAHLrb+6qLqiZrbA1SqSr/okuG5wUxidcjQSXV638DWUCT52nSn5i
	 sUSGqdwc76mOLslwQi0U1NbwKghr79X7FoAYLQxSvABdr1bppXI2RLflc3eg+sJzvK
	 fv69eG9zsyT5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/15] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:34:36 -0400
Message-ID: <20240329123445.3086536-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 6e4727304b7b4..08d1d456e2f0f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -182,8 +182,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
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


