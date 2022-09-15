Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749D5B9C74
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiION53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiION51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:57:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5539A953
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250245; x=1694786245;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=K/yEl2o2bV6ED5/2UoTabLc9B9CV4fegKplHEG+nD9t8frTJjcM4RHtG
   Wa3dHQdng1Gec8vJeHE4AGDplh/EfT6ZsMbnJXdEhphFV6Q93bOm20VWJ
   KieO1ArhZ5WAFN05Xo/xB0S7iBN06MHyPg3FiibwUxMZzzWC1lBPVj62B
   PAIk14ARLCjkrHySGwsc7y9yg+XA7aEWVJDJYwQe5WDu/CpkfGy0qphN0
   t76DJOVbSXZj8MXZkemEFBOiZF2FFhXv+bzp5/le8W0GcRIvkE7rYv0Ik
   WCjtK0CNm6oDOhCUcNkHkyQAhGO5E+/7ICYWx8BRrU5sBJ5Anktjou+S/
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="216606151"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 21:57:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B89lw3sUNabTZCDBTBuDPgv8cOpzMOfTajNnva/Dpso3wWyS9LOTm3slJaxfzE99J1yrUdh5PZaEsnrqnEdd0Jtqk4IzCdnL/pwZ0flvvXHoijbfSCCG6vC9df5Ot9thB5ENsOr3xFNOiAGCjVQtAFrHyhTd4AtDZZbl/qNw9yNY1GopI85QK14WMnTHgaJ3rVoFScaBIVnPcSyrqXJT7D5yHO+zwhwJaI8WlPU2Gzt4JJlw88wXbwKy3sNMTBAD62UX5u0dRiY1IhmJdEmV3wENMOdmlh18C1MyqjhR1eT7tg3pTMtcO6EzCxCz1ZjLOHl9kVaFySJp16ztcmc9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eXhPdlt+gk+8n6A+PHV2DhJ01+CGSzwvYEIt2OUuMs9fSA2DTVv2q+FF3FCfqNztSKOmVf/0tzIxtlCJtPwT4Yn8Q2Vkcnia8bqqS/QIeya7fI4ASg6XCjeFF7Y0jERMwBEinLvL86ydW2Aj7IyTrJuj4EFUpsPCboDDjYz+XmLliLvq6A4rYFpid5YkscZcyeESqmkptDb3k7iV+AIjn+Cb4CDOMhicl+cSUG5yonKjtXrx6Avf6TdGyP4NSgQ0dBmjZ/IA0b21h2969CnoKbQK7MuFJmV0uIvgmE72xyIEIykX5jStpzUiRN9AZZ1qug5fJZs+37HMmFNaUHKgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GulHsdBYcDCFJCHUlJfj/QUtE7T3vjtJjy7ibw0oprryO8EYx+iYn7/523FZpOnur1ifzVEZrSMQPmp6jWdTHLslR14qKjGcy83VMOtG/NxBK57qvxmkb5MLlXZgS+A6RAVhFGgOggU+XLc0j/0b7uqZOiNYsUXy1KNJFfJRRvM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6108.namprd04.prod.outlook.com (2603:10b6:5:128::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 13:57:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:57:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/10] btrfs: move btrfs_check_super_location into scrub.c
Thread-Topic: [PATCH 04/10] btrfs: move btrfs_check_super_location into
 scrub.c
Thread-Index: AQHYyI7bXNFtusZjYEeYnTP7XfoLGw==
Date:   Thu, 15 Sep 2022 13:57:24 +0000
Message-ID: <PH0PR04MB7416B8A63BF7D2B0C38184E09B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <32978def2ae6a480ad5734ce4d1c5661db0206c0.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6108:EE_
x-ms-office365-filtering-correlation-id: 92d10ccb-e0fd-46ca-fc47-08da97223788
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3L7g+bYwm8VUs5dyevdizq3SdlMXCbiLoBbLwxRrLXLfj0Losgug8Z+g3/dgpaNcjMmf+oNriW4cxmFg+Tokepb6ulkEY5nN15I8SrHzKZmzEDqJ7n3HkC9N4B4PWoQ52R3UQFTmcimK5v8p70Tqf+RXyDbw7dQAMGF16jOjMBDuKxsvCf+D1KdxNTdYzggO6n25vxx/GPtzdFE6R4/qJGLIwPxJsJkgfVM50WDjI2Ot1pfA9/fAR8DI9lG1s59ljctrpqnXZjCh3B5/TRBcQBj6CDNP6a2C0/kbVn2j+YRptYZ4/NES5p5z9Q3IF4QvUgpnpulipxmjhi6DJ5H8EWWGEe22XBy3WkwswX7ZpDn+WJvm+3H+OmAgX+FBBuWbGwqpoq7NxfDsIWbTrqblf8zKmhGD7gQ4rvWoP0LXtHtMgn2KCtE7w/E97rqNUG+6jlj2mNdhKgSgI4CDz3entOBjYGN771PcXEMGcQmpeSDWB0FTOM+vf8DPqmakdxMDIfMcQ4wos/BzH0dHhoZZ2YnhzrmDLgoRUXcSb57y7KiL1ir6ydnU6ot8j3U+X8xTw6Yi2OWBH28OgntMi6uClkBX4p9arrc3DTAK0b24X3YTmR7+6S1LFuAjBXwcRw55ofLObHAIvOuiK7ucGO5ELOuzyswbrtajsZ+jvcZAQRQ+lXVBju7LU2UrdRI4T0ITNJhx+TF6qtwBu6Qq0jwJyEaRv0lGHJsRP15XrBjaiRoyseZzT0V3S15ih1kcvA7fq834q6lrhKO5buAi0YiRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(9686003)(7696005)(4270600006)(55016003)(8676002)(6506007)(186003)(19618925003)(66946007)(66446008)(66556008)(66476007)(91956017)(86362001)(110136005)(38070700005)(76116006)(64756008)(478600001)(558084003)(33656002)(71200400001)(41300700001)(2906002)(5660300002)(52536014)(316002)(122000001)(82960400001)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4kiBdISBuyFFwQ19GVZfo6K0Rx+G/OlE88fnmn1062xpPl8+XgE6keoEXJ0V?=
 =?us-ascii?Q?tQV1LQESRJolEowKCsAVVm3i/vhCCHKPrkgz1vh0e0e+gIRtlaqlhqIqSWxB?=
 =?us-ascii?Q?ODw+S4gfTudy4k/eKtd+PzATz/xPosejIIIkwywV6gUwp/BbJ5Xw0/rkdUJL?=
 =?us-ascii?Q?ECFhqi3YOggiLo+FJbYTfHsGjkUqmT26FvLIuZH6EptdI2ZLAF4ett0aD9XY?=
 =?us-ascii?Q?wloxy1f9Nsb4Oh/+pmmWgDKD6wqC6kH4as/rpQ0bLPqishf+IGmSN00tp1qa?=
 =?us-ascii?Q?OCubcApt6EuAh8mgm95wRvLq4M2hzoZIsEerhZF2uW1biuR+PVVVToWFHkIP?=
 =?us-ascii?Q?aT3n3G5nlC6aeGedAoCQzChEfixzzNL2hsP/ABGvLBTTwWTht0i58daQsVgU?=
 =?us-ascii?Q?Pgjqd42LWCvq6eV5VD/jHBWPkVSeqbSvS75oOc86jmkdvbOHZAZnXLC2VpzG?=
 =?us-ascii?Q?/SeHVExUFuU256N2I5ieFVX8R+/L9oHjqD4pZsnYJbj4oQiZ0upYw5AG3UfU?=
 =?us-ascii?Q?m+ttzXZ81lyXQr/vz4FmnoTSpmLsliu4KCEgBZ1CVGdwp4AFlsrVYizWjHmf?=
 =?us-ascii?Q?JP0tzaTf1is+JvBirS3EyLrb+/fh7pF2r/R2F2CvZUjJjqMJzwgcSoWWvMFE?=
 =?us-ascii?Q?9pu1RlQXFIvkA51Lq64PWvx8An7bEZ+YnNxM86HLTuSs/m4cJebC92x8eDrQ?=
 =?us-ascii?Q?tSodZTr2cjHinamQtv2eqOD/f78/HvpeDiYlnWIi/mdJQYagNUfrLr4hygVa?=
 =?us-ascii?Q?yKSFK4r2vK5xWnuSw6lFsjb0ZZxofZwm7FVPk2KniVUyTsFtQNwWs/MUmGTi?=
 =?us-ascii?Q?sX8GJdI8XkJDL06bqx3/A/QBlhX3OI6uqayru4jSAjEtjiRAMtNLKNES+F3z?=
 =?us-ascii?Q?rNGr5ApByMz3TuzzutEviezbJoBWZ9Zf40giybikolCCY2V/4xR/H0brKdkR?=
 =?us-ascii?Q?Ig5DYlk8OFzbU59QXKRiEopsvxcliMEySfoCE+TAPfw6u3LdSbdpNw0LCyqU?=
 =?us-ascii?Q?TMSZ+JssAaeC3cG+BYLOs9QqcDmoXMmnatsR+gY3IHnQmjSm4xiRYnEW1Alb?=
 =?us-ascii?Q?TetbPN6LDYde+HjI6M2hLciiHMZY17wLWlyW2zvi7O8jdRgqWFaRyxE4VnD3?=
 =?us-ascii?Q?QlU67e+asududSUlK4Z1Fq5keBbOZSZSH3D/ZpB9JRpmAn87ubkHkoNTzt5G?=
 =?us-ascii?Q?vJb8SJhkYoIZ9WuDS0IPT0qjfJdl+k2LmZt1YltivJMnT1j8XkfqGspPLq3O?=
 =?us-ascii?Q?B6w6fZSYeyRzQ7XsXesaUW5DmOybieW88eYu07XEZpZ3RsxBPv9JnGJsBFhJ?=
 =?us-ascii?Q?DUSYzyfJqTl8x0bUKV1Q2UJ2KkkEZHeetMdHe1+oPzZ/p2JkWyzyfUkN8yeP?=
 =?us-ascii?Q?TtTfJ05M0sj40u4qdWRH5rBmknBtOh+P1RXXOqeG/QgxRj3guOcx/Zy/RxrP?=
 =?us-ascii?Q?RFJQFShXujejriMMg6oeW9bpZREAHGbBGWTxWTQCAp+wF1av4XLPPXkhg2dM?=
 =?us-ascii?Q?r16IycDF7Feu4Vn5vVp0g5r+eeqi66Gr7TlROuWpwI5kfvoNO6KAByzAXj5M?=
 =?us-ascii?Q?+C4f/YKdxhBdJJevRAJFVXP/py5tOH48HK6kmM1ARe/leJEug90MF6HpOBid?=
 =?us-ascii?Q?dSrScbIrsLVrFdNIs+wWkJZOIsBi5vRImuWIBhMPXaiYMrr95SVBdUlzdGY6?=
 =?us-ascii?Q?c5GRtA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d10ccb-e0fd-46ca-fc47-08da97223788
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 13:57:24.2596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGbtDcnSkMYW5nhFylIGvyLUZ1lmdLo8vC0015SgFP2YFFRaAruG43z9WXvLpLGhr1OEYx65oJkTmX859qziRZZTSCu4N2zITVVy/rWHy08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6108
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
