Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2434DA459
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 22:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351838AbiCOVKA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCOVKA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 17:10:00 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F4C833E91
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 14:08:47 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 714DF25D2A0; Tue, 15 Mar 2022 17:08:47 -0400 (EDT)
Date:   Tue, 15 Mar 2022 17:08:47 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjEAX6NVIaJdqnCS@hungrycats.org>
References: <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
 <Yi/G+FFqF8TlafF3@hungrycats.org>
 <23441a6c-3860-4e99-0e56-43490d8c0ac2@georgianit.com>
 <Yi/SR7CNbtDvIsPn@hungrycats.org>
 <eda21cae-4825-458a-dd69-1e2740955dc0@georgianit.com>
 <YjDgKzAx/tawKHCz@hungrycats.org>
 <97800cf4-b96d-27f9-1ed9-b508501e5532@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97800cf4-b96d-27f9-1ed9-b508501e5532@georgianit.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 03:22:43PM -0400, Remi Gauvin wrote:
> On 2022-03-15 2:51 p.m., Zygo Blaxell wrote:
> 
> > The main advantage of larger extents is smaller metadata, and it doesn't
> > matter very much whether it's SSD or HDD.  Adjacent extents will be in
> > the same metadata page, so not much is lost with 256K extents even on HDD,
> > as long as they are physically allocated adjacent to each other.
> > 
> 
> When I tried enabling compress-force on my HDD storage, it *killed*
> sequential read performance.  I could write a file out at over
> 100MB/s... but trying to read that same file sequentially would trash
> the drives with less than 5MB/s actually being able to be read.
> 
> 
> No such problems were observed on ssd storage.

I've seen a similar effect.  I wonder if the small extents are breaking
readahead or something.

> I was under the impression this problem was caused trying to read files
> with the 127k extents,, which, for whatever reason, could not be done
> without excessive seeking.
