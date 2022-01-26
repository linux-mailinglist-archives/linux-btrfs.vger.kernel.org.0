Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A049C90B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 12:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiAZLry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 06:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiAZLry (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 06:47:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB27CC06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 03:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6877C6190D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 11:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A81C36AE3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643197672;
        bh=2eU5+Nx1mg0yOBz0+P763P3hNueDdnXaDiPGW3AsECo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P+x+2oglXalSvCKdWmtRYW/6jrMtW4UGA8e8n1yG6QrpbcDgfzxjAnq36f6SHt/P6
         DaKv03pAoh+CI6kTUcoX4zBE4mHoFsyP8cAI8lgAsGf3hVH+JKBtHdAY3XDVmmZTzN
         Gv4I2vf8sXjIXPW6ZLfEjy/eOhu219fhDBw2hTt/SgCzYfKU4tEl78UFVNLyyq1Nv0
         V1OvFNpSGT9OiJtCJCkkORvicOkwhZW4qiOFs/OxLURjM2UHOR9zNicDY3vdWctmKV
         d4qhCwydQl5TK46+TJyCxaSDtwZb3TM1V259xaYycWoXxIS7Us+/o4e12/rObdNHqM
         3KaMaKUnRgsyA==
Received: by mail-qt1-f173.google.com with SMTP id w6so26921551qtk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 03:47:52 -0800 (PST)
X-Gm-Message-State: AOAM531qNdEHljH5RNZCzc6wNHF1FoXngfBrHm1x9MXUjzJdg7VASXVB
        PO+Rhev0u8OO/4o0/vWpbPwBjhsna+ypDtkXGdA=
X-Google-Smtp-Source: ABdhPJwpMyiZdcjEreprrvUqzhdKMoUK9tCdvaBDsMaMg9G1xuvX+Qn2GrC57Ee9p2rOylGlZxWdKCznoD9WwcqMI80=
X-Received: by 2002:ac8:58c4:: with SMTP id u4mr19764056qta.516.1643197671747;
 Wed, 26 Jan 2022 03:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20220126005850.14729-1-wqu@suse.com> <YfEv5THyUX/UoNZa@debian9.Home>
 <a4e09bf5-7919-1935-98f4-669484df4c62@gmx.com>
In-Reply-To: <a4e09bf5-7919-1935-98f4-669484df4c62@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 26 Jan 2022 11:47:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H51juQkEyhUsMiROW6Oer87eDp793wew4cJqFC5kDFmsg@mail.gmail.com>
Message-ID: <CAL3q7H51juQkEyhUsMiROW6Oer87eDp793wew4cJqFC5kDFmsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] btrfs: defrag: don't try to merge regular extents
 with preallocated extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 11:33 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/1/26 19:26, Filipe Manana wrote:
> > On Wed, Jan 26, 2022 at 08:58:48AM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> With older kernels (before v5.16), btrfs will defrag preallocated extents.
> >> While with newer kernels (v5.16 and newer) btrfs will not defrag
> >> preallocated extents, but it will defrag the extent just before the
> >> preallocated extent, even it's just a single sector.
> >
> > In that case, isn't a Fixes: tag missing?
>
> The function defrag_check_next_extent() is reused from older kernel
> code, dating back to 2012.
> (And even that 2012 commit is not really the root cause).
> Thus it's missing preallocated check from the very beginning unfortunately.
>
> Does it still make sense to include such an old commit?
>
> It would make more sense to CC this to v5.x stable branch, though.
>
> Any advice on this situation?

Hum, ok, then I think it's fine without the tag.
Thanks.

>
> Thanks,
> Qu
> >
> >>
> >> This can be exposed by the following small script:
> >>
> >>      mkfs.btrfs -f $dev > /dev/null
> >>
> >>      mount $dev $mnt
> >>      xfs_io -f -c "pwrite 0 4k" -c sync -c "falloc 4k 16K" $mnt/file
> >>      xfs_io -c "fiemap -v" $mnt/file
> >>      btrfs fi defrag $mnt/file
> >>      sync
> >>      xfs_io -c "fiemap -v" $mnt/file
> >>
> >> The output looks like this on older kernels:
> >>
> >> /mnt/btrfs/file:
> >>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>     0: [0..7]:          26624..26631         8   0x0
> >>     1: [8..39]:         26632..26663        32 0x801
> >> /mnt/btrfs/file:
> >>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>     0: [0..39]:         26664..26703        40   0x1
> >>
> >> Which defrags the single sector along with the preallocated extent, and
> >> replace them with an regular extent into a new location (caused by data
> >> COW).
> >> This wastes most of the data IO just for the preallocated range.
> >>
> >> On the other hand, v5.16 is slightly better:
> >>
> >> /mnt/btrfs/file:
> >>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>     0: [0..7]:          26624..26631         8   0x0
> >>     1: [8..39]:         26632..26663        32 0x801
> >> /mnt/btrfs/file:
> >>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>     0: [0..7]:          26664..26671         8   0x0
> >>     1: [8..39]:         26632..26663        32 0x801
> >>
> >> The preallocated range is not defragged, but the sector before it still
> >> gets defragged, which has no need for it.
> >>
> >> [CAUSE]
> >> One of the function reused by the old and new behavior is
> >> defrag_check_next_extent(), it will determine if we should defrag
> >> current extent by checking the next one.
> >>
> >> It only checks if the next extent is a hole or inlined, but it doesn't
> >> check if it's preallocated.
> >>
> >> On the other hand, out of the function, both old and new kernel will
> >> reject preallocated extents.
> >>
> >> Such inconsistent behavior causes above behavior.
> >>
> >> [FIX]
> >> - Also check if next extent is preallocated
> >>    If so, don't defrag current extent.
> >>
> >> - Add comments for each branch why we reject the extent
> >>
> >> This will reduce the IO caused by defrag ioctl and autodefrag.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Use @extent_thresh from caller to replace the harded coded threshold
> >>    Now caller has full control over the extent threshold value.
> >>
> >> - Remove the old ambiguous check based on physical address
> >>    The original check is too specific, only reject extents which are
> >>    physically adjacent, AND too large.
> >>    Since we have correct size check now, and the physically adjacent check
> >>    is not always a win.
> >>    So remove the old check completely.
> >>
> >> v3:
> >> - Split the @extent_thresh and physicall adjacent check into other
> >>    patches
> >>
> >> - Simplify the comment
> >> ---
> >>   fs/btrfs/ioctl.c | 20 +++++++++++++-------
> >>   1 file changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index 91ba2efe9792..0d8bfc716e6b 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -1053,19 +1053,25 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> >>                                   bool locked)
> >>   {
> >>      struct extent_map *next;
> >> -    bool ret = true;
> >> +    bool ret = false;
> >>
> >>      /* this is the last extent */
> >>      if (em->start + em->len >= i_size_read(inode))
> >> -            return false;
> >> +            return ret;
> >>
> >>      next = defrag_lookup_extent(inode, em->start + em->len, locked);
> >> +    /* No more em or hole */
> >>      if (!next || next->block_start >= EXTENT_MAP_LAST_BYTE)
> >> -            ret = false;
> >> -    else if ((em->block_start + em->block_len == next->block_start) &&
> >> -             (em->block_len > SZ_128K && next->block_len > SZ_128K))
> >> -            ret = false;
> >> -
> >> +            goto out;
> >> +    /* Preallocated */
> >> +    if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> >
> > The comment is superfluous, the name of the flag is pretty informative that
> > we are checking for a preallocated extent. You don't need to send a new
> > version just to remove the comment however.
> >
> > For the Fixes: tag, you can just comment and David will pick it.
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> >> +            goto out;
> >> +    /* Physically adjacent and large enough */
> >> +    if ((em->block_start + em->block_len == next->block_start) &&
> >> +        (em->block_len > SZ_128K && next->block_len > SZ_128K))
> >> +            goto out;
> >> +    ret = true;
> >> +out:
> >>      free_extent_map(next);
> >>      return ret;
> >>   }
> >> --
> >> 2.34.1
> >>
