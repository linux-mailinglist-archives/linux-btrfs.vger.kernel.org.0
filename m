Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985245B9C66
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIONzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiIONzL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:55:11 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E57A515
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250106; x=1694786106;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rOo2s69v2Jbd4MaovRKdCXGH5rLnqFLxO2oL2c9u81Z4NS8SFnr0q3a8
   bLx5I0o0e68MieEDJQpTEoLAvk+WD8jyhPPqg4JgQT/C/QUyufBZbgxUJ
   AruD2CQHBhc57E/Q/tG3U+qQ0Rgs08sAdstw0YcOA8Z4ZXP0XQNr1nunT
   z7akoynOWNrysY/uPoBXVKsfN+iw7NlKa0LwMRJtrKiHSJ1QoB01CuLQ6
   qp8vEPglYAhPqbaCRdzJaqA+6+gxouIRKKKRl2wzhWYT6VoaKs9O6kJFE
   rA2AB0RxbVrAcdPrPw8WFgur3dGoXjEf2VNanrg9KEc/rHlu/j9QHBq2D
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211436010"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 21:55:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1LCMSxxbkbUfHP5Li/4suVd7u0gpT77H8TX7Um5rEH4xHVnFP6dwnl5bJOuxTR2q0yXBqTFxS0J/vxp7bkRWQZ6B1SgWQvvxRj3qrBDO7QSMufAtamZT2pUJZtfY34JR8fe+QVWlU8bfXeA09M9eBALx9XxjD8jJOfFfe2aaCIcmr0McfrvcosCSWYycgqLGcd4ub9s5hX0tO86x9Ga8gK2wKFWX67UQNnDUTQpuXbXjs2f6KH/9ocJcjPsNzP3O/gSRnRGeBq3tdCs5em46jVXEebSkEHktaD9vjvzkT1Csi8xoyfNgq0PoqZdSCXJ4TNq3hDIYvGnn/kMOGTs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZAOfmfpB5qiZ9Bv4S1ORiei3LO5cBnGcXplY6b70HFZLJKYL8RuQxeViMfcXAaJI/Qkc46hpcfPwN4D5gHSgdpDigfxAo09O1iWuO7prBD+DBDyB2pwOJQc8eiWZy6hD/6sl2B9syOWtC4875i/TRZOnyRkGcGfhPXID9a4/Z16H8SEu7kcTQZi7edKEDHZkOhzHQf1nyA683FrcPim9W1BGei4T9tRCmVndqemdV3Uj0hTBaCEjY2abcqbirYhbcJzwyzpp5izbXcyITHNUGS0en+Ca7yvqSAX8nmPtOHysij2hnNGWIzqd7SSpYl9jyRHfo9qU7oNculLSZT9e0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L5NKePluQK/Y/Q/INWudWM1vuV+BzB8PzIIA3nzwWlcbPo87vbqGaB6iBWl2c5JeCDrEzOhxptCTggALFFw2crWtnZw/mda7sqBnr7G9efVNBdbxnm5O6ewTGZjBN4WbEpBqZUlXZAej2IVQddE1Q42A+c6Uar9UXipl+TpIL/E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2259.namprd04.prod.outlook.com (2a01:111:e400:c5f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 13:55:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:55:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/10] btrfs: move btrfs_check_device_zone_type into
 volumes.c
Thread-Topic: [PATCH 02/10] btrfs: move btrfs_check_device_zone_type into
 volumes.c
Thread-Index: AQHYyI7bfBOKEnMkckWEEtRhPew+ug==
Date:   Thu, 15 Sep 2022 13:55:00 +0000
Message-ID: <PH0PR04MB74168BFD6209DFCD8D9D42749B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <a156cf2430eeaf93a748882f49ca9dd1cf7d51d4.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN3PR04MB2259:EE_
x-ms-office365-filtering-correlation-id: 858d3052-9240-4744-46a3-08da9721e1ff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vz2DjouQI5phej0HIt6FLP/Mg4yOHdv8WZ8YDof+vPZOXWwA//pHIOEkGJRXbqQnnkvy7NglT2aAbkq55QClw6ijO5GT6my5H8KeoZMy/IOy7sVIERkTOZfxJLZH3ATcTkg3vgDBG79DqIPXNQXH2Or7owFMRO45p1WiOGe4EYMbcLhTQ28Xe7n/YesM5SuWeSAJ1OtHzimgSwX3T2GP+9/K4f4Sr28mii509BZxbY8TIRNUjmeiEmjeBRtGDt4IUkUd8dklP74DrhSpC3XKYB+HHpJRLhp7Rjl/Du1M5tfh4N/WgvJPHePE5+wFgqgYliAWhn26TZ0T4u4eglGkiFRU+IUjqPY+0jrQAwoylWNv8OVeAgdWXN/u8Zo/h6j+KuWIouDnfArHzymDyw157GTSe5H9dBkiTYS7YOhvU8iEr5wmgcv+I5Fk1h2IvvQcjWLHwD8JSiXJL2JsJTYdu5bAhfwwSPngJzrjOu3cYHFf+q1MmgbYEk7MynpKgWk44uu7dCWlyXBF7cWLolW2SudZddqCP36OGcnp+EeGMXXI/LtzcGEkto1AgENB+6ePQWTcuPtiCNwWArFQAD7DnppyZcALEAVrW6vVfMc1+sNp01zAAaYFPy/wGBcMvi1YCkR1Nn0bw0SwKBZDdHLxm+eV65vD/vN6gkrJW5FN8XQq6xnwbX3nASppim6nzSTKMKZne+JqO6tAuF7xSKeK3gTiwcJ0zpi1yzJpnmB3+FQrRdhUEH7wCe99J34iMEdHlYc8gmfW5vKTdGbet7HqwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(558084003)(82960400001)(186003)(55016003)(478600001)(6506007)(52536014)(7696005)(33656002)(122000001)(5660300002)(8936002)(38100700002)(66446008)(38070700005)(91956017)(41300700001)(66946007)(66556008)(76116006)(19618925003)(64756008)(2906002)(8676002)(86362001)(316002)(110136005)(9686003)(4270600006)(66476007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdM4nb+nsX9bxUmAUBdoe1sZtFw+pkoJw7uqgsOL5SCS1WPCYD6JjDM/9HTc?=
 =?us-ascii?Q?7+bv4gL14+BrlfAvPLPkD371vLqf1fZq4OhodC+Q2YFbdcxpr6SCVPmUKkc+?=
 =?us-ascii?Q?FvYrXkeSYLSmCJWmxPtreSZnKCm+Matd7W7NAWpdsYdlhI1zvQ06U3NTq55U?=
 =?us-ascii?Q?henUdNRIqK6LWEuKp5VD97pQmZ4Rg+7ZOltirx5MT7zDpM19lVZMJ/XKAhgi?=
 =?us-ascii?Q?783rVkvkwfc2O4MffLNnH3SHVDypWRjfZ31tmR/UIAH4sQ5J/aRQh6Re3P7x?=
 =?us-ascii?Q?QCHuF5U1zpzuTfrZyuW1FY04uI4seaI75A93GBu0nbNoAJqYorU0XxttGgTG?=
 =?us-ascii?Q?LUu1NEegZ45fa2s/Ypuyf6SrtEc+x3XEtypY/aDLoBpMaLE3o7ySfTSAd9c5?=
 =?us-ascii?Q?01jZ4yRy8eS7Hto8tmhov3d0f55N+TDD218S2dFRINJYMM9Gu2AZOyD8lgcH?=
 =?us-ascii?Q?uRJuZ6RHmygLSjtBPBnmrttUXSaZoww6IWBH4KrZXAdE1Lrl1RlfSMGC7HRN?=
 =?us-ascii?Q?Anx6gEG4KN+NNv78jRru0oVDXRTwNtzW++7nT8jdpESZTCIHPS8K5oLRfNFU?=
 =?us-ascii?Q?FqXXcRFI9t2BnQ56GjNPL03RQnRneWUL9KxJOlG5uChPe5xjaNPGbPLT1ZQX?=
 =?us-ascii?Q?W7YIKq5M6wZvR2k8j6Dlu3lN43EelImYT196MhwoMDEUFsp90A6MaV0qnUAk?=
 =?us-ascii?Q?0HW6QwSraGlPLFej4TxRF4Qq/w/NUZsgS9JnytfzufdG+ynOswSJdaFM2rHo?=
 =?us-ascii?Q?tmlWFwD/dc9DkhCtVkXuzTciwk+822D4llJlsUyCg9GiYo8QBzT7dt6HUOmi?=
 =?us-ascii?Q?nHMTeGcMX8HgprDpbGMxXGLQw2/zUFH5Fb+sX2c5QPnLwvFYGYXbyZsuZbjD?=
 =?us-ascii?Q?CjJCRanubOaBNUvQ8hcqQ8IuOEtR1tFytpS5xRu48365yMTsgJgsQy1e1oB2?=
 =?us-ascii?Q?vqeZkawM4R0ubUUbIOn0YzQQgbBLKeq7nTS/vdOLGvOT8IoHIrwVSpBsaANE?=
 =?us-ascii?Q?cc2uhl9JCL6EC9dt2IdAOOhtB8DeMyTVjI3oGhtINGppPrL09NnQQgowGk7J?=
 =?us-ascii?Q?IQXrXzH/GpEKSZMnRkuFp/++0uYrU+e3V6rf9hqL7El/vvY5GFwdWmT9LBMv?=
 =?us-ascii?Q?sFl+0BD63UyiPY/h1jt/JyFR3NHvyRirFXVsnZDy6FNLL0plyJ2MvNctPGir?=
 =?us-ascii?Q?brKWh9gDDkTduQ3fKVLeCDcItDcV7CCjh9nWLWWDh2C6MQfcWs+zVsXaddGn?=
 =?us-ascii?Q?GTpjR7qWSi2JBjWmTjPYvNrmr4t+3HEGQ6BHdX7+4Hg8Gl7mHJNMh9K4GCuP?=
 =?us-ascii?Q?5CJy/gXhfl6QAk+iEErcHRSqyAck5IMQjK95dJJNGOT9LYv4OoMrPeXRNKh3?=
 =?us-ascii?Q?XHQ/FA1AsQbiFJj2AxMdSDkHu6AykC8K2zVRtYXAvCHDffrDRDKZSQvP1F/m?=
 =?us-ascii?Q?nuViT2Aavu4gyujC2YMHxQSrGNcwzfibMbj+s19TIVI2JPzc9YpCxPcVkv6o?=
 =?us-ascii?Q?WselIBdAyvSCrPbpH0g5sR+4j5eCoHjkDp98XB+FH3hNxVyE1vhOtVE3AI+S?=
 =?us-ascii?Q?ZgFdGL0PkUcXVlP6l5U6tZsVqNqwL8adyw8fJR2FfLUZ0/d2OOZHIbYF6Jz9?=
 =?us-ascii?Q?GrFq2+P2Ba0J8U4WwwCFs/bSKFk2AcZox3rb9vDmfVstVie5/B4Py/ofU5Tg?=
 =?us-ascii?Q?Fsi53A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858d3052-9240-4744-46a3-08da9721e1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 13:55:00.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JL+eYX5S7ED6lSP3nya5BrNYFXmlFIltTZ8LRMjdHNU2yo0dsHOWQBbkB5mXWS1eAkcU9SEf9sZWAEI9/vkU61Ax6xRvI6ZhCi0jm/f53sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2259
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
