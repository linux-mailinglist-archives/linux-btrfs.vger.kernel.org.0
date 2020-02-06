Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 355BC1544E9
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBFNcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:32:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21818 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFNcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580995955; x=1612531955;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hNyuhL2Swi07hLXt/PR7WgLQGFXqE+GLyRb/cHDMQVicvY9tlV46zboQ
   ZDyxYjCutP6OFFI936lVMelmvaKH148aqk/m3W6mtZu8sSvVcaLxQonYt
   sVbRyIPaZPpzs/1sU+DQ0ZN37sAP5jHQn2QPQ8dLcy+zkdcOOtERBm1He
   /AhYgwPR+ThOQqEpXkP0ghBTVLbKBZDu86aFytP6PrC2+KgDGD61q98hh
   RAuF4yXxbwlIGd3rn8T1bnx7YXS61tuhfcBkFW6eYoGz9vR7sVbajB6de
   P7xLitFaDsJatsgYcWn5qrznEVT8a9jsHixHpwz2GrKODWzDqf6yhnf8l
   g==;
IronPort-SDR: nNYElJGNvXy/rx1YAVchOv9oYbDDTLfQL1cPoaD4ElFK7EyqkXMuPcmBufp/MgL77b4NEZrPLb
 UW02o/+a679yeHQalN3tvfoZGzrrup58K5ooVzU/sAs8dVGgFxm7Pi+GmaKvgd2W3OLXUhrblX
 ujNy2MYRHVUp1FWB1vbcwfaef/jyf2JhLnVg/6WLMV7fkkFmIvUONjYmX8+OEHiFCldD+ZiBV2
 Tf6o/T1G6ST99ZL/JikpIYTt0yFhYSG0nHNxGw/6mpEMji2fX8UEQM5/YwrTvez9aLTG7LgdJ3
 4Ak=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129251961"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:32:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsJh6kZh3TDs0EUiIuMJQgwFHxt41cADgoV07+Z94hr176hh/6kh4wT5raHh/5ZMnYdlkBxmquVuop0WlZNJP8uAxxAkSDdpYYY+DRo6VFhB7swJwIQalMgWHSEX2lFZ1rSQ3Wys6wUaLpQ1I3K1TRT6L6A/88k2sPt509SAGZUrJk4io/BxuLAc4cC8tvmOA9ugaO2hbA39KXCuUdYddtkvsffUQQM8NhbQJ3o4KLk0cyw2aLftIZhKY+YOAQei/GT8gpWV2trCKAx5zn0j6uORHD0H3R27V/ufxgnAZcVSO/yEyy7zPMU3M/Dqx9tPxdkW8sOJrYbP0MucaGcvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ml1sLk3mpODHteP4J82K+QLAEcxjjcEY48B3CT4QPkeiwaVHCmBz/FQ3elT0+TwbRsrFSsqxtjBbFYn2pLzppri9Zdko5XvtmAjBpKsOVBL2oj76ru9Ob2i3nk4U+0Hh3rpLOZ1AWtXlJfIwodgP6WVq5PWpd8FEjBIY02oVzON69RVqX1it7lrbGu4hHOtwOJ8hx3BuDONaIIo46EwanamUcAW1CCx3naSwRWjsa6JeSvNjDKcwiGAVGvljyVIQlME00RQKN3xlPMa+JyvVf+dcXAJBqCQOKLsxxELaVByGnqMooxke4WFmBj0c5Q45qts05QQg0n9U86R4cBXIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=G5xNnOAmLS8pfMLdg55qhBFDv1CAdqZuifoQpwPSnimNjEEWjX5HIGkNMyQ3/1qqaBmwy2AXxAOBt4Jou6rgEvD9nCx8RfC9HdJ17Ld28k/pPQGlZcW1tZq/pRnUZfZc7rVTNvoF3aa8uAKAWLHJ8PyvOA+/rBqFXI9pIXqt9Dw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3550.namprd04.prod.outlook.com (10.167.133.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 13:32:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:32:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/8] btrfs: remove extent_page_data::tree
Thread-Topic: [PATCH 1/8] btrfs: remove extent_page_data::tree
Thread-Index: AQHV3E9xTfOD1Kzktkuqwi87GOi6yg==
Date:   Thu, 6 Feb 2020 13:32:33 +0000
Message-ID: <SN4PR0401MB3598684249D65C5CE1FEAC719B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <9bca78d5ecd1eec04ebaa6fa760af3817f9345ab.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e0d1df7-5c97-4ca9-0010-08d7ab0905c8
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB3550638101F437BDA04D60359B1D0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(6506007)(26005)(52536014)(5660300002)(55016002)(9686003)(66476007)(66556008)(64756008)(66446008)(558084003)(4270600006)(7696005)(71200400001)(316002)(110136005)(19618925003)(86362001)(81156014)(8676002)(81166006)(91956017)(66946007)(2906002)(76116006)(33656002)(478600001)(8936002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFpiMvBecml6oFb0MkKfxbij7gOedxNHMHXSCv2fqc6j2jSVXeFWehijg+zMhbPVSeUL1FryEmYujwFzxpWwzYDbPeSWFaf0a3+gETz0xiddpHMUwf+tv9rGKQkbDa42NeJxKF+op0wzh9ivFykIyyh0k0lBQn358q4IFOwBxL+yhO/zkPSQDy4P/15Vw339/fyGzoc8kYqHOOK54cgFD01rBRR6KXq08r4PZyEqr1Kgf3vpMCpgmE/eN8jFhuXQFqKcCkH6w7TkblZ0ggfpN9/3NhxazYU7Z8vXFvV488TLIHLb6Z0e4+jY7fvr5Q4bvMLxBLXkG8n9/9tbYN2KoGIr0BHHCWYclFWmYfxTBrQcai4ltvc2SF8MxBf3kbhvQA4zFSawr2E/5qPJpx1Sbxqf/HT4+CEM7uqdtoHw2XaEPIJplSHelC57rA6Kpyoe
x-ms-exchange-antispam-messagedata: ugOzQqGfYj4kVUamUameyjXEWs70Cw+VyIdkDcxmyU8Lz4PQuC7B7j1WYaxWlgB70Z4VZSpNTMehI/P8YTvLDZ+sLjnR+GIxjQC4KCsQWKn1fVAN6PLTnlnLb4w4dAnYdP42NGRQVkR+DNXOzanLlQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d1df7-5c97-4ca9-0010-08d7ab0905c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:32:33.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtUjnfjWiYXadf+hs2ChaHoB18GbK5NJ7yM3WknuRU9KAzpN2i9t9Vi6U7dWfR9CQVA/FTTvbum0EQpd02kD0M0FB/s6hSZM3vet9HHKFMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
