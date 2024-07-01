Return-Path: <linux-btrfs+bounces-6091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B091E11B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8471F23BF1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2815ECD6;
	Mon,  1 Jul 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rAqstR5h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6B15ECC4
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841617; cv=none; b=f13p91/h+biJICDuJ0kuRdE5Wp9+Wqx30/wwtwM4X/jVwdcFxNOzPcwM+n3wxI4ryhrRA095MS+3ffySX9ADmNBJS3HfYP1aQRe9kVFRD6uZn0/zbC7rgtcSVkccQyiWzxL+wrw4oPpT2mrE5zQ68f9RfNtaN//8h/IKIO+nG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841617; c=relaxed/simple;
	bh=Ww3zO2BWA6CNrPfVjdCQ8/edKcVa8UvzDOn/+wZVrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFUI9i+ZT6HcMst1eiqIa2X2x9X2mcDKX03OYd3maWa7sws0OCopWWewtR5Q/s0ZEk6fC0bCdK7m0JCB3wCdy69loF6aAp42ZRiH+7wg0gtK7H2DMDA6N/p1wLoUkh5qGzaVgwdH4I1Y5iM71nUJCgRSnL4FSU+QZ7f40CPmZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rAqstR5h; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6adc63c2ee0so8424646d6.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719841615; x=1720446415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7pK8M+T679Mr4Uw1+2PXZ/iLLD0jN5yzRREJHhd/M8=;
        b=rAqstR5haeuwUowCfxCsQJIDf2qieHtgMh+/eTl2ebv8mkMM1HXvwROMApDpg6OG1m
         RqgsLoF652BqZbYRaiiuBfUxYrkv6/Oz5JDzyZma2wEKP7wTY/o3LltyoHd5HUXIo4fl
         0XSjC+XbKoPv58qG/XCotkfE7uut/wF1fCpRDqMY1MUEUtOwWDD6d7xy8pup9hVypChg
         /eRTAcd3ablPgl7txgWWcymn5qj10yEu1EkddYON84Q+tIl3mjdQOtYRv73QjZ1EqjsU
         IhU8ztbaR+NKHNO4lDc/gY6CB1waiKLXBNviHrfW4CRsj5QMny+jwXgvjjO4Td8ar6r0
         dHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719841615; x=1720446415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7pK8M+T679Mr4Uw1+2PXZ/iLLD0jN5yzRREJHhd/M8=;
        b=lyVyK3utOoThZd1fn+1ASUb40L5XPv28RpHfYbfFYnVhnr1+JmBgRJ7BAUzRP3WE2U
         H4d/K5D9NiCHApdntNhSY3WtN6GwLlriIotjbKdDA638iJki5XdKxKo72HyYte7aK1ls
         rezV/DyZUYVfsdffF1yh9lZk7TTElFuNqP3X/XCM77igWXujcCjZj/C3iyI57KvMXICQ
         m0u748YojwqDnAc+m8B6dNUxbrYdI5LfrKVwG3Ap3qN1hyDfUYCzJMxxXVkE7BJ6jSim
         Sq5x8KN92cW8qpJ6dHYNx4DBtICe6Dzl7eNUVD+O9mpuFu/7f8O5dVZP4PgQrK/HUbc2
         z+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSgS7lBQis32TWknYbW8lmvpw+Ivysx9BD+Kb+HHhUO7gc04ZNRcRffMZqKevZ3tbpeOytRdy4jKm4MvBHKGTPNFtN8H51ybvoCWk=
X-Gm-Message-State: AOJu0Yw2KKi0g50O04WNPRRYE+meWBOu0pxVKVMlAAoqm3Xf0JZbR1Dn
	ECHdXl8yF918tWC44ZznfiaGgG2G26SaJfMXL6DQ2SZYQSjtShICTRBPwmUi+iI=
X-Google-Smtp-Source: AGHT+IG8OekqgNnErri1uZBaOEWN7EF2UDkAF5obMoo6PPyjxSiFbWfhXRMS/kv2BHuTbAr7oS5ICw==
X-Received: by 2002:a05:6214:f03:b0:6b5:47b0:8f09 with SMTP id 6a1803df08f44-6b5b70cde0fmr83155356d6.36.1719841615063;
        Mon, 01 Jul 2024 06:46:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f5f51sm33227276d6.75.2024.07.01.06.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:46:54 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:46:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 07/11] xfs: switch to multigrain timestamps
Message-ID: <20240701134653.GA504479@perftesting>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
 <20240701-mgtime-v2-7-19d412a940d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-mgtime-v2-7-19d412a940d9@kernel.org>

On Mon, Jul 01, 2024 at 06:26:43AM -0400, Jeff Layton wrote:
> Enable multigrain timestamps, which should ensure that there is an
> apparent change to the timestamp whenever it has been written after
> being actively observed via getattr.
> 
> Also, anytime the mtime changes, the ctime must also change, and those
> are now the only two options for xfs_trans_ichgtime. Have that function
> unconditionally bump the ctime, and ASSERT that XFS_ICHGTIME_CHG is
> always set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/xfs/libxfs/xfs_trans_inode.c | 6 +++---
>  fs/xfs/xfs_iops.c               | 6 ++++--
>  fs/xfs/xfs_super.c              | 2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 69fc5b981352..1f3639bbf5f0 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -62,12 +62,12 @@ xfs_trans_ichgtime(
>  	ASSERT(tp);
>  	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
> -	tv = current_time(inode);
> +	/* If the mtime changes, then ctime must also change */
> +	ASSERT(flags & XFS_ICHGTIME_CHG);
>  
> +	tv = inode_set_ctime_current(inode);
>  	if (flags & XFS_ICHGTIME_MOD)
>  		inode_set_mtime_to_ts(inode, tv);
> -	if (flags & XFS_ICHGTIME_CHG)
> -		inode_set_ctime_to_ts(inode, tv);
>  	if (flags & XFS_ICHGTIME_CREATE)
>  		ip->i_crtime = tv;
>  }
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index ff222827e550..ed6e6d9507df 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -590,10 +590,12 @@ xfs_vn_getattr(
>  	stat->gid = vfsgid_into_kgid(vfsgid);
>  	stat->ino = ip->i_ino;
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	fill_mg_cmtime(stat, request_mask, inode);
> +
>  	stat->blocks = XFS_FSB_TO_BB(mp, ip->i_nblocks + ip->i_delayed_blks);
>  
> +

Stray newline.  Thanks,

Josef

