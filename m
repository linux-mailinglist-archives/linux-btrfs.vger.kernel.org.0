Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB8575D34
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiGOISK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGOISJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 04:18:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578157FE42
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657873088; x=1689409088;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dHR4kogUllLMQ9TJmSpygJm21r9iBGRuZM90uw7P/Lc=;
  b=A+W82zSdwA+Etvc+W8Ghm8EcZcdzbCm4BOPyJow1XjEK5x4MWrwO/9Tz
   +hciFbKZ6i9PTJQWnVhLeP26t402GhFPlD3LVG9zt3TAmD9+JhHcENQsm
   0uzIu0pv7MPkXpkLTJgGbkUzinf8IiEcp0nKL/cIzIKNPBK2/OUt0d+76
   7l/IPg7GJkW/2MMmaRx5hIQbmjOomWHLNM+tkmFs8L208jMkLwPLo0hQ+
   ycHsX2CoCEibnvoqdJJ41eoWLoc5K8nMzFGOQayeatvKB4FUnZ/UL3+tq
   mE8wxkc0jFHkMutKuTp0EoF28BAkSob3UUrE5QyFYj67Ys6WZcMsD1sfK
   g==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="204455203"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:18:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3Q22u6xQdXWGcFKyBYdZ1dV6Sq1fdTYMhUT35Iz/s1z6mmwKfm9hqdPAbMPr7qwRpSCcFlih+IxokFAE5FNj1EP8baqBVS0ojFJAWBbRNBqDi1GQgnEe9WUQgMxMADRKch6Bsn2Q5HjUgBUsijYK7yySNkiAVc7gFDLX12ykctsSQ5CLvxs4D4MH5V1xX2qRdfXGWAllHDXm8OSsouSZXZcBrxTv7DbQ0aHkaHTVW/EX4WCc4nfYSdrYNc8bstKN6mNY1pdXHZNiNOFf/Bqvp5EZ++R/oobdDBm8eCni+DOpx5x8qN1Jw9B/lzejuIQyyA9YSZxVHfgkvwb61ySmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExYw0soXSuuZVuVBIciUEfMfcSkEFOq1yiaMH9NG5D0=;
 b=nabzeBU4qdX9o3AIeR/5T3hfA0QviufvwHjsraM831IzWG8FjYiDCVugTPVcI8Ft6dsizyiP/SzENc9vEH880CR1z2+ocI1FcJv6RXmL7HMy3OXakEDfJ6f4eLFJmuTA7u0OXhuT39ORdf6oRLOgfrZDmx2KUqi5E67lflC/34Z2zVgZik2Z6xbQpfQ+S7qi0VGiLCqw8J4VYajwGfYE2CxRjKUsosA8rJ/3kns5Z+06WxYDP37IffKnMoVNkYeNYDWy2cT5bm52l4rGfTkCQrVLDNWmnfb6NzCvjzWBFmLKF0I4uQXrakL0wpT5ye7Mb32pYOlLpFd/05OphYUOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExYw0soXSuuZVuVBIciUEfMfcSkEFOq1yiaMH9NG5D0=;
 b=u/5cF39NFOUGl66YFQ1rTfLbmRha05zljTQibVaI/bSqXf8tHfx6MKlu4RoGOLub1k8QMo43oWwD/Gp02PGIyUcxf3Cvz0BMpVkepk8EuwdLIEoCvhQiuU31RyF/uw9vPnOPPjpP4pJPFw4L2hMh+r0E3ZT7cIcDa81GsPRTAPw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6481.namprd04.prod.outlook.com (2603:10b6:208:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 08:18:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:18:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Thread-Topic: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Thread-Index: AQHYmBhF7QwMy6jcLEGUIrdMeDdI5w==
Date:   Fri, 15 Jul 2022 08:18:05 +0000
Message-ID: <PH0PR04MB7416EA7C6195226B2EFDF7E89B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657867842.git.wqu@suse.com>
 <d0096ee10270e00362471c7a842aeefed20806c5.1657867842.git.wqu@suse.com>
 <PH0PR04MB7416789E6373C3685094D8009B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <2c0d5fa5-a2e2-25c7-9687-cfb12ab177a4@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb407fb-3b6b-4bf1-0236-08da663a8af6
x-ms-traffictypediagnostic: BL0PR04MB6481:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/abvAMw8LwjMW2im6UOFjWcXgEhW3Q7jiGflYwvPSmSh3bKz/VDZZFeYISWl17JUiZOx9bxCRUX47x1MXbiG1S5DS0WsQXaLpvOl0QLsJf15HzkmUGSvrrs2QL2czU2wZrhXByAgoGzi0M5BAG6tVcyW8YaJlQff1OtGkKuvYHFTrXCHT+ToylJcaqmvF2KY8FFTVz5rqyzCx62idxCjM4tsgoYLFYi70+dTFiIAQXeedI+WItu9hP9QHeRUTW+7lC7Ya/q+Y94yH9e/ViH4CxWjTa9LGzT7m7aamaG3X0ZFHKolz1BiZub8DCpFOE3q1w5Sa0/GasgNWjdC3E6FNY1H9a1vyxNbMgyRxFpcfy3aG9IvDW+8Wo7bFqHUJ2jQEJlyf15FlHIJKZCHoCPniLZdo1K3uqR4F+nw/3dOMPwD9to3Q4ZpGYRDBc8NdSQbQVrxUtLM3ctkozhmtVVAo6mcxjVCeA/2r1kxqd422nwS8SbstZR/rhbhNm6hdhJAMCOp67fSDthbnRaSb93ien5N+3RmHYQHg8DtcK7+I+Z8R5snagVf6Yix7GFM5YAJFdYNSNMf4VYnJ9Css9jhplem/H38xGpLIXeI04I+RkSUiO0x25vH6jJKgH022y+8JcZVLsX6FXiE68D04xKfhG8sgdyfT7FXMMyD+CW+j9YYL71QFkTtP0b2+UaQlPuom6m6SdDqO5uSyHAFAR1EUmNH1YIy2xmtT6x4dI1lRwC9VwyXObwal5wHePslgEcV3V1gjaG71Vqez8pZviStpMV66eF2iTwNKMhuJ2mAr6Lqt78xirWqf6wp+WyHo97
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(71200400001)(76116006)(52536014)(110136005)(316002)(186003)(41300700001)(83380400001)(55016003)(86362001)(478600001)(8936002)(6506007)(9686003)(53546011)(7696005)(2906002)(82960400001)(5660300002)(26005)(38070700005)(38100700002)(122000001)(66476007)(64756008)(66946007)(8676002)(66446008)(66556008)(91956017)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hRCe8Jqm6SvC1n6ocDe+5wxyhAcnpYQrP28RMb9qLtr9TJNOjjg26bt6onvN?=
 =?us-ascii?Q?kTK7kWIcyc+Iicb92Gy/PbIWsmao7dUa56F2Wma6r7mOOQxSR/ICMUrozxLU?=
 =?us-ascii?Q?RdY5XnQx8/j+JRJBQatjhkfYag8YVT53vMk+bPLCcwv32+WeBKjyP4xjxNr4?=
 =?us-ascii?Q?wIaNvkVfPFjN/4T54qAo40DESnQ6PSusfbeFTluzJVYWaBADFTsCqLVL6Zfd?=
 =?us-ascii?Q?FVVgC/ftzAZsBZCSTcfkDilrIjeucVpas85s0utU7yh1VA/eDGOTrYVv+Caq?=
 =?us-ascii?Q?S9QKobjtBm8vu5BT+4dYFeGBiRTVY8sWpvXfdrsqPYnpg4OA62ZNDEPGCxPr?=
 =?us-ascii?Q?J4mEjknpZRaD/ygYIO/eRACDODrYFG265fyoGyw9HKqbH6b9epubB76lwhkx?=
 =?us-ascii?Q?V4woUzXz4YuPtkEm57+/E3ZXZtXc6A8YgvVsPr6djOm0sZTFo409454742Jd?=
 =?us-ascii?Q?emtLRlDNRMwlZnTmYgpdNI8fTRY7E7rfIkmB9aBEdv/djv0Kx2aqvMGgYtK4?=
 =?us-ascii?Q?OyujZvmKUYAbrz07HZNRaj3FTVt+iobgGVSaPXBTA9JVckKEmZbdbQ5veK40?=
 =?us-ascii?Q?o/kUrNVI8TohlA9g/wiNnBQVMTpSAw/VaLEkD5okjtMBthEm/OTqzmTYkgtY?=
 =?us-ascii?Q?H1lcYDexrqOqQTQLna18sT/SHtQux1pqyKOJWgHgG52uwYsKQ6Y2I93V+q6H?=
 =?us-ascii?Q?0yyZK4Ujna3EdWeHO19yTeAENCyIKvf+dba0m1LOn2idqzS4Agjo23x5JgK1?=
 =?us-ascii?Q?ZhZHgzF4779koRUHNSvlXSxpkbQ1zYvpxhYesUEYgO0cVI6J1LtVNyVnZrp2?=
 =?us-ascii?Q?SSnphAtffca3c09QdSjNQ/BBmaV2GnNuGSDAWNU/YuLqVkS+XQaiRzqCVUXF?=
 =?us-ascii?Q?0StWrDw/c3O4aUtreY9Ndp0LnaL3QJDiVgY1OI5WJUsBjF8o3mTgWQVQtTaH?=
 =?us-ascii?Q?GaJtHVQG1LD1J02NsJgj4OQXwg63Gtp1gb78OJREH+WYDp+mjlDLfu6jV35e?=
 =?us-ascii?Q?9E+VPZQKOYk6Q+xq1kro1nqz916no49Tx4AcA80FY1M3bfFK08tAy5kN6m5M?=
 =?us-ascii?Q?BI6HEDMYlBOaF9dCB5J9+K122DSRxMYxuYLn0IRekCDTgSCdazrNOuf05Fis?=
 =?us-ascii?Q?epu8jSeINCs0x6KncX+MW02bIofyy0hGV4CmkHP2Lvix5mZhpGVvahsFAj65?=
 =?us-ascii?Q?pzbfBn6lccyuak0BwOVVlZ2ecNqL0ZBJo9nBBxdRMNMtKi8IFpupwBX2D233?=
 =?us-ascii?Q?mwDChO8MRIhpvHAVxZ6DFdwFfLxpOOOQRiPEAlJqpCXEOB5SErnEhI7ohbM8?=
 =?us-ascii?Q?/UkdYVANBY+3asZZ1Muftuu+B8RTddcjYvqUXrBPgyo/XaNRygHLJ1suxVeF?=
 =?us-ascii?Q?Z8agsCh7MhA1V6QD5UCfKbnc4ey/4cLViJIsz0n0wn6VNSfK/q4YGiXDqGBN?=
 =?us-ascii?Q?39FUoBEqBIHSJPcRtLrZPk7i/OR7G9xxMk6MiU8V1BDipCdC43mkdZegKK0y?=
 =?us-ascii?Q?HtacZNfuPDbnEh6ndOjbk9c1A2fzoA6Vm4AXlkMKOyJGWKOWFA9rNeDOxWvA?=
 =?us-ascii?Q?l4kzAc99tLV9Y11NZAt7BODfCpy4tCXrWlvGtaZvlq3hNfe4kCGlj3n8sdKT?=
 =?us-ascii?Q?arw8oYMzEHi8H+W8AiX7EUk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb407fb-3b6b-4bf1-0236-08da663a8af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:18:05.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3il/FZYg3t+2EBqX09LG68MZR/BRPYNNVev+tHA4Syw4Ne0RvtU/+6nUeh9O+Gxqza9Q42aIE8N6rM43YOCxnUiNJvKDsfiwn+WxkR7xxT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6481
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.07.22 10:17, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/7/15 16:14, Johannes Thumshirn wrote:=0A=
>> On 15.07.22 08:58, Qu Wenruo wrote:=0A=
>>> - Skip "size" and "reserved" output=0A=
>>>    Just output the numbers directly=0A=
>>>=0A=
>>> Before:=0A=
>>>=0A=
>>>    BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 re=
served 3653632=0A=
>>>    BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved =
0=0A=
>>>    BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved =
0=0A=
>>>    BTRFS info (device dm-1: state A): delayed_block_rsv: size 0 reserve=
d 0=0A=
>>>    BTRFS info (device dm-1: state A): delayed_refs_rsv: size 524288 res=
erved 360448=0A=
>>>=0A=
>>> After:=0A=
>>>=0A=
>>>   BTRFS info (device dm-1: state A): global:          (3670016/3670016)=
=0A=
>>>   BTRFS info (device dm-1: state A): trans:           (0/0)=0A=
>>>   BTRFS info (device dm-1: state A): chunk:           (0/0)=0A=
>>>   BTRFS info (device dm-1: state A): delayed_inode:   (0/0)=0A=
>>>   BTRFS info (device dm-1: state A): delayed_refs:    (524288/524288)=
=0A=
>>=0A=
>> Pure personal preference, but I find it a tad bit easier to have size an=
d=0A=
>> reserved printed. So you don't have to look up the code when you encount=
er=0A=
>> the error.=0A=
>>=0A=
>> Maybe:=0A=
>> BTRFS info (device dm-1: state A): global:          size:3670016,res:367=
0016=0A=
>>=0A=
>> But in the end of the day it doesn't matter I guess.=0A=
> =0A=
> The reason here is I want to avoid size/res affecting the number output.=
=0A=
> =0A=
> But your concern is also valid.=0A=
> =0A=
> What about a new line before everything, showing something like:=0A=
> Dumping global metadata reservations (reserved/size) :=0A=
> =0A=
> So that with that line, we know what is reserved and what is size?=0A=
=0A=
Yeah that sounds good to me=0A=
