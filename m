Return-Path: <linux-btrfs+bounces-3749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7ED89199D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EC5285C96
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70312F393;
	Fri, 29 Mar 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsQH8nNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C814A0A4;
	Fri, 29 Mar 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715345; cv=none; b=tYvV2ZjqR20GfSKFjUogfLvThdstoLSDR3dCSsbK11lqcmLbq1f6PBjwpkvOumuCM8XoM/a23+bTn7V9ZHdUyKa1KEk4pAWUYksvHGtuXNJe/cUja7Ox5WN3IXLs22Lvqeta+R79wzUQd3k1BjqN3JfUI3ElLf0D6GiXLCybP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715345; c=relaxed/simple;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lvsx2x7bZpZPMOU0X8Q8iXFAU5s9Hhr8siuksEyPISP0lT51CuJawbT6zGdvDm9OT6RYMwyxoSeAMEhaTptoQzhHam2t9pXcb70h5erKw27w0cdsd5JOGqCaprIOJXxtrEOrivAjlzUJPzO3/iD3nQn88sJY/1UP/V+P5Hh7bbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsQH8nNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B365C43399;
	Fri, 29 Mar 2024 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715345;
	bh=CBLJ62ZdxOVQDTLj11F5FJn+stz1NKJMv4S1wqAkH4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsQH8nNUh/6QmnC6QOffCNwJgBF6kcdzwYRmnqumjqXjY9pHHlJYbeQYMKUV2GWn3
	 PQYkoH9+NHhlV6RERGfoKXxK+T7B9B787LmODjSPkcYpBPtS3yuYEh/2Hp45eu6Fs6
	 Pzg4IsU2miONGU6YrASNRLnkaE+MCKrIWITjL90X7X9F9AzrU9t/klitdqB/nIrtou
	 QiGPsO5FIG6iknw9zNDQcZhsNfpv3OwsTqGIjCDFC5Xn+tnUj5nE6HB22qzp9P6vGz
	 vuDBbZ5pE6ipyFnQJ8QzG6fZVvDJgnh+37EAhZpSzC8qqFWAUz2wkJKJTQ7k875723
	 6ZVV4kSGOLhsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 61/68] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:25:57 -0400
Message-ID: <20240329122652.3082296-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


