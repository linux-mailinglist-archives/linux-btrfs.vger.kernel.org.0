Return-Path: <linux-btrfs+bounces-3439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BD880456
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BFA1C231BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364E2BAF0;
	Tue, 19 Mar 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pf5hpA/V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68A33CD0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871478; cv=none; b=Xp8iD1iQtGgWY+wKjffEtngZZnhytL36cnypWrVLyzWIPdtmGmSQu6p8SBqWu1/hvQCYjkm8pe9Uk7l8AmalUyd68MPI4M3g2DlUz6b5QRNZdf+19/aESlDl3TK4gTg8JxsH8jQOaTDioIr/P7Grez8kSKACISLhcYSqMitCiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871478; c=relaxed/simple;
	bh=mmW20jpvo1S3MK+oGphQNenSw9Y6Ju7EiQQL3ajF1cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS+bMvzwEHdpF+zGKapKZ3N+9dripTgm3BmpcfwqYueeQlInLr1VuzbS9DXvkf15OtqPPTvmxmOFVBp69l+K2LS9L0wypc3dKhus/Zok25izo/VHg6ErkVGGz1kQ3F8tE2N3FEf3+g1KlUkaGALL9sIvgIOlLGObRu06ulilqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pf5hpA/V; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a15537fa1so48950685a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710871475; x=1711476275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cc6f+c3kdrZZuPMSzkVlT4PO6jFR/NhaxkE/6j4fA0M=;
        b=pf5hpA/Vvh4BQrHGGKUvebLi7CF/vHYAzJXqxwk7bFEBb35LgNT22A3uzmzh3nYPz4
         eifYnOtjdUkgIhQH9+HwqLc53nbuYTExM8oUusjoLFWSJGe/kEO9NtcnqdYPx0Ae9LUx
         VEiirRE1I8l+PndNo93YcXAwM5aO1NdC3/KJ2mOXjMeys665aJ+Jqq3hxOz0PWguFDO/
         Dt/O8CKfFCKYDjIqlBEJYMNTGtxDwQY8KXSoTfkb6e5/sOkcZB426I1b9P+Un8S5CgxE
         dheW1zr5Lekt1mK9rmoRV0K0eJXQdBt5cwYxC8RMR/7MgF+Jsg7KKR4Pu8YaxYnRIZ8P
         A0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871475; x=1711476275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc6f+c3kdrZZuPMSzkVlT4PO6jFR/NhaxkE/6j4fA0M=;
        b=hcvAuaBscFGPzN4Q85ENdR7Lqtq8TL2U3+jMeFr2qq9EA/UOhah0pHjxkOaA3Pq5kp
         noald0sB02blB29si2gaI7ovtQ2iPFuHyaMDXfT1raIkP5Dcyfku+G1CWjlqxYMjHbIs
         /pBiFd1teNQCYoXh1GLQ7hU5+u/LrVoziCtuefsHr+nB8UIXGzOGQQpCL+2yiDJBRvKq
         rVOmWy1Z8/071jxx8qx/y/sfADT0a5OdYjBvWcf+ul4f5AiPARF0Rza66E0OOJXhtqTa
         zAxKCBlFBhu0ndpmPpg8Ba/hEcbzUV7VjEPpsRzcesY+nYDzFFPBGgxBF1E7s6R39Uuf
         g8LA==
X-Gm-Message-State: AOJu0Yy1iEG6QDb4m50KUsxZP8/8Fk6XZHVWdOABwfxdE+3Nv3LkEb98
	CHjMdS58mIMGA4yte7g0sKxRcbqhp2BcYZa3M2C1krCP4+5ak5Im4Tpw5b842mRz/0Rzm+9/9Fj
	H
X-Google-Smtp-Source: AGHT+IE79ucF2+F8Z83eGmtrV4F+HpT7JLW9xSzT/dgvhLtVh1SCOubaA7UVWs0BPz+KUAO52A39CA==
X-Received: by 2002:a05:620a:1707:b0:789:f174:c3c7 with SMTP id az7-20020a05620a170700b00789f174c3c7mr4573778qkb.37.1710871475124;
        Tue, 19 Mar 2024 11:04:35 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0c8500b00789e6f7f6dasm4155403qki.124.2024.03.19.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:04:34 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:04:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/29] btrfs: btrfs_relocate_block_group rename ret to
 ret2 and err ro ret
Message-ID: <20240319180434.GG2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <2af7ad0bfb1d016f4e5668d96cfc7d41c185cce7.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2af7ad0bfb1d016f4e5668d96cfc7d41c185cce7.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:26PM +0530, Anand Jain wrote:
> Renaem the existing ret variable is renamed to ret2.
> Since the variable err is the return variable of the function,
> rename it to ret. 
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 16a3882a4a7c..030262943190 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4070,18 +4070,18 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	struct reloc_control *rc;
>  	struct inode *inode;
>  	struct btrfs_path *path;
> -	int ret;
> +	int ret2;
>  	int rw = 0;
> -	int err = 0;
> +	int ret = 0;
>  
>  	/*
>  	 * This only gets set if we had a half-deleted snapshot on mount.  We
>  	 * cannot allow relocation to start while we're still trying to clean up
>  	 * these pending deletions.
>  	 */
> -	ret = wait_on_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS, TASK_INTERRUPTIBLE);
> -	if (ret)
> -		return ret;
> +	ret2 = wait_on_bit(&fs_info->flags, BTRFS_FS_UNFINISHED_DROPS, TASK_INTERRUPTIBLE);
> +	if (ret2)
> +		return ret2;
>  
>  	/* We may have been woken up by close_ctree, so bail if we're closing. */
>  	if (btrfs_fs_closing(fs_info))
> @@ -4113,25 +4113,25 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  		return -ENOMEM;
>  	}
>  
> -	ret = reloc_chunk_start(fs_info);
> -	if (ret < 0) {
> -		err = ret;
> +	ret2 = reloc_chunk_start(fs_info);
> +	if (ret2 < 0) {
> +		ret = ret2;
>  		goto out_put_bg;
>  	}
>  
>  	rc->extent_root = extent_root;
>  	rc->block_group = bg;
>  
> -	ret = btrfs_inc_block_group_ro(rc->block_group, true);
> -	if (ret) {
> -		err = ret;
> +	ret2 = btrfs_inc_block_group_ro(rc->block_group, true);
> +	if (ret2) {
> +		ret = ret2;
>  		goto out;
>  	}
>  	rw = 1;
>  
>  	path = btrfs_alloc_path();
>  	if (!path) {
> -		err = -ENOMEM;
> +		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> @@ -4139,18 +4139,18 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	btrfs_free_path(path);
>  
>  	if (!IS_ERR(inode))
> -		ret = delete_block_group_cache(fs_info, rc->block_group, inode, 0);
> +		ret2 = delete_block_group_cache(fs_info, rc->block_group, inode, 0);
>  	else
> -		ret = PTR_ERR(inode);
> +		ret2 = PTR_ERR(inode);
>  
> -	if (ret && ret != -ENOENT) {
> -		err = ret;
> +	if (ret2 && ret2 != -ENOENT) {
> +		ret = ret2;
>  		goto out;
>  	}
>  
>  	rc->data_inode = create_reloc_inode(fs_info, rc->block_group);
>  	if (IS_ERR(rc->data_inode)) {
> -		err = PTR_ERR(rc->data_inode);
> +		ret = PTR_ERR(rc->data_inode);
>  		rc->data_inode = NULL;
>  		goto out;
>  	}
> @@ -4163,17 +4163,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  				 rc->block_group->start,
>  				 rc->block_group->length);
>  
> -	ret = btrfs_zone_finish(rc->block_group);
> -	WARN_ON(ret && ret != -EAGAIN);
> +	ret2 = btrfs_zone_finish(rc->block_group);
> +	WARN_ON(ret2 && ret2 != -EAGAIN);
>  
>  	while (1) {
>  		enum reloc_stage finishes_stage;
>  
>  		mutex_lock(&fs_info->cleaner_mutex);
> -		ret = relocate_block_group(rc);
> +		ret2 = relocate_block_group(rc);
>  		mutex_unlock(&fs_info->cleaner_mutex);
> -		if (ret < 0)
> -			err = ret;
> +		if (ret2 < 0)
> +			ret = ret2;
>  
>  		finishes_stage = rc->stage;
>  		/*
> @@ -4186,16 +4186,16 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  		 * out of the loop if we hit an error.
>  		 */
>  		if (rc->stage == MOVE_DATA_EXTENTS && rc->found_file_extent) {
> -			ret = btrfs_wait_ordered_range(rc->data_inode, 0,
> +			ret2 = btrfs_wait_ordered_range(rc->data_inode, 0,
>  						       (u64)-1);
> -			if (ret)
> -				err = ret;
> +			if (ret2)
> +				ret = ret2;

Ok this is another place where we'll lose ret if it was already set from higher
up.  It's less bad here because we're only doing it if there was an error in
btrfs_wait_ordered_range().  But nonetheless I would like to preserve the error
code from higher up.  So add this to the series you write to fixup the other
error handling.

Then once you've done that, fix this patch to _only_ use ret2 in this block,
because for the rest of the code we can use ret for everything else.  Thanks,

Josef

