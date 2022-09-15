Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA45B9C7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIOOCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOOCf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:02:35 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BBC9AFA9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250554; x=1694786554;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MOtw7II2nhE6flAHvYnl/HwIwVzcafZwOLCY87CYE+v3jNap1sqiHE66
   9bcLu3qGG50fLayO8comXZkle8sNg3cRrgrFgUdBOfSv3ztVgOrWvnO/4
   5NuLo3OJk4S79o3VLzl7CMTkVmiH9L7fNT78hs/1lb0wtn4bpIWfoS1el
   eXy0nMcj6ZVoUjcDw8pClGFQ9VrgRh3qXOq5/ingUASHOE2Hho7wSlN0z
   MCmcQTcJbFxvBTOzAERSIAw09bL/ZE//o/WzMLvAeX+8rhcQt484407RB
   2zyeQxfr9CMGopx+7RPnCCpOCAEhNGrtCXJGid7jrbrGghN2oOsDnhzBf
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="315723247"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:02:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIM/myUHhg/s0UM6cCwpbOX7pzIwpKKSS5SApbAj6XVY7H3c/1twSiHylsKFpirXmyOeuiVHO/6iaAgqDbSdPd0a4OLkx1FTuKcJvh//yG5nr9vHOEHh5npymyLq/0Cn5PdCuA8PKeyUglkRDCqiwfMouVyqN0WuQRJcSgGjQG465FpSkx5MRBdrudOjoPRap8fOghCZfHd/SIWFK8xqWYl2fL3XDRNZfrALap5jpo0ceB7q26+0VSM/Xl5RuARjZE3Dx9OS1wY8tfCCbpgbhjYofewYzuT7zUwAM7JEubOHLQ4geKbKsIEEwUr4gGlLSXrAsSnY8btAR/1rTPlRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ny/XluA12NpKn1svaSRLRxDaPu49RTTiR9hU6jaAWPwpipv65h/wmQxqaXJ1VNg3UyCjfl/aavpF5zHnpYNNgp3a9PJ2zykW8cbLLopr9PjzsSFxpwi4cqBqE5qlsC+H5BbsE1sGYIOA8SdzgtW9O9j0szBPoU0xNCphQcbq9Qydrt39NpfJZMrs/dF/gHC14v4a/8jNhYJ0mzvfHLbr+IWImxVBUxorOiLh7cluUaRAzG6yQrqdVKzD45plnRJPa/LIL84b2ig9qq303slqEDPE6TN2a51v/s0LzET/+PhpKRY/92lRvKz2J2EW9m2cXIKDp74al2JzWS4PoBqKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tjMQZH5BAJ9xzwWxGannRr/OP+eLD48QcyACTEG35EIoZmXP+1dL3qpcoUnoy/G0FhQFuHV83erhzlrhZQif6Mz/mZgmNVbL4sb2vHQEpaRC83P47kO3I8fDLXMXu7gnnpimqs6dWRM/mUmI91KbSoFPqUBqB9CNsHLKYx0TIkE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7952.namprd04.prod.outlook.com (2603:10b6:408:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:02:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:02:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/10] btrfs: move btrfs_zoned_bg_is_full into
 block-group.c
Thread-Topic: [PATCH 08/10] btrfs: move btrfs_zoned_bg_is_full into
 block-group.c
Thread-Index: AQHYyI7eeJDbPuCT60illGgFnGcYEg==
Date:   Thu, 15 Sep 2022 14:02:21 +0000
Message-ID: <PH0PR04MB741678E7C4E31D5339D3CE5F9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <04ad998f1c1c383fd68577abf613ffd8e4622cec.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: 21113b39-5e1f-4776-621b-08da9722e8d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eqtuw9+ZuQw/8xHy7rpwBCA7nsOn4mO4TPPT3e7Q01v+CWB7O3q4FvK+gQE61e6EQxRQB1FSnwaVLDUM5dWpecj2vKHPFPBE6vh0T4m4h2snsmW1cFONJ5twm3HrrlapKPZoFESvU4C7DuXYteMLW8GBbrrcGMDcj45i3IbmuI2nbLovYjOgVKPOhPWrJ+NnJZ5jI+RCy/IOi207s9owig4RJttOi+k1T1zLDvt9t/U/CvtzxIdfqLkVkH1ZuIoMmwXgtCIUwHS/YIQkImDGjFZog4DBX6ziEayd4LDwNGNY2ka1d5dhjjbnSKrRNEq/qu+FL6WRh76OGLhXv0pAjNVAxWi/+t9/MOM1P/JaGHkUBWrNMmPsMPafNn5FRteMBfe4WBBg0ew5xkDh73JNLlBywwgR+d6Q18zgE0v0R7LVCzICjkWfbeDKL0feDypZ8xO4hZEzuGjw1Dqji9wBVm/IRdDhDlDUG9CrhLAAL5PFpkOYG+1Pq8G5VwRwk7CsWqNl0b0JAh2P9isxjrW6SxV3zQf1EcLQnvIVgpYUtQEkPvBmlaYBBtKS+LeZaRLvGMTnQVqWrh4gBVPPurOvESF5kEwqnr8tONBEnvjjabxokzqzb9viKiija0fKBYa/BKNGsZkr4/lnds4UTHuRPgpbHDk5JAL+Z7jYrBqr4Gw5Jcba314gS90TwTMK1rSwEagJ6nySuisbr+zM22kiocyv2pDMmTCURVKUm+VMMiFv00OI2qH6A4CJSCZaj5LocsCMKavfRfJ/FUYVA2Y8Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(316002)(38100700002)(8676002)(122000001)(55016003)(5660300002)(82960400001)(38070700005)(91956017)(52536014)(33656002)(558084003)(86362001)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(8936002)(2906002)(7696005)(19618925003)(41300700001)(4270600006)(71200400001)(186003)(478600001)(9686003)(6506007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RU0IZgNYqDW5+l/DZygvabk0P/WfNiv/GVpLhogv8vy6mB0lBzq7oA93mAvt?=
 =?us-ascii?Q?T+kuc9HMbMTpU9b6Tviz9V4EhEcBDsdg2mMItQGWnFdug1fTokddbSE00c+c?=
 =?us-ascii?Q?kT1fGN4kU5WSOKi39uxAAoVPrUQjGBv3ss7q5MkemfD1dkDJkrWLanjIJubM?=
 =?us-ascii?Q?4zYxmCLmvBdN9MKDc2siDYmlVR+Xb42fzv5lGXbQseQOY0K/wG4V+C7xV1nw?=
 =?us-ascii?Q?AxwyG6EyKQccuepewOV1UgQfRq3TDYqAMhqEqr1ZjxKj7ZAwIcaIiDQ/X2FY?=
 =?us-ascii?Q?cP4jN65VjT60/PC0knIx8jitcMDYIKqC+Kn8FrzSpgTv+g47KlagTPTtiKXB?=
 =?us-ascii?Q?gAh89SmiA1bZVqEBn1vRNG4YKpAZqOAEIS5Jbpve8XgVFnN3zdnaRoUTYO8v?=
 =?us-ascii?Q?PE9SX2h2I3ZHHYkmEajmWL/ImPCz5OmcHSy6jIZnubwJ2PAbGhWIVgothuXR?=
 =?us-ascii?Q?VWSR5xUmcQbYQn46GUbuInJK8ydkdq6muuCJ/9IeyujHLwua+1haBzZ5sXFW?=
 =?us-ascii?Q?w3ps+kxDtj+y35n7WMhLI4Ey2Aj2S7N7a+X/FGNBQbvEv0REx933VW/aVilj?=
 =?us-ascii?Q?jj+/blF1uAXLkFwZIkt1wxJ609tp5VGWxzBv8XTyci0AJ63U2/Tkgpf2kW40?=
 =?us-ascii?Q?4cwIbYvvPNkR8b7zDfnyuTLesoYcUWnrMjUOEDXeHfWYzKcqkOEdxNKJUlFm?=
 =?us-ascii?Q?iJPME8fKPqPRawULzPQKyCOCN7vY2/KkoUZxLpOya3VXkulsCc20xxGy4y4c?=
 =?us-ascii?Q?1gNurAdB1f7ilca2mW8sgpNqMjHNM1Jbk7GBOQGu3/VH1GHWwFonuOOnzHfS?=
 =?us-ascii?Q?it1ad2PjFMddQOAt5jZ8+KgdMxbOTrz4ERZNAQoT4L6wthbg/84mTDQSEe4A?=
 =?us-ascii?Q?gbyf+ke00ZNsPUhIrAhwu7CB4ILidbbqOhY/Adk33/QV/gOJfrKGb9DrVe7S?=
 =?us-ascii?Q?SOIAKqcnFlqRnlbjz71YI/neAG+lcDne7GQeBVuE82Ho/VqKB0+Fpc73Wuja?=
 =?us-ascii?Q?XP2Q6p0SI9pjfwKVfShrlOTnOPW/mgbWbmODkVUk5IudbytSjn8Zc3NuQCCz?=
 =?us-ascii?Q?vGPXj8i83wnFkBju4j0Nd9OZhdiS+jOXABEUonWBQRw2j1wV8YoyLGh8z5xb?=
 =?us-ascii?Q?AylBe4DyyBE4CJETem3VsTZxkCNfWcRGqr/OMOXVjRcnbONfIP97j1Szq0Ju?=
 =?us-ascii?Q?kMvt0BMwLckfpQWQsY+HzVcvby8NyKRKNFqaOp19ioQFPqViL0BarfBHOylo?=
 =?us-ascii?Q?Rd6Np8X1zDUjx0gvt+Uzi3y6HqzLIIo4OPiSGoNtu1pmumEierWHSS8U2OqW?=
 =?us-ascii?Q?+yf1Y4BBqFTiU6TIo/9A6S1Ecmr1QGy6W/hrOriR48HTDe2bBVIKBke8OuZv?=
 =?us-ascii?Q?UCKWh0sIb32nKnSkGLPevsw9nb3lBlwJrqVL1yMSh1B0LynB25Uf5FOYuLCl?=
 =?us-ascii?Q?5MpDVVgJiROnWQQ4BTIwuM4v1ciJ491SioZy16RoZpskYFyW95FHKped3Q3R?=
 =?us-ascii?Q?CKxPSBt3lcS2P4gssfp2BN5y57p9q+ys4BICtCqTHp+vFNcn7shAp55ceVSL?=
 =?us-ascii?Q?W+/ll2zsRbM9dyskMouyGX3k7sCgD6nlKGxUwjcvqjok9WbVO8Ohr9KPQD3j?=
 =?us-ascii?Q?+FPVpNFWb48lSCA9/XQxJoTD/Jua9yT3JBoUAnR1yNpkoeXKFBs+4Gy6vgcZ?=
 =?us-ascii?Q?ZA5n5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21113b39-5e1f-4776-621b-08da9722e8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:02:21.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFz8BDeheGb3TkAeTqOGXR1sczttZ7TE0sJIncTKDBokhEF23KAwA62+p3uB2zzniKaemhb1jZGRC20iH1cYkhGMCw52lFkeW5CIWUGVXLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7952
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
