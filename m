Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63C3331BFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 02:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCIBCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Mar 2021 20:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCIBBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Mar 2021 20:01:43 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE73AC06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Mar 2021 17:01:42 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id 7so2614132vke.5
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Mar 2021 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R/Y0qgTWIYNAvsv5vtdM+rBGdhStk0nJNC/yqKzouB4=;
        b=l3V6317NZz4DGGKd+PMrYXQ6KcT3WFMVk746v7LHG9ssP6mpH77nlUtU22LHcdvLEp
         RqS6omTOGdl+/ManrNUrVAKZ2WfE1d1cPvpMvBSVJkb+l+Sf3UnjX0irNGVd6ztLiH65
         v8bd6ofs/GbKXHfmZY81dNNNt/q/2KdtxNS1JCHrKLIL/jqqqP0/yhpQKuG7r2tk4JJz
         4rQ6j4IVtPwH8lro8NBziutehcT3p2BuHxKxxEK22INHAR5B8T8x3tt2lD1NRfftMUmM
         Sf/d+xriAbLrkYXiKIZSTD/1rkK7ceB7YZMctNHTUrsI2khnJLpj3kOMZQrMIghFhTdV
         Gs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R/Y0qgTWIYNAvsv5vtdM+rBGdhStk0nJNC/yqKzouB4=;
        b=ADM0LLslxia0mzJe2vmh49E19isbz+bitISfplEsOlrCiz/ypgkjFy1ZA2IVXy2aGk
         JA97nOHwpnicB5RAuyyGmDGT8C3h49XJDfebZTpoo/gHpa974HYfmnUPAzyE0V7n17tr
         aMeV5xbpkcm90lgma3ak8oV/pqbbqxbDFwpNAv+/5WmEp0vP+LTvTh3KIQwJ/0gw09Ur
         v8+KErXctnM2N4gICE7+AK7cjh518wSrFDi0RT2PeiyibabeLOoF1pGiGlNQecJS2D2K
         hmx008RKIFiCwIWBlQcP4vZp90hFqy+P9fQH23So01hBoehZRxHfFE7+sAf9k8cXHN+C
         8qdg==
X-Gm-Message-State: AOAM531djJWSWU3+K7cUO2Imh4G1x2+u9gmAhJqGemuQDpI7yd4rR1j9
        HMgjnyiPzMJ4oZ8WFlh0ugNT+uqk0jN5m/DVm6U7fe/FjO5j9cwP
X-Google-Smtp-Source: ABdhPJy1cPfjOx6i7K9+HVID2+r2uQ379TiSlsRy3Ogb7s7DL/wydYQHawZFukaSIWFL+QGqOjnHSfhahAAZnhScv1M=
X-Received: by 2002:a1f:9ed8:: with SMTP id h207mr15309924vke.13.1615251701731;
 Mon, 08 Mar 2021 17:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20200804072548.34001-1-wqu@suse.com> <20200804072548.34001-2-wqu@suse.com>
In-Reply-To: <20200804072548.34001-2-wqu@suse.com>
From:   Su Yue <damenly.su@gmail.com>
Date:   Tue, 9 Mar 2021 09:02:02 +0800
Message-ID: <CABnRu57qmjkmDd=iX76Rz8y1smmUgV+YnD4XvT4UKKk=Dmggew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: prevent NULL pointer dereference in
 compress_file_range() when btrfs_compress_pages() hits default case
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 4, 2020 at 3:29 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running btrfs/071 with inode_need_compress() removed from
> compress_file_range(), we got the following crash:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>   RIP: 0010:compress_file_range+0x476/0x7b0 [btrfs]
>   Call Trace:
>    ? submit_compressed_extents+0x450/0x450 [btrfs]
>    async_cow_start+0x16/0x40 [btrfs]
>    btrfs_work_helper+0xf2/0x3e0 [btrfs]
>    process_one_work+0x278/0x5e0
>    worker_thread+0x55/0x400
>    ? process_one_work+0x5e0/0x5e0
>    kthread+0x168/0x190
>    ? kthread_create_worker_on_cpu+0x70/0x70
>    ret_from_fork+0x22/0x30
>   ---[ end trace 65faf4eae941fa7d ]---
>
Ping=EF=BC=9F
The bug occurred while running btrfs/074 days ago. And the fix
looks reasonable.

--
Su
> This is already after the patch "btrfs: inode: fix NULL pointer
> dereference if inode doesn't need compression."
>
> [CAUSE]
> @pages is firstly created by kcalloc() in compress_file_extent():
>                 pages =3D kcalloc(nr_pages, sizeof(struct page *), GFP_NO=
FS);
>
> Then passed to btrfs_compress_pages() to be utilized there:
>
>                 ret =3D btrfs_compress_pages(...
>                                            pages,
>                                            &nr_pages,
>                                            ...);
>
> btrfs_compress_pages() will initial each pages as output, in
> zlib_compress_pages() we have:
>
>                         pages[nr_pages] =3D out_page;
>                         nr_pages++;
>
> Normally this is completely fine, but there is a special case which
> is in btrfs_compress_pages() itself:
>         switch (type) {
>         default:
>                 return -E2BIG;
>         }
>
> In this case, we didn't modify @pages nor @out_pages, leaving them
> untouched, then when we cleanup pages, the we can hit NULL pointer
> dereference again:
>
>         if (pages) {
>                 for (i =3D 0; i < nr_pages; i++) {
>                         WARN_ON(pages[i]->mapping);
>                         put_page(pages[i]);
>                 }
>         ...
>         }
>
> Since pages[i] are all initialized to zero, and btrfs_compress_pages()
> doesn't change them at all, accessing pages[i]->mapping would lead to
> NULL pointer dereference.
>
> This is not possible for current kernel, as we check
> inode_need_compress() before doing pages allocation.
> But if we're going to remove that inode_need_compress() in
> compress_file_extent(), then it's going to be a problem.
>
> [FIX]
> When btrfs_compress_pages() hits its default case, modify @out_pages to
> 0 to prevent such problem from happening.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1ab56a734e70..17c27edd804b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -115,10 +115,14 @@ static int compression_compress_pages(int type, str=
uct list_head *ws,
>         case BTRFS_COMPRESS_NONE:
>         default:
>                 /*
> -                * This can't happen, the type is validated several times
> -                * before we get here. As a sane fallback, return what th=
e
> -                * callers will understand as 'no compression happened'.
> +                * This happens when compression races with remount to no
> +                * compress, while caller doesn't call inode_need_compres=
s()
> +                * to check if we really need to compress.
> +                *
> +                * Not a big deal, just need to inform caller that we
> +                * haven't allocated any pages yet.
>                  */
> +               *out_pages =3D 0;
>                 return -E2BIG;
>         }
>  }
> --
> 2.28.0
>
