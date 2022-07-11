Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1456D4E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGKGp0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 02:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKGpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 02:45:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D718B30;
        Sun, 10 Jul 2022 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657521924; x=1689057924;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rmhwePrXuKL+JMXiNI5WyGf8bcgrSkzzLUlAufRMfEWMe75q6GIUpqHY
   7os9uNzGXAKpvcyMkcewhs9Ijt92ItH6xsUU0KlsZ1RKdh7m9FcfcPj9i
   zYYCuLAL0NLL8oKmLKzl3aGhp7Um5n9Xct7VpcZiNGOLkswGWNpJrYLE8
   fKK8gPFeMyRNAqUfq6qgAFYbmUYZVKfvE9DXnH3Rs0OvZ8y1RDdEXv/qo
   wDCEUiepM0xZ4t9QYRk2Bmhb7Xm2juBQkG3ROKHDRwaSKI7rbwBdZD8xY
   YNGIdAY124AgrOuO6tBcnWEPEdbtKYfeTCuIYkrMTybazlankCq2CFppk
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650902400"; 
   d="scan'208";a="203982665"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2022 14:45:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK/k5IgobSSoe8zhLYEUmJBoYNlwfTVyyugXBxuLclQYIN9gI3l1TZdRUSMVXiTaeU0j7XJV1qMObCCiNOi7qwuapm6cQc/04hnsW6StaW1K5oyWMZoRY2MzhUM0vGd80MG7UiqqRjBw26Gbc3mU1boADd+rCWbTXyovvQILOMjyLoiemSQkJ5NLBIo1h/rspUgvpJ9q2eFpP1NZ/JdXOeoAXh2o2+/HZsv0vygLug2J4lpwbf2DlKrva1jztg9T1pqirj0MRLMQPdL9GIKdaSS1PuTfGfs4LbeSJpD+Re6kmOhmLtX3o3NVkjFWhvay3/o7qLS+MYV+6WqKZO8f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IE+Vj41C/smouK99tsvPeXMb+Da1Ukv1JwIfeVGlGfNqDoYymY0lf2PBHh1C+EqYjWm9b0/YiSIY/1PpUc4QHK/FIfZTEwEHxJ+r4rO05JciCSnawXV7MWMLJ2PAOD62W5mSU85Kb/+Oe1fYsmkcZ/scf8NPBtFfcl10asjWovbQVDtW0SoKA4w3almeo9Y6kunNjJfRVa8BP4Dwg0Bhdug1JquN7ull4Lf//ElEpQvD8fbvZIfy15tbDh+a4rZ5q6yySQH8C565jKjZux9908qxxanGd69rt8MVLh8KwlOT1ykCns3hlU4fMPjTcswOrTIufEDPHDE3qZiSxjn5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Z24t0LQT+4xe93X+ND9TJxP1kHbnxqR0ZcVs5lxgUYHJ8Z6RJ6nBG0cK73Sg28KTV/fjdeHPrRyX3yOqDWmmqqWF3QgA3D1I7RtyQlYrBNqlup8mbkmjaZR+60HRM+CRNNJI5mGxOKeVITxV3H2etciRV9qPJSbt7vSSZPZ/wu0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7251.namprd04.prod.outlook.com (2603:10b6:303:7e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 06:45:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 06:45:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 07/13] btrfs: zoned: finish least available block group on
 data BG allocation
Thread-Topic: [PATCH 07/13] btrfs: zoned: finish least available block group
 on data BG allocation
Thread-Index: AQHYkyFqGnezSX2fzkSoNU5KLskCkA==
Date:   Mon, 11 Jul 2022 06:45:21 +0000
Message-ID: <PH0PR04MB7416EEB000CE021FBC2DEF6B9B879@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <b2d700b69a489077717814c5c743e474c283e27e.1657321126.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1539096-bd75-417c-0cf7-08da6308ed22
x-ms-traffictypediagnostic: MW4PR04MB7251:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nz1PozJipZpQXgcOd0X20Rb5Tu1IoBjb9mbWxmuOxDnqhFKfzkWTcpuwjgz5dkAptNc4tlYHn28wTNy5yjceHiGA0I9a3YPupGMKURcvZqcP744ZX+zAc+GoT3IdxaJw7cs2+7SZQM2LCGYzcVuSF+7OkhKQ/fu+V/DJxEIN8fNj5sz0+AxSf9lCKDfkYGfR8Cp0cw71SOjVvn/rh3Dl3eF7J661yYew0wGsMh2qO+QepnoaYYpnNMsNeKrMSt7YQ5OX1udPUBAEJOoMxpT6ukDhWg12vRDYftDSeNO/vJDqtEM+md3pgoRfgYRiGMV5zUEhENs+QFksuBKCEyyQ2biXFbt72viXAHRQuKZ7X0OoNVEzL96cIG/nWV/JsVzZXnK0LE24En/ZnDCOhy50gJnyK6400EZ6Niwu3PeawEUkFOurnb6IxdiuDsJWCnExRhN596gFZO65saPq9HFlyjslcFDQXGztqzwZ6yRSyzNOIASbJnmOYr4Cq4E9vihPAy+9DfebO+OATAp+6F2vO2S0gnL1t+/kzUjgT5UuxsvoFYSjnkzoqgVodM3yx432E9kSuh4WJqxRnJ00cRIPSm/ChYeEE01B0bAwn3i7uhbwEKQU0y0Mt9zCt+LdepkSRR86LFQPxYoIu8Yt/akygSx3MPXwczVq/idCm3oQktVs8zrGNNF93/+ls2foC8gzAt0+SAjY8Qbf2kYKQ/bIgXMt26pUF7xUppgsDGdJj0qffdvUo9/y6PXlWfKRaqd5PeTsnjB3C8aS58d1JWQ8WId7vvXXi+PUzwPHu/E2e+xFLjwRBli8mngwuJ4Lujq+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(110136005)(4326008)(8676002)(122000001)(76116006)(91956017)(66556008)(38100700002)(558084003)(33656002)(66946007)(450100002)(316002)(66476007)(82960400001)(64756008)(66446008)(71200400001)(38070700005)(5660300002)(86362001)(8936002)(55016003)(52536014)(4270600006)(9686003)(186003)(41300700001)(2906002)(7696005)(6506007)(19618925003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TnDEPq5G/4C/jDpKz69Yh35fQl/uKSj63qZ/T/A5lvZid67Hh+poHQHRvGOg?=
 =?us-ascii?Q?SX5hcWp8HvaOIuIju29a3y+mGsZ2A+DkU/LsFiocthG+c03Zxswk6NmFPLTQ?=
 =?us-ascii?Q?GN5GVvEswrk787sSoH9I221eQJIM4X/OUa+NxtYvPeCZufazhQB4lQlIAN94?=
 =?us-ascii?Q?83AUmc5BiGz5wtp14riCoRoBLLYuFix6BuR4A4UItx3JzzPWcznI+3iWgo+W?=
 =?us-ascii?Q?I1RNSEeK2NqN78nlSuItbdtC7lBentSrgCA4m6FJjukAfxRwWW5eco3QEYTS?=
 =?us-ascii?Q?454aeFougXBfXnKgAVj0Mcw4PiazaoNEF8x2rZF0FgR53qAUBshYBQxUARoo?=
 =?us-ascii?Q?DhMGJySLlmpyVsy2TWYU/3JdhYjWJq54s1L98CI6Laipwk/A80cSTPQlIgE3?=
 =?us-ascii?Q?LswM1mQf4LHjzFQELsJtLr8fxCgl8vSQp1/DXZjG2lRZ/qzLGg2sXen+1a20?=
 =?us-ascii?Q?W8Qxng+Yk3wZ63BtUsJ4NiBxQiw/ZmAqpcjgqMNydNuQ8HlCFkLRyzrjyXLB?=
 =?us-ascii?Q?G0GXSKsE3/DEh+vKQE65qxkvu6J1lCOp+8DqaFwh+92gNZtk2twLkS9rb1rj?=
 =?us-ascii?Q?+khHCZFon1ocVb5VQRa6VAbz6QPGcHUcuz89DQZdjQf1JiQGDwiUytmsbxKj?=
 =?us-ascii?Q?q2X1kdF9vZqhU0hcEp1eXifXDr02AlJHLiziEcW8BTka/msYg7acgAknyR54?=
 =?us-ascii?Q?dU3e0xHMRxf2zbZwaNmFU6+3ZrSwqbjwKnqr3/GmjKB28TJ0wa0GZyhois2I?=
 =?us-ascii?Q?9ZyJ1XYXlfXi/IzERWNwV1wx9O0aUlO8D8SX0rZAt9gZ51ug8a1kbThB0sLp?=
 =?us-ascii?Q?mIF4bthelF2mkWWaOJBloB1ypLUELZcdfcSFQHZErKAkuxnPRC+huY7yDEH8?=
 =?us-ascii?Q?8lLMwdS6DGBC6fH8p8O5C0EzFPguuwsuq80XS3F5FSlYD1yPuvUw0Y8PoJWb?=
 =?us-ascii?Q?h9q5DdRYSXEVJlj/fqFz61BHXxjDLwXuBDv3raRY0b7cnxPhCgYgcBVlgMOk?=
 =?us-ascii?Q?dxXPonQKq+2IfwyywYVk6Gt8AnjcFePEzRmq0jxNstH23KaExwAoaqPozvwK?=
 =?us-ascii?Q?GXm6FRXzCJo6F1kjQQfAF3lNb9khSoZ4muyo9jBY/SZDAscUEmLjmSOYnFSh?=
 =?us-ascii?Q?QK/Aw31iMjQjLwavRVa1FN/44hf+cXD9ylsbRgEPZM2QbS++hQUvG6CU89L7?=
 =?us-ascii?Q?W8E3tJlxnESsXUsI2FZ2JYHCk4VfBP66pqlNE3dRqqyxVXC5UnuAQiayeLoO?=
 =?us-ascii?Q?nCxfdCfkTHxlHD9rejoMSgCLqskSKazeitVfoBdn5MLm9gRVNSgHpz150P52?=
 =?us-ascii?Q?x0B5TmOHOmuBhBfZhVcqWa6XOv8JjEAt0N1Tqg+UlYHaIi0UmdU7U/Fjnbav?=
 =?us-ascii?Q?2io9ZghY0pWKVGdngPOXiTbix/fb6ASOjLZ9AzkDnIENZpXu4HWkHTXi8vWA?=
 =?us-ascii?Q?yRtpxbsm9jxe1UmgrgKqMrf18rm3OwKCMqlcYolDvW5oHlllf2jN/AYduhD0?=
 =?us-ascii?Q?fZm/rTPSviJYKSG0GMOYTJXsDdOeVwF19YHEcxwRSt4Y3Ht5EoaR+9Ol/GzD?=
 =?us-ascii?Q?7AmkuhvPDARvR5wQ5abyAAHhbi2wXQW2NvGQ710N3b51mxTGPbo2NmiZTb8r?=
 =?us-ascii?Q?vI9gzRAzjBLiLM6m9wgN9uAqEslp/+cYaLpIzkujKoeT2OrcfNr9xOgh1SQ6?=
 =?us-ascii?Q?TJ5ts5XAgUiGryHluVVSzYIUmTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1539096-bd75-417c-0cf7-08da6308ed22
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 06:45:21.5509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtplQXqT0Pu/kX6j3N/UEWXAZQC5cGvkHTXYpJSMINROLuBO1WS5DAKo70qy38lZfYvMzqsFHSP04+6WzXDtfYCkmreb9uh9XxSFkhBxo5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7251
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
