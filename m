Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B645C712
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfGBCVF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 22:21:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:49461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfGBCVF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jul 2019 22:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562034059;
        bh=oitA9/GO5LABuiDzQgzugYo43915NWffa8hpQEc3idc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eycEuIQLK4fVs+nDZcuaYYE7YuHbYwOCnhBcX0bXg9ixZvYCW0lH7B3ec9qGvTGwH
         NbLQF9sFRQveHqzlDBCS+D7BN5hOszZdG95u0qj394jNZF7Omh5kOmOHb60LE+6uba
         kfu+qvXU5UWDt6CVBelFZiA2LZ5Eq0H8luYV+Rrc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MU1MP-1i8qFP3czR-00QhXm; Tue, 02
 Jul 2019 04:20:59 +0200
Subject: Re: [PATCH 2/2] btrfs: Move free_pages_out label in inline extent
 handling branch in compress_file_range
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190701165055.15483-1-nborisov@suse.com>
 <20190701165055.15483-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <57001147-a0fe-de0d-c88d-9a4ca988d2a6@gmx.com>
Date:   Tue, 2 Jul 2019 10:20:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701165055.15483-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sPwCk5+mo8CrL8Fo8UCv7tfBzxSQtu97nefQpIV/UsBFNJSmxJJ
 TzDIkcy90w72yhCLkmEWqSVCzq6w/f9hJ5as4udiDAbT7empAJsnBjY3aCZ2n7h1Z0XHu4o
 b55izTo5/jPq9IKxHhTqKJjzg3w9Hm3Br1XOqTgiuYJ4wYX2PEolrW/nzXS94496D1O6b0v
 jczwAAQRrFHGRWQHpipmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hHSDzZoYLVU=:zVPEXsvHlFCLWXgX5IP9tM
 XpOz1AGHHwVpt7FaupGqRigCErAt0Qz3RsZ6yi1L0txsDcAcvRrTZmgz55HmQ7jmjQk6QaRyd
 B9huKbpkGiS8JHhXL1g8EQPb/t/xooqbER0d/Xj9PG+xdh2OkalAWI8kCKD6y4SHS/brUh9Do
 /a+YhTvA9Y4GTjZTaAhnlfh+JZd9pwZGA/ZMmZtt6wIpHFXa5LeEoR+YCeV5hRxqxoWtmBsRu
 oA/6v8gxKXKtOdjZeofVjxJHgnPrOwzDIowkcB8WW5x5fXmSI8e/KgNf1U4mjHYcH8nYQx5R1
 RJZTMKM7v302UE/rWerN/CeNL6t3An42VuMRQL3YT3DDRoKquM04uNJ7wR/UV8LacXeBnSuRo
 m9r+51CW1ysRn7bX6ZQ22uXcFmq9JcSOdBlCgYMjll5VLlXxZmzJCd/T3Ob8vur0xr9fFFfK+
 OjSMQ6bAdHgKclkc/A9bn9qMx+TaE0UvwkPxrUKFX3vY/pdmH+2+HCJ6pc22Lt/aM/z6Xo8g7
 tX/cUr3MdYM7LqL9G0CCfyc6+xyRsYtBFbWUjC4doRVFy6KemiBYU/6E3z+EJ0mHB50rbIwT4
 tJp5AAFHobo3URB47abX/P7ZyZMfiFsa+GkFFaG0oPKuB6Rhyo3gIUgFjf4Xu9L1RAt8j3LN3
 kKL5nM4S2X4uukZQTNTLv/EBzoaQLnQ68tFhNYjRun+hnoVM9gc0OhLj7aSWOcAS71PjbT3N+
 6jxqeBaqnI62XP3bxBAg1G7dIJuZU00jWvPX9gzVF14E7bhoLl7GanLNNucFueG16ucC0Tkps
 OgQstFGGRlCUV7AfI7cvXTpJFa3LeboG2tyzun516lSYr6PWuWUYttHpa0NWX/T0I+HbjDoBS
 bxHrNxkaVqTSuTtrhKo+NP7icBqq9+EBzRQOzW1spxuS2cNGW+eTA1SxNybfGnPXxhUHa+lJb
 ba76Pp2iQLH4A/cxVRviiUYhWe2fDkAQa6AxPTC6SG7O6SsGrF92V2ZHWaoWFnN++tT/ECUrB
 TYbpYk8B+Tikll7q70PxVlMsS07YwZ99QYmqS6sQfK5b+FZzciCH6OGAEsWrQ87FRel64eZ8L
 sy9Wf4nG/JCdCdUHrcSKS3Sww+S2mPyXSCk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/2 =E4=B8=8A=E5=8D=8812:50, Nikolay Borisov wrote:
> This label is only executed if compress_file_range fails to create an
> inline extent. So move its code in the semantically related inline
> extent handling branch. No functional changes.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/inode.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3b0bf5ea9eb6..072a300f8487 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -600,7 +600,14 @@ static noinline int compress_file_range(struct asyn=
c_chunk *async_chunk)
>  						     PAGE_SET_WRITEBACK |
>  						     page_error_op |
>  						     PAGE_END_WRITEBACK);
> -			goto free_pages_out;
> +
> +			for (i =3D 0; i < nr_pages; i++) {
> +				WARN_ON(pages[i]->mapping);
> +				put_page(pages[i]);
> +			}
> +			kfree(pages);
> +
> +			return 0;
>  		}
>  	}
>
> @@ -678,15 +685,6 @@ static noinline int compress_file_range(struct asyn=
c_chunk *async_chunk)
>  	compressed_extents +=3D 1;
>
>  	return compressed_extents;
> -
> -free_pages_out:
> -	for (i =3D 0; i < nr_pages; i++) {
> -		WARN_ON(pages[i]->mapping);
> -		put_page(pages[i]);
> -	}
> -	kfree(pages);
> -
> -	return 0;
>  }
>
>  static void free_async_extent_pages(struct async_extent *async_extent)
>
