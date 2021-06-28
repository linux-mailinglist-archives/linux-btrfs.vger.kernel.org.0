Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D53B616F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhF1OgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 10:36:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14430 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhF1OdZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 10:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624890681; x=1656426681;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p6Htuc+WJGyZr+NPqiDzRVvOco0p8XNEQ/nlfVkSlI8=;
  b=mKa6TWR6Za8qZy5QG6s1jIXOzS9txT2v5E6WeiRb483UH4FvTMivIQP/
   x3pTzWYCIi2k4kZWUuMhKLcgNIkULSGlM0V8MPdyfqCVjLb8LUeiPu3Me
   9lk7KNmEZf5QAcQIhmaUGsaK3u0S8Q0yssq/hV1Yhj097cBi8XQllSpWx
   jSEEx3rcDJmuwVjGRkP7TXV7sE4DQziZIFNqYKrbly/bBfdbsG94YP8R0
   cDAG+Zi9O6Da/RzdsZ9rHZPJ2ouL3LfNPSFFDUFBWplbjP7u8nFKJg0jO
   c3C2E7qx4n3t/opHRBaTTIWsf3Xfml/dm+GzfhpODKX8MdxvYai+7HPEO
   g==;
IronPort-SDR: Pi5tJnOuz0thyKNR2Xs9pfCIgojbj1WWtTDcnlpsjPEO3PkR+5guaKYs0gmlN2O2tpOPUZJcne
 SxSgqhs5WSrGYuqL3OWTWlV6oWjAhDLmnNuJO+RuxRKUGb2vCYYvAKRHwUrVsneY5wS/4EW8oT
 Ktm6DQBRYyDpwJR33VdNolqP4WTjkNwYNelRH4cftN/xrdvDJpTmFnUNCuqOzgH9pq2tg/2Cl6
 REFd5jW5GhgYjfw/6ZLsiQcxP/8tkY0e2n1onNvLu1EN8Hm5mYaK6/y1XsRwPdBrAow6ODH+Bu
 yqM=
X-IronPort-AV: E=Sophos;i="5.83,306,1616428800"; 
   d="scan'208";a="276892284"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 22:31:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSz6DnUiH7RCldWduX7O2r3SmoCcdLzstBmHDb5WeLMVbD9VL+uRf1xyK+MElq+RRE1nU4S3Und1cDB3zaqDtXdWh7/jTZo9kag+ix2PSrL6M8OCymlEbIztdGv6YR2+Xzc4Sa8aIMjeke306r3v0xaOUs43RB+rAd206/FuEz70uhVuAyPQKMcaQzgH0bLMFDXJ7kLPCjvYWk68N0ogeLFyxcW1jhUZ3XO0sJ6yJ4sNBe45ijNb3SBoKYRu4rwWG7t4IB5Stve3QSd2U/33QMLvr0GResFnpEueh5Bi6LkL8Sps/+05HCQ7aXjVPhWwXnXIe1EaQgbR4Zq20yVj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Htuc+WJGyZr+NPqiDzRVvOco0p8XNEQ/nlfVkSlI8=;
 b=OViGY+jSbvD7P563djzfaY8lK2YQEmzKNHMek1c7mV2o8Z6qFNyuO0YCJwUDuDEsnxmqHFpkNh9tvln9WincTNDMGtQYecjUsp6G7Dl9iOZm6JtbCRT0GCjBDzW2j2EJvbhJ5dLKKdTDs0MwEs5UXCQm1kmCqhxgnkvoh3wLD0WVfIJbnNdntmBkcdfq/mPvQhBoXA+4iJYVnR5DsLZFAy9wsyDhx05ioVgOQCIH2LcV3p9vaRe4XjXOofIlwSGTEiiVjVoohyuFXrJsILm+FbydPYnYIDZi7KGmlf0KzNsHYjUKmxjXRjixvGCdY1Deuk6CqWPdBN7UgZPKqBPQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Htuc+WJGyZr+NPqiDzRVvOco0p8XNEQ/nlfVkSlI8=;
 b=YeiHbVBvDfKScLhrADM44r8qHBaO50SJ1JEECu0k5vEIW0r+TjyL+ZZbPmTYhD/HJKIoxeqwWwEdt6R+3a5thvToTN0cFMwh7xZnu0UAi++zK8bAQ2atFsl4oXyt9kFfJw1dRLaj2HB4DVN7wVpNr22rJBx5tgxyoHLSR5L3t6E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7384.namprd04.prod.outlook.com (2603:10b6:510:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 14:30:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 14:30:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] btrfs: drop check for lowest max_zone_append_size in
 btrfs_check_zoned_mode
Thread-Topic: [PATCH RFC] btrfs: drop check for lowest max_zone_append_size in
 btrfs_check_zoned_mode
Thread-Index: AQHXbBMXTnP4fUQrVU2CXQnDp2QFPg==
Date:   Mon, 28 Jun 2021 14:30:54 +0000
Message-ID: <PH0PR04MB7416F57406B2DD15396AF5D89B039@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
 <930bc4470fafc02a3b8888fdc24f929977f7df24.1624880252.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2.247.254.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8438a41-9399-4a81-6b2d-08d93a4156a3
x-ms-traffictypediagnostic: PH0PR04MB7384:
x-microsoft-antispam-prvs: <PH0PR04MB7384AAA3D89036C4965DB3339B039@PH0PR04MB7384.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYA1DVUP9DdCvXk0rnbR0m2rYfMhOKxWGEsG6aGl1RWDQ5a1j3oTDNPUcKnls6u2womVPbf7L1KDWrfTX2d6lCajdvZpzSHnTgTTseUWfbnzE0S4ZOQVyKE8aWZx+wwLPdKemEFHnmp9QI6bl0Bi2Mzo4Q5kKmBIM1RMQVyjEdJVeqrTO5/lYi2nUzYSQwrFFfiT7W/IGijO1sFuOoEjVEtmMh2eDNkWphXXNO2rL9FSp087KNfndrnv1fmNmFOm0a4xaJ4skcDi2cfCpy5dPF3aS5XFMnXrP1Jm93ZwHoGXi7hx992W/qVjIWBNj13rwRJ610B6pNqxZQHj++t9nT7GT0Z306xgACdiy0XIzqiI1W9Ul1RNVkJ5oGJKJGo1/APGLRg8eSLavn6eDUojI3djbRWHkunXe7POpVkG18bHjYpqx8WHbBDJfm1Fei8zrRkB5nt3EyX4QxYkJ43ZnfUKywtpcKjHj49nleZ7imGfm8NLFkrD1hNdCwSCS3q/ax6aStX8cITIki1Khlqncac/1mb5YFg1HIcbxJa5nLJBFKSjXsjDfog/w3AcbZDib7oTCvH+3S+d192rCIzlxnQCeLD7uW3rnlDq7uuNABPCX1i8ADgSTJ0LSJ14r6gehVNqTzNUawUV2nAe0/x3uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(316002)(33656002)(110136005)(122000001)(478600001)(8676002)(9686003)(5660300002)(86362001)(4744005)(55016002)(38100700002)(52536014)(66476007)(66556008)(64756008)(26005)(71200400001)(2906002)(6506007)(53546011)(8936002)(66946007)(7696005)(66446008)(186003)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJlPLNCZ9EN8z3NmLWtVBghhz9VSYmi7ehi4v2NGdKaH7eX6hwJIsu3YpYId?=
 =?us-ascii?Q?BTi4uZZljS8japhDy3+diR7kmoX4nVhi8eqDguzEUxElGRVg/IA2QK2Y9Hxu?=
 =?us-ascii?Q?QoyNbzD6QSPBUhJ2nmTEhzkQP63W3NX+rN9gWel4Xku8YMI07GmV8RM3gfRs?=
 =?us-ascii?Q?a1CfdoFIOWRayxgmUMtNJPO0pZDrUS0Odd89SC262QGNFTm3Z/XD+Oo3y2OZ?=
 =?us-ascii?Q?45AMgpuP109+dQ138HdxRloCP5ZOFp7piRkOcMC1h2ZFDzaGXqyPQh/eTk/O?=
 =?us-ascii?Q?KCkQilIslZ1EmiPztpbR1JTiGMmtS/ZpcnNDnjUcuh2AY9aPEQe08Koa0Jcm?=
 =?us-ascii?Q?JDcMlehCTwfHFWqt0oHBYlXXBL0xCtnFgSOqdWr6pHTbFPCLv9L6wwtmPBO+?=
 =?us-ascii?Q?GaN97oqnmwXbzC43mCgFwyG4+MnoH/4/eM8PrirMIoxlG9R70N+vH3XjHE1n?=
 =?us-ascii?Q?vreKcrnCzOzvbA25BDYIUHO2cFpRUCFXYN7L4Y6GS9ec5tC8wX6qUoQaLg6n?=
 =?us-ascii?Q?txwr7xj++vCmuMPjCNsh6tcz+0OVuaQ8teNWlvbso0cC8OpaQ05t5Q5y0h4w?=
 =?us-ascii?Q?CD8bT45n4BnyJjtjBYP2auQ3Xf17+gwZkCQFz9PQYGLpwmz2fbRiWr03fvGE?=
 =?us-ascii?Q?BxzEIbOSYcZwfS6ZkQ6pxFwyRL5PGTqXwv/xqXkQF4OiKIS0Fzpwp9E4uMIb?=
 =?us-ascii?Q?u3OlkJb1bXd77FG1a4EkkCtMen/6L/L8emg7hEYcn6UZ33XuCu79bZadMh1c?=
 =?us-ascii?Q?n0p/+Naliwbixq6apVEK8Bfcgv3zl/7ubrSpCXOL4XCkt16xS7SWg/nUgUg4?=
 =?us-ascii?Q?jTepAckULa52s4j+0PHsrGT1Z/I7AEHPae7PxYSKsO0V20ck207rKGIhTaBS?=
 =?us-ascii?Q?Bx+UN/Df/+QsdcoMD8UEKi/23Ay9xIuclGSmRo5RB7MtrEihCq2SuY5K1V8d?=
 =?us-ascii?Q?SKii8KYNgU/0HmRZC3GWlQYhdrCASV56//zAgq8swl73Fif5ZBrBWSXwusj8?=
 =?us-ascii?Q?k5CSEghU6tkJqpc159zVYIbgcZHMgsl4L8eCceaFR3FocsQ1diXLfgNOxG9d?=
 =?us-ascii?Q?ixOVwkUFi0TAYqEWOh7KMo7tyaolNN1cp3WUFOGK9NdDT33PMNaURu+gGB3A?=
 =?us-ascii?Q?7+ZeLxsqXhao5JgFt5RGg/h7ef9qb2bswWXAcWpddZLe0gEwThDqPAMEr0Fi?=
 =?us-ascii?Q?rZqzn8I9KfGalEmfUsUVfhlu/LNN99xueH/hEV2++XOcYpvY9pbC1Xo7nF7S?=
 =?us-ascii?Q?8IWFyo2fo6+9Nzldmwd2vMYyuL+bj4F5sKQiWGd0Ws+AIgMQTs9nKYlE8YGV?=
 =?us-ascii?Q?IyAQ5qpBWaoMu7Cpt/SyKO4t?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8438a41-9399-4a81-6b2d-08d93a4156a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 14:30:54.9426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K609P8rcyZWNfUmmL8XuwxDUID/VSrkeJztovtQpqOYFtoSg6lIaKjey0QUtxYPN20sfPRs1Up0pRjGqMGXRanojLxdAbGKsg4oyQnTLbko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7384
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2021 13:45, Anand Jain wrote:=0A=
> Commit 862931c76327 (btrfs: introduce max_zone_append_size) add it.=0A=
> btrfs_check_zoned_mode() found the lowest of these per device=0A=
> max_zone_append_size but it does not use it. So drop such a check.=0A=
> =0A=
> Signed-off-by: Anand Jain <anand.jain@oracle.com>=0A=
> ---=0A=
> RFC because I am not sure if this check is preparatory for something=0A=
> WIP.=0A=
> =0A=
=0A=
Oops that should've probably be folded into the patch I've sent.=0A=
=0A=
My bad, I'll send a v2 layer today.=0A=
