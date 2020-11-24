Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B672C1E13
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 07:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgKXGUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 01:20:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:47769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgKXGUu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 01:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606198840;
        bh=+L90j/k8KrvEhIgAFBuRJNN8KqS8YEZ6Xdoqlm498xw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Pngb3Ae5ajE2dwSOiq0109wfpIevE9jf/l8xf+WZj1eDdTDsDCXJRur5qPlNYU4/M
         SFKDY5zvtVR+uCNwBl44ToaciDlMJkgz0q5cY1ajoH+uXmKfX54NrTZivad5UM7EBn
         /TVC9vg5rM4/xrFCSe2FyY7PKU8kIxY8YoNXlHok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1kFZrf0lHH-012pti; Tue, 24
 Nov 2020 07:20:40 +0100
Subject: Re: [PATCH v2 13/24] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-14-wqu@suse.com>
 <20201118194818.GD20563@twin.jikos.cz>
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
Message-ID: <3c797106-c1ef-36f4-9dde-b11f588947f4@gmx.com>
Date:   Tue, 24 Nov 2020 14:20:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118194818.GD20563@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VoQk814gcpT8SeOf3ySOtjevUF2kC7fNC"
X-Provags-ID: V03:K1:fLK3MYtR8MVWSI/N/jCOIGdvQJUZEMUstAqDnZNSsDttyCrt72F
 dAz/UNEtq3Rqw90/NhvTUqyPgGTJZmeNAwfbLQSyOOAWxkcXcxRwIPgKM5EBTMgl9DApZ2b
 V5BNob4ZFxrwUjbOXuSoFg50ftdHDkQCy2uczFaARU/gZ/nWjrgYM9R2tKksWv2/i/TAfOm
 xWbUlDz4x4rHrFLk7jICQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9IX5yOQDmDM=:5uwLDRhRyRpuy9uUs/O8ve
 Md5UoJVBYl1MgGlS2LDMlk4Kt/thIJNVUB9F7Vkl8Wqs0iNQuXa1r4QwtuhTgP2/qpV+rKYPg
 hyzm856+PhwKrSLuHoxys9PvuhyxjjC9OSScYT0XovT59U0zwtEKNcu/nc+86F83omkzOKXUT
 7jlPiATnESDTARZozUbzQsl1qcgsaW9h0tEa7dTIvxRfqd8jdxAmMMqxfGuGKNzPWZS+mUzSn
 5jH8NJuZmiDuMr7exSf2ftm1GPkAa+XzmGdwsid2D60jh45PoJavOSAiG17uv+vFD10M5VU7s
 vsAoxScAf2g6oQdJTaYvatlS/UV7vkRtY7EbPmMSqZgHhuqf+m8nWDaDEyjDxNKlcjIyYtYxd
 ZZr0tR0/Wiguj+c+FcuiI7opObaGAvjMlh05UoAoArTByavCRsWrK91BF1zIZeYm9JJyyMYPr
 A7LY+nL3Jh9+OzGGUjJSBzuBTfsT19l9747bs+a7+OOCSTO4bZ2BEcm8nVswJQoqoPHPtgSce
 4LM9s7xYifbpTkA0cvRXIRiVlB2op/yv2eopimFn5BW9cDnBZLkrLlWcDIrWIMbeIpCu/6u47
 PmY7E0b48zj21hz4BZU9TX/TKPTQVrCNAnx0mFpSIvJ3oFRXIzITmnxk4WbsD0fMGIi1EGecH
 zghbBkdWioRL9ZhISIGjcUmlaKU0Eyg7YqFEDjmazl2Pz9EXsvIrslLvLyzNPQdpQ3M6xcWCH
 GDdQdJL6dS5ga4GDq8x4ccBWLwYXlVSdnf6pnuWwMxTJS3q4EaUGPNRmiAwTlhOGvvn7ROEwv
 wC4QZ2CwaabcBhP23MlNXXRHoYbNQ/X1T99rqyM0/Q6MbZxwXX80Q78DRzBF7ZvBmR4R/eo5L
 3N/B/oHjZ9x/7vWEaA4A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VoQk814gcpT8SeOf3ySOtjevUF2kC7fNC
Content-Type: multipart/mixed; boundary="huZvlpUkxK1D3CFFEeOl9N5icKKgbE0HZ"

--huZvlpUkxK1D3CFFEeOl9N5icKKgbE0HZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/19 =E4=B8=8A=E5=8D=883:48, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:38PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -1686,10 +1686,11 @@ static noinline int generic_bin_search(struct =
extent_buffer *eb,
>>  		oip =3D offset_in_page(offset);
>> =20
>>  		if (oip + key_size <=3D PAGE_SIZE) {
>> -			const unsigned long idx =3D offset >> PAGE_SHIFT;
>> +			const unsigned long idx =3D get_eb_page_index(offset);
>>  			char *kaddr =3D page_address(eb->pages[idx]);
>> =20
>> -			tmp =3D (struct btrfs_disk_key *)(kaddr + oip);
>> +			tmp =3D (struct btrfs_disk_key *)(kaddr +
>> +					get_eb_page_offset(eb, offset));
>=20
> Here offset_in_page(offset) =3D=3D get_eb_page_offset(eb, offset) and d=
oes
> not need to be calculated again for both sector/page combinations. As
> this is a hot path in search it sould be kept optimizied.
>=20
Now you fall in to the pitfall.

offset_in_page(offset) !=3D get_eb_page_offset(eb, offset) at all.

get_eb_page_offset(eb, offset) will add eb->start into the
offset_in_page() call.
This is especially important for subpage.

So here we still need to call get_eb_page_offset().

Although I need to find a better name for it.

THanks,
Qu


--huZvlpUkxK1D3CFFEeOl9N5icKKgbE0HZ--

--VoQk814gcpT8SeOf3ySOtjevUF2kC7fNC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+8pjMACgkQwj2R86El
/qjLMggAjm3SUwM1nTRR2erVMzQUP+7DZDrKXeb53ZT1P6Pt+GG81R5N0CQpLSwV
OWRyuPaIHaIIOBszl0aSh4hSg2HBqaV12M3EJ43ijaZsfLaJGRU3wkMNRYPQeSGT
rM6mJn0Q26DW8conpRaPz1leWNKXcE1xmlRF81LgGX3+16Gu006SVjdj5sSkrwER
T6rjDvl608UBMp4J8SlML0mD99eOU42ld3lip/YagqUbZ2qWw7gcozWDNFvB2eS5
lOIBX5v5+F05b+lqSn8/u1zzvUUEsJuf0BEH1WecN9YEm/Tb1hL6reUmsMvXRhBK
jhLFEr2fiPEmpy6O9K3+T0XayVZngQ==
=6kGC
-----END PGP SIGNATURE-----

--VoQk814gcpT8SeOf3ySOtjevUF2kC7fNC--
