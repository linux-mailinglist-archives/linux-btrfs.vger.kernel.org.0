Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4001E3F75
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgE0K6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:58:23 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:49942 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbgE0K6V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:58:21 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.146) BY m4a0072g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Wed, 27 May 2020 10:57:11 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 27 May 2020 10:46:58 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 27 May 2020 10:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZy1ABuQuC3BHrXVZgbA0dZ3NdLhkZNsVGvW8alpkpgbWACtPOxvKFiludfxtTc7hPYFv6t/QdFIV1wAJrCameOwhiFfHwwNPvyRYR3uUy+GlAC1p5WZPbNmjtQNiHMU36djmejbN7dDprz8JXS4ZDCBRn4wymPJSnYr1Xh3n+cI7HDeu6ayWAio7kkCKXWrL8Ke0H0GsqocugumB2NCxyYsMx1YjTh2u4l2DK1MlzCB4GD3f07GkCHOeFfZiuf9VxLuBi93zATMsUMdNdjR9423FqI+2UjK/x5uIkeO860iMzZiZhGCjGQGpoIdNd2cNkIuY9xOG3MZIwXGvofSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGt8JHLSvocIWHF3jpNvQYtDkgiwZhuCrzLH1V0XPLs=;
 b=F0WCoYvzRYCiwO9ISSBHKMate0W0eyapO8tnk+51HPYpBRGsDTxFucYkcjhgtf6KEDGBv6er7Q0rc1WOKXz6iPjI9RBhVgTTr7CeXqt8Rb//aoMdNy0VxIvWTFOtdCbzXQwhp1ku2HLyfT2T5Hv1nlh+rgoeXBQeT5oq5wpnXxYXBkDwnLsBnuP047EU1sAW3Soc/tnRg98XoApkV1tbH4W3LLh4XmjIXfpsh7SzOPXURtIu5Xeh/pVYXl1AFOfhthB05EZVh3dn2qTg/WcknbXmsN0lCWu5u3fsFbTPTnKyjmSZXTbZbp/f8s0Mx3h9D33grOVYZQqNur9PjLUO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DM6PR18MB2411.namprd18.prod.outlook.com (2603:10b6:5:15c::18)
 by DM6PR18MB3033.namprd18.prod.outlook.com (2603:10b6:5:189::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 10:46:57 +0000
Received: from DM6PR18MB2411.namprd18.prod.outlook.com
 ([fe80::8916:a3e5:9bf:d14f]) by DM6PR18MB2411.namprd18.prod.outlook.com
 ([fe80::8916:a3e5:9bf:d14f%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 10:46:57 +0000
Subject: Re: [PATCH 0/6] btrfs-progs: btrfs-image related fixes
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20200527102810.147999-1-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <51ac5cc9-5902-663e-da51-b5a5004ec719@suse.com>
Date:   Wed, 27 May 2020 18:46:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="DIAEaQhBKoeEKqCL7b5l4saJOpJkfV7ap"
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To DM6PR18MB2411.namprd18.prod.outlook.com
 (2603:10b6:5:15c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:a03:1b8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 10:46:56 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31505a7e-e4cb-44d0-bdc7-08d8022b4717
X-MS-TrafficTypeDiagnostic: DM6PR18MB3033:
X-Microsoft-Antispam-PRVS: <DM6PR18MB3033EB8EE33D45DA947DA406D6B10@DM6PR18MB3033.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izOQZ67ilPceXwFGftx6xpxjePzmMc8MLAbmI8H4VrhmwJeYxgKQ0r06sWUPOLP/llewOXO7IqvbK26e2Y5BX0/bvcyvqVvig53pjOr0gmqCE6CjGzUttdevFEW/zN+BKTFPjH1nX8CdTSCUsFIe/nRqUiTBUprTHMFOx74M8ZzZTgNIfk6TAfs79k2KDhMu0DkkMTlKljQfFeoV06IqTup+liZ3efkPHau08oJ8bVI5/1EvnE24C9RbYXP+sFSJ4zDdvnfTJl0F04/6o2z3bK+buDYbTw18OW+Gls7TaEwbD3IyMorQChkWqaKPxg5kP1ZhifbQM6knzjlOMJwDWTy0Ojk8DlRlhYx743FbTB2TQ/vF+34SBvfXKxiKACl04NmMLuzM7001gjtlA4hgIfHAYhUBqXe+wIKrcNbZ2jM/sXS5EwDAl5A00J5coe4MbBu6E9KLYWn+j2ZvTUpBW0hlUVgXu35UGNPAReizYo9vfgaEnnzpFFIsfS74j8av7tC1CBIUG0UDMD5qMv8XJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2411.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(31686004)(2616005)(956004)(33964004)(52116002)(186003)(966005)(316002)(16526019)(16576012)(26005)(478600001)(6666004)(21480400003)(2906002)(86362001)(31696002)(36756003)(83380400001)(8676002)(8936002)(6486002)(66476007)(5660300002)(66556008)(6706004)(66946007)(6916009)(235185007)(78286006)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: N9eMbtAZeVqC7uOtHMawAa9Iaih4zVknmSjMYKiSolErCPseObt52Y48v3RoEPV2g2YA9/IQ8ll27v6PmOKIWzF41MMxnGELvTdoxh3XfHj8tTaFwINp4vc8DqGlgww0dIqr3UJbO5xG3RHePMzOQRvm7bUXKWExfSEv/fcvXzxSLdHLS8w7C0k4+u2JJ87nAJyfO0OCDFf408vY9li9dT+iREoETlDy2DKPS9mXW9IVSWkgBTUE6WITNP5+it1xfhUlQZKxtFTy+rk9Q6OfEE5hX5I0797tP6uTDwIwAok3IjRdkiWv2F/bdt1XgECzD6wk/wjja3kumiFTsOlFBWE8WwvrcJTo4gssV3bW8HKxryzw0BKEzyDafQk/32qRT/lpD4rTQj30wZBofQDFUd7Oiw++zbJy56bO1mmWT7a+IEno3WiQj+lG04tSF5tQg/5nr3tN/XR2+MzjX1ZoW8r8WtHF5+OEMWUoUy400Do=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31505a7e-e4cb-44d0-bdc7-08d8022b4717
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 10:46:57.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAJxoRKMBgJIlYQJIxVlVTzIvtnc+qSFYI6xzHZnaEIi4TTbuyMJbzdzfpSztyZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3033
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--DIAEaQhBKoeEKqCL7b5l4saJOpJkfV7ap
Content-Type: multipart/mixed; boundary="Qa8deb6tFvJVUFGRGNczS3kNTydm3RYad"

--Qa8deb6tFvJVUFGRGNczS3kNTydm3RYad
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/5/27 =E4=B8=8B=E5=8D=886:28, Qu Wenruo wrote:
> This branch can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/image_fixes
>=20
> Since there are two binary files updates, and one big code move, it's
> recommended to fetch github repo, in case some patches didn't reach mai=
l
> list.
>=20
> This is inspried by one log tree replay dead loop bug, where the kind
> reporter, Pierre Abbat <phma@bezitopo.org>, gave the btrfs-image to
> reproduce it.
>=20
> Then the image fails to pass check due to the existing log tree
> conflicting with device/chunk fixup.
> As log tree blocks are not recorded in extent tree, later COW can use
> log tree blocks and cause transid mismatch.
>=20
> To address the problem, this patchset will:
> - Don't do any fixup if the source dump is single device
>   Since the dump has the full super block contents, we can easily check=

>   if the source fs is single deivce.
>=20
>   The chunk/device fixup is mostly for older btrfs-image behavior, whic=
h
>   always restores the fs into SINGLE profile.
>   However since commit 9088ab6a1067 ("btrfs-progs: make btrfs-image
>   restore to support dup"), btrfs-image can restore into DUP profile,
>   allowing us to do exact replay for single device fs.
>   This is patch 5.

As expected, patch 3 can't survive the mail list filter.
It's 402K, so I guess one needs to grab it from github anyway.

Thanks,
Qu
>=20
> - Pin down all log tree blocks for fixup
>   For cases we still need to fixup chunk/device items, at least pin dow=
n
>   all log tree blocks to avoid transid mimsatch.
>   This is patch 6.
>=20
> After above fixes, fsck/012 and fsck/035 fails, due to bad original
> images.
> The old btrfs-image can fixup those bad device total_bytes and
> bytes_used, but that just hides the problem.
> We still need to update those images to make them correct, so here come=
s
> patch 3 and 4.
>=20
> During the debugging of btrfs-image restore, I found dump_superblock()
> would help a lot to expose bad values in images, so is
> btrfs_print_leaf().
>=20
> Enahance them to be more handy for usage inside gdb, and here comes
> patch 1 and 2.
>=20
>=20
> Qu Wenruo (6):
>   btrfs-progs: Allow btrfs_print_leaf() to be called on dummy eb whose
>     fs_info is NULL
>   btrfs-progs: print-tree: Export dump_superblock()
>   btrfs-progs: fsck-tests: Update the image in 012
>   btrfs-progs: fsck-tests: Update the image of test case 035
>   btrfs-progs: image: Don't modify the chunk and device tree if  the
>     source dump is single device
>   btrfs-progs: image: Pin down log tree blocks before fixup
>=20
>  cmds/inspect-dump-super.c                     | 454 +-----------------=

>  image/main.c                                  |  86 +++-
>  print-tree.c                                  | 449 ++++++++++++++++-
>  print-tree.h                                  |   1 +
>  .../012-leaf-corruption/good.img.xz           | Bin 0 -> 186392 bytes
>  .../012-leaf-corruption/no_data_extent.tar.xz | Bin 130260 -> 0 bytes
>  tests/fsck-tests/012-leaf-corruption/test.sh  |  17 +-
>  .../offset_by_one.img                         | Bin 3072 -> 3072 bytes=

>  8 files changed, 540 insertions(+), 467 deletions(-)
>  create mode 100644 tests/fsck-tests/012-leaf-corruption/good.img.xz
>  delete mode 100644 tests/fsck-tests/012-leaf-corruption/no_data_extent=
=2Etar.xz
>=20


--Qa8deb6tFvJVUFGRGNczS3kNTydm3RYad--

--DIAEaQhBKoeEKqCL7b5l4saJOpJkfV7ap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7ORR0ACgkQwj2R86El
/qhFqAf/Xc2nmnFSQzbDQ52vOG1xacTlWOe+A5WCtq0arVrHoXZPk+UyLq2SVPHP
kHgmYJUtmfmPkInAiurXcHNX/YB98JGtTZCA7ZPeqCCWXbEI+adkRirSugANCCHA
joavcixZWDWRkk9cEeC/vfiTxUlk27/nLXqJZzWlTgrcU0aP8WrSNdB47kwXxQY9
2JKhvWUVsNqg6lD4E1oa2DY5qFU28SovK2ItsY14YyjuUdKlVAtNiXx6441A087N
gyflqhuwyCYB+PzeHWTOICp97yNQxsMxQ7OewsL1Rv9d9nqhVD6m4EfXHvOWRwvB
FkpIxhhI0hkRM2eGiI6Do/H5KdHWBg==
=yIA+
-----END PGP SIGNATURE-----

--DIAEaQhBKoeEKqCL7b5l4saJOpJkfV7ap--
