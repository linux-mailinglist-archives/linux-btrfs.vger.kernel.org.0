Return-Path: <linux-btrfs+bounces-13105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF77A90C78
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF1D3B9CA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EF2253EE;
	Wed, 16 Apr 2025 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1CU0cv3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344E224894;
	Wed, 16 Apr 2025 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832495; cv=none; b=vABE4yvCj3FhWOuPYbooPthGUfM2l7zur1R0E+bQKc0njozMpeVUF9k0uXuM37a0b9zrS1mep+BiVzxLrZUgNR1fR/Y94ffA5JuUjZS3nMbZzTvnaxdwDEJQuaUbrSSUz9vGIeMCPDqWimLJ85M2sNF2bmKbm9Atj+QCfCj5YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832495; c=relaxed/simple;
	bh=rmmU8DVE2D232s4Grqwa87/AQMyhUhLBZFcdHIL8y6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8mfp/jz1Ila1zjB/RNPHM0jKatwMTqVcrsS5ahzkRiFfFqRJTxK+yCGzbXs7NUFgcmAL7jK+ikZspW7PqA3sbm0uWVyya71E2CcOHTtQcOrYSKJEeoHLM5lkTswFsSgGszw2vTrfrqQ/C17KJqH8IZrs3kW/DGSDPpgAEHdL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1CU0cv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973FBC4CEEC;
	Wed, 16 Apr 2025 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832493;
	bh=rmmU8DVE2D232s4Grqwa87/AQMyhUhLBZFcdHIL8y6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M1CU0cv3LvBNE9z/Yc2FX8HmZVEw6+6VcHYheF+OtcAspQDMz54hYzxIKWZvwthRo
	 YT1EsO+WZi7BtRyHfkvTG0FKUDnj9lJwT5n0aIRL7Wthsq0lg2YYVTFoQ1meg+1Ima
	 3TNlsfxUHGK1eiRBfKqoNzQpr1PI8xnwC3XALDeLdyMVCs8u6YVi52YBwDpAU9wUqZ
	 nAHcQHAh5akG+JLkjXR8TxZQE4Ii8dVXDP1uTHng361Q3EZji9Qik0wctWROzkomu0
	 Li6ZAWT29QPG/T2U+3K41jTI1Xnjax8vkfD5Tk0vVTWw8BmViUegb6QRhXh6nahaQs
	 4dJO4kmWhKA4A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2aeada833so13879866b.0;
        Wed, 16 Apr 2025 12:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNZpC9ovb3DDG2QHdEGEXuminCnBtpmlMjz8GMp8F0Yu9Vnb/TTN948eliPuIqK2al5TyejZ2BC5GxLg==@vger.kernel.org, AJvYcCXPu6keCHMhytuDYBGr/x8kxCrBf3DQVIlOShlh2Rla3rzCHT73diyXiMHQ0tFcbRCYEUXp/lI+2+zj6hk3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jcTew8QTOHiIRkGFAX2rAhNvwBUJ4263xdFBYW4kuRxG5Bhd
	BL4rYrCbB/ZA1WY+4pkj3SIIDycKDIwSAwQLxNKa6FL3vjXV1acOtRFvLk2TOkntJ9fgJbtJKME
	3qRWYFU23AJaA1hYZkwW93IOlLL8=
X-Google-Smtp-Source: AGHT+IEgaa/lF0B29FUztngMKiosbNE8d6mYtZEseWvSqOPDgclr+4nqD0zjKMj3ce/uu47GWIitbbPs25Ap3GHoykY=
X-Received: by 2002:a17:907:1c0f:b0:acb:3719:3011 with SMTP id
 a640c23a62f3a-acb5b44ed5emr4653366b.9.1744832492096; Wed, 16 Apr 2025
 12:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415033854.848776-1-frank.li@vivo.com> <3353953.aeNJFYEL58@saltykitkat>
 <20250415155637.GG16750@suse.cz> <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com> <20250416191111.GC13877@suse.cz>
In-Reply-To: <20250416191111.GC13877@suse.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Apr 2025 20:40:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4_vNoKokn213rY2Q0MNkDLWSk7XRBqJLxfiw1ikRGM7Q@mail.gmail.com>
X-Gm-Features: ATxdqUGFLnuNhPUgUv0nT_paFBRUcDj_6lgiv8IK1W8lqC_R5oeLvBTUezr2lF0
Message-ID: <CAL3q7H4_vNoKokn213rY2Q0MNkDLWSk7XRBqJLxfiw1ikRGM7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: get rid of path allocation in btrfs_del_inode_extref()
To: dsterba@suse.cz
Cc: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>, 
	Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "neelx@suse.com" <neelx@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 8:11=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Apr 16, 2025 at 02:37:33PM +0100, Filipe Manana wrote:
> > On Wed, Apr 16, 2025 at 2:24=E2=80=AFPM =E6=9D=8E=E6=89=AC=E9=9F=AC <fr=
ank.li@vivo.com> wrote:
> > >
> > >
> > >
> > > > Also a good point, the path should be in a pristine state, as if it=
 were just allocated. Releasing paths in other functions may want to keep t=
he bits but in this case we're crossing a function boundary and the same as=
sumptions may not be the same.
> > >
> > > > Release resets the ->nodes, so what's left is from ->slots until th=
e the end of the structure. And a helper for that would be desirable rather=
 than opencoding that.
> > >
> > > IIUC, use btrfs_reset_path instead of btrfs_release_path?
> > >
> > > noinline void btrfs_reset_path(struct btrfs_path *p)
> > > {
> > >         int i;
> > >
> > >         for (i =3D 0; i < BTRFS_MAX_LEVEL; i++) {
> > >                 if (!p->nodes[i])
> > >                         continue;
> > >                 if (p->locks[i])
> > >                         btrfs_tree_unlock_rw(p->nodes[i], p->locks[i]=
);
> > >                 free_extent_buffer(p->nodes[i]);
> > >         }
> > >         memset(p, 0, sizeof(struct btrfs_path));
> > > }
> > >
> > > BTW, I have seen released paths being passed across functions in some=
 other paths.
> > >
> > > Should these also be changed to reset paths, or should these flags be=
 cleared in the release path?
> >
> > Please don't complicate things unnecessarily.
> > The patch is fine, all that needs to be done is to call
> > btrfs_release_path() before passing the path to
> > btrfs_del_inode_extref(), which resets nodes, slots and locks.
>
> But this leaves the bits set, btrfs_insert_inode_ref() sets
> path->skip_release_on_error, this should be reset. In this case it may
> not be significant but I'd rather make the path reusing pattern correct
> from the beginning.
>
> My idea was to add only
>
> btrfs_reset_path() {
>         memset(p, 0, sizeof(struct btrfs_path));
> }
>
> and use it in conection with btrfs_release_path() only in case it's
> optimizing the allocation.

Honestly I don't like adding yet another function to do such "reset" thing.

Leaving path->skip_release_on_error is perfectly fine in this scenario.
If that bothers anyone so much, just set path->skip_release_on_error
to 0 after calling btrfs_release_path() and before passing the path to
btrfs_insert_inode_extref().

This is the sort of optimization that is not worth spending this much
time and adding new APIs - freeing and allocating a path shortly after
is almost always fast as we're using a slab, plus this is a rarely hit
use case - having to use extrefs, meaning we have a very large number
of inode refs.

