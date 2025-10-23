Return-Path: <linux-btrfs+bounces-18212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6DC024A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC2C3A89F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A546274650;
	Thu, 23 Oct 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSgchxuu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EE29B76F
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235229; cv=none; b=RsaXO6W4FgtBk0Mc5gQQ0s2Kx0DkvM2siOVna4ljVitW03+exPjBTjD+VHVz2CDtTPAP+fvmr16eRi9PN6T0jxi2UMRuHgoTJ0o5dyxL+5pwAzzbOfFTC2qXZ9zvUaYDcLzUKRJnXJ0nm0qoSyXjJb7xfoEMAt8CfkFqPp6dUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235229; c=relaxed/simple;
	bh=MRXDi2ZsDFHnVIXjpliu7akYOOr/vVBsBdAo3IyT3WU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nth8aP5QyyH9CJbKSurN2TAmiiKt/ITvKsD7GGGV1kZnyClFYHgHoR2F3lmJ9dEKP5LFV2knrD74ANS4KK/x2BKe7+pNt/zJP9ps5UNbiA8Cm7e4t5cVS+p87MXYQSO5gAkJf2GSO6cGmY5OOvXZq+kplJEQ8MD3RBsn8wnB220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSgchxuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4739C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235229;
	bh=MRXDi2ZsDFHnVIXjpliu7akYOOr/vVBsBdAo3IyT3WU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XSgchxuuBi3pcx37KL4AwCybSYOeuXyWtQcKXEzr+MFOXyfmnLhGdMV1dvTSUztkY
	 NbrHrfYPTbxqLbw7zXzHrOFYkTM0gbDlXOUPZKqxE0GIHuvdbB1Mo/7E+QeC1g9Fot
	 QvO8N+H6NDmOq/6uv8UYJsF6jcgHuVQIYGTOYiwoThCwaE9lTHHb9oDkdUn0f0GlRC
	 68sBhzwMQwG52lNR7UbdCCzlSalrR+Lz5c8ZU8Jc/02ot9Sh26jQ7EphbC27SOxNLF
	 pO7t4VpIYEj6DewSRHow6JdkUlnnLEkgRrwVHxTOZz/OTe0WOJX5UocZ2PSe9xWDeA
	 Lx/8RtfmUi5IQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 25/28] btrfs: add data_race() in btrfs_account_ro_block_groups_free_space()
Date: Thu, 23 Oct 2025 16:59:58 +0100
Message-ID: <1b139da4d48b3ef61c592122b44153b55fbdc5f0.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Surround the intentional empty list check with the data_race() annotation
so that tools like KCSAN don't report a data race. The race is intentional
as it's harmless and we want to avoid lock contention of the space_info
since its lock is heavily used (space reservation, space flushing, extent
allocation and deallocation, etc, etc).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index edeb46f1aa33..be58f702cc61 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1948,7 +1948,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 	int factor;
 
 	/* It's df, we don't care if it's racy */
-	if (list_empty(&sinfo->ro_bgs))
+	if (data_race(list_empty(&sinfo->ro_bgs)))
 		return 0;
 
 	spin_lock(&sinfo->lock);
-- 
2.47.2


