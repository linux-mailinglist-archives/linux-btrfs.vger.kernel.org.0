Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660A51A4E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353093AbiEDQGi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 12:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353056AbiEDQGY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 12:06:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54215A09
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651680168; x=1683216168;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=znlb3TP8/1KoMf6bqtKfTsSpKpe9Fzm2Ydh4MU+6+JY=;
  b=PoFG+YVUtCdI6pazEp3W+V12m0Ez62BRoSoYMM2fGjOyfOqHu7WHxO1G
   6ANOupFGEn3XPAxJkAYXcKdWX986n5TJgYp00kDoHPRDp2TjosQuW4IsR
   Ce+v7Et0x7ee0dcTVvKTNm5CpAgstseXqByhsaVa/8pezlMQDqodJmIxV
   q+Et6x3yOia2DbRgno+mYgrztutahQnLgTgbZ77My80Qb7ktLvsEiSksp
   7GQNbkzRQwCvQYVpePzQ/+E1nC3iBM0l8ewuTX4Pz3P9j56gggvxstF1t
   LrvCT9T9k1Q8vuNE6oZVVLO3AhkDY2eKWdBBwSfMfh04z9wL5vLDyYkFT
   A==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647273600"; 
   d="scan'208";a="200396110"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2022 00:02:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7lCygirwAPA4+7Cmh9FcMGPXOI7OBN0QetU/NuNs+eBos5Zz2BZpCOLTEPIfnlBfi5/20COi24ETXPzXMU6TevkCnb8pgQlRb2f7+3IRstCHNcAXBjlwgvn/bPDXdxx0YqF40jgD0nT8ea9bmC/1tQhSJ8sh0l+ua+wCiwGFHa0mDzz/Pi3UUbMe+Slh8cuMSchfjfj57uAsAuFqRjfp/VkyO22oiQSSWXa8mUv+faThVm57LKkc9Onky7QpyFf6qCRpxqMMrAoO3pwuorlllsup4oxRO1vJHtylqxEKeAOaumyA2HONKBSY1d8y6bwsfepPWWft2HBZDqXHWJAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znlb3TP8/1KoMf6bqtKfTsSpKpe9Fzm2Ydh4MU+6+JY=;
 b=mQTxOvBvLXiML8gVrF3/N5QSak8anYkH0BUO7B2TuFsXkSc90C5RREGr6viU6bA+ZEXLkT287Iv4QJNpUp1hLr/424cexKkG+oehZjqL6nwHRdQiZm/twZIEqPLsamDwTlRMaHCUdNEEmlgCJkBub7hZS1zZjZRaouCCt4ntHcssn827dP1YDCa7u4tg8IkPMGt6P7V8veuzL2jCzDgxMB9i+9DEPboroW1bheZAlDyGblx1/e2WWm9UmuuCeCCoKZ8ClEzrSuOjR/3KR7FeJdw2TA6bhjil+s8KnTmz4B6TBoj1J9cre2e8AF3M9Bq0a+sxn9Vq67sY1OQDMLaRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znlb3TP8/1KoMf6bqtKfTsSpKpe9Fzm2Ydh4MU+6+JY=;
 b=DfTI+zWJOgnUXNGZ7WY5toE4O0gS1onYqorvMRdf7XYcN08Ja9a49HpNrEpA/19WZPqUTCWVzpDVgnTQLyetXYWaHSvaIfbsKLlmRAuZAPwknnt3Go9wIGGdI63W2xoD7fChPGvC/GII/ioYAifNhlnw6nWLEGFFbzVV+8v7G3Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5788.namprd04.prod.outlook.com (2603:10b6:5:169::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 16:02:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.027; Wed, 4 May 2022
 16:02:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] btrfs: zoned: fixes for zone finishing
Thread-Topic: [PATCH v2 0/5] btrfs: zoned: fixes for zone finishing
Thread-Index: AQHYX1DgFGp6NpuiP0iBQsNcgCkpQA==
Date:   Wed, 4 May 2022 16:02:41 +0000
Message-ID: <PH0PR04MB74166A826E44B0B273BBD0DD9BC39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651624820.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7c7e87-9293-471a-b292-08da2de78519
x-ms-traffictypediagnostic: DM6PR04MB5788:EE_
x-microsoft-antispam-prvs: <DM6PR04MB578869CDA03787380A16E1599BC39@DM6PR04MB5788.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6XXN6B+BHGV/kLkjPe8+7mw8zXNrW3biyrcnhbJty7rrBsZmkc9rIiecjn5FSCf48I7PZjFiiojnN2hW9vcN3s0ZPDTZCap4zf0/IXXxF3IyXEptWYx43iP6FTKB+XC2i9mYS17rBSYxFjIbQwfX9cb7MJHKaiS0wWsT+nzYNm3OAHnlBSw/rcoufMDNBuPFnd6izBGs5PHeOWgZxxuFh53OPbP2WIqaiar9GIjxrHv9xa53KJ4wKBCiWhzepY2oCfLD7WHgV0UTpC7Fg/Xrj2iz9R37Tbc9uNW+Fi89qxssNm5jGGh3/in22SGaNqB4R9eP6sU8M+kYoMK2Agr5V+6oun7MSxCS5SwWwjl/vxpstMO5hr2XasCGNyTOkD1r1KeJaMEhtxRKvt4DdFqNc0bOWR5FcouMl2M+XqLb4LpO0x4mYAtaVx7p5n9XQWBgG6fEIV+QVx2FcYPRnk8Cbrrj5ONi0xDylaEJfSPGXtHnRiSfoy/UGb2bW0G/jziUIKA6Y346SFNijv3J9XSYbyO8XPFIpy/35PhpiPG9481AM/t4F8NhBDJy+xjjTojSGB4kNqrTDJ55hrf5jQjxrMWj3A/agOIM54uiCjlE0ZSlr4zVAJwEuMpcPAOY/JnoAs/o+G9xGMBgOIH5TWgXoMwcI4uWHBYyV6YE+DR91A4e4KTujImjvzFnn/SVfAM7EH4wuSkpMQcyNamhZtVm4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(38100700002)(38070700005)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(8676002)(316002)(558084003)(110136005)(55016003)(86362001)(2906002)(52536014)(5660300002)(8936002)(122000001)(71200400001)(26005)(7696005)(6506007)(33656002)(9686003)(186003)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iE1Q/3rXDk97wIUXlx7oiibjFHhoarS3DRPAhRiV33LCOn3hShYw8ghGRSeX?=
 =?us-ascii?Q?ZiAUTgTumwe2xuFSCWaUOORJ+wTBEMvyIUP7YNt0oxMbmvZCEnLTf92HJu0j?=
 =?us-ascii?Q?/YOe7s8+ikNVEzng7Wxf3H5btmRn55e8pdjV59BYVBeeMy0GLGn/Y4g1dGN7?=
 =?us-ascii?Q?Qqf1RfUg02ZZ9vTsJV0SuvbACccPCAFU7G3CHxCHRKxxhaY5LOcVL1VjNd3+?=
 =?us-ascii?Q?z1ZjS4BiFte3fxrn/j5TVFqv4uYNVyfjy6rF/RaY/xieO9UJtorqoPTahV5z?=
 =?us-ascii?Q?ILgEOUDY4e37z+PdGRuxARrpq1/56ycF6qUD9/hEDxMInTB7DOe3cXwJ18b3?=
 =?us-ascii?Q?kIvy9OTs1lVtRuVOHLg2n15J5RnX5Jg5NoC2o26YUUujFQHuSiCqpsyLLESE?=
 =?us-ascii?Q?M7F4NZhxiNPMPEqvv3Py5blfPPQn0DIvuPW6LDsk7lsPVcjUJX7gB3PgVk1b?=
 =?us-ascii?Q?keCzFySEG0kXq0er7HiupEOzEHYfkt99n7t5uV3Ozr7NrZE+W51/4Yi3eArN?=
 =?us-ascii?Q?vwnjkDRYBmlq5TJ6MoPJJ1fiR++/p0bbomjqpOz6WdpG7Jk651ZNnX1eQeHm?=
 =?us-ascii?Q?HU0Y10DYH2MFuJEr9ugrFcQg2eVT8FSZ8QAbc5SWNXX7r8a7i5QiqtqE5SHf?=
 =?us-ascii?Q?kRbTf5hZljkFLKE/WWBpstPvWp9nDE8L5XJreVNodXKYt7X/68jOWHJ/M4L9?=
 =?us-ascii?Q?OdN8TY7xR8vCj326q0uvzBpiRhoKGDfz859X+5zcswMlYkccWNnskTlqys+Z?=
 =?us-ascii?Q?bI9gzUWEsxc1tMqsDRCIPx09WoIBzBEncgl5uNe3KFDQIUEZa4BXOEi45nYB?=
 =?us-ascii?Q?qto3ULNi4T46opf/q5PWHj7AKS1NEaWKzeaFPBORvb1RGvXP7NZN7NjC7Act?=
 =?us-ascii?Q?eiRdaSQnMKnYBTXCu5iMydnrbjxSCw0y1PTtJ9E4juI5U0fN640BqF7gNc1S?=
 =?us-ascii?Q?ozjHnnxMqqXOlwpZOM0AQhzvFAktngux4Jj6jwIl4FRYB+8P0Xg9xXb2VOuF?=
 =?us-ascii?Q?WxHjxJ58o18BWMnK1WQ9fFZhZmpSpzU1fUPc2u5obIzGKOvJKq25gkaVnFGD?=
 =?us-ascii?Q?71/m5Af6+yg2nGBizUnPbzgvnWZMGtlPbiiRm1dnSBhW/M800+kZyQ43Hn4Z?=
 =?us-ascii?Q?3VaL5x+2XekR9DJhKnJ653zYtYHDUkXs3I1a1oAH84Ijue3p3/lxuoij+sZI?=
 =?us-ascii?Q?gDvRx9wJM+8JaBiyihpcg+e3S2Ki98AaFPFEISbnrPTXOZ9s7UEFvSlfAIW5?=
 =?us-ascii?Q?/vR+9YkhlL1NHn5l6JYHu+rYL2BVR3T4+dbICTsYB61ybycIls3mNdUuUNWS?=
 =?us-ascii?Q?wVhT8/Wp+PPlJTvIy8G04HZJDOBzxhJ5V1zmOUCxsboDuoGusmkvfxNFU/a3?=
 =?us-ascii?Q?EYL7+CPuFYR73flbvLVTuKeHjrOAJpZQam+Wq/qROtwm8TRKWkGvNUL9xDeK?=
 =?us-ascii?Q?4CFtApqOQz4FYflKAO9zznaY5Iy/v4svH5vYH/n6CWBygbMk6ktVoqoLWNrK?=
 =?us-ascii?Q?NC9J6YX5bcnMMkS6I9ZiyQ4WIYsY5xsBtVNkcBvk2XRQi1p4oSh9S6hGyP6H?=
 =?us-ascii?Q?IS4YgaoG9fRO68XXsw8kK1wtg14EFfDs+3Vjy88o00hi8vXBRct7PDe9RtiQ?=
 =?us-ascii?Q?prX9nIS5sjfKTkeSd2+31c6XMpK8QHZJqS0P69fmRrMbPHHSNmfJByjymGik?=
 =?us-ascii?Q?qaCgWin8Kl8ZgLl8me97hslqXAbppV3QViS9rb2X92FyVXAUSDDCkzP9Q2+8?=
 =?us-ascii?Q?OL4JdBzoyMcjVEL7E/eP32tabnKlYVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7c7e87-9293-471a-b292-08da2de78519
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 16:02:41.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjfC/5wDw3BbVVJEdDB5UXzusF033rLMWKwwwUmryUI9pMlLlVkwccsX3nosj/nff4IgW5U2xfqxnFxM/9O8HLUBENVNKxQr/n3VGBnNCFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5788
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Apart from the one small comment on path 2,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
