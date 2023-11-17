Return-Path: <linux-btrfs+bounces-174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8912E7EFC52
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 00:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA511F27ACD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Nov 2023 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDC47786;
	Fri, 17 Nov 2023 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B561A1
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 15:57:19 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so3586718a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 15:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265438; x=1700870238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvOjjfYaWB+gMFsOs+exK4JOomWwx09UGPXjBYb6OEo=;
        b=E5D0zDYKPxMoHJBkdchUE6xzM7xf9k3wf7wDcdqxqiMy/VpJxeNW3jHr8xG09Dn3Kg
         JEX+cpu50ILt9o6fX6H9OkN9GDeTDOf0SFQtvtdTC2Sw5dJ5TVHIc3YOpqvrgwou+alS
         OBjuYDuLLhVeCIdg1/IvJvzodZ4TAqttn+qhIjr5dkcNYV4GhQwgJqdBTrEIZiwcnyrZ
         ELR1fFy5AOgTgzFtTbbAh5Fdx9KW9tknkpx5pmSiRkesNWq6RMQq0aM2lebkhtkXVGmc
         39FrU092z5PkN8Gak/dPjEalP7skrlxqN7q83aYyS2vjANulY7KMMhG3rXpm6tO5igPT
         ksoA==
X-Gm-Message-State: AOJu0YxtWnzAwdbHBE+PphwVLoDilY8ioX+U6S+t2LWWEUruJGNTtGlb
	VqDrA6pD+3SOj+HSmdbQwFnra6cSgmqnsA==
X-Google-Smtp-Source: AGHT+IFxr8k0jKqRHlu1nrJ80m0SbKQ8V0IsY4etgGD22HScvfA3GiT8kUDC+w7GZ66t+ebXX3iqaw==
X-Received: by 2002:a05:6402:1258:b0:53f:731a:e513 with SMTP id l24-20020a056402125800b0053f731ae513mr362802edw.25.1700265437056;
        Fri, 17 Nov 2023 15:57:17 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id bc20-20020a056402205400b0054710139be0sm1173706edb.6.2023.11.17.15.57.16
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 15:57:16 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so3573846a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 15:57:16 -0800 (PST)
X-Received: by 2002:a05:6402:3584:b0:532:e71b:5ead with SMTP id
 y4-20020a056402358400b00532e71b5eadmr410120edc.32.1700265436462; Fri, 17 Nov
 2023 15:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
In-Reply-To: <b4097d7c5a887a0e9d8bdedd9cd112aadb716d58.1700193251.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 17 Nov 2023 18:56:39 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9tr4aQQBM29Tnq1SSaC22CZwAKP_aaR9kyjCLRnkg3LQ@mail.gmail.com>
Message-ID: <CAEg-Je9tr4aQQBM29Tnq1SSaC22CZwAKP_aaR9kyjCLRnkg3LQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: migrate to use folio private instead of page private
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:54=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> As a cleanup and preparation for future folio migration, this patch
> would replace all page->private to folio version.
> This includes:
>
> - PagePrivate()
>   -> folio_test_private()
>
> - page->private
>   -> folio_get_private()
>
> - attach_page_private()
>   -> folio_attach_private()
>
> - detach_page_private()
>   -> folio_detach_private()
>
> Since we're here, also remove the forced cast on page->private, since
> it's (void *) already, we don't really need to do the cast.
>
> For now even if we missed some call sites, it won't cause any problem
> yet, as we're only using order 0 folio (single page), thus all those
> folio/page flags should be synced.
>
> But for the future conversion to utilize higher order folio, the page
> <-> folio flag sync is no longer guaranteed, thus we have to migrate to
> utilize folio flags.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Just to mention, I really like the new unified folio flag accessors, no
> more weird camel case.
> ---
>  fs/btrfs/extent_io.c | 98 +++++++++++++++++++++++++-------------------
>  fs/btrfs/extent_io.h |  6 +--
>  fs/btrfs/file.c      |  5 ++-
>  fs/btrfs/inode.c     |  7 ++--
>  fs/btrfs/subpage.c   | 92 ++++++++++++++++++++++++++---------------
>  5 files changed, 124 insertions(+), 84 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 004b0ba6b1c7..99cc16aed9d7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -562,11 +562,13 @@ static void endio_readpage_release_extent(struct pr=
ocessed_extent *processed,
>
>  static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *=
page)
>  {
> +       struct folio *folio =3D page_folio(page);
> +
>         ASSERT(PageLocked(page));
>         if (!btrfs_is_subpage(fs_info, page))
>                 return;
>
> -       ASSERT(PagePrivate(page));
> +       ASSERT(folio_test_private(folio));
>         btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE=
_SIZE);
>  }
>
> @@ -860,6 +862,7 @@ static int attach_extent_buffer_page(struct extent_bu=
ffer *eb,
>                                      struct page *page,
>                                      struct btrfs_subpage *prealloc)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
>         int ret =3D 0;
>
> @@ -873,22 +876,22 @@ static int attach_extent_buffer_page(struct extent_=
buffer *eb,
>                 lockdep_assert_held(&page->mapping->private_lock);
>
>         if (fs_info->nodesize >=3D PAGE_SIZE) {
> -               if (!PagePrivate(page))
> -                       attach_page_private(page, eb);
> +               if (!folio_test_private(folio))
> +                       folio_attach_private(folio, eb);
>                 else
> -                       WARN_ON(page->private !=3D (unsigned long)eb);
> +                       WARN_ON(folio_get_private(folio) !=3D eb);
>                 return 0;
>         }
>
>         /* Already mapped, just free prealloc */
> -       if (PagePrivate(page)) {
> +       if (folio_test_private(folio)) {
>                 btrfs_free_subpage(prealloc);
>                 return 0;
>         }
>
>         if (prealloc)
>                 /* Has preallocated memory for subpage */
> -               attach_page_private(page, prealloc);
> +               folio_attach_private(folio, prealloc);
>         else
>                 /* Do new allocation to attach subpage */
>                 ret =3D btrfs_attach_subpage(fs_info, page,
> @@ -898,11 +901,12 @@ static int attach_extent_buffer_page(struct extent_=
buffer *eb,
>
>  int set_page_extent_mapped(struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_fs_info *fs_info;
>
>         ASSERT(page->mapping);
>
> -       if (PagePrivate(page))
> +       if (folio_test_private(folio))
>                 return 0;
>
>         fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> @@ -910,24 +914,25 @@ int set_page_extent_mapped(struct page *page)
>         if (btrfs_is_subpage(fs_info, page))
>                 return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_=
DATA);
>
> -       attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> +       folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
>         return 0;
>  }
>
>  void clear_page_extent_mapped(struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_fs_info *fs_info;
>
>         ASSERT(page->mapping);
>
> -       if (!PagePrivate(page))
> +       if (!folio_test_private(folio))
>                 return;
>
>         fs_info =3D btrfs_sb(page->mapping->host->i_sb);
>         if (btrfs_is_subpage(fs_info, page))
>                 return btrfs_detach_subpage(fs_info, page);
>
> -       detach_page_private(page);
> +       folio_detach_private(folio);
>  }
>
>  static struct extent_map *
> @@ -1235,7 +1240,8 @@ static noinline_for_stack int writepage_delalloc(st=
ruct btrfs_inode *inode,
>  static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
>                                  struct page *page, u64 *start, u64 *end)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         struct btrfs_subpage_info *spi =3D fs_info->subpage_info;
>         u64 orig_start =3D *start;
>         /* Declare as unsigned long so we can use bitmap ops */
> @@ -1720,6 +1726,7 @@ static noinline_for_stack void write_one_eb(struct =
extent_buffer *eb,
>  static int submit_eb_subpage(struct page *page, struct writeback_control=
 *wbc)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i=
_sb);
> +       struct folio *folio =3D page_folio(page);
>         int submitted =3D 0;
>         u64 page_start =3D page_offset(page);
>         int bit_start =3D 0;
> @@ -1727,7 +1734,7 @@ static int submit_eb_subpage(struct page *page, str=
uct writeback_control *wbc)
>
>         /* Lock and write each dirty extent buffers in the range */
>         while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
> -               struct btrfs_subpage *subpage =3D (struct btrfs_subpage *=
)page->private;
> +               struct btrfs_subpage *subpage =3D folio_get_private(folio=
);
>                 struct extent_buffer *eb;
>                 unsigned long flags;
>                 u64 start;
> @@ -1737,7 +1744,7 @@ static int submit_eb_subpage(struct page *page, str=
uct writeback_control *wbc)
>                  * in the meantime.
>                  */
>                 spin_lock(&page->mapping->private_lock);
> -               if (!PagePrivate(page)) {
> +               if (!folio_test_private(folio)) {
>                         spin_unlock(&page->mapping->private_lock);
>                         break;
>                 }
> @@ -1802,22 +1809,23 @@ static int submit_eb_page(struct page *page, stru=
ct btrfs_eb_write_context *ctx)
>  {
>         struct writeback_control *wbc =3D ctx->wbc;
>         struct address_space *mapping =3D page->mapping;
> +       struct folio *folio =3D page_folio(page);
>         struct extent_buffer *eb;
>         int ret;
>
> -       if (!PagePrivate(page))
> +       if (!folio_test_private(folio))
>                 return 0;
>
>         if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>                 return submit_eb_subpage(page, wbc);
>
>         spin_lock(&mapping->private_lock);
> -       if (!PagePrivate(page)) {
> +       if (!folio_test_private(folio)) {
>                 spin_unlock(&mapping->private_lock);
>                 return 0;
>         }
>
> -       eb =3D (struct extent_buffer *)page->private;
> +       eb =3D folio_get_private(folio);
>
>         /*
>          * Shouldn't happen and normally this would be a BUG_ON but no po=
int
> @@ -3054,12 +3062,13 @@ static int extent_buffer_under_io(const struct ex=
tent_buffer *eb)
>
>  static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page=
 *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         lockdep_assert_held(&page->mapping->private_lock);
>
> -       if (PagePrivate(page)) {
> -               subpage =3D (struct btrfs_subpage *)page->private;
> +       if (folio_test_private(folio)) {
> +               subpage =3D folio_get_private(folio);
>                 if (atomic_read(&subpage->eb_refs))
>                         return true;
>                 /*
> @@ -3076,15 +3085,16 @@ static void detach_extent_buffer_page(struct exte=
nt_buffer *eb, struct page *pag
>  {
>         struct btrfs_fs_info *fs_info =3D eb->fs_info;
>         const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bfla=
gs);
> +       struct folio *folio =3D page_folio(page);
>
>         /*
> -        * For mapped eb, we're going to change the page private, which s=
hould
> +        * For mapped eb, we're going to change the folio private, which =
should
>          * be done under the private_lock.
>          */
>         if (mapped)
>                 spin_lock(&page->mapping->private_lock);
>
> -       if (!PagePrivate(page)) {
> +       if (!folio_test_private(folio)) {
>                 if (mapped)
>                         spin_unlock(&page->mapping->private_lock);
>                 return;
> @@ -3095,11 +3105,11 @@ static void detach_extent_buffer_page(struct exte=
nt_buffer *eb, struct page *pag
>                  * We do this since we'll remove the pages after we've
>                  * removed the eb from the radix tree, so we could race
>                  * and have this page now attached to the new eb.  So
> -                * only clear page_private if it's still connected to
> +                * only clear folio if it's still connected to
>                  * this eb.
>                  */
> -               if (PagePrivate(page) &&
> -                   page->private =3D=3D (unsigned long)eb) {
> +               if (folio_test_private(folio) &&
> +                   folio_get_private(folio) =3D=3D eb) {
>                         BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)=
);
>                         BUG_ON(PageDirty(page));
>                         BUG_ON(PageWriteback(page));
> @@ -3107,7 +3117,7 @@ static void detach_extent_buffer_page(struct extent=
_buffer *eb, struct page *pag
>                          * We need to make sure we haven't be attached
>                          * to a new eb.
>                          */
> -                       detach_page_private(page);
> +                       folio_detach_private(folio);
>                 }
>                 if (mapped)
>                         spin_unlock(&page->mapping->private_lock);
> @@ -3115,9 +3125,9 @@ static void detach_extent_buffer_page(struct extent=
_buffer *eb, struct page *pag
>         }
>
>         /*
> -        * For subpage, we can have dummy eb with page private.  In this =
case,
> -        * we can directly detach the private as such page is only attach=
ed to
> -        * one dummy eb, no sharing.
> +        * For subpage, we can have dummy eb with folio private attached.
> +        * In this case, we can directly detach the private as such folio=
 is
> +        * only attached to one dummy eb, no sharing.
>          */
>         if (!mapped) {
>                 btrfs_detach_subpage(fs_info, page);
> @@ -3127,7 +3137,7 @@ static void detach_extent_buffer_page(struct extent=
_buffer *eb, struct page *pag
>         btrfs_page_dec_eb_refs(fs_info, page);
>
>         /*
> -        * We can only detach the page private if there are no other ebs =
in the
> +        * We can only detach the folio private if there are no other ebs=
 in the
>          * page range and no unfinished IO.
>          */
>         if (!page_range_has_eb(fs_info, page))
> @@ -3404,6 +3414,7 @@ struct extent_buffer *alloc_test_extent_buffer(stru=
ct btrfs_fs_info *fs_info,
>  static struct extent_buffer *grab_extent_buffer(
>                 struct btrfs_fs_info *fs_info, struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct extent_buffer *exists;
>
>         /*
> @@ -3415,21 +3426,21 @@ static struct extent_buffer *grab_extent_buffer(
>                 return NULL;
>
>         /* Page not yet attached to an extent buffer */
> -       if (!PagePrivate(page))
> +       if (!folio_test_private(folio))
>                 return NULL;
>
>         /*
>          * We could have already allocated an eb for this page and attach=
ed one
>          * so lets see if we can get a ref on the existing eb, and if we =
can we
>          * know it's good and we can just return that one, else we know w=
e can
> -        * just overwrite page->private.
> +        * just overwrite folio private.
>          */
> -       exists =3D (struct extent_buffer *)page->private;
> +       exists =3D folio_get_private(folio);
>         if (atomic_inc_not_zero(&exists->refs))
>                 return exists;
>
>         WARN_ON(PageDirty(page));
> -       detach_page_private(page);
> +       folio_detach_private(folio);
>         return NULL;
>  }
>
> @@ -3514,7 +3525,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>         num_pages =3D num_extent_pages(eb);
>
>         /*
> -        * Preallocate page->private for subpage case, so that we won't
> +        * Preallocate folio private for subpage case, so that we won't
>          * allocate memory with private_lock nor page lock hold.
>          *
>          * The memory will be freed by attach_extent_buffer_page() or fre=
ed
> @@ -3551,7 +3562,7 @@ struct extent_buffer *alloc_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>                 ASSERT(!ret);
>                 /*
>                  * To inform we have extra eb under allocation, so that
> -                * detach_extent_buffer_page() won't release the page pri=
vate
> +                * detach_extent_buffer_page() won't release the folio pr=
ivate
>                  * when the eb hasn't yet been inserted into radix tree.
>                  *
>                  * The ref will be decreased when the eb released the pag=
e, in
> @@ -4569,7 +4580,7 @@ static int try_release_subpage_extent_buffer(struct=
 page *page)
>                 struct extent_buffer *eb =3D NULL;
>
>                 /*
> -                * Unlike try_release_extent_buffer() which uses page->pr=
ivate
> +                * Unlike try_release_extent_buffer() which uses folio pr=
ivate
>                  * to grab buffer, for subpage case we rely on radix tree=
, thus
>                  * we need to ensure radix tree consistency.
>                  *
> @@ -4609,17 +4620,17 @@ static int try_release_subpage_extent_buffer(stru=
ct page *page)
>
>                 /*
>                  * Here we don't care about the return value, we will alw=
ays
> -                * check the page private at the end.  And
> +                * check the folio private at the end.  And
>                  * release_extent_buffer() will release the refs_lock.
>                  */
>                 release_extent_buffer(eb);
>         }
>         /*
> -        * Finally to check if we have cleared page private, as if we hav=
e
> -        * released all ebs in the page, the page private should be clear=
ed now.
> +        * Finally to check if we have cleared folio private, as if we ha=
ve
> +        * released all ebs in the page, the folio private should be clea=
red now.
>          */
>         spin_lock(&page->mapping->private_lock);
> -       if (!PagePrivate(page))
> +       if (!folio_test_private(page_folio(page)))
>                 ret =3D 1;
>         else
>                 ret =3D 0;
> @@ -4630,22 +4641,23 @@ static int try_release_subpage_extent_buffer(stru=
ct page *page)
>
>  int try_release_extent_buffer(struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct extent_buffer *eb;
>
>         if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>                 return try_release_subpage_extent_buffer(page);
>
>         /*
> -        * We need to make sure nobody is changing page->private, as we r=
ely on
> -        * page->private as the pointer to extent buffer.
> +        * We need to make sure nobody is changing folio private, as we r=
ely on
> +        * folio private as the pointer to extent buffer.
>          */
>         spin_lock(&page->mapping->private_lock);
> -       if (!PagePrivate(page)) {
> +       if (!folio_test_private(folio)) {
>                 spin_unlock(&page->mapping->private_lock);
>                 return 1;
>         }
>
> -       eb =3D (struct extent_buffer *)page->private;
> +       eb =3D folio_get_private(folio);
>         BUG_ON(!eb);
>
>         /*
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index a88374ad248f..6531285ef0bc 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -43,10 +43,10 @@ enum {
>  };
>
>  /*
> - * page->private values.  Every page that is controlled by the extent
> - * map has page->private set to one.
> + * folio private values.  Every page that is controlled by the extent
> + * map has folio private set to this value.
>   */
> -#define EXTENT_PAGE_PRIVATE 1
> +#define EXTENT_FOLIO_PRIVATE 1
>
>  /*
>   * The extent buffer bitmap operations are done with byte granularity in=
stead of
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f47731c45bb5..6197f585cdff 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -869,9 +869,10 @@ static int prepare_uptodate_page(struct inode *inode=
,
>                  * released.
>                  *
>                  * The private flag check is essential for subpage as we =
need
> -                * to store extra bitmap using page->private.
> +                * to store extra bitmap using folio private.
>                  */
> -               if (page->mapping !=3D inode->i_mapping || !PagePrivate(p=
age)) {
> +               if (page->mapping !=3D inode->i_mapping ||
> +                   !folio_test_private(folio)) {
>                         unlock_page(page);
>                         return -EAGAIN;
>                 }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9f5a9894f88f..40f64322b1f1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4725,7 +4725,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode,=
 loff_t from, loff_t len,
>         /*
>          * We unlock the page after the io is completed and then re-lock =
it
>          * above.  release_folio() could have come in between that and cl=
eared
> -        * PagePrivate(), but left the page in the mapping.  Set the page=
 mapped
> +        * folio private, but left the page in the mapping.  Set the page=
 mapped
>          * here to make sure it's properly set for the subpage stuff.
>          */
>         ret =3D set_page_extent_mapped(page);
> @@ -7851,13 +7851,14 @@ static void btrfs_readahead(struct readahead_cont=
rol *rac)
>  static void wait_subpage_spinlock(struct page *page)
>  {
>         struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i=
_sb);
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         if (!btrfs_is_subpage(fs_info, page))
>                 return;
>
> -       ASSERT(PagePrivate(page) && page->private);
> -       subpage =3D (struct btrfs_subpage *)page->private;
> +       ASSERT(folio_test_private(folio) && folio_get_private(folio));
> +       subpage =3D folio_get_private(folio);
>
>         /*
>          * This may look insane as we just acquire the spinlock and relea=
se it,
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 1b999c6e4193..72d8dd516db9 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -118,6 +118,7 @@ void btrfs_init_subpage_info(struct btrfs_subpage_inf=
o *subpage_info, u32 sector
>  int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>                          struct page *page, enum btrfs_subpage_type type)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         /*
> @@ -127,28 +128,29 @@ int btrfs_attach_subpage(const struct btrfs_fs_info=
 *fs_info,
>         if (page->mapping)
>                 ASSERT(PageLocked(page));
>
> -       /* Either not subpage, or the page already has private attached *=
/
> -       if (!btrfs_is_subpage(fs_info, page) || PagePrivate(page))
> +       /* Either not subpage, or the folio already has private attached =
*/
> +       if (!btrfs_is_subpage(fs_info, page) || folio_test_private(folio)=
)
>                 return 0;
>
>         subpage =3D btrfs_alloc_subpage(fs_info, type);
>         if (IS_ERR(subpage))
>                 return  PTR_ERR(subpage);
>
> -       attach_page_private(page, subpage);
> +       folio_attach_private(folio, subpage);
>         return 0;
>  }
>
>  void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
>                           struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         /* Either not subpage, or already detached */
> -       if (!btrfs_is_subpage(fs_info, page) || !PagePrivate(page))
> +       if (!btrfs_is_subpage(fs_info, page) || !folio_test_private(folio=
))
>                 return;
>
> -       subpage =3D detach_page_private(page);
> +       subpage =3D folio_detach_private(folio);
>         ASSERT(subpage);
>         btrfs_free_subpage(subpage);
>  }
> @@ -188,36 +190,38 @@ void btrfs_free_subpage(struct btrfs_subpage *subpa=
ge)
>   * This is important for eb allocation, to prevent race with last eb fre=
eing
>   * of the same page.
>   * With the eb_refs increased before the eb inserted into radix tree,
> - * detach_extent_buffer_page() won't detach the page private while we're=
 still
> + * detach_extent_buffer_page() won't detach the folio private while we'r=
e still
>   * allocating the extent buffer.
>   */
>  void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
>                             struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         if (!btrfs_is_subpage(fs_info, page))
>                 return;
>
> -       ASSERT(PagePrivate(page) && page->mapping);
> +       ASSERT(folio_test_private(folio) && page->mapping);
>         lockdep_assert_held(&page->mapping->private_lock);
>
> -       subpage =3D (struct btrfs_subpage *)page->private;
> +       subpage =3D folio_get_private(folio);
>         atomic_inc(&subpage->eb_refs);
>  }
>
>  void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
>                             struct page *page)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         if (!btrfs_is_subpage(fs_info, page))
>                 return;
>
> -       ASSERT(PagePrivate(page) && page->mapping);
> +       ASSERT(folio_test_private(folio) && page->mapping);
>         lockdep_assert_held(&page->mapping->private_lock);
>
> -       subpage =3D (struct btrfs_subpage *)page->private;
> +       subpage =3D folio_get_private(folio);
>         ASSERT(atomic_read(&subpage->eb_refs));
>         atomic_dec(&subpage->eb_refs);
>  }
> @@ -225,8 +229,10 @@ void btrfs_page_dec_eb_refs(const struct btrfs_fs_in=
fo *fs_info,
>  static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> +       struct folio *folio =3D page_folio(page);
> +
>         /* Basic checks */
> -       ASSERT(PagePrivate(page) && page->private);
> +       ASSERT(folio_test_private(folio) && folio_get_private(folio));
>         ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
>                IS_ALIGNED(len, fs_info->sectorsize));
>         /*
> @@ -241,7 +247,8 @@ static void btrfs_subpage_assert(const struct btrfs_f=
s_info *fs_info,
>  void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         const int nbits =3D len >> fs_info->sectorsize_bits;
>
>         btrfs_subpage_assert(fs_info, page, start, len);
> @@ -252,7 +259,8 @@ void btrfs_subpage_start_reader(const struct btrfs_fs=
_info *fs_info,
>  void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         const int nbits =3D len >> fs_info->sectorsize_bits;
>         bool is_data;
>         bool last;
> @@ -294,7 +302,8 @@ static void btrfs_subpage_clamp_range(struct page *pa=
ge, u64 *start, u32 *len)
>  void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         const int nbits =3D (len >> fs_info->sectorsize_bits);
>         int ret;
>
> @@ -308,7 +317,8 @@ void btrfs_subpage_start_writer(const struct btrfs_fs=
_info *fs_info,
>  bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_in=
fo,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         const int nbits =3D (len >> fs_info->sectorsize_bits);
>
>         btrfs_subpage_assert(fs_info, page, start, len);
> @@ -340,12 +350,14 @@ bool btrfs_subpage_end_and_test_writer(const struct=
 btrfs_fs_info *fs_info,
>  int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> +       struct folio *folio =3D page_folio(page);
> +
>         if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {
>                 lock_page(page);
>                 return 0;
>         }
>         lock_page(page);
> -       if (!PagePrivate(page) || !page->private) {
> +       if (!folio_test_private(folio) || !folio_get_private(folio)) {
>                 unlock_page(page);
>                 return -EAGAIN;
>         }
> @@ -387,7 +399,8 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs=
_info *fs_info,
>  void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         uptodate, start, =
len);
>         unsigned long flags;
> @@ -402,7 +415,8 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs=
_info *fs_info,
>  void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         uptodate, start, =
len);
>         unsigned long flags;
> @@ -416,7 +430,8 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_=
fs_info *fs_info,
>  void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         dirty, start, len=
);
>         unsigned long flags;
> @@ -440,7 +455,8 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_in=
fo *fs_info,
>  bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_i=
nfo,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         dirty, start, len=
);
>         unsigned long flags;
> @@ -467,7 +483,8 @@ void btrfs_subpage_clear_dirty(const struct btrfs_fs_=
info *fs_info,
>  void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         writeback, start,=
 len);
>         unsigned long flags;
> @@ -481,7 +498,8 @@ void btrfs_subpage_set_writeback(const struct btrfs_f=
s_info *fs_info,
>  void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         writeback, start,=
 len);
>         unsigned long flags;
> @@ -498,7 +516,8 @@ void btrfs_subpage_clear_writeback(const struct btrfs=
_fs_info *fs_info,
>  void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         ordered, start, l=
en);
>         unsigned long flags;
> @@ -512,7 +531,8 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_=
info *fs_info,
>  void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
>                 struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         ordered, start, l=
en);
>         unsigned long flags;
> @@ -527,7 +547,8 @@ void btrfs_subpage_clear_ordered(const struct btrfs_f=
s_info *fs_info,
>  void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
>                                struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         checked, start, l=
en);
>         unsigned long flags;
> @@ -542,7 +563,8 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_=
info *fs_info,
>  void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
>                                  struct page *page, u64 start, u32 len)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page,
>                                                         checked, start, l=
en);
>         unsigned long flags;
> @@ -561,7 +583,8 @@ void btrfs_subpage_clear_checked(const struct btrfs_f=
s_info *fs_info,
>  bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,    \
>                 struct page *page, u64 start, u32 len)                  \
>  {                                                                      \
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate; \
> +       struct folio *folio =3D page_folio(page);                        =
 \
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);      =
 \
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, page, =
 \
>                                                 name, start, len);      \
>         unsigned long flags;                                            \
> @@ -656,7 +679,8 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, SetPageChecked, Cle=
arPageChecked, PageChecked)
>  void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>                                  struct page *page)
>  {
> -       struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->p=
rivate;
> +       struct folio *folio =3D page_folio(page);
> +       struct btrfs_subpage *subpage =3D folio_get_private(folio);
>
>         if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
>                 return;
> @@ -665,7 +689,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_f=
s_info *fs_info,
>         if (!btrfs_is_subpage(fs_info, page))
>                 return;
>
> -       ASSERT(PagePrivate(page) && page->private);
> +       ASSERT(folio_test_private(folio) && folio_get_private(folio));
>         ASSERT(subpage_test_bitmap_all_zero(fs_info, subpage, dirty));
>  }
>
> @@ -687,6 +711,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_f=
s_info *fs_info,
>  void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page=
 *page,
>                               u64 start, u32 len)
>  {
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>
>         ASSERT(PageLocked(page));
> @@ -694,8 +719,8 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *f=
s_info, struct page *page,
>         if (!btrfs_is_subpage(fs_info, page))
>                 return unlock_page(page);
>
> -       ASSERT(PagePrivate(page) && page->private);
> -       subpage =3D (struct btrfs_subpage *)page->private;
> +       ASSERT(folio_test_private(folio) && folio_get_private(folio));
> +       subpage =3D folio_get_private(folio);
>
>         /*
>          * For subpage case, there are two types of locked page.  With or
> @@ -720,6 +745,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct bt=
rfs_fs_info *fs_info,
>                                       struct page *page, u64 start, u32 l=
en)
>  {
>         struct btrfs_subpage_info *subpage_info =3D fs_info->subpage_info=
;
> +       struct folio *folio =3D page_folio(page);
>         struct btrfs_subpage *subpage;
>         unsigned long uptodate_bitmap;
>         unsigned long error_bitmap;
> @@ -729,9 +755,9 @@ void __cold btrfs_subpage_dump_bitmap(const struct bt=
rfs_fs_info *fs_info,
>         unsigned long checked_bitmap;
>         unsigned long flags;
>
> -       ASSERT(PagePrivate(page) && page->private);
> +       ASSERT(folio_test_private(folio) && folio_get_private(folio));
>         ASSERT(subpage_info);
> -       subpage =3D (struct btrfs_subpage *)page->private;
> +       subpage =3D folio_get_private(folio);
>
>         spin_lock_irqsave(&subpage->lock, flags);
>         GET_SUBPAGE_BITMAP(subpage, subpage_info, uptodate, &uptodate_bit=
map);
> --
> 2.42.1
>
>

Patch makes sense to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

