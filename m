Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09772569CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgH2SqM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 29 Aug 2020 14:46:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42724 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgH2SqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Aug 2020 14:46:11 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A74B77D9A62; Sat, 29 Aug 2020 14:46:10 -0400 (EDT)
Date:   Sat, 29 Aug 2020 14:46:10 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Wong <e@80x24.org>
Cc:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200829184610.GW5890@hungrycats.org>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org>
 <20200828023412.GA308@dcvr>
 <20200828043627.GE8346@hungrycats.org>
 <20200829004240.GA32462@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200829004240.GA32462@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 29, 2020 at 12:42:40AM +0000, Eric Wong wrote:
> Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > Remove makes a copy of every extent, updates every reference to the
> > extent, then deletes the original extents.  Very seek-heavy--including
> > seeks between reads and writes on the same drive--and the work is roughly
> > proportional to the number of reflinks, so dedupe and snapshots push
> > the cost up.  About the only advantage of remove (and balance) is that
> > it consists of 95% existing btrfs read and write code, and it can handle
> > any relocation that does not require changing the size or content of an
> > extent (including all possible conversions).
> 
> Does that mean remove speed would be closer to replace on good SSDs?

It will be better, but there is still a cost for reading and writing
non-contiguously.  "Good SSD" depends on what the SSD is good at.
A SSD rated for NAS or caching use would be OK, but a high-performance
desktop SSD could hit big write-multiplication penalties.  A couple of
brand names starting with "S" have 5-second IO stalls when their internal
caches get full.  Proportionally, the ratio between the best and worst
IO latency in these SSD models is as bad as SMR drives.  Also there are
CPU and IO latency costs for 'remove' in the host that don't go away
no matter how good the disks are.

> > Arguably this isn't necessary.  Remove could copy a complete block group,
> > the same way replace does but to a different offset on each drive, and
> > simply update the chunk tree with the new location of the block group
> > at the end.  Trouble is, nobody's implemented this approach in btrfs yet.
> > It would be a whole new code path with its very own new bugs to fix.
> 
> Ah, it seems like a ton of work for a use case that mainly
> affects hobbyists.  I won't hold my breath for it.

Well, by that argument, mdadm and lvm shouldn't be able to do it either,
and yet they have supported this style of reshape for years.
