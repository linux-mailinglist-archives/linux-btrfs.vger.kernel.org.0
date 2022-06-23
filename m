Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53BD55758A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiFWIdm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWIdk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 04:33:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA543AD9
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655973218; x=1687509218;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MB7kg1tYHLk8CRoH/ntw+DecrC1u5C5ARpRdd59ZbAfFRsxb5cY/EUfh
   Iz997g7/FVk9KyZJa+AqLS0akbyHnSKDlZ7T8lE7wmQgLsoxLuEwNaJG2
   AcDR+yZgH4nERLNaewnnA0Zq4fqKjFmKDKS4ezAvC8j90gml9RRB6+kQa
   +aaHj9OzHNL9dAu1dTwxTG2TDiJBT8eNTzvU7tOZ4YfX0OsLOV2Cr1ne4
   +KCiUtgNzlNT6sJhnAxoy0j5RHdAYZSS5tk2MmnL2Tpqi/snS+Arashb7
   5N1UGWqH/6Zu0FhX4kxRC67SAONAA2ui5O6sG+3BXqNLwUhtguf9T6VYL
   w==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="208766326"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 16:33:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py1XPKLd1KUrcWm8PfmgVtRewotv4dJn3dBmd18k8x3QiDbpPNPbm7y7p7EpgL4O8fbtBRIr81KKjWWAEKhcJ6UKmp2sf/7guc/p+NtdslOmC8uruo2tXyM3JkwWRG9k0+26KaX51AagWDh2TxHcXlL+gb/RX2JScz31zhICMRtpSiKLOyrqrAWB2zv5+a/+PPseBQGmkbuw+mzol33qzUraQwuJUis0fNKB9Pp1HEL8iO45UFGgV9Cz+0THrc62WXm+TXZ2EBSLG6rfhmzUWExQ1g2cUUVlYDes+VU8b9bGlOa+2QDzQ1+U2hUEGsxZfivrmeggyg4au1O3cd9LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TvlRpqRlF6daeF4FboBlDo6vniI8P/8zur+4+8VMwP1SqXsUleF/2rQOuhLt0XN22XCsaQm3YY5ByRQaRNavC3GsbVYOVXNi0ll+Vpr9ASd8EMNhYiTSpETofGLjRNHuiEbXVb602+OYKC2WRkx9cc+KLjYIj9+WXv6nwSvXXOnmxfiQfKy8AfwGTmM5xKTdeKbfqkS1ot8RJopFhqjFVotS+g9A3R729NiRuaycY+UlKNwFyLf9fXGyaG6q5opjztcYK6eqr8s35ttioKcxmCpjqR1t8c4UaFJikfDiUNP5DF6ItAa1mf7QtmQgFwf7ah9hiaYKKCYa2/eJ/NlEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m4eOuiebRV7WNsr6OLR9eAvKgQeo7MAI+uY8VOb3zU9Vz3xX1GlHQqsOSynjmBvRC7TuURs+r8tOurQ8tWnuIZE45lC7FRlaO8Lmg1eZEzcHp3UwnehjhvuWWs+0f8ZVYl6wyX/o3ns+1Z3MoEA8Y2dMYSv4TT7UFyLi9PZUA/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4375.namprd04.prod.outlook.com (2603:10b6:a02:f3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 08:33:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 08:33:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "forza@tnonline.net" <forza@tnonline.net>
Subject: Re: [PATCH] btrfs: print checksum type and implementation at mount
 time
Thread-Topic: [PATCH] btrfs: print checksum type and implementation at mount
 time
Thread-Index: AQHYhmuRN9KCIgaTC0Sjqi+xCGMlJA==
Date:   Thu, 23 Jun 2022 08:33:36 +0000
Message-ID: <PH0PR04MB741698E1746209A338949FA29BB59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220622190331.5480-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5119dfa-8a20-46bf-9a00-08da54f31137
x-ms-traffictypediagnostic: BYAPR04MB4375:EE_
x-microsoft-antispam-prvs: <BYAPR04MB4375CD215128162475EC1DCF9BB59@BYAPR04MB4375.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z91o7isfd3N/FUNNgFwhd3Iy20aIaBJny5IWjdzpHtRfc9jvW0s6Tpmg893UBqkhRuRkRKCGERu/yyI33ak9hjH+HMm2z9PNdPdpy9ioAq5z+yGePSuaNPBdFqk3ho5pEILuSjbq+Z9nalVF70JQ+3VbhGUXnEBbS6ocjWG4NY+l3HAFZZYhWvNGv8BXRadPWEcL0P71dM4uBJF4ymDc/0X3+1q/87l1Hudg4IfdTG5iqjx1YSJSzA+enK3ssSAlBa3qbXmr5XC6oPFXqMwWkLBD1r+LRWQKGOJ7udE8Hf6MExTz52uD6/CXnftgDNMVY4G1d7kY9NQuApGI43yhosSiSuJ6cDDnbQ0bXRT7A5T4xGrZkZi7vRS+JflbgTvr7ltyxkp21nTpui4epS+R4r2HIUz47F+wKkVbE61FLjz5klNhORWezwblNL3CjOCyUwa4hyS37ZS7E7Pi33ClCG0O/f0Qr5IiL9OPRtSmDMnnG0yvo/QgLZCbhiU12o8BY5mwGanE/P1NuKCqGhMiwlmBrTLT0Wm+uRfHiZLG3MRCZjd7zHGBmUdcce/sckQXK17gBdDSWWAtkEULm38PvkcuFf3AY/SDDoN1C+eFApBcatbPlEG1cZ/ApTMrwoNVXvbhtFbMu1wUCf6jp1fiQjFydr0RueMskjPrPv9DuszAEg7BaR47XDjSnu07LXRj7pROtmPVXLjnl0EMBCjpZI/2c/pZCAujqjpVWafjVOxvCI/+vhMwBG2otc5W9FMgIa1yPaLiX86kptcO24nm3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(122000001)(82960400001)(478600001)(4270600006)(55016003)(2906002)(6506007)(71200400001)(316002)(110136005)(33656002)(26005)(9686003)(4326008)(41300700001)(66556008)(76116006)(66476007)(66946007)(66446008)(64756008)(558084003)(7696005)(91956017)(86362001)(38100700002)(38070700005)(19618925003)(5660300002)(8936002)(186003)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oIR5PSUNS5wrWRwYuQdy8ic42dA5mMxqnIi/W9+uf1/x4AgyX+mtwJc3AhpU?=
 =?us-ascii?Q?PaxN4WYjqmGyeWTpIBWRugOgDwhmUaC0x45HogVkelR3ETTtYoLp8mWFCB58?=
 =?us-ascii?Q?PJMIRyzlTD3Q5se9bZWPyOgFUoSfdEXH37v4FqkS2ZeR1qBTUxlb8hVLZIjB?=
 =?us-ascii?Q?vkNs/6wzZUkvcwFPCIk068YlQYuC1vErx7hWrMpbKKCtAW9Ym21XIGtV0p4G?=
 =?us-ascii?Q?5Ogt+FSCmexNMBkHyTaeKApIYNoS/stIr+T/iQ8KGRJzZ9Fv+ZSbOBo29rT6?=
 =?us-ascii?Q?VnSfnbS0J2VGEsYSLAfE/p/aJtnwMLxdfqp7wBqY7dhKTahV/ijiA8SwV4VN?=
 =?us-ascii?Q?ieIByI7SfdEKGmIKrKWzu4OT15xb/YMm/uJmqvIsKMns0RxRVhM+J+RnOqAj?=
 =?us-ascii?Q?MFhuvQRLmuxSms4iA1BGhBndf5Li481aBJv9BxLSN0jOczI9Suf2P41kYq8y?=
 =?us-ascii?Q?2wUsjM2EvvoenaAKXt5jYJJimlC9+Hk3yJDvFukdr6m73+XLgJmGhbF1A3LT?=
 =?us-ascii?Q?Cpr6ccGwaMqncP4C5iw6qJSJmulaQOEikuVcs3ca2dzYWTC/QXCMLvpInkRP?=
 =?us-ascii?Q?X/9rS9d4+OUrvvdhFUCZiPir4FUAuoOK94bigQWvnrgB81vRWGYX/dnck3kn?=
 =?us-ascii?Q?QtkwqIgQJIU2DoWfUTnms3FSuPNdynf9bBMcCT9t4Z4+w275Kcw+w5/79Dvt?=
 =?us-ascii?Q?JgxqlD5TONJ0VWOQPVpvyZDOxzw/wGkU9czJHM+0E15XHLnXBUJS2INCJ0KE?=
 =?us-ascii?Q?9vtOk9dQYPQs0zyZabGiA26G6WpnsMBx7mIBmZkZ5l5YWvynX0ywcgmezmi/?=
 =?us-ascii?Q?NQ5dX2Kvavx5e159C2xwYSkAhFZ/rCaulNXY7kUp72zQewbYujJ0dS9QQu7a?=
 =?us-ascii?Q?qOxAUBG4I401LZNDzviB5gXzGVo+xLuHSkfUYqwcmdlwr+Pq0xAlo/MPmePT?=
 =?us-ascii?Q?Iwfe0uP++23iHWVFoPK2qGS/gPRmy7MNVA9M5hGO73OwVDdSMfIJ/Hj8UiQ3?=
 =?us-ascii?Q?yV0cPUu9ajD1CutCaMzYYYIoM06IGN7YgyGeGmw8toRTMzlaKX1VJhIKjzac?=
 =?us-ascii?Q?y3xvhhMBbWDtF/rx4pi+StXT+Qxt6hcvpOd9B2heGgnHb2BNC2yqbNoeBbiP?=
 =?us-ascii?Q?+O+p5ATiQ9iqWgkYhsJopGta2TahS3YpL0gkHi5hPfLLo8uSclfwalN0lzSH?=
 =?us-ascii?Q?be0SprQDgIQBQm5qGsHMcA25bCrogAHKGqBoOvPU79uTLQrDMAWwIB/xGnJj?=
 =?us-ascii?Q?GmDsmmW5eNduBBmlgQbciR6KSu2iJ9I28f3yI2EimNVPyiJ2eIBbWWQomU3f?=
 =?us-ascii?Q?IuQvRb+4HD9Stfoh7HCZjB0YMw0nf31ZX00NnLlXri7kW7Fs/MZP+sYsKksi?=
 =?us-ascii?Q?ZbU/flb+MS35HefRd9lK3/n72Wv5ddjFLejaiWQAqgXiBe0fXO/gkP9O8FvP?=
 =?us-ascii?Q?FzUJtG6Yf2dm7wrjK/dfgE7oydp/EgqEezZ5rZA1n5PH5ScoMQBuqOwt2xZH?=
 =?us-ascii?Q?kKi/tbOGUz91H+Vfx3JrBpYc9T+Rq+XyAd0SsPQCbtbUNs+L7J20pLDnPG1J?=
 =?us-ascii?Q?CzLVzf4wJPDBJ4N0W8fOSVzufC0Qva6pwINBwE9ZNJFGrm2OIn7dwewl9Qn4?=
 =?us-ascii?Q?D70CME8WPxOh6n1OxMl5/oylA86JPhOHqx4zELHTFVNLdg+2Hmekxa/DzVaL?=
 =?us-ascii?Q?vFr9qIASMhvAlTnd0FkL8ozEpUcPy+Fv0upVRqmV6PCJ0GoPinqJqTnV8mfN?=
 =?us-ascii?Q?0g+26LzybfahKEtGbmBEz+bBIupB5b13SNql5DjpQsJzUiIRlb7R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5119dfa-8a20-46bf-9a00-08da54f31137
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 08:33:36.8833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b2Sw1iJJRDQWzNd7DnSSuQ4fddgjSJVNXHRnK5+ZuRkqoPQ3zOWkSGwbKFhMlVYQ71s+2CpwtyKtQ/wJtZKr9MMOkt/mwvXR6a5AL4zojCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4375
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
