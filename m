Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D9263060
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgIIL3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 07:29:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:49383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgIIL2b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 07:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599650848;
        bh=9StOKP2ysRJ0A8TtrC+tHS87+bDr4EtBOsI0Yz+XHoU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LcnbMKYFyrlSeXdqz37HiVKfpNqcJ1vnZBCEPRvHF4zdT2A6AJ70dRmlSVrKnrzR2
         G4SXO7reic0s0DzGd4rJYhlYIGhM7LSTTfZ/n/K/U4mIgep9XnnX4Hb6bt97UeVs7j
         mG6dQJ5QwvXFPuDZnewIvAyStMsVCXXHNTEcBkc4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1k4ATI49Uj-00WE4u; Wed, 09
 Sep 2020 13:20:54 +0200
Subject: Re: [PATCH 03/10] btrfs: Simplify metadata pages reading
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-4-nborisov@suse.com>
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
Message-ID: <d4a8e47d-04ea-79dd-3dd9-0080b611112b@gmx.com>
Date:   Wed, 9 Sep 2020 19:20:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909094914.29721-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HKp5K2htdxYQdj4Xqfr7AiFOVuYvpcd8Xj40NiwVm4E9HiUPY1G
 /5I1SYCg1RE6wuWtThQYxd6ycs4pt/m9c+9xfNIV+E9o3l8RKw72edr7QXksscoz7s40XFE
 fzFzOPaL0KIDtGMmthmPaEQWo/h3D7mj6Mk8/NpAetWWQXKhpcIS7slzAcbUQvZHvRbitre
 /nGhqsv1eYcUs0b/MBqqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TsK/WDX72wY=:hT1bYOKY07ntAthVOOhyrG
 9GWK14Aaebj3z9WiRuxvYgm4xLN69Uf5ZDn7WT6PUKSsgZbo7cxB6e+kZesp7buzGavcqfEzx
 gEyg1PylolTdrOznm5aM16zCALdf34rtSM8QAIgEbZGIAGw+6WFSC1h0y7vsQ/x/3Gs5azrMD
 0N/c2ijYiR+/APYW6HKPTTHsxUp02M7smFyUqa6ergCZN25NRKSHKZZRA7tBH5a12q2oxIvXZ
 Cs8Y9Wiz+gz7vnZalqNuwmtwWkt3d/RFF8ZZLeY1ni25PgPGfSTlicVxhRWuQF70g3c06EFrD
 eYG8yVAN5kWSWgjxHP1EO1SnfN1/S9zm0p74yhkGPO6CKZSRnCDQUYuKOmEbH/77K2FZfmjAY
 1g42LIHi6Sdd86NOXe2EtE63noeI5TrEUWO0VH1EJhcAYPhVUDrSjYYSD9BBGZTbbb27K7viq
 +mkhNFUChC3DnsjirQzLlFqjOgzKiN6JvKKp+itPH1BpmCPpAVx8yW1YMPan0eVfVUBn93nvq
 ISmSK+dw+2RkUoGvdc0Nl8abYIsQlQky9Njw/3skKu/5RwuTERfhb3ksHNRb9E7BFDpsco16u
 uk+Zz1PNttNefMdUC/4uEndjBec5tUQtzw3+M3nVvPNWhTSPrL2kqNzEr30CG5Xdqv1xNwI89
 SvqxJC4vpaOWxqnCJ4y6Bu17++hDr5M0xIoMWniRH1RkddsoG9Upc7leaxrVQSx6PI97wliEH
 XscdM+bTNPwgkQBQK0DBP7UeRB5NyuR/t9EAhYYPzJDsj3kSRsNxUQS3o/7fGzBxregCYuOXV
 lKVR/KP9QRD2pVxLHXPW106G+li71IG7QSuRlGP5Ly6Dx1/UnIfzQrNDRa52p3CpPgwplLODm
 +yCohLRjg7KZb4ST0H9Xr03ft52Zoc85a2DwK8LMFxNpa/Yd3oxn5KK6tpamOzGTr1sWPSHPa
 iuhoKiUsY364dUgmn3dYPbn/W0buo4zG3yBOrcOn0ZK7C7KVetF9QbHBg6/xIJtsZGpRMZw6Y
 K2cK+xD8jJixIZHv9H3ePwvsMz43jnpVjHs0Hs5mL4sJZpqlDJhKoEGF0CwbdtDSp5i/79fRM
 RL3o4eF4QxLEvQlsySx9ueCE01dx6Al5Yxh8jQTuG3tQPIWbVPG4x1uUUiLmrbOyaKHDegKY7
 l/Qq92Ufgxz5zCaFtuSy/SFgnDtgrik7rwFuezE4zT/hfReKQ1nyCarigRKgvm/dSfc0vrXet
 gXuXpIZ0Ci4meZBaCmsAlgXmlI1drRXyU23WRJg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=885:49, Nikolay Borisov wrote:
> Metadata pages currently use __do_readpage to read metadata pages,
> unfortunately this function is also used to deal with ordinary data
> pages. This makes the metadata pages reading code to go through multiple
> hoops in order to adhere to __do_readpage invariants. Most of these are
> necessary for data pages which could be compressed. For metadata it's
> enough to simply build a bio and submit it.
>
> To this effect simply call submit_extent_page directly from
> read_extent_buffer_pages which is the only callpath used to populate
> extent_buffers with data. This in turn enables further cleanups.

This is awesome!!!

And the code also looks pretty good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a note for further enhancement inlined below.

>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ac92c0ab1402..1789a7931312 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5575,20 +5575,14 @@ int read_extent_buffer_pages(struct extent_buffe=
r *eb, int wait, int mirror_num)
>  			}
>
>  			ClearPageError(page);
> -			err =3D __extent_read_full_page(page,
> -						      btree_get_extent, &bio,
> -						      mirror_num, &bio_flags,
> -						      REQ_META);
> +			err =3D submit_extent_page(REQ_OP_READ | REQ_META, NULL,
> +					 page, page_offset(page), PAGE_SIZE, 0,

It would be better to enhance the comment for submit_extent_page() of
@offset.
It's in fact btrfs logical bytenr.

For metadata, page_offset(page) is also the btrfs logical bytenr so it's
completely fine.
But it can be different for data inodes, so it's better to make it more
clear in the comment.

Thanks,
Qu

> +					 &bio, end_bio_extent_readpage,
> +					 mirror_num, 0, 0, false);
>  			if (err) {
>  				ret =3D err;
> -				/*
> -				 * We use &bio in above __extent_read_full_page,
> -				 * so we ensure that if it returns error, the
> -				 * current page fails to add itself to bio and
> -				 * it's been unlocked.
> -				 *
> -				 * We must dec io_pages by ourselves.
> -				 */
> +				SetPageError(page);
> +				unlock_page(page);
>  				atomic_dec(&eb->io_pages);
>  			}
>  		} else {
>
