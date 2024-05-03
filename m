Return-Path: <linux-btrfs+bounces-4697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5408BA5B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AD5284F2C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F72537E9;
	Fri,  3 May 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="muwBl8fJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD51CD3F;
	Fri,  3 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706622; cv=none; b=C/iWrkciixI9A3HPMe7n6NGpeEunkXvaxkfFNR6gEAptbA5MFmTKNz4NPTBPMTLaEnMm+EFQQe4kpAj4gUj/tMC5ARYn4HCDmX3I7ATJFT+0cDsOmW36z0Z2FEeyCrzosSjLfEc2+qyZHs6z3VGL9aKofutaaf0e+qgS5GsJt4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706622; c=relaxed/simple;
	bh=8ebE4XUh6TIL3U3rsVcYwl6FXdU+e0pvqo+4boUMA0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMKIU6K7wUkjR0ymkeslLqVX+gXMC/UMKdaWCLcn7UTV2vIhdHjJez6ltHy2GM9zJBQZ6SGe3FuOe9FEYRJsCjy5X8PEIN9F+GTZTJNPWFcLLH+pDdxxbsgF0u29mK2XeY9CJm0TeOVWneGqm267zHE+Qjy3yI6YppO4xMW6Dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=muwBl8fJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ve7iu3CXoCO+LauZkbPs8hbuR/S5IyZ4gzxOBBwRvaY=; b=muwBl8fJadoWlPuoDDbZv4caNb
	mvU3noT3VW7Ak7LfsjC7+LIBuOu54+uW9jQc7uyxlkVWHBJCUQMRBPhud1cOvekjZ84moQJUCY4yB
	yGA6QqY23MvAuqUe8a8jAysOOD7+Z/HL0HuN/mQq7IRhyT9RgcQx7miIi3olySNx3AQqXg56VtPqy
	8j6ibVKPnkO5wr+d9Lnz6xHGtOXJzDQxezt2tG2mUImVvcOBEcSQLfx/JUyRNnw9mFoyqr6bxF9IA
	btCRrkA1vTLi2m8/YEOx57hBW0VEJE+74fdOMg2m7IcvtegMqB50Fyg7p4vqR06B5wi7ey/Wrv/B9
	6nDTnLOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWE-00A2W3-2E;
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
Subject: [PATCH v2 7/9] btrfs_get_bdev_and_sb(): call set_blocksize() only for exclusive opens
Date: Fri,  3 May 2024 04:23:27 +0100
Message-Id: <20240503032329.2392931-7-viro@zeniv.linux.org.uk>
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

btrfs_get_bdev_and_sb() has two callers - btrfs_open_one_device(),
which asks for open to be exclusive and btrfs_get_dev_args_from_path(),
which doesn't.  Currently it does set_blocksize() in all cases.

I'm rather dubious about the need to do set_blocksize() anywhere in btrfs,
to be honest - there's some access to page cache of underlying block
devices in there, but it's nowhere near the hot paths, AFAICT.

In any case, btrfs_get_dev_args_from_path() only needs to read
the on-disk superblock and copy several fields out of it; all
callers are only interested in devices that are already opened
and brought into per-filesystem set, so setting the block size
is redundant for those and actively harmful if we are given
a pathname of unrelated device.

So we only need btrfs_get_bdev_and_sb() to call set_blocksize()
when it's asked to open exclusive.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f15591f3e54f..43af5a9fb547 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -482,10 +482,12 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 
 	if (flush)
 		sync_blockdev(bdev);
-	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
-	if (ret) {
-		fput(*bdev_file);
-		goto error;
+	if (holder) {
+		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
+		if (ret) {
+			fput(*bdev_file);
+			goto error;
+		}
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
@@ -498,6 +500,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	return 0;
 
 error:
+	*disk_super = NULL;
 	*bdev_file = NULL;
 	return ret;
 }
-- 
2.39.2


