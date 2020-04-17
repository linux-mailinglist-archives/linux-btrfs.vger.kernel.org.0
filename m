Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90B1AD93A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgDQI4Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 04:56:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25488 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgDQI4P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 04:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587113775; x=1618649775;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AFLYPpXXcm3BbwTmrtwIa0mpIERiFfG6nZCJGk41whUgTnfyAjdqnUoX
   zuxAE/s0ELhA2cz/ZU4TI9pq9hXQt+tE/14n7MR4rCp+U5OJGHMHyNLy9
   fwMgNXVEVqYEVlkdXyeKU1BdzVygaxQRKXOiPeNhqeJ+2Kaz1gDCDUMNp
   Q5nnlTCZ7O5xf2hW1ulyL6aWAeaBjWx/JVwCcHNcVhtQFwIyEd22iNPPO
   kgw/cozOlpoU1InuTjcZfR6GGVP3aQIxKiJpxYsUgx5BpCmHdrmygXfJA
   UiaOSafk1h16cSInnFNr+1oDba0CKGMsUojvQ91u6SMA3M8RUYKJ3svJt
   w==;
IronPort-SDR: lZdeI6QnVPExTOyikHpeUj84X+QyNJbeBVw6fYZRBtyk90GB5BXw7rqzerxPe+KGHT4Frn0Dky
 gfX4pzHJ8DyleZdO0/r5yLKFu0/21o7qyLwtfowjF/ph0b9K3XffAtO05QKuvhufM/uXwQirTm
 Qxcz9WDVG0jhGaXKNL/TghO74iOnBHnDk85B0n2fPN6p87HTmwe1irZ0akGPm/EP3WVeJc3Qp+
 5RTlGQp0sXDOZ+wqcFoHQc0guDrF4oX+IwXn7t5s9+8H1Dnq2ynRweHQKx7qVY6yE2EGwZ04ed
 jso=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="244222788"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 16:56:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K54GGMguc8kGmzLXcL5MExNCuCf8avXteyCMTWWZL8/gyUPNSKlNwksGdsqihXnigYmWv4E5usyLzQq1LNG7VOA0hQmORVAMv1+OJmlLMyYsx6GR5dkZoKqIaQHfpWQfeM+h86yP123rEQ3XXy9Z3CWT11ELUdrT2fHBaaTJ2Gu2FhoifYWcx/YSIDC+JcMAfU85EXBMsrDnaeeO8X5mUWsM7HstSmomCu87jexrmQtltTMToBVMG82Sx04Y/YrkdMRDFBU0RPb1VGavL549ZlTtaUirqazMAB3d/28DNCCbYTyxdtQb3S4ZKPH+GVRxjRhVSOdDC8j+jhJiPcYBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UDPnZd5gHY3PDqROHtU9Px9M3jlnqnLsk/+VeX6pVR9+IRF/TT0IxJ3OHPXDVIqHJsBUAhybwUhVVqbaUO+bMfyA/eRd99vsEZWTHZhbepUz/TmQ9kEtlKSveimghDws6ZMfapiK4uTZuW4Vz0XzvD7ademWpZuxCvQXk2XC08CuktzVSbaHNpJS4cBrCMUrQaLDGeRqItpiqnGeVPubEd9QXAJktdJMHuQgmX+aTZUeYh8Hc+LbPaSTuc07+esK1OE8vlFpgMMrJdSoeIHZnQ/lPAjdQyxXgkG6OYj4znuPq+uG8kAJr/DGRQnhUGOw5HpJcboHAQs0PgEe6TkIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ksk2Zj/qihmjCbhLdHys6tt7rkNZXSstgpqDJgH6CWXj9tBDeBJhLTH9r8PJV2BiVmgEO5OyxDrHOeclECMxgrsvlSEFp8ZWbTQFJm//aliQoZjIxHXUipqR1Q79w/83JpPbRgCCVzzUItb96SaFGh0+8neDVWqTqTzx5nJlKDU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Fri, 17 Apr
 2020 08:56:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 08:56:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH] btrfs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Thread-Topic: [PATCH] btrfs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Thread-Index: AQHWFIcLo+PZzoqImUOujahsn9x2xA==
Date:   Fri, 17 Apr 2020 08:56:13 +0000
Message-ID: <SN4PR0401MB359803C52646B719376ED8459BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417070821.65806-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc2e7535-6c6e-4cce-d3b2-08d7e2ad2ef6
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB3551F1B69473D54F053CCFD19BD90@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(186003)(5660300002)(558084003)(6506007)(71200400001)(26005)(55016002)(9686003)(52536014)(33656002)(86362001)(7696005)(81156014)(4270600006)(8676002)(2906002)(8936002)(66946007)(76116006)(316002)(66476007)(66556008)(64756008)(66446008)(91956017)(19618925003)(110136005)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1leljsRRSXutWuyQqxWgJdl+grZmC6Xss6fVFBsbZ9y9gEa0lVBUjz9RtCKEC5AclaH3+IkljB/mwh4v8fsiiuS7xSQa3lj9m1sjiIaghtR8frohyR1SvIrMLLSHRodEpsoD8AfCLmPzQZ4ISwHkQP9RR24av1mlT3AINKvxDeoPuCYPDucOuSveRe43N6sjX8FXFXeAOakqxrL2Pp8kJGYO0SVPa3FeQmO99wF3iWpGm8Hhr6gC9mKJCMmTF9DAlm6CqtiodXZWivQ9qUV+VdwVL3/+WzqWGG2CAZjC3M7BQZDCCwIYHOIgWVg3MJpFUcDAXWZQJjaKa1yvUnigDI/gy9MTB0UELPxsoaprpAP0y2M6oorKHIvHVxIUEmVguOzP1H7zP95Lbhz9YTsy3dcK4L71hG+/HllxudId/t77dpEQPZiAwmDt1cE0HQHK
x-ms-exchange-antispam-messagedata: chHoyWfDI16VzvXB0cWsXUXzH4BFMlCxo7jwIHfN/E5uLRsEhJlEwRrWrw5eV11aUKFkg0FoQ+NrcciNoV3ZUCqc3HJ2r/+JUB/7SlbJYjUPeqSYgdYJ4TMQLy/p/vibSuv2ZpDkBncHZ/Vxz5UiQQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2e7535-6c6e-4cce-d3b2-08d7e2ad2ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 08:56:13.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPjk1vbQiUf2kBi8uRHWmAK3efBgBWI9tv1Awe0/pY63Ng5IKRuxCzPeFGYcu6h6m3nfw4VM8ULGpeB/EcPfEui3PplbJA2jUIOEzmj2pPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
