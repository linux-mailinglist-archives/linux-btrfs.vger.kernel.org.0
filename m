Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A7229A85
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgGVOsT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:48:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbgGVOsS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:48:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54CF7AC7F;
        Wed, 22 Jul 2020 14:48:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0CD42DA70B; Wed, 22 Jul 2020 16:47:50 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:47:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: Use rcu when iterating devices in
 btrfs_init_new_device
Message-ID: <20200722144750.GY3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-2-nborisov@suse.com>
 <SN4PR0401MB3598E3FEB988273A2709414B9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <f8a7bab8-98dc-55c6-5adf-7d0ee95bb3a6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8a7bab8-98dc-55c6-5adf-7d0ee95bb3a6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 01:36:15PM +0300, Nikolay Borisov wrote:
> 
> 
> On 22.07.20 г. 12:17 ч., Johannes Thumshirn wrote:
> > On 22/07/2020 10:09, Nikolay Borisov wrote:
> >> When adding a new device there's a mandatory check to see if a device is
> >> being duplicated to the filesystem it's added to. Since this is a
> >> read-only operations not necessary to take device_list_mutex and can simply
> >> make do with an rcu-readlock. No semantics changes.
> > 
> > Hmm what are the actual locking rules for the device list? For instance looking
> > at add_missing_dev() in volumes.c addition to the list is unprotected (both from
> > read_one_chunk() and read_one_dev()). Others (i.e. btrfs_init_new_device()) do
> > a list_add_rcu(). clone_fs_devices() takes the device_list_mutex and so on.
> 
> Bummer, the locking rules are supposed to be those documented atop
> volume.c, namely:
> 
>  * fs_devices::device_list_mutex (per-fs, with RCU)
> 
>     18  * ------------------------------------------------
> 
>     17  * protects updates to fs_devices::devices, ie. adding and
> deleting
>     16  *
> 
>     15  * simple list traversal with read-only actions can be done with
> RCU protection
>     14  *
> 
>     13  * may be used to exclude some operations from running
> concurrently without any
>     12  * modifications to the list (see write_all_supers)
> 
> 
> 
> However, your observations seem correct and rather annoying. Let me go
> and try and figure this out...

For device list it's important to know from which context is the list
used.

On unmoutned filesystems, the devices can be added by scanning ioctl.

On mounted filesystem, before the mount is finished, the devices cannot
be concurrently used (single-threaded context) and uuid_mutex is
temporarily protecting the devices agains scan ioctl.

On finished mount device list must be protected by device_list_mutex
from the same filesystem changes (ioctls, superblock write). Device
scanning is a no-op here, but still needs to use the uuid_mutex.

Enter RCU. For performance reasons we don't want to take
device_list_mutex for read-only operations like show_devname or lookups
of device id, where it's not critical that the returned information is
stale.

The mentioned helpers are used by various functions and the context is
not obvious or documented, but it should be clear once the caller chain
is known.

I can turn that into comments but please let me know if this is
sufficient as explanation or if you need more.
