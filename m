Return-Path: <linux-btrfs+bounces-3782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE66891DEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14071C27CC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395E61A3382;
	Fri, 29 Mar 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6lArYuD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6461A3398;
	Fri, 29 Mar 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716440; cv=none; b=EN/1n5AbbzF+kun/QOaVrLLimODHHAChP9YEtpCeWyngft0mRRG78ZQjfa3hBTzWBBqG7l8lPv3jMx+NKdpQLsw/muHxMuDgxo7VgMTUHtUBPTp38zpdqx+BBLuqrTSt8tJgQbsUwsgRvwCV7H/zUf43bLCrTf+4X9PXaN69Va0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716440; c=relaxed/simple;
	bh=1Wra2lwoSp/z48sWnntzoYkS5wx/babMCJBNRI4avDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeyAB6csdJthwnGnFKBP11r5Pw8ZLXiefXgLJNhzltj9Ca106nHg4RxY9pggui+35/qsQq5ONOHmb18A0hwfVYHq1v9e+rFM35wHs9czX4CXHOGxdyFAEh7PqHwacJreLAXKZP3XuaCBtHa0AHRdzvj7ayFXKj9hdxN3fSmYP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6lArYuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5C5C433F1;
	Fri, 29 Mar 2024 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716439;
	bh=1Wra2lwoSp/z48sWnntzoYkS5wx/babMCJBNRI4avDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6lArYuDxDGV9bUOra2gFlAfN+6LcwW0nBJn3FZYL+0lMV5aVxaRBRpz3B7s8KRCa
	 As6aI7+R+RPGVXtuoqPOwMrDKGZmSsQP27Eu4IKubILBU98DSHlbIX0tJU2n1O4DRz
	 d/xMtkINn0iZ8RWTvbpTwVeg4yOQSmjHeD2DW8XvM38/xMPcxsD02bPZjNfXRzCLru
	 dt6lag0HSPqi234YlFlReCnfNUF85GTc2K9MOhFdcWVMdo5fhqhAMgQetjZKBPln3k
	 +c2QR25XLuqJiUSGdHW2Jxg+ly0yVx8uaN/Kkf5qamvhsQyG7aczA2ErrNRxeM6UA0
	 InJwt4kx80/Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 42/52] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:45:36 -0400
Message-ID: <20240329124605.3091273-42-sashal@kernel.org>
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

[ Upstream commit 3c6ee34c6f9cd12802326da26631232a61743501 ]

Change BUG_ON to proper error handling if building the path buffer
fails. The pointers are not printed so we don't accidentally leak kernel
addresses.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9f7ffd9ef6fd7..754a9fb0165fa 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1015,7 +1015,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 					ret = PTR_ERR(start);
 					goto out;
 				}
-				BUG_ON(start < p->buf);
+				if (unlikely(start < p->buf)) {
+					btrfs_err(root->fs_info,
+			"send: path ref buffer underflow for key (%llu %u %llu)",
+						  found_key->objectid,
+						  found_key->type,
+						  found_key->offset);
+					ret = -EINVAL;
+					goto out;
+				}
 			}
 			p->start = start;
 		} else {
-- 
2.43.0


