Return-Path: <linux-btrfs+bounces-1983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394E844E90
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 02:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613491C2B018
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 01:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511F2107;
	Thu,  1 Feb 2024 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="evPiEm7D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e8U2QQzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5B220E4
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750206; cv=fail; b=VkKXXg02cva2ab+kRKeuw21+NMa4n3IHWbP41qh9D8ImSd7K2kOtE5b4d7bwK1W09wi9uwFPiioK85hKl+wVrgJBw1A1VivekVxiWJ6af3Y6kF6N7IdO+ZUv6R1MWWGzVx+4BJU2OUfFjGSapMPr0YKGSz88Rscl3UMiBhGtSbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750206; c=relaxed/simple;
	bh=cr1Fek/E2/Kkh4cJrqg9Ahl7n0xykXcGiADo1qTZyro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mj+Dg6DHjqv/yrEpO6GbjQXCrrVPmUZF+do0hrpBSSQ8cx/wxztcVPAxudS9RE9++JTlIs2v7HviecgyO2+36oEVc64lBVnw1uWU5rK2SFK55G+4nNZ8SiQPB/jASMCorVeFWfRLQ9Gt9ws3YcdsRA71wNDk0D+20z+GcAKUs1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=evPiEm7D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=e8U2QQzd; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706750204; x=1738286204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cr1Fek/E2/Kkh4cJrqg9Ahl7n0xykXcGiADo1qTZyro=;
  b=evPiEm7DFs49R5fDEKDZ0OxP2JvdfdJviOCnlVJUbT6+M1klg20RR9/T
   dbvKlPHK7H8WZji4kPsYbrp3dksgsq2juBX5gDpi/Rfu5WN55X1oUp/4c
   DWDBiluvlVpayIa6/gPSR/i15j1g1XQCrdFcFitbjz/KNm4ejbpqSs6Q1
   moPMlbUFXvnC6UoU5R+VT2UfCpqle1L+LRBKQqynecfrO1bZklDinR/BD
   asE4wmrI/TvzkbY7CzTxDLrPX2JOb4kAaHUwzGEJvlKULE4jmwaV9yBhB
   82ovtSij9jfkiMTxiYxk7I6ApmSLWluMZRfciWksqeneUcmt3N7Ma2THw
   w==;
X-CSE-ConnectionGUID: Reg6XgU0QUiqVCvVshuS+Q==
X-CSE-MsgGUID: YOrbSWNwS0Klz2sJrzmtXg==
X-IronPort-AV: E=Sophos;i="6.05,233,1701100800"; 
   d="scan'208";a="8749183"
Received: from mail-eastusazlp17013024.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.11.24])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2024 09:16:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfhaTf963564tsl03AZaynIawR7JZW4CUP2nDx1N16n49o30tFIceb1tz7FOAz3o4VtUcaIBiMl+6yedUT1SxXiYnGGPl7XTxihGxdS3tQMw47i/Zf9q8bI5WVzEqg0wvH1Gqz3f5RGhbgy81bXMqJvGHLDevUgKjpgSdnWlL8dw1rxBuOnKXOG1nLafGZMFYr5YeK4+pSM8LrmtmrDCVtKBFq/tC0ftiFWfiSn5G6AwOq0MYmsRTZO02QFzNmKAOkdtudzUM7JQ03bfIoQXE3nQ774rJhDScFKsYHB/UcjEOHUirBgVDLc/XOcH8+ppYb6ujIU6PokegefDSB/sGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr1Fek/E2/Kkh4cJrqg9Ahl7n0xykXcGiADo1qTZyro=;
 b=dn+9SVUV6vx0357wshWU9xoGYJ693ISxVCRMbWglZWxp3flRhmFed7+rDXrBaxlt63cFGQAqwg4lMHtGbCnRobOJz/J2aAgGmSzWFufe4KzmMt1eCAOhUsJKU/XFrFg/j+2rNs5XfUk95ePYBtuUNaL5NwptFtdiIRPeFWEoK7HYJovhKl5u7PyTE3JZe7PzGtKfW77LP+mG5mxjL3REdJ1XxpOtgOdNjqFwXNYQasTykzH3rH5ze/YJD9wCMqfodam5Yr5/chVoxWxpX5kVRAPfnvbN8FSXCyV5OxyPW/6Y85KiJ4MPe+EZcvkDCA0Z33RLAtr/z5Pwv5OVv2GnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr1Fek/E2/Kkh4cJrqg9Ahl7n0xykXcGiADo1qTZyro=;
 b=e8U2QQzdR6M0OqCC7m1rY9/fX6oJxB/FiebbFYZfw7O6p9VvMpQLST4XTlhEfAudA6MDpcIgRw/btWdzdryNYryMbJJu46OrggVqBzVpA2SsRZDzyZDY07NAm/iOxtr15cqnopdjxgUFtnOS/k97i4gJIaoE3dQjH0c/DTfKQtA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6767.namprd04.prod.outlook.com (2603:10b6:208:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 01:16:40 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 01:16:40 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>, "clm@meta.com"
	<clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Thread-Topic: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Thread-Index: AQHaVBUW8GgHeMVXLk2Sy0cneKmkAbDz97wAgABPH4CAAGmZAA==
Date: Thu, 1 Feb 2024 01:16:40 +0000
Message-ID: <6ljnyrwminqxmtjmdozivtdgaiymp75xytxxvbgpkznpv3chwa@4v2r3emp5ko7>
References:
 <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
 <9624d589-43ff-40c6-81af-2c7b577edb22@wdc.com>
 <20240131185843.GR31555@twin.jikos.cz>
In-Reply-To: <20240131185843.GR31555@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB6767:EE_
x-ms-office365-filtering-correlation-id: c9fa0c99-c2d6-4cd9-31c7-08dc22c3721a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uZTHHiGr58zehhLFFJorjB4foOWqgbcrt2Yk4OflZGqYJrg9GIEl1WuU3vgs7oZKsilN7N/9pRV7zxY2abBiOpnsbuvR8q/GmD37AKl/KY+1Kcg1UVc1kd3Qky4XVxDq6FoW95m1rG06aAvw/W2SNZZ8bkwbFWLJFB4kpqSz06BFNMKx4S8nX3va8DeW2cjR5ASXTTmlq9JLl2h8jchzU2QLVg83zD7fPgMa5EmNFEfH2Hk+ggxfv3FnoYe+7sQfyEtP6m5iqbyVpeIEzOJ21LPxPQXmMs7h48S8CY80b61bO8qrg/feRGZwbBPtS71Mh9rl/Hsm9dew6SCVGJFkbWJy1LbwqUNNCIkr7pdSHnid3NtrE7xepkygdEzXsoAHLGqahJ3uPZJWzRnX0RdZpjvBHGX75HVhb/Hmgt/2V51HOgLQ9baRVUFSevqoeI3wSCFNrUkPae+ZBbHm7PojR/PyrzInT/gq6r0eMQwf1t/rGI2lAgGEysQ/PESLIhqLfKgvjWmI8ynqS5XNLQT06GMrztupmBGGMBIE4/Lwizm0oAIMVmVlV/hpbGDXDQwTMTukgpe/ukbQetgj/7Woj28qpuWJrlJSmj/wdbv4JewVBcPC5r6qk3+YLdimlVVBxymJGl8qKQrqxUHDJ1QNuA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(82960400001)(86362001)(966005)(6486002)(38100700002)(478600001)(38070700009)(41300700001)(53546011)(6506007)(83380400001)(9686003)(26005)(6512007)(122000001)(71200400001)(316002)(33716001)(8676002)(8936002)(4326008)(66556008)(66476007)(6916009)(66946007)(54906003)(64756008)(91956017)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3zn1p/micGZSCO1iph1DZQPuHXnA5sC4nlp4P38D8Sk7DnzGM1UDa8ZyK2nJ?=
 =?us-ascii?Q?Sn230nddnYNb3iKDh1v6wsWr0QjmNzOlrkW7NKs9g2HbTcpIHUrqtr3MfSZW?=
 =?us-ascii?Q?IKWsv3MVB55xU2+jjkyztUCgC2hcUYV2WpIc6DlkCIF2c+btyhodjQ2v2wpT?=
 =?us-ascii?Q?MnbonXG3NSTzXuIVCbJ7ZQUdkLyZIiZ7o+2oqg5b2pAcv3MpnW7LbC4seB6I?=
 =?us-ascii?Q?TMFv2xrwlJ52terDURPoH4moN0x38LU8faLwwAiKieQPjhhz71qSkLKKSV43?=
 =?us-ascii?Q?knGv71ZXhgUV9xCDJNwfqXKpcT/TtOn5z5OYdpRzk1IJjUdy3KXo5tmZIYaV?=
 =?us-ascii?Q?J4+VLIOn0Q/ouLQaadwzlH2zVyvhcBzX/OLrvWKY0iKalWsSvZZZMTh5GutW?=
 =?us-ascii?Q?6pnYz+v1LKFXOk/tYpZTM9ddieDrUzuj5MVNoflO0+z+uGUfaZdzvt7y2NMQ?=
 =?us-ascii?Q?k+cTPR2rbT2Yd6xQOQav83nFS0edSgeLknwFqHrw2yCtMpa/JkwC8LYOlrxW?=
 =?us-ascii?Q?3mrs3X3F5PMH5CBlFj6xET+u3bLvdacE4Dg/EhHeIfmz7nj22jrS9I8Oko6X?=
 =?us-ascii?Q?yotWSMdZA8Rtq1L7z3Rqf3+Zn5hQoT4nUyHG8dLkrNKxT/5df2lUXujiEVOa?=
 =?us-ascii?Q?WXzIHYHyoRKSOUeFTjaYtGbMbqnAIcM69wHR19g418sahj6+aMntFjMMueDO?=
 =?us-ascii?Q?7bxRXj44MXi9cXeLM/N7q/J3baRD8+ymu8Z64AuVuS5yW7g7tXlkTAmJ9vYS?=
 =?us-ascii?Q?buJIQmuJ6UKFsJEjfQM3mSDBKCN8IjLU93MG2oPdJ+RCpGRB7qoDXKpwWM4N?=
 =?us-ascii?Q?KLQ6SFmILp08vNTBMW7xT6r803aw6e+lz1e0rKBixzGHKN8ixhspaWgel4nF?=
 =?us-ascii?Q?L2R6lCApKeAM02U0iQa8iGnbW7rrvZf2TG+/Z8LPPcVLTn6Gu5MV1uM/NnWi?=
 =?us-ascii?Q?03dwn2GJUxZf6fOW6wRdCcgPRqNy+RntOxXk5zCx11uuypNMK9rGMwLEENLD?=
 =?us-ascii?Q?UJPUcAeB5hY2jG0VOdj6rzyh09F3kVXRZD3c95Q5gEFmeW8RbpqGJ3OPSKeM?=
 =?us-ascii?Q?uhGRTNibdyuKzuO8UYrXzhBh94wHq1OjUldVjthIYx2nbla+BZPuOtIvyhoC?=
 =?us-ascii?Q?LtKUxBFv4w9unm++dWaV4gPkG6ClaC9q+7zmXEvecGXdVeS2jzLJ6mTeKR82?=
 =?us-ascii?Q?YugYTHxtMI47nMaRMBIHbqCnm4rcKLj+oTH3zUB1g3Do5PLi2oPTWZp+PTxP?=
 =?us-ascii?Q?Qu90G7LISpgXvgdDGOugrWk94FXL//HgTMBKg3gPYqjhNJqJ5JZo6fQ86vAg?=
 =?us-ascii?Q?Ytb3E1x7l1uA6ZcnCQ/CeiQl9QdisrWCOigDvkpa8FtR6FAlwGotB40X9HDq?=
 =?us-ascii?Q?U5DlEZ46+bs0Zv3MJ5jEcxczGJixR1c2osvBXZ/F6JjsocCq8sjwbvDNYeIF?=
 =?us-ascii?Q?1NK8XGV/O0h5g4EpFO7MHZ2WvHrr3603bTnGux0poABuKH4l5IKhEsZdiq+P?=
 =?us-ascii?Q?4HNm+m+FgdPH9rjdSTRbpAUU6v4aXT/vPg3AzM8rz7KF3ClKu17R6966VHgI?=
 =?us-ascii?Q?RJcCr0iF/yjB719VsG7k03F1t6iqIQXQdo2wF5HMzfwudizDfv+6+p9JMT6k?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B392495087614498B6F7F7A5BF9ECEB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VuyWmC7L/zDNqB4nxbscfPbO9TCHKBHCbN/p3RnhH3uFn6D8G4o+yECHygCK7a7v6iGfTDqdDh8W7Aob4HPr7mSe/e4gdQruh3MclDL8mM9SzEHgucDM4v4UFXFW/r8y5dlK6U6pWEfTKsKmZOTqLTjsEpG9nuA0VjDEuF/+7Rwj/SA6BmLyo7EHA1Ut/Zn8NYCSqew91YitTqZbrCvH1jh5fbBa/e3GyNPROyGYjUYuuGBbg6Rmn6Ff9fOwH25hZP47FKeZOtNBcLWkJ3htEK+YIZpIYh0vY0rymV59TTDfLmirtW9fYUraxRkBkcoAp16BlVNzbWaXtaURoct7l74tmM1plHnZ43ZNA8gYazlTnrV1YJ5ETQfw4Tf7JuUANhJDYCb4wS2p6DCh+Q7Q5vKPMfhab0QZKQg9apjzqS7ZX9G2FS5dikkAF7niKvuRSfhm921L7ZUG7w0AcQd1sb/X7N6aYmbr1hAgmXqarMj0g1WE5tuCYUksqM91ii2Ke59MyCbjVzbHikrq/8Z4n1TDMF96nRaLQKQA7M9kKzYdwSfBxKAu7/iRpfpnKgqKl9upVqFF+V/LnHYnlz+396KGaW8TR0zHCQoKGlco/l2L6DHcUeK5J6AKB/S2G9QT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fa0c99-c2d6-4cd9-31c7-08dc22c3721a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 01:16:40.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAC523Nh35U60tQkVz2V3WYHnp+8oXp/tjU/9e6XuV/oXFmYGqnmCbrr/eCpv7o8Wsl9XiYTRVOR6w6LIU7TvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6767

On Wed, Jan 31, 2024 at 07:58:43PM +0100, David Sterba wrote:
> On Wed, Jan 31, 2024 at 02:15:32PM +0000, Johannes Thumshirn wrote:
> > On 31.01.24 08:15, Naohiro Aota wrote:
> > > We disable offloading checksum to workqueues and do it synchronously =
when
> > > the checksum algorithm is fast. However, as reported in the link belo=
w,
> > > RAID0 with multiple devices may suffer from the sync checksum, becaus=
e
> > > "fast checksum" is still not fast enough to catch up RAID0 writing.
> > >=20
> > > To measure the effectiveness of sync checksum for developers, it woul=
d be
> > > better to have a switch for the sync checksum under CONFIG_BTRFS_DEBU=
G
> > > hood.
> > >=20
> > > This commit introduces fs_devices->sync_csum_mode for CONFIG_BTRFS_DE=
BUG,
> > > so that a btrfs developer can change the behavior by writing to
> > > /sys/fs/btrfs/<uuid>/sync_csum. The default is "auto" which is the sa=
me as
> > > the previous behavior. Or, you can set "on" or "off" to always/never =
use
> > > sync checksum.
> > >=20
> > > More benchmark should be collected with this knob to implement a prop=
er
> > > criteria to enable/disable sync checksum.
> > >=20
> > > Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F=
4@e16-tech.com/
> > > Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcn=
a6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >=20
> > As access to sysfs and fs_info can happen concurrently, should the=20
> > read/write of fs_devices->sync_csum_mode be guarded by a=20
> > READ_ONCE()/WRITE_ONCE()?
>=20
> Yes we use the *_ONCE helpers for values set from sysfs in cases where
> it's without bad effects to race and change the value in the middle.
> Here it would only skip one checksum offload/sync. It's not really a
> guard but a note that there's something special about the value.

Sure. I'll use it just in case.

Maybe, we want to convert fs_devices->read_policy as well, to prepare for
the feature we have more read policies implemented?=

