Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236AB5B9D9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIOOog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIOOoe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:44:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F82FDE
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253070; x=1694789070;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rO1sEnP8ZWySKOt1ylh2ZwO/tZ/tSNIt+x1VcJcQR21PltTWU9N1qHG9
   vXjrIiB4zPvVssF+/y1bQ6lxUyOhhsoUF3WLbAkeKTOmU5gv7uiGnE+TU
   e59A6eNOL//w2HKqDUsK9bDkKgWquWEioJaRtx6luqkKEesOwRLshC7DO
   Wp2cZep7QUptY/ElwVWNBBmVaXyq5LPEhuawg7hso77oG0xA2kQLcRFWm
   QELActwZv3kL35+0YuHjUky5rOOUWAzSXZQNpmRiyC358zOqJq1P5Xxvs
   mkwQgz9B8BpwK+1jySb9PfOhx8sNfLl6aJjmgK06huV1Wc84ATd8sURTx
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209842338"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:44:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlSWkWjo/cokQIpSTum2RXsc6iNRM3PcvWSJSBxV8Xwq/nAVR2drLGtatcmVxPPzZqRXJIMV1miYlVMPFQr1RJUkdoDz290uWh/FyIiFaJN0KCK5KnQSvFOivZyrwRywPkd+1cHAHZ7p8RTKnl303I3/v4JB4C1bqUpzdc5DwUOZUNleyYs6wyxX5ibYtZ78giNI5B65INAff9AAYnwKph5uHGLmnfkuFzSQNMXc07t1yzKmZk1fANgaB4A5mM/xsvl98UbLjhmxv6zWUy+UafHBI+WeqN2H5/NmLBfjJFtCvHsLUtn0PnQT8oCUn5j8E9JghVgEiX6b43FPMHGfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WPiJq3zQwqITP2Rr8NIlPYRuwKJSQmbZrbVs2VtufFUNJBBPg/NdtyYxfXAobVIxZafzSSeRnCaVpINREX68KroPFBDV5zSMh2pbazOhBzmoTsBNfNIGRK7Aey5L0Db+0lUhbyJIUygph6Ly1jv2W4X7X368dr/DgMJDNzOWKB2hmR+NrSCYdHeuNpAcKn1dEckcseVcOQUdDgq0C8c2NyOubIHRDBGoQfDPmF9MpqLiUPAWrHZGY6Goq96CMwPeQZ91aBpPOj+nJF8i+PRely+oYZ6D7aKOkpJr07NfA6FzFdUBbEM2F+0RQ0PB0FLdOEHGjFZ++oFx5xur++y/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rtpS/wKsYT2VMkztjnsfGNbVe123smeIcQSFrexuIzAcQgiAAJ7J8C2KqXqp+ESnzRzvyowk22H+aCDpCwZnfzn0SOfem6/YIDUiiqwZ84WChzy4UdhZAwes7qsZcGXa2TaV6uUihxM/RYchIi24p7e4l9hWmdM117TAN/HpfbM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0706.namprd04.prod.outlook.com (2603:10b6:404:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:44:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:44:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/15] btrfs: remove temporary btrfs_map_token declaration
 in ctree.h
Thread-Topic: [PATCH 05/15] btrfs: remove temporary btrfs_map_token
 declaration in ctree.h
Thread-Index: AQHYyI52CCaO2bqyYkmQf7zJT/UPuQ==
Date:   Thu, 15 Sep 2022 14:44:27 +0000
Message-ID: <PH0PR04MB741682748818FA64FF02F86B9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0706:EE_
x-ms-office365-filtering-correlation-id: d25f8136-bfef-449c-dddc-08da9728ca1b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YV87rzDuXit01IWpmywJ8n+gGIGfEA7/2vqcL9KctuLA7sBa9/nWkZk5CzHJ146w5JI7Z60NHnx4QO696tD9RA4MNXgijBDL9OCpBBdjPvBenzqA2nHWByf2861woXobLHJA9/8FhgAF7hXwkJPGkd5y8cugK/boicfBuStJug+CE9/qIC6slaDfoBxOljvC1dQV0L/KHC5221TQoRfQY45ktPgJ1y3WOVqloI78B92mN2le2VzpmSL8igOYSFr6CgydjFGNcp/G/m/Si41WoIV2xfGKziT5n9gORLB4iUbkY82i3/KLF1AQBrZTXpZgnTm6noTrS50Kwhk/oyIb7uv2sdJAIpCaRSVOFtlK/TodFG/5Jr3uvd4vX32gXf3JeZ/ynVe/QswMU5vUhWRr9dJFKEIqiQQt8nKWCUxsdgoj49ivYyg/DgV1SAM2ZIxv7PZ+8OYSIINouxqjJJetil4kGPtm+6JZ1XzudXAjtctd5JWZAZevDGqhv9tcPfbhFeu/SACKOkD/iHYqDoPe777q2bI4yfOrDzgUL0EIiJIuXcwjx/nOsPCzGoh4+j+Lwu3Z0c6B540S2w0Fjl/+T9VpeOEeRxXzUJFhS6eEIJZJkdoUFar5YrIo/RAgGmA0tTuIdAfxKMIpWuzkQcidOD3/8q8oqAkzDDIikY34NtXRmM92eNToG7+TQEOu2VYlBUPt11wpTJtTCrzxgOjV0nkLqDGxH/c/z0FnNzgvsfxR0BPhwZkS9L9KtezJk4/fO/fTS7vdRiB2fQKnyAWP4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(316002)(110136005)(91956017)(76116006)(66556008)(66946007)(71200400001)(64756008)(66446008)(66476007)(8676002)(55016003)(52536014)(33656002)(186003)(478600001)(2906002)(558084003)(8936002)(41300700001)(38070700005)(5660300002)(86362001)(122000001)(19618925003)(38100700002)(82960400001)(6506007)(7696005)(9686003)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b7InUekEn2ttz/lh+OZo2JlTAG02UntQfr3VxOOgM5qGvmV4Rj1NwwbKfdS4?=
 =?us-ascii?Q?16MZen7Xv1C3SwvuLiRP/jIgMYZskTMp/zHkghOIkFxnT+pH92H/5WZ2TDLL?=
 =?us-ascii?Q?0D7kVXgX04j49SX8coWnJWlNu2lokXN1bBbcr5fwMtel9T9aZzgOkZ62YSL/?=
 =?us-ascii?Q?jDj6ZV3Hl3a798qIiaIG1L+9X0lRl48K8hbZMUOdJUgLSUIzl+ZX8Ei3Yqs3?=
 =?us-ascii?Q?f2VO4webJIwc4vyypUIep5W2Ob448vA+FYMDTYUYwE/Z8u9UDDOLOum4PycE?=
 =?us-ascii?Q?9AwsQDnIc1u4slJ2sKhxwkxdaWvpWBwEy54urG1W+tHx/jFa/ZChto24BnTu?=
 =?us-ascii?Q?OfUvgKJbCm1OE1/rujrZa3hIabremRdL5R8zVsd4Ofld9g7de6N4DSdBmPaQ?=
 =?us-ascii?Q?bhL4z8eCOLpl4fMdfnocSZses5t9kwHBlchgkGvUzabnOCbLmpRY1cJRLA4U?=
 =?us-ascii?Q?5VPxwgE5v+qT9zckJk9R/YdWO3yY+GYlxsqSgdzZKSHIYQHoAQW3uBxS294u?=
 =?us-ascii?Q?aln84eENTwm9bkrMy1PYx7n9V39yaxPeTnqEHl4Dga1QbP0NAfBgDxu5Dr7M?=
 =?us-ascii?Q?dd13/N1LIOoCpoXnioLhvJr1gT5ITDzcpzBTtNqLPD/bq9jJ8ScdxMIVPtXA?=
 =?us-ascii?Q?qETitjFGEN+pKO2rR72S8dsP2fHMB13u5zhpc163XtbsFULVT3uLTXEBtewb?=
 =?us-ascii?Q?/Rcw018qrLD8rkGH/33Qj7xNRVNYq5ONVb8BPlrwMUFD1KNJPvIHWtSMvxP1?=
 =?us-ascii?Q?hMDyP8W+/6MIeLMwU7uy3sYWJzLAG8JTQNqpCK6j70jN/lirCSdoudyAiTC7?=
 =?us-ascii?Q?0QuiiB4vXIuD6pA08CBqrHmA0051y5Ok89VopxBLItxwvt2MNEtIB62RmGV9?=
 =?us-ascii?Q?IEnHSVmK3v7mm+w7eXH3frkqvAhUDGrBO9u4dtaliYO1YsC2b+wAuw8P5Lje?=
 =?us-ascii?Q?wKq3TMu9sGZwH4l8ke8LLDn8l7H+spulZoa9nwhwz+REY6j08ncgu5QLccEP?=
 =?us-ascii?Q?5B7dHIdYbQQeBzmYQpDya2L+p9FJPTuJ3iqacc1QBSP3Z0hhcOIUuS8cOyX9?=
 =?us-ascii?Q?KoTFv8LsyfSKETN1CM4ujHQn1DdvZfYb2WJ7dlYbITzFqd9fakGWLQBX5cQr?=
 =?us-ascii?Q?xnGQvM7SpPrO2d4qYFC0/pW1/DpubLimiFh9P3wWo3AntzZvPdk3Vi8KdYWC?=
 =?us-ascii?Q?E6GnJNuyVIw3buUo1JVSHCVUcHGPIU4Fsic/k+YBQmRjhYQDTubJCpo2tFpg?=
 =?us-ascii?Q?iwZz0RXGpuDUsU1kr5hBzeX6PvTw6yAV819xGOv6E3LYY00V3sATpEXMPNJL?=
 =?us-ascii?Q?x5D8k+/j/asyLFKoZucCUC9t1MrBtHANd6nU0eoRWw8VCRn1RkgqNe4OeFML?=
 =?us-ascii?Q?jjoDt5ZyEgYjll3bGgrxWYoCVfXvkV17ET2l5iZQ4f6XQzxqLBJu/3+b0w+4?=
 =?us-ascii?Q?dxtSKMdLwox4YiOfjIDLLpoARlxkhscvOowxV/y9z4uyMH/Hrel6sy88S3Vy?=
 =?us-ascii?Q?ENTnaZKeeaxjwRpnJ3aCc3yflCx12JZSJrSQFWTdW2qwg8g1P9YgrvRdRVBs?=
 =?us-ascii?Q?Zae5oW1LkgkiVHOU19ky+aP/mDnkIAAl/yKL/WhK4Z9mIaU3rU0vne8XV2tG?=
 =?us-ascii?Q?xLgB9KAdhGwTROPAFKkS/esSp+kqS4zPJ5QqHahK3+7DwJ++nyO00kYqDd+d?=
 =?us-ascii?Q?SoAw77MTDtbcY+O9NYOzhnwvZlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f8136-bfef-449c-dddc-08da9728ca1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:44:27.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bG9OnXI7OjoiSYba4DMQF+ghWeagguBgvT0AyNXf+ziKyrjQvfdDBirdOc0sS7Buek7fzv3J1sjqiZE77uxp3AIsjfCN8WsxTidAz+T1Jgg=
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
