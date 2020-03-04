Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D289D1790F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbgCDNJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 08:09:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:50307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388093AbgCDNJs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 08:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583327381;
        bh=5qnXMqgySXGP5pRei6DIJYG/BFrVRag9faOlvqyYZgk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g811Ge8S0yGkTO/K91WSv9zG7prchTZU9dNWUgF0svqD8C92vIGGAAvjkgdLTRXEX
         8hl4hsz/s/l/G+HbADY8LGqVHzqsaOrkGdP14HyuBqrolGlwFga/+03kzCdP/mEuuW
         G0DdDP8XLGT9VZtnUfF3N3dg22q4X6FxCQTITKmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1j40860Ths-005ZCV; Wed, 04
 Mar 2020 14:09:41 +0100
Subject: Re: [PATCH v2 07/10] btrfs: relocation: Specify essential members for
 alloc_backref_node()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-8-wqu@suse.com>
 <d416797a-c174-55a3-2fc4-4e7d31ab33ac@suse.com>
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
Message-ID: <7c5d718a-4c90-367c-1087-823ae4643d5e@gmx.com>
Date:   Wed, 4 Mar 2020 21:09:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d416797a-c174-55a3-2fc4-4e7d31ab33ac@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V1BCBOcegSuGldMs/TsB7gu//3EGa9m72JHB2WzEq/lSCMd9zm5
 ylB4C0pOLKWDdIf9lSHoz97ULgKB8rRkjn4lDk+Vfahv1GXcYG1K2q4XasvG+/ElTX2by2Z
 V/2nax1K59QTNe0vqK8tViHiNyJZrtcYJ6oJCCSIfrY/j6uMbumD5HW4oxl4hkCVuivGMP7
 3wG92puBCEDzLfoLkJs9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JbMlYrpn3G0=:0t3lMP+I9H4mQLKJSYUdUB
 OMKK5q85IxiBG5jRDloEM2EDuunAsJlxItwxmtdOtPfsoN4diiv6iWzbosa+5jKX03ltzSThb
 yJGBMUI43qFEygBEtWZVPf7T13h6b7T35pE3tuVzjaM8WNZgwQrbEXUxxpCzUAJJR1tj8Ishb
 KWtQFT+vOFcr6EHQiDfFyxM3cf79NmtQpR+qMwc/es9NkIlmtucP+qrXA7K2ZxCaNaKH2XiM9
 t3jfbQagy+9VYT3mpYWgzNLz9W33m0vjCRoDnzHAD+mMbzu+3qq1phB7rrOC6zKhOoTjsw0NH
 pJCzfIJmipCXtabAYSiSp94qcjINK1HhKUkcEHTYM8GHQHrH/0+/MZ1D/TnFzDbHnwrQG3qjW
 YiTMC/YKgwd6j7c5K3bQ0xHcka2ntvy7QgF1mgmqscWfUYSkjNp5YseW7Y9Wwe+y/eg0tT/ux
 OHFmx915tkjJ79bhxji2Kksg1OqUw29Ek2Ld741nD6pDF/wTF2pf0mvpWPFc6YpTrcnAfI8LC
 jmX2m1mb+0GVHOPyePLc4KrPEuSrvsTXoDGs6hYeLJWzCKUq4ZZU2XzkYWvMltJhIDc23mvP0
 rQT1XRS8y0Nojg+YCaXoW3n7PKsWcjoiNlimPRcVdG6rqBiHzOeguA5Lr2dltEGIIwiZ5cimP
 I/nQaAy/lMlt9CtzLXP/C/pP3GvY7tYcNdI7Y5EVU9m2m2bEFUogROcRMmQZSoPwBokddK5Nx
 2y45HNuXTdHzpeHqe4yauKFPhxSBX+OITU3USIvgEBIP1GWwehDTJ68od638/H63DJBbMnNhG
 1OF8LDbG+UrkC9w/3Mto00AoyFQKDNnulvCPwldOaqkQkBwHlsp3Tdzmdztfml+mIdwyWCV2B
 YgQMkXgZsRu9HwlWe289BnBEYY8FMxY60kefZjpAbzdcttRdDIdwBWszvjt+mgqqRmNfGij3a
 R/pSTmXXeRlvd69p2/pyctLhkKMeLY9u9/E7uLnXat5CryCPgSLNsNMczwkaU1S7ayl3l3obe
 iw9I5RY5MPDxvbmSyKebKcLWduiEp7eKyyvs86UNguXWdhnwf/In8eXUWjrc/whvpPAnx3Vzk
 lB1p3ZQ052BsJYLCB1qMREtqWyzKLJ9pCDtjTcLsx5cllQse1QGMo6yUoZ3mkmqQUMw0/gEln
 aDX2BNm6zn2uFu7JNf0N+HQh/7veiI525y9G4FWPcPKiL0h6z4CYSFA1P7mpaXo+wcV2S3HGC
 J/B4ahKoJeU9+1e0q
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/4 =E4=B8=8B=E5=8D=889:06, Nikolay Borisov wrote:
>
>
> On 2.03.20 =D0=B3. 11:45 =D1=87., Qu Wenruo wrote:
>> Bytenr and level are essential parameters for backref_node, thus it
>> makes sense to initial them at alloc time.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
>> ---
>>  fs/btrfs/relocation.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index c76849409c81..67a4a61eb86a 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -308,10 +308,12 @@ static void backref_cache_cleanup(struct backref_=
cache *cache)
>>  	ASSERT(!cache->nr_edges);
>>  }
>>
>> -static struct backref_node *alloc_backref_node(struct backref_cache *c=
ache)
>> +static struct backref_node *alloc_backref_node(struct backref_cache *c=
ache,
>> +						u64 bytenr, int level)
>>  {
>>  	struct backref_node *node;
>>
>> +	ASSERT(level >=3D 0 && level < BTRFS_MAX_LEVEL);
>>  	node =3D kzalloc(sizeof(*node), GFP_NOFS);
>>  	if (node) {
>>  		INIT_LIST_HEAD(&node->list);
>> @@ -319,6 +321,9 @@ static struct backref_node *alloc_backref_node(stru=
ct backref_cache *cache)
>>  		INIT_LIST_HEAD(&node->lower);
>>  		RB_CLEAR_NODE(&node->rb_node);
>>  		cache->nr_nodes++;
>> +
>> +		node->level =3D level;
>> +		node->bytenr =3D bytenr;
>>  	}
>
> nit: One suggestion for this function, feel free to ignore:
>
> What if you do it:
> if (!node)
> 	return NULL

I didn't notice we can do that.

Looks like the style I prefer too.

I'll use that style in next version.

Thanks,
Qu
>
> and then have the initialization happen with just 1 level of nesting
> inside the function and not 2. That function is short and easy to
> understand but it might be a good time to refactor like that. If you
> think it's redundant then don't bother.
>
>>  	return node;
>>  }
>
> <snip>
>
