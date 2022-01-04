Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7E484B33
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 00:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbiADXdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 18:33:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:52907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234152AbiADXdD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 18:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641339175;
        bh=86C2wftjndtAK2iWcv41C0xFmPUyW3b0hrtgz4GnTTg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JwVFYQFMRqPO1greU7wXOsdkZxbBXgeOffBsHfV7QiF/dzCXwg3e27fyAyiQNIzaY
         qttcIGNq9t1ZO7Od7FycmOhlRu1x+nvuF+AnuxO/OxN/nH77Iq0J0JiYFaQGa9X8K4
         RfH6mG26/af5uABh9PDs3IGpUHs176MGd/Vrp1e4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9QC-1mCnEw1VLw-00s4eI; Wed, 05
 Jan 2022 00:32:55 +0100
Message-ID: <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
Date:   Wed, 5 Jan 2022 07:32:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, linux-hexagon@vger.kernel.org
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wgQa5C7dmPnoEf96aFIhDwr56crC+9t4UEuJO6iZ7LATkecwpmn
 2o4Ffdh638ZuQ3AZ/sHWO1B/LgDuf6rkh+vFOqSlw3slUMp4aZGQF8mFNVq6etD83zMZYEE
 5khf5L+YplEVXjk6LrIm9F4lFP77VI93pDYjn9u+6SRa1523PBu5ER9jj7DE18Pxm79blJi
 X06GHFHoRXKO04ZRE7S9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJLQ+lyiPPQ=:Hl+NW2skMt7kFcucVmV4An
 M+WsCbpT7ByUp2ehjSYDA5R93Zixllbs8eC6IFN3ixvYjnDt970y6mWr91Sbf4BoAAI9zN1cB
 o51tyiGHkfjJQxU7Dp9heXqZfXo0W3UOndfHLq9/DmLgHsk9ggTdSj5joqjw0i42HHDU6Bucr
 fAh9NOhAhaz936lxasfv1jlv0IavuNEb5ZXdzcdauxRDejSJOhDNusoQ6MckvRl7C7FNHVtwl
 4J2jZ3ysZQFlNHMKwJ8DxmDKOGpVUJSWx7k8UVyWV6YSkea0eHnJQrYDmMi6VkW+bt1NFr9RV
 AHaRLrCUZDA3Jwjd6r9c46TMEL5dAKS86BN2EA7s5wB9WZR77AqohW/QiSA970zxsiVfSlvxR
 VhC6k1XcO4P1N90cfPOTcbqPexZ6ZBzZfw2ou/R8HX/cXGLa1vrOVqjcEcU9pllPlT0f1XVBz
 aZHmJT/h1kLwlUqaQKho0jyPYk4B1P6bjuEQaXkRnp4cAgKpuapiVunxQjkX+8gdzTX+ppSn/
 DkstP/WfWFG1qaKIcvOfeVFfW5KcwivF9p7zluOHX/nnjgRXYJCSNEiNP6WgD+vZT1FjoMtqW
 SQ/CC7rA3WpdX5eN7bvvCN8hfD2AgfVnoEOlYjYcJblmT6vZMzEjwtyLEWrhYIPaPWewtI4mp
 JchODq8Kkv3X28fTRpYzjIBRFvWjqwBIMOrDPS7ykEjHTaMJnkQXhhw0czd6ejyfrRduICqY7
 QtIhlXw7caKHEXm/DzmfBUqfSwPFkuLp/ylcFXczNkh2VsnYFzNRrRprt1ckOQRbxNRIZBo0g
 +9OkeHZHqp9q1wdxdeIUh5doyqcBRozIoNezS6dGkZDBCN4oHVZTCJo7F678xZhTxS8ax8qSk
 b//EhA4v6ERBWM6k46x8dVIeQewhZmXrelGuAlmR/MXFml3lH4/NejJ2GyvwbqELUadn1hRLo
 w4dWwT5WwjYSwip629P9jEswjSkfILgQaA0CgfKSvkmLJuPT2le6gH39g4b9PAziKvcuto2B+
 XIz1sApS0Ap8thEQYenYkx3IbVpH7mhSRTHrb1Nt0D6E332T7bJPW1JEbRunw5VhBPijviY+w
 esSM8gUV5B89FY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Christophe,

I'm recently enhancing the subpage support for btrfs, and my current
branch should solve the problem for btrfs to support larger page sizes.

But unfortunately my current test environment can only provide page size
with 64K or 4K, no 16K or 128K/256K support.

Mind to test my new branch on 128K page size systems?
(256K page size support is still lacking though, which will be addressed
in the future)

https://github.com/adam900710/linux/tree/metadata_subpage_switch

Thanks,
Qu

On 2021/6/10 13:23, Christophe Leroy wrote:
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
>
>   	help
>   	  Btrfs is a general purpose copy-on-write filesystem with extents,
