Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA11FCDCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 14:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQMyI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 08:54:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41424 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQMyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 08:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592398449; x=1623934449;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=kQId72l33tZ0NODv0S3zxUXkD9tt5tznKtwzuoejUj3p5kTMSEg2ySLP
   CJhgNIIB+41EN1IYTknqR2q6HLhxbWPl3HgWzYP06VOIYkhNJSD/a6eF9
   IGDPpdRw9TTrgCxQDhaG6jxK38eVxKrpxm/uD0TNOVb8zbRYdEy5XsU5+
   +2E+2gm9PP9pUpcIiwVuXzjsMYm4YTxXJkB7u/2CZ5mKs/OStzjYhpmhw
   sp2wy2WTC0aHya1IV+7GrHGg6HBhe3bvMOAKA71eZwEJhzJcYggq0sTaF
   bLwbgcH7IpUX1LlKXw1oZdm8X5QVCHUdTOczEWiLCZZqc5mQdlo6ybn8Z
   g==;
IronPort-SDR: AHQSorSqRxgNvWq2CS99c4zDVW8uMkIy8UY69Pl6WhQekDSXU9MMe6CJyAmZtEsRt4C5njmFvU
 SONjDcvUuKHuqSlu8G99NpnFHGQ/GgVEshZm8gBYDmfak8hAxurK/0iSDWN75cI5u5IGKWC836
 /qW6Rcbpf019MfjPAe2uOh2YAkrrSijO323Lwfud1ZLrHMWadlFXbhNnBCPKYwqMSNMWsRQEUS
 HFQBJ9OsocUYY1DcxaYbR15nyBhrCrhEjqljbVdWP2mrPhChTUuWXogWgfIHatEiBxAh1+BwZK
 2SE=
X-IronPort-AV: E=Sophos;i="5.73,522,1583164800"; 
   d="scan'208";a="243174496"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 20:54:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ7t9m3Nx2eR3qL5vFtooeS1SUl2JzFTIA0roThFwAs1Ynfxn5BTMNybJLBD2kr1CVy6zq8wvcgkIyrtU9Uxom4i0kWWnkDt+DaUZXzfFlX/0e7RMneEMsJ3wbcLKYpiQW5jon/itI4/mZmxb+Y5iyZE3Y/kq+QW5Eawy0ESfZCYwAaFESWjnDpLIJhEvUMLs/f6LvYGyp2iXsVI2mgpma4W/uEWPyHQSu3jr/3CX7A4D5x74N+cGNMwDd+XyCxSwewsEBeO04LAG8dDD+ASaLjN4EhM2HZF3pmVmIQmSkbRpbQ99CSNMJnB+z5WDVuZwwOqnFed0uX1CA0UPSUt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kmmRjS/FnB9W/SUeqflN9WatDVaOgJTEBS39s6OgLCFUZyKYH1u7Yw7Vei4/UlzEutyL+gbpfUrUPGEcjcq64rNVtFRUOMFKOEeyiPXp4tU5DU8+eeXgTRTJx2jK7SxEY41wJB8IA6fwiPwYnA/8zvfQ+1KiRVp7T7btz/ZqtcIP5pxDwzCHw+jqAbRSNaKDwXCU91kc7++h3DkIbAABikS2FSb3RxAne54PZvvQ46oNrh2lPS/wtelcuJlZBUTpGYAhf6ccMvLgqsWtUNa8h6FS0aJ62ULkzQR03wclwRzJUvl9Lw0umOCp2hPKHm0kyd8OJnEzNO+vEl5CnGeQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=x8CHSg69oxO42n69+Rmt9KF0v3tUKigEeDRZ+IIhKm/QptPienD9eYHEr6/eyCFB/i5WXgOQ4sYQVXJMv5EqyIcSH/Uvfsthoq+s2yoHbiVXJqQu6amo/WQLwc/hmvjjAFVb9qYCLbekwTdocfBbkKFkgiAfCJglu0KRe2iPfVA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3887.namprd04.prod.outlook.com
 (2603:10b6:805:49::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 12:54:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 12:54:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: Perform data management operations outside of
 inode lock
Thread-Topic: [PATCH 2/3] btrfs: Perform data management operations outside of
 inode lock
Thread-Index: AQHWRIgjhZzh3gHb+U6KQnuii916tw==
Date:   Wed, 17 Jun 2020 12:54:05 +0000
Message-ID: <SN4PR0401MB35983A0A9C386417914CB5849B9A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200617091044.27846-1-nborisov@suse.com>
 <20200617091044.27846-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b5e5fc6-c652-4142-47b9-08d812bd84aa
x-ms-traffictypediagnostic: SN6PR04MB3887:
x-microsoft-antispam-prvs: <SN6PR04MB38871BB75D88C3ACF2A853D79B9A0@SN6PR04MB3887.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iKX7oyWJoq/iLUbMqinO91U7cYNVziwm8dzLmCEr2zHEqYOos7pM8D40jgCgqqtmcMSo0bXl4RiUiFZ7d43AlUllc9ONBNmaFpT+zATXkiv2RGV7bLdvBKOXQ+QUTld4MAq4PvlkhlBt5lAmyoEql3wB9ym5AZiJwo/jC433yyCKdQnkvVwW4WvJSb/a/8zG6Tgn14SupeZidTCArp1j7F3XhKy2pZYfBuflL7KrDpSlSKUO+pBvHADrebUWVZWBmuNGiLPEdBu0mwWDjCvqr/Nld6JGMsdzpusJ3+Iur5l3gR8RQF1VpxsWhM3ZLzEhb+8uRQOptWdWurTPnVk0vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(76116006)(64756008)(91956017)(66446008)(66476007)(66556008)(66946007)(110136005)(316002)(478600001)(9686003)(19618925003)(4270600006)(55016002)(6506007)(558084003)(52536014)(86362001)(186003)(8936002)(5660300002)(2906002)(71200400001)(7696005)(26005)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b/GHW3nLtNiNCvLgF6ExwwRTMDtZU+3T3LQfX85yvYUam/myTHGGRi0FB1EcPKR/DuGIof4XIqKRttihIHqQ+gjCZa40ksHpZRwLcFnKiJ1M6SuGpSmFD8/lqjDziHL57n4ViYpc9FkGgV4AjJbf6DyAQBZ8j3tdcIS49GOMqGfN5UJ+fSEycyQAOfBhhQwQIVNSzkW490JCabSzRUUNWHLMJqdkVB2bFmr17bYBCByNCSo9q9NvHX+TfxdLi66AqY031QjD/fEeHM40XAVTv6HZ3Z5AJxv6f8pbvK/BWKOnxSItkzWFfmPXcUf1ntuyv5UceHpV1GEIfUQ/tMJrz+A0eIgBgQ6QO4AVan+vlcIacNfNlg1OKPaDzQxvjoIC889kVTb92tauBkL5BGMzx6DemVfQU5/42jo51/oWnA9mOQuGbTM8ftHJHS0d8FFgdBK3IwgRxfhV5FihIx6PaHWif8DvtFByyQGyOjablb4f6FJJqwvFF876p3uSKVkc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5e5fc6-c652-4142-47b9-08d812bd84aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 12:54:05.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOnjSTEFgeGKOeGdeTaFQRYKraqKXDqk+KZ4dMdJ5ZveiTK6ES+x0eNaPA7ZJTxLihF1+MvJjcpateMvI+j7bCSnAWSu9VGHsZ2XB5ZuHTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3887
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
