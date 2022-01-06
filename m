Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E3486AE0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 21:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiAFUG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 15:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiAFUG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 15:06:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E425C061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 12:06:57 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id w184so10672235ybg.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 12:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKQWOi686Kg/svJuFJWAZmWbDzQ1pC861e44KCZ6ibQ=;
        b=ff6DkVwedcek3P8uER57KsJR8MKhgUgYN2Pi5hL8K+BAiRdnzKP3uF3WF4oPEkVdij
         Yf43yLeD7HmChNx7fNjknsw2bgczoeyBe5BuzMWmMkwoYiDUu1FxuQhcpw4eKq8wYVwz
         r+r8fYLsPoSgljvEOZacBLwkMoWZ6r16ay+3S1J/CcYamzGGc7S9s+uZ6pUF1hP2b7jL
         NoyJ3Zq2VOCWZ41zT8ezNfo9G+qg6xRxT6Cz6ctVukAxgPBBVftthynisd/0GGiJyecx
         HK/wVSMbPSpS2qSwpMfyIph7YDrRjBiwIGtwg9gcIeQUb+dhPMUtUFcIPGc7E0cpTUhn
         BuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKQWOi686Kg/svJuFJWAZmWbDzQ1pC861e44KCZ6ibQ=;
        b=D4wXLbKsVMYkvDZAtlML1hJ1EEtW6vMJn8giOusxwtyHlQfc2y1nNvvheRLH0XWsvG
         5qwMM4k2q40gooAQ5zDYqMO+hMkp/3ibL9fDxhzzm5EJYD93f3SdNRHxaUrGvLoLKf7U
         MSajlzS2TavzRY7n4Z6lxIsOhk3UTb8PRt/vWFMXHsAKxQ5tkLY+7Ez09mPxrOC78Drx
         B81hBOF4rT5yDzzK0KCkTUWk1GrkXPf0cAjaCfeTGVA/HKeaRH1WqQWXXksGZmVkwpGn
         t8eYwpXEzkevNujXpxNClPWYF3pUrH2KDCSpTIsIFiDQJOMst0a9NMyccjrHuAcFqD+J
         uydg==
X-Gm-Message-State: AOAM532Rfpvbh0gVM6jNUALmeDuCYpswzTISyBw/a1YnfVlof3RF3w6X
        qxmHjP8BrUxoM2GiIeX9dpPQPki0ypnx9gJoa8JrNA==
X-Google-Smtp-Source: ABdhPJwFhg67cxf5o/gJjMS/8qn7VKY1qESdDbQACZHLxIy2Cgn78NXh6Z+gsn1rxO0tuzG8b5nmq/QX0gjZyDW0OH4=
X-Received: by 2002:a25:cdc3:: with SMTP id d186mr75873177ybf.400.1641499616553;
 Thu, 06 Jan 2022 12:06:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
 <20220105213157.GE14058@savella.carfax.org.uk> <20220105213921.GF14058@savella.carfax.org.uk>
 <20220105215359.GG14058@savella.carfax.org.uk> <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
 <20220106102056.GH14058@savella.carfax.org.uk> <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
 <CAJCQCtTKkhQ+7=NK_KYktvuRxL+3yYMxma9WjB5eAbc5upWGaQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTKkhQ+7=NK_KYktvuRxL+3yYMxma9WjB5eAbc5upWGaQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 6 Jan 2022 13:06:40 -0700
Message-ID: <CAJCQCtTyUk_TC=W+2o+Cy_W_mfX-0_sTXGBLf1S9AdQiHkDiMA@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 6, 2022 at 1:02 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Jan 6, 2022 at 3:28 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Thu, Jan 6, 2022 at 10:21 AM Hugo Mills <hugo@carfax.org.uk> wrote:
> > >
> > > > Yep, that's correct Hugo.
> > > >
> > > > Starting with 3.17, the example on the wiki needs an fsync on
> > > > "file.tmp" after writing to it and before renaming it over "file".
> > > > I.e. the full example should be:
> > > >
> > > > ****
> > > > echo "oldcontent" > file
> > > >
> > > > # make sure oldcontent is on disk
> > > > sync
> > > >
> > > > echo "newcontent" > file.tmp
> > > > fsync file.tmp
> > > > mv -f file.tmp file
> > > >
> > > > # *crash*
> > > >
> > > > Will give either
> > > >
> > > > file contains "newcontent"; file.tmp does not exist
> > > > file contains "oldcontent"; file.tmp may contain "newcontent", be
> > > > zero-length or not exists at all.
> > > > ****
> > >
> > >    Since I can't find an "fsync" command line tool, I've rewritten the
> > > example in more general terms, rather than tying it to a specific
> > > implementation (such as a sequence of shell commands). I note that
> > > we've got a near-duplicate entry in the FAQ, two items down ("What are
> > > the crash guarantees of rename?"), that should probably be removed.
> > >
> > > Updated entry: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> > > Candidate for deletion: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_rename.3F
> >
> > There's the xfs_io command from xfsprogs that can be used to trigger
> > an fsync like this:  xfs_io -c fsync /path/to/file
> > But it's probably not well known for non-developers.
> >
> > Anyway, as it is, it looks perfect to me, thanks!
>
>
> I think it's OK to use pseudo-code. Folks will figure it out. So you
> can just write it as fsync() and even if you're not using the exact
> correct syntax it'll be understood.

Topical xxample:
https://lore.kernel.org/linux-xfs/6A65F394-C1BA-4339-AC9B-051885D12F65@corp.ovh.com/

Reminds me to ask Filipe if the example Hugo is writing up also needs
an fsync() on the enclosing directory *after* the rename?

-- 
Chris Murphy
