Return-Path: <linux-btrfs+bounces-3767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073A891B7A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615331C266E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD3B1741FD;
	Fri, 29 Mar 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcD21cCd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA071741E4;
	Fri, 29 Mar 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715714; cv=none; b=S2Q131CDVMrMTArtmnxs+QJ0ydGYWmne5GPUEIfUypzGGGUWOiHqG5ZqqA0Qnn/l9fFWfcUJebD4ePqX2I1o7QYOb+vOFRiN7AnkPl5uVzWtwCPTrzo+Gv1dSdJgBiacCTtno6tFxe1DgW+B+i78ElZDHLrmIvL8vj31AVdO5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715714; c=relaxed/simple;
	bh=Q3lRiFBJnaNpsMCNua1ttOlooq+w4ptJYkDpadxjCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMO7WrCFPR/7SZVooAcW1e/oJpejbCta/ptbDOH2ZL+kMTWPncsJxeAx7LRjTFb3JaYZo3I3eCpWRRbv5oVfrNm9tmeO49427qqk1/F49Ag+/o9oWJdzSW9//iqSnBYkta9GOx+houdmkckgxU8g9vzIXfBi1pZp4F+TKJ6pp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcD21cCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9555C433F1;
	Fri, 29 Mar 2024 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715713;
	bh=Q3lRiFBJnaNpsMCNua1ttOlooq+w4ptJYkDpadxjCVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcD21cCdIzba1Lu3viPqwXsRv/NuK5cwRxpHvrvkOhPqc8CBjo4qjRM9RYVQxVYqP
	 ZveaGm3Cr9VPTEj8ggp5fgRgizBYXgeq55mzaU908MVbP2bbUeyz8EDuoFJnkStzTd
	 Y4NckQFrOYxqbUt5ZomXxBilLv1oZRBVGrCRoc2/uPCgEhw0yGysoIVvspygBWHh6Q
	 Ap85NMQ2ytEHjIOpBL2Wh2U4kmglqfVTnvnRYlShSygfKx1N7hUNkcfWw7oigXFlak
	 a88LisYtJE796F2qwukcbZWMV2IVmFmjx6MdZhEG2yM/AGcmA8M5MbDbbHAJo4xwYr
	 JAI09NLdWKZxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/15] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:34:37 -0400
Message-ID: <20240329123445.3086536-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 0dfa88ac01393..576c027909f8a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -973,7 +973,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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


