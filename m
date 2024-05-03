Return-Path: <linux-btrfs+bounces-4690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAD8BA5A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA221C22985
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D71CD2A;
	Fri,  3 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g+Eqsup9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74FF1B299;
	Fri,  3 May 2024 03:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706619; cv=none; b=CBTsFs/pI6DVC+cwQrOmTw7baCMw2ydA8QdK/BEUVilO8FjOV0HrtK6PpzK8kYWf8K3ew+RSQHPjvGEaQzJl9V5/2yfVX6BVhbnPbtDSbDEvLnStN3nrGD9v2KcBGiJJLbQYLlMVrCUnVmZX0q9i7geh/QxfZ6LBPkeG0XkX9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706619; c=relaxed/simple;
	bh=coQnFaUQk+YonHP9VZcg1wZRWOXon1n6rf16Uoitesw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7I5f8CiBsAr0RSd1868Vf/Y6HVN2UcJ+enVWADu+CTAZm5Uto8KbHjIFIJ2HkrzBU8404QsAdS4PPsrlunxaa8KmhTh/xn+5eVBkJTNWkzGJF3sJ5A3nK9YZiCDAUTkOxk2TJ5R6oqy2m+i9paZW4J+i3/+Y+0Pk2H0A+LkKms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g+Eqsup9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cwCXl7bDNgEK3wEeB1dHuYl82HeOEvaS0e413hiuNX4=; b=g+Eqsup9JNOHEYfCE32VG18AWm
	7XWmN+HFgVTYrb441G625Ti6JvwG0GsoemplB+bAIfMS6RxeDB1mQpt8Gzmuyha/tdQlOIioA4z0b
	hCO6nE+LhIEjEprz/fA/F5ZO0HewVWiDpjHQVQ69SGTj75rFp9whVITT3+RjROME4X/4MNoVMJ1gS
	K+hwH0TgxPE6BrO3KGsBLdQwe674rDozvXZsrlvc3w/ZphJwe0I/XJwXKIyz2Y6yd2rb741HiRZtz
	kd4QJPPm/IrlydeGFmVTz5N34m9Zz7b0so/HG1mc6gYhJCyUbmGaUlah5KJpwHJIFMt1o3qsbFfa5
	wYIx64fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWE-00A2W0-1h;
	Fri, 03 May 2024 03:23:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 6/9] swsusp: don't bother with setting block size
Date: Fri,  3 May 2024 04:23:26 +0100
Message-Id: <20240503032329.2392931-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

same as with the swap...

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/power/swap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..d9abb7ab031d 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -368,11 +368,7 @@ static int swsusp_swap_check(void)
 	if (IS_ERR(hib_resume_bdev_file))
 		return PTR_ERR(hib_resume_bdev_file);
 
-	res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
-	if (res < 0)
-		fput(hib_resume_bdev_file);
-
-	return res;
+	return 0;
 }
 
 /**
@@ -1574,7 +1570,6 @@ int swsusp_check(bool exclusive)
 	hib_resume_bdev_file = bdev_file_open_by_dev(swsusp_resume_device,
 				BLK_OPEN_READ, holder, NULL);
 	if (!IS_ERR(hib_resume_bdev_file)) {
-		set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
 		clear_page(swsusp_header);
 		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
 					swsusp_header, NULL);
-- 
2.39.2


