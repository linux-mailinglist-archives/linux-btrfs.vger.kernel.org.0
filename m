Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFA5B9D88
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiIOOlG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIOOkj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:40:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675D9E0F9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252696; x=1694788696;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dtBcKmOqDYdsrI1CS1IzL+f1tX/fCsO2FntqX+uA3ozf/wqcJflOu0B7
   HP2n+qacaz0nFvYBNn/dmQWW4n8QEKyonXNJ1bsSTF1/5duK/GIbDY7PO
   rAxAZylpC34YaARfAJmBCGyxozUxnXaNG6S5+PFmfFjcHOncFrq2fCO+9
   EI3GLZjanHbf5Un3Peyn/f6F+u0dNbOpFWd8Z/j/XQLffthVSh1JVSm0Y
   mNhqqzr6CWovgS+tMpdYceFq7CjgZOoralZAlEsmDPj7QYRUgxi2eu2Fy
   k+6IGFna5ak0+tdSaCB10ndVr/+py83nmChJhqeNMjANdnKI+G8p/FcSX
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211893357"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:38:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hImpSc3rR7M+xteyWztO0nyI+bogRK1r9bzlz+/DYkmnMVte1nZbRvhtc9CLTCJ0Ee+jOo8HjUNDUMLeU+3YboiHbM7rrF2N17qRrRcCjebgquzmLzeAUe1AYx7iu4cLldERQ9Yv6xv4QlKNKoU+Fa9b2iy12XP5xsiO/++OFMMIyxuNsznA0G95MDsyd5z8REOQIJxUJFAYGmQLJsm4mSJtVfGylLyXGfBnIVIUD98nKMjRlOboJEvEt6Hc9ktO8XCQZjr95ni1iut1gfR07/M7XItq+2VCV9SITJTB4SkbYZ9fpSY+2rrNEIvr5pDuUMKFE1BG/UevTdya6GTqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i0Tivzif8BTiqFuk1/cy72/FcS80T/rIOZWFIED4t9d1GNkXnKJEnSbHMPmiFUW/iANfpMA8YgufDXZZnmwjyL4vbQ8KCKZoNx/UCGbqS7NLapS7BOXGgUCoVpaFY7P7IMBEbh76mtvTq/Vf/xEFZJSY6XBcNhzIw6ZuXr9y6ijfLtmTlBwuM0SQhF7wbtS/jT3qGefRwudIkYqNdguPF/JI/Qijytjnxj+8kX29utL30q/p33J31FicZh1/k4cgFtM4ElTmLeja4X9kJLwkXPPpHT3mVs+63QIXZlxJ5s7GZ2FMlnTucLY2WMQFx7e8ICA7eR7nhNX9CovkFALg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MtQipCcATTTbI2PoxkW8X7wcmcuQh9BDPurnj3KDxtzLEodDIIgO5ay+IjRQcORgnO0jMSZFL69G9opeKT5a2H4iZ17Y230vLIwqMomQQd/9KXr4fzv6Oa3LLKPoWjTaFBdJgIVEJMG651sMeNIPjljDaXP/LX/YPvY8GhZbRQ0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3543.namprd04.prod.outlook.com (2603:10b6:4:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:38:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:38:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/15] btrfs: move btrfs_full_stripe_locks_tree into
 block-group.h
Thread-Topic: [PATCH 02/15] btrfs: move btrfs_full_stripe_locks_tree into
 block-group.h
Thread-Index: AQHYyI59Yoqvar75yUmKCmMbnkrKgA==
Date:   Thu, 15 Sep 2022 14:38:10 +0000
Message-ID: <PH0PR04MB7416F28D79C88D365C6119819B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <6f4bd25183fd8844b5592259971ed4e060d9018c.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR0401MB3543:EE_
x-ms-office365-filtering-correlation-id: 8e428fb6-0d98-44a2-dad9-08da9727e97e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Cg0nl7wqo5v/R82kqAmYmvPaqgK7l/kHe/mtLSPLTYW893R/oj+aN+PbzgUzIfC6mzTNEVXL17Vf39QfDYoFxYVTSk6mEpZDhtRy4UA10lImQc6h9YHJQ2a3vy4Cx8EfHjLqgtxqSA/4VSifgCq2K8mllgK3fRDhIgZHaWF0M92erDm8V2+sCCWEvDPwOo1++BenKUS5WfZshEhmPO32p3ASfVED8M7dYdkYqPeTgRXeQ4lPiUdzjLf8gNhP+7+YxMp/86u5ftDg3x8c1mEyoZp8HDZylP/EkLSk4y9o70qB/biJqWAkgIwZthm6HUgtNrYws0kXAUy/5j/PaBdmhN2XnrUle6LyrAxVyP6OHtqMFe7qNJVzI00Fm+UNlYtmOpepANXbFKlG5ZGT/q++aIe/eTXOQUhRiYsvHM4OS+TkO0D4NbmuZbVwJ7SdYaQpQBXJ7T/+PUuaOE7PlCtQSmGVZKRdfLsEUe0qrvrxAz/q0zJY5hNbbd3VcojySGOeHQ7AwZvtQE7cgiF2R5Twsve8hIBxNFzBBiWgo+FiZ9m3ur0gGXhDOSWfpIXD7mQ6i3p8K2dj1TKfXlOJUHFzzlsezOqwkOgV9/HbZytjmQ88ud1qVgEMKvRsS+hGWamso436XonkrXMg3kwp8R4Mwz0NR31GuTO8LoL0UdcZf7aXbjgT0XUtESf4BDrxS7S97b/ntIq6+nTdcD29ghlXGIvCTx3RGwNDKumweHnCFH3j1qyJR+5hluxvlVCkjQseMZU8D6ASSNDuobCNCSGEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(52536014)(8676002)(8936002)(66556008)(66476007)(64756008)(66446008)(66946007)(76116006)(5660300002)(19618925003)(91956017)(316002)(558084003)(110136005)(33656002)(2906002)(86362001)(82960400001)(478600001)(186003)(71200400001)(38100700002)(55016003)(4270600006)(41300700001)(122000001)(38070700005)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?53XJRe8x40zYt0vmqTPY6gRpsr5+eBEhzhQ3VrsxVcQ2M7OECiBJf7+IJim/?=
 =?us-ascii?Q?8ub6ZLiyWgoAp44LXes+MT9kyZF6iOk4ldhOypdqG5jrUQgk3yIPTe0aYXBJ?=
 =?us-ascii?Q?fSFC9RJa3kziu1rAYO8TE/MsF/nUaacOqGV3N9VfwQb8HHW3qO72YYnClvmu?=
 =?us-ascii?Q?X+CrQ4MOdvLlV0n6iR/+N6RIJXV4gulZaC/OTJCWZE0M7y0xgxlR+2bcVBp8?=
 =?us-ascii?Q?sW11upPU7S+9JU+vThi3zeWY7vbU1Tf2Ia/2m1xBqRTyvPsnMMWjdpvmrruN?=
 =?us-ascii?Q?jnaarBUCZg9qTEhS47rKBgWkaRhQl7ALW2OkO1TCJZId7NaqZ2goBvDIczmY?=
 =?us-ascii?Q?LnLIEEVb7bUKcuogfPdVLYCxOvxUWvTXi1ZAlDpEZDnU6wR/24uFVjO7jTE/?=
 =?us-ascii?Q?LZ9/N6vE8S3Fpt0JEOX7r14b+G/sE9bUjGvMvoqwZqdvjpmZBhyFk2zjS1wn?=
 =?us-ascii?Q?GePeOWEsfj1I/+KdIaJ0vqogUHjWS1imAaSsHT8anAot9Sa1zAikZiB8F3Q1?=
 =?us-ascii?Q?BPtL9Dwy6Wyw3NkX5+himeMjuPZoPyqpcd01aQ1/kCv8mMC0O+K9n7759tDq?=
 =?us-ascii?Q?t1xHUGNesDCileLeZh3PKBj/S9EWmgpGqzahnP4JzZe88MqRyM2jgrnbsIKC?=
 =?us-ascii?Q?1GULHOhiYzqynB6Qb3Q4we+CCHOUyH8ZCstXOwuToMri0QsBmcYC+3TM2pD+?=
 =?us-ascii?Q?lXdAXvj78pyClssRnLivXnt82rrQwTlITFW57phEjbFDRmiydYyYOnBPrOqN?=
 =?us-ascii?Q?jOhz3a7RFXXeU+EmeFLn/UnWAx2kFtJ3mOk5vve6Rb6lPXJu2GgPenEHpIZs?=
 =?us-ascii?Q?1OlqGYOIsB1i0yiVejRd1Rrd+S7xTjZUIuoAIeBepOXJX/+YLsGNIrX4g9bF?=
 =?us-ascii?Q?Uhol9AhknfvbVxurwhthfb/VrfrZlRCO+h1bHzY99+xVsoL8DeCIdpM1VGKn?=
 =?us-ascii?Q?liGuRMqmi1UTEpUw+trzL0w42VebWd0nDxAsFoQ4Kz/Fels8KvWl/SpX31By?=
 =?us-ascii?Q?YBwemZ889BbuJ5oNZMseZ9wKgKumSwTe3WnFqc+ko/lMyqiepGKJFkclzTWU?=
 =?us-ascii?Q?wj5ZSC2YcD8rAl/PnWoZn+TNicfuhNYOjiUtS2Wz8RraeYMwQL3jLKLg4iG1?=
 =?us-ascii?Q?21Amaj479ur7tqOBmPKOmyoiU5b/jQosBDjDyJDVtSulqaOFyyKcXW/Ky1m6?=
 =?us-ascii?Q?sZF8c55I02zirR4fwk92JqAtXaaNizf0FZCaZI3erH0vF1IQYP6RMsn1karJ?=
 =?us-ascii?Q?MIw/kmKo2Df6RoH/cPZndR5Zt8B27dkCfpeGseMW2c2jQEAVsd/nNKi2X2MZ?=
 =?us-ascii?Q?eyYyLomqaCH6p36mawXepiId2ziaDGhq2m54RIAfA6OiEpadZvfGi8nsLzJO?=
 =?us-ascii?Q?KLCguE28goPAoiGNAENFaS58Tdmk2elcdtj5MWYUJlqC8qc26+FKsw+55kAs?=
 =?us-ascii?Q?2rPsx673299f5s5v4A2ue1uqZXsEJ7MlhbdsA04S4RetjwQeGKnEz6dOgrpa?=
 =?us-ascii?Q?9+xTHqB5ZzgjvmrzLyn3hIkMEl6PSG99m0E9SUy8DTX99XeunP9N1TnkTlRf?=
 =?us-ascii?Q?634rhGMimViu12oFteinxzNlaK48Wo0sm8iacwv/iN3JUQg+eBLS7Qq09OiM?=
 =?us-ascii?Q?MeE3FRYAlhSzk/6il2b9Tna5jCmPO+IvQI4YJ4MlaWwE6RGG2oHHSUuvrYAW?=
 =?us-ascii?Q?XfJVh9WqC01BZ1SgSkeGetyN1Os=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e428fb6-0d98-44a2-dad9-08da9727e97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:38:10.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wsjYDhnZ7FNpmSUujiE/Gk1wICADSh44k+NR8RzFcSKyD4ii0finG0v323y5MDqLG2H3wNVBH0XJBBJkCGIbiTz9OM8N/x7li0GPR9Peaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3543
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
