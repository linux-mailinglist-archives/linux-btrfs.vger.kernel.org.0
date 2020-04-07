Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6545F1A0C59
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGK7E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 06:59:04 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:46000 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGK7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Apr 2020 06:59:04 -0400
Received: by mail-vs1-f49.google.com with SMTP id x82so1851613vsc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Apr 2020 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RJV6bFpPJS64w/Mt/wv/CflaW1fVRvNTJb4ETMjHMMc=;
        b=CC71PbFleZBGpCdyKW1/x24/o2rPzCShkygfEtM1gL3deV45gSUe9XZQo55qp+KwKp
         X7LlYKo7NY9gHbRNElioBVaD2SziltxpFAyedn822iIeYE59w70xPqVBEXlisL3VGLjO
         +wbSlreoJFSnZHZMuL1ieLodM36nPxtoBwVlcR1cNyIR+Ez3kvAJGvscMMyiFIA3YVW8
         ZsqRnVGQE1tt8NaEb4uz5sRxE6CnZT2qUuZw7p7W8CPS+H3pamb1vIzdw7EsB5HMFvH3
         2hcNBu5wlWP5QGYlorcPXCDlyzVJhCNLpii2G27PZ6WXtJaXOGfnj89QWI3JnggItlCX
         Hcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RJV6bFpPJS64w/Mt/wv/CflaW1fVRvNTJb4ETMjHMMc=;
        b=OBV9gu46PLmq/PwXWp/NgyCvp22Ue0XN7cWGitewdffkV61ksAZ3rvyQe2qlyHapD/
         0NY2qWViEjx/R7w4ut3yUkP1jbUVKgsYTbYcPKpnEfg4oEY7KXElf1aOjODyEvwBXzVl
         7lbYvzOcJEU2PF/37l/gNH56k0cTFaKFf5PDLtn6vUr2PEA7o29she/OnIHBkHyp170b
         Ct9rFR1kBHBYJVmtdS1ENrnbJzT+8mm/qcVnNkVYkYCpELdvntr5UtVRWHG6a98kkvYd
         58Tsn+aGNcLbP5gIc06gogQXMuiJHVA6n4J5LKXE8byhZwMSlCLsLk1sFjQ5kxWv8IKV
         Me0Q==
X-Gm-Message-State: AGi0PuYN3ifsVArLq/CB8/rpi/OhdX1IJaJ+h71CG0W1UBNB8QzO14nt
        xpBG74JlJ+cMsd3fRTn5LQnH/Zxur4VrV3TbQPvKUQ==
X-Google-Smtp-Source: APiQypLXNX18pOa6ZkyzEZYwRpjDyoE1Qa3Tsbgut5V8pd1zQ+E/iqMSF8EuoKy9NsIr9eYYrPOhqVRrbmzFPgDgH/g=
X-Received: by 2002:a05:6102:2414:: with SMTP id j20mr1354161vsi.206.1586257142892;
 Tue, 07 Apr 2020 03:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <636dfbc5-32a7-bdf3-b83b-93e65901aa43@oracle.com> <CAL3q7H5r9tjzBzLK7iG5uLztujm=s7rZvuT=TYCUhr61OG-brQ@mail.gmail.com>
 <20200407021006.GN13306@hungrycats.org>
In-Reply-To: <20200407021006.GN13306@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 7 Apr 2020 11:58:51 +0100
Message-ID: <CAL3q7H6FmhRBmqfbY8FRRMGHB8zygwOYtGOaz6uPw5iF7XYseQ@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 7, 2020 at 3:10 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Mon, Apr 06, 2020 at 05:25:04PM +0100, Filipe Manana wrote:
> > On Mon, Apr 6, 2020 at 1:13 PM Anand Jain <anand.jain@oracle.com> wrote=
:
> > >
> > >
> > >
> > > > 7) When we do the actual write of this stripe, because it's a parti=
al
> > > > stripe write
> > > >     (we aren't writing to all the pages of all the stripes of the f=
ull
> > > > stripe), we
> > > >     need to read the remaining pages of stripe 2 (page indexes from=
 4 to 15) and
> > > >     all the pages of stripe 1 from disk in order to compute the con=
tent for the
> > > >     parity stripe. So we submit bios to read those pages from the c=
orresponding
> > > >     devices (we do this at raid56.c:raid56_rmw_stripe()).
> > >
> > >
> > > > The problem is that we
> > > >     assume whatever we read from the devices is valid -
> > >
> > >    Any idea why we have to assume here, shouldn't the csum / parent
> > >    transit id verification fail at this stage?
> >
> > I think we're not on the same page. Have you read the whole e-mail?
> >
> > At that stage, or any other stage during a partial stripe write,
> > there's no verification, that's the problem.
> > The raid5/6 layer has no information about which other parts of a
> > stripe may be allocated to an extent (which can be either metadata or
> > data).
> >
> > Getting such information and then doing the checks is expensive and
> > complex.
>
> ...and yet maybe still worth doing?  "Make it correct, then make it fast.=
"

Yes... I haven't started today fixing things on btrfs :)
However I like to have at least an idea on how to make things perform
better if I know or suspect it will cause a significant performance
impact.

>
> I did see Qu's proposal to use a parity mismatch detection to decide when
> to pull out the heavy scrub gun.  It's clever, but I see that more as an
> optimization than the right way forward: the correct behavior is *always*
> to do the csum verification when reading a block, even if it's because we
> are writing some adjacent block that is involved in a parity calculation.

Scrub does the checksum verification, both for metadata and data. So
it should be reliable.

>
> We can offer "skip the csum check when the data and parity matches"
> as an optional but slightly unsafe speedup.  If you are unlucky with
> single-bit errors on multiple drives (e.g. they all have a firmware bug
> that makes them all zero out the 54th byte in some sector) then you might
> end up with a stripe that has matching parity but invalid SHA256 csums,
> and maybe that becomes a security hole that only applies to btrfs raid5/6=
.
> On the other hand, maybe you're expecting all of your errors to be random
> and uncorrelated, and parity mismatch detection is good enough.
>
> If we adopt the "do csum verification except when we know we can avoid
> it" approach, there are other options where we know we can avoid the
> extra verification.  We could have the allocator try to allocate full
> RAID stripes so that we can skip the stripe-wide csum check because we
> know we are writing all the data in the stripe.  Since we would have the
> proper csum check to fall back on for correctness, the allocator can fall
> back to partial RAID stripes when we run out of full ones, and we don't
> get some of the worst parts of the "allocate only full stripes" approach.
> We do still have write hole with any partial stripe updates, but that's
> probably best solved separately.
>
> > We do validate an extent from a higher level (not in
> > raid56.c) when we read the extent (at btree_readpage_end_io_hook() and
> > btree_read_extent_buffer_pages()), and then if something is wrong with
> > it we attempt the recovery - in the case of raid56, by rebuilding the
> > stripe based on the remaining stripes. But if a write into another
> > extent of the same stripe happens before we attempt to read the
> > corrupt extent, we end up not being able to recover the extent, and
> > permanently corrupt destroy that possibility by overwriting the parity
> > stripe with content that was computed based on a corrupt extent.
> >
> > That's why I was asking for suggestions, because it's nor trivial to
> > do it without having a significant impact on performance and
> > complexity.
> >
> > About why we don't do it, I suppose the original author of our raid5/6
> > implementation never thought about that it could lead to a permanent
> > corruption.
> >
> > >
> > >    There is raid1 test case [1] which is more consistent to reproduce=
.
> > >      [1] https://patchwork.kernel.org/patch/11475417/
> > >    looks like its result of avoiding update to the generation for noc=
sum
> > >    file data modifications.
> >
> > Sorry, I don't see what's the relation.
> > The problem I'm exposing is exclusive to raid5/6, it's about partial
> > stripes writes, raid1 is not stripped.
> > Plus it's not about nodatacow/nodatacsum either, it affects both cow
> > and nocow, and metadata as well.
> >
> > Thanks.
> >
> > >
> > > Thanks, Anand
> > >
> > >
> > > > in this case what we read
> > > >     from device 3, to which stripe 2 is mapped, is invalid since in=
 the degraded
> > > >     mount we haven't written extent buffer 39043072 to it - so we g=
et
> > > > garbage from
> > > >     that device (either a stale extent, a bunch of zeroes due to tr=
im/discard or
> > > >     anything completely random).
> > > >
> > > > Then we compute the content for the
> > > > parity stripe
> > > >     based on that invalid content we read from device 3 and write t=
he
> > > > parity stripe
> > > >     (and the other two stripes) to disk;
> > >
> > >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
