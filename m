Return-Path: <linux-btrfs+bounces-2908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17986C74E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5E61C232D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E647A732;
	Thu, 29 Feb 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcUe2xmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5A79DD5
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203813; cv=none; b=bxfQ9mACwGEDqNNZbG35mKmm5hUKPQ7aIVsjjQQ4kq3JMzfPj9hwgEuNDVIKh2Mr4oJoDtHMFq2pNiwwj+VuaWcVz8JnEsS+Lity3oqaEmqWKkOaC5dhviX0VlxDp2J2NP5X7fqh7WKPSZZS3GsrYJitzqq9VYYq5kk+tYtBKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203813; c=relaxed/simple;
	bh=MFVlqJ6da1RUIwX73gm1u6qQgYTLyfPYIen4O0hjWQc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CvkNf2zRPEPytn1kBCnFBXBzTqaZb3h6bhWBmbggdYPdLEAN0ABbZjw5Ibxi1A0gRWAMKR5mHo+Bb1lufyNyxoyPdPn+tN1fq4dPZOj/q13cKxenJ0KKbU3f9yeg3iPh557Hb9ieYWTyDZmlHNKkRBTrrXLqRJqKTnm2tVCqalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcUe2xmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BE1C433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709203813;
	bh=MFVlqJ6da1RUIwX73gm1u6qQgYTLyfPYIen4O0hjWQc=;
	h=From:To:Subject:Date:From;
	b=fcUe2xmp6bReAhIr6SyOEDbEspcVNUhSdqyqXZaPrjiVxQYpzTGT0MXriw931n+4y
	 hRhYQd8uM3Jpre6QiSlbOOhmTg2tbbXEOGdqRx1X0dQbM+g0i/KDKxS9n6kz+a6zo0
	 4jmLs1ftmw04efAJaMMCBbRIbF7H1GllDmdGAWsayOm9GF7VMREfdoAhRGgVHMq/+0
	 fQkErxyDeHKqkZNfkf3WXBZln/B4YIS8BisGzgSKaI5dO50FQ2B+4XkWMuaDIbDyrB
	 ibyxNhZ+6ma4jJF4fUipCfL/tip6/0VU4DSjDUGV6AdLdObgJ51BqqMYBBalifghf5
	 3vxG4vB4lkWtQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix off-by-one chunk length calculation at contains_pending_extent()
Date: Thu, 29 Feb 2024 10:50:03 +0000
Message-Id: <daee5e8b14d706fe4dd96bd910fd46038512861b.1709203710.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At contains_pending_extent() the value of the end offset of a chunk we
found in the device's allocation state io tree is inclusive, so when
we calculate the length we pass to the in_range() macro, we must sum
1 to the expression "physical_end - physical_offset".

In practice the wrong calculation should be harmless as chunks sizes
are never 1 byte and we should never have 1 byte ranges of unallocated
space. Nevertheless fix the wrong calculation.

Fixes: 1c11b63eff2a ("btrfs: replace pending/pinned chunks lists with io tree")
Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
Link: https://lore.kernel.org/linux-btrfs/CAOcd+r30e-f4R-5x-S7sV22RJPe7+pgwherA6xqN2_qe7o4XTg@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3cc947a42116..473fe92274d9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1401,7 +1401,7 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-			     physical_end - physical_start)) {
+			     physical_end + 1 - physical_start)) {
 			*start = physical_end + 1;
 			return true;
 		}
-- 
2.40.1


