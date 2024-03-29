Return-Path: <linux-btrfs+bounces-3748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA29891996
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801A51F21A69
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335714A096;
	Fri, 29 Mar 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq4jnvvI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E47149E16;
	Fri, 29 Mar 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715344; cv=none; b=BxFmA/s+YbdEbMzSqcmmfVfz/QhxTAH3BroxSn3FK9C1Z5X5iRhuMaC8JvxyF4/wHgHiCmW4/Tzuscg8W23CwlRZMD3DQOTc1Y8tTqP/6fIw/j/bF1XjDIp62WO1b/3hnpw3RAsq6pn+pMOPUwhblwk8lbBwBexLfZSULtR37X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715344; c=relaxed/simple;
	bh=1LkM0DVVSxHRFqCqUyibA4ChmpR37hD2y9C2DhaWz7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP3kQWuy20Ibo44TUQ2iprIN3zigYZFEYt8rVSPnWayDHRkXh52OLkTUosOIbrkU5AGy17uu0FhMTWYFgXf5phgBB2aXtaI8M6ehsJ7mwwuTJETPcgI9mOxXuqtKS2hpf+ptz21Tr0u9xsyLAz4UeY9fZiaa4liUmxerr9UdItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq4jnvvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3921DC433C7;
	Fri, 29 Mar 2024 12:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715344;
	bh=1LkM0DVVSxHRFqCqUyibA4ChmpR37hD2y9C2DhaWz7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq4jnvvIynNy7PVk6Zqm3UGiAxeRP38crRwM/YUD+//rfP0XzDT6c3KCvhXswDbtX
	 4n1F00i1Onzv4ugsiG8+sh1TR2j+Qm9M5F6k9xsRwwi41mwHHamTvOp6bKQ4zGK/5l
	 4jeRbgDmdacffQ6iJ0KPbDV5Fo1o+4AtCQM4fjLQq0ZCAHAKyz/0Q/E2SQH+1UEn8V
	 SwlzILh9EH3Ve8cffvLY+AUo7+fOcJaCz7F73x+yyNry75OVIK/C7WfoeTyD81kc3i
	 EVx54Q0IOlfsCICfbKqvSTV+4U2fdEPIgwoKwK75PIZIA8ZhBVU1zDTPdT48PeVz/m
	 7vEmDhPVOVFsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 60/68] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:25:56 -0400
Message-ID: <20240329122652.3082296-60-sashal@kernel.org>
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

[ Upstream commit 7411055db5ce64f836aaffd422396af0075fdc99 ]

The unhandled case in btrfs_relocate_sys_chunks() loop is a corruption,
as it could be caused only by two impossible conditions:

- at first the search key is set up to look for a chunk tree item, with
  offset -1, this is an inexact search and the key->offset will contain
  the correct offset upon a successful search, a valid chunk tree item
  cannot have an offset -1

- after first successful search, the found_key corresponds to a chunk
  item, the offset is decremented by 1 before the next loop, it's
  impossible to find a chunk item there due to alignment and size
  constraints

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c778..6aae92e4b4240 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3393,7 +3393,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
-		BUG_ON(ret == 0); /* Corruption */
+		if (ret == 0) {
+			/*
+			 * On the first search we would find chunk tree with
+			 * offset -1, which is not possible. On subsequent
+			 * loops this would find an existing item on an invalid
+			 * offset (one less than the previous one, wrong
+			 * alignment and size).
+			 */
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, key.objectid,
 					  key.type);
-- 
2.43.0


