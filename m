Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74C12F83A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 13:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgACMcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 07:32:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:52281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgACMcs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 07:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578054753;
        bh=EbpKKjXwvOw8D8sYxqzNPcYoizzbUM9CzYoyI9WFMx8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z8/nbaZF74S9eySU11L7TAVHBUbXnk3GznQ2i/1wHpWungPs6xdUVIVuNldz6gIJq
         rl72IjSj9c+vvQUW08wcRydgNB5suiAbD6efTkV1LOlw0tv0RryNLstlYHLVKBc9NS
         /p78BodLh7/jD49mv1foIbrGQTl9KNDIxVnDyINg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M6Db0-1ipXyp2Iae-006j2s; Fri, 03
 Jan 2020 13:32:33 +0100
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
 <ff4f41f1-b0f0-a787-a9c4-73fbb5893fa4@gmx.com>
 <af1fafa0b9e6617ab3bccbdfe908956d@synology.com>
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
Message-ID: <f9807a7e-ffbc-7f81-47a5-861cfef3a008@gmx.com>
Date:   Fri, 3 Jan 2020 20:32:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <af1fafa0b9e6617ab3bccbdfe908956d@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QqQR84Bwk9h2CLba6RKgoTqj400PPjG0B"
X-Provags-ID: V03:K1:cM+9vk+h97TCM03jAg2xsY2C0qEK6TzegoJG8TGk8zZhDCCc4n6
 UFjuDkW5O3Xr+dqx11vG6iEOHDaLyVTVWP1Gbawnkn1xET4plyA/itbcsL3TadvmA2RkB5z
 RX0qRvkmnQPrJFSvAtFSbqWdx/binjD8g0jBnMHfCyT8MynXiBo9b/y5V8ZAJBnjpgArSU4
 jIoaFX+qpIrSGZGdwkbTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Szar7N9OfbA=:Z1m0eLJclJtm8tP4e9q9i7
 hqY47sDyv0DecDPpjnn/n62MP8jgfLLc6j7CKeSU+PfJ0AXou5qWl0nzFrrJCJAxc2a2pJTN3
 0tVEApV8iUbWWpRbp+nqoFstAj0LilK5IUuBc/bGstSfINQadpWmZ92OAiGI3V70mlScJ45F/
 B9E5DyJcFgwMSVYTzsduw+EqXSLGwmkqVs20eQduybwmD4+cdwI9/cbb1wV1Dxtsc98ewHfFZ
 nOl7aXO1s/hToL6Ah8L7hgpjnECipac0Nu6N22+0+RxE6L4vQFrpPEL3uSLbqz5EKGHz3Rw09
 OpLciu67dMcmT2h+QjSA4TOOI6IfNQtXGxZrJZLLNKnbTeDezKxlqeHs2C6pTSh+Z4/cxO1GA
 rgvPm2DoxmArUfUIS2rLRWZQnQDvaZy4Ke6Og+JDxWARvmGx4L17lzaZgN8efA4arFRanDXBM
 dhpSIwkYkqEQeFrV6u1zUDHwgwUp5Hv5vI8990UCF/ECsG+YZkGBvvAeSK/5WztPqIbVHV12l
 Oq58lxnEgqeXx1k0238mTH0D9E4fmLRAi2kwC29FXPyXuxSDvCn+Wnh7286IWAXiSLGOa7gV9
 NWkJ3Vnza6qybDL+0inTtkBLS2zfjutgpNiT5HToPyajuJMWR+byQpSsx567mG1xtLImhl7xe
 yFl91ljnSnzoFm3bMzdHaQN7y+f5Xw9QB7JrA2sh9gJCuA+8idt1dtKm3NVX4JJJP+i7f9JB0
 DYgap1iYYEDSRd3+mgIicpbEuGjq2sLNDL5EjLEEqEx+OE/04P2Mu2gqwNiPPZAtwGrdau6t7
 eHhHj+dBdEhsTiqQwYBlOf+NsULJ8AvVcy1GL4mSs78LV3AsGybc8pjuOrggjn+sCm2NvRq1a
 emiihQkTlKo8qIJeg2yXOLdbiriapVBfNrSsRHPLbPGYFFGLN6pggHDgYk72tCB8YRl/nI0d5
 /zxQYZIxXYRS0IXhtaOMpOPKFHZLbHA/vdpTFUpuUHYxx+8Wbyeo8Ayj5fGofgHCfTo3IXTbj
 4RkVA1yZNMN96KNGXcHEjXDJZPkFKesaI1SyresE2PxPOaEy9w7UUyi9msx9Wv23mV8z5X3VR
 AEJOvz3sQHCVegWKkeFgrKycxYllnvT2M9pQYY8yDGeDlb4Gs/jwNdAd4kV1+nXRZ/YYFvdJJ
 i2+AMT8TqYOoD9MsaS4lwvfdqEKPTQmkhlO/1d0RicNZ1hh1u8vmXfUD4hOSnVfHM6K+YDsgG
 Nhh1m57EiXttnsoiEDoPg8tbrvyqAxWp1/ogGKxJ5T0qwD4wiV/NPCEWV+/0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QqQR84Bwk9h2CLba6RKgoTqj400PPjG0B
Content-Type: multipart/mixed; boundary="9jC1te6FH9v25VAFf8gmF5btuUuoTxiTt"

--9jC1te6FH9v25VAFf8gmF5btuUuoTxiTt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8B=E5=8D=887:37, ethanwu wrote:
> Qu Wenruo =E6=96=BC 2020-01-03 18:15 =E5=AF=AB=E5=88=B0:
>> On 2020/1/3 =E4=B8=8B=E5=8D=885:44, ethanwu wrote:
[snip]
>> What if the backref offset already underflows?
>> Like this:
>> =C2=A0 item 10 key (13631488 EXTENT_ITEM 1048576) itemoff 15860 itemsi=
ze 111
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refs 3 gen 6 flags DATA
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE =
objectid 259 offset
>> 18446744073709547520 count 1 <<<
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE =
objectid 257 offset 0 count 1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extent data backref root FS_TREE =
objectid 258 offset 4096 count 1
>>
>>
>> Since backref offset is not file offset, but file_extent_item::offset =
-
>> file_offset, it can be a super large number for reflinked extents.
>>
>>
>> Current kernel handles this by a very ugly but working hack: resetting=

>> key_for_search.offset to 0 in add_prelim_ref() if it detects such case=
=2E
>>
>> Then this would screw up your check, causing unexpected early exit.
>=20
> Thanks for the reminder.
> I think in this case the check won't fail. Even when we revert the
> working hack
> in the future, it still works unless we use u64 to do the calculation.
>=20
> (u64) 18446744073709547520 =3D (s64) -4096
>=20
> Suppose this very large offset is equal to X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The next l=
ine is the original file view.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0 ......=C2=A0=C2=A0=C2=A0=
 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (u64)X + num_bytes=C2=
=A0=C2=A0=C2=A0 EOF=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 X
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [----oooooooooooo]=C2=A0 Original range =
to check. - part is
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the=
 very large offset where no file extents
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 X in terms of s64=C2=A0=C2=A0 exist, so =
actually the range [0,X+num_bytes)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ooooooooo=
ooooooo]=C2=A0 range to check after hack X=3D>0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0 + num_bytes
>=20
> With my patch, applying this hack will only make my check condition loo=
ser.
> Causing more range to be checked (represented by o) compared to no hack=
=2E

Ah, you're right.

Since file_extent_item::offset can never be larger than extent size, so
we backref offset can only be in the range of [file_pos - 0, file_pos -
extent_size).

If we got a minus backref offset, it means file_pos -
file_extent_item::offset < 0, which means file_pos <
file_extent_item::offset.
And since file_extent_item::offset < extent_size, file_pos < extent_isze.=


Thus even with current hack, the check still works, as we search from
file_pos 0, ends at file_pos extent size, which covers the file_extent_it=
em.

Great explanation and patch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> The only way I think this check would fail would be:
> File at offset 2^64 - 4096 uses offset 0 of a 1MB data extent,
> key_for_search->offset + num_bytes =3D 2^64 - 4096 + 1048576 =3D 104448=
0
> Therefore, when iterating through the leafs, we'll break early at
> offset 1044480, leave the EXTENT_DATA key @2^64 - 4096 behind.
> But AFAIK, file of that size is not allowed in btrfs.
>=20
> Thanks,
> ethanwu
>>
>> I guess we have to find a new method to solve the problem then.
>>
>> Thanks,
>> Qu
>>
[...]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key_for_search->type =
=3D=3D BTRFS_EXTENT_DATA_KEY &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
ey.offset >=3D key_for_search->offset + num_bytes)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (disk_byte =3D=3D=
 wanted_disk_byte) {


--9jC1te6FH9v25VAFf8gmF5btuUuoTxiTt--

--QqQR84Bwk9h2CLba6RKgoTqj400PPjG0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4PNFkACgkQwj2R86El
/qgT5Qf/Ug6NuzLGH1VbEYtE24cKS7j7JxXs7jS35t57lvImzVdDNFFx6fpJsUul
W/kayj6g45EbRNoVTQRNzUyDVf/4nfDdueMyvcJPNNgUj5hItr5ZNdyAUNiLb7yU
W0/s+p/NSdyeajSJhFUU2/83R8wPNkW8DugVsLou0Lvf0ivihZww4uQBecVEcH2n
G7K5UMKWaRcdwEUH9udw6dBrZtPkzm1Gfp43q2CxOidMsXA598OPQlY+4kkEEtDm
qR3Efrv/gpth8jV9mIe73Pz2uCzHWzPLvLKXcvqDgT/hyBfS0OMfgtyOBPQtu2sT
IPTv+VrQUcYwz4Lp8PCaDvrIehPW0g==
=Vj1m
-----END PGP SIGNATURE-----

--QqQR84Bwk9h2CLba6RKgoTqj400PPjG0B--
