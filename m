Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8531A85D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 00:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBLXhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Feb 2021 18:37:11 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:18838 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLXhL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Feb 2021 18:37:11 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4DcqdS2Jp2z2d;
        Sat, 13 Feb 2021 00:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1613172988; bh=1LIPV2cA41mWUhh9p8sX1mkd4boZDMkZYUfcvKjKciA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqWjAImNL+CwZRFOURoGv1b76qCHUxxwGVLBEtzkHKNvzVDjcldzajoLDOSofVGtr
         q9xMG7KBw5zL3eerdDnvmcbahqcqeAeeDzinN0Xsmq13nwHoFou4xxSSWkGWppkrQ4
         iPF6ypjXlV02pEY1yzrjGa0FzAgUA6syuACcE35KRIIaaj8sZgwBZgtt6O2XIwtXmf
         mZur81wnmmBfKrLMEyuF1UAUhm59rUhEZsV2bwdVot64WY6DR7VCZs2Jzqq03OB0Ju
         vMjkxgfKSLTeq3AZS1iPVDSKFkbj1qCosCUwPM9YbD22NjmB8aAmdOCPGehU0yEoDT
         ptqx+p6svNk2Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 13 Feb 2021 00:36:02 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type
 of devices
Message-ID: <20210212233602.GA30441@qmqm.qmqm.pl>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-5-mrostecki@suse.de>
 <20210210040805.GB12086@qmqm.qmqm.pl>
 <20210212182641.GB20817@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212182641.GB20817@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 12, 2021 at 06:26:41PM +0000, Michal Rostecki wrote:
> On Wed, Feb 10, 2021 at 05:08:05AM +0100, Micha³ Miros³aw wrote:
> > On Tue, Feb 09, 2021 at 09:30:38PM +0100, Michal Rostecki wrote:
> > > From: Michal Rostecki <mrostecki@suse.com>
> > > 
> > > Add the btrfs_check_mixed() function which checks if the filesystem has
> > > the mixed type of devices (non-rotational and rotational). This
> > > information is going to be used in roundrobin raid1 read policy.a
> > [...]
> > > @@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
> > >  	}
> > >  
> > >  	q = bdev_get_queue(bdev);
> > > -	if (!blk_queue_nonrot(q))
> > > +	rotating = !blk_queue_nonrot(q);
> > > +	device->rotating = rotating;
> > > +	if (rotating)
> > >  		fs_devices->rotating = true;
> > > +	if (!fs_devices->mixed)
> > > +		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
> > [...]
> > 
> > Since this is adding to a set, a faster way is:
> > 
> > if (fs_devices->rotating != rotating)
> > 	fs_devices->mixed = true;
> > 
> > The scan might be necessary on device removal, though.
> Actually, that's not going to work in case of appenging a rotational
> device when all previous devices are non-rotational.
[...]
> Inverting the order of those `if` checks would break the other
> permuitations which start with rotational disks.

But not if you would add:

if (adding first device)
	fs_devices->rotating = rotating;

before the checks.

But them, there is a simpler way: count how many rotating vs non-rotating
devices there are while adding them. Like:

rotating ? ++n_rotating : ++n_fixed;

And then on remove you'd have it covered.

Best Regards
Micha³ Miros³aw
