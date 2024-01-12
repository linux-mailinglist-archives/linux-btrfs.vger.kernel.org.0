Return-Path: <linux-btrfs+bounces-1409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DA82BC06
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 08:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288D028250D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA05D737;
	Fri, 12 Jan 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="nkSHVvla"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183A5D726
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1705045268; bh=qEC4Jko3sQWnwFnfDdJjXrJ3z/LI7000tMCSiajkamA=;
	h=From:To:Cc:Subject:Date;
	b=nkSHVvlaVJ1TxZdj4RfvYZJHWU8B/KL0yJ/AIrr6pZJYdUN/qXJfzPfl4oDS98nMt
	 8HOx6P3P4g3ZOWNLUj57T9I6vla4TpTkoiIoBXYTqQ/qNyGls6GzlMW02Og5vGQ5ct
	 t4NGEbl027km+Elsv6JX3/g0MNuRh7v70YBQlCo8=
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: shepjeng@gmail.com,
	kernel@cccheng.net,
	Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] btrfs: tree-checker: fix iref size in error messages
Date: Fri, 12 Jan 2024 15:41:05 +0800
Message-Id: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-MCP-Status: no
X-Synology-Virus-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0

The error message should accurately reflect the size rather than the
size.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 50fdc69fdddf..6eccf8496486 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1436,7 +1436,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
-				   ptr, inline_type, end);
+				   ptr, btrfs_extent_inline_ref_size(inline_type), end);
 			return -EUCLEAN;
 		}
 
-- 
2.34.1


