Return-Path: <linux-btrfs+bounces-6200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1A9279CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F503289999
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06B1B1500;
	Thu,  4 Jul 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXuFi+Xs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E701B14F0
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106173; cv=none; b=ufhJV3odNWYOpNf0voTdJ/kBkp1XoCgKaxcUXouFCNpCMYlr8wETtJNLw87piKEkID2A0Ebn3krEd/IrRDlIfy9hWwjFYdwXb4EAGcMQ5KhpvFPY2RpU45N+5BzdJXRvDNF8NuBU0g0OZUjeQEDCiZTxJmD5dt6Mpmf6fBf0VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106173; c=relaxed/simple;
	bh=K0NKPzzMdTdE6m3nYi+nJI/In3MZR5mlYpC5ytoHxBY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MegluheTe+a6on8qt4pboRGSvzodeOJkh8y++QZ4xUm2XuWsZVgU3YtESaEOTK3mPFS9j7Y44d0rbQ1I9M/YtxVjD+o+iUuZ1pVV18oVOi8E7QXMcu516wdxDnPthfBm8FxCaH/mn6DUHYZomDJAxRp+yi+bet4csZ37F4NV/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXuFi+Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5996C3277B
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720106173;
	bh=K0NKPzzMdTdE6m3nYi+nJI/In3MZR5mlYpC5ytoHxBY=;
	h=From:To:Subject:Date:From;
	b=FXuFi+XsJ87swQHY0biH+OiR8+CKKNaW+yN9MCDO8WT8epeu+qAayT9F5hsk1jJMB
	 JWQwLV3kdyNvJRO0vNYAG+mgzL2JozPM90uOPRSwsrrh5oXepaoq0N+VGIlo8J+9R+
	 eALHiz9V+0yepwbm3LHdBTbVmcPg4rGwgTKo+B3UXQ5HkAeOU+qr0X0CpPYsb87s8L
	 SZQ5GalepDqoHAlJ4XSyAJk15+exzV95JF2DbLUlHakSOEKF1WEgEVgnxhxynqLpUf
	 A+wpBTmKgsqvQ7RR5lKAkkz48mn8E68E7surRI8B8CtJixyKYVxNL1af0v2lfFw7bD
	 JcRuD1D1rT4nw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix extent map use-after-free when adding pages to compressed bio
Date: Thu,  4 Jul 2024 16:16:09 +0100
Message-Id: <21fac1f722255954c5c7e67637e388451ad309c6.1720106056.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add add_ra_bio_pages() we are accessing the extent map to calculate
'add_size' after we dropped our reference on the extent map, resulting
in a use-after-free. Fix computing 'add_size' before dropping our extent
map reference.

Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000038144061c6d18f2@google.com/
Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6441e47d8a5e..7c22f5b8c535 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -514,6 +514,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			put_page(page);
 			break;
 		}
+		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
 
 		if (page->index == end_index) {
@@ -526,7 +527,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
-		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);
-- 
2.43.0


