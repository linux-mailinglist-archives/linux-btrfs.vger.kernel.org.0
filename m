Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3755D5B9DB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIOOuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIOOuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:50:13 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0F13D5D
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253412; x=1694789412;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GQDxSuHiSya8+37fwawUC3+BiWXbld+gXbKOwc/g2hZ7bFVkBj/ODjrr
   b+ZAU94e8lPWUvfNpV9pDVcrLZp16zUUiDsx04lcVcRbu7SnmzpUtLZKj
   P5270kTfJePkAv6Z+6Y1L6xLktPe/3BeuFRJXy+arObUY9387+MQc+hUR
   zCKz6iOwwHjQ5xoHZ6cA2ZGT3vV/f3XUiP/Kz5t+EBB+a2o6PS420zhwc
   bjryxW16xxTwdbvcvBY/G3U+IsLXPvxOPAEDKhE6bE5gGiv3knWOzhoCx
   5o0PDifW4aWP4KClxpHrOX/gWCbM4nDbKk5dh3Cj71PEfi9HHOjMfJJnn
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323546862"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:50:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoAUx4JnGk2zsY1cirXYvTkn9Hjyzzd6pBiEFXfvztLIJQ5N1j/wtMwzopI5eb5qdDrwH03xdlwD8Lf1s6KNGGIBcH5gXrshDciqG5RSOjW1Hjvkal7KqNyEO7L9NVxBZbvo7qrbHHqSM2wzLucNixC0jDEy4ioVH+CwLK3rqw3r4R096O9sSqIZocKZicYuUZDfsbKpU+hiKdpnJWhE0Rvo02twS5E/J7rWJ6mdISwBmtDHmuqGbNudlvB4o/hB/fxsK3QZb96qEa6exUGzs5+qKmQuALMDAKlp8eUWw7aanJ7wS0KW4T2Y+xTwXTqoeX1wpuOs9bAiFDb2Zxaw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CT4Qp9qAQ1fwhBzuA8lunxT92cf1vh3B6JsFYQe6GdZ+fPJBNOPDXb+gXLree2s7zFJua0K0qWimVW019lPiecwaYqGPlzanOa+SOELPokHFI2H05LCVtue9VAz1SCtnA9nFNMdjFdyAMPZSQMNTMx1awukKdaWd7TySjkZRc85xz/DLhYwGSCM7PAzUQnHPB5+5p/afeNq9BFyKPXNI65wYmJ8YGtZs3fZeJQk/C52ey2tSV1JdT2PLb1QnlND2+yMcEHEIZQpZ6m8JlvUVHZGOlEuhBRmLg7FbmQ+AHcwZR9SbvEU4EhPNPqouWXTzyfsmOLkV8CV1AxrgyUmo6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CMHvz2yypJpSez813Yr0u+VRMu2GNyaDGcBBKzgu9m+Mo5hTNhZGb4eoq48yLJV/GZb7LaEAxkUQz7Vm/VS5W7jWvg7lp7WSks5SOQ0WFB64J4Ws5ejYYDYHutcVAFhOVlQNVCl0SH+DEeMvkiXpFY8/lqpawPAYICgBYP2nFj4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5923.namprd04.prod.outlook.com (2603:10b6:408:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:50:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:50:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/15] btrfs: move the fs_info related helpers closer to
 fs_info in ctree.h
Thread-Topic: [PATCH 10/15] btrfs: move the fs_info related helpers closer to
 fs_info in ctree.h
Thread-Index: AQHYyI56IXe7ThwfY0Syk4Oo8QJ0eg==
Date:   Thu, 15 Sep 2022 14:50:08 +0000
Message-ID: <PH0PR04MB74169F355627389AF4DE0F969B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <40ff0ebb4b409b881b7e4cd2e051b07acb05ff40.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5923:EE_
x-ms-office365-filtering-correlation-id: 6b14279c-4cfb-4bce-dd73-08da97299589
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TT0MO8+JNa2CJzWfNiaAiD7J5C6fQ0QmuJboXcp/8LaaNlufdGa4Wph2yZiA7vHlRTj2FL7BxizzjL6NwbScriIku5EMgjKavPjpSjoH0u9VVa9GP3nhas2w1BE2HHtfxRcLfgDnu7ZWD0v+Bz6zH3d8t2Sh+imAzNTsqLbaza/z9COIckMgvScAd1GidWHZH7l0hil678gTdaVcuQwhz0kHvkm/+L955TD+H787kA+UhMwap1X6YX0N0FO54fWLCIeOvTI7/OcZWIWljhuWlpj6HMHozVLZ/o2KNc74Ky5PaVZ3wFIQNQ24/urkRzvOeybQHMJH276XEXiVZP42BBqq276wgbDe+UOdFx2Wjqeb6B4gUDHAoxwPVrStWeTH/o+JUJvC9DVgfGJ70kYwVI8tROj3Xzl7kOto1QRIIXBI1245MIRyYUjGWfiRA0v+Q6nsJIUslSPWZ1Knmdi6/KgqRl9FDh1ELoS9Wa6yJPl8Boc3RgmLqnHSdf0m85CwEPO2fBe5k3OTZUAdjJH/V4Hr4s7r+VuT4MinGLUbnO0q3tgbV/P/G5/80B1Pxhj4C8tyDx3GGWGxU5iFYlkr5xgrSpv7nAJC7jhgJ5hmx/cavyOquAxkP8HLSuaafjUOVo2NT9oF56SskBObuSShIhPA6OVSCLLt1OhG1XuU6ZqWb+etNbSuZou0Yi4a6g/t087G7HVDRtoXDoUHOS/Jmwi09KbJBmMfCizwKJBtyhitsq828NGKvZacQ/okPhxKk8KMmAUo5cQHzqptpzPJ2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(52536014)(8936002)(19618925003)(5660300002)(316002)(41300700001)(2906002)(66476007)(66446008)(66556008)(8676002)(66946007)(64756008)(91956017)(76116006)(82960400001)(6506007)(38070700005)(110136005)(122000001)(7696005)(71200400001)(478600001)(55016003)(186003)(4270600006)(9686003)(33656002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gOvitu4BAHdQlrRGrGl53a4PQ47JjObYfxvQ5MvClI2RhWHh98p1ECKJMmD1?=
 =?us-ascii?Q?s5ldAvXaoDjFxcHZWVPGViz2MNUfCsJpsuu0BIi5iBxTpxw1EM5nJLtRN6eS?=
 =?us-ascii?Q?5wxzQa819RgNODGy/8BfQvxkgyjI91PKNnyBqZH0OuRftlEeuHGhvAfCjEjF?=
 =?us-ascii?Q?MG9AqTcrD1PTjVIU5Lajn3RoXbO3JPqH9nsh3AbBVD4H5yP9J/txtqLFrUMm?=
 =?us-ascii?Q?5FKG6UMhZvUqGGIrKPdjXuHLNA1WLvWWtWRp2fHTiND0l0TT+JGtZud2GkmD?=
 =?us-ascii?Q?07AgnYTxAN+u+YFd15sUhxj2ufJa94d+9957JsmkMo34R2llFL/buXsB/sd6?=
 =?us-ascii?Q?fICgSL+06B6qu+2lM4UITy6oRExYIt7hEgky2YmIRUt97Y+F2ytjT//ethPn?=
 =?us-ascii?Q?COGau8ndQhGiJxT6Yj730h2UAlRvXFGxTLGT/zeycvgnIORGd+joH47fZE0Z?=
 =?us-ascii?Q?oY65ktQWZwNHcGUMgSNrQvMXbk5PnnleQjW1vQ9MpfsfFnWkbHbUv0q0FIdy?=
 =?us-ascii?Q?PqK3KdQQNCyYIvtOC92QHBHR6hfTNXjb28vQM3Dl2CMMdbnmoya2ghq5plCC?=
 =?us-ascii?Q?XwgTSs5xCM8scls5AT7RTfrwRfmnZf9gLLSbJ102DyVlAo1opzzBIET8XLoc?=
 =?us-ascii?Q?Bf2R0c5m3ZLxd/bEmkg6LfwUyNfvK5+RSiJ7HldCiEzwOu0FwizKlG7NZu4m?=
 =?us-ascii?Q?GMOSXLoP9UdvtnUFgcyLXMqBmhcYqZAs40QuZ0zmREtjBjBbK+vqOaltqjPt?=
 =?us-ascii?Q?/81GCas3FCsr32OgNj2D4eFappAsfzVlGtTPADRQ0Tteso7udVfzkuyZD03/?=
 =?us-ascii?Q?jNHLn+f87FKZB0ZYJfjvY5dHBwt7yQ1IztT9ksSqzrrO08F9ZRbQMBSoIaBl?=
 =?us-ascii?Q?mhJayc2pU9go/TU1mWOdt2IGFnRjFYv0Xe5ikg7xY0VRh2/g4++e/bu9ZRDB?=
 =?us-ascii?Q?eUvAw29tbQ+9wqsy0bvmDQMeb9jw8hrcS2BhnUSz/4cXdrcDhTaOwGu5BuUL?=
 =?us-ascii?Q?5LX7Y/opYn7CzGlyduvGjQ3fY57Jljp1+UYNWkY4uqF8jTtCYnkMiXmNCQSl?=
 =?us-ascii?Q?fVsssTM4VXcGGMh8FF/a+J+aXEsDx0EvLgEqLlyV+K3AAzd2f6wGXP+R9XDR?=
 =?us-ascii?Q?JL9UKOcb6zoogIG7U3bliAYVJzcBZ3v6wh6YCw0QCutoGQP+iikIAmhlSOR/?=
 =?us-ascii?Q?dX8iFTBNjda7yBFVfjxXcX64O6/zH09E/ko8R/9qlmqHEw3qLRWpostacz1v?=
 =?us-ascii?Q?dTomHRVvPzdzXjMIrn95cG/11IfT/sc3KBMlpKrQ0jZ/jOz9CKrrfYZcqFou?=
 =?us-ascii?Q?g/Pv4XV7KJFyNcbav3O24ghrhNlUxX4GtGWtsMUHAXY7/kCarJIT32cuqHub?=
 =?us-ascii?Q?db/Wp0PSrC4Sgwfd10xQLs3nwBFn5sZY2+Bc3WiB6QXyfaqPLDKFk28Layby?=
 =?us-ascii?Q?zPkmgf2USyLhKKEf7NDwA4HhdNb20PGn5G+jobDfwVmTAuXZHQSiwqruN6p7?=
 =?us-ascii?Q?WPjiIO9c5q4fMLukJ8IhZ9CXrNtAJg/Q3nVTrn4BrouM1rbhgC7X1LWvTmqs?=
 =?us-ascii?Q?SZPyBbZJhgMnPK+ZIrZNHUqh8G4dXOBugY/YnRIv1VNVMBr5UIO9+RDuCaWZ?=
 =?us-ascii?Q?f2q0Xx8vZEj6h3Jmycv4a7QSRk3nDhazqp4Z9I7QaJec9q1WQpdpB0iLyyf0?=
 =?us-ascii?Q?/ccY7NlIjRTSccuRnWBy9A6KgQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b14279c-4cfb-4bce-dd73-08da97299589
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:50:08.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYJXIt46bmPSlQdXoPNfOw6qoqVf+Oh2o2nFHbZsyQBD5GGjxdZ5NgnJtDSUYgvJkvUczz/zM8NXXoUrvJ8ca3NhX6dyMc38Ft8cjtMB0d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5923
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
