Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7082B4862EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiAFK22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 05:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiAFK21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 05:28:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F999C061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 02:28:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CD4B81FBB
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 10:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE1FC36AEF
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641464904;
        bh=wXxmHMzWu3Gy/Roe66Kas5Q7NzMH3sPM+cd7c3plpv0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=mXvp5N1DN0VcnYjG2d0IV0GJL54AzKIoDOaHaURM5mRF7h5E1B2T4qYwblaw1Z5fa
         mo/elji75yvFsxTy6LvgyPxA9POLAEUmQi3I8aj/E5Mnf08JaOIKHoAFPYgKnWCncL
         0tlOtKBDVbyiOryOZb/DDGmdOSQt7g1WQwX2/Agr73Rd/v80+zDYrOg9Yh85mvKqVp
         czVskc7Tz3MMf3LrzlTZK4RNFRThhOu1a2r9xSIGotwJOkULNfad3Yv7b1EGw3fK23
         R70RDwJAeIDjwj88MIiLCH7duASJQ1ZtrlECiLa1bZ9YIC2QaqdaE3zLz7ypm153/M
         lwYJ53GflGapw==
Received: by mail-qv1-f44.google.com with SMTP id o10so1883948qvc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 02:28:24 -0800 (PST)
X-Gm-Message-State: AOAM530Y2fUzrNrmGfR94E0jx8Mn1FGhcHvbDr2Q9rQJSkQ6e4valcdK
        kuybp3pviyuQEaufwYMmxUq+oH04bIQ63afHR/E=
X-Google-Smtp-Source: ABdhPJyuQ0ETvWdR6xIYEuMfcFb72KZ/0usq/w/++JL4Jj0DY++ZmRLct5ucKbNOJqE66UPa3DoImGA/KrYIcW9Mq0A=
X-Received: by 2002:ad4:5c4f:: with SMTP id a15mr5381359qva.98.1641464903823;
 Thu, 06 Jan 2022 02:28:23 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtRnyUHEwV1o9k565B_u_RwQ2OQqdXHtcfa-LWAbUSB7Gg@mail.gmail.com>
 <YdXdtrHb9nTYgFo7@debian9.Home> <20220105183407.GD14058@savella.carfax.org.uk>
 <CAL3q7H4ofLVoGA3YC6M8gdBuW9g2W-C644gXgr9Z+r4MZBJZGA@mail.gmail.com>
 <20220105213157.GE14058@savella.carfax.org.uk> <20220105213921.GF14058@savella.carfax.org.uk>
 <20220105215359.GG14058@savella.carfax.org.uk> <CAL3q7H538dogW0-5PR1+J7FCKNJX6vY2_7tEpazskCmL4dmxKA@mail.gmail.com>
 <20220106102056.GH14058@savella.carfax.org.uk>
In-Reply-To: <20220106102056.GH14058@savella.carfax.org.uk>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 6 Jan 2022 10:27:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
Message-ID: <CAL3q7H4d9t=gBXYB=OVnPDuEMdo1-jmJweJTEshvc=9AGDeaVQ@mail.gmail.com>
Subject: Re: [bug] GNOME loses all settings following failure to resume from suspend
To:     Hugo Mills <hugo@carfax.org.uk>,
        Filipe Manana <fdmanana@kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 6, 2022 at 10:21 AM Hugo Mills <hugo@carfax.org.uk> wrote:
>
> On Thu, Jan 06, 2022 at 09:51:16AM +0000, Filipe Manana wrote:
> > On Wed, Jan 5, 2022 at 9:54 PM Hugo Mills <hugo@carfax.org.uk> wrote:
> > >
> > > On Wed, Jan 05, 2022 at 09:39:21PM +0000, Hugo Mills wrote:
> > > > On Wed, Jan 05, 2022 at 09:31:57PM +0000, Hugo Mills wrote:
> > > > > On Wed, Jan 05, 2022 at 08:38:37PM +0000, Filipe Manana wrote:
> > > > > > On Wed, Jan 5, 2022 at 6:34 PM Hugo Mills <hugo@carfax.org.uk> wrote:
> > > > > > >
> > > > > > >    Hi, Filipe,
> > > > > > >
> > > > > > > On Wed, Jan 05, 2022 at 06:04:38PM +0000, Filipe Manana wrote:
> > > > > > > > I don't think I have a wiki account enabled, but I'll see if I get that
> > > > > > > > updated soon.
> > > > > > >
> > > > > > >    If you can't (or don't want to), feel free to put the text you want
> > > > > > > to replace it with here, and I'll update the wiki for you...
> > > > > >
> > > > > > Hi Hugo,
> > > > > >
> > > > > > That would be great.
> > > > > > I don't have a concrete text, but as you are a native english speaker,
> > > > > > a version from you would sound better :)
> > > > > >
> > > > > > Perhaps just mention that as of kernel 3.17 (and maybe point to that
> > > > > > commit too), the behaviour is no longer guaranteed, and we can end up
> > > > > > getting a file of 0 bytes.
> > > > >
> > > > >    I'd rather not reinforce the wrong usage with an example of it. :)
> > > > > Better to document the correct usage...
> > > > >
> > > > > > So an explicit fsync on the file is needed (just like ext4 and other
> > > > > > filesystems).
> > > > >
> > > > >    At what point in the process does the fsync need to be done?
> > > > > Before/after/instead of the sync?
> > > >
> > > >    Hmm. That doesn't make sense, of course (sorry, it's late, I've had
> > > > a hard day). I'm guessing that the fsync needs to go after the write
> > > > of the new data and before the rename. Is there any other constraint
> > > > on what needs to be done to make this work safely?
> > >
> > >    Right, I think I've got it. Ping me in the morning if it's not
> > > correct.
> >
> > Yep, that's correct Hugo.
> >
> > Starting with 3.17, the example on the wiki needs an fsync on
> > "file.tmp" after writing to it and before renaming it over "file".
> > I.e. the full example should be:
> >
> > ****
> > echo "oldcontent" > file
> >
> > # make sure oldcontent is on disk
> > sync
> >
> > echo "newcontent" > file.tmp
> > fsync file.tmp
> > mv -f file.tmp file
> >
> > # *crash*
> >
> > Will give either
> >
> > file contains "newcontent"; file.tmp does not exist
> > file contains "oldcontent"; file.tmp may contain "newcontent", be
> > zero-length or not exists at all.
> > ****
>
>    Since I can't find an "fsync" command line tool, I've rewritten the
> example in more general terms, rather than tying it to a specific
> implementation (such as a sequence of shell commands). I note that
> we've got a near-duplicate entry in the FAQ, two items down ("What are
> the crash guarantees of rename?"), that should probably be removed.
>
> Updated entry: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_overwrite-by-rename.3F
> Candidate for deletion: https://btrfs.wiki.kernel.org/index.php/FAQ#What_are_the_crash_guarantees_of_rename.3F

There's the xfs_io command from xfsprogs that can be used to trigger
an fsync like this:  xfs_io -c fsync /path/to/file
But it's probably not well known for non-developers.

Anyway, as it is, it looks perfect to me, thanks!

>
>    Hugo.
>
> --
> Hugo Mills             | I thought I'd discovered a new colour, but it was
> hugo@... carfax.org.uk | just a pigment of my imagination.
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |
