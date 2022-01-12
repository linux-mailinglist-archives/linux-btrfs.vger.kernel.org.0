Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A648C31D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbiALLa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 06:30:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41338 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiALLaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 06:30:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5AE561F37F;
        Wed, 12 Jan 2022 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641987023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbnmV9uPOcPBnyC77Q20zR7L+I87rc57xrmChotj5gk=;
        b=NhphaQXtENHfAKKmVxKNGtcAomezzKCu3l6AFUAgPpi/q53LlieS6zo/EacDGu5Qhbql4n
        H8WLhNoKOYtOttn1Z1kmb+B6HfC/7ii4cnLvjpjzPi1DzxQZypSSncgzttfCpGjLPHyVSN
        IkV6ob/2XvUQM7gjS7lPHiy4Q6SMSoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641987023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbnmV9uPOcPBnyC77Q20zR7L+I87rc57xrmChotj5gk=;
        b=2BQaL7DB/H6i41821kPaKLJJkSKK0OglfXArPUQWYXG+3oeSLYRIJ9/eX149fsYO3RqM6h
        XwurpR/sOHLismCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 53ED2A3B89;
        Wed, 12 Jan 2022 11:30:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EA965DA7A3; Wed, 12 Jan 2022 12:29:49 +0100 (CET)
Date:   Wed, 12 Jan 2022 12:29:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs send picks wrong subvolume UUID
Message-ID: <20220112112949.GW14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
 <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
 <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
 <86abf8ba-5613-cf1b-bdca-6039b5e23524@suse.com>
 <CAOE4rSwxj4c5tHWzZO61zD5_CswX+DLxjNLWvLpt4EcNiGYBfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSwxj4c5tHWzZO61zD5_CswX+DLxjNLWvLpt4EcNiGYBfA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 11, 2022 at 06:46:11PM +0200, Dāvis Mosāns wrote:
> otrd., 2022. g. 11. janv., plkst. 17:33 — lietotājs Nikolay Borisov
> (<nborisov@suse.com>) rakstīja:
> > On 3.01.22 г. 20:09, Dāvis Mosāns wrote:
> > > svētd., 2022. g. 2. janv., plkst. 22:37 — lietotājs Andrei Borzenkov
> > > (<arvidjaar@gmail.com>) rakstīja:
> > >>
> > >> On Sun, Jan 2, 2022 at 8:05 PM Dāvis Mosāns <davispuh@gmail.com> wrote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> I have a bunch of snapshots I want to send from one fs to another,
> > >>> but it seems btrfs send is using received UUID instead of subvolumes own UUID
> > >>> causing wrong subvolume to be picked by btrfs receive and thus failing.
> > >>>
> > >>> $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
> > >>> 2019-11-02/etc
> > >>>         Name:                   etc
> > >>>         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
> > >>>         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
> > >>>         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
> > >>>
> > >>
> > >> btrfs send will always use received UUID if available, it works as
> > >> designed and is not a bug. Bug is to have received UUID on read-write
> > >> subvolume. btrfs does not prevent it and it is the result of wrong
> > >> handling on the user side. You should never ever change read-only
> > >> subvolume used for send/receive to read-write directly - instead you
> > >> should always create writable clone from it.
> > >>
> > >> This was discussed extensively, see e.g.
> > >> https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com/
> > >
> > > I consider it as bug. How can anyone know they shouldn't do that. It
> > > is perfectly valid use case for sending subvolumes from one system to
> > > another system. After sending using "btrfs property set ro false" to
> > > set RW. Sounds very logical, why should I create a new snapshot? I
> > > just sent new one. Original system's subvolume could even be deleted
> > > with no plans to ever do any incremental sends. And seems many people
> > > have had this issue which just proves my point it's a bug. And if this
> > > is not supported, then why there exists such "btrfs property set ro
> > > false" at all who lets you shoot yourself in foot? If it didn't exist
> > > then everyone would use only other option by creating new RW snapshot
> > > which actually sounds more like a workaround for broken property set.
> > > So I would say first bug that needs fixing is changing "btrfs property
> > > set ro false" in kernel so that it clears received_uuid and
> > > regenerates new subvolume uuid because such modified subvolume isn't
> > > same as source and would still causes issue if it stayed same.
> > > That would fix it for future but wouldn't solve it for many people who
> > > already have such subvolumes. And it's pretty hard problem to track
> > > down unless you already know it. Like it took me a lot of time to
> > > figure out why send is failing. ro->rw was done 7 years ago and all
> > > snapshots since then have same received_uuid but I noticed btrfs send
> > > not working only now. For me, easiest way I'll just patch kernel to
> > > always use subvolume's uuid and ignore received_uuid, then btrfs send
> > > all snapshots so it will work fine for me. As for others, in general
> > > seems proper fix would be that btrfs send would give both uuid and
> > > received_uuid. Then btrfs receive could have a flag to ignore
> > > received_uuid and just use uuid. Or search by uuid and then fallback
> > > to received_uuid.
> >
> >
> > That behavior got fixed in btrfs-progs in version 5.14, in particular
> > commit:
> >
> > https://github.com/kdave/btrfs-progs/commit/3b90ebc2d7eb4b4a4d5d55eff362e8127a673828
> >
> > Of course it requires users upgrading btrfs-progs but even if we merged
> > some kernel-side fix (there's been one I authored couple of years ago
> > and it's been circulated on the mailing list but didn't get merged) it
> > would still require users upgrading their kernel eventually.
> 
> The issue is not that users wouldn't update, but that old filesystems
> are already present with this case. This is why fix in btrfs-progs
> doesn't help. It prevents it only happening in future but not for
> people who already have such filesystems thus kernel fix is necessary
> as I described.

The progs fix can do (and does) the same as what kernel would do (while
cluttering the ioctl implementation a bit).

Old filesystems, where ro/rw switch has happened on sent subvolumes will
be reported and warn in command 'btrfs subvolume show'. To reset the
received_uuid, flipping the ro/rw property works since 5.14.2, and this
is needed just once on any affected subvolume.

Updating the progs should be easier than updating kernel, so the fix is
there and available also for LTS kernels.
