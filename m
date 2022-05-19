Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B152CE7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiESIkA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiESIj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 04:39:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E73762AF
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652949597; x=1684485597;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oF9RkR+xHwHSeXronTPXlbrLYYFvO6wXPUSeqQVtvaI=;
  b=PNA32bRSA+577M4BxBOalPL/9BKeUJWQWE7biNjuMky8yYDrr/JaU6ij
   JuxLQwiyKu/Xrm3qPlvPZaUylMR1O4oVRdTOkrmdzqORr4GYMCr2v3Nxe
   TS4PuixoCnaxsEzyk/7Q9Y5oZLnBPE5Oq0PvNRLMC9fbnsQe0/7qyFqtL
   U1tfSdaLy84GbnGS+TWLDYAn6LionHaeV06bNxKVr3rDZuHJBowpQLmSy
   abD9+BSX5uiHZiL4D46sW0ioXrujIs6aYNf4RiBu/4bPQyeSAXwQNfmxJ
   xHhlbSh1xpf7/bPAhwpFqKSEzKfyH6GQBUEGYxJsHxY7p6hd+dN9ToS3T
   w==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="304991500"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 16:39:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SohYw+bz87msYO+7JBhATn3R1SyoRPTN7aId9llBcnJ9u23ugLjYKDyZ708ZVMGLpnZD2GcuqKNFC9v3dr2B9Id6iBAQ498dQ+QbxvZlsQ0OylmUWOHedYowZ2SJWfenkk19I1Ahl21fNTUwkozFYaK3YMjz3e0IO1f9OiY5zwA+KLEV7HpH+0XW5QjnzEfamfY2Si98aC3qHDQw0LRqT/R4IqIjlpGoZCDcRTXMF7hDmwfWrLLmR6u4MFpKD+/4y4UK1R8eqkI5pLP7md5kWh5j7TFV1BH51Q0ynVK5DhSX3zaVRwivby0rutQEjV/r7i3XObkyP/UFGrlPrDXD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF9RkR+xHwHSeXronTPXlbrLYYFvO6wXPUSeqQVtvaI=;
 b=jlZdHqv+sTiy3ckzeyPQusy7EMpcmKJ066kw43ZyOH0Rs9NVP5I8rCP1f4SzR6sfbWS9nGWl2lnt3gV8kBkqP5hA7lp+j8htcPw/1yTsR4LSiduqCVYfmL+98zELPrW54YKhR1gDdET8eFc9sJW4YKP+kE6gry1Ut89zmilOfoyEhKBzuWMzaD8iJtCAaDcwLjQz88Fvq2n58qf3x1d76bzyXJFGzivKijR/PjksOFr2OhrODHH7yodUPKFVtdFbxFCAYLX8L66YAswkPOjG7AeaUq6XXk/f1sblulwkRPbtn2g1aJ3oPJvEW/a+LPJcx/91nxWnhfLKMkenaCurQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF9RkR+xHwHSeXronTPXlbrLYYFvO6wXPUSeqQVtvaI=;
 b=wJS5rBnnGttfNb2DaIZtJsrJ6/rfrlH0J+TIA9L9/uFNzFn2CW2ieqsf+gt8SDRdjhqcv20dBsD4kc66JKd7GFoM0sGtIRT1EC2dspMnbNsYNp47yzIKrVgJ9X3LCDHEyN8iTr4f0bCfbDIiMMlHD4pn6WuEj6I6IGaAJZhmMLQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8261.namprd04.prod.outlook.com (2603:10b6:510:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 19 May
 2022 08:39:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 08:39:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Thu, 19 May 2022 08:39:55 +0000
Message-ID: <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c54434f-cd56-49cf-6f11-08da39732686
x-ms-traffictypediagnostic: PH0PR04MB8261:EE_
x-microsoft-antispam-prvs: <PH0PR04MB8261A82EA58ED9CD5C134ADD9BD09@PH0PR04MB8261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSlZ6W4drrRWwxXDvA+qdmI7ysdmxUZmUO8UPxJkzPClcgpjZnfP8LzDKMeFMV8sVafSv1R9BlF8e4fIVcP7wmuA66FqydvT4dZPOPzCS9O173UQf110JEmwmc1r7RIDldn0AncCWo8zeWbpQ1jz/REplcAe54qSYFV1R5gyIAt6slowcXUylzOb1b7Iao0gbACTTcvU1oRkoiAiEgd1A6SRyCqhYm3PLv6Sy8Ts0SaakHogv0stmpf5eH6igdStoAVCliZwvrRdd/8isNPLHrwAB/dOa4a3TaasbCANrKjZ2PBvAIEQH6sQhWkBNVG6lKYPjrLy4eTxgS8OkqY4rujkDhEHv2EFRW6xEpi+YSq55Ix0p2XEDsEURi/qcWFyJg2UOeb78R7bUNOlA6CinlwdyUnmtUN7O2QNKOHQBpP5IqwcxujjzLLuQ+sMggq60qVv2TP/B14OBqWRvikDoskTDBXJPZ2Og5VXeVFtodoSpz5AyKVWv7PRc13PmFr4aRUDwcSZ/JI5nKECLaMqUCrw5C+NOB/t6pMLRRDVHGTCypRg5f4LYarASF49W5asWC8F7sF8+jJ20qztmLpwXxi+juibDto0gb1F8gW5P9duA0At1RM5u1fpH78n5iumKu41Rzst2QtPD1eEr9PhbcFEdz4j/svFQWSJeyrXEm0eH6VjyR8Zxdiwfg3pZ5NoKV8hiBJmfghvRRgvdymt3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(122000001)(508600001)(38100700002)(55016003)(38070700005)(316002)(71200400001)(83380400001)(53546011)(7696005)(8936002)(52536014)(6506007)(5660300002)(9686003)(186003)(33656002)(2906002)(86362001)(76116006)(64756008)(66946007)(110136005)(91956017)(66446008)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0paoVUrjwkcglq0u14EsURDB4ypJlfXXyeToHpTSOjk1F/cvOZQ6J4xX65fx?=
 =?us-ascii?Q?chJwNQ+Wvi5hgUaaOjLR1hPhAcjk+vUzqT6kONnxrMv76ZbdAFYdaMpaDWIs?=
 =?us-ascii?Q?UbZxlgqDGUOeRsaJCHf3z39Xn1Ro6m0Rlb9SYnNL42RTWcWMmcZ1+g999jSd?=
 =?us-ascii?Q?ZyyQIfDA7/McAWk30Wz/Kmez1bEF5K8UVJs0+Gsn9l3nFeSAnRtC95odamSW?=
 =?us-ascii?Q?MwZMTaHAqGNxMI3fs4DxhCo8dOGmGsOl9fDaK5I9SoPw+B3MvmWSIsqtoAkD?=
 =?us-ascii?Q?VlEi6JEvFBoYXdD3QR41FYZJqp2Mq9wV6JTTlVDYnP1OL0o851Q3NRwX5inp?=
 =?us-ascii?Q?LTkU5s/nSjAPkEV/azVlSj0sHaLPo0t7r1N18DT5zYovGXhFu7eWEQPRBrei?=
 =?us-ascii?Q?J4f6egK8c9kjcaow9emMrSVpBMZS5m8ABBeSTe9LynRboTHP0T3O6r64gpyb?=
 =?us-ascii?Q?pCVDOlNhfptz6AxKZtynxB92Oy/RQRJNsMPrHFii+1rhnVYiAqJGqVWWAk32?=
 =?us-ascii?Q?jPJ7GlntWXHP05S559OiYNv+mridAND8+A8De9WKA9wmNusIiiuwOeS8seD6?=
 =?us-ascii?Q?AA9UmHV07LT3Qb8IPPHMV9be8FUhxL8E6QlTVAQB6OSy56Mpqj7GJQmhAlYi?=
 =?us-ascii?Q?DrXxDsL7z9vXrWa+VuZjNNZzA7Hcer6DEjaEPhvQdQ2EmQWiwLY46VrDRKI5?=
 =?us-ascii?Q?jF9fqlNKboxx8PRnNN2vNm/idu7CYyDpVvhGbO0aqvNF/qREoG/wR6akqmM5?=
 =?us-ascii?Q?ZEEsrrEVGCclbZWypmTISUpuuq4QUxXjbc5EZyR2SmN7iQ44+6dERSm03A3t?=
 =?us-ascii?Q?CiEJWMy21IQlls37+fqEkPMikVQDRxyhWKxDjtItCqJizoi32+tZz4QlhJg8?=
 =?us-ascii?Q?qawupcoQ+P20KNJeUyVtGsqcIZ6Ymn2eqbcGw4rDIepm7tmDcbbmH57osA0L?=
 =?us-ascii?Q?9sgtEkKZsl46/hm/1utxY0VYAsEJGWypS856EeF5CzxjQU3/tdVZIVY1oukN?=
 =?us-ascii?Q?KpTq2SDORbtzIR069W4fbHBwd4CeZwsNJ1avGxvAcGRJhTbprZ416aa5c1Rw?=
 =?us-ascii?Q?5eyrOtZDtbreF4+UhZLtQhCE/esxw2bnzxIzxgkSqENElQxno5rvcnLYpwqJ?=
 =?us-ascii?Q?tfjyk4eFCpllI5QQoPebJS+8xljF+/SmPbn0xw20z91q8DgnwI6/TqUe0O6K?=
 =?us-ascii?Q?5ZcToNdWvvwUOlaO2qmETzaweRLCvH+deAvrP1zkWghElIVkrxHfEQqOWEiw?=
 =?us-ascii?Q?6TsPZioMM7hZOHXYYitr1LzaNilNiJTt42htJa7ZeLEiIvsOfafdJouVzzIb?=
 =?us-ascii?Q?GVP7O8CbO1+OF69Bvx5Zzh9S3SCNR6X4fLy1ARDIRtTG7FPQlBmXHYTokpoQ?=
 =?us-ascii?Q?rya+w8ReP8K9mo/o87SeQ4wkoxnBITiJywhpTJTHvVt5EVERWjLoCaD+6GFZ?=
 =?us-ascii?Q?MFFD6oPIXlf2xD+7n6OrZsHqJqBeZer69hhKYSZa6BtMlvNOLu9zjjw3/rMz?=
 =?us-ascii?Q?+cqnYV0QzsTYb8zLPgKllc2ox8DdJUQ1gktjW46JYxStLUtRMFLrHIigttgQ?=
 =?us-ascii?Q?1N2QPNMDVLO/I3472ds6BB1liA2OuoHoIEPD4tqvrpTWh0eCbaHwsFXc7SJO?=
 =?us-ascii?Q?+HA44+Gt6BspFH7OXVPSESyyUWki+hvpC3VF0pY8YRlIJcNdttELHWmPy+ot?=
 =?us-ascii?Q?URHU6VBdKAzKZptskzreX4I+HAm46/mUF7OO06/vTTyq2fJ4dd95WvLVQy8V?=
 =?us-ascii?Q?LA2niajLG3R+cMwI+ByWK2NpWsWqULlTj2BEBFv5V1DJbd1H69wttfrGLlE6?=
x-ms-exchange-antispam-messagedata-1: Cw2iPcAdzAM+f+t47gwdFZ7OQAnWuC1jW8xfWX3UzqZkaCXexbHpt+xI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c54434f-cd56-49cf-6f11-08da39732686
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 08:39:55.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53xQ9YBfkd2amEPe3ddviRCdJCpdl2oVSRboD0pnzu6G76vDli/P9wQ15/7PczpSLKz3CgvC3xWWEfJUv7/NLYbYQq6uqQRvBFQsu4+5bVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8261
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 10:36, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/18 19:29, Johannes Thumshirn wrote:=0A=
>> On 17/05/2022 10:28, Qu Wenruo wrote:=0A=
>>>>=0A=
>>>> Metadata on the stripe tree really is the main blocker right now.=0A=
>>>=0A=
>>> That's no doubt.=0A=
>>=0A=
>> What could be done and I think this is the only way forward, is to have=
=0A=
>> the stripe tree in the system block group=0A=
> =0A=
> This behavior itself has its problems, unfortunately.=0A=
> =0A=
> Currently the system chunks are pretty small, in fact system chunks has=
=0A=
> the minimal stripe size for current code base.=0A=
> (Data: 1G, Meta: 1G/256M, sys: 32M)=0A=
> =0A=
> This means, if we put stripe tree (which can be as large as extent tree=
=0A=
> afaik), we need way much larger system chunks.=0A=
=0A=
I know, but IIRC (need to look this up again) Josef increased the max size=
=0A=
of sys chunks to 2G=0A=
=0A=
> =0A=
> And this can further increase the possibility on ENOSPC due to=0A=
> unbalanced data/metadata/sys usage.=0A=
> =0A=
> Although this is really the last problem we need to bother.=0A=
> =0A=
>> and force system to be RAID1 on a fs with stripe tree.=0A=
> =0A=
> Then the system RAID1 chunks also need stripe tree for zoned devices.=0A=
> =0A=
> This means we're unable to bootstrap at all.=0A=
> =0A=
> Or did you mean, make system chunks RAID1 but not using stripe tree?=0A=
> That can solve the boot strap problem, but it doesn't really look=0A=
> elegant to me...=0A=
=0A=
RAID1 on zoned only needs a stripe tree for data, not for meta-data/system,=
=0A=
so it will work and we can bootstrap from it.=0A=
