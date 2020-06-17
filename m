Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34F1FD399
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFQRgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFQRg2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 13:36:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5DC06174E;
        Wed, 17 Jun 2020 10:36:28 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q2so1894243vsr.1;
        Wed, 17 Jun 2020 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TPT+GDJxit2F3Gup1TrYywaF5gUA+sStcAMgh+3tr0k=;
        b=BaNJ2BDFnzY7zPcodGIuwuxdVYhZN9Zc6gg1GAeWYL4nNWyBAXJ+FMcCiVScw1UYsQ
         UKxmR2gLVNGGlOPDqtr2zRT0gpCfF/NVU1cbaIdpERYoiNn7bJX/+XcTOvBBqjjDdUC8
         Jn0fIpDFkmCkfic10nrxK5UtEl8/fzNbjAuLB4ybsvpX75H55EmrCgfDWiWLbaJALA4L
         y8xR53ly+zENJYVFY0DlZuyjmioNkSwPWlMvaNX1sKlkfyG9iZSiRMEmT4GGfLGUCeFE
         11OXrGievfhoEDEyyjeU9F+eKS4ogIM4qYqFR5BHIjz2PkIXxH5Z2G5z0EWwSxLlzE44
         CKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TPT+GDJxit2F3Gup1TrYywaF5gUA+sStcAMgh+3tr0k=;
        b=P1WaeUQP5E1enSX5+3xAEeiiU6wibTMv63yxh7qvzQAcvvH0cdBbCH3kK4NkoCEBc7
         5L4iOzoiMQVZ1GkGSEURXgmexM3mu2t1ZvE29K05B0tMuXn1EuZHOQ8AJDZwzSw7jX4B
         E5+hNC3C8tM4pJgVCzqsUezVuB2h+pqp8+dN1dX10gUO93j/iZxUVE0DU9WMmJ64GXkm
         cfGCNplNxYl5v0MjH5lkKZlSbObFe/5MDgylLblqXcvVxvqCVL7qhPwrkGiGwV4jAFjr
         JCuOX3c6hOjGgsI5iS6xkhS7jAnwWdbkNyycoOhfPU1Y8emxm/1RqGU4BnQ/7ykf8PS5
         yNqQ==
X-Gm-Message-State: AOAM532z8T0/W3yXMLZfb9QeU2Cjh+/0x9ZZrV+8jCEgjgZ+7Ku+MJfN
        8JJiiwX3s6EEoxfVWNf4c+5TJvLTPOAgj2+fT9w=
X-Google-Smtp-Source: ABdhPJzZsge7Nnw3TqHFIiRPe1jc8rbHe/OitqDCGocJRBGiJQsQuAHHW8bxvsHkAARdciLLun9kzTu+HIEcVZEkorc=
X-Received: by 2002:a67:1e45:: with SMTP id e66mr196168vse.95.1592415387540;
 Wed, 17 Jun 2020 10:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162746.3780660-1-boris@bur.io> <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
In-Reply-To: <CAL3q7H47P6E9zn3Zk9C2LX8-1g2QNiCGgbcRMDQDk+JBCoOhzg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Jun 2020 18:36:16 +0100
Message-ID: <CAL3q7H7-WjkgSm5Hayj9nrSRHzTPn-_m_oz=jtiDkSXJYshpCg@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 6:20 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 5:32 PM Boris Burkov <boris@bur.io> wrote:
> >
> > Under somewhat convoluted conditions, it is possible to attempt to
> > release an extent_buffer that is under io, which triggers a BUG_ON in
> > btrfs_release_extent_buffer_pages.
> >
> > This relies on a few different factors. First, extent_buffer reads done
> > as readahead for searching use WAIT_NONE, so they free the local extent
> > buffer reference while the io is outstanding. However, they should stil=
l
> > be protected by TREE_REF. However, if the system is doing signficant
> > reclaim, and simultaneously heavily accessing the extent_buffers, it is
> > possible for releasepage to race with two concurrent readahead attempts
> > in a way that leaves TREE_REF unset when the readahead extent buffer is
> > released.
> >
> > Essentially, if two tasks race to allocate a new extent_buffer, but the
> > winner who attempts the first io is rebuffed by a page being locked
> > (likely by the reclaim itself) then the loser will still go ahead with
> > issuing the readahead. The loser's call to find_extent_buffer must also
> > race with the reclaim task reading the extent_buffer's refcount as 1 in
> > a way that allows the reclaim to re-clear the TREE_REF checked by
> > find_extent_buffer.
> >
> > The following represents an example execution demonstrating the race:
> >
> >             CPU0                                                       =
  CPU1                                           CPU2
> > reada_for_search                                            reada_for_s=
earch
> >   readahead_tree_block                                        readahead=
_tree_block
> >     find_create_tree_block                                      find_cr=
eate_tree_block
> >       alloc_extent_buffer                                         alloc=
_extent_buffer
> >                                                                   find_=
extent_buffer // not found
> >                                                                   alloc=
ates eb
> >                                                                   lock =
pages
> >                                                                   assoc=
iate pages to eb
> >                                                                   inser=
t eb into radix tree
> >                                                                   set T=
REE_REF, refs =3D=3D 2
> >                                                                   unloc=
k pages
> >                                                               read_exte=
nt_buffer_pages // WAIT_NONE
> >                                                                 not upt=
odate (brand new eb)
> >                                                                        =
                                     lock_page
> >                                                                 if !try=
lock_page
> >                                                                   goto =
unlock_exit // not an error
> >                                                               free_exte=
nt_buffer
> >                                                                 release=
_extent_buffer
> >                                                                   atomi=
c_dec_and_test refs to 1
> >         find_extent_buffer // found
> >                                                                        =
                                     try_release_extent_buffer
> >                                                                        =
                                       take refs_lock
> >                                                                        =
                                       reads refs =3D=3D 1; no io
> >           atomic_inc_not_zero refs to 2
> >           mark_buffer_accessed
> >             check_buffer_tree_ref
> >               // not STALE, won't take refs_lock
> >               refs =3D=3D 2; TREE_REF set // no action
> >     read_extent_buffer_pages // WAIT_NONE
> >                                                                        =
                                       clear TREE_REF
> >                                                                        =
                                       release_extent_buffer
> >                                                                        =
                                         atomic_dec_and_test refs to 1
> >                                                                        =
                                         unlock_page
> >       still not uptodate (CPU1 read failed on trylock_page)
> >       locks pages
> >       set io_pages > 0
> >       submit io
> >       return
> >     release_extent_buffer
>
> Small detail, missing the call to free_extent_buffer() from
> readahead_tree_block(), which is what ends calling
> release_extent_buffer().
>
> >       dec refs to 0
> >       delete from radix tree
> >       btrfs_release_extent_buffer_pages
> >         BUG_ON(io_pages > 0)!!!
> >
> > We observe this at a very low rate in production and were also able to
> > reproduce it in a test environment by introducing some spurious delays
> > and by introducing probabilistic trylock_page failures.
> >
> > To fix it, we apply check_tree_ref at a point where it could not
> > possibly be unset by a competing task: after io_pages has been
> > incremented. There is no race in write_one_eb, that we know of, but for
> > consistency, apply it there too. All the codepaths that clear TREE_REF
> > check for io, so they would not be able to clear it after this point.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
>
> Btw, if you have a stack trace, it would be good to include it in the
> change log for grep-ability in case someone runs into the same
> problem.
>
> > ---
> >  fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 29 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index c59e07360083..f6758ebbb6a2 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3927,6 +3927,11 @@ static noinline_for_stack int write_one_eb(struc=
t extent_buffer *eb,
> >         clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
> >         num_pages =3D num_extent_pages(eb);
> >         atomic_set(&eb->io_pages, num_pages);
> > +       /*
> > +        * It is possible for releasepage to clear the TREE_REF bit bef=
ore we
> > +        * set io_pages. See check_buffer_tree_ref for a more detailed =
comment.
> > +        */
> > +       check_buffer_tree_ref(eb);
>
> This is a whole different case from the one described in the
> changelog, as this is in the write path.
> Why do we need this one?
>
> At this point the eb pages are marked with the dirty bit, and
> btree_releasepage() returns 0 if the page is dirty and we don't end up
> calling try_release_extent_buffer().

In addition to that, when write_one_eb() is called we have incremented
its ref count before and EXTENT_BUFFER_WRITEBACK is set on the eb,
try_release_extent_buffer() should return and never call
release_extent_buffer(), since the refcount is > 1 and
extent_buffer_under_io() returns true.

> So I don't understand why this hunk is needed, what variant of the
> problem it's trying to solve.
>
> >
> >         /* set btree blocks beyond nritems with 0 to avoid stale conten=
t. */
> >         nritems =3D btrfs_header_nritems(eb);
> > @@ -5086,25 +5091,28 @@ struct extent_buffer *alloc_dummy_extent_buffer=
(struct btrfs_fs_info *fs_info,
> >  static void check_buffer_tree_ref(struct extent_buffer *eb)
> >  {
> >         int refs;
> > -       /* the ref bit is tricky.  We have to make sure it is set
> > -        * if we have the buffer dirty.   Otherwise the
> > -        * code to free a buffer can end up dropping a dirty
> > -        * page
> > +       /*
> > +        * The TREE_REF bit is first set when the extent_buffer is adde=
d
> > +        * to the radix tree. It is also reset, if unset, when a new re=
ference
> > +        * is created by find_extent_buffer.
> >          *
> > -        * Once the ref bit is set, it won't go away while the
> > -        * buffer is dirty or in writeback, and it also won't
> > -        * go away while we have the reference count on the
> > -        * eb bumped.
> > +        * It is only cleared in two cases: freeing the last non-tree
> > +        * reference to the extent_buffer when its STALE bit is set or
> > +        * calling releasepage when the tree reference is the only refe=
rence.
> >          *
> > -        * We can't just set the ref bit without bumping the
> > -        * ref on the eb because free_extent_buffer might
> > -        * see the ref bit and try to clear it.  If this happens
> > -        * free_extent_buffer might end up dropping our original
> > -        * ref by mistake and freeing the page before we are able
> > -        * to add one more ref.
> > +        * In both cases, care is taken to ensure that the extent_buffe=
r's
> > +        * pages are not under io. However, releasepage can be concurre=
ntly
> > +        * called with creating new references, which is prone to race
> > +        * conditions between the calls to check_tree_ref in those code=
paths
> > +        * and clearing TREE_REF in try_release_extent_buffer.
> >          *
> > -        * So bump the ref count first, then set the bit.  If someone
> > -        * beat us to it, drop the ref we added.
> > +        * The actual lifetime of the extent_buffer in the radix tree i=
s
> > +        * adequately protected by the refcount, but the TREE_REF bit a=
nd
> > +        * its corresponding reference are not. To protect against this
> > +        * class of races, we call check_buffer_tree_ref from the codep=
aths
> > +        * which trigger io after they set eb->io_pages. Note that once=
 io is
> > +        * initiated, TREE_REF can no longer be cleared, so that is the
> > +        * moment at which any such race is best fixed.
> >          */
> >         refs =3D atomic_read(&eb->refs);
> >         if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags=
))
> > @@ -5555,6 +5563,11 @@ int read_extent_buffer_pages(struct extent_buffe=
r *eb, int wait, int mirror_num)
> >         clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> >         eb->read_mirror =3D 0;
> >         atomic_set(&eb->io_pages, num_reads);
> > +       /*
> > +        * It is possible for releasepage to clear the TREE_REF bit bef=
ore we
> > +        * set io_pages. See check_buffer_tree_ref for a more detailed =
comment.
> > +        */
> > +       check_buffer_tree_ref(eb);
>
> This is the hunk that fixes the problem described in the change log,
> and it looks good to me.
>
> Thanks.
>
> >         for (i =3D 0; i < num_pages; i++) {
> >                 page =3D eb->pages[i];
> >
> > --
> > 2.24.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
