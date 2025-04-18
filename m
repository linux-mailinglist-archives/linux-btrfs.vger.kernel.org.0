Return-Path: <linux-btrfs+bounces-13160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BDAA936FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E71D7B39DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B51F27465F;
	Fri, 18 Apr 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aGc6Whf9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C302222D9
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979098; cv=none; b=QuvxMKLCbY4uFE1FsynRXjj7z8OQjbRZIdmJ1ukJHyHM21r60okmuwGKwH13fPn7hqwQ4OuauupuMV2a04xwvBhXtc70gXSsllf+S00xeAL2qvDJBFb2fZMXVSHVvSvbsUU7TPD3WpyCxsh7HlkRxwCiobWIcbuqJTuekB35SgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979098; c=relaxed/simple;
	bh=DdOekyoGFkYs89bzCCUhsWCUN4jH25HresJ2UkFL6ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6w05W0pqDI6cZEajKQjQH/rm0LCkD4ZgnInOM9MzBXg/P5dcEC0kDE1V6e+0m3aP7dSUW/dmfInB3Ns7qjDJ7jeZx3KsGDG5i0bSaFMson0U+gC66BKzgQWwbifdLV97x/D9MzI2UXt9f5L+tnsO336ksJOBoegcOlU3ohAZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aGc6Whf9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso2923033a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744979094; x=1745583894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm5UXiv8HZb9XcRPtuLJJBEzLiJM3+GgQkp/GaPnzWM=;
        b=aGc6Whf96ojzFSCLOjibeaS1BbppGskxySy7YRT67ZzkwaUd15yGOHhyJAODgvWCLP
         zhT0CP8saIFc8YEvVtK97v/UoLqaL8DbnaE8yINo5a0QL75B58BGpD+dkkokvFuyBQy6
         S86ANIdeTEfvmNWMexMP18/a84EvYS9+aElOgnXbylxOrSg0+6Iy1J3r1u2LMEbvJy7S
         +fa8RUC90t7AzGXgvPWO65RvSx5aMEi09Ep6WufyV8QrW9FfrzRNUUgioqjusKfR/qYe
         6OqGSR8trjMru2eARYSlyxPcA94RFlZRmsiIOJsGuuaO7i+Xv5vh2SxxHXmHxZ7ZFoEW
         4ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744979094; x=1745583894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm5UXiv8HZb9XcRPtuLJJBEzLiJM3+GgQkp/GaPnzWM=;
        b=S6gqWPvfrUumP4eCnlRNg0wNUWi/Y/xeXM8VEZ1mn+IAcMhcFoQ/2G9vr3zP6yzapc
         iAuMudK8FAsGKENhykzUeKNQERvqT7fO+1UbnwDAFFFryiZFuy4QZicNueYcjI3/Ty0o
         Lfd3VqR75Txk0eUGDD+a2wRBaOucjWSmXghacqQmd3EpzIUA/Fib2QFHWsNTVmvzOE5f
         NkrhJeGfGVRakGlmHDvgvaCswi652zby45KqTgt6X+TsjDBHOk80+4yNdLCtOuOjZeKp
         YQFXA0qi2UNdcDxO5y5W508dCsy/VWr6NMWQGDlKFsDe7M6UCqkmmG99eL3+pu7QZ+lH
         wU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUblpK7dQDtz2chK9vrkaVTLAZsB5XpIXeOIqQQc5J53UoNd5zGsAMaol1i/CxaStIfW+kmZsuR4hO5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzibW0PC4K/1855LhAuO4J2+UuV3GWyaw4rKrIMGmvlKX1eGhBq
	6nGJLwGI1Z8SPSRs4uW6HCdoLfZzEMX96QE0nnZ3eKSO9IteVBr4E9SF1RePetgjN1SDmkvK8sd
	VRdwrPqFBPSXoNHZUcn6rgt/AiX65FjbbdMz3pQ==
X-Gm-Gg: ASbGncsfUa8hUBMfl1RDsNMn/y2Jg4Ujw5mMI/ynS5bqc/6sB5EAHFVr1ODLiSnv5aZ
	G9ZWddA6jJfWObtaRzYkMG6JxqskR3Hb3XYJQud/ORFmO01n/wpB70lft4EU77Jeb4EB7HyAmv9
	xqNHU34kH2BCtxVtR7t4E4
X-Google-Smtp-Source: AGHT+IG4yLPR/qM5/9LRIukilksN38QirqTBJxX6NdJHWL1ki67VtZFzGz1dLAB06TGouOfVEX/826AsXBr49WFWhdc=
X-Received: by 2002:a17:906:c108:b0:ac1:f003:be08 with SMTP id
 a640c23a62f3a-acb74af287emr206631066b.12.1744979094426; Fri, 18 Apr 2025
 05:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5a3cbb2f51851dc55ff51647a214f912d6d5043.1744931654.git.boris@bur.io>
 <CAPjX3Fc9YAmfKGdNrQK=Zsv6NVERUnK9Fxg=7Z4vCBrimEjyVg@mail.gmail.com> <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>
In-Reply-To: <CAL3q7H7JAeT3C_+SULVRdZA6XsnHpoZD_je6dEKzj+K53KVgWg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 18 Apr 2025 14:24:43 +0200
X-Gm-Features: ATxdqUEaA54XQvXaHCIh1w9OrClxrFf34CHU7iehDFR2hUFf3ckMg7urkBnpwUE
Message-ID: <CAPjX3FcO5uy+H1tvB0bQFydV4tUQNJxqompiP-K8XUZ=_uu+cQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix broken drop_caches on extent_buffer folios
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 at 12:50, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Fri, Apr 18, 2025 at 10:24=E2=80=AFAM Daniel Vacek <neelx@suse.com> wr=
ote:
> >
> > On Fri, 18 Apr 2025 at 01:15, Boris Burkov <boris@bur.io> wrote:
> > >
> > > The (correct) commit
> > > e41c81d0d30e ("mm/truncate: Replace page_mapped() call in invalidate_=
inode_page()")
> > > replaced the page_mapped(page) check with a refcount check. However,
> > > this refcount check does not work as expected with drop_caches for
> > > btrfs's metadata pages.
> > >
> > > Btrfs has a per-sb metadata inode with cached pages, and when not in
> > > active use by btrfs, they have a refcount of 3. One from the initial
> > > call to alloc_pages, one (nr_pages =3D=3D 1) from filemap_add_folio, =
and one
> > > from folio_attach_private. We would expect such pages to get dropped =
by
> > > drop_caches. However, drop_caches calls into mapping_evict_folio via
> > > mapping_try_invalidate which gets a reference on the folio with
> > > find_lock_entries(). As a result, these pages have a refcount of 4, a=
nd
> > > fail this check.
> > >
> > > For what it's worth, such pages do get reclaimed under memory pressur=
e,
> > > so I would say that while this behavior is surprising, it is not real=
ly
> > > dangerously broken.
> > >
> > > When I asked the mm folks about the expected refcount in this case, I
> > > was told that the correct thing to do is to donate the refcount from =
the
> > > original allocation to the page cache after inserting it.
> > > https://lore.kernel.org/linux-mm/ZrwhTXKzgDnCK76Z@casper.infradead.or=
g/
> > >
> > > Therefore, attempt to fix this by adding a put_folio() to the critica=
l
> > > spot in alloc_extent_buffer where we are sure that we have really
> > > allocated and attached new pages. We must also adjust
> > > folio_detach_private to properly handle being the last reference to t=
he
> > > folio and not do a UAF after folio_detach_private().
> > >
> > > Finally, extent_buffers allocated by clone_extent_buffer() and
> > > alloc_dummy_extent_buffer() are unmapped, so this transfer of ownersh=
ip
> > > from allocation to insertion in the mapping does not apply to them.
> > > Therefore, they still need a folio_put() as before.
> > >
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > > Changelog:
> > > v2:
> > > * Used Filipe's suggestion to simplify detach_extent_buffer_folio and
> > >   lose the extra folio_get()/folio_put() pair
> > > * Noticed a memory leak causing failures in fstests on smaller vms.
> > >   Fixed a bug where I was missing a folio_put() for ebs that never go=
t
> > >   their folios added to the mapping.
> > >
> > >  fs/btrfs/extent_io.c | 28 ++++++++++++++++++++--------
> > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index 5f08615b334f..90499124b8a5 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -2752,6 +2752,7 @@ static bool folio_range_has_eb(struct folio *fo=
lio)
> > >  static void detach_extent_buffer_folio(const struct extent_buffer *e=
b, struct folio *folio)
> > >  {
> > >         struct btrfs_fs_info *fs_info =3D eb->fs_info;
> > > +       struct address_space *mapping =3D folio->mapping;
> > >         const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->=
bflags);
> > >
> > >         /*
> > > @@ -2759,11 +2760,11 @@ static void detach_extent_buffer_folio(const =
struct extent_buffer *eb, struct fo
> > >          * be done under the i_private_lock.
> > >          */
> > >         if (mapped)
> > > -               spin_lock(&folio->mapping->i_private_lock);
> > > +               spin_lock(&mapping->i_private_lock);
> > >
> > >         if (!folio_test_private(folio)) {
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2783,7 +2784,7 @@ static void detach_extent_buffer_folio(const st=
ruct extent_buffer *eb, struct fo
> > >                         folio_detach_private(folio);
> > >                 }
> > >                 if (mapped)
> > > -                       spin_unlock(&folio->mapping->i_private_lock);
> > > +                       spin_unlock(&mapping->i_private_lock);
> > >                 return;
> > >         }
> > >
> > > @@ -2806,7 +2807,7 @@ static void detach_extent_buffer_folio(const st=
ruct extent_buffer *eb, struct fo
> > >         if (!folio_range_has_eb(folio))
> > >                 btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_ME=
TADATA);
> > >
> > > -       spin_unlock(&folio->mapping->i_private_lock);
> > > +       spin_unlock(&mapping->i_private_lock);
> > >  }
> > >
> > >  /* Release all folios attached to the extent buffer */
> > > @@ -2821,9 +2822,13 @@ static void btrfs_release_extent_buffer_folios=
(const struct extent_buffer *eb)
> > >                         continue;
> > >
> > >                 detach_extent_buffer_folio(eb, folio);
> > > -
> > > -               /* One for when we allocated the folio. */
> > > -               folio_put(folio);
> >
> > So far so good, but...
> >
> > > +               /*
> > > +                * We only release the allocated refcount for mapped =
extent_buffer
> > > +                * folios. If the folio is unmapped, we have to relea=
se its allocated
> > > +                * refcount here.
> > > +                */
> > > +               if (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))
> > > +                       folio_put(folio);
> >
> > ...is this really correct? I'd do rather this instead:
>
> Yes, it is correct. It does deal with cloned extent buffers, where we
> need the extra put since we didn't do it after attaching the folio to
> it.
> Alternatively we could probably do the put after the attach at
> btrfs_clone_extent_buffer(), just like for regular extent buffers, and
> get rid of this special casing.

Right. That sounds more correct actually.

> >
> > @@ -3393,22 +3393,21 @@ struct extent_buffer
> > *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
> >          * case.  If we left eb->folios[i] populated in the subpage cas=
e we'd
> >          * double put our reference and be super sad.
> >          */
> > -       for (int i =3D 0; i < attached; i++) {
> > -               ASSERT(eb->folios[i]);
> > -               detach_extent_buffer_folio(eb, eb->folios[i]);
> > +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > +               if (i < attached) {
> > +                       ASSERT(eb->folios[i]);
> > +                       detach_extent_buffer_folio(eb, eb->folios[i]);
> > +               } else if (!eb->folios[i])
> > +                       continue;
> >                 folio_unlock(eb->folios[i]);
> >                 folio_put(eb->folios[i]);
> >                 eb->folios[i] =3D NULL;
> >
> > And perhaps `struct folio *folio =3D eb->folios[i];` first and substitu=
te.
> >
> > Or is this unrelated and we need both?
>
> This is unrelated.
> What you're trying to do here is to simplify the error path of the
> allocation of a regular extent buffer.
> Nothing to do with Boris' fix, and out of the scope of the fix.

Thanks for the explanation. I'll send it as a separate patch then.

> >
> > And honestly, IMO, there's no reason to set the EXTENT_BUFFER_UNMAPPED
> > at all after this loop as it's just going to be freed.
> >
> >         }
> > -       /*
> > -        * Now all pages of that extent buffer is unmapped, set UNMAPPE=
D flag,
> > -        * so it can be cleaned up without utilizing folio->mapping.
> > -        */
> > -       set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> > -
> >         btrfs_release_extent_buffer(eb);
> > +
> >         if (ret < 0)
> >                 return ERR_PTR(ret);
> > +
> >         ASSERT(existing_eb);
> >         return existing_eb;
> >  }
> >
> > >         }
> > >  }
> > >
> > > @@ -3365,8 +3370,15 @@ struct extent_buffer *alloc_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
> > >          * btree_release_folio will correctly detect that a page belo=
ngs to a
> > >          * live buffer and won't free them prematurely.
> > >          */
> > > -       for (int i =3D 0; i < num_extent_folios(eb); i++)
> > > +       for (int i =3D 0; i < num_extent_folios(eb); i++) {
> > >                 folio_unlock(eb->folios[i]);
> > > +               /*
> > > +                * A folio that has been added to an address_space ma=
pping
> > > +                * should not continue holding the refcount from its =
original
> > > +                * allocation indefinitely.
> > > +                */
> > > +               folio_put(eb->folios[i]);
> > > +       }
> > >         return eb;
> > >
> > >  out:
> > > --
> > > 2.49.0
> > >
> > >
> >

