Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858EAE16A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390321AbfJWJv5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:51:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:47291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732648AbfJWJv5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571824310;
        bh=S0wC3PxvVqYRHzdjPDZ2LdQEP2iazFcHr9fuXuPJg3E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MZIWiXf+Sn2zRFZ/2iPDaF+GImSP6vvPPKKJrhMfUkhM1kdE1GsP91wguwTpb0j/N
         F3dEL2BUQLNO9KMod0Uubf3oTX7E/2mui2UPBP5XrMSMD5fiGZFWjSfg4GRNbeRfAa
         qikgJcXJKQDldwr2nbM457Whbp09sz7gT6d5d4KU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1i2GIw2p4V-00wCWB; Wed, 23
 Oct 2019 11:51:50 +0200
Subject: Re: [PATCH 1/2] btrfs: volumes: Return the mapped length for discard
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191023085037.14838-1-wqu@suse.com>
 <20191023085037.14838-2-wqu@suse.com>
 <CAL3q7H5V0fapMLnznQhHuG8f1myhAdiy42WsUFr-6ryjV7orEQ@mail.gmail.com>
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
Message-ID: <f1c6306c-fc02-1713-589a-bba9a63c25d8@gmx.com>
Date:   Wed, 23 Oct 2019 17:51:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5V0fapMLnznQhHuG8f1myhAdiy42WsUFr-6ryjV7orEQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m5jOsxp0XIVjHyEr3vi4US2Demf3lKneD"
X-Provags-ID: V03:K1:gB9etTmR5Fbm4OrQZte0uqUwZFNhDUAgvRNUi7LeRbdoKqcu/X0
 PXyNSCfNkECeSmPbTRHOaFMgeIinuf8NUqCymd1iwAJBQdEl64xN4RGmcagRAf+MeOUJkdX
 DNe25idDwyvtjt4LIaiAa7UBV06ELp4yi1AmFodVB+JDc7AoMGwigryr8zdbEabGtgjzfPk
 QCUPFYAgzFFFAtwMnhFGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RvL1e2EWGU=:lvJwK/1OR2rMfuycAbRzx+
 Jf4tNquBQGTNGaVDW61iZbAp1j4JPszkj4GYJLvseIhsrA+1g/lFY8jrx72mcPb/eGzuCiqa/
 hsxFWtbYQ6sL7oV1LgNgvE3gP5GYRWV4Ct+qBYJEoyWKGmba7VocY5za3bkErUM1SXW8l2yqF
 DaSwWKhQFrfndk9r51MmkhxHbBQ75IXDGZdv27zRjuDqfCHgcWLbZXImgzUHmvSH0bZPcFKcm
 LKp0KD6ygvZS2geKfaYEAyLECt7H51l+RlPp+qPHrW4cTRnSvIOyo6LzYPCiJQoEs0DLS4cZR
 Z174TJVY7cS3xu7qjCdSReVT5M4dcW1n/O502zLPP1kzUXqdJ+9Tzxvr7Vi4Oihfmy4yBPq/4
 B1uPGg3hUZ3EVLNiP28b1aXgbHmPYFpa1tC6JXn36QwJTQP0kREaBLs3yWyBXdcUiw9omG2ks
 U9M7gWjuuYAAiKGPx9WQsBEQxt6qoHTrT0fUbjyKDay3bBu4nxDRz3lsOsv7GTrLi0wlYdGLn
 NcpnNpKoYtT+7p6eSr5u35oyxyvumaIy5myG73tynA03l97FULbowZJDgchsP5Ia96jkgCP1s
 mFZDvHyqYW6KUyTnGiZhzNpOXYFl1GqxEC/BtqkMIv/g9SCOpQb0iUrKcmpo5pBNlzwOSh+fD
 +CzfgHkvDvc047oElIGNqgLjQNXNN9UfRukPwxyPs0tO/SZZ/CX9Pr1udodUITSVqAvEfih/V
 S+sE8zxc15It/GFp9iXNGI33bcDgl1q6PqNj77nE4ZZJfAhHvMQ178YCVz22XLSdwCEdgpkT/
 8SdPi9gLT1ySK6RiWZCBQzHCQwFZgyBBkLaCcLNViAm+cqaltSk3xGhSdBS83fUkCrEY6GUhS
 7FROsyP+DxSmqn3UsN4foi2e8DpH+hVdvlu439OCUXrr+MmcP6vy8epl7hOgRzqTIGRyJXKgU
 R3zwYlLaTOI8fiaUZwXirkTmkg9+nb7uxtYGSpsT+JR+Q5mko3PkxhyHAjvvqPwwO680U99z4
 AzNyoBu+0gHv6c0FaHHH7GJ6ADytoF+tEEEld9n8iBzwQfTd67hzKTxXgrH+cb+8wPSNeCiWv
 nA3g9TnKz4X0+ED/J+qshErcd85FecokLxjKhVftREKd6WCusKOPYgkxPrpRuTyP27LLASLpk
 tg0c9fXTWuwjQPKeFvtgRCWtptjI9h/15FZdz4WevUXKcdgwLFA9kr3/ylyD1nu2ImbZzXNpQ
 4RfHCXVD2OubDfKNNKEWwHjjIP+WHXukF9w8BMCwtVsPI63pQIY//EENnJEc=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m5jOsxp0XIVjHyEr3vi4US2Demf3lKneD
Content-Type: multipart/mixed; boundary="LbvcHki49bDfjLB4qU8GuDhcvU9kZyubO"

--LbvcHki49bDfjLB4qU8GuDhcvU9kZyubO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/23 =E4=B8=8B=E5=8D=885:47, Filipe Manana wrote:
> On Wed, Oct 23, 2019 at 9:53 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>=20
> Hi Qu,
>=20
>> For btrfs_map_block(), if we pass @op =3D=3D BTRFS_MAP_DISCARD, the @l=
ength
>> parameter will not be updated to reflect the real mapped length.
>>
>> This means for discard operation, we won't know how many bytes are
>> really mapped.
>=20
> Ok, and what's the consequence? The changelog should really say what
> is the problem, what the bug is.
> The cover letter and the second patch explain what problems are being
> solved, but not this change.

The problem is, no consequence at all, until the 2nd patch is taken in
to consideration.

This patch itself doesn't make any sense, just a plain dependency for
the 2nd patch.

I guess it's better to fold these two patches into one patch?

>=20
>>
>> Fix this by changing assigning the mapped range length to @length
>> pointer, so btrfs_map_block() for BTRFS_MAP_DISCARD also return mapped=

>> length.
>>
>> During the change, also do a minor modification to make the length
>> calculation a little more straightforward.
>> Instead of previously calculated @offset, use "em->end - bytenr" to
>> calculate the actually mapped length.
>=20
> I really don't like much mixing a cleanup with a fix. I would prefer
> two separate patches, no matter how small or trivial it is.

Sure.

Thanks,
Qu

>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Other than that, it looks good to me.
> Thanks.
>=20
>> ---
>>  fs/btrfs/volumes.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index cdd7af424033..f66bd0d03f44 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
>>   * replace.
>>   */
>>  static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_inf=
o,
>> -                                        u64 logical, u64 length,
>> +                                        u64 logical, u64 *length_ret,=

>>                                          struct btrfs_bio **bbio_ret)
>>  {
>>         struct extent_map *em;
>>         struct map_lookup *map;
>>         struct btrfs_bio *bbio;
>> +       u64 length =3D *length_ret;
>>         u64 offset;
>>         u64 stripe_nr;
>>         u64 stripe_nr_end;
>> @@ -5616,7 +5617,8 @@ static int __btrfs_map_block_for_discard(struct =
btrfs_fs_info *fs_info,
>>         }
>>
>>         offset =3D logical - em->start;
>> -       length =3D min_t(u64, em->len - offset, length);
>> +       length =3D min_t(u64, em->start + em->len - logical, length);
>> +       *length_ret =3D length;
>>
>>         stripe_len =3D map->stripe_len;
>>         /*
>> @@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_inf=
o *fs_info,
>>
>>         if (op =3D=3D BTRFS_MAP_DISCARD)
>>                 return __btrfs_map_block_for_discard(fs_info, logical,=

>> -                                                    *length, bbio_ret=
);
>> +                                                    length, bbio_ret)=
;
>>
>>         ret =3D btrfs_get_io_geometry(fs_info, op, logical, *length, &=
geom);
>>         if (ret < 0)
>> --
>> 2.23.0
>>
>=20
>=20


--LbvcHki49bDfjLB4qU8GuDhcvU9kZyubO--

--m5jOsxp0XIVjHyEr3vi4US2Demf3lKneD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2wIrAACgkQwj2R86El
/qiGSgf/bJxmv/q9NnjcdxY0tDlGqy4N7mhA1PkywEdLJUc/z2T+Xa+jSi2BTMG2
IGWzS4lMBzSoKDhHgps39W4mK+M1sHIZ0SvZHADuG+xE+PXpxMr/duwkDG07tlGr
Uj9Sssa6Snc2geNhgaSl2xKl6+qUrjERA5koXI+pK69SWwf0YIXcnKX2JLDTR3E4
Ao+hg42a+ibCgW/Eim2ITew3TXuO0p7wBYSfYTg5l1GJtKGyi4VzDgJv4BXb7btb
RupeiC7/9dAsoQRhyjeCIuTUlmr/qCv6Iip50ejDvACVuBrJDfft9urhl4iPvwl0
j6xg/iy9pJx5h6d0JxTpDpXNMPaIgw==
=9h/w
-----END PGP SIGNATURE-----

--m5jOsxp0XIVjHyEr3vi4US2Demf3lKneD--
