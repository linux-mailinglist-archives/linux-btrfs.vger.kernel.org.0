Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07E5EE087
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiI1Pdk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 11:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbiI1PdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 11:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED3C9973;
        Wed, 28 Sep 2022 08:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BEA561EFD;
        Wed, 28 Sep 2022 15:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92953C433C1;
        Wed, 28 Sep 2022 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664379167;
        bh=2EUplTuwlkLDv8yF0HvdcZx3IIz7WNtbOI9oKAAlT0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwdBWdfZEjWnOk/oEvm0s9/Ub4NYipbKqNh7ruX+8yTvVeMQVjguQFakSG+r9MOjb
         9mgWzxl6kP4Zj6aHP9OJ7HaO1dyOMubMUXGScOYwhho9E20f8STrf8tM18gXTwAr9s
         Vbdt/yvNuWqnVUbJGiGpUhwKSQjp5evQo4iI6d41QcLb1Onr3P1qWPHDCWa3ElZgnE
         fOi3CEuyivcllR1KL+z0RaHmSiuwgCAJxJggQr45cAmzFdxJxONRWD7Ylaxv92MSTZ
         18hdDA0jhKa0o1x2o6n7lfArIo8f6hwcxA7tRPNUHoWz89e7gZNjh/AVFoCq7yo1oG
         v7Nzs+aWn4Zfg==
Date:   Wed, 28 Sep 2022 08:32:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: introduce zone_capacity() to return a zone
 capacity
Message-ID: <YzRpH5SvkKwhlELi@magnolia>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <97ede9bba67f0848fc0b706d757170d7dfacb7fd.1663825728.git.naohiro.aota@wdc.com>
 <20220922154132.dpadkhaccwzysq4d@zlang-mailbox>
 <PH0PR04MB741656D7881D11281ECBBD489B519@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220923115126.s3ctf4erpepa3zy7@zlang-mailbox>
 <20220928035707.v7kv4ult46w3hjlj@naota-xeon>
 <20220928054715.ol6gammnf6jmrjab@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928054715.ol6gammnf6jmrjab@zlang-mailbox>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 28, 2022 at 01:47:15PM +0800, Zorro Lang wrote:
> On Wed, Sep 28, 2022 at 03:57:08AM +0000, Naohiro Aota wrote:
> > On Fri, Sep 23, 2022 at 07:51:26PM +0800, Zorro Lang wrote:
> > > On Fri, Sep 23, 2022 at 08:02:10AM +0000, Johannes Thumshirn wrote:
> > > > On 22.09.22 17:42, Zorro Lang wrote:
> > > > >> --- /dev/null
> > > > >> +++ b/common/zbd
> > > > > I don't like this abbreviation :-P If others don't open this file and read the
> > > > > comment in it, they nearly no chance to guess what's this file for.
> > > > > 
> > > > 
> > > > zbd is a well known abbreviation for zoned block devices. I think most
> > > > people in storage and filesystems know it.
> > > 
> > > OK, but we haven't been that "a single character is worth a thousand
> > > pieces of gold", so we can use a longer name, likes common/zone,
> > > common/zoned, common/zoned_block, common/zoned_device or something likes
> > > that. Anyway, that's just my personal opinion, if most of people prefer
> > > using "common/zbd", I'm fine to have that :) 
> > 
> > Sure. I'll use "zoned" as it is more common in the kernel code.
> > 
> > > But I hope you can move all zoned block device related helpers to the new
> > > common file if you'd like to bring in this file, likes what Darrick did in:
> > > 
> > > commit 67afd5c742464607994316acb2c6e8303b8af4c5
> > > Author: Darrick J. Wong <djwong@kernel.org>
> > > Date:   Tue Aug 9 14:00:46 2022 -0700
> > > 
> > >     common/rc: move ext4-specific helpers into a separate common/ext4 file
> > 
> > Yes, that will be better to have things in common/zoned. I considered
> > moving zoned functions (_zone_type, _require_{,non_}zoned_device), but
> > _require_loop() and _require_dm_target() use _require_non_zoned_device() in
> > them. So, moving _require_non_zoned_device() will make a dependency from
> > common/rc to common/zoned, which I considered not much clean. How do you
> > think of it?
> 
> Oh, below commit [1] brought in the coupling of common/rc and zoned helpers.
> Hmm... that cause all the 3 helpers (_zone_type, _require_{,non_}zoned_device)
> have to be in common/rc or be imported in common/rc. Looks like we have to
> keep them in common/rc, except we make a bigger refactor to common/rc, or you'd
> like to make your 2 new helpers in common/rc too (likes these 3 old ones:)
> 
> BTW I doubt if we might need to use more zoned related helpers in common/rc, due
> to we deal with test devices in common/rc mostly, likes dax. Someone might want
> a seperated common/dax or common/pmem file one day. The common/rc imports
> specific fs helpers according to $FSTYP (common/config: _source_specific_fs()).
> If we need to deal with different kind of device types in common/rc one day, is
> there a better idea to determine which one should be imported? Welcome any
> suggestions if anyone has :)

Leave those three in common/rc and put/move the rest to common/zoned ?

I think it's fine for common/rc to have helpers that *detect* the
presence of a blockdev feature, and require tests to source
common/$feature if they want to do anything clever with that feature.
After all, the _require_non_zoned_device tests don't care about
_zone_capacity, right?

--D

> [1]
> commit 952310a57d9323ae0bb174b50be93107a8895e0c
> Author: Naohiro Aota <naohiro.aota@wdc.com>
> Date:   Mon Aug 16 20:35:08 2021 +0900
> 
>     common: add zoned block device checks
> 
> > 
> > Moving _filter_blkzone_report() would be fine, though.
> 
> Yeah, moving this is fine.
> 
> Thanks,
> Zorro
> 
> > 
> > > Thanks,
> > > Zorro
> > > 
> > > > 
> > > > 
> > > 
> > 
> 
