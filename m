Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6714678D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 13:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAWMHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 07:07:09 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36895 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 07:07:08 -0500
Received: by mail-ua1-f68.google.com with SMTP id h32so913645uah.4
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 04:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IImZX9GV9tThImYHUlH0e7gLnHoLshKrtYZUS+lDsgs=;
        b=owCKg8NVgWczVm3GUET+JqRrsp+PbZN8vDSALMi/ZeFlPN8Km7/4v2Stz+FzNLAxMP
         r3mQI2ga4cNJ84zGQxrcbILO8TnlpZLsu2idHyF772t5qifEHG7G7d3oxTHnuPXrUV7S
         ggRPjQZUMCtFn7HTWi5e8qcswLEl837aWCVSG2KEF2a742uT9IwIplVxNYIkzKqHUgOj
         0g260zzPI/VrzpvlcXw6QrPRf7xso2UoRrWKDxJhhnzttktI7lYkfgErkOrJysIU+eU0
         BvUddN9kkv/FOT0Bb1NuOulFam4qk6GxWhOGkj5TajNe/HEVmLduYPwnk8GziJ+3q+C5
         ldRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IImZX9GV9tThImYHUlH0e7gLnHoLshKrtYZUS+lDsgs=;
        b=EmFlQMyrqPiJSPbg2VBbS2o/etWl+ZHDL0xHEIE437Kj8xy0ADlGxj8uhPdJwdpzj5
         2uxFCbkU7oabA+BxeFTvtZ9nDLUN3lDVffdTfBP+xhLNvypnzc3xFOiZqTH72ywjXYeZ
         sPXoBPaT8QIQp4QJJlhS0Ax36wnBcYEfoIItxAj8bPCP0Pj4W+spwunaiCn56c7azIiv
         Twang3hYljpRtj7VdjrPn5Q1s5GfMxuRrDGFf+YPvGOuFfZ8BtfWKm2a+XUBg2rDj64w
         dhvYbzW2EigXqGlZ/2SCrXgga0ITztz2J0Y3d2P9SdBOXGTumfCTm5p8bexMX/xIyZRG
         cl6Q==
X-Gm-Message-State: APjAAAU24XKv5pyK90lMxtXpYa4mnanqsM0UwfgBM80If0LLSHKIWgNP
        MuP5+U41q315OgOuxzbuWTpZHZVtgaaq1Z2BUTb0gRNpmTc=
X-Google-Smtp-Source: APXvYqwwBNrX+UH8BRpRezcyt/f+VO61CBslpo50q2PQog5rhxtd7v9Ne6mSJozR2dyOO+/ky8jh9wXqUlSIx/2IblI=
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr9571799uar.27.1579781227073;
 Thu, 23 Jan 2020 04:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20200123073759.23535-1-wqu@suse.com>
In-Reply-To: <20200123073759.23535-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Jan 2020 12:06:55 +0000
Message-ID: <CAL3q7H4ed9PtALC_xjPeaiKDDhAN1oNzgM0yd=buF_C5r+x7wA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for dev-replace
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 7:38 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> For dev-replace test cases with fsstress, like btrfs/06[45] btrfs/071,
> looped runs can lead to random failure, where scrub finds csum error.
>
> The possibility is not high, around 1/20 to 1/100, but it's causing data
> corruption.
>
> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
> check free space before marking a block group RO")
>
> [CAUSE]
> Dev-replace has two source of writes:
> - Write duplication
>   All writes to source device will also be duplicated to target device.
>
>   Content:      Latest data/meta

I find the term "latest" a bit confusing, perhaps "not yet persisted
data and metadata" is more clear.

>
> - Scrub copy
>   Dev-replace reused scrub code to iterate through existing extents, and
>   copy the verified data to target device.
>
>   Content:      Data/meta in commit root

And so here "previously persisted data and metadata".

>
> The difference in contents makes the following race possible:
>         Regular Writer          |       Dev-replace
> -----------------------------------------------------------------
>   ^                             |
>   | Preallocate one data extent |
>   | at bytenr X, len 1M         |
>   v                             |
>   ^ Commit transaction          |
>   | Now extent [X, X+1M) is in  |
>   v commit root                 |
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Dev replace start=
s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>                                 | ^
>                                 | | Scrub extent [X, X+1M)
>                                 | | Read [X, X+1M)
>                                 | | (The content are mostly garbage
>                                 | |  since it's preallocated)
>   ^                             | v
>   | Write back happens for      |
>   | extent [X, X+512K)          |
>   | New data writes to both     |
>   | source and target dev.      |
>   v                             |
>                                 | ^
>                                 | | Scrub writes back extent [X, X+1M)
>                                 | | to target device.
>                                 | | This will over write the new data in
>                                 | | [X, X+512K)
>                                 | v
>
> This race can only happen for nocow writes. Thus metadata and data cow
> writes are safe, as COW will never overwrite extents of previous trans
> (in commit root).
>
> This behavior can be confirmed by disabling all fallocate related calls
> in fsstress (*), then all related tests can pass a 2000 run loop.
>
> *: FSSTRESS_AVOID=3D"-f fallocate=3D0 -f allocsp=3D0 -f zero=3D0 -f inser=
t=3D0 \
>                    -f collapse=3D0 -f punch=3D0 -f resvsp=3D0"
>    I didn't expect resvsp ioctl will fallback to fallocate in VFS...
>
> [FIX]
> Make dev-replace to require mandatory block group RO, and wait for curren=
t
> nocow writes before calling scrub_chunk().
>
> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue repla=
ce
> when set_block_ro failed") for dev-replace path.
>
> ENOSPC for dev-replace is still much better than data corruption.

Technically if we flag the block group RO without being able to
persist that due to ENOSPC, it's still ok.
We just want to prevent nocow writes racing with scrub copying
procedure. But that's something for some other time, and this is fine
to me.

>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking=
 a block group RO")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> RFC->v1:
> - Remove the RFC tag
>   Since the cause is pinned and verified, no need for RFC.
>
> - Only wait for nocow writes for dev-replace
>   CoW writes are safe as they will never overwrite extents in commit
>   root.
>
> - Put the wait call into proper lock context
>   Previous wait happens after scrub_pause_off(), which can cause
>   deadlock where we may need to commit transaction in one of the
>   wait calls. But since we are in scrub_pause_off() environment,
>   transaction commit will wait us to continue, causing a wait-on-self
>   deadlock.
> ---
>  fs/btrfs/scrub.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 21de630b0730..5aa486cad298 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3577,17 +3577,27 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx=
,
>                  * This can easily boost the amount of SYSTEM chunks if c=
leaner
>                  * thread can't be triggered fast enough, and use up all =
space
>                  * of btrfs_super_block::sys_chunk_array
> +                *
> +                * While for dev replace, we need to try our best to mark=
 block
> +                * group RO, to prevent race between:
> +                * - Write duplication
> +                *   Contains latest data
> +                * - Scrub copy
> +                *   Contains data from commit tree
> +                *
> +                * If target block group is not marked RO, nocow writes c=
an
> +                * be overwritten by scrub copy, causing data corruption.
> +                * So for dev-replace, it's not allowed to continue if a =
block
> +                * group is not RO.
>                  */
> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> -               scrub_pause_off(fs_info);
> -
> +               ret =3D btrfs_inc_block_group_ro(cache, sctx->is_dev_repl=
ace);
>                 if (ret =3D=3D 0) {
>                         ro_set =3D 1;
> -               } else if (ret =3D=3D -ENOSPC) {
> +               } else if (ret =3D=3D -ENOSPC && !sctx->is_dev_replace) {
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
> @@ -3596,9 +3606,19 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>                         btrfs_warn(fs_info,
>                                    "failed setting block group ro: %d", r=
et);
>                         btrfs_put_block_group(cache);
> +                       scrub_pause_off(fs_info);
>                         break;
>                 }
>
> +               /*
> +                * Now the target block is marked RO, wait for nocow writ=
es to
> +                * finish before dev-replace.
> +                * COW is fine, as COW never overwrites extents in commit=
 tree.
> +                */
> +               if (sctx->is_dev_replace)
> +                       btrfs_wait_nocow_writers(cache);

So this only waits for nocow ordered extents to be created - it
doesn't wait for them to complete.
After that you still need to call:

btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);

Other than that, looks good to me.

Thanks.

> +
> +               scrub_pause_off(fs_info);
>                 down_write(&dev_replace->rwsem);
>                 dev_replace->cursor_right =3D found_key.offset + length;
>                 dev_replace->cursor_left =3D found_key.offset;
> --
> 2.25.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
