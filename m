Return-Path: <linux-btrfs+bounces-3753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB71891A64
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2CAB22A55
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B20158A04;
	Fri, 29 Mar 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3h2c1bQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C91158865;
	Fri, 29 Mar 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715498; cv=none; b=T0GnMvEnwBlpZLDHyZ9swx7DTa21m+mYeXhfHXi+iKqykfUXzIxtFm9yObNv8C1N+hzBeizYzK5u2aB65THEOEPV9tb44DcYmUFgdWx6rnUolqbyMDHODPB9KX/C67+1a1qVErTDCf9xT+8TWND8R08DhjbJhKJWqMMEQm/Irc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715498; c=relaxed/simple;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MedZ1avtgGAdPkg4xOqziWmaPu+8lm4JZWETw7tQ2ardSy8qQgjf1PFW4N0zmP/Ps1EoNhnme+mmH0Iasnma73/rZbbe7op9/qa4G9wKXXPeVBcsZ6BDKz+MN1dAmk+2tcQ2VYiEOjRUpm88BHq0+tSlSbhzI04PyQmDUmJaqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3h2c1bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1127C433A6;
	Fri, 29 Mar 2024 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715497;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3h2c1bQvgMra6qRvC7OWyNc6tOHtK8OYqDHKw87nK3v58TtV91Ato6qMnyF1xEpS
	 xsQHy1v9u3JXyCItGoMPj84+2U2w8kcuiMEgqHv8OX+EXtiSbHWkIlH39g7vX7TW1Z
	 5lOVdG/sGQbf/yDT/lq8um9XW05OyFNSdoYG/dEol/QF664DLZo6oDBAZ93hrfwMi4
	 yHsadHxsgk4L+xMhCsifaejqDf0KcOPcx8La4VXL7UYUeBIfzElye4NOvHOh4507uB
	 4rFgQcNheJQx1UJIngbIsV3wabG0anWGAwKgnFF13C9DqcoYhDsU6IPpF6QD5AmF5D
	 86RY4Xu7VNXjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 46/52] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:29:16 -0400
Message-ID: <20240329122956.3083859-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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


