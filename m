Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15433953C7
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEaBzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 21:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEaBzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 21:55:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2508C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 18:53:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so14372529ybi.12
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Qn9rIxqeR+PdQ8KOQmCkvDLzhzwLOO5b1Ccn/5ht6k=;
        b=oW6ORZhSTYaAE4YrTsdEcOPlA01/rh1BdxXYm48DYYTHjnipvelc7VGHdmHndVqXCI
         Im2nQQsL7sq7/MZRMSaGc6m5uJQ1z4C2mvl4AuAUOAPZmXks/7Dic1qQrmMMeBOclydS
         GvcbE4jA4yprUbIPBOwLf4iKmH6Z5vQABvJjFHwc2h3pYKhfoBBUj49Gt3XUMoKeHP0q
         MjUwiJTFivspZXcULLujIiV7szY1jfPw/8uzSpYA0X62SRjapAEBxSraoODy0SJQg1TE
         CaUfWtTE+Ln3OPJp/Dl+KfV0jx91ztcLVIc6V5X24GcJMkXnksJSW6SiJewl4JkFMBuS
         Mehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Qn9rIxqeR+PdQ8KOQmCkvDLzhzwLOO5b1Ccn/5ht6k=;
        b=CoNjwc6rTr19Y9mj1/3Ubpt8U7T4W5HWrjA4NAE9kDLivftpTuclkgLmkY9Y4Nulft
         t4ANiv6nAn/Kj2Pq/gPpCYvRRxpZeA/1MHedhbfQeg/477FfNsbBlCAKU35nsc4ieHVl
         5GhWPN9kJBqneKsfGHNdsNOpRQ4PlD/XMBk4w+HxGdP0cGIceelteOEJ/GFJ4W+GsBjd
         OEL8wWICK4ATBzNen8ZVh8piCAeOhkqHb4Pq3G1+nWHtWr7TR43DXy+R5/mspoktMTdh
         nC6nv0cWDnz19NZtN3gYxY8NTuXkLKoouhv09f0mBlauOTvc152MolYs8hXoYxTdxQ2i
         s9Og==
X-Gm-Message-State: AOAM531oZdVin43vdFY9x7x18VMJosjSIdjkWWl8d5gsmX0w+Nn/sLmr
        Xh3MZiC22OHf9EPqzsP/XL3RUvfSo7Ou4wgbJxOADcfRylA=
X-Google-Smtp-Source: ABdhPJxOBGk8fP9c8cuohlq+ef8IiUVkvmkChT/sgSr96fouT8P4xGwTOEeniKX5tKPNL4HsNiVOflYL9bid5v/z2Ms=
X-Received: by 2002:a25:ce41:: with SMTP id x62mr29066246ybe.109.1622426009954;
 Sun, 30 May 2021 18:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210521064050.191164-1-wqu@suse.com> <CAEg-Je9m_Lpwq3oXOFfhrHU_OFxryrGE8-3vjMztn7tBt_uStw@mail.gmail.com>
 <35u3vfpe.fsf@damenly.su>
In-Reply-To: <35u3vfpe.fsf@damenly.su>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 30 May 2021 21:52:54 -0400
Message-ID: <CAEg-Je_OZNb4LvOKMNgFZLJSj5wOMRDvYv0kvnaoyGk7TXn1sg@mail.gmail.com>
Subject: Re: [PATCH v3 00/31] btrfs: add data write support for subpage
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 30, 2021 at 9:45 PM Su Yue <l@damenly.su> wrote:
>
>
> On Sun 30 May 2021 at 08:12, Neal Gompa <ngompa13@gmail.com>
> wrote:
>
> > On Fri, May 21, 2021 at 5:56 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> This huge patchset can be fetched from github:
> >> https://github.com/adam900710/linux/tree/subpage
> >>
> >> =3D=3D=3D Current stage =3D=3D=3D
> >> The tests on x86 pass without new failure, and generic test
> >> group on
> >> arm64 with 64K page size passes except known failure and defrag
> >> group.
> >>
> >> For btrfs test group, all pass except compression/raid56.
> >> (As the btrfs defrag group doesn't require that restrict defrag
> >> result,
> >> btrfs/defrag group also passes here)
> >>
> >> For anyone who is interested in testing, please apply this
> >> patch for
> >> btrfs-progs before testing.
> >> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.=
243715-1-wqu@suse.com/
> >> Or there will be too many false alerts.
> >>
> >> =3D=3D=3D Limitation =3D=3D=3D
> >> There are several limitations introduced just for subpage:
> >> - No compressed write support
> >>   Read is no problem, but compression write path has more
> >>   things left to
> >>   be modified.
> >>   Thus for current patchset, no matter what inode attribute or
> >>   mount
> >>   option is, no new compressed extent can be created for
> >>   subpage case.
> >>
> >> - No inline extent will be created
> >>   This is mostly due to the fact that
> >>   filemap_fdatawrite_range() will
> >>   trigger more write than the range specified.
> >>   In fallocate calls, this behavior can make us to writeback
> >>   which can
> >>   be inlined, before we enlarge the isize, causing inline
> >>   extent being
> >>   created along with regular extents.
> >>
> >> - No support for RAID56
> >>   There are still too many hardcoded PAGE_SIZE in raid56 code.
> >>   Considering it's already considered unsafe due to its
> >>   write-hole
> >>   problem, disabling RAID56 for subpage looks sane to me.
> >>
> >> - No sector-sized defrag support
> >>   Currently defrag is still done in PAGE_SIZE, meaning if there
> >>   is a
> >>   hole in a 64K page, we still write a full 64K back to disk.
> >>   This causes more disk space usage.
> >>
> >> =3D=3D=3D Patchset structure =3D=3D=3D
> >>
> >> Patch 01~19:    Make data write path to be subpage compatible
> >> Patch 20~21:    Make data relocation path to be subpage
> >> compatible
> >> Patch 22~30:    Various fixes for subpage corner cases
> >> Patch 31:       Enable subpage data write
> >>
> >> =3D=3D=3D Changelog =3D=3D=3D
> >> v2:
> >> - Rebased to latest misc-next
> >>   Now metadata write patches are removed from the series, as
> >>   they are
> >>   already merged into misc-next.
> >>
> >> - Added new Reviewed-by/Tested-by/Reported-by tags
> >>
> >> - Use separate endio functions to subpage metadata write path
> >>
> >> - Re-order the patches, to make refactors at the top of the
> >> series
> >>   One refactor, the submit_extent_page() one, should benefit 4K
> >>   page
> >>   size more than 64K page size, thus it's worthy to be merged
> >>   early
> >>
> >> - New bug fixes exposed by Ritesh Harjani on Power
> >>
> >> - Reject RAID56 completely
> >>   Exposed by btrfs test group, which caused BUG_ON() for
> >>   various sites.
> >>   Considering RAID56 is already not considered safe, it's
> >>   better to
> >>   reject them completely for now.
> >>
> >> - Fix subpage scrub repair failure
> >>   Caused by hardcoded PAGE_SIZE
> >>
> >> - Fix free space cache inode size
> >>   Same cause as scrub repair failure
> >>
> >> v3:
> >> - Rebased to remove write path prepration patches
> >>
> >> - Properly enable btrfs defrag
> >>   Previsouly, btrfs defrag is in fact just disabled.
> >>   This makes tons of tests in btrfs/defrag to fail.
> >>
> >> - More bug fixes for rare race/crashes
> >>   * Fix relocation false alert on csum mismatch
> >>   * Fix relocation data corruption
> >>   * Fix a rare case of false ASSERT()
> >>     The fix already get merged into the prepration patches,
> >>     thus no
> >>     longer in this patchset though.
> >>
> >>   Mostly reported by Ritesh from IBM.
> >>
> >> Qu Wenruo (31):
> >>   btrfs: pass bytenr directly to __process_pages_contig()
> >>   btrfs: refactor the page status update into
> >>   process_one_page()
> >>   btrfs: provide btrfs_page_clamp_*() helpers
> >>   btrfs: only require sector size alignment for
> >>     end_bio_extent_writepage()
> >>   btrfs: make btrfs_dirty_pages() to be subpage compatible
> >>   btrfs: make __process_pages_contig() to handle subpage
> >>     dirty/error/writeback status
> >>   btrfs: make end_bio_extent_writepage() to be subpage
> >>   compatible
> >>   btrfs: make process_one_page() to handle subpage locking
> >>   btrfs: introduce helpers for subpage ordered status
> >>   btrfs: make page Ordered bit to be subpage compatible
> >>   btrfs: update locked page dirty/writeback/error bits in
> >>     __process_pages_contig
> >>   btrfs: prevent extent_clear_unlock_delalloc() to unlock page
> >>   not
> >>     locked by __process_pages_contig()
> >>   btrfs: make btrfs_set_range_writeback() subpage compatible
> >>   btrfs: make __extent_writepage_io() only submit dirty range
> >>   for
> >>     subpage
> >>   btrfs: make btrfs_truncate_block() to be subpage compatible
> >>   btrfs: make btrfs_page_mkwrite() to be subpage compatible
> >>   btrfs: reflink: make copy_inline_to_page() to be subpage
> >>   compatible
> >>   btrfs: fix the filemap_range_has_page() call in
> >>     btrfs_punch_hole_lock_range()
> >>   btrfs: don't clear page extent mapped if we're not
> >>   invalidating the
> >>     full page
> >>   btrfs: extract relocation page read and dirty part into its
> >>   own
> >>     function
> >>   btrfs: make relocate_one_page() to handle subpage case
> >>   btrfs: fix wild subpage writeback which does not have ordered
> >>   extent.
> >>   btrfs: disable inline extent creation for subpage
> >>   btrfs: allow submit_extent_page() to do bio split for subpage
> >>   btrfs: make defrag to be semi subpage compatible
> >>   btrfs: reject raid5/6 fs for subpage
> >>   btrfs: fix a crash caused by race between prepare_pages() and
> >>     btrfs_releasepage()
> >>   btrfs: fix a use-after-free bug in writeback subpage helper
> >>   btrfs: fix a subpage false alert for relocating partial
> >>   preallocated
> >>     data extents
> >>   btrfs: fix a subpage relocation data corruption
> >>   btrfs: allow read-write for 4K sectorsize on 64K page size
> >>   systems
> >>
> >>  fs/btrfs/ctree.h        |   2 +-
> >>  fs/btrfs/disk-io.c      |  13 +-
> >>  fs/btrfs/extent_io.c    | 551
> >>  +++++++++++++++++++++++++++-------------
> >>  fs/btrfs/file.c         |  31 ++-
> >>  fs/btrfs/inode.c        | 147 +++++++++--
> >>  fs/btrfs/ioctl.c        |  12 +-
> >>  fs/btrfs/ordered-data.c |   5 +-
> >>  fs/btrfs/reflink.c      |  14 +-
> >>  fs/btrfs/relocation.c   | 287 +++++++++++++--------
> >>  fs/btrfs/subpage.c      | 156 +++++++++++-
> >>  fs/btrfs/subpage.h      |  31 +++
> >>  fs/btrfs/super.c        |   7 -
> >>  fs/btrfs/sysfs.c        |   5 +
> >>  fs/btrfs/volumes.c      |   8 +
> >>  14 files changed, 937 insertions(+), 332 deletions(-)
> >>
> >> --
> >> 2.31.1
> >>
> >
> > So this seems to have no impact on my system on x86_64 with the
> > branch, which is good I guess?
> >
> > Unfortunately, I couldn't make a test package based on 5.13rc4
> > for
> > some confidence testing as the patch set from Patchwork doesn't
> > apply...
> >
> > However, somewhat related to this, it seems that we're going to
> > be
> > seeing a need for 4K <-> 16K page interoperability because Linux
> > will
> > need to be configured to use 16K pages to run effectively on
> > Apple ARM
> > Mac systems[1][2].
> >
> > How difficult would it be to extend this to also handle 16K
> > pages too?
> > Not necessarily in this patch set, but in a follow-up one?
> >
> > [1]: https://twitter.com/marcan42/status/1398301930879815680
> > [2]: https://twitter.com/marcan42/status/1398301933203431426
>
> As a super fan of Apple, I've noticed Hector Martin's work on M1
> chip.
> I'm so happy to expect a full functional M1 device running on
> linux.
> However as for btrfs, I'd say just let 64k pagesize subpage
> support go
> ahead and fix potencial bugs by real users feedbacks for sometime.
>

I wasn't proposing that we hold this back for that. In fact, I
explicitly suggested *not* doing that. However, it's somewhat academic
for now as M1 support isn't quite done yet, and we still don't have
this merged either.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
