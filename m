Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF3C375301
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhEFL0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 07:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhEFL0o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 May 2021 07:26:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68641C061574
        for <linux-btrfs@vger.kernel.org>; Thu,  6 May 2021 04:25:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a18so3651478qtj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 06 May 2021 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=N1/Sg/SieKYMs9o/PGbqBmQAR0Cb9ynWUDEkjuanl0I=;
        b=b755k3DKlh8KCi5WhC8Ev6Dh+7ztyyxbzjRXfr2xQoIAK5XJ6GXsHabDHTqldiatBk
         HYj7ae4OSJoloH22ffED6vGdPQHE8cUWXt9eYx2EOiGXSU/nO9Yyf91SrY+2Mcik/G2t
         3buHfbjeGQAil/Bq7cdQKUaxFSoaCKPOm3TsjUvjAncGyXQVg/Ez4vHs7pIfaj04IOrv
         4ERyJLa3GvMYSynRYJvdB53Wz3wEDUB1ghKr4ahp+g7RFC+2N7hSlAwsUkoibN0QH3UK
         BghIrvAS8ABmMyaV6BDbTeUlO8EwWIx4GnkY8Ny8PVjZbAvUZ4XPdfsoGSmFxLaA18Z6
         wxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=N1/Sg/SieKYMs9o/PGbqBmQAR0Cb9ynWUDEkjuanl0I=;
        b=mdO68tV9EUILXWBkYHlzqvHJNf2whlBGUWd2t6sa+W4pXHzvUSIjp1mO9LeulOsc8F
         Yazkzv9toMYfHWrZ+OZ+dMonNft0UX8WzIQuLDSio0wmkzycMDlO5/Q4/js9fFJXjrrQ
         N70x9UxqRimTHZn3iPRL+R8c0N9HGNomV4jO5rKAL7eK6NHDMc4HbMhsUnsLet29B+oL
         YlpTc+AKHxipfp7nlUTt92xDg5yE3gPlBPEW6soMTbGDEnDc1jbRUbwHkTheiTPStOdv
         CfKa+BEMIvX3eOmADI/kju4sUjgpacdd+tR3/jkaIOf7s/rP8ms2MAMRSGdGt6onDSwa
         18Nw==
X-Gm-Message-State: AOAM531QmiEesuTdxiDpcN6vq49+Lxlu8gTm67djGb6lNoYULhwkeBIh
        hw4YpupouNHL8FlimG3A36eriJmEZHiUof0ZcAtc/NLN8H756g==
X-Google-Smtp-Source: ABdhPJxrMeURTYhNPGE0hgc6L47IqdsUHi1duyWa2zDXkdi2f24vkrwcjR2WojmhTqoVUnxjw/vfs/WlZU5g27XCrVk=
X-Received: by 2002:ac8:a04:: with SMTP id b4mr3684459qti.376.1620300345433;
 Thu, 06 May 2021 04:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210506070458.168945-1-wqu@suse.com> <CAL3q7H7TY9c=dzcJw62-nZh-fSieb3gQyqjdXLv+-rMVmQ+ZJg@mail.gmail.com>
 <1b3c38fa-122e-47ad-5d83-f45064de714b@suse.com>
In-Reply-To: <1b3c38fa-122e-47ad-5d83-f45064de714b@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 6 May 2021 12:25:33 +0100
Message-ID: <CAL3q7H4j+VbBFaf=-MgPDC6hKgqZ+V-SoF4nmnTxxYqpsDcWiQ@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: temporary disable inline extent creation for
 fallocate and reflink
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 6, 2021 at 11:55 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/5/6 =E4=B8=8B=E5=8D=886:07, Filipe Manana wrote:
> > On Thu, May 6, 2021 at 8:07 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Previously we disable inline extent creation completely for subpage
> >> case, due to the fact that writeback for subpage still happens for ful=
l
> >> page.
> >>
> >> This makes btrfs_wait_ordered_range() trigger writeback for larger
> >> range, thus can writeback the first sector even we don't want.
> >>
> >> But the truth is, even for regular sectorsize, we still have a race
> >> window there operations where fallocate and reflink can cause inline
> >> extent being created.
> >
> > Yes, but why is it a problem for when sectorsize =3D=3D page size?
>
> Well, it doesn't affect the on-disk data, but purely break the on-disk
> data schema.

Hum, I don't understand, breaks how?
I think just because it does not corresponds to a developer's
expectation, does not necessarily mean it is broken, unless it causes
a bug.

>
> We don't really expect inline extent with regular extent, right?

Hard to tell. There are cases like the fallocate example where that happens=
,
and for compression cases where we get an inline extent representing
one full page/sector of data.
I don't think it was ever written in stone if such cases are expected
or unexpected (and why).

We discussed this in the past:

https://lore.kernel.org/linux-btrfs/20180302052254.7059-3-wqu@suse.com/

It's hard to tell if it was ever intended or not, the reality is that
it's possible and that there are filesystems out there with such
cases.
I think what matters is if such cases lead to any problem affecting
users (corruptions, crashes, deadlocks, leaks, etc).

>
> > There were problems in the past with send, clone, and fsync due their
> > expectations of never having a regular extent following an inline
> > extent, but all the ones I'm aware of were fixed long ago.
> >
> >>
> >> For example, for the following operations:
> >>
> >>   # xfs_io -f -c "pwrite 0 2k" -c "falloc 4k 4k" $file
> >>
> >> The first "pwrite 0 2k" dirtied the first sector, while inode size is
> >> updated to 2k.
> >> At this point, if the first sector is written back, it will be inlined=
.
> >>
> >> Then we enter "falloc 4k 4k" which will:
> >> a) call btrfs_cont_expand() to insert holes
> >> b) do the mainline to insert preallocated extents
> >> c) call btrfs_fallocate_update_isize() to enlarge the isize
> >>
> >> Until c), the isize is still 2K, and during that window, if the first
> >> sector is written back due to whatever reasons (from memory pressure t=
o
> >> fadvice to writeback the pages), since the isize is still 2K, we will
> >
> > fadvice -> fadvise
> >
> >> write the first sector as inlined.
> >>
> >> Then we have a case where we get mixed inline and regular extents.
> >
> > Again, the change log should mention why it is a problem, how it affect=
s users?
>
> It doesn't affect the end user, just like the a log bugs exposed by
> tree-checker, like the inode transid/generation problems.

I don't understand. You say it doesn't affect users but the tree
checker complains? I interpret that as affecting users.

Now, how does a mix of inline and regular extents cause inode
transid/generation problems?
If that's the only problem you are aware of, then it should be
explained how/why it happens in the changelog (and therefore why
disabling inline extents fixes the bug).

>
> But shouldn't we still follow the on-disk data schema that, if we have
> regular extents, then there shouldn't be an inline extent.
>
> > Some data corruption, reads returning wrong data, some crash, something=
 else?
>
> Just a scheme breakage, kernel can handle mixed types without problem.

As mentioned before, I'm not sure if it breaks expectations or not.
Certainly it's not very common, and maybe it was not expected at all
before fallocate and compression were introduced - I suppose only who
came up with the idea of inline extents and who added the first
implementations of fallocate and compression might tell.

>
> > Is it only a problem for pagesize > sectorsize, or for pagesize =3D=3D
> > sectorsize too?
>
> Both.
> But for pagesize =3D=3D sectorsize it's much harder.
>
> In fact, with the btrfs-progs patches to report such mixed extent type,
> on x86 I just hit a such problem on generic/476.

So unless such a combination really causes a bug to be triggered, I'm
not sure it's a good idea to have fsck report them as
inconsistencies/errors.

>
> >
> >>
> >> Fix the problem by introducing a new runtime inode flag,
> >> BTRFS_INODE_NOINLINE, to temporarily disable inline extent creation
> >> until the isize get enlarged.
> >>
> >> So that we don't need to disable inline extent creation completely for
> >> subpage.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Reason for RFC:
> >>
> >> I'm not sure if this is the best solution, as the original race window
> >> for regular sector has existed for a long long time.
> >
> > Yes, but as mentioned before, it does not cause bug, does it?
>
> Depends on whether schema breakage is a big thing or not.
>
> Personally I prefer to consider as schema breakage as a bug, even it
> doesn't cause any problem to end user.

I think the definition of a bug is a glitch that results in incorrect
behaviour/result in the software (i.e. affects users).
As mentioned earlier, it's not clear to me if such cases were ever
unexpected or not.

>
> That's why I'm enhancing tree-checker to detect things that are invalid
> even it doesn't break anything.
>
> But I kinda get your point, it's definitely not a high priority thing,
> unlike real data corruption.

Yeah, I'm reluctant to add code if it doesn't fix any bug or if it's
not needed for some feature or other change.

Though I'm curious about the inode transid/generation mismatch, I
don't see how the mix of inline and regular extents can lead to that.

Thanks.

>
> >
> >>
> >> I have also tried other solutions like switching the timing of
> >> btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
> >> btrfs_wait_ordered_range() happens before btrfs_cont_expand().
> >>
> >> So that we will writeback the first sector for subpage as inline, then
> >> btrfs_cont_expand() will re-dirty the first sector.
> >>
> >> This would solve the problem for subpage, but not the race window.
> >>
> >> Another idea is to enlarge inode size first, but that would greatly
> >> change the error path, may cause new regressions.
> >
> > I think I would prefer it that way. I don't see why it would change
> > the error paths so much.
> > Instead of clearing the bit, it would be just assigning the old i_isize=
 value.
>
> What would happen if one is calling btrfs_setsize() to resize the inode
> during fallocate call?
> Wouldn't we restore some out-of-data isize then?
> btrfs_setsize() doesn't hold inode lock, thus it can sneak in.
>
> If there is something else ensuring we're the only one modifying isize,
> I'm more happy to go this direction.
>
> Thanks,
> Qu
>
> >
> > But I don't have a strong preference.
> >
> >>
> >> I'm all ears for advice on this problem.
> >> ---
> >>   fs/btrfs/ctree.h         | 10 ++++++++++
> >>   fs/btrfs/delayed-inode.c |  3 ++-
> >>   fs/btrfs/file.c          | 19 +++++++++++++++++++
> >>   fs/btrfs/inode.c         | 21 ++++-----------------
> >>   fs/btrfs/reflink.c       | 14 ++++++++++++--
> >>   fs/btrfs/root-tree.c     |  3 ++-
> >>   fs/btrfs/tree-log.c      |  3 ++-
> >>   7 files changed, 51 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> >> index 7bb4212b90d3..7c74d57ad8fc 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -1488,6 +1488,16 @@ do {                                           =
                        \
> >>   #define BTRFS_INODE_DIRSYNC            (1 << 10)
> >>   #define BTRFS_INODE_COMPRESS           (1 << 11)
> >>
> >> +/*
> >> + * Runtime bit to temporary disable inline extent creation.
> >> + * To prevent the first sector get written back as inline before the =
isize
> >> + * get enlarged.
> >> + *
> >> + * This flag is for runtime only, won't reach disk, thus is not inclu=
ded
> >> + * in BTRFS_INODE_FLAG_MASK.
> >> + */
> >> +#define BTRFS_INODE_NOINLINE           (1 << 30)
> >> +
> >>   #define BTRFS_INODE_ROOT_ITEM_INIT     (1 << 31)
> >>
> >>   #define BTRFS_INODE_FLAG_MASK                                       =
   \
> >> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> >> index 1a88f6214ebc..64d931da083d 100644
> >> --- a/fs/btrfs/delayed-inode.c
> >> +++ b/fs/btrfs/delayed-inode.c
> >> @@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_t=
rans_handle *trans,
> >>                                         inode_peek_iversion(inode));
> >>          btrfs_set_stack_inode_transid(inode_item, trans->transid);
> >>          btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
> >> -       btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags)=
;
> >> +       btrfs_set_stack_inode_flags(inode_item,
> >> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
> >
> > If it's a runtime flag, not meant to be persisted, then it should be
> > set in btrfs_inode->runtime flags and not on btrfs_inode->flags,
> > which not only makes it more clear, but avoids doing this sort of bit
> > manipulation.
> >
> >>          btrfs_set_stack_inode_block_group(inode_item, 0);
> >>
> >>          btrfs_set_stack_timespec_sec(&inode_item->atime,
> >> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >> index 70a36852b680..a3559ce93780 100644
> >> --- a/fs/btrfs/file.c
> >> +++ b/fs/btrfs/file.c
> >> @@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, =
int mode,
> >>                          goto out;
> >>          }
> >>
> >> +       /*
> >> +        * Disable inline extent creation until we enlarged the inode =
size.
> >
> > until we enlarged -> until we increase (or update)
> >
> >> +        *
> >> +        * Since the inode size is only increased after we allocated a=
ll
> >
> > So this is a bit confusing to read. You'll want to mention that happens=
 only
> > for fallocate and cloning.
> >
> > As I read it, if I had little or no knowledge of the code, I would
> > interpret that that happens for all cases.
> > But those two cases, fallocate and cloning, are the exceptions to the
> > rule, which is we update the i_size and then fill in the file extent
> > items (like in the write path).
> >
> >> +        * extents, there are several cases to writeback the first sec=
tor,
> >> +        * which can be inlined, leaving inline extent mixed with regu=
lar
> >> +        * extents:
> >> +        *
> >> +        * - btrfs_wait_ordered_range() call for subpage case
> >> +        *   The writeback happens for the full page, thus can writeba=
ck
> >> +        *   the first sector of an inode.
> >> +        *
> >> +        * - Memory pressure
> >> +        *
> >> +        * So here we temporarily disable inline extent creation for t=
he inode.
> >
> > Same as commented before, I would like to know why is it a problem,
> > how does it affect correctness, if there's some corruption, crash, or
> > something else affecting users.
> >
> >> +        */
> >> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
> >> +
> >>          /*
> >>           * TODO: Move these two operations after we have checked
> >>           * accurate reserved space, or fallocate can still fail but
> >> @@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, i=
nt mode,
> >>          unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, l=
ocked_end,
> >>                               &cached_state);
> >>   out:
> >> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
> >>          btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
> >>          /* Let go of our reservation. */
> >>          if (ret !=3D 0 && !(mode & FALLOC_FL_ZERO_RANGE))
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index 4fc6e6766234..59972cb2efce 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -666,11 +666,7 @@ static noinline int compress_file_range(struct as=
ync_chunk *async_chunk)
> >>                  }
> >>          }
> >>   cont:
> >> -       /*
> >> -        * Check cow_file_range() for why we don't even try to create
> >> -        * inline extent for subpage case.
> >> -        */
> >> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> >> +       if (start =3D=3D 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NO=
INLINE)) {
> >>                  /* lets try to make an inline extent */
> >>                  if (ret || total_in < actual_end) {
> >>                          /* we didn't compress the entire range, try
> >> @@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
> >>
> >>          inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
> >>
> >> -       /*
> >> -        * Due to the page size limit, for subpage we can only trigger=
 the
> >> -        * writeback for the dirty sectors of page, that means data wr=
iteback
> >> -        * is doing more writeback than what we want.
> >> -        *
> >> -        * This is especially unexpected for some call sites like fall=
ocate,
> >> -        * where we only increase isize after everything is done.
> >> -        * This means we can trigger inline extent even we didn't want=
.
> >> -        * So here we skip inline extent creation completely.
> >> -        */
> >> -       if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> >> +       if (start =3D=3D 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) =
{
> >>                  /* lets try to make an inline extent */
> >>                  ret =3D cow_file_range_inline(inode, start, end, 0,
> >>                                              BTRFS_COMPRESS_NONE, NULL=
);
> >> @@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_h=
andle *trans,
> >>          btrfs_set_token_inode_sequence(&token, item, inode_peek_ivers=
ion(inode));
> >>          btrfs_set_token_inode_transid(&token, item, trans->transid);
> >>          btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> >> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flag=
s);
> >> +       btrfs_set_token_inode_flags(&token, item,
> >> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
> >>          btrfs_set_token_inode_block_group(&token, item, 0);
> >>   }
> >>
> >> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> >> index e5680c03ead4..48f8bdd185de 100644
> >> --- a/fs/btrfs/reflink.c
> >> +++ b/fs/btrfs/reflink.c
> >> @@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct fil=
e *file, struct file *file_src,
> >>          if (off + len =3D=3D src->i_size)
> >>                  len =3D ALIGN(src->i_size, bs) - off;
> >>
> >> +       /*
> >> +        * Temporarily disable inline extent creation, check btrfs_fal=
locate()
> >> +        * for details
> >> +        */
> >> +       BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
> >>          if (destoff > inode->i_size) {
> >>                  const u64 wb_start =3D ALIGN_DOWN(inode->i_size, bs);
> >>
> >>                  ret =3D btrfs_cont_expand(BTRFS_I(inode), inode->i_si=
ze, destoff);
> >> -               if (ret)
> >> +               if (ret) {
> >> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLI=
NE;
> >>                          return ret;
> >> +               }
> >>                  /*
> >>                   * We may have truncated the last block if the inode'=
s size is
> >>                   * not sector size aligned, so we need to wait for wr=
iteback to
> >> @@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file=
 *file, struct file *file_src,
> >>                   */
> >>                  ret =3D btrfs_wait_ordered_range(inode, wb_start,
> >>                                                 destoff - wb_start);
> >> -               if (ret)
> >> +               if (ret) {
> >> +                       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLI=
NE;
> >>                          return ret;
> >> +               }
> >>          }
> >>
> >>          /*
> >> @@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file =
*file, struct file *file_src,
> >>                                  round_down(destoff, PAGE_SIZE),
> >>                                  round_up(destoff + len, PAGE_SIZE) - =
1);
> >>
> >> +       BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
> >>          return ret;
> >>   }
> >>
> >> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> >> index 702dc5441f03..5ce3a1dfaf3f 100644
> >> --- a/fs/btrfs/root-tree.c
> >> +++ b/fs/btrfs/root-tree.c
> >> @@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_r=
oot_item *root_item)
> >>
> >>          if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
> >>                  inode_flags |=3D BTRFS_INODE_ROOT_ITEM_INIT;
> >> -               btrfs_set_stack_inode_flags(&root_item->inode, inode_f=
lags);
> >> +               btrfs_set_stack_inode_flags(&root_item->inode,
> >> +                               inode_flags & BTRFS_INODE_FLAG_MASK);
> >
> > Same as before, using btrfs_inode->runtime_flags would eliminate the
> > need for this.
> >
> >>                  btrfs_set_root_flags(root_item, 0);
> >>                  btrfs_set_root_limit(root_item, 0);
> >>          }
> >> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >> index c1353b84ae54..f7e6abfc89c0 100644
> >> --- a/fs/btrfs/tree-log.c
> >> +++ b/fs/btrfs/tree-log.c
> >> @@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_h=
andle *trans,
> >>          btrfs_set_token_inode_sequence(&token, item, inode_peek_ivers=
ion(inode));
> >>          btrfs_set_token_inode_transid(&token, item, trans->transid);
> >>          btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> >> -       btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flag=
s);
> >> +       btrfs_set_token_inode_flags(&token, item,
> >> +                       BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK)=
;
> >
> > Same as before, using btrfs_inode->runtime_flags would eliminate the
> > need for this.
> >
> > Thanks.
> >
> >>          btrfs_set_token_inode_block_group(&token, item, 0);
> >>   }
> >>
> >> --
> >> 2.31.1
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
