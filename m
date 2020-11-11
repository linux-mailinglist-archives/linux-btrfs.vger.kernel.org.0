Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3222AF4CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKKPey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 10:34:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:44482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKKPey (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 10:34:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BC27ABD1;
        Wed, 11 Nov 2020 15:34:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5627CDA6E1; Wed, 11 Nov 2020 16:33:10 +0100 (CET)
Date:   Wed, 11 Nov 2020 16:33:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Nikolay Borisov <nborisov@suse.com>, wqu@suse.com
Subject: Re: [PATCH RESEND v2 1/3] btrfs: drop never met condition of
 disk_total_bytes == 0
Message-ID: <20201111153309.GS6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Nikolay Borisov <nborisov@suse.com>, wqu@suse.com
References: <cover.1604372688.git.anand.jain@oracle.com>
 <682907bcd58ffeece1a76c6ec3b866139a6381bd.1604372689.git.anand.jain@oracle.com>
 <20201105223654.GO6756@twin.jikos.cz>
 <019a25c1-d4d2-02e3-3b82-2ae46384b8d3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019a25c1-d4d2-02e3-3b82-2ae46384b8d3@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 08:20:12AM +0800, Anand Jain wrote:
> On 6/11/20 6:36 am, David Sterba wrote:
> > On Tue, Nov 03, 2020 at 01:49:42PM +0800, Anand Jain wrote:
> >> btrfs_device::disk_total_bytes is set even for a seed device (the
> >> comment is wrong).
> > 
> > That's where I'm a bit lost. It was added in 1b3922a8bc74 ("btrfs: Use
> > real device structure to verify dev extent").
> > 
> 
>   The call chain where we update the btrfs_device::disk_total_bytes is as
>   below..
> 
> 
>     read_one_dev()
> ::
> 
>  From the section below we get the cloned copy of the seed device.
> -----
>          if (memcmp(fs_uuid, fs_devices->metadata_uuid, BTRFS_FSID_SIZE)) {
>                  fs_devices = open_seed_devices(fs_info, fs_uuid);
>                  if (IS_ERR(fs_devices))
>                          return PTR_ERR(fs_devices);
>          }
> 
>          device = btrfs_find_device(fs_info->fs_devices, devid, dev_uuid,
>                                     fs_uuid);
> ------
> 
> 
>   Further down in read_one_dev() at and in the 
> fill_device_from_item(..., device) we update the 
> btrfs_device::disk_total_bytes.
> 
> fill_device_from_item(..., device)
> ::
>          device->disk_total_bytes = btrfs_device_total_bytes(leaf, 
> dev_item);
> 
> Hope this clarifies.
> 
> V1 email discussion has more information.

... that should have been turned into a changelog update in v2.

> >> The function fill_device_from_item() does the job of reading it from the
> >> item and updating btrfs_device::disk_total_bytes. So both the missing
> >> device and the seed devices do have their disk_total_bytes updated.
> >>
> >> Furthermore, while removing the device if there is a power loss, we could
> >> have a device with its total_bytes = 0, that's still valid.
> 
> 
> > 
> > Ok, that's the condition that the commit mentioned above used to detect
> > the device and to avoid doing the tree-checker verification.
> 
> Ok. Please look at what did the commit 1b3922a8bc74 do? It re-ran the 
> btrfs_find_device(seed_devs,..., false), which anyway the 
> btrfs_find_device(sprout_devs,..., true) has run just before. In both of 
> these btrfs_find_device() runs, the dev returned will be the same. The 
> fix makes no sense to the problem as in the commit.
> 
> 
> > 
> >> So this patch removes the check dev->disk_total_bytes == 0 in the
> >> function verify_one_dev_extent(), which it does nothing in it.
> > 
> > Removing a check that supposedly does notghing, but the referenced
> > commit says otherwise.
> > 
> 
> IMO the reason for the problem found in that commit was wrong. Qu 
> commit's email thread has some discussion. But nothing more on the problem.
> 
> Also Nikolay had the same question here was my reply.
> https://www.spinics.net/lists/linux-btrfs/msg105645.html

If the same question is asked then it's missing in the changelog, that's
where people will want to read it in the future and not in the
mailinglist archives.

> >> And take this opportunity to introduce a check if the device::total_bytes
> >> is more than the max device size in read_one_dev().
> > 
> > If this is not related to the the check removal, then it should be an
> > independent patch explaing in full what is being fixed. As I read it
> > this should be independent as it's checking the upper bound.
> > 
> 
>   That came from the Josef comments, please refer to the v1 email 
> discussion. Most of the above concerns are already discussed there. I am 
> ok to move it to a new patch if required.

And again. Same questions still unanswered, the whole point of the
iterations is to add what's been found unclear or missing. I've added it
for now but next time I'd prefer not to have to.
