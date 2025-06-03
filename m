Return-Path: <linux-btrfs+bounces-14420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617AEACCD6A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55B4188DD72
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88D202F79;
	Tue,  3 Jun 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAEp2zBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733DA748F
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976992; cv=none; b=YDQJuU9tyebuecsh8HPSIB/hYqxk4TumGTrtN6ldZQT3ER4ZNinw+vTLSaqbFiIuJbl3cFmLDRGD8EOTsJWiBLKPctq68GpfuGlJwCUoldmPQezYsBaY/PaXJAisBT+t3/Luj9KD9vzAoPUJLH8/0XRfVJ88HMJGPd8k/YcNmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976992; c=relaxed/simple;
	bh=e0NVyulTOg9mArJ3SZVNms+CzrskRFUhlywCUfU7Rvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lq2EqXgZxdYe21j6gc5Pa1BRC8piWRsNoPFBgN5gb0+NSm1YQ0LHKgV+u2ZeDsB/nZ0RpephCV+XdnmDKuYL73QbUx2/CIfWl+XBMrusBZB9UcCdwwnrJLWmyGVSRvoY+qTLTHL2OSI47nLQLqeKJoxSsFBRo14G+IU0E/qPUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAEp2zBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50902C4CEED
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748976991;
	bh=e0NVyulTOg9mArJ3SZVNms+CzrskRFUhlywCUfU7Rvo=;
	h=From:To:Subject:Date:From;
	b=QAEp2zBKZOl/qsIaU4AKToN/ZDK+z4Vc3GEHVswObXOGp2mhNqw5gkemak0F8Tkqz
	 /PTqTTtWuxehpyIMQ2RSETEJqB8E58BliIRjk/vpxVsKobNjWuAm43exlhAetEXQRT
	 Mf6boUwDFN1haTmOrL61AODyusFKwwotlFJey/3SFzly6R18/E443A9IzTBKu/Oqn+
	 P/uFy9oq7QfacIL5q92cXWz0RHqmdrZPq8Ci3iMBMQVnneejlS+BxyvtpYR36Dn35y
	 apF9FEy+jYxNnVh3OJHaS2rdb19SWrSuHdwLxzGrZyQtQ9UdpYHpS2x88i1BELA9Ck
	 iTpkmbYD/ASPw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix double unlock of buffer_tree xarray when releasing subpage eb
Date: Tue,  3 Jun 2025 19:56:28 +0100
Message-ID: <0ed0d97779576c626a953c5d2ce23ede647e160a.1748976868.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we break out of the loop because an extent buffer doesn't have the bit
EXTENT_BUFFER_TREE_REF set, we end up unlocking the xarray twice, once
before we tested for the bit and break out of the loop, and once again
after the loop.

Fix this by testing the bit and exiting before unlocking the xarray.
The time spent testing the bit is negligible and it's not worth trying
to do that outside the critical section delimited by the xarray lock due
to the code complexity required to avoid it (like using a local boolean
variable to track whether the xarray is locked or not). The xarray unlock
only needs to be done before calling release_extent_buffer(), as that
needs to lock the xarray (through xa_cmpxchg_irq()) and does a more
significant amount of work.

Fixes: 19d7f65f032f ("btrfs: convert the buffer_radix to an xarray")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-btrfs/aDRNDU0GM1_D4Xnw@stanley.mountain/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ec1333dea064..36ce81301270 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4316,7 +4316,6 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 			spin_unlock(&eb->refs_lock);
 			continue;
 		}
-		xa_unlock_irq(&fs_info->buffer_tree);
 
 		/*
 		 * If tree ref isn't set then we know the ref on this eb is a
@@ -4333,6 +4332,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
 		 * check the folio private at the end.  And
 		 * release_extent_buffer() will release the refs_lock.
 		 */
+		xa_unlock_irq(&fs_info->buffer_tree);
 		release_extent_buffer(eb);
 		xa_lock_irq(&fs_info->buffer_tree);
 	}
-- 
2.47.2


