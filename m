Return-Path: <linux-btrfs+bounces-3785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4763891E4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F51F27D57
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378671AB1EC;
	Fri, 29 Mar 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3sj7tWG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FF1AB1D7;
	Fri, 29 Mar 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716517; cv=none; b=n3pnJ3OB1Kqh+4BQaQtmR+MSengGY7wn61aYdZu3y66/TiGRR76yyxuwfxcIzm9ULMJyN2bL/kVyYTqvf8KbhD2/by9erZ0bNCrFAXatH7WWl4q4YEJjdnEqqtLqmH0SBJyvnKjdu7deFtRPsdW3x7LAXaUCQQk2fC+W8WfgoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716517; c=relaxed/simple;
	bh=XsvXVhLLWUYugHIGnmfSQTbg5lFxG0Xy6hMGJ6e+2NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0nftlGXM9t2L34PglYlhpHoe6AJ3jvSoygHhjqL+Ld29oQ6G2+9q5gQum6Cj/ZJD1KaCnINCp93c+uNN3vjSreFaivuHqD/cxNz9ACWs+dfLi8TvE7Y7dVI1YdRXvc5Y/wN61iUfphJNuSqODnQAg54rcjc2qG/6F7d5onnFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3sj7tWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6DBC433F1;
	Fri, 29 Mar 2024 12:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716517;
	bh=XsvXVhLLWUYugHIGnmfSQTbg5lFxG0Xy6hMGJ6e+2NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3sj7tWGVGQ3AxnjkHrqrgf4A1gL02Y7RYPlUbTciCHmjcmMPwoaQO5R8J4yABAUu
	 xV/gUeu3wzKS2VQAk4/T3EhmzhxIAx5GJSeenYP9Fh2v6kSMb3Ne4OdFz2MWYcMF60
	 rsTKJi8q5EcWDh/ENXiL0Db53U0UJfh3ljiHcpH7oF78ku3e8xM+9ks/mRUjO/kWJL
	 WzcF06b2BLhu5CjKPehnyXPxXuwyjzVKUGzwwwXGp75SerrYNQuEgNSCgGo4RDpcKa
	 tFxWAiWaohVilnkBtAa68YXpdbIPA7v4iYhWJdroKe/RPXS7JzA+RNaqp8BVCHEDzR
	 Tt6elAtaELQsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 27/34] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:47:28 -0400
Message-ID: <20240329124750.3092394-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
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
index 9900f879fa346..f1ef176a64242 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -976,7 +976,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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


