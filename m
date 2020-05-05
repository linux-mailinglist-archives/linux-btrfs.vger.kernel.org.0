Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B31C4CAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 05:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgEED27 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 4 May 2020 23:28:59 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37664 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEED26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 23:28:58 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 575216A66A2; Mon,  4 May 2020 23:26:55 -0400 (EDT)
Date:   Mon, 4 May 2020 23:26:55 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <20200505032654.GS10769@hungrycats.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <CAJCQCtQt0S6b66yKRFT6bV=z4r+CEvjss3o66EoT=oiz7UKuxQ@mail.gmail.com>
 <20200505020021.GR10769@hungrycats.org>
 <CAJCQCtTxtY696bFwhOscOHc5fjsRz_=EzO5Zf9spBFez_59Ltg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAJCQCtTxtY696bFwhOscOHc5fjsRz_=EzO5Zf9spBFez_59Ltg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 04, 2020 at 08:22:24PM -0600, Chris Murphy wrote:
> On Mon, May 4, 2020 at 8:00 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Mon, May 04, 2020 at 05:24:11PM -0600, Chris Murphy wrote:
> > > On Mon, May 4, 2020 at 5:09 PM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > >
> > > > Some kinds of RAID rebuild don't provide sufficient idle time to complete
> > > > the CMR-to-SMR writeback, so the host gets throttled.  If the drive slows
> > > > down too much, the kernel times out on IO, and reports that the drive
> > > > has failed.  The RAID system running on top thinks the drive is faulty
> > > > (a false positive failure) and the fun begins (hope you don't have two
> > > > of these drives in the same array!).
> > >
> > > This came up on linux-raid@ list today also, and someone posted this
> > > smartmontools bug.
> > > https://www.smartmontools.org/ticket/1313
> > >
> > > It notes in part this error, which is not a time out.
> >
> > Uhhh...wow.  If that's not an individual broken disk, but the programmed
> > behavior of the firmware, that would mean the drive model is not usable
> > at all.
> 
> I haven't gone looking for a spec, but "sector ID not found" makes me
> think of a trim/remap related failure, which, yeah it's gotta be a
> firmware bug. This can't be "works as designed".

Usually IDNF is "I was looking for a sector, but I couldn't figure out
where on the disk it was," i.e. head positioning error or damage to the
metadata on a cylinder or sector header.  Though there are maybe some
that return IDNF instead of ABRT when they get a request for a sector
outside of the drive's legal LBA range.

The "didn't find a sector" variant usually indicates non-trivial damage
(impact on platter vs. bit fade), but could also be due to too much
vibration and a short read error timeout.  Also a small fraction of
bit errors will land on sector headers and produce IDNF without
other damage.

> 
> -- 
> Chris Murphy
