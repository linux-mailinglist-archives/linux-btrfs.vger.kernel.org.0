Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163C8D1E97
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 04:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbfJJCmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 22:42:40 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:54028 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfJJCmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 22:42:40 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY m9a0003g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Thu, 10 Oct 2019 02:41:59 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 10 Oct 2019 02:40:50 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 10 Oct 2019 02:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXAHgWjOM4T6S23duANURelrKbJsO001XcWMoTpNtc26/v60dnvo9oID1r/KnI4p0GgUoCBt++er/ypxpRvAVW+HsJINA78UakjG9CurEvT/36ssA72kHBweVd477ANtLZc6A0X2iBx2fKXauwW9kLeMye9Bbw+iCA/AkcAKi25yVDF4IogM15/n5imKgYwhwzFGomKOBAEC1pNDF6oId9o6PavGQHyNp6KPfJb2dT+xdrxaBOjW2vbKtizsl4UxtakeeHF/57vH3SSCsOOu0P6PzgNBOGeOG0ko7Z4Il1DcctBWmUWoCKGqQ0FCptWnFOCyvxujT8HypyHovM3amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcM/zE9nDYnjle5zPTcTpmMpc7TT/jyu3gJ/4TZAHbU=;
 b=IPWGaeyu3ytPkE0G2Dv2vLFTj0k+Dljq3F1A8EV2dQ02awY4Tp6+DE4chx12xKW561U5JgFJViMcDuG2xR2Z2Wv4s/mpJfDm+rLfyzwxv+heWbVG6kqq8b33RKmM3p36eqVlctitq7YPn361i5aktqXHC5d0CQAvNAE9F0J7L2pd5A5iOYBgD4sX4bjGYxVpHS4Euy4hwUSK5Po/w4P/wRlhmTXcJ7EX+c165tD+xL0o7NT1Rle3yYgClzxkE3GA31j+V1vG3QbxEsZOEdQcN1Oo9v65grWtNY6FKYInhjHqwcCDUwuv+ihW20gglY69rFjb6AMDScOlzP/zIi+7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3236.namprd18.prod.outlook.com (10.255.136.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 02:40:49 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 02:40:49 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
Thread-Topic: [PATCH v3 0/3] btrfs: Introduce new incompat feature BG_TREE to
 hugely reduce mount time
Thread-Index: AQHVfxQf0ZF9fk++QEOmbzPAEZ1tEg==
Date:   Thu, 10 Oct 2019 02:40:48 +0000
Message-ID: <115dcff2-1cff-1a33-3b71-20acaa2f2ef9@suse.com>
References: <20191010023928.24586-1-wqu@suse.com>
In-Reply-To: <20191010023928.24586-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80051c34-d5c8-4b16-eabf-08d74d2b420c
x-ms-traffictypediagnostic: BY5PR18MB3236:
x-microsoft-antispam-prvs: <BY5PR18MB3236ABBE225EE1DF480D7E20D6940@BY5PR18MB3236.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(54534003)(189003)(199004)(31696002)(102836004)(6512007)(2501003)(6916009)(5640700003)(66446008)(99936001)(66946007)(76176011)(6436002)(446003)(386003)(6506007)(11346002)(8936002)(66476007)(14454004)(66616009)(64756008)(6486002)(81166006)(186003)(86362001)(66066001)(8676002)(81156014)(52116002)(26005)(25786009)(6246003)(6306002)(66556008)(486006)(71200400001)(2616005)(478600001)(966005)(476003)(99286004)(31686004)(71190400001)(6116002)(3846002)(256004)(14444005)(2351001)(36756003)(316002)(305945005)(229853002)(5660300002)(7736002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3236;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7IxU3GVTq2f8Huv19QAxCN4qVGufPj8h2WSbD5cnC52j2R4z6UJLv7X5Tcf4rz2kUWjS1AGmcLU50CtVi9KI/IeV1PRb3z0MtHWYhVRC00QQr0wv4UhRc6vlDdddkTKnBm1qnelqeFdtga0A4OG5V6jSIq4hLVq20VDpyZWRnpmuidyKHH19G16ip3jN9FLSJoxhHNOhZanN2s9OLfOXOBRZIidFoYw0PoODCOEL/C4SJchudJxdWXL10S6H8VipKFlOhhAwvs68NwshOOTqOcvvIvdWQPH5SmnHfvGn4hR5zhAIqu4p93SuioMTJyAE3cmG5u/mz9kLSf2uQoiisPInnv8Y1XlGgYm7JqKY9iElJQv4fusiXpZpLjZ6UCSg7PHfpXRBLnfGj06WR3hlX1TPs0ijeMilP8V/7spq7tU=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="EovkCANdpLM4w1CTHALwyAA8H69T4IBC6"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 80051c34-d5c8-4b16-eabf-08d74d2b420c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 02:40:48.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RXYIQA2xlNr/SWoFbxLorU1Xkbxp6nMLrdVSZSJ629mfEfx0qq28RYyyEKF+SMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3236
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--EovkCANdpLM4w1CTHALwyAA8H69T4IBC6
Content-Type: multipart/mixed; boundary="ZJohNMdz7nzfj854O7x7bLfUwCUQN98Ef"

--ZJohNMdz7nzfj854O7x7bLfUwCUQN98Ef
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/10 =E4=B8=8A=E5=8D=8810:39, Qu Wenruo wrote:
> This patchset can be fetched from:
> https://github.com/adam900710/linux/tree/bg_tree
> Which is based on v5.4-rc1 tag.
>=20
> This patchset will hugely reduce mount time of large fs by putting all
> block group items into its own tree.
>=20
> The old behavior will try to read out all block group items at mount
> time, however due to the key of block group items are scattered across
> tons of extent items, we must call btrfs_search_slot() for each block
> group.
>=20
> It works fine for small fs, but when number of block groups goes beyond=

> 200, such tree search will become a random read, causing obvious slow
> down.
>=20
> On the other hand, btrfs_read_chunk_tree() is still very fast, since we=

> put CHUNK_ITEMS into their own tree and package them next to each other=
=2E
>=20
> Following this idea, we could do the same thing for block group items,
> so instead of triggering btrfs_search_slot() for each block group, we
> just call btrfs_next_item() and under most case we could finish in
> memory, and hugely speed up mount (see BENCHMARK below).
>=20
> The only disadvantage is, this method introduce an incompatible feature=
,
> so existing fs can't use this feature directly.
> Either specify it at mkfs time, or use btrfs-progs offline convert tool=
=2E
>=20
> [[Benchmark]]
> Since I have upgraded my rig to all NVME storage, there is no HDD
> test result.
>=20
> Physical device:	NVMe SSD
> VM device:		VirtIO block device, backup by sparse file
> Nodesize:		4K  (to bump up tree height)
> Extent data size:	4M
> Fs size used:		1T
>=20
> All file extents on disk is in 4M size, preallocated to reduce space us=
age
> (as the VM uses loopback block device backed by sparse file)
>=20
> Without patchset:
> Use ftrace function graph:
>=20
>  7)               |  open_ctree [btrfs]() {
>  7)               |    btrfs_read_block_groups [btrfs]() {
>  7) @ 805851.8 us |    }
>  7) @ 911890.2 us |  }
>=20
>  btrfs_read_block_groups() takes 88% of the total mount time,
>=20
> With patchset, and use -O bg-tree mkfs option:
>=20
>  6)               |  open_ctree [btrfs]() {
>  6)               |    btrfs_read_block_groups [btrfs]() {
>  6) * 91204.69 us |    }
>  6) @ 192039.5 us |  }
>=20
>   open_ctree() time is only 21% of original mount time.
>   And btrfs_read_block_groups() only takes 47% of total open_ctree()
>   execution time.
>=20
> The reason is pretty obvious when considering how many tree blocks need=
s
> to be read from disk:
> - Original extent tree:
>   nodes:	55
>   leaves:	1025
>   total:	1080
> - Block group tree:
>   nodes:	1
>   leaves:	13
>   total:	14
>=20
> Not to mention all the tree blocks readahead works pretty fine for bg
> tree, as we will read every item.
> While readahead for extent tree will just be a diaster, as all block
> groups are scatter across the whole extent tree.
>=20
> Changelog:
> v2:
> - Rebase to v5.4-rc1
>   Minor conflicts due to code moved to block-group.c
> - Fix a bug where some block groups will not be loaded at mount time
>   It's a bug in that refactor patch, not exposed by previous round of
>   tests.
> - Add a new patch to remove a dead check
> - Update benchmark to NVMe based result
>   Hardware upgrade is not always a good thing for benchmark.
>=20
> Changelog:
> v3:
> - Add a separate patch to fix possible memory leak
> - Add Reviewed-by tag for the refactor patch
> - Reword the refactor patch to mention the change of use
>   btrfs_fs_incompat()
Forgot one:

- Remove one wrong patch which could break usebackuproot mount option.

Thanks,
Qu
>=20
> Qu Wenruo (3):
>   btrfs: block-group: Fix a memory leak due to missing
>     btrfs_put_block_group()
>   btrfs: block-group: Refactor btrfs_read_block_groups()
>   btrfs: Introduce new incompat feature, BG_TREE, to speed up mount tim=
e
>=20
>  fs/btrfs/block-group.c          | 306 ++++++++++++++++++++------------=

>  fs/btrfs/ctree.h                |   5 +-
>  fs/btrfs/disk-io.c              |  13 ++
>  fs/btrfs/sysfs.c                |   2 +
>  include/uapi/linux/btrfs.h      |   1 +
>  include/uapi/linux/btrfs_tree.h |   3 +
>  6 files changed, 212 insertions(+), 118 deletions(-)
>=20


--ZJohNMdz7nzfj854O7x7bLfUwCUQN98Ef--

--EovkCANdpLM4w1CTHALwyAA8H69T4IBC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2emigACgkQwj2R86El
/qhMwgf+L8AetxKC/REdun9Zg7bn3afsFAE8kq8oCvyDNzIV5z3JCdnGZ10IcrKM
v2s+Eqn1aH/GpMZtZThpHDXEQiH4I5qjrrIGlLUAAVdxN1GnIGo7ZRvqgUGVDXpM
xxUP0yIN4/jfwyQkKKL9cCyrVw9kj8nscBxWeuSmYsK7qCT6FoRCe0Kagdk1aYFl
fxOOe1F5Pvbj6nxV4AG7XRbLcV49I+ldsWBs5z3ru83oyOP+IIPTrOjx2vzb4FsQ
9KCkUoS294JTV9eL1U5ZjlSx3yM2XEua3K5RtsUZy53VDdub2f/tn6u9BcQt62+y
udl6FcF87Bx9g/0zMS4g7TODJhu6ow==
=/H5O
-----END PGP SIGNATURE-----

--EovkCANdpLM4w1CTHALwyAA8H69T4IBC6--
