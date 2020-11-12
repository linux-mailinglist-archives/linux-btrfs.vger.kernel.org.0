Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441922B01EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 10:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKLJY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 04:24:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56608 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKLJYZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 04:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605173065; x=1636709065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Y6BtycZ3DYqyJizeUOP3IFYRuxCO/s0E6eex3HM4DkZVIapMrqO+xKq+
   Bf/STsmsHG5bvgWLKCuXZ5gL62nNJoVr6vaMmno/xpmZEUPAfyxKFFm8U
   nmS66D8s6qGclWP+fswIdyRq7ojQUkTKr48AK91/Wm3N5zGA4khtcDPtp
   Us//n/yg2PyiwhyLk3tTjWTyNwSnwr7Iov1d9VLOcF6okiOliIpD4GboF
   qSugwwE+V2GVOcttG7UUYyhaEFqlpCZz8o5LXMoheU/i03zTb/pQsCrz3
   OyRYePyJfaTvJGD6reWh6jFFRQeKCS7lHDyD2LCz/ugLz59mrLRnRH4sj
   w==;
IronPort-SDR: S2L7PTuOejrx3LjYlVb4XUFJRJrN1SXa6ywaEcMluKRw4xseuInzDs7vY7htAEaH4LIZzxGMj+
 LGNzoqtIPTZCO3RZLwZru++xZiQfkrzKvf3v08HmPe3dCUNzGIyC+XYmrcOI8u1Yfw771djqEC
 ZCVBZQAFD4kwA7x5BfkSR35/hurg7glDjxkEr7eaHYFu6uBfJu29N188F1xg+v4PlzexHLhFHU
 ZnRwU9bM+YriVp3+9Ai7tLbjL77xmZWVNXt626G1eu1d7pZWIt3LvV0q/VGo7Boe3t0kIjmAR+
 ot0=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="262482970"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 17:24:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLCprOaiyoRkwTQFEluNvrTHmVYUtmKBcdzLyDvU6HE0F+9j/N6VZ69ZsaZXcn/ZHsaxZsgs/FIPD061pjRQkhpb5bDKjklZkYavcTGlP7cBJI42MrUYqFCdCqSDSiXgzdTvcJgke6k7QEgLvhvgyPUJYIAkQBJGH26+LcCMhbs9SMwjqGrx/P5gBvboxJzhzwAI+xLxto2FkBhAo2p0At5PQwGi+l72dTH2AdKTXiNMFosRu8LhuwuHmxZNlzXrxKcFD4NvUigwLQtL97NP7MYtSpvWL3FTkmvIf0nGEVDTZy2hohRWwjHCG45yRqBmgZSNt9FCGMUk5Y8ce3uAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kNlv6OYa35dI9SdgIs7VTj5FQfcJ3I0B7mz3h+YyJNZv50aAqDi38XhOIucKVqytbJk0w4K5CO5numOxrHgspZK2wSc8ucNeSRM5SuZDnYDtSaXAFmdt8C+qmuRccCrFeMKHzsPsgodZQUPFgTSPoJWAixJzgartRUEIOtcTneiyw1M6GLRnnj8R58IqxcosARH4oGErxp52iPoqE6ZWMcj+p3PxWCeZYgQWyGlwMRiBq2l/cW1p8qwg7xAtI1m+X2uRK+yoNpTrfCVXX3G3NSnd5bV6CgWocEhQV4IbXXGO/qWXmyu96SBSX47vcBr1mp86sJO41maTB0U2LdYLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dV8UmSbrf3YLdyCwP2C3omWBPrLBxn9ZWV/pMaoF6Lt0dcWRjTnjwSw3i/v5pfYT3cwpnETkaN4oJkR5BLmVGUFG0xo7GJ3d2kAZOB9ov8V1QnQ5CzjLCOSlBS7O42jnS0zh9e/Y2gCFy0pzEnAGB7YGBmsA7gTAg+6EpBDtQhY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 12 Nov
 2020 09:24:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:24:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 1/2] btrfs: remove the phy_offset parameter for
 btrfs_validate_metadata_buffer()
Thread-Topic: [PATCH v3 1/2] btrfs: remove the phy_offset parameter for
 btrfs_validate_metadata_buffer()
Thread-Index: AQHWuNCUtHlwo6Ja2UK0Flllbny8lA==
Date:   Thu, 12 Nov 2020 09:24:23 +0000
Message-ID: <SN4PR0401MB3598AD6AEB15582C1965CF3A9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201112084758.73617-1-wqu@suse.com>
 <20201112084758.73617-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:3d02:4ac1:70fb:2ebb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81795287-d220-489d-f201-08d886ecbe3c
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-microsoft-antispam-prvs: <SN6PR04MB3965236671FDA4D4CCDA1CED9BE70@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfajRDh+ArzG3/6PSd5dzLeyAyD3pefbbwC4do89zEXZufDZJBg3yafaTmXAasIkPPBBb2jLd+fHt0BwxtzECh//VY5M1FDudupZhQns4STn7lBx6EYWO0DF/oDnwPYxjyF5+Qh+LT/t/HciSZ9shEE7NUUMdvX5m/8oRVALUWBI61dmcWGcSScCTvhcIzoDhrM0qQTG2MEz9M5W/65IxfT0agVyMPvduaOvd6n/9LMMMg9KWpNqWqY7j8mGCdWwCfiFwi1J2K/DmzyHilu+BdtMR/ALoX5GLQ+E9tHXWfm3Fv57tMERzJK6tBC/QUHz26puwq63De6QOOIt/qqReA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(8676002)(9686003)(316002)(8936002)(33656002)(71200400001)(4270600006)(5660300002)(186003)(76116006)(19618925003)(66556008)(110136005)(2906002)(478600001)(6506007)(86362001)(55016002)(7696005)(66946007)(66476007)(66446008)(91956017)(558084003)(4326008)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t2OvwgmZ8BjDlc/vU/acc7NpghAOCw0faDougWDP4fDz/Fe/7NdcB7TxH3JcKx4GsxadfhQxg3A6PZzIBsNPUPiDKEY+0TgZWhOUjgFp4pX+DFuXkAmDAIZShycc5SmlqwxWVUjfVmOjUPLIN1sbnAiZMpUbDQr9hILjq7mUT89+CZl/Kv6v4kxjCbQ6giFB2kTWc+GB3iDFn6n9dR2IoxUkkcE/rIJtp1Ktjfr2FGNEXmCFw4C11vVD/s8sT47fW06BE+zfoscvtZtz08li9ov3OjAfZPhjFXLP1qOF/jCEL3NMnSNWsJPLQxhV44WP2K4T47NI+I1oT4ZUhSZqjTWE9AXbQb5wm1VYKqP60LsN8geLceSkdRBKPNPTsbixh9ncYsd1lDgPXoUC8XZ7MIdn+sXH299ZmY0Jh1rnjGAM6Ry0l3GDiAhN0BG3t5aDLhYaWNxeH7w21oVFAz5+n8J+GMeZCgWmO0szqINpygh9G8TD/GvSUFSVEdcSRZB9/HkreKfjfMF2l8kUx72kh6+o2lOl+2WII4D1/OtTslybFSa9TdED7cvD8324wi21PvXM4ZNLmR1sKD3vgwfnScalBbScSg9BsH1EqaqPTqGdjWrnNXn4QyBjEQA3WpM2sP7CR7t9YsVH+sjmN2vuZAc8oZMcTRWLBvjUCcctS8Vn4OJrLgNi9Y89lUjPxftbciEJDpAmkSsLSzoBAnn5fQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81795287-d220-489d-f201-08d886ecbe3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 09:24:23.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o04cbhr/4WHPsYQ37nI4B52jKG53NDzWJWBexa2siuOYV+2BJg84fnhab5IayzwIVQYRKbulfkVN3qSqaPm2DsCA0Akg5H8IoKw3nlz3Ucw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
