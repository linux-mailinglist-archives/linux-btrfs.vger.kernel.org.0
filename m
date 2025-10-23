Return-Path: <linux-btrfs+bounces-18202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7FC02489
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90751AA2888
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CF8288C81;
	Thu, 23 Oct 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RilcbzSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32792882D3
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235220; cv=none; b=iTIFHlpBmLayKmROdmilVwZxMwDk9koOLXmDlRVoTL+ktthS9k7R7jqbyEbVrk8g0o48UXAYnjKt7yT5Aps/m74Lg+LCQZoXTnR1oEtzyhIr1fQXOmnbqQvIFjeFuUZpw9GUXM1JSR+3BN4Q85rSK5RLjOdEkQIohNl0qDSvA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235220; c=relaxed/simple;
	bh=YvKoyfXB9GlWfLu8L+QaIm8mCMp0+RJrl9kP0QCx/04=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRmCYL9QeVZFopNW5xmWxTlebob25BNtN7K5hCltAs5ManPLcAoob6Yyu2eggiQMYxnx1m69H9NwvifFvtNG26QT4BCJGM4SnwTpufiZ15OnS7kyXjSFRac/tL3sHrjnfivsEDMXlN3i5e6/pFkcVox/n/8kmD3wXF+IsgezydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RilcbzSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C43DC4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235219;
	bh=YvKoyfXB9GlWfLu8L+QaIm8mCMp0+RJrl9kP0QCx/04=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RilcbzSdWFa3XBkWkw1P6NvVMgCaYHRQ4V5fiviaLVBXhIMXyzG5/57+kDWEhttsy
	 Q7THFdlZkaBEB3OVY6AxxEAXULaSPjkli3Nw6om4KJ56+NrQ43NDeLrYlkZZP0L6HR
	 McBDBIIRKnFv1rcKZnnRK9bW6Ko3HkI1Po5fo8nUq6ItocQiB7xeLoYVuG4xLx7DF6
	 Xx8pqq+WsX2rYPoraKjt12DZCj2ExegqWw98KdeykOmx6s0ENwNB7o7IHv7ziYSuWa
	 dW+tGfdkw3ivtT2OHocZEQ1tIiCk1vsz8jc/hhK7VhM7k1U77p/GLKN2zX35C02/d1
	 r9eACStpDbMTg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/28] btrfs: reduce space_info critical section in btrfs_chunk_alloc()
Date: Thu, 23 Oct 2025 16:59:48 +0100
Message-ID: <771ac42e62acec5b34b4169d2c99b37513145e4f.1761234581.git.fdmanana@suse.com>
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

There's no need to update local variables while holding the space_info's
spinlock, since the update isn't using anything from the space_info. So
move these updates outside the critical section to shorten it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ec1e4fc0cd51..ebd4c514c2c8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4191,11 +4191,11 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 		should_alloc = should_alloc_chunk(fs_info, space_info, force);
 		if (space_info->full) {
 			/* No more free physical space */
+			spin_unlock(&space_info->lock);
 			if (should_alloc)
 				ret = -ENOSPC;
 			else
 				ret = 0;
-			spin_unlock(&space_info->lock);
 			return ret;
 		} else if (!should_alloc) {
 			spin_unlock(&space_info->lock);
@@ -4207,16 +4207,16 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
 			 * recheck if we should continue with our allocation
 			 * attempt.
 			 */
+			spin_unlock(&space_info->lock);
 			wait_for_alloc = true;
 			force = CHUNK_ALLOC_NO_FORCE;
-			spin_unlock(&space_info->lock);
 			mutex_lock(&fs_info->chunk_mutex);
 			mutex_unlock(&fs_info->chunk_mutex);
 		} else {
 			/* Proceed with allocation */
 			space_info->chunk_alloc = true;
-			wait_for_alloc = false;
 			spin_unlock(&space_info->lock);
+			wait_for_alloc = false;
 		}
 
 		cond_resched();
-- 
2.47.2


