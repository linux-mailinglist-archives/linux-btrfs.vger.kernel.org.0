Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B69160DF2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgBQJEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 04:04:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51612 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBQJEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 04:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581930260; x=1613466260;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=M2sPWc1wr34r+2B7pW+fbt4FZ4emntNeHLf0aS0PJmrdi5KPS0glSDcE
   WRjhH+wzJibv23/U8y4/o8TVdMf+COZz7lVWTiAyxbVUuh5PEz5iivIDB
   copAii0nGcxEPaB9Ad+j41jlJqUxO2pNK3ARNFFzFwoOIvddJgiNAIwGv
   gg+2YAdf36k7EZ0e91iNWCvEyj7oSjM8IUx7OayP2/2j834aOt6dP7J8I
   sTYwLJm1+b/d36kQ9Zjjr3uoqqKsHyurpKkrm49/RRhEpti5wGQuAqqKf
   E2aZM6WF5GzMi4UkNpE75VadhTUXeO7+PUXOY+FP86bVCgwp4qF8BWeQz
   g==;
IronPort-SDR: Jm3EpMqlNwOOpelJo4jk1hmgOcRgK+iQ7pufftmOTn1FCK3SqrbyGANDYMKSO4WJaYpLq8OscX
 nyVISRzqYASO+NltNAZT/AEmO3xuCYo/d0JmBqtMQMAtgthQep1ALY+CjnLjBjUQIZQ08hLxzj
 htBUjrtj8OYVsyIRkfmZa32zZgre5mXtsJPVqljTkVQNthHNJOzwPn4L1BvcEp/BKT/7ked67K
 X6hKALwJZQyJtAleS0jX1J1y290C0ULLhEs62DGoyVcReoYlim5SIejB+2MRjTccwzTGMBCSpK
 Nyo=
X-IronPort-AV: E=Sophos;i="5.70,451,1574092800"; 
   d="scan'208";a="130530914"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2020 17:04:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq6GcJn/eLJjqVGtr3C1mnnwtG+gjwEGMpy3gf5kMOdG1kOOJcSV9p02DvRDjwnLyi/wqsTOyPgttHYK76W+UkPws5uPfx2V9ViVtPalmuBnJRw5Et/OkWMWgYeEInnhDGKKElyGV9Iz/8ydkbpsZvHmCxYhvMXvtdYB5BZydfeU9GznzSwwLaU/gm97oXLIZ2kM/6O5JddxNGvDeH89IN1124tY++puR1nIZiX7bkZbELb1Zj9T6hUyRqk03S31nlfy1FO9RKM3WTs3qEQpeu+mYdsktuAYRtJthrKUCJjIrVtrG9Wwh24w0/M91wzNFZhKPmx3/cfEII/ezwnq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=E1DeBrTu3hl4xCgCqzPV3fga/Gtlp+VlQpAoQmZGUEySBbzWO5boT3sjNNn4yW3HHINAn/OIzoGknzNiUWlm/ZOj1T+RMgS+TkZqa1yf878DYnrElF6inVkhukexvBRf0iTvj6CRZWghKWcHqAfHICKNGqRLZMjlgU7KA0Q2Arz1aM6jdFHCQoKxxdIZSFY6n9JdNCljHHdKxh6GwL5gAeY0we1Owx2H6ZiTxSZAN393nhwH6JlzeNl36MAOHqWjJ0tDOWZw079tq8Xc6uUeQTxfkpHcZnXd0T3HrABzCPJOz5e8BRMQ2jXMJGdChVRNmH6Tckehogo3zTco+LuLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UEPP5zM9orCcbyVl1Jil8qnxbuUnhz1gdPWMU48dx8Sn3l4IhTi4WjFPfZ0j9q+T2Ebx0acpz9MaB4yk2ecWhgQlC2JnNmicWYoiw90D+uIqGdYLEyGWiPov8/bpJOmMib4AimCYay+jT2Ma49FF54VCK6irbxy4tvRHLaf6aXE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3646.namprd04.prod.outlook.com (10.167.141.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 09:04:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 09:04:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] btrfs: relocation: Check cancel request after each
 extent found
Thread-Topic: [PATCH v3 3/3] btrfs: relocation: Check cancel request after
 each extent found
Thread-Index: AQHV5VnjS93qDsN490GhICHa7B01WA==
Date:   Mon, 17 Feb 2020 09:04:18 +0000
Message-ID: <SN4PR0401MB3598CE7ADD5D4B66E94CF4AC9B160@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200217061654.65567-1-wqu@suse.com>
 <20200217061654.65567-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7153fc7-5476-402d-84d7-08d7b3885f37
x-ms-traffictypediagnostic: SN4PR0401MB3646:
x-microsoft-antispam-prvs: <SN4PR0401MB3646CE4AC89206BCE79DB0699B160@SN4PR0401MB3646.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(64756008)(66556008)(66476007)(52536014)(316002)(186003)(86362001)(66446008)(19618925003)(2906002)(66946007)(4270600006)(33656002)(558084003)(81156014)(55016002)(5660300002)(8676002)(478600001)(6506007)(81166006)(91956017)(76116006)(71200400001)(7696005)(9686003)(26005)(8936002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3646;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zHuE+s0QT3lJas41ZlSFVuJDC08DqKBgbwaOrqqwTWS5YUr/aZkrM4pLqZg8XM11zOhLoEJVD1G58K4zcOyVKs/x9ahrpIYyFSuQiEvKxGwOPaUcUzhS+mBMvHF2DRLKPknBzua1qPJLUWUCQjbLTWPfCnUOvkaM5XgD+CD6ChOIWIM2f554YP0iF3g1x8hVxr8XPSQoy0/YlHC5yA04y2JpYRaoH3dSpcbBu9rt5ga8/IPvrX4obZ+9DNMWBoqtRwsPe2a1OSLK0jtTHRruKmO+24Ylsnfv+GQCOtKCV3VfFJv4/MfM5rGjuR+HLvAYpK3fVzjLlAN8PpsWDpgMo67x/PJIdU0vT2NJ0z2bF4knzd3kXI9N3jCNqZ+NZgWonHX5VIrJEqoO55qi6qaTKP48tC5DM1nz23CH8T0xNYw0Qo13UwBlbsL6K0lwndW
x-ms-exchange-antispam-messagedata: NJV6BkrJJPYcY3kobD7WTvCt6x9Wl1v3TwoZqUT6ciuMp+J5HZt9Q7Sfh+L+5RG3jo8a3nVvDfyICOak9thhrzNGegpZ0+YrzAym+6+DpBnaNzcD1/2kkzdiHun6i0TIxvgGl9kDOmxaTe/Lbec0Iw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7153fc7-5476-402d-84d7-08d7b3885f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 09:04:18.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IV0LSFqqDOlXzSyXCzxvle1Ot0XCB5srRtkEJeGqlQev/PlAmPuFi3kV9pTjLDh1EiXA7N/KjJSUOTgu5eQQOTipHqV9KYlKBDElcT7Fp7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3646
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
