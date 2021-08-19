Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982303F12FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhHSF6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:58:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:56519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhHSF6c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629352672;
        bh=JPPH5DXey2sjmVmO/Qf29Ep5cZe/7tF5HwldynAjGws=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KwJO8Hb+Uss/YW1RSi/GSfLpFHggmG1C7VLuuYlvZOeS3B+QPg798BUvr0Bhm+9wP
         i9Ys4JDIM801iT3j6M2Ct7iFN7PHVmwquNsmoU8v+yKuh22tCEj+2770GrhZhiqs/Z
         i1kuWQsYXCDI2V3yw6y2tN0RAWqi9oEk9r0FR8BE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1n4ilq3LR3-00tXq4; Thu, 19
 Aug 2021 07:57:52 +0200
Subject: Re: [PATCH v2 10/12] btrfs-progs: check btrfs_super_used in lowmem
 check
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <ebeaf9c035019f2d5b210ad752caca5655c69edc.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <cd401399-791a-ae06-4934-98dc15b57610@gmx.com>
Date:   Thu, 19 Aug 2021 13:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ebeaf9c035019f2d5b210ad752caca5655c69edc.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M7hzje7gusk3vKwX3cQTGSqaQvckNH1N0/htEgpcD/RJOCcLyoU
 08mXyEjrmpRXMsITMrfb2BxvPn1rl+QmjIb1tiE+6SMSwxy/cA1yc6Fds0BZN5HbrPheOU+
 sbYMgeKWC8tTCoNWgbOFA2W02jNlPwLXSH75M4hXDFNRe6XUpbaPMCUtQUiRI3g+kFwlVsb
 Vc63+9doOT6Xtys6qCozg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWvdGJiSP6U=:IpNJqeN639iYAC3eQSgIdz
 AZtQKoQCMUj9RFBPDBRC/eZsuVXkflF9oG+QqyRD4RQ7gp486eL95UGRZ3ItOIPGoEsVvL4hc
 i0q524JeNgcPA1ugRd+f6AiyTe7KjbIau9uMVtUzR9k7ohmhTNLwhZIrqB6IM4ifl2d1VGbTQ
 YYKvatzQVpibAYtoIB4D/S1rzqV0SfjDIudEmSW7buSDlTvk7i3+2mwvZAFsAgfbX2eM2tEK4
 ChLh1A62v58nh2E9wumd46NRuK/o1eyTAH3Va0hstT1Z6/XiixYptp72YhusbeNOEOkoW3bK2
 OC9P8ATCT9PeOKcwSf82rCLkWIyoLUMYbp1laC+h2Wo67ET0ZOgKWADoUcZSbHpPIWbO7Z33n
 KlhwAKJMvIUofrQijLtrKqqYpCKR1EsJhQcTg4E+W5QTM44vTSSjFpA9lL/eu1knpVk5CfN/v
 nfmldO4Lz+NOU3uKPler503M4vFjnxl0NBu189wvJLFx7SJgfo3NpN1b5JNmFG+kx3iJ9Anay
 TOZAxHEif8ddSfobr3ZQrkqRV63hUEIt4p/96Nw8cO/B4ITVdybO5N/mvEB0eo7j8FHKFzowd
 7bnwsNsvA4TpD6moMlJZPZn65sj0d163LKUfQSIN28b6WUv7ztPjPym4i6pTtAkAWszbBVdYm
 bV1BANr9V5A0RpCBaq/CSiSMjz8Wcg9qosMf37CL/RH03SZA1OSsnJLOn1/lJIp/9HQig4qyt
 Yib75GRp7UDXLh3nzw0M0ZHknYsQroAq+M6VlCOw/g0VqvGy5pG5bHhey7RufGpov65Biqazz
 oN6ujiMn1szRJyZ6pMOMV2RFNrV35LwVTAP3bJ58YTVetoOHCJjXoJyP7q2PdAIOh9f3El7qj
 8fdEXMS579uF0uqcutqk3R9/5k1SrMNDLZJGnaMdz+i+SK0/SDOXa8d9hMe5GJhWXISaTe+xu
 24Y/N8Wgi/tw3zvl1+sB6BGL0Ulma/hfkDUvnq2Cb7fHHujaBf8QZxl4QzIx0ND5sCmohGKER
 diFI1y/nvC5zZqeCe0UTrMSmUHANFXBCvFIOLB8MxsnrDI+N1Rar0kFnMqQs54y/M9j7pdR1w
 Dj4143PvM9wg9r2j/kZgQN3OqIYUtTX4my39fZwcCT7UWYlbhQ+YRmc1g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> We can already fix this problem with the block accounting code, we just
> need to keep track of how much we should have used on the file system,
> and then check it against the bytes_super.  The repair just piggy backs
> on the block group used repair.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

One unrelated concern inlined below.

> ---
>   check/mode-lowmem.c | 13 ++++++++++++-
>   check/mode-lowmem.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> index 14815519..dacc5445 100644
> --- a/check/mode-lowmem.c
> +++ b/check/mode-lowmem.c
> @@ -28,6 +28,7 @@
>   #include "check/mode-lowmem.h"
>
>   static u64 last_allocated_chunk;
> +static u64 total_used =3D 0;
>
>   static int calc_extent_flag(struct btrfs_root *root, struct extent_buf=
fer *eb,
>   			    u64 *flags_ret)
> @@ -3654,6 +3655,8 @@ next:
>   out:
>   	btrfs_release_path(&path);
>
> +	total_used +=3D used;
> +
>   	if (total !=3D used) {
>   		error(
>   		"block group[%llu %llu] used %llu but extent items used %llu",
> @@ -5556,6 +5559,14 @@ next:
>   	}
>   out:
>
> +	if (total_used !=3D btrfs_super_bytes_used(gfs_info->super_copy)) {
> +		fprintf(stderr,
> +			"super bytes used %llu mismatches actual used %llu\n",
> +			btrfs_super_bytes_used(gfs_info->super_copy),
> +			total_used);
> +		err |=3D SUPER_BYTES_USED_ERROR;
> +	}
> +
>   	if (repair) {
>   		ret =3D end_avoid_extents_overwrite();
>   		if (ret < 0)
> @@ -5568,7 +5579,7 @@ out:
>   		if (ret)
>   			err |=3D ret;
>   		else
> -			err &=3D ~BG_ACCOUNTING_ERROR;
> +			err &=3D ~(BG_ACCOUNTING_ERROR|SUPER_BYTES_USED_ERROR);
>   	}
>
>   	btrfs_release_path(&path);
> diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
> index da9f8600..0bcc338b 100644
> --- a/check/mode-lowmem.h
> +++ b/check/mode-lowmem.h
> @@ -48,6 +48,7 @@
>   #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
>   #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
>   #define INVALID_GENERATION	(1<<26)	/* Generation is too new */
> +#define SUPER_BYTES_USED_ERROR	(1<<27)	/* Super bytes_used is invalid *=
/

We're reaching U32 limit now...

Thanks,
Qu
>
>   /*
>    * Error bit for low memory mode check.
>
