Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCA3FC30F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhHaG6i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 02:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhHaG6i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 02:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D5DB60FC3;
        Tue, 31 Aug 2021 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630393063;
        bh=wHK6qfKX++QAQojCOPGBWYgvRTvoiuHwb2lvUSOyRgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tF0e6avVMLNDG0P1hv7Z95/GvzKvP8ko4m/ynh48kkYGbrwu0dh59TCUptGtiVD4p
         wp2QfXmyRONpwvT9fnAMB/GvbLIBNfT89PhL1Zfh4MIhj2Zmlszrv3NE/o9j80kdCR
         jA31XF38c80symD9YllP2ASzOsIuHToZmYJeM/NA=
Date:   Tue, 31 Aug 2021 08:57:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     rafael@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] kobject: add the missing export for kobject_create()
Message-ID: <YS3S5Nd5YW5pwcta@kroah.com>
References: <20210831065009.29358-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831065009.29358-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 02:50:09PM +0800, Qu Wenruo wrote:
> [BUG]
> For any module utilizing kobject_create(), it will lead to link error:
> 
>   $ make M=fs/btrfs -j12
>     CC [M]  fs/btrfs/sysfs.o
>     LD [M]  fs/btrfs/btrfs.o
>     MODPOST fs/btrfs/Module.symvers
>   ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
>   make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symvers] Error 1
>   make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
>   make: *** [Makefile:1766: modules] Error 2
> 
> [CAUSE]
> It's pretty straight forward, kobject_create() doesn't have
> EXPORT_SYMBOL_GPL().
> 
> [FIX]
> Fix it by adding the missing EXPORT_SYMBOL_GPL().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> A little surprised by the fact that no know even is calling
> kobject_create() now.
> 
> Or should we just call kmalloc() manually then kobject_init_and_add()?
> ---
>  lib/kobject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf483..af308cf7dba2 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
>  	kobject_init(kobj, &dynamic_kobj_ktype);
>  	return kobj;
>  }
> +EXPORT_SYMBOL_GPL(kobject_create);
>  
>  /**
>   * kobject_create_and_add() - Create a struct kobject dynamically and
> -- 
> 2.33.0
> 

What in-kernel module needs to call this function?  No driver should be
messing with calls to kobjects like this.

thanks,

greg k-h
