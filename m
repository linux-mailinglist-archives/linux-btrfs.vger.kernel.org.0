Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3251916A6B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXNAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 08:00:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:38013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbgBXNAu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 08:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582549244;
        bh=u9JJKVhyJ9Jp//SHhFK3pKdR4cdi9AHrgy+EUE4ND48=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EJax5X05O00w8bkLF+wg3Nys1jVvRsoy6DaoLw582GMRysK2LeZyTDf9GwvuQAxRk
         kPSWqYf7Bc4If8ybLLkXSvp76LDZcCRfUszivc5vpuZ06FpTqMu7A//IMOTH7jxvNV
         aNxdevs3l1x3VM1j6TbXocPXT3ejZswK9aqntI6k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9o1v-1j2f6n0jDx-005tdU; Mon, 24
 Feb 2020 14:00:44 +0100
Subject: Re: [PATCH] btrfs: Fix uninitialized ret in
 btrfsic_process_superblock_dev_mirror
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200224125628.27121-1-nborisov@suse.com>
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
Message-ID: <1bbdca2e-b92f-b9dc-dc32-de4de377a7e7@gmx.com>
Date:   Mon, 24 Feb 2020 21:00:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224125628.27121-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vpKkFsIjGvghICiPcGEp8fKUkLF0YKnDCU75VW3wEnzzSTmeXBX
 IL+5Rw046OozPAiKGU7mT9DXLvBRjXLsaB+jnxqOetzRJYZS5gA+z/HXjTL3x3r07Q6IXM4
 l3A7eQUQBy2YA1mgXdYBMNPb9HdI2x42PmMExsIBTOWjn7KOBzNCdpWarBOjki5q3c2RWrZ
 ia3Bh7W80Nwod3NmKXh6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivL4J0R5kp0=:lcAiSIhR4xJajwWyxRKfvG
 PV4hGB3Tk0+WBlmF+25DwDxcqT/lv1W/sdNj8x1tTOCpKv2TlnWuYBin5rxCcb8cl7eFojGh9
 raesknuPZwwHFGbci40nmTh8G42eBoRSD/3KnDip3VcToD39Nn4xTT5xRyQzip9DXff9pPQsb
 OsUpM/WKnF6YDW2u1/5iDKcwEsaUOfK908GnB886+Jf7aI99weMLfznkyqKLlwVqcdPw900fJ
 XLw0cLZ8Vjveob37qJ8/87ecL1iLVMRl3rJlbDmsn8QBSc8L77Jl5D3zKFJi965uIURUeA5eI
 ajrh1hIO+pPT3Jgb3+IGzQdpzL1X38buBb/z+m8QQMUgyCwhLGnmcLZyWch62nSVzvVdie5CF
 hp6TngIkPYskzg+Rn6Vl7lbW90vBhtW2ltYJrTDR7f/bCi+MGEtc7dvgZiasRd3oijOgJ1RFb
 /ciSXfyoYmQf8sZbe/Kjttj029R0tPlTn/mgN4Uw4kzUVx1uAZnDSMLenk4cSTSXe+aehu7U9
 7b4n78AdG6++Yav9+b5kXuFSSAnwKpiExghltzyEMGmWy8xHed8Lr3HgUYmBAWT0xPchfPBfw
 +/U1Om4OrjY3OKncihFv7693VI6EOAk1W9/7I+2zIcWJJoDdYa5pmcfr0VxoRyQhxLdM6J7zA
 3P+Vv06IwessPFnwA1gdmLd5l12HMj/Dis7PJax6QN7OSG8au/pmx77Y32MS54xUsCgNUmDIl
 SkxdzagrqixeJiytdV1wkpr8Vo2vzqiiUBwFS4Kw67DqlDhDzWwqlz86cUHPhrGl7hEIYu0Lz
 AxSA1/T7vuBwBbKtxal6z3XzZXr8l4G/We7L1MHkiblaP86/OXL+PDUYWsp+re4y2HS8udjt6
 0gmKZ0Dw486tvU6UTSTfEjGbZXRkhYZ8RIeLhbiqA97MXVF3TLy3hpv2PU/MP4KMD0aU1fkq4
 MuGZIg7u9plK/9vsCpLy4W694xxepwYvXHeIZUXpPNpHBdLjQzHYDty3wNvVoCum205nAol8F
 JPmSN+PkVGocUaF4VzGnwCd0XhfyMQiymlPv87tSKuZxa98xp45BWKABx/szDWWSo9TmRvfdk
 vLz0EN5Knl0oQFdoKyguV7cD+eq1VIqFlN72nn7YX4DpngfvCt7zQnYMe930r6ovCZPKavBA/
 FOM84fGMsxl2o23NR0PomI9x4H5qDZgyIxk8QwJPFr22h1ssCVUL4+IZd7kz5TfXjMUx6nWaf
 TIIBgK+sMbZhl1elA
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/24 =E4=B8=8B=E5=8D=888:56, Nikolay Borisov wrote:
> We could return ret uninitlaized in case of success. Before the code was
> returning 0 explicitly in case of success but now it will be a random va=
lue from
> the stack. That's due to ret being set only in error conditions.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/check-integrity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index 23dd65e1c5e3..85b27e9742c8 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -766,7 +766,7 @@ static int btrfsic_process_superblock_dev_mirror(
>  	struct block_device *const superblock_bdev =3D device->bdev;
>  	struct page *page;
>  	struct address_space *mapping =3D superblock_bdev->bd_inode->i_mapping=
;
> -	int ret;
> +	int ret =3D 0;
>
>  	/* super block bytenr is always the unmapped device bytenr */
>  	dev_bytenr =3D btrfs_sb_offset(superblock_mirror_num);
> --
> 2.17.1
>
