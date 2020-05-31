Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A21E94CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 May 2020 02:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgEaAwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 20:52:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:51517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbgEaAwA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 20:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590886316;
        bh=HraL4VkfMnmQVl4RsXezDUBii/wN4LWSq/5BaAqBS7U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fNfMqioJ9XzNXvhFRBiavVjnoQEEuVc3bw22lyNLy3LWAxcRBQhi/BKXkhNfn3lxc
         YQRGGKsdmpGoBvhSAz8s5G5PujvQcpANMNbBn5nTMjRjyN5O3VLXWIOsH6I6aDffoQ
         4gwt8ufq8m7RFj1mx6gOl7BEnF/G8N+a0gVL+SxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBUmD-1jqyAO3ntn-00Cy2S; Sun, 31
 May 2020 02:51:56 +0200
Subject: Re: [BUG][PATCH] btrfs: a mixed profile DUP and RAID1C3/RAID1C4
 prevent to alloc a new chunk
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>
References: <20200530185321.8373-1-kreijack@libero.it>
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
Message-ID: <fc8f88a4-3812-a0dc-99ab-929b27d7530a@gmx.com>
Date:   Sun, 31 May 2020 08:51:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200530185321.8373-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eaKjwQFEcBdfPdadQinV03z6WjziP4oaTe5FCC0cnRRefCCXnV7
 CPEwBVFqdf/YacdyxAT8B98PLHxAA988nn/hzZuEhSsjvDUxGIZJDu2PPKnV9jlXlAInAoC
 vyDQYhvymW9hqg+nYRWb5JzjMFJdURw1Ztalvpbq3RB1YI5rBQl4tIIQA7f2teFSLJ6u7ra
 qJUVCaf/O048H+6YZefWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DqTiUM4KpxE=:yvnjMU5SvrsFCngDUqUgs2
 ZWJYpnEHGkIJM7GpDCoK7ILSiYHBCyDPIliRIoXYglAD6dZuYAXbwDD14D3wILKw+bS7hK1vi
 H0ij1YSabKcYGvPp1IdZVVw1px+2H2MPeOL4XTuBaCSLpTX1Oxi5mdjpflxIcBdAmxWoW3wDn
 VE+E10xQbeYTM7cjYgfd+zuiDDPxp7foNA5l39fYJQfAOKXgs5JKlt4LXfEKCWfkJran7hLWz
 joKnZGq3VDrCG48f5roF1sM1iXJFyUiw1eClH9Ci1MEXsjXJZqcqVPbxSdg3m5OeTdSKY1aMg
 dy4lsE+ac8plY56UiBqggFpDUtSRCXgnvarciqTOakVqkkfSU4thO5PRgpvSj6fXUreH+mOHt
 pkVf8PDIuBJK8HgUQEFtF/FRHtPy2yPj+cFBptdWspegng4gfAnVFD5yDJc5Wk+KqogUmZ16J
 R1+878uj7Lm1BZBNZu3lM2DYAkBfAwkibel8YIQIVrjFbt/PNYeGCS6lUIRlte3kPKFJC5OBX
 EmdTxHg/SE6HuqDEYfLxvgZj2n4XaYFC0TuUXlL0V8BeawvQZGM+8hB4kpg4DHzZQPD0QAPFG
 gWE/GmSlXGIOQQWrFUfmOwMy0JNoA980A/cta/bRouaolw7g54JAmzt8RS4jjFja6CNde8MGK
 CTTAdsSvgQEdK3wXRrElqEPSD5rcUl5SWNeLr6+y3Y8Ym17My+qQY0qxlqDMmOtrzKdCG7Ygw
 cSAVhkz7vbKRVHKWcIuY3hZBk/brUvQsHyVt6XxgXbcUmh8d5sjs0nf8tOPysEQ8k7CV7WVPr
 dKzmsyJ79juuzZPCzO+TqsEQO36oE7geGlz9ipEUejXRwgltGy5ZEgufiMce4BHweKSEkfw90
 mTY7DPqKmfEM9vDT7Ewl67EbZ8hlKYtoUMvwZWXzdFywGpZTh6zJ/CCyqEuAPfwxsl+3HVXTX
 9D+GytPkoVoSO5POkuDf4k8rHKMHVNYpjuCc1Cwr3Bvq3G/qBPg3stbMqyGgmZmhanwZvxWIG
 OmXrxlpsSmMm92FEZbIqgrX5+P/srS866koGqCTvBB7W8zrJUd5MY9ExGBxPcL0b0QGny0Dd1
 JXUNxhkxFB8f9dB/PRIzanwqKw4BZhP1hQLlSL/J86jH2rCADuBoL0u+bfDSO/BuM6/JeWehC
 cI4tvH96oR1WXFbV2K/5WBJUxiSu5ufihy04OpMkO0gme2vkwGTU6u1dIT4d7Y1jAtMxRQ0Rc
 IMCMAK5niJ0Al/vZL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/31 =E4=B8=8A=E5=8D=882:53, Goffredo Baroncelli wrote:
>
> Hi All,
>
> after the thread "Question: how understand the raid profile of a btrfs
> filesystem" [*] I was working to cleanup the function
> btrfs_reduce_alloc_profile(), when I figured that it was incompatible wi=
th
> a mixed profile of DUP and RAID1C3/RAID1C4.
>
> This is a very uncommon situation; to be honest it very unlikely that it=
 will
> happen at all.
>
> However if the filesystem has a mixed profiles of DUP and RAID1C3/RAID1C=
4 (of
> the same type of chunk of course, i.e. if you have metadata RAID1C3 and =
data
> DUP there is no problem because the type of chunks are different), the f=
unction
> btrfs_reduce_alloc_profile() returns both the profiles and subsequent ca=
lls
> to alloc_profile_is_valid() return invalid.
>
> The problem is how the function btrfs_reduce_alloc_profile "reduces" the
> profiles.
>
> [...]
> static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64=
 flags)
> [...]
>         allowed &=3D flags;
>
>         if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>                 allowed =3D BTRFS_BLOCK_GROUP_RAID6;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>                 allowed =3D BTRFS_BLOCK_GROUP_RAID5;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>                 allowed =3D BTRFS_BLOCK_GROUP_RAID10;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>                 allowed =3D BTRFS_BLOCK_GROUP_RAID1;
>         else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>                 allowed =3D BTRFS_BLOCK_GROUP_RAID0;
>
> 	flags &=3D ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>
> [...]
>
> "allowed" are all the possibles profiles allowed by the disks.
> "flags" contains the existing profiles.
>
> If "flags" contains both DUP, RAID1C3 no reduction is performed and both
> the profiles are returned.
>
> If full conversion from DUP to RAID1C3 is performed, there is no problem=
.
> But a partial conversion from DUP to RAID1C3 is performed, then there is=
 no
> possibility to allocate a new chunk.
>
> On my tests the filesystem was never corrupted, but only force to RO.
> However I was unable to exit from this state without my patch.

This in facts exposed the long existing bug that btrfs has no on-disk
indicator for the target chunk time, thus we need to be "creative" to
handle chunk profiles.

I'm wondering if we could add new persistent item in chunk tree or super
block to solve the problem.

Any idea on this, David?

Thanks,
Qu

>
> [*] https://lore.kernel.org/linux-btrfs/517dac49-5f57-2754-2134-92d716e5=
0064@alice.it/
>
