Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF043C3BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhJ0HWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 03:22:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53636 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbhJ0HWn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 03:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635319219; x=1666855219;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q5dsw7HUgJzJoM5qHI3jmgnSDEKcHGbpRp4Pa83GR0I=;
  b=osYm2JQ8pIf1xnxq8DOq7298SNagwQeaaXXjtxbQNdO9gKGAndns2xK3
   NKPphg/tXHrI9sexNwVPLJvhUT87eD75BUPdSxEUcD2ScJFdquL0rHJnW
   AKBUpLP7qRMVxfB/aKbHAaMxnoUmjUTp0notk2huqtSA54y32Jbte0p8n
   0wiLaOYedt9MY2CMk+LRUVLtq9yHsjCmhSfcIrKlAewITsJ/GpW/DsICQ
   byrqvZ3ZEOHOSfuCs447xOxIsXVvzxM7nSDl+SN10U5STkHIy8HSrCaS3
   2rm7ElUvF3hLafNGqKB8yj6S5LW4cfhJSRtVQ+hkCiOuhf4T1uRipC1Qs
   w==;
X-IronPort-AV: E=Sophos;i="5.87,186,1631548800"; 
   d="scan'208";a="184883436"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2021 15:20:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It8qNXfO+EKciu5S8fY6+O5k85m5JYPxlWWkgGXLfgBfRI/FubT01WzS/FRJhAAQJS8/8RQxr9V402XpOEiL3nCwjJcdbxRPS0Rk03g3CR4pzPghuNiLuOU9sXlD0HwMCHjknQbSPFWucvOqW9ITGRgIOzyFZf5gpovu85/PBlwy3ZFVK+EOXC6Rfn7dfNp726GO2ERGtgIQa1swE+8hH+/14NH3l78ZCimIYzoe8iSE0BOU3gpDc5X1i4YeaGRG+/TJCmbypZiANLmQuwbgOq4OOQeca6nQ7q1Dp3P3tguEq26WloyCAnmeyxYrizYC8DzqUHYejK4eqFEVAut1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIQb64HVuddMs85L0XknJ2YSDOEgfAcOu8rJsZWg3IY=;
 b=MtE6RIWQjKZT4mDJ16SXHLY9Rch5VP/9zq997ZvRqFn7z3KycikxFVxREtSNOSH4Lk+FcD8HjVyfpplK07ZocUSclKGdAfzDyQRdH1So1MIR4m4n5IWAEHsi4E73JZAo+WEEUoAAcgkeAJlI3/9MkvzsD70/YH4o0ZFKXvgC78xdKJryaqxrHYf8xhQ1jfOmU/S1X9oOICJ9KgNQDgXUfVLkxQWb1bZk9XCaJ1xbdIo301OnEiHQFTDly/wk/2cNm9cC29stb17BS6Fkka417YaMmdRXN1XPrRfASMXaMKX3BZsA9kqgef9slt/ks1IPPw3/5yrIOtuwzTMN68qfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIQb64HVuddMs85L0XknJ2YSDOEgfAcOu8rJsZWg3IY=;
 b=Zspej2cfQ2A+msdC7vIFXZqzTNig6Al2r+gmBvCTNo06+clPPIbjd8XfS5m8dWHI/n1gPyXCz1eYyLtFm/elmgNGxh4WZ21mUlDq0t9xcZv7rxYBnalRNP0UcWwVLO63DMzT107hPRl/9ia+7EfEEb+5OBaOvvChGs7/YdErsIc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7574.namprd04.prod.outlook.com (2603:10b6:510:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 07:20:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 07:20:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Roesch <shr@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXyordsU5W6HCCtE+CLExpPEpQgg==
Date:   Wed, 27 Oct 2021 07:20:05 +0000
Message-ID: <PH0PR04MB741631D6EFC03E3E54FB881E9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211026165915.553834-1-shr@fb.com>
 <PH0PR04MB74165B2A0D395AD9A45310C79B859@PH0PR04MB7416.namprd04.prod.outlook.com>
 <9a0a442c-8409-3401-da85-9032259a7bc5@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ff36448-930d-40b4-ed05-08d9991a3332
x-ms-traffictypediagnostic: PH0PR04MB7574:
x-microsoft-antispam-prvs: <PH0PR04MB757485B2B37C6AA6E8890E069B859@PH0PR04MB7574.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Sa19eRpcG5qMBTYzFrYoNrwEBJHDbYtqZJYtu9kgaUzM8jHHmTCV04i7xL/ETVEXfBI7n1G+eH4SlKiPTQPRYExaD5RZTF5zqgkOH0l3wOJUwjEJrCDFiALAOz20APBGDnrueCEiKiGxQmuRqOpZp6vtLh9HPDUZ2mTLT316nuPQd1H4RdIz29NuKMC7fnTGnwBFGzegyLiOESgIcvkKGRyjlC21JfFI2M9GQvRASJfvObGThybk1HLmIjPy/VYOyn/aOsoRuy2AI0w49ZLwwK4wfQ0CXRYRy73w960YXSWnp84bxP8P9h2CPlc0uv7q0a0lHMH9kt52prblaZHDtT96FLFKGZmGFvEZajFa1sqX1K8DZmF92tfuB8gUTKp+ouhKUSJzqmfAoclak3/BzjkYH8tM2mPNO3xhPB/EquQ9aXn51yQl3XvAdDNF7K1+CJM/GyZVU+QKnuynpoGpYI4v/0f+3EzIvhqRhpvb+hTKXFF+3pD5M80xvZsxJAbkoI8Dw3hhgZkZryRODLjvDwuBtqCHn9ctSHIAONIyUo4XG+9blXACs/tNWA1CCipNNuyEG6FK4Jvd5fcT28Ad1h6iOr9a/arAFm+SSqEpA/1QX7EOc7nO+s6QxlmfCqNPFn2AxAv9P4gf7yw8I4zPvnPXPYpQax6/mgbJpi+UMJsMza7hQKZTIoxjI+dEdxSWc/WwSyt/CgzkeD6QIiyww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(9686003)(186003)(26005)(7696005)(33656002)(8936002)(6506007)(8676002)(82960400001)(110136005)(71200400001)(83380400001)(53546011)(55016002)(122000001)(86362001)(508600001)(38100700002)(64756008)(66556008)(66446008)(66476007)(38070700005)(76116006)(66946007)(91956017)(5660300002)(2906002)(4744005)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KMIZP/7ds8WhjFCD9EAyesCTe6N0OloNGkHYGV4pEk5OWMvFTxD6+YyNNjUn?=
 =?us-ascii?Q?RIXbr2S+z5qMKSH6F9hoGJZNqTgAjVhmeQ4F/39lS4wS2l/WW8PK43Xm4nWw?=
 =?us-ascii?Q?oPCfPA3pAjIHKFYT3kAZX8xxIyTQxsT14VzeS+LaNDjiu22uouM3Gv6r1FTJ?=
 =?us-ascii?Q?TgLwc7wZhDxh6Ya0ev9oIes2otsO03Z38eSW+38Qc9MCsMVsYCJwT+3V7re7?=
 =?us-ascii?Q?Fcg5U0JdZyT3LKZ/jxFa+FmtuAQ8G/3Reopd/fcmvkv6y9khbsl13+rvwRo4?=
 =?us-ascii?Q?7pcCjx6sk4+pkQXqq5ITH9g/X8kUNaofEKzrj/FzaVSlv+xPvxqOjR5kF4Gn?=
 =?us-ascii?Q?Bt6PtlxH3ZwGYOxt0obJcFKm29tTppyFpxi6K5lEe/tVRy0FkppliWkvUL8v?=
 =?us-ascii?Q?ytSOeh2E1APe7KymMBKUYOMl1FH7XRDYmxy++BUk+WBju4H6xM4xis+jbQoG?=
 =?us-ascii?Q?wCy8mpQjLISreWwMFCLWxU6OCp3FnNJRO1mZMSka4vUV0WsfSIog/pMTapSP?=
 =?us-ascii?Q?sQk6BSQTj2uIsTD09GSbHLZSZjkhyUjQZ5sFIFJM5LK6zle/CK2v2MFtF0tR?=
 =?us-ascii?Q?1L+ntr4r54LtS0HC5yVYzEMzokh61OMY83EOu3RHMymq/tRupC4hM8EaClM4?=
 =?us-ascii?Q?1EBLTAR9cHEGW9R+/cVqpjZ2n5JGfLtblEBAoMAvB1LI7Yek3/CmkmgyEotp?=
 =?us-ascii?Q?Bfe0pb02MGGEdS8LTm9YI2pzPmVRZDmDnvcUfY9QAxXC0uuYEUpXJJpyq1Zl?=
 =?us-ascii?Q?Be/IwFzEgK6nZForc46Q84D/7AMtfjWPCR6BH5z4mFiFP45k9ObpRDWOqPfv?=
 =?us-ascii?Q?DpEGC/amSLc2c4lyiYFCV72eIM5gSVvDfSwvpInuKcPuDL+izV4GuFfgkbhx?=
 =?us-ascii?Q?QkooAH0m1l4ElM43DN61d4IRoTP9hMDczhooAoqdLXOkGv6wZgBYdmGPSuNa?=
 =?us-ascii?Q?2Ke4Zq3GCkZoFC38tVAX6Og+P8U4U+xZletdY1rBH08zYLUyMYkqLIyZMJkj?=
 =?us-ascii?Q?qR3VYPmiDAgGIjPrLdKMJJUDrdXoEkFhpMvKB2rauarX6MpCYgRxHqyDQeK7?=
 =?us-ascii?Q?rHeePwbDL+Prt5K5kJYrAjoqTGEo8zfg702YvngJ3kxjcg8nzVYOh6+RxHpQ?=
 =?us-ascii?Q?M+5uLGznwZhLhZ7ecTjpQgviRgWHJRCscDZ6FoXSl6hzYuNTp2cefQ3kyjKE?=
 =?us-ascii?Q?KzmujmSWZ+iLDBtLUicB3cUVmbpiw+bumZw2Dg02+7bW5RXdOIbtsKpHNsM5?=
 =?us-ascii?Q?a2zEpJokLavcX4goeHMMmnSfM+sPEgWoQbbrhd2rPTMrjVyPDvWfOdC+lID6?=
 =?us-ascii?Q?w5clHg2cQhc3/DSX3aFaof+7pBZcqtS8RXr42WZ30/cn15vtlsWslfnDLUNm?=
 =?us-ascii?Q?ZeocU4C9TX3qy4fgaBZKlyKT+wav0sjn6BkzAfmcdvx06erArLWmniZCDqEZ?=
 =?us-ascii?Q?KBsEDIYG0rRaNh3XUAmiwG/QvdeyH/Cr6TLUgIEHPYbGYj4hPK+/qfTupLTf?=
 =?us-ascii?Q?6yn/13a6ATRLmq05odeGN5yQdjK2Ro1ECutNACSlbu5x3cB/GAIfxJ0oc+bk?=
 =?us-ascii?Q?sWTe5wz9rVSPfEerx2IIROqQ5TR1HbWJuRnQhsNqn3iDUF3JKVz4tqGzz+py?=
 =?us-ascii?Q?E//MaCCM44dafxyp7qIqZCUuTHnhQh8s/SQKniri4Ygf6mJ96riMTuzI82ve?=
 =?us-ascii?Q?2tN2/+y48M2jLEVemo6Ryf1Dj8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff36448-930d-40b4-ed05-08d9991a3332
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 07:20:05.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EemYm292swLjEEBdgv8of1aiSjD+zMAuY6aIEMpybARrEii9WyXP9qe+k1+u9/moVAw/+gjpQpPPL4S9cgsPMJo481cbjWoOvjX5nelAZ5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7574
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/10/2021 08:51, Damien Le Moal wrote:=0A=
>> static ssize_t btrfs_stripe_size_show(struct kobject *kobj,=0A=
>> 				struct kobj_attribute *a, char *buf)=0A=
>>=0A=
>> {=0A=
>> 	struct btrfs_space_info *sinfo =3D to_space_info(kobj);=0A=
>> 	struct btrfs_fs_info *fs_info =3D to_fs_info(get_btrfs_kobj(kobj));=0A=
>> 	u64 max_stripe_size;=0A=
>>=0A=
>> 	spin_lock(&sinfo->lock);=0A=
>> 	if (btrfs_is_zoned(fs_info))=0A=
>> 		max_stripe_size =3D fs_info->zone_size;=0A=
>> 	else=0A=
>> 		max_stripe_size =3D sinfo->max_stripe_size;=0A=
>> 	spin_unlock(&sinfo->lock);=0A=
> This will not work once we have stripped zoned volume though, won't it ?=
=0A=
> Why is not max_stripe_size set to zone size for a simple zoned btrfs volu=
me ?=0A=
> =0A=
=0A=
The other possibility would be to have compute_stripe_size() fan out into=
=0A=
compute_stripe_size_regular() or compute_stripe_size_zoned() which will do=
=0A=
the right thing for each.=0A=
=0A=
