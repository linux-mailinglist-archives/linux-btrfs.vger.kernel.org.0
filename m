Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2B1FD356
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 19:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFQRVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQRVC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 13:21:02 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC21C061755;
        Wed, 17 Jun 2020 10:21:02 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d5so748977vkb.12;
        Wed, 17 Jun 2020 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h4+kQBpcsw7AL0bB0KTWEGS4omPeS4od+scoObArtv4=;
        b=vCMeek6pX8ft+4TPLuouef677C9IkED3okJfBDTsTF3mXlOo3gUQDSRmECG3rXUsZB
         HbgH3gQcipcJ7YnpuwlucOaUGWP//vzqvvhLVyUZzHFbz0/lnpJGPW93xrMBYa77EU4x
         AmoITbxLw+lP0qB6b93FriUgEEQQYXKfPtOfxv9yPqY1nDuesbC2hAGH3Uqth2tL2Aky
         CQ/HZzZuJJbeE8IzM1lA6aqY7YmevxLKAzCXz3P9Ona/mT8iECbTB8jlypOYjAU4UpKv
         Go0EKB0mfY8srPwTgkPwEtKZo1XqVF23JZAl3JhLMEn43LmiqRO7oFyaGRVbz8Zzdndg
         8kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=h4+kQBpcsw7AL0bB0KTWEGS4omPeS4od+scoObArtv4=;
        b=I8eugcgs4wVf8yKa609+pGj0wqAEV5k5EBbIEn6SZMkDpEp7uOgaloyNokvsLKZYWb
         jJYQFLpjVbrk3Ajudaf2NB2w+7t10I6YzQnqY2QuqZepkf2qiambjxdQb+eoy28T3ozS
         GXRA9RO8sQ+2p3balXE+UP3uBpKRs2+1+AlJJY1kwbyOufjgb5In3GDXmnQZrMn9uHS3
         wO+vO2KbB/e9DIdfKpWCcpdmqUikNitxpziIMSAVrZwfGcSrXAyNFjx9y1rBOIAlr73U
         mRyv9Rz9zgPJcUZQgsL+FUvQr2TW/88TNA2WdX+IMD6egcOceVyPVbKhz8PksOuTozZ8
         n6Fw==
X-Gm-Message-State: AOAM533YyNm2VTINRxScr+D9edTm0VXA8QNrmcefwToN/NucyrQQdwyx
        UZZn7UDCkHjSSBNNltOcIT6VHKTVw1lWHIT4SRHbu/UO
X-Google-Smtp-Source: ABdhPJyvWQn1qHMUj3921o1IlM3jAx+R+tQE1S9ifDLIpYEE1AZJzTawc1EEGAr7F2AazEGxLkPITIyZjbdFGBgZvSw=
X-Received: by 2002:a1f:e8c4:: with SMTP id f187mr419884vkh.24.1592414459859;
 Wed, 17 Jun 2020 10:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162746.3780660-1-boris@bur.io>
In-Reply-To: <20200617162746.3780660-1-boris@bur.io>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Jun 2020 18:20:48 +0100
Message-ID: <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
Subject: Re: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead
 vs releasepage race
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

On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
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
>     release_extent_buffer

Small detail, missing the call to free_extent_buffer() from
readahead_tree_block(), which is what ends calling
release_extent_buffer().

>       dec refs to 0
>       delete from radix tree
>       btrfs_release_extent_buffer_pages
>         BUG_ON(io_pages > 0)!!!
>
> We observe this at a very low rate in production and were also able to
> reproduce it in a test environment by introducing some spurious delays
> and by introducing probabilistic trylock_page failures.
>
> To fix it, we apply check_tree_ref at a point where it could not
> possibly be unset by a competing task: after io_pages has been
> incremented. There is no race in write_one_eb, that we know of, but for
> consistency, apply it there too. All the codepaths that clear TREE_REF
> check for io, so they would not be able to clear it after this point.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Btw, if you have a stack trace, it would be good to include it in the
change log for grep-ability in case someone runs into the same
problem.

> ---
>  fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c59e07360083..f6758ebbb6a2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3927,6 +3927,11 @@ static noinline_for_stack int write_one_eb(struct =
extent_buffer *eb,
>         clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
>         num_pages =3D num_extent_pages(eb);
>         atomic_set(&eb->io_pages, num_pages);
> +       /*
> +        * It is possible for releasepage to clear the TREE_REF bit befor=
e we
> +        * set io_pages. See check_buffer_tree_ref for a more detailed co=
mment.
> +        */
> +       check_buffer_tree_ref(eb);

This is a whole different case from the one described in the
changelog, as this is in the write path.
Why do we need this one?

At this point the eb pages are marked with the dirty bit, and
btree_releasepage() returns 0 if the page is dirty and we don't end up
calling try_release_extent_buffer().
So I don't understand why this hunk is needed, what variant of the
problem it's trying to solve.

>
>         /* set btree blocks beyond nritems with 0 to avoid stale content.=
 */
>         nritems =3D btrfs_header_nritems(eb);
> @@ -5086,25 +5091,28 @@ struct extent_buffer *alloc_dummy_extent_buffer(s=
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
> +        * conditions between the calls to check_tree_ref in those codepa=
ths
> +        * and clearing TREE_REF in try_release_extent_buffer.
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
> @@ -5555,6 +5563,11 @@ int read_extent_buffer_pages(struct extent_buffer =
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

This is the hunk that fixes the problem described in the change log,
and it looks good to me.

Thanks.

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
