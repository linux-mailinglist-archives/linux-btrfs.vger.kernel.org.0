Return-Path: <linux-btrfs+bounces-3754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE44891A67
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CEDB236E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB0158A11;
	Fri, 29 Mar 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMAdWFU7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B5158A00;
	Fri, 29 Mar 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715499; cv=none; b=JajtcpAoLmhEsK22B/o5ld6y+8R/PpqYvnUgtnwPctvPPHdNqK8PT3pKXcX2jKYChk79K2CP3VXJY9kXLzrFzqwnDTchdV55lkhmdaSN6PUstAc5f5+pEDHx5/CfANKwILRwspTDUxcWrdkhGfuud581QRGU97PLlhnMuI5B83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715499; c=relaxed/simple;
	bh=4AEv1m8xHgXU/Y8C0iHCFFw72cKVv87JcH9AXZftZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7xX9w8Wct/YUj0f+1DdV1oIGnIokj4gEPCKawipJ49hdIIoUmnAO97NlOU33WZeLBhv4DLchQ5C7cGHec+vftaruD3qWipSn81Z5A9LnBI3ZnZ1G853Fch9kznMMO/HMI6mtua3+VzCVlW+v7Tn8Gsnq9IIwNcIUPUZtX42LEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMAdWFU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D08C433C7;
	Fri, 29 Mar 2024 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715499;
	bh=4AEv1m8xHgXU/Y8C0iHCFFw72cKVv87JcH9AXZftZCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMAdWFU7FNGGcS+bF7dFdaF/Ytd8+JhPOtI6eDzO00IkCK6wOsQGIDK6UO30Mvh5B
	 pfbzB5ZMXKeaQoKbd5ZzTcUknmTSuYyiRzGAKhhQVW0ZZnU6P3IplIWB1T8fNL2uvh
	 3nV9tHQ0v50hYDuj5gqYdB+Nv8QeNNmYzQFmPwDWWikcJG/o7w2YbVgn+FOgQYXC4y
	 rjMrZF8cKH6BqzYwLtfEYEx3+jT0ZcbfIgIcbBmNatV4pSSG6daSuMcgsxIrSDk50D
	 gAz0r63zZ87SFfDX+EixCbihdHsqGOQ92Ai7/SoddAmWyYx4hpIbyd1Umbn7eJX20X
	 9/mdnroZ83MLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 47/52] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:29:17 -0400
Message-ID: <20240329122956.3083859-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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


