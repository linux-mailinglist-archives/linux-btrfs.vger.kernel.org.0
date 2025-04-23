Return-Path: <linux-btrfs+bounces-13298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B9A98CB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC95441B42
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF12797A1;
	Wed, 23 Apr 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxe9a8eO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B18155316
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418008; cv=none; b=GTBMPcp/sxCUjT5xieH/q/N/gTXtUMldw9ZwHembF5eZ5arO2Ufw4dn1yOzGLzLGjgqIGIaCf2d1MLZtxKWrk1sFZv3RIUAVGFuXi1eb15DCUzaRdJp/ALmBbnawGpNqHlH6SSisp+XsqInmM7iqhD5gTHHFnsWP9+B5Tm07jUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418008; c=relaxed/simple;
	bh=XJ//GUvFDpptVUrl/QLGT0w1trXaUdYY2pTCv0v/Q7Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbPke90gtZwLmBb55UJBLzsBIB4ozOH1oiT5ng0l+EVAG3wuqoR7LhA/8SlY7sA9ifhzIL9qPZxaIWfLSU12ppryCsR0Sr6jFcq/BpN30fWjNBPvf4SbYf4yugH9TRicTNcm6RYc+a8BlZTNX3CVK2HIrPRLMMC9c5pwyu1gdPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxe9a8eO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D54C4CEEB
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418008;
	bh=XJ//GUvFDpptVUrl/QLGT0w1trXaUdYY2pTCv0v/Q7Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pxe9a8eOaF5cbilmWcRi/k/asTtY12mVRyIs6n9sUIlPckxaDgNDzLy7qE3GvEaeM
	 +GPEA5Mi6BdYhwNKxIFQGzg9Zemcv16WZb6yENCC3uCd2CA9ferwttWn8LOd4sM5wD
	 IMZPXNo3vyXru20FUYm+F1ruzv/1t6L9DZNOgzF2Ygs+CxDNwbqz7/yLbpotIMBNrg
	 jfwXaAXmD5I9GG3Ry1PXdocqzn9ZUyb6AGSCLZY4qbfYUtmg7L/nb6m6Na1OoUxfnk
	 k7cwqy7m/cTtTtYQOhVLnVRq3TrXU8o5Y+lvAQCRDWtppN2IKVAPGGXnIK5SF889vN
	 0XIKh/2IG6rUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/22] btrfs: exit after state split error at btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:42 +0100
Message-Id: <9c4f62cd7727944bac3c64892c0419968f7f1a51.1745401627.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If split_state() returned an error we call extent_io_tree_panic() which
will trigger a BUG() call. However if CONFIG_BUG is disabled, which is an
uncommon and exotic scenario, then we fallthrough and hit a use after free
when calling clear_state_bit() since the extent state record which the
local variable 'prealloc' points to was freed by split_state().

So jump to the label 'out' after calling extent_io_tree_panic() and set
the 'prealloc' pointer to NULL since split_state() has already freed it
when it hit an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index dc8cd908a383..b3811bbbd53b 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -712,8 +712,11 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		if (!prealloc)
 			goto search_again;
 		err = split_state(tree, state, prealloc, end + 1);
-		if (err)
+		if (err) {
 			extent_io_tree_panic(tree, state, "split", err);
+			prealloc = NULL;
+			goto out;
+		}
 
 		if (wake)
 			wake_up(&state->wq);
-- 
2.47.2


