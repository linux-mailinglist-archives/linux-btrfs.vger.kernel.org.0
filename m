Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C424102494
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKSMhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:37:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:41456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSMhx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:37:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4E96ABC7;
        Tue, 19 Nov 2019 12:37:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E24ADAAC2; Tue, 19 Nov 2019 13:37:50 +0100 (CET)
Date:   Tue, 19 Nov 2019 13:37:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/15] btrfs: sysfs, cleanups
Message-ID: <20191119123749.GR3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191118084656.3089-1-anand.jain@oracle.com>
 <20191118154556.GJ3001@twin.jikos.cz>
 <99f5241a-bf39-3f12-dfce-29cfafdc5c42@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f5241a-bf39-3f12-dfce-29cfafdc5c42@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 02:44:10PM +0800, Anand Jain wrote:
> 
> 
> On 11/18/19 11:45 PM, David Sterba wrote:
> > On Mon, Nov 18, 2019 at 04:46:41PM +0800, Anand Jain wrote:
> >> Mostly cleanups patches.
> >>
> >> Patches 1-7 are renames, code moves patches and there are no
> >> functional changes.
> >>
> >> Patch 8 drops unused argument in the function btrfs_sysfs_add_fsid().
> >> Patch 9 merges two small functions which is an extension of the other.
> >>
> >> Patches 10,11 and 13 removes unnecessary features in the functions,
> >> originally it was planned to provide sysfs attributes for the scanned
> >> and unmounted devices, as in the un-merged patch in the mailing list [1]
> >>     [1] [PATCH] btrfs: Introduce device pool sysfs attributes
> > 
> > We want something like that,
> 
>   Oh.
> 
>   Ok then I shall relook at these patches with a mind that we might
>   introduce the sysfs for non mounted devices.
> 
> > I don't recall all the past discussions,
> 
>   No worries. There wasn't any discussions on this specific topic.

There were several patchsets sent adding device information exports, and
commented, eg.

https://lore.kernel.org/linux-btrfs/1423439785-10260-1-git-send-email-anand.jain@oracle.com/t/#u
https://lore.kernel.org/linux-btrfs/1416814173-16945-1-git-send-email-anand.jain@oracle.com/t/#u

and maybe followups.

> 
> > but a separate directory for all the new sysfs files should be
> > introduced. Extending the existing /devices/ that contains just the
> > sysfs device like should stay as is.
> > 
> > /sys/fs/btrfs/UUID/
> > 	devinfo/
> > 		1/
> > 			uuid
> > 			state
> > 			...
> > 		2/
> > 			...
> > 
> 
>   umm how about..
> 
> $ btrfs fi show
> Label: none  uuid: 52ad6beb-524d-4cd8-8979-0890d0b74314
> 	Total devices 4 FS bytes used 384.00KiB
> 	devid    1 size 2.93GiB used 368.00MiB path /dev/sdb
> 	devid    2 size 2.93GiB used 368.00MiB path /dev/sdc
> 	devid    3 size 2.93GiB used 368.00MiB path /dev/sdd
> 	devid    4 size 2.93GiB used 368.00MiB path /dev/sde
> 
> 
> # ls -l /sys/fs/btrfs/52ad6beb-524d-4cd8-8979-0890d0b74314/devices/
> total 0
> drwxr-xr-x 2 root root 0 Nov 19 14:39 1_sdb

Something like that has been suggested in the patchsets, I disagree with
the device id and name being glued together. The sysfs files should
server scripting, the enumeration should be straightforward and not
requiring parsing of the filenames.

> drwxr-xr-x 2 root root 0 Nov 19 14:39 2_sdc
> drwxr-xr-x 2 root root 0 Nov 19 14:39 3_sdd
> drwxr-xr-x 2 root root 0 Nov 19 14:39 4_sde
> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdb -> 
> ../../../../devices/pci0000:00/0000:00:0d.0/ata2/host1/target1:0:0/1:0:0:0/block/sdb
> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdc -> 
> ../../../../devices/pci0000:00/0000:00:0d.0/ata3/host2/target2:0:0/2:0:0:0/block/sdc
> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sdd -> 
> ../../../../devices/pci0000:00/0000:00:0d.0/ata4/host3/target3:0:0/3:0:0:0/block/sdd
> lrwxrwxrwx 1 root root 0 Nov 19 14:39 sde -> 
> ../../../../devices/pci0000:00/0000:00:0d.0/ata5/host4/target4:0:0/4:0:0:0/block/sde

If you want to put the directories under /sys/fs/btrfs/UUID/deevices/
then it's probably ok as long as there device node links are plain files
and the directories represent the ids. But just the ids, the actual
device name depends on the assignment by block layer. This is not
persistent.

So two possible layouts:

fs/UUID/devices
	sda
	sdb
	sdc
	1/
		...
	2/
		...
	3/
		...

Or the one suggested before, where devices by id are in a separate
directory. This is modelled after /dev/disk/by-id and the like, but I
don't think we need to make it granular like that.
