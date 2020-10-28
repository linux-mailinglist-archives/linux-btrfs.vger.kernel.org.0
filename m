Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB2E29D9AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389940AbgJ1XAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389913AbgJ1W6h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 18:58:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52ECC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:58:36 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m65so721585qte.11
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cRJdGrGk8lr+rQ4oilyCFUsudf6+pbnlaXb3ImwTGSA=;
        b=ebVp1QwrALIMINJwMhHe+qsfmtdiaqlH9wyfd09HNGoMgOKfked8xCn83DJYMtHCgC
         zFMW8HWurJyJ2t0vRmMWPjW/ZTq3m9oXsKmNHieGznap+n1aE4L7PpLUuwsKwwM7go58
         acJC/nM5ppqLrZI10nE6+8Gi1n4PyOz+X+XXgYLiBIvau31E8+OklL6XbDa6fmToSVWg
         Je8xS5znP2G1R/M3p9cM+PfwMrsRGeorqvP/tVFqPLtDgvtTwnLAdt9lrSJjyYfasaKo
         LflPxync4hOZ3S/56V7Jf4ATJPW96fu6PyJYPMon0Ye4hox5GHnYcBlRDf8B13f6u558
         Lg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRJdGrGk8lr+rQ4oilyCFUsudf6+pbnlaXb3ImwTGSA=;
        b=n8CCLCIo0NfLfGawJ5wxAFlo6rHkwZ62kc+k6AwW2AZyLBUw2Nf6KaxocEyY5F9RI8
         zLtwXK9Xa17J0Fw6EcM3x5UJkGOEX9hNcqqyGzauP+r4Z7oRTnw+D6LQBKY3UpVNZZvY
         GqDM+AddjqDl1EifogG7bdPxNvYrzE0+BfglIkIAZZDim2f++NGMvq3sulQwFmfhuN7N
         sQJIj8jeypsMTcN9MkIAwCNukGYU6wBEjrd6lRZfm5TBoF3uw+J3LilYDF5my/kJ/0dY
         FiqoDwq/ikSnR1Dx0JENsvUF6xCCzMYmkzUlhB8HIPktkqic21urfZ9bWfB82XEqooPC
         DUBQ==
X-Gm-Message-State: AOAM5303wJLIHXRjSC2dX3zAC0RMnUtOPb+IC0bxWf6puZe677N3iusC
        R8jGthGIOigZ2x99o1xSgxey2j/rKtJik8Yy
X-Google-Smtp-Source: ABdhPJy4sPBpKy1YyvW2H5R/ufsbFvoBRjpZSZ7nrku/nJ/PhQQLAepKcrd9lfytcDmFKqiBoQ8+Ag==
X-Received: by 2002:a37:ac11:: with SMTP id e17mr7647998qkm.232.1603894112322;
        Wed, 28 Oct 2020 07:08:32 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b22sm1497182qkk.6.2020.10.28.07.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:08:31 -0700 (PDT)
Subject: Re: [PATCH v5 01/10] btrfs: lift rw mount setup from mount and
 remount
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1603828718.git.boris@bur.io>
 <a8e439ad35a37fdd1a245299aa261bc49dcc4aa9.1603828718.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b1437103-dce3-3751-a46e-4e34a2af4f46@toxicpanda.com>
Date:   Wed, 28 Oct 2020 10:08:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a8e439ad35a37fdd1a245299aa261bc49dcc4aa9.1603828718.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/27/20 5:07 PM, Boris Burkov wrote:
> Mounting rw and remounting from ro to rw naturally share invariants and
> functionality which result in a correctly setup rw filesystem. Luckily,
> there is even a strong unity in the code which implements them. In
> mount's open_ctree, these operations mostly happen after an early return
> for ro file systems, and in remount, they happen in a section devoted to
> remounting ro->rw, after some remount specific validation passes.
> 
> However, there are unfortunately a few differences. There are small
> deviations in the order of some of the operations, remount does not
> cleanup orphan inodes in root_tree or fs_tree, remount does not create
> the free space tree, and remount does not handle "one-shot" mount
> options like clear_cache and uuid tree rescan.
> 
> Since we want to add building the free space tree to remount, and since
> it is possible to leak orphans on a filesystem mounted as ro then
> remounted rw (common for the root filesystem when booting), we would
> benefit from unifying the logic between the two codepaths.
> 
> This patch only lifts the existing common functionality, and leaves a
> natural path for fixing the discrepancies.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/disk-io.c | 93 ++++++++++++++++++++++++++--------------------
>   fs/btrfs/disk-io.h |  1 +
>   fs/btrfs/super.c   | 37 +++---------------
>   3 files changed, 60 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3d39f5d47ad3..bff7a3a7be18 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2814,6 +2814,53 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
>   	return 0;
>   }
>   
> +/*
> + * Mounting logic specific to read-write file systems. Shared by open_ctree
> + * and btrfs_remount when remounting from read-only to read-write.
> + */
> +int btrfs_mount_rw(struct btrfs_fs_info *fs_info)
> +{
> +	int ret;
> +
> +	ret = btrfs_cleanup_fs_roots(fs_info);
> +	if (ret)
> +		goto out;
> +
> +	mutex_lock(&fs_info->cleaner_mutex);
> +	ret = btrfs_recover_relocation(fs_info->tree_root);
> +	mutex_unlock(&fs_info->cleaner_mutex);
> +	if (ret < 0) {
> +		btrfs_warn(fs_info, "failed to recover relocation: %d", ret);
> +		goto out;
> +	}
> +
> +	ret = btrfs_resume_balance_async(fs_info);
> +	if (ret)
> +		goto out;
> +
> +	ret = btrfs_resume_dev_replace_async(fs_info);
> +	if (ret) {
> +		btrfs_warn(fs_info, "failed to resume dev_replace");
> +		goto out;
> +	}
> +
> +	btrfs_qgroup_rescan_resume(fs_info);
> +
> +	if (!fs_info->uuid_root) {
> +		btrfs_info(fs_info, "creating UUID tree");
> +		ret = btrfs_create_uuid_tree(fs_info);
> +		if (ret) {
> +			btrfs_warn(fs_info,
> +				   "failed to create the UUID tree %d",
> +				   ret);
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>   int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
>   		      char *options)
>   {
> @@ -3218,22 +3265,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (ret)
>   		goto fail_qgroup;
>   
> -	if (!sb_rdonly(sb)) {
> -		ret = btrfs_cleanup_fs_roots(fs_info);
> -		if (ret)
> -			goto fail_qgroup;
> -
> -		mutex_lock(&fs_info->cleaner_mutex);
> -		ret = btrfs_recover_relocation(tree_root);
> -		mutex_unlock(&fs_info->cleaner_mutex);
> -		if (ret < 0) {
> -			btrfs_warn(fs_info, "failed to recover relocation: %d",
> -					ret);
> -			err = -EINVAL;
> -			goto fail_qgroup;
> -		}
> -	}
> -
>   	fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
>   	if (IS_ERR(fs_info->fs_root)) {
>   		err = PTR_ERR(fs_info->fs_root);
> @@ -3286,35 +3317,17 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	}
>   	up_read(&fs_info->cleanup_work_sem);
>   
> -	ret = btrfs_resume_balance_async(fs_info);
> -	if (ret) {
> -		btrfs_warn(fs_info, "failed to resume balance: %d", ret);
> -		close_ctree(fs_info);
> -		return ret;
> -	}
> -
> -	ret = btrfs_resume_dev_replace_async(fs_info);
> +	btrfs_discard_resume(fs_info);
> +	ret = btrfs_mount_rw(fs_info);

You've swapped the order of discard_resume and the mount_rw stuff, which 
can be problematic because the tree log blocks will be marked as free, 
so we could discard them while replaying the log.  The discard_resume 
needs to be moved.  I'd even argue it needs to not be resumed unless 
we're rw, but I haven't looked at the code that closely.  Thanks,

Josef
