Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D152B88D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Nov 2020 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgKRX56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 18:57:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:39287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgKRX56 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 18:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605743875;
        bh=T5VtW/TQf4c6+KR2rQEUZLtXtemkmYlHa718sAMrACQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=co1vWc2kdCtTQ/RZUwkBBFacsmiNzxxwtn1mfZkVqAt1NgXeGkM8G8xZKdXS3z+h+
         IMuMA8pXdiVTzStaGfvybCBxj+kqAQf97E1Au/Eu4+WBjs1aKGU2d8uDMwbCRycO4b
         QmCIlolsyveanNe7+HEGlad+xFanPGQjY5tPmF90=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDc7-1kOhLD1RYj-00uc0g; Thu, 19
 Nov 2020 00:57:54 +0100
Subject: Re: [PATCH v2 18/24] btrfs: file-item: refactor
 btrfs_lookup_bio_sums() to handle out-of-order bvecs
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-19-wqu@suse.com>
 <20201118162754.GB17322@twin.jikos.cz>
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
Message-ID: <5810e611-9f77-6762-d9ad-94b4341e16ae@gmx.com>
Date:   Thu, 19 Nov 2020 07:57:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118162754.GB17322@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4PVgLI3wxGiHUYCnmUGuvE2N6g9DUJGrw"
X-Provags-ID: V03:K1:Qi4I/G3LVxkIIlgLA1SFK/Gom2Ws8NvBjOfIL+htpwtxHj7sVvu
 KSUwJqatuR4G/dsEBLyCVYm74pDm4AifmXTPPaUXYWl6We04Zd0vGAKQMJ+Uz9jHqEI3sOP
 LEOHR/Wrx9qHb1NRnLwagyN6VuODqPNRFSXDaOaPrDN+lhOD+sjxWhnsdFYEzyrSu0dp4IQ
 xKaJkMAzMMfuREg27VpJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5novPpPdysY=:QEhdn7o+0POplOPnjj6PwX
 DzSUEQFpFhTIvEwMw2mKVmtJXrK6T9qO17lsuEY3HPoih5JR3utt01diSyregq0E0C39ABwlc
 RJlVfh47Xdn5It/GuRHRna7NGo8+FczAszMfw5eQSrdvxjFU19JEWQqNxtJ0FZgDp3Dct+AOG
 jmNNucQgqGnU0Zsfea7JWkuWEqwR2CRZIcySFnBNBVjG1jmXL/PNtQPnHwU45RKlXYwMKtJF5
 52bTTCGY52H4QIPRVZEaNU+VDCRa/DPhzt2NqajI+j/DSK3aG3xyuDjvbkHj24kdkfAEj/Apw
 tA1MedTed1XMQVMXwXk8Mfv2TYOS+BoH1jav3//aeH1TQj8xNvOiKqTwGhDOHXhOFBqEknGcZ
 6K2zcsrCfMcFzQnVnbArrFWiq1YEWuQe/GqUvv5CsWnfPK2vZPCyWVJq9AQTSq9LCMK14h+ar
 qE2cqoPW/y2hi7A1TS4co+Xld3wOUbDbzGGk6bznEbfsVdicUGYnWhCH2jqbdWw/NqhmgjK7b
 XVUB0OvdSVsH1gy7VVgrqlbQrFMm4kg0oVeViHcmYLEklC2UsG490sacZso+tiFBd/vGbxGdR
 yu5p/P9yV+Xc4Gr1uIGn3Ic+3BLDSeqt5aFej4uaH99ftTOVi0Bqnx3ysMq/3g3NOrIanIdHJ
 tiLsGI0b28npJXgWL6mn20g1XgAuwuyzeAWPwvKoqVhJmcGbAHcSQgPDspPUrIAzotfvgdzSk
 daVdx/4r2yOUE1dmB+ZW1qr9UnY24H+qbWKMRAZk6ktheK05tBahtN1bu0BW7mv+y7hLi3t/+
 jQ+F4gesqaZPczC3vvkRvU+jTS6zSPbHbTaEKpQhoBnD8XMhgRSUUAwWvN+FBHdXfPs7t7Uui
 INJdR1haaP95atVsMDfQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4PVgLI3wxGiHUYCnmUGuvE2N6g9DUJGrw
Content-Type: multipart/mixed; boundary="2KZLx11gBugK6SXAod6QFGjqppQbYYsLc"

--2KZLx11gBugK6SXAod6QFGjqppQbYYsLc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/19 =E4=B8=8A=E5=8D=8812:27, David Sterba wrote:
> On Fri, Nov 13, 2020 at 08:51:43PM +0800, Qu Wenruo wrote:
>> @@ -325,81 +428,53 @@ blk_status_t btrfs_lookup_bio_sums(struct inode =
*inode, struct bio *bio,
>>  		path->skip_locking =3D 1;
>>  	}
>> =20
>> -	disk_bytenr =3D (u64)bio->bi_iter.bi_sector << 9;
>> +	for (cur_disk_bytenr =3D orig_disk_bytenr;
>> +	     cur_disk_bytenr < orig_disk_bytenr + orig_len;
>> +	     cur_disk_bytenr +=3D (count * sectorsize)) {
>> +		u64 search_len =3D orig_disk_bytenr + orig_len - cur_disk_bytenr;
>> +		int sector_offset;
>> +		u8 *csum_dst;
>> =20
>> -	bio_for_each_segment(bvec, bio, iter) {
>> -		page_bytes_left =3D bvec.bv_len;
>> -		if (count)
>> -			goto next;
>> +		sector_offset =3D (cur_disk_bytenr - orig_disk_bytenr) >>
>> +				 fs_info->sectorsize_bits;
>=20
> I replied to the mismatching types already but because you've been
> sending out the patchsets too often this got lost, I really don't want
> keep seeing the same things again. You left some int type mess in the
> new subpage patchset as well.
>=20

OK, let me to be clear here, what's the problem using int here?

If your concern is the width, no, 32bit is definitely enough.
At the right of the assignment, calculation is still done in u64, and we
should never have a bio which is larger than 4GiB.
As bio has its size limit to UINX_MAX already.

If your concern is sign, I'm fine to change it to unsigned int or u32 to
be more specific.

I believe using u64 everywhere is definitely overkilled.

Thanks,
Qu


--2KZLx11gBugK6SXAod6QFGjqppQbYYsLc--

--4PVgLI3wxGiHUYCnmUGuvE2N6g9DUJGrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+1tP8ACgkQwj2R86El
/qiwawf/UfRI5vJ/EJ0QOaCayGgeObCz/QE6aL2vFXBUJ8Ly58sXDCO71wRwsL2C
j43KOsUmyBZnboxEsKcWIfEAwHJiXhNfzy8Y+S9Lpctg49llbDJLKaShKQXLd0Wn
g/4tYJjrxAhWIZIPF+ktnKYx7BEzSR5mA3mUppL2TltqN4hfWItCawjsqWOVgr1T
e2qodQcnH69iQ61H6+gX71gxF+C19E1uyaBMM392/u/5gP6tyQePCTwtCmHeYdOl
cBPGhVUYaJs91ZExcCjN9Pg8ki3nqxm8HofsKgX7drv5BvcUYV4qZYSwjL3McmKp
tOH6CsTWRoBgWHzj5wpDwTnZky8KRg==
=C7U3
-----END PGP SIGNATURE-----

--4PVgLI3wxGiHUYCnmUGuvE2N6g9DUJGrw--
