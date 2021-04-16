Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5D361978
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhDPFva (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 01:51:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35339 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhDPFv3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 01:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618552266; x=1650088266;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JCmHcoGn6zjUfEotlhtHtZhegGpRc+zqcMV6zXWSxNg=;
  b=MXWAh6vprZvrMK2Vv9csWikpU+ASzS2/R9gW8P5vFlhXhrszxs5fB5P9
   IyubugZzMjXXtXt6NlC4Nb797X/AjRou/6i3pteLXoIrcPPCEgqkhgC/u
   wjH6BcQZjiFknC/f4L/LO3elJvju0Et7sd6ZuGV9eBrMzgsjBWzpZxWqN
   tiPNHZz6GLHnNYBjTemTBYyucKSg5cL4IFM6yL0GTDnensbHObUW861qk
   r9ZvYPag07TaR65LQ3rfBld9ii0ns3zH2/tTWKgnkRTmL+S4/84Ij9u33
   8eRel6Hbi6xWCK2kY7MDtQw1//8TB65JGhRVZMPoddJo+8OHW5RuCX+UV
   A==;
IronPort-SDR: XjlyRyReJ0f73XjEHYXD1Rh26x34ovo6CiXK51EJYzw+lX6No2IdG8S9ms4oPQF0MTfrS0sTyF
 LvHPJEQqJ625tIqKZWzhgQxRRX4epjuN1Iv6e34U1XaISUr2vLpPyrLUmYbTj3bSLNEPhUOirP
 Gbbw6D42C+hDmb5TQ0ZhUcjP8dLJxpEntC7Ya+NSja9tLy1lG2h7dUd33gYjSw0dT7IxPqNuQp
 IEUFWihhNRUJ+rtkz95zFJcte7dBVCnNLBsOvPR3BNh6zuEl+z56Fk3/OQaPst21QF8ZT022eh
 FSI=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="165613672"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 13:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlP4OMNpVPQlb1xSNc+YDe0BeEI4NM1B/EUdXY4cPHMH4BW9gud9O3+ERwYFNRrK+4SnxoDKwA3Ed9esHDV5ln65ZT6wtueVN0uSGCmgIGls0C3yBP+urMwsjtxGgZ/bb7YE/pDQBcmYBkklPtJw8HKUMWg5dClXBea3sAqvHbLFH1jcNSKXSz5zTBFkQXcaiah7+/TAClyzJ7213qLgWBbKQev7SvXF3DDDPM29jaxsU8uieisN/sswITu5F6G95hCp2QaIhalElSKsaahb4VSopThHc6luAmsq1DgjEN6kUfXmXiv9twSQsGn3IfdSJVjT3Blje5gOfEFWwEEgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGY4HciLTyZc3CcSXVXJqfh8O7xTMNTgsjP90/FyLYw=;
 b=QSyldet4/uVlUr/qPhiuJ6XSwU8UJS+Msr+8oW8shSiwzva4HtS3TQFcfcsx8Tu8pgq+KTzXw3PQB4rxvtAJFIwxrOETYCALMMaW6u915Q0t3DZPSLkHvy9Gta0R2K2kFSmPsBb72dJ5CQI1yz2Rf2mlTvAvYF4S0ZEvr6wFAgFy+gsYhsBET1nKG6SHmoqyMMYb7+WHOrLY727I/HRtlejxItgod1VjULYEyMyyRXGRAZBK+S5qsZcrl1upX49shZEeOqLLY84MeQc4Z3sjoRKU9ijqkHkC60gRsDM1Fyq2C5gZpikLdfph7Wb+MYneBmIdIp8nJAEFs6yu3N6YAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGY4HciLTyZc3CcSXVXJqfh8O7xTMNTgsjP90/FyLYw=;
 b=c6Ilzt6WqpsHWeH8u86x2GphJ7CjM40m5um1hPU37il5dau6OA2ub6Rnf5UW3MXTdmw2vOTV+WLBfgDnGlIimMS83piFHTFzngoodG9biSB0guPUPdDpEvlclOcPqVrPE2RCFlbivqbk2KVK4wJrMFeooLxl3GNuT9jpGy/2R+g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7286.namprd04.prod.outlook.com (2603:10b6:510:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 05:50:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 05:50:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Topic: [PATCH v4 1/3] btrfs: zoned: reset zones of relocated block
 groups
Thread-Index: AQHXMf93GJooZ3c0CU+2cn3hwVcHMQ==
Date:   Fri, 16 Apr 2021 05:50:05 +0000
Message-ID: <PH0PR04MB7416771017592BE6E743DA499B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <d3aec3e168a547dcc39a764f242d1df9d3489928.1618494550.git.johannes.thumshirn@wdc.com>
 <deda311b-3ab1-fa89-9700-73b2cf049be1@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4639cf1-33d7-476d-5905-08d9009b7c62
x-ms-traffictypediagnostic: PH0PR04MB7286:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7286D901C5BF67A64EB25E0F9B4C9@PH0PR04MB7286.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AGs1oECXjQITfv48YABSBLplVwo29GTWeGc9yZkm/4pN0JK7em3YM3iWc+Ea3ON447KnvyGKaLXpyGONB3S5SJpg+PG8c0Pu7yk0kjn5HQlC/H4Xa7s4odtY30X/N35CLKR2Hzr713a1x9rl3quWdU5/stJZ4fn5i+F1gYt44zjRaUga2Y8/+7UvQUmjsRuxVzPc2L1j0TAyvJS0PnOKmUTCitCHzziIUrJi2Rm8fkuUm3Yp4NTtCxdd75nTnq76wRxlOnFbj+3RUAOR6xcy5X49TmAZsyn5X8XkK4ZVLmfqDPriJ0VS/vQVIyAZvey2W5Lw5ShAqe/Dhw0Fx2r8aelvFSEVJQ8ETclJYHy/oQXj3SkJ+/SkuvuL0i/hBKQprVtB5ZGAsiEhwV5AOxIT6ySfnWOlr7pvwZHPlo/THxmJ7LeCIx3u8qRsBBZ+0tRfiQ9K9ezy5XyWUKRfDmkOL1TXgeV72a508bFtAhWQRzZ6P/+7KE77PIw6KyEnwYeOmfAGS696fFGSbpg1HUKlPig/KOSalaS4mnzJ1orr+P4jiyloNmtkGYRMgW3NGUxbyvt0l84hMBvAk5LLNxoFb4C3q4Lrhw/8IxLQH9gwU88abNZBTCDiJ1IpfZV5Wr73vzw2eV/sff4/PFV0hZqXNFLBsBwzDCgOB1qUnZYrZ9dEJa0hi0eT88dxD2Jz3X+g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(33656002)(7696005)(2906002)(71200400001)(38100700002)(5660300002)(122000001)(478600001)(966005)(4326008)(54906003)(8936002)(8676002)(86362001)(52536014)(83380400001)(76116006)(66446008)(64756008)(186003)(66946007)(66556008)(66476007)(55016002)(316002)(53546011)(110136005)(9686003)(91956017)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FkMpNj5C+Q/4lw7HWy2COmgjv4H6Fg4a0wIVn9dI1fQXf46Ks3VGbXGuVHQY?=
 =?us-ascii?Q?EOe2KR0z3U2/upNi4Vpc+hYpcSwO8URfIg/zABBBeCb+0J0BCJ9ls/yWEK3b?=
 =?us-ascii?Q?mGzHvkoTquv9nbcbqc5B043XPmk8GB6WXvlIiwHQ36AQdXgYUZcsf1Gn7eCS?=
 =?us-ascii?Q?wXGsDSsPMo15Sl6EWLDzLdX8wcaoS4FD8Y84fmkvqjc0X85C5cjRcQGhr5bn?=
 =?us-ascii?Q?a9K7upq5tzEDnXgNp3PtX5GUPLytkGujoxwoe/wuLyALHx/AMUeCpo4UBuYf?=
 =?us-ascii?Q?x9lERv+x6M4TonL7ywBDfKMmsn9lM/kODUwBleM7R70PFflmREs6z0CGe+ZN?=
 =?us-ascii?Q?NxAv8ahHKKWY5sc8RW7c+KLYzcXvoR+iRIfNSdAemkoiWOur/BGIHFIWf2Gt?=
 =?us-ascii?Q?QbaIKbrXAg0fENjM9ytgt1PfPEiKXpwZdVavJ1tsAvbsfI6fsYSSVFXuBb55?=
 =?us-ascii?Q?5wc/kPzq29UwboEq+lG1L/73Dynrc3Yh79kOEEAEx8dBXsp6Q9f0S2g3eO7f?=
 =?us-ascii?Q?LLqY7ofWV22Cmvxv1Ps/MSHXSUBA6zNN35JpYHhOwcFm3GF0biIkDSYOHIpD?=
 =?us-ascii?Q?7K40JFcBQZPAbBMSgXeQMzMu61qSXDeBBftvqZiIHYTfobBVBrglMieQDs4C?=
 =?us-ascii?Q?J2DPvaeJKGb+NCuLiBQ0RB9AQCGVKcldSjPZRsd13CDbzXH+BaoBFDTzrsG6?=
 =?us-ascii?Q?B5uPe/mBqzVl1jlNDIe2OWTMnIDCMLZfRy9yXGUgTIEpiRP73rrPeaCUekwL?=
 =?us-ascii?Q?2MXnHXd0TBtL+qNdT7pS+dpCUadajX60gyk9MLn6F28NvieYkNXfoOR8Fs0N?=
 =?us-ascii?Q?uynJobuqVawsb1P3hbWNzNJXJ7PJJYpnudEs11tAbq11RU8wiWmMSFVG9oVX?=
 =?us-ascii?Q?r/fc4YubwD/Cfi+AuaCknS0M7BDPyFm76OQIjiZ5ZQLRJCMcv1Yv+nbcqzFA?=
 =?us-ascii?Q?imA7c6C+TJ/O+vUoBCsrQJWMdyW4197ulxgcVmN244Mm2gYvqECtqmTpqeA2?=
 =?us-ascii?Q?CLrG+5kFF2iau1eqqcDboi4ml4vv1XX6DspA06ESZvrmaXC2SXElBSMrvD1/?=
 =?us-ascii?Q?KnnvLIgG7yE1xJg+miO4Xp0jJcJov36dArjqIRXmB0hMh8b9cFpvEsFvZvXL?=
 =?us-ascii?Q?XnW+IdhRNylb25lwh8C61WS7gxq0bpghbHWSOmId87d3otlg/PaphQvvPNiy?=
 =?us-ascii?Q?/K921gEP7M/y3WgtkIkZipAk3/SO+B8iDJdITnkANxnOM1n2RGP6+wFlnLOb?=
 =?us-ascii?Q?+KuEj/811m2C/HIErbm8pwMJoCPpH/LvoQohMbd3MK6m7hSiYeJ+/JXVqMHZ?=
 =?us-ascii?Q?4hQc/t8EbzULfvJYGRYEONzq/rNR5QLApDh2ua+0+alAD3/ptJZokN6C5PgV?=
 =?us-ascii?Q?2q5n23PYzrQzXntzZcfm+RvMUKUd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4639cf1-33d7-476d-5905-08d9009b7c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 05:50:05.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RFE3432syUA3feM2L3hBKpW57Ev7X5W51Xgv6cTFevBfi5ZaN9cpnVhUVyvrFFpRmxzt8B7UpYw6Z1ZauSV2g0itjpGHasDUBhyU35U2f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7286
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/04/2021 20:26, Josef Bacik wrote:=0A=
> On 4/15/21 9:58 AM, Johannes Thumshirn wrote:=0A=
>> When relocating a block group the freed up space is not discarded in one=
=0A=
>> big block, but each extent is discarded on it's own with -odisard=3Dsync=
.=0A=
>>=0A=
>> For a zoned filesystem we need to discard the whole block group at once,=
=0A=
>> so btrfs_discard_extent() will translate the discard into a=0A=
>> REQ_OP_ZONE_RESET operation, which then resets the device's zone.=0A=
>>=0A=
>> Link: https://lore.kernel.org/linux-btrfs/459e2932c48e12e883dcfd3dda828d=
9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> What would be cool is if we could disable discard per bg so we don't disc=
ard at =0A=
> all during the relocation, and then discard the whole block group no matt=
er if =0A=
> we have zoned or not.  However not really something you need to do, just =
=0A=
> thinking out loud=0A=
=0A=
I could say I'll add it to my queue, but that's already so long, I have no=
=0A=
idea when that's gonna happen.=0A=
=0A=
=0A=
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
=0A=
Thanks=0A=
