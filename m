Return-Path: <linux-btrfs+bounces-3760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6D891B03
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298CA2885AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAA16A9AB;
	Fri, 29 Mar 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7Z+o/3X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746316A992;
	Fri, 29 Mar 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715630; cv=none; b=lHSwhFnGaSdQHvKOqLjXtevV7dUM3fi6xWlqvDqsEDjUtZHVkmJRglPCpaMnCBDQeBqXnFy/OLXDUlca8BuztyEBLBss56t0Cw6s/9/ahpaY/m0vWJyVYlMDOr+s65jZQLWqWWeqVFS5YVpz+xARhI9I2HD/tyinVyMvPVImLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715630; c=relaxed/simple;
	bh=d5DArg/0hqWJGePnz1+kSxWB/3LWOiBxH1jRuA5RlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVUeIKqthg40gFfMiE6b5mY3Zbxr9XKyFhNpoHgqZjVcEVfhDP1JTrynLJ0X+1GhApgXj5MLqzm305jsCrZC8gh254tSaT3WrPzH27l49MUsql/zdOKTxF9J0e48iycVwNlyEBLIviaDLip3cU2CMcX66ajTTGhUVbTNiJow16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7Z+o/3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB0C433C7;
	Fri, 29 Mar 2024 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715629;
	bh=d5DArg/0hqWJGePnz1+kSxWB/3LWOiBxH1jRuA5RlpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7Z+o/3XEeBTpoKRrG1U8w7Qk47rVWhg9/A4vgVMB2tOFaTvNdT0evSESbRqCpUSU
	 eozM0l4NCGb8UxT61hz9Tw5ziFuVHlviv3g3H3hLvtxhQgA3nKDXAMxUUY/er6c56G
	 yyNDONNpXO9eX1f2qBWp7UjBv9TAgBHtcEfDoSp70o+H534R6HL27ngM1rjccew0gW
	 GP+qWgvwL+ic4kLS5Kjpt/oEZkJjeOfPabtqlvQAKPUAcqOz379FjSBcR0kBj+vmbS
	 kqTJKse9uTMT86qv3rZ7vzU8dB0nlrA+Dc4kQmY8jhTISAHI8nW67/ujv2RIXOKMEY
	 JRbp1tyA4IwMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/20] btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
Date: Fri, 29 Mar 2024 08:33:05 -0400
Message-ID: <20240329123316.3085691-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index fab7eb76e53b2..58b0f04d7123f 100644
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


