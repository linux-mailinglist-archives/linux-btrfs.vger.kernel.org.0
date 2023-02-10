Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF40691CAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 11:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjBJK1c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 05:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjBJK1b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 05:27:31 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2662E6E54F
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 02:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676024850; x=1707560850;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KRaSkH6pqAd+jOzlSJM9lhIqePFTbPWcNpEcUj9bPw0=;
  b=PJKxHLqgZ6xpT3wT/raoqlT5Z4hVP8ozowleEvP0bsbhrzB/x+r9FR3n
   wRZSb9a5oUrUtLvJmKx98t8eophgTC0a8A2oDzzlOQk2xgQ2EmqubKbbs
   k00ZExax7z8i3Lb7TZAQ5c5u3YINCEZWGwtyH4lepkyNEFZ26xnTTgIO0
   1JQa8igAt6nRQu+Yax3/r6+jcurJmxSVum3PuyNj7cIKofCUStjPPW1Br
   bxVeHpjmB7dFOmRCQWHWwkTObq4VIc6PVmIVM8d8bZJX9Iq2khMaM46mP
   9lRwoDqRDQ2IxlEap78giGHIVRvhjMz2JIusRPLYBhgtXOl2aZ+Sloak7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="334958557"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 18:27:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epvf8lW002VbwBvc4D++o8h7Nwl/xmSB3xJFc/P9UvQFmz0e0rGRO8vaihLwPsukz6JGnN8IIXQbq8XPR8ajkBxLl/xjgKULH35y3FhMl4p3vAgCeono5OzSwlp1zMKvvKXcNvZ1Plpv5ADNuqNmS8wq4Bqb4cLMntWqrrT+n6e06f03xbM9ZiGOh9fujYuPilG+PLvm110up7UQBUWJzt9yT5HXspP5gsVJN8+f7vp8mV8ONTc+a//p0KCJpPRVZ/2L4gVQtxU//ksmTBSkYNhhFPJAiKYo1InPnth3OliSmX2JqNJ4w8k7AYgLtGMJX8JQX/+g1wJ38O7Spl/ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRaSkH6pqAd+jOzlSJM9lhIqePFTbPWcNpEcUj9bPw0=;
 b=oS781LKT71UtY2rBelZ/3AQpTml6bjKVqGT1Ez6PsEmYYopq++igdZk+Bu0FFPKJiTy3w9iOi09NFZBnfsfd3kpncySjz2eUF7mUAtEm+oPA32+M/QI3iNDzKIch7AkR41iXnx6mf8V9/TZnUwEDvssSlOK2aEu9wya8Weps378VdeU4RlfuprGOhRu+krhgJFZMB7X+y58r94w2viMVdfSXWc1aEbQ4hYp/XuIA3Iham8DL0asNNBNue7zXGW+9bnuIuoKRy1Wvk2X0h7PCLKOsKn2PR8aD7Un4h0QCiHaEhH5qZeGZCT03aRTIxbUFBVB8a+3pDSVooJecFOZ6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRaSkH6pqAd+jOzlSJM9lhIqePFTbPWcNpEcUj9bPw0=;
 b=YgVxawuUhk2o50JZksLVG5ifR7sY6MG4tXjNneOrm2oeivLzEhtvPNl5/U4in1t0jxwHqnxPwxMpqx0aToDw0JxBl++tiS2Az04d/Sryr+XB+Hzi9wOeaF4M0njRyf49mYLmUa1ZEzhT5Xu8upSS3vMa2PGFptlL11R+nuicyxI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0541.namprd04.prod.outlook.com (2603:10b6:3:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 10:27:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 10:27:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Forza <forza@tnonline.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Automatic block group reclaim not working as expected?
Thread-Topic: Automatic block group reclaim not working as expected?
Thread-Index: AQHZPG2akAEfAE1cFkyLx/ChHDx+hq7Ga+4AgABNQwCAACr1gIABF4gA
Date:   Fri, 10 Feb 2023 10:27:26 +0000
Message-ID: <f6e2f95e-0892-f82b-43fa-34ef32f19320@wdc.com>
References: <e99483.c11a58d.1863591ca52@tnonline.net>
 <b508239a-dd7a-98d9-d286-7e4add096e13@wdc.com>
 <2563c87.c11a58e.18636bcdf0b@tnonline.net>
 <31bf44b.fe8fe284.1863749a10f@tnonline.net>
In-Reply-To: <31bf44b.fe8fe284.1863749a10f@tnonline.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0541:EE_
x-ms-office365-filtering-correlation-id: 3426573a-1fd3-4231-db79-08db0b5167f1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjTQJsbsHCeGNr+OWuzt3yspFTjLeXOTG2HngI+3AMtJtnaJoI5qGUksLcScJWcV+6dAzCcwU8oDbdm4uSuCOBKlVAL+YmNjE7AtCDg0YDCpNy5395/kC2/cIgr7LhpasDuQPsBRaIU67fFwXMq7qM49Uar4fSp7xJ1srMhCiwWrdNbU/tGHSWCMFj5va9LbK/KnA4OVDvS47lLP4zW9YtRiaVPdEayYkkjksOK8TKKsfheN12BB9JtESfyMpR5/7S1BZgT6e0vy2WcnkX/rWmDmniO0TMAHp+Upu1xat2fk5lOjZ8UfKhSEyJLHwyxhw/gijf09FOks42WGXWzL8lThUf/Kzwx0icwRSSwSE5TwIS5V4Rm+cuGWGKsNUZDPmkrly7F0EHda3iYO68eCkHDDqMtuUrZm+nvIpmVeTXDHvpXuTtQUezPn3A2zFdR8luXGV1JFBwJm31C0Ya+mfEdZ2FIpYL6UltDmDus1ZhEzhXBYLaqxVkcZTFvm0cTZWXCIVhIguQpOOaaNNKs+snEFFuOcARd60jH8o+7+6FeGhnjbLSzDQMq6a6UIl+Yp4LTNBS4LlQZVqgo4UHJ1aYJ8/U/G4ZGhKt55oS95lZIBJGt8gur8wi3b0wV1lFITuL2FXEOsJ2wDfBWN0ACU2caibGyR1jUE3oUOlRMan+GpVfCJ9bXzkPTgwsKysUL0Jpo3vwyDXFnNlLPQQ5JvlYOpUG7/p6Tl5qHA7tLlrFi18Uh1P0tOg9D9+tuaksWQMVzpvb2o1s3sqy8PZhSA0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(66476007)(91956017)(66946007)(76116006)(8676002)(31696002)(316002)(38100700002)(66556008)(122000001)(110136005)(86362001)(478600001)(31686004)(6486002)(6506007)(53546011)(186003)(83380400001)(6512007)(36756003)(2906002)(38070700005)(82960400001)(71200400001)(5660300002)(66446008)(64756008)(41300700001)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkswaEkvNzhvajE2cVg1KzUxVXpqRHJsZFNST2tvcmcwaVZha3A4SiswUU5M?=
 =?utf-8?B?YzhURlBwSkQ3eDdnb1Zod0IvTFRuWjZaQzU4cWtBL2lsckdndkFMSk5sS0JY?=
 =?utf-8?B?VFdQSXhlTUErczRyL28xU2E3MHRQZlVKSHdvU0hZWEF0SUl5MmlMbDF6eWd3?=
 =?utf-8?B?ZElFRjk0QnZGUzQvalE5OTB0ODlZWk5KR21uSEhhbVZ1TU5URGVSMmt5SlNw?=
 =?utf-8?B?WE11VkNuc2h0SHRTbjdnTktoN01vK3ZmcFpvbUFqRHNYaGFkVUlCaUpVOFFw?=
 =?utf-8?B?RHliWWprYWVwbFBvQUxKcGJrdVFEekNSNmNJQ0N4OWUrQWlGMjZlaGVTQ0Ny?=
 =?utf-8?B?TDNtVDJkZTlQK0tSVmRwL0NWZjdXQWRoVXJLSVdwSTc1aHRDZFVmbU9wUWJW?=
 =?utf-8?B?c2IxVmNZWW5DQUZSaW9MOE93eXdmZldwanczd21obGhLMkhpNE1qTlN5K3R6?=
 =?utf-8?B?WW5ieE5MZ0NGWFArSjM3NjlXNnNHb2xjeVJjN1ZVekZ0VTBEaFpMdlVDODF6?=
 =?utf-8?B?NkdPbCswbHJZSHRlZEFjc3RZclBuWjYxNFk2dExVZ1B3UlBHdlRCb0RGWDBV?=
 =?utf-8?B?amtqWnNoaGRPNmUwV1BqY2tndms0YWZCbWZjYVF5Q3lpbG5ySjZQN2xpdU5J?=
 =?utf-8?B?K01ycU5ZaXBRdXhWMVVBQ0pPZnJZOHAxOVJRNDBKNmFnTUFuUkk0UU9vdVkz?=
 =?utf-8?B?NU42VlV0VlZydytuL0Ixcy9wMmpVM3BYZ2Z2d3F0SG9sTXJlYXZlTXVOeEZN?=
 =?utf-8?B?aUx2djBmZGQwbHNyanhURFl6a1VZcm1QcWxnWC8rV1QvaUltWDdhbGNEMHZF?=
 =?utf-8?B?Q1lqRVVpaVVvRTFHeUdCcHp6Ym9lUXlwT1ZpbmlaTDBNcWo0SmN2aGVpQzNm?=
 =?utf-8?B?a1A0MG4zMHVoZDZRMXF3NHd4eVFua25WNnlvaDUvR0dVUU1yeFIzZHcvTERZ?=
 =?utf-8?B?QXV6ZXBmZ0ZXcndIQytoaU9uOVBsd3FhVFZPNEQ5THZLS0Z1RzZ1UlFtVEJT?=
 =?utf-8?B?MXVVRnFMcE5wVThFOCtoQmZORURhc29mbyt3SUltbGtEbGJUYit3ekk4VEdI?=
 =?utf-8?B?NDZtTGtGYlNyV0h4clp3Y3Y2U2xoeUlVV3cyS3l1TG1pTzNrSHFucDZrelNj?=
 =?utf-8?B?LzB1SG5KZVA5OS9rYWN5ZWpab2xhYTV2bUFpV0FmMWtPNFhlaXN5U3F3NXhq?=
 =?utf-8?B?OW5SWklJVW83bnpSV0lmZGE0RW15ckdTTFhzMHhoeVB0NkxpVGpYTUhsSkgy?=
 =?utf-8?B?TDV5YStVcythdG5sbWNHcWFncGRnRmJ1Ymo0d3JZdmRvbi9YMTNTYmFXTkRo?=
 =?utf-8?B?MThSUmJDbjNYR3dkVFllNXFoTGxjRXdTQVVMVVIzZE5XR1J4QVlEWmZoQjdr?=
 =?utf-8?B?ZUFUSGxBRHBaMHR2WjRzb0VsYVg2Y1RkWHhnNk5IY1doKzM2WVJZK1BGRkho?=
 =?utf-8?B?REtLUUtWbG1LdXRXd2dkSlFpZ3VDc1VMRThYNUFzdjZIMVNmYlQrdmZ1cXEw?=
 =?utf-8?B?Q000ak1BKzlLSFNXZzFrVHBhKzFrSXIvSS80Ykc4ZXljZzFPdm5MTzFVRUhN?=
 =?utf-8?B?NnVXYU1aeWtPdTNNdWNzQktDeWRkVDF6UVBadjh5L2NHUTBEdUFPdForVTYz?=
 =?utf-8?B?SXpSV1FacjFjeHB2alJBRmVFR0N2cjBTcHc4bmNBbkFMWGk1T3NCdnNHcVpy?=
 =?utf-8?B?a2pnY3JNaFBhY1B1V2RaZmV6U3Ayb3pWa1lwcHhzbEVOWGxmd3dZZzA0dENJ?=
 =?utf-8?B?R0M2a3FiM3A0bjBMNnVrek5wVHpQczhRV2h2L2VZVzY1dlNJa0VwdVVoUDJS?=
 =?utf-8?B?dGRsUnVFVCtOMEZ0b1dWeUhiZXVZWUZseUVxeVowS01IV2xKa3I2L0xWTU9x?=
 =?utf-8?B?enpkQXB3R0JxdHpIOVhIRWk2dC9FcUJ3N1BDWEFEaVhCUFRmSC9yR1luUFV0?=
 =?utf-8?B?REhrTWd5SHIyUVg5dHNOWU5HYTBNSTI5L0RUVjhoelBoZGxNQlRETGNLVjd1?=
 =?utf-8?B?MlYreHY0SHQ4Qk1NdFVLTmwvaWp2SGpETEdPYUk1bmYyUFJJNEp3dWpVeGg1?=
 =?utf-8?B?MVg1MTRBMEtNY0dtMzZraEYyR2tXNy9IMEVlQXF5eGtVMWZaZkRUUHQvUjhu?=
 =?utf-8?B?anJjNVV5bUR3aERpaSsrbzY3WHEwdmhsVU9ZMVJQYnRZdGlPWko1R1NMcnh0?=
 =?utf-8?B?UHZHU2FlSnA4MnRSM2hFdXJOWWNXWisvMVFEMU1MaG8vUUNtdmlqT0xHdWZ0?=
 =?utf-8?Q?ktNghGMnWB5Dd6DHNZL0fePcaJ5ic7o0001jWufnTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2C04BFEA160E42B29DD910108314E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +kVck2TOH3XnXSHZmRSuGV8HJmYWpkHeUXPl2L1hwStrEJukEhYAqEyiCWMg1eEZ6r8XPpbUrTjYB2LXvmqsnH+bpiufuengeOEmyYjd8hGWGImvpu7LuURSIbw5zde5y8VNSai5IKJIDvEMlEvAe7AiZvOELmbLsxfMD0ysJsSygMMNnU6mUQeXIbnsXbB6RP7BG1deSoEPb0Kb/KYIObzkUZ6tJbgLw7XUHzzP0dFGcQkvCc0FD+HlqjrM1w2cEjvtrMwniwy7gDKV3ulsVh/zLKULw82rR3G3Vm+R4x0/jgveBcspVuLNh79SAwq371yRxgEyj0J0wxfrEwZNe2KqWE5vYudAX6VepBgTfXiLLnZ8Y8kluvCMBo4oxzze3urEiTw1N+Ahb+GV0y0p/DZeYbu2mCanLIi2qA2wdUo7wSAUsi5K8wP/wxFv98OAfbA4PuM0S5BWYKHdFBvmv5BNvJhWqv5DpUhh9a13XeGQNa3w16NUfFsmGBs2ivDOzKnrMeMII8mHdkJcIC4M0xLbj0XZrl6Y4x5ubq72gJSYuy2nTWziPdTmOHzBk95Ni9ECTrDMzBjzUb55yTDNiKVQ3UvC6RMHUfyTe3vlo01xCmblV2DhKHBcDzgG0sO8HVpeJ4FgBsM/TTaCZ021uGcCCCSGojlPwQdXMJmYovidf6sBEDhHP/mz1CK8ScYjpI31jUZINcm6Gxppt8kR8ZMJsiiH97+CyYxgokvubEHXcbMQ8/aKOFcibyvG9ZG2zKgriiKnsVxyKdJxOwFCaFBgeAXPOboPZ3oq7SUsYby9Uxxt+n7Xysc+4Vj9J7HY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3426573a-1fd3-4231-db79-08db0b5167f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:27:26.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUJEhzLktKjIzIDOTpFx63c0MI4Rd09UG+lvDwQUOgBsBxKe1RTB+MQ4sbgrrEaOu703fQaBe1GSIRFVZnrdXUcX0SSa6TtWKDzoY4k9taA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0541
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDIuMjMgMTg6NDcsIEZvcnphIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0gRnJvbTogRm9y
emEgPGZvcnphQHRub25saW5lLm5ldD4gLS0gU2VudDogMjAyMy0wMi0wOSAtIDE2OjEzIC0tLS0N
Cj4gDQo+Pg0KPj4NCj4+IC0tLS0gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hhbm5lcy5U
aHVtc2hpcm5Ad2RjLmNvbT4gLS0gU2VudDogMjAyMy0wMi0wOSAtIDExOjM2IC0tLS0NCj4+DQo+
Pj4gT24gMDkuMDIuMjMgMTE6MDIsIEZvcnphIHdyb3RlOg0KPj4+PiBJIGhhdmUgc2V0IHNldCAv
c3lzL2ZzL2J0cmZzLzx1dWlkPi9hbGxvY2F0aW9uL2RhdGEvYmdfcmVjbGFpbV90aHJlc2hvbGQg
dG8gNzUNCj4+Pj4NCj4+Pj4gSXQgc2VlbXMgdGhhdCB0aGUgY2FsY3VsYXRpb24gaXNuJ3QgY29y
cmVjdCBhcyBJIGNhbiBzZWUgY2h1bmtzIHdpdGggMzAwLTQwMCUgdXNhZ2UgaW4gZG1lc2csIHdo
aWNoIG9idmlvdXNseSBzZWVtcyB3cm9uZy4NCj4+Pj4NCj4+Pj4gVGhlIGZpbGVzeXN0ZW0gaXMg
YSByYWlkMTAgd2l0aCAxMCBkZXZpY2VzLg0KPj4+Pg0KPj4+PiBkbWVzZzoNCj4+Pj4gWzg2NTg2
My4wNjI1MDJdIEJUUkZTIGluZm8gKGRldmljZSBzZGkxKTogcmVjbGFpbWluZyBjaHVuayAzNTYw
NTUyNzA2ODY3MiB3aXRoIDM2OSUgdXNlZCAwJSB1bnVzYWJsZQ0KPj4+PiBbODY1ODYzLjA2MjU1
Ml0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkaTEpOiByZWxvY2F0aW5nIGJsb2NrIGdyb3VwIDM1NjA1
NTI3MDY4NjcyIGZsYWdzIGRhdGF8cmFpZDEwDQo+Pj4+IFs4NjU4OTIuNzQ5MjA0XSBCVFJGUyBp
bmZvIChkZXZpY2Ugc2RpMSk6IGZvdW5kIDU3MjkgZXh0ZW50cywgc3RhZ2U6IG1vdmUgZGF0YSBl
eHRlbnRzDQo+Pj4+IFs4NjYyMTcuNTg4NDIyXSBCVFJGUyBpbmZvIChkZXZpY2Ugc2RpMSk6IGZv
dW5kIDU3MjEgZXh0ZW50cywgc3RhZ2U6IHVwZGF0ZSBkYXRhIHBvaW50ZXJzDQo+Pj4+DQo+Pj4+
IEkgaGF2ZSB0ZXN0ZWQgd2l0aCBrZXJuZWxzIDYuMS42IGFuZCA2LjEuOA0KPj4+Pg0KPj4+DQo+
Pj4gT29vcHMgdGhpcyBpbmRlZWQgaXMgbm90IHdoYXQgaXQgc2hvdWxkIGJlLg0KPj4+DQo+Pj4g
Q2FuIHlvdSByZS10ZXN0IHdpdGggdGhlICdidHJmc19yZWNsYWltX2Jsb2NrX2dyb3VwJyB0cmFj
ZXBvaW50IGVuYWJsZWQsDQo+Pj4gc28gSSBjYW4gc2VlIHRoZSByYXcgdmFsdWVzIG9mIHRoZSBi
bG9jayBncm91cCdzIGxlbmd0aCBhbmQgdXNlZD8NCj4+DQo+PiBJIGRvbnQgaGF2ZSB0aGlzIG9w
dGlvbiBpbiBzeXNmcy4gRG8gSSBuZWVkIHRvIGVuYWJsZSBzb21lIGFkZGl0aW9uYWwgc2V0dGlu
Z3MgaW4gdGhlIGtlcm5lbCBmb3IgdGhpcz8NCj4+DQo+PiBDdXJyZW50IGtlcm5lbCBoYXMgdGhl
IGZvbGxvd2luZyBjb25maWc6DQo+Pg0KPj4gIyBncmVwIC1pIGJ0cmZzIC5jb25maWcNCj4+IENP
TkZJR19CVFJGU19GUz15DQo+PiBDT05GSUdfQlRSRlNfRlNfUE9TSVhfQUNMPXkNCj4+ICMgQ09O
RklHX0JUUkZTX0ZTX0NIRUNLX0lOVEVHUklUWSBpcyBub3Qgc2V0DQo+PiAjIENPTkZJR19CVFJG
U19GU19SVU5fU0FOSVRZX1RFU1RTIGlzIG5vdCBzZXQNCj4+ICMgQ09ORklHX0JUUkZTX0RFQlVH
IGlzIG5vdCBzZXQNCj4+ICMgQ09ORklHX0JUUkZTX0FTU0VSVCBpcyBub3Qgc2V0DQo+PiAjIENP
TkZJR19CVFJGU19GU19SRUZfVkVSSUZZIGlzIG5vdCBzZXQNCj4+DQo+Pg0KPiANCj4gSSBjb21w
aWxlZCBrZXJuZWwgd2l0aCBkZWJ1ZyBlbmFibGVkLg0KPiANCj4gSXMgaXQgZW5vdWdoIHRvIGRv
IGBlY2hvIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL2V2ZW50cy9idHJmcy9idHJmc19y
ZWNsYWltX2Jsb2NrX2dyb3VwL2VuYWJsZWAsIG9yIGRvIGkgbmVlZCB0byBzZXQgdGhlIGB0cmln
Z2VyYCB0byBzb21lIHZhbHVlIHRvbz8NCj4gDQoNClNob3VsZCBiZToNCmVjaG8gMSA+IC9zeXMv
a2VybmVsL2RlYnVnL3RyYWNpbmcvZXZlbnRzL2J0cmZzL2J0cmZzX3JlY2xhaW1fYmxvY2tfZ3Jv
dXAvZW5hYmxlDQplY2hvIDEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3RyYWNpbmdfb24N
Cg0Kc29tZWhvdyB0cmlnZ2VyIHJlY2xhaW0gDQoNCmFuZCB0aGVuIA0KDQpjYXQgc3lzL2tlcm5l
bC9kZWJ1Zy90cmFjaW5nL3RyYWNlDQoNClRoYW5rcywNCglKb2hhbm5lcw0K
