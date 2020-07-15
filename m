Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FBC2209DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jul 2020 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgGOKVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jul 2020 06:21:38 -0400
Received: from [195.135.220.15] ([195.135.220.15]:46988 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgGOKVg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jul 2020 06:21:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D4FCB090;
        Wed, 15 Jul 2020 10:21:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DFE83DA790; Wed, 15 Jul 2020 12:21:11 +0200 (CEST)
Date:   Wed, 15 Jul 2020 12:21:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs_show_devname don't traverse into the seed fsid
Message-ID: <20200715102111.GW3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20200710063738.28368-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710063738.28368-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 10, 2020 at 02:37:38PM +0800, Anand Jain wrote:
> ->show_devname currently shows the lowest devid in the list. As the seed
> devices have the lowest devid in the sprouted filesystem, the userland
> tool such as findmnt end up seeing seed device instead of the device from
> the read-writable sprouted filesystem. As shown below.
> 
>  mount /dev/sda /btrfs
>  mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>  btrfs dev add -f /dev/sdb /btrfs
> 
>  umount /btrfs
>  mount /dev/sdb /btrfs
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
> 
> All sprouts from a single seed will show the same seed device and the
> same fsid. That's messy.
> This is causing problems in our prototype as there isn't any reference
> to the sprout file-system(s) which is being used for actual read and
> write.
> 
> This was added in the patch which implemented the show_devname in btrfs
> commit 9c5085c14798 (Btrfs: implement ->show_devname).
> I tried to look for any particular reason that we need to show the seed
> device, there isn't any.
> 
> So instead, do not traverse through the seed devices, just show the
> lowest devid in the sprouted fsid.
> 
> After the patch:
> 
>  mount /dev/sda /btrfs
>  mount: /btrfs: WARNING: device write-protected, mounted read-only.
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sda /btrfs 899f7027-3e46-4626-93e7-7d4c9ad19111
> 
>  btrfs dev add -f /dev/sdb /btrfs
>  mount -o rw,remount /dev/sdb /btrfs
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs
>  SOURCE   TARGET UUID
>  /dev/sdb /btrfs 595ca0e6-b82e-46b5-b9e2-c72a6928be48
> 
>  mount /dev/sda /btrfs1
>  mount: /btrfs1: WARNING: device write-protected, mounted read-only.
> 
>  btrfs dev add -f /dev/sdc /btrfs1
> 
>  findmnt --output SOURCE,TARGET,UUID /btrfs1
>  SOURCE   TARGET  UUID
>  /dev/sdc /btrfs1 ca1dbb7a-8446-4f95-853c-a20f3f82bdbb
> 
>  cat /proc/self/mounts | grep btrfs
>  /dev/sdb /btrfs btrfs rw,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
>  /dev/sdc /btrfs1 btrfs ro,relatime,noacl,space_cache,subvolid=5,subvol=/ 0 0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
