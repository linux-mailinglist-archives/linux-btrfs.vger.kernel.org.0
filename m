Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6A29A1EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443518AbgJ0AuW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:50:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:50081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438851AbgJ0AuW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 20:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603759819;
        bh=FoRIwKcEqlze1e+IUZ/EDwtql4MFiCCUniy02Y+GMMI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NjFfhPvJGsrAOJoTBTo3/aCKSpLwOMSVdXnHy8z8JMhYWRJoCwJnK/iUyWA5duHVL
         yQH7VeYSSuAjLfXhEua9bm1UdL8CJTCmzher+Jykvgh7nmFaFMWNHIALexqvwZ4Cg5
         hQ66s9lT8rSWKbNBkrNydHI0CE24rDZTRHAfRWRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1k7B2r32mV-00mKik; Tue, 27
 Oct 2020 01:50:19 +0100
Subject: Re: [PATCH v4 08/68] btrfs: inode: sink parameter @start and @len for
 check_data_csum()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-9-wqu@suse.com> <20201027001305.GW6756@twin.jikos.cz>
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
Message-ID: <bb49899c-c25a-a4e4-825c-4c8a2ea4b176@gmx.com>
Date:   Tue, 27 Oct 2020 08:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201027001305.GW6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V8c2p4avnhCRpUQT4I7wUVpxIG0KO1G9r"
X-Provags-ID: V03:K1:jwKpQBbDWy5Z3jkY23KhPBUFDrejm2VBf8lZHTEa9tC/oruMIjR
 AaAW4eZ1WkrkXEiCBGiOvkwKylofknhjvuqMtRKPcygP5VA2X+M/eiMy7p32u8LRLteTWR7
 4Rke6vL8Aa9IWrnX6ZUNlTN+Zqo4l5SCzs/di2MwvWR6SYdMsaRAV7NR6oM58GHZRcXi/R9
 RQ2Ni70tJE8Cs+W4oQlVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TAXFGpMgGZo=:o73ftfcl1QuER1aUBY0B+J
 xLrFRx5nl3ZXEOiGPJfKTXzg0+UBjQn6anMIimR4egICRhH/RMnsrE1ayMEHC4utc/hyA67vd
 BNR2hXHchnBeF02Ym2I4P+RcLtOybYM9y7024pCc050a5KYpzegqXVJv9bMd7iVotip5n7tts
 IZTDdLUeOmQoNV7Zw/8JZ6iX1utsdacXWFPFJeSnTKSEELKPR87pY2qTXZC0t3faUeNS5wTf8
 YzNPUDO6H1oiUkbvk0AEq6Zr10ENVAWyd5JvYFFM+ghgosZNXVJZVdh+Af3o0d+7db8cSz0iP
 R+25o69482s+4R4m5yPNWC3JLt8YIoIF8ACTskj4hqYQXHJRDiZFYsGrahPfN0r8wyzpfyGJT
 jKGuvE75E54d9aEpnp3piI2fgDrcUqvyYe8qD2CuMhzIfiQPSzNLwfkkYUQjmKdzR/HxTZ21C
 9z2E8UJDYsijYyb4+kp6tw7p4CSfDeZl61ttAJJsbpNUYKcnh7kSQGS1sAy+EjI1NRTodwFoq
 yVgyCkyTIxnjVWr6XC/eZNWVDOFYyKvCDj2Ej5bisbFX89nTTvcZhy2RJd8oYGMxkJNW/YONh
 wqDSroRWO8DZzJYDIiNDdPXv+E4oSMKdspilCb7Wlhgw7Wb18rx9qsdEeiMtCjocH+kLLfwSh
 UzX9H7C62xOca0qjRxNmA9x185RMh5hORA01QxUULuff4MJ/jxWMeiwQt7ZgdPuglPq8LM8m8
 xEfB8Dg1MCvdNxTn2vCdWdQJ04fJ0h9sGgNY15dVlfSVP/yoWrzwnPQuottesKGVncX2NbIOZ
 O31Th1LG/KWbgsh0/KFIz7bmoPd5aHcCBtMar4O0QLe0MfLuVezweDYG7le5lsHsOs/li9NoQ
 mr9lLsVW4yMvGNk4TVDw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V8c2p4avnhCRpUQT4I7wUVpxIG0KO1G9r
Content-Type: multipart/mixed; boundary="zb575Pn5hPiKyVpAD6g9YePLCML9Tiian"

--zb575Pn5hPiKyVpAD6g9YePLCML9Tiian
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/27 =E4=B8=8A=E5=8D=888:13, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:54PM +0800, Qu Wenruo wrote:
>> For check_data_csum(), the page we're using is directly from inode
>> mapping, thus it has valid page_offset().
>>
>> We can use (page_offset() + pg_off) to replace @start parameter
>> completely, while the @len should always be sectorsize.
>>
>> Since we're here, also add some comment, as there are quite some
>> confusion in words like start/offset, without explaining whether it's
>> file_offset or logical bytenr.
>>
>> This should not affect the existing behavior, as for current sectorsiz=
e
>> =3D=3D PAGE_SIZE case, @pgoff should always be 0, and len is always
>> PAGE_SIZE (or sectorsize from the dio read path).
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/inode.c | 27 +++++++++++++++++++--------
>>  1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 2a56d3b8eff4..24fbf2c46e56 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -2791,17 +2791,30 @@ void btrfs_writepage_endio_finish_ordered(stru=
ct page *page, u64 start,
>>  	btrfs_queue_work(wq, &ordered_extent->work);
>>  }
>> =20
>> +/*
>> + * Verify the checksum of one sector of uncompressed data.
>> + *
>> + * @inode:	The inode.
>> + * @io_bio:	The btrfs_io_bio which contains the csum.
>> + * @icsum:	The csum offset (by number of sectors).
>=20
> This is not true, it's the index to the checksum array, where size of
> the element is fs_info::csum_size. The offset can be calculated but it'=
s
> not the thing that's passed as argument.
> Isn't the offset by sectors the same?

If it's 1, it means we need to skip 1 csum which is in csum_size.

Or again my bad words?

Thanks,
Qu


--zb575Pn5hPiKyVpAD6g9YePLCML9Tiian--

--V8c2p4avnhCRpUQT4I7wUVpxIG0KO1G9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+XbsgACgkQwj2R86El
/qgdUAgAmwKmNGYvIex4z/L2zq3obKjqp+T0eZVawgA351P4J5GgL05k7Czg4jSN
UdawRuuXr0t127FZGHl47Tagj52+k0co6ST555gBSe5p0u+HA1yRQP8nS0uDAWw1
Oe59bc/EcV68IjoLP9Mcm9K057T/EiDJoliV5cbPQx81DFuSAenudh6Rx8mURxev
o9yDdoqWCq/3WqojANnxyZzomyNFu0uPCrTzOgiKKIu5hxKWSKkejj1HJ5uIvxDe
C0+IZa0C8AdisdwKrABAUsMAm1sZJyHF24mehexbkN53cXFux6YVQbJ2l/o/ZzmZ
KYG14mf6nY6D4xnlxJlNygENkpHA7A==
=Ovq7
-----END PGP SIGNATURE-----

--V8c2p4avnhCRpUQT4I7wUVpxIG0KO1G9r--
