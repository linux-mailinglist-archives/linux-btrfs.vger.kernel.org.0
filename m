Return-Path: <linux-btrfs+bounces-4696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC798BA5B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75DF284E81
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDD4F88C;
	Fri,  3 May 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vQxxp3bQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C301B299;
	Fri,  3 May 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706622; cv=none; b=QxC5lIOimlPryjH9ZSIvuavBgpYYNXYjaZRrkvVCOrt84hJIX6JgWwE4o7hwUH+bLnhlUF3beH6hnBlt6RsyzD3L2x3WISVlobws1wAk/oyrfSeWDwDQoXVazObQLLPqhLdkEtE9+G43NSwxIOsDR0VOwupGcM4nWRZY+FuEPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706622; c=relaxed/simple;
	bh=T22JrpafRjR0cPiRd37OY+3r5BzgSapXYKLtL7I1f1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4x+6Oo5Jn9ZBiUIZEI7kJrssqsgJQoXwBOY63L1+8GQJPbltGaMTU8BqFGggXi3C7qCOtvmm45TxLCKnIWqiCiBX3HlcIGLzElc+pr1Ubz6vExeTpFLxwdzGPPGEBL3BvCNoE80R/PMshdDZfsF32gHln0S7Wlob2c1hugoaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vQxxp3bQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zwCOMy2NEj3BPtx134SFdJYS70Xwr8CQmU8M48tauxc=; b=vQxxp3bQsUGSpNF0seAOsviYP4
	KJuxYmU9WWHgqbug2UkvbfQuqUqy/3mRFSZDXr5a0kLXlv5/LhgE55N/NK0fg62uO5SlwGrA7lSd5
	lJ+jLPXj1/Vq0imGW4PcTzoRQud9Zi0OWOtm4tzzO2gCCtxl8nYKM/f5l1oK3FC6cQse6DsuyXHi9
	aryull+gkzdB9rS32Bfv17kkMLfB49QtBIVAfhXe6hvhvIjG+hNaosAtk4PBjVf+mt9ysL9RVpFF7
	YOJXqJKJNpN8/bFleTTnAyI65ZaKrPX9QXjJlTuntfduTREeAxh4ubmt2A0H2aEQYMSeQ72s4hzKH
	Wdhuk4IQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWF-00A2W8-08;
	Fri, 03 May 2024 03:23:31 +0000
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
Subject: [PATCH v2 9/9] make set_blocksize() fail unless block device is opened exclusive
Date: Fri,  3 May 2024 04:23:29 +0100
Message-Id: <20240503032329.2392931-9-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 7 +++++++
 block/bdev.c                          | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1be76ef117b3..5503d5c614a7 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1134,3 +1134,10 @@ superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
 device freezing now works for any block device owned by a given superblock, not
 just the main block device. The get_active_super() helper and bd_fsfreeze_sb
 pointer are gone.
+
+---
+
+**mandatory**
+
+set_blocksize() takes opened struct file instead of struct block_device now
+and it *must* be opened exclusive.
diff --git a/block/bdev.c b/block/bdev.c
index a329ff9be11d..a89bce368b64 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -157,6 +157,9 @@ int set_blocksize(struct file *file, int size)
 	if (size < bdev_logical_block_size(bdev))
 		return -EINVAL;
 
+	if (!file->private_data)
+		return -EINVAL;
+
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-- 
2.39.2


