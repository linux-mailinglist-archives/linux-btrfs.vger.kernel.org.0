Return-Path: <linux-btrfs+bounces-3752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF9891A61
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37FF284B87
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B815885B;
	Fri, 29 Mar 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL3ZVCx3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A649158849;
	Fri, 29 Mar 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715497; cv=none; b=GMJHhYruQnRFl6Lwzn4NueqtVO3ZSoDJFSRKvP7hZFbBiZHweKp90VuvjV3F3VdlwEPWOQmrZWomqU65G8n52OS32h4LQ7u0tT1tKFEv+6dtjqGNoFhbYVvrfnbqnrJfYMrP+0BbzH5DmNkd8eMaly2nqOsWTmZNrj2H+fvACJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715497; c=relaxed/simple;
	bh=l3Psi5Y188FysbyMVKHvE/2s4Z+BDxi15ATKpUq23kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8BfkjW+VXh3RlV9BmvpuDPVAjDXilfHskDjFBiciT8mwG/ooYoYngisCV7UmEZVq39lwaJ9bd/IyvlfK9lmmvdZZA6wOL2UdwqZ24nzPevCsfZUtr/Fgy/vX7oWOaT2+h3KB1H3X1ri4R7GWb1//Iyx2Pm1S0mxfJ8tuwZ33gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL3ZVCx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0EEC433C7;
	Fri, 29 Mar 2024 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715496;
	bh=l3Psi5Y188FysbyMVKHvE/2s4Z+BDxi15ATKpUq23kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gL3ZVCx3/XiuYDhflCKFzW3JA8R3MXHYaaBIyr7L644S4OV1QgNXH/r6HgnLqkwYK
	 OBvlumEIySjaX14fxkIw8k4T6u0r8jJ0whB1oYBHjH4MlBzgflI6yRVcxZj+fZ0TAZ
	 RcriGsBNA1t8RLOaHZ+yRUrV4sN8qF8PFroZzAHj/JIMAUf+EALE3ReroaVxJpXKYB
	 TYrm4RJhwTQW25pAyVgcT4YAS45Fqm3BIAoI5kyJfeM988OY4/2+ESiJq0VBP+uOK/
	 hhANZzVUfXSJ1K66y4aS5ILZI0D80e64SebTfjwWqXMmbfQqE7ei//1p+bOeyCEk+v
	 zekBLll6WwBng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 45/52] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:29:15 -0400
Message-ID: <20240329122956.3083859-45-sashal@kernel.org>
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
index 722a1dde75636..18b12cc4df68a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3352,7 +3352,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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


