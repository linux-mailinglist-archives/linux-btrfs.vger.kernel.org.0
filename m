Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7122735B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 01:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGTX4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jul 2020 19:56:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:42205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgGTX4L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jul 2020 19:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595289369;
        bh=GYLKSCb7m18VeEGy0fkkOgJDiil5jd5JD8iAdxM5/5Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=HJr9VHSK6+ivQg4YsTzXzt4kM6i4HEhOG8M/iIcXRUQyHSoDm4SITiD+ItAfxhWrv
         38griljptgBisdJw9xsBNZ62aGBW/MeK2XuNuOC8TlyydtbAxRibg6xlSCKeeFhMBY
         fyeFhFv9qUlHTGyCuv0J15r/oOC6IoadcGYnQwjc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N33Ib-1kynUY2j5J-013R65; Tue, 21
 Jul 2020 01:51:04 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
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
Message-ID: <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
Date:   Tue, 21 Jul 2020 07:51:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720160945.GH3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D6lnZocBXCSiZrlKtvw59PrMopXFoar8U"
X-Provags-ID: V03:K1:IjaWQZ6/N1rw8CGWiSmqvJ53ggNx4e752zLjlsynOMivc0Gy90z
 llTU7g6c8CTjhpz0dL/8juuIMxvkxjHnGSE80foUjzrnKjICdGn/EaX84zzoJSvTC6Ejxi0
 rAeK2mW/rQeQsk+wAlvAbQDqnOw9YyzzvD4/73NFX9hMvC7SGQK1JiZaqJfACg887FHQINu
 fIm/6mLIi5DN6iouTf98g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KVnB6RGHmBM=:8ZP08MWjjZPBw8gSloNjky
 xWrXGfPb+cldLm3ZMWQtp9iujT4zYvd/GOgmLe0rLGJL5YVIy7MJ0GDh4360P/cPmG5Ht5zpH
 Ddbzcxtz8+qIR5q+TdBqFTCRHEZ3AjuVQsM2gJVb+tXhAadzNZTaG4XCzIT2fxEHrrLb4sduN
 1P+Z8HfjyteA20Jg0/7dLkWhAyUaHDrZQsC03lFc5jCeY2CIRctiX1n11WWAWqjte+ZMWcaa6
 lMjvrW5HBTid+zRLiQdtggtsmjPc/HW+490Ky54/CjwwlD0OWppeBGvomQjVSQOX5xUoH0Zdx
 LSBvSLbPDD7tYnfDlvKNrAP8NCNsTt0Gx7t+BOE0RaTG8f9t0vk7J3H4PnQGqDVhId7d/mTIK
 nGMGVJTK/ny7KmBVW1K5VQzEXGvFMOS1Pi7fLpqQXAm4JlnRzT3L/NV+lwwiF4f1bM0ICQYUq
 Zg76LlGEoO9YnWuLZYZj1iRI7cOdlcXY26xSzmSNiwqnWuvyurxwSODiK5O9mYAhGLvn/im5g
 rbNpcEN/XzgV3JMYfKLysYTeHFhX1WOTzlsWOgX786xoIN56K1evKqmJCvKsYomDJtnmQI/Kr
 HBbiafghGFmTP3TOh65/aZFadAy0mywTNUNqdpp8r2K/1iuwq/bmIOqyOm+aVLDY6ZZWQRkxc
 b4o4hcT8QR76h581oh7MhuEC2hazIThFFN0rRpixccoiZe4BwfPSDKE/j7W2lUgo2wxGcj3Gy
 vRi7L0zMNX5I1w9AeBg/XSAsYw9n8vf2JUAWYTgnd6lADYw9LxWdoFK1PjWY/iEd34WuFOhF9
 NbTVVT5JykDawJiWVjsgaHXxB7efy/KrxdLmjjMsVk+9SsjqLtDCuUKeIQwFGWZ4ZKxIXRE8Z
 kt5OCYrmuhpZw0Fn8SUxGtXGt55Qmi/2VhzuqbDFXT+AvGpU262Hqszn+e4uhTk9pbquoZAQD
 VyIw+hl2ypHokYYBdSRvDegy35K3XI19skoxzG+J+FYWbRsjDPXDSgkizpz6lISA6r/LQ8qfL
 yXIebvUL6D4OrParm50Eh9aC7ofsVIzMbJgRxsoNDYwaD8NWQPHjtimXoIt4AoIAo+6ZAu6ls
 am8Pqd4WMdaaW8xypP4WSvRTniLZ73lV4MXpgEjRosTi55Gxy+wS0ZJDG0aGelq5I9WfYDMu/
 LiOSHvH4M67XAnGOH7lLmZtWb/5mMi4j5wULaWDUEZX3Ig/OGg3Hz2v1Wo8LD24mAy23/hpT4
 4Y13G5Wo03okY3Mzw2gB4rR2RUZ/PRFJmUCdHvg==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D6lnZocBXCSiZrlKtvw59PrMopXFoar8U
Content-Type: multipart/mixed; boundary="gn5tHaFuW09Tm4yRI6LIfr5f55kzh8pGN"

--gn5tHaFuW09Tm4yRI6LIfr5f55kzh8pGN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/21 =E4=B8=8A=E5=8D=8812:09, David Sterba wrote:
> On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
>> --- a/convert/source-ext2.c
>> +++ b/convert/source-ext2.c
>> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context=
 *cctx, const char *name)
>>  	cctx->fs_data =3D ext2_fs;
>>  	cctx->blocksize =3D ext2_fs->blocksize;
>>  	cctx->block_count =3D ext2_fs->super->s_blocks_count;
>> -	cctx->total_bytes =3D ext2_fs->blocksize * ext2_fs->super->s_blocks_=
count;
>> +	cctx->total_bytes =3D (u64)ext2_fs->blocksize *
>> +			    (u64)ext2_fs->super->s_blocks_count;
>=20
> Do you need to cast both? Once one of the types is wide enough for the
> result, there should be no loss.
>=20
I just want to be extra safe.

Feel free to reduce one.

Thanks,
Qu


--gn5tHaFuW09Tm4yRI6LIfr5f55kzh8pGN--

--D6lnZocBXCSiZrlKtvw59PrMopXFoar8U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8WLeQACgkQwj2R86El
/qj4DQgAnBvxH/+qxQYGJvxRBHoEZynf2xW2+ChpLd6c+yoRn12WYMHSGWn6CRwl
0N74+OiLRvM9Y+747UUlIYxozf3dv1kfDPOoE1e13FsZUg97NC04of/6bDKx3mtH
UK5Dc4PYyX2gE0nw6+a6meB6M4+x5r9qFiiCM3W3uhgAAJHS+/IVNQuU+lwfYQBk
wIeldSTY3rodK/ATs1odunUupvd/guMVxoZyv5c41YNJpfp3RfmDR/y0R9qdVZPx
6/vxQHXKDTHhP0kAz1xxL93WXynkrFc9e3sMKxc6Q+gSpeaJHZF458hqZMlG17ZY
/Ew25odbRSUb8xe39ISpLLJJtgMY/A==
=zPYN
-----END PGP SIGNATURE-----

--D6lnZocBXCSiZrlKtvw59PrMopXFoar8U--
