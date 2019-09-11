Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5CB01B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfIKQhi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:37:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:57704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728794AbfIKQhi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:37:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD04FADFE;
        Wed, 11 Sep 2019 16:37:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1222DA7D9; Wed, 11 Sep 2019 18:37:58 +0200 (CEST)
Date:   Wed, 11 Sep 2019 18:37:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/2]  readmirror feature
Message-ID: <20190911163758.GG2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190826090438.7044-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826090438.7044-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 05:04:36PM +0800, Anand Jain wrote:
> Function call chain  __btrfs_map_block()->find_live_mirror() uses
> thread pid to determine the %mirror_num when the mirror_num=0.
> 
> This patch introduces a framework so that we can add policies to determine
> the %mirror_num. And also adds the devid as the readmirror policy.
> 
> The new property is stored as an item in the device tree as show below.
>     (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)
> 
> To be able to set and get this new property also introduces new ioctls
> BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
> is defined as
>         struct btrfs_ioctl_readmirror_args {
>                 __u64 type; /* RW */
>                 __u64 device_bitmap; /* RW */
>         }

I don't remember if there was a suggestion to use ioctls for read
mirror, but the property interface should be sufficient. Besides this
ioctl interafce is quite an anti-pattern: narrow use, non-extensible
structure, alternative and more convenient interface already available.

> An usage example as follows:
>         btrfs property set /btrfs readmirror devid:1,3
>         btrfs property get /btrfs readmirror
>           readmirror devid:1 3
>         btrfs property set /btrfs readmirror ""
>         btrfs property get /btrfs readmirror
>           readmirror default
> 
> This patchset has been tested completely, however marked as RFC for the 
> following reasons and comments on them (or any other) are appreciated as
> usual.
>  . The new objectid is defined as
>       #define BTRFS_READMIRROR_OBJECTID -1ULL
>    Need consent we are fine to use this value, and with this value it
>    shall be placed just before the DEV_STATS_OBJECTID item which is more
>    frequently used only during the device errors.

-1 can be considered a special value in other cases, not necessarily
here but if the ordering of items is the only reason I'd say no. The
keys/items will most likely land in the same node so there's no point
forcing the order.

> .  I am using a u64 bitmap to represent the devices id, so the max device
>    id that we could represent is 63, its a kind of limitation which should
>    be addressed before integration, I wonder if there is any suggestion?

Uh 63, so now an implementation detail is posing a global limit? That
sounds backwards.

>    Kindly note that, multiple ioctls with each time representing a set of
>    device(s) is not a choice because we need to make sure the readmirror
>    changes happens in a commit transaction.

I believe this can be guaranteed by the properties interface, ie. single
value gets processed at once and with some locking around the state of
devices can be updated atomically.

The open question is still how to store the readmirror property
per-device, it could be either an item or bit inside the device
structure.

Besides the interface, I'm kind of missing the usecase description what
is expected from the read mirror policies and how they could affect
various scenarios. Maybe it was in some of the previous iterations, it's
hard too track everything so this should be part of the cover letter (or
at leat linked if it's too much text).
