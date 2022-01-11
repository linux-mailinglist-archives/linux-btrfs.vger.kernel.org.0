Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35BD48B291
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiAKQqX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiAKQqX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 11:46:23 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C4C06173F
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 08:46:23 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id v12so30898809uar.7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jan 2022 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4toKpV/S5Oo17Feh90ozsoHTPstufTwck3WpgrKgBIA=;
        b=IgrCayRRwBTdEA9mP11sPkmXY7c0xAIza0PKa5zrKewyxeGzLJULqzLMiLR3S45S7V
         IsBYkqeVvus4wEee86D8Yv/2TyM5mJtMO+a2hdAeV1D6fVBKPwrBeC3ziBya1kSpmeMO
         j7vQXlZgPik4ck0ezQAxebUMP5JhKg9N5xN/0vHmc9aaMw350xSf/K0i4QtY+5NKJhPV
         Mm93+FOD7EJqtkvg3ogwFgL3XNB/XPtDQ6NMxR4dBFoYWm6N3KpVAPJzeO3AW9ih7UnW
         C5L0w3AM/u/TZYEr0v15jjES+GLb3ahRveA6812QK0E7a1DWJGRlLmp0GazVWNeEv+1X
         XAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4toKpV/S5Oo17Feh90ozsoHTPstufTwck3WpgrKgBIA=;
        b=S1+xKKJtFeVfbN7h0b62/njDo75PRJO6JLMzlPQKcka+VYkCB19C/zAZpuKSaaN/Ry
         QlMxpB7L3I51k2rtaKpC9c/fxWQevNdRqy68fwQvYuao6WSiAfslws2zRtjsav5Bids1
         sn/kMi7FV/UJaecFM5WS2YFuovrr1Ic7/wkgtrUlPuXoLLnEtqL1hT/kz4eVQHnPggdb
         +gP2amjv3XgqtUAkVAe8c3pgl9WTcibHTJAHKlNiMdynpvFJZY7TAra0NHyEvxxLGzYJ
         zMCSSYG898HRbmSRLuB/xhD4kB4wZVJWRbN2s4hZc+WWidIwvtqwAKk1X9aco2ETN5HM
         b6SQ==
X-Gm-Message-State: AOAM532/eIZXDaLopPBshXhdIWR92RQHEzrsXBvCwI3sQUDwuSTDXSRU
        djcmqKP8k+BYNISdxQC6VhfhLLWdT+gxIEH8DXcjR6LR4PdVUQni
X-Google-Smtp-Source: ABdhPJy2LoVIF7Xx2ipERDox+fTzturq+J3Tlc5uVy4sG4Hma7GIJI+1qlBVTb6GNxc8ovVdaKiiVJfKjvF7k3Jnp70=
X-Received: by 2002:ab0:6813:: with SMTP id z19mr2432644uar.28.1641919582125;
 Tue, 11 Jan 2022 08:46:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSz2f3xHj7Mi_JFgSMHHN8XSGxMr4NWZdcu4qd1-zOYOsg@mail.gmail.com>
 <CAA91j0XmeOUA=sioDh7p8Of6O3n8=E8nCAeYs6GXE4awr=Cs+Q@mail.gmail.com>
 <CAOE4rSwtend5c2EeOZDwatXLRyEXsVwjQftawFB4asCvs-Cb8g@mail.gmail.com> <86abf8ba-5613-cf1b-bdca-6039b5e23524@suse.com>
In-Reply-To: <86abf8ba-5613-cf1b-bdca-6039b5e23524@suse.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Tue, 11 Jan 2022 18:46:11 +0200
Message-ID: <CAOE4rSwxj4c5tHWzZO61zD5_CswX+DLxjNLWvLpt4EcNiGYBfA@mail.gmail.com>
Subject: Re: btrfs send picks wrong subvolume UUID
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

otrd., 2022. g. 11. janv., plkst. 17:33 =E2=80=94 lietot=C4=81js Nikolay Bo=
risov
(<nborisov@suse.com>) rakst=C4=ABja:
>
>
>
> On 3.01.22 =D0=B3. 20:09, D=C4=81vis Mos=C4=81ns wrote:
> > sv=C4=93td., 2022. g. 2. janv., plkst. 22:37 =E2=80=94 lietot=C4=81js A=
ndrei Borzenkov
> > (<arvidjaar@gmail.com>) rakst=C4=ABja:
> >>
> >> On Sun, Jan 2, 2022 at 8:05 PM D=C4=81vis Mos=C4=81ns <davispuh@gmail.=
com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> I have a bunch of snapshots I want to send from one fs to another,
> >>> but it seems btrfs send is using received UUID instead of subvolumes =
own UUID
> >>> causing wrong subvolume to be picked by btrfs receive and thus failin=
g.
> >>>
> >>> $ btrfs subvolume show /mnt/fs/2019-11-02/etc | head -n 5
> >>> 2019-11-02/etc
> >>>         Name:                   etc
> >>>         UUID:                   389ebc5e-341a-fb4a-b838-a2b7976b8220
> >>>         Parent UUID:            36d5d44b-9eaf-8542-8243-ad0dc45b8abd
> >>>         Received UUID:          15bd7d35-9f98-0b48-854c-422c445f7403
> >>>
> >>
> >> btrfs send will always use received UUID if available, it works as
> >> designed and is not a bug. Bug is to have received UUID on read-write
> >> subvolume. btrfs does not prevent it and it is the result of wrong
> >> handling on the user side. You should never ever change read-only
> >> subvolume used for send/receive to read-write directly - instead you
> >> should always create writable clone from it.
> >>
> >> This was discussed extensively, see e.g.
> >> https://lore.kernel.org/linux-btrfs/d73a72b5-7b53-4ff3-f9b7-1a098868b9=
67@gmail.com/
> >
> > I consider it as bug. How can anyone know they shouldn't do that. It
> > is perfectly valid use case for sending subvolumes from one system to
> > another system. After sending using "btrfs property set ro false" to
> > set RW. Sounds very logical, why should I create a new snapshot? I
> > just sent new one. Original system's subvolume could even be deleted
> > with no plans to ever do any incremental sends. And seems many people
> > have had this issue which just proves my point it's a bug. And if this
> > is not supported, then why there exists such "btrfs property set ro
> > false" at all who lets you shoot yourself in foot? If it didn't exist
> > then everyone would use only other option by creating new RW snapshot
> > which actually sounds more like a workaround for broken property set.
> > So I would say first bug that needs fixing is changing "btrfs property
> > set ro false" in kernel so that it clears received_uuid and
> > regenerates new subvolume uuid because such modified subvolume isn't
> > same as source and would still causes issue if it stayed same.
> > That would fix it for future but wouldn't solve it for many people who
> > already have such subvolumes. And it's pretty hard problem to track
> > down unless you already know it. Like it took me a lot of time to
> > figure out why send is failing. ro->rw was done 7 years ago and all
> > snapshots since then have same received_uuid but I noticed btrfs send
> > not working only now. For me, easiest way I'll just patch kernel to
> > always use subvolume's uuid and ignore received_uuid, then btrfs send
> > all snapshots so it will work fine for me. As for others, in general
> > seems proper fix would be that btrfs send would give both uuid and
> > received_uuid. Then btrfs receive could have a flag to ignore
> > received_uuid and just use uuid. Or search by uuid and then fallback
> > to received_uuid.
>
>
> That behavior got fixed in btrfs-progs in version 5.14, in particular
> commit:
>
> https://github.com/kdave/btrfs-progs/commit/3b90ebc2d7eb4b4a4d5d55eff362e=
8127a673828
>
> Of course it requires users upgrading btrfs-progs but even if we merged
> some kernel-side fix (there's been one I authored couple of years ago
> and it's been circulated on the mailing list but didn't get merged) it
> would still require users upgrading their kernel eventually.
>

The issue is not that users wouldn't update, but that old filesystems
are already present with this case. This is why fix in btrfs-progs
doesn't help. It prevents it only happening in future but not for
people who already have such filesystems thus kernel fix is necessary
as I described.
