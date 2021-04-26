Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61F436ACE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 09:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDZH0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:26:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26458 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhDZH0g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619421955; x=1650957955;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JNSxVkhG36i9yN6b3dGipVmhwYYp1H8S914Kp8v/MuY=;
  b=lDgarc2ZasSiiXdPdq+0Upoy7pVW2n/d+rNQGHpMJne2piienjloLYzc
   StnRa8enjG+ahGnBF2/yA5VEFHwxPVYvZobnnusj+6c9v5leUdaA8Uxqs
   kNBvVGRh6x02fgi7xNXQRduF7d+Vo8PQcYbO/m55HBPh+no1vS/5LVrQX
   ujQ7KnfWY9soHZT38n61E27Nlod3AYVNejAXP49znnC06Gta3U+0BoKIO
   Q+f6ezC8M6VjY6K/aXqg9pPUvMydCMUq7YTadpx2QQca5M0N2KO9MkIxK
   jtyow6UOWX8hhFtpbpx2tuQX7m8bszlplFvUz9TtW8/k5Ep7O6hXpyW+r
   Q==;
IronPort-SDR: yoM7y6sV3m4BGex4fzGbCjSeAjrOZm+VOZJglzaAEWNtqBSHoAz4dSYd0s5RKCTcJ9+BC9QC55
 uQMmY9bvM//XSvfIzX40FMjQ3OvjtK2gYsJ8qciG1VeMgmMW5jhIBSIEcr1BlJG+5AR/iersR2
 rd4xugVmDCoFgF5C3ugtXcEsOfPVDIs0DMt6sxPmmqvjJeKwpytKggPy/7ZH3ZSsoFyd5qqT/u
 i/WhMZYK9nQA+pNdjnPCisY6SsmEniYX1yLHrMiZiT/lqpaEXq2wnu42aoPJKGlBzvAk0kxLHf
 Bt8=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="277247890"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:25:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RElv0gTUoqRFMPgAwnUx9e2brS4K0z7L6yYHrb6wdyJd+x6jYc8FykFlDjcJCKQ9FsIU7XWqOQDK4k2mb8o13lTWPXChs1QH4F445ynGnXmvpfVTrXbTpdSIJNIdsaCQjjRf5Co0sBx/JWpuiGZg+bIK2f/kGjT57ovPoOu/8XL2gf/bhjXMaQvFySCY7qYJj/w1cGDo+p9VZHX5b6ljyYQNFrchAM0w/2d8NDK1UuXJ70BmXJXX+ukcHlOvPbPPGED7XAsUMmze2qoAYHnPPByieSIltDnWNhSsq0VewoNSDaHE6IkwnqrvSShlvIUBrmdPhmkIrIYoCMkxIkqFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhGtSTM/CNVzzwYSGqhWA319OKnnpZy2qpdzclQxziQ=;
 b=mNV1AT0Uot1eXFup0OQ+HAamKfDekihDTwKBn3pvWfc3BiEKXw7JKqP5+xlVBAfWCxnQvygmryJ7K51a4REz3M2/SRCXbVt0KuohlOW/z7R+Qd8yhlXm+5kCbD8xg4AnS/naTM4d8SYjNkMQV3ApsvnsN+kZKXcQhE0pMEaC43tYz6hWZG9cot3/++B40SYu4p5NE94GqwdBp+CQPtJoKLY/5Lddzo37+rTKrUjnsioT04QIHP0c/MzHIzlso43c8OVKTRolr9hchGL5ETXjqFQ2tDAkLZRkRydqYSFlHPjG5a+mZuEVTW7foZBEP7UL94HespLCNDhkIUdt0MSs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhGtSTM/CNVzzwYSGqhWA319OKnnpZy2qpdzclQxziQ=;
 b=eg4c8S2RWHnqfZ6Ar8SNztsashbF4YWIIlgCwtSHXRYWlNTqUhGNk00QlHj+0SWCA9lAQ8PPG1zXxWTVHv7nFiU39Dw3IyyNxMCl+Jdkyt+AwKoHA7D8LzqG+7VaATJNxw3gNc08NTF14qg5zpZAVt2ZFzLpsd6QQWtizK7u+fQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7368.namprd04.prod.outlook.com (2603:10b6:510:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 07:25:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:25:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 02/26] btrfs-progs: provide fs_info from btrfs_device
Thread-Topic: [PATCH 02/26] btrfs-progs: provide fs_info from btrfs_device
Thread-Index: AQHXOmVn5pgVmriQbkGuveXQyk4dxA==
Date:   Mon, 26 Apr 2021 07:25:53 +0000
Message-ID: <PH0PR04MB74160B091D7E5890C0B9DCFB9B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <6bc8f7eb4dee9cc47219fd0930c892b6683c3b14.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f52417e-a9f3-4916-2c16-08d908848682
x-ms-traffictypediagnostic: PH0PR04MB7368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7368CF211511E02921F9CF5F9B429@PH0PR04MB7368.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VC9Mpoz1FkKOBDu/f0L9GqRBi9CGnaoM0zGLX2bj8PCuuz1LQuDzTda2JO5U97f/5yluCyECg86qfEObtbc7fJLEWoTrDxQ+y7b4UwIBs0nOYnelTK0eDN6PkVD6IILbdZBVFsc1/wmTCUJZQdlxGFVyO6g2/uPR+Bzqq/0/UzmVLSbcsPDAlshKwn1fqVEV9IcpVwedSq/U+IxY4QG+vppEr5UJdmD6AJfPaLwR/LTlNnJLFpbIu9+laV3h73U3PMU8XNjc1UFr6mNVSp3+Hz7CKiolbM5vcRD116kBSP1VKV8dFXIznq3VI5UHFNTObLvo4SMq8mKyHrJlLNgoS6UpNcIJ5ulKyAQ9ojhhUEkcRW+My6sLbwVIMA4m7OS/QMqctECH31OVbAGWpsmM/BRf6HUXXC7eMbx34aNLm7MmFTyPJtOHJzVxxcozWEnRaVyTjrWWZGrZIajdiMUSYLAOKifZZj3OnckPu+7WnppWHS5UJmk97fk4E7ZpJ00VMtcWyZSaSveMoSlYnejE9Dg7nRRcxIH7jop4wnEvvhxKJleJetLpnpLX0MjOvsiGhaSPAlf/LGLInwH3cmNLNl17IJeX/YZBbfOUCH/Nwr4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(122000001)(71200400001)(4744005)(55016002)(7696005)(186003)(38100700002)(8676002)(4326008)(478600001)(26005)(6506007)(9686003)(76116006)(86362001)(53546011)(5660300002)(54906003)(66446008)(64756008)(110136005)(66476007)(66946007)(66556008)(33656002)(2906002)(52536014)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8meVfdaouHEY+NrDWToWfu+D6fkpdI0/arklt2CMwbWAbKUBiV2gYNXkPu/c?=
 =?us-ascii?Q?L9K2LsicjUmWzUxZYSql1FNxLIUwCZbjUD7TEQYC5T806ZP0yM8+8urq7GEX?=
 =?us-ascii?Q?0VXNcKthwj+7AhNKaGlDIKKQ/2cE2s4bjum02Odrdud1fnJGYJOkWwS72YKt?=
 =?us-ascii?Q?R7wZYkDp4JRc1S85lr9TZhy3Hyy/okRLnDLIPo7UkbR6GpZj2Rk0cvZcRaRj?=
 =?us-ascii?Q?u/x3nAtwNTswXf1gGdaEZFpRv0cBtC3o5JdeATj6/tSSlsrgwwfp4bnEfDVZ?=
 =?us-ascii?Q?l2N/ToslGmx0ux5womSQw+bbp/LKPPlf9YrJOTdJeauL3Rlcdnb/TKezSKgK?=
 =?us-ascii?Q?x6ehJmkxzagHozbF4IE1FpjSlz30Uzl70656S7DsybtKlAVPJZvzROpBD9wH?=
 =?us-ascii?Q?XbsGfCplVwkXxuyxdkUj/mtoUQp2lnGlUl5lWj2FgQI78vS9bJ9BxmctmmZq?=
 =?us-ascii?Q?YF4zZfcSMx7Q9T9tI6WM3cRnZO73vV7DDhfO8YKnpSmFxEVvCWqJuLtekVlE?=
 =?us-ascii?Q?eSgVelYUO9o1Gb14wtmCtx5Je+wZyCuDgCjPSXag2KzM3O9HS/oFq2MyYtWk?=
 =?us-ascii?Q?6CKqtT1ZVBC9ezJCD7KJNtJggsNJ1sByCjH9luikE6oZX3J9lfMSO8uKXr0y?=
 =?us-ascii?Q?dqdIS0dTO1Cha587VE+YOMJBMJRE5+RUsKKIjODBE6BiRFjsSOxXMsaYPwzs?=
 =?us-ascii?Q?Kx7az53ek0kNCmXn91drewn16Nmk5TDVT8mG2eXDqMnE8GNsEDFRdwRQWjOn?=
 =?us-ascii?Q?88BODqSkDHekC06KEs720ruIQ2fj1kps1ATlcBWzgRwCC5kz3Wua5BoNnPHT?=
 =?us-ascii?Q?7CmDkTaaaA4T3J5RP28tyKs2UuCRI/6iO7LC2zE+rvej4GL9NiIqodV6pWXr?=
 =?us-ascii?Q?oTfFRl9uI7lCAFqE8/DWR4u03fmnt8xYZYQdmH5etRTvyD4AZLdsUw3mDaMe?=
 =?us-ascii?Q?Ju0tVucuB6eg/VxzXMHfBZlrq1xFTDdTe2yqs5PUwDDJuqMeHJOXThwzDul4?=
 =?us-ascii?Q?A+pKGbD518wSpxTVc4Br/PIgb1imsAhUo4C0m32mU+wrr+sRoSPKncbsG2NN?=
 =?us-ascii?Q?yO8y38ywbzYXU3H0P8mQS8mZqiCGm8Lgk7YIPLxa+xb8cZwY8rGcnlq01CB2?=
 =?us-ascii?Q?yNIkBIjDg0vP6pcggGsdClZA/V0qwU9gD0SJtaf1hZD1GLTuARKlb6dJZCYI?=
 =?us-ascii?Q?31zKxZoFd8YgY7lN7jG9ZKE8f+Kh+/j7AzBYnMQ3ZODOLx8/RsGUwgJFXdCH?=
 =?us-ascii?Q?tZvXvU3lDGh0zZBffkTc2M5kM07cpIrnvxez3VrBEbaTESFDn3UeCifQwKGw?=
 =?us-ascii?Q?9O151cz04CJQ30dcPdrsp7S5UbknbRY/Yu3GHGOaJRuzyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f52417e-a9f3-4916-2c16-08d908848682
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:25:53.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jwLcLb0/uVUou3L+qvWlZzA0+6WtG3EdPmc3DMz0tbF7pymcXqdsQVH4gbFcoIj8mSP2UQ8E5uu6/Q/BcqKd3ZFpwcWt37T5gW5iWgs/CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7368
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/04/2021 08:28, Naohiro Aota wrote:=0A=
> -int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)=
=0A=
> +int btrfs_open_devices(struct btrfs_fs_info *fs_info,=0A=
> +		       struct btrfs_fs_devices *fs_devices, int flags)=0A=
>  {=0A=
>  	int fd;=0A=
>  	struct btrfs_device *device;=0A=
>  	int ret;=0A=
>  =0A=
=0A=
Why not pass only fs_info and then have?=0A=
	struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;=0A=
