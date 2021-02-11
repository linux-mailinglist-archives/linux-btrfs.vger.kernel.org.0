Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6360318B7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 14:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBKNFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 08:05:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13427 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhBKNCQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 08:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613048532; x=1644584532;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Cjo53GquMgJnhXVT2FMsXKQ213EPkb7fnXQ7th0nYMM0xy87ZxyFF2Fj
   WGjvBHnpDnFQiF/fGjx6ErUKZzRzXNU2Sx0cKgYcGc0pn1Iiyr8O/TtIL
   LbdkCp2xPRjratk4ZNJ9nD96FKfM8bYtBVNf8KXxUda/tZkR+LK2DnoGy
   coT/XMAj8bHyvfK7vv1gsgh4W6AvqhRxse1ZUdSyvICASu7gIKSiqe61B
   s0+z1zpbKP9t+nbjUvML/zhoOdDNnZCzyhD88fK2sAn5OPaU4e3BfLZkD
   JgqtJNUORe0JfLB+E3GM29GFv4+TkQK3d7bNXSb0NVnUwBjKnHYAlPG1O
   g==;
IronPort-SDR: QabrmTEhwdcPFKoTy6JfOAf5cxOZPN56GJRsxiX66zzpcj2oBYpzgpiZJPH6mMzPT+EHwAf46f
 brGcAsZI/zRC88jrjGgEtP9pH94QHb1iMFAhk4LDBx5CKT7CEioNTulbrPwAPSmGis9ElS9ZRX
 7WduFcM+MtZdUObBJ0QZkfVSzDwXObH461Acq2qabJTgnTqAgI/rMYS5EnupA/WoiDekxLb2OT
 ygTIJ5VIwEgLSO0sVRUh25Z82nKg//PATveUs0wHEjeRW0ZnfOPiT/mNMzwFMi2hJZ6T8Ego9k
 TPU=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="159765321"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 21:00:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW754hxQa3CBySuSoLGiKr1F65j8ioVkGYRVjatnH0zFGsjh8rCIUDkKP6PQ9ttyPFpqU+8MjN6ywR2PS2gaywTnOXn+CT66kL586BrSW+OBC7hT0e/0CbubuFlQtTbk8sS682YZxT0ii39C4NCSH4Hv6rOIsUT0R5dcjcfSWagu8M90L11nCTU0gHsuLZEJXCurUw0J8dqjIpVSy03HCdvSIdGn/NoODnkQOr8Fgk0SoKThxHoPrmKViivYJx7HFCzAi+pzVKv9mbpm9BbzCW8c3SIyc6GbOku3qqZbmHxXCSPe7nEpFpZdZnqFvt9JNIsrc5vihp5F8fdxlZrGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fpc6U4l285rYBHqHxpwVcpzA62J4jtZKk2hmFaQ9nX91LNbItWVW31gvHrbLle7zsd4DGZXt9JJ5bHuYqiqyEA1dnNB4ZpvuhWQwRWGf5IzwIouI2GQflo8D9NqU/AjVGa24Jn1MAi+GocNEhbD1r+9b6HiYBsK8WNCkJgbiTkFmd/o3E+rQhFVLuOFwgozN4upiLvgzveWGVyYrgBOZz6thRg23z2OHyFRRH1+k+DfdsUUWTR1XCAiDtSkWsHX6CMT8izcKQN37YyopC81WFjRDhAdADtXm1Yu2+ROO4rEgvNa5HqwV/LpCoJRhsbcDGZsqyJHt5GZkMSv2/Bslzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zFmUCeHlF3aZGCI37ZgyeXhBPTPJNLXqXTUIUMzi4ucQPOPgmIUhXXK4C5TbruXdlUVzAxzGtVnU1DFBTSuw+N3oorYdCmBYMq5lJB0TtEu0KJLnaUTkK3ytR2p/padSuL1PNXsZ5ib3UBWRDWUSSqdJy+yeszNb5It2hyROlfk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7594.namprd04.prod.outlook.com
 (2603:10b6:806:136::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 13:00:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 13:00:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH 2/5] btrfs: btrfs_extent_readonly() change return type to
 bool
Thread-Topic: [PATCH 2/5] btrfs: btrfs_extent_readonly() change return type to
 bool
Thread-Index: AQHXADamGRoe4GzrWEuRqzRATINqvQ==
Date:   Thu, 11 Feb 2021 13:00:41 +0000
Message-ID: <SN4PR0401MB359836112ACCEDA83B5960619B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
 <3c0e3bc3fa0577bded592b37d281e8fd27a8f779.1613019838.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 654fd400-fdaf-40e9-16f9-08d8ce8d091c
x-ms-traffictypediagnostic: SA2PR04MB7594:
x-microsoft-antispam-prvs: <SA2PR04MB7594171544A822470BFB96509B8C9@SA2PR04MB7594.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/l6zEnyJFRyANp68JVcKSYc9HhIKc49saZRGMPcXa9gBJdl8EODw7a1Mwl9xuG9SN6T+yLfOC+gZ6CQweW02EMx10EQspKF/LonsxKXe6UvmSHDL8docZ4r7S/++ACaRsPWwk9BqdWv9D7KsGsoaSLEdwhN65Q7Aa/PwA7F7ilP90NVLBfHmS42ETl49Bp+1gcdkFjD7bZI4MpqS4OIfdw5N1Qref7THex9OYw4nec4nD8qSld545VUCmMUqCTWvj1rduKkl0O33dlBZHbVYRG0xTNKvUEsc65nJ/2H6Z+FGHa1uVqb4vnmLfhZ01N/er8Iye2qfJjmEGm21W+UpgmcDXZoQV1T1g0bZVAIgvbCXG4LorCk9CZJfizJ/u7MPwOu0Jag99TSCjY3w8d+81dA273dpZ3EvwBJ2b45dbYNX33DUs7wfbEG0yTA+4j4X3khVfSczohAiQyGH57nOcv+EFtdnYVJcr324Azf6JTMLA2HHpiUQ1+tzDNjEKOuNFXeUWUBuJ6BtNNz1kqk/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(4326008)(71200400001)(4270600006)(66556008)(91956017)(8936002)(7696005)(33656002)(2906002)(76116006)(66946007)(5660300002)(86362001)(64756008)(66476007)(66446008)(52536014)(8676002)(110136005)(55016002)(9686003)(478600001)(19618925003)(6506007)(558084003)(186003)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ysdYYmGeED9oy64eOoj9JxoPgyrhidJ5mzUvLSie1Vw8xLTfX9USXyFcPltk?=
 =?us-ascii?Q?uxkCxoDeUCZcSyPKHVnIeb5JXfJ/guYVc9p3Kf0yulMIULr7V7X2ztj/OuhX?=
 =?us-ascii?Q?+GiNfdlHaFwGO2sobbq6aejvwWJXYSEdb3nVNe5z103tCsRT8bXhit/VonLs?=
 =?us-ascii?Q?wV9naaLHxlEfbYSetpW2QG52e1UJJQqE1MiJQKeVzpuofWR/1BfWbxm8k37r?=
 =?us-ascii?Q?6EVydwp857BJHnMZZ0ZfWD/YkrN4XwSXdYQbSXyWIWW1LBQXIzYvKvclzQYY?=
 =?us-ascii?Q?IZZREm+jREmX4ZfdpbGHj5w/0oI42bc1XznjUJwjPrhyKbScBPU11ll/DTBs?=
 =?us-ascii?Q?DBDql62m9Yf1yyA0is6LU6YYlI4rilPBED3NtSMpcoWN1NgB12NT4tiEhMZk?=
 =?us-ascii?Q?25A1oxkZGu8oqpigh0NXP8i0BTjdUHtyXq6pbo6zYXtZJt9ngnaGlOJ9pMJD?=
 =?us-ascii?Q?1H3T9KeL1Ivm/tf9OJxAZdHfPP5K1FPOBwKxy0x3R+psn6BnnOX2ZDfX3HEn?=
 =?us-ascii?Q?Od4+GjvghMfpqrmhuZOEF+ouAwg6770FKvKF0j542ssyPhSVvjlvqRGkJXS6?=
 =?us-ascii?Q?bh7XYEi8823tHFBtHxZMtFU0Jmx12Ap9VO+CPA005xT02ORBVYXferX73IqE?=
 =?us-ascii?Q?kwntmFDRjMrZdMuG5cH/6rghVSvq8eSK7ze9Qxi4WoYMeRKp5LN9riEs277r?=
 =?us-ascii?Q?7IEoSX6WQF94sOHu1VDPqmQuiyuuIMLkGLlMiUEpDf7635Rh+IQYvozksREE?=
 =?us-ascii?Q?f6L4VLuK79enry33iyv78vOXcJfKbNna7Nc4WdE0JjImzRZd2KM3ilFv60Ak?=
 =?us-ascii?Q?5XWVuVRV2L+jIqt+FJ2AwCf0e4wro+XMtieG+tFiKsyIJ9t3H/4YMzf4qkkt?=
 =?us-ascii?Q?+xsYeyGZa7Y9Uy63Awisr/qR5sVLQzJ7mnxw24AMDl76FMjIigJZ7sQ2NljP?=
 =?us-ascii?Q?Ol+ohf4MWzhCeSV9W0+k/MX7qqaEobC4C/X4P7gWqTBeoe38jBHWonhOu6g6?=
 =?us-ascii?Q?5BihbiQ2tndxrBj1uDOkb54lHYfPjzPFho1/uuLtwsuZnnIAiLBbcyR1mcoC?=
 =?us-ascii?Q?/NBW71xkkazLfaW/s4xXKNpxgm9m7iMZTyPAGcbyP8HjYc3h6TQ1+M0A3LhA?=
 =?us-ascii?Q?N8BIAi+C5c+HKQuMgqzv9B/1xTZh38Pj0cQJ3BffmFJKKQh2dRgmiCdJZMsk?=
 =?us-ascii?Q?ULy4fLSiBbl94AzEEfOyWR5gdUMsexn7VvaSES8DFNsCz01SsufSUBDdt3Hh?=
 =?us-ascii?Q?nG2A0geILpGMlkTafBLCxTjtGmFUIJroltw0egJxddC+UBVlj7Ak/b0IGGPX?=
 =?us-ascii?Q?62xuppygdVqH3T1GHBetG8o0D5341FGWI85bNEcSf6dOzw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654fd400-fdaf-40e9-16f9-08d8ce8d091c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:00:41.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsyXpTjK+viG/ZJXgWvmYvXkZRWh6QU2RXf4mF4SKWQU7zdnObOJXMQJUvwtzNlLTwc21sEKbprHPCkr0sF2vwazX1IHpbj5cT+Kt9bxVFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7594
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
