Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC35414EC21
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgAaL6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 06:58:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:41381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgAaL6U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 06:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580471894;
        bh=5MiRT/lbUVH9nh55zAYlZ9ou7EmduOKHtc4uCwckWoU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IUkuKksemcdpRpDZR36PHgHtwtkyJTqOLtWN/GiJ63SBY6KfV3UUORsRyNZcJYJkh
         YkyA+tT5ByuGV0xvzg7lqFylPlnzShm8svwo/IjDAyniXKAPvAnFDFMF/zMOOHLuZ2
         g3yPJq1RMaA8itjJSFvvQll0nrogUmRbhRXOgKqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp9i-1j35Uu3eKS-00YCB2; Fri, 31
 Jan 2020 12:58:14 +0100
Subject: Re: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over
 committing metadata space
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200115034128.32889-1-wqu@suse.com>
 <38a5dc98-7233-0252-4ba3-76c59d7b21e7@toxicpanda.com>
 <5fe1d568-9c6b-7fcd-5d82-04738dc64b4c@gmx.com>
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
Message-ID: <f977eec9-afec-9270-c6bc-b19730cfccf9@gmx.com>
Date:   Fri, 31 Jan 2020 19:58:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5fe1d568-9c6b-7fcd-5d82-04738dc64b4c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SDRYK41jfNTIlfOmS5VsK0d0YLhxb0ng9"
X-Provags-ID: V03:K1:tcH4VOBTDy6h0u5y+6FcCDV6BxU2xyBKrKWg1cIe3eF16eRH49H
 qlUX4rJetJXbvIgEqLChDkszTiDDnjbIzFXX5o1Nq/ajqjn32M+y3vJRKcG6Sumn4ea5qV1
 SOIh5RYDTegR7XFOB9DZ1aw3OV/2FUJ12QZGDjt1k06mUG9ko+svMYPW4fmN04ihcn1wye9
 e8C6/g8UrejkDhIloyaRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:93HKL9Kxtn0=:+dmFPgdKDJbzFISC1Hw3T3
 Ims4YKZxJ9CSrGBijUqPwFYwIbXDFo5BMgxUIPmwJhxkwBUI6nhcDY4GNjfPs+W2z6fnqZck8
 4/XGJTQK07znotL85TbA16TP5fIBxkKUwY3rBcllTVD3RYxQCtC22+I6xkpfpDEScS1Yn8qFb
 YYjyRztRdAd8yyjRIKb+wSRyYfLj2Hdj13LP56Eda7iqpUUnonvBOgrBeAhBz2V1z+XBG4pZb
 8fjDQQZci3qO38mfl/OgJDNoRtJ1C/Iv9Wm1+EktjbXHv58cHztGL6iQZMulMhMpczhex2sWi
 fl0muZRHHcWQ64ggNeiEndoW+Ebs+MfhG+oNUUcNQwmYtpNaLrIrCH7Zp2dB/q51GiZFdnOph
 q6TuTahGOV8Fot8Llmr0AO6SmV65jrrSrAqqyYyX13QIHyiuGrT5vvgh1DCBgKloxwcDh14E9
 M+FjxtIqivfDjdRw93b4jf/QO1xo4NFcBOI/QGjqEurGYvmlmH9w9Is82bLDElBtFZageNfGc
 KcGzPjWzdaE1g0TV94CoyOVNwyMZuOrghXC4EjZJvV9fL189RhPjLXpevNPdsoafAHn/hXASW
 eLRt/fOJChFAi1WGhyi2ljPYxx0XOW1U/pzEObB5FKTkOI2Nv3AwGQE+Vf+2GOAN6VsH0cCdl
 56pZMyB+ybWUdCdh1VGgnI8/eTte227dpmEzNA8X/0OnN6Gy7g74RKuMk1y3reOvcVfkynGEk
 2M+1HlMCXQ2Qw6pB1aqrbOnobYOOj7aXk5JNdxMD7278YcXYltF2ZYItVOYTt4XYad4xLjltd
 fwvPJ1ymocxGnbiHEsG5OyN6XTwYF9oiTQ/7P63TE6hVoJeuOHr9LrsgCGPvMkwTgrPZxtSzp
 kXR6cd2kpXyRzJLB8houLbYy9f7u9NqTz/EhNSFD10ruUdrN5jtWKM7okMYpNq4YsIf69pCk9
 sxNNbjVDgkumrKTaQotf98HcxfVgAVs1xBHicovJl9DZmjqY9kyIIqBOTCRosYzES3BARUwWl
 obNY7WYh8eei3gNEw8lo6nFYkRBDsdUUM0nH7ZDa2yHclkWld2GxNaUUGCKW2PFSRp+dIGpSq
 FbJI/BLouEeAXRkpsHlTIh2pSfGDHqPMjmkJPGXq4lCreRZQqvlRS5GFU8iTpqffTbLzl5VqM
 q6vCHy9OQArhKDex5hyOuU74/ZHG6Ll+JGxWaD87aKAaLup6fgrE/JRsUFJBh1trdRvaVhrr4
 XQTPpYyjbYtwfEcEj
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SDRYK41jfNTIlfOmS5VsK0d0YLhxb0ng9
Content-Type: multipart/mixed; boundary="YW8pXCforZ8WlSWTyOwpTRdvoYuBZd1EF"

--YW8pXCforZ8WlSWTyOwpTRdvoYuBZd1EF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/31 =E4=B8=8A=E5=8D=888:35, Qu Wenruo wrote:
>=20
>=20
> On 2020/1/31 =E4=B8=8A=E5=8D=885:05, Josef Bacik wrote:
>> On 1/14/20 10:41 PM, Qu Wenruo wrote:
>>> [BUG]
>>> When there are a lot of metadata space reserved, e.g. after balancing=
 a
>>> data block with many extents, vanilla df would report 0 available spa=
ce.
>>>
>>> [CAUSE]
>>> btrfs_statfs() would report 0 available space if its metadata space i=
s
>>> exhausted.
>>> And the calculation is based on currently reserved space vs on-disk
>>> available space, with a small headroom as buffer.
>>> When there is not enough headroom, btrfs_statfs() will report 0
>>> available space.
>>>
>>> The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
>>> reservations if we have pending tickets"), we allow btrfs to over com=
mit
>>> metadata space, as long as we have enough space to allocate new metad=
ata
>>> chunks.
>>>
>>> This makes old calculation unreliable and report false 0 available sp=
ace.
>>>
>>> [FIX]
>>> Don't do such naive check anymore for btrfs_statfs().
>>> Also remove the comment about "0 available space when metadata is
>>> exhausted".
>>>
>>> Please note that, this is a just a quick fix. There are still a lot o=
f
>>> things to be improved.
>>>
>>> Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have
>>> pending tickets")
>>
>> This isn't the patch that broke it.=C2=A0 The patch that broke it is t=
he
>> patch that introduced this code in the first place.
>>
>> And this isn't the proper fix either, because technically we have 0
>> available if we don't have enough space for our global reserve _and_ w=
e
>> don't have any unallocated space.=C2=A0 So for now the best "quick" fi=
x would
>> be to make the condition something like
>>
>> if (!mixed && block-rsv->space_info->full &&
>> =C2=A0=C2=A0=C2=A0 total_free_meta - thresh < block_rsv->size)
>=20
> block-rsv->space_info->full is not reliable afaik.

My bad, I should double check the code before writing bullsh**.

That full is set as long as we can't allocate a new chunk for that profil=
e.

So that fix is pretty good.

I'll update the patch to use Josef's credit.

Thanks,
Qu

>=20
> For metadata we will never really reach full space info.
>=20
> Anyway, the patch is already discarded since it doesn't make sense if
> the patch can't reach v5.5.
>=20
> The proper fix in the per-profile will be the fix.
>=20
> Thanks,
> Qu
>=20
>>
>> Thanks,
>>
>> Josef
>=20


--YW8pXCforZ8WlSWTyOwpTRdvoYuBZd1EF--

--SDRYK41jfNTIlfOmS5VsK0d0YLhxb0ng9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl40Fk4ACgkQwj2R86El
/qjGiwgArPPsLRXhouiQJJKNn8RHvdFu7DQPy7iAVaEM+QB3o5jq/aS9/+KBdU6u
ySoqEKaoZGEMTBDKXKcmOUHCTceycmH0yOoZ89iN0tvWmi/YuqhFUrCI9lQEGcXJ
agFNEbKdGAM/6+uzslT/vk1G3O7cZcFuN6kRhalFFsy6nM+A48XEQE6JbAFa56Gf
GKPYuJw5ssdsO1TCFGkprGdzSB8gZoqbQpBUXEb57QM3M167OMaU9MotlWLfgan3
xWA3NnR3fRKq1Im5s2vKdS9KhQSKC9wrpOcx5KCgEFq6TUUP+dQZtVmy1XD1cO2v
MPEpyWnXpWpIfo16IXFwTICzDp12Mg==
=MGqJ
-----END PGP SIGNATURE-----

--SDRYK41jfNTIlfOmS5VsK0d0YLhxb0ng9--
