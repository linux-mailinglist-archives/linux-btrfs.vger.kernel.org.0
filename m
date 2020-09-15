Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444926A2BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIOKHl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:07:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:41619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOKHf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600164450;
        bh=MNJqGD5nhFUh47kCkgrjnjqFJoyOE7SZhlQgu9fZjuY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lMEpCcVEPv02PVbsecr2Skz51+Fcm8s9QfImmDJIIpH6e0Xq8o05j6xh4ArF4I51i
         HT/5dhdOuCT8qA3MXNMgoRVeMvHCu4BuCzd8rvdpwbKD2M6PFsKkWeDLbCCZkAm5tc
         /njPInJtQ89Z0Y3u1CLVsCDooCETjMLVVXtUDdpk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1jyy9j2t6w-00Xc4p; Tue, 15
 Sep 2020 12:07:30 +0200
Subject: Re: [PATCH v2 07/19] btrfs: update num_extent_pages() to support
 subpage sized extent buffer
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-8-wqu@suse.com>
 <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
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
Message-ID: <56c0c885-fb75-36d3-00de-202ea53b1b0b@gmx.com>
Date:   Tue, 15 Sep 2020 18:07:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <DM5PR0401MB3591309523CD789D48387C8B9B200@DM5PR0401MB3591.namprd04.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3fzIuSauCBmPd09e1Jc89lSqQjej3uTNo"
X-Provags-ID: V03:K1:6ld0ldt17ErhnoAITsiUnTaGzH/HO8BmmNMvF3NXKw/9OuTZPLO
 IcjD3iKJyOE7w1N4E5pesfBkDbqrfdBn+UF38MsKVJK9ktY0yNYzFQlEPHtnDFw/biAFDJx
 wc/y2X9jO3RQ4dPgFEaE/AmEBFTpUMDmzZtPLh0F984jhMh49efWm506B10PvlmUnzlxNJe
 1E8jBP0Zqj2jgXxei/ocA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nG79zx8lwog=:mcYxghgLudTSH5Rdsqm+Fj
 wH8JFiHoPD17WM2D2Zeuu9JdH4lpWvlwr1KMIwEU/vxsz/danBmYMH3QSXCFTGygppnMozhYg
 4KDpTwozZu+ssV1wIwSpalvfptGu/Bx7EZ5auVhdzz/aRwhz7DajzH8vJDv8XPsqHvA4paYpR
 QbtXo7KJasFBmOhzQXJi88j8aomQMBYsvFeH36W5HA0wFfMYU3kbS9dIKi6i1EL1tnbHdUu0H
 r80sqYQQlt2YR57UzvRbJah9xP+vSHuItVkQcKsnKe3/jxgeeA49tpz7Nj6lQb6fqLVP+Mk7m
 7pYh4UAFcFdjV7EyLfO5M0Zr4tF9w6BjjBJqckcJcbV+kqyhxj9/y7IDL0rCGiESpczroU05m
 ywhdQkzF1BWzf3foWidI1jCMZotBJylx98U+E3tPANZtHjZ9wCgRCPIw3jNkINyxOhQMrKIz5
 HyOCL63od9agNyiziqlfLITzFIlmtnAVMMeqQiCoaijZF8QWJFxS3OfmKoDUDUCOQiVC7hmzD
 cqDhsctt/Br1eTbKPRKuzC7vCuXwfcle9RBFc9ARXnKbep4oZMB+ZyihxYYncW8cSZ1+D0mGd
 LYl6jxn5JXBwr6G6SSbtVZKlPOk0KrSSEFilLFdPyb//aoFs7u5mxVB+NaTS+Ep7DjR1gviQv
 Iedvjahw6Pg7FoQqUmoHwfkymRrI+YZCq9dJmcTc06/HFA54FuvrTNct4sdm/r6w4HgOWXFDk
 FvE5OnB3VydBgjEZbrD4stqj+EDhsjpQ3KS3eqodY80nsfIyb5Ik/s0tnlPrL4PpiiytMRhGN
 6Ddsub5BBqzt+WIkSu8LGaVPKeKSSMlUsC8+xQDrLfrpIT7ih80ByUaH1gU1mzfrvZ7S99PAe
 6hzpAjb+LrwL4NchomGv4oRsFUnxXWgPYD2u82O30Ap04QcZhKlq/fiDLWyFlaPMzCoQHE4T0
 homGfliUHD7IS7jdKw8UOKD0nEiRs1HhSsv4ntjJkwxHhchOMScf+A21yLDOKY6sxP49ty5HY
 KkYmihwEHE4W5tP/ARLdFOEjWzYOjj/mJbhAfaoyOVexTwbjOaRyuLV+DPnaTtWVDUbA7jwlU
 H0AU2+Olaa6qWnQocIuw3oJd/+fFEOULSqsSv3Uys8zwJaEefGRFOkAQrzykBHkUOtDL26Mfx
 5t2fg4fgyKKYU58NZtADSFK0O2moVUxyTw57rCw8miQIE+pd60jYFuI/Hv0brOPOEdNHloj1f
 m38Szem6MsipbkBKjou0F8vftU90YBh0v/qH36g==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3fzIuSauCBmPd09e1Jc89lSqQjej3uTNo
Content-Type: multipart/mixed; boundary="VeqYIhLWcBzbATeKJw7QUf1V6bGHOAi37"

--VeqYIhLWcBzbATeKJw7QUf1V6bGHOAi37
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/15 =E4=B8=8B=E5=8D=884:42, Johannes Thumshirn wrote:
> On 15/09/2020 07:36, Qu Wenruo wrote:
>> +	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
>> +	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.=

>> +	 * So in that case we always got 1 page.
>=20
> Just to clarify, does this mean we won't support 512B sector size with =
4K pages?
>=20
At least that's why I have planned.

I think the current minimal 4K sector size is pretty reasonable.

Thanks,
Qu


--VeqYIhLWcBzbATeKJw7QUf1V6bGHOAi37--

--3fzIuSauCBmPd09e1Jc89lSqQjej3uTNo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9gkl4ACgkQwj2R86El
/qj4CAf/dFDxJ7xkp1cNpBQw68AUAReu97XVIsQRa1k/vYaRAK3YXCBJ09VrPorU
93DBvapeHiaj1YmBBwY/ANtfrOkBaquvlM9gybKWLsHFNF9sm/89gA1KxBtPbC3G
Zp998R+/KvYyAQJ8wP/aZdV5zJpBCE1fIkw7yQ83OB/8qFM20j8oTyIsaDPsLccS
JpapGAqmUzg0i0iig1voJrv8C9UpQoJV38fkpb0Z5EfbF2c6S+nDdsWGLyJmAVRj
Wdp94hIvGRf9TQ4fJSfrow3uw2OHCedGTQSBkRSZQUeK31fLKhfi6Pat36DqNRB3
a7NTT3njIERAcmMK1LRhDlovh2UDEw==
=rJPa
-----END PGP SIGNATURE-----

--3fzIuSauCBmPd09e1Jc89lSqQjej3uTNo--
