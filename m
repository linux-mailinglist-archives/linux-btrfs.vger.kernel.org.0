Return-Path: <linux-btrfs+bounces-3770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96D891B9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D5B2938BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F21769FA;
	Fri, 29 Mar 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk7MvLHO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870BE17655D;
	Fri, 29 Mar 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715740; cv=none; b=ZaiHOc8MUUlVCgsdySIsg4Pecq9JO1Pj5+ke5CHf/R+s7kH3ER8+uhwtjovPw7kmsfeyMLnqnYVdyLUVIKyWXZNmmrJUu1VSczft1eJqt1SDZeMVtzNPBbBROtjFaksMSeJ6mJe0YHX7NRqSgzlIhi2+eR9HKh2UoQ4m1IkJWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715740; c=relaxed/simple;
	bh=GCCcXe3ICsPyaH8GbioAnxtzD+uP1Z9fAotkEf9lyHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9KMoY/ExyFPAtkUXkqtsGzDiSAxLqZwRo2I0FW+zAnLEapVk7dWblfJRn2Q/YzeuNyCtcvFAn4L+K9mzIGxoPyjwi1NOqXuiNvXEMOh4HoHYCbDw03g5CseAi9ntjeYPytGTF92kmmvT+M2ZI5nvxgZN/Rp36ikSkyYJbr/sHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk7MvLHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7C9C43390;
	Fri, 29 Mar 2024 12:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715740;
	bh=GCCcXe3ICsPyaH8GbioAnxtzD+uP1Z9fAotkEf9lyHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xk7MvLHOpFuCb1ue0EtMNZwZ4PQTKSbFAixPvSoKDSoEabdXBAJfe9ox5/vgoDMB1
	 NoEV7Ca+vKIvm2naNI42Zicg/6BsNO8zo01lA3Odvek4jAorKdMIFE3zAsmkKFbmC0
	 ZuUDn26bo/XmpxaR5rQyEwGfyYfIklIvIBbsP+157hRLyqOFwBS5TEVaV+oESc+6a5
	 Dd3LIT1HEXSRYlBfNLsO77bcU0ErSJYL7rnGblZ0inyA59yXUBzJnwcP/HmaU3zlLK
	 6TxRG0YxeH+2+I4BH5+WdsPBGf8zE7fU4uuSFi2vMYuaAuX7KohxmguQT4vkvXz75G
	 p6FsAROAxgk3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/11] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:35:16 -0400
Message-ID: <20240329123522.3086878-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123522.3086878-1-sashal@kernel.org>
References: <20240329123522.3086878-1-sashal@kernel.org>
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


