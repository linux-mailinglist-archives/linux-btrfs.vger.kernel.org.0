Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883853E5902
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhHJLX6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 07:23:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54699 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhHJLX5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 07:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628594616; x=1660130616;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
  b=D5uk+pZwx2X6Wp/wcFqdtPINp9KGjlF/tbVHu8TfhJhjq7CjjT2etv4d
   XORqHKc40lj00V+0gMxntQ540hFMi7TfgGhFwfvOXTvruMdqYJKKMUGK9
   H6j1qG9deIXTrn1QnIY0QbloTqvuEN2ibCxKuZka0wH05ssPNQVKFN9BL
   hmInxPG7494i0UQeGtlW7VbmN+KJ/mzgG2DNrMyi/fek/59fQKtNG3kRw
   AfBu1FuzZodTfv66X1weoZt/eODs7yWLbwXDDRN943MXJRoVqDUSzTTsa
   /Qx6SY9OiViY2LbFeKe1kixqvQAZAsK74J04sQ2kaeCbsYMUL6JH7HvlH
   g==;
X-IronPort-AV: E=Sophos;i="5.84,310,1620662400"; 
   d="scan'208";a="280627756"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2021 19:23:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNCdejPmZXvJnuiE1MNyKAbSAVv/jSyz/yQsldB1LWiG9sHJz6MV+TJ6H8CflGI8fJ4WgEee9nWx9tGsZXeVO/OpoLDAoheXXWSBTmuQCCy/u6xqTz7aszksVsidVxnW/rMi1s2ly9cGaj4+kBKiCkxJuRNmVwO9VCDNm2Te393FItPC39Q4ouz2IBFebprE1WMH+LdeUwhj2LwI0ephOmgSzXJ4ApsSF4V1K/TiMHORyavibaTzIIKotsp8p8sA7rjSfzSMPRcsZXnSMB0Dn/DfvneWsCCH6UTX6c183+8E+hA8MesaBx7s3H/NB05d599Yvl7A2b+pdCi6+CB6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=hVVeuy4t8tFC+G8ChA9SSqZh7hyqaHX3AQRULPOoHNOLl39s+Z24pbFiGolnnIQN77UCd5H3XpDvnbWJKim5xNL2bADgGe6xWAPZkEFYnyOGvSrUurX1fSAhSe7T3g+HLEsa3k9zfMYZU7jiwYhUKgad1HHdAwquTP1dwA4mcI9rHC4B3DOsyOgnTu57b8kX+OWgRcwcctJw3zYEwLy8DaEFn92myvbsVqH+aj1S7ajd6QbWeT8MTyovWYBvDgFunfgeia0rprxk3Ov35ivWqV3jdE9FyO4Udqwp/uny4FHheH8odlPwYNT10Scxc9Z/IANlaDPHcLDj0w9jN2W4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BpIEyPRfmyrOA6/E9ebK68b7ZlVFhqWJ1s5onMDm+E=;
 b=d9lgbuyl99IbNwHpHe6HHRC/B0stK/ogEgi7NUc5pZwKBIlfqrRIri9vaYs1WzyawkUIZz8O7qv+5Cn10cBoMt8lqXuTbOc5Ouvql59osXOVXevN32VBI1kLZzBhr7ToLrztcV7HbTgfOhcIDPfEMWYJVPn/pa2OBRtn2AWTu64=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7160.namprd04.prod.outlook.com (2603:10b6:510:9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 11:23:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 11:23:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: zoned: add ASSERTs on splitting extent_map
Thread-Topic: [PATCH] btrfs: zoned: add ASSERTs on splitting extent_map
Thread-Index: AQHXjLWn0Op9WYd1a0OC5nB6vEB47w==
Date:   Tue, 10 Aug 2021 11:23:34 +0000
Message-ID: <PH0PR04MB7416B798CE93C3A306BB7A3D9BF79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210809002918.2686884-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7353f045-d9c1-4710-e935-08d95bf14a77
x-ms-traffictypediagnostic: PH0PR04MB7160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB716046FE1D2969702746FB2E9BF79@PH0PR04MB7160.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rzONFrsSPM1kN9tCll/KxPa62UYk+ig//x30Vyy02zjokciLiJ+5W3QPKzlTwXYPkiSeZqK3DWD+AHiXNP/A91ubof+Y60iUte0/KwgfWN8TWyUWM1zbMEAMZijP2+Nw0zFZw3qStX6ResIh4LQ+9Yifdo7ma2kYAF2+BBGCt7mlkzUN2A0MrOCoi5uP6WwEpo7hnuQKAj0Yvx4BOamORSbpPvQBIOLc38BqS0fIyHphfiEXf78PIBv1h0U8RyJ+LGfS9DmfFixV1jTqR2pC2g/F8yB9IfQZ1kZPOtJFvx/KufCXLwfDuVkA/dRQCuCxTTNmYoROdbyn+TnLlj7C+A7r9kF6j0RjOhW1RAcHgqLuwgJrKZCZOyELcjxocJQna2Eq4ZukmFk3hx3gheX6j3QlwrOmMvETdxfgMQsMjKVBqA+bqrj4ef2i0Zswj9Oy5PiXgrUsvq9moTgRmaDiHIMry9tI/iKDAxnoYl+O+AB3zePaoDiG3A8BX1wCdjyczo/qV76+YZxzPCvyO/y/UzG1bbERbcgW8jH7HV9Bv4vxq84j0vQ3kVPKk1yTD0OxbJaUx0kTFv8SEcwXNterJDuqscNSA2moR/hBVBx58WBZPu4L9F6Mwmr+WLLbv+rZoud+kC2VfnabIIgacry0aMMkzBHummKV+isvUlHCMZwUiOyCx7oLmaEmyv9EppCEWai2D3s4k2HENoZlZ5hdsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66476007)(66556008)(558084003)(52536014)(66946007)(66446008)(64756008)(6506007)(76116006)(4326008)(2906002)(5660300002)(8936002)(33656002)(38070700005)(8676002)(186003)(478600001)(9686003)(38100700002)(7696005)(122000001)(4270600006)(55016002)(71200400001)(110136005)(316002)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hH1aoEjbCa3GrG/90fWzkoxFWXCgegI+NLOxz45DWaTBaWNDZVvo6br8Pb6v?=
 =?us-ascii?Q?IA9XvJbVhWAFVJ8uEVQ3Y3kOllgEUyBfhPw0bn6Tf6OhJm/HylGA1mUCCvFm?=
 =?us-ascii?Q?+JyBFj/eq6GyRlGclz0hqhRlL4ujDGr/XU7k5A3luSCBufGEPjzf+09bMJmk?=
 =?us-ascii?Q?nBWdykAQjNq73/RmRGE1xfoApP0KLC1vEorVWXdFCld4u0K2KzusFKoLrK9c?=
 =?us-ascii?Q?AccGnodY9cocRtPZ0d6knUVaps6l8bEk5cdWEoQEE1Lw5L38YEdhpb4m102M?=
 =?us-ascii?Q?zP2TQs8/QehE7oQsMSn8GBIFykffCzH7fYM6I1F1yDj+VGdiFoBqF6NJEaXk?=
 =?us-ascii?Q?c0663Bah0Bv+joiBNXq6KBY9wpEH5kMbNIOjz3jkXMRGj08k0v34pbp5YXR/?=
 =?us-ascii?Q?kJsDoUmDCf7hMYPqGE+IMj/q7/8YImjQaVXIrxs/kXK3azhhbjO+aQHbhv0F?=
 =?us-ascii?Q?21w83qblFY9zPafUCr9WERuBQ4D7i/cXRXvdZ78Fva4vonFS7kb5wnFunuws?=
 =?us-ascii?Q?8VoS1AJ2B1qXdkiFdlps0lJyiJnEMJfAT5BcfhZ8fxNY7+xyCn+o9nvQ1+dm?=
 =?us-ascii?Q?K1sp4tvxSQHcWn3OhBVS/gZkOvTTvU3TKNj0clcJ8V1L6keSsp8ihwKmerPn?=
 =?us-ascii?Q?xGUHhASsm3fSy63r09wZ5NGgg3oc7q2Vy7q0ml1qc5eK48+qcpPnWIzpb1b2?=
 =?us-ascii?Q?viNgUq9ijVhaxCSND+Lvzg4jAEKXYzWgdBzdbRAKsOx34AWWKoMQ3KOCNeiK?=
 =?us-ascii?Q?VFiDr1jLwGhwS1u17ON9v7lc4l9XSadVjSxwgvskT5yadcJM3L3txyPKg+Q2?=
 =?us-ascii?Q?NiHHAZuJ+VleN3VqmiqS0up1Du1KRhSkzx/Vy1a8qE6egP1fCz20YXMHEvfI?=
 =?us-ascii?Q?yTwdPITPolEdHZpLD4N9HDRn88xY9PzU/akqj155nZE2seM8OJbC9O6u7nvM?=
 =?us-ascii?Q?r0Vt3VRVEhuPwNL4OIrzgONAC3hjOw30Arfck5AVYZDyCW62Nqhrj08UaLGR?=
 =?us-ascii?Q?P6EqtdRrM5ne0IzaRt3soRamfcQF3PiIjFOmuxAmzr2My49rErnuL//OYV4s?=
 =?us-ascii?Q?gee2NoOTzrqJLxqLroZIzxcaq+qKCY+6PZV9w6REQ3OTXM9xcUPlQqznwVQ7?=
 =?us-ascii?Q?zlJYM82nBNKskoBvtu123e9FfXefkPCjGBbq2xWAv8O2gEa0qFzKW5F/MqPF?=
 =?us-ascii?Q?ABGNlyY4ofcvS5HeeAUGImEvk6nOq44pSL8c4EsVQBNoqudDsL/bs/IGiWvS?=
 =?us-ascii?Q?lgP0y0pMEJcfzrsxp92KHRPWmPWZmofuIy2pXb7CDtYv9wPKKpvWJTrg4H+j?=
 =?us-ascii?Q?z0z8gfph7rGV6CZML81hrWZB7xetIR4c56V1rUN4LX9RaPXkMf7QM0YtvUhs?=
 =?us-ascii?Q?ZfIjxVIepVJdukySwb+tVxNQVWgXvWpTR1fSs8nqnkt/qvjFiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7353f045-d9c1-4710-e935-08d95bf14a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 11:23:34.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wohhVMSqxA6HjMh7S7fPB8bbpp7AhgmIef+wFJ+DelHVvL/zSZ2ELAmho59eA3jp68vX08z6ABFce6eJ/hgk7pJrxRAM7mMOxyevz26fhj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7160
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
