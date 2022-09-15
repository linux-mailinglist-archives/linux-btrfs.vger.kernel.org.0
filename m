Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A225B9DC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOOyg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIOOyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:54:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C20B84B
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253673; x=1694789673;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=a/YtP+FWAlopUyC+e/x0niJVQP2HROGxIFmrd/k5l5yefqyjZk9E0NMP
   XNcAXrLmx7ToWSd30ve/jR1/CsU18X2pl6en/bVDk6ik7PiT1z0v6ZmyO
   bevYxCeVZ5C0G6bDAcvFf852P4TwS7bp9gbGtYTZxPTvgTvrm0pGHI23T
   j/9VuCtJrKeZaCf/hOURnQNvlgOI/xHnPhW1Mv6lArA00Ul/Q0juL7/31
   A0+jEmGPGZhF6Jwco/PO8Kl5yFWmmNjrdxdi37G73/OhoO+AZ1z7TIk3F
   vZgEGaspsTsEL64NUW+tFLU2Kw/ID5StMH3u418FZIzTAbtic+yiHOOvL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211441837"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:54:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOVXSwNFensa1bhpXoE4AU84ZQfDmpTEiOdjlT6earffqn3b++pmkswxeNktDybdNh2lFetVBe2DxJEupzdEWS+Njgl+JIMkv4zh9EPfIQxEdWrf+tMy0SGa/R8h84nyPXptne4zmCHjcfsXBfO1zJ3Wqn/Enh3B5ZAQUQl/4Q8LrXpwzAiNUIbseEph9eMm0x24MxyGfqKacS03vlsgMybDUJ3llV0iDgpAsDO1vbM67wQkaTS0JVYZenxY7Cv5NM4+CPQuIU8iH4XQSuoRkgV/gVWeq21LRDAK66++BYfJ2j09rfr5f/jzGEMcqkzzChpyBd0F4JSiNT3hpSPyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oL/JdIU8Y342vl63Za2EE5pfVyLPmSqwUH+VdeP9GnSsh605ym2KM+PJ2nIBs/QcUzfN8zTWXc1UueSSdzhcRHuASrGyG+oGRz939Khm2laPDPzB2krajPBE7KpM4brO+MknsJONUQk6V3fo47ipAX1uzQxBTVOsiLKtdSUXXloPio5yJdoJQZu2KwO9ajUDNwm8YqZ/PxfU+pH0OWM6sMxmXnuxJDOu+cyLCv49u1WctAWdtnN0TRFfFlNc/iVwHJ8HzJb9S/uqi/isuMqqvhWjM/Euo9oFg6uPLc8SOSi6RHfvsBbR3fLNEZ1g1VwugQINBKvZ1swyFd0O2SWR2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MY9PmrsvtfVam/VZFwuh7oBDfvdpKxta+CsnvuzV4ke0H7s6NSA6CGgLrjxvlWYsjeHkw7t7OFICJe+q8OELfjqVCODoRgQlEr68QKWSbM3LLiSpgXdz+SYkWt1qvUcaEg+1dtooAKyqftbyMwnmZCyCqOfuN8pzYwPO5PB6rsg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6543.namprd04.prod.outlook.com (2603:10b6:5:1b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:54:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:54:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 15/15] btrfs: add struct declarations in dev-replace.h
Thread-Topic: [PATCH 15/15] btrfs: add struct declarations in dev-replace.h
Thread-Index: AQHYyI5/KT7FAw3mg0uOBuaaykbqHQ==
Date:   Thu, 15 Sep 2022 14:54:30 +0000
Message-ID: <PH0PR04MB7416A4B9DE48ACBA4B99C53D9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <aea129f8e5420561d3f5fbeaa0de297b7122e815.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6543:EE_
x-ms-office365-filtering-correlation-id: 699da36c-4701-4cb5-667b-08da972a317b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDS88oCH2Pu32+RkOHMPw69Irhp7dtQgY4B/W0ntDW82HX42MTjdpmkxySDkkSmApBX8lHma/9+v51Sdt7gXMbOTiOTOZcaY/YWT/OOYJwMpXHi0EBgpemRRl10ULXAB8q3/s9DU7UPajWt/HDVCmWOteCtkxjHPltyvkE8WYGkmxGE0Mxr8k63Y3NJtv0SAIiBRIf/eIwnGxMNICAKK3f7sWdbdAhMLuoUCoQMbxWG2b1DTiqiXI78VMly8JLL9GFBXB078ceq2QzXmUFj/SmRONBmtX+nmETGij6qhdQpL/HQ9kNRjjeAsGLKiIriSQFPpEBtp+c+BmlVdTFbUQsS1+D43ei9BVRrxGliB6J/9ZtJS7u2tNeFBOod60lRLwXiCJ3NDozynir6R2oiAB+xaRN9x8X7IhqrBXRBYWHrbiLA7Ct7J204mp3Wz5ztIANSvvRgLj01TVDgGhmdKI1jxdtEOM/5geP1QjpZ3LGqr+fw6u5ZrfJE/dqjR7Hp0sWqsjZoKJaUR4EqdTMP+92P4EELSWoz2S2fu2gFUiFWtcbK9fJC3b6Gqce0PgZbrtmbtcm2wIjPmiGe04KOJ9gvk/UcMCno1gML84tydULooVHAhpKDwREyQAQE5qThcdzQYdH3yI+mxbKSrH1npfsqgu+yxqhNp3g4qPF/5jlpYz3Fjw8Rr4kA7f+AAj68NfAUzl9P5/dcMp+jIamnEGSPWv76y6do4lX4xMjC1kSP8u7PTvz47b0z86Rxl2gWQePw2hZnB2uywYiv46ppLIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(41300700001)(71200400001)(9686003)(6506007)(7696005)(122000001)(110136005)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(52536014)(64756008)(38070700005)(86362001)(558084003)(82960400001)(186003)(33656002)(478600001)(4270600006)(316002)(55016003)(91956017)(38100700002)(8936002)(19618925003)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QWopInijpFgEhE9F2OcXf5a5kyMRIbk75PE9V2sBCOJ1Af+sJYGMEIUHiYH?=
 =?us-ascii?Q?sqatzhz/wBnlsl7WpgKNJdtE6dYSDz+8a0oye3rNj2bipyHwGcNg4ZlNnFhW?=
 =?us-ascii?Q?6fcls/TpuKb6mwzhxQJ0dArHd/szBgvLaBR8uYEsx6uOBIi/ZvVC78aAUqwx?=
 =?us-ascii?Q?dV+ehQawpjLzsvC4VN2RXIoqXcrXti60by79JjaVHVVOMszJzQxeDNQ032R8?=
 =?us-ascii?Q?UHZWl51SWUgRApQ7XAMH/hQI1m1o46aTzSld0TH18VBBU/dIGpHnJn0Xm9Ta?=
 =?us-ascii?Q?LyZj3JKt+J9JxnRWVG4pn2Nn3Thk6TEls8ghlUmtcrfEALHYLcOexZ6uDLLY?=
 =?us-ascii?Q?hpfRLZjZ6LHom191/niXr5gI3Ledo/VS66U6s+mTO8k4Jfoyo/2hZZYcj32D?=
 =?us-ascii?Q?tJyy9thFmtFp4NGh6rjk0HbHfZ1CopUtEtjUhVCN+qWMr/NbDi8JIGB5NbjU?=
 =?us-ascii?Q?GK6f0YMWvsr+fXRqDm9T4ip7RIydPQk4SjRoaADSdT6NebxkmIHIktHGWgzj?=
 =?us-ascii?Q?nUSs7sHvWkTvdw2x9ZUakaXJmfUQoqTDE1xBceylcoKg/yWxbxa/xdzqI4AM?=
 =?us-ascii?Q?OdQ91XYi5BSoBSKg6pLB4xkLAjR/ssfV0BA3Mh1bVCbSzpBiq4TOMD0LlDcd?=
 =?us-ascii?Q?U9wONWKvYbZRrsRPiWXpwkzNR4F3vXlQ3qclvXblhRS2oo+y1x1YbJc0GTa4?=
 =?us-ascii?Q?Gu+cVTYgGTPu404/eyYG/hawM3iWmUAkfrcSyt7zWpwqI00PnpY+UZ+whETn?=
 =?us-ascii?Q?39/sbeTdy7KcHFp3+A8fPo/GvvS8bci+lWjuyc1pLYVjRjpUVspSlbbTq7I8?=
 =?us-ascii?Q?h+Hshlh5l4MkP/vbH1PZsRgbBAXP32D0AYyAiLjR+FKnzcv6L4pWtXkB21PM?=
 =?us-ascii?Q?gHMN2bjMjBen7/MX8WemGeLzFpaNwfBDpT1iEIVEyDXf4AoXa1OxSd0/REEp?=
 =?us-ascii?Q?Hv95yG5jdJlSITzjPxOrW1DvoTQ7dlv0YO6jg22O4A5S6su95TF+qppTSz+m?=
 =?us-ascii?Q?NKXa46if4KfWiG6+uljwpj6QN4mPGEClW5VtqGDjSnZlY9L3ph3o9fmg1936?=
 =?us-ascii?Q?/f+UjZEd//M9LO1dNrZEnYj+JuCRyOtmpYrLlvL5FuRhfeqPYC0xsvqp9ss/?=
 =?us-ascii?Q?0WFIU01yqFaQPklqC7UItKWFdzjQHBlG7JLjumu4vBADcxmRWTQNzS0+Zdl+?=
 =?us-ascii?Q?Wxab+BD9iMOmaEi8uM5ttarJFoXYN4raoUyvCDc9EOHdQUDwHxyJqHwfnXAm?=
 =?us-ascii?Q?TYdtnUSTw3hbczzZTBkQ3NGjDCEFKmW2JKWabKyLZrRXWbH6LrwJbklhqE8i?=
 =?us-ascii?Q?mVTNW3enBzbmldvXVutJZJuvxT8bCWNuWCcUQL9F+wE/wJGpJJjHJg6oKs7A?=
 =?us-ascii?Q?vhhfzcF/pGG+gmfIZpuOAPXi1HoiWA06NmF6SHxBpvgd0GR0LIJihs8SCoJy?=
 =?us-ascii?Q?xLJznm9dTKVCkWQgIhlkOE39mKqr4XIFoWHjYkOomyzm+OI90lw65OckslXh?=
 =?us-ascii?Q?W3TpHtmHk2OjJouBnvR0yahwA0Q+n4E11cY/MaNb5GLdGk4rL0Ltq+hwIG9x?=
 =?us-ascii?Q?c9DUFz4gy3qg9mxGwp3Ym11qQaXKbZcmB39paE8nDXeobp47KxkRzy91wVZ5?=
 =?us-ascii?Q?E85Me+CwGdX+L1oiiB5iVZ/YrVnHyoFn68wn8IaPnH3cdAQs3L71gwke8WO1?=
 =?us-ascii?Q?MWeD2YcDDDb236hLFFFxYXBUa9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699da36c-4701-4cb5-667b-08da972a317b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:54:30.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r027FxOA2Dt2CZ2LqZqomqgYpMaLibBnh12WcTiaj6lDqY1DA7HEBkja1N34fM0+UbEBF2XTWljI4OO8AWlLlaag2iEBtO99nJYPWMkhB8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6543
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
