Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFC1469AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAWNtQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:49:16 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38960 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgAWNtP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:49:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id y125so1751197vsb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 05:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6OmO0YLtC03LXE4VeEDJChMcR3yeSwXfAY5rErkCpK8=;
        b=Z70jGFojfxUgbo4wP5SaKZAoOtd8YkLh+dWq/ICjY7f8F6LKfxqqFB3MQFrX/f7V2X
         70D5y+8Q7W+LMDrP1jIrt29Rqqv7J+fGVP56pWVDrboKcueSOIwa40Y8hCwaFYioBCYl
         KrC3VGgr45UtlB7v+pD2jPZIG2aaYXgBesUflXQC8FYeLPQ7cE/b9l/RrORyeZ7AKg5r
         lKq4bYV2xEGlwtZHeTnlk6XKtnEVpgA6fuWGpSz4ANcuvzcau6grtN+FWIMDgxIB5DMJ
         RD4kPziLtRh7gCpt3hjbjYI3QSUstJCAShSfb5kMfLHjRM7ayI8wNVfcHiPl8IFsbd8R
         B6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6OmO0YLtC03LXE4VeEDJChMcR3yeSwXfAY5rErkCpK8=;
        b=YqOIkKB9LnQRferJJihuRrMBoXu+ZpPoCt0UEGn/99uafPjUCCIJLa0Crj3uyqwm5g
         bdYc2aPQka4zLNXYehOSDuvDakh36Dfj2GPvQ2yXdsF9GC305XhHA9gGtoegP9mfCLCr
         Gc3tznDc6C2pte9dmxfFYPQ3hb1Ncff2qfqTdFjjk/fWdMiRV0WFQODK5k83JQeb+y/E
         1wAQaHkJbPqkfLhqLXsDk9Mda0FEUVXLOtuTf1JljjvkKGXJTCqSoLsc5BlQQofALRcO
         QmH5v2Guby5IZ+w8QncltQoFgvV+E7OpOmO1ZCHTxhOs9UGSo44q3vFI+7i9AoqHFoeQ
         0nQA==
X-Gm-Message-State: APjAAAUVcnXlIoO2/DrON+PZbbOB7A1rYxWn/v17t59pz5cTmN+4hcbS
        JjrFOkSK9oi/SX/LjiD9E0BQUdwzs2URnrWQJfY=
X-Google-Smtp-Source: APXvYqwNXkMEnXlE/59i972HNs8jTYMSlkE0HWIwCT5ZA7whYH2qkVr2pixIPTZMicQ/kjPB+1cRLTM0TPItmh5QnNc=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr5792971vsq.206.1579787354051;
 Thu, 23 Jan 2020 05:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20200123073759.23535-1-wqu@suse.com> <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
 <f32340f7-7e0c-e6fe-3122-4d8e8cab9257@gmx.com>
In-Reply-To: <f32340f7-7e0c-e6fe-3122-4d8e8cab9257@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Jan 2020 13:49:02 +0000
Message-ID: <CAL3q7H5NudsNQZo+W1mJ26VxFTrowpqAH7soE0j3F2GTygae8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for dev-replace
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 1:39 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/23 =E4=B8=8B=E5=8D=888:06, Filipe Manana wrote:
> > On Thu, Jan 23, 2020 at 7:38 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> For dev-replace test cases with fsstress, like btrfs/06[45] btrfs/071,
> >> looped runs can lead to random failure, where scrub finds csum error.
> >>
> >> The possibility is not high, around 1/20 to 1/100, but it's causing da=
ta
> >> corruption.
> >>
> >> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
> >> check free space before marking a block group RO")
> >>
> >> [CAUSE]
> >> Dev-replace has two source of writes:
> >> - Write duplication
> >>   All writes to source device will also be duplicated to target device=
.
> >>
> >>   Content:      Latest data/meta
> >
> > I find the term "latest" a bit confusing, perhaps "not yet persisted
> > data and metadata" is more clear.
> >
> >>
> >> - Scrub copy
> >>   Dev-replace reused scrub code to iterate through existing extents, a=
nd
> >>   copy the verified data to target device.
> >>
> >>   Content:      Data/meta in commit root
> >
> > And so here "previously persisted data and metadata".
> >
> >>
> >> The difference in contents makes the following race possible:
> >>         Regular Writer          |       Dev-replace
> >> -----------------------------------------------------------------
> >>   ^                             |
> >>   | Preallocate one data extent |
> >>   | at bytenr X, len 1M         |
> >>   v                             |
> >>   ^ Commit transaction          |
> >>   | Now extent [X, X+1M) is in  |
> >>   v commit root                 |
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Dev replace st=
arts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>                                 | ^
> >>                                 | | Scrub extent [X, X+1M)
> >>                                 | | Read [X, X+1M)
> >>                                 | | (The content are mostly garbage
> >>                                 | |  since it's preallocated)
> >>   ^                             | v
> >>   | Write back happens for      |
> >>   | extent [X, X+512K)          |
> >>   | New data writes to both     |
> >>   | source and target dev.      |
> >>   v                             |
> >>                                 | ^
> >>                                 | | Scrub writes back extent [X, X+1M)
> >>                                 | | to target device.
> >>                                 | | This will over write the new data =
in
> >>                                 | | [X, X+512K)
> >>                                 | v
> >>
> >> This race can only happen for nocow writes. Thus metadata and data cow
> >> writes are safe, as COW will never overwrite extents of previous trans
> >> (in commit root).
> >>
> >> This behavior can be confirmed by disabling all fallocate related call=
s
> >> in fsstress (*), then all related tests can pass a 2000 run loop.
> >>
> >> *: FSSTRESS_AVOID=3D"-f fallocate=3D0 -f allocsp=3D0 -f zero=3D0 -f in=
sert=3D0 \
> >>                    -f collapse=3D0 -f punch=3D0 -f resvsp=3D0"
> >>    I didn't expect resvsp ioctl will fallback to fallocate in VFS...
> >>
> >> [FIX]
> >> Make dev-replace to require mandatory block group RO, and wait for cur=
rent
> >> nocow writes before calling scrub_chunk().
> >>
> >> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue re=
place
> >> when set_block_ro failed") for dev-replace path.
> >>
> >> ENOSPC for dev-replace is still much better than data corruption.
> >
> > Technically if we flag the block group RO without being able to
> > persist that due to ENOSPC, it's still ok.
> > We just want to prevent nocow writes racing with scrub copying
> > procedure. But that's something for some other time, and this is fine
> > to me.
> >
> >>
> >> Reported-by: Filipe Manana <fdmanana@suse.com>
> >> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed=
")
> >> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before mark=
ing a block group RO")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> RFC->v1:
> >> - Remove the RFC tag
> >>   Since the cause is pinned and verified, no need for RFC.
> >>
> >> - Only wait for nocow writes for dev-replace
> >>   CoW writes are safe as they will never overwrite extents in commit
> >>   root.
> >>
> >> - Put the wait call into proper lock context
> >>   Previous wait happens after scrub_pause_off(), which can cause
> >>   deadlock where we may need to commit transaction in one of the
> >>   wait calls. But since we are in scrub_pause_off() environment,
> >>   transaction commit will wait us to continue, causing a wait-on-self
> >>   deadlock.
> >> ---
> >>  fs/btrfs/scrub.c | 30 +++++++++++++++++++++++++-----
> >>  1 file changed, 25 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 21de630b0730..5aa486cad298 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -3577,17 +3577,27 @@ int scrub_enumerate_chunks(struct scrub_ctx *s=
ctx,
> >>                  * This can easily boost the amount of SYSTEM chunks i=
f cleaner
> >>                  * thread can't be triggered fast enough, and use up a=
ll space
> >>                  * of btrfs_super_block::sys_chunk_array
> >> +                *
> >> +                * While for dev replace, we need to try our best to m=
ark block
> >> +                * group RO, to prevent race between:
> >> +                * - Write duplication
> >> +                *   Contains latest data
> >> +                * - Scrub copy
> >> +                *   Contains data from commit tree
> >> +                *
> >> +                * If target block group is not marked RO, nocow write=
s can
> >> +                * be overwritten by scrub copy, causing data corrupti=
on.
> >> +                * So for dev-replace, it's not allowed to continue if=
 a block
> >> +                * group is not RO.
> >>                  */
> >> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> >> -               scrub_pause_off(fs_info);
> >> -
> >> +               ret =3D btrfs_inc_block_group_ro(cache, sctx->is_dev_r=
eplace);
> >>                 if (ret =3D=3D 0) {
> >>                         ro_set =3D 1;
> >> -               } else if (ret =3D=3D -ENOSPC) {
> >> +               } else if (ret =3D=3D -ENOSPC && !sctx->is_dev_replace=
) {
> >>                         /*
> >>                          * btrfs_inc_block_group_ro return -ENOSPC whe=
n it
> >>                          * failed in creating new chunk for metadata.
> >> -                        * It is not a problem for scrub/replace, beca=
use
> >> +                        * It is not a problem for scrub, because
> >>                          * metadata are always cowed, and our scrub pa=
used
> >>                          * commit_transactions.
> >>                          */
> >> @@ -3596,9 +3606,19 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
> >>                         btrfs_warn(fs_info,
> >>                                    "failed setting block group ro: %d"=
, ret);
> >>                         btrfs_put_block_group(cache);
> >> +                       scrub_pause_off(fs_info);
> >>                         break;
> >>                 }
> >>
> >> +               /*
> >> +                * Now the target block is marked RO, wait for nocow w=
rites to
> >> +                * finish before dev-replace.
> >> +                * COW is fine, as COW never overwrites extents in com=
mit tree.
> >> +                */
> >> +               if (sctx->is_dev_replace)
> >> +                       btrfs_wait_nocow_writers(cache);
> >
> > So this only waits for nocow ordered extents to be created - it
> > doesn't wait for them to complete.
>
> Wait for minute.
>
> This btrfs_wait_nocow_writers() is not just triggering ordered extents
> for nocow.
> It waits for the nocow_writers count decreased to 0 for that block group.
>
> Since we have already marked the block group RO, no new nocow writers
> can happen, thus that counter can only decrease, no way to increase.
>
> There are several cases involved:
> - NoCOW Write back happens before bg RO
>   It will increase cache->nocow_writers counter, and decrease the
>   counter after finish_oredered_io().

Nop. nocow_writers is decremented after creating the ordered extent
when starting writeback (at run_delalloc_nocow) - not when completing
the ordered extent (at btrfs_finish_ordered_io()).
Same applies direct IO.

Thanks


>   btrfs_wait_nocow_writers() will wait for such writes
>
> - Writeback happens after bg RO
>   Then the write will fallback to COW.
>
> - Writeback happens after bg RO cleared (reverted back to RW)
>   No need to bother at all.
>
> Thus this should be enough, no need for btrfs_wait_ordered_roots().
>
> Thanks,
> Qu
>
>
> > After that you still need to call:
> >
> > btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length)=
;
> >
> > Other than that, looks good to me.
> >
> > Thanks.
> >
> >> +
> >> +               scrub_pause_off(fs_info);
> >>                 down_write(&dev_replace->rwsem);
> >>                 dev_replace->cursor_right =3D found_key.offset + lengt=
h;
> >>                 dev_replace->cursor_left =3D found_key.offset;
> >> --
> >> 2.25.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
