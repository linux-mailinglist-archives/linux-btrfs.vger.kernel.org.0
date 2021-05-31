Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B110D395A4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhEaMT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhEaMT4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 08:19:56 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF13C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 05:18:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y2so16281387ybq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+xiXpZoWQWZp4S2vbcTYOEs5d/AZLg5j/olhumSvPM=;
        b=jHHrCZDDudyMIHDyAEDwhkNmja0mVzuhANebuEmnJ+0uUzQH8suqavxdbLIECKogaY
         QnmL6YrLtlQsrWgZGpSKYbrJ9ndMmo3DixolFo1cd359TxT6mbqFeGeaIL3/khGbtbTv
         Ma4SdGz85w5a+rMnimyY7vluh2aNOzGYcODxwILGMzqZaLn/CMEPdMIq+P1q94SlzJfK
         knFG2lZWUZ7L6ts0zeaz/cZvZQxmSqEJKCQ0HZLtq7Wp0hBsbiS8gioL5ZWs8k0J3GGd
         ZAzFiMeqFjeNIgIklusFxFZlxg0mpQW9xikYASo11jR7/03Dw5Jmfw54vJIZ0YpyctgJ
         kQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+xiXpZoWQWZp4S2vbcTYOEs5d/AZLg5j/olhumSvPM=;
        b=NiHpuR6lfKcId6U9/VLPpRQsDgtAKw8HUrDMGWUb+hDKGwScMo0sJ+ZlZcYZFFJhA3
         U7otpvi9KQxVLimFnrzc+tvwq+tgCVCA49jFGPWV/MB7nD5aRYZ3PFZzLw/pw2dqkEOU
         ab0s98nDOkJfcvkwUX6dS07Nq+cL3Gq9a4Ajg/S+ZqtN+RqsBjNSYuof2Ijz+SxQaWTX
         bYnWkjV2JZ2vyvGtIYAIeFGj9RVn37LZELkqS8SpUtBlykb5ACy3vEaGzqjfltsp89BC
         2cVAk4O0wXsu3a8F8HVP1MF0rJhjrrsH0DAT+wtns6iOCBiER7yzCK69k9fXisgfJ2EK
         VwFQ==
X-Gm-Message-State: AOAM532zl1eyb7Zs7k308Y7fedvO715bjgCGVXKRKImf5fnp6qEoqHJf
        +rmcnWrOQcPjduTch5x/VIyKSPcykSNmXewEixs=
X-Google-Smtp-Source: ABdhPJx/Z+qlr3D1rrOGt0SpLwsNXOBrX7NZbuOJvvnTiVq9yrjupFZCXA6RxkVF+bi5E5jUPPeJUiEifbssK81PW1k=
X-Received: by 2002:a25:6185:: with SMTP id v127mr21206975ybb.0.1622463495977;
 Mon, 31 May 2021 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210531085106.259490-1-wqu@suse.com> <CAEg-Je_0FrdEYKsHKb3e-kL2zehawwA9UVVmv+2wVC_+wQTC1Q@mail.gmail.com>
 <3e254c57-b82c-443c-a05e-d18fdf261e41@gmx.com>
In-Reply-To: <3e254c57-b82c-443c-a05e-d18fdf261e41@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 31 May 2021 08:17:40 -0400
Message-ID: <CAEg-Je8b74AHC32Z7Zwrfz_83bBSLjaU58AdzvgSanBNoZ3X=w@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 5:50 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/5/31 =E4=B8=8B=E5=8D=885:47, Neal Gompa wrote:
> > On Mon, May 31, 2021 at 4:52 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> This huge patchset can be fetched from github:
> >> https://github.com/adam900710/linux/tree/subpage
> >>
> >> =3D=3D=3D Current stage =3D=3D=3D
> >> The tests on x86 pass without new failure, and generic test group on
> >> arm64 with 64K page size passes except known failure and defrag group.
> >>
> >> For btrfs test group, all pass except compression/raid56/defrag.
> >>
> >> For anyone who is interested in testing, please apply this patch for
> >> btrfs-progs before testing.
> >> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.=
243715-1-wqu@suse.com/
> >> Or there will be too many false alerts.
> >>
> >> =3D=3D=3D Limitation =3D=3D=3D
> >> There are several limitations introduced just for subpage:
> >> - No compressed write support
> >>    Read is no problem, but compression write path has more things left=
 to
> >>    be modified.
> >>    Thus for current patchset, no matter what inode attribute or mount
> >>    option is, no new compressed extent can be created for subpage case=
.
> >>
> >> - No inline extent will be created
> >>    This is mostly due to the fact that filemap_fdatawrite_range() will
> >>    trigger more write than the range specified.
> >>    In fallocate calls, this behavior can make us to writeback which ca=
n
> >>    be inlined, before we enlarge the isize, causing inline extent bein=
g
> >>    created along with regular extents.
> >>
> >> - No support for RAID56
> >>    There are still too many hardcoded PAGE_SIZE in raid56 code.
> >>    Considering it's already considered unsafe due to its write-hole
> >>    problem, disabling RAID56 for subpage looks sane to me.
> >>
> >> - No defrag support for subpage
> >>    The support for subpage defrag has already an initial version
> >>    submitted to the mail list.
> >>    Thus the correct support won't be included in this patchset.
> >>
> >> =3D=3D=3D Patchset structure =3D=3D=3D
> >>
> >> Patch 01~19:    Make data write path to be subpage compatible
> >> Patch 20~21:    Make data relocation path to be subpage compatible
> >> Patch 22~29:    Various fixes for subpage corner cases
> >> Patch 30:       Enable subpage data write
> >>
> >> =3D=3D=3D Changelog =3D=3D=3D
> >> v2:
> >> - Rebased to latest misc-next
> >>    Now metadata write patches are removed from the series, as they are
> >>    already merged into misc-next.
> >>
> >> - Added new Reviewed-by/Tested-by/Reported-by tags
> >>
> >> - Use separate endio functions to subpage metadata write path
> >>
> >> - Re-order the patches, to make refactors at the top of the series
> >>    One refactor, the submit_extent_page() one, should benefit 4K page
> >>    size more than 64K page size, thus it's worthy to be merged early
> >>
> >> - New bug fixes exposed by Ritesh Harjani on Power
> >>
> >> - Reject RAID56 completely
> >>    Exposed by btrfs test group, which caused BUG_ON() for various site=
s.
> >>    Considering RAID56 is already not considered safe, it's better to
> >>    reject them completely for now.
> >>
> >> - Fix subpage scrub repair failure
> >>    Caused by hardcoded PAGE_SIZE
> >>
> >> - Fix free space cache inode size
> >>    Same cause as scrub repair failure
> >>
> >> v3:
> >> - Rebased to remove write path prepration patches
> >>
> >> - Properly enable btrfs defrag
> >>    Previsouly, btrfs defrag is in fact just disabled.
> >>    This makes tons of tests in btrfs/defrag to fail.
> >>
> >> - More bug fixes for rare race/crashes
> >>    * Fix relocation false alert on csum mismatch
> >>    * Fix relocation data corruption
> >>    * Fix a rare case of false ASSERT()
> >>      The fix already get merged into the prepration patches, thus no
> >>      longer in this patchset though.
> >>
> >>    Mostly reported by Ritesh from IBM.
> >>
> >> v4:
> >> - Disable subpage defrag completely
> >>    As full page defrag can race with fsstress in btrfs/062, causing
> >>    strange ordered extent bugs.
> >>    The full subpage defrag will be submitted as an indepdent patchset.
> >>
> >> Qu Wenruo (30):
> >>    btrfs: pass bytenr directly to __process_pages_contig()
> >>    btrfs: refactor the page status update into process_one_page()
> >>    btrfs: provide btrfs_page_clamp_*() helpers
> >>    btrfs: only require sector size alignment for
> >>      end_bio_extent_writepage()
> >>    btrfs: make btrfs_dirty_pages() to be subpage compatible
> >>    btrfs: make __process_pages_contig() to handle subpage
> >>      dirty/error/writeback status
> >>    btrfs: make end_bio_extent_writepage() to be subpage compatible
> >>    btrfs: make process_one_page() to handle subpage locking
> >>    btrfs: introduce helpers for subpage ordered status
> >>    btrfs: make page Ordered bit to be subpage compatible
> >>    btrfs: update locked page dirty/writeback/error bits in
> >>      __process_pages_contig
> >>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
> >>      locked by __process_pages_contig()
> >>    btrfs: make btrfs_set_range_writeback() subpage compatible
> >>    btrfs: make __extent_writepage_io() only submit dirty range for
> >>      subpage
> >>    btrfs: make btrfs_truncate_block() to be subpage compatible
> >>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
> >>    btrfs: reflink: make copy_inline_to_page() to be subpage compatible
> >>    btrfs: fix the filemap_range_has_page() call in
> >>      btrfs_punch_hole_lock_range()
> >>    btrfs: don't clear page extent mapped if we're not invalidating the
> >>      full page
> >>    btrfs: extract relocation page read and dirty part into its own
> >>      function
> >>    btrfs: make relocate_one_page() to handle subpage case
> >>    btrfs: fix wild subpage writeback which does not have ordered exten=
t.
> >>    btrfs: disable inline extent creation for subpage
> >>    btrfs: allow submit_extent_page() to do bio split for subpage
> >>    btrfs: reject raid5/6 fs for subpage
> >>    btrfs: fix a crash caused by race between prepare_pages() and
> >>      btrfs_releasepage()
> >>    btrfs: fix a use-after-free bug in writeback subpage helper
> >>    btrfs: fix a subpage false alert for relocating partial preallocate=
d
> >>      data extents
> >>    btrfs: fix a subpage relocation data corruption
> >>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
> >>
> >>   fs/btrfs/ctree.h        |   2 +-
> >>   fs/btrfs/disk-io.c      |  13 +-
> >>   fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++----------=
--
> >>   fs/btrfs/file.c         |  32 ++-
> >>   fs/btrfs/inode.c        | 147 +++++++++--
> >>   fs/btrfs/ioctl.c        |   6 +
> >>   fs/btrfs/ordered-data.c |   5 +-
> >>   fs/btrfs/reflink.c      |  14 +-
> >>   fs/btrfs/relocation.c   | 287 ++++++++++++--------
> >>   fs/btrfs/subpage.c      | 156 ++++++++++-
> >>   fs/btrfs/subpage.h      |  31 +++
> >>   fs/btrfs/super.c        |   7 -
> >>   fs/btrfs/sysfs.c        |   5 +
> >>   fs/btrfs/volumes.c      |   8 +
> >>   14 files changed, 949 insertions(+), 327 deletions(-)
> >>
> >
> > Could you please rebase your branch on 5.13-rc4? I'd rather test it on
> > top of that release...
> >
> >
> It can be rebased on david's misc-next branch without any conflicts.
> Although misc-next is only on v5.13-rc3, I don't believe there will be
> anything btrfs related out of misc-next.
>
> Is there anything special only show up in -rc4?
>

Not particularly. I just want to layer it on top of what's shipping in
Fedora Rawhide to test it there locally. Admittedly, Rawhide is still
at ad9f25d33860, which is just a bit above rc3. Nevertheless, the
patch doesn't apply right now, so it's a bit hard to test beyond the
"I compiled it locally and it doesn't break my system" level.




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
