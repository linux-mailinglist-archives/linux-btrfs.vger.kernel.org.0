Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66D725CC75
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICVkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICVkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 17:40:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F27C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 14:40:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so4503654qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LQxz2ToSwsyB9OjRXX/QRAVeXXxaCh7pVgKWnv73MRA=;
        b=clpVgk5VXULmciF0Vppb11O/KZhDBp2eGSxgTWcN6hNtoh1FcqhWzDSb2uwowAlowW
         HR8Kvo0kIW1Y2CaAdp18ffejPMLA4nOlczuuaaExdzUVau0LdDvi63xmywQoRKeRPWq4
         YPYoWmce1WScD/BGYNh8OKFG8BIyoNo6vN2QTHh1cVQ8JcGQyJHWMdHqt/lKr45ITRCp
         at0niT4wcXby6JORPtUky64NsWklgTUDdm8W1bcEDfpq1rKxtYXsbUoJ4EbZ7vhZe6nn
         dLROoWuKJcRby41tdj+9binB/pxONbtd70YWM1NKILlQtHhKKP1woou9arwvDpofsyca
         SbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LQxz2ToSwsyB9OjRXX/QRAVeXXxaCh7pVgKWnv73MRA=;
        b=jkeSWhPuyR/0t7QxN4mIaa8JigkoAJ9sUNV9dLuzGNp8FcZFvQiY1c6Sk+Z4xWoZPD
         GYusyNaECZqV+HQ3AZ8xMnG4eYM23qxYcpfH765/i4RXYsMZ8QqE1fLj8JXmoAHL83cT
         4Vpaln7vb2R+X1HpKn63X0TgL2SZbqAIeLn++Sff4MWQW8Yu35z8ZyjrxaNTDnpOHJTa
         ut4euLp/TSmRz1LKaviIzNleQAsFSi6ckw2j3sa0awxW4Acc/DKjgHvC8/yqeLOCRddT
         R3BMPSR55+Osfb84+qbzIyVemUwkTJqX9OUHoBl4DtkQytjR4tFXMD0be/cTsHxY84bu
         fTrg==
X-Gm-Message-State: AOAM530AUvdOqo5QrAK6nbnNGQ2EXOI+Q/3J4l5/lH9wRbQ0bZsR3JJJ
        TI5f4F5lTqNZD75vaSvjSq85sA==
X-Google-Smtp-Source: ABdhPJwCuYYXV+kIV3YMTuw21YtvEomPBSs+0a+VQ5+d9GqymGJGAKLpPM8qWXSO7dl66CUS95fhrg==
X-Received: by 2002:a05:620a:1015:: with SMTP id z21mr5323978qkj.2.1599169241091;
        Thu, 03 Sep 2020 14:40:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11a2? ([2620:10d:c091:480::1:9e05])
        by smtp.gmail.com with ESMTPSA id f127sm2983640qke.133.2020.09.03.14.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 14:40:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: support remount of ro fs with free space tree
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599164377.git.boris@bur.io>
 <dea5fb2c9131b0b1c274f011596e5798fdc1971d.1599164377.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d21b0694-2ff6-dba0-2c93-ceaef0c0bed8@toxicpanda.com>
Date:   Thu, 3 Sep 2020 17:40:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <dea5fb2c9131b0b1c274f011596e5798fdc1971d.1599164377.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 4:33 PM, Boris Burkov wrote:
> When a user attempts to remount a btrfs filesystem with
> 'mount -o remount,space_cache=v2', that operation succeeds.
> Unfortunately, this is misleading, because the remount does not create
> the free space tree. /proc/mounts will incorrectly show space_cache=v2,
> but on the next mount, the file system will revert to the old
> space_cache.
> 
> For now, we handle only the easier case, where the existing mount is
> read only. In that case, we can create the free space tree without
> contending with the block groups changing as we go. If it is not read
> only, we fail more explicitly so the user knows that the remount was not
> successful, and we don't end up in a state where /proc/mounts is giving
> misleading information.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/super.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3ebe7240c63d..cbb2cdb0b488 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -47,6 +47,7 @@
>   #include "tests/btrfs-tests.h"
>   #include "block-group.h"
>   #include "discard.h"
> +#include "free-space-tree.h"
>   
>   #include "qgroup.h"
>   #define CREATE_TRACE_POINTS
> @@ -1862,6 +1863,22 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	btrfs_resize_thread_pool(fs_info,
>   		fs_info->thread_pool_size, old_thread_pool_size);
>   
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
> +	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> +		if (!sb_rdonly(sb)) {
> +			btrfs_warn(fs_info, "cannot create free space tree on writeable mount");
> +			ret = -EINVAL;
> +			goto restore;
> +		}
> +		btrfs_info(fs_info, "creating free space tree");
> +		ret = btrfs_create_free_space_tree(fs_info);
> +		if (ret) {
> +			btrfs_warn(fs_info,
> +				   "failed to create free space tree: %d", ret);
> +			goto restore;
> +		}
> +	}
> +

This whole chunk actually needs to be moved down into the

} else {
	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {

bit, and after all the checks to make sure it's ok to flip RW, but _before_ we 
do btrfs_cleanup_roots.

Also put a comment there saying something like

/*
  * Don't do anything that writes above this, otherwise bad things will happen.
  */

So that nobody accidentally messes this up in the future.  Thanks,

Josef
