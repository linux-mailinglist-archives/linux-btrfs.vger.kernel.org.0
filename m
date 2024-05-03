Return-Path: <linux-btrfs+bounces-4692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E8B8BA5AC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9AB284B29
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA972943F;
	Fri,  3 May 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jfy+P7MN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D021D6AA;
	Fri,  3 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706621; cv=none; b=cWG9IIo0RAqLLmH1acfSIpj7wOLQMPXx7dNG7HUfyjgiv8+3ZzSIb5QMzNoHpGwLNvzvh+qNXmQe/dXLBnRJfqGMrKYB9g/nhD5hZScyGNQyX4IxnLEkur9r06xIrNSeBX1AR47/RKa8AMOLdQG576GuXBedNO9gDzOcPMFYZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706621; c=relaxed/simple;
	bh=NocbQBxKcyJelIDA1CsgTAp6trZZyE/fEv+c5mWg8DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o0RcYIRg76y8K16vT8mLMh0W7tclKt+lEaI8ofiNCVf6vKa5xmDQbWF5E5ZCr7T8AT7PPEwynmMwYZUdxjYLwPAyTdG2VlfXyOLqDJnKSSgzelzNWsoXWK32hXXOEcUlPs3Tk5H6npMO9Hn8eVpc1Wu5LXpFZPSF2ET1csagSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jfy+P7MN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=soKYu4AIzkQ6eIL3mrQB3BPphhAGIT6bosMOIB+slWg=; b=Jfy+P7MNmrJpf3nitpRAd9ZQD/
	uWdGyWfNQUbVssJcwt0hW9eGkmwC6cII3L8tMJfONfH6PlNvDK6uJjsrIAXyMyIy7WUFhTnv+eTLS
	GSgEuU9OMrWVIyKLmp3/UCueCW2t1slI5Bn6zCbZN8joO7Jg1I+WZ1pupMbnP4judDW3z/hvtXCu5
	B7b7G7+2MJdDf9Fb3P82gybZrclhsOfBaEk33p0r3Y3lTGP6NR2aoQ2lML3p+U5HDMQ4jqyDChHNN
	lGyZWsQk5qfmTons7kfYTJmU+BqblFGcRNeFErCMk1HnmaAUZ+mo0BF2wuXMUsQWhKeusslPr30qK
	XahpbGoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWD-00A2Vn-2I;
	Fri, 03 May 2024 03:23:29 +0000
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
Subject: [PATCH v2 1/9] bcache_register(): don't bother with set_blocksize()
Date: Fri,  3 May 2024 04:23:21 +0100
Message-Id: <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503031833.GU2118490@ZenIV>
References: <20240503031833.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We are not using __bread() anymore and read_cache_page_gfp() doesn't
care about block size.  Moreover, we should *not* change block
size on a device that is currently held exclusive - filesystems
that use buffer cache expect the block numbers to be interpreted
in units set by filesystem.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
ACKed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/md/bcache/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 330bcd9ea4a9..0ee5e17ae2dd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2554,10 +2554,6 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (IS_ERR(bdev_file))
 		goto out_free_sb;
 
-	err = "failed to set blocksize";
-	if (set_blocksize(file_bdev(bdev_file), 4096))
-		goto out_blkdev_put;
-
 	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
 	if (err)
 		goto out_blkdev_put;
-- 
2.39.2


