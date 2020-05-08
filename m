Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9061CB0EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgEHNsM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:48:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43006 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEHNsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588945692; x=1620481692;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3admdsj3W1Fb3r+cs5SsgGsZDI/A0kgnjvG1mKh/N0s=;
  b=M8C6h7P+WNxofUPRdQnx3Ea3pAIPunYD58iINi81G05LhGYxkFmCBgUZ
   P7PQGYGu68iyzQ7M4jw73bCgTy6uicqfip5ImqxTBruIF+QcZ3U1pqm2W
   PbtRB77QLrEKtNEJeMDDUDQA0MdWCAoQJErrN7ADH+KjML8MLiAVECCdf
   ZO/zo2YPj40bW2jp/7E/gciejV94wKNPFhfz1X5uLaq17UgidsEm/eHX6
   TSjwJ2I+L2vnYKs1va1RU9Si+Vtl2B86pA6apBWkU8PGAitrXbBaG4WxJ
   lO9V9gmIbPloWyxBookFaG6Gl/y7adWXcO27SPl3XqFvfg2+qwIFA0ZDn
   g==;
IronPort-SDR: 82I9BTMIOcFKO7ecrhxgK2kgd23NVz97vnlq5MQL3gMrHrcFV1zTulKTo+t+7NAY/B/mgRSE5G
 df26kqfvppZUkYc11dL9rBhyn/SVlefe1zmRglySriQjWLbaBFCBW4miM8IiSGaBVqOcL7Gfka
 dcSJL2ZhHirWaQp2e5c/VDTyrl3uGfqSwiGdDHk35j1L7tlDHiU4xRT08kO/H+DMo3/qRWAcyO
 fT9ABv9AI5ebxbeAGjEuy55qavAFTKFzGJwMmh4i9UBgYs3OjCX2uT9n81zeDwxaZ61o2Rhxko
 ERM=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138659016"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:48:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI95pc5o763jzbeaGh4oZRkv5N4N54sAWEi+z+CkEKF4K4pfyqtf/6JFIbmnQ+elrjgNghib/p9l31dkEhSNWGHvN/YAp/HXQyhCFUGHVqqRHoTZdsONqPq/EDuRfowCYcZ4KtmFIbxsRy/23x5Wyg6NtxSi3xHNoTePEKUM8yncgKkDgUb+jx1mjqk5X+Y//3ZhH2AB837Yp2TfXfUwY/qJ/bIBdGF2Sg1VMNCXhkXCfjDQUR8K4sVGLrfqCN/BQlVX1LMhzapNKn9lQwQ1V3qPFCVRae0tJ+1fvZAOCK7xYg2YhAi1hm7DYdyrjTQAI4Ga5h9QIb3ntM4a6iyVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv+mJ0AkvbQhrVhLZyRvihgZ4rjiI4qhnOqi5ltlVDY=;
 b=CPTR+PPPAIAUmarsLtJsHgYYyqCXhtHNkRy+/7uiA+O1zvcKHqql8nh11Qp2Y8FFF7FAm2W17Z1uN8+AUpo+cEZJ4j1qVO1xtMjYdJGxZLwBVuQ5H851fw4z3pDyE4sV1h7bhQOyojPczukcm+/3y5n5JrFztuisPQ5pCfBzpfsow15TXsXHkKtteALIqMSXvVh9xrzHGjn+ERLulv+s3iWyvwnoxKG/PzSQNy9T5SoREg15V9Y9iyVX2Fltc0ue+g/FlHfPCY8Chrepc5jIdWtCGB++siJeD9q17CSOhiYVQuYWn1aN+bLSKOqgBEboXOSP5J8nyWh0TTE6PeVUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv+mJ0AkvbQhrVhLZyRvihgZ4rjiI4qhnOqi5ltlVDY=;
 b=gZ3LrDqytyS5cDkCC4IxGknia07MN0Qh4ds/qX/Hk/VGfUe4jn2xycvuj9SMfB3AWaNXP40q5neKtGLsbnbLcBS9Ut7nGonBCCslIoLdxV+j1dC9XYLezHY24uNXy6Rqm0Y73TmmWzYbe5Z0Y8f9g+VmFiYGKtHp4slT7XL6/8Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 8 May
 2020 13:48:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:48:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/19] btrfs: speed up btrfs_set_##bits helpers
Thread-Topic: [PATCH 09/19] btrfs: speed up btrfs_set_##bits helpers
Thread-Index: AQHWJK0MU71MJEpU7EaFUJ4nYpzXNw==
Date:   Fri, 8 May 2020 13:48:09 +0000
Message-ID: <SN4PR0401MB35989A7F087D497AC29C48F49BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <8b8fec84228876473634e41953be055ff1ea3288.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a08e83b4-853d-45f2-071b-08d7f3567193
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677F19A02BF88829813B0609BA20@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHUXvNDe9nISxUvwEULff5zKgl6V/Cm8+Jrd4Y4R5fPKjP67ZyZmxTBCp4PIbGUUMNpEQ2w6vCAEGJFyEYzcxvgHk4FupP+91ZzoB9+5ceJ6r4b39j+xhacH6m9Q2jueGFbzf+x0LZROvRofJlQdWqxmifb0duX8yiMiuHD7LFKYLc23IbhSmZJniJteEKiFswr29tF6v4wsgQN5cq7GBAHzZJxMGQh25IJu0Uq6cebK801GM3rQvRLpHQAar908qMWHzbTdRms+1oerGMto/skGqGP6OfJRZ6LveUVIsIKG6XrP1f9K2hsnxEs21q9pPhvXyT+QH02TEg6rh0+5JCQJajyaTNFJQlZS42tFeR7WJtzbV9+tEb9jULlX8owy96g142xWCt5/Zr82IJ85BoazMrTWCFbgxYurwLvOc6mjbUA9T0yQDHnl7GuuHvsGaRlXEnUKwiYjCWZcq74TqN3IYiHH5zT/LAB0LhBMDb0T++mSC7lvbafvKRKr1dWu9eWJ4GlAS4OrmV9uyyvO3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(33430700001)(26005)(8676002)(5660300002)(53546011)(6506007)(33656002)(55016002)(9686003)(110136005)(7696005)(86362001)(558084003)(478600001)(52536014)(66946007)(71200400001)(76116006)(91956017)(83290400001)(33440700001)(2906002)(83300400001)(83280400001)(83310400001)(83320400001)(316002)(186003)(66446008)(66556008)(64756008)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ff5qbhz6NKwe0KvrI6bcX9sNjm47Bhih/YD7Gur38MNgEiyL4RYXUYGCUjOc+ueMrxqJreVDmaec77T2URC1KSj8PF0DllPR5tp75SUIUgtMLYBTrH+Znxar5Z5dhwLqBxu4JCFPlWRLoHhUHfWE2nuU4yHGF7gnBaaPq6GtM6p7z5tCEpQuVMZ+7ueB351B+B6VEHV0BCVUY1F9mMUvXU9InbgQ68KPxl6mzibdFQmxMpzKUHDdnU8Kfo9UVb8o1BaAdda/OiuhJ/1/0KjY6tUVe+rpnxWQ0jxFq35K3zO2NE5lFyj1dLCnNxaBuQ+mHXLdZoi4Yt/so++kPfpzz8ANZY+W/EFb0jH3NBINkJHhEWaxRlw2/v8OQh6fAwO+OP57U0G7i5bJF01iLwX6z3wAT7b+o6mmseHDlhMYTPQIlHXatr9hKzw1wvl7A3A1Ka5vUFhFHaxTVRT5aw3ptDG7ts6u6QEhFBAiba1Ng+KTssxcWpvvHuyn4HP0vfoq
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e83b4-853d-45f2-071b-08d7f3567193
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:48:09.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02IBAyRnw7VijYRzrGwGS95IZbwUVbIPBUcKEu9U5wlcK+NKyZW9opQUQte9Lb77ZqGD04PHU7sVJDCjFAcNwW8lTBIatgwHZznqRGGFl54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/05/2020 22:21, David Sterba wrote:=0A=
> This is all wasteful. We know the number of bytes to read, 1/2/4/8 and=0A=
                                                 write? ~^=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
