Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819A929F94B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 00:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgJ2X5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 19:57:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:54823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2X5s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 19:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604015864;
        bh=xXeQkRI/swdyPVodUo7+l+MsLXp8Pc2GgRgjkAsbqGs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LdPJlnSUgGKbtblUbgk1a1mcrixi2+99PbPImZlYLGZ6Q1jHeWcGnFBX3/YyXAaRn
         Bd2IUD7K2wNChNqHVBiQINiRMVTD1Xbq5hAtzvcswCPqhLBBv36DR8kZUFBRsGM0gX
         N+KZVs9FQZ4zYLupmz6Qay6azOKpcq0TaZp1YGxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wpt-1kN7jK25er-012JUc; Fri, 30
 Oct 2020 00:57:44 +0100
Subject: Re: [PATCH v2 1/3] btrfs: file-item: use nodesize to determine
 whether we need readhead for btrfs_lookup_bio_sums()
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201029071218.49860-1-wqu@suse.com>
 <20201029071218.49860-2-wqu@suse.com>
 <946ec8c3-9480-e3c3-aad7-9b97e8aedf12@toxicpanda.com>
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
Message-ID: <a933c57a-7514-4db3-7fee-04af2e7becaf@gmx.com>
Date:   Fri, 30 Oct 2020 07:57:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <946ec8c3-9480-e3c3-aad7-9b97e8aedf12@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wIKXhbA2yST6PcSrdtGKA9jM66Ytsf7ou"
X-Provags-ID: V03:K1:6JivSjhCfBP4jLtbjFuuC8w/65pZ3SPptCHfxhm9tT8aVD2fVL6
 ouXAkQ1toiDKJsXRQOwTDgF24UZdScs0omFe4ID2zWmb2clN4AH4JtPkQFAMz673heYuf5N
 VXr76FsY0VgfBbV4UbElHPGo5Ef4XymOuTzrZQJeg2x+rqxXK49MYjxOfcnP/+c2rUCkWBi
 GmwPUNLJQ6XbNKyaZjiXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCeBAm9bY/U=:8yva/rcfjMOrMxw58obHv5
 YqU3KgfKo/EbY6R5YXGv7RZZ96PgPu+WZP9oTYNUd2qhXRwyycJFar/C94siG8UJQpEEFhcCF
 lutD591tLMWBy4eGCH/YEhgoZpd1dRYx1WbAvcOKwCPogHSMwyLVVVd1y00Dp6M2dXK8JPUM2
 9V4O7L27Na7FhiU4tF1Mw4kCi1kWpVTeZkqgJtm5pmF9K5apQvPPmVtNgK8XDj+O/hMThkPin
 yIGLK9nqP+F22trgSme6eQMERtDdtT3qP8B4IM1KQ1bD7Em6BPGXoccfD3qMQwiXQRgEhxasw
 j9iTT1SgziKBp3qLtpmQ/RcwsaxE4Rx93DP4IHiFvSdW4mjXJCkP7glB/n/gRC0TyS7iC8Oay
 VvZg6pyJ/9GjWYtoYjs1mYhDaVgW5R0TrcSTwZSOUdqKR8WKwMNtqFZI3kf74ynAN0OFgsfam
 sbLrbIwA74VX/rPvzelXwspIfoG8QC5E4kvbCKU5aeuohF02JlMJ4drXcuTyHPp9D49i8LVfz
 wD6au0LQ8dCdFzOqwwRIsT0vfz41Wdn2dKPi/C3zmVKp1yjqlSSVoNPI2yJjs8xqSn65A6ZlM
 tdMFPBi4PAsQLDL99Cl5VuUNuTLLxT5chC43aKR/Ns+APqm7v1myymrIKu2lO6ETj4YCZq9ov
 HOS/IdBz2CmLPoSUJ8e4zLQPIewlqFow8f4RnxvXoBXbQogM2MZvipyGciMdN5YEsyl9XJcLE
 WEQmaRLu2MqGS5p35KmUz/f59Bx1k4IfUYlEf8umtASByROvl8LfoRpQaOAk+wDt5M1hAhFa5
 iTZV4FEGzOSKKFTYRmAAGGXex/eiMkUhY8Athak1lgMpIv+PD5r+rn1TZT2YzIvu5+xc58fYh
 NJPbqGACzASVs6PexPpg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIKXhbA2yST6PcSrdtGKA9jM66Ytsf7ou
Content-Type: multipart/mixed; boundary="XcibNfDnAF504cPVDZjTjQzVEaHpzmwLh"

--XcibNfDnAF504cPVDZjTjQzVEaHpzmwLh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/30 =E4=B8=8A=E5=8D=882:57, Josef Bacik wrote:
> On 10/29/20 3:12 AM, Qu Wenruo wrote:
>> In btrfs_lookup_bio_sums() if the bio is pretty large, we want to
>> readahead the csum tree.
>>
>> However the threshold is an immediate number, (PAGE_SIZE * 8), from th=
e
>> initial btrfs merge.
>>
>> The value itself is pretty hard to guess the meaning, especially when
>> the immediate number is from the age where 4K sectorsize is the defaul=
t
>> and only CRC32 is supported.
>>
>> For the most common btrfs setup, CRC32 csum algorithme 4K sectorsize,
>> it means just 32K read would kick readahead, while the csum itself is
>> only 32 bytes in size.
>>
>> Now let's be more reasonable by taking both csum size and node size in=
to
>> consideration.
>>
>> If the csum size for the bio is larger than one node, then we kick the=

>> readahead.
>> This means for current default btrfs, the threshold will be 16M.
>>
>> This change should not change performance observably, thus this is mos=
tly
>> a readability enhancement.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/file-item.c | 6 +++++-
>> =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 7d5ec71615b8..fbc60948b2c4 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -295,7 +295,11 @@ blk_status_t btrfs_lookup_bio_sums(struct inode
>> *inode, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csum =3D dst;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If needed csum size is larger than a node,=
 kick the readahead for
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * csum tree would be a good idea.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (nblocks * csum_size > fs_info->nodesize)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path->reada =3D=
 READA_FORWARD;
>=20
> Except if we have contiguous reads we could very well have all of our
> csums in a single item.=C2=A0 It makes more sense to do something like
>=20
> if (nblocks * csum_size > MAX_CSUM_ITEMS() * csum_size)

Oh, thanks for this.
I was looking for things like that, but didn't find a handy one.

This indeed looks better.
>=20
> so that we're only readahead'ing when we're likely to need to look up
> multiple items.=C2=A0 Thanks,
>=20
> Josef


--XcibNfDnAF504cPVDZjTjQzVEaHpzmwLh--

--wIKXhbA2yST6PcSrdtGKA9jM66Ytsf7ou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+bVvQACgkQwj2R86El
/qj6KwgAlzK/pujr/O1txdYfquddctN54fTAsJgfH6PawKIOTyB0V7Hwjm9/y0dR
9T+DLcyBSKsm//fnouYsRUSbXhZQfvye76a7nZTBRCLbKzf88dpxjlvrXUJCMjQC
i/0f6Dnr+W+YQex7K42GkYhrAB3ozXruC4QWk152wR5fZlkbnkgJvg4QnIVOHKQD
6sbDok0KoWzFja14pGF/agufn7zeTVQejzTjHLdUVMwqykk0nQPMECTrU/+zDrP/
QpkrMtXpNVgTQm+UJSnbswdu4I0mfDSgujMwK/TpZKmVX05HE0B7KmfhR8AMj06b
W90dG/lg4UKBnPzIyalD4pUVNgbQJQ==
=KNmR
-----END PGP SIGNATURE-----

--wIKXhbA2yST6PcSrdtGKA9jM66Ytsf7ou--
