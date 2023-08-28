Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5A78AE71
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjH1LGc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjH1LGI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:06:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9818D
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220764; x=1724756764;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=CbQ4ASxtXcyMLYKWZCk/cAcUa3YBH2PIN1asS8+n/fO6GCSstP8u6fvy
   4inY9sQ6mcafbetddJZHc59pCYNzMX2pYXJTPaaGMV1hiF9gn3++J2L0G
   r95eyZrsUWattQJ5iyIOoAbM+3Q0MZ+k/gEJG/x3YNTa7sDvTyx05RM26
   W1Cb945Ug9GOGQsQHhtrMhByperzWLNTpLBCMIuYR3MI5Qdd7GdLJ4fQi
   4PwGDcRGWey0lHKnaH8++Z8agow579xO2GIxVf6kX4E9HsyxLs02w62xT
   N89PnnusooiFML7XIV9uL2Zs0J1+YD00DzCK+vuJ2wfFokovGPrhNjKyU
   w==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="242248750"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:06:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmo78+zBdpC/rdznuX9b2wePA6O5WODsFoTFBn5hpjT6xVP1cSSIeeiUJGEK3+ylNUKkA4C6lzU5GE2b5oVB6SgKJgcr9zX+x3ewi4GFjel46kzmjb861xDutf+LtPlEAKuW9CXaQongVEJO8DVemSWgIdYPL/f7HqQTlBfMTHMQ6eACkQyadIX74TNhJ0/PO2ti+r/Ll/hDYEJyGOtrls2OEozvzrMs6JSKdpOORHuo1Tx00FPZo51W0r5brHat51Td85LR+/9GOLnEYvSy/jjrQsYCeCN6W6uEPUgThL3G+vMoajl+m60XzRwCLlKGMLYp6sqXIUcMCB4fd829Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=hr+LbYOSLEkOnHnSOQo/qi5GonzxPPFNaTLBG9zqsoBdkuuf8Cwd9dUrxXpLnqjKKLMEhIjGxK0jEsDqYiZhF2IA62o6/0T8v1haIDhaw+F3s/aRcPRdM55H0WCMFM26gWLIqxmRV8Ed2GgJhGB87kdkSc6YO8QOz8U++6qCtWmakTHPfFRzUKEUjK1RLpBXN3Wlre6saBDj5gcrag1+NLJb0jcqePsqyQLC6yW7LVti2drgIH2OWCMX199m73kr73mkN5THyvEQ2JOD+q6Z8iK8AoZxIY9kl5gNw+ynt4J5rq9i8jtmgJIIx2mRvoVC1y3LInAX2g2sRIR+H5Atgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=RRZ3aiL3WJNiJouXxIQ5EeAatdMsVObrRrRQDHt3kL9NV6K/vMxG6G33K7W62hJAQ7hl++yDTWWEqId8s4OX7GH/MvXXRa5yLJKyxpDK0di9FJ03lzVjewwyEPB+B4tP5JIAY4Fgb+9q7uaDdCvOqqjpvUPqZ0HEq4vnEeQjlHA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 11:06:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:06:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/11] btrfs: add fscrypt related dependencies to
 respective headers
Thread-Topic: [PATCH 08/11] btrfs: add fscrypt related dependencies to
 respective headers
Thread-Index: AQHZ1ckCltP6OjtbGEaZ/dJoU2eSaK//k7CA
Date:   Mon, 28 Aug 2023 11:06:01 +0000
Message-ID: <9855358d-9631-496a-94bd-c7778030cf2e@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <51e817ceddd3f694740c7fcc6f9dbe7f2d720fbe.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <51e817ceddd3f694740c7fcc6f9dbe7f2d720fbe.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 0194c918-04ac-41e8-8337-08dba7b6c3f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLwZIWwyWmqb0YY11MFN8rPrTe7veZpnB3Hq1gy842KyF0cpNk7PJRX0PteagmeCIpoZxuM7HIJ7SdwsJpQfaekYE4Ql1Eh4zZFv+3LIMDm2gF2v/eZbi0aH4PYsVZIkgsj9c58qp/XNB3SrljLsyY32Kcu18X5ZKP0XLD/FL2h9FM/9HpkTCKaWvdFsbhyz2Qvl8bQcOu3UAW45/AmW+TC+4fdZfGFpovRIRFiJGOZnqt/Vqm4FRRtk1eQGJSkENAckPLdrkWBCiUSs0vNSHzQNVrMZzqt4XR1do5LVBb+2fcBxxmSa9+9Pk6XM+KKz5n3YZdikuT1db+lfuSqc+s/hlC5WSxhlUKv9rPxU+v95PV06OO1bNlSpBEmOT0RnSDdJlX1FlLQyrkSsWshJ8SOSROR/l+3YvVryuw0r+i3YQyI020Kp7cAI0h4g4N9vO4LBl2vvVzJxxnkHlYMKbqL1jHzEWhaJor9HwwjzEMUcooopAxPrwnJFGMybgSqHS0SSEXHxonkcCH94wS8v4eOD4RTl2BS0fgkddeoWM8zMPLaP3inmAztW6XihUfSpFM1TdBE9VYoVThYH8ICxlCaRudcqVbENK5rFLfORq174PE9ND2s2PU5DEt75765plgkThhDf/zyhZwBZybtLOOZVZms39vPjMYdAjVpP9IfBjPD5jHQH639DEidmrRMn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(5660300002)(31686004)(41300700001)(26005)(6486002)(6506007)(2616005)(6512007)(4270600006)(38070700005)(122000001)(38100700002)(82960400001)(478600001)(19618925003)(71200400001)(558084003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFhRdmdLamxMNkpoUm85c09HK2xOcnc1RWIvN1lPTWNFbXlIUUh4RzNQYjMv?=
 =?utf-8?B?SElkY2R4UG03OFE1djQ2T3d6anVIVEtGbG1CZnF3K0lnU1QyOEd0eWRZdjhR?=
 =?utf-8?B?VDNFdWxydmMwdEJJekl4bCtWcFdNbDJPYkE5L1ArL0N5TEg2aXRnUklMaWh6?=
 =?utf-8?B?TjVjZUhsdUY5Qm1UYWtVME1FNjVUa0F6U1lyYlhFR2hRYWhXZmJhTE5tVTV3?=
 =?utf-8?B?dDFuVElHVHFYQTVVcVVsbkhmQktoZzljckMxZjludDdyNG0vcmN1QWtMQzhz?=
 =?utf-8?B?SFhoam5oSGVidzhCNVlGSVVxcG9YenFJbERZVUZ2bmQwQkllOUE4WVV2Nmpq?=
 =?utf-8?B?NWZrOFd2T0d2NDlrVlJNYUU2OEpvY1RGeUlHb0REMHY1UXRSZHY3SjBKMnBt?=
 =?utf-8?B?cG1aSkswTjY3QWp2UzhEMG1PQlJpWEdsYUE4RHlWYjI3L0JPNitqZjlvK3A2?=
 =?utf-8?B?dWhKZUtOOE1aVUNlWVIrcjhJbjJhb1ZsNktJWnBna3RXdUNoQkxpNWtnbXNy?=
 =?utf-8?B?Q1IxbzR5UDNKYmlHNmpGUnpCNjdvb3BUVTZuZ0RUTmc0RVNVUnZ2WXVJdEpO?=
 =?utf-8?B?dzlzM29KOUpUQ21EOG00MlF3dlFqQ2J3UjFnSjE5WDdHK1plWnJkd0pZenB3?=
 =?utf-8?B?Q0djT3Q4MVFVTzI4Z2tlcmQ3Yk9LZXJqWU1XYWhRSENjK3l6dVVDSzFnVk1m?=
 =?utf-8?B?bHU5TGJBTGh3Vjl4TDRKRXN0Rk1jMHlPQ3VEZlk0VVpOVXJqU1pKbXFHRWM4?=
 =?utf-8?B?aHhiMXdKWW1LZWhPU29rNnNpMFlTbmRGSHc0MnlEVVNVeXY3RTBaempuTGho?=
 =?utf-8?B?VzlxN1o4YlFEakVmSkxWZ2hsYUVoZjJ6MVdQWUZVN0VhdlFOOHVoanhsd254?=
 =?utf-8?B?ZmFtUEVUUEdPR0pRbDl2MXNERktFdjZZUk1KY1Z6Z3ZWRGFuWVJUZDlCczhS?=
 =?utf-8?B?U3FPUkxBYnppM1Y5bzYraElVdXhnK0xTY2tiT3c4cU02MWZRbStVMUk5YTMv?=
 =?utf-8?B?L1AzaUhQTVNiSkh6SW1TSS9EYTd0M2NPY09ncFNNUUZ5SmpOU2hFOEhCdDB6?=
 =?utf-8?B?VncwY25Da3ZZM0xYeW56cjJwc21FNVVZa0pqMXIvU01aUVlhVTdEcWplK3U3?=
 =?utf-8?B?SlVVcTQxb09BdnN5UGYydGJEZnFqSkhkaS9Nak1DaU5rSklpZEEvN2F6dGkz?=
 =?utf-8?B?SVhmODZmblNocDdWRjBjZzVYc2ZOSGQvK285RzNlQ05sV3RUSURiRVhlN00v?=
 =?utf-8?B?SWpoanN3d0krZit6czFUcjVSOFFWQUtndjhYNmpaUGc4OURvUGtGMjhjd2Vq?=
 =?utf-8?B?Wm90YzNmcnhob09oRFpOaWJ4cGZkTDZhamhxSVJWeDY4cXcxR01pdGxZUmRj?=
 =?utf-8?B?K1UrREtwSDBKU1FlSjF2OW8zUmJDckVvM2wvVkdCWjFqQWtnakJhVkZ2aHE5?=
 =?utf-8?B?eTM1blNTd0lsZDJqRElZQVRIQUVoR3Z1K1FmQjVBVXlrSWJBMktUd3FSZ1pH?=
 =?utf-8?B?Z1FjTWRlc0RVczhQSVBNVS9aOGt2aHZ4alNQMTJ6eGNzenovODlTMnV1TmQx?=
 =?utf-8?B?VW0zenlnMFozR0NuNU9HOFVvaFpvT3cwWFp4NEhWbGczdE9ZRE82WCtSN3dH?=
 =?utf-8?B?S0xuSEVEbHB1L0VuZ0VQOGgzYkpMM0dUa0gvdlQwWW1nWEhxRytZd2YrUzZI?=
 =?utf-8?B?UDBpWjlhTHUvdllvT0txcUhNaGUxNjMrTzFSVW1TbGVYeXRuMjl4RUQwYkJq?=
 =?utf-8?B?QlExUDBrcWN0OUlReHFpY3dTc2E3S2RCWkNJUHlqUEVKcU1aV3NzNjBZVFl0?=
 =?utf-8?B?NVU2Tm1ab1M1MVc2SmJoaHFlU1h1QjlQbW1kditIb2RTcFJ0MXdBVndKb3RM?=
 =?utf-8?B?MWtqSHlkd3lHRG5vMXlwUXB3NVBiK0k5WVJBY0RwZVc1ODlUZFRlV21FZGxF?=
 =?utf-8?B?UjczR3FJd25wRFUwN2szWm5pc1RKLzZBRzNYRU9IVkp1aHlLc0pwWnkxOTM4?=
 =?utf-8?B?ZlFJMUFyY01ieExqRUhiOWxHTDBITExqSFJYVHhGQ1drV21PTVU2Wll1bkZO?=
 =?utf-8?B?MFdmQWYvUVFSRExsZFlJTVpyaHB5bmY5bEU3SjF3ZXErc1E3WGpDaXlsK2lK?=
 =?utf-8?B?RlBRZWZxbjY1OUR5ODV3d01FSlBDWFVmM1hINEswK0JtNlI0U0lCTFQzTFE4?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37D5C3D05F00964CB17C41C332A121AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9WqUQeygHEItrWHHOO6gJrOw4h5n7Nhk9rjnOFfjx9ja+2ZKPVYubawHCyK7hPP6SIoidHgZQfCXzwZIOyp7V9Sun2PxmPYZoFNOw8nl5aQrV3Y+xWwrzrkEyKV2s58rY0SASYu0iCbDQ27GtA4tAMvVgIwVZ4SWj/XCYCKaobJJGGysqpkbihtkYFwA+dwODuVIE2d0ilDWLA5wAGDbO+RxZX4pCqmk3veV37g3EgfrzaBjIwxQvaPjil1q4QpbfXZYJeqfbHq7dOXDBDGln81HDCSvpDMztzNQGzBBGSSNTV0VvvYQwQ6IXdXS7CUxjIezBStXLLoPpAzlqulAhKsWzCjvWo19Qlv8I+uIBD480gViL7x3CgyVj1VoJF/pgbYGVza/uDaaTbupb9cckfbVFZHwWuE0BpAAUutsthHll9qb5y1DCsA7+TV2nH9C3B57R1/YqV1nykP/2BsYfr0hibIlsP/3RBi+Sa3YDXjZgV2wB9bCPCZf5C+Ap3yDNNRPGq0u+bM5kmARpXM1zZCouiKI2BrKtLXdd76gKnmzNNUcFubT+1djs8bFpumLQ2I0fv/SB6HuFG1wihi6tB81wbAZMd0SXyCCNz0n/w8JxVRmm478M9WIepFeHXp4Au98P8mHLx0S6JgtlCrpM6RXIBnJSzRchq6rTFGjxaBEuUNF6ZY8qVnNh+JzxcsyeU7FdJaU0Aw3PDbWkwET/pEI3uFvyr5NRX0EQN9XRng8dF7H1jKEDE+AAJNkUHdzUYQhegeuj+dpnUID/dIkiXb9RjEL3/a8h4UAXbuQf47prwIiAAul4rSQ2HwFXqdvGzRj+Ci4ksDZVX0vDT6czg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0194c918-04ac-41e8-8337-08dba7b6c3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:06:01.6242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ps/vA3GJadaStsL44EBKZoORwWEwwUewTs5bRfDizKY8ANlkSrmLML6VN048IAdio/aCk9rHlnJ18qFadu7RZQ3JlwmrsntPHRNY1b+82c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
