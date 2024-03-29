Return-Path: <linux-btrfs+bounces-3788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A745F891E9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AC5288866
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AFE16DD32;
	Fri, 29 Mar 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fudjKDFv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB016DD16;
	Fri, 29 Mar 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716586; cv=none; b=omZOWP6AKqwFeYW0tWiEmF+n2v1EagxyqfrzcZPYiFHiXTEEcPMViqKwY7O95SwLirzIa6VLi90UPQr7GGmwNljr7KMT+pynujy6HfNZVueqoVIyfW0UbsFjgfOWqqzJ6LMNo8z3rtaGc7s6LN7T412Q7Rr58V21j/A44bsVFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716586; c=relaxed/simple;
	bh=zzYKDyBN459cVJ4IS4EZ9JGCOLWY+lxRX5Q5g3/uN+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trX6M2HwY5IKrCC227RWByRbzIvP3DQV4QEGm5eWOlH6rHtpFdq4jljxcmHr6pU0DulY8hA6vQQptp2ftv809tfFxh8GnfbcaX9cHn68N1R+X7mbiuvPiKQC92MRE7zJ8fzO0m6f29nFqcYNEX8XsmE6Aa1JeYMdsgE7CH2VjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fudjKDFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925DDC43390;
	Fri, 29 Mar 2024 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716586;
	bh=zzYKDyBN459cVJ4IS4EZ9JGCOLWY+lxRX5Q5g3/uN+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fudjKDFvWPgzkbOu+cKijiE/ZTjb3bhXCOZDs566jMO8q++jF6gnqr7F0Hk1h0kNl
	 Ug6a7IZ66b54UQ9mYruuQ6Cy0wPFb8uT6QJ0xKX55osDh57C3NVTJabDwlIn+ZwEG6
	 A2qnopQqkO9azPGQ+y6FAg++CG8lXGLs4V2VhcTK8sR9QqqVkPhoAVKY7sJWxBCjfM
	 0+DIT9w+mdJ2Ec0z8C6d8AnR0IlnLoaUDD4lVYvX9XwkDAZHY+a3jukwpRZ0tKX+g2
	 60fTFWWEMBRkd+DxfJjME0X1RHtPD4YFuVk56TgGwx6GnpBpUkc7UJzKOHF3dqJF8N
	 IjOdRnFcEHsBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/31] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:48:42 -0400
Message-ID: <20240329124903.3093161-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124903.3093161-1-sashal@kernel.org>
References: <20240329124903.3093161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 0b04adfd4a4a4..0519a3557697a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -966,7 +966,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
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


