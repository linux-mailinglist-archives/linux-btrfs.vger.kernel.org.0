Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63F96D336
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388031AbfGRRv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 13:51:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53328 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbfGRRv2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 13:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBDDDAD4C;
        Thu, 18 Jul 2019 17:51:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3825DA8B4; Thu, 18 Jul 2019 19:52:02 +0200 (CEST)
Date:   Thu, 18 Jul 2019 19:52:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] uuid: Add inline helpers to operate on raw buffers
Message-ID: <20190718175202.GK20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Lu Fengqi <lufq.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org
References: <20190716150418.84018-1-andriy.shevchenko@linux.intel.com>
 <20190716151133.GA6073@lst.de>
 <20190716152222.GJ9224@smile.fi.intel.com>
 <20190717153706.GJ20977@suse.cz>
 <20190718053951.GA18122@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718053951.GA18122@lst.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 07:39:51AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2019 at 05:37:06PM +0200, David Sterba wrote:
> > > This entire patch because of BTRFS maintainers, they didn't want the explicit
> > > casts. Maybe something has been changed, I dunno.
> > 
> > No change on our side. The uuids are u8 in the on-disk structures, that
> > will stay. The uuid functions use a different type so the casts have to
> > be added, that's clear. The question is if it's up to the API to provide
> > functions that take u8, or btrfs code to put typecasts everywhere or
> > carry own wrappers that do that.
> 
> So why do you insist on the u8 for the on-disk format?  uuid_t is
> defined in RFC4122 as a stable format, and one of the two origins of
> our uuid_t infrastructure is the XFS code, where it is used for the
> on-disk format.  What is different in btrfs?

As I replied to v1 (https://lore.kernel.org/linux-btrfs/20190121181841.GJ2900@twin.jikos.cz/)
I like the simple types in the on-disk structure definitions and that
the amount of bytes occupied by the member is obvious.

Use of guid_t would need to include linux/uuid.h in the UAPI btrfs
headers (that now only include linux/types.h and linux/ioctl.h). This
pollutes the namespace as there's also the user-space uuid library that
provides the same type, so I can't say that's totally safe.

> > Specifically for uuid, the endianness might matter, so that we use the
> > raw buffers makes things more explicit.
> 
> u8 arrays hide the endianess, while the RFC4122 UUID is very clearly
> defined as having big endian fields where they are bigger than a byte.

So we'll use the proper accessors for the raw buffer that's by
definition of btrfs format in little endian order, like cpu_to_le and
similar.

I really try to see what the uuid/guid types would bring but so far see
only problems we don't have and the remaining reason is a matter of
style/preference/consistency.

If you are concerned about uuid API cleanness then we can add the
helpers to btrfs. I offered that as an option before, but pushing a
typedef to on-disk structures does not feel right given what we have
now.
