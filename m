Return-Path: <linux-btrfs+bounces-12487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81516A6BAD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 13:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A360C3BDC94
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED1226D15;
	Fri, 21 Mar 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXQ0ZnBU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D38CA5A
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560716; cv=none; b=OTRrrZM/jdghJ0wDvgw6e5er/gOT8/BtkAgjY93dQaEWB1xS39XQMtKH3Gs66Db0H1uHo609mBBa25l7WxcfHVp5+BOb3puVbBgxk+x0GbaRiBIWYE1M1M+9jJjOPkEfEuVcwz1PaIfT0NeONWeZe5knxfNJEz+J73t5eeAwuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560716; c=relaxed/simple;
	bh=bzxtQWljjZ+IoAwrIfqrh5bGfb6OULYvpmQTe9CAaes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moJ4hZ4ThRBg5bxVxWOTOH7dOgzN/0KRqsxuXVugqhCDhbbs9pKv2L52NrNdlwfaC2zwt/PRwVRyThIbti3diuhA/xZ58jeOwwJnAeKpzpgdioS1Giq2wuE7XOC31FevHAKUfA0Z2cm048NiKp+1U268EJe6AtM4RInBDxZG36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXQ0ZnBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58234C4CEE7
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 12:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742560715;
	bh=bzxtQWljjZ+IoAwrIfqrh5bGfb6OULYvpmQTe9CAaes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jXQ0ZnBUyhrCll8KculgJS3xZvNI7JMoVsLWY7HcGExYdX3vQ7c50rv0b8A/JwXq+
	 qSTAQtLwD7/l0RUdehGQZeJvCCxtHUyhCCLyrL56a26vDK89ZzbSCwCzE2TAO4J/Jy
	 lll1bYRGzhnwj01talGjhlJG2OMGeEhO10tztuvl/ZtAfOrj7F354yPU5XZrXpJXHD
	 gxK7112KejdYSARbpeNo7ET4IEI8QJeIMK0I92Nqmq2lB/6eDR02AVJTQhbBCCaIDL
	 gDv00a0X9NrZIOVy+jCM8TzCtVanb8Om8T/wEO8jPCE1cbaGPU32aoE53JZyo9ppt7
	 AXL40G5fw4GMA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab771575040so595657666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 05:38:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8n4EFR3idkVeazGayouJF7+/FUuaYuoTPa8tpGmFNX5w3iuhz
	5dqfqxteXMzvuNuJlcBI1DUCgiAc+CJkRJK02VqkQpmu+s5ZJuZGZnkycFzlEHPj0P7SfUA0swi
	jmE0fLIH1e/tDViLr5zl1zmTRTIY=
X-Google-Smtp-Source: AGHT+IFZ2hkcow4ZKZj1OmGdRmTXzV9D/s2kM6o8UrbRWh8YZoAhdZnyQN2OPwat4dxtg3gNMBTPkK/RTWcswro0YzE=
X-Received: by 2002:a17:906:fe05:b0:ac1:791c:153a with SMTP id
 a640c23a62f3a-ac3f042fc4bmr271772566b.27.1742560713765; Fri, 21 Mar 2025
 05:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742443383.git.wqu@suse.com> <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
In-Reply-To: <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Mar 2025 12:37:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5r5U1_aYcScvcLr3f3g8V6QDnxTPRonOGoDrNS+9L=ww@mail.gmail.com>
X-Gm-Features: AQ5f1Jradh9FcMThDvpxx2oH2yGYRarpKH4rVZ-gai-oD4p_vdJALoL2vEdIy5w
Message-ID: <CAL3q7H5r5U1_aYcScvcLr3f3g8V6QDnxTPRonOGoDrNS+9L=ww@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: extract the main loop of btrfs_buffered_write()
 into a helper
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:35=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Inside the main loop of btrfs_buffered_write() we are doing a lot of
> heavy lift work inside a while () loop.
>
> This makes it pretty hard to read, extract the content into a helper,
> copy_one_range() to do the heavy lift work.
>
> This has no functional change, but with some minor variable renames,
> e.g. rename all "sector" into "block".
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 292 ++++++++++++++++++++++++------------------------
>  1 file changed, 147 insertions(+), 145 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 99580ef906a6..21b90ed3e0e4 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1153,21 +1153,161 @@ static ssize_t reserve_space(struct btrfs_inode =
*inode,
>         return reserve_bytes;
>  }
>
> +/*
> + * Do the heavy lift work to copy one range into one folio of the page c=
ache.
> + *
> + * Return >=3D0 for the number of bytes copied. (Return 0 means no byte =
is copied,
> + * caller should retry the same range again).

Return > 0 in case we copied all bytes or just some of them.
Return 0 if no bytes were copied, in which case the caller should retry.
Return < 0 on error.

> + * Return <0 for error.

Using space both before and after the comparison operator makes it
easier to the eyes and consistent with the code style.
I.e.  "< 0" instead of "<0".

> + */
> +static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
> +                         struct extent_changeset **data_reserved,
> +                         u64 start, bool nowait)
> +{
> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +       struct extent_state *cached_state =3D NULL;
> +       const size_t block_offset =3D start & (fs_info->sectorsize - 1);
> +       size_t write_bytes =3D min(iov_iter_count(i), PAGE_SIZE - offset_=
in_page(start));
> +       size_t reserve_bytes;
> +       size_t copied;
> +       size_t dirty_blocks;
> +       size_t num_blocks;
> +       struct folio *folio =3D NULL;
> +       u64 release_bytes =3D 0;
> +       int extents_locked;
> +       u64 lockstart;
> +       u64 lockend;
> +       bool only_release_metadata =3D false;
> +       const unsigned int bdp_flags =3D (nowait ? BDP_ASYNC : 0);
> +       int ret;
> +
> +       /*
> +        * Fault pages before locking them in prepare_one_folio()
> +        * to avoid recursive lock
> +        */

Since we are moving this comment, we can take the chance to make the
line length much closer to the 80 character width limit.
Also finish the sentence with punctuation to make it consistent with
the style we prefer.

> +       if (unlikely(fault_in_iov_iter_readable(i, write_bytes)))
> +               return -EFAULT;
> +       extent_changeset_release(*data_reserved);
> +       ret =3D reserve_space(inode, data_reserved, start, &write_bytes, =
nowait,
> +                           &only_release_metadata);
> +       if (ret < 0)
> +               return ret;
> +       reserve_bytes =3D ret;
> +       release_bytes =3D reserve_bytes;
> +
> +again:
> +       ret =3D balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_=
mapping,
> +                                                   bdp_flags);
> +       if (ret) {
> +               btrfs_delalloc_release_extents(inode, reserve_bytes);
> +               release_space(inode, *data_reserved, start, release_bytes=
,
> +                             only_release_metadata);
> +               return ret;
> +       }
> +
> +       ret =3D prepare_one_folio(&inode->vfs_inode, &folio, start, write=
_bytes, false);
> +       if (ret) {
> +               btrfs_delalloc_release_extents(inode, reserve_bytes);
> +               release_space(inode, *data_reserved, start, release_bytes=
,
> +                             only_release_metadata);
> +               return ret;
> +       }
> +       extents_locked =3D lock_and_cleanup_extent_if_need(inode,
> +                                       folio, start, write_bytes, &locks=
tart,
> +                                       &lockend, nowait, &cached_state);
> +       if (extents_locked < 0) {
> +               if (!nowait && extents_locked =3D=3D -EAGAIN)
> +                       goto again;
> +
> +               btrfs_delalloc_release_extents(inode, reserve_bytes);
> +               release_space(inode, *data_reserved, start, release_bytes=
,
> +                             only_release_metadata);
> +               ret =3D extents_locked;
> +               return ret;
> +       }
> +
> +       copied =3D copy_folio_from_iter_atomic(folio,
> +                       offset_in_folio(folio, start), write_bytes, i);
> +       flush_dcache_folio(folio);
> +
> +       /*
> +        * If we get a partial write, we can end up with partially
> +        * uptodate page. Although if sector size < page size we can
> +        * handle it, but if it's not sector aligned it can cause
> +        * a lot of complexity, so make sure they don't happen by
> +        * forcing retry this copy.
> +        */

Same here, can make the width closer to 80 characters.

> +       if (unlikely(copied < write_bytes)) {
> +               if (!folio_test_uptodate(folio)) {
> +                       iov_iter_revert(i, copied);
> +                       copied =3D 0;
> +               }
> +       }
> +
> +       num_blocks =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
> +       dirty_blocks =3D round_up(copied + block_offset, fs_info->sectors=
ize);
> +       dirty_blocks =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
> +
> +       if (copied =3D=3D 0)
> +               dirty_blocks =3D 0;
> +
> +       if (num_blocks > dirty_blocks) {
> +               /* release everything except the sectors we dirtied */

Make the first letter capitalized and end with punctuation.

> +               release_bytes -=3D dirty_blocks << fs_info->sectorsize_bi=
ts;
> +               if (only_release_metadata) {
> +                       btrfs_delalloc_release_metadata(inode,
> +                                               release_bytes, true);
> +               } else {
> +                       u64 release_start =3D round_up(start + copied,
> +                                                    fs_info->sectorsize)=
;

Also add a blank line to separate variable declaration from code.
This is the style we follow nowadays.
Could also be made const.

> +                       btrfs_delalloc_release_space(inode,
> +                                       *data_reserved, release_start,
> +                                       release_bytes, true);
> +               }
> +       }
> +       release_bytes =3D round_up(copied + block_offset, fs_info->sector=
size);
> +
> +       ret =3D btrfs_dirty_folio(inode, folio, start, copied,
> +                               &cached_state, only_release_metadata);
> +       /*
> +        * If we have not locked the extent range, because the range's
> +        * start offset is >=3D i_size, we might still have a non-NULL
> +        * cached extent state, acquired while marking the extent range
> +        * as delalloc through btrfs_dirty_page(). Therefore free any
> +        * possible cached extent state to avoid a memory leak.
> +        */
> +       if (extents_locked)
> +               unlock_extent(&inode->io_tree, lockstart, lockend,
> +                             &cached_state);
> +       else
> +               free_extent_state(cached_state);
> +
> +       btrfs_delalloc_release_extents(inode, reserve_bytes);
> +       if (ret) {
> +               btrfs_drop_folio(fs_info, folio, start, copied);
> +               release_space(inode, *data_reserved, start, release_bytes=
,
> +                             only_release_metadata);
> +               return ret;
> +       }
> +       if (only_release_metadata)
> +               btrfs_check_nocow_unlock(inode);
> +
> +       btrfs_drop_folio(fs_info, folio, start, copied);
> +       cond_resched();

It doesn't make sense to have the cond_resched() in this function - it
should be inside the while loop of the caller.

With these small things addressed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +       return copied;
> +}
> +
>  ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>  {
>         struct file *file =3D iocb->ki_filp;
>         loff_t pos;
>         struct inode *inode =3D file_inode(file);
> -       struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
>         struct extent_changeset *data_reserved =3D NULL;
> -       u64 lockstart;
> -       u64 lockend;
>         size_t num_written =3D 0;
>         ssize_t ret;
>         loff_t old_isize;
>         unsigned int ilock_flags =3D 0;
>         const bool nowait =3D (iocb->ki_flags & IOCB_NOWAIT);
> -       unsigned int bdp_flags =3D (nowait ? BDP_ASYNC : 0);
>
>         if (nowait)
>                 ilock_flags |=3D BTRFS_ILOCK_TRY;
> @@ -1193,149 +1333,11 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb,=
 struct iov_iter *i)
>
>         pos =3D iocb->ki_pos;
>         while (iov_iter_count(i) > 0) {
> -               struct extent_state *cached_state =3D NULL;
> -               size_t offset =3D offset_in_page(pos);
> -               size_t sector_offset;
> -               size_t write_bytes =3D min(iov_iter_count(i), PAGE_SIZE -=
 offset);
> -               size_t reserve_bytes;
> -               size_t copied;
> -               size_t dirty_sectors;
> -               size_t num_sectors;
> -               struct folio *folio =3D NULL;
> -               u64 release_bytes =3D 0;
> -               int extents_locked;
> -               bool only_release_metadata =3D false;
> -
> -               /*
> -                * Fault pages before locking them in prepare_one_folio()
> -                * to avoid recursive lock
> -                */
> -               if (unlikely(fault_in_iov_iter_readable(i, write_bytes)))=
 {
> -                       ret =3D -EFAULT;
> -                       break;
> -               }
> -
> -               sector_offset =3D pos & (fs_info->sectorsize - 1);
> -
> -               extent_changeset_release(data_reserved);
> -               ret =3D reserve_space(BTRFS_I(inode), &data_reserved, pos=
,
> -                                   &write_bytes, nowait,
> -                                   &only_release_metadata);
> +               ret =3D copy_one_range(BTRFS_I(inode), i, &data_reserved,=
 pos, nowait);
>                 if (ret < 0)
>                         break;
> -               reserve_bytes =3D ret;
> -               release_bytes =3D reserve_bytes;
> -again:
> -               ret =3D balance_dirty_pages_ratelimited_flags(inode->i_ma=
pping, bdp_flags);
> -               if (ret) {
> -                       btrfs_delalloc_release_extents(BTRFS_I(inode), re=
serve_bytes);
> -                       release_space(BTRFS_I(inode), data_reserved,
> -                                     pos, release_bytes, only_release_me=
tadata);
> -                       break;
> -               }
> -
> -               ret =3D prepare_one_folio(inode, &folio, pos, write_bytes=
, false);
> -               if (ret) {
> -                       btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      reserve_bytes);
> -                       release_space(BTRFS_I(inode), data_reserved,
> -                                     pos, release_bytes, only_release_me=
tadata);
> -                       break;
> -               }
> -
> -               extents_locked =3D lock_and_cleanup_extent_if_need(BTRFS_=
I(inode),
> -                                               folio, pos, write_bytes, =
&lockstart,
> -                                               &lockend, nowait, &cached=
_state);
> -               if (extents_locked < 0) {
> -                       if (!nowait && extents_locked =3D=3D -EAGAIN)
> -                               goto again;
> -
> -                       btrfs_delalloc_release_extents(BTRFS_I(inode),
> -                                                      reserve_bytes);
> -                       release_space(BTRFS_I(inode), data_reserved,
> -                                     pos, release_bytes, only_release_me=
tadata);
> -                       ret =3D extents_locked;
> -                       break;
> -               }
> -
> -               copied =3D copy_folio_from_iter_atomic(folio,
> -                               offset_in_folio(folio, pos), write_bytes,=
 i);
> -               flush_dcache_folio(folio);
> -
> -               /*
> -                * If we get a partial write, we can end up with partiall=
y
> -                * uptodate page. Although if sector size < page size we =
can
> -                * handle it, but if it's not sector aligned it can cause
> -                * a lot of complexity, so make sure they don't happen by
> -                * forcing retry this copy.
> -                */
> -               if (unlikely(copied < write_bytes)) {
> -                       if (!folio_test_uptodate(folio)) {
> -                               iov_iter_revert(i, copied);
> -                               copied =3D 0;
> -                       }
> -               }
> -
> -               num_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, reserve_byte=
s);
> -               dirty_sectors =3D round_up(copied + sector_offset,
> -                                       fs_info->sectorsize);
> -               dirty_sectors =3D BTRFS_BYTES_TO_BLKS(fs_info, dirty_sect=
ors);
> -
> -               if (copied =3D=3D 0)
> -                       dirty_sectors =3D 0;
> -
> -               if (num_sectors > dirty_sectors) {
> -                       /* release everything except the sectors we dirti=
ed */
> -                       release_bytes -=3D dirty_sectors << fs_info->sect=
orsize_bits;
> -                       if (only_release_metadata) {
> -                               btrfs_delalloc_release_metadata(BTRFS_I(i=
node),
> -                                                       release_bytes, tr=
ue);
> -                       } else {
> -                               u64 release_start =3D round_up(pos + copi=
ed,
> -                                                            fs_info->sec=
torsize);
> -                               btrfs_delalloc_release_space(BTRFS_I(inod=
e),
> -                                               data_reserved, release_st=
art,
> -                                               release_bytes, true);
> -                       }
> -               }
> -
> -               release_bytes =3D round_up(copied + sector_offset,
> -                                       fs_info->sectorsize);
> -
> -               ret =3D btrfs_dirty_folio(BTRFS_I(inode), folio, pos, cop=
ied,
> -                                       &cached_state, only_release_metad=
ata);
> -
> -               /*
> -                * If we have not locked the extent range, because the ra=
nge's
> -                * start offset is >=3D i_size, we might still have a non=
-NULL
> -                * cached extent state, acquired while marking the extent=
 range
> -                * as delalloc through btrfs_dirty_page(). Therefore free=
 any
> -                * possible cached extent state to avoid a memory leak.
> -                */
> -               if (extents_locked)
> -                       unlock_extent(&BTRFS_I(inode)->io_tree, lockstart=
,
> -                                     lockend, &cached_state);
> -               else
> -                       free_extent_state(cached_state);
> -
> -               btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_by=
tes);
> -               if (ret) {
> -                       btrfs_drop_folio(fs_info, folio, pos, copied);
> -                       release_space(BTRFS_I(inode), data_reserved,
> -                                     pos, release_bytes, only_release_me=
tadata);
> -                       break;
> -               }
> -
> -               release_bytes =3D 0;
> -               if (only_release_metadata)
> -                       btrfs_check_nocow_unlock(BTRFS_I(inode));
> -
> -               btrfs_drop_folio(fs_info, folio, pos, copied);
> -
> -               cond_resched();
> -
> -               pos +=3D copied;
> -               num_written +=3D copied;
> +               pos +=3D ret;
> +               num_written +=3D ret;
>         }
>
>         extent_changeset_free(data_reserved);
> --
> 2.49.0
>
>

