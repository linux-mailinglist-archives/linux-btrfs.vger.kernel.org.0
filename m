Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB9135055
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 01:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgAIAPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 19:15:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:52551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgAIAPE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 19:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578528895;
        bh=SsWwf+brg7EVMwI+MvKuL0AYzgnBph2eIwgBSoATMyQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kSVF+Nof4LzpD2c2181RkAsyIiyCKZSZxZzpWzF78+QVyhDE0PWWsj4RL+lUFzpsm
         QIRrvlwyzTz1zgdbD1A71vaB9NkE7ieWd2JVSgFwJInujyQljmjlvUUiZ4y3hSY+rQ
         D7aBmWB4gjQOhwrNIutDYzvj12DrKiuxXKNNxVlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3ir-1jHZp60Xal-00TQeT; Thu, 09
 Jan 2020 01:14:55 +0100
Subject: Re: [PATCH] btrfs/202: fix golden output
To:     Johannes Thumshirn <jth@kernel.org>, Eryu Guan <guaneryu@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200108174510.6261-1-jth@kernel.org>
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
Message-ID: <7a4bea28-8897-80af-7398-3b5c0fbdd746@gmx.com>
Date:   Thu, 9 Jan 2020 08:14:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108174510.6261-1-jth@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tFn3fDiCesj4iqJlQgqEt2SQrZbFlQX8J"
X-Provags-ID: V03:K1:2R7IY4cYx8nuUWDuvcddQlOrVfBp/FxStnZQWv/SDWoM6LKnFCt
 N6iAnr6fvHFyb/J3VhQLQTC17K24W3aIpJlZzjlFtXaWSkxjiq7L8yAXO2x/MQN4Tl9gSe0
 r200ME2jhWcLFzW9WYFfjifo1OEc3DQy96JgoYzQ04u0p/U1f9ffR4O5Hb/5A5TCNOs64kh
 i5qE1k/XxW0EIrwtV0lcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GIfc3SOMXYo=:jhx+9jzo76mKZ/gIci8cx8
 xfaAN1yRxi89+m6yU/9sQUQvKkzoowmOxGQI75GtLv5bZ010M8ckq7yZjFDBEy0Tqajs1p7sH
 eiicn0ixvWEgQ/EetxpdMSwDeYM+j0c/+1HjEBbHF0LItS+8ncypGYNaxJVaruTZ5Dbl3Zbjl
 LuOxYb+Tag9szsNl1DLDE+Kce2V7FTLVHLrpS6o59eSlh221dF7h1BS3z0C7UnL1bLg9I6nJh
 9oVVKa3tuoAh12iAo6I+J2sHTL66zhm4Lh+3tsBFwgfBQbnd5PHaRiEyQrOqW5tkGdPJOpDCw
 zvf6u33f0NKbgqyM7W3eHHQwXRb+/eGPEjqKaI4cyUb2QpJQWeHiqn9Q5U/ngK3XUtjo/mq+E
 SEKBglHfbd8RSq0XlyK60C+YjQ6mMHRuHewTYac62Wm535yuM68aCrwBAsrg4DRmmDjmkD4dR
 k5zNOsKfbW8A0481dhvz6Cy6zsPy2B/G+0H/OwHZLdO+qx0ShhZg7sYOb1SfC/elTQxaOBm4I
 hAZAhnsWCaGY+BKhNy6+5mVyA0lUqgHiwoKtBwDOsScgFfN+gvpONxd3gtvQgYSmoERE2sDXw
 w7VUJvU86VwCjEnfD9dd5bMfOuqXXK7Z8zesrUtJTDbOW3g56o0NvJwM0Ctv19kqCIpzJMq7B
 9LRA0HKjvXFOWCBPFiDxM+tHEHDtJUlnab5kdJHlCMMhN/7mL07CMVEHRbsioZ/Rjy4R75Kau
 76A8+Q8lkrY131CpzX2MeHuMENwQtHCDTe+QawbM9DK5Tdeir0jV60kGQGUN2rwLRpJrjHOcu
 AQFm12LeYdDkvolZuUZ2RwPjKkSeklPysP6YVix0UE7hGVJRWoU+voVP/pSC1YFcOg5NFuGvw
 U/XWHfQSRGdbWq9t6vyrFnpeqc4mfQ9+2D72hhaewqR9sJ6QqsHxu+Qjk2NRpBuTAq8Mr5yX/
 yQuKtiu0YHmgG/GRhAw12hzgY62iFn1rSPQAoIQ9RGNOsdlKDPuD6iv+hC+JSmTA8xD/ekZYQ
 GhgE3FGf9nwLpVwKUtmjjNNdqsYBER7Hel40IDRmNDeK9pIfifxXjJ43bI62kmhleR6ofyfig
 613RQ9+BV/7NK2/nMgLlwBCboxgifoleez1olTDukxUet//4Aj+ZadyD2R/B1o5/FZ3W5Q+6X
 V+2ToC+31QMgl03xlWpl4MpHPT/VV8EuFPuPlEKYEODN9Qc9+mrP6V3cYWB9+Xdu4r/8VHIrE
 m2I9JyK0Xwe/on3vbtYdzQfMTDy3nbdOGvq4gmc5FyspCZhZXttmV166FJzA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFn3fDiCesj4iqJlQgqEt2SQrZbFlQX8J
Content-Type: multipart/mixed; boundary="hhwiSJ0435yckf9vSvIDC8J9UmILRxP5w"

--hhwiSJ0435yckf9vSvIDC8J9UmILRxP5w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/9 =E4=B8=8A=E5=8D=881:45, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> The golden output of btrfs/202 contains the sequence number 201 instead=
 of
> 202, fix this.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/202.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
> index 938870cf..7f33d49f 100644
> --- a/tests/btrfs/202.out
> +++ b/tests/btrfs/202.out
> @@ -1,4 +1,4 @@
> -QA output created by 201
> +QA output created by 202

This really makes people laughing.

But this also makes me wonder, do we really need the test number in
golden output?

If the diff is from `check`, we have context showing which test case we'r=
e.
If the diff is from manually diffing golden and result, then we have the
test number in the path.

The test number in golden output looks duplicated to me.

Eryu, can we just remove it?

Thanks,
Qu

>  Create subvolume 'SCRATCH_MNT/a'
>  Create subvolume 'SCRATCH_MNT/a/b'
>  Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
>=20


--hhwiSJ0435yckf9vSvIDC8J9UmILRxP5w--

--tFn3fDiCesj4iqJlQgqEt2SQrZbFlQX8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4WcHsACgkQwj2R86El
/qj4fwf9FKHSX92jH5JvaUdNywOWAGK9W+92Nim2J9gDWj9p9XrvEkqEhXZLdGpk
s+FY9OAuGrnu7mEp7UDltng87+BeU98ZC4/m4vLMA72f196MqedWuHm71fj1BkFL
f1a1K6oW50VLmnSRAHa6PdpRbiN3P62vVWEri2tpqoXrsenLnG+QMZTedu6RJuGm
JlUCZ9qhyUobpfHzk+LJD48tDSP68UL+UZYdl3zMyLJ8QEUUbKdEuoGXe1QUy0RY
ive/KQSL2AxQ4ci18aKJFBEsKc/oAWENU3uZZO32QCKsu85LpbkED0Ef30WObskX
P24QjxdG7zR79qWgUD3RcPTQXMkufQ==
=DZZS
-----END PGP SIGNATURE-----

--tFn3fDiCesj4iqJlQgqEt2SQrZbFlQX8J--
