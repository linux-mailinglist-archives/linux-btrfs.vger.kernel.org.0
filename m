Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D971379C32
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 03:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEKBnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 21:43:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:32947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhEKBnl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 21:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620697354;
        bh=FuT/hLiZWvlW4ow+d4WHJ5lLf/7J+O4ZrasAaSCeB+o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fhibGPEsrJ1EE6nHWjdcbXFKlzyAAUYk5IRJpFioPEPUe0wrUOcZHfNX3CS49d7is
         HAfam2FqL3O0Fo72QB20+bP14+szEN3Of/N0PPVYJQl7c0f/6Dzq1MAla7oXSzMv0a
         xIHVjjQjZlb4rp1XLATQxPfEQeN3uBxdJ158BSjY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS9I-1lE4Tj16lu-00kxMV; Tue, 11
 May 2021 03:42:33 +0200
Subject: Re: [PATCH v3 3/4] btrfs: submit read time repair only for each
 corrupted sector
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503020856.93333-1-wqu@suse.com>
 <20210503020856.93333-4-wqu@suse.com> <20210510203203.GD7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <751b7396-d0fd-d3b2-f14d-e730e6b08222@gmx.com>
Date:   Tue, 11 May 2021 09:42:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510203203.GD7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1A7f6MHrPHfqmNpGPdEYjn69rL/iR1ZFjslXJwvmf8L/h0U+uk4
 Ehh4ki3aqFvYpIt/YRXb6KCmXpQDfs9IxfOqYmFpAxSCNFFvN3U23ooj1ih6GPV7CY95JnL
 zfVerMp7EVKjrG2yBms2gt6CzwOMhodQPutYM6Z/ot+C64qmHTl43+aq03nFZXkARMjGnRT
 y41r/+qJjVqjeSglhM1Qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4ur+tNCTJQ=:qy+gl5GHxj1IX5YWzx+xAf
 An+VUsW7LpOvCMb7DPmdgHPFNe+ZZxtBSf68rbYClR1tgLFxtPtEaCKDqQfIKSfTypvvAyQH7
 GScK5TTC1mYJ13RZFZZPUFA8Nx70rYQorWt9yGB2baro0chzn2pf+51ZtRAiofLdDHhctIIrT
 v4WO6py/ClbCvtQfQ8chRP2JM1PT8vMbXrtIqFfYwHzevVS3cOhu3FhsGhjknvSGznuZZ3cKl
 rG6tOHB34/ghcGu41cFdWWpEIhe7ImMBXdTmFcxw7S8k0CJrk6mTOFvNy5XlcMVs5tQmCrRz2
 XMy9NK0hRIHtKza4YelsjuYLxLy4veyPO4t6k7uX+DYD6ab4XKmYRin2b0uQEWcoYvGkvdwLe
 t6HuEZfd25SR0NVSjZwOcGvayg62ZHI4GFcQ9CCWGyPyXE6YtZ4pttwozAt8o7jPKka6jFJts
 46S/euC78YLpl3M8ZDuRXufC9JAsLWUfyQSYiqX4Z2j8kEMmJINeH+zN3HeCo92hAEb5rhV1K
 qlUu+unBdFjJKgPsfy9JaeoB6dRBiLAos8xgyRJUEIZA4LHmDLzWEJ6f70Cj0fnf8kl1umFQx
 1a9RN19qVzp/9STbi/HBsLaXNRNmmMs9js0WzOvlO6e0xNcimHr0btgCZHNWfLnPNrMF+fjGJ
 PSpf9PDqzCUT+pI3ZzWp48j5LyphzBoFCawkk4MfrBKJdAY3OgcUgkFuLM8t5wN/tEtfAEEVv
 Ls6hRBki058j39U+YMc8FxCef7w0dy0ss0ROleOtuBcXrpp0RQG/7MMVocX/PNdeCUAAPKInt
 eFGOFoKwJ1IGe2ShYzgiGG/yJGS9D0uoQoq0MXztOWG+Z3o6G0ILdhtaA1kb1n59BFsXaBQpk
 h81WToyWzLsBBaP/lGTpn6HBDUL+6OkL2tCRvfZ/EFBFOYkRsio1bIvTv4gcFxqryfqmpC+LP
 uKUppGUXT5WPJmm3vaSXXKEJqDoP3FxofRMJswowSY16qLsdZyqd8RiBdBacxmtO+Vrdspdpy
 48vk1uVGpEClY174XKuusQn1e30Zbmnjl3YlnEwQuZngO1C1nDCS8N27AzbAsrE/az/XODtmF
 IxQXwPFeumkSefwAfAUt0NLlbDQNnPKnZRVBCxAdr1dppVHws3eO9HFJeLfL+iTGVIZhPHAVD
 R6dHwn3AGuqEiez5C9bgi/IOccPGV610Ppn4K1zmxUzKwxsNqMtX8y619vrCKEQc/tfXqgELQ
 gBZXp+APv6K/HhlyZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/11 =E4=B8=8A=E5=8D=884:32, David Sterba wrote:
> On Mon, May 03, 2021 at 10:08:55AM +0800, Qu Wenruo wrote:
>> Currently btrfs_submit_read_repair() has some extra check on whether th=
e
>> failed bio needs extra validation for repair.
>>
>> But we can avoid all these extra mechanism if we submit the repair for
>> each sector.
>>
>> By this, each read repair can be easily handled without the need to
>> verify which sector is corrupted.
>>
>> This will also benefit subpage, as one subpage bvec can contain several
>> sectors, making the extra verification more complex.
>>
>> So this patch will:
>> - Introduce repair_one_sector()
>>    The main code submitting repair, which is more or less the same as o=
ld
>>    btrfs_submit_read_repair().
>>    But this time, it only repair one sector.
>>
>> - Make btrfs_submit_read_repair() to handle sectors differently
>>    For sectors without csum error, just release them like what we did
>>    in end_bio_extent_readpage().
>>    Although in this context we don't have process_extent structure, thu=
s
>>    we have to do extent tree operations sector by sector.
>>    This is slower, but since it's only in csum mismatch path, it should
>>    be fine.
>>
>>    For sectors with csum error, we submit repair for each sector.
>>
>> This patch will focus on the change on the repair path, the extra
>> validation code is still kept as is, and will be cleaned up later.
>
> This leaves btrfs_io_needs_validation unused and compiler warns about
> that but it gets removed in the next patch so that's ok.
>
> I did some minor style fixups
>
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2706,7 +2706,7 @@ static void end_page_read(struct page *page, bool =
uptodate, u64 start, u32 len)
>          struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host-=
>i_sb);
>
>          ASSERT(page_offset(page) <=3D start &&
> -               start + len <=3D page_offset(page) + PAGE_SIZE);
> +              start + len <=3D page_offset(page) + PAGE_SIZE);
>
>          if (uptodate) {
>                  btrfs_page_set_uptodate(fs_info, page, start, len);
> @@ -2734,7 +2734,7 @@ blk_status_t btrfs_submit_read_repair(struct inode=
 *inode,
>   {
>          struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>          const u32 sectorsize =3D fs_info->sectorsize;
> -       int nr_bits =3D (end + 1 - start) / sectorsize;
> +       const int nr_bits =3D (end + 1 - start) / fs_info->sectorsize_bi=
ts;

It should be >> fs_info->sectorsize_bits;

Anyway, I'll submit a proper updated version, with your update and
proper test.

Thanks,
Qu

>          int i;
>
>          BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
> @@ -2747,10 +2747,10 @@ blk_status_t btrfs_submit_read_repair(struct ino=
de *inode,
>                  int ret;
>                  unsigned int offset =3D i * sectorsize;
>
> -               if (!(error_bitmap & (1 << i))) {
> +               if (!(error_bitmap & (1U << i))) {
>                          struct extent_state *cached =3D NULL;
>
> -                       /* This sector has no error, just finish the rea=
d. */
> +                       /* This sector has no error, just finish the rea=
d */
>                          end_page_read(page, true, start + offset, secto=
rsize);
>                          set_extent_uptodate(&BTRFS_I(inode)->io_tree,
>                                          start + offset,
> ---
>
> The division can be replaced by shift as we have it in fs_info and "1U"
> in shifts is for clarity that it's performed on unsigned type.
>
