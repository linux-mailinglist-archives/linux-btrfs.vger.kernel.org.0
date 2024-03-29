Return-Path: <linux-btrfs+bounces-3786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8785891FBA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 16:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E647BB24D34
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0491B1989;
	Fri, 29 Mar 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn1lXu6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16C1B1971;
	Fri, 29 Mar 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716584; cv=none; b=nPLQha7kOajHTyrZqeR3q03PJeV0E1E6+v5uznirMVjo5sehVoNP1Aebzz8hkZY4RIdkcslbFr1L+YWjSqGSWQEwzi2sqS5FpC8zdG1KAu9QFLx8K47MRWdIcqgthoZ3T8v5oaUCO80tCdGRBs59lmwBg+WtlAM0lvTkCXV2Ei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716584; c=relaxed/simple;
	bh=Wbr3WrvcU27mxVlXxKr9LiCbLXTK6CwiODDSojafyfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKsbC/tj1k/M4UQMv6ZUWFHZdyq+qz59TXtkmvX5eRaqbAZ76/jB/Oqd3gk78I+Dsa/Zg6lOr/X07Rdur0G3xafn6WanfIvjdEwG0VbUfuLYu8v+iiY7D6YcPiRVPeM/Fc62G3mUUjY8hyqhM04kVeweRjg6X/Hr4y46siY3LD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn1lXu6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FFDC433A6;
	Fri, 29 Mar 2024 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716583;
	bh=Wbr3WrvcU27mxVlXxKr9LiCbLXTK6CwiODDSojafyfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dn1lXu6qus+iRJEUNadNe5WiSKkqKvp3lDi9FaFkNOCYOAFPEOf5Oura4NysWeqHp
	 ImwTDb+y5xdm1Pr3wgJOmnoig11zF/IqauNSOIduXtpG6w5lRxif2R8sA5vRbhWeUo
	 7LmawgrW/wrZYdkx8Y6+0TGkE8IpsHbBatdUOrx+bjfb0TJWDJyLNYxM677P5yZ8UN
	 KP9OcWZnJ5GY/joxuarhGdjh/rLEqcZjmEq96EHgoIPxoP1kwJZxlBfYQacBD7k2HZ
	 cQDI92u0WL9pBSeiYQf3w1WJywa+UiYBxcfd4IX1HL5JPGMB3O2XhtBdPMnVs6f/Aj
	 8SQ2BUoPDbn9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 23/31] btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
Date: Fri, 29 Mar 2024 08:48:40 -0400
Message-ID: <20240329124903.3093161-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index eaf5cd043dace..634b73d734bc6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3178,7 +3178,17 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
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


