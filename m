Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58053B9F06
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGBKXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 06:23:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:54425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhGBKXT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Jul 2021 06:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625221239;
        bh=T3blYNmFI2GKalKq09476nnsDrOrJu/NwKnt6msmFMM=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Clb4bepDe2JydiW1OTIE+iItMgjzidcrOOIbKjQgIabSl+z+kiy5xXOJvvZd5XPYo
         Oc9o3gP/ehBj16/YBAatxGgqkgNxDC+N+dg4SUV5r7V3iTfbx2x0H2uQmjEh/dRv3/
         6xek3td3gGBITrtkb8uT6TOpSD3/YsYPBThBmeiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1lnsWz3QCp-00TV0s; Fri, 02
 Jul 2021 12:20:39 +0200
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210702010653.GA84106@embeddedor>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH][next] btrfs: Fix multiple out-of-bounds warnings
Message-ID: <ba89916a-f141-2962-2526-89bd43e75a42@gmx.com>
Date:   Fri, 2 Jul 2021 18:20:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702010653.GA84106@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t/xcHCfGeezxJYTvmjZ7tZxF09vKnpkhk963DJjSEbwRJyu2ntb
 3u3uf4VgDD4NPisfkgwOqzXZDGHRPHl+Oxjwh/LlepwbuMyj3bxeikLNQ0z03iLw4u96rAw
 szoLSX82gVNagyAY0dRYLDerd92pmIPD9uVKKYbKwLaaH3hfRVDmvGQXxES0AyJcHaCW7fz
 6+qljbljwnH9Mlf9esXOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pS5dcC7rXOM=:pkEhMl0X0J7fEtyxuFLXMz
 VPRiKRXfsJ7EqdQ8GyM/QgNLUebWJMLxBYj6VVwqkz5+9pDNleDztiBeGYmKj6t2UQdOQqaMr
 NVOz7CtTT1hKny3yxHuk6WNZByZp6vh76qebnfBNA4g30qPcrcaD+M9A1OzbGIo6yLBu4HEh5
 8ssgpF43u5idSRCg4vvFHrMcBHPyPCUAdiCb6FJr/5EoM/4yJhVT4nTIQT5gvFMukmmx9nvfG
 b8Qvnapsm/4Xo3cIDzlL0Wx8znS7WHMot7qFY4gFnN0ppQ6slR3i9i/reEuQqaA/63x+Q5v8c
 0BurRNsNMkh5aAcLpmDUdLrAVNXHDBd76lNHqTcPYkNQZ/LbrvYDWJxvvUt0OPmDnsTJWMWXN
 KOLq8jQEfFqgoaAgCfaHWw/U0rv+N26SAQvbIMs0YamK7MWu9zjS0FJBrHMq7C3Bce6QsXt87
 GSFh8eh/UnToZjtsIa7ukjhVVYPobsDBJ96jMRFcz5I1yOmadgk5MZBxkoEIyeI2Oqs2emsjs
 95zpGLlU7QCYt2Qvh6qSAvL7d84RMRTW8O1mfnqh8I+9HMkGCKE0fhFDurK2W1uJOOWBHVSeX
 zw70lF4VMUVGsmLkDAX9mYaiDejUsvVqEkhGGkmzHpmr/rvd+TEqSJdgyURT8HX2NpxDBba+y
 mnm+BrQOc8Q2zxDN9yAsCu54ce4mYYfJRxQH3cYn9EjQOrYKpa6ONpj+798LwFR655C2TG0Ok
 zHWqCG9lNAwLDpeu3Docy2RLxa1cIM/yxiQbW2oLh0euTudzQ7MG7Iyu6Zk4NOW9KK1HUc4sH
 JR7BSvmXnT1gBqtoMtcxBmixy5ynefboi4MPKcUqnzux2xAOVKrWXkO3gmoEiuhBLdsPwPEdq
 //gu93pCBm6BYVO+zQPSQ/vkVKuDcgu1qRGWPOi/muiEE5DkT5ErcFjEhwsksjpit/euo+I0v
 51BCHZ3Y+4Mf/QQ70Dwq9XrW+S+nwTlxAOk4nk9Ivddywgy+5jhMe7YMfajstKFu3PE55TCDg
 QZCVu5XbQU363WNLHHKr6TV50ZeT0lc0e7V9sWvgIlZTS07Mcyw8cVnIWTsbkC7+H9cnvQT4D
 zkRTmOfUe+9Sz07ciff6OikV0xHtRYiqwVIotAX8OuWDGMga8m+aSyNLg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/2 =E4=B8=8A=E5=8D=889:06, Gustavo A. R. Silva wrote:
> Fix the following out-of-bounds warnings by using a flexible-array
> member *pages[] at the bottom of struct extent_buffer:
>
> fs/btrfs/disk-io.c:225:34: warning: array subscript 1 is above array bou=
nds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]

The involved code looks like:

static void csum_tree_block(struct extent_buffer *buf, u8 *result)
{
         struct btrfs_fs_info *fs_info =3D buf->fs_info;
         const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
	...
         for (i =3D 1; i < num_pages; i++) {
                 kaddr =3D page_address(buf->pages[i]);
                 crypto_shash_update(shash, kaddr, PAGE_SIZE);
         }

For Power case, the page size is 64K and nodesize is at most 64K for
btrfs, thus num_pages will either be 0 or 1.

In that case, the for loop should never get reached, thus it's not
possible to really get beyond the boundary.

To me, the real problem is we have no way to tell compiler that
fs_info->nodesize is ensured to be no larger than 64K.


Although using flex array can mask the problem, but it's really masking
the problem as now compiler has no idea how large the array can really be.

David still has the final say on how to fix it, but I'm really wondering
is there any way to give compiler some hint about the possible value
range for things like fs_info->nodesize?

(BTW, at mount time we have super block sanity checker to ensure all
those basic values from on-disk super block is sane, before populating
the in memory btrfs_fs_info structure, thus unless runtime memory
corruption, fs_info->nodesize/sectorsize should be untouched)

Thanks,
Qu
> fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array=
 bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array=
 bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:80:46: warning: array subscript 1 is above array=
 bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:101:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:133:46: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page *[1]=E2=80=99 [-Warray-bounds]
> fs/btrfs/struct-funcs.c:156:32: warning: array subscript 1 is above arra=
y bounds of =E2=80=98struct page * const[1]=E2=80=99 [-Warray-bounds]
>
> Also, make use of the struct_size() helper to properly calculate the
> total size of struct extent_buffer for the kmem cache allocation.
>
> This is part of the ongoing efforts to globally enable -Warray-bounds.
>
> The code was built with ppc64_defconfig and -Warray-bounds enabled by
> default in the main Makefile.
>
> Link: https://github.com/KSPP/linux/issues/109
> Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   fs/btrfs/extent_io.c | 5 +++--
>   fs/btrfs/extent_io.h | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e81d25dea70..4cf0b72fdd9f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -232,8 +232,9 @@ int __init extent_state_cache_init(void)
>   int __init extent_io_init(void)
>   {
>   	extent_buffer_cache =3D kmem_cache_create("btrfs_extent_buffer",
> -			sizeof(struct extent_buffer), 0,
> -			SLAB_MEM_SPREAD, NULL);
> +			struct_size((struct extent_buffer *)0, pages,
> +				    INLINE_EXTENT_BUFFER_PAGES),
> +			0, SLAB_MEM_SPREAD, NULL);
>   	if (!extent_buffer_cache)
>   		return -ENOMEM;
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 62027f551b44..b82e8b694a3b 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -94,11 +94,11 @@ struct extent_buffer {
>
>   	struct rw_semaphore lock;
>
> -	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>   	struct list_head release_list;
>   #ifdef CONFIG_BTRFS_DEBUG
>   	struct list_head leak_list;
>   #endif
> +	struct page *pages[];
>   };
>
>   /*
>
