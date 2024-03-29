Return-Path: <linux-btrfs+bounces-3768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F134891B94
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001871F27A7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67B176532;
	Fri, 29 Mar 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF6DvpcX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DABB175C9D;
	Fri, 29 Mar 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715738; cv=none; b=nyK4/Y1r3+JQlMIRAqdc+aEFcXEpdiqM7LPX6/yf8uJ8+dZo/zMjl+qHuo0SQ1dvfY6QwEnS8FO5RDEBKlwnLPk8MyzbYySEXb7vCzXIi+Nr3PJbtEzLyGjOyEeBf7RWiqdJdgU1pxkbw0plC+8Iez5jmJNoiQooQsC0UV7GkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715738; c=relaxed/simple;
	bh=PLWhnObGJGsVUQsXHjLQ9apPb6v5V7hE3iLPqRqZYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A++vCG5wz3Ew3XJia0cJLLQ6YJPeyRqqzMibKXwDUaAIlHf+yN/NqzQ4fWI+qcVsfV67+qtmHKF2PErk8uP69GnEyAO154c949VC0P2lDjvW8LAptPKBR68CtFautNSo+XArh2C/4iZPiZ2mvDdp9PazAzzQDXwOUegXco7Yw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF6DvpcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE692C433C7;
	Fri, 29 Mar 2024 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715737;
	bh=PLWhnObGJGsVUQsXHjLQ9apPb6v5V7hE3iLPqRqZYTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vF6DvpcXqpgNQmuV3yCXXJ1jwNEdcFZQaTp06/HCAxlMGAh/RlS/JR8vA54Fw26q/
	 ckgvqnXLmtT+a8r2/me2Gw+rvRoco/kTeWTzz9+qIDtEUaiEKo1IZoE98cmqwaALTx
	 bxPYAkJqsrCWLkzPqx1kct03bGTZs3JvjYH300Qn6s5A9mR6sPYuM5KSGkXBGOnMOw
	 T0PDEDWTQVUZoMLd2dyXzBF2K/LcbA4Wl6oGHlpYdeSSNe/UWoM6RSSfZog/tlIUVs
	 GymQ21vYOUffbGG4IkzVldCfZRPa2ohKVMu1oYEkNPi35mQMEokWxZVEjDnNSm8z6T
	 rACldzZe0gKFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/11] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:35:14 -0400
Message-ID: <20240329123522.3086878-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
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


