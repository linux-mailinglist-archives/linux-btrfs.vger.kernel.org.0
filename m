Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7E172CDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 01:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgB1APa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 19:15:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:59393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730009AbgB1APa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 19:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582848923;
        bh=hGwiqx6o+rEc8k+BQbjyDV3qxd3OJIF1igrf1lNdk8g=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aOhn/qcmVZYjI6fNjIjmSng9/kDvCoKjOo2q6r4frAc8W9YwGz74Qoh1UE8h4yErH
         u8SJ51RsXsDaBgXzhbQ4RG7FJiCWFiswHlkZMEjnfYwPtiP9uqCWgU32t/SAwAiixP
         ltYZLez92KGU4iBTdtJOd1HDU301G6c+1hfFqMnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1iqcsi0Dnn-00IVED; Fri, 28
 Feb 2020 01:15:23 +0100
Subject: Re: [PATCH 3/3] btrfs: relocation: Remove the open-coded goto loop
 for breadth-first search
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200224060200.31323-1-wqu@suse.com>
 <20200224060200.31323-4-wqu@suse.com>
 <72797bb0-b20c-3e80-6a15-131e33c9bd26@toxicpanda.com>
 <013d9b26-d7b8-bc81-6d5b-1585924af4df@gmx.com>
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
Message-ID: <c6295678-d999-b93a-2350-de58a1951a89@gmx.com>
Date:   Fri, 28 Feb 2020 08:15:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <013d9b26-d7b8-bc81-6d5b-1585924af4df@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NFd2t2UogYmFSlXKK4RauvYFQ61OPAlnK"
X-Provags-ID: V03:K1:ZPRD4eWTzqkehV0s3vZDLFxbzVXQlBYkrdD2tfVCaT/nJ7t/EK1
 E6FldwjFD8bkeP/p8+xnIjgkym85+bh2Lv+wVy4oXH64HDGaYDaIvQLD2lPboeAbtDih55x
 /mECv+ER6e+OQfIUXHvi+0xSnKxsYVB3rL7zcErXs9YggOA+mMomLRdoqHUOfqlxC4clTym
 WCUcJw3rRPx7QMFl8tFPA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRcmLMOJ2pQ=:lrCcGbnhrzbGbgUty+wEtO
 LrAQ81JBIu+MRRjoejksusuIrlyseRpQe3c2/UN4ATtL/6YW++qgkZTg1jTMTE7VXp3AIfkBA
 c/SXYmwpiv6Vb7gd0+9zhaxvF0Vdwbus/XawUGPFOD79W63Nnk5l82sNtypQpM4Qb1KqoHoCT
 GkUYgTaggE8CipcdiI6Gs8G/D4pXMrvh/QCHHYRLeIOp7UzC1HbKCco+qfzBOZlIc3RfF+yUj
 LL9z/00yhFXKfMDu34QC/6qMyQ3Dsf9XDzhN7K4504au2dIzDMS6HD78hP/FX8OWzwvoOrG7c
 TvbGm0vGprUKRSGpNq83rUzA7udVqdmqaEKr/x0zj1s5xJ77zslMsdQn3g0jMPuWxX/yXkD0p
 G+lnUXJP4CYaJ8sGox/DlChDtx9M5/+JMzh6cw+GUoZe3AR2CV92W4I7s+3OJwqVKaKEvWvGp
 TQlqj51+nDNQDUvRvNrE0GVI65uIELvwelHpah0KAWEggugkMTjvd0fnunz0vWVxJOdbGRKtn
 ANwEv0gpfRWF8ZSo1TvWGGZV4NOb6uHzVyUtgPwWAG1B34/i8PtxTlOxoI18PQRJPaXe0KQKo
 eCY5hg5Xsv4BDJLQZoYGNq/2C4mY53UKEaB3cb3pb4eHb53aUHvM+aTQBJ0GnEfeF5/QHiYZY
 BFuEaKGZHw6L7710UNctk9z3oQPLRpzQm1kvUdXIYb4wMyE4DhXri0oB4IoMPhkNoeA3RbhAc
 ZSmF3KZEt32ghxwzAJazh3RTYnksMhTUjIS/Vxv3wiparyM7zXuFPbyPjieUYgWcmy32ivLt0
 tAgg2YcwrXeQ2/QXjncoyFERyPnBJ0NCSrUH5/wEPdBwtDN6XFug7TfNCH9KXLr2HmodWE5or
 z7SP7T9ATMfPYWuQaZ08tGlapFo8pcyZxAY15zklb/PRBZ8WWwhYfje2yWgfFsoVYaDGRe08D
 yng4HIOKxYy8tJUsnzeLIxuBJjjTfqIakwlkUUc7YEDNdMMDN141yVmV15F1TEOQDYdOtI/SD
 L7lSytJbAT0jUQWPYFsna17eu/xRT3+JcUYw1LixleguDCfoh+l11dXEMjXhTcKi7gqPmaI0P
 fmylvPAV+MkYqH4J9+MZIZlSsqzUphQfySbKlDcDfKMpmmzlyKpVxFXO1D8HLeBJPcwohaLQB
 hFnjHnTCgYEvf0WyyGx+kx6A7dHD8nI4eFroiER3K9PELoKP5Q2OwkRdnqWOicY1RkUZETrcO
 FkE52TM2YpldKLA2G
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NFd2t2UogYmFSlXKK4RauvYFQ61OPAlnK
Content-Type: multipart/mixed; boundary="dBRiycPQ2UPGEXwKQevrwgUg3QBRvWWGa"

--dBRiycPQ2UPGEXwKQevrwgUg3QBRvWWGa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/28 =E4=B8=8A=E5=8D=888:08, Qu Wenruo wrote:
>=20
>=20
> On 2020/2/28 =E4=B8=8A=E5=8D=883:51, Josef Bacik wrote:
>> On 2/24/20 1:02 AM, Qu Wenruo wrote:
>>> build_backref_tree() uses "goto again;" to implement a breadth-first
>>> search to build backref cache.
>>>
>>> This patch will extract most of its work into a wrapper,
>>> handle_one_tree_block(), and use a while() loop to implement the same=

>>> thing.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Do you have this in a tree somewhere that I can look at it?=C2=A0 I tr=
ied
>> applying these but they don't apply cleanly to anything I have, and it=
's
>> hard to review this one without seeing how the code ends up after your=

>> diff.=C2=A0 Thanks,
>=20
> Sure, here you go:
> https://github.com/adam900710/linux/tree/backref_cache_new
>=20
> But please ignore the latest 1 or 2 commits, as they are still under
> development.
>=20
> Every submitted patches will not undergo any extra modification in that=

> branch.

Except this commit,  "btrfs: relocation: Rename mark_block_processed()
and __mark_block_processed()", Nikolay had some pretty good advice on
it, and it's updated to address his comment.

Thanks,
Qu
>=20
> Thanks,
> Qu
>=20
>>
>> Josef
>=20


--dBRiycPQ2UPGEXwKQevrwgUg3QBRvWWGa--

--NFd2t2UogYmFSlXKK4RauvYFQ61OPAlnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5YW5cACgkQwj2R86El
/qhyowgArknXKWqnJdc4JIxhHE69TYJgNadNdUCV7AQLPDQnMql0VrDoBUsqRIZc
H3zDrZiM68dngGw+/BRf+rWY06K+mgPZR5zcfb+Xs0MrjGSxRy2//KUAEr2yoVHh
LWVrG2VsyOC9/FLKxdVb0nRZiFygDNF5sa7Y8v1ZO0+QYM+iQmpFy7MxZ7wM24ja
WKXdyYMv9qw5iRYQPSnp6LV8tW0r8VEgfZTaDqydkL/UHdDKtFpQPSTzPR0O175p
ffTDbxuCGbm2NcPmk7MpcggHFkDCNLRYNSVUCUKcqDs3PkXj93glWTuLmFT+01OR
O7F4ahNJpsu6RCqWkVE6DWfAcy2+dQ==
=lPkD
-----END PGP SIGNATURE-----

--NFd2t2UogYmFSlXKK4RauvYFQ61OPAlnK--
