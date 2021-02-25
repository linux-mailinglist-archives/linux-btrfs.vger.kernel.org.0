Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED351325294
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Feb 2021 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYPnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Feb 2021 10:43:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:39890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBYPnE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Feb 2021 10:43:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E217CACE5;
        Thu, 25 Feb 2021 15:42:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DDA9DA790; Thu, 25 Feb 2021 16:40:29 +0100 (CET)
Date:   Thu, 25 Feb 2021 16:40:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, 'Chris Murphy ' <lists@colorremedies.com>
Subject: Re: [PATCH] btrfs: fix spurious free_space_tree remount warning
Message-ID: <20210225154029.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, 'Chris Murphy ' <lists@colorremedies.com>
References: <4a019f01584f1d818203b7c2ed65204583a11592.1614104082.git.boris@bur.io>
 <8769846e-68b2-766f-5fdd-43ffb79f4586@suse.com>
 <20210225145920.GC7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225145920.GC7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 25, 2021 at 03:59:20PM +0100, David Sterba wrote:
> On Tue, Feb 23, 2021 at 08:28:10PM +0200, Nikolay Borisov wrote:
> > 
> > 
> > On 23.02.21 г. 20:22 ч., Boris Burkov wrote:
> > > The intended logic of the check is to catch cases where the desired
> > > free_space_tree setting doesn't match the mounted setting, and the
> > > remount is anything but ro->rw. However, it makes the mistake of
> > > checking equality on a masked integer (btrfs_test_opt) against a boolean
> > > (btrfs_fs_compat_ro).
> > > 
> > > If you run the reproducer:
> > > mount -o space_cache=v2 dev mnt
> > > mount -o remount,ro mnt
> > > 
> > > you would expect no warning, because the remount is not attempting to
> > > change the free space tree setting, but we do see the warning.
> > > 
> > > To fix this, convert the option test to a boolean.
> > > 
> > > I tested a variety of transitions:
> > > sudo mount -o space_cache=v2 /dev/vg0/lv0 mnt/lol
> > > (fst enabled)
> > > mount -o remount,ro mnt/lol
> > > (no warning, no fst change)
> > > sudo mount -o remount,rw,space_cache=v1,clear_cache
> > > (no warning, ro->rw)
> > > sudo mount -o remount,rw,space_cache=v2 mnt
> > > (warning, rw->rw with change)
> > > sudo mount -o remount,ro mnt
> > > (no warning, no fst change)
> > > sudo mount -o remount,rw,space_cache=v2 mnt
> > > (no warning, no fst change)
> > > 
> > > Reported-by: Chris Murphy <lists@colorremedies.com>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/super.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index f8435641b912..d4992ceab5ea 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -1918,7 +1918,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> > >  	btrfs_resize_thread_pool(fs_info,
> > >  		fs_info->thread_pool_size, old_thread_pool_size);
> > >  
> > > -	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
> > > +	if (!!btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
> > 
> > I'd rather thave the !! convert to  bool magic in the macro definition i.e : 
> > 
> > #define btrfs_test_opt(fs_info, opt)    !!((fs_info)->mount_opt & \               
> >                                                BTRFS_MOUNT_##opt)                     
> 
> Yeah, that sounds safer and we should convert all predicate functions to
> bool eg. __btrfs_fs_compat_ro. The whole value of the macro needs to be
> in ( .. ) too.

For the minimal quick fix I'd add (bool) cast to both sides of == so
it's clear and then we can do further cleanups in separate patches.
