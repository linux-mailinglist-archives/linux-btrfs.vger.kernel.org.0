Return-Path: <linux-btrfs+bounces-4698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951418BA5B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FCE1C22B68
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460556457;
	Fri,  3 May 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Cq8g5eR7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6B1BF47;
	Fri,  3 May 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706623; cv=none; b=WDc9kHTWVAiW1FqimQafXhx5YSku8Dihx/9i/SB8jvyIXnKB+S4SY8fW4XwPcdKFSQTMooBRwm7ZEex0DGVXRtJoNzYIQUbU11SNBsA3XmkOyK/wM2z5lf+RGgse3rU9IeuXWk+003BAGEYgwCsG4f0OCDtX0b+0+jVQtJjE3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706623; c=relaxed/simple;
	bh=Ny/piFSeo/b8skljYppcXOeFUcUBl2a+DCCTPN5ciBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKGb6pquyVEFDnrkvlj+jdSx1Kl9zJ5FPRNRLDj9urWiLLgyA1iYetEeRXbNfs5x89CVB6KF/QTbfjF81Wjo8GNXdMs08sVLWUhDV5DrHzniR80uuUUBYqfGiZSShEo3zGnHb70gNKFyoNYK1r1qXQ4R146asMXaMlLMIol90yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Cq8g5eR7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=93pWwp0Zz5qYrYHUR6o6Sk8WkFP1Q/YOlDatYiLWcaw=; b=Cq8g5eR7johzHILI0qWZufmuF0
	sfNlpGtOrp8JpgmQjrBpRpi6jTP0aGXQDUkE8OkIBYCUzAG4gPCE7/LaQqr4a5mVRTg78I2xRt4Er
	4MBYRguwXyobe35JYEfG3zIIru//QRvnh7/g5xXUF+KSoozVarsYbmHDQy3DO1vRf1UPu0TPT3/3P
	m8k9lyf356v8bOAk21a9B1i+bp+tdLc/P/YsoXxagd7TTwwGvd929rkypmxabv3ZFVqyE5YL7Pnw1
	u+aTkeroVrquF41Ujo4ktwmF8e67D+wQ+ojacHfhYmqb5lFQSEAYpKIWp6tOfHl0gByVDQycbo6Au
	q/44jmQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWE-00A2Vu-0S;
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
Subject: [PATCH v2 3/9] swapon(2)/swapoff(2): don't bother with block size
Date: Fri,  3 May 2024 04:23:23 +0100
Message-Id: <20240503032329.2392931-3-viro@zeniv.linux.org.uk>
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

once upon a time that used to matter; these days we do swap IO for
swap devices at the level that doesn't give a damn about block size,
buffer_head or anything of that sort - just attach the page to
bio, set the location and size (the latter to PAGE_SIZE) and feed
into queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 12 +-----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f53d608daa01..a5b640cca459 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -301,7 +301,6 @@ struct swap_info_struct {
 	struct file *bdev_file;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
-	unsigned int old_block_size;	/* seldom referenced */
 	struct completion comp;		/* seldom referenced */
 	spinlock_t lock;		/*
 					 * protect map scan related fields like
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..304f74d039f3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2417,7 +2417,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct inode *inode;
 	struct filename *pathname;
 	int err, found = 0;
-	unsigned int old_block_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2529,7 +2528,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	}
 
 	swap_file = p->swap_file;
-	old_block_size = p->old_block_size;
 	p->swap_file = NULL;
 	p->max = 0;
 	swap_map = p->swap_map;
@@ -2553,7 +2551,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	inode = mapping->host;
 	if (p->bdev_file) {
-		set_blocksize(p->bdev, old_block_size);
 		fput(p->bdev_file);
 		p->bdev_file = NULL;
 	}
@@ -2782,21 +2779,15 @@ static struct swap_info_struct *alloc_swap_info(void)
 
 static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 {
-	int error;
-
 	if (S_ISBLK(inode->i_mode)) {
 		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
 				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
 		if (IS_ERR(p->bdev_file)) {
-			error = PTR_ERR(p->bdev_file);
+			int error = PTR_ERR(p->bdev_file);
 			p->bdev_file = NULL;
 			return error;
 		}
 		p->bdev = file_bdev(p->bdev_file);
-		p->old_block_size = block_size(p->bdev);
-		error = set_blocksize(p->bdev, PAGE_SIZE);
-		if (error < 0)
-			return error;
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
@@ -3235,7 +3226,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	if (p->bdev_file) {
-		set_blocksize(p->bdev, p->old_block_size);
 		fput(p->bdev_file);
 		p->bdev_file = NULL;
 	}
-- 
2.39.2


