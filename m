Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB32F33A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbhALPJV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhALPJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:09:20 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98656C061786
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:08:40 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j18so1006652qvu.3
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XUFQ82e9UcMWEKHKNu9sEF/G+Hkc+AdvZb6eMwLu3hA=;
        b=skewaFHGeYz/muNm5yKvVbhVBt8JHq4LwB9A2+H+RzeFB2xXc8u7Nmwv+r4t7q1hHm
         eOKum/4X/Kcch8jSLWhu1LOniQMN4/XQ3ERB4HXHfi/RAtSmy7IWC4fTvXo+0PHen9OQ
         OIHbb2ihFgDZZiU1Unke9uIBkg3ol7HQPs/oniqBOov2scUWscwRzGYOiuVV5f6c85Bl
         Y5TcGtRGT82dqtT5VUNUe85/sO9mAbRWQmKC6X/EiCkFVpu12N3Nm+Tv+WVEl7/csrZT
         eIxmnLY+r6TnNcVQx8rBQXSy5QLozcV/oVE23mrWkHuUrGbqsW6B1Un6iK8Ossr+v3Dh
         heuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XUFQ82e9UcMWEKHKNu9sEF/G+Hkc+AdvZb6eMwLu3hA=;
        b=FCDOBjeDCXuLXpZY8oQn8iMpE1espO4vL36TYDb5oBP7LgdkvNoS4rTLiHBTQyxmfN
         GQTNFw3zA6dXNhSTY41/tz6cs2QFu7dNSgJS2OHUgEr/8rg4Mq37skb3pGuZMFr108Fq
         XPbKCf6IMJfrlLzR0CfO4lkpKRfTfY5khataH4JtCmhJQ6qgm/fUV3t9FrIcIy091Mlv
         z9YPhZ5IflOt+PexVwHVZSmQPcTnNqiWjuJ8+g49tExK+xZXZFUatzVd4xmwnr4W/nQV
         xwr0qs3+63PMrYoxZ0JAHiAGT+zUH1TSqi6zXX1CP9Po+GEA3TblL5IWTV6PUZQuRVED
         kAPQ==
X-Gm-Message-State: AOAM5317ieOd+Dr5Lwr6T9INOczSBKEXpXekupwUeo5Ifc75uPXy5/Mi
        J3y0D/5OjOAYq8+xI0I2XS4mjqTKVvUq3U/eCvtUNm/NfMo=
X-Google-Smtp-Source: ABdhPJzkvYweK5wqUPDZq9G3I+NkMs04rI9LBx22YyfOZJLOvW/9a8BgstPZT/3MKJ/rXs7DoAKEaeMzg1yGlKXLzfI=
X-Received: by 2002:a05:6214:10e7:: with SMTP id q7mr5281750qvt.28.1610464119659;
 Tue, 12 Jan 2021 07:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20210111190243.4152-1-roman.anasal@bdsu.de> <20210111190243.4152-3-roman.anasal@bdsu.de>
 <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com> <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
 <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com>
 <0ce2d415308ab40874aff535031e9871a442cd9a.camel@bdsu.de> <CAL3q7H6T2oFwt7EXZ2HsbGhhtpfSrju961W5vysJ3LcuahsUxg@mail.gmail.com>
 <7d18529276be4a6a4ae0de149b7906163b060ba8.camel@bdsu.de>
In-Reply-To: <7d18529276be4a6a4ae0de149b7906163b060ba8.camel@bdsu.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Jan 2021 15:08:28 +0000
Message-ID: <CAL3q7H6NDy9NTmbmkK-C2vSsPdC1S8OSvJQpE++qwikep_LyYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
To:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 2:37 PM Roman Anasal | BDSU
<roman.anasal@bdsu.de> wrote:
>
> On Tue, 2021-01-12 at 13:54 +0000, Filipe Manana wrote:
> > On Tue, Jan 12, 2021 at 1:10 PM Roman Anasal | BDSU
> > <roman.anasal@bdsu.de> wrote:
> > > On Tue, 2021-01-12 at 11:27 +0000, Filipe Manana wrote:
> > > > You get all these issues because you are using an incremental
> > > > send in
> > > > a way it's not supposed to.
> > > > You are using two subvolumes that are completely unrelated.
> > > Yes, I am aware of that and know that this is not a designed for
> > > use
> > > case.
> > >
> > > > My surprise here is that we actually allow a user to try that,
> > > > instead
> > > > of giving an error complaining that subvol1 and subvol2 aren't
> > > > snapshots of the same subvolume.
> > > This could be one way of solving it. But this is already harder
> > > than it
> > > sounds, since the same issue may also happen *even when* the
> > > subvolumes
> > > share a parent/are related, here an example reproducer:
> > >
> > >   btrfs subvolume create subvol1
> > >   btrfs subvolume snapshot subvol1 subvol2
> > >   mkdir subvol1/a
> > >   echo foo > subvol2/a
> > >   btrfs property set subvol1 ro true
> > >   btrfs property set subvol2 ro true
> > >   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> > >
> > > This will produce a stream that tries to write data into the cloned
> > > directory inode.
> >
> > Indeed, it will.
> >
> > That use case is a bit different however, the snapshot starts RW, is
> > changed and then turned RO and used for an incremental send.
> >
> > But the idea of an incremental send was always to use snapshots from
> > the same subvolume and the snapshots were always RO - once created
> > you
> > didn't change them.
> > Otherwise you can never ensure full consistency.
> >
> > So in the end it's not that much different from the case of using
> > unrelated subvolumes or snapshots as in the patch's changelog.
>
> That's what I wanted to demonstrate: it's basically the same case - but
> it is much harder/impossible to detect by the send code as long as
> there is no flag on the subvolume whether it was ever rw.

Yes, the only problem I see here is that we don't prevent the unsupported c=
ases.
Detecting if the send and parent roots are snapshots of the same
subvolume is easy.

Checking if a snapshot was ever RW before is not, we would need a flag.
This is already known to cause problems, and has happened and been
reported in the past - mostly someone changes a snapshot from RO to
RW, changes it, sets it back to RO and uses it for an incremental send
later.

These all fall within the same category: not being able to ensure
consistency of the roots being used for an incremental send.

It's unfortunate such cases aren't forbidden with an explicit error.

>
>
> > > So we not only had to check the parent relationships but also
> > > ensure
> > > that the descendant snapshot was not modified, i.e. was never set
> > > to
> > > ro=3Dfalse.
> > > As far as I know there is no flag tracking this on-disk? So this
> > > would
> > > need additional work, too.
> >
> > There isn't.
> >
> > Maybe all we need for now is to document how the incremental send is
> > supposed to be used.
> > Adding a flag to mark if a snapshot was ever RW shouldn't be too
> > hard.
> >
> > >
> > > > An incremental is supposed to work on snapshots of the same
> > > > subvolume
> > > > (hence, have the same parent uuid).
> > > > That's what the entire code relies on to work correctly, and
> > > > that's
> > > > what makes sense - to compute and send the differences between
> > > > two
> > > > points in time of a subvolume.
> > > > That's why the code base assumes that inodes with the same number
> > > > and
> > > > same generation must refer to the same inode in both the parent
> > > > and
> > > > the send root.
> > > >
> > > > What I think that needs to be answered is:
> > > >
> > > > 1) Are there actually people using incremental sends in that way?
> > > > (It's the first time I see such use case)
> > > Well, I did (:
> > > But admittedly in a kind of experimental setup testing out the
> > > limits
> > > of btrfs.
> > >
> > > > 2) If so, why? That is completely unreliable, not only it can
> > > > lead to
> > > > failure to apply the streams, but can result in all sorts of
> > > > weirdness
> > > > (logical inconsistencies, etc) if applying such streams doesn't
> > > > cause
> > > > an error.
> > > In my case I was moving around subvolumes between multiple disks
> > > and
> > > deduplicating as much as possible. Trying to preserve already done
> > > deduplication and purging some intermediate subvolumes I ended up
> > > using
> > > "unrelated" subvolumes as parents.
> > >
> > > Thinking of it, maybe just using them as clone sources would have
> > > just
> > > worked? That would then of course produce much larger streams since
> > > *all* meta data had to be transfered.
> > >
> > >
> > > > 3) Making sure such use cases work reliably would require many,
> > > > many
> > > > changes to the send implementation, as it goes against what it
> > > > currently expects.
> > > >     Snapshot a subvolume, change the subvolume, snapshot it
> > > > again,
> > > > then use both snapshots for the incremental send, that's the
> > > > expected
> > > > scenario.
> > > I actually don't think that it is really that much work since
> > > besides
> > > from some edge cases it already *does* work - I tried ;)
> > >
> > >
> > > > In other words, what I think we should have is a check that
> > > > forbids
> > > > using two roots for an incremental send that are not snapshots of
> > > > the
> > > > same subvolume (have different parent uuids).
> > > I'd like to argue against that:
> > >    1. I don't think allowing this requires that much work
> >
> > For the cases you tried it surely didn't.
> >
> > >    2. explicitly forbiding it requires work, too (and maybe even
> > > changes
> > >       to the on-disk format?)
> > >    3. fixing bugs for this unexpected use case will probably also
> > > fix bugs
> > >       for the expected scenario which may only happen in very rare
> > > and
> > >       extremly unlikely - though still possible - cases and thus
> > > make the
> > >       code overall more resilient:
> >
> > I'd have to disagree with that.
> >
> > Having pretty much being the only one, apart from Robbie Ko who did
> > solve some hard similar problems,
> > solving this kind of problems since 2013, it's far from trivial work
> > and there's always one more case to solve.
> >
> > Going through the change logs and send specific fstests should give
> > an
> > idea of why I don't think it's that trivial to add support for these
> > use cases.
> >
> > My concern is that this will require a lot more work for a use case
> > that is not standard, it was not designed for,
> > and this always adds the risk of introducing regressions for the
> > expected and typical use cases.
> >
> > So I really don't find it compelling to add support for cases that
> > send was designed for - unless there are indeed users for them and
> > there is a good reason why they can't use the standard way (use
> > snapshots of the same subvolume and never modify the snapshots).
>
> I didn't want to propose adding and supporting a whole new use case
> here. In my understanding this case already is handled for the most
> part by the existing code and there should only be a few edge cases
> left which should be catchable by additional checks.

Well, that's what change is doing, adding support for cases which we
can't ensure are going to work all the time.

If we change the logic here, at , then later we'll realize we will
need to change the logic somewhere else too - as after this change
having the same inode number and generation can actually mean a new
inode, and other places do such check - or worse, introducing a
regression for the cases where send was designed to work. Not to
mention that future code changes, for the supported scenarios, can
become more complex because of this.

>
> Looking at this very patch: all it basically does is add an additional
> check if the inode has the same type in the snapshot and the parent and
> if not branches in the existing code for recreating the inode.
> For the expected scenario this is (incidentally) covered by checking if
> the generation changed. So the additional check is no problem here and
> redundant at most.
>
> If any further fixes for the unsupported cases are only possible with
> major reworks I totally agree with you: the risk of breaking the main
> case outweihts the benefits.
>
>
> But limited to this concrete patch: would you consider to include it?

I wouldn't, for the reasons outlined before in this thread (which also
makes the first patch unnecessary).

However I'm all for making send fail with an error for the unsupported
cases and updating the documentation (man page, wiki, etc) in case
it's not explicit or it is missing something.

Thanks.

>
>
> > > For example the assumption that inodes with the same number must
> > > refer
> > > to the same inode doesn't even hold for direct snapshots - almost
> > > always it does but in some rare conditions it doesn't, which is why
> > > there already is an additional check for that.
> >
> > The assumptions everywhere take into account inode number and
> > generation, not just the number.
> > Any place that uses only the number to check if it's the same inode,
> > then it's almost certainly a bug (a notable exception would be the
> > pending directory renames iirc).
> >
> > > This already caused bugs before. And the bug I hit with my
> > > unexpected
> > > use of btrfs-send and originally set out to find you had just fixed
> > > a
> > > few weeks before [1], i.e. if you hadn't fixed it I would - because
> > > of
> > > the unexpected use.
> > > The bug my patch fixes I only discovered by reading the code and
> > > having
> > > my scenario in mind.
> > >
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commi=
t/?id=3D0b3f407e6728d990ae1630a02c7b952c21c288d3
> > >
> > > That's why I think the work fixing arising bugs for that case is
> > > better
> > > invested than in trying to just block it completely.
> > > But given its very rare occurence I would agree to not put any
> > > priority
> > > on it.
> >
> > Well, I'm sure there were plenty of bug fixes for the intended use
> > cases that also fixed failures with the non-intended use cases.
>
> Of course, absolutely!
>
> >
> > Thanks.
> >
> > > > Thanks.
> > > >
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
