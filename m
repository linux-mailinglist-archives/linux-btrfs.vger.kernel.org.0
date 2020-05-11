Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A478E1CD135
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 07:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgEKFGi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 11 May 2020 01:06:38 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46582 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgEKFGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 01:06:38 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 560C26B938D; Mon, 11 May 2020 01:06:36 -0400 (EDT)
Date:   Mon, 11 May 2020 01:06:35 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Phil Karn <karn@ka9q.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <20200511050635.GT10769@hungrycats.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 09, 2020 at 10:46:27PM +0100, Steven Fosdick wrote:
> On Sat, 9 May 2020 at 22:02, Phil Karn <karn@ka9q.net> wrote:
> > My understanding is that large sequential writes can go directly to the
> > SMR areas, which is an argument for a more conventional RAID array. How
> > hard does btrfs try to do large sequential writes?
> 
> Ok, so I had not heard of SMR before it was mentioned here and
> immediate read the links.  It did occur to me that large sequential
> writes could, in theory, go straight to SMR zones but it also occurred
> to be that it isn't completely straight forward.

This is a nice overview:

	https://www.snia.org/sites/default/files/Dunn-Feldman_SNIA_Tutorial_Shingled_Magnetic_Recording-r7_Final.pdf

> 1. If the drive firmware is not declaring that the drive uses SMR, and
> therefore the host doesn't send a specific command to begin a
> sequential write, how many sectors in a row does the drive wait to
> receive before conclusion this is a large sequential operation?
> 
> 2. What happens if the sequential operation does not begin a the start
> of an SMR zone?

In the event of a non-append write, a RMW operation performed on the
entire zone.

The exceptions would be data extents that are explicitly deleted
(TRIM command), and it looks like a sequential overwrite at the _end_
of a zone (i.e. starting in the middle on a sector boundary and writing
sequentially to the end of the zone without writing elsewhere in between)
can be executed without having to rewrite the entire zone (zones can be
appended at any time, the head erases data forward of the write location).
I don't know if any drives implement that.

In order to get conventional flush semantics to work, the drive has
to write everything twice:  once to a log zone (which is either CMR
or SMR), then copy from there back to the SMR zone to which it belongs
("cleaning").  There is necessarily a seek in between, as the log zone
and SMR data zones cannot coexist within a track.

DM-SMR drives usually have smaller zones than HA-SMR drives, but we can
only guess (or run a timing attack to find out).  This would allow the
drive to track a few zones in the typical 256MB RAM cache size for the
submarined SMR drives.

This source reports zone sizes of 15-40MB for DM-SMR and 256MB for HA-SMR,
with cache CMR sizes not exceeding 0.2% of capacity:

	https://www.usenix.org/system/files/conference/hotstorage16/hotstorage16_wu.pdf

btrfs should do OK as long as you use space_cache=v2--space cache v1
would force the drive into slow RMW operations every 30 seconds, as it
would be forcing the drive to complete cleaning operations in multiple
zones.  Nobody should be using space_cache=v1 any more, and this is
just yet another reason.

Superblock updates would keep 2 zones updated all the time, effectively
reducing the number of usable open zones in the drive permanently by 2.
Longer commit intervals may help.

> The only thing that would make it easy is if the drive had a
> battery-backed RAM cache at least as big as an SMR zone, ideally about
> twice as big, so it could accumulate the data for one zone and then
> start writing that while accepting data for the next.  As I have no
> idea how big these zones are I have no idea how feasible that is.

Batteries and flash are expensive, so you can assume the drive has neither
unless they are prominently featured in the marketing docs to explain
the costs that are passed on to the customer.  All of the metadata and
caches are stored on the spinning platters.
