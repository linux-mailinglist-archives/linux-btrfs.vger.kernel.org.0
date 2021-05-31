Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B02F39586D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEaJuM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEaJtw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 05:49:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F0FC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 02:48:11 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g38so15788232ybi.12
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pgHYMoWSeMygYl9syKIbf3JcTa89IufxPtPAD2Xjpzw=;
        b=c8VgA6zhm+SGK1A+vafXZX+I6S3JQQMYKauJiz3Ekokq1yFme2H/u1k5tRSYLelJjc
         nZHjVZbuv8iOjD22gFx5PbTfLN/SKrAsjulGjaecM6uMXISrHVbroSWM5kuHr5nkSiGM
         TafWQeNOPo1G9l6lm5B2Zi6eshn823YUjWLjcuf9TOwDYOF6szSbcJcaU48NCTlOkcZ8
         a52hOi5OdTRXS/nNFNMJwyjzqvwjbm5108fLfdKPFDIKuWOEA2IC8+t2+DmC/L9C5zxM
         oHP+J0LmmF8IMbyeG2URfB+mlbfd848qPc/qUB4LIQ+JZc0fEFTGppZ/P0ykF/JW90E8
         IY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pgHYMoWSeMygYl9syKIbf3JcTa89IufxPtPAD2Xjpzw=;
        b=YlRWKlma8YaDRogPr8uEulWC9tkjyfROkyDwTpfYjfY3fldnAZ3nzpy+RTncNhv605
         ckKjVtn/PiDfYkgfRVWy38D7CI35msU7lx70SoZwwHKdA3RDQla+3f51D5ersxJWkRgH
         ST0eqssm0kdOnqDkHFluWVEdXPmhfeMU4DWJnmHtsBuMZwv5qDWyuiRvC1RoGA65eqDt
         5hQyi+yrBJLNf05MGyGNsaWWq6R/6g4F9oT96pxiYHcAWONVpvnzmdejGhoMPOwx7hjd
         HjyHo5TNAzBR2CAKDZ4sjsOO+wruaDGHLHUZzFf4/xJ2p5e7rlmy+ACa5JBhoYaoptXd
         t4jg==
X-Gm-Message-State: AOAM530YZ3DMjShdxhcSerG2ktQmpPygQhsD/v5OABIDqrEfu2FBH/27
        bAD1NxInu4DMhju/XA/GVqXbsjVB9VUQriv8jyE=
X-Google-Smtp-Source: ABdhPJyNU+P9oUolrmK4Blae1LTF7nzU8Z0G45nbjiEhHtVQm7wyYonYzzKYd1YHrf2EYSk8TIPVEymiK4ZXRan0Z54=
X-Received: by 2002:a25:3357:: with SMTP id z84mr30055543ybz.260.1622454490609;
 Mon, 31 May 2021 02:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210531085106.259490-1-wqu@suse.com>
In-Reply-To: <20210531085106.259490-1-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 31 May 2021 05:47:34 -0400
Message-ID: <CAEg-Je_0FrdEYKsHKb3e-kL2zehawwA9UVVmv+2wVC_+wQTC1Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 4:52 AM Qu Wenruo <wqu@suse.com> wrote:
>
> This huge patchset can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>
> =3D=3D=3D Current stage =3D=3D=3D
> The tests on x86 pass without new failure, and generic test group on
> arm64 with 64K page size passes except known failure and defrag group.
>
> For btrfs test group, all pass except compression/raid56/defrag.
>
> For anyone who is interested in testing, please apply this patch for
> btrfs-progs before testing.
> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243=
715-1-wqu@suse.com/
> Or there will be too many false alerts.
>
> =3D=3D=3D Limitation =3D=3D=3D
> There are several limitations introduced just for subpage:
> - No compressed write support
>   Read is no problem, but compression write path has more things left to
>   be modified.
>   Thus for current patchset, no matter what inode attribute or mount
>   option is, no new compressed extent can be created for subpage case.
>
> - No inline extent will be created
>   This is mostly due to the fact that filemap_fdatawrite_range() will
>   trigger more write than the range specified.
>   In fallocate calls, this behavior can make us to writeback which can
>   be inlined, before we enlarge the isize, causing inline extent being
>   created along with regular extents.
>
> - No support for RAID56
>   There are still too many hardcoded PAGE_SIZE in raid56 code.
>   Considering it's already considered unsafe due to its write-hole
>   problem, disabling RAID56 for subpage looks sane to me.
>
> - No defrag support for subpage
>   The support for subpage defrag has already an initial version
>   submitted to the mail list.
>   Thus the correct support won't be included in this patchset.
>
> =3D=3D=3D Patchset structure =3D=3D=3D
>
> Patch 01~19:    Make data write path to be subpage compatible
> Patch 20~21:    Make data relocation path to be subpage compatible
> Patch 22~29:    Various fixes for subpage corner cases
> Patch 30:       Enable subpage data write
>
> =3D=3D=3D Changelog =3D=3D=3D
> v2:
> - Rebased to latest misc-next
>   Now metadata write patches are removed from the series, as they are
>   already merged into misc-next.
>
> - Added new Reviewed-by/Tested-by/Reported-by tags
>
> - Use separate endio functions to subpage metadata write path
>
> - Re-order the patches, to make refactors at the top of the series
>   One refactor, the submit_extent_page() one, should benefit 4K page
>   size more than 64K page size, thus it's worthy to be merged early
>
> - New bug fixes exposed by Ritesh Harjani on Power
>
> - Reject RAID56 completely
>   Exposed by btrfs test group, which caused BUG_ON() for various sites.
>   Considering RAID56 is already not considered safe, it's better to
>   reject them completely for now.
>
> - Fix subpage scrub repair failure
>   Caused by hardcoded PAGE_SIZE
>
> - Fix free space cache inode size
>   Same cause as scrub repair failure
>
> v3:
> - Rebased to remove write path prepration patches
>
> - Properly enable btrfs defrag
>   Previsouly, btrfs defrag is in fact just disabled.
>   This makes tons of tests in btrfs/defrag to fail.
>
> - More bug fixes for rare race/crashes
>   * Fix relocation false alert on csum mismatch
>   * Fix relocation data corruption
>   * Fix a rare case of false ASSERT()
>     The fix already get merged into the prepration patches, thus no
>     longer in this patchset though.
>
>   Mostly reported by Ritesh from IBM.
>
> v4:
> - Disable subpage defrag completely
>   As full page defrag can race with fsstress in btrfs/062, causing
>   strange ordered extent bugs.
>   The full subpage defrag will be submitted as an indepdent patchset.
>
> Qu Wenruo (30):
>   btrfs: pass bytenr directly to __process_pages_contig()
>   btrfs: refactor the page status update into process_one_page()
>   btrfs: provide btrfs_page_clamp_*() helpers
>   btrfs: only require sector size alignment for
>     end_bio_extent_writepage()
>   btrfs: make btrfs_dirty_pages() to be subpage compatible
>   btrfs: make __process_pages_contig() to handle subpage
>     dirty/error/writeback status
>   btrfs: make end_bio_extent_writepage() to be subpage compatible
>   btrfs: make process_one_page() to handle subpage locking
>   btrfs: introduce helpers for subpage ordered status
>   btrfs: make page Ordered bit to be subpage compatible
>   btrfs: update locked page dirty/writeback/error bits in
>     __process_pages_contig
>   btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>     locked by __process_pages_contig()
>   btrfs: make btrfs_set_range_writeback() subpage compatible
>   btrfs: make __extent_writepage_io() only submit dirty range for
>     subpage
>   btrfs: make btrfs_truncate_block() to be subpage compatible
>   btrfs: make btrfs_page_mkwrite() to be subpage compatible
>   btrfs: reflink: make copy_inline_to_page() to be subpage compatible
>   btrfs: fix the filemap_range_has_page() call in
>     btrfs_punch_hole_lock_range()
>   btrfs: don't clear page extent mapped if we're not invalidating the
>     full page
>   btrfs: extract relocation page read and dirty part into its own
>     function
>   btrfs: make relocate_one_page() to handle subpage case
>   btrfs: fix wild subpage writeback which does not have ordered extent.
>   btrfs: disable inline extent creation for subpage
>   btrfs: allow submit_extent_page() to do bio split for subpage
>   btrfs: reject raid5/6 fs for subpage
>   btrfs: fix a crash caused by race between prepare_pages() and
>     btrfs_releasepage()
>   btrfs: fix a use-after-free bug in writeback subpage helper
>   btrfs: fix a subpage false alert for relocating partial preallocated
>     data extents
>   btrfs: fix a subpage relocation data corruption
>   btrfs: allow read-write for 4K sectorsize on 64K page size systems
>
>  fs/btrfs/ctree.h        |   2 +-
>  fs/btrfs/disk-io.c      |  13 +-
>  fs/btrfs/extent_io.c    | 563 ++++++++++++++++++++++++++++------------
>  fs/btrfs/file.c         |  32 ++-
>  fs/btrfs/inode.c        | 147 +++++++++--
>  fs/btrfs/ioctl.c        |   6 +
>  fs/btrfs/ordered-data.c |   5 +-
>  fs/btrfs/reflink.c      |  14 +-
>  fs/btrfs/relocation.c   | 287 ++++++++++++--------
>  fs/btrfs/subpage.c      | 156 ++++++++++-
>  fs/btrfs/subpage.h      |  31 +++
>  fs/btrfs/super.c        |   7 -
>  fs/btrfs/sysfs.c        |   5 +
>  fs/btrfs/volumes.c      |   8 +
>  14 files changed, 949 insertions(+), 327 deletions(-)
>

Could you please rebase your branch on 5.13-rc4? I'd rather test it on
top of that release...


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
