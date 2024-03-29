Return-Path: <linux-btrfs+bounces-3761-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BD891B07
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656581C26254
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72416ABCE;
	Fri, 29 Mar 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI3hMIAg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAD16A9AE;
	Fri, 29 Mar 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715631; cv=none; b=lGL7zxCfC8SuV4YaOUZXBD+hP0eDdc4c4zkOoVtIk0+Od4BlNKW1g8hhfnqV0qvNdmdObeJUDntceB/dfFY0311dEpH5FqpwQtdR9mJztcBPbv+YKX7vbR52b/7a0ypghHZJDQ5/alCL6fZVKXW1/VCZ+KaprvRrXLFNPqv1T2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715631; c=relaxed/simple;
	bh=XsvXVhLLWUYugHIGnmfSQTbg5lFxG0Xy6hMGJ6e+2NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gShfVCzHTxckDJmFEhV8OXGkWFEN3dUqIrJBNpGPeAvVsStXSJJgThwhOMORuf6AfAs3rTb0KhDL83p4gbwt8giQokaQ+l6AR5EbztB+1HEH4/2NcHbJ+R7LVj74h2m4W7rBRy0+m+mZdHf7+dR0L87cpg9QVOh9QIVxMJeM35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI3hMIAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E775C43394;
	Fri, 29 Mar 2024 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715631;
	bh=XsvXVhLLWUYugHIGnmfSQTbg5lFxG0Xy6hMGJ6e+2NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fI3hMIAg8dJCc7rYKIQgADw22e8kjqVApgo+Z6S44/8LTxldeHuZiUbAIpOvwn9Z0
	 WyWbca/e9iZlXCmoJX3U/T0iDRfOTunRzjDzFE0Hb40XJ8TZKiBDirbjtU98WlNluH
	 vfqot4vWAhLxPQxuSHT0eHPoP1boWDSBNbA8kZItxE8Kb0oCg8+mGSAk/kmZLF/TrW
	 qLU6A4VWlLHqEwfCJx6a6sJbZ4QQAnspetzYHCdM6ZX0ml+ECabkT93OiI0nOZ6RHN
	 5PpAXDd8HrEL1jl6IkDdaQgZs4XDQMYCU8JrQllpOhR0/a8OAqEmdR5a1T7VyJY7Vo
	 VLkgEbcynzFUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 18/20] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:33:06 -0400
Message-ID: <20240329123316.3085691-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
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


