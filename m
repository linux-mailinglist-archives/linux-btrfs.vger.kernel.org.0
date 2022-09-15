Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B15B9DAF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiIOOru (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIOOrt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:47:49 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5EA6A4B9
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253267; x=1694789267;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hRJXXHEzn1JNUXrBXdSXoeRKHBpgVPhi0Ss/9zhu7yVYP9p05OPQ1FOc
   qEnC2M+HtxvLf2dy80KrZoB8Ma8bR/QK95FA2DKvx1Q+jVugF0OAzGL1C
   v4MjkeIDOv08Qdi0Tu6mnQXcIrvr9Ia/SoK38Fp01tIFDIxj/cPe6mbIp
   iZa0CmFed6yuPQltn+CV22KGUgzdTRx8rOxasE7hJ9r/OWgzqaIZEUG40
   ejI5xs5MkO3tMaMCQHFiUc4ZR2+0pe3htijlOfPX/HqaP1OVBS+7Gsf/h
   MkYwmOjts7RZthgWm11gBwy+iI5PUSvi4nB3IKmrbCkbmbHkoKJJrmpWU
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323546670"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:47:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCgk+iPHupuNhHdKW2RJ1EUYxih77OjiZGiXcZns/4PB2yU2xQ2VqNzy1ZJyGrcpzc1Nvg2JWkYwjLrfvVNQ3UveO3m404WXr00JeT4IOrAKMdDqylt2ERkBPoyWjasrzGTGuIuAKQxiLFkeP01JrTHfewmTiGZIzORchYYrrMGXhSBcDLYOXGDJooMEYcTzfNBQUI66K9b8eIKQeENRV5OWTZPbNpWW9A5h3OusWQvg1ykkC2FVquexGbx0MXdI5x5z0yKeE6rSq8Y9y7o2trwy6nsMtRlVHJIljF1LiGAcJxZC2A+0WEdz/C5j07nF7BawNoWC5cI4m6Fhl0+YAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WCpJE4v4EpdMEOk34tobWPq2bpQcZYUdchtTh0aO59LJS8ioYUkyRWDPV+o91MPKHnhVJc9eXLDtDo8uRsnsXMLL5pUNtsjzypsi5MiQVrKHO3v4bvIUHlLru/e2vyiFYyYX5keuLPJHq851sq3XjbbcuL65gaBV7p2bC0oqOuIF3VOTu9fE86/JuQWFxBRIQawSx30ZweWeLsipT/0QYBaKZccBtQ4+Qk270s/YsXlqRT9/Fk2pSUhH/FMw4IBEw+jDyIo2yLcW2KqirDD3RCkUWo8w6ulWSpEJC6HjSWS16uGFjxjL+3xZQ/Y5gBcleeNNmoic/sduzg9nuWg/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T1NxF+VE95QdBv4elt2N2+9LtfN0mvVQAlYYe7eZ8qodMFWQ5JNJzl3MPcxmUhnH45y6bmqhkYNhYV92PBV3UPyxc+oIxoUYonJHrxsXHvryN49u4Pix0NMJojMYeiumlxw7JbuYZW0NrUVs5+EM9CcyOl0/WZx4+LfkqTjFj3U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN3PR04MB2276.namprd04.prod.outlook.com (2a01:111:e400:7bb9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:47:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:47:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 09/15] btrfs: move btrfs_csum_ptr to inode.c
Thread-Topic: [PATCH 09/15] btrfs: move btrfs_csum_ptr to inode.c
Thread-Index: AQHYyI57ityEMUEtdkqkZZSeP7qJug==
Date:   Thu, 15 Sep 2022 14:47:44 +0000
Message-ID: <PH0PR04MB7416B514CFCF699EAFD6178C9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <c3cc874650f6266c390ff3d3631b7220001e21ae.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN3PR04MB2276:EE_
x-ms-office365-filtering-correlation-id: 4cfd871c-8810-4539-b67a-08da97293fd0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jVd4QZ09pHzsj90q/ta9mQVLBlMV5rB6X9hXETyi7EgciooIV65FyDW22mN7jEFNptktvHHMaKXK1XTF5xAzrTqzUdV/DLzSA7rG0f1sFkqA1mB7onLUC0M++DnqFGTBeYgbf2WMQldzuznh+f1WZglINmkF7ule5qtcTy6/HPnRLTwDRDlzi9xWiXf9tbEif0jp09EtoB+ffUS4RaeTSLiGYCmMiVPnvOrfxT/Vo2hM/t3pw3Rh73HoFebf2Nub2EZQGssb3rtn2COf2qni2eGRNGFUt8hh6760fvVZafthE0//0tYUCjDrXtpws3/FZD1UB8TlzKu6S+d07dFDGody9CBmwzbXOOBokD8NhnFaKw85Y1DikOaWVYYk8NqTB0/AcyLjowC+XuRScMYuAknLzMMa0RxlWZi8wGKAdKotTqC60RPeuuiuc3tu9Y60APKQgZK3FciWmg4HQpEEZaYOew0b7POOZnxdA61B2GjSfiBPKr4YB+Cf1G0d4vrUSzbMEJwCxCP88qiUZAAM/mZPF9ag93CeO5zleWfJ/7wmlmfFQO7K+tiZ/kPZ0NUoTbqfG6wsRoh2bW+An5WdV3jr+3DzeUk7mvH9EK1vRK0E1YDWfbPsDwWmkkqNiS5ZsHwVsIh8bnNPR74LHXunyPBKG+k8c0ZmT7vt4hS1hg0IkJWKvrk1eN9E6H3EtrUNXGp9/WeezLscKiS2fGyMEuL1ya5MWMMn/GuKP+bFztefbqGpAHIDa7TzyFytkpQaTpd1urKxYznpeehkbc/wJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(71200400001)(478600001)(33656002)(110136005)(52536014)(6506007)(7696005)(8936002)(38070700005)(91956017)(558084003)(66946007)(8676002)(76116006)(64756008)(66446008)(86362001)(316002)(66556008)(66476007)(55016003)(38100700002)(41300700001)(82960400001)(2906002)(9686003)(4270600006)(5660300002)(122000001)(19618925003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vf46iV4KAxglQYSayOF4ZciH5HUD5O61/qfn1LizM/LEQ/jzPJECsubm+Ao/?=
 =?us-ascii?Q?wFnE7f1z++nVl4oVNogAAhmrF2GZO3kLDmR3Daty7fpQLFdkSl+dKrU1l1L1?=
 =?us-ascii?Q?7izVCXBfnPJiQ7VwFd7+bFuhcAd8bvB3Sn0nOi0GYa9CWri+Stw65xGb+lx4?=
 =?us-ascii?Q?MMvS43FWK/9KrJlLdgmJEPsbuFjn7CNaLZ6L1lHj/EKxlnlEUaApTBHs2CmW?=
 =?us-ascii?Q?lyLv6g9WhlybfyDuIs86w7sRN9LCTfRl7KhiGmRlwtZUSLWqA85mXWOSUvu7?=
 =?us-ascii?Q?rQuj34thhMvXc6/n10ttIW3zWdLGjF6ZiNoMVdyLrHJX5yHSFamSKX1uPHcy?=
 =?us-ascii?Q?jOtRmXm2IPHc4/oyfUsOp7Z1//Zcxr07uOUtL6xqOQnVOnMkDpXqekq/ClAf?=
 =?us-ascii?Q?J5KW0eM8vPRzWJgabWlJI0Uj4yDn7PDrMjSrqlhVrA70TuVqjN53VAxe0fH0?=
 =?us-ascii?Q?PwNI+Q4DV+8ntNzwh1D2kRQAAFjgmaKFsMPprnBp+emAaC5z8qkWFpUtHD3w?=
 =?us-ascii?Q?bWfjDthDUMVCRWCSsS59lS7BopVPKfqT2UlKsYrWz7kDI/8Ol9cJQ6IuItwF?=
 =?us-ascii?Q?Vlm9VULUECRZsyLSmpOCYgDO6Dc5+AxJemfHqox6ckLVkvjSTDmX56i6CyDa?=
 =?us-ascii?Q?r2d0U5cwwDy6gkBevHB4eZOsh78L1RrCEVA1YmbYKcPOq3LndGQZzIwikAil?=
 =?us-ascii?Q?nQx2yYAAuY1zAmH2I0UJM8Jt2TH8SsWrGrkOwOJLFfmaEXxZ065NjfHCRUHI?=
 =?us-ascii?Q?pcWjyAfhmXPb95E5f2nshG1KzpjIoi6RpuW/kZ+7h22HnShJwq6TeXxUUmTA?=
 =?us-ascii?Q?let6IeEKMWSFVlDMqzA6Vf8QxCGSuA9Ip+Vbg8zkoWLMh+dVLph0S2aclUuI?=
 =?us-ascii?Q?dNJ3ZSHCtRfo1jWaAVA/5UEPRLEjoSF0mukqghWVdBHlwEljOpZ4YBQxriSf?=
 =?us-ascii?Q?PeOnK4kHdqAorBDhYz9b5JleuXXJQTQWGsNdxa4rzBzwOsj0MKQtyUcTUv9h?=
 =?us-ascii?Q?ccvvxerOxoKGck8QWYuGj/E/eGlbBMm5Jl7SKnxCehkjXAse5kAjU2a/qnng?=
 =?us-ascii?Q?cMv8nX4pomIhR14I1+3K6gtvq4OcIcHFqIKy/0SiSO92Gh6hoMYMZ30RcwDq?=
 =?us-ascii?Q?HlMeh+0FTFYLi/WMEiJqzk2Ghg9ieSm/w4AhldviBVLi/IEhqwTzuLX87m71?=
 =?us-ascii?Q?ZYcCnJggLku5+QGDjrYH++U0ad3+eiMe8hdJ4wtoBdBXltwwFvH9ApvBmJQt?=
 =?us-ascii?Q?202vb6Vzo/hezBBjmzSZ06Tf3nYaf/wXD8hfEHWDFSzLjHpwj2v/wYXZmE53?=
 =?us-ascii?Q?DXu6f9vjUCA3lZPOEl7C+TUaehZkPo6AdNAKWWjZO1NDlUNS/gs0bgaUhQ8R?=
 =?us-ascii?Q?SWfcoPNN2Ge52yjxlkwdOCCYy9A12d+/0PZDx8trq3gM5/KeLnHZil73ib0s?=
 =?us-ascii?Q?y9u/RJfL2oOv4huTMGM3nzWt1YgztSWzL7QopeGUP++vL9ODmgNWtJss0bV9?=
 =?us-ascii?Q?IH5GAukiMlkJt4XTDN/T11gnEPh5HUZk8P9TKmH/igjRVjqHMToBLA9c+Z+3?=
 =?us-ascii?Q?T3jGr4Il4MXhx9pcXn78kHIDL7/opLx1bDKpUOUDvi9O/cEB8qYSHSixFUf3?=
 =?us-ascii?Q?vfJL+k7CMByY0hAOMm/oCgH7Do25ILwuPwsKeE3yI7rJ+yPhUxTnFtduZ0SS?=
 =?us-ascii?Q?S1ZW1Bsocj2kOwahr/EXaozzQ9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfd871c-8810-4539-b67a-08da97293fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:47:44.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZhKhV/8GESieJJytV9uhPI8t1VarswhDRcI66nkTcG5IolbMf8su2SvbYLRAXQkQRO18c7QmwyEE3cmsOJTD3oV+wXwjvq2VxbLT6aZbAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2276
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
