Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B475390D0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhEYXt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 19:49:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:38069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhEYXt1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 19:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621986474;
        bh=d8IGUqj4j/i9SCE+fe23oagxBkTnNhlvtH3y1DK9eRo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WkibTt+K1FN/xYlHyqvU4ZrzeWnYoNpKKmQHtCUbN5WLZPyDWZjFxtWgwv/1MhQie
         CdBdMPKjx9b02Oq3JrkYdo7SBxBpi0hJb884AY0K13NgQGRfIBkka2BGzoShGemJPv
         SNZRWaZQ3PEzpiQQ5iMU9tPeZEYDAdu5G+Zb8Qzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MybKp-1lUqqi2VMT-00yv4O; Wed, 26
 May 2021 01:47:54 +0200
Subject: Re: [PATCH 1/9] btrfs: sysfs: fix format string for some discard
 stats
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <aabd2d30ceb25be5dd6ba2812f85b92fea0544d1.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <dfec2910-4754-f683-d0e6-d9f539190a4b@gmx.com>
Date:   Wed, 26 May 2021 07:47:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <aabd2d30ceb25be5dd6ba2812f85b92fea0544d1.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yOa6K4/AKQtGA+ZhSwcZOC0FD0LdiALymOVILfyr8lxZZhNNhH5
 mS969TKQYEcBrPBhcJtNiqz5fRPN2YTCR89fcw7x+RVtamDfCxlshznPJkByLeC5BolNGab
 PEhZNQlVQJtTUicoOmT3a5Fzvig0adf+nACt48di7ymfQiCraXqUAKikcUeNaENxTXIF1eU
 Oe3Uf7K4s15G/BqUKLOmg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cMptMtAwxNg=:vLsvAkUlWjhkitQugjfY/Z
 UEar2T756kolZtnKJUrZY0pnOJ9uXk0A2KKctg8oMen84TwLXWcRf3lAIPzsDRdOlS7WEw9WM
 DDBf2OxGYjLLEq0fDmVDc0hZJqUKtDuIiqadQeAsVpbyz7VGGe9jKXk16mG37Xmilo6kLwPsT
 ksWvI12gic4d3n/2HlGSqZr42W6Gu1t2peZs3X32GEbg/TuCOx+G8J7Z2BiGy/QZVb3xCAz44
 7Fv45igmLqEocu5Puox9F9VHinI41W9EZEeQgZXTvMQ4F+e2VrpWAUdm0k1QA7IVWqDiuh1JB
 BB7j9aLOdlQ6+oqKP82PB6SURCT10wXjZGlhqA/1HET6W5q7+oxNnsV5AIOlUCpsOWMMr48kF
 TJ2rNKhGehEMzcFgaRqx2nY/bGprEptQAKzMXc7rwPfynTvxFkG3ADQ4Cwcj63uKJWZfV3KZh
 1qBEAQVLkRsR1dDtbJnM9pcfPyOaWWRDaWSpDziPE8T2YxZ2sLoYlyCRKh5V8Y+s4/N/OabJ+
 P1YAQUXVPFaQf/MqI/vVTROosmJpW+LcH294F7AJF1EMtbE9P4DXZkDXShuzuRZ2RbwAuQAkB
 9q8GX2u8YeKXXrekyoY0cAam8GNqo7kLPn1IdpUmJtiTc2tSRcq5kxRWL5YlLUfYfD6RdA7mo
 8dJ+BgsLl2AEP/lP+LuVEXL9/LaFfr2y13CeO7lfMtrPTSqXZk7CIbYT4i09sr0pMicjgfXn2
 WM4xxYWviwbS0vATG3Q/5tO9hRTHyjR0E78e5UXktkTYGCBdSvLrD/HUTJ0aPb0p39m6i5cLS
 GeW00Z7CDm60ie7a1oKRr23nE/PCYsC1nU5nEGpqCh7rkcOwuR6uwqNdaAkiA4CSyp6s/Ie92
 6ppTmnktWtK/1diDK/rh8+SYM5nOPSqN0UlDDzGoY2CsFhZ9Yi7A4olwozM2QrMXK8nHcApgf
 wBsjkaeh6/+QfGsKj21GIeCI2BgRqstrqN5RY0aQnyTUw/OcQEdviinUIlSwdqTr14TbOuAzF
 MrHdyb95LymYUeoV7XqQxRNeOMpSxvD12hPV1vTc9jKoRcCWlwD/3dGk+jZ+YXL2BRHshRA5B
 nI7J6VGyh/wAFLdfdsNbDUAba4LXBKathgu4+lSizIhaqc7Rda/hVbCfg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> The type of discard_bitmap_bytes and discard_extent_bytes is u64 so the
> format should be %llu, though the actual values would hardly ever
> overflow to negative values.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index c45d9b6dfdb5..4b508938e728 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -429,7 +429,7 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struc=
t kobject *kobj,
>   {
>   	struct btrfs_fs_info *fs_info =3D discard_to_fs_info(kobj);
>
> -	return scnprintf(buf, PAGE_SIZE, "%lld\n",
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n",
>   			fs_info->discard_ctl.discard_bitmap_bytes);
>   }
>   BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_s=
how);
> @@ -451,7 +451,7 @@ static ssize_t btrfs_discard_extent_bytes_show(struc=
t kobject *kobj,
>   {
>   	struct btrfs_fs_info *fs_info =3D discard_to_fs_info(kobj);
>
> -	return scnprintf(buf, PAGE_SIZE, "%lld\n",
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n",
>   			fs_info->discard_ctl.discard_extent_bytes);
>   }
>   BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_s=
how);
>
