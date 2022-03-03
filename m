Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292C04CBC7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Mar 2022 12:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiCCLZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 06:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCCLZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 06:25:35 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D0E148924
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 03:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646306690; x=1677842690;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=eY0sP8ki7GlJRIkdmqwSkXPjsmKoYcu7V3CSf2vLIUyB3wFJ4ToeSVwt
   nAMH+xQQmjpLpeVbeGQskO8lZKKT1vB1hPDFoYe8nAD1VJOIHKvwA0qQ1
   BGeIJYubVlxfCfTY7QteE7I61b3k47xDnLEhGXm/PhxUpHzTzoGh3tylE
   Ac20B5HKTFfl695p1cF7vISM5uUmznZ3qufQUy2mRKdH1e0WBFh+3S2Qn
   cikohRa04i8w3//eZ9LrqVUWszhDlSslAtQb2pCWWZqSIoJ4i70OXijff
   fg498DPY/skOMjELFIaxAhtd1Mi0rPnciksLTiXMZJ9YlYW1JG3CAly5t
   A==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="193309079"
Received: from mail-bn1nam07lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 19:24:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeywiiHWm4LQxitPtFTKij2YRx27JS61C50Z61HaKjt5sEKFJqpg1mUfY0mxkjMVrO04RwuSV6VFFy7W9SZW056xLMZrLpa3/wgOtF9RUP2/UqBqM8Vt4anol4BmgDJ5l+I3uhci5bdivvEd8G8Le+Sxhb/olMQl3KXdWiyXNQAnljYoVnT7Ag+ItUokYVqt7VyVwIpBLu0ySWXPh8Fmd/PM5YLU7WpVNzBPccldh89J25/mqi3fZ2bnDcWOAJrdwd8ULR38f+rDOH3zkkX6Jo/tM9WP638MH4x0IEpvSGRad055GRhOuMaABs+aYWyzgvPv1527Ez95O85Aqc8cCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QsH7IIrPLa2zyBA2X3X0QapnwaL6bOmwY0OML/zMv4WXzojp3kEMRaUWzMpT15tTuMyiM8EsVnOtjpF2LTzz4cQpcG3sp+GFIhP2pSgs85yJrhOiJYBQ+f8OWwmyd+6nYYRTAjCQfh3oQ/mPDjv1Awh7UTADBgOQ54eYAtMOtSTqze6CmRO7VA4BtgisNwGcET+QOOAwhKqOaCkbGKFXHM+TZoK8vpkip8GtDGPWgnTM0+7rQKUaMYBdQ6G00C3GWj/xeMbg+DCqguMmE6v/cBlMWQ37XDWliK0Bt8CNZVqDq+wut6xt/91nXWa/sWVr26FV2jjhizBB+EGZpLRkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ce2ZFKyiYHGuphn5+5w50/LHBcMXk4fcs7ACI5cDfKECnakdoEtolnSYSrWRCrzNTjwz6nwxVOhAxzKo1nIe3WB2P/bUtIvJa22iu31M4oGp8nAgA1JDZUwI119PccdLBi1uxwWH9j2cMaaUoR68cdDbK7gh5O7/VXw+5PeZQ5U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6362.namprd04.prod.outlook.com (2603:10b6:5:1e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 11:24:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 11:24:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Niels Dossche <dossche.niels@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs: add lockdep_assert_held to
 need_preemptive_reclaim
Thread-Topic: [PATCH v2] btrfs: add lockdep_assert_held to
 need_preemptive_reclaim
Thread-Index: AQHYLpcdt7bZyLR8Fk6ZIS2IZ4YjZg==
Date:   Thu, 3 Mar 2022 11:24:47 +0000
Message-ID: <PH0PR04MB7416EC74D84C6380B5A1407B9B049@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220303003838.7328-1-dossche.niels@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 906ef8a0-90ee-4e57-71bd-08d9fd086cc3
x-ms-traffictypediagnostic: DM6PR04MB6362:EE_
x-microsoft-antispam-prvs: <DM6PR04MB63628B0D33A049DCAAE7F7D29B049@DM6PR04MB6362.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c90FnE1edqybXD3UIBRnQnbMcyo7Gbg5gMMwcxGyTdqQq3r10876OKYkzU6FKxy1AefAQ4qDRlLi5lGI/w5Z3iItwJoWCMHNWp5B85cc4sY6C5PZSXyKbS2VFTFrBFa4q/0Z1VFaWCNC1aA6yb9q9irLKPPtEi37P7q42aI+eJ1VArxWIOlFOIElUANHhveg8CrjF2sAeo6kwsqrUQyf8ONc03clmob9dO3hWdwmNyb800q03V7lL49VdcxocHfhnePE7pVFewfHgifN14ISpZFF6QwhtC2Iq8oJhatarJQA5Tjl/g/31iRJyn6vGZJ7aFHwZd8U8KmmzOttcuIxDsbXyqR/gZ/prsrpRvSJ3yXybDCJuqaSO+8hUyp/NQrPbGxeJUbCLGojMMa0iz16sOOq0ZUqBCvfL9HUdrWvOymYfT3sbYww9zXMjjiih8sCEd6ltLhUN6r/pfQTz+t8ARAOFGtZ+klgqQXkjtvCEfVr3/DcyrlM1dO+2famdtOuVa76V8t++XJ4W/8R/iNgshf1W97S0h7Z8Er1fjwAwn2TiDH9kukDfQnnhywXBApg0bK1bytI9RYrGVd9q6EFV1Qi/Uey3qQj+ADyp1+GBUXq+5uL/Q9O7omgWtTwwJpjbIE/17aH7d19aASLXF9hhLc74IwqqbKpIfxRhuzgKmEs/5XhlGZ2A4G5r1IJxp8Vx1R5tvkxcH5O4clIFhQr8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(55016003)(9686003)(5660300002)(82960400001)(2906002)(4270600006)(52536014)(8936002)(508600001)(54906003)(110136005)(91956017)(6506007)(33656002)(86362001)(71200400001)(186003)(19618925003)(38100700002)(38070700005)(66476007)(558084003)(316002)(76116006)(7696005)(66446008)(4326008)(64756008)(66556008)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?10/vWXPc04W8wc3GRVSwmNZC1A8RxcRVCHhTDUjRq4l5Wn1AtgBIh9jUdbcg?=
 =?us-ascii?Q?3ZFipoXtOb6cw+Y0nsxNVaVjgAQGLIz7tYt7K2wpn+ToukcZih8tBIRAxtUH?=
 =?us-ascii?Q?Mhdldevi18GfwLXewXRmzFlSM2Lqx+oqyLuQ87lIaE5KHuwqGUs0rwjUReLe?=
 =?us-ascii?Q?EYtgR5QQW55ZkvpdvcC4cMILH8vQqQ2Xh9ZmWKl25ZRWWd1x5QRIBY2dojxT?=
 =?us-ascii?Q?HGYGq1z2BZ8NxDK/FCzeNxRMaMtlV1gVaJcolsGA7BZ1qY1Z8fmCeMNz2M0s?=
 =?us-ascii?Q?0DstwNVFu1MLJCYF2iXoY71YcKQ+GWPy9H3V6tmGcsccrN5uc4MYbq5hM53e?=
 =?us-ascii?Q?nRGWN84msWo1Dz6by/41Uj9SubuO7dZ6/Lexy6AxLGxb6oQd9q7KT0duDpgD?=
 =?us-ascii?Q?15mz2aGTwWLQ5wRbpfgK5AsB6vylrvrdMH8MW8/5VLZrsnKY7FSBpE/FusYC?=
 =?us-ascii?Q?EEY7iMS8+B9QVn3+qV4CLGwNrvDr8UvCirN9/PRb+YaVBlRWiTfoM4gWINGg?=
 =?us-ascii?Q?jiN0TXZchJRGyY412kSvHDicI2QDlNgkzoLzfaKpAkhTHq5vTC07Ea5dzl2c?=
 =?us-ascii?Q?6VVjekRFV9oEeA0NW+Jpz9yJrnxH13XwdazhQVftL3W9HqkiON3Cjdtkts5Y?=
 =?us-ascii?Q?L/FUot6vI7PZ/rXNNU1PR8M+qTiUFfOuw8in+/aiXmtbqgmUVS8d/TbEYro9?=
 =?us-ascii?Q?7uIu2khF7MLEIwAQY2J+ZRBDepBZ5ziGJZP48hwJB12JF1ZNyY0sULS4RlBm?=
 =?us-ascii?Q?fgfppORbZ4qYK+d0SkzzATF3z2C5DOjyuIPH4UX+spvXv25NOso15r5QI342?=
 =?us-ascii?Q?6fySi+OvR2EIrh53Q32lppmOklTsQsPzarub2ydnCmW6AaFKW5xUZyHih3Sz?=
 =?us-ascii?Q?sxii5vAEROzoVTRIyP8z8HZSN6usJ6UPi15ZBvdA/tpopVecH2fIIvgW09q/?=
 =?us-ascii?Q?N4OaRCx0iXeYE/LyOSLprn+HJf51/MJ9ghPHNsBacPgiNSv+x0XsyvWVnXWu?=
 =?us-ascii?Q?wgpPbbO3IQfRnUTyen4At17oMqfD80ZLyvT0S4zuyrBPJ64vBDvdFgbQx3Qc?=
 =?us-ascii?Q?Vw+h+2+28WFO9hgk2n3eaS1WVlMKJgCH5Qyt4C2BssucBJgfttqcZFJ/BuP8?=
 =?us-ascii?Q?u2SEimUK4ldpQqdD5/6K+8WGGS5/m/+r+zI18lL7Ubr9yUzevg+VhaXsDQWl?=
 =?us-ascii?Q?HwXcjXq7WiVw1FLweyuLtpHe2BZg6atNLARrt8e7ljYn/4V04e8sEPW3r8y+?=
 =?us-ascii?Q?tRG5G+pxsg52APyUXPNBe/bnRQ8P7EC7VPZ5UK0cAxswsBoVklz7chSCm5N1?=
 =?us-ascii?Q?CqZTqd7zfIflfAX47sW58Vwl5COGaQJdZuHfMzw2vHJ+2nLajl5S7IHnDuRC?=
 =?us-ascii?Q?l4ZdKFhs2qlB8t+53KtJ7CnirGlLz7E96CNLqh4krrZYkZcMeQRrKhkTKBEd?=
 =?us-ascii?Q?TN6yyEC3mBjXsUHI+jLh9/ODk+VtXqZ4gqx9RPRGsM98PZA2xUnpZc/d671b?=
 =?us-ascii?Q?Tz9zyN00Zk+ZigBaL6CeD8cYtvn8dc59gSNbgmiJuGRbt8g7AIltlzr+5Cup?=
 =?us-ascii?Q?KcLqXgpgzbA7QiGzoDJwwHDFlHTUqDc+Xy+cer54zFtyC9PXaQkkX+IE8ljF?=
 =?us-ascii?Q?kMV6cBJhdVLC/CyBH3rVUp7rnEAIWpmnI4QQIqH36C/igyfHLqqvy/1cUp9Q?=
 =?us-ascii?Q?pxFbELoSq+bRmRvYd3sWrdK4DASD2GEC+E4vzQVLkKR6NasiKPZ+pXiJZCiw?=
 =?us-ascii?Q?+WaOCUhMWeOHTNG9N9XJp+VPXmO8a5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ef8a0-90ee-4e57-71bd-08d9fd086cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 11:24:47.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PstRl9A9eDsnaIU2HePg90MA25ZbBWZPmK+JVntVVTfXbZ8F79JJHOj+UFGBYDYkR9r/rQ8rh+CEoNOrc0GoKVQaMxhJ9UCeplUQzCJHUa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6362
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
