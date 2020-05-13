Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED61D1262
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgEMMLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:11:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:35945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbgEMMLg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589371887;
        bh=9dntaNbHhyWzaRxCYzt57WEoG8NhG1PDbvULCQjzvps=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IluWe2GiHNFurigWe0JJ8H3KnJSblM4t5SZ1NBfUGMhZOnIxgp8BOwatoaS/GBlKS
         35LqDN7m/dCH2DeKv2v2UNW0Ylw546ww8VG0xys7VOpv9XXq0qL3MG74LMQJMnWzy7
         k6EHkb5eca0EbnGeGumgypRVEnSgzpjptPLXPCi4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSKyI-1jfLWA1MTI-00SiEA; Wed, 13
 May 2020 14:11:27 +0200
Subject: Re: Bug 5.7-rc: root leak, eb leak
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
 <20200512230333.GH18421@twin.jikos.cz>
 <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <fa11e7ec-d785-455e-02f9-c45d607c0b52@gmx.com>
 <SN4PR0401MB3598875C33493DDC0D8BA60D9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
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
Message-ID: <2dd7f27b-e505-aee5-2ffa-7e72f4623479@gmx.com>
Date:   Wed, 13 May 2020 20:11:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598875C33493DDC0D8BA60D9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DNfzaektbLxvkisr0oBjMd09Ji2WbBeSW"
X-Provags-ID: V03:K1:skUkcT/P+Xr4aPOn1qgqIxl8aP8oa98x48sOaPnMM7ifd6PD6J0
 31B5fIC4IIuftN6mj2ZMno0yQPECLND6SOux6Z1L0OBqIK3XBSHyzp835NlKX7/d3uox/w2
 /g33WPE0/fv35dXNne/JDdebv80y/hqZcj03C4SWm9il/stNbhaM6OaT6Ln2v80CLR4at0g
 Nkxhkh4MgSvq2HkvbkJ3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxP5c2/aFl8=:oQZVWufVrnUdj6A5jxIexo
 9E9hUVSFSJVgqq3GYXHTHf2fEBHp0Jdtp4keXl+56+1JyoybspvrllxvORSDaXMANpRFPCOwJ
 JA4eqd8wz6EHKX3eO4V27PJtuYpj9t/uEuibn/E3TzYOStviHrsHW7/iEwdxOkGJAid56FWkT
 O4vzLtUts0RZ0hpeZOzDXONWwFpo6SXIAgTPjz9/RgKsA59+vuqZ5gNdF5Pfy/AjXzo8kj13M
 swSTfc/Jbrpp9bIDIdDGuthrUi2e4OhOZBPkRhcP5N0pIRt7CglaDRMRLYe2nuI8jTDpA1fWu
 pvvEMIHkzBGbe7nUQ7FAT6A08sBnImySw++fTiz3xQeMTKCIRAjpCeMKftvyIetYdTmE4lDyb
 cos7D/LLPLRYHD3lm3T29Xw8fw4gyI+wC2/VrpE+gAYO/mGk3zLbB3Il104s/xZevAH0Gsn75
 IPRrtyCNxejuSYkvhFXLhxgvxkPWG8b1/oDUnw8ewPuPipaD79mVg/m95G7cVVxKpv1pdEiqX
 6scucsV/xcVdvxAnnd6oF0WJ3weYsT25N1g2UXTdvr3gwWFVdNAAYQAUTDWrGHu4g562eoE0k
 5UW9WR7rXHjcooiYEMWcs+k3jBv1dirMUPTvCjnqv/nbQrz39dD77qSAxBR/AUJ9vhfteKa5z
 OK7i4Y+KK4Y1lTY5/suSfFMxatUzCvzNN/CXZeiXaEqWdgUPEtHdPihmn3DhWNQVH0eb5qpo7
 DoEcA5NdE4RL/nBQwyqrfY2YSUOD5tLt+/UuV9auaqhPVzfPrfJM1gvjshu9TjSX7neBSL22R
 AExn45tylPIhmHy/6Ue7MsyXkT/V1Cm1zpShmzoqgvFFmnVyU2xc9SPrmm7ZukVBPjuZHA7eR
 od0vKSr8bWKMkJTES1LtFn03YcD0X5rlsCgKa/ZqZNytteQe79GTj0juV17ZCCpiQ2I/zsfxC
 fmhVpJ+TRJ/pJ6VSOrd/Hqsxv0mojC9RIhRYnrwQUeS2DcBZ57OrgmuqFsHv0aZWVp++IC7S/
 pO1C9LSHJZzaj1asmJW9q9wbmW97FkmHRmiKwZKfrD6OfNpXiIzvV4UZZbfCiJxvBz9681fW7
 4/8cj/RP3SxkKX+C9DcGT1Xa4WDqFwbHXsw0wD4tZ411Xz5pp5RXk6Hrbq1OBku8TG3XNkFFr
 2SDkt0R4Syip9sxvgSkbzo7quV2De31sOyucrbFeFiriXMAIl8crfxWBOf4S77zvS9F/d6s8l
 qPMceGpJwbJddi0s7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DNfzaektbLxvkisr0oBjMd09Ji2WbBeSW
Content-Type: multipart/mixed; boundary="dicDz93W2OfluVoDqQRvw2NmwAKkJUgHy"

--dicDz93W2OfluVoDqQRvw2NmwAKkJUgHy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/13 =E4=B8=8B=E5=8D=888:06, Johannes Thumshirn wrote:
> On 13/05/2020 13:57, Qu Wenruo wrote:
>>
>>
>> On 2020/5/13 =E4=B8=8B=E5=8D=887:54, Johannes Thumshirn wrote:
>>> On 13/05/2020 01:04, David Sterba wrote:
>>> [...]
>>>>
>>>> Johannes, do you have logs from the test?
>>>
>>>
>>>
>>> I recreated the logs for btrfs/028 (dmesg, kmemleak and fstests log).=
 Please find them attached.
>>>
>>
>> BTW, what's the line of open_ctree+0x137c/0x277a?
>=20
>=20
> Here we go:
> (gdb) l *(open_ctree+0x137c/0x277a)
> 0x122acd is in open_ctree (fs/btrfs/disk-io.c:2826).
> 2821            u64 generation;
> 2822            u64 features;
> 2823            u16 csum_type;
> 2824            struct btrfs_key location;
> 2825            struct btrfs_super_block *disk_super;
> 2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> 2827            struct btrfs_root *tree_root;
> 2828            struct btrfs_root *chunk_root;
> 2829            int ret;
> 2830            int err =3D -EINVAL;
>=20
> So its:
> 2826            struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>=20
This doesn't make sense.

That line doesn't even call read_tree_block() nor even any function call.=


This looks really strange.

Thanks,
Qu


--dicDz93W2OfluVoDqQRvw2NmwAKkJUgHy--

--DNfzaektbLxvkisr0oBjMd09Ji2WbBeSW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl674+kACgkQwj2R86El
/qjWtwf/cPTbqatfgzeu8uhP9ikCCNPnSe6Hgp95jmuevqnbApoChPDDWdMxTdZ4
RkU8VjAlGcjio1K134oV6w5tulqNK7St3W99En6ZAyh4aL9zSrX+lzfY6S5roXfr
7T306PMyAKrPXVOTWY6qxePol+vvO/5g0la/3pLFwr7WvnToypDe2VctsL9UFMQI
0kbSmTIIrlc3ZSRnE9jjytl8Av2Ou+cL3IpaLilw3/DElJK6EnZfYYbLfLUB8hIh
q2UIgIV3SxAsEhCXniV8PlEtWRvIebZHTQu9uvINGJ9eNPMV+F8GKn/hvGminRzI
2ceyr1ZjdeONvcU6WGrG+pfMb2bgnA==
=/zjb
-----END PGP SIGNATURE-----

--DNfzaektbLxvkisr0oBjMd09Ji2WbBeSW--
