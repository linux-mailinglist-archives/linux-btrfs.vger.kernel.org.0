Return-Path: <linux-btrfs+bounces-10244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F39ECF4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BB0169899
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D661C1F27;
	Wed, 11 Dec 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clqktjK4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728891B6D0D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929516; cv=none; b=tSoy2AdWX2XafBh3CB//x46wJQl/qzUrrT37phvP6qdVU+3VzGGdTmyP2IF1iZx/gRqIQhlZ8Ck6fRlShvpwvODo0GrLzVbX6YqMIM/5+yTGPvdsEmnm/DV7vTDkEasq6y2Niy2Ztt+L5KPIossTzopqQmLOH1oumOrBzTHrQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929516; c=relaxed/simple;
	bh=gcJlCl3eYEkScuFHlQMq13/7I4cWeKB5TpS20bMssO8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QsrEXKNxUAAo+UhkdV5BuEm4SE/Si20hD2CJo0s0kQE+eqVc0qo5v/rdfSEyaF7/+oX3hErq4J7IJ+ypzfwyruZLWepW9rvCuzwA/Gsn6A0CXgFfsDGM37RNh5CeSLL1i4unchJ18P2z1qxpKYfXjp01kYV5ydQT9nRYkCfzyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clqktjK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDFBC4CED7
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929516;
	bh=gcJlCl3eYEkScuFHlQMq13/7I4cWeKB5TpS20bMssO8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=clqktjK4Vm2tqJLP96O4Z/7Yx0vm+UV10X3mwQishiTPM4k2q6e2dXqNxurLEZNts
	 rFp9ojXMBvBGM7oDDsSAU2r7HJs7nS9eToMdNRE2Yg0GLPHNtPM8Niks3vLuF8v5MD
	 3cNKr9Ih5rplRcgS0CGrGny9ti2Ii3CmTg4vnZB9/nehR88mO1TpXsMyc6J3+9rmKY
	 XbEs3FG6uBd5XwQjlGMPUACPI3hIaJeRi50l0UQEzBnaHD/ih2qkN9DjAeugUomCer
	 K+IS9bkMplcwTzSNWZ7QJQs6hC2MCe5v1fivNPfGTT8DxUOGaKuDFnOXPRfUOmrTPM
	 vPIXzR+Pq7+xQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/11] btrfs: avoid monopolizing a core when activating a swap file
Date: Wed, 11 Dec 2024 15:05:01 +0000
Message-Id: <c37ea7a8de12e996091ba295b2f201fbe680c96c.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During swap activation we iterate over the extents of a file and we can
have many thounsands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5edc151c640d..283199d11642 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10078,6 +10078,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			ret = -EINTR;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


