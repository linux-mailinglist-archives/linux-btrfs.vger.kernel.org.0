Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FD3432B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCUNNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCUNNJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 09:13:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B8C061574;
        Sun, 21 Mar 2021 06:13:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g20so7972191wmk.3;
        Sun, 21 Mar 2021 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JUDymxwtSFHPVgruXaSnC6jMYF9w1F7+yx2+dobVyZs=;
        b=HuidxJ+F1Zrw3v0bs0vQRAO11MELb2JwvFwZl8e1ZEO6iNF2Y4o3tqmXxmv1jeeG92
         bCD3MKJft7Fy54zlIAQ8AA8S8nyBQJT2epRvKjhnPUMKu4uWI1H5khQW/PQ+ERnEgTSA
         xdgF6aOoShvxB5f8A0xyvTRCS6wIbvu5g+9xieUxi+8XfuNY2FxOvgf9H1nZRGPImpl9
         FJrKivC87/yBk2LWr3uUjrav+fgXc3k781Jehafo0V/OT+1X6F+MKuJKm9acfoQ5R881
         xqYapLa+bH0u2VI/tBB2DA0E9iZIqe4z76LpjTvjUZN0TRwDeHQ7npdqI3YAmnGSqpnK
         rqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JUDymxwtSFHPVgruXaSnC6jMYF9w1F7+yx2+dobVyZs=;
        b=YWK5yrDklP+zuE/+vMe7pu4rAD6d0DsX3synmwJlkYJwZZi2dAf15rMSKHkn1sdNjJ
         /2z7EPtdfJIuAV2GCINIOMVTE066PiP/ymFqlHnXQgJECviY5ZQ1J93588c0yjDelrT1
         x9v2oZZPE59pwnMkkqLmHboU4sMQ+5CSQMEzJJpnZe6Yo1CFFRKS9NCD8kf+tTzTVVKy
         d0a3fgy14vFSYp0YHTVNnQcgbVa6ZtxfR+pfnkmOiJQDDkjxkTeoDlZ4XNVFsKdT1hBe
         F7F7/BSOYVBn9zxB/0R+9CR2oXDDfEMe//4Wxkkw4NbHgD0bkwuepn4X5TRxV3IVb3wN
         h8HA==
X-Gm-Message-State: AOAM5309VxXi0tjQ8cfqvLuiHNvZVTOJ30lsMMWY8z40MikpvaBPpxDF
        +AJYmpm3BIEogwhmTjSKsNY=
X-Google-Smtp-Source: ABdhPJxM8Z9nC3zJlY99KJL6mU3eft1ZqI7Phs+GQt+wk9I95j99/YxnT4q20NB3LLaEO5hFsDRwYg==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr11907674wmf.106.1616332387306;
        Sun, 21 Mar 2021 06:13:07 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id 12sm13276817wmw.43.2021.03.21.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 06:13:05 -0700 (PDT)
Date:   Sun, 21 Mar 2021 21:13:01 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/232: fix umount failure due to fsstress still
 running
Message-ID: <YFdGXfemIyoal44X@desktop>
References: <024df0e67e78e0a77fedef4f6451eab6b26326b6.1616068024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024df0e67e78e0a77fedef4f6451eab6b26326b6.1616068024.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 11:48:15AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We start a process that runs fsstress, then kill the process, wait for it
> to die and then end the test, where we attempt to unmount the fs which
> often fails because the fsstress subcommand started by the process is
> still running and using the mount point. This results in a test failure:
> 
>   btrfs/232 1s ... umount: /home/fdmanana/btrfs-tests/scratch_1: target is busy.
>   _check_btrfs_filesystem: filesystem on /dev/sdc is inconsistent
>   (see /home/fdmanana/git/hub/xfstests/results//btrfs/232.full for details)
> 
> Fix that by adding a trap to the writer() function.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for the fix! I missed that in review..

Thanks,
Eryu

> ---
>  tests/btrfs/232 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/btrfs/232 b/tests/btrfs/232
> index b0a04a61..b9841410 100755
> --- a/tests/btrfs/232
> +++ b/tests/btrfs/232
> @@ -32,6 +32,10 @@ _cleanup()
>  
>  writer()
>  {
> +	# Wait for running fsstress subcommand before exitting so that
> +	# mountpoint is not busy when we try to unmount it.
> +	trap "wait; exit" SIGTERM
> +
>  	while true; do
>  		args=`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
>  		$FSSTRESS_PROG $args >/dev/null 2>&1
> -- 
> 2.28.0
