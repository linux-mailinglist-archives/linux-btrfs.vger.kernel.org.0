Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BB4DAC91
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 09:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354460AbiCPIi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 04:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiCPIiz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 04:38:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9357663BE5;
        Wed, 16 Mar 2022 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647419859; x=1678955859;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p6TysjhLf7ro/HSYcECNBtU38QMuSowJQSTefukd1aw=;
  b=UJY7px2y0wofFJ7nNm2TARW5HgdJxHYvRLu50p02pnm4qtOsEls9OQT5
   2WruUpJOk4CU1z0F/tXK4DCH3X4Z0aycDcuPnnvbtEHIFYbGRXSafFjFk
   yQPqmQhTY5NI4cdBvb2Zkz50y+AXpzm9IYYGJAB85ds5v6YKYd/qz4mtQ
   5ETBdGdtEZ++CqYsuomxY5o3lwtB6ZKn4e8DYKH2fpErTbnG50a1IDLkq
   HYaG55LWA9b4iX69LNu1fM0+zYVbj1yVCNRfcuSfq8hhOsr1Wnucf3nGp
   9EC+1SNAGY8OLcav6rElBLX21xb+WolZi8oLZB/XOkADYv1aZrVLFvUne
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="200332736"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 16:37:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXdtkOexvB6h80UMw5xxlChrsPGkie8Bts/ft0pz8CrjPJgEkpMUo1OW6+ytpFQnpgRkUxhA2Pwv22i15koiiPxIZsA2yTHOIYuEuGnojpzDTGjumi+iXPXTqWHfDgFmT6g6fqJ8vp9LW1ANQP0E6dSC9+3Qojb+HNZlSGCdjR4M/Em8d9Ifq6A5oV3WcvmXB+pSsX/lg1cYCIxfmulWR6NlZDTlccZA4P3l5OKfaaZLQT2lRdiYOJj5DW4mJqljNz7iGqRhRhMJw2xdqZcc+VXOTaSkisgyZ2Tj+fwH5ZCTZXrsbchenFKD1Q5sax7taI6dW1m0RimHs9UGiQeTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6TysjhLf7ro/HSYcECNBtU38QMuSowJQSTefukd1aw=;
 b=Zk5Frl/xP8Yu0EUylxPVE68ng1AV4GOWADGlLPz5HhehRHBYgrRaVzVGMGMsYzPOKo0Uw06beBVWOCSpNvdEeLS2uNOXts9NowoYt97MSJoQaLSXHoy1NIumjf1z7HJ6XLaRzaPOD/cr3tBosfJQQPZ7+pPRdu3W8bMkhPwlXd2tAv8TNFf2w5kiT7wVtBvM/fw/K5s39mFsN4ohxZ6+iR86T89lY/zGGxsZoUkdxnX2yhgv0kBnjf5tElft3dYWDwHOyVL2gll/Lmf9qwFhQ/lTg0CKfPVHMtCYWvOVB8ITC8wPR4brvKp0N/APoIaeWYMFcKbhSuchB/db9VKGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6TysjhLf7ro/HSYcECNBtU38QMuSowJQSTefukd1aw=;
 b=K/FuWofz+IMPyMNR99TQyk/H9nDVfcCu8tNNsntPsTf0fmJcZY6NlVeGCz3doNSAdp60C2OvzEaI5sCF++Y8hKrRWUgwzggRnYjY68Wfrtl3bB+mCUqzLzlIPpeqZEirrxyqVIxod1aNEcaVrGHNMqNrnqpxm85a0d0YEd8SQxI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY1PR04MB2138.namprd04.prod.outlook.com (2a01:111:e400:c616::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 08:37:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%6]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 08:37:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0u9PVwGbb7iEezZy7Ka/EIBg==
Date:   Wed, 16 Mar 2022 08:37:38 +0000
Message-ID: <PH0PR04MB741644DA1FE00A2563CCF3BD9B119@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <20220315135245.eqf4tqngxxb7ymqa@unifi>
 <CGME20220315141431eucas1p211ee887321bb49977a7ce30543bbbf3c@eucas1p2.samsung.com>
 <PH0PR04MB74167377D7D86C60C290DAB29B109@PH0PR04MB7416.namprd04.prod.outlook.com>
 <f034dc8c-ab78-3c4e-3ed4-8173dcdb2819@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7d761ad-3c58-4e90-72c5-08da07283a4b
x-ms-traffictypediagnostic: CY1PR04MB2138:EE_
x-microsoft-antispam-prvs: <CY1PR04MB2138D0CAAAF3FA860F6E3EC89B119@CY1PR04MB2138.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXD0gOfAEY1Hn/nE5FdsYgH0e3SZ9aWXebaDANwSyYmNYpQr3Yxn5byNXyRUzBcVqXadROdKQiP176p55vw6lkwwnrHqIPJvxf+LL8zlsumNyFTUlGkFCmgDFC0x7pRL3pqEFU3ZpVn33IoYr5fVC43beqnOv8lapiE/+VCTVnLqWFuZC2Xy2HajFVOsqDO18cKukQWJ5efDqLR2QBV3PNrPN258FBmu2YFj3PUzwKg9JdjfRVnMY9LttHDD8s9VupCljHq+/PG4oxQXTdmCbqv3a2PEAJUEHhwUeBhS8PV3iEikdH6mv5oJrQ/WrBIlAFlWORqNNYo4xi1PBAltkNpOu47Zf7uC50vJ1dSJOjkQmg/qVf0chscYJ5qSgvf6UC2Q8bgNqsVnx+HenKnwg4+ijCvQjlqyeLO9Kif6t5lhLQo1G5yN2Nizy4JCPN6tHBz2lMxzOszJ1gqjF86xYp2AiP6DgiSN1F+fYLDSRsqAqOLapJWZ75k2zmqxyMCNn99dUcvqgzUdCMITG5IOEjG8wUTs2l9gHJSXyU/mGmluutIyh9KvbiTWBufDE+LDu62UcnfnAJKb0QyF51U/29RsKAqd68dxR7rbKhbSuOx2CkHg1TtCkKu7kJtlOrcRu+udfuXW4mhBBpnaoenJYUW5NZBeNh1o+2+0sBgtNUTjPET4dYjE4jYFd9euhKq2GyaYyrqNPhKm1hIjaFjnQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(9686003)(76116006)(508600001)(54906003)(6506007)(7696005)(110136005)(55016003)(66476007)(33656002)(66556008)(66446008)(64756008)(66946007)(83380400001)(8676002)(4326008)(38070700005)(4744005)(86362001)(122000001)(2906002)(71200400001)(8936002)(82960400001)(53546011)(52536014)(7416002)(38100700002)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Spa+eBobyNmd31dqczOJEc59c96IZNWVzBxIrOxc1t1T//g6cej9kxhtDr?=
 =?iso-8859-1?Q?tpHgpLMRGaUdm0Hwa36VJ0hqCkww2+dD2cWfAWsaftQGsJ5k8Oecjk2KOc?=
 =?iso-8859-1?Q?gEheAO49GFkjPNsWXWAeve1oZAItw1YFv9g2IEXfwAA1+hEjjOdo7tIto0?=
 =?iso-8859-1?Q?FDy2wbCNYzEMHhxyNm3+BZE6LF+qhYDiSPFf2LCRU96+CiNRpw3xmn3IhS?=
 =?iso-8859-1?Q?U01zwGZCbtYQu5r16KFKzInrkO2jxFlMsuMzB73IyVIQ0R7pElfHTa3q0/?=
 =?iso-8859-1?Q?uEcKJVbdjvur4ZUTwpZxX+p23nTmt6BkkckANV7TGCMmxGCnVjE+N5wYkI?=
 =?iso-8859-1?Q?urHkMgpGt9Qknqmjtwc+N8U+1cDSfzGYKosTz2eCtApGfp3bcTGzlwhIbr?=
 =?iso-8859-1?Q?xdFr7NlqDa3joAxaDkx50fzCcyP6HDB0GC/V8QcpBdwx0AmpGcgNceEzkM?=
 =?iso-8859-1?Q?bMruEQ7uJFbX7bgkeDIGjQK0I7D5KoPrGyEMOl+4FxZWS3E21hwtOuVG22?=
 =?iso-8859-1?Q?4LOmiOgWvncWb8x5kciyjy+JeIbX4yhWjHprmcBPOQq2vYSd5X9xHd2dPQ?=
 =?iso-8859-1?Q?zP4GFCgdzHfMJJRyzbJZR1y27bg4nH9MtBGWDclxjFdCNsnleQVPQc8iI0?=
 =?iso-8859-1?Q?miZpIw8kO2NJvAFjkmhoCfy4CtJcjk4SN9rNLRo/8CcLXPZFlxuoQ0zbNM?=
 =?iso-8859-1?Q?OqULok1k+fCEPmAvHnA006KSDa0GpzwvNChR8rVXLObaLuSw/kpU2XEX9w?=
 =?iso-8859-1?Q?JzCf0C//BOWmG+I4hh20mC4fD2l6ipECiHGhucZkjGX4JrItGh9aCU2aeZ?=
 =?iso-8859-1?Q?/DTDypX0m0dfJiHyjjErQwDVOndBC9SGXsH54cVwUT3LR8mu54N+g5SF1X?=
 =?iso-8859-1?Q?RJ276LbrJt7vIuKZKgOulzq70tWiAbS6V6/b23HDTgi8ymRkylIqtg2P9P?=
 =?iso-8859-1?Q?lOBSwdf5z9oRSdKvN0xo7IXInaKaBFbsNPpd7VuKNvodU7DMUMVgsNTVh4?=
 =?iso-8859-1?Q?aPcHJ1RvqrvWVcxUBGmwzSGyE4+6rqwz8Ui2HY2BTuEogNIBvRM+AcbV9r?=
 =?iso-8859-1?Q?xcGxxpjwBQBFQuj7qrYosZq+1RBKRrfUeuko4J2wSKDUCPEIOaXF1O9dfx?=
 =?iso-8859-1?Q?hpRvpflQYmfeV0VjotbmAq5H+GDxUnzLkJrjnt3g76K9wjUlEWnBkIC03e?=
 =?iso-8859-1?Q?hI/EB9QQ/mv68pyBNy0j1QWcYnYbeRrFWJQsBrRt5TgILUqeb+49xgWGNa?=
 =?iso-8859-1?Q?ptuabX3/Q30SwueeFrZCXmiVySmAFB6DAKA5ZrQuD2dCrO/LAMhXsK6j2B?=
 =?iso-8859-1?Q?X40O9XwCCAjF8Y90RRXB4v8uFkmGgbLqxlZWsVtU5WYyczPAZiMdMrXABT?=
 =?iso-8859-1?Q?T7U8qctgueFAyKbU+SNvKleaJIC4Vj/eDDyOHLgzbSqOyZpEf3gqq/FZa1?=
 =?iso-8859-1?Q?UxOpQpvQrU5haU7dBbIN2vnvp+WWiX4mZ6Gjyl3INUrE0/FhUtzTfv+RBr?=
 =?iso-8859-1?Q?KyXsCqEndwVXrvjV846I7EhzNGu1LgXtpJpH+RbAKrYSMnTn/sCduHqGTw?=
 =?iso-8859-1?Q?jMIqAy4jVrxhooVE61q9MC1SvBHWAPQGSc8q947PuvCyo9EA+dG6vEzHAB?=
 =?iso-8859-1?Q?S5hLnmaJdWHkA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d761ad-3c58-4e90-72c5-08da07283a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 08:37:38.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RgwOcqVv9JdXI+b/cjQTpqEXkEaCI9gVdnzZsfswqY5QEYuHqHYegtL1xOOJ8WJdAyVVl4O+ujQlzvijdtltppeEKO2TArdNiwcnXVzNyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2138
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2022 19:51, Pankaj Raghav wrote:=0A=
>> ck-groups (and thus block-groups not aligned to the stripe size).=0A=
>>=0A=
> I agree with your point that we risk not aligning to stripe size when we=
=0A=
> move to npo2 zone size which I believe the minimum is 64K (please=0A=
> correct me if I am wrong). As David Sterba mentioned in his email, we=0A=
> could agree on some reasonable alignment, which I believe would be the=0A=
> minimum stripe size of 64k to avoid added complexity to the existing=0A=
> btrfs zoned support. And it is a much milder constraint that most=0A=
> devices can naturally adhere compared to the po2 zone size requirement.=
=0A=
> =0A=
=0A=
What could be done is rounding a zone down to the next po2 (64k aligned),=
=0A=
but then we need to explicitly finish the zones.=0A=
