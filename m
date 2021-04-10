Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4FA35AC7A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhDJJbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 05:31:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDJJbc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 05:31:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7181B1BD;
        Sat, 10 Apr 2021 09:31:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2270DAF21; Sat, 10 Apr 2021 11:29:02 +0200 (CEST)
Date:   Sat, 10 Apr 2021 11:29:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH v2] btrfs: zoned: move superblock logging zone location
Message-ID: <20210410092902.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <2f58edb74695825632c77349b000d31f16cb3226.1617870145.git.naohiro.aota@wdc.com>
 <20210409110719.GR7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409110719.GR7604@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 09, 2021 at 01:07:19PM +0200, David Sterba wrote:
> On Thu, Apr 08, 2021 at 05:25:28PM +0900, Naohiro Aota wrote:
> > This commit moves the location of the superblock logging zones. The new
> > locations of the logging zones are now determined based on fixed block
> > addresses instead of on fixed zone numbers.
> > 
> > The old placement method based on fixed zone numbers causes problems when
> > one needs to inspect a file system image without access to the drive zone
> > information. In such case, the super block locations cannot be reliably
> > determined as the zone size is unknown. By locating the superblock logging
> > zones using fixed addresses, we can scan a dumped file system image without
> > the zone information since a super block copy will always be present at or
> > after the fixed location.
> > 
> > This commit introduces the following three pairs of zones containing fixed
> > offset locations, regardless of the device zone size.
> > 
> >   - Primary superblock: zone starting at offset 0 and the following zone
> >   - First copy: zone containing offset 64GB and the following zone
> >   - Second copy: zone containing offset 256GB and the following zone
> > 
> > If a logging zone is outside of the disk capacity, we do not record the
> > superblock copy.
> > 
> > The first copy position is much larger than for a regular btrfs volume
> > (64M).  This increase is to avoid overlapping with the log zones for the
> > primary superblock. This higher location is arbitrary but allows supporting
> > devices with very large zone sizes, up to 32GB. Such large zone size is
> > unrealistic and very unlikely to ever be seen in real devices. Currently,
> > SMR disks have a zone size of 256MB, and we are expecting ZNS drives to be
> > in the 1-4GB range, so this 32GB limit gives us room to breathe. For now,
> > we only allow zone sizes up to 8GB, below this hard limit of 32GB.
> > 
> > The fixed location addresses are somewhat arbitrary, but with the intent of
> > maintaining superblock reliability even for smaller devices. For this
> > reason, the superblock fixed locations do not exceed 1TB.
> 
> Yeah, so how much should we adjust the offsets in favor of smaller
> devices instead of larger ones? I think this is going the wrong
> direction, the capacity will grow, the zones are supposed to be larger.

For the record, we had a group discussion about that and the consensus
is to do sb offsets at 0, 512G and 4T.

The rationale is to prefer large devices slightly more than smaller, but
are 2 superblocks available under 1T to cover small devices. Physical
devices' capacity grows and the 4T copy should be available on all of
the HDD type, while flash storage growth is a bit slower but still
projected to be up to 10T within the time we care about now.

The small devices are for usecases with not necessarily a physical
device, eg. emulated or on top of device mapper targets.

The superblock copy itself is not a frequently utilized feature but we
still want to keep it, for parity with non-zoned mode and "just in
case".

I'll update the patch changelog and code to reflect the changes and
resend to all people involved. The pull request is scheduled for
tomorrow.
