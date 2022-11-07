Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF60261F763
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKGPRO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGPRN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 10:17:13 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FAA1EC68
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667834231; x=1699370231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C2uZvdnIjHTZDjt3Tle41B1kYl0n+2dc3e/osPasX8Y=;
  b=cIiCvlfrTL++MTWTm1epBqDB3g/zjZDfsDO0xV5QO7GInaTl2m4urFEY
   EDQ3exTvMfcYdsHtIlKl3EzhMZmPJDeHCid32wStJUVA/sVrRxHicyvJD
   ljlKP/CtWDEHECbjHVilZCKDMXUw0YhHhi8yWYIYaEdQMB3RX39LnKzoE
   C3wEZn895LvDg/eZAEksWom01djs30gAI6nRSEhrB970Jx9d1ON87XsAP
   QuG7HZhyqLaPD5ZXzJnFbEoUg34DhDSoaW3J4JkjFpak3rVeLgnnpUcxO
   yXcJtNHRLDXZotzVR/yYzjy/i1+ryuwSBE/yLW5ZSen/zv5DqqnMBWVDQ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="220831311"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 23:17:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfrJR+QfY4h4aCGT2JTTmnwSrrhDHHpwSHadI0ffhReaahdNWmhLlQoK7UyIiC0Zw3OBXaOh9W+DeCJCrLyssn58RWJNyXVkq5M2JOTqFK8a3smerMBNv9lVEuNiGFJq+ywd58XYxq008yoWKroGdB5YrvdGIbTzaZhYxvjwg1XkXkfrmhB6U4AytbJ5kx3YwNUm2XozTSzlR8hp6XhA2TwrkxFW0QxZxctOxC75QXetqUBVJzR3n4E4GE4u8RDvAtcd5V1hgjnDXUPgCZBaQjDM090iqakeqsUWSJveEcpfxOug+oAVEBX65//veqcfIJbSXcMtC8J+HBfp0od5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL/fZEtPZiQwVd1etxskfBfRcHXrE3ofTG3eljdt9p8=;
 b=k62oCVzIJh2R9SDM8uaswJpGeWl4NsjyB4JgJmCcabcIqlSDxUP5oFI5LB3TGVZQHmQj0n3sK8uLDidcb9voSauZFBwXj2lyVS+pqvADO6EYapnPo6MV6ah2hHxk56/Cr5Y/fur+A+GjSQbmoKiawlKGR/jD4xfduTYhFt+gB3z7T4gDRciW88wpjRc1KPyZuw8Hwysy/Wd7J4xbX6dpUBF44gFoqHkElcDSJf9/m5dd7Ocdd7RMNnA8BWIxoRsL7xBPk+mDeDs3uYlCk42eT52VI7dCqylDyxky+3gI9SncHweaeWriInL8T6gTTiFpedjUUM5FiXri0hk4IzwNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL/fZEtPZiQwVd1etxskfBfRcHXrE3ofTG3eljdt9p8=;
 b=obxcqT28jICjJZ62iWMZBuey9zylTcZTd1CicaUbyVyWaMiYpECZVX5qcFzlleJXUYvHOLCbS4vS1bvKxj/7srsFt6izsefekZHRaxoe0yLOZLmpGKM/kIKW+Ad5c5lGQ2Q2gjaVXnd8Oq/A+cp2PTDJE61TIaFVZexu9l28RU4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7798.namprd04.prod.outlook.com (2603:10b6:8:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 15:17:09 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::858e:9d4d:399d:b1a2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::858e:9d4d:399d:b1a2%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 15:17:09 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: zoned: clone zoned device info when cloning a
 device
Thread-Topic: [PATCH 1/3] btrfs: zoned: clone zoned device info when cloning a
 device
Thread-Index: AQHY8FeDhy/MyJDl+0WSU7oAyL1kGq4zl1EA
Date:   Mon, 7 Nov 2022 15:17:09 +0000
Message-ID: <20221107151708.hddbm4gqxucdwtro@naota-xeon>
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
 <af4caecf1d6fac27654cfd47b72eea865cdcbf61.1667571005.git.johannes.thumshirn@wdc.com>
In-Reply-To: <af4caecf1d6fac27654cfd47b72eea865cdcbf61.1667571005.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7798:EE_
x-ms-office365-filtering-correlation-id: efcfd647-8d1e-48e2-6ae6-08dac0d3239a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPZhRitzoEXrQev4RHKbtfjNZKabz5WQUQKG8RywFi7APaEPp5J4ZGFWtb/04LMj2e9z0cMUuOjsQuyEKoYx29egfIyBtPkkR+ytebUA8IYGRAVXgWLPQximWu/ENCKSwBqhEQTg67PKjBvkumr0p1jpb4mfQDI2ASYYceUTHmwbu0MifR7T7qahn4m+ixTRzcgsCaVqiZUsl2f1iq53TNElKM63V3fAFGMjo0tUdZSxxLl2OGF7Tbf9MYQyVNYAZpSbG0KfSenWSTmhO4F2NTAXB4bzYS2T0HTOv6CLpzRHlbKgVScMmDfRTJ3qUQJiiq5vVBLGDk32+fN2qHjry1nYGxhg+WyTQyiT36hJC6tMyqd8lGQ4CEKcw0SCyc8xx+DgHE4Utk2cQxDF2FTPO9JvI/pI+nVhLKIClP5oICjXqav9Y+6nLkuZlQW1//Q81hX8UnmObX92Mcxt17+GAYWSG8/m67cohwz+sbD8Hdej/VrCtcNz5CzidiP9HfdGtOpptIFI//8STRY0ziQ7Ol2eCrlzVFMtlvyguwOMzyBmqVwhs7WTFptZEYbiZ8RvSef+9wCN9ThjQ7r0pkalvH7jDMIlBHIdmL2abXdt4Hz69eVJV4Wb4wbKmHr36BUPvfchcww2s1zl6HE7c9EypMDdb9+hrUxFaoWpBXQkqfKdIieOmYXeEcVg4snrbf4lF3WTXEI/qFui8uC7/MNKD5GuIaz0wGYtCGSc5EOB0c/k5QOF4QcUK5MrjTTmnYRJ79+oifLx3wWVrOII8kNLnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(186003)(26005)(6506007)(1076003)(9686003)(6512007)(38100700002)(83380400001)(122000001)(66946007)(5660300002)(2906002)(33716001)(71200400001)(54906003)(6636002)(316002)(6486002)(6862004)(41300700001)(478600001)(4326008)(66556008)(64756008)(8676002)(8936002)(66476007)(66446008)(91956017)(76116006)(38070700005)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?id/dffOgCI21y/EQevAK1N6GNnM6WA3RAXqnqdGR519Lm4O4O6stV2HbLKcB?=
 =?us-ascii?Q?kqmgwSZ3GWpxzeqevz+a6Os4gqhhmZ+9Fhzt2+jHwnfTk1uIBKJbmYYfVw59?=
 =?us-ascii?Q?dTzRIy398zkwsovh56vZyG/STUCUeWHSH9taN1cyfcWykkdGcY65fZv78WVk?=
 =?us-ascii?Q?vLSBNUs47bj9i3KmFp7HcRsZ0pfWpzaqTCrwmPQg1hyyXThmNDgxRZURL9KP?=
 =?us-ascii?Q?oSvDGprzNUHnNDLEny9qoSz9hzI+GfR5PLQUuMj/fHgGCTQLYi/oYeqzi0Qc?=
 =?us-ascii?Q?h52EEiUnUw5fH4N17Ozkln8IYDR1uu/oOus9gycikVJPQ7ZR82C2vQvnj3yk?=
 =?us-ascii?Q?4FOcRbgJH4Lj4vhRDlLDX8WnOyRmwQ4GcINaZfN/UwD5yr8KVpmo4vdjfdj+?=
 =?us-ascii?Q?oN55FsHG1klJdeldu3mKpgbNPadtWg4enueiac2klULYZgAYUBgeMx6JPPlc?=
 =?us-ascii?Q?ZYkc4Uo6w7EhfaIWqMNQBbpMJE1ra+Nf6RtxbdwFwUMxDZoq8kJ8pIngSVxz?=
 =?us-ascii?Q?ky3EqzZ3pzGWufC+7pjDHC42kwcPC7N19f8P95AHVgzYPTpO7tpWUnQWXR0J?=
 =?us-ascii?Q?TdcOtB9ZjBUjDxgpbkxOwF+N8CH6kiWCXk0VzZN+PbwS/N4i4Zeg/zaXSUIE?=
 =?us-ascii?Q?rWk3jTTrBOERht2ETGYEH+xvFAdTLmfNPEthcO5jHqCIyb7pKPo8jMVjpSBA?=
 =?us-ascii?Q?bN4QwgGwcGc3hoQ1cWS7dBmYX+k+a2WnhG+BCnSHI9X7wnNkzCryac8eSAps?=
 =?us-ascii?Q?PGRobTdnDTO3iauVbK5hxazgkVpOkHR3B4nNX2T+h8LL7JZTdNxtyy84u7bL?=
 =?us-ascii?Q?BjX8qgz9R0aBLm44EyQyIwVspLzquBYGn6lOLZrR4vKu4AeEGtDMvFdBL1f/?=
 =?us-ascii?Q?jWmPaS2TvWJ2d5mfcas0AJtA+AgClDDPR1L7/Mdvx6atdSGJOY8/MyV81dvn?=
 =?us-ascii?Q?GFNytnmK38tpYMvo4UDRJvc2cchXeCew+Smtvgxd20+SIBy2y5o5DO1UFhPM?=
 =?us-ascii?Q?CZtNk1BWkxJhLQrEwm6QZ2DzPMwynMr+yi1QBQpr1fpr+km0vlJ0mykA/Qcr?=
 =?us-ascii?Q?B0+rZwnv1yvTnV8ai1Rof5KP5yji092aHGNRbxXUpN35AxpD/a8n2tU8ftEx?=
 =?us-ascii?Q?Wd9IRZAebzMiystdyd2pdNZ306GYaAplvh+sT0vC/Bwswuy7MzWajnA7gJex?=
 =?us-ascii?Q?PEC57TDcGxwCgEprvNJokIYfDDk5R/3dDLIfk3Od/OdXDm7/2MZ8QY5i6JLl?=
 =?us-ascii?Q?WGmT7c89S82lCoxSZLdZQ0zL8PNP8SUpEvZm8e5oMftghs5Hn4bzwscIwxj7?=
 =?us-ascii?Q?k4hlUt0VB1gx9OLUylvZbZ+B91ZIFfy6CegsVfcdYoTVjD5en43CxOdolSzd?=
 =?us-ascii?Q?1KUjTciuylm7nJZHD9JjmeVLe0ieULnkQ9B/aiO80np/nVm/UgEySkxGYEz0?=
 =?us-ascii?Q?ZhJcEwPAfxF9M7YpljrNdWu3iwbbA7GhBEhejv8ix0Vck8x57R7Ol4TSlmrV?=
 =?us-ascii?Q?UcoMZV0DMj0BMsNOoXWbGpJ51bmdAjUvWmQ8O1VKBcfcCucDyKIj17lQGP40?=
 =?us-ascii?Q?CpPOBLGUEamTztsffWiLdrkkKnksMs5GJ8So9LOJp0JiXn1PM3Q2wiAxQ9fF?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D070D3B3B73A24882F39C593D140C3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcfd647-8d1e-48e2-6ae6-08dac0d3239a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 15:17:09.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0fjZ4bGg88WVjgm9YZTB71KAaFCosao1R8cA6SG/vd7y4SKG4s4UneGmSXjySzgXwqgxrpOAev3ms7BeE0KEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7798
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 04, 2022 at 07:12:33AM -0700, Johannes Thumshirn wrote:
> When cloning a btrfs_device, we're not cloning the associated
> btrfs_zoned_device_info structure of the device in case of a zoned
> filesystem.
>=20
> This then later leads to a nullptr dereference when accessing the device'=
s
> zone_info for instance when setting a zone as active.
>=20
> This was uncovered by fstests' testcase btrfs/161.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 12 ++++++++++++
>  fs/btrfs/zoned.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h   | 10 ++++++++++
>  3 files changed, 64 insertions(+)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f81aa7f9ef19..f72ce52c67ce 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1021,6 +1021,18 @@ static struct btrfs_fs_devices *clone_fs_devices(s=
truct btrfs_fs_devices *orig)
>  			rcu_assign_pointer(device->name, name);
>  		}
> =20
> +		if (orig_dev->zone_info) {
> +			struct btrfs_zoned_device_info *zone_info;
> +
> +			zone_info =3D btrfs_clone_dev_zone_info(orig_dev);
> +			if (!zone_info) {
> +				btrfs_free_device(device);
> +				ret =3D -ENOMEM;
> +				goto error;
> +			}
> +			device->zone_info =3D zone_info;
> +		}
> +
>  		list_add(&device->dev_list, &fs_devices->devices);
>  		device->fs_devices =3D fs_devices;
>  		fs_devices->num_devices++;

This part looks good.

> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 9d12a23e1a59..f830f70fc214 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -641,6 +641,48 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device=
 *device)
>  	device->zone_info =3D NULL;
>  }
> =20
> +struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_d=
evice *orig_dev)

I have a concern about this function. Since this function duplicates the
zone_info, it might cause a split-brain state of zone_info. Actually, that
won't happen because the current callers are the seeding device
functions. And, another solution, reference counting the zone_info, is not
an option as it is only used for the seeding case.

So, this function is safe only when a caller ensures read-only access to
the copied zone_info. I'd like to have a comment here so future developer
notices the proper usage.

> +{
> +	struct btrfs_zoned_device_info *zone_info;
> +
> +	zone_info =3D kmemdup(orig_dev->zone_info,
> +			    sizeof(*zone_info), GFP_KERNEL);
> +	if (!zone_info)
> +		return NULL;
> +
> +
> +	zone_info->seq_zones =3D bitmap_zalloc(zone_info->nr_zones, GFP_KERNEL)=
;
> +	if (!zone_info->seq_zones)
> +		goto out;
> +
> +	bitmap_copy(zone_info->seq_zones, orig_dev->zone_info->seq_zones,
> +		    zone_info->nr_zones);
> +
> +	zone_info->empty_zones =3D bitmap_zalloc(zone_info->nr_zones, GFP_KERNE=
L);
> +	if (!zone_info->empty_zones)
> +		goto out;
> +
> +	bitmap_copy(zone_info->empty_zones, orig_dev->zone_info->empty_zones,
> +		    zone_info->nr_zones);
> +
> +	zone_info->active_zones =3D bitmap_zalloc(zone_info->nr_zones, GFP_KERN=
EL);
> +	if (!zone_info->active_zones)
> +		goto out;
> +
> +	bitmap_copy(zone_info->active_zones, orig_dev->zone_info->active_zones,
> +		    zone_info->nr_zones);
> +	zone_info->zone_cache =3D NULL;
> +
> +	return zone_info;
> +
> +out:
> +	bitmap_free(zone_info->seq_zones);
> +	bitmap_free(zone_info->empty_zones);
> +	bitmap_free(zone_info->active_zones);
> +	kfree(zone_info);
> +	return NULL;
> +}
> +
>  int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  		       struct blk_zone *zone)
>  {
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 8d7e6be853c6..69fb1af89a53 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -37,6 +37,7 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64=
 pos,
>  int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
>  int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_c=
ache);
>  void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
> +struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs_d=
evice *orig_dev);
>  int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
>  int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info);
>  int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, in=
t rw,
> @@ -104,6 +105,15 @@ static inline int btrfs_get_dev_zone_info(struct btr=
fs_device *device,
> =20
>  static inline void btrfs_destroy_dev_zone_info(struct btrfs_device *devi=
ce) { }
> =20
> +/* In case the kernel is compiled without CONFIG_BLK_DEV_ZONED we'll nev=
er
> + * call into btrfs_clone_dev_zone_info() so it's save to return NULL her=
e.
> + */
> +static inline struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(
> +						 struct btrfs_device *orig_dev)
> +{
> +	return NULL;
> +}
> +
>  static inline int btrfs_check_zoned_mode(const struct btrfs_fs_info *fs_=
info)
>  {
>  	if (!btrfs_is_zoned(fs_info))
> --=20
> 2.37.3
> =
