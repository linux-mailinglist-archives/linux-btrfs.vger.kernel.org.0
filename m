Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019473D3BA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhGWNay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 09:30:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhGWNax (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 09:30:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E1E71FFBD;
        Fri, 23 Jul 2021 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627049486;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEL3I9lPPxZMigus1J9CQerWJ/oSid06amLVgKlOooc=;
        b=j89yQk+5iYg2+14EtIjI2RQarJW67nb69wjm6pGmEQbrlL/6Pvyrvs7HhFxP/jv9cO9isW
        OvyGnLzX8TbXoSOd0tvn5z77uSX9BwCVUmvdlCcR+ih9WK2dmj+TU4aKjPb7b6KEdpzwLV
        QFtZ6rwo47grJSkD+aQtQ2z6E+E7V1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627049486;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEL3I9lPPxZMigus1J9CQerWJ/oSid06amLVgKlOooc=;
        b=Jw5AqEWsAShHqv73olchQ0cNXlejT6o7NDBT76QqsLgtB4eYg3mWhOq4GONnd4lPjhMrl8
        cHNegPU+nhXv7bCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 76C12A3B90;
        Fri, 23 Jul 2021 14:11:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 498B2DA8EB; Fri, 23 Jul 2021 16:08:44 +0200 (CEST)
Date:   Fri, 23 Jul 2021 16:08:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210723140843.GE19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 23, 2021 at 06:51:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/23 上午3:29, David Sterba wrote:
> > The data on raid0 and raid10 are supposed to be spread over multiple
> > devices, so the minimum constraints are set to 2 and 4 respectively.
> > This is an artificial limit and there's some interest to remove it.
> 
> This could be a better way to solve the SINGLE chunk created by degraded
> mount.

Yes, but in this case it's rather a conicidence because raid0 now
becomes a valid fallback profile, other cases are not affected. There's
also some interest to allow full write with missing devices (as long as
complete data can be written, not necessarily to all copies). MD-RAID
allows that.

As an example, when we'd allow that, 2 device raid1 with one missing
will continue to write to the present device and once the missing device
reappears, scrub will fill the missing bits, or device replace will do a
full sync.

> > Change this to allow raid0 on one device and raid10 on two devices. This
> > works as expected eg. when converting or removing devices.
> >
> > The only difference is when raid0 on two devices gets one device
> > removed. Unpatched would silently create a single profile, while newly
> > it would be raid0.
> >
> > The motivation is to allow to preserve the profile type as long as it
> > possible for some intermediate state (device removal, conversion).
> >
> > Unpatched kernel will mount and use the degenerate profiles just fine
> > but won't allow any operation that would not satisfy the stricter device
> > number constraints, eg. not allowing to go from 3 to 2 devices for
> > raid10 or various profile conversions.
> 
> My initial thought is, tree-checker will report errors like crazy, but
> no, the check for RAID1 only cares substripe, while for RAID0 no number
> of devices check.
> 
> So a good surprise here.
> 
> Another thing is about the single device RAID0 or 2 devices RAID10 is
> the stripe splitting.
> 
> Single device RAID0 is just SINGLE, while 2 devices RAID10 is just RAID1.
> Thus they need no stripe splitting at all.
> 
> But we will still do the stripe calculation, thus it could slightly
> reduce the performance.
> Not a big deal though.

Yeah effectively they're raid0 == single, raid10 == raid1, I haven't
checked the overhead of the additional striping logic nor measured
performance impact but I don't feel it would be noticeable.

> > Example output:
> >
> >    # btrfs fi us -T .
> >    Overall:
> >        Device size:                  10.00GiB
> >        Device allocated:              1.01GiB
> >        Device unallocated:            8.99GiB
> >        Device missing:                  0.00B
> >        Used:                        200.61MiB
> >        Free (estimated):              9.79GiB      (min: 9.79GiB)
> >        Free (statfs, df):             9.79GiB
> >        Data ratio:                       1.00
> >        Metadata ratio:                   1.00
> >        Global reserve:                3.25MiB      (used: 0.00B)
> >        Multiple profiles:                  no
> >
> > 		Data      Metadata  System
> >    Id Path       RAID0     single    single   Unallocated
> >    -- ---------- --------- --------- -------- -----------
> >     1 /dev/sda10   1.00GiB   8.00MiB  1.00MiB     8.99GiB
> >    -- ---------- --------- --------- -------- -----------
> >       Total        1.00GiB   8.00MiB  1.00MiB     8.99GiB
> >       Used       200.25MiB 352.00KiB 16.00KiB
> >
> >    # btrfs dev us .
> >    /dev/sda10, ID: 1
> >       Device size:            10.00GiB
> >       Device slack:              0.00B
> >       Data,RAID0/1:            1.00GiB
> 
> Can we slightly enhance the output?
> RAID0/1 really looks like a new profile now, even the "1" really means
> the number of device.

Do you have a concrete suggestion? This format was inspired by a
discussion and suggested by users so I guess this is what people expect
and I find it clear. It's also documented in manual page so if you think
it's not clear or missing some important information, please let me
know.
