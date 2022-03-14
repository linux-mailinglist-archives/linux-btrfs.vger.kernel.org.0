Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED214D907C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiCNXla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 19:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiCNXl1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 19:41:27 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C0AB3D492
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 16:40:17 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 32209259B49; Mon, 14 Mar 2022 19:39:51 -0400 (EDT)
Date:   Mon, 14 Mar 2022 19:39:51 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <Yi/SR7CNbtDvIsPn@hungrycats.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
 <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 07:07:44PM -0400, Remi Gauvin wrote:
> On 2022-03-14 6:51 p.m., Zygo Blaxell wrote:
> > If you never use prealloc or defrag, it's usually not a problem.
> 
> You're assuming that the file is created from scratch on that media.  VM
> and databases that are restored from images/backups, or re-written as
> some kind of maintenance, (shrink vm images, compress database, or
> whatever) become a huge problem.

VM images do sometimes combine sequential and random writes and create
a lot of waste.  They are one of the outliers that is a problem case
even with a normal life cycle (as opposed to one interrupted by backup
restore).  A cluster command in SQL can instantly double a DB size.

> In one instance, I had a VM image that was taking up more than 100% of
> it's filesize due to lack of defrag.  For a while I was regularly
> defragmenting those with target size of 100MB as the only way to garbage
> collect, but that is a shameful waste of write cycles on SSD.  Adding
> compress-force=lzo was the only way for me to solve this issue, (and it
> even seems to help performance (on SSD, *not* HDD), though probably not
> for small random reads,, I haven't properly compared that.)

Ideally we'd have a proper garbage collection tool for btrfs that ran
defrag _only_ on extents that are holding references to wasted space,
which is the side-effect of defrag that most people want instead of
what defrag nominally tries to do.  I have it on my already too-long
to-do list.

If we're adding a mount option for this (I'm not opposed to it, I'm
pointing out that it's not the first tool to reach for), then ideally
we'd overload it for the compressed batch size (currently hardcoded
at 512K).  I have IO patterns that would like compress-force to write
128M uncompressed extents, and provide enough extents at a time to keep
all the cores busy sequentially compressing a single extent on each one.
