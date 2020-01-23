Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D473147520
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAWX6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 18:58:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:41005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgAWX6x (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 18:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579823926;
        bh=sbWiKjNY3ZtYcRdPctNdqLl9QjAF1UtjVA0gQl8vtLY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JgGvj0YRLSDDjmbRg3M9QNNDSjGB0LZYSrBM7DPFmeeXThofBc7gsomly98Fo/4Ez
         Hq699AYE1T6fUpmiv2qq0klsZ52NwwqCkneon21AAd/QVUdFKtZfKQQStwowz/o1Ly
         ELmZBnIDcP1o0RxziWsf7e57IzFUZTLtL/V1ThIw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf0U-1jKjFk08AM-00ioaU; Fri, 24
 Jan 2020 00:58:46 +0100
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200123073759.23535-1-wqu@suse.com>
 <20200123164043.GE3929@twin.jikos.cz>
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
Message-ID: <f838517d-c4fb-32ce-3bd7-ae4d0d547ad7@gmx.com>
Date:   Fri, 24 Jan 2020 07:58:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123164043.GE3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SUxNEVF1ufqXh9rMxljRoQImeQJ8YqHsd"
X-Provags-ID: V03:K1:5v/Z/rWxEIk9/LE1MMrqC6mJYsOwqN7+31YCcEstFrkbKOR6N4Y
 gplB9wg+CVf5AoRxPNJa6+q1wevSbl6i9+wAF/CF1fKeyZLkFGjIDKWqzWphA2IzbLADTXn
 HwrwiyxKwjQ8pGvWLhIuMvvzbQJ94xBN1pllNmAwv3Q5i03poL2xZKLwj4BZ0Vc1NyOZ42S
 ndL/3LWtHqyZY590Awx4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2SXETbBUBzQ=:jlE5F/rCTilrAmYb+zvszs
 mpI2klSh/1brnZv2gcuvzjnx4aOrEUA+OJsxVH74ESasXRXfsk1aHiDQ4acaS6K6wUwxMjvVR
 P7YukNqeeoH8KPnI31uGL06DVhYaZjKewHRJRsvw1vjCL3+1x4VGh42i/3APznY84IrrbP7eY
 C6si7wO9p/Hj/I7O7AhTlyXoMnE/M0HtFr4TpCx3EFxXoF8OoZf+tF5wsxeGMpoy0t09bEdMS
 MjWSzV4PGhDL/th6EFUGoiF2FKlu8MPeQrpHAkRyaGQonKZxaHYJ/CLB2HAvc8/I6nV2DnDBE
 cmzie+UTC2Xjwaend7iCwUOEG8hWSZOFD5+JkIo2ZGjOxZaB2XbQviSyYoOLmoUL5ahUy3eHZ
 3vRRJLa4+fzVwATxaYfw74m0Qaxry8a5qgoK8/zQ5ciCtVYCRONimAup9YdipwlV0HPqRNk2+
 Cwy0fT/w5kufi5nFza935A7W9w1XXmoo+IPtP10UOA43J0iIXOTLF7paOuKWDoMQgsSBeEWPi
 ahckWUPhnIVQGgO6qJdy3iaC/z1zeUT5Zw6aDAwBaPzkslhBc5fxa9jKl0pwNKrknaWw090FC
 4BnQ74CUwpF1Hn6uILC67sw13kL0/n2gnY4lw/zimlv9gZhy4reI2K590I/EvoERpyYiJyksY
 pyRUIe79dy6xBoSZTQuRkKpsJ1dUFWZ/xx380VHk+j1V3gXCT0v8xpmw1pGXInhcqGqlwChSr
 gZ1oIso/uYxhWDt9mOsBTizEnBheC+mgF77XwGQWx+zW88czzDz725nrsVZDq9WXwfc8lxWAu
 nVvYCyS143FT8RyyuMjPBehVaB7w8MH0SrMwNIvvH0Tfs4je5+redT2Y+z3yllAJvmapw+wxY
 PEG2S/6K7z4TXS+YSMuQwUo+p+FMV2p+OPPth8bSYRYhGShE9AefY4Tb3mjJq5kA2n89XRxqs
 0/hErZUrbGbTNkDMJREmWnmjpnVe7oFkkY4A9sHttYOq9G+ZdimSX0xkc7IgZ0+ZcB+K2vcCJ
 3nShhWODflzd3szwKixZQbt1BLoLChvFnRxzuCJm/0GUb1Gp9g+/YG3jPrwoxgbexmRS+9XoW
 NJWRA/k3u6PNq7AkV1y6LB7FSXk7Cc3Z2Q3xH0ahFtAuRxxWSkK2Y+sDg6W+7uekHUD5YBdRk
 LNSILLF89vVK/De9aRUbLgGq8P27Q90GFypA626+AXlCZG/FBdOIeojn+9Bh0yVL14iztFLRu
 cpc7TYv7YgzymFmg7
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUxNEVF1ufqXh9rMxljRoQImeQJ8YqHsd
Content-Type: multipart/mixed; boundary="e2pL7KeWTA6Hn8HtlaZTSrABW6KPjH8VL"

--e2pL7KeWTA6Hn8HtlaZTSrABW6KPjH8VL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/24 =E4=B8=8A=E5=8D=8812:40, David Sterba wrote:
> On Thu, Jan 23, 2020 at 03:37:59PM +0800, Qu Wenruo wrote:
>>
>> Reported-by: Filipe Manana <fdmanana@suse.com>
>> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed=
")
>> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before mark=
ing a block group RO")
>=20
> This one is in the 5.5-rc, so I'd like to get it to the final release. =
I
> haven't read the discussion properly so please let me know if the patch=

> needs another round or fixups I can do. Time for the pull request is in=

> a day (2 at most as it's too close to the release) but given the type o=
f
> fix it's justified. Thanks.
>=20
The v2 version has Cced to you (and the mail list).

Thanks,
Qu


--e2pL7KeWTA6Hn8HtlaZTSrABW6KPjH8VL--

--SUxNEVF1ufqXh9rMxljRoQImeQJ8YqHsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4qMzIACgkQwj2R86El
/qjVZwf+MMFK+FCHs0CnvCQJiZqv+oTbAGdfNRViOzxtV07ceRg2RrKd6G6y0J7V
ND7i0K4G44d59c3jwADjZmdCbjgCPqPwoKwVJvAXMjcBFNh5k0BMvuy7ElXG2R1g
316uA90xCofOWwnZ87ip3WQknDSbSnhGsTmXrPhr3O/yIiSK9X4qUdx66AiWoS/i
gBq3zvUffNxir3ppbq/8avu8SdFv18wK1K40uKS+bo7VBdZ6kp2Oeno88mTqqipD
ABZXccFHRMTYD2sp+Ft+H1PZE3pP/K17WIrkz7A2TjRCM2HQhHy35mMjfgqLLFSG
6tgpo2ehpD3Uh4ctEYbTdQiephkcpg==
=JqaO
-----END PGP SIGNATURE-----

--SUxNEVF1ufqXh9rMxljRoQImeQJ8YqHsd--
