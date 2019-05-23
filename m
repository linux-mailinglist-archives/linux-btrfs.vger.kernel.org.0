Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91E12770C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 09:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfEWHfB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 03:35:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:51471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 03:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558596898;
        bh=LAyuoZNf3AYLlGjJbKwL+sT0IhE5StiLmE4XBpPZtcs=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=kLG86q3uqeOEDvLnHZfWVgBMzad/DuqJjrFxS1i5ick4H0ZjrZpzJdiYwcA1llF+U
         YjzdbreD/K/9grBZ5bl/dIm73EoPoNejSNlH2oIqRby3Wm29kcUOa9sXXy9cD07lwZ
         41B6qt2QkAwLk6IJgVP93L5V30y7q+23ySxW5o88=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MD9NE-1hQS3p0iIm-00GcwP; Thu, 23
 May 2019 09:34:58 +0200
Subject: Re: btrfs-convert with --no-datasum and --no-inline. How can I enable
 those features now?
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Daniel Martinez <danielsmartinez@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
 <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <033c6347-edd9-503f-f0df-5628a83d8a2d@gmx.com>
Date:   Thu, 23 May 2019 15:34:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vjRA0uo9SERxWHNHX5IP30cl0CO7V7PIs"
X-Provags-ID: V03:K1:a7OZA0cYbQk5pHGWwiIN/fHH60Y7cjXgpefT10MLY4IL+mphSdM
 X6z/eqPImsPoVhToNUTw9lCYrNLrIyoIYGuv1G2mIzf4RX2L95yUIoMwEOEfDVjI7voKVCi
 3SSYF4EpPwndcix9Q9ZQPavSRxLxEOPVG9ERYOMW6a5sfW9oyzxfiRM+iMSgpA5OLSzqDad
 mtM7FNoxM+yOd+DhQAZug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DZ6CVgDVkSw=:ntzmKOXLmXPDwqfEuobkSg
 q5fu6tbcCpeP/UDZOa88HKuMiqpiC6phfF0iV4qnFMoMqCCE17WOWcH0QRKhtEFxHnWlBMWYf
 EEN2rNSyvws6FMgDRicjk7ki0G7j9D40A4XwqTo6iiNwW++jCwp0me+ni1Zb4YxehFDkrPVy3
 m6pk0lI5D9z4uMLM4RxHIO2xGpyHw21y8j36EXgfxwVduRCB4rrvjflyKGhqaQI3JSxLyQevw
 zyqxG6A6/z3315GMC1tVpHKtp9AwR3MpavAd50nMf+niPmjQM8/oIlRCvlx8N+WVs3ZssQnkt
 LdVtkGEp2S2N/Ji24sfkZIBg941O3GM5VXXpU8z3p7LCa3/3KyUHA2kwb37Jfg8tp0ytUmxYC
 7ZxPtqzx0Am5oHHePPVxuHrWJFQCyR+Um/RMuRXc68VaAo1DWQPzMdEWu/tHsfP4H2qXpZ2v9
 svDzSOj07X7Z08JtIrUy5Ey3emajqo5J0oTws05BvlpS7vFNizp3k3JhdWGMit/u4b0NVXpUB
 BngnU4VZ9cMRHJCkWugV/mKf9uZl83JpdUq60DHYXYBiR/newTo41bb7PfuPPLJYSB8sR3KBx
 T/kX5B9agb6uomC6SxSMKKGyXwp+WVBi4oLpbxpqqRpThlCYe1A49nyKNSYmxkF2bDlSVjHe/
 y+P29EFxkGpJPKjP+kY3fp5CzCDwgQrSiydcTnyWUtVm8urtjv53AhawKfXLMp+h+4kZDIt5I
 5HlD/5qxchnjJIqHrvXkEgla/3GixBEAlxMF4RV724GVVP6V8wVRIM8bcxVuzTFUDxFmUstqx
 9V9Rt2H0IcyKSl3jKuEnBmVN3nMAyKvoMhcS2W0hoTWS9WV2TmlVeckKPmBBWc5FdBO89gAJS
 /WHRq9bnwhqK2RlRsoF2QIpZ8Czs+i4N8xqyVzbrZH8qdxIhB1C2qH6J1Sbbu7+QrRem0G3JZ
 IQGiBZiKRQmVskjHrNEpMWCKoDvlTmTY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vjRA0uo9SERxWHNHX5IP30cl0CO7V7PIs
Content-Type: multipart/mixed; boundary="JQPnlhLmGEa72xwNmoL3PsVez8kh10r8f";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Daniel Martinez <danielsmartinez@gmail.com>, linux-btrfs@vger.kernel.org
Message-ID: <033c6347-edd9-503f-f0df-5628a83d8a2d@gmx.com>
Subject: Re: btrfs-convert with --no-datasum and --no-inline. How can I enable
 those features now?
References: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
 <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>
In-Reply-To: <7c75acac-428e-40b2-ac0e-7f89d6dcd2e9@gmx.com>

--JQPnlhLmGEa72xwNmoL3PsVez8kh10r8f
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

The problem is caused by the design of btrfs-progs which doesn't have a
reliable way to determine whether we should preallocate extents.

The problem is mostly exposed by recent delayed-ref patches, as tree
blocks are not committed to trees immediately, delaying block group used
space update, and basically screw up chunk preallocator.

-d/-n can not fix the problem, as long as our metadata usage exceed one
block group, we will hit ENOSPC anyway.
This bug should also affect mkfs.btrfs --rootdir.

We can have a workaround to make transaction commit more frequently thus
has a higher chance to make chunk preallocator work, but it's not the
ultimate solution.

I'll keep you updated on this bug.

Thanks,
Qu

On 2019/5/23 =E4=B8=8A=E5=8D=886:44, Qu Wenruo wrote:
>=20
>=20
> On 2019/5/22 =E4=B8=8B=E5=8D=8810:37, Daniel Martinez wrote:
>> Hello,
>>
>> I've converted an ext4 filesystem (after a few attempts, and after
>> rolling back to a system running both the kernel and btrfs-progs 4.12)=

>> to a single disk btrfs filesystem, but to do so I needed to disable
>> data checksums and small file inlining, otherwise I would get ENOSPC.
>=20
> We need extra debugging info and output in btrfs-progs to make it clear=

> what's the root cause of the ENOSPC during convert.
>=20
> If you have a small enough image, would you please upload the image for=

> us to analyse?
>=20
>>
>> Now that I've defragged everything,
>=20
> Defrag in ext4 may not help much for btrfs-convert.
>=20
> The ext4 block group design makes it fragmented in nature, each block
> group will have some space used in its beginning, which fragments the
> usable space of btrfs.
>=20
> IIRC there is a feature for ext4 to make unused block group completely
> blank, not sure what the feature is.
>=20
>> I want to enable those features
>> back for all the existing files (datasums mainly). How can I go about
>> doing that?
>=20
> You can manually remove the NOCOW attr by "chattr -C"
> And then re-write all existing files, you'll get back the csum.
>=20
> For inlined file, as long as you're not using "max_inline=3D0", any new=

> file smaller than 2K should already be inlined.
>=20
>>
>> I assume `--init-csum-tree` would recreate the checksums, but will it
>> also set the appropriate flags so that all new files in all
>> subdirectories have checksums aswell?
>=20
> Don't use that, unless you know what you're doing.
>=20
> It's for heavily corrupted fs to rebuild its csum tree, not for your us=
e
> case.
>=20
> Thanks,
> Qu
>=20
>>
>> When I tried to run it (back on 4.19 kernel and btrfs-progs 4.20), it
>> ran for a few hours and then gave me this error:
>>
>> Creating a new CRC tree
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdb2
>> UUID: eb930a78-f6f7-4552-8200-6ebdd6c56b93
>> Reinitialize checksum tree
>> Unable to find block group for 0
>> Unable to find block group for 0
>> Unable to find block group for 0
>> ctree.c:2245: split_leaf: BUG_ON `1` triggered, value 1
>> btrfs(+0x141e9)[0x55d3c529d1e9]
>> btrfs(+0x14284)[0x55d3c529d284]
>> btrfs(+0x169ad)[0x55d3c529f9ad]
>> btrfs(btrfs_search_slot+0xf24)[0x55d3c52a0f9f]
>> btrfs(btrfs_csum_file_block+0x25f)[0x55d3c52ae888]
>> btrfs(+0x4aa30)[0x55d3c52d3a30]
>> btrfs(cmd_check+0x10b1)[0x55d3c52dfc9e]
>> btrfs(main+0x1f3)[0x55d3c529ce63]
>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xeb)[0x7f2eb872309b=
]
>> btrfs(_start+0x2a)[0x55d3c529ceaa]
>> Aborted
>>
>> Did this actually generate checksums for some files and then stop, or
>> was nothing written at all? How can I verify checksums are calculated
>> and enabled, or otherwise make sure its working as intended?
>>
>=20


--JQPnlhLmGEa72xwNmoL3PsVez8kh10r8f--

--vjRA0uo9SERxWHNHX5IP30cl0CO7V7PIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzmTR0ACgkQwj2R86El
/qgqAgf/Wro7aaKU/UVuZ/E6i2Le+80Py/O6HoJcn33TwWumK+RalCAYEjVxNOEp
CyaxyLVNCY3vVFWrCZtFLnxIORWif4AY0h0QYI/RNyfOOMlPH1y5E7Ab2uu/arOe
PMC8veKJqtrGQuaU7R4G6pKex7R8/wHZ9Mv5uXfb+M3Go8ondSvkDBq/ESGxeYpo
dGZ0QQdS6uQqZ2JKASqgLhjgGFiXax3o1ZBO6lU0APy7M+rg7csEF9+N8dgKaPtb
3FbKsUAwBh/OmvEZX8Wnw0pDnOlYCkqGaaVgnSgah+Ei631nlHjyCPUVEWJnU2ys
pDqd/mNwxDmPq0Y04kRQhG2H3QyuXA==
=EvtI
-----END PGP SIGNATURE-----

--vjRA0uo9SERxWHNHX5IP30cl0CO7V7PIs--
