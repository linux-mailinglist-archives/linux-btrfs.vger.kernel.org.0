Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B578BCEA08
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfJGRCx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 13:02:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfJGRCx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 13:02:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A627CACC0;
        Mon,  7 Oct 2019 17:02:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF2E9DA7FB; Mon,  7 Oct 2019 19:03:06 +0200 (CEST)
Date:   Mon, 7 Oct 2019 19:03:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: remove identified alien device in
 open_fs_devices
Message-ID: <20191007170306.GI2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-5-anand.jain@oracle.com>
 <b370fdd7-2d97-877f-88e6-3624205c8617@suse.com>
 <b8ffd660-5055-d609-4fcd-169090e7914b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8ffd660-5055-d609-4fcd-169090e7914b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 09:37:49PM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/10/7 下午9:30, Nikolay Borisov wrote:
> >
> >
> > On 7.10.19 г. 12:45 ч., Anand Jain wrote:
> >> Following test case explains it all, even though the degraded mount is
> >> successful the btrfs-progs fails to report the missing device.
> >>
> >>  mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdd && \
> >>  wipefs -a /dev/sdd && mount -o degraded /dev/sdc /btrfs && \
> >>  btrfs fi show -m /btrfs
> >>
> >>  Label: none  uuid: 2b3b8d92-572b-4d37-b4ee-046d3a538495
> >> 	Total devices 2 FS bytes used 128.00KiB
> >> 	devid    1 size 1.09TiB used 2.01GiB path /dev/sdc
> >> 	devid    2 size 1.09TiB used 2.01GiB path /dev/sdd
> >>
> >> This is because btrfs-progs does it fundamentally wrong way that
> >> it deduces the missing device status in the user land instead of
> >> refuting from the kernel.
> >>
> >> At the same time in the kernel when we know that there is device
> >> with non-btrfs magic, then remove that device from the list so
> >> that btrfs-progs or someother userland utility won't be confused.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>  fs/btrfs/disk-io.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> >> index 326d5281ad93..e05856432456 100644
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -3417,7 +3417,7 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
> >>  	if (btrfs_super_bytenr(super) != bytenr ||
> >>  		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> >>  		brelse(bh);
> >> -		return -EINVAL;
> >> +		return -EUCLEAN;
> >
> > This is really non-obvious and you are propagating the special-meaning
> > of EUCLEAN waaaaaaaay beyond btrfs_open_one_device. In fact what this
> > patch does is make the following call chain return EUCLAN:
> >
> > btrfs_open_one_device <-- finally removing the device in this function
> >  btrfs_get_bdev_and_sb <-- propagating it to here
> >   btrfs_read_dev_super
> >     btrfs_read_dev_one_super <-- you return the EUCLEAN
> >
> >
> > And your commit log doesn't mention anything about that. EUCLEAN
> > warrants a comment in this case since it changes behavior in
> > higher-level layers.
> 
> 
> And, for most case, EUCLEAN should have a proper kernel message for
> what's going wrong, the value we hit and the value we expect.
> 
> And for EUCLEAN, it's more like graceful error out for impossible thing.
> This is definitely not the case, and I believe the original EINVAL makes
> more sense than EUCLEAN.

I agree, EUCLEAN is wrong here.
