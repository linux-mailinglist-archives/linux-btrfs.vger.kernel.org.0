Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC9C60F10E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 09:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiJ0HRV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiJ0HRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 03:17:17 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A8F6C07
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666855036; x=1698391036;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=qnqlawiPKsUy6SEhdlRb8q7YaA/Wu7fyi8uzqCAoHjdC+eMEmCyavzNW
   jFvQyXQEBo3d4U6CBIJQH4re3Nw2NEzOOveGpnb26L5mMYSjjvmjqZ6VK
   QVarAEp9Y6VORnQD6CfRzPJK06oc2Q0JWCO6AzEXo6+y9+WoYTXEFH6tN
   yiDWfvFf1ife67AhLqDTZla2hJBiLBpnWD784yTdQSmFAKDvIxIEFHIAE
   +3a5YRCMHX+nJges5fH59yTh39i843L1VGEtIfNIvcNe+lLRVcRaT+Kv1
   PcjXI0DE+bxKpdtWDUnuTinBctWwMhD7RQNXAEYB1ruQtObIaQtHm5+M2
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="215213187"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:17:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfj5AAB1Woe8juWvhT/7ixUm5mVFuVJxlLNCxDuZ5fsGzP7XxqFj8zUjYWQMfESEWBrC9Ha5cRID2JX6zV/vArnLK1Evz4BpjyAdpgDzjP98gGdQZcoUBAP1djRYfg7DybKcILNCCB/6xcE2uEIMWKyrDb3AddZYY7uSKLpG1h/A+4fS7XCYwaRIVWZsHJBBxsQsl3y+bp1sejjHgfzK4KtpsxnCKhbH3+pwG/YX5ZfFmZIJ2cDVu2M5zlDb3VTWlCqndyB1iq/6K9csOh79WqAGXxKqgoxjTn1bjzgHAYXg2nqUtLizRCW7zitF0nf+PcEQz5BSzai0i2q28CnK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=C8y/OE5gvi5wwxgwXrpSDgy/G4/zXnFBU5QRV6jMXcXeFtgHw+S3StkB6q7DuopsDzme355ndp7ZGv5SlkFSWmMw0WJMN46QFw8yHrbaVCsCygiYkD327QOPfG85qVEyvRov8nGMQFiwEXUm740yqWMnt64JdE68xinsW7rq2UiGfnmx4xScdnyMXBcO79MNKuNVS4aO7U+lntsdUlDeA3t3gbd16EA6yE3DVFb74bMDmeLpGdQJ6eZtvs/RWjaSqszQvdcGHAuYZPROVrNzexOZ4fL4VTZx1oazwap7FHx8ktZb3jcr+YDmXOgKTF7YlxqumyeOQbqrqQ+br+qQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=U171ouhfEdLsNKzEpUABXjyRjNMwUF5JkomXGTWcGiRNY1tzpMSJYkLxAc0LLlrPD4MH4ms8DCZ4ABK/oxKtuPoFYcYLN3FS6+D6sZCQV39WRD6wk9tlwKhwVMwsJzA6wFEh+aymZ0r8KlF24qJQsME0KqDgFr7ijO9+tw0ZSck=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 07:17:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 07:17:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/26] btrfs: move defrag related prototypes to their own
 header
Thread-Topic: [PATCH 10/26] btrfs: move defrag related prototypes to their own
 header
Thread-Index: AQHY6W7TYrZDGNERuUGB2V8oow8BnK4h1WWA
Date:   Thu, 27 Oct 2022 07:17:12 +0000
Message-ID: <870c96b2-5307-960a-7975-16fc3aa1aa90@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <c190b1a94b741f0e8c8bfb9253932f24da006a67.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <c190b1a94b741f0e8c8bfb9253932f24da006a67.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB1048:EE_
x-ms-office365-filtering-correlation-id: 018f4903-061f-499d-e912-08dab7eb447e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Rv1bNd/+jA5Fbm/PsbWqIeOV4/KlbJzjSjCtTyHsoYcuzkwD9Dxw8Fa7sdNSWMKYo5/G2LBCKa5pHhC850Ao4iWJ71BCV8/aJu2XtU49CTY/cwcZHCU3Au2O905enP/KJeLMoKHE/oytW3Ui5CeldBOfoGwl8WAY7DTVlEzaWQUt2tY+O5qN829Ob/iiNaxwVDL27OetGWdpMXD9QKgKLCwesbVPLn8W2aHVzLHxEdMdIUP5LrLYk7JQDvmu0WTz7qUTlr19dyuB/csCJmV9T7VkBt/zOvGllpf2H8retqv+T5+5yo4y+i9w4JTZeBWcG6h1pjiCZHADIjU9gX//InjDOPGrU0acmkMF1lyHB1+FmeZMa7p6aX5puO0IVyQ8pefwLh8PupHN0vUXig/J2bo6tJ2KJxm9Sc2nd6hm7mxqptXOPk1XpN0nI7SEqtDSNUk2krcqWUc1KWuHQVmoREA//eoKblRXJfwN94zsFxlEI09XUPZ+k+UqKb7fqOg6rTuQyFIqew/9TTNN/1hOmy44tjNcGft5EMaBySc+eGeiEoTxgN4FH+OYbxGqVlDCHDHclqHRq1ynExLPH1r3kAXfThAe9X8/tPs9Y9RBP8Ujf8dDNZI6tlmy15MkHMTWAUoIRrZrCLQTPj/Uesp6xgVpR9G3bkoQM/hcFrMPj4x8aMRYKP0wmi8bj/gNnpxwJ4uJjifcrwxqViIVssUo9rOyLTNqJk9IqKUtPhMVWZeN9YNXq7wYTwVPfi7wPp/+kK9yT74P8DHOyuqL8Boryj7vFjSfJwudXWxcvzuwisEKs25RrLJdyLhubt2cvQEQqZ+ltf0SXwz2pJFICafOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(66476007)(82960400001)(6506007)(2906002)(31686004)(26005)(6512007)(8936002)(5660300002)(4270600006)(36756003)(8676002)(91956017)(38100700002)(122000001)(64756008)(66946007)(66556008)(66446008)(2616005)(76116006)(558084003)(41300700001)(186003)(38070700005)(478600001)(19618925003)(316002)(71200400001)(6486002)(31696002)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkpUYjN5dFBONm5lUWZPdnhETUVwMmNOZCsraW5vcDRhOEZTVncvZDFnZm5s?=
 =?utf-8?B?bGxnaU5NcHNieEhxOWFiUzB0R2pXMjJUOGZtdXlaL1JyOElqcnpxT2wyRFB0?=
 =?utf-8?B?SHZpYVpHQ3BaVHFsamo0QW9FL3hCRGlIbXNmNmpLSmNJTEdqaGlpNVhVODVw?=
 =?utf-8?B?K3loQ0Era3R1RDFwRFNEUGcxUnJmS3grL2hvY0I0aVlXaWxJa3dFdk12SDFm?=
 =?utf-8?B?Y3Q4ZElDQ1N0K0pzdHVlNWNCeEZVeWtueWtxVzBMd1lPTzUvTFlkQi80amV6?=
 =?utf-8?B?cGtMRXVKbGllczVqZG04dm9OcDc3VitkeW5RT1BNejFjYUNGekd2Q3ZzRzND?=
 =?utf-8?B?RTF2M21WQ3ZaZ1kvaHorbXFyZzk3TkdMTC9VV3pEbnlTeTN6aG9tNWhJeEhS?=
 =?utf-8?B?MnRvYnJ1dm83VWlzUVMyT0FFRUpLMFg4a0Fjb04rOWtjMjVDOThNajhMSlV0?=
 =?utf-8?B?NXo2T2ZaTHEraGg5a2pCMHVqdXlDZUhGcEV6cUtteU5rSzdmb1pkZ0JqOHQ2?=
 =?utf-8?B?UU1NcU1KcmJ1em5oa0VHVy9vUHk4WG96ajRwcENNS1Z5T2RMVmpZNEVITEVu?=
 =?utf-8?B?bFd3Zmk5K2hjZUMrZGwxdmFIRHNuRjBxZFF6a3VLRXZHNTdKZ0R5SnBZeGww?=
 =?utf-8?B?STVGOFllMFFWbkZFZmJrN1pEQ3BQZlBjOTNkZ3NOcVFKQzFFYzU5Z2RTby83?=
 =?utf-8?B?MlJrcnJPWHJxZ1JRQkp3STd3bGRsUFF6RzlHOWtnL0I0bldGSk50SkcvbXVH?=
 =?utf-8?B?ZFQyU1Bvc1IwOE1pVExOeXV6dGdiUG9wQVJUTHBMUzNuS01oNElUWXJ3ZU41?=
 =?utf-8?B?UVducFZrMGR4VkxYNkFhK0N1Nk1yM1R4L3N1NFhuLzdQN1RQbzE3ZzR5aGth?=
 =?utf-8?B?QzZLQXEvT2pzRERTTlozUlBaZmZUMkJhYnFBVFdxanlhSERRS2UwcnNXekFp?=
 =?utf-8?B?NFlFSisvQ2RFQWpOSkUwMkRxYmxCY1d4UWQwamJ0RkxFaVM4aXlZRjVPL09l?=
 =?utf-8?B?RmdHYVZTUUNFUFk3cXN1RVloN1FFY241bnlIS3NDNHQ3ekh0dnVDUVpveE14?=
 =?utf-8?B?bjAxaE1WOXVVM1JudTl6Z3RidS9CUHpHekdSMWRoU2dCNWgyYjJJcUp1ZjM3?=
 =?utf-8?B?Yis5cTFwZlU1UitpVTg4TGFjWExWd01IRzVUdERlN0ljT3NIdEVMelFSN3My?=
 =?utf-8?B?a0g4OUNwMWUzZzRJSHIwaHBqWjhDbWIxcUlOdU82QTJrZ2JCczZ6MFFlMXFm?=
 =?utf-8?B?VHZKMmtzYzBZejBkcjdnTWYyalhBNWdDTHVXeW1HM0RVWmd4cENrYk43RE5u?=
 =?utf-8?B?a0toOGxEVjNHcGorVTk4TUdlK1FIbzNkM0tOSjhaTS9LWURKRXE2MWhMRWRO?=
 =?utf-8?B?Mi9KK0NwNzFsem9MVEdvNU1BcUV2eG9GVnNGdkQySDVtem8wNmFpTXRwUnNx?=
 =?utf-8?B?OWdPeFdLUXVGMVZZbk1uRitvRTNKK1Q4bFVEcFRiMHhHN0RFMHQ5MThEMWZx?=
 =?utf-8?B?bERsaTlCUlVueWRRYkRGQU1zSC9GSGdYY1lyM3VRNGVicGdSRFJlZC9ZbWhL?=
 =?utf-8?B?Z0VjWlQ1Y2NqVTNHK0R3bWgxTk9WNkNLMzdaancyZjdFMlNXdGRLeHhUODQ1?=
 =?utf-8?B?L2xaRlgyUDB4eUVtdzhtMVUyTDVTaDNuNFNnWnBjVFJOWEpYZ3VZMks5eFJx?=
 =?utf-8?B?K1ZsT2s5UDAzcTBSV0pJR1phUTl6aTBNV3dydEJCRkxGMU1QTExGaDZuMVhh?=
 =?utf-8?B?alBRa0JTRWpVb1dDekpBL3ZwbEZCZkdwaDJ0WWdsSWJJY0RyLzhoNENob0wx?=
 =?utf-8?B?U2EwaTE3dWNoazNYNEtleWdNMnN3QWZacUxCTnRMWmhxNmpnSDlKZEJhY0xH?=
 =?utf-8?B?T0prdUcvd2xkYmN5UllQc1REcjQ3NTVuelVpWk1TSFAzV25uR2FpamZVZVZD?=
 =?utf-8?B?Mms4RlAyRGxmMHBmVTFzcDhHTzVXMDB2N3Vzd1dLQm1ZRTdPNGNqbVJENWk1?=
 =?utf-8?B?ZjQ2bmQ5RC9DT3NkT09yY3hMZlN4SzE4OHpaT0ttQ3FyVVdhVnNRRVB2WlBW?=
 =?utf-8?B?RDI5S1h0NHlTa2pFblhVUkNzc3VaWmlQUm8yTWM4NExXUm1lVTF3WWxHMjAx?=
 =?utf-8?B?RHRqZ1RqbThEVGZYQVhOOWdCVkxQRFBkMDgyWlBtMHFWR2NCYWc1TEYyTm1F?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <192D1A185B508642815ADD18C1194C3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018f4903-061f-499d-e912-08dab7eb447e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:17:12.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dl/eljAwWuFl7tH5A7yPaKsmmTCLdmAKQbgH0F6yUyDTQX5BX10Oicabu+N/Y9JD02rm9OopK8XO6EH1H1LzC3kZ5KTUwAtes5heIqXO89Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1048
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
