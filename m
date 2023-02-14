Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCB695562
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 01:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBNAdM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 19:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBNAdL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 19:33:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E35FEE;
        Mon, 13 Feb 2023 16:33:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8359161321;
        Tue, 14 Feb 2023 00:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695ACC433D2;
        Tue, 14 Feb 2023 00:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676334788;
        bh=1ymseE1gp5qMZ4fK6OR64Bt4GpPkoCf6SwlltlIgmWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTsuvEPk/1lZqAbz7kX4AEo503bxxPYd7VC18LinOA5jekrNF/QXwPlkEfhud0zbs
         Myb35+Rl9MtrbCCB7ul40XKe7E3MTHT7JwidO+AzfqV1/OPt2M8zZ5ohAJVKZTYrWQ
         pXdk+EwEr0JHWxuLtdnuz4A0lSuB1Jvmqr7tbg/Am+4gXnl1wzbFRI6UWlEzPBKpxI
         dffCfe7H7Qs2kTc+MwtQ02nB39vW5jz463fcNs8Ua4Lz7YcQw8tmQwXWU15GpOu2sO
         1zpIehswoCD1KqHj7HCnHsU/ACSIVVRT9dV8IYe0UdVdpSeGgXA931L/nNKW1h68YF
         71XUDBd5JfQZg==
Date:   Mon, 13 Feb 2023 17:33:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     gregkh@linuxfoundation.org, chenwandun@huawei.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH -next v2 1/3] driver core: add error handling for
 devtmpfs_create_node()
Message-ID: <Y+rWwtjVBDHHVzB3@dev-arch.thelio-3990X>
References: <20230210095444.4067307-1-xialonglong1@huawei.com>
 <20230210095444.4067307-2-xialonglong1@huawei.com>
 <Y+rSXg14z1Myd8Px@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+rSXg14z1Myd8Px@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 05:14:27PM -0700, Nathan Chancellor wrote:
> Hi Longlong,
> 
> On Fri, Feb 10, 2023 at 09:54:42AM +0000, Longlong Xia wrote:
> > In some cases, devtmpfs_create_node() can return error value.
> > So, make use of it.
> > 
> > Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> > ---
> >  drivers/base/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 7dab705f2937..aaa3088e5456 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -3405,7 +3405,9 @@ int device_add(struct device *dev)
> >  		if (error)
> >  			goto SysEntryError;
> >  
> > -		devtmpfs_create_node(dev);
> > +		error = devtmpfs_create_node(dev);
> > +		if (error)
> > +			goto DevtmpfsError;
> >  	}
> >  
> >  	/* Notify clients of device addition.  This call must come
> > @@ -3461,6 +3463,8 @@ int device_add(struct device *dev)
> >  done:
> >  	put_device(dev);
> >  	return error;
> > + DevtmpfsError:
> > +	device_remove_sys_dev_entry(dev);
> >   SysEntryError:
> >  	if (MAJOR(dev->devt))
> >  		device_remove_file(dev, &dev_attr_dev);
> > -- 
> > 2.25.1
> > 
> 
> After this change in -next as commit 31b4b6730fd4 ("driver core: add
> error handling for devtmpfs_create_node()"), my test machines failed to
> boot after the rootfs could not be mounted. I added some logging to see
> which device was failing, which triggers a few times with the exact same
> message:
> 
>   device: 'btrfs-control': devtmpfs_create_node() failed, err = -17
> 
> with -17 being -EEXIST. I am not sure why this device is getting
> registered more than once, it appears to occur during module insertion
> though, as I am able to get to systemd starting within the initrd.
> 
> Should this particular return value be downgraded to a warning so that
> the device still loads or should the driver be fixed? I have cc'd the
> btrfs mailing list, in case they have any input.

Apologies, I see now that the second patch in this series is logging for
this, sorry for not using or noticing that sooner.

I am now looking at some of my other test machines and I see messages
similar to the one above for other devices:

[   16.268685] sound timer: failed to create snd/timer, ret = -17
[   16.274666] ALSA: unable to register timer device (-17)
[   16.500253] sound timer: failed to create snd/timer, ret = -17
[   16.506124] ALSA: unable to register timer device (-17)

[   18.273067] misc rfkill: failed to create rfkill, ret = -17
[   18.464836] misc rfkill: failed to create rfkill, ret = -17
[   19.366149] misc tun: failed to create net/tun, ret = -17
[   19.371613] tun: Can't register misc device 200
[   19.552362] misc tun: failed to create net/tun, ret = -17
[   19.557839] tun: Can't register misc device 200
[   23.124993] misc tun: failed to create net/tun, ret = -17
[   23.130460] tun: Can't register misc device 200
[   23.299267] misc tun: failed to create net/tun, ret = -17
[   23.299319] tun: Can't register misc device 200
[   27.050363] misc tun: failed to create net/tun, ret = -17
[   27.055824] tun: Can't register misc device 200
[   27.181496] misc tun: failed to create net/tun, ret = -17

So it seems like this is not a btrfs specific problem?

Cheers,
Nathan
