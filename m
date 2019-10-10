Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA24D1E5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfJJCWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:22:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:47157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfJJCWF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 22:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570674111;
        bh=91egluPUohULZ3CRz8pvgwnPPJA5WCsjC8qX5rDIPb8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FSsKnwvHm8yjKeO1NMEfbj8R5mZYdSvlnAFGzws7BDI6anryLi7f9NKW/vpHnpp32
         VlDYwT20gyz1YEZVSU61MPMizW9M4AqHTFVYqt886RlKpmPerRsPeE6m7JmGqT9xPx
         AXCiy2UbKaNRtXSVD9hoMg++XEx9HaNVdxkmE5L0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1hoJeM24i7-00mKBJ; Thu, 10
 Oct 2019 04:21:51 +0200
Subject: Re: [PATCH v2 2/3] btrfs: disk-io: Remove unnecessary check before
 freeing chunk root
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044909.157750-1-wqu@suse.com>
 <20191008044909.157750-3-wqu@suse.com>
 <a51926df-f18b-68dc-9241-7e9df1164199@oracle.com>
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
Message-ID: <f279edaa-f504-a953-1d0c-b90d1aae77e1@gmx.com>
Date:   Thu, 10 Oct 2019 10:21:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a51926df-f18b-68dc-9241-7e9df1164199@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RHPaimokcGd4YZtuCKD4adtqkuW9ZrnQA"
X-Provags-ID: V03:K1:4dMuRKDuSaXiNuVJl85aZI5KFru0o/SN+yd8jTOphgnAa5IICT6
 b14dB3xp3Mevky1yDBIGchF7uaWdowwE/mdZmdtHntjxVvYgrDfChnPLAPS5l2QjoMpfFuh
 zDvKfo/yMgAPYqDox+8BEpASbMu+vvPwWPIRXT6O8oP07t9MPRTC7wDRm/lL0yFJqKijLUz
 RQDlDYQdo7V0yQYX1I6pQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QcMnd0sM3Xw=:5kJCmnVaXPkZ632Viv3YBe
 vWII9ktE/JiGeb9dOJfX7WeTco6KQmTNEh7rqPtfhTF2IbZpKg4BW9jz3yqYagAFpi6kPutRi
 zXGKdGQkNF3x9xfkCdsEWFLFwztz8UTZYkACbsEWny3q2d2ypgGJLUK6u8NoFgOiPvjyjVEOG
 neydHfxa0QBpRQMOJaO9tzLLHhlKea1AK5sX34ptAGY/b15cHADRsUHj9QLg2kpvdYIEL4n0N
 sxH43jgJqh62rp9AUylDh87D1xQNr8XpA36Xc+9befJmrZeKHHEWqWpHT/vSlYwNJtMTkBBsu
 PRuF4L5EB13At9Hjnthw9LlhQfUDjOtrImZZnwoAlqnMukUja+j4nf25gaJ0aBurP1qp1wzeS
 hNVhF7KUGRFr70s98eKnm22fg2Z2uQkK9JWIldhvxp57nOCsMPbda+1c1RG2JW7Q9hp4LeUUJ
 yCBA+5qcQjaom5VqA6wwn3WYh9GwP8tWtlUqnfto6EMKh0uCjpSfGXViUZ6bClBjkIMz7z/6L
 BPbNs4oclvxZPvWTqT2SHxnRV5W2ZZTd31tgylqgshbkbhILw9Ty3GIlzuoxzC8l/rMqZWwou
 kLN7BM/OeBPYzXAuGXZlLmudXXws+MPb/+Fzs5cflWCugW4xOr5V47d+h9aj12tJiAfBDsE3X
 8a2YLNFypJpJsU0+jwn6stIp3596C2Bl0KzSNxGea8IhZg9T66ckKQfKkmz3xfMk574vXM56w
 nwq0ODIjo9m4NvqbXM5/sSlwcQr1TQpfEie6rHod3z+14j2loppKHMRLt3oPUerq+3dU2xe9X
 TDebwPursE6d3DcnJbAT0fDOJQE4HdsF6OZk1OFt23Hx+lcGTtxuMTJZA110ds2IFC22sDp5d
 J+1GLL+kcbooMLQbr4t8cy04tDQAxAH2Yzpe8sxeTApf6IgMpvOBe6CHVfCwavO6eBmZrY2kx
 UbxyNbbDj/Grtc0ZeqvQfQtGEH+cBECLz+DMNCSi7g/I6vPx/JY7F7PEw0Owv/htjWM4lV9YZ
 LcQEOV1+nnsv9Rkrfu6tU37Zr/GmOH4x26+gWfJZ78vZLZEh3URBn1sWfFm+cGwJXGzZvaOLi
 qD/8WRKh+Ww34P5tdyX+HWhB8Rf4xApFjlqaYJajmLok+MUGnoSXjvXGUhVDZXZCXtoHWub3c
 J3xdwWFufntPiEwc5WIveZjUvIu5CvKUhrWSriFH4T2lOpnPK+6+VAy24WVnVZq06eyS0IAnU
 p41cyWVSKRRll9Go/R2iMSDnmB2IVSCYAzsslWs2nzNWtwYrgE6JGQH9iiGk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RHPaimokcGd4YZtuCKD4adtqkuW9ZrnQA
Content-Type: multipart/mixed; boundary="YZGnUSv09u76g9EjcNnBEbT5P2HyNnBME"

--YZGnUSv09u76g9EjcNnBEbT5P2HyNnBME
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/10 =E4=B8=8A=E5=8D=8810:00, Anand Jain wrote:
> On 8/10/19 12:49 PM, Qu Wenruo wrote:
>> In free_root_pointers(), free_root_extent_buffers() has checked if the=

>> @root parameter is NULL.
>> So there is no need checking chunk_root before freeing it.
>=20
> um..

Oh, my bad, I get confused with the parameter @chunk_root against
@fs_info->chunk_root.

So please discard the patch.

Thanks,
Qu

>=20
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/disk-io.c | 3 +--
>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 044981cf6df9..bfeeac83b952 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2038,8 +2038,7 @@ static void free_root_pointers(struct
>> btrfs_fs_info *info, int chunk_root)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(info->csum_roo=
t);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(info->quota_ro=
ot);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(info->uuid_roo=
t);
>> -=C2=A0=C2=A0=C2=A0 if (chunk_root)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(i=
nfo->chunk_root);
>> +=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(info->chunk_root);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_extent_buffers(info->free_spa=
ce_root);
>> =C2=A0 }
>> =C2=A0
>=20
> This will cause the regression and fails mount from the backup root.
>=20
> We have %recovery_tree_root: which shall re-read all the trees root
> except the chunk root.
>=20
> I don't think your idea was to re-read the chunk root as well?.
>=20
> -----------------
> recovery_tree_root:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btrfs_test_opt(fs_info,=
 USEBACKUPROOT))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto fail_tree_roots;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_root_pointers(fs_info, =
0);
> -----------------
>=20
> Thanks, Anand


--YZGnUSv09u76g9EjcNnBEbT5P2HyNnBME--

--RHPaimokcGd4YZtuCKD4adtqkuW9ZrnQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2elbYACgkQwj2R86El
/qjq2ggAi+J0BQciSNcsHAuDeqUr+bL4tk2ruFWgbYVZ7iyzsNSK20N+LPway5IU
XJK1ZoX4ZQDbD5B57bsqW0VEmekbbEGa9kVbqp+sa439r3KMNsiJmSzL4a4zLusH
dDe/zzXLfKQtqcMGYccGdlWMQfuLWeWK7xSE52Uybn1ODZo+jYogUU9e1psm4ENR
Cv4b2Jig5Jn6I6mr3y8Z3J519cjxaYUaL2kr+zbWwILUqfouueaCLKN8kgP5UC0h
+mGLL4IKngJOCha9y2hdlKtVV5zMAJzzVfysm5pchea5NHkB26IqN0UIfkx9r0yG
bme+GTg8mmlzN+NfOp4V7aKKYsPFFA==
=whMH
-----END PGP SIGNATURE-----

--RHPaimokcGd4YZtuCKD4adtqkuW9ZrnQA--
