Return-Path: <linux-btrfs+bounces-3794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE50891F1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15371288CA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C61C014B;
	Fri, 29 Mar 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTijMNFJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23271C012B;
	Fri, 29 Mar 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716689; cv=none; b=GNB8XGw//DrCR+uGgv7Sbu6OMgC728LHLSEQOVM3wXIK5nkxpW7I9Yai2AQRiOamCTF63qLDSBwH1KnQHtXF6twpmLSmqmZvslT4NPQ8iMoYMMveGbXY2WIBhb/OOfXiJ3UIjBSmYKrhPbMmjoKXfiuaEU+enQit59lGbc711BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716689; c=relaxed/simple;
	bh=GCCcXe3ICsPyaH8GbioAnxtzD+uP1Z9fAotkEf9lyHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8JmNvCR5YRBayAqZI62dSLHl/6L8CMnfIYZ49BzFKo07lUOn207A5Mi3cqB3w7SjXFg0gguWtdjRM8nc7eUvgFo1n2pT9GgYhtm/sBOIJh5X75x67OfFXRd1a+hj28dMehHBpePdW6OyU4AUj1LTmhiE4VjsSvBfq0EkCLTOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTijMNFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68E8C43330;
	Fri, 29 Mar 2024 12:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716689;
	bh=GCCcXe3ICsPyaH8GbioAnxtzD+uP1Z9fAotkEf9lyHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTijMNFJzYyhMf+UylBj0DstNeuTEoPMO/+0stOsNckn3nv4SrBGxGj7S//aaEqEF
	 Mue6//o7ZD9/xmbRoKfGkQlG8+XJ7rYejLB4sWrt6OyUUTo2130AkA7t0HjfZAQ5qj
	 9il7KVksMyQNnhujBJxRol6HkzjOlZwFXw5aTxIuE7XEquxAxZySCrv3evM+BOwS8a
	 PpEI2rjKuGN2hAZVnTtRD6KjhwLdjtaYbfJr9mneiEEZdx7HQZk11ap+l45Z19Xwj8
	 KZbgXVgz9dpmbSJ/+Rz/KYUHGnN5clCiFsrLx8FOyaAj8bdLpV3Rn88JltcNSYuTjG
	 snkBXiv3kSA3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/19] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:50:48 -0400
Message-ID: <20240329125100.3094358-16-sashal@kernel.org>
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
index 0c86409a316e8..e3b6ca9176afe 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -958,7 +958,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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


