Return-Path: <linux-btrfs+bounces-3780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC3891DE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A83D2866C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DAC1A2B89;
	Fri, 29 Mar 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp32yP2E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB21A2B72;
	Fri, 29 Mar 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716437; cv=none; b=R7opnKyYflDU66w8BIVgFqZf76s+v9TKZV+/TYI9P6Iea9U7S/GPzpX9lrxY+NyftwLfoEaY9TkYK6WN3utuGAjDx+OZNXZJ++4KpKr2z/6pgLcL+7moyHflMMlnrzvutPkduYP1bBt9DmFxWvEiMfrsBHKnk2x4c8H4q8d3ssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716437; c=relaxed/simple;
	bh=KWF5woA40Y3P0zjBP6wmfQIo/JmwcFCBoVMPAt+k7cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqeBXsFzDVPGOc0/JrO7azhN8ZyLP8U2+mPZhIDh8nJu2cIF/IAYMxGoUiQjvQFhQnX27fx9jGkUlhXlUN/dYpZH8smfC66Ej0ITZqDmtNiFJ6vXfnxJVYKgQ0cLHKSg6YDEYAbcXdXAdq1h32+71L57x27sydQ3ImgtfYoQvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp32yP2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA7C433B1;
	Fri, 29 Mar 2024 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716437;
	bh=KWF5woA40Y3P0zjBP6wmfQIo/JmwcFCBoVMPAt+k7cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gp32yP2ECJOWsiDxxf69xsDyKhaSl/UgFeZ1VXOci2+CEsq93oNrWldrMfFuzV6hk
	 LB9mIiVBYZCQN3LDh5IDNxXrkMm7JW5fmyeIwST8BI6lson47K1pJ2sJDssF6XC2L4
	 Xt3F3w1tXZi4Ho+yat6SuW1/biMD+DaDU9NHilPCDnAZVS/SqbieEBmvEJldF3CLWO
	 TGK65VXWvKSY/j9OCs2WlgPlrFE5G6jmkXng5+MtumrvWzIMcVt4jc1wJYQM4KrNfj
	 v0KSExnhwD5WklO9UKWGB1WdhjsREs44JEg8+eKmL4CesqD17hlIqOs+iV4+L5VbIs
	 ivCg1yPRv5O9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 40/52] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:45:34 -0400
Message-ID: <20240329124605.3091273-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 6fc2d99270c18..06db09c20df2d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3381,7 +3381,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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


