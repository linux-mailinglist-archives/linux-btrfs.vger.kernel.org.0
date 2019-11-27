Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3A10B6DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfK0Tgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 14:36:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727091AbfK0Tgf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 14:36:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C3BEAC2C;
        Wed, 27 Nov 2019 19:36:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B96BDA733; Wed, 27 Nov 2019 20:36:31 +0100 (CET)
Date:   Wed, 27 Nov 2019 20:36:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: volumes: Add btrfs_fs_devices::missing_list
 to collect missing devices
Message-ID: <20191127193631.GC2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-3-wqu@suse.com>
 <cf9c85fd-4d9f-43be-049c-a5694c0a25e1@oracle.com>
 <0d4d78eb-eede-98c0-109a-c731ddffb5d7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d4d78eb-eede-98c0-109a-c731ddffb5d7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 06:29:46PM +0800, Qu Wenruo wrote:
> On 2019/11/19 下午6:03, Anand Jain wrote:
> > On 11/7/19 2:27 PM, Qu Wenruo wrote:
> >> This enables btrfs to iterate missing devices separately, without
> >> iterating all fs_devices.
> > 
> >  IMO.
> >  We don't need another list to maintain the missing device. We already
> >  have good enough device lists.
> >  The way its been implemented is
> >  Allo_list is the only list from which we shall alloc the chunks.
> >  Missing is a state of the device.
> >  A device in the alloc list can be in the Missing state.
> 
> That would cause problem, especially when you only want to use missing
> device as last resort method.
> 
> IIRC it's you mentioned this is a problem in my original design (which
> put all missing deviecs into alloc_list). Or it's David?
> 
> > 
> >  If there is missing_list that means the device in the missing list
> >  is also possible candidate for the alloc that's messy.
> 
> But when you want to avoid missing device, alloc_list and missing_list
> makes sense.
> 
> E.g. 6 devices RAID5, with one missing device, we should *avoid* using
> missing devices as we have enough (5) devices to allocate from.

I tend to agree that adding more lists would make things messy. This
needs to keep the missing state bit and presence in the list in sync,
there's the counter of missing devices. And that there are typically
only very few missing devices is also something to consider.

The device selection in __btrfs_alloc_chunk can avoid that. There's an
array allocated, with some size related data then it's passed to qsort
so the first N drives will be used for the chunk.

In case the degraded allocation is allowed (as mentioned in the other
mail, only for the mirrored profiles)

* add the missing device to the array
* update the comparison function btrfs_cmp_device_info to order missing
  devices to the end

Then the same logic "first N" would work here.
