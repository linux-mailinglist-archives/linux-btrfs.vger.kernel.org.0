Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156484D8FE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 23:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbiCNWye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 18:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiCNWyc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 18:54:32 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62BCC13F25
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 15:53:21 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 76AF125991B; Mon, 14 Mar 2022 18:52:10 -0400 (EDT)
Date:   Mon, 14 Mar 2022 18:51:36 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <Yi/G+FFqF8TlafF3@hungrycats.org>
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <CAODFU0rXnDhQjGPyuBQ8kxUGBXzQFMkXrNXiSxmcvgaaixspvg@mail.gmail.com>
 <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd54e6e1-6180-1685-6500-278c639bb2e8@georgianit.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 06:24:43PM -0400, Remi Gauvin wrote:
> On 2022-03-14 5:53 p.m., Jan Ziak wrote:
> 
> 
> > ....
> > 
> > In this test case, "Disk Usage" is 60% higher than the file's size:
> > 
> > $ compsize data
> > Processed 1 file, 612 regular extents (1221 refs), 0 inline.
> > Type       Perc     Disk Usage   Uncompressed Referenced
> > TOTAL      100%       16M          16M          10M
> 
> 
> It would be nice if we could get a mount option to specify maximum
> extent size, so this effect could be minimized on SSD without having to
> use compress-force.  (Or maybe this should be the default When ssd mode
> is automaticallyd detected.)

If you never use prealloc or defrag, it's usually not a problem.

Files mostly fall into two categories:  big sequential writes (where
big extents are better) or small random writes (where big extents are
bad, but you don't have any of those because you're doing small random
writes all the time).  Writeback gets this right most of the time,
so the extents end up the right sizes on disk.

If all your writes are random, short, and aligned to a multiple of 4K,
then you'll end up in a steady state with a lot of short extents and
little to no wasted space.  If you run defrag on that, you end up with
half the space wasted, and if the writes continue, lots of small extents
either way.

Prealloc's bad effects are similar to defrag, but with more reliable
losses.

A mount option to disable prealloc globally might be very useful--I
run a number of apps that think prealloc doesn't waste huge amounts of
CPU time and disk space on datacow files, and I grow weary of patching
or LD_PRELOAD-hacking them all the time to not call fallocate().
