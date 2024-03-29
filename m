Return-Path: <linux-btrfs+bounces-3778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B22891D4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2541C27384
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7AF1D2AA7;
	Fri, 29 Mar 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peNvYnyY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E771D2A82;
	Fri, 29 Mar 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716324; cv=none; b=W9BpOQl47WlWXF7tAyRc328nv1IZPqqWm8GI9iOvtPDCjhHLAyqKAbAf1Qz7y5m8HIPwCgXKeTB9wxsdE/tDDdGLr5iFsiYwaaGMXuGao2OL0wgAtGhICuxH90StWfg9S0oZrm10duUKcGKd2zUmUGtOJlnVvHEMSl29+xk+/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716324; c=relaxed/simple;
	bh=4AEv1m8xHgXU/Y8C0iHCFFw72cKVv87JcH9AXZftZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lS8Yui2tMQgsJodzK1S5jVq4rIyfYABMDEPRbzBAzZJCu6XO6szucWabqnrdFu5Ci0QwxmW00Tc4mjfNTP2aN+zTltYU+q3pgNMIi/z1HsYZrE/yvNlg5v2jrCE5aCLADetmuXK/PzMRuJhdOFZX5swZ3uedQGhCSd6PuH3MnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peNvYnyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EE2C433C7;
	Fri, 29 Mar 2024 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716323;
	bh=4AEv1m8xHgXU/Y8C0iHCFFw72cKVv87JcH9AXZftZCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=peNvYnyYSdkJXuNOJ0zOnXwa+tDM2Tj5jFaH3lIUT1Pjh9vWsk58Tfap6UnZqQM4O
	 Htd2qn7kX2Wf4VzP9XoFcNa/glIplr8MxmR6o8DpXvY5dK2nH0gSwGbSofg1McBQ4v
	 BbA81QLpUwvpV64Ah9yUjSxahh7BYZCYztNdgrbxPmzdVU5GovETLRixAktoDwbjh9
	 36MKBdDarOmHjmwxmF3S2PKNvGaFmp5Wd1Fo7EzRomp9VTuqoGLLbf7oFDuCeZcSG2
	 wMlOP2T7UU7ukXAw+kKyMWzSc3QfxD51i/YsZyFOUMU+xTOUiXmC0wqgrkxSimqSJC
	 Gyubl3y2QSxiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 63/75] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:42:44 -0400
Message-ID: <20240329124330.3089520-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 6a1102954a0ab..b430e03260fbf 100644
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


