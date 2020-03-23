Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD31901C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 00:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCWXP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 19:15:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:58465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXP5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 19:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585005351;
        bh=DGFLRPD88Dr6RU0SM8hO16iEZy1mHrYcLKEPmSokG94=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=g0bB+CsobZPPhceoiMbQSyniqwiE+XbxE1hyEKrJN4/BSo5hLxYg42ivG7GMYgiUY
         gSgvMT04EBABlh1y+kV2B2N3oQlttOg7pzMbpBB8IRzw38Wj+5Qod0ONKW3hiAs8O/
         +oR/2GAbeMt2ZlRfo6SqI/h+cyUdFrEjuqa9CMNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dwd-1jLrvf3mYH-015W9L; Tue, 24
 Mar 2020 00:15:51 +0100
Subject: Re: [PATCH] btrfs-progs: check/lowmem: Fix a false alert caused by
 hole beyond isize check
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200321010303.124708-1-wqu@suse.com>
 <20200323193826.GN12659@twin.jikos.cz>
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
Message-ID: <23f1c445-8a0d-b0b4-a557-51e602d58db7@gmx.com>
Date:   Tue, 24 Mar 2020 07:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323193826.GN12659@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mu9EXvutNesGO9W1IqlWyijJNpiBJDNG5"
X-Provags-ID: V03:K1:C3l9x/S9XRBaBA5CxsgF7zllMktBk/RPr8k3Zs061wzdOvlFRAY
 PLQcUrJ5925g4VG8gMtRpHrrBx4xqFmPfwouMUju/bpDb4mgzrc+uI7VfA1/S4STIhyj1GX
 kPjrl3uP6K84ZJXHHGuYrarkAG2ZxJ0sZ7fwL9J+vIjtnCduYQmOCJBCWjQNd+ubmU3n8xF
 FFCUw7VB7PCqJnf2cMDeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wakHYvhjg48=:gMo1TenIyTn2QTgklMN25x
 6Cacs+uQAFWss0dlHK3Cim/uFGUlJN5ObXe3B12jLcU2cXxnJpnhmIyAaZ7I7G6X9VDDz2IyK
 a8+scJS5x+PLQok8dsJ18pSKttUHVfc1DRAv1vGhX8DNnKy4GvxUp2cwWQSancwIuYS1L5ivp
 CBPfI1WFTVczkvl/Vjlz6rBwD1kVgM+xccCeyh1SFWVRT0ewM6MsQsLqiTq+c4l1mhMSxNXVv
 MSm6Q6bTLq1rFD62P59HhnswO3Fo9hCEcjw1qgYRl/aodfABWVa7oLjXwwtHi3BVpG0ht0rIW
 u5ePt5NjylKLcA23atS2nzN0dsXBD72syyrHNpd86LnPbpLSek+wIu3t2rXuHPqWbD7A3Ss3Z
 b5Gggy7fr+A6ch8oh7NMegD7wG18gqVOL+C2HYLw+HaobnTcQMa80qCRKGWmLRp0ndhjcj2/A
 JOQykVzWxCJRZ0/f5KqUtbSiSXdwFzUlzmA1vb3ksPli8QMrM08HB26xKVNSUzyaVkfqA+L/T
 p2EFqMDz9++Wqe4jpfNizDcj3QOqahlmSsmw7LrxBEK2R5zx/QiCphGJaka+LmAXpsCq3B8Oy
 DBbENXI7O8pFxNRmT5bWYUfkWf5Ns12hoqWjkWKhJSOn0d4z1aW3ziB7mt1UOoszs8nqPpZsC
 r6r60ss1p+t2uToEUZPo/mHgCGi5PrZ0/4vFovyFvM7HkrhCVjszmbkycBd1bKesLOtNOyLXD
 46sAwZB11JE+PH4lsMauALNXBD8Yf3Yc0dAXUBX1bW4EqjbYWs0sNqlSBDHHjwenA7H1kuZ2y
 /8hbcFYwuVJyCSF2PZ0+Yrk3pDW2zxLuMbTAZnZOgHKDUFFeBBvNIQAhVi1Qf3Zyoe7YjLt93
 oQSEUCYSfgF1u89jtZGd2W+KsVO3/KnEGbR2Xsx8SA6JBuALZzbWymvULfPm9hzMKYqMKiLyz
 7Dc7Wu0u/D1+y3Q/6zilhL3Ozovux8fbQ0Xx8blp6X/X3nhlkxkZaTcSKssHGJj6BeDCQxYrP
 8bpZJe1VpPvQPPNvaf70hamtzmW9sgDupG43wLsj0uxtL/RlWDceVvKmNDqRVUrax4vdG6g0P
 lCQC1Zhaa59Hvh99jrSyxKuurAULcGyndg5ar/kiTyF3BOWB46p+p/rgatwswS3bXmZWhKVqw
 fLZ7U+jRxgQYrRfA8n2m/lVEXBotKe9QlO2/bT/7Oz6axSLwCNQN8rUt9SK/bT5ioYrBm7cxx
 Kiz1f0r5BVXQCqvqV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mu9EXvutNesGO9W1IqlWyijJNpiBJDNG5
Content-Type: multipart/mixed; boundary="eAFv5GbzsZt0yAZJmc8HBS4yckuPiVwGr"

--eAFv5GbzsZt0yAZJmc8HBS4yckuPiVwGr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/24 =E4=B8=8A=E5=8D=883:38, David Sterba wrote:
> On Sat, Mar 21, 2020 at 09:03:03AM +0800, Qu Wenruo wrote:
>> Commit 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of
>> holes") makes lowmem mode check to skip hole detection after isize.
>>
>> However it also skipped the extent end update if the extent ends just =
at
>> isize.
>>
>> This caused fsck-test/001 to fail with false hole error report.
>>
>> Fix it by updating the @end parameter if we have an extent ends at ino=
de
>> size.
>>
>> Fixes: 91a12c0ddb00 ("btrfs-progs: fix lowmem check's handling of hole=
s")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> David, please fold the fix into the original patch.
>=20
> Folded, thanks for the fix. The lowmem mode tests still don't pass for
> me, have been failing since 5.1. I've now added a make target for it so=

> it's easier to run them without setting up the env variables.
>=20

Mind to provide the fsck-test-result.txt for me to further investigate
the problem?

Thanks,
Qu


--eAFv5GbzsZt0yAZJmc8HBS4yckuPiVwGr--

--Mu9EXvutNesGO9W1IqlWyijJNpiBJDNG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl55QyMACgkQwj2R86El
/qh3jgf7BSGJPwIkUW6SyTi0XLCnqX+RiB4IfQukxeKdNm1mgjyA8sgrYmTpjZKw
o3OCtuC3H6nviZ4Fhf06hh3qQ4JEjd8sa1f17VgCN1nH3fEqc5luhjK4xQLBDtEX
852ArFzvv+PV5+0/T1kbwtocLcU6ouibKSIU1AE2Gr7k2UyOIa5CU++fFTuKptc9
sR7Hxsg1y2OkKT3iz+lNlpTKn85iImMFnpCivwLthiT+XeGroDUhmHR7nIFhVMw7
PaEjilwXVt8rgSg6F9NhmvK9UVVq0f+hEVHSgHmMD+pJDxWJqiwGSH2jVTOwO6tX
wgU6TGp/mcwyIOOvsEs+P3igJEEaPg==
=ymX+
-----END PGP SIGNATURE-----

--Mu9EXvutNesGO9W1IqlWyijJNpiBJDNG5--
