Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505764B205
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiLMJNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 04:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiLMJM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:56 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D162F1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670922672; x=1702458672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9yo10/lpUJatenz1ZpPPMpbTZBjvaahJQqkj0GyBgzo=;
  b=BFEGMuSbdgU21+FtAgmL9hsucOqjV++MpxT1r5+uWq4p2doHY/MIlgH3
   Sn/Nf+95wiy12uSSXIALs/HGK0JmtyTOkSV4jqMVKl1RzIafqM24lsP+I
   hPuzchKWYaSMsw/pZiB+qXovkyfytj35hxjMdZXLI//d9Y221+tmSRzVp
   VNczALQE7iigMVIdoJGFW0Jn8uFVqbnz+U7PEue6PlNtd8zyXgmuWxDKn
   NZ1D1wfC5jMKPYIgogdi9JW0SX0r3W1C2jmT0O9bPZ38U/m6Wzju7ocam
   f6b7RPFEWli7KKJtlOEIZo1L472pFUDYSUG7r0cKaAZ1M24+m/XYOUcA1
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,240,1665417600"; 
   d="scan'208";a="330617747"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2022 17:11:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/42BfoyDNBVS/4tgSdctW+UyvOC3HE9ZOAkHeehKh/ghqq2RdJmb8Zk4WVVsdNQaAAjR7jTe/jyFhHhB0UQp90OUha1r2jXBZHWor9RXTCw5RXBEWDePXLBHK3TS49YmWqcileJPYpAlpkmxjFKW5FuFVT/GeSSex+7XrX2plcKo0lSyxImJwxyIR2e8pQUS4rTFH/GjZNFnf/OdefuzeSEw6mfPiqF7uonG4s9Gym3+O9HjuajNwOIhlf1/XP60WHXzY29ty2wHDJGgVZNnbW2GAMr06v0mE9AJ+QieqEjQmABVE3wvsu5URo4RtTB0DwuNb7ZVHjAdnqqQ9PyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hboMklNg2G7AgrVGCkLvvqDeY4/HFXYq69brM3Ryhc=;
 b=bFnn20G4hXR2YZL3Sj4ab2CJjDEfebmlZZwFT4sVHWvn3YPs1k7Qz0+dU8SaGpGCzIEnboHAH1PKMOt2vMbvTLLq6CSJXhxi6WjuoSjtD7kjGYj3eBCgHMrMBxxRfpWJMnU0Q0BEH/kMIyap9OmLZ3C3l2t51F2wMbsLwKTZ88cHSHbqyGsgx6PgReDkuYbUGYmZfyVBo8tBg9ZXWLB4DS+uTe6Xxtt94HC3E+xRAvsat1IGuzX5H7Vli+U5qP+I7P2O9SGmWWzZBbTsuyTB0rCqkPuV9tJTLoA0tj2Z1gy258z0afbYYfd+WAwIrI0Dxt4mKsbGIroXEdBruUyXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hboMklNg2G7AgrVGCkLvvqDeY4/HFXYq69brM3Ryhc=;
 b=ID+7jzWWAeuhe902wg7J5PJM4+mDoOS/EuitKbmohmT8Y0Y8EnEni+X97jx7zk+dSXGH7qvixPuI+otuKUmv5LX4dNkwj4N/ugRIyfHlY5Ced0cf6Woc2Q5GJWLQHOl+0d4ZRdzkOuT0ohdQ/2SEBJpiq11G52T72EVNwsi2C+E=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB3939.namprd04.prod.outlook.com (2603:10b6:406:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:11:10 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:11:10 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Topic: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Index: AQHY9cPqVfDtAIM+a0yo62/Je674uK5ruiKA
Date:   Tue, 13 Dec 2022 09:11:09 +0000
Message-ID: <20221213091107.aezonr65mivb2ijq@naota-xeon>
References: <cover.1668166764.git.fdmanana@suse.com>
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN7PR04MB3939:EE_
x-ms-office365-filtering-correlation-id: c8c8cac7-369e-4933-cada-08dadce9f999
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHTZnGWOVAgwic0PE2gk6Q1ypmTH8Zal2lgtNnU9DTvy3F1sVTQaeo3Z2XOswNFr8myrxwnhuXEEtK/y2wPDXbGdawWEqOnE0DK8e7QHCdv4tpqUr2BX2fgZ8ycEyyzPRq4hzQtQ18AphllO+EApWZLHybJF2MBMa7v2jmcLIa+DwyLBSQfdbwfSyOkgyRvM30tB2djHTwnNfb7RXgKRpSbcU99+oYEa82IYLWawR1VqtE9Q8fnP99eYw89BWSEqEWOCvLTOsiKFXkgsjc+o22VL4t8fkLUREvuLNCsbyC57kkxTuafWc79dYC4T5x9AdU4wqimgptRV0uNi3vd9KavKQyml12SCFVR0e5AjOg2MdZByD7apRMLc5aZX85kBqZPdbKrJmDkHlBLF+KMj8W5NXexYyPzH4KC3tcMdOhV472+PajNeNBiOosrfWhG25c3IjuxEHJ840W3bQaCQJOz0zS9xENR3SRjwTTOK02S94lut4OJ1an57D/ovfsUET45dhBLcn7qUYMMjbGYK+voMoA+NS+GOAaqkNBG6KHZgiIl8wmnrcL5hGh3dkj0D0twMWevcsiU6j2h/xosf6bk6PFHDmv5pw5vAC8T1TQg30tt1eaD+bU/8SBFfnvEipWNwmlEefFblS5oUE74V+81ymLCeACRrgGWB6iq2lK/9FnB0tKCDv1gbPExB1KzL+YkNYmg4W7Xk3Hkj+hIPog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(91956017)(76116006)(2906002)(6506007)(66556008)(71200400001)(6486002)(1076003)(41300700001)(186003)(478600001)(38070700005)(316002)(122000001)(64756008)(6512007)(66446008)(9686003)(26005)(6916009)(4326008)(33716001)(8676002)(66946007)(86362001)(66476007)(82960400001)(5660300002)(83380400001)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sHFtkQalktKNGPRegyhqK1MV+jgqhPA8Zyhfr9sgh7dUHdY75EFK7M8qT0aK?=
 =?us-ascii?Q?mXkG0WjklvQ6CBAnVAuarfnmJykT5/9ZcwTXshC730NqlcrkHZDrcTVeDywA?=
 =?us-ascii?Q?i6GQlH7BtoPwbgcq9U/S+TH5CLoJthAdSjQpj4auMwbU7xaoL/ok6ss7LLOH?=
 =?us-ascii?Q?4q68EOZDGAQ65xz/7mtaU0wp+VCGZuZbE7FOF9fr9zLKE02NVBlfAnssDhUQ?=
 =?us-ascii?Q?gN4pid+VDZLHKlNEZW61qbwj/ZaXimEDRluHUB7O3sPX8RJs1xrVwe8l72Ui?=
 =?us-ascii?Q?yuznZMT7yLG45f1OQzbTC4n8FJzR/9WaEEIXgK6slLwR6+wYzi7lJB2TGlY/?=
 =?us-ascii?Q?YYIjIdkGNrsSBmPtcKW/6OYbsXrLYCbQfSLgI0UJ1KosrAOoUhza0o2wy9b9?=
 =?us-ascii?Q?zmRQi92KH5D9ARkkY6oXripE/05sQupnRqHGrYISHVaGNbt+1jAEt+pUHSi6?=
 =?us-ascii?Q?9YDBlthzELoezfuMN1dE2ypTO1xyZWcalHuw/17iLMIK+UlmzIbR5PCzt9vf?=
 =?us-ascii?Q?bRzSLH5GSM8M9eUegY7/oEk7CHz9IurGR4cyEHoBStoI3I/emiQJ/s4t3wUl?=
 =?us-ascii?Q?FlvtSbpZgkS1UJT3Tz+U5f06S0PoRt2JCeYxAFoLwqzCjv2sXkVBiQ/sW5pN?=
 =?us-ascii?Q?4nTLW4t0AlZwwq68DiD09vSdX6lXRZLl/r649HFMfETlphKtn6q8kpcH7ABh?=
 =?us-ascii?Q?RuBq8qobWlXowcO4a5SNZBYwLp1UuoJ6JvM2toGW58ZzMV9J2GPv7A7te4IC?=
 =?us-ascii?Q?d6Bc2q0fVcimZbI60Rq0ZmFxo8JzizMikrSLDXhcaPur4i2Q3PlTS+UkiLMj?=
 =?us-ascii?Q?0HYL922OBVse76+TGoEJQhWchlYBe5c/zDVpQCv5H/eYlBYaDBDkFC6CTPz4?=
 =?us-ascii?Q?evsd+WfThXuQwf8VYLEHzjmNahce/DOrdpA0C4+80yBig8kAaclZ/RoTshvL?=
 =?us-ascii?Q?ydA36ZvRdBGBxb3eELtq4e8bH0S4mA9x7ZlngOqsHPvnpWHjr5nb0XLwZT9z?=
 =?us-ascii?Q?zzyoZ/h/12MGOe796d2lz9hH304Tcuxt5UJ+636La5TaHcB7WQLfh+IDUpKa?=
 =?us-ascii?Q?asLBTg0wi2kYvq5NgO6KQ4axHjVI6Pd8ZcuVvnSRNmC/ZhVOuINaQRjUYGCx?=
 =?us-ascii?Q?3JFsTAppgeboXAjG1AfJFp03b8YKcevETuALrCseeneVhmMJo8EvUmVW7a3f?=
 =?us-ascii?Q?TsU0mjhy7KohamxJ86DMtorTOtDsQNOGjTywk9df2GYhgjazpX7tKNNeCjs+?=
 =?us-ascii?Q?aELw/ntiDe8OiLfxRa0JvndTyRDqBB2x1ll9OOQ02ZLzvJH7oQ+ZeAoUQb9T?=
 =?us-ascii?Q?Wakd7/fr8cuh5Q3kAlFI0rKg2D3BNFWjU01tIR7ju9aZIsBJdx3/of6Suzav?=
 =?us-ascii?Q?5kaMA3zaaWDrZsayvjXA+Ryhz1DwnJ0EVpBvL/BDU4QztheFP1AMGephccge?=
 =?us-ascii?Q?og7Pa2zIKrsrtBNWkNhj/bSbdEC0F8r7hnfxxU4nikGFBZGyG5QRcdG3LvPo?=
 =?us-ascii?Q?Gw/4n9hJpLCWcbmmZ7nPkZqGMj9Xt7m+8MDuDNhihUhhEYLRiKyU3IGi30vM?=
 =?us-ascii?Q?Og/yJ4PFegFr+2WfUf0V47HKZE2F3oV4LMDhNas4IP6HQpQywJR6S12CPX5b?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8BF65D45C347449B350B3C0440A9CE8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c8cac7-369e-4933-cada-08dadce9f999
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 09:11:09.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGldKE/X2moNHurwvuTQJfuVUz2Pd+HpG2I8wJnye7cMj1eXDp9Us1uYRw24McSNd1Dx6Ozd/2NdDmXy4Nlj5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3939
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello, Filipe

Thank you for this series. We had a performance issue on a HDFS write only
workload with the zoned mode. That issue is solved thanks to this
series. In addition, it improves the performance even on the regular
btrfs. So, this series might be worth backporting. I'd like to share the
result.

The test workload is a system call replay, which mimics a HDFS write only
workload. The workload does buffered writes with pwrite() to multiple files
and does not issue any sync operation, so the performance number is the
number of bytes issued with pwrite() divided by the total runtime without
sync. The total pwrite() size is about 60GB.

Before the series:
- Regular:         307.68 MB/s
- Zoned emulation: 269.32 MB/s
- Zoned:           231.93 MB/s

At the first patch of the series:
- Regular:         349.84 MB/s (+13.70%)
- Zoned emulation: 363.48 MB/s (+34.96%)
- Zoned:           326.40 MB/s (+40.73%)

After the series (at b7af0635c87f ("btrfs: print transaction aborted messag=
es with an error level")):
- Regular:         350.22 MB/s (+13.83%)
- Zoned emulation: 360.96 MB/s (+34.03%)
- Zoned:           326.24 MB/s (+40.66%)

So, before the first patch, the zoned case had poor performance (-12% on
the zoned emulation and -24% on the zoned) compared to the regular case. As
the regular case and the zoned emulation case ran on the same device, it
shows the zoned mode's penalty.

This series improves the performance for all the cases. But, the zoned
cases have far better improvements and it somehow solved the performance
degradation.

Also, even only with the first patch, the performance greatly improved. So,
interestingly, the first patch, touching only the readpage() side is the
key to fixing the issue for our case.

On Fri, Nov 11, 2022 at 11:50:26AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Here follows a few more optimizations for lseek and fiemap. Starting with
> coreutils 9.0, cp no longer uses fiemap to determine where holes are in a
> file, instead it uses lseek's SEEK_HOLE and SEEK_DATA modes of operation.
> For very sparse files, or files with lot of delalloc, this can be very
> slow (when compared to ext4 or xfs). This aims to improve that.
>=20
> The cp pattern is not specific to cp, it's common to iterate over all
> allocated regions of a file sequentially with SEEK_HOLE and SEEK_DATA,
> for either the whole file or just a section. Another popular program that
> does the same is tar, when using its --sparse / -S command line option
> (I use it like that for doing vm backups for example).
>=20
> The details are in the changelogs of each patch, and results are on the
> changelog of the last patch in the series. There's still much more room
> for further improvement, but that won't happen too soon as it will requir=
e
> broader changes outside the lseek and fiemap code.
>=20
> Filipe Manana (9):
>   btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's i=
o_tree
>   btrfs: add an early exit when searching for delalloc range for lseek/fi=
emap
>   btrfs: skip unnecessary delalloc searches during lseek/fiemap
>   btrfs: search for delalloc more efficiently during lseek/fiemap
>   btrfs: remove no longer used btrfs_next_extent_map()
>   btrfs: allow passing a cached state record to count_range_bits()
>   btrfs: update stale comment for count_range_bits()
>   btrfs: use cached state when looking for delalloc ranges with fiemap
>   btrfs: use cached state when looking for delalloc ranges with lseek
>=20
>  fs/btrfs/ctree.h          |   1 +
>  fs/btrfs/extent-io-tree.c |  73 +++++++++++--
>  fs/btrfs/extent-io-tree.h |  10 +-
>  fs/btrfs/extent_io.c      |  30 +++---
>  fs/btrfs/extent_map.c     |  29 -----
>  fs/btrfs/extent_map.h     |   2 -
>  fs/btrfs/file.c           | 221 ++++++++++++++++++--------------------
>  fs/btrfs/file.h           |   1 +
>  fs/btrfs/inode.c          |   2 +-
>  9 files changed, 190 insertions(+), 179 deletions(-)
>=20
> --=20
> 2.35.1
> =
