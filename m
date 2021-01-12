Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B852F3249
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbhALNzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 08:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbhALNzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 08:55:51 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD4C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 05:55:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b9so1560329qtr.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 05:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ihfJdvXuo8gXYhL1o2qpY3R2l4myN2DC+kCqQgN5/3U=;
        b=rrU8chnTCTVxVTIAJbeOZWXqIWe+PJa2uMgm5y9aN+uYYtmnW4j+Nj+qrYpbsBzrA2
         2a1HE1+JUcnCBl925LAKiG5KuYMDt40/L19ReHsGZCb3HMlTfxGOOTObsTRfaMBRZgHQ
         cTIcIEo3Qj0RUEwv6BADtgHx+SfkvW3IKI7PSwqsO9bi2pz4cNJUGaaGUu+XSGx37m90
         RCkw9ew+2l/9Swbk9WHRxSXlWu6mnl1modAafRhbZUq8PZPXym/Yfwtgqh42oPs4OD6U
         hlaXzPb6tGjkM40nYb/IB7w2AWOWNzvBlme2qki+qMvIkj9f69j7Thcay7xL33SkR4AW
         RJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ihfJdvXuo8gXYhL1o2qpY3R2l4myN2DC+kCqQgN5/3U=;
        b=PdLTfqcoIaApc18uxw2665X0PLb4Jt58Qio6e5jksgGWZbK7lUK2FshXQ1p8YtAedv
         I3ip6JXTB7axPNKVrMU2PJxOMSPwaAR1QQSQgzUgUYyDRqBh/MSh/grhqUZu8l4Ibhf6
         i2YDyJGMlP03sD3E7vKrx/a2udb52QsqzMRD061Qsws0PBdpKUFNZJOZl022qk1Q+cgY
         tn+EJ6qp6jxEFEiTfmx5He2vM0DgipiqOaQLjLw4p6g6mIKlekL/TIkMYxzs8hTTjelf
         d0KcBsDS7vRulZq+spa/vt8vYhlT3pa3zrhS+oBibQFOHBXfcmCzOeZY+o7ufbEywXfW
         7MCA==
X-Gm-Message-State: AOAM531S8O2L8But5XiCdqqXTRcIF2+TQpc9GfXn5JmdJ1OhGH2LYxay
        0dt29CpaEW5ytPYQxHDD+j8kdWyY5ecwFsW/d2rXEbqryN0D/A==
X-Google-Smtp-Source: ABdhPJzrNdaSjeYp46XvSgzo8LUeLwLwTAL3e6RpgmgxtqmUDF53BnDe05zA7Viv9zJRid1o9B9OuiSkdId7hCYD2Fc=
X-Received: by 2002:ac8:7349:: with SMTP id q9mr4698868qtp.259.1610459710537;
 Tue, 12 Jan 2021 05:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20210111190243.4152-1-roman.anasal@bdsu.de> <20210111190243.4152-3-roman.anasal@bdsu.de>
 <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com> <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
 <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com> <0ce2d415308ab40874aff535031e9871a442cd9a.camel@bdsu.de>
In-Reply-To: <0ce2d415308ab40874aff535031e9871a442cd9a.camel@bdsu.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Jan 2021 13:54:59 +0000
Message-ID: <CAL3q7H6T2oFwt7EXZ2HsbGhhtpfSrju961W5vysJ3LcuahsUxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
To:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 1:10 PM Roman Anasal | BDSU
<roman.anasal@bdsu.de> wrote:
>
> On Tue, 2021-01-12 at 11:27 +0000, Filipe Manana wrote:
> > You get all these issues because you are using an incremental send in
> > a way it's not supposed to.
> > You are using two subvolumes that are completely unrelated.
> Yes, I am aware of that and know that this is not a designed for use
> case.
>
> > My surprise here is that we actually allow a user to try that,
> > instead
> > of giving an error complaining that subvol1 and subvol2 aren't
> > snapshots of the same subvolume.
> This could be one way of solving it. But this is already harder than it
> sounds, since the same issue may also happen *even when* the subvolumes
> share a parent/are related, here an example reproducer:
>
>   btrfs subvolume create subvol1
>   btrfs subvolume snapshot subvol1 subvol2
>   mkdir subvol1/a
>   echo foo > subvol2/a
>   btrfs property set subvol1 ro true
>   btrfs property set subvol2 ro true
>   btrfs send -p subvol1 subvol2 | btrfs receive --dump
>
> This will produce a stream that tries to write data into the cloned
> directory inode.

Indeed, it will.

That use case is a bit different however, the snapshot starts RW, is
changed and then turned RO and used for an incremental send.

But the idea of an incremental send was always to use snapshots from
the same subvolume and the snapshots were always RO - once created you
didn't change them.
Otherwise you can never ensure full consistency.

So in the end it's not that much different from the case of using
unrelated subvolumes or snapshots as in the patch's changelog.


>
> So we not only had to check the parent relationships but also ensure
> that the descendant snapshot was not modified, i.e. was never set to
> ro=3Dfalse.
> As far as I know there is no flag tracking this on-disk? So this would
> need additional work, too.

There isn't.

Maybe all we need for now is to document how the incremental send is
supposed to be used.
Adding a flag to mark if a snapshot was ever RW shouldn't be too hard.

>
>
> > An incremental is supposed to work on snapshots of the same subvolume
> > (hence, have the same parent uuid).
> > That's what the entire code relies on to work correctly, and that's
> > what makes sense - to compute and send the differences between two
> > points in time of a subvolume.
> > That's why the code base assumes that inodes with the same number and
> > same generation must refer to the same inode in both the parent and
> > the send root.
> >
> > What I think that needs to be answered is:
> >
> > 1) Are there actually people using incremental sends in that way?
> > (It's the first time I see such use case)
> Well, I did (:
> But admittedly in a kind of experimental setup testing out the limits
> of btrfs.
>
> > 2) If so, why? That is completely unreliable, not only it can lead to
> > failure to apply the streams, but can result in all sorts of
> > weirdness
> > (logical inconsistencies, etc) if applying such streams doesn't cause
> > an error.
> In my case I was moving around subvolumes between multiple disks and
> deduplicating as much as possible. Trying to preserve already done
> deduplication and purging some intermediate subvolumes I ended up using
> "unrelated" subvolumes as parents.
>
> Thinking of it, maybe just using them as clone sources would have just
> worked? That would then of course produce much larger streams since
> *all* meta data had to be transfered.
>
>
> > 3) Making sure such use cases work reliably would require many, many
> > changes to the send implementation, as it goes against what it
> > currently expects.
> >     Snapshot a subvolume, change the subvolume, snapshot it again,
> > then use both snapshots for the incremental send, that's the expected
> > scenario.
> I actually don't think that it is really that much work since besides
> from some edge cases it already *does* work - I tried ;)
>
>
> > In other words, what I think we should have is a check that forbids
> > using two roots for an incremental send that are not snapshots of the
> > same subvolume (have different parent uuids).
> I'd like to argue against that:
>    1. I don't think allowing this requires that much work

For the cases you tried it surely didn't.

>    2. explicitly forbiding it requires work, too (and maybe even changes
>       to the on-disk format?)
>    3. fixing bugs for this unexpected use case will probably also fix bug=
s
>       for the expected scenario which may only happen in very rare and
>       extremly unlikely - though still possible - cases and thus make the
>       code overall more resilient:

I'd have to disagree with that.

Having pretty much being the only one, apart from Robbie Ko who did
solve some hard similar problems,
solving this kind of problems since 2013, it's far from trivial work
and there's always one more case to solve.

Going through the change logs and send specific fstests should give an
idea of why I don't think it's that trivial to add support for these
use cases.

My concern is that this will require a lot more work for a use case
that is not standard, it was not designed for,
and this always adds the risk of introducing regressions for the
expected and typical use cases.

So I really don't find it compelling to add support for cases that
send was designed for - unless there are indeed users for them and
there is a good reason why they can't use the standard way (use
snapshots of the same subvolume and never modify the snapshots).

>
> For example the assumption that inodes with the same number must refer
> to the same inode doesn't even hold for direct snapshots - almost
> always it does but in some rare conditions it doesn't, which is why
> there already is an additional check for that.

The assumptions everywhere take into account inode number and
generation, not just the number.
Any place that uses only the number to check if it's the same inode,
then it's almost certainly a bug (a notable exception would be the
pending directory renames iirc).

>
> This already caused bugs before. And the bug I hit with my unexpected
> use of btrfs-send and originally set out to find you had just fixed a
> few weeks before [1], i.e. if you hadn't fixed it I would - because of
> the unexpected use.
> The bug my patch fixes I only discovered by reading the code and having
> my scenario in mind.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commi=
t/?id=3D0b3f407e6728d990ae1630a02c7b952c21c288d3
>
> That's why I think the work fixing arising bugs for that case is better
> invested than in trying to just block it completely.
> But given its very rare occurence I would agree to not put any priority
> on it.

Well, I'm sure there were plenty of bug fixes for the intended use
cases that also fixed failures with the non-intended use cases.

Thanks.

>
> > Thanks.
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
