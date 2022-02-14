Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699B04B4F08
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 12:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352905AbiBNLnQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 06:43:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353061AbiBNLm1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 06:42:27 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1B25A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 03:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644838487; x=1676374487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2CADjnzjoyTOpvGzShLf6h07Q65b8FdCP3merYPxrwI=;
  b=gKaaDGptPBD/FDh2it4R/efHLmDYHNkjVPumr3561VsiZTFiyRbxArHD
   AQkdyZGydaES067/Zj7U95YocggnV0wPJiyGjWTqBezcf77IXZq6NKSoz
   iHEqWoVjy9TF71Q5DnwSewYroJKRwV8wDHXNgJpUtls537hmVjyTzMMF3
   NRjr6w+MIkRXmqddegKKQgYPY4fcxcu0kL9Pk7heVRPLThoA8z95H+8Zs
   41icc1icStdst6UX3nrlh4EGoXlABdib+fpRkZqFGALGFyVF8kqPHOdLq
   M6W/5J1lCJmlW+wiUlZ52EcSVJAoYnq6qM3VhZr9G3/glaObzXyvYqu57
   g==;
X-IronPort-AV: E=Sophos;i="5.88,367,1635177600"; 
   d="scan'208";a="296963030"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 19:34:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3I7oGAeqSpxDIcpPBTREeOY/vIaEIfGgvInCbU1aTjGOlNiu23e/DpvkrQUCud3q6IhZITzTwAiKG1DEQU8UXYQyOWhBcltv4VcNjkdozeefM2wZux5or2nTXZKuFQCUcBoq9nmu7AsMijvJ22PndbOBUHmJum+tolRE1LTER9HvAvv1V51ut71mzlDcr8Mtt1pDP69gaOUumnduGAypF0uFfM5AvRa1Srg4ff9xCuDflnVPf/RJVygLLOZSZ+X7WR94m9vZ7lpPxKBJ0AWbTWpsMYjahPxskVhXxyZ2WtJRuS+CiRtFOD2N3AFIAjPNFUuDC9xp0+PDAbN5AauBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY5iU8RkQrs866LtxM2XYrEYzr/v2SIEF8BlKG3kZqY=;
 b=ggi1ESpoImlbK/xjPgCIwfSF6HmhI1zeoH0VtGXt2raaYuWttrKgEq6E1peoVwVqqMO6IYz8ePNq3JpOnyrQ72rz+/UwJKyEI+3K/SG2uu2NfcMEpqSetAXjdf7KLR0wyZOL77tUZHhb7zeZ3EuFdB2dvp63P1QUcoHJkLb/815j8X8T3Vs5YJQwe6ydDKJ6PMkx1awp0WBU/5ub6EQyOpFaSSoP7VNm8vA4ovvzdiH3S+xCg72gqS3xAVAeCJe5Cc+mOZHSNarEpAUqyN8BU3VH+ajaKPQwRqvqYPMLXQmIvBvJUZ2SosPINBUekMPGvt85aCq7uUElETJLjuXIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY5iU8RkQrs866LtxM2XYrEYzr/v2SIEF8BlKG3kZqY=;
 b=dD8CLW12ObclTE5FkWOrIysF+l/UatajlLI5xaO+uMrNBq9Mg1DaIuwPfEh9i/EbWFtP+0UA7qoveuzMaQWH5rCavBcS/6HYr5Izm85ns0Djz+lfA+7P5SrMATmwORiMPqHhtzrlX9AFrELcCR4fAsp3FtNWlv+sKZepNIVYnbI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7463.namprd04.prod.outlook.com (2603:10b6:510:15::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 11:34:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 11:34:43 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH RFC] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYH07bkD6HBKyLMUivjyuqvQxEfKyS7xkA
Date:   Mon, 14 Feb 2022 11:34:43 +0000
Message-ID: <20220214113442.zxwpjdcwxkgtlx5v@naota-xeon>
References: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
In-Reply-To: <6e2f241b0f43111efd6fe42d736a90275bb985a9.1644587521.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84ade8a5-fe03-4b5d-ef4c-08d9efadfee4
x-ms-traffictypediagnostic: PH0PR04MB7463:EE_
x-microsoft-antispam-prvs: <PH0PR04MB74637BFF30365D38004217678C339@PH0PR04MB7463.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOwonRibjSLYSPL3oR+ah4VCvw1JPKqwQzuJLIf2ESI+WUNhqRRfSCMh/04MKQaIuJZ/dwgAk616PC4KmlIpAySLIn3KxjEyhwfgUZfAD82T9ov0Bf/2JA74NSFlBNPmelxaOpH1+omH20klXM9S99/kTDVAAqoDCaCQWDKF5YpjW7/ATvn7Qz4BxcBDn+FIKv1XhRK4uCANzjQ0Rtti/6qnpNsO1aeenRMh5eX+HnAn9gy+Fw5mPqh84ARO17E2g8vu2U6oBdlKFoZ6ZpveWl0lxvUMTl8whmJidsJEAkAMyV/Ff/SRZJ421ekZYkgh8adbPjErVfYKjgiSXcNxINSBg+AECd8EnLATabH/xu6RqGD7hUEp/630QQ+EDMaaflb5e6+YMdj/pGADVA5DKc6H4Hm7iJz3/Wv16RElkOqakw3xKnh6ETAPVUY5BX87nsD17a/TVjT5Yj7IjvltnF0ynfPytMGGWs0AuwbdOJQxhXnH9mOVd/SzCKBknm3Z1333XfeXV5uqhNM/WO2uWdEb6h/33uKlp80OwfRzLshW2hem6BlqaY7Z3uxqDlSrhbLCNYGvpVVOMTp0znVBO2949tt+z0hjdJms5TUfHrOnmzQ4Gt/b7khFNX3D8xyAdLWLakEyRPfsD7vSaBl3ikFicdfc+SFueaTUO68eDsIqu4i1CiIUcqCste5sfGHITPiF+lpKPF8hkMCPsQSj0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(54906003)(82960400001)(8676002)(4326008)(71200400001)(6862004)(122000001)(26005)(86362001)(6506007)(6636002)(66556008)(186003)(38070700005)(33716001)(1076003)(38100700002)(91956017)(64756008)(66446008)(66476007)(6512007)(66946007)(9686003)(76116006)(316002)(8936002)(2906002)(6486002)(5660300002)(83380400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ttleKc4LdfBX2ZY/Qi5QwhheBy8GMiUJMxvDLWnqEILNaBr/LzF6y7tHFxo?=
 =?us-ascii?Q?rJseBm16sWWB+fPArn8uDSreVheQ8mWP6B4lWdEYoYwtVn28RgUIFJazVc+9?=
 =?us-ascii?Q?5EJGlsc78J7VXKPmc3O7yTUKmgY9RPXlZpCcWKEV/vvoHJpmeOYzMNWL20oF?=
 =?us-ascii?Q?MWMmydKpRQvBAwur4qcq3nY3+71aRsYGIICaHd+9CPpFdj7NccuKXeYgVcaB?=
 =?us-ascii?Q?ov9Z3ce5jvv/WrPKt/5lgiF9/a+7BUMD9EsLIUguikziVH7u1dBdc4Kifoo8?=
 =?us-ascii?Q?Zryyl6hTpkhNdR+/iKXJpG2f3RQ8yOjzdYH6N6ic/CRztJFCwFUmyPJoyFmf?=
 =?us-ascii?Q?nt2GqYGBiOBEpfExaJjvisysbzMUtR/bksh1UVzlHl5HwsI3alWgWubOJb7i?=
 =?us-ascii?Q?2u8ssPUDxFgdZvWeTKWZcVOuTDE9/H1B2RBIJT9Iqf7p5SRXJxRiuHxGC2Vt?=
 =?us-ascii?Q?wt0oCwM++WPpa82awNt5YFkOjiH4w6f4Lus4kepqX9bTVASz1T6x8WZlDfIv?=
 =?us-ascii?Q?NYxMFOVZ4e6hATnzck2Rz/EIoKsVXGEk5uLZU8acf6GQuoGNBWXPGPs6bzkr?=
 =?us-ascii?Q?wZOlyW4z2W7HBGgQ4+LHyHckw9Zs968H+ZziuHMt61jerhiB8emXNBbZEUEg?=
 =?us-ascii?Q?v6dvCqFRQNdXk2xE7uT+oNrHT5ipAFbTUU33eZ3lQJaE1tVNbmTyg8njNZdK?=
 =?us-ascii?Q?kV45nOAoGU/6Z0kjKi1cRbD2m6CmHnTgPBoZ3RexVy6E80Hj1vx1FqFcbTE4?=
 =?us-ascii?Q?LCLx03XJkdVgBMeWHZpzH8CXGRhcC/IZAdTFr1uInT9g2LCqUymP9n8Gq8ak?=
 =?us-ascii?Q?Aq3YDQD8KG9mTGLuYk5CkBawOLtjQiotVnPLzxqUsqIseEWkgXliCP9Ku86O?=
 =?us-ascii?Q?2t2uXEswimRg/cedLKr+Lyzi+bV9eDMidCxSOrd+4VEJEMYlUWSM5Y6cS/aj?=
 =?us-ascii?Q?JvUqm2sl7Xq8MgfkrypC2cAYxPZgnfPwzSR4ce3gm7BoFe/gQeclKe/8/TDB?=
 =?us-ascii?Q?55YnnoZFTyLatIT9NnMY8hQ92egAY/AjspCOKX4QtK+muP5HjMBnKIIgqkb9?=
 =?us-ascii?Q?UjXBl0t6MslATLaTxaKbvZLMqJkBDVxh0dKxCnxpfRZZ0cKspQDMqOXELblI?=
 =?us-ascii?Q?LmJirzgx8VQAuDYtALo5MI8a5lNcO900niez/K0Pe6yrBifmNsVqz3gWQmoa?=
 =?us-ascii?Q?C9J//g2ce6IRKkEQaQsFgMjsQLCsTY0fBXwDxV82sYI0+aJqCD8zquPBQT2j?=
 =?us-ascii?Q?NQG2WP5QxjNVHH5vgyTQokhtvZz4QBd/cVd9KCbCospI9Y6/d76QnRIAS8u5?=
 =?us-ascii?Q?9E4QHkKbqpWhYmgumPuQmw0PVeTq09M5z5zACH+GwGfrHWErt2pUGRPKZ5gP?=
 =?us-ascii?Q?IfaXUnNfl/5XF8eg0sUnQsZ2Cv7013Uq4NEnnykHDD4maKBlzZ4J+ccczAwR?=
 =?us-ascii?Q?rUPstPdIFnTSoq3wwAhbE8s89Q6Cr8BFXKHUpWPDFhIH76vem747GboUJBc/?=
 =?us-ascii?Q?szKObjW6ohHWMdnB4VW+EEOGBCxknqMkyel/SSu+AJcKhiitrrSaxtxyT7Vm?=
 =?us-ascii?Q?fS0QiBKE362sK4HJPLFJgEZUrHwMBl8CNb8CdeRszeqiTJha1VeQBPno5Upa?=
 =?us-ascii?Q?j6dKXCyuHxryWyqLZeTkcwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A608B33598755945B0E2941D7EFE9F29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ade8a5-fe03-4b5d-ef4c-08d9efadfee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 11:34:43.3182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp3p6/ly1fq9gUKTxqIZUU3+ZEeRAGfRY+hZfs8MMANGH5BOIN0E49i+WNJDJaZ5yIlR25oDoTalJ5ze36xDdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7463
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 05:54:02AM -0800, Johannes Thumshirn wrote:
> The current auto-reclaim algorithm starts reclaiming all block-group's
> with a zone_unusable value above a configured threshold. This is causing =
a
> lot of reclaim IO even if there would be enough free zones on the device.
>=20
> Instead of only accounting a block-group's zone_unusable value, also take
> the number of empty zones into account.
>=20
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> ---
>=20
> RFC because I'm a bit unsure about the user interface. Should we use the
> same value / sysfs file for both the number of non-empty zones and the
> number of zone_unusable bytes per block_group or add another knob to fine
> tune?
>=20
>  fs/btrfs/block-group.c |  3 +++
>  fs/btrfs/zoned.c       | 29 +++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |  6 ++++++
>  3 files changed, 38 insertions(+)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 3113f6d7f335..c0f38f486deb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1522,6 +1522,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
>  		return;
> =20
> +	if (!btrfs_zoned_should_reclaim(fs_info))
> +		return;
> +
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))
>  		return;
> =20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b7b5fac1c779..47204f38f02e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -15,6 +15,7 @@
>  #include "transaction.h"
>  #include "dev-replace.h"
>  #include "space-info.h"
> +#include "misc.h"
> =20
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2082,3 +2083,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *f=
s_info)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  }
> +
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 nr_free =3D 0;
> +	u64 nr_zones =3D 0;
> +	u64 factor;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return false;
> +
> +	if (!fs_info->bg_reclaim_threshold)
> +		return false;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		struct btrfs_zoned_device_info *zone_info =3D device->zone_info;
> +

We should check "if (!device->bdev)" as we can have a missing device.

> +		nr_zones +=3D zone_info->nr_zones;
> +		nr_free +=3D bitmap_weight(zone_info->empty_zones,
> +					 zone_info->nr_zones);

Here, we can use device->bytes_used / device->disk_total_bytes instead
to see how much bytes are allocated as device extents. This metric is
also usable for regular btrfs.

> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
> +	factor =3D div_factor_fine(nr_free, nr_zones);
> +	return factor >=3D fs_info->bg_reclaim_threshold;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index cbf016a7bb5d..d0d0e5c02606 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -78,6 +78,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>  			     u64 length);
>  void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
>  void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 po=
s,
>  				     struct blk_zone *zone)
> @@ -236,6 +237,11 @@ static inline void btrfs_zone_finish_endio(struct bt=
rfs_fs_info *fs_info,
>  static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *b=
g) { }
> =20
>  static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) =
{ }
> +
> +static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_i=
nfo)
> +{
> +	return false;
> +}
>  #endif
> =20
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, =
u64 pos)
> --=20
> 2.34.1=
