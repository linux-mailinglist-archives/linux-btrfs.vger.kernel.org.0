Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8243D6619
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhGZROs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 13:14:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhGZROs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 13:14:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8D8321FD4C;
        Mon, 26 Jul 2021 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627322115;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiAUuRCIK8YoHaDGXQL+7hFDjT5BNNPCMjip4/yKDHw=;
        b=sOgUfw8xnMVv/32/CFW2kROW4WK9xlfoYGPWNwCqTPxXXUh3uucpOmvJuxE3Sf0a/N7rSJ
        FLtax77vXBNdhugO/csP1xDYm+lfeFtigRB0mchxvqU02Y+uX1zwFKoWnNN9LPrncHc+KW
        g1U3FrEwZ3/85roSQ8+p4Lc+xajpd8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627322115;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiAUuRCIK8YoHaDGXQL+7hFDjT5BNNPCMjip4/yKDHw=;
        b=Phjh5UoVcKgi6aKj85Yqhl9TdyQIGVD6RR/CJoC847SyW+lXy+fwfDznO0Asz8W4DfXMx7
        vtQhpmpWymPtNGAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7A1F7A3B89;
        Mon, 26 Jul 2021 17:55:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92B6FDA8D8; Mon, 26 Jul 2021 19:52:31 +0200 (CEST)
Date:   Mon, 26 Jul 2021 19:52:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
Message-ID: <20210726175230.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
 <20210721175938.GP19710@twin.jikos.cz>
 <9119934f-fb61-3b55-655c-9a7552e0b30b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9119934f-fb61-3b55-655c-9a7552e0b30b@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 02:19:52PM +0800, Desmond Cheong Zhi Xi wrote:
> On 22/7/21 1:59 am, David Sterba wrote:
> > On Thu, Jul 15, 2021 at 06:34:03PM +0800, Desmond Cheong Zhi Xi wrote:
> >> Syzbot reports a warning in close_fs_devices that happens because
> >> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
> >> on each device.
> >>
> >> This happens when a writeable device is removed in
> >> __btrfs_free_extra_devids, but the rw device count is not decremented
> >> accordingly. So when close_fs_devices is called, the removed device is
> >> still counted and we get an off by 1 error.
> >>
> >> Here is one call trace that was observed:
> >>    btrfs_mount_root():
> >>      btrfs_scan_one_device():
> >>        device_list_add();   <---------------- device added
> >>      btrfs_open_devices():
> >>        open_fs_devices():
> >>          btrfs_open_one_device();   <-------- rw device count ++
> >>      btrfs_fill_super():
> >>        open_ctree():
> >>          btrfs_free_extra_devids():
> >> 	  __btrfs_free_extra_devids();  <--- device removed
> >> 	  fail_tree_roots:
> >> 	    btrfs_close_devices():
> >> 	      close_fs_devices();   <------- rw device count off by 1
> >>
> >> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> > 
> > What this patch did in the last hunk was the rw_devices decrement, but
> > conditional:
> > 
> > @@ -1080,9 +1071,6 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> >                  if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> >                          list_del_init(&device->dev_alloc_list);
> >                          clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> > -                       if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> > -                                     &device->dev_state))
> > -                               fs_devices->rw_devices--;
> >                  }
> >                  list_del_init(&device->dev_list);
> >                  fs_devices->num_devices--;
> > ---
> > 
> > 
> >> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
> >>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
> >>   			list_del_init(&device->dev_alloc_list);
> >>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> >> +			fs_devices->rw_devices--;
> >>   		}
> >>   		list_del_init(&device->dev_list);
> >>   		fs_devices->num_devices--;
> > 
> > So should it be reinstated in the original form? The rest of
> > cf89af146b7e handles unexpected device replace item during mount.
> > 
> > Adding the decrement is correct, but right now I'm not sure about the
> > corner case when teh devcie has the BTRFS_DEV_STATE_REPLACE_TGT bit set.
> > The state machine of the device bits and counters is not trivial so
> > fixing it one way or the other could lead to further syzbot reports if
> > we don't understand the issue.
> > 
> 
> Hi David,
> 
> Thanks for raising this issue. I took a closer look and I think we don't 
> have to reinstate the original form because it's a historical artifact.
> 
> The short version of the story is that going by the intention of 
> __btrfs_free_extra_devids, we skip removing the replace target device. 
> Hence, by the time we've reached the decrement in question, the device 
> is not the replace target device and the BTRFS_DEV_STATE_REPLACE_TGT bit 
> should not be set.
> 
> But we should also try to understand the original intention of the code. 
> The check in question was first introduced in commit 8dabb7420f01 
> ("Btrfs: change core code of btrfs to support the device replace 
> operations"):
> > @@ -536,7 +553,8 @@ void btrfs_close_extra_devices(struct btrfs_fs_devices *fs_devices)
> >                 if (device->writeable) {
> >                         list_del_init(&device->dev_alloc_list);
> >                         device->writeable = 0;
> > -                       fs_devices->rw_devices--;
> > +                       if (!device->is_tgtdev_for_dev_replace)
> > +                               fs_devices->rw_devices--;
> >                 }
> >                 list_del_init(&device->dev_list);
> >                 fs_devices->num_devices--;
> 
> If we take a trip back in time to this commit we see that 
> btrfs_dev_replace_finishing added the target device to the alloc list 
> without incrementing the rw_devices count. So this check was likely 
> originally meant to prevent under-counting of rw_devices.
> 
> However, the situation has changed, following various fixes to 
> rw_devices counting. Commit 63dd86fa79db ("btrfs: fix rw_devices miss 
> match after seed replace") added an increment to rw_devices when 
> replacing a seed device with a writable one in btrfs_dev_replace_finishing:
> > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > index eea26e1b2fda..fb0a7fa2f70c 100644
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -562,6 +562,8 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
> >         if (fs_info->fs_devices->latest_bdev == src_device->bdev)
> >                 fs_info->fs_devices->latest_bdev = tgt_device->bdev;
> >         list_add(&tgt_device->dev_alloc_list, &fs_info->fs_devices->alloc_list);
> > +       if (src_device->fs_devices->seeding)
> > +               fs_info->fs_devices->rw_devices++;
> >  
> >         /* replace the sysfs entry */
> >         btrfs_kobj_rm_device(fs_info, src_device);
> 
> This was later simplified in commit 82372bc816d7 ("Btrfs: make the logic 
> of source device removing more clear") that simply decremented 
> rw_devices in btrfs_rm_dev_replace_srcdev if the replaced device was 
> writable. This meant that the rw_devices count could be incremented in 
> btrfs_dev_replace_finishing without any checks:
> > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > index e9cbbdb72978..6f662b34ba0e 100644
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -569,8 +569,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
> >         if (fs_info->fs_devices->latest_bdev == src_device->bdev)
> >                 fs_info->fs_devices->latest_bdev = tgt_device->bdev;
> >         list_add(&tgt_device->dev_alloc_list, &fs_info->fs_devices->alloc_list);
> > -       if (src_device->fs_devices->seeding)
> > -               fs_info->fs_devices->rw_devices++;
> > +       fs_info->fs_devices->rw_devices++;
> >  
> >         /* replace the sysfs entry */
> >         btrfs_kobj_rm_device(fs_info, src_device);
> 
> Thus, given the current state of the code base, the original check is 
> now incorrect, because we want to decrement rw_devices as long as the 
> device is being removed from the alloc list.
> 
> To further convince ourselves of this, we can take a closer look at the 
> relation between the device with devid BTRFS_DEV_REPLACE_DEVID and the 
> BTRFS_DEV_STATE_REPLACE_TGT bit for devices.
> 
> BTRFS_DEV_STATE_REPLACE_TGT is set in two places:
> - btrfs_init_dev_replace_tgtdev
> - btrfs_init_dev_replace
> 
> In btrfs_init_dev_replace_tgtdev, the BTRFS_DEV_STATE_REPLACE_TGT bit is 
> set for a device allocated with devid BTRFS_DEV_REPLACE_DEVID.
> 
> In btrfs_init_dev_replace, the BTRFS_DEV_STATE_REPLACE_TGT bit is set 
> for the target device found with devid BTRFS_DEV_REPLACE_DEVID.
> 
>  From both cases, we see that the BTRFS_DEV_STATE_REPLACE_TGT bit is set 
> only for the device with devid BTRFS_DEV_REPLACE_DEVID.
> 
> It follows that if a device does not have devid BTRFS_DEV_REPLACE_DEVID, 
> then the BTRFS_DEV_STATE_REPLACE_TGT bit will not be set.
> 
> With commit cf89af146b7e ("btrfs: dev-replace: fail mount if we don't 
> have replace item with target device"), we skip removing the device in 
> __btrfs_free_extra_devids as long as the devid is BTRFS_DEV_REPLACE_DEVID:
> > -               if (device->devid == BTRFS_DEV_REPLACE_DEVID) {
> > -                       /*
> > -                        * In the first step, keep the device which has
> > -                        * the correct fsid and the devid that is used
> > -                        * for the dev_replace procedure.
> > -                        * In the second step, the dev_replace state is
> > -                        * read from the device tree and it is known
> > -                        * whether the procedure is really active or
> > -                        * not, which means whether this device is
> > -                        * used or whether it should be removed.
> > -                        */
> > -                       if (step == 0 || test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> > -                                                 &device->dev_state)) {
> > -                               continue;
> > -                       }
> > -               }
> > +               /*
> > +                * We have already validated the presence of BTRFS_DEV_REPLACE_DEVID,
> > +                * in btrfs_init_dev_replace() so just continue.
> > +                */
> > +               if (device->devid == BTRFS_DEV_REPLACE_DEVID)
> > +                       continue;
> 
> Given the discussion above, after we fail the check for device->devid == 
> BTRFS_DEV_REPLACE_DEVID, all devices from that point are not the replace 
> target device, and do not have the BTRFS_DEV_STATE_REPLACE_TGT bit set.
> 
> So the original check for the BTRFS_DEV_STATE_REPLACE_TGT bit before 
> incrementing rw_devices is not just incorrect at this point, it's also 
> redundant.

Could you please write some condensed version of the above and resend?
The original changelog says what happends and how, the analysis here
is the actual explanation and I'd like to have that recorded. Thanks.
