Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176B5B9D99
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIOOn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOOn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:43:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C034A1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253036; x=1694789036;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UlqEUX0bqO8EOkbwpRFRYH+Y8LB4XBJvIGjLjO9OnOpS1xqPvCyDf81j
   QfMK4QRcTNV4zU+3V24tB9/GMa6Y1teMLAdwkEifqjB5IlRaFWBFl/HvW
   RqGNx+uutrpD2NJFFNKCZMv4AadA0QARAzCu8cJNG1ASMw1u9z/WqUvhW
   g6MijJ4rPIVkABMZqiVhNAx95t5sz0fh2592J5Im7q1w3V99VEHMqjbMv
   tf7t/zHrezCq7N9lrZGodt5GS+h3DimV/Y5m+SaUjphQL4n2AW5h1TFnI
   w5KKz1OiJK2czkyOsYdosTquReyYOPC0gzzlZjxixlqeX9JxTK82AYb9M
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209842295"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:43:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHydcL4Izd+6+2d/l1PaGLqSi4KNrEGPo/S3ckmSzNJa1RFhoYTX0vBxzfwaFsJMgKgX8xeDPNJHp3cKnlZrzjq0ZuCVx//hUcd8aHoGE7+pl6Apw2yTBLtZ8cDVvhljq8Qxo09cLiZCuyK8UPI49YAiW2rKW+yrCYFR033S+LngahT7NPiQ4WP+DWS3Xrp7Pm/BxS5harLajTaTOzpcPPhNzYlE+XqgyrrKEo0CU/sEZbLOeWujONSQGXFC5RV8JL2tLrgAVncGig0Eg8/CiQPLGuvzHJ4NwPswRMttl+EEOa2j0cHPEtMcp9wBcoxuCMnDaX9ZbUyvWslnAh430w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FTe3Smcf/WyNqW1p3UNxd8Zo986k/UH+WqncMYsgE9eKxS6sa+IWj5R76PuFXEEcJnv+nTwBwBVl2Nv533sXuZMRxE3yEtYrDk5n4yxRjKQ8wPbTImoKUPc6t0X/7yia1aRMIOb1G6MqS5BtoruGBl7e29K2Pdai/5TI7XhdYGiHo+/35UvIvP9CHzkl01SA3MccigRkL2F7fmNdI6NoMjtyMI2/bcYGE+KKhtZc+c9kBkgx/U88J81IeACLJWLklLS4kXv0IklDka0Flweog/9YRAKvBDbjLHBGXiCbgOYCmGmKrNqmy7AZTojOrdoFVkT8oq3VOS/kvkU9B0jZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=wX3r2bEep5knADogQPlefj07jUrrpqh950+5DvWzT/1ewWLAihcAK3z1nLPOD6bi5OdN2tVvqXvQSyqdrVc90z2gye4YGWLboKRBgJ39OfNAH6oXIDQAbFzocMY3AkUYjMUoTSwLjHQa80lWw4Z+NLWsdBuQ7Jqkbz2tavnEbms=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0706.namprd04.prod.outlook.com (2603:10b6:404:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:43:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:43:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/15] btrfs: move btrfs_pinned_by_swapfile prototype into
 volumes.h
Thread-Topic: [PATCH 04/15] btrfs: move btrfs_pinned_by_swapfile prototype
 into volumes.h
Thread-Index: AQHYyI5zXp+01yipCEOv+mREBlbryw==
Date:   Thu, 15 Sep 2022 14:43:52 +0000
Message-ID: <PH0PR04MB741616A1B48D655A9D0BE52B9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <4cddba7a242f71c09a9cedd03fe726482ab90c5f.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0706:EE_
x-ms-office365-filtering-correlation-id: 5364dc05-cd2d-466f-3ffb-08da9728b594
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5C4P9/+O60XR+7w3RxHOJkNcZN1u9XFYvdzOoLUa8VyR8cW3kHhZ/uPhUvgn11dG2TtFKTXuBGcQu7zpKP5jh4knGvrZG7RnulZ3Et01pAXj9wyVNQBY6jAGcpPeZJkzAcGbOb0qumfcG42c3OlXcr5x/eefbHN3L1uKNKbxrV4CuY88l/rL9DVlT+MRRkfOtjEG0DcU9CTNmA94pRsNImgEvdXh2hn0aEvIDbCR+/Padp/BM7bjwjFLpigggfv5dYSTFFcOq2ABOwu4Lq0q4KDKeehuZw7pf27CdsariAjnJ8HKMaGsRNfCZAp4RsKIkbo4wljCsW8Gqi1Kvzk6XZvAE2gYWWVYCG4mYrSDe6+XH2cx8+QVdxQwrQSoOoFuteYn2nkHjnYxdE5FLt8GrYnQRdDN2SQUR9pnKDNsY8GCrLte+w2rjabavoGuN95Vd94jfFV/clDNH8CBHw+tOddL+MTsEWCKgXnuje7mIEezSPyfusm4/UwR6qMSWKtU9WVQobzBPAgxDqKS1K9pHkkjV/HhAdrVo+qfwdyoI5UnH7O8I5wnJ3gXmqY7LuW0CRYhB5A/KQ9Ir1UIqmrq13i/e6cpdFn/ey0yCs0gtE0zOhJDc+UykzGugAcLJ3rFlwsofBdQxBAA48sARasDsvDbJAmThBWJZCPN76Me09So8+j8pRKnvRcNQt1I1mUD6owoUng1qA5bAiBXpIlxbeyxvMMDIMKFYmHP+Q5+LKGga1TRkJ55ZC6kbGbrpkm60e0X9Wk6mw+dEJrVcSr0KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(316002)(110136005)(91956017)(76116006)(66556008)(66946007)(71200400001)(64756008)(66446008)(66476007)(8676002)(55016003)(52536014)(33656002)(186003)(478600001)(2906002)(558084003)(8936002)(41300700001)(38070700005)(5660300002)(86362001)(122000001)(19618925003)(38100700002)(82960400001)(6506007)(7696005)(9686003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EoRDBSRXcFW32UwPz5MZSEDtrmGvxKBbv9XlKf4suQOyucMgZIl1c1Iy6SNP?=
 =?us-ascii?Q?mGpw3YBy4gYkQpMj+AGPFFPqCb0lyVbVF/aM9yov4RUcNhalMXbuevEP+lg/?=
 =?us-ascii?Q?nsbGMT7RN3MyU6oXJAsnIuvxKVRRKU83eXlLO2FTQbl6NquHrvqLlI6HgZIV?=
 =?us-ascii?Q?ioiKE6lxwxMaugGU1lixHlYfa0CVaHrHJvb5gv2D/Om9z5lkNtJfFxRmCfaQ?=
 =?us-ascii?Q?EaFjD7ca8aaljlS6PL8V+W8zRZX7YJg0sWTGesg6vM6pZMJ9gIK0jXxxE34F?=
 =?us-ascii?Q?mzHtZWoO7fdG/kOwxAK8lT0uc4h2zVwSu1hh3AuEgbuCqp5JoJ/UAkVUQkRb?=
 =?us-ascii?Q?l0IMJROAeFTPs83i+4Jvv3euSY2UbgmCY/xiwt7lzE+NGyJATHk/itcAWtIC?=
 =?us-ascii?Q?s54vcRml14jbDlKgXxCW3u/rHVNmoo43bv/yFR6mpdU1imAmuxwcYOXHW4GO?=
 =?us-ascii?Q?6v2dtROrNpmgmhYxjjW77CXedqAZiCMosvqeztvvu4MMY5DlQnex0L3BaRVa?=
 =?us-ascii?Q?5+E8gMZv4lsoPlsiXwzI8S/5TC6z7RI9NUQo3GFmJiZ+M1Wrd6ccOy9ZOcg0?=
 =?us-ascii?Q?w8k33fXWQQYSdVySyj8DD8E+GvG1wk4A2xOYpojdkZjzeCEpQXbdbBd5eZpN?=
 =?us-ascii?Q?LfjESpKssQXz+VV2GEx53Af8rqjzWJZQE5B6/ZymSOlLcDChVRaIfXrHXJpG?=
 =?us-ascii?Q?qxvJDwBYSX26v0zaRjrEiEHrizvj5vBvTMgjVKtpskSUb1svrSC+Iln2tkDc?=
 =?us-ascii?Q?IOjHIgFEo/TcvgLJRkAzIJ0As9uOyoaE823tQUzj2p8cNeL2xb8dHj5UpRTP?=
 =?us-ascii?Q?8Ic6l0ujXPi/Isy/eNkUcLwwnPxCvLP/FsHwHfMvJdCxnoc5ybGfWSCF2ByL?=
 =?us-ascii?Q?3TpDlnlSTmLUvcZnHwa+j4ZwZ2A5wGz5s25n150LZ0m+vkx78xVJFtYOlK7k?=
 =?us-ascii?Q?q5wgRgIOBBysQujNsdFs2E2ZPloTLQVmnR7Q5zEwsbNLwKzGl3rdmHZ3R77x?=
 =?us-ascii?Q?1TuRLxnATAsb44lVZyezzHxxRH5aMiaXse95UC65UYUnMYN4SVCrMvQW45Qd?=
 =?us-ascii?Q?2qBt0hAwxrf2rvDQloV5v1lAXEJo3sBKTkruLGADQRsgaOC/6GQohpNWff7w?=
 =?us-ascii?Q?DEsuAdzSnQIlCvowKwqGDHIgi/zbXY9lrCql+hQV5Fzhk0TYWlv3QqrrQdoN?=
 =?us-ascii?Q?Gf4qt7iPPsR2JMrnqpXbubuxpccfEQL/UrTS+UDdQul+xfNwrQPhmyneO+gL?=
 =?us-ascii?Q?Zwei6KSQ2xlCl0iXuRzSeIz/taD17JIgEhfjd3OU4PmWCPjbTvgQz3Eo1bNn?=
 =?us-ascii?Q?n/R6G+HuCuwzX+bMbXhgrU6DbYlYmXI59HG4A+hYCUYJxaAhGTlDWoTx8NQ8?=
 =?us-ascii?Q?0x6uf393zeLEhdRIUrfD2JuC+JdxT2zsEYc0AiQxx+gfO8nnsQ9WiN45DPPN?=
 =?us-ascii?Q?88/XvxRz4mfsKbig6YP82i4rtXyflFzVnw47lGIPgLJ4POQ4sxl6Y3bUqwSL?=
 =?us-ascii?Q?g/XA4Lff+l2iWh9ZOv0TzD1OJtijETDC9G2u03d73zWdCfE2mazkqPUwp+v9?=
 =?us-ascii?Q?isxwxHaC0zNSVpzB6BvmEmXzqsAtK1fdANOyoKcjStNtXURAVPszsLrklKfc?=
 =?us-ascii?Q?tHJF4D0XSDyBTQSW3h2urUHt3TA2+tbSSX4nDLT5HykKPl42BjXsL9+HkzmU?=
 =?us-ascii?Q?5DSAJDiEHfq7LdqEwVEJso+FrMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5364dc05-cd2d-466f-3ffb-08da9728b594
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:43:52.7067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGOttvyFuK+OAW9FLMbUeaqo9DeYrjkeOA9KErIcdGkvM6IYgZdGVWQ63R0eCnlKNlSL9LZKnxHc2bL7WGuWG7nrzAK7GWUHkp2djZA0Sh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0706
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
