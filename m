Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554B120D0CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgF2SgG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 14:36:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31221 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgF2SgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593455764; x=1624991764;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=K8JvCHJyU4dVhC5LCfq/SDCMmnYWCJh/trw+LJeFSAY=;
  b=G/85olWYmyAjoyvMwwgGUNV5ztHc/WehEJctksyztYr27DewjUU4USl3
   TwaTzIY+KOTQMlMy6/Lb9zORM8/rc/ySs42Sp3vPhxDu2CyoW9X/ZsVlw
   8yyiLAnYKipEnDskv3X0yUCx2EGn5bc4mVsKNzzUtX2L2UTOGo4GuGgoF
   84vmbZ6zaKQwNsy5M5LGIHylhkiELaZC2eIyNnNcyIdcD/kdcwqhyml5V
   lnywABUj+mPEwDUZA+d2BtqEDVLNnseZAxn+C65XfaqUvJg+2nTKfSXvg
   ovxORubuMVA8T4hmy+wrKEBp4X7XQZhQt+A0XcVELxbkSMdJviAhuutNk
   w==;
IronPort-SDR: y1mJozHwQGZ5Jped3hwf//P8Cl3KmVGZMPNtU4srnYGMECs6/X/Jx+JRUp0YaQJkg5E47m9RK9
 ZYpc7VUMrNH8iEtXAIrDpuLDcyEPn1f1hDK1QIn84n/hmaSimfg0OBcZl+qZEZnpZQeY0/48Co
 G434vmy4anFWoCvWM0Mo9rpGhrs3CLgXowiFOrsMbZNQtoRDEraB/oL3ACp70ydgbNdz1DnQwJ
 EXHg3NKicJVUf9MrNom5hnt0Ins7AZZSaDBvtaYBXWTJomUV3h4+7evzR2/8BYrQpoB5URJEf1
 RwY=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="250390737"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 15:13:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/PC8IBkjqkBGb7FSAi2M/8R/vMEHeoONnu6O5xo/Ridn9HRdHeE83nDKU45329AehB6nTDwxpf0JK5ipAZ0N6iJpSkRWlCudwDonSpjS42csTCYMbxbhfHlwMwB5geSjO6YtrctLp+QzMlVsXaTVy8Ej2HfQXZaYhrbieRbi5WfVLRmsMLRSYDv607GvAZBybhNobMm8sp/Bdo8TR9gR0z/Wat7pRynH9YL4l4olDKJlbBGn/Nvo4hG5pXj5dgVUjZYPAPxAs/M2lCSnAwTRJt2qxa2p/7kSVBcXmDKxITQydiBHsAK0GAnBkGfuwhdqTMIrIBQYQVJ1nAmhhu8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrikHC7mkeGq+FvBNAzyRzHaqiVX+uikghwdsmSokhw=;
 b=WXYCBjzp4v3fzdDAKSVoTKX9r9uBGQfE82WASNJBC1wnmsdVDAwZd7liG6C7LQGpKvVQDWouhki35cbT4owkTGDjHndgeJnlPvvpcfZiHIMvbgMYYU9LPSilkSSih50HqIwJ2tEZUK1fjmYg+qxCUjCiVwsGJ1N7Xi1gaMODsItdOy1O1Cn/3DcYlcj5BR9d+yK74rO9N0qNNdGsVnlnO54WPjJI2uu/TEoIaPP+P2D1XXiQyWvE92ep0TrYGykvIvd+gWJwpZKEqkt1XuljrSuSJi327c8xai0wzt2ttWNeksz3g0W/xSLqHYUbjfyDLLSGAJLKg3Q8z4l+SVzXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrikHC7mkeGq+FvBNAzyRzHaqiVX+uikghwdsmSokhw=;
 b=gjhIoqLnfp/07kau5RVZtSSjKspA7FDnCeYvgycokMBvzbewzDfqFvunQm7KJkPJRCxkdu5cQWT14VnhPs/b8imqj3xCQdANKeBzSSdKN+DD3o7kfgqT7a6BsDqvcpJSCLXDXFg8yVmhUXm9ew2cJDWWpn+RSeJz4J3/kDCNe9A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4783.namprd04.prod.outlook.com
 (2603:10b6:805:a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 07:13:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:13:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Topic: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Thread-Index: AQHWTQumtHw0YuLQiEi8HGKNSWneVw==
Date:   Mon, 29 Jun 2020 07:13:45 +0000
Message-ID: <SN4PR0401MB359839A2E5EA48ED5D0B2E2B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200628051839.63142-1-wqu@suse.com>
 <20200628051839.63142-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:5d2:80d1:159b:260e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f749aa59-314d-4ad3-b5f7-08d81bfbf650
x-ms-traffictypediagnostic: SN6PR04MB4783:
x-microsoft-antispam-prvs: <SN6PR04MB47836A0E720037B59271B0489B6E0@SN6PR04MB4783.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGVzJr7EYlM2kE7kbi510a9dJzcqrt+UGaLfZw1iE+2m6JFM+4zAZvuLy0QlFs7yB7sH4M09k9LumRUAluoskuXYaM0sNHupmI/GzMmooyb48zP0IwK8s5XcerDq0vsOlS5pbfPKKB779NMUY2xt1aPipQgfNqrd29Gbqhu4t46Ronvy2xac37iStFYOQnaOqG2mYdMma1dQrNZcvGTcp64+veUpVpfftj7ZTY4IOLJwJyUJ8ARHU6T5/thtsLEmsQjoyMrBHyHBenHy9aRr14Q4MM1sceKULNUKVcIaBGVE0SAoQu1EzCxkOf6nvOLbz8NI6qUoLi9tp4LUVArVQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(5660300002)(8676002)(186003)(86362001)(8936002)(2906002)(55016002)(83380400001)(52536014)(9686003)(316002)(110136005)(6506007)(53546011)(7696005)(558084003)(33656002)(71200400001)(478600001)(91956017)(64756008)(66446008)(66946007)(76116006)(66556008)(66476007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SJPIBwh3SpqMYOfLz5hMPpzE73C+nH2kkBN/HaNIvLqoiIAiVlAYx8SPF4i9SSOsBmsHA0w+3QQHTHqVgEY3xpFbNFxf2R8QNm/sfPQ5zLZjht//4FDFxJZG/7CjcXgXyS2YeFqb0wyReXn2LcEK6ih7LDFDfw5OsUHjSJzde5qWOstNG4hMLTvicsZtKR1dk1I5ZrNzNqTe5YdRfVt0mlq7tAW00uiD15pX9os7WPsm5aIR8MJpN0ooNPMO5/SbMK6lATa58OqNiMjLZMBAwdtEwydx60hJpAFgEGZ0/TBeOogM8/1PuQI+uFou4DvR2TTUCV9nTQMkL8oArQ+wKOyFWOXnSJZe5z7q+chRLzQ1B5/LgaNuZioTO8I6Yl0gZrr5r0azTJXUDdbiocVsCahccOqK0rDkqcQb2UNHMS1t0ZqUDAQ5BGWBxOkDYEdajW0hwKpGINJjPT3GveKAQTk6DejB5EcLGddj6Rl7sDkycKzcXvi2W/n6FE36mPZQ74jgT+2rWW7BZiWxvSOYejNcmwHYnzyk4Lps+CoO9BU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f749aa59-314d-4ad3-b5f7-08d81bfbf650
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 07:13:45.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLkd+k7GV90BOalL/P1A6MlsOb1wIaQnRhAZaiU0N2h6Q1BRp0fgY0d5jdHwT7o0DFbCvLRMYqXSf4xtadJI0cDvbWM1/vaF8oeEP95I7CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4783
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2020 07:19, Qu Wenruo wrote:=0A=
> -		btrfs_drew_write_unlock(&BTRFS_I(inode)->root->snapshot_lock);=0A=
> +		btrfs_check_nocow_unlock(BTRF_I(inode));=0A=
=0A=
Huhz?=0A=
