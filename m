Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01224575D27
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 10:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiGOIO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGOIO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 04:14:57 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD92B2F3A5
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657872895; x=1689408895;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iCYzZl6N1H29DGt/98HN4xUV4yGp9z2mrTmRkKqHrrY=;
  b=rSErftgeXhOCM0SJxi5bWz5iHTsFMvcTSznSfyjFZilCArCbjOIJIhp4
   yvXx8D0lwnAzeXf80IX6emQ5243llF0oisb43xV6SQ/yACbVpwdJ+UFpZ
   xWrPD+VYyXMS4YKDERbdrmXoeGh63U5eXqVFxSiRcSO8RiJnJ0Nan7xFr
   TSfNMRAzQhq9PNayNAjp8Uh8cB/W3WAuEpdlGrBUbGlvDOQnBYew0I4DB
   bCaYq9TRE3HIbD7syzhYwyUGdacirzaTKsEJE/b+AtR492l6mlGeb0Cxg
   oVi06/8TcVpBQRCQEvJRGUuKT9ebjGHtOTLn2cosh+dxqXUF6jCCOnFgd
   A==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="205825068"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agGgCMkNAKXvUmxagR2yCURD5WJ2QkA5X3kywosoBLxfKz+g1GUxWtKt1D1tcnrSRSiWSo10+CVl8xmKSm5tKqdjHEqhJ2WegETJBbIIje+MneIgZ3BWy7IY1qFnKz3usbmA0RWlNhIMXneIQzS45t4lu+hm9EODeZ9Ber1UZV+B9LK6BBfTNnPCY5qUjQs9VGTPESFRWrhRIpbxnZuRYBpSer386R3iywSlwWFNII5T8UWOatqtycS6xsU3KjeJoFypjuVfKIcRDQWj3xnjq8tx6yGJFHqrb+2ma1p7Skh3+BNWdp+Wa+mDIuAslg73gVU0r0G4zAXcdFOhg0WAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvFd4bBSv1EfLBqa58KNrGtAjDOblUT3zkh7tH1rfU0=;
 b=Vl26RxJ+RdEjYtNdU/RnSMN2BgafTHzwt3mnjhy0nOG4JsiOTKvobc1L5VAweCe3NHzHK/2Ob0LVKCfUue/qhLpqxr773G35E8z0oxxuAEj+FudBa4M1Xx8fKN/yvMNk5/d1+Y/SNX3J48T556ysQSkv7WxhJt/6P2hcnMKZrk1qL5eizZh8jiFmgQA2gw1zAsXS0YsrLjKCdIBGBuxlRffqUReFtZaEuI77S4/ru98W1OjD1QMxe4pAZEizjtgI5F6zyS+jcawsShfIWMfnQ1xOqNqAsDkXlLX6Cvvysqc6yan8XX0jGrmAMDC+AcyXf3wwIJ/cq/ZTg+gPoF0Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvFd4bBSv1EfLBqa58KNrGtAjDOblUT3zkh7tH1rfU0=;
 b=t50ny3ZtYjtqhnlTgcLNTab0YA07e6ZUXx+JS/KoH9mRfE7FvGmif1o1HjVrmobarfBBg9g9MSGtjNzQu4Snot/eXIZ/JpqaGI2pN1oftQHbvx8gJSSoShHHe2mbv0aX5pTKBKcZHWEDbBZQ2itdYiPF7juNfQCf16/xCZrctSw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 08:14:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:14:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Thread-Topic: [PATCH 3/4] btrfs: make DUMP_BLOCK_RSV() to have better output
Thread-Index: AQHYmBhF7QwMy6jcLEGUIrdMeDdI5w==
Date:   Fri, 15 Jul 2022 08:14:53 +0000
Message-ID: <PH0PR04MB7416789E6373C3685094D8009B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657867842.git.wqu@suse.com>
 <d0096ee10270e00362471c7a842aeefed20806c5.1657867842.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5cc281a-c9dc-4164-d9f5-08da663a18d9
x-ms-traffictypediagnostic: BY5PR04MB6723:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjt3vmtH8Mgl+FjzMoQoWqcs/MqGkGSOow7w8cyRQ1+pwd+Aq1ZqeCzQ148tQtDLvHSiOVi/vN3zId2qcPzSSkW/c/V6vqM8fLXT+nn1hlTcC0pZuyDWIX/fjPQOlOH8o+nkI80Q9GctAJFsY9aWibgEaXj7w5FexWm/cFHGGaMCcUBrz693ZpeWj5t8MqpOPALnvaIu3gOkh1VbSQvCOpzVUAviZhPMkdSSwIdVWfvNqq9i4YjLlrFOmDqMc9wvoGZPTKN+YsqhPQZE8u0jAgmgXIq1mkRSPavxURHA6QHZJTIv38xT6XYA3gXsmRyKy8zLlOCCSqUH5trkWJDyDbSqS5DErcPh9rVH1Id/o7qCuDQmuTr2L/iooZGDCXw8aUkNC9rm3lE+WJ7uYxgDoO4jrWPINQP59pN341SeKc7D5drUKKokh5aK5i4jIhRzAenIdXq3+RHycYF9Wg0NwpD5M/gwemt/89FDJyEXcQShLZNqVksARjV9d04Uq8jJV3ueSKV5b6CYCAq7S+P/UOxFSkT1QZplxRm4bcpmmte0HHTffmbDvKxwETQTPs5eRab0P81x3hshW/bbdyk+XCPEmQ+JKAodN0WPJZtEnSavtxEC5xW2LdKZoDAltVeKfdJGd8rTdwGjGsZKiCbjjHx+dT9bFJJWwJIF8Ykh6y2JIYeGl9cABCaFlAjye5qR2RcSn6h6UuLYb7xawUZMWGzTtunoO/bz3W+OojauwQHWSvLN5mmvmid6f1AOdPEtxY+hSvzwKk+1QyiqnILu+/1EkGwkdFQ8EqACKwaYWyalLL30ysiBrY4BvdWuO1Iv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(8936002)(76116006)(86362001)(186003)(52536014)(41300700001)(38070700005)(83380400001)(5660300002)(2906002)(33656002)(110136005)(55016003)(64756008)(91956017)(122000001)(8676002)(66556008)(66446008)(66476007)(316002)(53546011)(6506007)(26005)(9686003)(82960400001)(38100700002)(478600001)(71200400001)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUkeRPCbPp7v+PHy2zi2lGlXKQthSRNAi/oN9HkjsWKZIGcHvkat5Q5w6LYk?=
 =?us-ascii?Q?t2/v1/p9L1ZRsUvbRh0ccDxGehxU61BBdn+RLZiKvOaYV1mTjFI4jd8S2YX+?=
 =?us-ascii?Q?95le8aTYGJX0UNWRwU2nfhC8I8wo9WpuOpUC9fx1rjGVRWh4GAoF2khxHCsM?=
 =?us-ascii?Q?OXXJ+L47IwdmZW7NJwhF8gyKaq4uT88Xaf25d8xW6J0IOTJSPXcgGxqblduI?=
 =?us-ascii?Q?mGaqgAREQEV1B7gFYmhMvcEqRz8zXvGnvwP93BxBUavu+ZBTInh3RNuhLwFW?=
 =?us-ascii?Q?Pa0zKrAJgpMh+/br5zGBkikDpc7wyMghADreSIMIWsomtyuSr7WnRMvlRna0?=
 =?us-ascii?Q?NMh31PuYMQ8aE5PbXQvcgl/mQgERwYS8BAEFhWNcJ5o1lQMHeqk+4DN+nh6P?=
 =?us-ascii?Q?ZCmutKLvPZwnUsf1Ki1VUNT82Qe507dE+lAtnGTFtcX9BtM+lLEcaZD+ClgJ?=
 =?us-ascii?Q?cCzvkfSTAbRrba7CMYLpiv94FIYaHa8eEXYEJ/1fwhTwQHm0PU70R14wj55G?=
 =?us-ascii?Q?MVvQUgMM5vZocVzD06Uh40kPiRSXq1Fklr5kMF1Mem3HM2XunOlEG2xwhRaD?=
 =?us-ascii?Q?4E44jycH9sTy9v0jRV2Z5H+QFGVxhJrpsSb/iW7wTHCei0/UyTLTfHl23NJ1?=
 =?us-ascii?Q?nqnnX9Iz4WhtnxrfL7H3Afi+M4+BvQ2k80JP40V4wsUPRK+q3G4GUHLG/nCb?=
 =?us-ascii?Q?rkKdAe2TUPxT4zln6EyYi7kr5SniTJD6o8L9qL73AA0ehwhAHIgP+1Z3zA4S?=
 =?us-ascii?Q?5zvKtW99gaDWN79J7QiyRDYMS1862M6ia1iOyl+klbgVa6SNWi5bOJer6Yf1?=
 =?us-ascii?Q?jN9Fw5YL2oAmHTNY56zKF7urUSsEGSoRfelSwf3tqe6zhaTjQDsxia3AQQQO?=
 =?us-ascii?Q?84/9y4AEGaLQ/QCEeFPrRqjdfM51l0hyDC0B2i8TYpHbv27Ko5O19Zg3h/Tp?=
 =?us-ascii?Q?O30lCfTq48tMTazcm8dtKQQN7LvrXT9R2BvFs7I8ybJBSNA4Q16w4zBPvmz8?=
 =?us-ascii?Q?2WgAGO01rb9gysBs3ytfqjWvk8lkIhvwAQkCVoPP9vCWcsMklS7CbIrA33St?=
 =?us-ascii?Q?b8QjL31cz4JBzzrQ5wBbmZ8QVznuOsLhcLdQY3JWZyMjc76E5obvL08ouQrM?=
 =?us-ascii?Q?BPFnZq6lywbsIg5gnPe2hDueb+Ljc0GmRyA9RD9edCZ9NRj8w1Oy/j0bfdkG?=
 =?us-ascii?Q?3eX3Mndr6vfB19O2baySx9CAwdWQ/5rwGtRnMVftP6fMWXEceG8EMem0ECt9?=
 =?us-ascii?Q?GMo4v74uXvw4DJn7FIZhiHFWITqHP5EZTrBAGohOG5E/qT2zi4yoADqS7XKC?=
 =?us-ascii?Q?JGTUFMsxvKuJZDoKHTBa1dGGv6jGyBqi5cjd3s2CcPQgbWgHP+vcMNx36rGY?=
 =?us-ascii?Q?QBbQianOTMoigZcdkNbR4AO4D77kew2yzLP1be6TAqTiMWbaGzbplvkCD3Md?=
 =?us-ascii?Q?oq5vf9+XJCnYzKAUSQpiUjbmU6F+LDX0RexDcivNptmO1DZhH+LCxl4Y/H43?=
 =?us-ascii?Q?vBz5ZKdKDbAhpVKP7tkZniY3xhQ9fx0Wwp66v9neXe7noejhj88tPYB66v9E?=
 =?us-ascii?Q?7CY3q2pcH5e/eMV+bMLQjGA+Vj0K9Qt4P4nrt5CKhqZ9irc0ATvK326lQODk?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cc281a-c9dc-4164-d9f5-08da663a18d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:14:53.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB2g5n08svEqjTtD6XjO0INHoJ6rt5McvD98O0bDud91BaGHN4QHiU6mkMDpCLmdmJN2G08Wg6mdZ2fdbpIT8ZqxP293BU/d3AB2ZhKDQlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15.07.22 08:58, Qu Wenruo wrote:=0A=
> - Skip "size" and "reserved" output=0A=
>   Just output the numbers directly=0A=
> =0A=
> Before:=0A=
> =0A=
>   BTRFS info (device dm-1: state A): global_block_rsv: size 3670016 reser=
ved 3653632=0A=
>   BTRFS info (device dm-1: state A): trans_block_rsv: size 0 reserved 0=
=0A=
>   BTRFS info (device dm-1: state A): chunk_block_rsv: size 0 reserved 0=
=0A=
>   BTRFS info (device dm-1: state A): delayed_block_rsv: size 0 reserved 0=
=0A=
>   BTRFS info (device dm-1: state A): delayed_refs_rsv: size 524288 reserv=
ed 360448=0A=
> =0A=
> After:=0A=
> =0A=
>  BTRFS info (device dm-1: state A): global:          (3670016/3670016)=0A=
>  BTRFS info (device dm-1: state A): trans:           (0/0)=0A=
>  BTRFS info (device dm-1: state A): chunk:           (0/0)=0A=
>  BTRFS info (device dm-1: state A): delayed_inode:   (0/0)=0A=
>  BTRFS info (device dm-1: state A): delayed_refs:    (524288/524288)=0A=
=0A=
Pure personal preference, but I find it a tad bit easier to have size and =
=0A=
reserved printed. So you don't have to look up the code when you encounter=
=0A=
the error.=0A=
=0A=
Maybe:=0A=
BTRFS info (device dm-1: state A): global:          size:3670016,res:367001=
6=0A=
=0A=
But in the end of the day it doesn't matter I guess.=0A=
