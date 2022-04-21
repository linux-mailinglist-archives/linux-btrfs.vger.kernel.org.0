Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63DA509E04
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388521AbiDUKu3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbiDUKu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 06:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204285FE1;
        Thu, 21 Apr 2022 03:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6EF461A7C;
        Thu, 21 Apr 2022 10:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF673C385A5;
        Thu, 21 Apr 2022 10:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650538057;
        bh=UB/wj7Q5GrgKrtaTY9oAg++NK8E5bgXvVO35tjMchH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUdwbHoj/T4pxwvFzDFT9UDg+MNNMxcQchGoaIti9d6F23eznnuruZ9yJqn72Je09
         iap9idw8HdZF2t3rzsclNEvtv/qcx9IPOjNIkjTHw8Sf/A9O+vvwJjusSq8FrpNeNR
         Xrz5pema0o6p8gATJuMK587da1Lp0K1dAxHix7w+QN9WMWPhgEsVCYnrTF20H+3Jc6
         NAKPCY38mblBzSyR5kywBBgi/f85no4oUsZ8LI8QUPEv5ccouvTTRo1JmgsBx6zwfN
         Yn0XZ2g5uDYa1E2xr0Zh5bmNrvEgRSSa5nTbRSiPSSeAkHGkqX/SRDRW/HYm30h4M/
         Vc2jj5MEMfoQg==
Date:   Thu, 21 Apr 2022 11:47:33 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Message-ID: <YmE2RV6yqDeghFJn@debian9.Home>
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 05:51:17PM +0800, Haowen Bai wrote:
> Free "bargs" before return.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  fs/btrfs/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index f08233c2b0b2..d4c8bea914b7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4389,13 +4389,13 @@ static long btrfs_ioctl_balance(struct file *file, void __user *arg)
>  			/* this is (2) */
>  			mutex_unlock(&fs_info->balance_mutex);
>  			ret = -EINPROGRESS;
> -			goto out;
> +			goto out_bargs;
>  		}
>  	} else {
>  		/* this is (1) */
>  		mutex_unlock(&fs_info->balance_mutex);
>  		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> -		goto out;
> +		goto out_bargs;

In addition to Qu's comment about the double unlock, this is also a fix
for a recent patch that is not yet on Linus' tree:

    btrfs: simplify codeflow in btrfs_ioctl_balance

    (https://lore.kernel.org/linux-btrfs/20220330091407.1319454-4-nborisov@suse.com/)

Something usually worth mentioning, as we can't add a Fixes tag in this
case.

Thanks.

>  	}
>  
>  locked:
> -- 
> 2.7.4
> 
