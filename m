Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0085B077E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGOvO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 10:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIGOvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 10:51:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBACEA720C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662562270; x=1694098270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S4lQNzRgg0MwUXdHpzT2JlwIY3Y4mMOUCGSSQMXyN1Q=;
  b=CzDk3T0KFnERB+sUMp0JuuO9wUakBiwR8nKsnCfHR+rjLSAiLtRHK3Cb
   ahpyFKi6VOrMh9tXdXZbRIRcdHUvH3Cr6VJmABcBLFi+6L45pDsqohBKV
   5ikFgcp+T5OKSmM28rR+YI5GxBBuILkk+J1KcGzlEzOLiPpq0RKRdsenC
   8BOcSeii+qC7CZFlOIcNvnscQrXoylz9+0PYU4dycm8AyMFocYHxrl3d5
   AudqOJEg/oYUBeNa9INc6JFk2THVeEtLWPA+mAxjVQ1ZvjihFYlXpqzjQ
   sK0F5xGL/m81fFGlYwyiOmvj3oXRh/yOIEAu5DaoVMHjAPSAoYTDh+pk1
   w==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654531200"; 
   d="scan'208";a="215907698"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 22:51:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1HIK2sSIdWWfIgNX0w8LotWJDZQJdxpTtIGtLl200mAVmynxmAYM+rfed/5WMrD7IDT3Ng702ELx5j7GR0G1C+MT97y0RBM4dT/sbv8+pogpRTY2CRsH8siuZ0YnRYX3XaXo36Nncp5sncJMqc3RmlTd8Nh9ud2L4qVYOyaFjb9gThEiaOM+kW7rSCP+9+dMa8fh1r5nJIiEDeYlJsmSQAwJOu7du6W9uIEI2HJkSnRpKAYUdo9uIx3mpBo42uETR/i2/MK90yhRIcp5BvODVD/L2ETd6PyE3W3GxIgfRxmIY8dES3fLFKinoMyyLpG2p3JY3yXOc723mT/+VyAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWq5oj+Trfa9GWAoXZd2YEzhAn939f5nM0yHZQrOlKo=;
 b=VYeEOUaAC4wlHbevvwPbgKtiVCzHP4KfCG83u+LCf1a9oOp3a+y+voS18mgvN4to3NQqxoEoR7Y2kek6qmEsl7za5dccbC6poIl98hE1yZq22bFGVO33z+C6fDzTjqqLvF6tCT0J4h5Xt5j+p6WHIthUG3L4B+01Y1Nujgx5aU9rlrwgzJZ1FRcXVeeQIL5hTYJQgqyR7xSKA0Ro7nRjLvUXht9I39ZAqaPyYVGkM9+8RmQ31o315GdsvzNOzKSTsf7/t7eKOsy4UKCZwk+0ILKG8T7lWe1DO0zsOvbZ2lbjI+xfzG/yeycaGvIvWbyk/XTim5AKh9Wp/DbIRyIbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWq5oj+Trfa9GWAoXZd2YEzhAn939f5nM0yHZQrOlKo=;
 b=iyAuCsYQDGsGQn7PegJXrsUFGxSjvtM70xqnRFD6UrdYyXE73q76firmlHvCWK4dk4jaDMDbd8hQ1aqDsdRacGV27IuvM0ETApNp5enMzfHBXIrNg6pBBC8xRmnVa1e+q/91nwaRaLuTNeKBlD8S/fzUX/+rZorip9QFzdWGwZ0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR0401MB3642.namprd04.prod.outlook.com (2603:10b6:301:79::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 7 Sep
 2022 14:51:07 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%7]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:51:07 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: refactor btrfs_check_zoned_mode
Thread-Topic: [PATCH] btrfs: refactor btrfs_check_zoned_mode
Thread-Index: AQHYwptdS9fbJ7WOfEiDZE4T8HUrUa3UDU0A
Date:   Wed, 7 Sep 2022 14:51:07 +0000
Message-ID: <20220907145106.pq5eki5wusaluomi@naota-xeon>
References: <20220907092214.2569409-1-hch@lst.de>
In-Reply-To: <20220907092214.2569409-1-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MWHPR0401MB3642:EE_
x-ms-office365-filtering-correlation-id: 89e67680-d34e-4e5f-2652-08da90e06582
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l18clgEtxhxXF11d8pAOslpNOlsgKioukrJ7ImkRlLh6A1qwRwQbJKQ5uUn5qhTC354sNGtDZzZJBnpSdi2ffkW3DMADowDQ7H8k3APVbYyvdjtHtHLhc2l9bTv6UibnpZLj46UZhwqq1CAyY+isiVvj56h17maZsjTkScRnTuvGC/SwZCW4aa3VgLMQaObFYuA3vFq4cMCU5PH1CQg0KtmNhYMQi44SI6Ltwpsqy83z65rRQKWAovrv8P5fhtfiX8uPMmCdeNoxXwqrQwKC+Sk+TnRt/XoKWCjmF16ArxOfzADQZfdkRnGMl3TPrl6L2CPZronoThgdcXN02QMLoT7XZjLhdFJ592mfpIYIU+2XVVVsNNpGScMkjqC7aNi811ccWVig6419diCW/cWrMZbjJ6jJS79DJSIoX2EDOEl0go5it8tgcP1GbzYL0+mZgf4q5njKXV9JQe0JIggCi3XsoDfBEvV5fzwgcR+kD4KYR7s+JQy4IeoA28dPnD6bQjQJr7woW4tXMQ6fnn9H4HUuBOtDBNOYMEq8YG0LSQI3C7hPWarKfK2+8pRbO3gGrxehoTHzQlWdcM+lRsnR307fkApDhmVYwYMAt7Y1RGp3Z7kgBKihrMNlznQNhFo9ws47q3x2tHSHb30QfVNNeeq93wvgfpl9UinXrfm4EXTGcOU18AVigqb6+UsnQWxo39185fh3lA7mCb2oJ5EJyGw/m2zsFGxug1LWrsa0YbCia6oWS8UAlvQKMcyDos4GQleSk0ULRctQTooxG5xSxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(91956017)(8936002)(66446008)(8676002)(66476007)(5660300002)(66556008)(66946007)(6916009)(316002)(76116006)(4326008)(64756008)(1076003)(2906002)(54906003)(86362001)(41300700001)(6506007)(9686003)(6486002)(33716001)(478600001)(71200400001)(26005)(186003)(38070700005)(6512007)(122000001)(83380400001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u6zKDGsqfucmJj3RhnzqXzgdmf0/Wwym611tMe3dfqnnQ8wLP9bIauWerACY?=
 =?us-ascii?Q?mS9+kjzthyNuK4+mWAqPQ7bFQbxlDqupkChl6ZXNPDYwWwPBfDOBr1BoxURP?=
 =?us-ascii?Q?TRsFtp9KI/lt9jbtAGT5L/JAkH2dYCrPldaWlhl2+u5HGZdnGJ1CmSxUhMVY?=
 =?us-ascii?Q?hle0HHRDqjiuN5WStg21hg/oPIOzAfwi9Hzg9PXv+Yg1+ifJz6YNewf6YEJm?=
 =?us-ascii?Q?Hod/7esX+KPsLDYduGR3W7tV1tCqFP7Yvi77doH+awbZ3OOEoTPFtXG9Nuvw?=
 =?us-ascii?Q?TgAp3FcLRzjzRwNpIzL5/s96t7CpywWk0ii5E+GVUmLqxmRN5Gb2UEW/6W1m?=
 =?us-ascii?Q?WaxaOeqRBt2DTzvzutUxpZillZRuQOUOipqLLoHpBIYwNXV7PxBk7a59cs3y?=
 =?us-ascii?Q?eunJ0i+fPO9FCtHlCxyU8d7L/t9/qezssMqAcwPFO/ek8BP3NJZs8OTvXOHx?=
 =?us-ascii?Q?fHDX+9WYnaBYmA6JyMM/4R8e/kS3zvdnQESAD7vkU2o0lWBCelbCMKabR4wy?=
 =?us-ascii?Q?Q+6+NhncA4Rlu8AZtGO6iOXnWyfDNvG5LjpeN9cmEx6Z70IesS/YaEOtSDLT?=
 =?us-ascii?Q?RaCO0I38LhyaXsDeMkwHFHbheSIGhG/BZ5olAMqIrijkZe9akv5+jqrTwHg8?=
 =?us-ascii?Q?E2kapeYX/R5A8CwjZXZ3DgpuWbIonxtUcpzLNluZrngrrgEOyb/Dd+7b+9PH?=
 =?us-ascii?Q?GsLFaAYb8yCE+hpcQFAkwQPvJXv94GX3abDQth9gar61JNUrZZP0K8NO5Dtf?=
 =?us-ascii?Q?jWqIb57Jcg4YMS9i1+1AV8dSXsrYn8i7OVfhiUBvJTVKBYNBMOLodAWDQPq4?=
 =?us-ascii?Q?Sl+/YkcZsBAwgKvUFGrq9tqMMQrAZe41AjH2Jzhz8fC+ZAsYKSXsRlCNIDfF?=
 =?us-ascii?Q?xESBXEOeo9a02onouZ3Uf2Y/L5c28EIH8SVpXSHSEK/F8VS9t45PaJn8LMEu?=
 =?us-ascii?Q?+pbEOs8BmuaJvJJX683bI98OEMnWY7hE8zMYJ/QHB2fXflsmS/FeYQUIjDlJ?=
 =?us-ascii?Q?vbrFAcA+lciYrJbkoqqma2YoEqX1Ggn2idPo198RQkR5XJ9/IbA01Nm3dwTR?=
 =?us-ascii?Q?t1HDmpvx59J1+qCexcbGWFa9xDgtcACsR6ke42WFkL3Kk8zMXP8Og0LcoTNp?=
 =?us-ascii?Q?z7w8cwM8rgdDjUW5HnzVqq61D6QGU3F3vQZPgc4UMCetUySrqIb/S1t7HUR/?=
 =?us-ascii?Q?T9NGtDSITRiv56RIR0Cw2dEZ1VjesrGUddpw+cVdpXlUZdHYzNz11ncbLBq6?=
 =?us-ascii?Q?Pahhf0FM2Y14H3b0/Brs7u21S+KM8IlNOvgpjcCueo7ZyJXlsI4pzg9H7RhA?=
 =?us-ascii?Q?BsVLUjl7Bk4aAOBAePulR2xWZk95JLc4HC7KKcs6+Qqund4xKXnARP9gQX80?=
 =?us-ascii?Q?6IIr5M2u49IVZQ3o0RUqJvSZfTH8rceIKdxzqPGnxwbrddBK4N3ao9SbboOv?=
 =?us-ascii?Q?YLGP/5nUJEuV76onR0f4xJuiTeAzKHAqaRUduhcM1ieqswgGYw4Kr4L5h8If?=
 =?us-ascii?Q?NcqCvUWy50AhHUAzB1uKztU0aoTdWPtosU1+yzmpA/Eiclrp8wgeHhMn54HM?=
 =?us-ascii?Q?/6NDSjEluePAdQis/Qz7PxffFzO4i2sCfrnk19d8IPbCiiPXH/1AD65FFH5n?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF5E60240B62C047BDD2DBA81D065FDE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e67680-d34e-4e5f-2652-08da90e06582
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 14:51:07.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+XEs8xDPLFbKMBOLd6EIEBUTLLOOaTcHKUHAnquZMw6qqQU4rKPuWECkBVahltQZ+rwaqxlGiQjGyeFT1ol9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3642
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 07, 2022 at 11:22:14AM +0200, Christoph Hellwig wrote:
> btrfs_check_zoned_mode is really hard to follow, mostly due to the
> fact that a lot of the checks use duplicate conditions after support
> for zone emulation for conventional devices on file systems with the
> ZONED flag was added.  Fix this by splitting out the check for host
> managed devices for !ZONED file systems into a separate helper and
> then simplifying the rest of the code.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/zoned.c | 111 +++++++++++++++++------------------------------
>  1 file changed, 41 insertions(+), 70 deletions(-)

Looks good to me. Yeah, factoring out the non-ZONED flag case made it far
better. A small nit below.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index e12c0ca509fba..3cd3185fa8c34 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -652,80 +652,54 @@ int btrfs_get_dev_zone(struct btrfs_device *device,=
 u64 pos,
>  	return 0;
>  }
> =20
> +static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)

Maybe, we don't need the "btrfs_" prefix for a file-internal function.

> +{
> +	struct btrfs_device *device;
> +
> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> +		if (device->bdev &&
> +		    bdev_zoned_model(device->bdev) =3D=3D BLK_ZONED_HM) {
> +			btrfs_err(fs_info,
> +				  "zoned: mode not enabled but zoned device found");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
>  	struct btrfs_device *device;
> -	u64 zoned_devices =3D 0;
> -	u64 nr_devices =3D 0;
>  	u64 zone_size =3D 0;
>  	u64 max_zone_append_size =3D 0;
> -	const bool incompat_zoned =3D btrfs_fs_incompat(fs_info, ZONED);
> -	int ret =3D 0;
> +	int ret;
> =20
> -	/* Count zoned devices */
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> -		enum blk_zoned_model model;
> +	/*
> +	 * Host-Managed devices can't be used without the ZONED flag.  With the
> +	 * ZONED all devices can be used, using zone emulation if required.
> +	 */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return btrfs_check_for_zoned_device(fs_info);
> +
> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> +		struct btrfs_zoned_device_info *zone_info =3D device->zone_info;
> =20
>  		if (!device->bdev)
>  			continue;
> =20
> -		model =3D bdev_zoned_model(device->bdev);
> -		/*
> -		 * A Host-Managed zoned device must be used as a zoned device.
> -		 * A Host-Aware zoned device and a non-zoned devices can be
> -		 * treated as a zoned device, if ZONED flag is enabled in the
> -		 * superblock.
> -		 */
> -		if (model =3D=3D BLK_ZONED_HM ||
> -		    (model =3D=3D BLK_ZONED_HA && incompat_zoned) ||
> -		    (model =3D=3D BLK_ZONED_NONE && incompat_zoned)) {
> -			struct btrfs_zoned_device_info *zone_info;
> -
> -			zone_info =3D device->zone_info;
> -			zoned_devices++;
> -			if (!zone_size) {
> -				zone_size =3D zone_info->zone_size;
> -			} else if (zone_info->zone_size !=3D zone_size) {
> -				btrfs_err(fs_info,
> -		"zoned: unequal block device zone sizes: have %llu found %llu",
> -					  device->zone_info->zone_size,
> -					  zone_size);
> -				ret =3D -EINVAL;
> -				goto out;
> -			}
> -			if (!max_zone_append_size ||
> -			    (zone_info->max_zone_append_size &&
> -			     zone_info->max_zone_append_size < max_zone_append_size))
> -				max_zone_append_size =3D
> -					zone_info->max_zone_append_size;
> +		if (!zone_size) {
> +			zone_size =3D zone_info->zone_size;
> +		} else if (zone_info->zone_size !=3D zone_size) {
> +			btrfs_err(fs_info,
> +	"zoned: unequal block device zone sizes: have %llu found %llu",
> +				  zone_info->zone_size, zone_size);
> +			return -EINVAL;
>  		}
> -		nr_devices++;
> -	}
> -
> -	if (!zoned_devices && !incompat_zoned)
> -		goto out;
> -
> -	if (!zoned_devices && incompat_zoned) {
> -		/* No zoned block device found on ZONED filesystem */
> -		btrfs_err(fs_info,
> -			  "zoned: no zoned devices found on a zoned filesystem");
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
> -	if (zoned_devices && !incompat_zoned) {
> -		btrfs_err(fs_info,
> -			  "zoned: mode not enabled but zoned device found");
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
> -	if (zoned_devices !=3D nr_devices) {
> -		btrfs_err(fs_info,
> -			  "zoned: cannot mix zoned and regular devices");
> -		ret =3D -EINVAL;
> -		goto out;
> +		if (!max_zone_append_size ||
> +		    (zone_info->max_zone_append_size &&
> +		     zone_info->max_zone_append_size < max_zone_append_size))
> +			max_zone_append_size =3D zone_info->max_zone_append_size;
>  	}
> =20
>  	/*
> @@ -737,14 +711,12 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs=
_info)
>  		btrfs_err(fs_info,
>  			  "zoned: zone size %llu not aligned to stripe %u",
>  			  zone_size, BTRFS_STRIPE_LEN);
> -		ret =3D -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
> =20
>  	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
>  		btrfs_err(fs_info, "zoned: mixed block groups not supported");
> -		ret =3D -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
> =20
>  	fs_info->zone_size =3D zone_size;
> @@ -760,11 +732,10 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs=
_info)
>  	 */
>  	ret =3D btrfs_check_mountopts_zoned(fs_info);
>  	if (ret)
> -		goto out;
> +		return ret;
> =20
>  	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size=
);
> -out:
> -	return ret;
> +	return 0;
>  }
> =20
>  int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
> --=20
> 2.30.2
> =
