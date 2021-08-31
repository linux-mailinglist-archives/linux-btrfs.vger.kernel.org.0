Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5693FCE23
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 22:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhHaUF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 16:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhHaUF4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 16:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 739FC6108B;
        Tue, 31 Aug 2021 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630440300;
        bh=Z4VyIS4V2ccFAu8cyFW9Vk8zYcbKFk5BWzmgrGc20hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckrN7wQu4v/wTHWkukCBDmxMQFTGqJ5zeOFoSWVJyUYbM2rEheLQJc1ztLTr1OAz5
         GvA/Xup23SIhSIQDWfuRaAb114faGwW9N8i87hBdSkdurJIAGQ0hyd9FY9VujDGTX2
         ipFTUZAC/vG9ZG+ji7mdGdwr0DpbS05vOWN+Ezso=
Date:   Tue, 31 Aug 2021 22:04:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     rafael@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] kobject: add the missing export for kobject_create()
Message-ID: <YS6Laf6AT3Bhwxeq@kroah.com>
References: <20210831065009.29358-1-wqu@suse.com>
 <YS3S5Nd5YW5pwcta@kroah.com>
 <9236c202-03f0-e42f-e9c0-cde6a5bfad19@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9236c202-03f0-e42f-e9c0-cde6a5bfad19@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 03:53:02PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/8/31 下午2:57, Greg KH wrote:
> > On Tue, Aug 31, 2021 at 02:50:09PM +0800, Qu Wenruo wrote:
> > > [BUG]
> > > For any module utilizing kobject_create(), it will lead to link error:
> > > 
> > >    $ make M=fs/btrfs -j12
> > >      CC [M]  fs/btrfs/sysfs.o
> > >      LD [M]  fs/btrfs/btrfs.o
> > >      MODPOST fs/btrfs/Module.symvers
> > >    ERROR: modpost: "kobject_create" [fs/btrfs/btrfs.ko] undefined!
> > >    make[1]: *** [scripts/Makefile.modpost:150: fs/btrfs/Module.symvers] Error 1
> > >    make[1]: *** Deleting file 'fs/btrfs/Module.symvers'
> > >    make: *** [Makefile:1766: modules] Error 2
> > > 
> > > [CAUSE]
> > > It's pretty straight forward, kobject_create() doesn't have
> > > EXPORT_SYMBOL_GPL().
> > > 
> > > [FIX]
> > > Fix it by adding the missing EXPORT_SYMBOL_GPL().
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > > A little surprised by the fact that no know even is calling
> > > kobject_create() now.
> > > 
> > > Or should we just call kmalloc() manually then kobject_init_and_add()?
> > > ---
> > >   lib/kobject.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index ea53b30cf483..af308cf7dba2 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -788,6 +788,7 @@ struct kobject *kobject_create(void)
> > >   	kobject_init(kobj, &dynamic_kobj_ktype);
> > >   	return kobj;
> > >   }
> > > +EXPORT_SYMBOL_GPL(kobject_create);
> > >   /**
> > >    * kobject_create_and_add() - Create a struct kobject dynamically and
> > > -- 
> > > 2.33.0
> > > 
> > 
> > What in-kernel module needs to call this function?  No driver should be
> > messing with calls to kobjects like this.
> 
> But kobject_create_and_add() can't specify ktype if we want extra attributes
> to the new kobject.

You didn't answer this question, what in-kernel driver needs this?  We
do not export things that are not needed to be exported.

> Or is the following way the preferred call style?
> 
> local_kobj = kmalloc();
> ret = kobject_init_and_add();

Depends on your need.

Why do you need to call this function from a module?

thanks,

greg k-h
