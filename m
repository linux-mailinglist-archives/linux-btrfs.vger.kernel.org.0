Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20323D47A3
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhGXLuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhGXLuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 07:50:35 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0EC061575
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 05:31:07 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1m7Gnq-0002xH-Af; Sat, 24 Jul 2021 13:30:50 +0100
Date:   Sat, 24 Jul 2021 13:30:50 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210724123050.GD992@savella.carfax.org.uk>
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
> Perhaps slightly off topic , but I see constantly that people do not
> understand how BTRFS "RAID" implementation works. They tend to confuse it
> with regular RAID and get angry because they run into "issues" simply
> because they do not understand the differences.
> 
> I have been an enthusiastic BTRFS user for years, and I actually caught
> myself incorrectly explaining how regular RAID works to a guy a while ago.
> This happened simply because my mind was so used to how BTRFS uses this
> terminology that I did not think about it.
> 
> As BTRFS is getting used more and more it may be increasingly difficult (if
> not impossible) to get rid of the "RAID" terminology, but in my opinion also
> increasingly more important as well.
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

   Sorry, I missed a detail here that someone pointed out on IRC.

   "r0" makes no sense to me, as that says there's no data. I would
argue strongly to add one to all of your r values. (Note that
"RAID1c2" isn't one of the current btrfs RAID levels, and by extension
from the others, it's equivalent to the current RAID1, and we have
RAID1c4 which is four complete instances of any item of data).

   My proposal counted *instances* of the data, not the redundancy.

   Hugo.

-- 
Hugo Mills             | Great films about cricket: Silly Point Break
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
