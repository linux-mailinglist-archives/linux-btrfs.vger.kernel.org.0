Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28B695547
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 01:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBNAOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 19:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBNAOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 19:14:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9C18AB6;
        Mon, 13 Feb 2023 16:14:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78B94CE0B97;
        Tue, 14 Feb 2023 00:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551A7C433D2;
        Tue, 14 Feb 2023 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676333664;
        bh=YALIEKwDWeTS5hkjQM1YsNTXDG41DravRixOrdPsrZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZw2RRzWn+O1Z5oeIlFWqKh2uLq2OKCjfmo2wAA3qpDnxpdyG34A37APcsyu1QjEX
         n+hVbRUpIgCYhfRmjxINoWcIrAYeRqaToH4bSLJoDWClXlQVlhGayUU3Fq678NezBB
         2FTLAZpFFlpM4bWjdmENGrYCjcuOzrBN7R0+ZkyjFoML9DxtcQN/uW/A3BJi6x20e8
         /M6O9kxhwt7tX/X8F/eR5V+snKzOZgl7t3ASwgH4eQ5kirosoVy+Y1LZe+pXpxkMU4
         dmzmJN/+xauJB6OxrRcKSjpat9sTX99g7ojKuvd0Zg6owO17vIdDvwRqmjMRHntJq4
         MTahIZ3aYj4XA==
Date:   Mon, 13 Feb 2023 17:14:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     gregkh@linuxfoundation.org, chenwandun@huawei.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH -next v2 1/3] driver core: add error handling for
 devtmpfs_create_node()
Message-ID: <Y+rSXg14z1Myd8Px@dev-arch.thelio-3990X>
References: <20230210095444.4067307-1-xialonglong1@huawei.com>
 <20230210095444.4067307-2-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210095444.4067307-2-xialonglong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Longlong,

On Fri, Feb 10, 2023 at 09:54:42AM +0000, Longlong Xia wrote:
> In some cases, devtmpfs_create_node() can return error value.
> So, make use of it.
> 
> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> ---
>  drivers/base/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7dab705f2937..aaa3088e5456 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3405,7 +3405,9 @@ int device_add(struct device *dev)
>  		if (error)
>  			goto SysEntryError;
>  
> -		devtmpfs_create_node(dev);
> +		error = devtmpfs_create_node(dev);
> +		if (error)
> +			goto DevtmpfsError;
>  	}
>  
>  	/* Notify clients of device addition.  This call must come
> @@ -3461,6 +3463,8 @@ int device_add(struct device *dev)
>  done:
>  	put_device(dev);
>  	return error;
> + DevtmpfsError:
> +	device_remove_sys_dev_entry(dev);
>   SysEntryError:
>  	if (MAJOR(dev->devt))
>  		device_remove_file(dev, &dev_attr_dev);
> -- 
> 2.25.1
> 

After this change in -next as commit 31b4b6730fd4 ("driver core: add
error handling for devtmpfs_create_node()"), my test machines failed to
boot after the rootfs could not be mounted. I added some logging to see
which device was failing, which triggers a few times with the exact same
message:

  device: 'btrfs-control': devtmpfs_create_node() failed, err = -17

with -17 being -EEXIST. I am not sure why this device is getting
registered more than once, it appears to occur during module insertion
though, as I am able to get to systemd starting within the initrd.

Should this particular return value be downgraded to a warning so that
the device still loads or should the driver be fixed? I have cc'd the
btrfs mailing list, in case they have any input.

Cheers,
Nathan
