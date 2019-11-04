Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3412EE14C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 14:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKDNd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 08:33:59 -0500
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:36761 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727430AbfKDNd6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 08:33:58 -0500
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Mon,  4 Nov 2019 13:32:49 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 4 Nov 2019 13:32:52 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 4 Nov 2019 13:32:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL3VQi0tPJbAK5sB1sKMRJ98ivEnuCz8pJGQUKcuSzur059tRryMRHql+5Cp7bobl803Q06u5tXt6rmViFlUH8IJlwScNcT3O6xIYfdb2is3+enTACBBZlah0BC2kTR4EuVYNDvqszEGhAzCDY9cdeh1GSrjq+NBe12POgecyCtxXjcIlabGZD+t0CG3UB2yBlvgWpblhtRimfzirwb15RDpUW8KCrJg35AdWB1pqUfMV9wrGD0WKFE9UTt0MUvztXTNL5wFwv7JGkjsS4QpqUaSZQIeCDR1L1hy95xKY7fsUveAbJecIyekeEGqOFbGWpeJxlJUA2fhDxCrkvGCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS6pVEagi2UvQFD1Ezt6elYptA17VJbfESLrgmjuzvo=;
 b=ht95nabEMCV5GI4HOSTuRilfe2iRn+GLmAeiCUJB0lEZcrrmcylh/Ih/JqiUD/RWrmT9Pm8EpivtYy5m7Cv1SQV+0cGtq6sJvx3Mk077NPnKRz4fY+QXdD3/15SxtaVKdWZ+kRPjylPF9i+nN9rF1K7EAoOPd/3o22C1S7oY30+isF6l/JffOsh0nD4dgHby5goFjH222h90BRfe3XBEpQ/NjNcc8B6dluYSeYuIHwxNpVrK3vxJbEN0yClJaUVHgO88T2hKX5EBLxypTiMy8FuxK+AiRarQBSyd86Z/FSLftj4N5yxzY2FAZ2OUmvdU2QkwAw+Y3qKQnEU8syIcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3123.namprd18.prod.outlook.com (10.255.139.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 13:32:48 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::1842:7869:d7de:a07b%3]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 13:32:48 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/2] btrfs: Introduce new incompat feature
 SKINNY_BG_TREE to hugely reduce mount time
Thread-Topic: [PATCH RFC 0/2] btrfs: Introduce new incompat feature
 SKINNY_BG_TREE to hugely reduce mount time
Thread-Index: AQHVkxRZLzovAFnZdkaWxfn0BSNb8w==
Date:   Mon, 4 Nov 2019 13:32:48 +0000
Message-ID: <6e6cde26-194d-d3df-044e-340340d4c7ac@suse.com>
References: <20191104120347.56342-1-wqu@suse.com>
In-Reply-To: <20191104120347.56342-1-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0191.jpnprd01.prod.outlook.com (2603:1096:403::21)
 To BY5PR18MB3266.namprd18.prod.outlook.com (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c292f370-039a-4213-0cbe-08d7612b7b4e
x-ms-traffictypediagnostic: BY5PR18MB3123:
x-microsoft-antispam-prvs: <BY5PR18MB312373703E16DFC1B8185EC5D67F0@BY5PR18MB3123.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(54534003)(189003)(199004)(66446008)(64756008)(66556008)(486006)(2906002)(6916009)(2351001)(99936001)(6116002)(3846002)(478600001)(305945005)(966005)(31686004)(25786009)(256004)(71190400001)(14444005)(14454004)(7736002)(446003)(11346002)(2501003)(86362001)(6512007)(102836004)(316002)(2616005)(476003)(6246003)(99286004)(66476007)(6436002)(31696002)(76176011)(66616009)(71200400001)(66946007)(5640700003)(8936002)(8676002)(81166006)(186003)(81156014)(66066001)(6506007)(229853002)(386003)(26005)(5660300002)(52116002)(36756003)(6306002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3123;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHfykKuAfLHtXN+3LdwK80LjsAZ3HpBDEFGRLgx55LAFSwFfBqoF+o2hWJx+HNbGom+I9aVehRSZUWlxvGHdnoa91KKDYAcK16omTR4YwzldKU1fMcHrwMn15gJUHK19Whgpl5otjGNk/RgTfYeKgiTJnJchPd7HXdB77SOXZU5PHOeUqJmmu883hHiM/6YlDSZsfDUuRVspzz9+p4kDiw/ZGFxUqf1f2GT5fIZRpbYS5jmdGwsoBnHkxn5v+0esUrDAWgEKOojjKpsb+s8Ri4ECqMFwOO+8Rzy6VDmdc8kFJNYZ40gj2NzHLt7sblcOa5ylAHHWxcVjnDhCNlCzp+4HjNEWOjYeFO10sPEIv+xhtg1Hs0smBWR0Jhl0Co0SKUDWxqCwia93RXQR6sxQ4RQHEc3MAJx4o0R9chmZCtfHmB5UMnmR98zJYPSoiY9U
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="3h8ZDxtjiVaCWJHdZPxemfEYFvesG6N6p"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c292f370-039a-4213-0cbe-08d7612b7b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 13:32:48.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EE6kNhzYucB1PXB4J9joOeHXSqUy78U+RXcKM8hRjwveu+wRhyg3ArFxMQVVly86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3123
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--3h8ZDxtjiVaCWJHdZPxemfEYFvesG6N6p
Content-Type: multipart/mixed; boundary="IPBLSVPVHo59LMCZJuw34jwufI8y4WK9A"

--IPBLSVPVHo59LMCZJuw34jwufI8y4WK9A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/4 =E4=B8=8B=E5=8D=888:03, Qu Wenruo wrote:
> This patchset can be fetched from:
> https://github.com/adam900710/linux/tree/skinny_bg_tree
> Which is based on david/for-next-20191024 branch.
>=20
> This patchset will hugely reduce mount time of large fs by putting all
> block group items into its own tree, and further compact the block grou=
p
> item design to take full usage of btrfs_key.
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
> This can be improved to RO compatible, as long as btrfs can go skip_bg
> automatically (another patchset needed)
>=20
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
> With patchset, and use -O skinny-bg-tree mkfs option:
>=20
>  5)               |  open_ctree [btrfs]() {
>  5)               |    btrfs_read_block_groups [btrfs]() {
>  5) * 63395.75 us |    }
>  5) @ 143106.9 us |  }
>=20
>   open_ctree() time is only 15% of original mount time.
>   And btrfs_read_block_groups() only takes 7% of total open_ctree()
>   execution time.
>=20
> The reason is pretty obvious when considering how many tree blocks need=
s
> to be read from disk:
>=20
>           |  Extent tree  |  Regular bg tree |  Skinny bg tree  |
> -----------------------------------------------------------------------=

>   nodes   |            55 |                1 |                1 |
>   leaves  |          1025 |               13 |                7 |
>   total   |          1080 |               14 |                8 |
> Not to mention all the tree blocks readahead works pretty fine for bg
> tree, as we will read every item.
> While readahead for extent tree will just be a diaster, as all block
> groups are scatter across the whole extent tree.
>=20
> Changelog:
> (v2~v3 are all original bg-tree design)
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
> v3:
> - Add a separate patch to fix possible memory leak
> - Add Reviewed-by tag for the refactor patch
> - Reword the refactor patch to mention the change of use
>   btrfs_fs_incompat()
>=20
> RFC:
> - Make bg-tree to use global rsv space.
> - Explore the skinny-bg-tree design.
>=20

Forgot the reason for RFC:

I don't know if the tradeoff is that good enough for all the extra troubl=
e.

If we compare all the needed unique tree blocks, it's indeed an
impressive 0.74% of original extent tree, but only 57% reduction of
regular bg tree.

So any feedback is welcomed.

Thanks,
Qu

> Qu Wenruo (2):
>   btrfs: block-group: Refactor btrfs_read_block_groups()
>   btrfs: Introduce new incompat feature, SKINNY_BG_TREE, to further
>     reduce mount time
>=20
>  fs/btrfs/block-group.c          | 462 +++++++++++++++++++++-----------=

>  fs/btrfs/block-rsv.c            |   2 +
>  fs/btrfs/ctree.h                |   5 +-
>  fs/btrfs/disk-io.c              |  14 +
>  fs/btrfs/sysfs.c                |   2 +
>  include/uapi/linux/btrfs.h      |   1 +
>  include/uapi/linux/btrfs_tree.h |  11 +
>  7 files changed, 342 insertions(+), 155 deletions(-)
>=20


--IPBLSVPVHo59LMCZJuw34jwufI8y4WK9A--

--3h8ZDxtjiVaCWJHdZPxemfEYFvesG6N6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3AKHUACgkQwj2R86El
/qh1JQf+M3hE8FWQExliiCf+CrE1fWq2n3xampADDRr/jTDn3080s7g/i9xKIORx
e5BdcBLlhPwAVeUlNBRLymLMN6lWtIWfwdIxzR4cKgMKm9aq2BpUkik/sgdM5d9i
NCsrdf4MBhFhYd11C3CzXV9heAVI4Knnpj6m217J/oh9uEgnBsn2vN3bLnDB1bMO
m7nGOKGtdOXegyUdbizEScKZ9+HxLO0Sq1q+whPeriEWVjopfhPVtNeRzFDRc1I5
S7SqsX2pqSqgf2YTMUnjtTXul9JWVbo+ED5ZEIcMeGT2HNewMwLxIswtFQah3Pcl
MDYh+um1DhSMi/iQWqRB0jamwUYNEQ==
=He8i
-----END PGP SIGNATURE-----

--3h8ZDxtjiVaCWJHdZPxemfEYFvesG6N6p--
