Return-Path: <linux-btrfs+bounces-14413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B4ACC99F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 16:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72DA1895372
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD023BCFA;
	Tue,  3 Jun 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbvkyDtK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913C23AE87
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962234; cv=none; b=hXHYjIN86ik2/tzC6Tq5XkJWmSLS6aGk6x62U7m9xXfk7GqbvZD5wvAWy1yEPexWcsXi52fGp/G1B+9HKZ7xU67o6kbSjx0ak5YiUWPiIMM0YcKNWEPYaGS2P4omsR//ALl4MM9XEemBhMVS0FXcqX6WsoLBJUp/AOzvnHbObJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962234; c=relaxed/simple;
	bh=HTfXuW2gTq8Y1JivEFkSbyX8RcGNtDTph4faBlboF6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czakc4TzRavMMFll4ascLt7L/jc2Yxguk2BAw8JxVjR+NoJ9vQZLzT0RV+798OMJIGM5JQCOPu7lkuYCKeoKhXCb2lSEiFDpmRrkEE2r2d8zzkMa/D3QZhQZxZmqEoXZBSFOJ1KxOND/3L4dguAptZRVaTGYR6JyppVQD3eteM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbvkyDtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF05C4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962234;
	bh=HTfXuW2gTq8Y1JivEFkSbyX8RcGNtDTph4faBlboF6Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WbvkyDtKDc9DW+HF4QwUWqjobUdDgZGpedhPSi30uc/k25T1GmHQpooABEWih60va
	 iI/YFN2tdz8BRgegBG+K0Egu0G0AhrEXwXoBBIOXQPUsUKlcjh8SmzDrtmHQMwpqno
	 D9kSGsEDGJVxwb9Sp5gx7TY8J7YIxvm1ovEg8jah9WZsP0QTyfy6aEr+zOK/jtqUgF
	 qpG7rQlr8Xtn8AkKcaeshsWKle+tXbMUrfjEt90wiNcePobfmj4cmi9JZxbP27hYih
	 FMJBCpiMhuy3iiHc2jEfKdQEbQqoDxp8Ot2MyEoidzaFnmPn1vSUz4VQMfnmHFDTLq
	 CrKTWI7tUX4Vw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: add comment for optimization in free_extent_buffer()
Date: Tue,  3 Jun 2025 15:50:26 +0100
Message-ID: <29c55c54e59fd8bcd6b9b2691918edd84abdd132.1748962110.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748962110.git.fdmanana@suse.com>
References: <cover.1748962110.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's this special atomic compare and exchange logic which serves to
avoid locking the extent buffers refs_lock spinlock and therefore reduce
lock contention, so add a comment to make it more obvious.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a7713be7ae87..022c67c01689 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3494,6 +3494,7 @@ void free_extent_buffer(struct extent_buffer *eb)
 			break;
 		}
 
+		/* Optimization to avoid locking eb->refs_lock. */
 		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}
-- 
2.47.2


