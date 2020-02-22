Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF8168DB1
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgBVIs6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:48:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36032 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBVIs6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361338; x=1613897338;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FK///ZbxPcCOO38wSkCnnWSVRR1kfxXxtGDW/cIEqtI2ksiDWetOW0mS
   rbQzy6B1pV/6CZhqzmYjVd6Go/MDmrDxIxPIQsIwT/q/uxKJnDHOWBLJ5
   68WFDcXsEyNcWML/7TvwJxvX7lb0yzx3+mFcdkRrv+6gIdWkR3rYo8Gln
   9J1tIMv+i2TZPyJ9IxlnY3/J6sfIqQyhjGvkDJ9+ZLxRaP2ktTY8L7ZqC
   PhfAuzQ3Vi6AAW0CmMoPTErEL1sxyuOlkHDLBm9D5HHyNz+etI0xskez8
   o5+N8HG5IdM0lJ9h8g13T5GcIg/dWtBYJZEQZSaHJye+pby84yB+Do8BR
   w==;
IronPort-SDR: lgZxS1SlSFPGAaWbM9hszpMIhmKVfNb2sX5dVNj2wmDlzvhuHgKj5Dju5BclNLaJKwK1Q+wEj+
 KZ8TSB33ArQV6POGN4S1rBraDpoTBLed9yxdOcVM5QKsdyAixV3n8/I1AcFTPj0q7Dbr7++t9l
 YVn6C0Tty5l+9RQVZ7/CwzAMx9t2i1gk8RVqT76jqajWnsbZM7WoOLdcHdOpmcM4tP9QsTfU+P
 iBi6OqZz/KFUkR661fg/PChmXtvu8z8+zrC13DlEmtA2l8KkQArBwkXLNmWSDFayJ+BAbMj0NI
 BdE=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="232334617"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:48:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpEtXIX0fWwB5zEX+bqBoFKTWTiLUodnYIe+jpEOx8T+cSvJa7uWL+TsOFhTHMTHns7M020IqTIO7TR3P68zXULNuEr+Nh2vv2vsapwmelFuGi5h29eild21aa6vWKumeqODii/MzyHFSYcItxhi7PY69IIaB1m18I3Xa4zo2K3WVCzhSU/QHnBkD4mKOLs+eIjOl1cYDY6zjRyx0GPMvIMSIL1HuSsnjGPEUJHbmHJqNZuia0oO1YbrspweArys1tOz9ArgCGEbURiBFpm+NBpoBYM34fw3U/az4ZTOOQGmzPs2wGIBOHgSdExT2lJDa/FQG3DW4vAyC3ShzRogVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=P2X9LxosphW1eRp6XNycNAcYC7SZW8yhJJ9uMOOPrl4r9j3CL/e/HvdEaIj+m5vhzcwwwZCdoo/XbZek9GiFlMXdS8RwZYQzJGROoE8yES4Gu1ThYMpt1wU/uTHQBHTGc6CPJxfjOVbf1hVpsulQyKUGlBwETpVOuYtQTO65rNSFJ4e2HotgN0TA7aRPY44qdLo0QSoLsh2Z2a/sWFDT0HGUIFpDAWNRmZIQJYvH6T4trT+c0X5wzeHjGoE4iIahDgE6LOEeKUf3aNpYokZ/D2DX4X3nmAzGhuuTWauA0Hvx1AFzPLsVUIsOhvYPNpAywmil3LFwk41IZ4iEr/SUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mgJqksFJxiVXJVaB5laq1bX0T9WmSk1s7kcXk0GGk+5tHTYTvDZ77dby6yTE6Jes57w5cOq/zCYsFUJjmV+s4lqMUSlAS6eMKXBKfOgefX0seNYypkA2fWZNv7B2toFuXwSBsODcHCT+ZKfYTnZc678J5wxhPuq+BvlXpribVpo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:48:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:48:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/11] btrfs: adjust delayed refs message level
Thread-Topic: [PATCH 09/11] btrfs: adjust delayed refs message level
Thread-Index: AQHV6NRo2dywxxtIGUyLvyK1kL7iAg==
Date:   Sat, 22 Feb 2020 08:48:56 +0000
Message-ID: <SN4PR0401MB3598809D18B83E82FE39FE9B9BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <f8d0bd62a1cea81145756e5fb7857c8cd4dcc8a2.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50fb8305-e38c-4af9-e9dc-08d7b7740d51
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB35839B65D1B02F7E6E1D04CC9BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5T5mIsV+6g724SkWrQcK1/EBuPr7a/yUnxn9X2FzLuAhfE3UtrS+hBZBvQpcfL7moRYsK7awaQvuxRvqV1irGmRKhE5h3behWefYcIJjEfCpFdlMum0QhKGrMBc2SL3mmiAY09KXm/Ym+29QplZhW5LhByyjXP6wb63m2IeRzrGbdz1rc4LUWjG0tTs8CP8ne7YxvFef92zG0T7NU+U22I+tqnC5OzhbtQ3/gacnEARRpv6wWpHisjJCigTilgRxtr1hDNGZavjghya/kTi+pNfw82SY0L9JvE4QbXu+k2j5oIsd9fcFM8aS/Dcg3kGXEn/+fdaLtjVLRRnVGpezgnAIsB4txHXBS566sjGLjsY7UpO0+lwE5niwUZUGOFcTS16gGw530viDIUqyHzfBFYEMiG3AhWRqRU6xl79wddHdhvOsjB7r0uOdkZjrzBX
x-ms-exchange-antispam-messagedata: Gzt+Z1ULX1stG7E0rDoLtMaZCinNB2TDDExpRJF/lq+H6qFJBt8YoldGo2JzVibb2JOY0EnV++byG7Pfg11uhj8EOwf7IY6XQFQymN7d03oOgrojsmzd3xDs5llEZBryOstXayYAtSubs+9x9oL6ag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fb8305-e38c-4af9-e9dc-08d7b7740d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:48:56.2886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d73RbKnujighB82hYtsslOgZsWhgwtNZ6z68g8zCqAQeYThZsKHe45U+ylyD9+iflqp9TLthSnbCBZM0SxaZomL1ynwMbhw3z3G3UauAKPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
