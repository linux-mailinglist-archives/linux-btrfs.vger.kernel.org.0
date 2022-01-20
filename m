Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF94E494633
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 04:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiATDjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 22:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiATDjH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 22:39:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED0EC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 19:39:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o12so16423247lfu.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jan 2022 19:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r/Y4IG7wEz/A36rPphhoE4OH8f7LzdcrrSvmj78iC1o=;
        b=C+PI45HPfomG81Ej+dR2ykHEhLSzneAVOVlGxpUqET92fMicrg/BUq/4JLwh+GXDJn
         t3rsS1++/oMadMZA9T/lJ1px1ybEdYQpocGf5tRXoSBlSDQk+TJLe0M1D/zhCU7r7la5
         6taTGL6W7Mf/UGggQciV8BX6jg/dHtGvRp7Zr/PVlZFfT2/rq3gMCMNjonU10Vvd+Iyn
         CpsQ7vY3OTVlB/r6t6SwtQTPhiLPagcUda1gFN1sDcGerRjvy7Yfp0PBY5sROhuaOdSH
         Y32BnP1UYES696Zgjq0B7dTga6EE1E8Fon5jWicJh1UrYmycFNa8EsaHP11dXZVnrKq5
         DdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=r/Y4IG7wEz/A36rPphhoE4OH8f7LzdcrrSvmj78iC1o=;
        b=WVDTkjncOofAi0pIcPcauVxWlZYFt2Jpc6/rbXXX8AwJx0wr1rg40kyoVZNMoVusux
         y4Jz8K/kv8oQTRjlKlOq8YKtiBav0Y04zstyZ0YRqbUDagu3cVfm06OqnsQUvPMXeRac
         eP+h45RXo6K390i62i+1xyxgXzmsq0f1vWjgHixZA7uisnZN+qlOYES1AlthAlF0xP2B
         NFMHLSWu7FNl4gsJqLk2MfA4nH2AQhCBxQrzRmcYY7uRbsj7x0OU5Q1DHqjUvdG8CXEf
         SVrpT3NJjtkoONNBapLU9jE00WWl2I7QCKL2OgNwtzyTnAJCGSEzx+VjEmQZkiPl7QX7
         yzQQ==
X-Gm-Message-State: AOAM5333sXvrY5H3MkdL2xbH7J6NEC0uzeIDtEK40/srJoISnJfpd17w
        cs6YVDw+3iO6XfqMvxo4TYDlrwIFOljn5xNfYqn0JmH2fvyXbQ==
X-Google-Smtp-Source: ABdhPJyRmDTEBGi+Lk4DNTYVGvuWMNvQtrJaIdpUAAKbVoTZp+lhZ3dBRS3Wfc6BEMDi35ffO/AxclQAhPioaeiH1Mc=
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr19958822ljj.141.1642649945420;
 Wed, 19 Jan 2022 19:39:05 -0800 (PST)
MIME-Version: 1.0
References: <1642323083-2088-1-git-send-email-zhanglikernel@gmail.com>
In-Reply-To: <1642323083-2088-1-git-send-email-zhanglikernel@gmail.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Thu, 20 Jan 2022 11:38:53 +0800
Message-ID: <CAAa-AGm3mfehYuE5YUGaq4-inROWsgT4SJh8jxXmG6BH3j3uHA@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: Compresses files using a combination of
 compression type and compression level.
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Allow user set compression type and level by btrfs properties.

Old behavior:
# mount filesystem with compression level 3
$ sudo mount -o compress=3Dzstd:3 /dev/loop1 /mnt/1
# set file would be compressed by zstd and level 11
$ btrfs property set /mnt/1/1 compression zstd:11
# compress would compressed by zstd and level 3(still use filesystem
compression level)
$ cat ~/202109091507_210601004_A_PE150_COVID19_iGeneTech_0909_i_D8_F_L01_R1=
.fq
> /mnt/1/1


New behavior:
# mount filesystem with compression level 3
$ sudo mount -o compress=3Dzstd:3 /dev/loop1 /mnt/1
# set file would be compressed by zstd and level 11
$ btrfs property set /mnt/1/1 compression zstd:11
# compress would compressed by zstd and level 11
$ cat ~/202109091507_210601004_A_PE150_COVID19_iGeneTech_0909_i_D8_F_L01_R1=
.fq
> /mnt/1/1



Here is my test method after patch adding:
First I test all compression types and compression levels, I write the file
to the btrfs system (print the compression type and level with
btrfs_info to make sure both values are valid),
then use diff <btrfs_file> <original file>, it tells me both file is
the same. Also,
I compress the file with the btrfs filesystem version before adding the pat=
ch,
and then read it through the patched version, the file can be read
without errors and data corruption.

Li Zhang <zhanglikernel@gmail.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8816=E6=97=
=A5=E5=91=A8=E6=97=A5 16:51=E5=86=99=E9=81=93=EF=BC=9A
>
> 1. If the file is being defragmented, combine defrag_compress
> and fs_info compression_level (defrag_compress will be
> extended in the future).
>
> 2. Extract the compression type btrfs_inode using and write to extent,
> because decompression does not need to know the compression level.
>
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  fs/btrfs/inode.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3fe485b..fb44899 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -602,7 +602,8 @@ static noinline int compress_file_range(struct async_=
chunk *async_chunk)
>         unsigned long total_in =3D 0;
>         int i;
>         int will_compress;
> -       int compress_type =3D fs_info->compress_type;
> +       int compress_type =3D btrfs_compress_combine_type_level(
> +        fs_info->compress_type, fs_info -> compress_level);
>         int compressed_extents =3D 0;
>         int redirty =3D 0;
>
> @@ -683,7 +684,8 @@ static noinline int compress_file_range(struct async_=
chunk *async_chunk)
>                 }
>
>                 if (BTRFS_I(inode)->defrag_compress)
> -                       compress_type =3D BTRFS_I(inode)->defrag_compress=
;
> +            compress_type =3D btrfs_compress_combine_type_level(
> +                BTRFS_I(inode)->defrag_compress, fs_info->compress_level=
);
>                 else if (BTRFS_I(inode)->prop_compress)
>                         compress_type =3D BTRFS_I(inode)->prop_compress;
>
> @@ -706,7 +708,7 @@ static noinline int compress_file_range(struct async_=
chunk *async_chunk)
>
>                 /* Compression level is applied here and only here */
>                 ret =3D btrfs_compress_pages(
> -                       compress_type | (fs_info->compress_level << 4),
> +                       compress_type,
>                                            inode->i_mapping, start,
>                                            pages,
>                                            &nr_pages,
> @@ -743,7 +745,7 @@ static noinline int compress_file_range(struct async_=
chunk *async_chunk)
>                         /* try making a compressed inline extent */
>                         ret =3D cow_file_range_inline(BTRFS_I(inode), sta=
rt, end,
>                                                     total_compressed,
> -                                                   compress_type, pages)=
;
> +                                                   btrfs_compress_type(c=
ompress_type), pages);
>                 }
>                 if (ret <=3D 0) {
>                         unsigned long clear_flags =3D EXTENT_DELALLOC |
> @@ -808,10 +810,12 @@ static noinline int compress_file_range(struct asyn=
c_chunk *async_chunk)
>                          * The async work queues will take care of doing =
actual
>                          * allocation on disk for these compressed pages,=
 and
>                          * will submit them to the elevator.
> +             * It only need to record compression type, because decompre=
ss don't need
> +             * to know compression level
>                          */
>                         add_async_extent(async_chunk, start, total_in,
>                                         total_compressed, pages, nr_pages=
,
> -                                       compress_type);
> +                                       btrfs_compress_type(compress_type=
));
>
>                         if (start + total_in < end) {
>                                 start +=3D total_in;
> --
> 1.8.3.1
>
