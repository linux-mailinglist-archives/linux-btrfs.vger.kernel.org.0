Return-Path: <linux-btrfs+bounces-1897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DD8406DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 14:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA156B25BFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1A6312A;
	Mon, 29 Jan 2024 13:27:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-54.mail.aliyun.com (out28-54.mail.aliyun.com [115.124.28.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D063105
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534841; cv=none; b=lsjqY9QSrNitHeCQACdoGtvXGOX2vJXBubIich53B8WFCSWOvnocXzQ1FmBAjSH/YwqJ3FfhEadZ3V7+/6ibTmCOyCMtmkaPfPsoKqTbD5se+kegRmaTv+FGx4igX72M3Cq/iUky0iTfZlHteORC7M8IShLiW1pmpfuaydbKNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534841; c=relaxed/simple;
	bh=jH9JiH1etfHxoFogJ30atlVKqm01dzITOUBxGtv1jck=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=fUIcYfx900SLQv5VHrW1G+aPwKqGXpWt0sgwrFeEb6nvM14DG2RzZuF4r7HE1iaWPpmhz9TniymqQrZrxvsQYNbTdmoICPqXoz6hQ8CgTEAqCjLRWBjjPesBEHC9LsLldS44L4EjmG+x+fNuzVpwgpeJemhgpCmJxSQvePqKGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04442335|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0130562-0.000483652-0.98646;FP=1934797680062827995|1|1|2|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.WIdi1X1_1706532981;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.WIdi1X1_1706532981)
          by smtp.aliyun-inc.com;
          Mon, 29 Jan 2024 20:56:22 +0800
Date: Mon, 29 Jan 2024 20:56:22 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Naohiro Aota <naohiro.aota@wdc.com>,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped FS
In-Reply-To: <20240124081931.1DDE.409509F4@e16-tech.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com> <20240124081931.1DDE.409509F4@e16-tech.com>
Message-Id: <20240129205621.1BA8.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.05 [en]

Hi,

> Hi,
> 
> > There was a report of write performance regression on 6.5-rc4 on RAID0
> > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > and doing the checksum inline can be bad for performance on RAID0
> > setup [2]. 
> > 
> > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > 
> > While inlining the fast checksum is good for single (or two) device,
> > but it is not fast enough for multi-device striped writing.
> > 
> > So, this series first introduces fs_devices->inline_csum_mode and its
> > sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> > it disables inline checksum when it find a block group striped writing
> > into multiple devices.
> 
> We have struct btrfs_inode | sync_writers in kernel 6.1.y, but dropped in recent
> kernel. 
> 
> Is btrfs_inode | sync_writers not implemented very well?

I tried the logic blow, some like ' btrfs_inode | sync_writers'.
- checksum of metadata always sync
- checksum of data async only when depth over 1,
	to reduce task switch when low load.
	to use more cpu core when high load.

performance test result is not good
	2GiB/s(checksum of data always async) -> 2.1GiB/s when low load.
	4GiB/s(checksum of data always async) -> 2788MiB/s when high load.

but the info  maybe useful, so post it here.


- checksum of metadata always sync

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 12b12443efaa..8ef968f0957d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -598,7 +598,7 @@ static void run_one_async_free(struct btrfs_work *work)
 static bool should_async_write(struct btrfs_bio *bbio)
 {
 	/* Submit synchronously if the checksum implementation is fast. */
-	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
+	if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
 		return false;
 
 	/*


- checksum of data async only when depth over 1, to reduce task switch.

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index efb894967f55..f90b6e8cf53c 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -626,6 +626,9 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	if ((bbio->bio.bi_opf & REQ_META) && btrfs_is_zoned(bbio->fs_info))
 		return false;
 
+	if (!(bbio->bio.bi_opf & REQ_META) && atomic_read(&bbio->fs_info->depth_checksum_data)==0 )
+		return false;
+
 	return true;
 }
 
@@ -725,11 +728,21 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
 		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
 		    !btrfs_is_data_reloc_root(inode->root)) {
-			if (should_async_write(bbio) &&
-			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
-				goto done;
-
+			if (should_async_write(bbio)){
+				if (!(bbio->bio.bi_opf & REQ_META))
+					atomic_inc(&bbio->fs_info->depth_checksum_data);
+				ret = btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num);
+				if (!(bbio->bio.bi_opf & REQ_META))
+					atomic_dec(&bbio->fs_info->depth_checksum_data);
+				if(ret)
+					goto done;
+			}
+
+			if (!(bbio->bio.bi_opf & REQ_META))
+				atomic_inc(&bbio->fs_info->depth_checksum_data);
 			ret = btrfs_bio_csum(bbio);
+			if (!(bbio->bio.bi_opf & REQ_META))
+				atomic_dec(&bbio->fs_info->depth_checksum_data);
 			if (ret)
 				goto fail_put_bio;
 		} else if (use_append) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d7b127443c9a..3fd89be7610a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2776,6 +2776,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 
 	fs_info->thread_pool_size = min_t(unsigned long,
 					  num_online_cpus() + 2, 8);
+	atomic_set(&fs_info->depth_checksum_data, 0);
 
 	INIT_LIST_HEAD(&fs_info->ordered_roots);
 	spin_lock_init(&fs_info->ordered_root_lock);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 7443bf014639..123cc8fa9be1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -596,6 +596,7 @@ struct btrfs_fs_info {
 	struct task_struct *transaction_kthread;
 	struct task_struct *cleaner_kthread;
 	u32 thread_pool_size;
+	atomic_t depth_checksum_data;
 
 	struct kobject *space_info_kobj;
 	struct kobject *qgroups_kobj;

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/01/25



