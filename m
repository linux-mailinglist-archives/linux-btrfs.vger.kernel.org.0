Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDD23E5061
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 02:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbhHJAgl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 20:36:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25572 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHJAgj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 20:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628555778; x=1660091778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OwaJcCGGk5/9g1aK7/CUeaIOg54qMb5luztG0P7zxYM=;
  b=nnt/h5eedJItknRstL2Tg/8jO9ZmhNdEnfMq9A69Flw+jotXdAXsWra3
   qo0WqIxEdyF8WM6F8lmK7aoZLBX+0oVHubsvqKR/hQOBI5MC6ebctuaw6
   5bDpYeFTsHcZVpmjbAYTz+mu6Ye9DAMT1peksV1+JPM+kE27XWOCtUh1i
   cq1XD4jjbpW/MCNHUsahW7tDK4kPOdgnWnK0eg4ioUPivdTXjBBOD8CcJ
   boaXeZaILqblN7SIkvFkQlKQtS2ZgXAP/rDuNhgkaGPzGCrV1zEhahOrO
   UB3HKc+3kOx344kzA7VEhyFUSdOzYb4idiCPh4gh2U6p+1dFHfQ7HZaIL
   A==;
X-IronPort-AV: E=Sophos;i="5.84,308,1620662400"; 
   d="scan'208";a="288314303"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 08:36:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKc/DIfoLpO7Ser9M1Juy/wjd3SAsoBaRSP1OrcBkv5WtLtG9/E1rqUvxBURWm+qSr8IvWIPMUwuK6dMSw6+NY2lG3UoH0Lj8mM7mkPLUXMfMaNUjU5XM2WdHquK05ZNQw3km5pOSQvgkn4dWQb1vodVcIlfNApFtXGIptfiDSXjV0fAc4D0ijp4aFXX3FGmB4lr29B7rlXw0Au9L0O9b9pKgKX9Ht1tdc74rrCzZoTUOiwScADO9ccbeH9b3WdJ19HeMdhXahc5i/A4cdrLR7PRAJ7cCar5B8QNDGqG/8+cYbR+lHqWVIUSqCobhKQUvZlQZ9Ck8MRaKG8zaeozEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnRshPqfa0sibLXlgLHeV6LWzX8J92/NHFzL+Ke9Rgo=;
 b=jyONKJj0iqwlu7voBP+Buu9+uh+jXoo8y2H9e7yDlyDZdc2bGTvh8TC91FOpIcRQfN/6wXZX8jh18ljYSXn7ysFGs2V1eGrBct568fSGHny2oZVpLxxqnaxj2MKCc5l3Q/naN8UYJvx7Fu7NnAT80CdgTdgGb/frCZiJyC7ohcx7MXmKWnX35z7KxMGg5i2Xa5RnYbgHIrSKwY2EEnp3JAM02cOaOVR9FL9IT6GCD6LNvffk8o+dA8vIcvuIlQRPrBStY9JTp6XSBBtCo3dUqs0KrBda4mTCwxlZ2HDd3XzYWbGE8qY2RF2Qio3EVdTJ2KTm6QsD8L+FcVbfHBXqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnRshPqfa0sibLXlgLHeV6LWzX8J92/NHFzL+Ke9Rgo=;
 b=MWurBlimi3402QtkzNuh9KGiHbrIpUL2KLvf0ANlnsBr+HYJJs/kXqMRIf4qv9aU687eZB341aIVcKaEcZNu1fNDI39QF+lNJrIVWdcNpjGjX/QmTVBYzcNj0n1vEEnSd6Kpie/TlmHm7g/0mrQHFuQjdL/VgilgrMiVSe7oh/4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8359.namprd04.prod.outlook.com (2603:10b6:a03:3d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 00:36:16 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 00:36:16 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Topic: [PATCH v2] btrfs: zoned: allow disabling of zone auto relcaim
Thread-Index: AQHXjRN9UIG4WzfEOkWkC2HI6HEZQKtr5U4A
Date:   Tue, 10 Aug 2021 00:36:16 +0000
Message-ID: <20210810003616.l4im4v4ifzrwlotb@naota-xeon>
References: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
In-Reply-To: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f76a7e-1bfa-4bb8-1628-08d95b96dd74
x-ms-traffictypediagnostic: SJ0PR04MB8359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB83594E8EB88CE6AFDE727FAF8CF79@SJ0PR04MB8359.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uikU0cHTkKQP5OVO26DynpidW95wO0UTm+7raS5yOcNrfq2EG3xsDxKafuodel73FDcVplQNbdGzwC7eX7DBk/ff9G8Cz2zrF44F3bd/3FomzyY2ruNy3MY9C00mvE6lwgmSJUh3PZbNdqEknX9NacEd6DnGYLXry5ZK+GsBAwuis2TlPA4euCoMmRTJzQQM4Ybe9W7ecDFdqxEk2LY49V+KJF/T8AmSIIxtJLZlxe+7h1UdZDtpKBYVRYDL97rvyq1K4QmKV5mwRzPuF9eeBgFhimUkgEeng/LSj5kFv2naLb/y7BxEc8JRPA2HNEzwZoZCx9++GDYwxZjjfnzJQUuFRK6d6hqbgtAEVqe64yqqQfirkRIDUZQhBZD0tb+Da5/phOr5/q7VRvYw1ida1KM2wh5B72N2NV+z+nw/maFBmLsFsscFiLBdTHv1MRVPLjnABfo2Fk9Myl4+xCEH/z/RDUseIpYX4zWhlXSbuQ6yNPTJ2DQzWxvNN7gUicE6HYoQddzKinEvbs4fzAD/3QC1wh+8LaLgJhFEXgk7IjyxTGVOvmN/mrx4XuoVfcOAyXzYJQ3n1V7zN7HRuG7WM3RdlPxj8kgev10dNQ6QgwxOPzkZP9t7lLwUE3elX6XnNKjlcWalROB94Q1EN4REcj5BR1BLS8axpo/MYZzikaG6Gch3tspsdwB5/GnL7peov/AKtfPQdzJtqb92DJs/Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(66556008)(6506007)(91956017)(64756008)(83380400001)(66446008)(6486002)(6862004)(8676002)(71200400001)(76116006)(122000001)(33716001)(38100700002)(2906002)(4326008)(66946007)(66476007)(38070700005)(478600001)(5660300002)(86362001)(8936002)(54906003)(1076003)(6512007)(316002)(9686003)(6636002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8wgplzLLxiGmbiqUUUt3ePpnPZZCeN/rmUTfHhGhyoAHcpD+cII2RN6zyhzm?=
 =?us-ascii?Q?YZD3AYzS1+Z1V3zlQusYcJPR9H8FMu+UnAcyhKJNdwq6EZUkMg+xOLtrcw5q?=
 =?us-ascii?Q?4rHbn98+6whYdbBUb28UTQNFw8lfu70TKTIbDSJ7IIiCP7ylNnE7utvnSQX/?=
 =?us-ascii?Q?xcbBkOnCRMdYMiSXtUE9aOUgqQXbdHUUR/OBYq5LHGcmr7SesFV9fRNmM6Vg?=
 =?us-ascii?Q?g/Y6fPZqS2R3uUkXHCTibjYNYE6MrABmU3Z7iULBcVP9rCEQF8thu8hEI1EV?=
 =?us-ascii?Q?+qzq/uQVg9ZlxUBiOQxuiI1Q+MLuLwTOli8I4iTLt06rqURCFRp9+VHxEjjv?=
 =?us-ascii?Q?1sJbogG6X51ZfnMXnFC42WNMLrGUAauvjIlPcNgIggrLUtD62e9R/5VFLMRR?=
 =?us-ascii?Q?r7/cXFcfEADhzhADkfTROJqAafxMCiEhBalrs8xFklFHSyaYhQ1eHJWSiIF5?=
 =?us-ascii?Q?0/4UDI66i36toXG/zfneCxUmZrNBhUli+l1k9yHn/OSCwTsug7vGK1QGCi3S?=
 =?us-ascii?Q?k02nJ3p7m8TC9fbLcgxZwjEhkycYW+T64pgLE32M80AtD6AUWJHEmi5GTdD+?=
 =?us-ascii?Q?q0oWxdYb285+akrGGKObxIxaVpXGKGWQEyjmOc721cL1OFWtm+NDix2KLSEu?=
 =?us-ascii?Q?zqZelkttohvqNK9f1cOJIUxI1rqytCWeIEZOpKX91KZGUQlmDa0D5ypy6XUF?=
 =?us-ascii?Q?hOFD4D4lbbKWw7lngR85ek0TUegbKf95qTdtVNh7P4PwGJ/uVeCQAFy2AHs/?=
 =?us-ascii?Q?Fpye8LIORpygURN+cCYx9fy7Vpc/P0elyZZLGBL9DpwwmbUX2u8mRPpMkdzi?=
 =?us-ascii?Q?laObKXVmEd2Rh5jTZ58tAdWZihirFS2AecG+Fn8A75eGnO7oPiTuULITCsxQ?=
 =?us-ascii?Q?1nxf4qPscqGi7IvB3reLoGlFXBfffJetloW7H6iEwMUF2XtxqvXgbM5CkkkU?=
 =?us-ascii?Q?2ZEggnXKZfz9RL0t8GVBGNZ29diUJ1Ep/1GZKRrBfZsvwK+w4bzOeGGEGqXD?=
 =?us-ascii?Q?LaMUoO9+JQNaapR5EWl3VCu/JUVj8QXF3dYqoUcsh5UIQ15K1RlJxQriJyGJ?=
 =?us-ascii?Q?YOd/SIclkNyOulY7QQjmlhnZzbHSp27J8n4IYe8tZyZ+015BEFHUu+7VtUOX?=
 =?us-ascii?Q?+13jtSjqZRRxA4TOA/ltsSpZfnTDkyFcNtwf3ZfDWzXlzawvMlxqHi2JEfWH?=
 =?us-ascii?Q?FMXep5/l8WFSgu9CCIg/pkobtUD096y29RknNlZZK+Mdqm0qO/WMd+3HdPF4?=
 =?us-ascii?Q?HuWOjcFEp6cInmcUn7Lh5ad+rgsZQPuYAjlKKfGzTd+P20ACtqVIrmreZP5H?=
 =?us-ascii?Q?U0poYuVPzrD85pf6WXGIL0hd36oFO2rxHykBxP9eMsHBAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22BB52C87D31E940AD7EC0F7556E113C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f76a7e-1bfa-4bb8-1628-08d95b96dd74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 00:36:16.7135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq6TsnrlDcLH9DlOwx5LqTu23IRuRTFPHuWvrvjg9PkHhGTYdQQuwb+FyprhcDKQeFGu70b9r85sPvx+913uZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8359
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 08:41:17PM +0900, Johannes Thumshirn wrote:
> Automatically reclaiming dirty zones might not always be desired for all
> workloads, especially as there are currently still some rough edges with
> the relocation code on zoned filesystems.
>=20
> Allow disabling zone auto reclaim on a per filesystem basis.
>=20
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> ---
> Changes to v1:
>  - Use READ_ONCE/WRITE_ONCE
> ---
>  fs/btrfs/free-space-cache.c |  7 ++++---
>  fs/btrfs/sysfs.c            | 10 +++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8eeb65278ac0..05336630cb9f 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2538,6 +2538,7 @@ static int __btrfs_add_free_space_zoned(struct btrf=
s_block_group *block_group,
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
>  	u64 offset =3D bytenr - block_group->start;
>  	u64 to_free, to_unusable;
> +	int bg_reclaim_threshold =3D READ_ONCE(fs_info->bg_reclaim_threshold);
> =20
>  	spin_lock(&ctl->tree_lock);
>  	if (!used)
> @@ -2567,9 +2568,9 @@ static int __btrfs_add_free_space_zoned(struct btrf=
s_block_group *block_group,
>  	/* All the region is now unusable. Mark it as unused and reclaim */
>  	if (block_group->zone_unusable =3D=3D block_group->length) {
>  		btrfs_mark_bg_unused(block_group);
> -	} else if (block_group->zone_unusable >=3D
> -		   div_factor_fine(block_group->length,
> -				   fs_info->bg_reclaim_threshold)) {
> +	} else if (bg_reclaim_threshold &&
> +		   block_group->zone_unusable >=3D
> +		   div_factor_fine(block_group->length, bg_reclaim_threshold)) {
>  		btrfs_mark_bg_to_reclaim(block_group);
>  	}
> =20
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..7ba09991aa23 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -984,7 +984,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct=
 kobject *kobj,
>  	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);
>  	ssize_t ret;
> =20
> -	ret =3D scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold=
);
> +	ret =3D scnprintf(buf, PAGE_SIZE, "%d\n",
> +			READ_ONCE(fs_info->bg_reclaim_threshold));
> =20
>  	return ret;
>  }
> @@ -1001,10 +1002,13 @@ static ssize_t btrfs_bg_reclaim_threshold_store(s=
truct kobject *kobj,
>  	if (ret)
>  		return ret;
> =20
> -	if (thresh <=3D 50 || thresh > 100)
> +	if (thresh !=3D 0 && (thresh <=3D 50 || thresh > 100))
>  		return -EINVAL;
> =20
> -	fs_info->bg_reclaim_threshold =3D thresh;
> +	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);
> +
> +	if (thresh =3D=3D 0)
> +		btrfs_info(fs_info, "disabling auto reclaim");
> =20
>  	return len;
>  }
> --=20
> 2.32.0
> =
