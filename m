Return-Path: <linux-btrfs+bounces-13884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A2CAB363F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C653A2B38
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDDA256C82;
	Mon, 12 May 2025 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5lBIJkW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFA1A315A
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050674; cv=none; b=BuWrUw5Buv7KUOAJBcZUK675rEwkqw+DUFEBmgA88sFymZPM/2z5F70gclfli23SYJYQqL1qBA3GLdcCCGqNvF5VbXIdzUrXeyQn+RuWsDcpMYPY+ZfQF4yZbIBM+MYT2oK3OoQP1JUKBGy/gI07YqnZQ5rEgm2eqKfQq4gdmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050674; c=relaxed/simple;
	bh=3c1iGTnkMw+RAEF2fYLKZR5uwQJ0XX0VyrXEs9EQziE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YmuAVVSryNynSkoVcAaHOiE2dlYvmLcsUh/DZVpL+yxfM8aXFzDHoMyP2o3x6TPIq51sUEWpCuZVk2gX+Kz8Sy6Rhce5P4WxfbL8iu17LiqJxkKPXaWbWDex6k2p0O5F0Y5TUzlka+3Bq5IBPoFmZ3f8/vF0RO5dTdmV6h7785A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5lBIJkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C5EC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747050673;
	bh=3c1iGTnkMw+RAEF2fYLKZR5uwQJ0XX0VyrXEs9EQziE=;
	h=From:To:Subject:Date:From;
	b=t5lBIJkWeqBetxJ2+bzDpeXP30ApaOEQ/vfTqszLyaZXWs+nAz6+GXu0VGYvLhK0u
	 xmcf2OV+LzCM36U/zeVKZ6uDXIEY/Oa934vq6IN8J5IEfYE/vL4MTm2vrKKPeqnGiR
	 zMco2P9/dl3REd5Xbx30Cee3nGdZTbggPAN9zX+Oyw3UexcnaknoiFdmpcpFL+xf8V
	 98Of+Wuzz6DVL8NNf55vDtZLnvKRiepPdNCbS0RFDWKigeEQDj8S5lgTqzjlBdsxSa
	 BPpd1nMSOn2w9296IFQHihg1YTLSTp8QU+FuEe4pEJ6J4cG4v4MV+LDruQYMZ6gpQ0
	 IRNUflx+pGzbA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix harmless race getting delayed ref head count when running delayed refs
Date: Mon, 12 May 2025 12:51:06 +0100
Message-Id: <13e40ba1be5f87e2b79275f58f4defe11e6bd62d.1747050634.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running delayed references we are reading the number of ready delayed
ref heads without taking any lock which can make KCSAN report a race since
we can have concurrent tasks updating that number, such as for example
when freeing a tree block which will end up decrementing that counter or
when adding a new delayed ref while COWing a tree block which will
increment that counter.

This is a harmless race since running one more or one less delayed ref
head doesn't result in any problem, in the critical section of a
transaction commit we always run any remaining delayed refs and at that
point no one can create more.

So fix this harmless race by annotating the read with data_race().

Reported-by: cen zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAFRLqsUCLMz0hY-GaPj1Z=fhkgRHjxVXHZ8kz0PvkFN0b=8L2Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 14589d1a5f49..264bbe3cf27e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2006,7 +2006,12 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	if (min_bytes == 0) {
-		max_count = delayed_refs->num_heads_ready;
+		/*
+		 * We may be subject to a harmless race if some task is
+		 * concurrently adding or removing a delayed ref, so silence
+		 * KCSAN and similar tools.
+		 */
+		max_count = data_race(delayed_refs->num_heads_ready);
 		min_bytes = U64_MAX;
 	}
 
-- 
2.47.2


