Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C65B9CA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIOOLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIOOLp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:11:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F09C221
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251103; x=1694787103;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=USINnG2K3LyVAEOHS4ow6tL84VEsqrzJEpEdG8HUAU8eq6JDcNWyIBLE
   sN67fe3Jg8Z+7CuUmhWTv8y3DQzNAWgV7sIO+teQLYUckcU8H9b7/GH/n
   7GHhY9Wp8zKqQXXJevEA2LtijfxJKRC3VE/f9M+kN1s8GpwPbyMmPWdx1
   D03TqDRKFoNB3An4XBsDcWSlkQfgWxdAO0S2wTqyfwL/u5B6dNlH37rPg
   xhvOYyBFesD0qQ8kJBZUD5FRkpnng3rp/OTpweZmXLE0W0heETGwABbK5
   dgtRL3uSYghMqDAcYjeFrwiferR+IXXu2KDfMDs9MQDv9/hyyL5+HO7k3
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="315724399"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:11:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVLL3QPz1zWLq3mImYo/mI3dPa4PTSj7Pa8UNp90Q1D3ry3IRdh7zOlVx2GT8xmN67Rqvjs8aWQxLXf9bmyRVXZ06daozB23rrUGXRRpjwVlsYDmudgb8VjAPK3cNw/0QdlQqzi2q4GTWd4RUI+aoAhHR2zabcezy2WTdQDnb++BdkQm7P3w2kdzaij1aMXhYtWHQXsyMxwhjpNOJ9hKKJUEXBwCFd/JMJ/e/pU6WEhvTYT0ZFaMZuSGn3cfH5EF7R+SADX6pdJyANM0ScSpI8g79heDpW3SFuYtsk3uc2TJPy52X8dZFgjp5mP/Lp6Z8TjtDRwN0kQQi8NclUk89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=j5Ed1C6VAYEtbZi2bx4gWdf68TBn/tfFXKdngL/9TO2Tp0vK6nr+1p79005CQtNEPQ8ttTHoXGhbzDpPYYM8jIRscg5yCGEyAxrVOzzjPZ8zS/5Bl6xZPbUufJVPB5yG8TQ59ulPndAQXGMU4skbdUx29GZmFOWpZIW/+EzwcFe9Of+JJ5eLg9zI1oFN397qMHkDcGowMOiM2iCN28WhBzjk2H9eu8OVKpS8Ci4ubjKaehoXkSlQg/ihe3wjPjRBmy5JCm9KNaCI63TPArJONYc4+EbrDf7dt5Luo/lePour381r6FcRRpJ6qyb6MxmHT2OzHiDJrcs+KL1Ygg0pvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lWP8CO1rjAMJh7QxG2pD+KWsv8iJ8/365VD5rpOw3O8hrTbWqOTXh9K5PhlDjkeMtwErS1xPoTvTFjfgCExSFu11CCvxBco4KhciJcsT2Z7KZPQAJYUhTIc0Hs54kG3k5EDD3+9MsJrhHHGR4TrxIyYy4WPcqCUaRS6eRfhLGjw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2258.namprd04.prod.outlook.com (2a01:111:e400:7bb2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:11:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:11:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/17] btrfs: remove set/clear_pending_info helpers
Thread-Topic: [PATCH 01/17] btrfs: remove set/clear_pending_info helpers
Thread-Index: AQHYyEuq1NYVE759Pkayo1bkxgz3kQ==
Date:   Thu, 15 Sep 2022 14:11:41 +0000
Message-ID: <PH0PR04MB74165B70BD76981825ED237F9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN3PR04MB2258:EE_
x-ms-office365-filtering-correlation-id: 518bbac8-a53e-468e-984a-08da97243640
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kw6BRXsznPyyDnYe+dPRQ9ulWeOhM/iVVbbon+9cWEJr9+YG0ddHlCBAlpHfiv5spiQoiTanolkB1F3kV8wOsDz0q25eeO0COj8qgpHVryhh2AfV4UknltyhQnBDWUhzbU+u6aVcDSa0UPpLQh2KvOBy+pUDwkLALiPj6Vh3T9HPT23Gnk48LfiXOGL3yTSGjm/pgeAWjF1Az7kvJTXLGLavtKtPTkNigPiK6TJntUmcsR1MvA2maTftNN2xRYxzo/j8NBg8DHlhBPuINvfHLBLpd/BWEb9S2N9POJ6Dy1OKpTs5TShUJA8JG65b/Hze42UlwgQPHBvbIdqDXDKggXyFaq/UVCwE0i/TJIdmlL9nNCUdi5HCquOpBtb/smmUvrSmV5UKY3fR2zNLSEidI+dbI7K4qtcQ2H39Csq2gVvG2pLZjB5Xrt7C4HTMJJYv9nJFMhdeb/WhFFBfg0W3jk/LmFUrrOwHxcIRE5n70AvaU7VkIsweLGlgroZKRjr9i7nSjGguFa5V3w5TmfDFDde9cBLVMocy4ZNWsifCSQa2mU9OxWBBUw+lbGREzEtiseMGBjW1qo3dp87S2zvR8ccs1khjkRv0TVjjijrxoyaYqIGFVT6Kh04DYqv8YCMl+ssh9voR2vOR2QvYS1hcw5hV9lYVec9IKJzHqLhYlwDQTvlYlj/0ppmtzh7iQvBZAta/XJY7gIN0SztkAw9PP2NYwnUbeNknPwRShk4/9h+y/kQBbMLXZ/dZdH3C09W0D7X+hyTfCqpzUa+EcKMtOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(9686003)(71200400001)(6506007)(7696005)(41300700001)(38100700002)(110136005)(122000001)(8676002)(66446008)(66476007)(38070700005)(76116006)(64756008)(66946007)(66556008)(52536014)(86362001)(91956017)(558084003)(33656002)(82960400001)(186003)(4270600006)(478600001)(55016003)(316002)(8936002)(5660300002)(19618925003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ShgOiDXrFEW+sNGyFhLjytNxtexGXqhi0cZY6y+yKfO+CJIrDGyAoKg4S4TA?=
 =?us-ascii?Q?20HJOSVRWzdhZjvvDR1vZUSJeeBBj9yS0NCipgC0LB7R2Z3RPjkelWv9yiXJ?=
 =?us-ascii?Q?r45a5aHDqO4eTE4pi0C/9Zbo1L6daI1CO7op33u6QCfXaEZb6JyZo5S83SXp?=
 =?us-ascii?Q?giy3ZlTgktL/h+5mrrbHyiOmuiTwoKYNqBpLqsjqegOgfP+XjuKs2iHGFLmL?=
 =?us-ascii?Q?/5uRvV98xgpkxDb4HJfNhXFo1/De2yfsL2erolcJI2PmviKNh412MGQFXhny?=
 =?us-ascii?Q?x2eKVu8PeBRr0uSU/CIIUGZkdAlzrQnafZmZuZxi3JMhSXCAaLkiOR40lEOV?=
 =?us-ascii?Q?1lG1SUPpjlydYWRxwmAhUb9bl5oiJdgJq2UeYPzxBtrCQ33FDGPuTQdcNf+/?=
 =?us-ascii?Q?iE8goEconIEppgbLZm+A/Xm1z7+uF+eMPwKE+NPseiMeoO9xe/eNnnB3xsMu?=
 =?us-ascii?Q?m1MqPM5FJ6a/2j/J6jsIj7x93bxlGXJ4X5YcqAxqbMq53B0VAxPIgwcjcvZH?=
 =?us-ascii?Q?b5SnR5gwVHHq8es/rEpViA1TN0attbEUVrwNVETqSHdW8MiOljbgNGCifK6k?=
 =?us-ascii?Q?0gd1+V004V3PJ7yXGBuLPN85syieY8x686wEizJnUoTbtEJrpjanHRAqIkql?=
 =?us-ascii?Q?hsGWAtiWYBkuPy4kaWKctR64HLgsSxf/hsAUZK5xfLGO9rLSRFPGJkPkeAXL?=
 =?us-ascii?Q?CU+10VvB2hwbkI1SN9BQvT17SEFHxFtUluwJXlCpsayVtFCzOjFW6b40ncWr?=
 =?us-ascii?Q?CnCS51mkpN6x88JSoZgCWEUBpMXNdSyaKDtIZj5bF4aBNA61oObaP6rwB7By?=
 =?us-ascii?Q?EHB+1cvMpR+IPYyAeK91g6c8YVIR5CrxTG2cbiTn3jmLuj9mQmOxHfMfacRL?=
 =?us-ascii?Q?Vjv1+i85ngNUOZ1DpEUrVQqHik72APk9rwWRzZyTstIg4K7m3J/YIZPcs3sz?=
 =?us-ascii?Q?0E9nx2XI3wsT78ZFfKNnYEsTyGZexH3Dmk2hCwoULfknzP3ZTqUoVOSbsiO2?=
 =?us-ascii?Q?0m7VdlrxUdYq4As3qRqAIbV1TMZXp/boISvCrAoFCV98qNj9pi3hKwUQE7pJ?=
 =?us-ascii?Q?sZP8knW6cXSYUYCkgfnDV5x3Mqm7pD97SAeTHbfC/ptQu1KMp1AZXnueGhDD?=
 =?us-ascii?Q?O9tEFcs3XTSw8fky66VoE6cs90h8LKSmzKNvzn3i9oKHytbwxrLcpV4CX5j0?=
 =?us-ascii?Q?pS4LoOjiwP21iJSjKIGMeIfn4kk+7iIWNk4MF3yfymRhVS1U0fn2tkb5CZ0O?=
 =?us-ascii?Q?vWEQdgOghudhIQMBOWlVXZ+yoc04ip+qyvya13ZWULCCZdaN+dOjplhIHbWV?=
 =?us-ascii?Q?CrMzvmqvxLj8tLYn+QIDxVYWT3zagvZAJplON20TUcPYQYwauVRlykA1FGFJ?=
 =?us-ascii?Q?K1kgs7VrXiv1Ivct68DYnc63k7fcnMeuXwtBJms9b+jr7k3S+Ezn6FO9IKw8?=
 =?us-ascii?Q?xGplfXubfEVjth+Fve7ivBRUORJ0EBg5YQKUrsgSFX0Dun9JQcsj2dXI/uyR?=
 =?us-ascii?Q?5xlTRYhFlM6Tz1rHJg3L/m6CYJ+bwDc0lctAUnC2TfQ8I3xV8wPy8Py3hbZA?=
 =?us-ascii?Q?zAtJ76I7fbTGShjhQOmh5MrkHbpXvVLx3dR/qMWICKgdeDsMir9roHuH5+u9?=
 =?us-ascii?Q?CxtSMuvM5goaaW1+EgT6IFrxlwLmtYNRDcz385ygEj3jzRVQu6psEN4naBwu?=
 =?us-ascii?Q?YfyeZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518bbac8-a53e-468e-984a-08da97243640
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:11:41.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nn7pEK732pgkDOY48o9PFbFUshI47P7BIgq3Lh3R6NkDK9k2IffjAMwddfInEpBMwQ0TZSxPmR3rUUe0ebG3cohmAV9ZCgln97Gh/4FcYfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2258
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
