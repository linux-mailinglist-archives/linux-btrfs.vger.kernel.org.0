Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3AB147A5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 10:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgAXJZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 04:25:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44146 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgAXJZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:04 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so778399vsj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/V9m5hrKz9sQUUys3Z7olUTiDN/uINR5RapQUMArL6M=;
        b=IZjSa5tU6RfHmSgeaHDAcZLjkUBhoFT39Jm2HbmjpLt2IYYdim7OsRiksm0e4lRxOj
         RDKkRqbKD/zZmh9MoMW7QKYKyk+v8aFoDpQNUaB1B9+u0dmjhSFUdRBGLCHkBvgqvJHK
         SfhgQSrALrNTmQw+4039kgi2ypyoTYUG7RsjfGYSexXgaVtck2R+QP/k02bpKYPxmimJ
         hXwYY3L3/A6wmg8cYhchBaYvsXeXmit++LvdpQ5kbsXXrjUyu6iWdCtlbNwsrhid5E5I
         qyPhVrBPRj5r/si58RkrzogpRYgs2LZQe1lx5VCZJN47oFTrUQUQT2ebUrXYjvUXHTj6
         M5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/V9m5hrKz9sQUUys3Z7olUTiDN/uINR5RapQUMArL6M=;
        b=GedyBblmkGxNUsgaQuEKG5qLAt7kWMt9rdB7GbjoREcKK4z7tSv2IAm2WY4xcFXi3r
         10Qczc3j5xRQ9foO1r1fUwaDQ1lDKjx8DovXJEQ1MH7Kq0Wf8JI7kQjTiRfBDRjwFY6D
         FHblTmquaA0r1g5tXf2Nk+5wynxj0dn3JRXnd+/phkBxt0NL3A6WiErkYtgXfoDPS1iv
         WrppUc27T3lfpc27yA4sB5hXkWF2EaN1Wp1mUCRo2aM9vg1gDpqqh5DZRtgJWuXJxqBr
         XAc5FcRRaTxpMhx30nZ/WPYYywNirnqSPOtBWvFoMo4dRLrffYHXKLvsmGH7Jh3bgYHa
         vjdw==
X-Gm-Message-State: APjAAAUk+R8bw515bpM2iHeDS6W+lgTY9gCewlVJ6780Lpltli71pKbq
        8k2tZDd4SeDVhdo0FTCJapQXhQ+WokYrKJm3Itw=
X-Google-Smtp-Source: APXvYqzpvBMnF5TUMWLcHEeEW1yG0mED29CgMW0FjuwlvL2i16sldfjQZX3u7sQxRn8c01QMBZ0tWPs6dd8kwikMEWc=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr1459297vso.14.1579857902498;
 Fri, 24 Jan 2020 01:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20200123235820.20764-1-wqu@suse.com>
In-Reply-To: <20200123235820.20764-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 24 Jan 2020 09:24:50 +0000
Message-ID: <CAL3q7H5FRdvnxG4KQhLTaaHFcP_bMUQsOxoJxfQwi8L8npGxDA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for dev-replace
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 12:07 AM Qu Wenruo <wqu@suse.com> wrote:
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
>   Content:      Not yet persisted data/meta
>
> - Scrub copy
>   Dev-replace reused scrub code to iterate through existing extents, and
>   copy the verified data to target device.
>
>   Content:      Previously persisted data and metadata
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
> The side effect is, dev-replace can be more strict on avaialble space, bu=
t
> definitely worthy to avoid data corruption.
>
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking=
 a block group RO")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good, thanks!

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
>
> v2:
> - Add btrfs_wait_ordered_roots() call before scrub_chunk().
> - Commit message change to avoid confusion.
> ---
>  fs/btrfs/scrub.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 21de630b0730..fd266a2d15ec 100644
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
> @@ -3596,9 +3606,22 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
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
> +               if (sctx->is_dev_replace) {
> +                       btrfs_wait_nocow_writers(cache);
> +                       btrfs_wait_ordered_roots(fs_info, U64_MAX, cache-=
>start,
> +                                       cache->length);
> +               }
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
