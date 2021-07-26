Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25793D59A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhGZL57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:57:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:34721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234116AbhGZL55 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627303099;
        bh=HWXR/cqJLveXTNhTNZQ+3pF8xdanuiIz+vmVs3I16dk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Q8DT6z9XRD4IzvRNq2BKjkKA0l9UKx6WC7YrNX4Pr5aDf2e2qy8qa5VXiAewQCJpG
         SIn63kTQGpfD4Q1SPiIVVtyhdOVuMEgt7ln52aNWJcf/1Kwn16KVSHBrvu6Ew2SFsP
         Von36S7Z4M6hmCTrz/Dju1DxNGK2hMb28kktUuSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH5a-1lVLfS1gj6-00cdQ5; Mon, 26
 Jul 2021 14:38:19 +0200
Subject: Re: [PATCH 08/10] btrfs: simplify data stripe calculation helpers
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1627300614.git.dsterba@suse.com>
 <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <41a6c967-1f34-b48a-c24c-14cf226a5c67@gmx.com>
Date:   Mon, 26 Jul 2021 20:38:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6e7fd9d9fe39f547eae063dac6e230f155980ba0.1627300614.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iiyMdnx0htFzBLprSMyi7lVhMFYW3vvkHJ9ALd2zTKSSOmUHJJs
 CQuiIT28v2viJpvlLY9ysJ/LfkxbFZmtNbtu0+QUbUXrNVG+iMBpJ4oQ7M8xZi8g2b/3NSH
 yBSF7Oh3G9uvEStdDhtsXA8uqVQKLHh5BGy33nB4oKkbn7qH0PjInPoGTLayePmEk6ihtW6
 AnX4gRU678Bo9V5VEbjrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:APOjuqRMTrc=:nM5Kt/qB8uS3qJzGwYCbcx
 lwb3T6hePb937MDHvWO9QqlIKUmhBdxLT0sexXV11BLP93zElXQEmAulVk/77wouMA0Ztac5J
 jWZ42SUIsan2rkULWEZ3/tmdJMn3DfEfO5PywJFEM+9xHJ+wOlhel0ZeNEoDletqwshWMRI5f
 QFRO1jCvsUY9VUmGb7JS9xI5HaTY920FR717Y1I4JgJPTk6zDlu470KcqVpdfiLX50g1t3JBn
 ZMZJ3TedX9284HuemewaMKQo0ZVByXNeHBn1+Wv7xe6+XvqN68KxIfBMJA3bg7RfES0BMCjJ9
 ly7DIUWhAxPJt1toluDy4EsVnV8FrDSZqNLq0kuhntHUkqCKCzn3/FUlbm+ixtfOYMfsdxZFl
 Dca8t/lS1TB5s+c/iN6NHrk7NHZyiBUvUE5SBnh6UIYoSXmFW35hE/9tpbDZsoPycdxax7cYc
 mJ3QDqZghtRZcmoOWhZvNc8/+BPAlirSpTIeebSafA2HR+4RXHr15rcL0vpQ/nKRex7z9Fg3c
 i9sbrGghryhzNWwcfdQWmSO6ZhM7Srzv1233alZdRZbJjQjMWGkmeWXeQ9EMsPOK9SgT1G1Ar
 E+iWI+gqBhMc+PjuXIca/99Tg7MFTdcGSPREPUqvkfwC0m21ns7jAKtOAl+wtzzkVxvHm90zx
 0tAUT596wtWiWzqXyieiG3oYKeHyx9+QwXNxaAaoGtp+ClJW84A+mqJ32bSW9tpupznTyoGaq
 /CFGI7L/d9kLyvI6uPpMcjQ62TvvQz72CaZ6J8/qCzZNomY3hLO4Jht2B/+1J9qlaGxNRcsX2
 jhfRBdvBkGufGSCIqI9Tcg6DXCMxW2CwLhNf+aJYQ64EqpgRHZyp9+UQxMEdcc1rWSWtYe3kA
 CHqvuXMADmNAF4CCsT+M1cU1Flr4eozvNgEXSNWFXCGCc02RxRCX3pDm5MVteVHx4jW43f5si
 zJmxAC47yJkq4l+62iaeHuFClv+z6CtxY1qcYGQ/iGnQE6dSjN91XI4X45bZurrQF4sfBkSP4
 wAA2akPXENGupq7IcBYKhyWXhLwcF8lErnD16FD+MmadVnk19cnQ0VjkbsboUC7YDizEtkSCT
 KLJxj5rIfPhLkkWS7yIXvEej/HuORlF58fZccmdDbBg2yH40d6+2fbR9g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/26 =E4=B8=8B=E5=8D=888:15, David Sterba wrote:
> There are two helpers doing the same calculations based on nparity and
> ncopies. calc_data_stripes can be simplified into one expression, so far
> we don't have profile with both copies and parity, so there's no
> effective change. calc_stripe_length should reuse the helper and not
> repeat the same calculation.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one nitpick inlined below.
> ---
>   fs/btrfs/volumes.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d98e29556d79..78dd013d0ee3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3567,10 +3567,7 @@ static u64 calc_data_stripes(u64 type, int num_st=
ripes)
>   	const int ncopies =3D btrfs_raid_array[index].ncopies;
>   	const int nparity =3D btrfs_raid_array[index].nparity;
>
> -	if (nparity)
> -		return num_stripes - nparity;
> -	else
> -		return num_stripes / ncopies;

I would prefer an ASSERT() here to be extra sure.
But it's my personal taste (and love for tons of ASSERT()).

Thanks,
Qu

> +	return (num_stripes - nparity) / ncopies;
>   }
>
>   /* [pstart, pend) */
> @@ -6878,15 +6875,7 @@ static void btrfs_report_missing_device(struct bt=
rfs_fs_info *fs_info,
>
>   static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes=
)
>   {
> -	int index =3D btrfs_bg_flags_to_raid_index(type);
> -	int ncopies =3D btrfs_raid_array[index].ncopies;
> -	const int nparity =3D btrfs_raid_array[index].nparity;
> -	int data_stripes;
> -
> -	if (nparity)
> -		data_stripes =3D num_stripes - nparity;
> -	else
> -		data_stripes =3D num_stripes / ncopies;
> +	const int data_stripes =3D calc_data_stripes(type, num_stripes);
>
>   	return div_u64(chunk_len, data_stripes);
>   }
>
