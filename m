Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9161145219
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 11:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAVKFX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 05:05:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35759 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgAVKFX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 05:05:23 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so3819810vsc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 02:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mtYrLnbIlTJp4kjsQdGdm3/p4WoGGiH54SxZFjvXctU=;
        b=k0I7DD+3HaYa+0IyykRr3XmRKUXsasKSFFoQ5lWqAZVsNVxYJrL7IgFj6oq91eK95/
         E5/KqTyGAv7z27AmWy5JvNEFRxugxpDEC+gmOXHB/1//wdV+Dr5ssFHN/zwVsz+V8B4w
         R2Tg3BR21PPd/oiX3Xb4q/jFVY7p2uKOZiwRCd4i8pDevs2JvdwnAQ/K9g1yKkOpRQg1
         ousKBZqdfZH4S4a6OtwNT0ZUAS4v1qjru5jETD/MO2cglM3uv1LEy/SXoHqmscm95Tj3
         x1NMqlc5Ic4OCtQHpZhUi+P+vC+2udrWPFCh6mSTh632HyZ//8xU4vmM7uv9iD5GZo9L
         0U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mtYrLnbIlTJp4kjsQdGdm3/p4WoGGiH54SxZFjvXctU=;
        b=JkeAlfgAnayVQc58+lQdmKnX6c1TBFFeg4qBolRicHNJrGXd3xlikbC5bTIp868QLO
         1slbeSR+i8uCFCwKqdUWqjBUuwISlyzJrRtO/UjCycC1piegmndIizSmVbsJikGHGvGm
         2luIv0igiY/wEPhO4nhT2hCxaFQyn36t0OcV+rly4xNtDUG7Jep4mGvB0QZydg/k11L5
         o9jUABkiTJLA6zhGI+no2sFzD3R68HLOC2AgZ+mRKh/d/jF1PyTWUt/nAbtyEqK8DgjA
         G1bzHldhZNLoo9vkDcnCaNoh0HHY9ErWCpRY2YDji6lkrGu5K4AWlL+9uG+6/wEGJudl
         YU8A==
X-Gm-Message-State: APjAAAWQrOEvm1HXX6Lyy7h2rBvOYOByBAZ7NP4uSmAfauxwK8eBiiEM
        5gciicAipgB4AnOpmK6MPsaiQCydKyo2dJr3ssQ=
X-Google-Smtp-Source: APXvYqwuQZnRxLFK0mIQkfpW8wVNT/PiosXxaKRi8Dk0jEDRLn3NtPavemSlneVVjvnOBhUi0gB967rKAgcj1HOKi/o=
X-Received: by 2002:a67:af11:: with SMTP id v17mr1795960vsl.99.1579687521543;
 Wed, 22 Jan 2020 02:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20200122083628.16331-1-wqu@suse.com>
In-Reply-To: <20200122083628.16331-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 Jan 2020 10:05:10 +0000
Message-ID: <CAL3q7H7tk6JdVpjz9xne7S4JBL8DZTKp04nTrhLTHjKeSyUtqw@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: scrub: Mandatory RO block group for device replace
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 22, 2020 at 8:37 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> btrfs/06[45] btrfs/071 could fail by finding csum error.
> The reproducibility is not high, around 1/20~1/100, needs to run them in
> loops.
>
> And the profile doesn't make much difference, SINGLE/SINGLE can also
> reproduce the problem.
>
> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
> check free space before marking a block group RO")
>
> [CAUSE]
> Device replace reuses scrub code to iterate existing extents.
>
> It adds scrub_write_block_to_dev_replace() to scrub_block_complete(), so
> that scrub read can write the verified data to target device.
>
> Device replace also utilizes "write duplication" to write new data to
> both source and target device.
>
> However those two write can conflict and may lead to data corruption:
> - Scrub writes old data from commit root
>   Both extent location and csum are fetched from commit root, which
>   is not always the up-to-date data.
>
> - Write duplication is always duplicating latest data
>
> This means there could be a race, that "write duplication" writes the
> latest data to disk, then scrub write back the old data, causing data
> corruption.

Worth mentioning this is for nocow writes only then.
Given that the test cases that fail use fsstress and don't use nocow
files or -o nodatacow, the only possible case is writes into prealloc
extents.
Write duplication writes the new data and then extent iteration writes
zeroes (or whatever is on disk) after that.

>
> In theory, this should only affects data, not metadata.
> Metadata write back only happens when committing transaction, thus it's
> always after scrub writes.

No, not only when committing transaction.
It can happen under memory pressure, tree extents can be written
before. In fact, if you remember the 5.2 corruption and deadlock, the
deadlock case happened precisely when writeback of the btree inode was
triggered before a transaction commit.

>
> [FIX]
> Make dev-replace to require mandatory RO for target block group.
>
> And to be extra safe, for dev-replace, wait for all exiting writes to
> finish before scrubbing the chunk.
>
> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue repla=
ce
> when set_block_ro failed").
> ENOSPC for dev-replace is still much better than data corruption.
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking=
 a block group RO")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Not concretely confirmed, mostly through guess, thus it has RFC tag.

Well, it's better to confirm...
IIRC, correctly, dev-replace does not skip copies for prealloc
extents, it copies what is on disk.
If that's the case, then this is correct. However if it's smart and
skips copying prealloc extents (which is pointless), then the problem
must have other technical explanation.

>
> My first guess is race at the dev-replace starting point, but related
> code is in fact very safe.
> ---
>  fs/btrfs/scrub.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 21de630b0730..69e76a4d1258 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3472,6 +3472,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>         struct btrfs_path *path;
>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>         struct btrfs_root *root =3D fs_info->dev_root;
> +       bool is_dev_replace =3D sctx->is_dev_replace;

Not needed, just use sctx->is_dev_replace like everywhere else.

Thanks.

>         u64 length;
>         u64 chunk_offset;
>         int ret =3D 0;
> @@ -3577,17 +3578,35 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>                  * This can easily boost the amount of SYSTEM chunks if c=
leaner
>                  * thread can't be triggered fast enough, and use up all =
space
>                  * of btrfs_super_block::sys_chunk_array
> +                *
> +                *
> +                * On the other hand, try our best to mark block group RO=
 for
> +                * dev-replace case.
> +                *
> +                * Dev-replace has two types of write:
> +                * - Write duplication
> +                *   New write will be written to both target and source =
device
> +                *   The content is always the *newest* data.
> +                * - Scrub write for dev-replace
> +                *   Scrub will write the verified data for dev-replace.
> +                *   The data and its csum are all from *commit* root, wh=
ich
> +                *   is not the newest version.
> +                *
> +                * If scrub write happens after write duplication, we wou=
ld
> +                * cause data corruption.
> +                * So we need to try our best to mark block group RO, and=
 exit
> +                * out if we don't have enough space.
>                  */
> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> +               ret =3D btrfs_inc_block_group_ro(cache, is_dev_replace);
>                 scrub_pause_off(fs_info);
>
>                 if (ret =3D=3D 0) {
>                         ro_set =3D 1;
> -               } else if (ret =3D=3D -ENOSPC) {
> +               } else if (ret =3D=3D -ENOSPC && !is_dev_replace) {
>                         /*
>                          * btrfs_inc_block_group_ro return -ENOSPC when i=
t
>                          * failed in creating new chunk for metadata.
> -                        * It is not a problem for scrub/replace, because
> +                        * It is not a problem for scrub, because
>                          * metadata are always cowed, and our scrub pause=
d
>                          * commit_transactions.
>                          */
> @@ -3605,6 +3624,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>                 dev_replace->item_needs_writeback =3D 1;
>                 up_write(&dev_replace->rwsem);
>
> +               /*
> +                * Also wait for any exitings writes to prevent race betw=
een
> +                * write duplication and scrub writes.
> +                */
> +               if (is_dev_replace) {
> +                       btrfs_wait_block_group_reservations(cache);
> +                       btrfs_wait_nocow_writers(cache);
> +                       btrfs_wait_ordered_roots(fs_info, U64_MAX,
> +                                       cache->start, cache->length);
> +               }
>                 ret =3D scrub_chunk(sctx, scrub_dev, chunk_offset, length=
,
>                                   found_key.offset, cache);
>
> --
> 2.25.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
