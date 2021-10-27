Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0910643C300
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 08:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhJ0Gaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 02:30:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62767 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ0Gav (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 02:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635316106; x=1666852106;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OGq3iGSpBLHABqLvpg5LJHesAsive2+Vys246iUiuNE=;
  b=k68ILjoHkMdHE636L57lWC2ldpDZru2jzKO08yGD0goxT/lXTK01BVli
   X3TBPPKS0hKTPXnYJh9d0/kA0w1Fd1WcWUxIkazvedDDtYTmNY+2jsqhh
   lFEJX0UWthJVQEprIVKYpLqZhqKQcR7lTbHwHR+Qdg4x6entBNuKE8jDy
   AlVGGvVjlTdb8YPaKb4Ij+/EHW1CS9Y1vd5Hus4rn39ajO5i8tqbR7Ys/
   PyMmZGFIHAhvpF9ilyV4cqZEZQ0vFuXC+UVamrwgPEFitcy9ZVKde1vH7
   ri/g2LNlxI+hxwceO+qsDm0TkHa6CyU7fx++Iq3U1iV2mFglvAEFudlCR
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="182951344"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 14:28:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieN0Ua/acDg9KNPwJ1Slwus4hPcqWTn2KXl1g8i2SvdYH4Xvk+MQt0IeBTWeZtOLhclW3oE8W7sgxQP6VNuxq54ZWtXt5iY83tfjZVeFsfDxMD/xWZnXYWJorSVzdW4D6VNApUiw9yiFpGIsIy1UDrkiiSm/IGyntZHp4ul8ApxLXcrc+h0CjEJu/5OBEwRq3aJhc94UoHpaOMOwUvyeOzQ7BGiht/qnwMaHM1/VeVgM+lSkdd+8UG6yz8MZeTop0s+DCKUj/rpUt0p8yqN+8r/uyqSGNbCVak1wTZdynBgVWsKgs8+y/k0XUR4CUjzu1+vk8fhXk16KDdmHgOzY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/xFIcnuLksq/YnVpJ4bEd6HcJM0whFf80g+L2DBgXQ=;
 b=Em60AmYT88ASD1oQ4rL7kHwLq35wiB7nVbh/L9y7iKhAkkPSzCrxU/wdMyM+LcZyTwVALxC3AXxKO6a6G0QpGtkh14YS/Gv1D41nBpBbnwOYZMd5VR2mWdY4j6BmLvUzyrzEVOsZV1joE8vq3elON8vJfakojZkaDawu3kwhxTP9LCriK+/rkGmJDwZnBnCGA2xai/y6JpNv65el01lVA4HbmbhjJ44x3jMCoNvA14Ghb7pMuhJUkrVEt1zOqp7KcV3ik619r3S8XpyhAYVaBli0jclgTeawnxlzQ3xKXyTb+Owb2Glrt4TGXko7HLuiu3p4f+D5qimmaJ7GY1ashQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/xFIcnuLksq/YnVpJ4bEd6HcJM0whFf80g+L2DBgXQ=;
 b=Um4aSBpugiT1OSsyp11GiwELkgPhGNjxgBRLw2CUE1H2TbQDBaszxzVxmipsFTfzWKQaSUTc73H7CCGuqRCJhGeNTU8I8Ku8VLXi4VQCi0SFnPiIbMBLAkqWcXjuMerC9L7GY9bdBS5D2V1yQUOcju9+5fNRRSSKr7PoqEFEqZ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7590.namprd04.prod.outlook.com (2603:10b6:510:52::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 06:28:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 06:28:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stefan Roesch <shr@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXyordsU5W6HCCtE+CLExpPEpQgg==
Date:   Wed, 27 Oct 2021 06:28:23 +0000
Message-ID: <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211026165915.553834-1-shr@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3cc797-df2c-431d-effb-08d99912fa3b
x-ms-traffictypediagnostic: PH0PR04MB7590:
x-microsoft-antispam-prvs: <PH0PR04MB75900410F134F04A996977A59B859@PH0PR04MB7590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l6N7LVXRkkRFuwaPfxjoeVXnxAj/tPG83ggCgumOJ438Nx4nD5c1GAVEy3cfCLSgn9C79cycsSf0WKupGfjrynPAm8cYpwnRp64LHv4f0XzZKZKkMaezuR7X/m1tqPi8ToWhTY/g+yA1eGnPg+X+wosQQbpbsDYuK3/SA1Ihw+acPjjHoFGwKHfK/TGtSNmMwuCtJu0MYIKW9LElMw2dqry7cXoXmFirNk2yxgEbunB2hbWt1RvQsPXSHo5j3MHDmj8mVnp52nwdpmQgtd96v2UdPjHSrW1PDpRtY/EPQcpXbeFC+xXzAoande8Uf2MODRrST+LVaEGjw3NqoH6qSp6El/UMrm2dLxzpLhB7dZrllKy7aQ/PouCBg589Zuc4Zi2oVPnDaSS3rYGD/WuEK1FY0Cw5ltf7+4jBNk9Io1mzMtQ5AC5ThZel1Qc8cjXIBSnK3SWkgFwiD6/fLkADYNXB+bIqP93yijFUs9KfS3ir20LUaI0vSHQMOZhw7/F+wT+drXCeSzwuypo+nNq+n/VdGRJaygj0L7qE75Cyedv7ttNLmWfdu1SssNrJeJ9pK/OqZBE6LInWh1/IlkoHc1qNfoW4XUM5CgRZ2orqrssRVdQKsUTSUthErkPm6XFsXB7Rmbxssv2PZC0VnENAJhvkmzFrupjV6JnFEShETkd4X+IY8mCP16F1/M6kS9yaBXdBaFu5+rszgmuW3A/WDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(64756008)(186003)(7696005)(86362001)(33656002)(66476007)(38070700005)(66946007)(76116006)(66446008)(91956017)(52536014)(55016002)(316002)(83380400001)(5660300002)(38100700002)(82960400001)(71200400001)(8676002)(53546011)(6506007)(110136005)(122000001)(8936002)(4326008)(2906002)(9686003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SqCbRHw/B/Ghdd5a7q64xD2Hk5tXz2KavA4d4+UkB6TnY/ROw5zkGhvEG3n5?=
 =?us-ascii?Q?hNvSYRcZ2U2Om2Xq9eLMivjDMIReuu6P0wvuHFZZ1lxyFpEErQjBA/1Z9THA?=
 =?us-ascii?Q?eu7SJ2CZJJUHfU/tdIbdEGtTLbjoqv8Gth6+qzU1+Gp+MOUQY2nefZhNZ6KJ?=
 =?us-ascii?Q?8t7KMojZxx1XxQF/6QqX34bVhM7+d+C7eH6q3b4cIp9UEF/Xmoi9sPb9zvTY?=
 =?us-ascii?Q?m7AVrNmWSK2hQwnWeIJNFTsI5lJz970Z4nsH8F8kC7rQ6TGjpQlzO439sj/a?=
 =?us-ascii?Q?89w1q84B4QzTTqioUAX5EAXNfd8cxD3J4xeZeRnPB2r2x0u+2QpPqzz04k9X?=
 =?us-ascii?Q?GtiKvax0YlKdnyIrHCsg3UXJMsKGWLYC/bbqb6CTVBIXYSPQLqlp+lQo0azw?=
 =?us-ascii?Q?zKRr3BpAm8AlgZyQmFSi4+aO4OfrsSj+sNc7JmLTMRRS9jWo9U2po/KNkRFO?=
 =?us-ascii?Q?xbZwOSaiQTA0m4ECVrvf/1YXPtLnu148r94dIl569mF/L2399MAWO57Ud8kB?=
 =?us-ascii?Q?VNnp8f1yvmIm22H1wYFp0nTcR6/HoNLsmWxhKP018I1I1MrUVEA78Z1DZuRK?=
 =?us-ascii?Q?Jr9uBky5Xy98NjbVQHF76e8ejbcgNRCbq4vBwXWyb5mXm8lu331rNZRJ+wtY?=
 =?us-ascii?Q?biP5HNIeK1M8mN/p7uh+iNFqER23dbnxBWE2GD4k2TGLp6NMjDGecb4ms8kW?=
 =?us-ascii?Q?r4ZErCV0SvV46/11N0bG4HwaY7LYDYYBiODnFRXVREvVu4wNG3GXqTmhWnlT?=
 =?us-ascii?Q?7cARLrYPLGfrIiV3EGpl5RaQLGFDx9MrWXsz1kdkRG1KEF79II2J8zBK5EsJ?=
 =?us-ascii?Q?0y+chB3XtfPC2T6ONlXNJZOOi765As8twTdIJs4VMgLPS2Pu1TDsarYDFxPg?=
 =?us-ascii?Q?gWMxnV1VyMilivs+0dh0cFO8CUYlHXQWWjX6ZiY1lt/JqqWmAGhbQv3Yaq39?=
 =?us-ascii?Q?/j/xKDg+pFXu6dAWPHf4MyYBRFipi4GQGj8Lpk9O276LmECSSPMG8MEZWVnN?=
 =?us-ascii?Q?lnTJpfJKQlf4ncClsekIs3vy/1+wame3aAm1/Odq6c7c3f5osCSJLK4Aszzl?=
 =?us-ascii?Q?R3l0tyQUnH6pyIxzQo5L8ej6qpiJ0w4ZpoR3wdtH5Ss6+egJiSG2y9XsB/N/?=
 =?us-ascii?Q?Pf5CKGjxATmK5y0p3SI72kWuyesdt5A8MgiDlLjcnMeCV/Ls/2MyGVA7sZRA?=
 =?us-ascii?Q?+WUXhbA5acoU+uX+gXyWI6x5xAQ/lTtwEJ9Zt5TMyppUdHW7mpgB3SEfGVEe?=
 =?us-ascii?Q?A6PBPROCLsiuZVkRYecaJGHa9HwsNKlENMhduWyxvn0hRjo4Pm2TSsPw2wTc?=
 =?us-ascii?Q?XOMzXqVyT1ukmA9Kvw53oK56KxtI2qtw0mOa6YbjhV6jxv/6j+FZ9/HMH100?=
 =?us-ascii?Q?79v9+nd7LWQBQlcMq8ZmDYtMRsckmWj52bXljfbF3QXXY58AJ71iXBiXPhyw?=
 =?us-ascii?Q?X15UV5MOFG+DVYle4L3lOUWa2hjLMAJQim198sTAXbXREEe8uaiLlUqPUo7G?=
 =?us-ascii?Q?0udIPH7z3++7Wes43sfDSjXpAeHgnAH0lAT60gZCe9xuwsoo6byGboue1b5W?=
 =?us-ascii?Q?PRjPPdmNmvrtBXLxE95jywB7rMWmrHDoAesqXPonERMO/QaOMYlmcWQuRS6q?=
 =?us-ascii?Q?lpANDeRG1YO+6YoRoC+mK22wRcQxCqOpWr/kS0E9PanOck+s+38kEM5Hu08H?=
 =?us-ascii?Q?NGQ6ozOTKLsI6XosubSJTSUExvMg46GVikeoC+xLgdA+QhjIVO/VVqvIYvlT?=
 =?us-ascii?Q?U2nJZRm4JUHZhfnUkUTcFEZCXzm3fQE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3cc797-df2c-431d-effb-08d99912fa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 06:28:23.4795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LVTTxrRQhF/pVnXcJQSCUOe2XLr74T1VCtAxtenlaGJ/M1k6MmFTJYrNCaN/e8E9qAwyqLba5HQEELzDzQmvUbHTWB/5opX4WvgtcaRjBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7590
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/10/2021 18:59, Stefan Roesch wrote:=0A=
=0A=
[...]=0A=
=0A=
> +/*=0A=
> + * Compute stripe size depending on block type.=0A=
> + */=0A=
> +static u64 compute_stripe_size(struct btrfs_fs_info *info, u64 flags)=0A=
> +{=0A=
> +	if (flags & BTRFS_BLOCK_GROUP_DATA) {=0A=
> +		return SZ_1G;=0A=
> +	} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {=0A=
> +		/* For larger filesystems, use larger metadata chunks */=0A=
> +		return info->fs_devices->total_rw_bytes > 50ULL * SZ_1G=0A=
> +			? 5ULL * SZ_1G=0A=
> +			: SZ_256M;=0A=
> +	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {=0A=
> +		return SZ_32M;=0A=
> +	}=0A=
> +=0A=
> +	BUG();=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * Compute chunk size depending on block type and stripe size.=0A=
> + */=0A=
> +static u64 compute_chunk_size(u64 flags, u64 max_stripe_size)=0A=
> +{=0A=
> +	if (flags & BTRFS_BLOCK_GROUP_DATA)=0A=
> +		return BTRFS_MAX_DATA_CHUNK_SIZE;=0A=
> +	else if (flags & BTRFS_BLOCK_GROUP_METADATA)=0A=
> +		return max_stripe_size;=0A=
> +	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)=0A=
> +		return 2 * max_stripe_size;=0A=
> +=0A=
> +	BUG();=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * Update maximum stripe size and chunk size.=0A=
> + *=0A=
> + */=0A=
> +void btrfs_update_space_info_max_alloc_sizes(struct btrfs_space_info *sp=
ace_info,=0A=
> +					     u64 flags, u64 max_stripe_size)=0A=
> +{=0A=
> +	spin_lock(&space_info->lock);=0A=
> +	space_info->max_stripe_size =3D max_stripe_size;=0A=
> +	space_info->max_chunk_size =3D compute_chunk_size(flags,=0A=
> +						space_info->max_stripe_size);=0A=
> +	spin_unlock(&space_info->lock);=0A=
> +}=0A=
> +=0A=
>  static int create_space_info(struct btrfs_fs_info *info, u64 flags)=0A=
>  {=0A=
>  =0A=
> @@ -203,6 +251,10 @@ static int create_space_info(struct btrfs_fs_info *i=
nfo, u64 flags)=0A=
>  	INIT_LIST_HEAD(&space_info->priority_tickets);=0A=
>  	space_info->clamp =3D 1;=0A=
>  =0A=
> +	space_info->max_stripe_size =3D compute_stripe_size(info, flags);=0A=
> +	space_info->max_chunk_size =3D compute_chunk_size(flags,=0A=
> +						space_info->max_stripe_size);=0A=
> +=0A=
>  	ret =3D btrfs_sysfs_add_space_info_type(info, space_info);=0A=
>  	if (ret)=0A=
>  		return ret;=0A=
=0A=
[...]=0A=
=0A=
  =0A=
> +/*=0A=
> + * Return space info stripe size.=0A=
> + */=0A=
> +static ssize_t btrfs_stripe_size_show(struct kobject *kobj,=0A=
> +				      struct kobj_attribute *a, char *buf)=0A=
> +{=0A=
> +	struct btrfs_space_info *sinfo =3D to_space_info(kobj);=0A=
> +=0A=
> +	return btrfs_show_u64(&sinfo->max_stripe_size, &sinfo->lock, buf);=0A=
> +}=0A=
=0A=
=0A=
This will return the wrong values for a fs on a zoned device.=0A=
What you could do is:=0A=
=0A=
static ssize_t btrfs_stripe_size_show(struct kobject *kobj,=0A=
				struct kobj_attribute *a, char *buf)=0A=
=0A=
{=0A=
	struct btrfs_space_info *sinfo =3D to_space_info(kobj);=0A=
	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=0A=
	u64 max_stripe_size;=0A=
=0A=
	spin_lock(&sinfo->lock);=0A=
	if (btrfs_is_zoned(fs_info))=0A=
		max_stripe_size =3D fs_info->zone_size;=0A=
	else=0A=
		max_stripe_size =3D sinfo->max_stripe_size;=0A=
	spin_unlock(&sinfo->lock);=0A=
=0A=
	return btrfs_show_u64(&max_stripe_size, NULL, buf);=0A=
}=0A=
=0A=
[...]=0A=
=0A=
> +	if (fs_info->fs_devices->chunk_alloc_policy =3D=3D BTRFS_CHUNK_ALLOC_ZO=
NED)=0A=
> +		return -EINVAL;=0A=
=0A=
Nit: As we can't mix zoned and non-zoned devices 'if (btrfs_is_zoned(fs_inf=
o))'=0A=
should do the trick here as well and is way more readable. =0A=
=0A=
=0A=
