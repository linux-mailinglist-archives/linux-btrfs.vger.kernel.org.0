Return-Path: <linux-btrfs+bounces-3773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B01891C90
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA8D1C267D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CB18B5EC;
	Fri, 29 Mar 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9N7uhMW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE71148839;
	Fri, 29 Mar 2024 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716147; cv=none; b=MvpxbO6kFxPOIUWBaOkLOrAc8ctNJbmAGTXC18eYrzMZ3+N10ZEcjsD9mxG6d8Y+Cdy9TrrlFK2rpm/q2W/4e3IrJpZ/LlWmJ9hP6OQb1Jre8ybMmvvI9tO+4I0ejyNutXwx0MJUV9H/l0NZxy0Ugg/ojXKdK0ze5KXwEnZrU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716147; c=relaxed/simple;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PltzN6gNfH6yB/+q0TIdAKL56jau+Mcp1y4cclWCu2GT7DR9hBB3wUhSMTrkb6PGJofqXdoKv93YR0e3wo7faa4D9WMD3vEczz2cPYZF+4rzK3It6l1GM9ZS1fHFrPRgVYib4mlwxJb4x0XDsjqVDPHUP1xRP4PK18t3Nkn9gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9N7uhMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE71CC43394;
	Fri, 29 Mar 2024 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716147;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9N7uhMWRGVdxWsMQcpoA3S9J4+3M0IlwKl9J6l4c2+tBisLwr7THUaTTM1yqCGKt
	 ucBvxKvedC6H2XpPRZUvoUM+iXd8lww39QshzTnWEQEOUSkKfQygVTNQngbDspaXdg
	 cUXDG0lmMoHQg8n0j1EnxAdHZp/96+Q5L/aiPdhovW/UmJh/vwZxI1wKE+nRZ7qJb8
	 bZq2ytsSgtXPFWss5wNThSj69cCi8wdSWXizawaQpQPJfTEFvkBfWKX7mJ/gw9rAok
	 q1oFRm2OXm/e2AqGC1Y1E/0Sl8TG8nrs93XI5Fw0gugA7TF5wIEWYvbNOyMg2Z0Cow
	 jy46rxOdioHrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 82/98] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:37:53 -0400
Message-ID: <20240329123919.3087149-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 744a02b7fd671..203e5964c9b0f 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -174,8 +174,15 @@ struct dentry *btrfs_get_parent(struct dentry *child)
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


