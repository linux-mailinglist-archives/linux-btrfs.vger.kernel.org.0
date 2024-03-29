Return-Path: <linux-btrfs+bounces-3764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8C5891B46
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A7B28E8C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C41703B6;
	Fri, 29 Mar 2024 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWXtSeOM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D01D170A37;
	Fri, 29 Mar 2024 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715673; cv=none; b=Gk/PgfXw31bCx94U8gi6WNAb/r/gsECxuzQ80sE73nhK4ujsdcCoQNyQSjWJRT5CAxWxWduY3ycI8p3S8yzLRkuNxckELpc0kOg6oajhhudAHi4Ash9auoEXWZzYC53BZyqvo+cDqCsi0Y0W+SRizFnZjlbtazZktbadj7A21ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715673; c=relaxed/simple;
	bh=zzYKDyBN459cVJ4IS4EZ9JGCOLWY+lxRX5Q5g3/uN+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuWU00gvvTxebwEriyF7TQOM7eJ58AJk1KMH2xP5Y9AoyoRl6tzqfHa0z0M0E+2BnYyL+oZLdxtS9PaRO+itZy9SkEsB8uX7yOUFU8aHAXMlv09YowZ30bia1klkT3vnzk5csaM8eeU+Nq8pvUgODTcQ1eMXNLryS/SjVwmToic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWXtSeOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B089C43390;
	Fri, 29 Mar 2024 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715673;
	bh=zzYKDyBN459cVJ4IS4EZ9JGCOLWY+lxRX5Q5g3/uN+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWXtSeOMGpFyQcH7mzptTQpkJmoTVnGLvvpXmz93V3vwzaOYzMmzDhV91QV1AqJZq
	 yukNUnRPQnnaeLbyr6BK4h4lZAoRU8lM1F3o0apSG43B9TUuQ0hp0gTi07W5NQ1NY5
	 MRVSFJIOWmlK4y8iFQ3XUfhCx5AWi+lFZF42pb8b+gux+N/0cJKxzbgKizp9IQCJV9
	 5pBGVmA/uV2AjO4YNzc22/we/pPJ+cZGF06A4+XnbgO7OaH0ZT3pOMAUuv9/8UqbjA
	 nVtMq99KHqqaeACOKq1nc52R460R6PRyGnFBxKp/EqsSWaoQXPboHkV+Y055WzpjCl
	 xjqm/mQOS570A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/17] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Fri, 29 Mar 2024 08:33:54 -0400
Message-ID: <20240329123405.3086155-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
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


