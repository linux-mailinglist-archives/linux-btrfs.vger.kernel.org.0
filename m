Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502855B5B37
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 15:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiILN3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiILN3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 09:29:53 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5411175
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662989391; x=1694525391;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=oWw1Jvy8VuXDDjM7vQ/8siXTWidX3cL3SXaBcXmoQSdwOBc6wba1Sm1q
   T3GfhCG1xaMcTB+LDc13tHxwkd/oUpo3YqTS8VENBQMuX9GagMHbf1abJ
   2mYK8uqYMgIOxF7NltMyYMYCasT1fou4l70b2dMRxg9bHI+4kWVJhgh7r
   rkcsZJLbrGLxflTIeJJ3T4tEo7cIytJeqgwQEc+YGce69xaNn9DaUsZR6
   2qn+akjb7ATlmlAH3KJRo/KKzpIoLVio1IUSse7B6SRKPeXsv9Rf/EpwZ
   QIney2YL833wvwzJHfC7+rw5m/zKCHQmMFH0cf+tsRnRQe5/kAyF4MKgO
   g==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315409626"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 21:29:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLsjvX7AbL6RylMyn4iGzz9rAaQsBIZ8i8JNIFZ3rrKoqqx7Jzn6W/4GmR1fcfpNFc018w2teUY7HaafJ8GVtNqJ5k7BLajmImZQwTGn8FfMtYVUmf/CsNiOrwONrOBMpeFfvDGz7hSvHXidyIDY7ajYDbQplvm3j9zJZHoydVVnXFF3HhFHgz1LpYioD8icEfKtJO02NyclhCqdBl1FlHSGdaT8Wnn44OjHzUITpvPe1ni+dVBo4LPPZ2dmlVj6jkXnWffTYCLzQBgMJoJY36Qf0D/c4nw97Nu7dbl1nccapcdE0sPRK4L+lBfmAWr1YNhR8hbQsu4B0DzU2yHQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GjEkwkUvdPS/HtJ64T26cbPeucTZCRxQRHWZwhp1khG5a/LEef8R/ymVUd4pI+j2Zg9gRlFCJnixS56TATn5SejmLm/sB7lfd4SakGIU5NSVN3EM27NCbjL3LRXLDkj80yG88Xb/r2WcwmNb9yl0Uq+m1ERDwtKI+wZR5rtvmvJ7KChcI/aaika8aXzhUEzwTRFELfAarcqE9pd7VY+bGNXC9UmXLz8EfCLtQMNe6DZiaDKvWWIsJhgsXb2ROFOcFNNce8VdC3l7V3HPoPqtlFzPbh9gUHcQmG/XXZbeA5Nxvj3n9Si10+F045hxh92lU4w5YLCOjiv2zo1S1Oe3gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BiwDkBlSy6v2X3R6/++VSqoqT2kK5pmWsInTQ8ydHzzp+aItyyLpBiOcjIrW1CG5iE6hP+8k/WuL3cxWi8kN7/IJob46N7fNkhH84nyBIB2FsU4t8xM0Z98USo/OnIQZ04iu95yr/9BAzK/IDMvET7STbOtkOpsrqkleHFgcmos=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 13:29:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 13:29:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Thread-Topic: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Thread-Index: AQHYxJbetYXM63yf3keSNLFD1QkoHw==
Date:   Mon, 12 Sep 2022 13:29:48 +0000
Message-ID: <PH0PR04MB741671C745D1AB22BFC068769B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0567:EE_
x-ms-office365-filtering-correlation-id: 2994e2e6-f76b-4e8e-6af1-08da94c2dd69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Y6ljZNK1b+jgNIQt3ALGR7WVRWAA6/LULMGdde3NrdEC7oD5erCjPrgIToqBN3ob+eN47bm5dFagy95oHakqJn8FCrdJfC5cSZoIwsx3dx82YDk6bBCO8BPBdZ77z7bNbw/hgELn/345/NeA6xHmANVwaD/u/li1CCCkN44Di7d9m5bfhLBVc4n7mdYqoCRLdGig/MNUvC/4ZzIt+omqxaTKHOHs8VkZW0PvHnA1MNz0rAZoVGugQmataA4icJwFftEhoIfaEnQCoiMI+yfrsV0i+4a5TwmAdWokHyAZq8CSx9aKFmxDduyl478L8i70qq22e3kQUDuiQ43lnca0of53YaVVpWV5fxorRZu6a5hu3uaBtp03soZDoXiVpRfWPJm0ZmRVxQTS9RorGlD21/IH6x7ThKXnepXU6Nidg+2W44AxbtkOByxxBXtHq61e1dIQISydoRpnpt/GPqsg3tH1R2109NGU61dBxj0ZwPMrbPY2WaruoLCqM6pjpnz9QhICLWwhdzaDbEYfEtVBFXXSGsF6dzxXLTJmHbuV6at6mrgz4JaIEuBFCzhi+CDF9bUoynD+y38ROhna2Cm6g7IyeJNeiM4xoORYXG/KlylAwkc6zfj92YO/3diIum8AYxwOKS5tGZbez1E+h8jK/euoRTZB8wNoX02pC3icIGiAkm0BtoovLMWlsYWVUpeRDIdQNQF++3whlxS7EZa7CJuub0dAVd+MwYX1fJIzadwHLFGSyw2EyRPcOgCyiut/L0n5Z9qvB9dpEpeuAo1Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66946007)(64756008)(76116006)(66446008)(5660300002)(66476007)(52536014)(8936002)(41300700001)(8676002)(91956017)(66556008)(19618925003)(478600001)(9686003)(2906002)(4270600006)(186003)(110136005)(71200400001)(316002)(55016003)(33656002)(38070700005)(558084003)(122000001)(6506007)(7696005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3fomlHptaBmJ1KETVFPcfJsB8RK0/ezpjf+rIIE8uLqYzpCoZzq2d3+OeXH?=
 =?us-ascii?Q?Q1OfpUaWMCOTvHYfDFn6BtP8W+ITUZSLhw31aPm9fGhD7brXzUj20f8GWDAj?=
 =?us-ascii?Q?Gtf6t1nnUyUOuY+pevWELGr93CIW8JPE/jylmdCHD8BNnTdoqkX00Xh9x/2F?=
 =?us-ascii?Q?1kALQktDgQ/yQVTwwD8wT/F1fV3dZz/UHcF2NqFAdY0Ar1oxw5eRDqJAIBYn?=
 =?us-ascii?Q?0gIWingXJ6BPOa6epxID4JupR/xBjJfVS8LV952ZSkNnTq9O06oy0gKwep8H?=
 =?us-ascii?Q?CxlF2X08DlZXX4B8/Mloi/f7bPkMdITKp243AHs/9Huo1fwY/ocK2YXiI9Ye?=
 =?us-ascii?Q?YxhEjNO7DME2Aw3wD92UDr1jRGBNvjbM/qrsyKkGMgRxfQATozSyWOFqrQsr?=
 =?us-ascii?Q?Gbt5wWFGMb+DntNov9yzx74MfP8voo2nTKmBtd1opcyWdPSaUDZrG5MNXVBs?=
 =?us-ascii?Q?+eAgOzcshGsnc7xx0Yz0fAcfZDLd/SAJaW+tb7BwWqhazLMFlCToqFAiO1m4?=
 =?us-ascii?Q?L2/tdie2EaxRN8//flPVdyMk46Y1XVLqP170zeo6LvHfgFFP7IL5ywBNGUnB?=
 =?us-ascii?Q?rKpPTEUaUID4PBmocFDlkfC4Rwz6K6TeZ98Hj8oqIHpMvb9lV+BTbgFsqE8B?=
 =?us-ascii?Q?rqHoQKuhT+D+00Nj3c2GeFU7DWVv4eXDGvZHr5DPiNpUFnkuLjY508k1qzQt?=
 =?us-ascii?Q?f78UQKmNY8/kvQXWnG59zSxFKNuzcPH/fmZEs/kM5EeLN1AJNM6K8tO3FYhV?=
 =?us-ascii?Q?L7QeLYaQnws+5H8KDJ+4BzzkmS2SdUZPFVF/r2OqwB4GKzexFfO933zwwGgs?=
 =?us-ascii?Q?39NgVu3O6qndMtydrUovnmdl8PRn+JtjmT1dOw+GE+TbBL2zXTeGIZerGBuc?=
 =?us-ascii?Q?lADaQ+jWveIUa2t2Mb7nn5wDB3wWk0Pbv3Cnf1RfhD0WQIkG528NWTgrpzw8?=
 =?us-ascii?Q?yQdA/Or50KZYxTn7WhgOMCAgNtcDhw2A5whpsUDayff9ABJKALA/QOhQn5Vi?=
 =?us-ascii?Q?NYC7x1izAGvRWJhQNusTAkxwGvEXfBj0wQ3AXh0SxY2wLT9t2B95mR0m6X1a?=
 =?us-ascii?Q?YnQexlxO6mgnB6bbuigu+Cxg8bo7WnL2P868KBFo39FoZujdzGFvN1FEZdmY?=
 =?us-ascii?Q?a3Rk2BWK6ifR5pNFsj5qg0RGb183RKr+zXEO6wd3rFV1Vr9WfA6m9CpRAo2E?=
 =?us-ascii?Q?QawJshr5pEVaRWgZZ5mnFcpHhcvgq3VgFeuSEct/H9nb5C2ZbqyZfYM4cb0I?=
 =?us-ascii?Q?fl/vvqRx1+qjN020moSBtvsVpoTJ9o9O5qWM8hmyyn5v63iOD6Wm8dRjU3lO?=
 =?us-ascii?Q?djmhoYKDHnAv7YWumyI99nen0QXoJ4jz+Km8UlhNeA4EcKtqI+YiF/W23uYt?=
 =?us-ascii?Q?ViR2FS+uubWGMOicmCFD8zlt6so8Pd/RUAlxAjKEmSH26H3Yy3pEiTPwveYJ?=
 =?us-ascii?Q?zuAhHyW07G2twM/XFGkeNXDHs0WKrjQMHlr+3OSUcnW0sVWSlRW0laIb7hxF?=
 =?us-ascii?Q?LaM8EFlilHAZSKsIU6xeAIdpbNyQKYgUTWcwTNpe2cuXrfS0ZGSRs8GWpmI8?=
 =?us-ascii?Q?UkXE4TygQNUt7reREz5oEl7/OgzWG8E5HJssuAKiXCU0mEes4cAm93h+G0Sz?=
 =?us-ascii?Q?Nma0jd+KrnoQ8TqVDhk1CQ0qlMPAlIFvTJ03lxQ5v8sG8riwTEOAJudIuFf3?=
 =?us-ascii?Q?1UQ/4u68GUnZoVUQD6rj+w9lZXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2994e2e6-f76b-4e8e-6af1-08da94c2dd69
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 13:29:48.5117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r43sLBm8uGjjlBZZq3uAiCOBpCw0MGrOiD0YNlBN5YGExo635/G3iOrGv/kClMvme/UV2Ybu7qvLPQeNvhIm0Lq7lvT0jf1OMsXm53wm+Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
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
