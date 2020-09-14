Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA926899A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgINKvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 06:51:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:53375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgINKvx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 06:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600080710;
        bh=b8izZVPmanoh7f82TucVnlMonUuB2rmigd/Nz3wTUOo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CcE/V+kZeL+HVLNGFa+RF57rGKveAWc/OuCxMV5kG+wvKyVFPqv4i9/NWGmxgv7T1
         ZvY70WjQ8k+MQ6g/7aADlNwBZTjIzTgDzmKd43BSKJCluSjB9Jau5YSCr25n5ZGH0e
         9wGFqy2NwR1985IJeyHzsjNvkccCNM9y0SOaCEeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M26vL-1kFI323ZIv-002Wsx; Mon, 14
 Sep 2020 12:51:50 +0200
Subject: Re: [PATCH v2 1/9] btrfs: Remove btree_readpage
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200914093711.13523-1-nborisov@suse.com>
 <20200914093711.13523-2-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <c39f36e5-5502-c118-6df0-8dd0ef278d7c@gmx.com>
Date:   Mon, 14 Sep 2020 18:51:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914093711.13523-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4WU5WbEMtM0X4LERA8AqZ8mI0PSBhbd2ZoXXMhVKhyWgfwISzr
 rJz0KSij8+uLPAjWnQDllKO0YBiIdt0kPEIVsdD958+tFgciT1O2z3VziuVmQ1MgGX9R4pK
 TNO2hl4bzdkzYmHmgsLwyEdRQW/caHDeVBY9ralivuwLcgx/zvSXWnkaffM6c+oYERnfTee
 dvOGfVat+HeIti/zcTsMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OTc7ftDAmhA=:MVcO0wT5DEoavAt++eO8Oj
 tDVrKhf++2PkSu2+R2GgiwVV6pLk5AFMAV8dwqJ7UD7vs4fER1u0EZ1stzTEzF6gbItRjnzOj
 l1lopwvKG0gdSgiPq0MGwFg1qDV/5Jecmy3LFVh2dCgHZVdQi6kgll7Gr/hJJIj0xt5wTxH9U
 hkGz6C7smkqMTvYYiwf3dqV96wPpTXQYttzr3sGWf2cZdiM/AW6bEv17WSzLqIQ1PknUCi8UX
 3BQoHFKJwtB9H4UrottXCyt6Ysz72S42+hkk4ZLORDx0/Ffa9C3JZJiUlAQy2VHhbtcIF+hHg
 xaCcGKrm6vyGPDg8IsKGZN7YN4Itil23O+AXXbKFCRTmPsVm1k1CoOSACxpZksuqy//8JZAxr
 0+W3MNO0wojqWUmLj9GbRF/ZIhrvkLcfljXUGtIyI3d4I5iIuTLPuMslYeXCesxTKCCQ4KfB6
 lo4/I93o6+5Fk+gogAoJp3+KJV9Sks6uN+qH7q7U+BFTOonNCEJC206z8fVsr7sioF5u0pAgX
 IQ/oI4+5YSDrABs7Tj5iQQwZp27/u2i7Q4dCHAwDMT7AatttA52M5EA+9K3quF0nWQIWScB2r
 +9Roj461c/k+J6wbwPkvUWGERHmb50Jay1r4Vd22RO1qNj/AI2te6Zaw4LS660zvYQPav0yJD
 EvENY7ijKT7hgRmGTS0fI5qvlRQHTtnfCtvMt6H4ZKCpPPMwT7BmaF9uTKCADMorxBdvvtS0m
 QP0dxSAbLfaSZF8pusQ9zP6N/SugotLVXBI0/9/owGhlyQhnrBhElSj/jx03hQrrgmFcey1kX
 pCEpOX3BFPs14YHl8OarIbRd1p5wf6LsuNz1//ueg2o+SK85GVWKxpfz0c8chloTb55mH4Ub3
 xpijtjXhc/XuKcPMZA8nrsSgxKt2nCcO3Fg50l506MOQs7zRJowHF1/y9/a3e1RKfzoFm26Pm
 6qb8RAuqocrCvg5nXmXzKPI66j2topuhA+j5uLn+A7ym4wULV5nq1adFVYP8IwIMk7pMicjAX
 ZitzH1Eqqu1qBErLdesxxkFDA3k5KAj+bFVm8/CcKSt8AVr25BOIaGPlzdEamCg3JynX4OHvI
 yVexn6h5WZ+qevgbaaMZE259LlirH0j4m9nn3BM2SMvrMWpnZn8xBIfxp8SgfP3SSAUsABtlV
 85DcLVsV+Mh5sNdDMfJ9lljlgV8ENyxMP9J0AVyIzwJoDPzISGiGKTdDmD9ua25gbLOCPsGLT
 3+BrgTOjnN+/13AVbnV7oG2m9LaKUmg3MHrhKCg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/14 =E4=B8=8B=E5=8D=885:37, Nikolay Borisov wrote:
> There is no way for this function to be called as ->readpage() since
> it's called from
> generic_file_buffered_read/filemap_fault/do_read_cache_page/readhead
> code. BTRFS doesn't utilize the first 3 for the btree inode and
> implements it's owon readhead mechanism. So simply remove the function.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

With the new commit message, it's way easier to know why that function
is not needed.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/disk-io.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7147237d9bf0..d63498f3c75f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -949,11 +949,6 @@ static int btree_writepages(struct address_space *m=
apping,
>  	return btree_write_cache_pages(mapping, wbc);
>  }
>
> -static int btree_readpage(struct file *file, struct page *page)
> -{
> -	return extent_read_full_page(page, btree_get_extent, 0);
> -}
> -
>  static int btree_releasepage(struct page *page, gfp_t gfp_flags)
>  {
>  	if (PageWriteback(page) || PageDirty(page))
> @@ -993,7 +988,6 @@ static int btree_set_page_dirty(struct page *page)
>  }
>
>  static const struct address_space_operations btree_aops =3D {
> -	.readpage	=3D btree_readpage,
>  	.writepages	=3D btree_writepages,
>  	.releasepage	=3D btree_releasepage,
>  	.invalidatepage =3D btree_invalidatepage,
>
