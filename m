Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA13931BB4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBOOlW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 09:41:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:49828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBOOlJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 09:41:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 785F1AC69;
        Mon, 15 Feb 2021 14:40:27 +0000 (UTC)
Date:   Mon, 15 Feb 2021 14:40:26 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type
 of devices
Message-ID: <20210215144026.GB21872@wotan.suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-5-mrostecki@suse.de>
 <20210210040805.GB12086@qmqm.qmqm.pl>
 <20210212182641.GB20817@wotan.suse.de>
 <20210212233602.GA30441@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212233602.GA30441@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 13, 2021 at 12:36:02AM +0100, Michał Mirosław wrote:
> On Fri, Feb 12, 2021 at 06:26:41PM +0000, Michal Rostecki wrote:
> > On Wed, Feb 10, 2021 at 05:08:05AM +0100, Michał Mirosław wrote:
> > > On Tue, Feb 09, 2021 at 09:30:38PM +0100, Michal Rostecki wrote:
> > > > From: Michal Rostecki <mrostecki@suse.com>
> > > > 
> > > > Add the btrfs_check_mixed() function which checks if the filesystem has
> > > > the mixed type of devices (non-rotational and rotational). This
> > > > information is going to be used in roundrobin raid1 read policy.a
> > > [...]
> > > > @@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> > > >  	}
> > > >  
> > > >  	q = bdev_get_queue(bdev);
> > > > -	if (!blk_queue_nonrot(q))
> > > > +	rotating = !blk_queue_nonrot(q);
> > > > +	device->rotating = rotating;
> > > > +	if (rotating)
> > > >  		fs_devices->rotating = true;
> > > > +	if (!fs_devices->mixed)
> > > > +		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
> > > [...]
> > > 
> > > Since this is adding to a set, a faster way is:
> > > 
> > > if (fs_devices->rotating != rotating)
> > > 	fs_devices->mixed = true;
> > > 
> > > The scan might be necessary on device removal, though.
> > Actually, that's not going to work in case of appenging a rotational
> > device when all previous devices are non-rotational.
> [...]
> > Inverting the order of those `if` checks would break the other
> > permuitations which start with rotational disks.
> 
> But not if you would add:
> 
> if (adding first device)
> 	fs_devices->rotating = rotating;
> 
> before the checks.
> 
> But them, there is a simpler way: count how many rotating vs non-rotating
> devices there are while adding them. Like:
> 
> rotating ? ++n_rotating : ++n_fixed;
> 
> And then on remove you'd have it covered.

I like the idea of storing numbers and simply checking them. I use it in
v2 - though probably in a different form, and I will most likely move
the whole logic around checking device types to separate functions, to
not bloat btrfs_open_one_device() and the others too much.
