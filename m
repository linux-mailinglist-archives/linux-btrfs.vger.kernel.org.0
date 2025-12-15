Return-Path: <linux-btrfs+bounces-19734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D77CBD324
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 547FC3017F34
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8F329E54;
	Mon, 15 Dec 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tox1r/qh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FD329E56
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791513; cv=none; b=iitNi+fPuHhUwDFzH+DDm9MQ0GXKRBTuA9FOsNP1K4HGE1+oFbOv4oC3tjgLl9T5YPGBfKDUHV85ZKpfo6GJ998ViE7DWG3c2849Ekin1oynSRTy+B1axV4aWNA1FYzLZK1iFmDrd3A+r/AZ+sbtNWS1YuRBNHLvWBIwFGgGhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791513; c=relaxed/simple;
	bh=HQFhzQigSTIWYhAnlrpcJH/YFScZid6pB0U5Am9jdCw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM+g/KKk3Zvs5JaHl8V/gOSm/l2Io4pSDcvAt889gBMbM+8wHqJ7mKfRVEyEOQv1b7mbjF5KTS7tMdOl3mKC7ULFgyORim9zjRbt9s9DWwEBOCoBTh0ZwZMO43V88w2ytxKf/fA1d6vb2FVJlQHxddC4jUXr9UgHfeONNLLYgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tox1r/qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2F4C19422
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765791513;
	bh=HQFhzQigSTIWYhAnlrpcJH/YFScZid6pB0U5Am9jdCw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tox1r/qhi+s1NR7Z8iGWZB1UiVLC/alEocWee46N8qMykD0RuqyVBPSIwkw7itFlE
	 AQ4VODGkwaa3w1FPL2EU0T1vCpLBVLkA9+gajecnuh7yWOvcVVBvmu615zAhV7Kehj
	 LQE/ibR/OF8SeEDcKHosIa5qzFDoJYp+sMk5VbEB8SdOAaul0ncNcNhHjLOnsI3JkK
	 GbIifbrKSLRQ4wFQZTBvDsRbgUPGQ3MUEK2Jh3ZLdPN97rbLTEstb/Libt2AJQUbhQ
	 lCtPrLukQjn16M0913hpWgAxCoVil0icX90Q7cmauCvqVVI9b89DpaNTwTB2JQIeny
	 bzezCIMqJ4vdw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: update stale comment in __cow_file_range_inline()
Date: Mon, 15 Dec 2025 09:38:27 +0000
Message-ID: <edd0445538783749845d7b1911737237a41595ff.1765743479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765743479.git.fdmanana@suse.com>
References: <cover.1765743479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We mention that the reserved data space is page size aligned but that's
not true anymore, as it's sector size aligned instead.
In commit 0bb067ca64e3 ("btrfs: fix the qgroup data free range for inline
data extents") we updated the amount passed to btrfs_qgroup_free_data()
from page size to sector size, but forgot to update the comment.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f1ead789146b..6ae36cc5bcda 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -676,7 +676,7 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 	/*
 	 * Don't forget to free the reserved space, as for inlined extent
 	 * it won't count as data extent, free them directly here.
-	 * And at reserve time, it's always aligned to page size, so
+	 * And at reserve time, it's always aligned to sector size, so
 	 * just free one page here.
 	 *
 	 * If we fallback to non-inline (ret == 1) due to -ENOSPC, then we need
-- 
2.47.2


