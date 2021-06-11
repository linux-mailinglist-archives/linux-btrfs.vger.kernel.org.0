Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3713A4341
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhFKNt6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:49:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:58483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhFKNt6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623419269;
        bh=DQZaNV/hwR/W07WPShIulNh1yaAYynzVvSqkCu5eIgw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gv0lZuxvaCRSdJw9ALtXnvPNz0RpqA3o41KJkHnFS3JAjFQN0NXaOJPZaJGXTvfRW
         cRfk/2pcZiRH3pYPujayL27QT3O3kXFTqWzKe5XgNOYazGOEsu4txjz+xPemm2fyAr
         YAjNey8WEfRl/vTGUIWJQwCexlRqJdpxyNvj5fgc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMGRA-1laadG39Pi-00JMkH; Fri, 11
 Jun 2021 15:47:49 +0200
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, linux-hexagon@vger.kernel.org
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a2411cbb-d793-5e11-dd4f-cc25ca55ed91@gmx.com>
Date:   Fri, 11 Jun 2021 21:47:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oz7Y2Pd5S35Xo4teAX2NkhjMPqdlSnZ/X9M7YWX87qJwU02UdFX
 ONeoj46pv+uWradLLCwtNKQu4Cfv5yDkU6d45LZ5rCh+Y/quqn58yXkyyZr6GdAEf3NTJn6
 z73x+9KfLF5ujCc1xo8aUcmcu5186WRbra////x4K2z4hYyKti1aXCI9uvZG1WZSdk0eBZg
 3K2AT4odeGMgO39E5fGTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbDu+ROrRRM=:IYeBLdyGVO30AKgwzEsXt4
 gG4vovTO3s34V2CXIH3btu/cwpr/xRNSZG+86ds/zxDzdUzeY40v7unNYDxYiGA7hBEhp06gZ
 1kh0kIajOPnDNXZAVoNo2FOE4IwWrLS+SZHAgNy5/Qtn2ZH+e0k2w4vxK5qwZqXbmsoMDtWqp
 UXyB3B9yrQ9TdOzaN33n0BsCpu3L4OIFkhnrzrlkRZtlyJHaPM29WA/0VjiuoEmeYKY7AsgvQ
 4HmmPnPePgovVDoNVTnoM0EXHFE0HgeJOE3GBopX7zaiv4b+7mdkZOchAM7N+oPe/2+D11V3b
 grPqObRUO2Vaj6qSsKCDpaDm7ckE0eetfMVyIUo8eYRAo2FOGUBxnAha/i4mMeHmK/Ixi2Wro
 QqNJREbuFNxzTiy9lCExyyk5+qj47I0U8Vr6UjJP4v+7F7jCPWMv5322jS6HzhuVF6qHMKwaj
 snNtAHa6Y0m4yWBMDXM06lcKb8knZRcjlUFZJ5gc7tU6Gpi9UugylOx8y0aIE9p6ZEUQPiEzr
 I0xhXHfh8Z4DlQV3WqMoE7vBo72U28jK09FPto0cuB4c0w/yZc0WDc9DHcDIEgEKpTjeS6t5J
 rOUjuKHNoLdhJ5iAfr1vdC6Ky9Z3sHO4rCoD1z8K0Qp3/dzyvIltfn/s9eacKdU3FiYSHdvQd
 gzz0Nfo2C+qJwDoE53dbldbOe13ld81dkqDJDdUENA62MzUfSKtOTKpIX/p62q3q5WaEmGJy9
 /0JFyC/XmdhnDmv1z5N8USGAd2GVZG2VhbJbxrCfUsNinG1zo3uiw+k11TdM4bkFMwQbQM5Jl
 /u/67Q/Ho25UIyVLHey18fBYKvh96vpKv75AJP37tclGlC5HGzfVPJbMrclCkLgMMbni5SIqe
 v5vNKDVvLukKc1mz4IZBSO/j7MtIA9oJH86d03cDEx3NBZKy0q2JwGTUCSG1xVsOWuiwjRftW
 VU0eBEflj0GCzVuXn0hh3YWX6IDFO5Q9crhZ2kqaFqZpAeO0l2YTp64iZkk0AvehQw46dkDmq
 RRbxqoCumDZJhsDVv9AgnK5xMorDPNl3UhgArmNyd5e5r9+lCZHV+XmRSyS1VpPf4mxdUWJ5k
 4/5dGKThpbFBLPEr3JoynjRfYJJ9Xwl+O69Pqs/bVSPrGE6wvdes4F1gQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/10 =E4=B8=8B=E5=8D=881:23, Christophe Leroy wrote:
> With a config having PAGE_SIZE set to 256K, BTRFS build fails
> with the following message
>
>   include/linux/compiler_types.h:326:38: error: call to '__compiletime_a=
ssert_791' declared with attribute error: BUILD_BUG_ON failed: (BTRFS_MAX_=
COMPRESSED % PAGE_SIZE) !=3D 0
>
> BTRFS_MAX_COMPRESSED being 128K, BTRFS cannot support platforms with
> 256K pages at the time being.
>
> There are two platforms that can select 256K pages:
>   - hexagon
>   - powerpc
>
> Disable BTRFS when 256K page size is selected.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   fs/btrfs/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 68b95ad82126..520a0f6a7d9e 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -18,6 +18,8 @@ config BTRFS_FS
>   	select RAID6_PQ
>   	select XOR_BLOCKS
>   	select SRCU
> +	depends on !PPC_256K_PAGES	# powerpc
> +	depends on !PAGE_SIZE_256KB	# hexagon

I'm OK to disable page size other than 4K, 16K, 32K, 64K for now.

Although for other reasons.

Not only for the BUILD_BUG_ON(), but for the fact that btrfs only
support 4K, 16K, 32K, 64K sectorsize, and requires PAGE_SIZE =3D=3D sector=
size.

Although we're adding subpage support, the subpage support only comes
with 4K sectorsize on 64K page size.

Until variable length version is introduced, 256K/128K page size won't
be support.

Thus I'm fine to disable BTRFS for any arch outside of the supported
page sizes for now.

Thanks,
Qu
>
>   	help
>   	  Btrfs is a general purpose copy-on-write filesystem with extents,
>
