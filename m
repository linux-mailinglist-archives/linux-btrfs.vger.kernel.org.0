Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAEC52E749
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 10:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiETI1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiETI1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 04:27:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A1F17A92
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653035261; x=1684571261;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nl0P9BCfSwWXM/5A6+JQKzrod1f4Yf3/4oRVaFOuUBk=;
  b=Sj19uUPm0XKeblxjrFq/wqX61UtOKBisznrsWn9FHU2JlMaY2iEcujPx
   L/VRENN/LOqDSfzjpRNALAoHPLbLzHTDUZ1VMTsUoZIUZ4ViPxOBaNnWu
   SmoFxFLUcDgiw+qCTxuYc+Wi4R6IuIbo2Sm+HZ105mTQPDp+pxz9cBicY
   6ocVFY/83eNQ6EUv7i2xZcvYqCqa7joi2azJ5jEgUYPI2O6sXT9HfJzgj
   JYt9jyH2CA/BssnUKxPY40qMmHXjvmuPS12LVgFqjNdDVbmohniIhHlPR
   ihtr51gVZIZPXVaD9tNfCiqJy6z2aSpQr2qtpmHToO3wJOUUPKQ1fkq6B
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="305110191"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 16:27:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncc0wcvKSJVhIJd+GzNBYiMG4Ibo1xIPr5eZaM6zF6VH6nXRMq6ZFHxRvtu7KsfP/lw8U5DE5UAtRR5xqHqjPiH0uCA/bxEVmoI3ICrio30Wa/h1+qccbAK3OBtFKqUWT5yHm/CpSx4P8qSu40x5u8JP1E4Rb9eOxSzIFbPfp/FCWOdceQ3GoU6whma7BsSMFNo3o3kEuEavYGA3zA1hCCeOzAl58Vy21Hqjv503oeFoqmu+ypzY2v0daN14hHzknP7OPQJw9mfxO3HiNWB+VmIPtxa5UK8srorfsao1OCqAAYulYC+9nFDr4bH/MBqnsZmDKvh+gZqHY4HcF78aXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl0P9BCfSwWXM/5A6+JQKzrod1f4Yf3/4oRVaFOuUBk=;
 b=AnpfEd87iLef7xoqZ6TIiVzQu4vR58lRQ0POuJOIqXbE+qom9lQdAONpdLkp50DCu/joinwNIByxHxpiOrM9RP8omJXd6H2Z8B6tkUd3fZ9laSCxdIhARl+ss9+pz2jb4vQixijptpLzUWnOJXUQDu7Pt42tfW9H9CL77P4cYHyVGQl1Gu+rgJt3XBA6+DODoEJnQrSzHySNJIpyGEeidhqqpWNunFMgKYjiBOscmORLaLLUs9yL7FHxBXjyP9zemDaBJLvbrNg2Ic3Ln2Qqm3v4wk7zBDrI6rygAe371QGF11NVsx85I1p3picIbgg7kSkLWNtBMkAC4L+HNl6xFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl0P9BCfSwWXM/5A6+JQKzrod1f4Yf3/4oRVaFOuUBk=;
 b=kCcJLtFwzucDfBucvxuTLSHyKPSgd5Dg8JK2ngWSB90/yf0OnFbO7AJt9i44xWRRD91F4c9OXnJfbhYNWkvoUupibkBcCiNegTqOKNaVpVrWxwvPyi+1ymCluyjBANNlbK5s0Y4tMoBk3NcdgADfg4q6h8ej//6sPewtpBE6NYc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7018.namprd04.prod.outlook.com (2603:10b6:5:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 08:27:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:27:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Fri, 20 May 2022 08:27:37 +0000
Message-ID: <PH0PR04MB7416B590815219790C33DE219BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
 <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e0ba76bd-72c0-fa6e-212f-92e060d79d42@gmx.com>
 <PH0PR04MB7416361C433278AAECFCF6A39BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e14a2990-193d-024a-856a-c56ded756042@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2537007d-2b87-4dca-2976-08da3a3a9922
x-ms-traffictypediagnostic: DM6PR04MB7018:EE_
x-microsoft-antispam-prvs: <DM6PR04MB7018718435425957B763B7879BD39@DM6PR04MB7018.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBOl86iuV5F4F5xuFswDfsFCNLSlPp7ycffoRv4BIqi9NkskDPpSdn21A9k3bLzlSU9Wkk/T9cZbbUqn3BpBCaPsBMYuMcfuGb/12vHedbrygacv0gl5NDvMpBxXQuqpVXe/AqYKNSpzz/vNbV7OC3ENynKHfY9jw3NEJNWhhnPFB0uUZMiKSQbnV/Y8jxwVGlL9U27qqDzFcdloHsO3EyvdUR3tNB2bCPt5Bpc11hB+EfLV6kXUZVpk0uA7aGqCtFaRBier8//aJWRjO9imrm1LQulrYOmTGx0bMaC9+2omAQcaruXj175lOnYspf+uwrxo75KhzwRaBxiSazsKV0x5XQP4yiA29HkWgBNacZTph5cilLcp9mQdqTCZgb70jNuJQNB9SGRYXg/XlsXp0IPIdQAB6QUvXiOfsZ2mOsJJHBD5QWazV7HOQbUMw3Ay+1AW+hptzsumf8Nx1KoyFaJ7AlSo7jQCidTqtEepxgkTg1TzBop9LrCH4iK3FqRMCDut2Oi7GEEOnh3QsaBdw/rrXZEdUhrg3bUuFLLOSB1TLpxysGoz6gpiGmRUJxPePUX4zxJNo2pgVFUqkHlqs8LSMI3Ml6e4Mx+GMr+ZOqvp2iyKA9pmxpGEK6/VKU3yN5MLSKjVsVCv+FHTabQHqi7OOIuHsfqYOZ2HkglAZ26mWG3tzcUU6eW5gBftOCLQA15Q83mbbGuTk4YRru0bmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(26005)(33656002)(122000001)(82960400001)(38100700002)(38070700005)(6506007)(9686003)(86362001)(53546011)(55016003)(64756008)(8676002)(83380400001)(66446008)(66476007)(66946007)(66556008)(71200400001)(186003)(110136005)(316002)(508600001)(2906002)(7696005)(4744005)(5660300002)(52536014)(76116006)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TQUldtmhaPB++iGyhkOOmBzDjRKc03xXNGmUwoaDB12qG79F1GlmdodcL8Rj?=
 =?us-ascii?Q?90mHa8ZyjZ3CDk+Ntq8sHr5ssW+ZiJChyr4+wkwc36E4FZZpERrEAe3BSJmU?=
 =?us-ascii?Q?pcrjTakTDpRzukgbCLjJmXyz029oTOxKkW1qqYJxKW+CQAKepjPGOUygV0OU?=
 =?us-ascii?Q?L0xKbBz3xuLoCY0Ka5q6sy1y1pBblXRLqgRSYvrthLJoGQNdnOupKcloJ7GV?=
 =?us-ascii?Q?Kcwpxdqjofm+xluArj/rWfYdoR1J0tThUJE4Wo5vHwdGWnXHvL7rcRgYv+Dy?=
 =?us-ascii?Q?2I3ozLfoP8sW7eg55fjbsRnsMHM2XNLQQ1bdkAPSjLdUYquO0OeQn9wautjX?=
 =?us-ascii?Q?oiY8zQUg2QkDtyI/VGPJRr9iHlaudBUG3xlYI+HLHLpaOOMOviat5shFdfOQ?=
 =?us-ascii?Q?jJPy9MXu5HYPZ2b4/yRH46V/cHF9KyiExVMI/vuwZ3epRSSPArFaOYvROBTX?=
 =?us-ascii?Q?ZJCUmdAx4z52SL5dI7wcQPsHINcz98bn2DxT+WiOZzV9IOSzJwZ5PgoB6e6C?=
 =?us-ascii?Q?6oYo0wVn5MI86u+b00FK9nyxgI1NJtLaVJcWqgkcgYQBDuOy1FYcYtH7xeaP?=
 =?us-ascii?Q?TrTx+jC4D6gnu21Ce57qaNXpqlsqYbWLXcOVibp6Fuku3CLb/7p39BDpnDen?=
 =?us-ascii?Q?Fk+4P71XyQJ9Cc+sApMrXtUO+/o95Y9+Sl5gMD6xK7dgF+pBe8lt6jPH9Niu?=
 =?us-ascii?Q?0S3baQIWgGFi/tfc3EgyTAfhHxwa96SHjSatNgSvon4kvXm4OSTL3k92zxyp?=
 =?us-ascii?Q?d1I/G83NcLEWFo4PzayutNO7lFWznTRALAlW1leQ9usyrnK3TSzolD2mSLz7?=
 =?us-ascii?Q?BUuzWAcbt3hoxwgCTPdUWc769V9ZQ4JZkuToizgQW3jgkjSeZWODtDzTsgW0?=
 =?us-ascii?Q?ci69B8Rn+ws3CYf/fR72Tph223iGqxhUSVVfgKQgftwlPh1GVpoo8emwubtW?=
 =?us-ascii?Q?d8XVDyjoWQdombMqVO4yscKG1sKVDRxGFZEHHVazPUgacuURiTRwXH/KoeIN?=
 =?us-ascii?Q?jvpZvnRDNi6TTO9Ks7HRgYZDc7OJOOu9COCZFS5ogNFv558Xu7mX1Yav8/zW?=
 =?us-ascii?Q?0kS6awxThGYAL8DjWx8Kk49rsJX9WosN7Ugfh4tjx0nXUmkSOXFx28to+cXM?=
 =?us-ascii?Q?5jVw/T2tj2HsgGImdRsBFtoua4+OOdNZso0PR3ccg8vOF8WxTy4pAPtpgPws?=
 =?us-ascii?Q?I6ZvupuwK/UhlR+Bp4oAlzTgJCF0glw8zZDUNYDTYxI2HZVaQHM8N6Iq50iz?=
 =?us-ascii?Q?BTstRFS3Vf7uCacUFlNndopcI47f7/E/7M2BwxVqKQIKe0TEF5uobZbaj2AZ?=
 =?us-ascii?Q?SN9D4S2Hl8eCv9bawZSIa47rllKajSmFUcyKtVN9b+VPvJCr0Kcw8x4SVJQk?=
 =?us-ascii?Q?vXsawaG77YQjO8mip+3GIPtzzs9kLyQe7Yv3yL104cQBPdLXZUN02Qu+s+F/?=
 =?us-ascii?Q?EzBF5VMMIv/yVBxhf+BIvxZ2vKJZcJ6j+X/6mNhjJRKij44XNMatJmst5py2?=
 =?us-ascii?Q?94yQ2XB9emwf2g8npyA3fOaS+2t8wB3/Zyezm3N35FUX00XrFPrPUvOtPBq/?=
 =?us-ascii?Q?qpv9/xqfHNcsy8bNcqA20ZKSYPljLIarsZX/qn1HIkxnC9WpfntHxI7Rn1F7?=
 =?us-ascii?Q?LCuPBTrp7wWhmlh0V2+smtcurQ4af74SqIdc5tkEHRSr3dnGpCUm0rBSxAWM?=
 =?us-ascii?Q?kxWLaYkVMXrk3FwBudVYWQeXMthUCryeqZi49X0mX/Fe0/ZU9LGgU+sr5vqo?=
 =?us-ascii?Q?NiW4U2IQE7MWNZXOBFcVfi/ourxyWoplmzGDA1zetj+DnrW90vbW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2537007d-2b87-4dca-2976-08da3a3a9922
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 08:27:37.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abuECgEumNEnI8lbKZ6S2/xLVyo7VJOcDtSM2VCXIIZ/m+KAPbeh8He3SkfSiRGZ+TJLn5hxflR6vb2mBQRTnJOf+fzScTrNkIuHj8Zg/6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7018
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/05/2022 00:56, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/19 21:49, Johannes Thumshirn wrote:=0A=
>> On 19/05/2022 15:27, Qu Wenruo wrote:=0A=
>>>=0A=
>>>=0A=
>>> Then let us consider the extra chunk type flag, like=0A=
>>> BTRFS_BLOCK_GROUP_HAS_STRIPE_TREE, and then expand the combination from=
=0A=
>>> the initial RAID1*|HAS_STRIPE_TREE to other profiles.=0A=
>>=0A=
>>=0A=
>> That would definitively work for me.=0A=
> =0A=
> Just one thing to mention, does RAID10 also need stripe tree for=0A=
> metadata? Or since we're doing depth =3D 1 IO for metadata anyway, RAID10=
=0A=
> is also safe for metadata without using a stripe tree?=0A=
> =0A=
> If so, I really believe the metadata has already a super good profile=0A=
> set already.=0A=
=0A=
Yep I think so, as no meta-data is written with zone-append.=0A=
=0A=
I just think for meta-data on raid56 we need something.=0A=
