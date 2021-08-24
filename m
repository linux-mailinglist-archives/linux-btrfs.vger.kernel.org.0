Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33A3F59AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhHXIKQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 04:10:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16350 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhHXIKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 04:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629792568; x=1661328568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dJ3a7gGGlIcR0q/7ULx18WB1GWlsZzhhOdNyPdSjFPo=;
  b=mmHxWI9aJZj2ppIjATjKjvdlGOxOqaJQP+Hv15G01IONrhrnQto+EQyX
   OoeFLcKgfh3Dpsn88f0XFeS9fLyHHAoMahPwZzmVFmHYMFPUdWhzbTWtx
   ZxkasvdLmMwiNLBMT5+7cduO/Cuwzj8M+7Nn2UnNkCmI4QnbNp8KwhFCh
   DD0MlaxsSlh81OLDbV2uhJyQRBvTn9HxoH6LG0Uz2WMo0TGL+g3MZwLEq
   DyyIg0bDeu+Wr8GHWP9Th5pjLWacyC/VNvJ+I0tR4ga37JJBR0UpLs0EK
   8KTqkYFnL38E7P8UJ4HWLPalnBdYnGHNf6TkI76Z600n+AWL0XA1XrqF/
   A==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="177339269"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 16:09:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNVUzsNrODr0/iKBS4BgxsFJzSt+SkF+Zp2htoHeKQDyAql6jjmRT9oOIRe7Tdq8B2UijKfwcSSsS6pnB88RHDBL1CVvd34Yxji8z/ggzdvr0WwQ+2PXXDE92vTjhXcm6YiQRxTnf1M8Kpu5pL1gztajFV9++nv5Ie5V2CgG5Mu3vAyEbJADfBM12t9g8jQ0Zp+KVS2y5HdKi7cLwTgvREoBkfIPvz3WATx6LzogzdvvEsZpKe5tqvXmDLvJty0oKOvNNKZa4H2sBH/YC54cy35mdb8rKsVJPLfMFYyGhf62J9oeDEWDP9vRo7EqryUOqxGs69Ghsd69a1i3hmmTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3a7gGGlIcR0q/7ULx18WB1GWlsZzhhOdNyPdSjFPo=;
 b=RA+UiqvN9meHxaO2FuEG9Lkvndxxrf2VjV6NGx0vz9eTdyO6pWkn02Z6sYYMT/7TAj2s9+1mlPXg7PvJA2IFinnkqzH7pbn+k0Wwj+dxyywe5Vj20jMjzpSvXdWI1YS1MMJohKnYN6kFrBvhM3UAgou0RoX6vniyJEZsQCNxe8cvGHrDssV+XkPqPW5AMRwF+y07mRsC/Cs/WZ/53g7gROPChKm7MDpz0xcbdErvPPumzeIv9tUjDRtdAw6UjrBxdQFhkMsiKatcfAv0qu/Xhbw4Rza59kBuv22aKT/76FeO10XtLUDhj1OhbCU+Alcl7BI6UYFS5eHs5ycihA+IhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ3a7gGGlIcR0q/7ULx18WB1GWlsZzhhOdNyPdSjFPo=;
 b=K13+0wCr7Q3N9zzs71JxtzY+0PGP0dH3KdC0Hqofbe1B8dplsuYPzJcBXp6yh+9EDbTQzRw/XJMQ2yvKzdyX8C5SfIq2ldhA9cOq9qaiBt/uQ3j1fZvFMhc2xuUIBTE8edmcYOWRUejoGb2ALsWFD4vg2dgMQ40SDVTY0U2OeWw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7432.namprd04.prod.outlook.com (2603:10b6:510:9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 08:09:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 08:09:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 04/17] btrfs: zoned: tweak reclaim threshold for zone
 capacity
Thread-Topic: [PATCH v2 04/17] btrfs: zoned: tweak reclaim threshold for zone
 capacity
Thread-Index: AQHXlPWO2Z6YXjIEaUO0S+d7dTyrJA==
Date:   Tue, 24 Aug 2021 08:09:22 +0000
Message-ID: <PH0PR04MB74160DF153C5639253E32ABD9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <7af8015000f794f3481a2a36a25391dea0d8124f.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f199658-d194-430c-6217-08d966d67b4f
x-ms-traffictypediagnostic: PH0PR04MB7432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7432C83D0B6A722B247F4A2F9BC59@PH0PR04MB7432.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4LaYgMXswkQH9/QQe89j9K29uPgmiLQnXc4C24PNga+XZgiG7ShJLpXGbZyxTOCbkGweoVp6N8uIhgUAKUnf9DssS6QANcUBHZ/SLgWktW9qvDItY4PpBUS1LVB7pDqle0TBqk+lrXsuZSgNRtO03X5zcCr7rNqn4jzEO6eM8gWyPZMmJ6AWkZYd89yLeLOrTykEuCD4q5ZOTDdnrHXQ/bAKnDJRlHZ5jNr6eZRcQcB6oayGLd5vyAINWy8UoJYyipD95YbicZ8JGKXJY2xwEaiB3LU1WtTaT04Rcb19i6+ebFU84KEAcmwnxbT800Qedm5HaxHf8vW68MSbO8iBcaTRFnxiiINyrkahNYQM+1jVOILvmzLtR+c57F4mtj1WURW1stFNm2rm8jvMDSqzvPDnO9yks/GAQsBbJfc1WyMNNIoMGgMQG5N8o2Qq2ODbfckjtH4hWxof61Fit275PPP7J/d7Y+q+ESEHZgX2IysnORBDJaAj2hk87RnKWRVuqt1/QbjBA401/HlqC0jIhrefmJMvBE65nNu0yz5EwcVATMqQQlFabeYRRu7IsfTT7iUXse+OAT9zu2MKayAC7zAvDhD2Hwm1VOFIVmlvF+5OgNgx7b7rhMtCtI4q9kkfoQtvp56h9NNCvlHPIXJZT9zWQZsZTA3oWUtSfwvIB2gUWQ+dkhmv5uZvfu3TywHqZ+LXgqj2VlEq7hRZM7Zx/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(8936002)(66946007)(66476007)(71200400001)(8676002)(478600001)(38070700005)(110136005)(55016002)(76116006)(9686003)(4326008)(66446008)(64756008)(66556008)(122000001)(38100700002)(2906002)(52536014)(6506007)(53546011)(316002)(4744005)(7696005)(186003)(86362001)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tluI4PpbKvokXZAgdkC21tixZbc3vDMSirSC5PD8Ur1G1ZYslwdcQ/YD2Cx2?=
 =?us-ascii?Q?TC+H3eJlIk56nYNMHldZpWK84f8o8HvKN3vma5akOXsNpGfW6bLz5HAP3569?=
 =?us-ascii?Q?jvxokh5MYVdLG6KS4QDyCNLaChz3wrRazID5G1y1Nuv8YvMycDxRtJ4bU+Th?=
 =?us-ascii?Q?Zv4iniNyfxEFVBHpPvTCjVKiSwvAZYAvVOqT/Lbr+1pQFopnZy6DmM6MK6bM?=
 =?us-ascii?Q?/3P8U31BzqUBfdtqJr8S1OfGbyRavPOhJrXoB12c3bEPBrUnXdVrFirTM1hY?=
 =?us-ascii?Q?22he7LIQjiT11z5UDlAQsYIE5B446IrRFuSWy8VZy9ouaQMthyZeTkYzDNMl?=
 =?us-ascii?Q?r6/WJmqb+z1uiPcfZMRNSiq1A0pmsfGqIZiUumsfvNZH7J+L0iZ3Y0ZS0Xpu?=
 =?us-ascii?Q?Z1Rt5T5UCZ4j71TRCyTtSFMKolrA0U1w8tBD5/vfC4T49uTb/1L1MfH5h0E6?=
 =?us-ascii?Q?FMyyTKptEJ4h8kX6qKCNPFV8NRgVc/jpx9pL0hyKfjwxA6eKnGXlVhFbdfty?=
 =?us-ascii?Q?m1yoVdrVoPRmZQh///DVU5SvqEGEf4tBUxN1iIbsBTYhrHtsPWa3urU9lzOB?=
 =?us-ascii?Q?R13yhCLCw82lkQM5sH8x6YWGd0HTF/D4JDAeVcCG5REIZFQxHoW8MJMgsJyO?=
 =?us-ascii?Q?X1yKkErAIODhY28gvJ6l+7ex0Nkdfz03J6DoHZXzXP/tI18HNdmmPZXA4ew9?=
 =?us-ascii?Q?qlEVkRqDdKc+B/8QGpzhcTVYAXMB+m/QF9k4Alm0Z6VcD/3EehMRm9Q4hyrG?=
 =?us-ascii?Q?I5+VuqZ0AibQmy6SJJYX+q3K57GRLw1SrWZ8sRd9pXmBzEmcWi2SSlgSLpmB?=
 =?us-ascii?Q?O2bveODBz4+zFRT6q3eoo8Rfn82pUN747pCvrKGIhuUQrruna830bIDDgWtH?=
 =?us-ascii?Q?j0mk4sK0nZdLzPdLKVG1HxLkE0/GkiX/dLiPZG72qGtrXL5623K1AL5+Lx5T?=
 =?us-ascii?Q?0U4VaNCaq3mgLWo8LTcNShIoITplt882uT/ZkBcRixmFzkYkSnX9F94b6LkY?=
 =?us-ascii?Q?RdLxftVoTdu9WLosbIc7nAW+HGrn14Z22vsNNuu0h5l+Lx+8W1D/wZcL6P5g?=
 =?us-ascii?Q?7BJP71axgWt8LoI6xSgwu+epFQtp2EMsfC5Ll/tJNLa8R9AiNhkO4hPb8Xn2?=
 =?us-ascii?Q?cdLXAtQ8HtfvNeVbHlT8Rp3AeZ786J0JG6Xz7IDHmJNP5upMaH8dwBLUjzOA?=
 =?us-ascii?Q?NjwyR8dyBUhgjpoi3WWiWVY0FRHQlWfw8dDaRPSJZVv8ZuaXlL38DwJcoHkZ?=
 =?us-ascii?Q?zDtytFwMmJK18C+6wRFf8MEW0e4i3oysELEFKTm/Pts6s/ICikQUw6n4Aa23?=
 =?us-ascii?Q?u489TNV14eIJH4+zQgJUqzRBVRcUrGW9chqd+1mMrwLnvlhhg4GvHHXUge1j?=
 =?us-ascii?Q?8+bdOQu4DNpNtXraGXI+RqxU9nEy/4Tk4eqTed/pEE2lQtj/Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f199658-d194-430c-6217-08d966d67b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 08:09:22.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9s+NAEQONIKjFDsG6sEb4TiMKzY61yGjZLSjicxMLOCW2tGmb8/vJpfpHHmFH4A6BZPiPwVgeMQWzAGhu6qM3byrYCADIS1dzFEQdZ465GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7432
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/08/2021 14:27, Naohiro Aota wrote:=0A=
> With the introduction of zone capacity, bytes [capacity, length] are alwa=
y=0A=
=0A=
With the introduction of zone capacity, the range [capacity, length] is alw=
ays=0A=
=0A=
> zone unusable. Counting this region as a reclaim target will cause=0A=
=0A=
Looks good otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
