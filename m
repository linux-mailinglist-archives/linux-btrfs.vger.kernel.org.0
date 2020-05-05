Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825561C4BAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEECAY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 4 May 2020 22:00:24 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44264 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgEECAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 22:00:24 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 432AE6A64FC; Mon,  4 May 2020 22:00:21 -0400 (EDT)
Date:   Mon, 4 May 2020 22:00:21 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <20200505020021.GR10769@hungrycats.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <CAJCQCtQt0S6b66yKRFT6bV=z4r+CEvjss3o66EoT=oiz7UKuxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJCQCtQt0S6b66yKRFT6bV=z4r+CEvjss3o66EoT=oiz7UKuxQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 04, 2020 at 05:24:11PM -0600, Chris Murphy wrote:
> On Mon, May 4, 2020 at 5:09 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> 
> > Some kinds of RAID rebuild don't provide sufficient idle time to complete
> > the CMR-to-SMR writeback, so the host gets throttled.  If the drive slows
> > down too much, the kernel times out on IO, and reports that the drive
> > has failed.  The RAID system running on top thinks the drive is faulty
> > (a false positive failure) and the fun begins (hope you don't have two
> > of these drives in the same array!).
> 
> This came up on linux-raid@ list today also, and someone posted this
> smartmontools bug.
> https://www.smartmontools.org/ticket/1313
> 
> It notes in part this error, which is not a time out.

Uhhh...wow.  If that's not an individual broken disk, but the programmed
behavior of the firmware, that would mean the drive model is not usable
at all.

> [20809.396284] blk_update_request: I/O error, dev sdd, sector
> 3484334688 op 0x1:(WRITE) flags 0x700 phys_seg 2 prio class 0
> 
> An explicit write error is a defective drive. But even slow downs
> resulting in link resets is defective. The marketing of DM-SMR says
> it's suitable without having to apply local customizations accounting
> for the drive being SMR.
> 
> 
> > Desktop CMR drives (which are not good in RAID arrays but people use
> > them anyway) have firmware hardcoded to retry reads for about 120
> > seconds before giving up.  To use desktop CMR drives in RAID arrays,
> > you must increase the Linux kernel IO timeout to 180 seconds or risk
> > false positive rejections (i.e. multi-disk failures) from RAID arrays.
> 
> I think we're way past the time when all desktop oriented Linux
> installations should have overridden the kernel default, using 180
> second timeouts instead. Even in the single disk case. The system is
> better off failing safe to slow response, rather than link resets and
> subsequent face plant. But these days most every laptop and desktop's
> sysroot is on an SSD of some kind.
> 
> 
> > Now here is the problem:  DM-SMR drives have write latencies of up to 300
> > seconds in *non-error* cases.  They are up to 10,000 times slower than
> > CMR in the worst case.  Assume that there's an additional 120 seconds
> > for error recovery on top of the non-error write latency, and add the
> > extra 50% for safety, and the SMR drive should be configured with a
> > 630 second timeout (10.5 minutes) in the Linux kernel to avoid false
> > positive failures.
> 
> Incredible.
> 
> 
> -- 
> Chris Murphy
