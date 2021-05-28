Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE1393F61
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhE1JJe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbhE1JIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 05:08:53 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F93C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:07:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o3so3404830qke.7
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=k+WSP1vmkx55Tdl/WjucHVETqF1PW1Z0ly9vf1t/B+s=;
        b=Y6XYwTCWnHJCuu8k20BufeSro823d235IrNo8tPcEUfEuKwTf9ZgARppz1Ca7UURu7
         gkFWlLeY5ldPHNVL9IJj/qTCVBx8goBEY1yOKgXs6lkP26pvGZH+epYVa2kipx6v7MR1
         cRXcKH1xQlChs8gR/9WELgNuYxny/gD4VXuePD7wWbIrqTk2Ccb5yBZBo4JdwrEasE6U
         CsXmZJbsjsddHtw2JokC6aQx63xyqYa6W2z5alnstFa3TrCYrHFMIsxd3q6/xrgUhETE
         f+MllhEyfXDzg0scc1HfKIPhBaI11qHGtudSLwEU43NVMDteQKRV7sNesAqT3BVW3MIQ
         9ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=k+WSP1vmkx55Tdl/WjucHVETqF1PW1Z0ly9vf1t/B+s=;
        b=cocNHzuURuf8J9g1AtznWa4KvPc8t+ZlhLXlxyvKjWQj5yE+KZ583XIJ5hnmUZh4E0
         jGL1bDeBaKsTRD2vVmPFWoEGYhIluJD4qBqR/i2nxIX3IyQrVLyhwCXnEa1p796ObDfL
         t57LcbeZKkGyuNHvZmflxXj2tJB9BKYwJTQSX6DyXSE3+GMfh8BMK0XSECrQC2zdv7YY
         8nfEbh3vHYzD79rHtDfBNWARs4JXB/nqwSFATKKELVRoTqbfYI6hqt2KaSXOKC/MMomm
         d+VEXddwYHFvTwuDs4LRT+mJVcrwREe3Dcs2O+4PzVzfliXOnOzvVtzElhZ2fZQAjtOu
         oJZA==
X-Gm-Message-State: AOAM530QW81OK9VaOKJ3FYKMBr6asdixv1B0POFU+otGgah2OU3zsXeX
        CfrfIDHNHBNm3KX0jewGRbJdEl5j1kckWoFyiaGIVisOpac=
X-Google-Smtp-Source: ABdhPJw+iTbaP6+QUeDvgkEQS3FoLtvJD8T519dYFFRzb8sdX1jNr3NggFprdR08hy5PBoEy4+5S21uPurMY/rQXXEI=
X-Received: by 2002:ae9:dfc4:: with SMTP id t187mr2896714qkf.0.1622192838172;
 Fri, 28 May 2021 02:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210528022821.81386-1-wqu@suse.com> <20210528022821.81386-5-wqu@suse.com>
In-Reply-To: <20210528022821.81386-5-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 28 May 2021 10:07:07 +0100
Message-ID: <CAL3q7H55XRQ5zr3g-brs=eS_kMOb6orsCPYDP7Jr0JxJ45hNOw@mail.gmail.com>
Subject: Re: [PATCH 4/7] btrfs: defrag: introduce a helper to defrag a
 continuous range
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 28, 2021 at 7:00 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Intrudouce a helper, defrag_one_target(), to defrag one continuous range
> by:
>
> - Lock and read the page
> - Set the extent range defrag
> - Set the involved page range dirty
>
> There is a special note here, since the target range may be a hole now,
> we use btrfs_set_extent_delalloc() with EXTENT_DEFRAG as @extra_bits,
> other than set_extent_defrag().
>
> This would properly add EXTENT_DELALLOC_NEW bit to make inode nbytes
> updated properly, and still handle regular extents without any problem.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 1e57293a05f2..cd7650bcc70c 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1486,6 +1486,82 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>         return ret;
>  }
>
> +#define CLUSTER_SIZE   (SZ_256K)
> +static int defrag_one_target(struct btrfs_inode *inode,
> +                            struct file_ra_state *ra, u64 start, u32 len=
)
> +{
> +       struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +       struct extent_changeset *data_reserved =3D NULL;
> +       struct extent_state *cached_state =3D NULL;
> +       struct page **pages;
> +       const u32 sectorsize =3D inode->root->fs_info->sectorsize;
> +       unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
> +       unsigned long start_index =3D start >> PAGE_SHIFT;
> +       unsigned int nr_pages =3D last_index - start_index + 1;
> +       int ret =3D 0;
> +       int i;
> +
> +       ASSERT(nr_pages <=3D CLUSTER_SIZE / PAGE_SIZE);
> +       ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsiz=
e));
> +
> +       pages =3D kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
> +       if (!pages)
> +               return -ENOMEM;
> +
> +       /* Kick in readahead */
> +       if (ra)
> +               page_cache_sync_readahead(inode->vfs_inode.i_mapping, ra,=
 NULL,
> +                                         start_index, nr_pages);
> +
> +       /* Prepare all pages */
> +       for (i =3D 0; i < nr_pages; i++) {
> +               pages[i] =3D defrag_prepare_one_page(inode, start_index +=
 i);
> +               if (IS_ERR(pages[i])) {
> +                       ret =3D PTR_ERR(pages[i]);
> +                       pages[i] =3D NULL;
> +                       goto free_pages;
> +               }
> +       }
> +       ret =3D btrfs_delalloc_reserve_space(inode, &data_reserved, start=
, len);
> +       if (ret < 0)
> +               goto free_pages;
> +
> +       /* Lock the extent bits and update the extent bits*/
> +       lock_extent_bits(&inode->io_tree, start, start + len - 1,
> +                        &cached_state);
> +       clear_extent_bit(&inode->io_tree, start, start + len - 1,
> +                        EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_=
DEFRAG,
> +                        0, 0, &cached_state);
> +
> +       /*
> +        * Since the target list is gathered without inode nor extent loc=
k, we
> +        * may get a range which is now a hole.

You are undoing what was done by commit
7f458a3873ae94efe1f37c8b96c97e7298769e98.
In case there's a hole this results in allocating extents and filling
them with zeroes, doing unnecessary IO and using disk space.
Please add back the logic to skip defrag if it's now a hole.

Thanks.

> +        * In that case, we have to set it with DELALLOC_NEW as if we're
> +        * writing a new data, or inode nbytes will mismatch.
> +        */
> +       ret =3D btrfs_set_extent_delalloc(inode, start, start + len - 1,
> +                                       EXTENT_DEFRAG, &cached_state);
> +       /* Update the page status */
> +       for (i =3D 0; i < nr_pages; i++) {
> +               ClearPageChecked(pages[i]);
> +               btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len)=
;
> +       }
> +       unlock_extent_cached(&inode->io_tree, start, start + len - 1,
> +                            &cached_state);
> +       btrfs_delalloc_release_extents(inode, len);
> +       extent_changeset_free(data_reserved);
> +
> +free_pages:
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (pages[i]) {
> +                       unlock_page(pages[i]);
> +                       put_page(pages[i]);
> +               }
> +       }
> +       kfree(pages);
> +       return ret;
> +}
> +
>  /*
>   * Btrfs entrace for defrag.
>   *
> --
> 2.31.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
