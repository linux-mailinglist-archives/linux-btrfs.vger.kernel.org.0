Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF89629EE9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgJ2Onb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:43:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgJ2Ona (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603982610; x=1635518610;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=J6YBMFqvlzngL3kz5XZUXYMdVX5twjaIg1LWxxeDXNM=;
  b=OkEbp2LVAvO173yrWvm5puQRo8B3Mi+M4c2DxfewnheuWScMm8f8GSD3
   hApI2l6y4vxCzlrRVsKAxy+p426lU+koxp8UEVHcWY5GDkqzlfBC8kBOn
   7MISIC1ljuqCIW42FOnDf0DX4zzbtIa0NJok5ekVv+a7Z6+60xRUbzWcU
   +2f6WegsN1dReOmSxLp0oaf/xuN4gce106xf6VzGJvzhhty1/gB4VWrcL
   DAijih5C9t5bomVc23mV4UAmj0kT2lgR24ailzZGD4rMpxWU/Nxw/SIlG
   P17l5BkIMBenAbMcD2jsm+WXommZzbwJkX+hqqyQfrXnYaDH9ku35Gdyg
   g==;
IronPort-SDR: 4vDGR++itTiBwH7iXCStW5rrUQU7TC0XIe8jnWGiV+EJQJnphnLp813SRchWmTX7dorXASNaeh
 1oY02hsHJvuSO2pkfT+s2+Cri+liQHdRYwKLZ+YQMONWPCXB4oD8ds++SQMq4vFjDWHbBrCoy2
 OoUUlou5N8mSA4G4CpxQgbsUl2zRLyyZxOCFFf+9nTMEVULVyKKB9M0fEmP4nE0EMksv0euIXR
 K3pWznMsVUqPS2wrOr8FFaxwASD9yJTqgmV6+tVO17nFfaihIWNMCWOGq1AHcUrnDZBJpOf2Ah
 iyo=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="155679974"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:43:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnXnz1htSK0ButT/dO1Ph+1xEPBcPX1nisXH7wT8YTgGrztV9oBC9WmA9YPOGobWneJhYZhGYO95WoQimsMtwgmPRjTuvBeLj/fZ9skGtF9jAxj17gc5Fr9wGjPe8RrvUlMLXW0vDUDklv4JobGCWkPWYGCxcuWcoPo1ounex/ptpXXjcmU2vJQFneoAERt03RHmOzC0TX5K2A5H1ldIFQN5q1ET2l0m/HrWSqch52HwsRyMUnHP0azYraRF+7WqQTHZTQfQZLAK66tD7PGjf2j0Tm3+Try+ktn4bt+6xsrmoOwogYrm/CNbEKFNXwWkEK7yj4WAgvXXistKSCD2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6YBMFqvlzngL3kz5XZUXYMdVX5twjaIg1LWxxeDXNM=;
 b=IaY+3vU3QcdmYBIqts/D2uBcnpRlhjzJpZglLjioQV770Is5c6ExnhdN8kS0VSIFIUO10mWCc57Vw04LeP4vdzFIWsAU5C822edIcmYr72qf1ssSGTnljJFXlf/ZqOzZwsPyyf+By6rsoTM70kSs38IpUyIUCIdTuraB/zp9pu0B/GkTJ+TR0ujIeMa2WwEexZnRkb2Wct8WZCgcM+YsIizu0ZQmzRjQ2vwcqGnYCrvHMFyGGMFI+PRnSZh4mcqWlqmBImuKMYqDtvR2O2x9ZEBTC6IzY278hDhnny+RnfHC9JNHrJVTJu0XAkQR5OF8wKZDwohH0BINfbVePp2juw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6YBMFqvlzngL3kz5XZUXYMdVX5twjaIg1LWxxeDXNM=;
 b=qr5qeh7DOTiUvjtYRl2fqTPD2UIrATsK5Mcdc+V/JDO4ZeEYepgp5pUQF4HgeJlmmt9LwhwBJ3THBWetCpMHNIEhZDMTieaTp7SHjauJY8NyEba3I1jL9fRUXn8JUbPBXy3sUD8hogxK5s6M7BhRiihgcKuCK/msd7EXjI6Xixo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7162.namprd04.prod.outlook.com
 (2603:10b6:806:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 14:43:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 14:43:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/10] btrfs: remove unnecessary local variables for
 checksum size
Thread-Topic: [PATCH 08/10] btrfs: remove unnecessary local variables for
 checksum size
Thread-Index: AQHWrf/wLo9KiXVH30mm9FeFurF3yQ==
Date:   Thu, 29 Oct 2020 14:43:29 +0000
Message-ID: <SN4PR0401MB35989C0B91085C36FF2669339B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
 <da71002084c80344ea01f56b0554ed9c88dfbe10.1603981453.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1251d1b0-980e-4919-1d34-08d87c190038
x-ms-traffictypediagnostic: SA0PR04MB7162:
x-microsoft-antispam-prvs: <SA0PR04MB7162CD9BE030910551D1C3A29B140@SA0PR04MB7162.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcuCeQglZNzX2dJaOpwkRMhbe/R5uUuU77lK3ehqCeMhO5ywP8hVcgTX59oCs5LKD5SnKmooK7c+5yi8jHGB98GZnnUYqt0T9qFc3qFpQWPk6onWpiW/P3sfrq1ddAYCqWw7uDK2VGwf5Uh3lNla3T8aoSwlKy3yrWTI/aIcCy1hoxKQReOURcPbf3ya2j+fZs8BXAI/XRWO7EEEFVhGKoWqr3+JA68ineWcuIFlVb1md5TAdcGpQL9eRzJWsjGttONEFOwfbQbDD9Wi4n43M/CMumSPZ23LKM75G5ahxxtQwZtQo7yjJGHLbHiJIW785LceogPFEiXByNxWHm+EJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8936002)(6506007)(91956017)(66556008)(66446008)(33656002)(66946007)(52536014)(66476007)(110136005)(76116006)(64756008)(7696005)(558084003)(5660300002)(86362001)(8676002)(186003)(71200400001)(53546011)(316002)(26005)(9686003)(55016002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WWFMCGy5dXw8o5wFS3tdCPZG+b5foOjmmWbRArhDqd537zmUB2zl0xS1mKS0LebViqUTE6lSmkcH5KqX3kKHP10evqriZk4eg9JwVcRHY8E24AubvAa6DvGxxPePDPM5+CB9/pEMMsiLswLG9abMLs6MWOQnjgbdLspnjt1g294JzYSolWRC1ndyaCf9+X8pbugO8p+rWvg/NookagzPL7eFvEKnm0IvlioN0UhEIczVnKNnZOmDoO5LAM91YTaUOKteOZq83QFl4Qj5QQssuHei8SGC04dydvbc+5PZsUv9ZHsDw7Mm7HKFHoen/Zy/KnPyRCYcJYM6dor+mgDzIAKJyLqvV4oxlBV9loZJTxnBztEM4sB9od93Bt/5gjugNAzjQ6EzhZ9e61CuRBLqtPTAhWduXR2WWWgWNHC5BZWufNGqhO0uc/FcxxTQZCZNTnfwqQUBkeC/mrjZL3mb5ZlUoZBt6TH0FNP5l0njGFELEoSVFNj69b7c9KwXagxQNjOn9oUODF3OkTe0ZNWbwl/sQnwR56f1pm6b3Be3IM1hDq/1U2ARaqR/921PYPlp3fXDyygZ6UNCPbh7/NpXVdUNU06AtF27RqHA8IuP2p+eYCTbGuJPz7g3TRo14dI3HfhsPgKUYGdSb1NBmyrlTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1251d1b0-980e-4919-1d34-08d87c190038
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 14:43:29.0760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaZ9cwgrq8Njji+1gN9nq2YAj1Jva8cJlYkROCskN2Oc+8EEFw+Hn6r2883CUhx86nQaZKeVcoCBdBoVUvNO9V5oKn/jBncHkv692KBiDBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7162
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2020 15:29, David Sterba wrote:=0A=
> Remove local variable that is then used just once and replace it with=0A=
> fs_info::csum_tree.=0A=
> =0A=
=0A=
s/csum_tree/csum_size/=0A=
