Return-Path: <linux-btrfs+bounces-3750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4268919A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C180A1C24DC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 12:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B314A601;
	Fri, 29 Mar 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z49BDlqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BB14A4D8;
	Fri, 29 Mar 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715347; cv=none; b=SAPVpN+2Qi3O1BsUz6pC2jxy81kB5BowCWcO7CqNgFmjCjPjK0M6fzlV2TttDTow0ZVeKJjHTlyy+vkrghLKx+ygPoHaZxTZPN3k/SJCBORGUNE+qJycpVsiN2/KdmJmrsInniy8Q00jugdf3Z1zCMTFbzkJk4z9OQ7Scb9KFQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715347; c=relaxed/simple;
	bh=T07ykANRiSqZ127sWwnwShI1QgsOuD8uUzy1UKgsxBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDwNxdnJRRzG6UHJxNs1u1gg7L/4qcxtMf/XHCKCB1afMhT3szjXLfsikg/Pyn54F7U+zWOcY1M4dOjCG0e1je7ltv/CYaK4K+eS1tkUnskFZIqbpi2RQz2oRrlSSjqEeq+ENMzLjqIA4Fd+IfwVDEWFZREvorJwND3JugVxYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z49BDlqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF623C433F1;
	Fri, 29 Mar 2024 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715346;
	bh=T07ykANRiSqZ127sWwnwShI1QgsOuD8uUzy1UKgsxBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z49BDlqfpNKoc2g8/BkVtw+OMfm8Hqlol9hUQ4s1S0QzKc2cCx2zca+H2mc1sjggD
	 NQSeV/hVOMTdfzijxMSzqBuHRy6GbqKnw6oezPEBVaYP8lMycJ0awmS3lNLxpNmN2K
	 iOhjlXiR8vsMKChY3r1vYq0N5aVEh+dZMW7+DMNlm1gXB5L8I2tYnio/yIg15ffo2B
	 H5a25ltslyqptS2+wOZvcs5+RRNgFQWcSQO0ue/apa57VyLoEgFQws96tjB8DoHC2x
	 9Egl76avoueH+fmX3MsD7UpRlLQnD7UjMTPMHpZDAM1w7PXGKJMKwJLKICp/QTkDoR
	 kKdDZsl6V9mjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 62/68] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:25:58 -0400
Message-ID: <20240329122652.3082296-62-sashal@kernel.org>
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
index e48a063ef0851..e9bafc73c621e 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1070,7 +1070,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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


