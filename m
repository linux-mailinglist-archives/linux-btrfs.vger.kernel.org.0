Return-Path: <linux-btrfs+bounces-3791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20A891EDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF5C1F2B77C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5711B9F52;
	Fri, 29 Mar 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emOzkm9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B11B9A3A;
	Fri, 29 Mar 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716646; cv=none; b=TWiZXI2ZuFVGS58trVgS5rfSYcHlZtjS+m0IViwqY+EJAQcHuicxjo8++/pR6BHQy7MrTi68V0ESJZ99bE1X9FgZAsvgNAHtFxgXnwD2PKV4O8kz4Z0O7LYv9i3RXyVZZW7c6EuQROiQUiu6elvq1MSDm0leYBPYmL/pxNWzuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716646; c=relaxed/simple;
	bh=Q3lRiFBJnaNpsMCNua1ttOlooq+w4ptJYkDpadxjCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnAOKAx9eqmYbZP4OCvHpntGp99vUHqhArZvzqIsxIQDv92rqA5vB7fZ8RYH1jJn9NCELQRMHhz+BVp9PsAca3HWdULxmVZu/G8aos8KauwoxjHVXGyHT3NW6p8ue6fWMgf3p1Lp/uqBHdOXapRn0QeXjPXqM/SobHNOASuGEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emOzkm9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C887C433A6;
	Fri, 29 Mar 2024 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716645;
	bh=Q3lRiFBJnaNpsMCNua1ttOlooq+w4ptJYkDpadxjCVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emOzkm9M9Lxrfi95th+5NYnJ4hcGHPaosLqo6gLaWzsov/TMo+H7vPzHF0/Teh7uX
	 5OjJrYu8vBeBhTK/fPRFrjZbxZg8Hn3ZxEoYHCumrTcvWDWXkc1IXb1z2ugDHMJrM1
	 rpQRY1FU5DvXM2aax/pyoahsgpM3Ny5uwojv2OALH35elAv19auQuotTUQkIJU5wgi
	 +oivewKQ2lm5As5w5zfWZrDNvER8ZWHmKEdK8PTTGGr3lF2OQ696PbH+esvz4dezsJ
	 RFwYkwKx9ocUUQDefgwFXRIdLawbjCHuZ/w8j+s0k3WpXuLa+h/HDC1lMjxKpNGywD
	 k05p3VKFjDfKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/23] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:49:53 -0400
Message-ID: <20240329125009.3093845-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
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


