Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D73D4762
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhGXKoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhGXKoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 06:44:11 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7BBC061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 04:24:43 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1m7FlV-0002tY-8z; Sat, 24 Jul 2021 12:24:21 +0100
Date:   Sat, 24 Jul 2021 12:24:21 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210724112421.GB992@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        waxhead <waxhead@dirtcellar.net>, dsterba@suse.cz,
        Roman Mamedov <rm@romanrm.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz>
 <20210723222730.1d23f9b4@natsu>
 <20210723192145.GF19710@suse.cz>
 <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 01:04:19PM +0200, waxhead wrote:
> David Sterba wrote:
> 
> > Maybe it's still too new so nobody is used to it and we've always had
> > problems with the raid naming scheme anyway.
> 
> Some years ago (2018) there was some talk about a new naming scheme
> https://marc.info/?l=linux-btrfs&m=136286324417767
> 
> While technically spot on I found Hugo's naming scheme difficult. It was
> based on this idea:
> numCOPIESnumSTRIPESnumPARITY
> 
> 1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.
> 
> I also do not agree with the use of 'copy'. The Oxford dictionary defines
> 'copy' as "a thing that is made to be the same as something else, especially
> a document or a work of art"
> 
> And while some might argue that copying something on disk from memory makes
> it a copy, it ceases to be a copy once the memory contents is erased. I
> therefore think that replicas is a far better terminology.
> 
> I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is far
> more readable so if I may dare to be as bold....
> 
> SINGLE  = R0.S0.P0 (no replicas, no stripes (any device), no parity)
> DUP     = R1.S1.P0 (1 replica, 1 stripe (one device), no parity)
> RAID0   = R0.Sm.P0 (no replicas, max stripes, no parity)
> RAID1   = R1.S0.P0 (1 replica, no stripes (any device), no parity)
> RAID1c2 = R2.S0.P0 (2 replicas, no stripes (any device), no parity)
> RAID1c3 = R3.S0.P0 (3 replicas, no stripes (any device), no parity)
> RAID10  = R1.Sm.P0 (1 replica, max stripes, no parity)
> RAID5   = R0.Sm.P1 (no replicas, max stripes, 1 parity)
> RAID5   = R0.Sm.P2 (no replicas, max stripes, 2 parity)
> 
> This (or Hugo's) type of naming scheme would also easily allow add more
> exotic configuration such as S5 e.g. stripe over 5 devices in a 10 device
> storage system which could increase throughput for certain workloads
> (because it leaves half the storage devices "free" for other jobs)
> A variant of RAID5 behaving like RAID10 would simply be R1.Sm.P1. Easy
> peasy...  And just for the record , the old RAID terminology should of
> course work for compatibility reasons, but ideally should not be advertised
> at all.
> 
> Sorry for completely derailing the topic, but I felt it was important to
> bring up (and I admit to be overenthusiastic about it). :)

   I'd go along with that scheme, with one minor modification -- make
the leading letters lower-case. The choice of lower-case letters in my
original scheme was deliberate, as it breaks up the sequence and is
much easier to pick out the most important parts (the numbers) from
the mere positional markers (the letters).

   Also, the "M" (caps, because it's equivalent to the large numbers)
in stripes wasn't for "max", but simply the conventional mathematical
"m" -- some number acting as a limit to a counter (as in, "we have n
copies with m stripes and p parity stripes").

   Hugo.

-- 
Hugo Mills             | I must be musical: I've got *loads* of CDs
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                     Fran, Black Books
