Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D690D10C2D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 04:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK1DaT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 22:30:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:33421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfK1DaT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 22:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574911743;
        bh=UzDKAz3lVyjp4vGSE8CSnpH5rB6SzsX64OwEZ2wGt10=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YiIuf5xMcImN51znBJwKBXopvaSq65q1/2qbYDuW/efZgoHm7XmWmY/+Ky7dywf/4
         LygFm+Uk28mQSVPvWXyNZaXA/dIpuWpz0C4cBMZ23Ql1YsuOb/6wwTfUVdWph4qPHn
         gI/tlqUQBrlApbr4ddl8+Wtjw5wS4eo3dKKjOnAg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MSbxD-1iOv7X1uR7-00Svto; Thu, 28
 Nov 2019 04:29:03 +0100
Subject: Re: [PATCH v3 0/3] btrfs: qgroup rescan races (part 1)
To:     jeffm@suse.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20180502211156.9460-1-jeffm@suse.com>
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
Message-ID: <930692de-a07d-bae8-b09d-979fc2fd0427@gmx.com>
Date:   Thu, 28 Nov 2019 11:28:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20180502211156.9460-1-jeffm@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aBegEfcG4IgkAT8Yrnnswzmqyq3nKg0ga"
X-Provags-ID: V03:K1:dxcu7Bry9ILCg6KA9kXaBB4jdqrMlBkJU7eOKbHuKC8OUflaMfc
 CWFOXHHiLR+B3rbqfDcWsPkqZ4ido9X3DJtW7iBpbjFnUnITYIvBqobxqc3ksKWa29lFgOT
 MYIR28IbwUUic49Z3hX4p1u4FjGZ33y+omiBBGV4vUED/QldXZ3RqucM/ZW5JQiXDZD7sUz
 V/A03HQRc3TDEaa4AxEOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6zHQLiCNzA=:qusQ/drTGEsv8wD6NrjJIF
 OP8XtUssL237j4BXh8RvtbBbuROvGAZVXixZAzBp7w0wbECKAV5ivvsuZ+RLJhU0JybGT0+ap
 /HsBvV6c18ZL3is3YQDjmweNBdNGAq3oGNUM6pKgpFgmNErZ62whIIXgisdqCto6EqDpJk1UV
 dFtRXRUhD0zbvVA3zG7Y5Fb0NZMOGUhVN0eiUuoVEcl1tsCWaxi509bVWi4MPyQXLs4SdkW1F
 YYAK0KqR/6Sd9/DSqlexl8qI1yC2LLBXVEuhFAZgXUjMM1biArM9FPjZJTtdsUJGC4WnV3/wH
 wqgSCcXBNYp8Ahelfy/FOliHbf8gAv9YhhDT+vfFhDLaCCnlU/e31sHWUwRuodByEPSDPAefV
 7H2vYGfC7upVbgB6bH7ZzJZvshMWY6iwCBGi9I0s3g7RcvQlhHcEyTB/cc7mFNL35RQBhJdvx
 2P31A9F6uh3Gy2UcTT9HwtjDr8nbboCond+9QkJF/zuyVBjHQvCCtEdC2sMadcUc7ASAHIXcW
 lN3p4d0uDxwKV7w4+OcmgquI60ZCQZiEGbRxMDw0yEQ2NLDiGOQpfDVfZ9I6knQryeMR3+I0s
 Yl1d+bGd2dwv2fUknvAgHTMHBMv/O+9tMu+qWWR2e5vkx36CV7IhoTKLI/pKI5W3aSU70wcAU
 6N/FoSOhS8goonef6Txie2pQ1lgRyz/dq6tzupHUvbw7tjPv/CBZs59nyFVX95PC5c0sBkRlA
 1ohjcpTyLIIznMQuUi+aH147o5L2oTD5UZPJiEjFPs8Y6Grva8M3yarxbwupCy2poHYpupEI0
 4b0dVqzk4233E2e8fDNKm+i3SPOYwBmtiBqIm5asbmy5dUbm0iHxlcbJOHiAnbKd8a3kDkkwd
 5Ia/NaMAKl8N1roWcYGqnVzNds1G8gBMbs5YSrka1mxvSwq7UnIfl1fK8xtSJd0flFETkiPP7
 em05LFbbCPlpMZWtLO6tpzaQdC2nEY4LE0MTjiWdMzkv/w4pysilaInuHP4Crk24s/jCAy1Hz
 rkIkFZCTNKHypUlpCitjVgH6ukkWw72sp3zaiqGhBD3jooxCdFE7i5gR98UemCtZvz78U85WY
 B3RGz/4HroA21pDFhGm6LjUoWLW8diZxwsRLjiLzGKbuTAYta7Ff07GSAsjhFzRZjx1l/f66H
 NqisVnniRUNy4k8z79gGZQJmGkIyyK65yo0KCMNQ6uQX325n6fc62zvvTfYAhMtHBe6pCP2qv
 FMsJ4k61z9cyy6ThUC6vTzJ2us8A1hLW09/qkTuiq5pdG3b/QThPmjMBilSY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aBegEfcG4IgkAT8Yrnnswzmqyq3nKg0ga
Content-Type: multipart/mixed; boundary="Z0vTCOTf9YJ4hZiq7yfwRzadBdcbIF4R5"

--Z0vTCOTf9YJ4hZiq7yfwRzadBdcbIF4R5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Any feedback and update on this patchset?

It looks like the first patch is going to fix a bug of btrfs unable to
unmount the fs due to deadlock rescan.

Thanks,
Qu

On 2018/5/3 =E4=B8=8A=E5=8D=885:11, jeffm@suse.com wrote:
> From: Jeff Mahoney <jeffm@suse.com>
>=20
> Hi Dave -
>=20
> Here's the updated patchset for the rescan races.  This fixes the issue=

> where we'd try to start multiple workers.  It introduces a new "ready"
> bool that we set during initialization and clear while queuing the work=
er.
> The queuer is also now responsible for most of the initialization.
>=20
> I have a separate patch set start that gets rid of the racy mess surrou=
nding
> the rescan worker startup.  We can handle it in btrfs_run_qgroups and
> just set a flag to start it everywhere else.
>=20
> -Jeff
>=20
> ---
>=20
> Jeff Mahoney (3):
>   btrfs: qgroups, fix rescan worker running races
>   btrfs: qgroups, remove unnecessary memset before btrfs_init_work
>   btrfs: qgroup, don't try to insert status item after ENOMEM in rescan=

>     worker
>=20
>  fs/btrfs/async-thread.c |   1 +
>  fs/btrfs/ctree.h        |   2 +
>  fs/btrfs/qgroup.c       | 100 +++++++++++++++++++++++++++-------------=
--------
>  3 files changed, 60 insertions(+), 43 deletions(-)
>=20


--Z0vTCOTf9YJ4hZiq7yfwRzadBdcbIF4R5--

--aBegEfcG4IgkAT8Yrnnswzmqyq3nKg0ga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3fPvoACgkQwj2R86El
/qgSCQf8CJBrTsjGsP3SZt0NtbyRU3GnNOW1i5Vqvz+RmkgJlfCoaXBFU4UKjkG6
zGF2Z5JEEeg5wwJn+KLEl3DfuR4ELtUhcRZ5Rl73x7CSqileaTOeRdTj0NdYPCCS
+b/MOHcrEubPjkJ7jR+r7yWjxfLJiHesQ71qxEtcD1wI0UdQLSzuoQiDjzarJTOx
kU+kD4TblKqg7JX6C+cX9jsAdebsp1N7PzapTenUhGvADKbav5lW0iL7YRQ+r9KC
NwZx3Wh6e9986Bv+ZrIx8Vb39tQamabnJ/D8OFxEHS2AwxNyMpnE321xWOqFLAk0
u6E8y7YzUrltW+MkK8rsWjhG6CNNxQ==
=GtBD
-----END PGP SIGNATURE-----

--aBegEfcG4IgkAT8Yrnnswzmqyq3nKg0ga--
