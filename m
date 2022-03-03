Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFA4CBDE6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 13:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiCCMiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 07:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiCCMiX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 07:38:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0811A3D
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 04:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D104DB8250A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 12:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80400C004E1
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646311054;
        bh=UM9ewXqZbkqAPrKALFl+PWtVtgHe80FfXlp1KkwJDyY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Cv3FLR53T1+5nSd9iDvs1eSKcv+XRF8cu+2rkV4odp5w/+4O4HQxYtYC+SVPFNk43
         YBCFTAOazGSuSHBb9E7CB3ZGmSRq5goHye4T2z8jh6fC//xRM41z8K5Le1waXpBCfR
         PVB5ZrwVUX64H/BQGf/pxgXyuAq2jLBtVLDGyt9IfJA1O6mZ2SyhD8Lfa22WnoX7L0
         6nDpZVJK/MBInqouI8vD1VpiZc7xinScFOn9QTf8g+WH9o52+u9pIcZMXjfArn77Dm
         2gWxreH8u/RrlcsTW35b75EtAJlpzhlIWe/KnQIUtupymPrFD45GpPWV3yvv9hXOW7
         BsHh89Dwvz39w==
Date:   Thu, 3 Mar 2022 12:37:28 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix a NULL pointer dereference during device scan
Message-ID: <YiC2iL8KGKwR/TTN@debian9.Home>
References: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a7cc9b024432855337990f471b91054504cc92.1646306515.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 03, 2022 at 11:25:55AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At device_list_add(), we dereference a device's name inside a
> btrfs_info_in_rcu() that is executed in a branch that can be triggered
> when the device's name field is NULL, which obviously results in a NULL
> pointer dereference as rcu_str_deref() tries to access the ->str
> attribute of a NULL pointer to a struct rcu_string.
> 
> Fix that by not dereferencing the name if it's NULL, and instead print
> the string "<unknown>".
> 
> Link: https://lore.kernel.org/linux-btrfs/00000000000066b78e05d94df48b@google.com/
> Reported-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/volumes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7fee09e39b..f662423fbeb7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -940,7 +940,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  			}
>  			btrfs_info_in_rcu(device->fs_info,
>  	"devid %llu device path %s changed to %s scanned by %s (%d)",
> -					  devid, rcu_str_deref(device->name),
> +					  devid, device->name ?
> +					  rcu_str_deref(device->name) :
> +					  "<unknown>",

Taking a better look, device->name shouldn't ever be NULL here because
we have checked device->bdev is set.

So drop this change.

Thanks.

>  					  path, current->comm,
>  					  task_pid_nr(current));
>  		}
> -- 
> 2.33.0
> 
