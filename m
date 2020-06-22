Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED88203E15
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 19:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgFVRed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 13:34:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVReb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 13:34:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHBhdA020483;
        Mon, 22 Jun 2020 17:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VfhuG5En6CEW4ZLej2eaAM9QbT+5NiA3s7lKPm3uy14=;
 b=cqzgjIBPzIdO70u8dWgY1eCxot9ZoneoE4I9BN1SsYlKKDX0TeNLW8K9X30z+Z5p8jkB
 fIU+ecj6GNsWhXnJxTsxtwIr081D4pxFe1+fHQxGtJRpHNt/0DeCMxo4AOnzAxiGJ5Jp
 kJGBhhMmG/4pPzqjxBsEHHnCvRKxHGCKBoVhx6ZT1Db3OXnfFpqZ7Rv4GJPJHOZpeIGr
 TQXl2Fvslxe1rJ6BAPFDoiavegsMNrqiafKrQUtYJ/bNlhAVl7cn0PLz4Slfx8O/31qO
 DdNB6mwJ9hq7vsuy/DOe3pNLxTCdZgsR+ArNdgHNy+g/V6w9/1QnolWOEUw99zmC5C9C jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31sebbgr19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 17:34:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHY8Wm099296;
        Mon, 22 Jun 2020 17:34:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31svc1qhsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 17:34:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05MHYHFC023447;
        Mon, 22 Jun 2020 17:34:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 17:34:17 +0000
Date:   Mon, 22 Jun 2020 10:34:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, david@fromorbit.com, dsterba@suse.cz,
        jthumshirn@suse.de, fdmanana@gmail.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Message-ID: <20200622173415.GB11239@magnolia>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
 <20200622152457.7118-2-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622152457.7118-2-rgoldwyn@suse.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=1 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 cotscore=-2147483648 mlxscore=0
 suspectscore=1 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220120
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 22, 2020 at 10:24:52AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Convert wait_for_completion boolean to flags so we can pass more flags
> to iomap_dio_rw()
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/ext4/file.c        | 11 +++++++++--
>  fs/gfs2/file.c        |  7 ++++---
>  fs/iomap/direct-io.c  |  3 ++-
>  fs/xfs/xfs_file.c     | 10 ++++++----
>  fs/zonefs/super.c     |  8 ++++++--
>  include/linux/iomap.h |  9 ++++++++-
>  6 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c..d20120c4d833 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -53,6 +53,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	ssize_t ret;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> +	int flags = 0;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>  		if (!inode_trylock_shared(inode))
> @@ -74,8 +75,11 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		return generic_file_read_iter(iocb, to);
>  	}
>  
> +	if (is_sync_kiocb(iocb))
> +		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
> +
>  	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> +			   flags);
>  	inode_unlock_shared(inode);
>  
>  	file_accessed(iocb->ki_filp);
> @@ -457,6 +461,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>  	bool extend = false, unaligned_io = false;
>  	bool ilock_shared = true;
> +	int flags = 0;
>  
>  	/*
>  	 * We initially start with shared inode lock unless it is
> @@ -540,10 +545,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>  
> +	if (is_sync_kiocb(iocb) || unaligned_io || extend)
> +		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
>  	if (ilock_shared)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
> -			   is_sync_kiocb(iocb) || unaligned_io || extend);
> +			   flags);
>  
>  	if (extend)
>  		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index fe305e4bfd37..232f06338e0a 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -767,6 +767,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  	size_t count = iov_iter_count(to);
>  	struct gfs2_holder gh;
>  	ssize_t ret;
> +	int flags = is_sync_kiocb(iocb) ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0;
>  
>  	if (!count)
>  		return 0; /* skip atime */
> @@ -777,7 +778,7 @@ static ssize_t gfs2_file_direct_read(struct kiocb *iocb, struct iov_iter *to)
>  		goto out_uninit;
>  
>  	ret = iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> +			   flags);
>  
>  	gfs2_glock_dq(&gh);
>  out_uninit:
> @@ -794,6 +795,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t offset = iocb->ki_pos;
>  	struct gfs2_holder gh;
>  	ssize_t ret;
> +	int flags = is_sync_kiocb(iocb) ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0;
>  
>  	/*
>  	 * Deferred lock, even if its a write, since we do no allocation on
> @@ -812,8 +814,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
>  	if (offset + len > i_size_read(&ip->i_inode))
>  		goto out;
>  
> -	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
> -			   is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, flags);
>  
>  out:
>  	gfs2_glock_dq(&gh);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..7ed857196a39 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -405,7 +405,7 @@ iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
>  ssize_t
>  iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion)
> +		int dio_flags)
>  {
>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct inode *inode = file_inode(iocb->ki_filp);
> @@ -415,6 +415,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	unsigned int flags = IOMAP_DIRECT;
>  	struct blk_plug plug;
>  	struct iomap_dio *dio;
> +	bool wait_for_completion = !!(dio_flags & IOMAP_DIOF_WAIT_FOR_COMPLETION);
>  
>  	if (!count)
>  		return 0;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 00db81eac80d..38683b7c6013 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -169,6 +169,7 @@ xfs_file_dio_aio_read(
>  	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
>  	size_t			count = iov_iter_count(to);
>  	ssize_t			ret;
> +	int flags = is_sync_kiocb(iocb) ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0;
>  
>  	trace_xfs_file_direct_read(ip, count, iocb->ki_pos);
>  
> @@ -183,8 +184,7 @@ xfs_file_dio_aio_read(
>  	} else {
>  		xfs_ilock(ip, XFS_IOLOCK_SHARED);
>  	}
> -	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,
> -			is_sync_kiocb(iocb));
> +	ret = iomap_dio_rw(iocb, to, &xfs_read_iomap_ops, NULL,	flags);
>  	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
>  
>  	return ret;
> @@ -483,6 +483,7 @@ xfs_file_dio_aio_write(
>  	int			iolock;
>  	size_t			count = iov_iter_count(from);
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
> +	int flags = 0;

The variable names ought to be lined up.

>  	/* DIO must be aligned to device logical sector size */
>  	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
> @@ -546,9 +547,10 @@ xfs_file_dio_aio_write(
>  	 * If unaligned, this is the only IO in-flight. Wait on it before we
>  	 * release the iolock to prevent subsequent overlapping IO.
>  	 */
> +	if (is_sync_kiocb(iocb) || unaligned_io)
> +		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
>  	ret = iomap_dio_rw(iocb, from, &xfs_direct_write_iomap_ops,
> -			   &xfs_dio_write_ops,
> -			   is_sync_kiocb(iocb) || unaligned_io);
> +			   &xfs_dio_write_ops, flags);
>  out:
>  	xfs_iunlock(ip, iolock);
>  
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 07bc42d62673..88dc5aa70d1b 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -715,7 +715,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>  		ret = zonefs_file_dio_append(iocb, from);
>  	else
>  		ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
> -				   &zonefs_write_dio_ops, sync);
> +				   &zonefs_write_dio_ops,
> +				   sync ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0);
>  	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
>  	    (ret > 0 || ret == -EIOCBQUEUED)) {
>  		if (ret > 0)
> @@ -814,6 +815,7 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	struct super_block *sb = inode->i_sb;
>  	loff_t isize;
>  	ssize_t ret;
> +	int flags = 0;
>  
>  	/* Offline zones cannot be read */
>  	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
> @@ -848,8 +850,10 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  			goto inode_unlock;
>  		}
>  		file_accessed(iocb->ki_filp);
> +		if (is_sync_kiocb(iocb))
> +			flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
>  		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops,
> -				   &zonefs_read_dio_ops, is_sync_kiocb(iocb));
> +				   &zonefs_read_dio_ops, flags);
>  	} else {
>  		ret = generic_file_read_iter(iocb, to);
>  		if (ret == -EIO)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..f6230446b08d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -255,9 +255,16 @@ struct iomap_dio_ops {
>  			struct bio *bio, loff_t file_offset);
>  };
>  
> +/*
> + * Flags to pass iomap_dio_rw()
> + */
> +
> +/* Wait for completion of DIO */
> +#define IOMAP_DIOF_WAIT_FOR_COMPLETION 		0x1

There's a space after "COMPLETION" but before the tabs.

--D

> +
>  ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
> -		bool wait_for_completion);
> +		int flags);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>  
>  #ifdef CONFIG_SWAP
> -- 
> 2.25.0
> 
