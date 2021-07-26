Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D093D513A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhGZBkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 21:40:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4893 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZBkJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 21:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627266037; x=1658802037;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Llnq2cDRdn1yCnx3gzswWo88K4FVV15rPZImRdGKA1A=;
  b=Lf6UtzDsu/n+dcdd/5iKJ7h4uZIZ/jszCeMAENz3/AQEscw0Sw5UM1jI
   HbZFB6qfHoVKrfiZ9xJrtgTTN+SE8eyTZhGbTVTvTBDgX//ZwLGxlbDQr
   ivcWOedahWMarJVZkwvFpEcKP2bVJo9+ouimZ+HSrT4Jp42GuflErP/iN
   R6GYQ0954KOsCKJRrujZvmBV+nR3UjkOPHOK4VJDL1TD53oaDAo9JOj73
   +31hfA3Rcdl7wPLhi9PF1I8zeyIsMVzT+SaQrAd74FxLsKTClXtSK8zmJ
   hhc7hn5iKf4mNg9WLRT3z0nOik/CMWmjquU5IEgTC+u8S0+WoDb/MKXZG
   A==;
X-IronPort-AV: E=Sophos;i="5.84,269,1620662400"; 
   d="scan'208";a="175463836"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2021 10:20:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB7cTPo3y4AgvS77iDtfPxFMQVW716Hrkuw0GzGinqwDdDdsNmVb25XMuKD15yGTHXk/C6XVAa0wFmpcnZmZSokAfemafPLoHw4eRKzFqC3UEme3aFKFyxdtlvVlcbmgudXylRpjBFg90VAJzjVY+kgx4msIURjECwgmWniUpQqTQzDCTsLlYnjxxoZozltbd0IOq9LlgBKukEU6gBmNeEmQMyD2mOohqjDetdXBcAimjYr06SybGKT7CCfaZ5pJlu4lUGZ+wp6QYNyP5c3EPKbeTI1kKzvGcj4QfYn4ZCdSuLZYSnHz05g/CYb+I1Eu/MMdnqfeURCn4l6fvTVQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEagqNbu3InuqTW3SN8cfkohty69DjkSTYJcZObOnms=;
 b=newGUFnSouDsZhvgLmhUBVjiiWrlTvTwHZCE8hC8BGNGD9FBiz6r1xiZZrLqqwckImzxjYm0HQ/LsLrq/05MEP9XM3WZqbQVDHH8b66IXF4GYZpNiscJatPSAVtmQ8SgyurRUC8wWn/tww6msz0kVCXmHp+VGBMLkddizU7ELHBpeE8Qb+5FQmYs0+WinH0TAxQleMcLmdrqcP/x6xj8MKhhfw/TbBobFLFnIvrdCleKt6yGiB8pzlFISainSwILQ/D2Yy5ilAcPLKD1VEzsZhCzUyh06fLhzxBBYOvX6UKDijCr/bsFZ0bmT3b+CcDTemUP/eOeKoTE00ezOhj/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEagqNbu3InuqTW3SN8cfkohty69DjkSTYJcZObOnms=;
 b=Mr06/IsnDf8QLCwFPB8Kw0H0Wfg+eEMY4+pVMFe94pBc3mJZzWnTadhbh6kaayFHzzfgZ56/hlmL482Im72hLyV1K+xlEBlHaoLAmE/THJd30KQfduimKBkmsAjFR26vIKmImuWXghlSLfD7tCiwYxO60EuJrKuGED+xr6hLz/A=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5100.namprd04.prod.outlook.com (2603:10b6:5:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Mon, 26 Jul
 2021 02:20:36 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%8]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 02:20:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/10] block: change the refcounting for partitions
Thread-Topic: [PATCH 06/10] block: change the refcounting for partitions
Thread-Index: AQHXgFu7zJ2Q1gh81EWRznbYLJ+kgA==
Date:   Mon, 26 Jul 2021 02:20:35 +0000
Message-ID: <DM6PR04MB708159627FB52CFA496666BFE7E89@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724071249.1284585-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bb89e6a-4d5b-47c2-366a-08d94fdbf40e
x-ms-traffictypediagnostic: DM6PR04MB5100:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB5100F09EC3F93AB03A8D88F6E7E89@DM6PR04MB5100.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fcpXj+84gFsDKf02LpCwexGNS5HSuJk4zw1NDkfhtGTlVUPw05LMEXOrA0MsAQlaDbpu2hfI8L4DosiW/rZ/gWIusnDhtwiUVt1PtQcdQC8rJeWawB5/kC1vBHGrdWcLDfQvsZkN7kZ42jqEJWvGN/nyiGFfhKwUxR4bptQEll8K6BdKJiPjEVS5GjIdTAxRuou5n+DXdee6O47RXTVm+3pKM52239PAraVgnHxCFOQZKbdHYZ4jOlsAu9f/ikEAqoAQbomjJPgwiprdFB0dxMlNsfr5fR57vdBUqvO6WJI/A7+4kUHzYakoDSq00XOx5NJ/zj5JvEmxKdt/joN3gn8pNE6ezJiDcZVwpaun77E2BBcboEcpkwkCgGK2GO+sOELeafutJaItEn6jhId3f77JNTbO4ou+CR1ZZ+5i78hEzCRB1Vq5BbvvB2/KIV8vBrcYg1wuW0JWkRLMrbHMswv5QR+7yl40am8l2nA3iO7BltsMwHRe8SJmZKDnXzHHHuzFi0D/KMv9kwIguRdh7ZrXC3kc7SDJ7pD0jJrzCcDuf0yxLC4hw5knB4g3HyS3FVPWr9ZJAJozu1r/yGbRntmz3VcdcppZO4UzweroScpK+NIMraWEhdKAJE6ItDcLXMzI4UTGt+mfi/u/9PxwgV24IVNI8eG1VL6fRG++4tYaQ+kDI9L5LykCWcDlL0CY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(55016002)(8676002)(26005)(6506007)(33656002)(66946007)(478600001)(76116006)(38100700002)(5660300002)(66446008)(66556008)(66476007)(91956017)(64756008)(8936002)(186003)(52536014)(122000001)(86362001)(71200400001)(2906002)(9686003)(316002)(83380400001)(54906003)(4326008)(110136005)(53546011)(7696005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xmhS9ttonWLbCMKCMTxXwCnUj0uZwlHavIvb9rfgAyuTx6RIAvmY0wjOX6XD?=
 =?us-ascii?Q?yW6bIQ1Hg/fC+wczNy1Vr9Nyokrt5nzmA+TqbNo95hdNZP0vDZ04cpXMiJZ/?=
 =?us-ascii?Q?Hesv7ooPj5eRs4ud1mue2uEjnyF9CmfztomKvxZxVZkTxEbq0oweP/G1kB34?=
 =?us-ascii?Q?J1lXb93E6jhE46eISfqVtFbjqUh3miknrNDcNafrWu6o1+iN8NZe7/fOPRSo?=
 =?us-ascii?Q?Bk8pHwldclelI8CA4O20IHTim/LZ18KTnL78mrIm2V5jVIWFxx0i1zxRPGMa?=
 =?us-ascii?Q?TEuXYokJxJXTXIjtZaUO56XOqw55dsu+270vI9MlH9ZagcKSlPKIhcfoIxWX?=
 =?us-ascii?Q?2myukTMd0mZxtT6v4o0k5CRkxMGNWXF/Z8iv3b8UizWXhXfsgnlXmCdl4JIq?=
 =?us-ascii?Q?J0bzA/0iB1Q76SQvfEoQc7Idc5Uu/qgW7jM0hZF/Fs3hy47nva0uJCuHxoQj?=
 =?us-ascii?Q?DiQfjVrrZMz4s7cw1ju/RaPq/kpOLvBTsGpzu+Vp5i2lx7kOYPjXQR1h2GPQ?=
 =?us-ascii?Q?LoW4CPGnU7a2Ktj5O5kTsMEZA01gmqOdmKklYva52qpB+hemWy63o/Nv0VhO?=
 =?us-ascii?Q?33/N1p9dZ8KJa6iV8xEP/IS8rpjQavVq5pyYwpnsJl/QfnWWSpkFK/6sJ7Nw?=
 =?us-ascii?Q?MmGu7hCSfY9EQ0b3xZDzW49/MOUMCOTQqX0fcE82c0VP51tHW5+HKQAOupQ4?=
 =?us-ascii?Q?gulM2ueKQnrxDhS4EQrEX6wmxT8O1FFCwHp4LbtUcxHMuFVQiRe5bji86FCZ?=
 =?us-ascii?Q?DG2SEuY4p9n36sInLNZOplxoVUFn/QQ0s1MNDncKvsoYs/f45elSft5C0IMy?=
 =?us-ascii?Q?GPujQDA+y5xgzhsJ9xmPA0RreYm3Kido0AIEYY6RNFfFBC6VNj8L6KbZlvXt?=
 =?us-ascii?Q?IdPk3D74ysKPDNqU4iUw0eIsV7Qb5nQJKYmLZoy2pT+/BUy+ZZfF0eJPaoou?=
 =?us-ascii?Q?RDSuBw4V6a4t1oiy9Wdt211CNlWynn3dX64BuMITMXFfPB6StTo7hLETu+I9?=
 =?us-ascii?Q?Zrm7pZu6jI+Ub9O01M2dCDfsIBIkyunKviArlY4jwuNNLDzs4UcrBGObzuW8?=
 =?us-ascii?Q?PlYtvxj1m6Ffg3llu/Kki7sBk8n5niY7KdcM62NwSpiAOfRpHH5D4Zspz4HO?=
 =?us-ascii?Q?BRbNE9DmdBv0FtlDjTVxYigKWzl6eweNJtC2kz5YsAGEnT+Hh4gaA/2j7xef?=
 =?us-ascii?Q?ynE+QgvuIEgywhgUmnQLd9WLWRrMCgONpOf9u0z0KrOegcL3whNVPjH4GjjZ?=
 =?us-ascii?Q?iURVChF9GceYZxO63mg2bLsQaGmKR73+At0f1fiyyGKfV00v0+5xwsXfoyWx?=
 =?us-ascii?Q?HaPLMVNBbx39vTaYKg7kWRzfi0cxzNkujqri2iy7gNk/9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb89e6a-4d5b-47c2-366a-08d94fdbf40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 02:20:36.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDuJpL2PFJVpY/+aPdTOHBYpj7Gol4LIl3vkTrvBTaXne3Ep9O2ruGconYdgSHmSyoQN2qigNZLmJ/mSNNmEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5100
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/07/24 16:15, Christoph Hellwig wrote:=0A=
> Instead of acquiring an inode reference on open make sure partitions=0A=
> always hold device model references to the disk while alive, and switch=
=0A=
> open to grab only a device model reference to the opened block device.=0A=
> If that is a partition the disk reference is transitively held by the=0A=
> partition already.=0A=
=0A=
Your SoB is missing...=0A=
=0A=
> ---=0A=
>  block/partitions/core.c |  4 +++=0A=
>  fs/block_dev.c          | 60 ++++++++++++++++-------------------------=
=0A=
>  2 files changed, 27 insertions(+), 37 deletions(-)=0A=
> =0A=
> diff --git a/block/partitions/core.c b/block/partitions/core.c=0A=
> index ae88b5439056..1b02073a2047 100644=0A=
> --- a/block/partitions/core.c=0A=
> +++ b/block/partitions/core.c=0A=
> @@ -261,6 +261,7 @@ static void part_release(struct device *dev)=0A=
>  {=0A=
>  	if (MAJOR(dev->devt) =3D=3D BLOCK_EXT_MAJOR)=0A=
>  		blk_free_ext_minor(MINOR(dev->devt));=0A=
> +	put_disk(dev_to_bdev(dev)->bd_disk);=0A=
>  	bdput(dev_to_bdev(dev));=0A=
>  }=0A=
>  =0A=
> @@ -364,6 +365,9 @@ static struct block_device *add_partition(struct gend=
isk *disk, int partno,=0A=
>  	pdev->type =3D &part_type;=0A=
>  	pdev->parent =3D ddev;=0A=
>  =0A=
> +	/* ensure we always have a reference to the whole disk */=0A=
> +	get_device(disk_to_dev(disk));=0A=
> +=0A=
>  	/* in consecutive minor range? */=0A=
>  	if (bdev->bd_partno < disk->minors) {=0A=
>  		devt =3D MKDEV(disk->major, disk->first_minor + bdev->bd_partno);=0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 932f4034ad66..4a6c8c0a3bc9 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -921,16 +921,6 @@ void bdev_add(struct block_device *bdev, dev_t dev)=
=0A=
>  	insert_inode_hash(bdev->bd_inode);=0A=
>  }=0A=
>  =0A=
> -static struct block_device *bdget(dev_t dev)=0A=
> -{=0A=
> -	struct inode *inode;=0A=
> -=0A=
> -	inode =3D ilookup(blockdev_superblock, dev);=0A=
> -	if (!inode)=0A=
> -		return NULL;=0A=
> -	return &BDEV_I(inode)->bdev;=0A=
> -}=0A=
> -=0A=
>  /**=0A=
>   * bdgrab -- Grab a reference to an already referenced block device=0A=
>   * @bdev:	Block device to grab a reference to.=0A=
> @@ -1282,16 +1272,14 @@ static void blkdev_put_whole(struct block_device =
*bdev, fmode_t mode)=0A=
>  static int blkdev_get_part(struct block_device *part, fmode_t mode)=0A=
>  {=0A=
>  	struct gendisk *disk =3D part->bd_disk;=0A=
> -	struct block_device *whole;=0A=
>  	int ret;=0A=
>  =0A=
>  	if (part->bd_openers)=0A=
>  		goto done;=0A=
>  =0A=
> -	whole =3D bdgrab(disk->part0);=0A=
> -	ret =3D blkdev_get_whole(whole, mode);=0A=
> +	ret =3D blkdev_get_whole(bdev_whole(part), mode);=0A=
>  	if (ret)=0A=
> -		goto out_put_whole;=0A=
> +		return ret;=0A=
>  =0A=
>  	ret =3D -ENXIO;=0A=
>  	if (!bdev_nr_sectors(part))=0A=
> @@ -1306,9 +1294,7 @@ static int blkdev_get_part(struct block_device *par=
t, fmode_t mode)=0A=
>  	return 0;=0A=
>  =0A=
>  out_blkdev_put:=0A=
> -	blkdev_put_whole(whole, mode);=0A=
> -out_put_whole:=0A=
> -	bdput(whole);=0A=
> +	blkdev_put_whole(bdev_whole(part), mode);=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> @@ -1321,42 +1307,42 @@ static void blkdev_put_part(struct block_device *=
part, fmode_t mode)=0A=
>  	blkdev_flush_mapping(part);=0A=
>  	whole->bd_disk->open_partitions--;=0A=
>  	blkdev_put_whole(whole, mode);=0A=
> -	bdput(whole);=0A=
>  }=0A=
>  =0A=
>  struct block_device *blkdev_get_no_open(dev_t dev)=0A=
>  {=0A=
>  	struct block_device *bdev;=0A=
> -	struct gendisk *disk;=0A=
> +	struct inode *inode;=0A=
>  =0A=
> -	bdev =3D bdget(dev);=0A=
> -	if (!bdev) {=0A=
> +	inode =3D ilookup(blockdev_superblock, dev);=0A=
> +	if (!inode) {=0A=
>  		blk_request_module(dev);=0A=
> -		bdev =3D bdget(dev);=0A=
> -		if (!bdev)=0A=
> +		inode =3D ilookup(blockdev_superblock, dev);=0A=
> +		if (!inode)=0A=
>  			return NULL;=0A=
>  	}=0A=
>  =0A=
> -	disk =3D bdev->bd_disk;=0A=
> -	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))=0A=
> -		goto bdput;=0A=
> -	if (disk->flags & GENHD_FL_HIDDEN)=0A=
> -		goto put_disk;=0A=
> -	if (!try_module_get(bdev->bd_disk->fops->owner))=0A=
> -		goto put_disk;=0A=
> +	/* switch from the inode reference to a device mode one: */=0A=
> +	bdev =3D &BDEV_I(inode)->bdev;=0A=
> +	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))=0A=
> +		bdev =3D NULL;=0A=
> +	iput(inode);=0A=
> +=0A=
> +	if (!bdev)=0A=
> +		return NULL;=0A=
> +	if ((bdev->bd_disk->flags & GENHD_FL_HIDDEN) ||=0A=
> +	    !try_module_get(bdev->bd_disk->fops->owner)) {=0A=
> +		put_device(&bdev->bd_device);=0A=
> +		return NULL;=0A=
> +	}=0A=
> +=0A=
>  	return bdev;=0A=
> -put_disk:=0A=
> -	put_disk(disk);=0A=
> -bdput:=0A=
> -	bdput(bdev);=0A=
> -	return NULL;=0A=
>  }=0A=
>  =0A=
>  void blkdev_put_no_open(struct block_device *bdev)=0A=
>  {=0A=
>  	module_put(bdev->bd_disk->fops->owner);=0A=
> -	put_disk(bdev->bd_disk);=0A=
> -	bdput(bdev);=0A=
> +	put_device(&bdev->bd_device);=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
