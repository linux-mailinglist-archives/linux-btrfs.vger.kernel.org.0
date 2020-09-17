Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF84F26D5D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIQIKH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 04:10:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:56145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgIQIJn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 04:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600330156;
        bh=qa61IQkA0HxTUyHHcS84ta5IRfRjK5AdsDnrMTAWeP0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RdEVvnQ16ReF78IDPmaqN+QxRnnVs2MMbOrZcG1g/QtRNw0KyO+sr1RE7GOxLOCo6
         qoNNJtQNVPQV5iPGqwiutUfihZrsqMxydli5nQztCmH8Lik10FWlcPCFLn2sjeqOIQ
         ohdfLkpsNfHQ5Fj9hTe1b6c5uIxqRAhVqjG3txng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1kj7Gj22qH-00iUVC; Thu, 17
 Sep 2020 10:02:41 +0200
Subject: Re: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-5-wqu@suse.com> <20200916160115.GN1791@twin.jikos.cz>
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
Message-ID: <e5a6d6a4-93b7-9845-5448-ac56ecf97075@gmx.com>
Date:   Thu, 17 Sep 2020 16:02:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916160115.GN1791@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AGtanVCExu6IZSyPTih2f1lxS7Y2NkmjD"
X-Provags-ID: V03:K1:Dglamnc0n0qkXPShYU3budSNu9bjeiq/wDVKzfB3CjjFtc6XQTz
 9vYD6zPhCxARbV6JJKXAQrwIVdsLdydLVz3r54vHL3w0+/iTVdojlXhM0tKVAH6Yc5AZWud
 BXhHgeDj05ElaUvlQ6o+U8RWQSmXiC7Yr5MsZk1KOnP8jclVFIPMhiJZ5xkyCW3snQc53m8
 NAFzzAaR73YeyDSBQ/EFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5dPyHFibE0=:JJbGrZcgXzB2gpeCltKvI+
 8lFah78RTwTg9HYv8C7jhE55T/itJyzIlpti1ywvaqR7+Nd0CXeJOOU4e1h4CY0YmserFSmw6
 gzfL2GemoTd5L4e0pUhu88xwNAjG4bKrA5c5AQZJ2bhpcqjAtsjb7+s9eANz4DbPnuoslfV4l
 nk4IKkg98uTozJLlCQenr3WxDeiOvGG4hsy4G/NKYIhUhzkOF88Kny/ow0oE1cIAA5Pn6E9mp
 wpxRBenKhjQ8VLxe5kbtZ4lvqrM7pW1NxOMk4CoEYxmHv5RdOAsBC9/14ez83ldSAQ7zeey74
 mjCs3MBf0ZXPD0nMo74HUA6FdAGCnfu7NJoRkwy2hqxng4gHrXclTOEq0IIb9d96gIo2pXy6+
 /n3O5mV7HH8qgp+rP202zD4gR6oVD8w/FfO6CScu566lrMzjw5wwnKDtxhSY2ZErlXZt/j0Hy
 0uKKa68nlOWvlUa/BATTFPkNpi0BHeYRntCKORQwH2raMdmymQd683h/nGjPYa9j7MChRzyfP
 iF+z89v8jAM3qDjXnDvVHPWY/u2RprwfftgBFZxobkyRcuP8XC40s8Jx7TavZADJTIXBCCyFw
 d8r3k1B+pqosWCxhO/F6Oe4wgGXWMBaM5ozle1ny+Tm1IQjod6ZvUhAyJ++oVJkYdd5eAGlAB
 cojPdan2f4n7l2VcBD4960hK/AQ0En1Tu/Z02FGccQzL30bTxnAdxbMNleqZdkjRfbGjaZC7G
 dxok5Pg3liHu4ooLJAZ7M1L+a1m1nJL3z/NR6S/FWRZOAGsTe9uBcm6Fz0WRMxvH6xhklbo9/
 r3rSOEXIDqbr/kLhBZoOgMMTUK2L7VWQUG+LX16hKcLb715udZLtu3hOWUWB/CnSiu7Tad9AF
 ggjmpGqXlO36G+8Vpn1FJmwKj0qUIgUDSFNVD8274BJb6/BQdwbFyNKd3ArkXKvnMPiYtSIrB
 5+tsrgcX0HTvx9yagSPcCck6GKCXInRkPcvAcwzgiVqCSsK7rg3A7DpQLYDiTvQhmnpGyejxI
 lfu327zqmAZ2c9iSystqbD7PyzDPgWdpRL4/CE07BOd9mAJ0G1IbFeChVO6TKzzoSbKPn2Gf8
 L8nBXzez0s7n30ygyIm8cjl7MWtC2MPg3TmfOYhDHLDmypH416NyTKgjgE+ue/VO2PY0Dg0I8
 tk63YHYa74gOq9MUHgwglIC3l187z3q48+l88ROJTiEKBxGCnij8GHuNso2yLHC0UvD8BlKOO
 60zZVn99HbaIL+Ed3dCrGrnXU6ApPsw6Bt5rIgA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGtanVCExu6IZSyPTih2f1lxS7Y2NkmjD
Content-Type: multipart/mixed; boundary="fXpkFiBojmvVLGkPlMXVaUln8kIOtBQVD"

--fXpkFiBojmvVLGkPlMXVaUln8kIOtBQVD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/17 =E4=B8=8A=E5=8D=8812:01, David Sterba wrote:
> On Tue, Sep 15, 2020 at 01:35:17PM +0800, Qu Wenruo wrote:
>> generic_bin_search() distinguishes between reading a key which doesn't=

>> cross a page and one which does. However this distinction is not
>> necessary since read_extent_buffer handles both cases transparently.
>>
>> Just use read_extent_buffer to streamline the code.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/ctree.c | 13 ++-----------
>>  1 file changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index cd1cd673bc0b..e204e1320745 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -1697,7 +1697,6 @@ static noinline int generic_bin_search(struct ex=
tent_buffer *eb,
>>  	}
>> =20
>>  	while (low < high) {
>> -		unsigned long oip;
>>  		unsigned long offset;
>>  		struct btrfs_disk_key *tmp;
>>  		struct btrfs_disk_key unaligned;
>> @@ -1705,17 +1704,9 @@ static noinline int generic_bin_search(struct e=
xtent_buffer *eb,
>> =20
>>  		mid =3D (low + high) / 2;
>>  		offset =3D p + mid * item_size;
>> -		oip =3D offset_in_page(offset);
>> =20
>> -		if (oip + key_size <=3D PAGE_SIZE) {
>> -			const unsigned long idx =3D offset >> PAGE_SHIFT;
>> -			char *kaddr =3D page_address(eb->pages[idx]);
>> -
>> -			tmp =3D (struct btrfs_disk_key *)(kaddr + oip);
>> -		} else {
>> -			read_extent_buffer(eb, &unaligned, offset, key_size);
>> -			tmp =3D &unaligned;
>> -		}
>> +		read_extent_buffer(eb, &unaligned, offset, key_size);
>> +		tmp =3D &unaligned;
>=20
> Reading from the first page is a performance optimization on systems
> with 4K pages, ie. the majority. I'm not in favor removing it just to
> make the code look nicer.
>=20

For 4K system, with the optimization it only saves one
read_extent_buffer() call cost.

In read_extent_buffer() it's still doing the same thing.

Or we will need to manually call get_eb_page_offset() here to make it
work for subpage.

I wonder if it really worthy.

Thanks,
Qu


--fXpkFiBojmvVLGkPlMXVaUln8kIOtBQVD--

--AGtanVCExu6IZSyPTih2f1lxS7Y2NkmjD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9jGB0ACgkQwj2R86El
/qjdsQf8D8akp1rmb7GIzyE5B1C9HDhEXcVzHSy0JzZ86lVqZvIKTveEqv5cOuZ+
Oj6oCfKid6fSItTDsxl6DAvNxlfxOi4wGkK4173UHM9P/0h69BsC2Q4OC1nPKBNy
Xv9kL0DtWOOvKyW395UjC8rBCIZ+x5FDQcybF49XGk0x3X2POA6coEYhaB3+CC19
v5f/tRdj5BY+uLK2R0vVVZcfFZfVOnVaFHtBxOUoH0c1OiKcd2Wwj2t13AnnqtOG
3FEQLpXE2y1F6H10u7aRVbxh+/mh8ga2DfzzZpzIFpzpfacWgxBsY8fKD0veRGii
7edVy6ZgP9BToMrtOTCNClqXlN4MDQ==
=67Vd
-----END PGP SIGNATURE-----

--AGtanVCExu6IZSyPTih2f1lxS7Y2NkmjD--
