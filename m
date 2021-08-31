Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792873FCBC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbhHaQsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 12:48:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51994 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhHaQsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 12:48:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 344FD201AB;
        Tue, 31 Aug 2021 16:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630428465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qVY7qSMYbjs3YSsdcfRCFNAFvnRikensWwON4dtGiI=;
        b=SuPHT89ToYecXmKD7TjEq8YYfvuZthekiimbqtM5ipri8KdFdWB9kD22vSPQjXkwJ8hWmQ
        cIdCfYp955TAsVS57Zfie7ONtUw9GxKnM3g/wlIhLdlYNGrsncT/c2b1Tem5JfNGEP04PX
        WjmnrQGhZecnhu0JJtfCEYluSJnDqNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630428465;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qVY7qSMYbjs3YSsdcfRCFNAFvnRikensWwON4dtGiI=;
        b=8xBYn/6tplEn7oAHNjaCEXpKk8tdgaHIWyOTvpMoJy6F38P6vFXpJSVNU4RgpQTPOiyvme
        7CF4YHY7/KGbWqBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E9CC1A3B9C;
        Tue, 31 Aug 2021 16:47:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1028DA8C1; Tue, 31 Aug 2021 18:47:44 +0200 (CEST)
Date:   Tue, 31 Aug 2021 18:47:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Jingyun He <jingyun.ho@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: btrfs mount takes too long time
Message-ID: <20210831164744.GM3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Jingyun He <jingyun.ho@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAHQ7scVOYuzz58KcO_fo2rph44CCC46ef=LFVZF8XzoKYq27ig@mail.gmail.com>
 <250cfece-1d7f-b98a-b930-36baa34b8b72@oracle.com>
 <PH0PR04MB74166604ACA14137484EA6E59BCC9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB74166604ACA14137484EA6E59BCC9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 01:10:38PM +0000, Johannes Thumshirn wrote:
> [ +Cc Naohiro ]
> 
> On 31/08/2021 14:11, Anand Jain wrote:
> > But let's see what part in btrfs_load_block_group_zone_info() is taking
> > most of the time. Could you please help get this output?
> 
> I'd suspect it's the btrfs_get_dev_zone() call that we need to do for 
> each block group in order to determine the current write pointer to
> set block_group->alloc_offset.
> 
> We could speed up the mount process by caching the device's REPORT ZONES
> response, as we're doing a REPORT ZONES once to get all zones and then 
> again per block group load. On a 14TB SMR drive this results in 
> (14  * 1024 * 1024) / 256 + 1 = 57345 REPORT ZONES calls. OTOH 
> struct blk_zone is 64 bytes per zone resulting in 64 * 57344 = 3584kB
> data to be cached.
> 
> So the solution should probably somewhere in between, aka caching X 
> REPORT ZONES responses before we need to do a new one.

That sounds like a good option. The number of new members in block group
struct has grown due to zoned support, this means higher memory
requirements, scaling up with device size. We'll have to do something
about that eventually.
