Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8181BF9DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD3Nqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 09:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbgD3Nqu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 09:46:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 653DAAC69;
        Thu, 30 Apr 2020 13:46:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 220D0DA728; Thu, 30 Apr 2020 15:46:03 +0200 (CEST)
Date:   Thu, 30 Apr 2020 15:46:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
Subject: Re: [PATCH 2/3] btrfs: include non-missing as a qualifier for the
 latest_bdev
Message-ID: <20200430134602.GM18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com,
        josef@toxicpanda.com
References: <20200428152227.8331-1-anand.jain@oracle.com>
 <20200428152227.8331-3-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428152227.8331-3-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 28, 2020 at 11:22:26PM +0800, Anand Jain wrote:
> btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
> to point to the bdev with greatest device::generation number.
> For a typical-missing device the generation number is zero so
> fs_devices::latest_bdev will never point to it.
> 
> But if the missing device is due to alienation [1], then
> device::generation is not-zero and if it is >= to rest of
> device::generation in the list, then fs_devices::latest_bdev
> ends up pointing to the missing device and reports the error
> like this [2]
> 
> [1] We maintain devices of a fsid (as in fs_device::fsid) in the
> fs_devices::devices list, a device is considered as an alien device
> if its fsid does not match with the fs_device::fsid
> 
> $ mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs

Please put each command on one line for clarity

> $ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
> $ sleep 3 # avoid racing with udev's useless scans if needed
> $ btrfs dev add -f /dev/sdb /btrfs
> $ mount -o degraded /dev/sdc /btrfs1

So the cause is a second mkfs on some devices, but is the degraded mount
supposed to work? The example goes:

- create first filesystem with device A
- create second filesystem with device B and C
- add device B to the first filesystem, effectively making it missing
- mount first filesystem, degraded because of the missing device

For a reproducer that's ok, but is this something that we can expect to
happen in practice? The flag -f should prevent accidental overwrite, but
yes the kernel code needs to deal with that in any case.
