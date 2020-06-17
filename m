Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690011FD4DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFQSvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQSvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:51:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2802BC06174E;
        Wed, 17 Jun 2020 11:51:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y123so2023480vsb.6;
        Wed, 17 Jun 2020 11:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mavERrOSDaw4tPiOCGQPm94xf6hNb/oVu98aYfWA5Oo=;
        b=JbRj5EdG3rA0pkfVHzC/IB1bgldr9OnFNEOUsXR0g4j6C/DTSsLY0nF8ELq5m+xkH5
         DesjB8hfTjn7PYcC79iH3qNTSwSMoLSTyXJFRUY6KrFQw3zoqzAgkrPp8mFjP+Kd0QIx
         1aqs8lm+d3g+2gkcO0+9i4yzcVDjhgdc0ttcJuirtuO1J7tkgpM2R84GgtcuuRWg7OHB
         AQnBo6ElCVKA5lZ44vJavt80IRyMeeF7QCiFfLvhkMYsqCqbMMN5YJcg0Tioj8w5gKeH
         uBsWl3zRQuKDAQBFaOFbGMLnjI4oEnk2iyy/KVhx2qbOYyoCkhkGH4rsV47gi/RIIEfe
         fd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mavERrOSDaw4tPiOCGQPm94xf6hNb/oVu98aYfWA5Oo=;
        b=RGrIZDNPWHpfIpNU9gmTz3vRbM3XEzG0E7HWI527LUfDxQ8TZaONl4h3EbvZthmuVb
         4lOoTcjiVvIoDhuEhh8g2PholLg4mggvBznCahQsZjzeOCojXCeLY8i1EtedFsDG9Xwd
         lrrUftl1WW549GLZDYPoStS/+ZSUmOLUKYTyMATdVEehpBbWNn45N2rKCU4OwA7SnTG8
         3kA+Q64yuijubp991IBGGxxwlceaffERavDKrKOV+YKZLz5iXRHmN1t5mzEsYlLQvUrQ
         bc4mCOAgu1mt1n2W9xbv86Q9J+N+TjAL+AvF/yU/4xdz4LIitSHYlAipqUCWCHjyo67w
         lS7Q==
X-Gm-Message-State: AOAM530m7cimziJkuZYWxA621R9OuitF6cAPVWUxhNooGK29196afQrr
        6fcudzy8qoVRTqftjL/4YgIsXsKJi33Oq3tCpRE=
X-Google-Smtp-Source: ABdhPJy1YryHnsit7+l94G1+6sFwupFqU1owBYsJ2SPH4tDXHrbrzPiXAuO1ObXvg+JXfR78qFylpcNE8eMTfOYiHh4=
X-Received: by 2002:a67:2dc1:: with SMTP id t184mr513971vst.90.1592419895215;
 Wed, 17 Jun 2020 11:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4GqjcesWir69PULr4a9rSi2cVQ366y5bAEU23wS6xJkA@mail.gmail.com>
 <20200617183519.152946-1-boris@bur.io>
In-Reply-To: <20200617183519.152946-1-boris@bur.io>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Jun 2020 19:51:22 +0100
Message-ID: <CAL3q7H4qXbT297gRZSzR5JwCOXspgEebwNv8JXE_d+07FOampg@mail.gmail.com>
Subject: Re: [PATCH v2 btrfs/for-next] btrfs: fix fatal extent_buffer
 readahead vs releasepage race
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 7:39 PM Boris Burkov <boris@bur.io> wrote:
>
> Under somewhat convoluted conditions, it is possible to attempt to
> release an extent_buffer that is under io, which triggers a BUG_ON in
> btrfs_release_extent_buffer_pages.
>
> This relies on a few different factors. First, extent_buffer reads done
> as readahead for searching use WAIT_NONE, so they free the local extent
> buffer reference while the io is outstanding. However, they should still
> be protected by TREE_REF. However, if the system is doing signficant
> reclaim, and simultaneously heavily accessing the extent_buffers, it is
> possible for releasepage to race with two concurrent readahead attempts
> in a way that leaves TREE_REF unset when the readahead extent buffer is
> released.
>
> Essentially, if two tasks race to allocate a new extent_buffer, but the
> winner who attempts the first io is rebuffed by a page being locked
> (likely by the reclaim itself) then the loser will still go ahead with
> issuing the readahead. The loser's call to find_extent_buffer must also
> race with the reclaim task reading the extent_buffer's refcount as 1 in
> a way that allows the reclaim to re-clear the TREE_REF checked by
> find_extent_buffer.
>
> The following represents an example execution demonstrating the race:
>
>             CPU0                                                         =
CPU1                                           CPU2
> reada_for_search                                            reada_for_sea=
rch
>   readahead_tree_block                                        readahead_t=
ree_block
>     find_create_tree_block                                      find_crea=
te_tree_block
>       alloc_extent_buffer                                         alloc_e=
xtent_buffer
>                                                                   find_ex=
tent_buffer // not found
>                                                                   allocat=
es eb
>                                                                   lock pa=
ges
>                                                                   associa=
te pages to eb
>                                                                   insert =
eb into radix tree
>                                                                   set TRE=
E_REF, refs =3D=3D 2
>                                                                   unlock =
pages
>                                                               read_extent=
_buffer_pages // WAIT_NONE
>                                                                 not uptod=
ate (brand new eb)
>                                                                          =
                                   lock_page
>                                                                 if !trylo=
ck_page
>                                                                   goto un=
lock_exit // not an error
>                                                               free_extent=
_buffer
>                                                                 release_e=
xtent_buffer
>                                                                   atomic_=
dec_and_test refs to 1
>         find_extent_buffer // found
>                                                                          =
                                   try_release_extent_buffer
>                                                                          =
                                     take refs_lock
>                                                                          =
                                     reads refs =3D=3D 1; no io
>           atomic_inc_not_zero refs to 2
>           mark_buffer_accessed
>             check_buffer_tree_ref
>               // not STALE, won't take refs_lock
>               refs =3D=3D 2; TREE_REF set // no action
>     read_extent_buffer_pages // WAIT_NONE
>                                                                          =
                                     clear TREE_REF
>                                                                          =
                                     release_extent_buffer
>                                                                          =
                                       atomic_dec_and_test refs to 1
>                                                                          =
                                       unlock_page
>       still not uptodate (CPU1 read failed on trylock_page)
>       locks pages
>       set io_pages > 0
>       submit io
>       return
>     free_extent_buffer
>       release_extent_buffer
>         dec refs to 0
>         delete from radix tree
>         btrfs_release_extent_buffer_pages
>           BUG_ON(io_pages > 0)!!!
>
> We observe this at a very low rate in production and were also able to
> reproduce it in a test environment by introducing some spurious delays
> and by introducing probabilistic trylock_page failures.
>
> To fix it, we apply check_tree_ref at a point where it could not
> possibly be unset by a competing task: after io_pages has been
> incremented. All the codepaths that clear TREE_REF check for io, so they
> would not be able to clear it after this point until the io is done.
>
> stack trace, for reference:
> [1417839.424739] ------------[ cut here ]------------
> [1417839.435328] kernel BUG at fs/btrfs/extent_io.c:4841!
> [1417839.447024] invalid opcode: 0000 [#1] SMP
> [1417839.502972] RIP: 0010:btrfs_release_extent_buffer_pages+0x20/0x1f0
> [1417839.517008] Code: ed e9 ...
> [1417839.558895] RSP: 0018:ffffc90020bcf798 EFLAGS: 00010202
> [1417839.570816] RAX: 0000000000000002 RBX: ffff888102d6def0 RCX:
> 0000000000000028
> [1417839.586962] RDX: 0000000000000002 RSI: ffff8887f0296482 RDI:
> ffff888102d6def0
> [1417839.603108] RBP: ffff88885664a000 R08: 0000000000000046 R09:
> 0000000000000238
> [1417839.619255] R10: 0000000000000028 R11: ffff88885664af68 R12:
> 0000000000000000
> [1417839.635402] R13: 0000000000000000 R14: ffff88875f573ad0 R15:
> ffff888797aafd90
> [1417839.651549] FS:  00007f5a844fa700(0000) GS:ffff88885f680000(0000)
> knlGS:0000000000000000
> [1417839.669810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1417839.682887] CR2: 00007f7884541fe0 CR3: 000000049f609002 CR4:
> 00000000003606e0
> [1417839.699037] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [1417839.715187] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [1417839.731320] Call Trace:
> [1417839.737103]  release_extent_buffer+0x39/0x90
> [1417839.746913]  read_block_for_search.isra.38+0x2a3/0x370
> [1417839.758645]  btrfs_search_slot+0x260/0x9b0
> [1417839.768054]  btrfs_lookup_file_extent+0x4a/0x70
> [1417839.778427]  btrfs_get_extent+0x15f/0x830
> [1417839.787665]  ? submit_extent_page+0xc4/0x1c0
> [1417839.797474]  ? __do_readpage+0x299/0x7a0
> [1417839.806515]  __do_readpage+0x33b/0x7a0
> [1417839.815171]  ? btrfs_releasepage+0x70/0x70
> [1417839.824597]  extent_readpages+0x28f/0x400
> [1417839.833836]  read_pages+0x6a/0x1c0
> [1417839.841729]  ? startup_64+0x2/0x30
> [1417839.849624]  __do_page_cache_readahead+0x13c/0x1a0
> [1417839.860590]  filemap_fault+0x6c7/0x990
> [1417839.869252]  ? xas_load+0x8/0x80
> [1417839.876756]  ? xas_find+0x150/0x190
> [1417839.884839]  ? filemap_map_pages+0x295/0x3b0
> [1417839.894652]  __do_fault+0x32/0x110
> [1417839.902540]  __handle_mm_fault+0xacd/0x1000
> [1417839.912156]  handle_mm_fault+0xaa/0x1c0
> [1417839.921004]  __do_page_fault+0x242/0x4b0
> [1417839.930044]  ? page_fault+0x8/0x30
> [1417839.937933]  page_fault+0x1e/0x30
> [1417839.945631] RIP: 0033:0x33c4bae
> [1417839.952927] Code: Bad RIP value.
> [1417839.960411] RSP: 002b:00007f5a844f7350 EFLAGS: 00010206
> [1417839.972331] RAX: 000000000000006e RBX: 1614b3ff6a50398a RCX:
> 0000000000000000
> [1417839.988477] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000002
> [1417840.004626] RBP: 00007f5a844f7420 R08: 000000000000006e R09:
> 00007f5a94aeccb8
> [1417840.020784] R10: 00007f5a844f7350 R11: 0000000000000000 R12:
> 00007f5a94aecc79
> [1417840.036932] R13: 00007f5a94aecc78 R14: 00007f5a94aecc90 R15:
> 00007f5a94aecc40
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks!

> ---
>  fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c59e07360083..95313bb7fe40 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5086,25 +5086,28 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>  static void check_buffer_tree_ref(struct extent_buffer *eb)
>  {
>         int refs;
> -       /* the ref bit is tricky.  We have to make sure it is set
> -        * if we have the buffer dirty.   Otherwise the
> -        * code to free a buffer can end up dropping a dirty
> -        * page
> +       /*
> +        * The TREE_REF bit is first set when the extent_buffer is added
> +        * to the radix tree. It is also reset, if unset, when a new refe=
rence
> +        * is created by find_extent_buffer.
>          *
> -        * Once the ref bit is set, it won't go away while the
> -        * buffer is dirty or in writeback, and it also won't
> -        * go away while we have the reference count on the
> -        * eb bumped.
> +        * It is only cleared in two cases: freeing the last non-tree
> +        * reference to the extent_buffer when its STALE bit is set or
> +        * calling releasepage when the tree reference is the only refere=
nce.
>          *
> -        * We can't just set the ref bit without bumping the
> -        * ref on the eb because free_extent_buffer might
> -        * see the ref bit and try to clear it.  If this happens
> -        * free_extent_buffer might end up dropping our original
> -        * ref by mistake and freeing the page before we are able
> -        * to add one more ref.
> +        * In both cases, care is taken to ensure that the extent_buffer'=
s
> +        * pages are not under io. However, releasepage can be concurrent=
ly
> +        * called with creating new references, which is prone to race
> +        * conditions between the calls to check_buffer_tree_ref in those
> +        * codepaths and clearing TREE_REF in try_release_extent_buffer.
>          *
> -        * So bump the ref count first, then set the bit.  If someone
> -        * beat us to it, drop the ref we added.
> +        * The actual lifetime of the extent_buffer in the radix tree is
> +        * adequately protected by the refcount, but the TREE_REF bit and
> +        * its corresponding reference are not. To protect against this
> +        * class of races, we call check_buffer_tree_ref from the codepat=
hs
> +        * which trigger io after they set eb->io_pages. Note that once i=
o is
> +        * initiated, TREE_REF can no longer be cleared, so that is the
> +        * moment at which any such race is best fixed.
>          */
>         refs =3D atomic_read(&eb->refs);
>         if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> @@ -5555,6 +5558,11 @@ int read_extent_buffer_pages(struct extent_buffer =
*eb, int wait, int mirror_num)
>         clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
>         eb->read_mirror =3D 0;
>         atomic_set(&eb->io_pages, num_reads);
> +       /*
> +        * It is possible for releasepage to clear the TREE_REF bit befor=
e we
> +        * set io_pages. See check_buffer_tree_ref for a more detailed co=
mment.
> +        */
> +       check_buffer_tree_ref(eb);
>         for (i =3D 0; i < num_pages; i++) {
>                 page =3D eb->pages[i];
>
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
