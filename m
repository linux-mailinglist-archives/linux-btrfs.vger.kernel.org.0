Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327D02B8876
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgKRXie (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:38:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:47317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgKRXie (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605742710;
        bh=nL7RTix2shZSOn/eyq7ZBrjr5iYE1RBwb5hy9a10BVE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T7H5OSbm/ZWbs1h9ALDDsl7xpi9CVQzq70ZxXi+YZ0tFBk4ZiOOkhaEdCc0O7IbaX
         1ay2vO/ZeJebo3MlNMqVv9sfhkEVrsrlUbTTXRbrKBxtH82Tp4vITPfTKfjN5EcPru
         voKnwQQfM8T5JEeIcLXGgyhTOcT8fGCeFSPxW+yA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MacSe-1k8xR610dW-00c9wg; Thu, 19
 Nov 2020 00:38:30 +0100
Subject: Re: [PATCH v2 22/24] btrfs: scrub: support subpage data scrub
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-23-wqu@suse.com>
 <20201118162944.GC17322@twin.jikos.cz>
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
Message-ID: <4483e15c-a983-0469-609a-0e38b1461a61@gmx.com>
Date:   Thu, 19 Nov 2020 07:38:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118162944.GC17322@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XcP5CzfNm8DJGYfqDYYBOqvR0vlkBmH4x"
X-Provags-ID: V03:K1:sxTLZBdTGXeWUA5O1gQEPC41gXM4SdZGLGUte284/RTQhgpmRlo
 UgTFeeyAnyZkcbM6N+QT1W+8m6ILyrzxRf6ymfvE52L5cW9/PsYrZ4MrzLCx77kn1RvLKVi
 w7nMQGIo5FZ3NW7eISt89N1RqWISD0XFAVoDO1EWBqck8EJqkFPHkBz8I8I6aazf3tZmkSg
 IBIXIAVoxcFyswmhenM9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E3y6o2jcLc4=:Cvg/7nw6atBeY8xBb9KXh0
 jkV4p2gvKEr/XNH+VY/7dVx8RVfKanI1C5Frgu7Tlvg1FuL0zKFfTqU9/YtelVqm10vxLK7TG
 PNahJVIk48yyMtxnGk8/wK+n0j1Hb0KCW8lZSMd+KGr25QbyzqMendWgQcUDFPbPyW63Vw8iK
 yYGcArRRPtfHWy4q74zIeYBXwYzy7kmXM0GddToDoFUpmRDBqhD5hjJUXqalqADi4czRhrpJO
 HAxKJsF81Y2tavG+xd27E1yf9LXpQcuv3R59qqgeUd4ebMleB3vVVZldCWFHnenVZ8iOSfWRB
 pCUk/cnYGadUWEMqqaJmuU0DuoeYF/7kd28YBi1kY5X5bUz1mByu8V0MNot7+T6EM/0sHeNml
 ee/7JjIA5GNR6RUFgdARw5aFrBDq1J1LUCSS/l/CIOJ9Vgrp91L7OSmzaWXO6oEHRu2VtAwxk
 3sHHVPyhYOD8wtLH5i9k1gNu5HFeiC8TDMaGe3UszELxunEZNBGiq4c8JUzJHOld0mP3jAS2M
 U2+Ss/2YCCdlrDnCJIqD1HbV8YwIR0WQL/4vkqyCYTdK0NU8Ki/xbftWO7uA/fo3xuStkZNXV
 D9rrUlLJVZSi2//HO1CshuTq+rScpHVIJMLN5sT83nO5Qe0inyfwiIekGe/3Z44nR1KyNNYb/
 7g+HiMaB9JOZAMiukZGa8T+5otqV1kNRFBd9jlrxEX9A3dAwWajrgePQ9Uizs0MKfpxji1f6I
 VsJ/S3uaOrrUxvvITUsQ4ON028o/+Wtd4wDYLbZ8cqqZ5aP1aWlwOFqzysBaUhJzp2efd9WID
 CJeysT1Dwm3VSrTG9NGLoXlgGwUhtpazvHLt0Kqt5KDaM3OQVl2hNvPhHvZ69KDMEcq7Vxwae
 /n/utuQrsu2qxpgVHhTg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XcP5CzfNm8DJGYfqDYYBOqvR0vlkBmH4x
Content-Type: multipart/mixed; boundary="DwxkYAV03pe08ySqnzVdqmHzzjUS3Ry5u"

--DwxkYAV03pe08ySqnzVdqmHzzjUS3Ry5u
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/19 =E4=B8=8A=E5=8D=8812:29, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:47PM +0800, Qu Wenruo wrote:
>> @@ -1781,8 +1781,9 @@ static int scrub_checksum_data(struct scrub_bloc=
k *sblock)
>>  	struct scrub_ctx *sctx =3D sblock->sctx;
>>  	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>> -	u8 csum[BTRFS_CSUM_SIZE];
>>  	struct scrub_page *spage;
>> +	u32 sectorsize =3D fs_info->sectorsize;
>> +	u8 csum[BTRFS_CSUM_SIZE];
>>  	char *kaddr;
>> =20
>>  	BUG_ON(sblock->page_count < 1);
>> @@ -1794,11 +1795,15 @@ static int scrub_checksum_data(struct scrub_bl=
ock *sblock)
>> =20
>>  	shash->tfm =3D fs_info->csum_shash;
>>  	crypto_shash_init(shash);
>> -	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
>> +
>> +	/*
>> +	 * In scrub_pages() and scrub_pages_for_parity() we ensure
>> +	 * each spage only contains just one sector of data.
>> +	 */
>> +	crypto_shash_digest(shash, kaddr, sectorsize, csum);
>=20
> Temporary variable is not needed for single use (sectorsize).
>=20

Personally speaking, whether such temporary variable is needed should be
determined at compile time.

For reader, I didn't see anything wrong using such variable, especially
it can save some "fs_info->" typing and saves some new line.

Thanks,
Qu


--DwxkYAV03pe08ySqnzVdqmHzzjUS3Ry5u--

--XcP5CzfNm8DJGYfqDYYBOqvR0vlkBmH4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+1sHMACgkQwj2R86El
/qiGswf/cmTLjoDI1SZKgvXEqlLWUwllhjhi3f433B5QFjvrGzDQvSi/9q03PMX8
tdVrFSH6PdQPlWkJh6q7bnWUcP6mlMhUW00//gsDbXvsMpCb9zk4iA1HTu/780DE
kcYlltZ9TOBnPcbrx53cJbu2ap/3h/SJrt57Man+AMBplIHJo7Z88VeWOGRzbv4T
epHCwh7U28xyb5+q2Au0yVRkfXxUDRRt6koN5612ta3+rykU8yx59HGJ1qiYJgzL
dXmRPJiKGAOv60TiPnwhsKxPRSzDA/CQYEjALu4ttsxaDArXOPcoCLMSNDUyzk9z
R82DdjRf/PhRmzfWUDTEzrBTZTbkiQ==
=ldLv
-----END PGP SIGNATURE-----

--XcP5CzfNm8DJGYfqDYYBOqvR0vlkBmH4x--
