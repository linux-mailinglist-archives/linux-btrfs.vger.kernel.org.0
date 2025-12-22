Return-Path: <linux-btrfs+bounces-19954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC8CD67D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C589B3043548
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Dec 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4D9321448;
	Mon, 22 Dec 2025 15:13:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BB2F5492
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416401; cv=none; b=AkJ9SZkF87Id0nKDcvfP75SSnCfIi3OnqxwG74ktuoqoozsUMUYzknOowzMg2O4UDDFZl2DNDp+ey3v7zt51p1d3xNNqRUX+CoHjrRZkLBBiyLqdV+kwbPoIN8r7s/iA8hJHgA9F+WMTJ7S/RrUsjOOh085kA37PyeirFkTGYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416401; c=relaxed/simple;
	bh=uqmF20jLI987bWGJ+gcvxELDmusXZKL01I2ooHIqfJk=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=eybdLS0lKjhn17dmXW+qDkeOI93Y5tvMhwZzOuuyDCJS3/z3B30vDpIuAbVHAs0hdgh9tXzLcnfd4NXZvpot5arJH7hxXNlBhjrrHYuAlRVUIHq6RYY3C80Ce5IKUeXC6ZzND8JVrQHzO2bg/0iKUO90N9XGu36fmJ0hauJOK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.fqRt7kT_1766416068 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 23:07:48 +0800
Date: Mon, 22 Dec 2025 23:07:49 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: Re: FOP_DONTCACHE when btrfs Direct IO fallback to buffered IO
In-Reply-To: <20251221215913.E7B2.409509F4@e16-tech.com>
References: <20251221215913.E7B2.409509F4@e16-tech.com>
Message-Id: <20251222230749.FFE2.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.82.01 [en]

Hi,

> Hi,
> 
> Could we add FOP_DONTCACHE support when btrfs Direct IO fallback to buffered IO?
> 
> I noticed similar logic in zfs-2.4.0 too.
> 
> https://github.com/openzfs/zfs/releases/tag/zfs-2.4.0
> Uncached IO: Direct IO fallback to a light-weight uncached IO when unaligned
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/12/21

The following dirty patch seems work here.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/12/22


diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..2642dceb6911 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -881,6 +881,7 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 */
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
+		iocb->ki_flags |= IOCB_DONTCACHE;
 		goto buffered;
 	}
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fa82def46e39..64eae7417242 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3843,7 +3843,7 @@ const struct file_operations btrfs_file_operations = {
 #endif
 	.remap_file_range = btrfs_remap_file_range,
 	.uring_cmd	= btrfs_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC | FOP_DONTCACHE,
 };
 
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)




