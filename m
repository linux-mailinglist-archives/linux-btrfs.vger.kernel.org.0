Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325D533F118
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 14:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCQNWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 09:22:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32056 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCQNWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 09:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615987344; x=1647523344;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PCBko5VhvqHX19xD8nDTiTx3PIdt0m1HfNCbgKzs/9Q=;
  b=FI0klNhiR5tg2ai/k6bt96YmUVGJxAs+oBUaea6RF5z1aqc//nxyk146
   +IoyeF/q/pzBVBTlZj4SVxBSefnCO5G8t7/0SLm0xLQDTNTF2n8tjF720
   8yu2MaBKIO5tArJs4P3D+LjJ71g77qvNyZlO/w1EymDG22CpUw3Bm+u9L
   O1o5M4KQatng7dYG7Iy1KQ+pQkBGFA8mJ162n44Hhr4DUwlu0AJ1Es5BQ
   UtBT3BRtlP3V2SwRh6g8BfdAu9tr71tbV5kmR/L2y2oUQb8AUjAYJ9QbI
   ltYLn83ffM9KHMEp7X4rZoSeGDtGWqxsfpfBssIaqNfUkSHYPJqCmjdTT
   w==;
IronPort-SDR: zHdLuElQr7g74EV0+qw4Y2x50p+1VhZnC1m0q5UERMy2jMhYkKCucOVq+uuHCeLWjwzAg/nCeO
 rgz36Q8Im7pkdSzCYhRO1a8d+/lNuIbX+yOitpM5S/4aZwLdKWuddcLZ8fWuUAQMmNcd5dz5Yh
 aw6iZrFHQUov6WpHi4iFfw5gR1H8PyVSBNr4FWokN5Bwd8tCPXd6p98dyxZ3c7E/2a5vF2tiV4
 JhlQbyTMQm4Q+EMhS2Tp9uh5Od1rBGTuSTFqFcJqutKjpUVFBO8qW0D7WxvM2KGH6t+JvK0ZZD
 4o0=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="266757807"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 21:22:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4kV6ukKUq2v5n2Q5nCaBdRGr82uKmtcuwODCfyA8lSOnvvXuv1u6sWYFSig5hbZC9LsOx7YilkcqBFzPQl8PXaLBA1O9v9tlbLUkZZLXwz/q0fqJzjj9Jn7dd9ex7kJdE+yA2kcUZiOMlFCVD8kWxMePq7RQsUb+6Ov3spHQN+BKLhE2VoTdPHwfE8IdPwOyHAi3r9Qgr9UkLtP8HwB5DDrFS2tel9xYGxKV7rdeMMuCWAvQ0l87AZD72cIDr5aWEZgl/jiRlIAzoydUpJulR7cU6/dkOm4Axkwxhob0/A4C7OVvyFO9cVmBS484WKZMcHoEYHvfNdW4cV+jOk4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCBko5VhvqHX19xD8nDTiTx3PIdt0m1HfNCbgKzs/9Q=;
 b=YA+hPPHozuDpQpoQgwzj5HoVUZO2wN5cC1MbIVS+vv2URMAZLj7v38OMA3O49rqSDFUCwO+MXAMgnPO/NyumJykqeU2EiAyp3664forPFzCR/u6rbpDxyPiVDpdeLBoQ9QfBBcttqgCEQlnUnTemSsOa6Fo6fExnyG6KFtVFM2RQQ4BorvtTfnrv4TeaNfwhozp4gLpfMvSikAAUxz+xmIJloZxAa3nibr82nnJvYPnN5tZz1Ib7jFqxNVQkCbQ4BmrNZu8tgb+6U6fNk3/P3KbUmRp+Ja5/oTBaDOPyd4ciVwsReoDW3pg7hYfdMAM4TFNK17J7MDkrB1b9krwZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCBko5VhvqHX19xD8nDTiTx3PIdt0m1HfNCbgKzs/9Q=;
 b=HNmSB1QXwe2H3trX2RDRtrTMS+y+eFvpdqPN09hgC1OaeSAWzUqBdNokXNN4wtPCyKrck80cCSJar54eQNVBW8MTMN1nautF6z6JxW5h9eGgQAb+X95rvqGmVDDm4oM8Ti5D7ksPxOr4z5cFFXT5xmu9mnt9zwy/M5l4bqgztr8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 13:22:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 13:22:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Topic: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Index: AQHXGwuXgKGaiXI7vEOD28gRwVSOCw==
Date:   Wed, 17 Mar 2021 13:22:11 +0000
Message-ID: <PH0PR04MB7416C9EB06CEE0A47D66FE7E9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
 <20210317105156.GO7604@twin.jikos.cz>
 <PH0PR04MB74162ADE333CCD6A943802A09B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae9a463b-fdfb-4992-6f7a-08d8e947ac8c
x-ms-traffictypediagnostic: PH0PR04MB7653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76533C1B0E1EC80B3F51AF909B6A9@PH0PR04MB7653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nG94WzZgPPT/VwW0UHceXlZEpBbQ7rZfUDXznUi7arNtkNDkOvPv2REHsueVflgdnJLN50170odpOSG+0jhrTg3wLYiR10GZYA31WXJmo6rp2WrSl5WWUBfKF/RqZUweJ/QxwoSicohnuIfzZLpf4ltQmWoXgy0pTBskw12Ca/vrXjGS8aWTzASiMFR5u6fG/Pk9ioRnlxW8yMnASmxX6uPFoLExzVIXNT7lu/w4R7I3fNjTGNCeWsmP21RIaWp9CbpedauAkh1WwMzAHTgLdM6OCQeGR0loLpjE8nZiHwuX++F0Dw7r81qHLdT1RJqwS8bDQ0El+vS4MTpTDXF08MDC53pZIOtTsCO+isBv4UkBEaGIJeqL/Q8f0eFbGpCDWs1gVsYHDdxEconOEFvpQMpPGX5WcbcJ+77e42QwJIIkgYTTyFu48t/OL8q55NokDMy5B59JYwyaaHu9GhqsOQrOOufe5Ala1zdcBzrhq5/S41268rgJt6cOMAVtFFvBvquUaLZVCgS2HpdEkkX1neOJ6W+W5098ADNUpYWrmhPx1UhltuMen3LeaG/HQQmD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(7696005)(2906002)(478600001)(86362001)(9686003)(6916009)(8676002)(55016002)(33656002)(53546011)(66476007)(4326008)(186003)(66446008)(76116006)(66556008)(66946007)(64756008)(54906003)(8936002)(71200400001)(83380400001)(6506007)(316002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nc3dBQ1S19+zcSCVR1p878Urcfpex1oSKqfH1AIKmVe9DOerIJMwgZyyE9lA?=
 =?us-ascii?Q?tIhLgjAIRWJD/9E9n0MrO1ws7snuoPWDZr0lPWATsSkffeVA37Jh/W/2SDC5?=
 =?us-ascii?Q?WsGhA9DtOeJPNm+WXW6f7jnaqqsLSFdhxJ7Qpha5RvQYFTIsGJCPvP5GYlbq?=
 =?us-ascii?Q?B+hX64iCZ6yW7lPQd+62BMRMxcgqvHuHYYBOInXtLpDKFfcdk2LbqE3Z0zDh?=
 =?us-ascii?Q?mepKua20b3VmHXF6oaAzd9jl1rPLR8dy3zEHr86UKFI14roVOCXTppJ8bUoi?=
 =?us-ascii?Q?c/NX/5Nf8mHahlsRW5tG2X4gQz8qMIOv9LS4Ack3LKYiDY18d6VylMQO0gs8?=
 =?us-ascii?Q?WE4Rr7PCs74L+c5WNZfMv4yNFRkECYQkrCJSx75i2XvGnNr9EKV7FcCVqFyD?=
 =?us-ascii?Q?89VR01QPWsQ/THzgHJBiOBYfmS5tUVLp1eQnmjKcTJihwvsvniaerd5r0kgE?=
 =?us-ascii?Q?4wNDfbelxujbszNvUMLivsMgJ3l4g6N5cz8oh2x5QIXU29vTgnzRPqQa72sq?=
 =?us-ascii?Q?1BRc7LwIbja+hH1NibJeVIkC2CDXPAjsJ9Fm2bg0F0Luc8sNu0EqAhlmdggJ?=
 =?us-ascii?Q?XVpCPOQdUv+GFK5PhqaCIo8Wp7qoENR5Yj8mUk4c9xW/a42xjKV136Z3pmom?=
 =?us-ascii?Q?sQPWPCjUHCy/Bxcri6fMl1hLPDD45s4c2xQnH4jK+xFCDKlWXx+vlU4As6iu?=
 =?us-ascii?Q?uXO+ecXyKxliINqdTHP03Q6KoDp3rGKRuJ+GGr0SfXZCyGiistHT930dETB4?=
 =?us-ascii?Q?h1N4LsDFFf7OHJ6gXdB3qSGL+HW6yaInfN2KY1EThfZOVZRnSPyxJG3PsI+K?=
 =?us-ascii?Q?rhO5pa2G+JmuSZvIsRcXQPT0pReg5H4zi9xODtl0tqmzZpdKNorjNomy1Wtr?=
 =?us-ascii?Q?Tcya1A5qOp5PP2EIIxDjxM0wVui3B/mCwDKQCEPhOZm9DI1VLRdVuY6IyNg3?=
 =?us-ascii?Q?NE5//30acPQneYDjcYR3LFE1io8w3xtWKtIY6txcCYOEPmS/GwjpVxyxryWi?=
 =?us-ascii?Q?072DQpNVkIyBHx+83hLxWig/SjbE5Pe1lEgwKb4G5n8GyhB4kYwWEj/s3d1E?=
 =?us-ascii?Q?uFzh7Vnn7o30O8KfdVT4OG7nCwfMozSiW977wTLofOzB8/Un4rrPOUBZ4xPE?=
 =?us-ascii?Q?zX49ZAgEkPqVDgPZzRfmrGJ9XitjFt2hN6Qy6QsT87eJkFEJ8BprhikVu9PD?=
 =?us-ascii?Q?ro1vXqWNg1ouIWfMWg7hwyltpwAFCGx3Vt5PdVe5kJ/WBWMmKBEU54SnudNg?=
 =?us-ascii?Q?O0vSI4mS63mZ0hmUmtdFKYTPfB0PIR+K/S8RFCeZhwCdaygRzQDpTlu5695L?=
 =?us-ascii?Q?6ONqKvt9a+Q4ZW1RW+VWvNkLK8WkNa4CcoogrfcUVahxZ7tQK9cmmpmxZyBV?=
 =?us-ascii?Q?O2UBaQLH3zK2G4d9x55xc308iZ4rcPzSrdIg2eJcwdYpa0Bdyw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9a463b-fdfb-4992-6f7a-08d8e947ac8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 13:22:11.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GOenHQSRd1ivcxe/Z+odJ5/XEv9HgyswibDU/Z+VyN3xroyEdeIFp1YqmI1HkGR7qgpDYNNBzC0+Ko5qTFMMhpqtFskRXWxUmiP+mpUeQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 14:20, Johannes Thumshirn wrote:=0A=
> On 17/03/2021 11:54, David Sterba wrote:=0A=
>> On Wed, Mar 17, 2021 at 05:57:31PM +0900, Johannes Thumshirn wrote:=0A=
>>> In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if=
=0A=
>>> we're submitting a DIO write on a zoned filesystem but are not using=0A=
>>> REQ_OP_ZONE_APPEND to submit the IO to the block device.=0A=
>>>=0A=
>>> This is a left over from a previous version where btrfs_dio_iomap_begin=
()=0A=
>>> didn't use btrfs_use_zone_append() to check for sequential write only=
=0A=
>>> zones.=0A=
>>=0A=
>> I can't identify the patch where this got changed. I've landed on=0A=
>> 544d24f9de73 ("btrfs: zoned: enable zone append writing for direct IO")=
=0A=
>> but that adds the btrfs_use_zone_append, the append flag and also the=0A=
>> warning.=0A=
>>=0A=
> =0A=
> It is an oversight from the development phase. In v11 (I think) I've adde=
d=0A=
> 08f455593fff ("btrfs: zoned: cache if block group is on a sequential zone=
")=0A=
> and forgot to remove the WARN_ON_ONCE() for 544d24f9de73 ("btrfs: zoned: =
=0A=
> enable zone append writing for direct IO").=0A=
> =0A=
> When developing auto relocation I got hit by the WARN as a block groups=
=0A=
> where relocated to conventional zone and the dio code calls=0A=
> btrfs_use_zone_append() introduced by 08f455593fff to check if it can use=
=0A=
> zone append (a.k.a. if it's a sequential zone) or not and sets the approp=
riate=0A=
> flags for iomap.=0A=
> =0A=
> I've never hit it in testing before, as I was relying on emulation to tes=
t=0A=
> the conventional zones code but this one case wasn't hit, because on emul=
ation=0A=
> fs_info->max_zone_append_size is 0 and the WARN doesn't trigger either.=
=0A=
> =0A=
=0A=
I just realized that explanation should have gone into the commit message, =
do you=0A=
want me to resend with a more elaborate commit message?=0A=
