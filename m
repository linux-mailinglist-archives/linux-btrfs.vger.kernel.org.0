Return-Path: <linux-btrfs+bounces-3774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CBF891C94
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50944289B23
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3FE18BC21;
	Fri, 29 Mar 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oz0qfMR1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F718B5FC;
	Fri, 29 Mar 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716149; cv=none; b=FNU2quHqxW7Ue5/XKE6iKn+eJ54rzEZwoa8PPrs1rbkg8x5OQ8QqoYq5xov4xkjNrXm1TT0cxRYd9l/ZMIqIEQFwOccTdge65rVr2YqCgP7t13VaGoGMiJAvZ1d7eNCTNhauRJuFymBzOdiAUw4go8AsYaYbUkI7eV8W3LuENlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716149; c=relaxed/simple;
	bh=T07ykANRiSqZ127sWwnwShI1QgsOuD8uUzy1UKgsxBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUToFUpKwLeaHDutuaWFT4l4Xy43ihi+BBDMyNTUTEDM6+sMbkhE9RJFuj4QRh5oaeyA3gmteIpzq7gENoxAs9zD7pp0CMWHBYcYTgBHgTniNhjO39LxOvynlMnBVXNUhR1O2rz6jr4LQCC0nlVYkDu7rL3UVQZgMm3kQhdEnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oz0qfMR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED49C433C7;
	Fri, 29 Mar 2024 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716148;
	bh=T07ykANRiSqZ127sWwnwShI1QgsOuD8uUzy1UKgsxBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz0qfMR1XemVm7Mx2hTw03ANnYjjJoiLIOBgVSktFEMg0FPWZiFPTUOm0PIg/vBkJ
	 /wXKDt6CbWTBBCmLlmqBjJG5p5/BKTQr8EGXgBgHljlrCURLyAYO0VKL2E3ikcYOfA
	 B/L5lo7b/PqzISrQvsAWxG4HMhvkUSG/uTaRi26xfzAeYt3Umi5uOUdNqsGyNjboPB
	 SQEIMQypiPba6DeYd/RK25cJgRwYL9g5Aw8lGm4eSfiHJdKkrE7SSOoszqOn1IGjVW
	 Y0omEQr2PlKP2CjtURE0EAt2L7Xuf89loE5L/1ydR3rKRenApxa5CjsLIu4zDfolSt
	 PPhk2n0dgm62A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 83/98] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:37:54 -0400
Message-ID: <20240329123919.3087149-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
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


