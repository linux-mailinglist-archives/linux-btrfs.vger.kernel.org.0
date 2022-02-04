Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368A04A98F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 13:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiBDMH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 07:07:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26539 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiBDMH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 07:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643976449; x=1675512449;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KGnzEVBSaoSV93VFefTq57bsTfISJLg4nBPrW0XtOTETgzX0JzoLwDlJ
   JHRgduNbsNtOsESBoTipoxW7Gs6GlHX85xfz3xa+m8UtRpmb7ILUOeREW
   U+0LKcMNqQEQImr9olbLi/ulNpG24eZu9/lFuc47wZHXpVkJcC7nHZ14Z
   e3wfGSrYZlGQvIyHVDFILjREYZst+8NoZg8HF5azyVGk3+ZpFJx/1ibzB
   qxZsDuS2gtG+hXclTQW5h/Abu4xcykvSfbrS0MUkZnbwak3eFEcfMBNtC
   ShjVwsTl8UOxs7LTMqcDZ9vWRyjCQ6aTWpOKtoUTejAwdrdC10ePQeuUG
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="193148802"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 20:07:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcUnwV28YeGKwz9M3VIoo628o3wVCUaZv/2gTzfiX+YBYtwBbi05R16KkmIPCqzIWhHU5gQRKF58eK1c2uSK93LOn3pxvuXlvDBUa6RDSiuql9AqcQXEae3nsdGcr6EU0HIk4U2207MIFJCPj7MJC3tF6rXMmevIPsu7aLr0DuF7MLh8iqVrVlIppP5ptG/cxKzO2OveQ/lV5Y42ZG4WtSnvTRsOrxXj9rKzHhzNgwVn7KbuOrDXENLVHTq/Bm/Hn3OtlcbN2rFY6Sl+SmQEfYR852UWRDGrg29ceqBOLKqXwpxhalSVUoFBHdJ4Kt2XCTQ8f3zxqu9k0r4Uy8mwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jGccYsjGMN+gJKyGdU/y8XbcC+JCMGu+BPBqWTxOb73eQkpfLDqrKjHuoBkKvXmKsCbbMeHwT2wMm+BQ3RZWBmHDFRLvNbCoHjs0fpxhlM7ZhtQUrWEfteL6VZBT2MSsJSVprGafvzstnhd9qiE9OVgKqpKeZSJMJYYXBxNhS9GWUcbGnemweYZzh23GWUm/FN1APFkWXjX69rzOog0IZVEkwabRh/NoP+Fx5qkG8xcqFKqTBGqSSLbMJHrqv/dzcjnRai+B6ne8z93uMM0mkb1H6CzU359X6FGDPAyHKfSgtQVvETQbclCGgbmib61vqjOwBd3hlkQ2e/ysZ+rsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YShem2xI1bKhnhFYvJSpt8hNu6Ag/x7xgHJJLxzWrOik/lcvRqu/5Jlfra4sW5+nh8z1xGtXtx9R6UjCNPKJSNmPsCDL1qa2jy+RIEmswnxAn0iPq81zY0qW25THwnb3P7C/UXXNTUwUA4FSJn/aoXB3UYk6teVyp1AQhdscZJk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4120.namprd04.prod.outlook.com (2603:10b6:a02:f8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 12:07:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 12:07:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>
Subject: Re: [PATCH v2] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Thread-Topic: [PATCH v2] btrfs: zoned: Remove redundant assignment in
 btrfs_check_zoned_mode
Thread-Index: AQHYGb7P3zK5D93ZzUyZZEyYF0cqvA==
Date:   Fri, 4 Feb 2022 12:07:24 +0000
Message-ID: <PH0PR04MB741659C7D9FA8E1C5B1F1FE79B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CGME20220204120024eucas1p24a253ca559b0ba10f6e1f2c72dbd06d8@eucas1p2.samsung.com>
 <20220204120022.101289-1-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab7a1626-1ad6-4cd7-1356-08d9e7d6e7cf
x-ms-traffictypediagnostic: BYAPR04MB4120:EE_
x-microsoft-antispam-prvs: <BYAPR04MB4120A96CEC7E1D95888F77619B299@BYAPR04MB4120.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhtrYMuMHwzT3JIMgj8lFLl2yISGokPT7WMMeLUuij5PeA8ozwkyUqAUxB31fs4PullqvPj0q8H6oTItPlx4KHjPV/1gakr1AIblm1s0bMBavY8iPwQ2lrm+0ScsuVVpz4DMagtWmwsNNKqJd19rJj1iP0t+WCmtE9YGINBujO7fTAClKHk7ynsfleBUTv25XlBnZAv/CFu1nzg/hbJ2EwkRvvcLok+JWyqKvuBelhSj0Is3v/raAJkMzYOfVn1NyTLXhhaBRBsDk5F6/sdmajHa3MkQvEqcdFPwBemxxTQds/qBu4S3Br3bCYAfARYzGH79oR2LE/Afn0sKEW8XPlfHyVM/rWMgLCRGlo3RZ5gNG5J6qn69nT2efePCiXrLPkXZUoUfP6eBhT0VuCv0F9aGWRBzZAaeYCNHmhHHF59+nYl8sLGwqTwspiHGheMq5V/fXCGpQ8oH7oE+dYZm5+mO0nij3H4ua8F6R6XvM48aOGYCh0KL1Z64TWXlG34OSP7hYwRdS6+v6isabo1dH4d1XQMmna10nRb5ZxRCpKKY/3EB1aWt6j4I8O2ZgILL0eyoLZkgCHVoFbAzHlNRaeIWPh7axsHogPw4rWs+1hiTuykngVFJMsgPHDhg5UfI5UFARMvoLDi0y0zPzVNrMjZ3yT2sfsIqH0dANOmjs60FIf3WgmNa5jXG1adwzVHaJfwrpf64jO6W5O26v0pXOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(8936002)(71200400001)(122000001)(66476007)(66556008)(558084003)(5660300002)(4270600006)(186003)(19618925003)(2906002)(508600001)(55016003)(66446008)(54906003)(110136005)(316002)(38070700005)(9686003)(82960400001)(6506007)(4326008)(64756008)(66946007)(38100700002)(91956017)(86362001)(52536014)(33656002)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nXeTuwBWBQPhZ8o5fHT8xaRhJFmUNtNKFL+80UFstyeQVOFo+vojVwQkHypU?=
 =?us-ascii?Q?uiFfi3dB7Xtg0lA6Jv5eeiCHIApeF3y0ITtGtKIWunok6AOOMPW+ayuH4JTC?=
 =?us-ascii?Q?Dg+TsHi2OtKT4sobHUJbamHa+5D/UTI+s8WcElCI30XUjGSoLb7Vywqgu7qF?=
 =?us-ascii?Q?MgePZNc/m9FUgkKC2NSNomHcQxg2LgzK5991Yov6gmcWVV8eQGDdD1z6e0aI?=
 =?us-ascii?Q?uuxLHZAKD/VDrxDhdpAZIbV7rft2X3kkufKUnayu6PTdyt3WzWHiy/kpGunz?=
 =?us-ascii?Q?jKX4XE6eG/MkEP2DPmAntW9sk0V/0gLfDwI8WsUkK6pyqRC/XUWcbyslVqc1?=
 =?us-ascii?Q?hHDazZDEF/dfUn46MoFPpz2Ujs4zD+zyhdiPjF/dVZ5oxA/d0unUa+mgJoX6?=
 =?us-ascii?Q?/VDINHYhbC3TKhoYeRNEIok2zpHdq/Dw26ESXuTumrML2dXMld7iHPr93Ulz?=
 =?us-ascii?Q?YvVftMhN6A3mDYnT3YoQqI5vPK1fiYQAui4yvQ3yQvDixqOJftUPrJ38aXZX?=
 =?us-ascii?Q?6YWRClMCsY+gEqw40OjueaIgu+wGjcSkb+CRUcGelG21urCHDTHZlHYZX5wc?=
 =?us-ascii?Q?qPm0yWLyRP7tRLEsWN+fX4Wg5GEN3dONa/mTRi4755cTYfDTEjE3Rj6J5TOz?=
 =?us-ascii?Q?zvX11auC2MxtNrmGV7M1Hqw7ENH1p3mB3T43uYw6mwG+R/urUhPkPkPtWsct?=
 =?us-ascii?Q?Aml8Y3gpzhuf5phudBOdgdRdPLwURjLx0apUD0uT1VEwZRHWudaOYrlisx38?=
 =?us-ascii?Q?R6WGpwZ4ohtCJFLo888wvHN+mXq9jTSYaq3jHSFcTVe7hG2ygPrqT+u5Yd8L?=
 =?us-ascii?Q?e9bC5ZPTskYkW8y6u3D/Q1aQISDuogLkUeiwzNNpipzv+M3+625J0exc+wc7?=
 =?us-ascii?Q?Sa6IpGongXrc/AFbAuRSVL9qU0tRzsrUTXrC3WHM3Gm0K3U3vPjt+aR0R3g0?=
 =?us-ascii?Q?jMuZu5xDIKI7ATZarnz1DIzNfLHXeNr1Aa/Ksxichcm092hK2y6wKraViuAD?=
 =?us-ascii?Q?J6Tne2OIQldr8lBFIL/tZ9c6Nvq6U0SZ7CVf8NChVHUhs6A9Am7cOWvNCGQN?=
 =?us-ascii?Q?NT7Uy2zkzI+pWbjmDUU3K5EKgXwrilgSSkrNp0s6sNiF2IMvaY9s/0JrAlB3?=
 =?us-ascii?Q?e6Azn/SGn3rOmYMbw8/MWQRlV97L3mtaj1VsZN6xr2DaU/0tIdnoHD6+QXmS?=
 =?us-ascii?Q?CXoXt6/TC/XP7LYVrDY3JpEdAvfdYFqt7Gmxjx6EZiUmM9DDuC7N/wjQxNRl?=
 =?us-ascii?Q?e0G9UWZDamuWK3kkiTCbI+Y9AHRaQhLOIXy/0Nw6uwJCtiHbwPdukv3yb89S?=
 =?us-ascii?Q?ZwZdCU6CK+dUk3q3VubMR1sPeHMDG4zfLMA9x/TFEGwEBC9Yg6oBQVSE7D0P?=
 =?us-ascii?Q?cwxkOWUQ4aQ9SOK+QZUeSjXdqXZu73DsurifR8JP917wpYauIcLGdHhcqGfu?=
 =?us-ascii?Q?798GR4jo4dWqTYiuKb61TfcjRBVpSyz205d2Dg9kkNTHUQMG1N7JyODpE6Ql?=
 =?us-ascii?Q?Ty6FNjlzxSp+sIbApL5sv3tc1XJl3mLj6xy2W6dEY2BvXVDqlqeAWhfV+ngv?=
 =?us-ascii?Q?+AQf4Xsl2t/aGj8UdY10O12Ll+v81D528lrMtga4fZbJdNirz66LuKsjZ8rJ?=
 =?us-ascii?Q?ODWkJITZfFm/D1DzGGFn3ALtdc9Eq6ObSUITBBsHMbPUrtlTf4Rn+/3Puzhr?=
 =?us-ascii?Q?GhXdxAX80U4aREWKujxv1NKZiYsDLunjL6nDgQMjkaK5izjEJQ1h4c1iM7o/?=
 =?us-ascii?Q?2zN8varKj6dZF8zOUbpKPOqzfz3ktlE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7a1626-1ad6-4cd7-1356-08d9e7d6e7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 12:07:24.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayqYO3hs4un5U7AM4Osp5kdBbiHNZKqHX7tDCdj2lfvIOIiI4j9DXL4/YXfHLoMh/4pHvRTCVYdUeZTsL7H/LTY0XcvsPjkh7GXgNMnI4Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4120
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
