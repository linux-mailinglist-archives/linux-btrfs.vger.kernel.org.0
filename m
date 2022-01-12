Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2491448C345
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jan 2022 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352901AbiALLho (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jan 2022 06:37:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239690AbiALLho (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jan 2022 06:37:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 594261F37F;
        Wed, 12 Jan 2022 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641987463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTLj63OtNDKyTw5nqMpDPvkcnYC7H5NnNHwc+WUPlqI=;
        b=ourqjNDM452Ou+yStziuK0MMHkHdONliN19njQPTG7df5LdR4QZ27v9GvzI0R/FIdZE+m1
        Ta6gVamvpYsON1XBeBksPThwHFWzi5SD15fSLF5C1IPO+iaXNiOO1kS4nnyQNse9c5rG9L
        p7WZ1VuU98kJOGhsG7dfNSfTPtNdMIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641987463;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTLj63OtNDKyTw5nqMpDPvkcnYC7H5NnNHwc+WUPlqI=;
        b=honapWfmLnr20NPythGf5hbSgQHdCsUahRIWWfznSgX1Q9SQrhu4OK+IYhCjg2V+ljHklU
        uTbP5rLmjgaxDvBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5207EA3B83;
        Wed, 12 Jan 2022 11:37:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D95A8DA7A3; Wed, 12 Jan 2022 12:37:09 +0100 (CET)
Date:   Wed, 12 Jan 2022 12:37:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs send picks wrong subvolume UUID
Message-ID: <20220112113709.GX14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
 <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
 <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 03, 2022 at 08:09:01PM +0200, Dāvis Mosāns wrote:
> svētd., 2022. g. 2. janv., plkst. 22:37 — lietotājs Andrei Borzenkov
> (<arvidjaar@gmail.com>) rakstīja:
> >
> > On Sun, Jan 2, 2022 at 8:05 PM Dāvis Mosāns <davispuh@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I have a bunch of snapshots I want to send from one fs to another,
> > > but it seems btrfs send is using received UUID instead of subvolumes own UUID
> > > causing wrong subvolume to be picked by btrfs receive and thus failing.
> > >
> > > $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
> > > 2019-11-02/etc
> > >         Name:                   etc
> > >         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
> > >         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
> > >         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
> > >
> >
> > btrfs send will always use received UUID if available, it works as
> > designed and is not a bug. Bug is to have received UUID on read-write
> > subvolume. btrfs does not prevent it and it is the result of wrong
> > handling on the user side. You should never ever change read-only
> > subvolume used for send/receive to read-write directly - instead you
> > should always create writable clone from it.
> >
> > This was discussed extensively, see e.g.
> > https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b967@gmail.com/
> 
> I consider it as bug. How can anyone know they shouldn't do that. It
> is perfectly valid use case for sending subvolumes from one system to
> another system. After sending using "btrfs property set ro false" to
> set RW. Sounds very logical, why should I create a new snapshot? I
> just sent new one. Original system's subvolume could even be deleted
> with no plans to ever do any incremental sends. And seems many people
> have had this issue which just proves my point it's a bug.

It may sound logical but breaks assumptions of send, so yes it is a bug
and the fix took more time than convenient, because just fixing the
kernel was not enough and later I realized that's the wrong place to fix
it. There's also updated documentation regarding the usecase so this
should address the "how can anyone know not to do it".

> So I would say first bug that needs fixing is changing "btrfs property
> set ro false" in kernel

So technically it gets cleared in kernel, using the
BTRFS_IOC_SET_RECEIVED_SUBVOL ioctl, but it's initiated by the command
'btrfs prop set ro false' for the subvolume. Effectively there's no
difference for you as a user.
