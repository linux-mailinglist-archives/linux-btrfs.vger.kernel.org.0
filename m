Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23FC151EE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDREn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 12:04:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3300 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbgBDREm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 12:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580835883; x=1612371883;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mLM9waQRVpP/xyVzNu6xHz9lFOmgHQWvriGBc8iwhxPptBwELPXvKhaz
   GJA6kQJWM0J1GZhZwWaMOmxyenRbW7Q47STF0nem9Kaou7UBFqtXE85ke
   7ivLUt9vF3aTTW+yotuzZfb3ReqY7uZFAY+PwNHWFyCpZIrLsOvqNNV0W
   hbNgGXPrnhgpLega0kDW90l6m2+2bvT2gJ8Q+S0WRku0B0rfwVyNthK3N
   zw0NKVanclhl7+PB8zusrOvwahvFIwDXaL19t/McNt8zpanBeHFE6NAAS
   uImG2ZvqN66RnpErC99ueQ9jeM8I1SS/juVlfP3BCgaj88q9/2WrYafw+
   Q==;
IronPort-SDR: +rhrY24DVEelQVL/jmxgTRSQmX+w270yryub1o0sMuRA5J9UNVcAyqGPubumrq1BK7Wn8l7v6H
 0h0S2bJ1c4ulBxheu++G8bIeVPjOTxGQV0wdlfN++IBd+fcxpbI/nzawf1TzICOmUHNvLYPD9a
 ucBSknXSDrAtKc476AGa2CETFXy7qoWcTE3H7pxGed8RhGKH5Eta+HyUc3y6Rs40qNOEHqQfH1
 5qOywVWASr1z0FQFS4AQJJoGumHVUKgrzJjXfYMW2gEOnAPE6WiAcc8/lAdXYuMcCmqzAQNnpQ
 kbk=
X-IronPort-AV: E=Sophos;i="5.70,402,1574092800"; 
   d="scan'208";a="133432984"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 01:04:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+xxZNNem7XIl1Ozz5TsdmLTmteq1y63zC5erG3fuJ0uGJvL+5y0+8JQsQKFElTux5m/5hh+0WPOYBFHza+Bb64myh7lrlDzRl05677j+N5J3E7oKl0SfhFB7f3k0xjJRNUs3Qp7WboI2fRIvObeRNyBLg6Lp23LxXavCMI/R5OmB4Fkwg0QAYLadc9zSJuAsf3lAet3JnlAXlNarldzQ7pmGemSELqW7bDil8c+peclD+MCaxPbKKsVFLAXfnjDR6JyAU8FASKewGz8T707E78QZOFS94HD+ymZMJCu77ictAlngDpsZbToPnHqhvdfV8HDN/fw4DmrEhri+MvFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i+CLoaW5TattrG1DfQxk7BkG4EJ4IJ3ZNwIEgQuskepZLmYsRjBsZ9gFBYDPdO9BLbJPPa7SUFUKrqOk2/r/e1tOBoMwtll8sdKuEFFtUcLLKcVorwvBdhqKasm1jyz/DIP004KDSEer/k2aKyLBS+IlXa6dAqmvpaiztScPJAultGfjaE6rieS36FVF0FzvjNt8cMruq7JewBf/u0U5wfwLhbO5LPi9WG6D4j/jIJJ5kseQakFuwRhGB+AmW1wMtfksodpcaWyAueDsqRM/vgiBPJFhG4UAkiZXuF1sa/zMwkTpJjbX5dfBmY/7QQiDaUivIyuLAGYlYSbvNn4Yzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ccaBq66E/is9PDn3ecEQRI1MsE+U2BiA4sr2MEzKIwPv9bxjToDui95k9evtjItadMLxrOr0CyjFwENcAC9VVVApyiME+ZZIzIxAChmXSW0VhqBze6OepHBs0Cu+lSbbOFdco9UC6QzNFhJAms3RzLoQ7HiWZaDneL46iTlrSqc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3567.namprd04.prod.outlook.com (10.167.141.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 17:04:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 17:04:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 15/23] btrfs: use ticketing for data space reservations
Thread-Topic: [PATCH 15/23] btrfs: use ticketing for data space reservations
Thread-Index: AQHV23cCEAIWr9KpVECN4wYON/dgCQ==
Date:   Tue, 4 Feb 2020 17:04:40 +0000
Message-ID: <SN4PR0401MB3598B8434758F8BF9CFEAB049B030@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-16-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd274fbf-7420-4dac-ae08-08d7a99452e1
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB356742EDD19DB0C410ADEBE49B030@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(33656002)(86362001)(186003)(26005)(316002)(110136005)(7696005)(6506007)(19618925003)(5660300002)(81166006)(558084003)(8676002)(478600001)(52536014)(81156014)(66946007)(64756008)(8936002)(66556008)(4270600006)(66446008)(4326008)(66476007)(76116006)(91956017)(2906002)(9686003)(55016002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3567;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bApmCEOZ0kixVJjusT7h/149fkP9EpumsaTwPCNwHDyS0OsNQI94h+GXHUf3HVjlRbG48sad+FkmrAL9Y+N595luBZwS07ti7LMGXQDLEZRBW8zvMAdy8Zf9v+La1SwsXMmhk5FplNdKYVw7w4WvtEfjo96DJ4QASEE/cFSmM2SNngrrNr15ZSFFYov1ptKM1AQVKFKmg7r4DgnmZLx9lb/XjwJqaWe15C+kl+t7SSGv/MZ+YFv8vX75UjdvZTgYFSbpy7OPj1yJfXKxkug11xWnZmnXSIyWa9xYOY3lZyFLHs1MPePOsxZByeebn+BVvlIWJEd97tFjuZoWzahCVn2AeIMD6SsNM6ITgCuruwredcVqILsiAqF3Cfo9TJyVvF0iXEKcjNpiYUKMvvws7t/7AZJiZooYhUQDRnaxAa2qbZHunzxFzGrxa7HhA2nh
x-ms-exchange-antispam-messagedata: /HkvtZkpSu2p2+TAc7RuAx4tCTtNzbtoikJ1r3Qca/XQDTe5Uz/ReyRI0fRh1fFN+DeNzdDs3uOJC/ddr9EQzt+FsSllGXWWP0DIePL3RCod3FX/DNRdc1mzuk9a5iwjwtn0SKx/4nd1H4QWDH9xEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd274fbf-7420-4dac-ae08-08d7a99452e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 17:04:40.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hv8OUgdRp4t2dJGfRxthVXk+Cgkw0wn9G/IJKiM/DnkObniDEKpo02rYW2vuQ8ZgpEDYyN8aSVM0uOxK6LS87Yz/A8l5XYrF7fmf2gcq0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
