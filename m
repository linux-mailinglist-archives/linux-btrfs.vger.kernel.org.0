Return-Path: <linux-btrfs+bounces-13547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38891AA4B51
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23DF1894629
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306C25A356;
	Wed, 30 Apr 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ7jO08c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3301DAC95;
	Wed, 30 Apr 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016472; cv=none; b=UdllZzKTV4I9s9cUL1wmetWAXICcoUmIiaXTFzqfdsKDMYvo8GF7I+IeS9m7G77F8Ft3eXksLD28xJ9yKpfh8qYSi4agGHgnq4sAIvnryVRLwjQ1sS0nDXuPYgmmZ7hLEVqMRojyd+DPTv4B/ZhjPPMeZiXBgvy2KspTmVmzaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016472; c=relaxed/simple;
	bh=/mZne+vIkHkY0VtHorX2T77c1BAVGzZhAC/aAgWWTco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcP485oHP/VjAcI8SZ6AmKyOL3W+wqHZodkJjVUaxvyIkVu1NpcQHjCMt3WG61W0g8sB7Oii9S+aXkXLOWRTsM3sNdfeYZPjKMq4XjFpUx497nmlX/2pOmh+BS6yvolLi+BXAiQHMpi1i5qnmcqcZ4Mfd8yt+XJar+Baz14Q6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ7jO08c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A493CC4CEEC;
	Wed, 30 Apr 2025 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746016471;
	bh=/mZne+vIkHkY0VtHorX2T77c1BAVGzZhAC/aAgWWTco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fQ7jO08cjXGdsnXMzUsHUXeCsz9zzm/A6IfrkHSqmJoykSX5qxVwBn87NFSq351iX
	 JZp9FBJhsFesE1i+X70CNhDD3tmQt6nc10p1eGx6zALss9NnuNf7q1p37QzhbBQZz+
	 HTW99tvZ8QXSo5JAPZYIcGbc8fzBjbBmFFnZ9uKmpFZ4ui0+TtUQXKXZmeIPBSHrAt
	 w5rvJ/jWd0OxhLzi+r6EPj7fRU+/rXWOHtyFK3ghPwkSEsGkWuePKpCYctUrghlivE
	 O3A6Q2YrqzzGMVHCW5YTJgrWY3DA++gmGSmqpZoTUqi7jKzP9oM5cmI7eYAuciPV7a
	 0v+BK1F1FZs1g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb415dd8faso1014209466b.2;
        Wed, 30 Apr 2025 05:34:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwhy7nEjGDi5DhMQLVQCRYHnx6g8Z1DItF4hEKd0BCcv+mNpAWdw6T6/xS54phvRjBMZ8hKrIgvvik9ddD@vger.kernel.org, AJvYcCXLle23+CjJrXrym/U/BMfu391l982ZrUeaWhOc6P1kMZ79URi+2wShVt6U/bXnDEfnp9sUdDy7duvhMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeq5nWeGQmCW2ZCgQDI8TLYYd0WqCVfcMC0jQfixTo7X/HoD04
	Y0D0E5mdfyD3UnQw3U0o/kEh+xvp9XRH90WmpatDEEc7jyFwOhKLaFBYBQhYNMvPdPOULHOsdZ/
	P2X2JJtrIFUhxTQFGz+EM+Poownw=
X-Google-Smtp-Source: AGHT+IHhHwkOhrjJHW8bahSH9fqRwcXZ4y8YzVzqQAzKfieAr1yi3Gh2LduH38vYcNbiQhzWVnOLbJjLUbVp9P/85qQ=
X-Received: by 2002:a17:907:3ea2:b0:ace:da39:7170 with SMTP id
 a640c23a62f3a-acedc768b2fmr354786966b.55.1746016470130; Wed, 30 Apr 2025
 05:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com>
 <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
 <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com>
 <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com> <CAPjX3FcDrr7D7nwh3=fyyOCxnp0iv+jeyPcGRX+gpw9zGHJ3vA@mail.gmail.com>
In-Reply-To: <CAPjX3FcDrr7D7nwh3=fyyOCxnp0iv+jeyPcGRX+gpw9zGHJ3vA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Apr 2025 13:33:52 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5TVPG-KiwZfEmndAQh8g+CT1tMPSYcT1Omhc3om6EHEg@mail.gmail.com>
X-Gm-Features: ATxdqUGbxifhosfNCLVh_JlNp9QQFOFY0zM2ZN362YmKLa8OEx9Cv-h_ypvBoVg
Message-ID: <CAL3q7H5TVPG-KiwZfEmndAQh8g+CT1tMPSYcT1Omhc3om6EHEg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:06=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Wed, 30 Apr 2025 at 12:26, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Wed, Apr 30, 2025 at 9:50=E2=80=AFAM Daniel Vacek <neelx@suse.com> w=
rote:
> > >
> > > On Wed, 30 Apr 2025 at 10:34, Filipe Manana <fdmanana@kernel.org> wro=
te:
> > > >
> > > > On Wed, Apr 30, 2025 at 9:26=E2=80=AFAM Daniel Vacek <neelx@suse.co=
m> wrote:
> > > > >
> > > > > On Wed, 30 Apr 2025 at 10:06, Filipe Manana <fdmanana@kernel.org>=
 wrote:
> > > > > >
> > > > > > On Tue, Apr 29, 2025 at 4:19=E2=80=AFPM Daniel Vacek <neelx@sus=
e.com> wrote:
> > > > > > >
> > > > > > > Even super block nowadays uses nodesize for eb->len. This is =
since commits
> > > > > > >
> > > > > > > 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_b=
uffer()")
> > > > > > > da17066c4047 ("btrfs: pull node/sector/stripe sizes out of ro=
ot and into fs_info")
> > > > > > > ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buff=
er")
> > > > > > > a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_=
create_tree_block")
> > > > > > >
> > > > > > > With these the eb->len is not really useful anymore. Let's us=
e the nodesize
> > > > > > > directly where applicable.
> > > > > > >
> > > > > > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > > > > > ---
> > > > > > > [RFC]
> > > > > > >  * Shall the eb_len() helper better be called eb_nodesize()? =
Or even rather
> > > > > > >    opencoded and not used at all?
> ...
> > > > > > > +static inline u32 eb_len(const struct extent_buffer *eb)
> > > > > > > +{
> > > > > > > +       return eb->fs_info->nodesize;
> > > > > > > +}
> > > > > >
> > > > > > Please always add a "btrfs_" prefix to the name of exported fun=
ctions.
> > > > >
> > > > > It's static inline, not exported. But I'm happy just opencoding i=
t
> > > > > instead. Thanks.
> > > >
> > > > Exported in the sense that it's in a header and visible to any C fi=
les
> > > > that include it, not in the sense of being exported with
> > > > EXPORT_SYMBOL_GPL() for example.
> > > > This is our coding style convention:
> > > >
> > > > https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#f=
unction-declarations
> > > >
> > > > static functions inside a C file can omit the prefix.
> > >
> > > Nah, thanks again. I was not aware of that. Will keep it in mind.
> > >
> > > Still, it doesn't make sense to me to be honest. I mean specifically
> > > with this example. The header file is also private to btrfs, no publi=
c
> > > API. Personally I wouldn't differentiate if it's a source or a header
> > > file. The code can be freely moved around. And with the prefix the
> > > code would end up more bloated and less readable, IMO. But let's not
> > > start any flamewars here.
> >
> > I'd disagree about less readability. Reading code that calls a
> > function with the btrfs prefix makes it clear it's a btrfs specific
> > function.
> > Looking at ext4 and xfs, functions declared or defined in their
> > headers have a "ext4_", "ext_" or "xfs_" prefix.
>
> I see. Makes sense.
> Does this also apply to preprocessor macros? I don't see them
> mentioned in the development notes.
> I'm asking as I did consider using a macro which would look a bit
> cleaner perhaps, just one line instead of four. But it would also miss
> the type checking.
> So I guess the naming convention should also apply to macros, right?
>
> Finally quickly checking I see a lot of functions like eg.
> free_extent_buffer(), free_extent_buffer_stale() and many others
> violating the rule. I guess we should also clean up and rename them,
> right?

Haven't you seen patchsets from me in the last few weeks renaming
functions from extent-io-tree.h and extent_map.h?

You'll see examples of where the prefix is missing, and this happens
for very old code, we rename things from time to time.
In those two cases I was motivated due to the need to add more
functions soon, or having added some new ones not long ago, to make
everything consistent in those headers/modules by making sure all have
the "btrfs_" prefix.



>
> > > > > > In this case I don't think adding this helper adds any value.
> > > > > > We can just do eb->fs_info->nodesize everywhere and in some pla=
ces we
> > > > > > already have fs_info in a local variable and can just do
> > > > > > fs_info->nodesize.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > > +
> > > > > > >  /* Note: this can be used in for loops without caching the v=
alue in a variable. */
> > > > > > >  static inline int __pure num_extent_pages(const struct exten=
t_buffer *eb)
> > > > > > >  {
> > > > > > >         /*
> > > > > > >          * For sectorsize =3D=3D PAGE_SIZE case, since nodesi=
ze is always aligned to
> > > > > > > -        * sectorsize, it's just eb->len >> PAGE_SHIFT.
> > > > > > > +        * sectorsize, it's just nodesize >> PAGE_SHIFT.
> > > > > > >          *
> > > > > > >          * For sectorsize < PAGE_SIZE case, we could have nod=
esize < PAGE_SIZE,
> > > > > > >          * thus have to ensure we get at least one page.
> > > > > > >          */
> > > > > > > -       return (eb->len >> PAGE_SHIFT) ?: 1;
> > > > > > > +       return (eb_len(eb) >> PAGE_SHIFT) ?: 1;
> > > > > > >  }
> > > > > > >
> > > > > > >  /*
> > > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > > index 68fac77fb95d1..6be2d56d44917 100644
> > > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > > @@ -598,7 +598,7 @@ static noinline int create_subvol(struct =
mnt_idmap *idmap,
> > > > > > >         btrfs_set_root_generation(root_item, trans->transid);
> > > > > > >         btrfs_set_root_level(root_item, 0);
> > > > > > >         btrfs_set_root_refs(root_item, 1);
> > > > > > > -       btrfs_set_root_used(root_item, leaf->len);
> > > > > > > +       btrfs_set_root_used(root_item, fs_info->nodesize);
> > > > > > >         btrfs_set_root_last_snapshot(root_item, 0);
> > > > > > >
> > > > > > >         btrfs_set_root_generation_v2(root_item,
> > > > > > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > > > > > index 6287e71ebad5f..5086485a4ae21 100644
> > > > > > > --- a/fs/btrfs/relocation.c
> > > > > > > +++ b/fs/btrfs/relocation.c
> > > > > > > @@ -4352,7 +4352,7 @@ int btrfs_reloc_cow_block(struct btrfs_=
trans_handle *trans,
> > > > > > >                         mark_block_processed(rc, node);
> > > > > > >
> > > > > > >                 if (first_cow && level > 0)
> > > > > > > -                       rc->nodes_relocated +=3D buf->len;
> > > > > > > +                       rc->nodes_relocated +=3D fs_info->nod=
esize;
> > > > > > >         }
> > > > > > >
> > > > > > >         if (level =3D=3D 0 && first_cow && rc->stage =3D=3D U=
PDATE_DATA_PTRS)
> > > > > > > diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> > > > > > > index d4f0192334936..711792f32e9ce 100644
> > > > > > > --- a/fs/btrfs/subpage.c
> > > > > > > +++ b/fs/btrfs/subpage.c
> > > > > > > @@ -631,7 +631,7 @@ void btrfs_meta_folio_set_##name(struct f=
olio *folio, const struct extent_buffer
> > > > > > >                 folio_set_func(folio);                       =
           \
> > > > > > >                 return;                                      =
           \
> > > > > > >         }                                                    =
           \
> > > > > > > -       btrfs_subpage_set_##name(eb->fs_info, folio, eb->star=
t, eb->len); \
> > > > > > > +       btrfs_subpage_set_##name(eb->fs_info, folio, eb->star=
t, eb_len(eb)); \
> > > > > > >  }                                                           =
           \
> > > > > > >  void btrfs_meta_folio_clear_##name(struct folio *folio, cons=
t struct extent_buffer *eb) \
> > > > > > >  {                                                           =
           \
> > > > > > > @@ -639,13 +639,13 @@ void btrfs_meta_folio_clear_##name(stru=
ct folio *folio, const struct extent_buff
> > > > > > >                 folio_clear_func(folio);                     =
           \
> > > > > > >                 return;                                      =
           \
> > > > > > >         }                                                    =
           \
> > > > > > > -       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->st=
art, eb->len); \
> > > > > > > +       btrfs_subpage_clear_##name(eb->fs_info, folio, eb->st=
art, eb_len(eb)); \
> > > > > > >  }                                                           =
           \
> > > > > > >  bool btrfs_meta_folio_test_##name(struct folio *folio, const=
 struct extent_buffer *eb) \
> > > > > > >  {                                                           =
           \
> > > > > > >         if (!btrfs_meta_is_subpage(eb->fs_info))             =
           \
> > > > > > >                 return folio_test_func(folio);               =
           \
> > > > > > > -       return btrfs_subpage_test_##name(eb->fs_info, folio, =
eb->start, eb->len); \
> > > > > > > +       return btrfs_subpage_test_##name(eb->fs_info, folio, =
eb->start, eb_len(eb)); \
> > > > > > >  }
> > > > > > >  IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, foli=
o_clear_uptodate,
> > > > > > >                          folio_test_uptodate);
> > > > > > > @@ -765,7 +765,7 @@ bool btrfs_meta_folio_clear_and_test_dirt=
y(struct folio *folio, const struct ext
> > > > > > >                 return true;
> > > > > > >         }
> > > > > > >
> > > > > > > -       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_in=
fo, folio, eb->start, eb->len);
> > > > > > > +       last =3D btrfs_subpage_clear_and_test_dirty(eb->fs_in=
fo, folio, eb->start, eb_len(eb));
> > > > > > >         if (last) {
> > > > > > >                 folio_clear_dirty_for_io(folio);
> > > > > > >                 return true;
> > > > > > > diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/test=
s/extent-io-tests.c
> > > > > > > index 00da54f0164c9..657f8f1d9263e 100644
> > > > > > > --- a/fs/btrfs/tests/extent-io-tests.c
> > > > > > > +++ b/fs/btrfs/tests/extent-io-tests.c
> > > > > > > @@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long =
*bitmap, struct extent_buffer *eb)
> > > > > > >  {
> > > > > > >         unsigned long i;
> > > > > > >
> > > > > > > -       for (i =3D 0; i < eb->len * BITS_PER_BYTE; i++) {
> > > > > > > +       for (i =3D 0; i < eb_len(eb) * BITS_PER_BYTE; i++) {
> > > > > > >                 int bit, bit1;
> > > > > > >
> > > > > > >                 bit =3D !!test_bit(i, bitmap);
> > > > > > > @@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *=
name, unsigned long *bitmap,
> > > > > > >  static int __test_eb_bitmaps(unsigned long *bitmap, struct e=
xtent_buffer *eb)
> > > > > > >  {
> > > > > > >         unsigned long i, j;
> > > > > > > -       unsigned long byte_len =3D eb->len;
> > > > > > > +       unsigned long byte_len =3D eb_len(eb);
> > > > > > >         u32 x;
> > > > > > >         int ret;
> > > > > > >
> > > > > > > @@ -670,7 +670,7 @@ static int test_find_first_clear_extent_b=
it(void)
> > > > > > >  static void dump_eb_and_memory_contents(struct extent_buffer=
 *eb, void *memory,
> > > > > > >                                         const char *test_name=
)
> > > > > > >  {
> > > > > > > -       for (int i =3D 0; i < eb->len; i++) {
> > > > > > > +       for (int i =3D 0; i < eb_len(eb); i++) {
> > > > > > >                 struct page *page =3D folio_page(eb->folios[i=
 >> PAGE_SHIFT], 0);
> > > > > > >                 void *addr =3D page_address(page) + offset_in=
_page(i);
> > > > > > >
> > > > > > > @@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(s=
truct extent_buffer *eb, void *memory,
> > > > > > >  static int verify_eb_and_memory(struct extent_buffer *eb, vo=
id *memory,
> > > > > > >                                 const char *test_name)
> > > > > > >  {
> > > > > > > -       for (int i =3D 0; i < (eb->len >> PAGE_SHIFT); i++) {
> > > > > > > +       for (int i =3D 0; i < (eb_len(eb) >> PAGE_SHIFT); i++=
) {
> > > > > > >                 void *eb_addr =3D folio_address(eb->folios[i]=
);
> > > > > > >
> > > > > > >                 if (memcmp(memory + (i << PAGE_SHIFT), eb_add=
r, PAGE_SIZE) !=3D 0) {
> > > > > > > @@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct ex=
tent_buffer *eb, void *memory,
> > > > > > >   */
> > > > > > >  static void init_eb_and_memory(struct extent_buffer *eb, voi=
d *memory)
> > > > > > >  {
> > > > > > > -       get_random_bytes(memory, eb->len);
> > > > > > > -       write_extent_buffer(eb, memory, 0, eb->len);
> > > > > > > +       get_random_bytes(memory, eb_len(eb));
> > > > > > > +       write_extent_buffer(eb, memory, 0, eb_len(eb));
> > > > > > >  }
> > > > > > >
> > > > > > >  static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
> > > > > > > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > > > > > > index 9d42bf2bfd746..c7a8cdd87c509 100644
> > > > > > > --- a/fs/btrfs/zoned.c
> > > > > > > +++ b/fs/btrfs/zoned.c
> > > > > > > @@ -2422,7 +2422,7 @@ void btrfs_schedule_zone_finish_bg(stru=
ct btrfs_block_group *bg,
> > > > > > >                                    struct extent_buffer *eb)
> > > > > > >  {
> > > > > > >         if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->=
runtime_flags) ||
> > > > > > > -           eb->start + eb->len * 2 <=3D bg->start + bg->zone=
_capacity)
> > > > > > > +           eb->start + eb_len(eb) * 2 <=3D bg->start + bg->z=
one_capacity)
> > > > > > >                 return;
> > > > > > >
> > > > > > >         if (WARN_ON(bg->zone_finish_work.func =3D=3D btrfs_zo=
ne_finish_endio_workfn)) {
> > > > > > > --
> > > > > > > 2.47.2
> > > > > > >
> > > > > > >

