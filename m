Return-Path: <linux-btrfs+bounces-4691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FD8BA5AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E822280F96
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E022F11;
	Fri,  3 May 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aldtSzxQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62018B14;
	Fri,  3 May 2024 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706620; cv=none; b=WJsf4ISdN16l95W+pEF8gyUNAuWI5pol/VrV1gBAuPmwFnQHFGEpTPoqPRNenw+Sq16vWRKDoJ3mCeGxaQU/GfXZN6ZWZ3ta/Y41lV7YZSA4/EHN+C/0kR0qBYblQIvr2b3oYxmdXV6v/6me8ZBgPMXTvfKWtQUhRr5y3Qpxi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706620; c=relaxed/simple;
	bh=nwdHSJ9iozj2tXtGX3zISOTD/CRAK2jBWcLjfLEAl/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RpYzCKm8BWWDvpLjY6jZPOukOqpE8+ZQAPnAEE9y49TordL241sAu1eNqDHljk95iDf7lLNa/SMPqSHP93bEoeAXXz7olgJPn3cjmRMgBmaB48rUNNCNUAakaz/hqY31n+Ru8+VYnwc0YBdKBJ2shFndeTLPq7zHP+zKCcp6q0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aldtSzxQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dhN/ef6KzTW6/TiSYN+7LCG+cbp0sa286GVMcEU5JNg=; b=aldtSzxQtvWbuMVeHyJU/XvNYp
	BmW5vet/5yCcaR4XmIFuSwc9H7AED9rWxVvfaxrwulcGXL3FQritOJXAEOvhyLwadjHux05gkSVrW
	KxF9lFBrG/sLvunA345VOuW+GOaYzDvblPXF3/3x0M/KZ1wfutwCts8MVs1NbjegLCppm3DRqeGWp
	9S5Qd8vXZ8ZbFGasFTGiUaTYABF2nwr0W3lEfeEWZh0WOaaOiFzbyYnrksS8FliXyH188IooJUfJP
	mawXwSzlYljAH8XanGNBKAU6vX9TpmcvvwhrTYSIqA4UZfy2erYA/d2q7nfIU6Ief+AwlUEMOe5Fm
	lS8BC97w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWE-00A2Vw-0u;
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
Subject: [PATCH v2 4/9] swapon(2): open swap with O_EXCL
Date: Fri,  3 May 2024 04:23:24 +0100
Message-Id: <20240503032329.2392931-4-viro@zeniv.linux.org.uk>
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

... eliminating the need to reopen block devices so they could be
exclusively held.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a5b640cca459..7e61a4aef2fc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,7 +298,6 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
-	struct file *bdev_file;		/* open handle of the bdev */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
 	struct completion comp;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 304f74d039f3..7bba0b0d4924 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2550,10 +2550,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	exit_swap_address_space(p->type);
 
 	inode = mapping->host;
-	if (p->bdev_file) {
-		fput(p->bdev_file);
-		p->bdev_file = NULL;
-	}
 
 	inode_lock(inode);
 	inode->i_flags &= ~S_SWAPFILE;
@@ -2780,14 +2776,7 @@ static struct swap_info_struct *alloc_swap_info(void)
 static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 {
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, p, NULL);
-		if (IS_ERR(p->bdev_file)) {
-			int error = PTR_ERR(p->bdev_file);
-			p->bdev_file = NULL;
-			return error;
-		}
-		p->bdev = file_bdev(p->bdev_file);
+		p->bdev = I_BDEV(inode);
 		/*
 		 * Zoned block devices contain zones that have a sequential
 		 * write only restriction.  Hence zoned block devices are not
@@ -3028,7 +3017,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		name = NULL;
 		goto bad_swap;
 	}
-	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
+	swap_file = file_open_name(name, O_RDWR | O_LARGEFILE | O_EXCL, 0);
 	if (IS_ERR(swap_file)) {
 		error = PTR_ERR(swap_file);
 		swap_file = NULL;
@@ -3225,10 +3214,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->percpu_cluster = NULL;
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
-	if (p->bdev_file) {
-		fput(p->bdev_file);
-		p->bdev_file = NULL;
-	}
 	inode = NULL;
 	destroy_swap_extents(p);
 	swap_cgroup_swapoff(p->type);
-- 
2.39.2


