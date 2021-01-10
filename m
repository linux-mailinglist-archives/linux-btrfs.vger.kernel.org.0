Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162152F0762
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAJNWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 08:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbhAJNWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 08:22:03 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1D2C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 05:21:22 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kyaee-0000R6-7Q; Sun, 10 Jan 2021 13:21:12 +0000
Date:   Sun, 10 Jan 2021 13:21:12 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Cedric.dewijs@eclipso.eu, arvidjaar@gmail.com,
        linux-btrfs@vger.kernel.org
Subject: Re: Re: Re: cloning a btrfs drive with send and receive: clone is
 bigger than the original?
Message-ID: <20210110132112.GA1374@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Graham Cobb <g.btrfs@cobb.uk.net>, Cedric.dewijs@eclipso.eu,
        arvidjaar@gmail.com, linux-btrfs@vger.kernel.org
References: <55cef4872380243c9422595700686b79@mail.eclipso.de>
 <2752504c-d086-0977-06a3-1bb22c799a70@gmail.com>
 <b709a56556c3adfc9ff352f2a51db3a3@mail.eclipso.de>
 <067af02fb023de04276f14aa6f26ae8e@mail.eclipso.de>
 <8344b57d-9a2a-f4e9-59cb-42d6a7fa0600@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8344b57d-9a2a-f4e9-59cb-42d6a7fa0600@cobb.uk.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 10, 2021 at 01:06:44PM +0000, Graham Cobb wrote:
> On 10/01/2021 07:41, Cedric.dewijs@eclipso.eu wrote:
> > I've tested some more.
> > 
> > Repeatedly sending the difference between two consecutive snapshots creates a structure on the target drive where all the snapshots share data. So 10 snapshots of 10 files of 100MB takes up 1GB, as expected.
> > 
> > Repeatedly sending the difference between the first snapshot and each next snapshot creates a structure on the target drive where the snapshots are independent, so they don't share any data. How can that be avoided?
> 
> If you send a snapshot B with a parent A, any files not present in A
> will be created in the copy of B. The fact that you already happen to
> have a copy of the files somewhere else on the target is not known to
> either the sender or the receiver - how would it be?
> 
> If you want the send process to take into account *other* snapshots that
> have previously been sent, you need to tell send to also use those
> snapshots as clone sources. That is what the -c option is for.

   And even then, it won't spot files that are identical but which
don't share extents.

> Alternatively, use a deduper on the destination after the receive has
> finished and let it work out what can be shared.

   This is a viable approach.

   Hugo.

-- 
Hugo Mills             | The last man on Earth sat in a room. Suddenly, there
hugo@... carfax.org.uk | was a knock at the door.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Frederic Brown
