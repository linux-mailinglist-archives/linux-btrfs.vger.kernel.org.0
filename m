Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 310D215AADA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 15:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBLOUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 09:20:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:54735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbgBLOUO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 09:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581517207;
        bh=oo6qY20kC04YNhEd8Bj9VWo5iqLnjV4vXtFl73na9BU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ejKlrPRfs7epNWCrQzDYBjCP+J201tfWXOFB3RY0DNZkc6190jv5+Cl2mAs3TyyZu
         9yf1MtlxV4vbk60h3MszylV+qxFtE+VWS7LeQQ7Ox+wCRSrZnnWPgl1y3zrgtzSX3L
         dae6jV6Fz3OEPAHRcVf+9da2Gg2QRSvlGW4tdnEo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1jpq5C09ZV-00qFGR; Wed, 12
 Feb 2020 15:20:07 +0100
Subject: Re: [PATCH v2] fstests: btrfs/179 call sync qgroup counts
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581500109-22736-1-git-send-email-anand.jain@oracle.com>
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
Message-ID: <d6fb1d1b-351c-bdb8-692d-b767840193f1@gmx.com>
Date:   Wed, 12 Feb 2020 22:20:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1581500109-22736-1-git-send-email-anand.jain@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dYrctnbqnCJeqPwHVrfFBKBSFusBonrjf"
X-Provags-ID: V03:K1:vJiy3HJK54lgIceZ9FEhkTsJOEl5fD2/BMyHt0qH2ivCiGHwmH5
 emfvPvr5DLzdxoSUjUovUjFJy9wOaJNA7jOmr0OF4OuaOHNTHVA+3TGGD5e3wTuFBMKZpVe
 V0B/jfb+TXvJ+xUm4kppunnE2D0dNYMVFcVHQc2cD8nEyK9hO2LDJmkhemL4mG+QJ07lIKC
 BRZ3DFrIwcFRBzamt9J5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NnImzBsOT4c=:KBQA3+B3taaW/isTyT3W+F
 PM4Nac3f7a1h85Ow5dU/mF1SrKx7zG1+Dqclw06Y20EKDLLgJSIeIO+v99/QQLgy8lhoI57dT
 m5dKTO/7XAORYqGwJGUteaA7Ah8egNqnCD5wdDEGK7QYjZvovxM0NHtjdHSnUBsikuoTgOuOR
 NveZOlmh2drA62i/JI8NeFziB3jNgVDrX5/usEvhfOGkGojQu915Qz+9gLQiVbkhzPkoPWnOI
 vHU9gsf+puaYFsj/3/bA/qr3z2FVXCXFI+9fXvwCI6rrhaGKWkD1LIda+/m75MSl+tmr4ErsI
 MgfUdg9alQWV3pT2L9yFvYCrYQJJMCcEHvvKWhEQS5tGXg0jQJKbu2mA2I6PPsTv9vN8xNXf7
 oLnVuKafYi0eP9fLgJoEjLQkM/uMK1tg95oblE/HbEjDJo6f+qYhEC3kNImIlE2w7hljJhNJY
 8FVDfWzamzdUAn2CMmMnLdmvk6X1zfGFeMkr0nqko0akkp/zaNbNzZZHm/8mCpiPw9dsBNTx1
 TcU0lk/n4LUD0Auc8pYGXEE85Str5cPJwrizPECFJhARTMRVDGTntkBL+GuR5oDColudXyl14
 nR/P2rjmhn4C3ZIwPfnc0bwrmHiTQ9Iel4aiEFs6plKHBcceiBNMtCLGPvO/bb+3YM1Yrl5Y0
 yIaqlp9O2nPI8Mex0Cy9axCaXbo2Zbl2V5+GpOMWtYZkYar0o8vY1AnUl7OGdFODdHT7O3lcB
 H8iUXvZFIklzA1pCdXbw2LgQM9+7yVTF2OY+y1jPKvy4b05zdYW9phqZSjrWv7T/cmMn00QCq
 HUxIqqHfsRNJow5BIbNYXpUzpWlFSSWeLYMZdxMGPoKdeXxovBanQI9AdDupsYf82RCahXoSc
 We+uP8j7oGYHTX781QwfcEh+ZzZ5l18SnuYaGZ8CzOrzd/xhjWgNg9Ta3oVg1/iS+4Wvob2Ty
 tLNpqr6UKpemCicsSzYDKM0WYzeTUtAjFRFU8AtNeGAqwg32zj7J/ERWmOhgZHqzYA98rsG7c
 8NVvMTAefW/xtI9IEGef68jfk/ypmek114zMDNPQZUERkiShhvhkE2SX/xY3sai3Qb1qSx2Gp
 lJE8Vl5ZF3yjO2qWSB5J9XI1DBV/mOXBdLHGrEPQwmfn4bAGu04V7H0QPAYP59QWjMceQ1hLv
 C7z5/pB9hFcOvcrdjxQKcoh8g7BOzM77ukxXZ4yipRRd+RqGNCRpbTs03xrSjumh+oISXAIz/
 uLE+wcJn0/LlxJylo
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dYrctnbqnCJeqPwHVrfFBKBSFusBonrjf
Content-Type: multipart/mixed; boundary="44FlbcQx4HlCTyrVlwi0mCj4nZXkxAcyJ"

--44FlbcQx4HlCTyrVlwi0mCj4nZXkxAcyJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8B=E5=8D=885:35, Anand Jain wrote:
> On some systems btrfs/179 fails because the check finds that there is
> difference in the qgroup counts.
>=20
> So as the intention of the test case is to test any hang like situation=

> during heavy snapshot create/delete operation with quota enabled, so
> make sure the qgroup counts are consistent at the end of the test case,=

> so to make the check happy.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Use subvolume sync at the end of the test case.
>     Patch title changed.
>=20
>  tests/btrfs/179 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/tests/btrfs/179 b/tests/btrfs/179
> index 4a24ea419a7e..8795d59c01f8 100755
> --- a/tests/btrfs/179
> +++ b/tests/btrfs/179
> @@ -109,6 +109,15 @@ wait $snapshot_pid
>  kill $delete_pid
>  wait $delete_pid
> =20
> +# By the async nature of qgroup tree scan and subvolume delete, the la=
test
> +# qgroup counts at the time of umount might not be upto date, if it is=
n't
> +# then the check will report the difference in count. The difference i=
n
> +# qgroup counts are anyway updated in the following mount, so it is no=
t a
> +# real issue that this test case is trying to verify. So make sure the=

> +# qgroup counts are in sync before unmount happens.

It could be a little easier. Just btrfs-progs has a bug accounting
qgroups for subvolume being dropped.
Btrfs-progs tends to account more extents than it should be.

The subvolume sync would be a workaround for it.

Despite the commment, it looks good to me.

Thanks,
Qu

> +
> +$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >> $seqres.full
> +
>  # success, all done
>  echo "Silence is golden"
> =20
>=20


--44FlbcQx4HlCTyrVlwi0mCj4nZXkxAcyJ--

--dYrctnbqnCJeqPwHVrfFBKBSFusBonrjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5ECZEACgkQwj2R86El
/qjFYwf/b8irjBQWXSDWD4DsQGZuJBdI1LyOAhlXAoXhqE5WW6NfFEDzl667nP4j
SIBhDCi+xQnJl2zac3tt8bUdvNhSSlByHgHTQTIedx1EO1ezRWhfCSvfoj3h3xSj
jokx6q6wAhPN/iXT/j6EIjq2pUNOEcs+wNIrwxnS7yhKgznpA9sZrUmEvaY8GGb/
YSnREFZrIn9RJ6D/hObRMaL2VtfhpHHfHMuolRn4TdVy09gtvpLU4ZMRrtYMWsVy
WPJ6MqlIFnekcpmcydXEOIpajZJbJpai6Z1OoewB1KPiwe59ImysA09MTGL1hhuJ
gnM3n4m0r565TxKUgzF1fooOlt3L7g==
=KXpE
-----END PGP SIGNATURE-----

--dYrctnbqnCJeqPwHVrfFBKBSFusBonrjf--
