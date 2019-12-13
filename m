Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41311E899
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfLMQni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:43:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:54656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728126AbfLMQni (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:43:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02899AC68;
        Fri, 13 Dec 2019 16:43:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48116DA82A; Fri, 13 Dec 2019 17:43:33 +0100 (CET)
Date:   Fri, 13 Dec 2019 17:43:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anandsuveer@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs: sysfs, add devid/dev_state kobject and
 attribute
Message-ID: <20191213164332.GA3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anandsuveer@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-5-anand.jain@oracle.com>
 <20191205142148.GQ2734@twin.jikos.cz>
 <78560abd-7d85-c95d-ed76-7810b1d03789@oracle.com>
 <20191205151428.GS2734@twin.jikos.cz>
 <673babd8-90ec-2f7e-532a-df8c98a844cf@oracle.com>
 <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bd3d9b9-11b1-4c9a-8b59-ccfe0c6d92c4@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 09, 2019 at 10:05:39PM +0800, Anand Jain wrote:
> On 12/6/19 9:49 PM, Anand Jain wrote:
> > 
> > 
> > On 5/12/19 11:14 PM, David Sterba wrote:
> >> On Thu, Dec 05, 2019 at 10:38:15PM +0800, Anand Jain wrote:
> >>>> So the values copy the device state macros, that's probably ok.
> >>>    Yep.
> >>
> >> Although, sysfs files should print one value per file, which makes sense
> >> in many cases, so eg. missing should exist separately too for quick
> >> checks for the most common device states. The dev_state reflects the
> >> internal state and is likely useful only for debugging.
> >>
> > 
> >   I agree. Its better to create an individual attribute for each of the
> >   device states. For instance..
> > 
> >     under the 'UUID/devinfo/<devid>' kobject
> >     attributes will be:
> >       missing
> >       in_fs_metadata
> >       replace_target
> > 
> >    cat missing
> >     0
> >    cat in_fs_metadata
> >     1
> > 
> >    ..etc
> > 
> >   which seems to be more or less standard for block devices.
> > 
> >   Will fix it in v2.
> 
> This is fixed in v2.
> 
> 
> > 
> >>>>> +static ssize_t btrfs_sysfs_dev_state_show(struct kobject *kobj,
> >>>>> +                      struct kobj_attribute *a, char *buf)
> >>>>> +{
> >>>>> +    struct btrfs_device *device = container_of(kobj, struct 
> >>>>> btrfs_device,
> >>>>> +                           devid_kobj);
> >>>>> +
> >>>>> +    btrfs_dev_state_to_str(device, buf, PAGE_SIZE);
> >>>>
> >>>> The device access is unprotected, you need at least RCU but that still
> >>>> does not prevent from the device being freed by deletion.
> >>>
> >>>    We need RCU let me fix. Device being deleted is fine, there
> >>>    is nothing to lose, another directory lookup will show that
> >>>    UUID/devinfo/<devid> is gone is the device is deleted.
> >>
> >> The device can be gone from the list but the sysfs files can still
> >> exist.
> >>
> >>      CPU1                                   CPU2
> >>
> >> btrfs_rm_device
> >>                                          open file
> >>    btrfs_sysfs_rm_device_link
> >>      btrfs_free_device
> >>        kfree(device)
> >>                                          call read, access freed device
> >>
> > 
> >    I completely missed the sysfs synchronization with device delete.
> >    As in the other email discussion, I think a new rwlock shall suffice.
> >    And as its lock is only between device delete and sysfs so it shall
> >    be light weight without affecting the other device_list_mutex holders.
> 
>   Looked into this further, actually we don't need any lock here
>   the device delete thread which calls kobject_put() makes sure
>   sysfs read is closed. So an existing sysfs read thread will have
>   to complete before device free.
> 
> 
>        CPU1                                   CPU2
> 
>   btrfs_rm_device
>                                            open file
>      btrfs_sysfs_rm_device_link
>                                            call read, access freed device
>        sysfs waits for the open file
>        to close.

How exactly does sysfs wait for the device? Is it eg wait_event checking
number of references? If the file stays open by an evil process is it
going to block the device removal indefinitelly?
