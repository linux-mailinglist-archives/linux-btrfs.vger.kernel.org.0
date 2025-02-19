Return-Path: <linux-btrfs+bounces-11573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC8A3BD49
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED743B24A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0671E834B;
	Wed, 19 Feb 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC7rlCGR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C71E8346
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965419; cv=none; b=poqvF0YWSJH88zOiVrs/DoxNlS8bIh+vrnT4F1P1WzpUm+JACms/uKgT67txsAD/oK3AKfKJCOpidF9po4aibR7cAfpuF+qOiUgBFX/JBwa6X9UhBkJGo58IJiKbBw6ExAoTWfDfaLtn4uUcWf/gJAPxxkDJn+Hzqso4SIhAr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965419; c=relaxed/simple;
	bh=jyxzL+aBLpb/hFzx7tyDyKjp6IkA5CQDpEEkFLuAiaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eww/PmdSto6yEPKOnhz9RHLyQvRyYay8mTdcDfzoUJe2w12tSoZ8jwqLHSobM7wiNUATiOKPIvkCe6nXO6wpY7W1wQFCehenTzEZx8cJXMPGowZB8ns90P6KDtzu/EDd78DvzDpiZ302f8/iy3ZILZPmLczSzw3GBGimvLeTdoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC7rlCGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32C2C4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965418;
	bh=jyxzL+aBLpb/hFzx7tyDyKjp6IkA5CQDpEEkFLuAiaw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dC7rlCGRv8qu0KsbLYHYdahfWdWTZJH+SR3XDFf8q3nJRIeFh1rILwzAXjaB37MnH
	 osiBDyStE64DoSo+B3OkyNkFdMkkowIz/CvY8GLpddTFy1bEJg2WgRv2oiX/vEGg8e
	 1i08EBGHaKx+b8nFEseFlPHeKOYE9KzMWhU6EOKC6dZfKxaYQbwBbsIPxtqEl0WaQ5
	 DlsoQ5rDSaPluVfRSiSeoSbeWCq8xH+GQHt6thVgwChYc19Cv5hT2d5xKS85WGEQyr
	 NSqrVb6EeAqutCl9EVO5li+v8ib0ZoNh32rbjEfyglvrGI4MSpHUYsmU9mpA81gc9W
	 nfBv2cB+8Qc1A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/26] btrfs: send: return -ENAMETOOLONG when attempting a path that is too long
Date: Wed, 19 Feb 2025 11:43:08 +0000
Message-Id: <b43606bdf86af69c4786deb1a0cc8a9329c1245a.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When attempting to build a too long path we are currently returning
-ENOMEM, which is very odd and misleading. So update fs_path_ensure_buf()
to return -ENAMETOOLONG instead. Also, while at it, move the WARN_ON()
into the if statement's expression, as it makes it clear what is being
tested and also has the effect of adding 'unlikely' to the statement,
which allows the compiler to generate better code as this condition is
never expected to happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b9de1ab94367..dcc1cf7d1dbd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -484,10 +484,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = fs_path_len(p);
 	old_buf_len = p->buf_len;
-- 
2.45.2


