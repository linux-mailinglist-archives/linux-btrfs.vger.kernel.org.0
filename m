Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA625BEDE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 12:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICKLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 06:11:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKL3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 06:11:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C9F1AD3C;
        Thu,  3 Sep 2020 10:11:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A7750DA6E0; Thu,  3 Sep 2020 12:10:15 +0200 (CEST)
Date:   Thu, 3 Sep 2020 12:10:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: improve messages when devices rescanned
Message-ID: <20200903101015.GP28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <77fc0b0c7c88b14c734b646d1969ccf45a063146.1599118052.git.anand.jain@oracle.com>
 <fe35d005-a3ad-2a30-99a0-99416846d5e1@suse.com>
 <6da22ff1-3dc0-d564-4d9d-befa82827bfe@oracle.com>
 <7d811665-5033-782a-881d-7731f60fecc4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d811665-5033-782a-881d-7731f60fecc4@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 12:42:09PM +0300, Nikolay Borisov wrote:
> 
> 
> On 3.09.20 г. 12:41 ч., Anand Jain wrote:
> > On 3/9/20 4:16 pm, Nikolay Borisov wrote:
> >>
> >>
> >> On 3.09.20 г. 10:27 ч., Anand Jain wrote:
> >>> Systems booting without the initramfs seems to scan an unusual kind
> >>> of device path. And at a later time, the device is updated to the
> >>> correct path. We generally print the process name and PID of the process
> >>> scanning the device but we don't capture the same information if the
> >>> device path is rescanned with a different pathname.
> >>>
> >>> But the current message is too long, so drop the unwanted words and add
> >>> process name and PID.
> >>>
> >>> While at this also update the duplicate device warning to include the
> >>> process name and PID.
> >>>
> >>> Reported-by: https://bugzilla.kernel.org/show_bug.cgi?id=89721
> >>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>> ---
> >>>   fs/btrfs/volumes.c | 14 ++++++++------
> >>>   1 file changed, 8 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>> index dc81646b13c0..c386ad722ae1 100644
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -942,16 +942,18 @@ static noinline struct btrfs_device
> >>> *device_list_add(const char *path,
> >>>                   bdput(path_bdev);
> >>>                   mutex_unlock(&fs_devices->device_list_mutex);
> >>>                   btrfs_warn_in_rcu(device->fs_info,
> >>> -            "duplicate device fsid:devid for %pU:%llu old:%s new:%s",
> >>> -                    disk_super->fsid, devid,
> >>> -                    rcu_str_deref(device->name), path);
> >>> +    "duplicate device %s devid %llu generation %llu scanned by %s
> >>> (%d)",
> >>> +                          path, devid, found_transid,
> >>> +                          current->comm,
> >>> +                          task_pid_nr(current));
> >>>                   return ERR_PTR(-EEXIST);
> >>>               }
> >>>               bdput(path_bdev);
> >>>               btrfs_info_in_rcu(device->fs_info,
> >>> -                "device fsid %pU devid %llu moved old:%s new:%s",
> >>> -                disk_super->fsid, devid,
> >>> -                rcu_str_deref(device->name), path);
> >>> +                "device path %s changed to %s by %s (pid %d)",
> >>> +                      rcu_str_deref(device->name),
> >>> +                      path, current->comm,
> >>> +                      task_pid_nr(current));
> >>
> >> This 2nd messages is misleading, it's not the process calling
> >> device_list_add which have changed the path per-se but rather it sees
> >> the changed path. It's not possible to know why it changed in this
> >> context. The idea here is "
> >>
> >> "Process %pid saw different dev path %new_dev_path for dev %old_path"
> > 
> >   Hm. How about we stick to the usual scanned by. That is..
> > 
> >   "device path %s changed to %s scanned by %s (pid %d)",
> 
> works for me.

The device id should still be there, the filesystem is referred to by
the device name as printed by btrfs_info* so its uuid can be dropped
from the message itself.
