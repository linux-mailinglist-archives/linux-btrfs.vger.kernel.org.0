Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F727A0706
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239843AbjINOQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 10:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjINOQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 10:16:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469ED7;
        Thu, 14 Sep 2023 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694700991; x=1726236991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eg3IHYalZYYZFgM14cI7rChk69Caw442P9JjQEo7PJ0=;
  b=g3LAfcV5d4ka/42bp/TDJXJaAgMfxcCAL8Cr5X7bHrS6Abj/qa8uEpBs
   KoPg3Tl4n6B9++WjfyH1nGKIxVibdgcsyhOJu5mIAoFr5I3Ir/LNIZWxB
   bbFoeDXyxt9GT54sgYyI+MmwNf2ypFz4vFOu8/iwPggr6dONj4ykKNggU
   +Si2CZTjuQ+ZFgz0Mx24soqjqIoeouMv+ek8eByPzIHGPZyqB9/wPIX5n
   HMUJhofO2JxKZZdaR2PT40LOaaLTMKwM4rpM3ga7pj78IUv5lyjJdieyv
   FDEa668PyCOTslMbAWjCXWaHPVbAq8K69uYdq2ii0s8rMRfq10cMzzjW5
   Q==;
X-CSE-ConnectionGUID: shC2wpofSCSH/3+8Nsmy7Q==
X-CSE-MsgGUID: p5C2XZ9GSTmqobokaVsECQ==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="243961183"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 22:16:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XL1T9p16Nl/Lmg+y6T1T34ifQV8Jet3bB8qw8M+CWcm7sC/32Vjqx2JqIQfpIPt2+epmiC5rr6trh29Yvjzv3moed7NBeBeeFNXOFLXqAnIkbpUhAA6SP7wgfsn3H4s3A/yGTS+bQ4gbHGBYpwY7GuMgq1cHRpTp23pQu/FTMqevm5FdL7fhe9uVxMG2QGVQY5Rec0jANMwzPp7PcoQe1fGCRZbMVoXxxP2U7phDE8Dx5i07CKFniUmviAiPDa2u4cecJsyCLBv2b11+/g3aoHJRNhMvPoYDutmOD0UdxAE4TGTROJGJc/e+oW1jyKVRMl1yWL84NifACtNlquylNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg3IHYalZYYZFgM14cI7rChk69Caw442P9JjQEo7PJ0=;
 b=UeZkP39cD1u2xT6ymqSlC4qK5snxnSIUp8qk1uNZN2bcVeeO0u7ugFQz7gR0PbbeTu5F/mnPdor8JoTpokSQHRaaOTuhRoEgIYIFS+elnnYMliAoNr4Hu7STarAvpxPQfC+tp38cnO4LiJ5yNOQ1DB4KMqSmjVGPWS1Bz0KT5aOcQs9/PeG5L0vtCTFcfNp5KbxS1bKylvwK9b45qW+cviTL1B4RTrWKyMUBTnFSvoAy6Jmh6ORIyBpFB6lwCDjJ6YPAWULh4yxPXHwQ/dQbf9tCSiw4ZDrYaR3MUsr3C+lZ5tONQs2S8LoOyB3gfXfsrPOYhoYl3kEVizcx75XzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg3IHYalZYYZFgM14cI7rChk69Caw442P9JjQEo7PJ0=;
 b=NH2lPO9yPnlzwxRcAX3lmLnTHuFT0Rc21R6FJltJsw7n9qnF0zCGY+7g4WMyfB7bgL5vdMuRIdhMyKh4lC5YgNrDQHeK3XurAGY8DZmDDJgnBrFioK2Ds8HbPd3Dt0zgsrDgO6QNERd0vtLFImx7VZGiaQOvCeGlI9/zj/wCSeI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7007.namprd04.prod.outlook.com (2603:10b6:208:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:16:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 14:16:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 05/11] btrfs: lookup physical address from stripe
 extent
Thread-Topic: [PATCH v8 05/11] btrfs: lookup physical address from stripe
 extent
Thread-Index: AQHZ5K7X+NaiivOY50OfPFaw/W1JyLAaD2yAgABTUAA=
Date:   Thu, 14 Sep 2023 14:16:28 +0000
Message-ID: <0cd2a81f-00f0-4afa-ab24-448d89e1d4e3@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-5-647676fa852c@wdc.com>
 <6de87230-f981-411c-b173-55871e4d4720@gmx.com>
In-Reply-To: <6de87230-f981-411c-b173-55871e4d4720@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7007:EE_
x-ms-office365-filtering-correlation-id: b5f8078c-7f21-4aa2-6b11-08dbb52d3015
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xps2zovHk5FMTXSLtGqcHu/cQtkdtpPhRlJ7OtAzPXrE+WUX1fc7FTXXyfr0SA8U+GsrhNE9JjWuiyX7zX4tATl0fUy/dpyjQFWRDlRAfD/yoy/akL/QEswpUcswKXryTDcynoUmQycMf4iDPNzARdE5BNHYzubPKU9loFiqb8Q5r1osCH65O9Fs+HcLVNS470PEtzZbhjwvT81qLFVRTHYxnxvuLYDtyZGJGTnpCFMAZSZFiZJRU6iCH2YHtArmkT62ZdqH48I2MVvLiBWgMkhoxjdDVJSej7LqhybWHxV8CTLrwZPDE854kkgmNyDtCXVDqzhZX4KIfpZLEbdEJR0hq8jZwIavj+AWlvD0oRqY54MCkXR4zHRsC64YAgrxWcFv5Y/EvjRm9cXyn2RrAAqxJXyjnDNzuNJzwkdj7HWpgJ6w1Jgh8SeHfLkcAVbpKdj7/nqXckUBwFQje1o/wzHoJpZRrYSiw3k4iLy410THu2i7BP0D/+4SxNGAaESuYsugWOBRU/UMRYxp9X7ZhoWGwctHaB+kDeyMIu1IKCDM95nxJomQe0bK8CpyI6dNqHxMo0ldIc0tdHXfFZyJMG7btLvo/SndmlNtsQ9b5O8338Ys/UP3XUC1kYjHsE3Iak3aVrIbwIOFaE/D5ZgGaZqzmGgkJxShiD2ALFDYyKjamEnpWAni5fcFRUHGslLU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(31686004)(53546011)(6506007)(71200400001)(478600001)(66476007)(6486002)(38100700002)(38070700005)(82960400001)(110136005)(91956017)(83380400001)(6512007)(2906002)(2616005)(26005)(36756003)(122000001)(86362001)(31696002)(64756008)(54906003)(66556008)(66446008)(41300700001)(66946007)(316002)(76116006)(8676002)(8936002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckp4SGJ2VVpTMGJ3VnI1YnQ2Rk12VXdpa1NTdXFYZXk0UmlndXVtTVFLa2Vp?=
 =?utf-8?B?UnQ0S0Z4cUJSNzBoMk04Zmxmc2dZNXBBKzc3cUE5ZVRBY1kwV0dacGtvZ1I5?=
 =?utf-8?B?YmVwTXZrZ2FldVhRQjR3QTBSeUlSRWlqTWVrdmttUnBGaXpqOWxwUENaSUVw?=
 =?utf-8?B?VGdXd1ZPeFFhaVFJZ1JEbXJvdzJzUWxqdk52UVhkVGNNOFErRnNuWW9IRTFF?=
 =?utf-8?B?a0dNVnpzNy96cldTR2N6YlJGUzRQK2dRWFhBNktrd1RaZHp5WFBqajVRalhW?=
 =?utf-8?B?QUZnbzkwWTQvZy9QR3FaejJybkcycGJjaHBadlFDaHRSS3NVSkVNVzV5L0o4?=
 =?utf-8?B?UHdudFpnYTFJT1ZCZ0tCS29QMmRPdDhNUmY2NzA1YU5FK3hmZ29sOVpaME9o?=
 =?utf-8?B?QlFhYkQ3SHNJdHFoMW5UUUNFY0h4dmdvaWh5QWFmQlkwUlA5UXVXWUJ4eW5S?=
 =?utf-8?B?WlVlSURhSjRoL2RRNGt5aVJ6dHYrclFBL3NEUGYxR0JTUUZ2OUJXVkR5Y1ds?=
 =?utf-8?B?aEc2U3ZQdzdEMUpLcTFtM3ZxUGdWSG5IZms4ZjJzL0NQdTRwajdLanorUGdt?=
 =?utf-8?B?T1p4eHF1QnZCbW42elJWQmRBUDMrelh1Qk50TXNibHhva0dGby9FTHhId1NL?=
 =?utf-8?B?eCthQUZsZkNwMWZ3c2xITDNLRkZCWFIxMHYwU3o1a2N1Qlo5WFJZZ0U5N0hu?=
 =?utf-8?B?MitVamFJSGhsV2U5eDV6MlZ3UW5nZEpLRVR4MkFKLzFDdXlidThCSlM2Q3k0?=
 =?utf-8?B?VkJhMTFCZ2MrSGM2ZkhMNzd4NjBBKzFNbHNEdnhYL1h0UjdoalBxWkF5VEVw?=
 =?utf-8?B?Z1htZHlwbjVxT3diVEt2Z2N6SW03aEx3ektodko4ZVQ5Mjl5U2lLVDM0T3JE?=
 =?utf-8?B?QXRyVVhac1lHNEVyeFNWZDk1MlJrR1dLNFIweDlWRmREMmFtVUpuVlQ0ckVa?=
 =?utf-8?B?QUIrN2M2RGxVakt2eklPaUNhMXZzK2JrZEVXS21lSVFuKzNjSS9mR05MUEVR?=
 =?utf-8?B?MVlCRlUrM3QxWXhpL2xWbkJ4eFUwT0RvaEpocE9NTWJoSHRUajhHcXQ1cnVW?=
 =?utf-8?B?VHVVc0pyVEh3ZVBJOUhlUjlRaUNldjZxcDd5a0RITStFNlp6U3YrbEtNRDdx?=
 =?utf-8?B?eGpRdkdBMTFUM25aYUV5c25lVDF4cHNiWjdzbGVQMm9NV1VraXZ5d1AwOEtx?=
 =?utf-8?B?VkQ1ZWw4VmZpSURiWlFsWEhsN3VEMlJYN21XU01mVmIrUU1ZT2VpZzlFR3RR?=
 =?utf-8?B?ZG1Kemg4VTRnd1BtdTlGMDFOdmI5RitMS3JqS2trVzZaalJodFdjd2ppS0ZJ?=
 =?utf-8?B?ODBubEpJLzBxcnl4V3dsbzBTQjZsbVcrNXpGbjdBSTR0RXFRdTNyRkFoSXdk?=
 =?utf-8?B?SlpheWZzaTEyWXZVQUFjSjBKdXNZZ2luTTVKZGVudFdGMHl6MG9CRDAxL3B1?=
 =?utf-8?B?M1ZFMjVZd2N1NXRuL1F5WW5RQTRZT2JlSkxSZmJZbUc3YUZ6MVVOdlgzcVlG?=
 =?utf-8?B?WXFJWGo3Z01POEhEVGhIWHhiMFdlcW9IeFZpWFdQWHFZcGdpUVJuQStoaG5K?=
 =?utf-8?B?WWl0NGJIWEJoT0JiMHA5NWlqVTlzMURWcHh0amFHRHB6akVvbG9QUjQ2ZzVM?=
 =?utf-8?B?dmRvM00wZFkvS215eGRZVVh0QlZyY1pjY2YvWGhjSWNBZ0FXUkJmRXZ0a0F4?=
 =?utf-8?B?WXNpeDR1L1V2VWxETkJDRW8vSFFKN0NMQTdtb2Z2QlZmNDh0U1hXT1MxSlpv?=
 =?utf-8?B?UERIaWVyVm1WODlEYkFIZ1gyd0p0WURsWGYwaXdRcVFiaHhqS2g3bGhTSXZz?=
 =?utf-8?B?UkFxdGdRNzJJMmc4a2pVZnVLZ3FWaHIySE9Vb0Yrd2dIOXluRkd3R0lOdVlN?=
 =?utf-8?B?S21qNE1lMVhhbFl1dG9valljd1p3bXVyK3dqOWxXNjIraWJKL0gyaGlBMm0w?=
 =?utf-8?B?cG9XSUp1cXp5VnQxNG9ML1FOMGR3R2dHR3J5WFhOTGNyRjloYU5TbmZtZlp2?=
 =?utf-8?B?YzFaalVZWkNlUFY0L2JIcEdSSEk2clhoenBkN2dDWE04bmxvMUxwM2VYaUF3?=
 =?utf-8?B?akJMVG5id05NMDJkYlNDQ2NYTUN1c1RDU1NMZ3cwUFUwRC9YODQ2SktadzVT?=
 =?utf-8?B?K3JvdjFiNlNicHY3NXhOclZldFlpU0xxVnZyaXRxV0Q3QVI3KytwaVcvbnJy?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8642972B6A84EA45B0E3AEEA0043C04F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S0ZSTW1VdlYyZFNPRVdndEVHOEdxQVFOUWliSlM3eXdyL2RQNExVcGlES0pH?=
 =?utf-8?B?NFhtOWlYYnRxWktHdDJhMk5tT3R2VkFCUmprN1VqN00wbVJXaVJaNnFzbUVs?=
 =?utf-8?B?QlVVL3J0WlFic0tVY2lkWkFNS3EwT0oyODM1d1RIdlp3ZWlhQXVlOVprL21m?=
 =?utf-8?B?amd4VmxuL2FKTU1UZE5jSURJakQxZkxJV08zMVN2VXcrMml2UEF2R0w0NTBv?=
 =?utf-8?B?bCtpbzNWY1luZnB0VnJjRUx6aGdOQW5OQ09Bdlhub1Q3VkQrckl0NW5KV3hx?=
 =?utf-8?B?THkzS01hckdCYy82MEFSa1RyeXNHRndyaUpXQlpBR2VNK2llQndYd05CNVlr?=
 =?utf-8?B?ZlFVOS9xUkFjT3JwbXVjSklIN21uTCtBelBGRHVTWTRIT0tEcE5IdTJ2bHVl?=
 =?utf-8?B?YzFzeDNXUUFsTHdJMG9VL1VvWEdDMXJ5d0RxT0hQaytGV1V0bnBPZEJ3a1hP?=
 =?utf-8?B?blppSjhiL25CL0NxOXcxYnovWEluNGFXU0pxWTJUWXFQUmJBa2dDTTU3WHJ4?=
 =?utf-8?B?NjlPeDE3aWRKK25yMlQ1a3dHMGVkeUFqSXc5a2JNVVVkWmlPRmpzbVNLdDBU?=
 =?utf-8?B?Yll0aXNQRTBJWS9YalpFRFhWcnROUXZzK3lwSlcvVGtrQ1BydlhhWjlIZW5N?=
 =?utf-8?B?YW5WWnBleWFBMzRHSFZiMHF0bEM0VGFvVEtwbG5XM1ZWSm1xNDhETklHTjV6?=
 =?utf-8?B?RXJVaXNVMHhSN2RMeWMwbnNIU0dHL2VnTStkNzdDNkljRWg3SU5IUW1tb2xq?=
 =?utf-8?B?em1wYnloYmx0bFhxdlArajRwdHBrZ0pTM2pCdnQveFFRZGpFRXM4eWRkdlAv?=
 =?utf-8?B?RVZlMHJtcEluNUhZYTdCNUZmMm93WCtQendFOTFmeFFvcldHZlRDZFBRODcx?=
 =?utf-8?B?elFMV3M1NU9JZGVNejd0dnF0K3dPNmltWDFPR0NYcDRPUDVPN2JnekhJUzhi?=
 =?utf-8?B?TFZGNHQ2Wkt3REEvYkVWTVNnUXM4ZytKRjZ5WkpFSWMvSDFrUVMwU3psUVNH?=
 =?utf-8?B?TENTVzF3WWt3QzJjdTJzNE93TXpITWM3Sk9PM0NHL29zc1ZrbWxmSVowNTZD?=
 =?utf-8?B?MnFTa0haMGJWNEIrZEJyN0tLVk1iMXFDT0xoMGNWZUVTSlVadFk5QTFXS3Bn?=
 =?utf-8?B?NWYwdTUzanlmcGlZc3krRjkyV2JCWUhMaFJENEpDTXZncVNEaElDZ0hTazZL?=
 =?utf-8?B?MUZ1L3JONHIySCt6dkFKdDduUGVoNEgyeTBMOUNReTE5SE85eGRkTy94OHNr?=
 =?utf-8?Q?arjJ1kQPCs+KI82?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f8078c-7f21-4aa2-6b11-08dbb52d3015
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 14:16:28.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAHpO43LtmU1JN+frEODmXe45g/Xr66IpOOwL1E2QvYhraXbsei33GhK2C0ObveJl39uPxyVeDySCIzQ3oNscIysd1f5XMB5UHdij8BwLAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDkuMjMgMTE6MTgsIFF1IFdlbnJ1byB3cm90ZToNCj4+ICsNCj4+ICsJd2hpbGUgKDEp
IHsNCj4gDQo+IEhlcmUgd2Ugb25seSBjYW4gaGl0IGF0IG1vc3Qgb25lIFJTVCBpdGVtLCB0aHVz
IEknZCByZWNvbW1lbmQgdG8gcmVtb3ZlDQo+IHRoZSB3aGlsZSgpLg0KPiANCj4gQWx0aG91Z2gg
dGhpcyB3b3VsZCBtZWFuIHdlIHdpbGwgbmVlZCBhIGlmICgpIHRvIGhhbmRsZSAocmV0ID4gMCkg
Y2FzZSwNCj4gYnV0IGl0IG1heSBzdGlsbCBiZSBhIGxpdHRsZSBlYXNpZXIgdG8gcmVhZCB0aGFu
IGEgbG9vcC4NCj4gDQo+IFlvdSBtYXkgd2FudCB0byByZWZlciB0byBidHJmc19sb29rdXBfY3N1
bSgpIGZvciB0aGUgbm9uLWxvb3ANCj4gaW1wbGVtZW50YXRpb24uDQoNCkFjdHVhbGx5IGRlYnVn
IHByaW50cyBoYXZlIHNob3duIHRoYXQgSSBkbyBpbmRlZWQgc29tZXRpbWVzIGhpdCB0aGUgY2Fz
ZSANCndoZXJlIEkgbmVlZCB0byBjYWxsIGJ0cmZzX25leHRfaXRlbSgpLiBTbyB0aGUgbG9vcCBo
YXMgdG8gc3RheS4NCg0KPj4gLXN0YXRpYyB2b2lkIHNldF9pb19zdHJpcGUoc3RydWN0IGJ0cmZz
X2lvX3N0cmlwZSAqZHN0LCBjb25zdCBzdHJ1Y3QgbWFwX2xvb2t1cCAqbWFwLA0KPj4gLQkJCSAg
dTMyIHN0cmlwZV9pbmRleCwgdTY0IHN0cmlwZV9vZmZzZXQsIHUzMiBzdHJpcGVfbnIpDQo+PiAr
c3RhdGljIGludCBzZXRfaW9fc3RyaXBlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBl
bnVtIGJ0cmZzX21hcF9vcCBvcCwNCj4+ICsJCSAgICAgIHU2NCBsb2dpY2FsLCB1NjQgKmxlbmd0
aCwgc3RydWN0IGJ0cmZzX2lvX3N0cmlwZSAqZHN0LA0KPj4gKwkJICAgICAgc3RydWN0IG1hcF9s
b29rdXAgKm1hcCwgdTMyIHN0cmlwZV9pbmRleCwNCj4+ICsJCSAgICAgIHU2NCBzdHJpcGVfb2Zm
c2V0LCB1NjQgc3RyaXBlX25yKQ0KPiBEbyB3ZSBuZWVkIEBsZW5ndGggdG8gYmUgYSBwb2ludGVy
Pw0KPiBJSVJDIHdlIGNhbiByZXR1cm4gdGhlIG51bWJlciBvZiBieXRlcyB3ZSBtYXBwZWQsIG9y
IDwwIGZvciBlcnJvcnMuDQo+IFRodXMgYXQgbGVhc3QgQGxlbmd0aCBkb2Vzbid0IG5lZWQgdG8g
YmUgYSBwb2ludGVyLg0KDQpJIHRob3VnaHQgYWJvdXQgdGhpcyBhIGJpdCBtb3JlLiBidHJmc19t
YXBfYmxvY2soKSBhbHNvIGdldHMgbGVuZ3RoIA0KcGFzc2VkIGluIGJ5IHJlZmVyZW5jZSwgc28g
aXQgbWFrZXMgc2Vuc2UgdG8gZG8gYXMgd2VsbCBpbiANCnNldF9pb19zdHJpcGUoKSBhbmQgYnRy
ZnNfZ2V0X3JhaWRfZXh0ZW50X29mZnNldCgpIElNSE8uDQoNCg==
