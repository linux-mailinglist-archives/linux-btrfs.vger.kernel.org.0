Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26211272944
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgIUO6e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:58:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27501 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUO6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600700311; x=1632236311;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G/d7iEmDHAjA9thAMA5sFtdFkRk/EA8oxyof6qTyXNY=;
  b=XIsUV67lR2Oh0adBToh+Wk58wl25ADyoVSupEfakh/R1KEVJjwdRf+Cp
   DV6iD+pYvbMq1BC4s1zyxY6vyIU9n6B5e/EoyMEEe12NI/2agQBdfP4eZ
   HtrWoX5Dvn4cpm3Szn2SuHtlq/8Z4HbBvne2dCE0CptyiMileW9pSgT8r
   TWeg2EMK5uRtBxisU5P4d57v8yySZlNT0Q+AhKtaa07OeMTFh9lexOMNo
   XAJdGa7aGIM5hdoHaqvGCvnEuDdse0N2Nmm1BtYQH48iq7p58EjwJTkaK
   wvkkuKA76OViPpNZOzRRPMSAQs6V3WMRudIqxcV9IF9oKpvQtOAIwjL9N
   w==;
IronPort-SDR: pDfI0KiHgBqDKZ97uIZiSX6ZcjMJy4PTcwbChq26WNwTGAWfq0E6lFK3UBLOrLeMFgLl65XVIx
 EWtV/rkU3Vllrz/0aGugJOeuGsJRFubbAdJc5WaEV0xItYIo+ALLegY5xFV9K9fr79UzqOZlAQ
 Kubo43T0mByuE1pwIcjRzuZog9fQy7FADrYSd1Q2UFtBOR0vTMynaGSVzqEjHtOFXzGggdG/Hd
 Fzcal7Lmx1/jGwdkC7/pmNl1r4IvqDGN9RcuNPz7M0gf2p4K0j3XL0hCJSM4FJSSlLV7JDNB3G
 EiQ=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147819046"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 22:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZfc7WUyXJ6R7aQcehRelg/cWc4wmTRk/Tpp1euw7FwY/YX1XgJ9/V4v3fs9HVa7GpUSkS9TersEieDvbGcpL+awSiVb6/YUwbirdYeSv/bAX8fZdU0GgOJoPbLMb4R10rjb1rdXW66TJJCJ/CjtWucFOKMzmltKlR+aARh7sR6JYdKh5LcuJAjauB4WhkhjoAf9iDuBoaK5vqJq86jOI38KbhrS+sLE737cuw06hlN52qifd8RmlG71Lj00H34TmlkOrajP1++Wcvc8HwQkb/sjpKivB9Pekq/RDKHHo3bqV+Ta788+JUVzAwVVR1yAE/dd5Vp8Rx7f3wgJo+ymTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/d7iEmDHAjA9thAMA5sFtdFkRk/EA8oxyof6qTyXNY=;
 b=jvjxk37B6a4EUtxPNMwGHLAae8EypjpLUP98sjvTn4Aa7ay/rlem7mYdO0LfRdDT7FYsxBlLWeeo0Csl5nOlHU7+H5/6ZoqW0fb8tM3+WOz5NiUUJ4/MY/e6ESvVtyqgOyCAzDB70hvCzOKFA9oAc1q6ybp3QLcMa6rO7k5YZ4i4s+rIuoAyKgsxwg6SF7sU6M05nVei2Ysi/U+IqNLDVjVRxEN+mZOzKCTO8KpsGJU9Q8AV1VDdNku2X87VJSYz7G5Bv0m+BDC2100hqyU9tJZPAXzy9K266he8zq7z8begpxlRwRH5h04llszrqQCyhsJJlRPcoqN4x0Enw6ddoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/d7iEmDHAjA9thAMA5sFtdFkRk/EA8oxyof6qTyXNY=;
 b=SSV400l9z05dI4Y1cN+SnE5OEN5x8lkX193qKMJ1nhoKyua9lSL3iu/n55j5v27RT9ZcD56VQlOlugXKLLg1bUdJew6rqpXVuMpE4DbP16PSWxIJHPb5d64sJNA9teOFyQlAxkiLzO3/q/9GIVsV+eX52o+BA7fzPvezQstUh9c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4605.namprd04.prod.outlook.com
 (2603:10b6:805:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 14:58:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 14:58:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/7] btrfs: Remove extent_io_ops::readpage_end_io_hook
Thread-Topic: [PATCH 2/7] btrfs: Remove extent_io_ops::readpage_end_io_hook
Thread-Index: AQHWjcB62hPPSZqljU2+kMJspMY4Ig==
Date:   Mon, 21 Sep 2020 14:58:28 +0000
Message-ID: <SN4PR0401MB3598201FEBC2133AEFE3F7C79B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9569af2b-d7fb-43a1-e2eb-08d85e3ecccf
x-ms-traffictypediagnostic: SN6PR04MB4605:
x-microsoft-antispam-prvs: <SN6PR04MB4605C6A11EA424FA02EBA2109B3A0@SN6PR04MB4605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgbXeBah7cGp2nyolUmBhFvAcG4o2b6hIV+PyMb7vGEGVYBJwz5pxfedmkSO1mvswSs6ZI3Mv9iBKwqHC8L0WV+TZ8ocwiaN03f97yxDK+6B86DGAcWTuy1+19IiONCwU5WRRuSbfi0yZWgm/QDt472Eh0wVoK43TxLZ0yW/uibamNoUQvst4CHCDvXou/kTGlTcWPDC7AsAlKNuM8aSOP35GAxxYWg3j2O57HoeZPVoFnWYQjMaWEiGyFhQGhHltK7m9zdvLnyoO3jUt8w1ukses4dI3eIWadN9H7c41qH7Lb/7y7S6NMEOkQTYfhAROJUKCOaiqtjBPU8AdNjSzxyA/RXxtvHmcV5qB4YIk1/CzGzbOflMhO+LzfeRzImu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(6506007)(66476007)(66446008)(558084003)(64756008)(66946007)(110136005)(478600001)(66556008)(71200400001)(91956017)(4270600006)(76116006)(2906002)(186003)(7696005)(26005)(316002)(86362001)(55016002)(5660300002)(52536014)(33656002)(8936002)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dMmuFc4z7NXViPBpLgQN/bOyNw8kwYxBNFDmTARo2VfVxhnn/UmQd4ZXIhwh2aGkbsPoiAlCU/DFdH4lY/Ixll/RwtWbTjNBEmH5JOEbcDqXFzsLaNnNHUMRB/zJnQthU3YW7NgtG/uotx7DJcrJ1Xm2MpbYz5No5zbjYWRwNdg3685iEHidDlsiSES0YB5cfHCly1PgwH2gx6yTug6h+nXnW1lDpERY/i3pAu3wHs7VojlmJKfQ1tlE4XxWbYxxqkmlWBMS8uu5Df50RDI4QlxnI9T9KyvLeA9oFmvX1d+s8qBv4TelwTErbTqoQCOUVAwPtmjumt+CyKCiwZudBQGweln+fApzp5a+42LX1LgxLAjoXWvi9DSdReM0ngk3/Z5V7gKYe+QUiP8aAfxV1r7Cm9K+fKBeyJTUyZ4QxLExv41y27lT5v9UiEHBkEgywHziJqppqyJS9Ui3dH8CgymWeNX7gGrMZ3WEvt7FRF3EYX8TVWE2hcM+P7/IyrUb0mj4TnzTVhmbn/ApSbPDFy2+16rem37ke5xBstJkwWlJAXY9Xhs0Sz2qB2WfX1WdT4fGD/kl4Z583WojC1fRun1ys8F+9HH9hgt/G5hO2qybwbD1KBetByrQ5/koIoK0LYA7jNDbUjo8Qa338ChX0A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9569af2b-d7fb-43a1-e2eb-08d85e3ecccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 14:58:28.8495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZb9e5mqZWqbSQVb7gtFbpCtop7bYepeBj47t1qfXBPP2Ukk48Yt2zvzlrnjL9RfMQfpHumozHMSFDwH097/KXBg+vEMDpwmgVt+GR0zJkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

And here it is. I think these two patches can be merged.=0A=
