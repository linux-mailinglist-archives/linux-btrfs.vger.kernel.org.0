Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDB93D994D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhG1XOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 19:14:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:50869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhG1XOj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 19:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627514063;
        bh=z28ihPKFuFtS+BxhwGwg26hcNeDtRLaGds1phaU3qTE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TMzsR4ev7FuFP2HEanlybqB4A6VZZtMLKneldtbgCDjxWFyIWIxk25OYn3sCjIXLs
         iPFXj6BtLZHMzgevKHlkKxVgWAYmpYNBbDd5rG+H42kYvPTc+g5Hujo72T9SqjPoEF
         EveWRL5SkWRWSEQLR1aRGb4eJEEcgoB7fiy7SLSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacSY-1mkhbr0h7i-00c7N5; Thu, 29
 Jul 2021 01:14:22 +0200
Subject: Re: [PATCH] btrfs: calculate number of eb pages properly in
 csum_tree_block
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     gustavo@embeddedor.com, wqu@suse.com
References: <20210728160800.21341-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <58c385e8-bc42-ad9b-0bfe-ce9fa650bae1@gmx.com>
Date:   Thu, 29 Jul 2021 07:14:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728160800.21341-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HxnKprUF2V2l3i8O5Ghu/gh4L0+mDv9bOa4580wTjdO4M7rbvIm
 zjJNWvvglTdixu3yiwvGasQ4zPVKD63aLq0icDQk03zw0LoGiE457AswLrSLdWJr1Cs9ggI
 IgiMG6zQoEodAZ5cIOF57hY8Z2kSE6TZTsaoRMb1RDX9IhHqqnbqSEEkGERxEX2jup3coWE
 c49LngpGN8pFRKmYhxlZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ktg/6X+vA18=:5uC1b8rt1yO3ninEvWYRG3
 8jWdm5vVq4/GwVGP0QnpxxSZDnEnIgSWUTssQvfNSTbuYzLvO5+4xdeB9PkhQAk3nJALnAl6b
 rwIdU2vR4zz/VQv9e1NiY45BU8CmQmm3mXifXzlYEQlZAX4F6RfH8CjEWyg/kWvIG10O0lUGN
 bSV1baCCP4ozw23GSbiCx6yz3WAZuO3M/DOAL2ysX1QKvoJQitRqsv2UNSs1o2LdNZmSepTRA
 PiQgSus/u6EM5urDmGBSQ5XgCgNlt2P3msZVXj9OOZtcUclR2AbEC0LWrNJ7RBIuNBs7575ZK
 CMY27guPtg8i0202oZfyHJbMlouFvdhsGCuZbDkMK7wuRUg01XbonsI3+4Eqi+Ky3GOy5rnk+
 uolht5HtKEByXZPhxpAzfrQj/l8gsR3hBfcH0uUlL95viKEsCd77L3SJRw+Gl2DqtNKj9tSuB
 CoUE64PFk0XNOxgdNdf8UPG7F2VGjvwVbCXyKG47Dxv9gGjlpezplraNEqbydcJtaw4lp3UuD
 +QaM5JZwYVJ2bGMbwT4kOhMvkTCAe4vcEq4Sz9ssTLQqaeUQap7oYr5jTagMBtrZLj9zIwQo6
 y7suOs4aBS1sh22IbSDG0EOlBfosPlh46Ckds+UDD6c6wTNiDhEjUf3dcAyAWQcq2b6vVN2FA
 5AKJ/GMfzqIm969MmdP7NOEsgukf4vGZ2IhgnOaMEpfa7hRwTPdO01SIf0s6iei9yBb0LZ2jI
 WwhaNgSbgdJxU1/yfZdjwEH2wRZ5Z8rxLCqgGMmZrpkhku5ks2T3D1q57JTMkwBK98509ggcW
 so26EP1H392F8EgSAcEligYhSdtsug1ZBdnUKxOLphrPaDGE+wZrAmjoWe6xo8AjoBoOR+xEP
 VwJZkpLiARFHuOna6sP/43UmY+LvSkEAkQKJLllK7H5q39xG1sQKTJf6aaCo0s4UlwHv2FdPY
 yIZXCZDohj1Wd56z/ox7B83Pu2DdEkzjzi8VUoaZ6SvllmtsI4QgZktAQbSE5eZ5BMINSBzAx
 vKeROEKfU4TMI4zS4G1jLrCgbIc7uOzH0oRv1Kr3iMvjbSXZ4wIqdH+7jZhJ+TRPe3kN2qlGs
 l3m1hDG33WcsJQsZTnKWOwzbFwfmozLBc4IVtO/d/XZ5Y1khceViE3lLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/29 =E4=B8=8A=E5=8D=8812:08, David Sterba wrote:
> Building with -Warray-bounds on systems with 64K pages there's a
> warning:
>
>    fs/btrfs/disk-io.c: In function =E2=80=98csum_tree_block=E2=80=99:
>    fs/btrfs/disk-io.c:226:34: warning: array subscript 1 is above array =
bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
>      226 |   kaddr =3D page_address(buf->pages[i]);
>          |                        ~~~~~~~~~~^~~
>    ./include/linux/mm.h:1630:48: note: in definition of macro =E2=80=98p=
age_address=E2=80=99
>     1630 | #define page_address(page) lowmem_page_address(page)
>          |                                                ^~~~
>    In file included from fs/btrfs/ctree.h:32,
>                     from fs/btrfs/disk-io.c:23:
>    fs/btrfs/extent_io.h:98:15: note: while referencing =E2=80=98pages=E2=
=80=99
>       98 |  struct page *pages[1];
>          |               ^~~~~
>
> The compiler has no way to know that in that case the nodesize is exactl=
y
> PAGE_SIZE, so the resulting number of pages will be correct (1).
>
> Let's use num_extent_pages that makes the case nodesize =3D=3D PAGE_SIZE
> explicitly 1.
>
> Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b75ffc1214ed..2dd56ee23b35 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -210,7 +210,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, st=
ruct extent_buffer *eb,
>   static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>   {
>   	struct btrfs_fs_info *fs_info =3D buf->fs_info;
> -	const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
> +	const int num_pages =3D num_extent_pages(buf);
>   	const int first_page_part =3D min_t(u32, PAGE_SIZE, fs_info->nodesize=
);
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	char *kaddr;
>
