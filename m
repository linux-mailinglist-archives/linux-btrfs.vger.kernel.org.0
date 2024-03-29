Return-Path: <linux-btrfs+bounces-3792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C60891F11
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCACD1F29430
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855861BFB50;
	Fri, 29 Mar 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgodiCmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7F1BFB3B;
	Fri, 29 Mar 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716687; cv=none; b=ZF5DDztbIbHvsSYovt5WseGhuCSmL7VHdTrZ+wxNPc6XPwQSYZcjOX2LgjWjqtWckObvmGY9fdTSkwzO9f9OvMsUa+MtdHZr9xCP+w+m0CQj3AXBg/pYKcqhVG5FJH0dOA8BMKANhFz0kIcmNNZIqa1WOlow/oZ2pmdO090Zi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716687; c=relaxed/simple;
	bh=PLWhnObGJGsVUQsXHjLQ9apPb6v5V7hE3iLPqRqZYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLQmOBNtmt2Zrw8a7O2rxVZrDThxPW9mJlFC09Six/MrGWo7c2RDy4HmOV5ZrLr4nWxWk5Vxqba7R9J2VXA+bgiIjF/p0BbLtbJNbiHMjoCboMwmDzPN0Z9iqXFiP6bnt2blvDX+LycXRRM4N8eIICDzH5JNKqj0ssQovCA8Uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgodiCmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550FEC43394;
	Fri, 29 Mar 2024 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716687;
	bh=PLWhnObGJGsVUQsXHjLQ9apPb6v5V7hE3iLPqRqZYTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgodiCmpUevrYxPPSP0uL31EwTESkzPhZEdOjPB9CJILTrnDnoF6xFy1vdSyOxH0V
	 e/vfzF0yJrXs4Dwb4UKPBI3AqlWfR25lttoq/BKFQgsVsQ125As0M8db/l2cA2EYTk
	 7pF+Ehz5iDxAmMWV8OqGjZtbcRtHdARTV/JwBJlgJInU4yzPJzXBJqz78gd0HGrLtO
	 N77QQzq+F5Il05zDiJ8qDlTFegAhIxea6bNJ+D7n8mrpFiJw59YZchqycyqUrwQGRl
	 9zKTRqtg6IgBu2hMcw6x+f28r76jemi8VO5dJrldTXx8sCPh2G9qwsddZAoCcYeTQt
	 EGfXzuISG9mAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/19] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:50:46 -0400
Message-ID: <20240329125100.3094358-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
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
index ceced5e56c5a9..30b5646b2c0de 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2948,7 +2948,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
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


