Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504F2BB067
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgKTQXU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 11:23:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:37612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729953AbgKTQXT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 11:23:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E115ACBF;
        Fri, 20 Nov 2020 16:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A386EDA6E1; Fri, 20 Nov 2020 17:21:31 +0100 (CET)
Date:   Fri, 20 Nov 2020 17:21:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Message-ID: <20201120162131.GT20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
References: <e639c7a057653c1947b3a4acf2fba6c7798000b5.1605690144.git.johannes.thumshirn@wdc.com>
 <64eb0192-1997-89ee-25d0-94cc0ec93bfb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64eb0192-1997-89ee-25d0-94cc0ec93bfb@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 05:28:57PM +0800, Anand Jain wrote:
> On 18/11/20 5:03 pm, Johannes Thumshirn wrote:
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -940,7 +940,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >   			if (device->bdev != path_bdev) {
> >   				bdput(path_bdev);
> >   				mutex_unlock(&fs_devices->device_list_mutex);
> > -				btrfs_warn_in_rcu(device->fs_info,
> > +				/*
> > +				 * device->fs_info may not be reliable here, so
> > +				 * pass in a NULL fs_info. This avoids a
> > +				 * possible use-after-free when the fs_info and
> > +				 * fs_info->sb are already torn down.
> > +				 */
> > +				btrfs_warn_in_rcu(NULL,
> >   	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
> >   						  path, devid, found_transid,
> >   						  current->comm,
> > 
> 
> Few lines below, there is btrfs_info_in_rcu() and, we won't have
> reliable device->fs_info even there. But we have seen those info
> quite a lot of times. And so far, it's been ok. So

Right, this also looks like potentially unsafe use but given that the
2nd print is still under device_list_mutex it think it will be harder
to hit.
