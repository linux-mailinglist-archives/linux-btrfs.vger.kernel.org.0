Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6263C263054
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 17:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIPQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 11:16:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:59863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgIIL3v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 07:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599650990;
        bh=B7AGbDVXDhpkirq3jER6IzeBNdkXvtASnvepYaqBAlk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CyDZuZf9wKUAFeUlYOWJc3MqD83SLGP0qaQqm2rwR2dzokHMIj5XjjlStdI3GRihv
         q1EcOaLRmALkSAdDk+m96SotJScWy5F62X89deUQmmPsy7Wp/Z//nn+1ddDCKgQ3cp
         psSI29HUcfYUbVz42V4l5i7yiu0zYGtytxjqSuA0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9Mtg-1kcwug0xKm-015Kdo; Wed, 09
 Sep 2020 13:13:10 +0200
Subject: Re: [PATCH 01/10] btrfs: Remove btree_readpage
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-2-nborisov@suse.com>
 <MWHPR0401MB3595EF09FB771F648F534FD09B260@MWHPR0401MB3595.namprd04.prod.outlook.com>
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
Message-ID: <11e52423-f84f-6ce3-6707-fbabe6d823dc@gmx.com>
Date:   Wed, 9 Sep 2020 19:13:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <MWHPR0401MB3595EF09FB771F648F534FD09B260@MWHPR0401MB3595.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fGxwD78pauUVnGs5YDeEVHlpkpGYfu9TwsiD01WpmIkhsF5l/fd
 yKWSq4Zs+D3YaYmraWNcqyxCCdSFlphoVjQNaDjuavx1zz4oU4lR766jeLQ6n7OcTzLTJ2q
 fnswqOHMcraa5hgf1lkq+ahIsGAXismQ2I2PCS56W7Fs/IJrF3bgSIqltgsxXq2Ag2Mgx65
 NBTM6eGj7nVaOHBRZk9pA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x7xyLjhXtvo=:VzL24czfqfhJM7Td4aCgy/
 Mc5DyUUDLetallSukOWBXJwEk7xYnUcmDfIgWP3iouRXRP3vCLqXoYV/eWmxACd9PnRg4ygN2
 xBe4D9p3hXhpPKC6yACC4eVrA/HVb35bYmP257Pa1M2twZwiowUQaupMYUiD9+mjCpuwG+9xb
 DYCfQ2vrnXXwYFAn8h/Qvml6VjKGBvtmmdYr58zViqJ1grEGEihAPrO7nq3xb+A1a9zyXvzRw
 hiBCowApwXSGGBrB+jL1ImXpDvdUmTsiy6uX5/QTdZZy+DqmSOvzc92iAilkmThgnU0AipOqW
 0ATFQL/nxJXlfkR5mOYFL2g/0p5Yr0Nnf4Ie8i2gvu1j8WD/6UJKPuFPJozMVrMVuV3E1t7AY
 hrCoIGIfhUhT1o4FXE9MrqLtGTLSt8PabtYJtxDMIzfitm4kAHSvwqV2TRmdXiua7rlx0sjio
 oXkDO6d2WLABgOHuRzwtm4A8/WpxVdiSk4auiTsfQy9t6bd7fPQHTowHzZwuZZpGkwsoqfAzz
 irGvI4s2kI2Ih5Om2hKI9XnIvertvFu3m8+gipPLd3X+++yW4pGp3idX9+oquEUj/DWr60LH4
 moqjwEwBnYg6m9zx7zgc6svSCUp/GtrY0Qg5e2EaDJIWqQGJZio86Nj2iOcHy1tJiU4nuMAM/
 rRXzhXm+eik94piUxBdWQ63kB8LGtx5QC13KdUdVdFvtjDvIjPX5vOvKEpKCTVXSiXky5Enbq
 OPAlu/kc6wXgn7mHtpWox6vCF5bE62OxZIuL6L7HOPzP6dXTRQmb0b7uzOrMqgtBWn3K4PD8M
 7POPuD69yxut23NK5N6Ur2g9xpVsnBS1Kz92Q/dbgWKnQxbhsTwbJYhZwmWFKtEbQ2pEBhAEi
 LxRqCY40MAVUvI4YUnimuRSAEvIMgT7C4ub4psDu3wnKFMIuBX89Iaf9mbc1EmvihhhUCFHsV
 64rPARmpz+IJUtYEz3XWiBno7L65Jx/kvOugyYVWeoShu49aAG2InPW5IjwpR7h3VNJL+dxT1
 k7RoLW5EzvnNm++mlaO6AqxviP/d+gzC0+UG9nicTaes9yhvcg8coi8jOtnVbW7iGoav58GBa
 9EyCEW9F7NWQ52aPcmIyLjHJEch5cYcTfwL7eKueKn5+k8SOXVUVLyxkaYUzrHueIYUakhpYp
 /LZ62PI2DjBxwzAsiE6UnhsOYXUUEaBC3ORy65rdJD3CWxPXR3ZaYvIvMjcUKE2S1vffl+qr7
 kO6uviBTvZNagEK1+Z3w5HNneaA9I3/gU5RztWA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/9 =E4=B8=8B=E5=8D=886:37, Johannes Thumshirn wrote:
> On 09/09/2020 11:49, Nikolay Borisov wrote:
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/disk-io.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 7147237d9bf0..d63498f3c75f 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -949,11 +949,6 @@ static int btree_writepages(struct address_space *=
mapping,
>>  	return btree_write_cache_pages(mapping, wbc);
>>  }
>>
>> -static int btree_readpage(struct file *file, struct page *page)
>> -{
>> -	return extent_read_full_page(page, btree_get_extent, 0);
>> -}
>> -
>>  static int btree_releasepage(struct page *page, gfp_t gfp_flags)
>>  {
>>  	if (PageWriteback(page) || PageDirty(page))
>> @@ -993,7 +988,6 @@ static int btree_set_page_dirty(struct page *page)
>>  }
>>
>>  static const struct address_space_operations btree_aops =3D {
>> -	.readpage	=3D btree_readpage,
>>  	.writepages	=3D btree_writepages,
>>  	.releasepage	=3D btree_releasepage,
>>  	.invalidatepage =3D btree_invalidatepage,
>>
>
> Maybe you could add a little explanation why we can remove btree_readpag=
e.
>
Same idea here.

The main concern is, wouldn't the exposed readpage callback being used
by some cache or whatever from the VFS layer?

Thanks,
Qu
