Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287B22AC9E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 01:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbgKJAxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 19:53:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:57233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJAxY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 19:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604969599;
        bh=7XUOY40ZbtDB4AHmIN7qW3oWXT0NvQSShoNLrN9foRI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GioPM1UFhKQ7fKVQMBB5auYrAzLHE58SxVvk1qBFjAQL9G0uu7MoLELmisBv5fHDI
         ni1tFIw/fdC5PlBwUB0hum4A459vzr6aub8ksb1/9eMzpty7nEXG9SzSinKlnTv9BY
         oQCsSO6IbXObFq2MB34k1YNK19R1rDnkLAcRDYQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1kz3YB41tV-00NTNB; Tue, 10
 Nov 2020 01:53:19 +0100
Subject: Re: [PATCH 27/32] btrfs: scrub: use flexible array for
 scrub_page::csums
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-28-wqu@suse.com> <20201109174449.GZ6756@twin.jikos.cz>
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
Message-ID: <35ae2a3c-5c98-4f78-cc88-ad0dbea93d32@gmx.com>
Date:   Tue, 10 Nov 2020 08:53:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109174449.GZ6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YmwkB0Lt9nDzi7aqiAjaf9mzU15Spkz4f"
X-Provags-ID: V03:K1:Eie+ylaYez9tpnuSvEsw7pZzwd0iInD+HxhDPOl2pJD6G6G9xrr
 0ROTN7znBaXp1C5yAc1Q7HKXm8SrXee1xVZUkJufV21MCZNpBkHJ6akL/FEfYecnX9+8g4q
 kj16fg6OAJnCMBchFSy/KBBnAlm8R1d3toeGhkUGcuoTTRb4pVsu3Ym/S7nvVAkIOFScIfP
 6esw3PuvYXkkvsjqiNHIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EFzyB/C6aMI=:iHfmalal6q7x2yqUisw4PN
 pOjZMMrB0zqsqXb5XJsIld1TdE/vzo93v/lqcI5lzbKrhY9RKlTNlgaa+MIgV0//Txxve411T
 OPA3LhypjbTE8A8vJ7re3b4mDjgqaEOuQY+5c/IaDpQXFp3lLCk9rR3xIAYzHTFWw/A5WTrGG
 rvlr8xWsq4iecHXivxzu/vqjGxTex00kARNsglE3h3ulx+CyV7kB3JFi4PyfNPZbBbrmF6KMs
 VRaJjyZYtxtWpCQ6O2G53wi4jY2ed8T+y6ykntskT7Z9iZ38sbLKFpauJ50K5UoYPmJvRTE0w
 A1cbGoFqGHISSVDC6e1T/0lJNj77oOrlUhF+HuJbd5HgWdi6TkJrHZmhMu/PldJf15x2P78Rj
 c+Rgi5NrrHbLQ3vUG0DaG3mG+nIm3T6Bn3jWzDXv9EPTDkgONK+aujuejvnLj8XBJrbMAIYg4
 2NNBI6qZuS6dDfvB9X1BzV5I5a2tIyMWLjmOCYCGSnr3h5jPuJVzJABgOXEUgIuA36CH9CELY
 XpfFeKLyKVkcfQVJW9rViXORgRlNSfY+fYAL/ZrMW7T6jboK5NfLo2xFTz+WU7DKpsGh5tYdI
 sKIVXdqiCTWWWfgC9m1cZi8a9yddtq0+BtlN2JH7WiFnbjU4WNEBTsg1R3aS+1dBGekBSOOVy
 zejEmwcEJEBQb0si/oUFXXj+uPyLQcMvPkMgc3/OHc4EuIhY9YJeGHmKyXRNFoqS2+36X8SVh
 kn4YDdUipdW1BwgpLuCM8/w/t7HdHYoDR2v6l8rCLR1ZfdimyDzBRsUwj8oQlVxAcHKQWoO5J
 +3WtOJnYnw9S/hHRX4XEphQnUbDH9ysrOzlfgVrgytfEOKbg4orBWK+PjAD5exnuplk2w871G
 4MF5+38pWmPUnwqkWJLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YmwkB0Lt9nDzi7aqiAjaf9mzU15Spkz4f
Content-Type: multipart/mixed; boundary="dD689Xz5Kq0X6xngqXiodhiooPScxkCc8"

--dD689Xz5Kq0X6xngqXiodhiooPScxkCc8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/10 =E4=B8=8A=E5=8D=881:44, David Sterba wrote:
> On Tue, Nov 03, 2020 at 09:31:03PM +0800, Qu Wenruo wrote:
>> There are several factors affecting how many checksum bytes are needed=

>> for one scrub_page:
>>
>> - Sector size and page size
>>   For subpage case, one page can contain several sectors, thus the csu=
m
>>   size will differ.
>>
>> - Checksum size
>>   Since btrfs supports different csum size now, which can vary from 4
>>   bytes for CRC32 to 32 bytes for SHA256.
>>
>> So instead of using fixed BTRFS_CSUM_SIZE, now use flexible array for
>> scrub_page::csums, and determine the size at scrub_page allocation tim=
e.
>>
>> This does not only provide the basis for later subpage scrub support,
>=20
> I'd like to know more how this would help for the subpage support.

For the future, if we utilize the full page for scrub (other than
current only use sector size of the page content), we could benefit from
the flexible array.

E.g. 4K sector size, 64K page size, SHA256 csum.
For one full 64K page, it can contain 16 sectors, and each sector need
full 32 bytes for csum.
Making it to 512 bytes, which is definitely not supported by current code=
=2E

But that's in the future, as current subpage scrub still uses at most
BTRFS_CSUM_SIZE for each scrub_page.

>=20
>> but also reduce the memory usage for default btrfs on x86_64.
>> As the default CRC32 only uses 4 bytes, thus we can save 28 bytes for
>> each scrub page.
>=20
> Because even with the flexible array, the allocation is from the generi=
c
> slabs and scrub_page is now 128 bytes, so saving 28 bytes won't make an=
y
> difference.
>=20
OK, I could discard the patch for now.

Thanks,
Qu


--dD689Xz5Kq0X6xngqXiodhiooPScxkCc8--

--YmwkB0Lt9nDzi7aqiAjaf9mzU15Spkz4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+p5HsACgkQwj2R86El
/qhcpAf/W0pbCEPBjA658mC+Uht4uBbpIEBpZqjVCLu3qN//cFBycpDg/Gu5j0DC
1cxM+2bvrrCyecOMxLFTKuSxkSixBSkF7MsuZIUhsRrCHQRQR4sbZSmOKrX/Ypp9
Gys0dV6AYrw6+feR/6ta1xvNSnvbKVER2EwGuKw5zNEOhNue5Dl5n1Iprabaej/+
STZ9CaEHu+pspCL/BF9xwtoqBa3rX6eNtsbD9apL1tfXq1pxTJUQkIG0TTjpLZtu
XgMDnsjNDR2Y5PL8MNhoN71nL5astSrL/e1xMYVOTR4DN2zX0hyrw7Aj2SpBOavZ
3/ABcLhQKKhjFJtEoxZr/RSeNPcWHw==
=b253
-----END PGP SIGNATURE-----

--YmwkB0Lt9nDzi7aqiAjaf9mzU15Spkz4f--
