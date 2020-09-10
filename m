Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B32652F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgIJV0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbgIJOXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952AC061343
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:05:42 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so6135189qki.6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gK+DHBxQ6JMP/98j0PyVg4nf++9F3xbTOlpKHzYGFPo=;
        b=b9TRwHNxn4PPf4iwja7ivv9hklywDq723I97mg2zQNE4KMSeiX2qQr4Ho5SAhDvrn0
         EAoQDSSSOR44SxVHOIRIPx+y753sWNuVgtoDWuhy+yW95VC9AL2EDX9GnfI7GMGEVdHK
         Pv1ctNd/wwmVoAS95HBfcH424b4dHLIFj9oTIkN5zzkW/gGEZ5wgyPbrgux9M/kSSc3A
         UHCzmEU8zVGv3vKjPOoL+3p9AJth462kcKYJIxbE2uu/nAAFr8V2uHRlAz+RYoyoNS+6
         unFWoyyzdMnPeP4FM1/EDE1V0VkzFSNN5fKiB41zEAFio2AWaP3KrLC04I6zMfupUWLJ
         8sRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gK+DHBxQ6JMP/98j0PyVg4nf++9F3xbTOlpKHzYGFPo=;
        b=fOVCI8jRts34c8fM4z5A/T1E9j0yyBAmPvUgUYF09S4Iy6ZDXElZwlq/V0yMlIl64Q
         2eLQZdXIkN5rFQ1fupSN1O9fnMsT4kWFX0vnkxCkYi6fRKlqTH6r4KN5WaRABLpnFm/U
         cDN7syUGWlOFuLNXvM19/FBhqGUQqm2ycRPaL8l+gRhb/wSoPCS/lMUZDi2Icf/7aF2F
         WJfLlWddn4eaiWg4DBlWx5myQIG/G8BM52k1/opC/YjPBHSXJQ9AprgCYakKtcUcmlm+
         nSyq5KmwQYzYsJQQ2YYY6iVnBRm+h7kLAXf2zBY1Hln4u5XDpJvR+Up5/vbUciVCb8Xe
         lVVg==
X-Gm-Message-State: AOAM533b4lBY8gptgH2Px6d6Dvwa0ilL13FciDj4Okwb0c2fiZDdAsDd
        s7LIR/HQkZqsRkAnxLcEUsi3kx4BrKCC/uaE
X-Google-Smtp-Source: ABdhPJw6RTtDu3wQskgUrdaA+mXA8ie0wnSZm+Q9AQqnHzrDBMXAQ1eZyMGQlEnh1duzFJNBsBzNjw==
X-Received: by 2002:a37:a617:: with SMTP id p23mr7909733qke.95.1599746742001;
        Thu, 10 Sep 2020 07:05:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm6631753qkg.40.2020.09.10.07.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:05:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] btrfs: support remount of ro fs with free space
 tree
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599686801.git.boris@bur.io>
 <9bca6fcf34bffc73c42323c9f79f5c1a9e6ef131.1599686801.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <812d62a6-3afc-b30b-e15e-f9cc58ba2aa8@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:05:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9bca6fcf34bffc73c42323c9f79f5c1a9e6ef131.1599686801.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:45 PM, Boris Burkov wrote:
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
> misleading information. We also fail if the remount is read-only, since
> we would not be able to create the free space tree in that case.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> v2:
> - move creation down to ro->rw case
> - error on all other remount cases
> - add a comment to help future remount modifiers
> 
>   fs/btrfs/super.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 3ebe7240c63d..0a1b5f554c27 100644
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
> @@ -1838,6 +1839,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	u64 old_max_inline = fs_info->max_inline;
>   	u32 old_thread_pool_size = fs_info->thread_pool_size;
>   	u32 old_metadata_ratio = fs_info->metadata_ratio;
> +	bool create_fst = false;
>   	int ret;
>   
>   	sync_filesystem(sb);
> @@ -1862,6 +1864,17 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>   	btrfs_resize_thread_pool(fs_info,
>   		fs_info->thread_pool_size, old_thread_pool_size);
>   
> +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) &&
> +	    !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> +		create_fst = true;
> +		if(!sb_rdonly(sb) || *flags & SB_RDONLY) {
> +			btrfs_warn(fs_info,
> +				   "Remounting with free space tree only allowed from read-only to read-write");
> +			ret = -EINVAL;
> +			goto restore;
> +		}
> +	}

This will bite us if we remount -o ro,noatime but had previous mounted with -o 
ro,space_cache=v2.  These checks need to be under

> +
>   	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
>   		goto out;
>   

This part right here.  Put the check for remounting RO with space_cache=v2 in 
that part, and the check if we need to create the fst at all down where you 
create it.  Thanks,

Josef
