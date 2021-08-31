Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71443FCE25
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhHaUHR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 16:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234689AbhHaUHO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 16:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D4356054E;
        Tue, 31 Aug 2021 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630440378;
        bh=scJJ6y3n216BiP5okQ48SVmyGGjmP3BSrlGfWw8Zato=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2N+WJr2aaMPtcSfaLzMHyW+l/D8KDwTt1tISOeXOYNfB8B368Ls9YCuV/QHPM9Ga
         QOS3hgCJD7wokvcZt+XIEQabSNY/qH6pegq93GGXUxBIQFTngZ7O82GPTg+oDZ9+pj
         +HMaEcFiCSpvFfp9lxd/eSfbHvm3K00OL4ynqsg0=
Date:   Tue, 31 Aug 2021 22:06:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     rafael@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] kobject: unexport kobject_create() in kobject.h
Message-ID: <YS6Lt4OCbbauJHXo@kroah.com>
References: <20210831093044.110729-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831093044.110729-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 05:30:44PM +0800, Qu Wenruo wrote:
> The function kobject_create() is only used by one caller,
> kobject_create_and_add(), no other driver uses it, nor is exported to
> other modules.
> 
> However it's still exported in kobject.h, and can sometimes confuse
> users of kobject.h.
> 
> Since all users should call kobject_create_and_add(), or if extra
> attributes are needed, should alloc the memory manually then call
> kobject_init_and_add().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  include/linux/kobject.h | 1 -
>  lib/kobject.c           | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/kobject.h b/include/linux/kobject.h
> index ea30529fba08..efd56f990a46 100644
> --- a/include/linux/kobject.h
> +++ b/include/linux/kobject.h
> @@ -101,7 +101,6 @@ int kobject_init_and_add(struct kobject *kobj,
>  
>  extern void kobject_del(struct kobject *kobj);
>  
> -extern struct kobject * __must_check kobject_create(void);
>  extern struct kobject * __must_check kobject_create_and_add(const char *name,
>  						struct kobject *parent);
>  
> diff --git a/lib/kobject.c b/lib/kobject.c
> index ea53b30cf483..4a56f519139d 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -777,7 +777,7 @@ static struct kobj_type dynamic_kobj_ktype = {
>   * call to kobject_put() and not kfree(), as kobject_init() has
>   * already been called on this structure.
>   */
> -struct kobject *kobject_create(void)
> +static struct kobject *kobject_create(void)
>  {
>  	struct kobject *kobj;
>  
> -- 
> 2.33.0
> 


Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot
