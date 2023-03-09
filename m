Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B46B2390
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 13:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCIMAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 07:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjCIL7r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 06:59:47 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7CD90E0
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 03:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678363185; x=1709899185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=JRHleIUopLFSmSleNNXO3hmBOivAFE8VLZjWQkbUzl8AYoi7iluWuFfP
   /vsP8Qf1OCxrqI4ZiVG5Ru1pDlO6j8oEG8o0CntGOqrOgHKOioVDCzDdA
   LsDcXQg1/ifQJ1uYdQjfVLoQRlk3Icrt8z+lKgGTelIFjLJ8PeagO/d04
   wVUasbd3ljAqJqgbD9+8e9hwbqtuXMNh1RUP23fvS0/1vRTITQGNuq1VK
   NuWMjSrEHJnca9xmnLix9CmSAj96ir5cXhTQvl9Hy3QdSRdfQZ47jkzaf
   UwN8rNgYJ6kMNHdWNeAk2iPg6eiWljyMA9RiTRqaBtsSs7RWK02NJb0U2
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="230173263"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 19:59:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTnSOQ/GOGhKmh+U8SKuXZzrtNjErRPi0tPpZjZtfqArGDQzE+KQ0uG0XBPe0NwFIIj90DrS2xgxRPaKa8PXFufIh0sTmhAbXY6Q8ALMSR4Z/SJaAM0I9B7eO+Bx+ts4+9a9D/Ov7au0fa61CDnM5B2fc/YzqQ8zYO4KnYJSc32ffWXZHPAc41ynlCg3q5Ki2ufjB1fvcYkQ2NZ7qS1IEvb7iuK3mYTlWCHfSJ2GNjkGfcsmAESNrHWZ0Fr6ta4qfRqgWF9RUzj8ZbZ3xVTHiiTnC0tChT6xRK6C/6qH+mEUJ4Qgcd8++kfWmVcUFSMdrvXbVueZqw2DpXj8Y4s14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=c8LOxeShB8QygosVhTrPHSxfKw6uLHWObx5ORITgtUda12BBzksOPHSFGuKvzHH4ZnyJMAhE881VvDqKnbt+NaeeIYTThqccdAfTqJ+F9K67nc4MV6HA8Q8D+KZSHmA2g01Sh9adYr5kBCHUXxC9JHjkvP0OuRXczNoS0uVIFvzSmkwzP3Rtyv1To5EXlFHxyHRJD3YuRAFyTkiywx3qzRdnpQrsxMZ5KW4jhnjSiWm+1jrvRx/rtDEfLuarC1DSCFG94y52Jslsfmxhm3Xc4fHg11STNNmp3a+eudnaL99emcRuhdU5+yKc3RGLpIS0nUN7TdCovd//yAAfZlR7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QB174K3ZD9KghreybRxkuRbJEAiGh8xQCGsj7h1XSFaNUIHfT4gMvvKDPvsuey5xSwBEtXYxY84FVFe+3T6w5dK2XuSYulgWiTRqkc6gQvcfzsKpaqU6NqMaUdy9Rv2YQjCJwo43DK82w/WWwDUd1wZSjnaWW+jIRB+mQ2cS92E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7505.namprd04.prod.outlook.com (2603:10b6:303:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 11:59:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:59:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Thread-Topic: [PATCH 05/20] btrfs: simplify extent buffer reading
Thread-Index: AQHZUmaKAgK2nJmtNEiJkv51ahgTP67yWFuA
Date:   Thu, 9 Mar 2023 11:59:20 +0000
Message-ID: <22a604b0-d160-4bfb-06d4-9e7c3289ca4f@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-6-hch@lst.de>
In-Reply-To: <20230309090526.332550-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7505:EE_
x-ms-office365-filtering-correlation-id: 185de76b-401d-405a-a40e-08db2095b790
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: phorBt9QXHecmro8TypxQpsjt2IAYVhT2OdWedzdupmBygvItaawaPBxGncqUqKVLuBD4QUlCszHDYWj2xjSS/sMRhNeJylJMkyK0mLftRpDSBgcAa/BnA1ENb6T/cw0qUbDGghJujAsIFMzf6Bl7tIv0eCaB2S+iIwKJDswWRNVOxvGN+YLX2qF1Zq89S4ZsIN+rgQlCDXdB9CEikb4oe1qNnC33KRg/xkBJqtAFdO1M0pU16NjWJOyOHcHH1TIp/tQv7FFH9xMarYHEbhYfPFzxnlGcC90ocUMFtERwCavDF1fgE2khkolqOX7MeSxsXzUNiSuSlX1dQ8nTHyZgcIEqneWIy1NggmuTYs7E/0Ta8UkihnWMk/thQD9AGbdMJjEJm6XfW9OA+ES7itMDqGJIgQebPLc+drTl5vL/8ZKfNLnNpK95jaoJscCweaEbxPIjRU9iyH+ywFftUTsXWrC+toEEJ+RbzlQ50TZqR/8derLTRPME4lbk3eqohmW6m7Xgu1VVsh0VxlPnxIk+13QH2ydVRqGi7my+tqnNJBvN8s76tbVWDMQGMsqg0Z9Tf4JQG+fgwF60aGd61MNp4EdabNIPD+V2BpNxCXbjIIK3KlHp6AskPRIVfMEH31Tu/ZvOWaAppJe0u70yzgQJAbMRT2A2ujKdwc3Xri0SxsUqSvDoBPs7qOoai3c+TQPFvdBc/RQJi+jradrmR1aaWJ1tA4PscwqsIqo310+ojmpONvHitJExSc8YMzev9MbkI2jiCG0qUgxravlMCc7vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199018)(31686004)(110136005)(36756003)(558084003)(38070700005)(31696002)(38100700002)(86362001)(82960400001)(122000001)(6512007)(6506007)(26005)(4270600006)(186003)(2616005)(4326008)(316002)(5660300002)(71200400001)(478600001)(6486002)(41300700001)(19618925003)(2906002)(8936002)(66556008)(64756008)(8676002)(66446008)(76116006)(66946007)(66476007)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVRGQTJabnByeGJuRWFNUW0wN2M1ZUY1cmVYTGt5b2l5dktXMytNeFA1OHZ5?=
 =?utf-8?B?NDY0cXpRZnk2RXk1bmJyYzV3bFhnRkZOSTJENkJjOFAvVmhZelhEdmlMdURn?=
 =?utf-8?B?RXVWSHIrM1pjWXRpUldzWDViQTRBc2ozVHBTclFJcUxJM3Yydk9RVlBJd3ZE?=
 =?utf-8?B?YnkyZjM5OHU4dDBuMXNJWjJBcjVXTVB2S2JzUHhGQnUyNUJnQ2ZMSUMvREZs?=
 =?utf-8?B?QWpabEZnQ1pGTmpMa2E5dzk4RXlMdjFzK0VRSG5lQmFiQWdHTGdDcE5kTUFG?=
 =?utf-8?B?aUh4QWY0bUwrekZEMjB5Wk1kRzk1cE81bWdveDVSMUF6QlpGelRESFN5ODJY?=
 =?utf-8?B?M1k5Mi9JeXd4SlBtb05weFBPTWpGYjdKVWR2b0d6OFVpWkRiU0ZuRHNFb2lR?=
 =?utf-8?B?eDBpTUtXaDdnT0FIT1FhcjdwQnFDbTBwQ20wdisyaDVLd1pYVEZHWU9raWR6?=
 =?utf-8?B?QzVUdDhUblY0R3hQL2l0S0ZRZjY3Qy92SWVwUzdva3dzNlIxTXlxazMxT2sr?=
 =?utf-8?B?UUVQVzFIRWxtV3ZWV0RpYUdvSzYwb01wOWtSTXVrUHJDL2NFWTRrWGV2NE0v?=
 =?utf-8?B?a200d0FoeGdhb1RNdWxHQjN6ZGpkMzJiRXlUa0UyY3cvSTNpemM0VlFBN20x?=
 =?utf-8?B?QjF0SXQ4NlQvdUptM3ByOFliaHJvc09obEh2eHR1VUNTZk9UeFByOXlFYW5q?=
 =?utf-8?B?UzJQZE1PeFY1RVZJNlR0UzFuMkN2eEszSnNiNG1KclBEUEJ1S2NXWkVaT1pE?=
 =?utf-8?B?cEsvMzdlR3gvZXc1RFBEVDlyOWtLVEZxWE1jRFpkT0Y3RW5RRXdmSWRlaUE0?=
 =?utf-8?B?VldaeDc1RUtHeC9yYlQ4WVhVT2Vkc1RjclBaMUMxL2lwcjlhNzdTRUEvVThh?=
 =?utf-8?B?VDVwZlQwTDNNdnZLMnIyUTNUM1kwQ0E1NmgwUVY2L3dORVdTdUNwb0NsYzZN?=
 =?utf-8?B?VUYvNVdrYjNoclFWUlAxVEU4bXp0dStpUzk3VUxwR0cydDRJVDhjaDAxQUdM?=
 =?utf-8?B?TGZkUFF3STR4SkpxSzFpVm1ndWM3aHpKdDlwUi91dEtCU3dPSndHNGdGKytx?=
 =?utf-8?B?ZzZqKzgyRys2Mk11bVVyM3NHUUZhaVFPOU0za3hHNlNnMFhLejh5OUE1eFI5?=
 =?utf-8?B?VXQrS2U5dC93aStjY255cDRwd2xCK0xVTitBVWhxTldITWJHMmFzUDBVZDNu?=
 =?utf-8?B?c1FDV3JYaVVTUFV1Y1Vyc3h2OHc4a2Z2c0d0OTdtbGtvd1ZZR0hBdmVuTXE1?=
 =?utf-8?B?YXpqN3c4UWZ0RzY2cG5YbXRnbzdUaW4wbXFqTzNGdXJYdVl1cHI0SzhIek9T?=
 =?utf-8?B?NUM5Mm1RRDk5bnhXZ0paNHNZRExNSmdZRzZBaWwwQURuRHUreDhZY21aTkxT?=
 =?utf-8?B?UFF6blJxWDFXZlgyK0lNQUs1SUlWRjlZRWc5VFJFb0RaWnVNVjNQSjhyNXU0?=
 =?utf-8?B?bk9Ka2gvejh0UndtSVRVOXJBeThuU3VGb2g2QkI0Tys5ejJrZzRESHF0bDRU?=
 =?utf-8?B?VkUva3RWMWkyUmR4b3hsS1ljZnE5M1B4eWhmWGVnZ25JcWhBeFo4emd4TVFv?=
 =?utf-8?B?VUF0SzY0RlcwMG5IOFhMUXV3UXA1Z1ZUQVJoaHk1Z1U0ejduVlpkaWxTdjJB?=
 =?utf-8?B?V3Q5NllyN21jVWhBQTVNVytsOXpHVVZYUEoxY2pkam16UHpwak9lL3lKOEE4?=
 =?utf-8?B?YkNEajlFS3JQSitkLy9QUVhEYUJ6S1VZaG5oSGc4VGF2WDBaeFBtTWQ2TGxO?=
 =?utf-8?B?dzR6a1hEUDB2WDE0MUM2RzR4UGplSWtCRnRraXRkOUgxVUZsS2FXWms5MnhI?=
 =?utf-8?B?RFIwMnJRampGQUY2dHUvL2Z2MXZ5a0I4VkN0aHhObmE4UEl1RUVkZ2xZNm1J?=
 =?utf-8?B?K00wOUNzZWxLc2FhOHhscUI4NlNja1ZXMUdGQVJFMVJGNldLeitCc2dDbmNh?=
 =?utf-8?B?cEZ5NitlRmh5M1FzN2luM3A5TjFGZFQySTJMODdTeUc4L2FPSE1KRTJDUzZm?=
 =?utf-8?B?cGs1WjRxdXRraXdGVmhncHF0QWFBMnNpOHgzTHdjckVxYVZRM0tQTndzeG9R?=
 =?utf-8?B?T0MyQVNRMXZvb3pIS1VqdVUzM3ZQTGJKM1ZlTDRhVzh6YWpyTTRNZkxockh4?=
 =?utf-8?B?eGZEZHRPaC8yZFRhTU1ZYld2Uk5jbXdnNnB0aWtvMkh5T1JpSU9aTXNzOEgx?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E899569DA0E8F34DA8F51A8A4F395DD9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qbt7DdOFAK8KEYW/dF7cpudy+g9DjigUMY+bE1j6UMYLPtKtgWiKZeJSWBMlWNJejeRn0Pp7ZjicfhgAqwVn94QJm8CCCdPfuoOUG1eiQE2Iv3xBaIY7i/5CVufC3fr6I5iICorIb97kEpmMQkJjX54yl9DoNpLsClA5PuzPJcPVHHie9HvOTt8VU+NpQ4iEtTQOeALoLN5qi7ZR6W3OHgiqrpuJtRajuQHfFKkgySLJVnoMSXinRercJNTrFkoe8TMaLeOMNE10Tqb/bKDd2xPGxmJjjFKtXMHgDmw9wtlb0t0kqG6ny5ZHzhiobQvo4Ywflt2usfM8FxjtUFMLqmqB6Sj0WcAIHr+pTJDJ1hI6a7z52ejEzYBL4WIeDLVigZq4SmoyXgMVmTTvLX1+7y/K1RAtuQSSNPYBNCCtojFKWNzd3qTgFAKH+V1SjA/GPOLajjQ6NHeLqeBYwLsECEAlmLWWCyuTSkKr5yEiCbbPXJrH0u+Vl0z50HyYshwOx53CD6QJ/8UvuxNVivtMGexVurU/aVz2XNWYGE77VWs5eIc+otHNY8Ny8V+7f9NjNI7C3kmztlbhDrC/H68dJYp8HkbJ7zvukEsg+5TrdV+BBTBkPFFuhGAGrti9ElZW689+RCG87+rXylvaXmc0WQBcipHun5Rd9upeaS8Xada0mC1UxTHsNzkkExdgd5pyLcEFis+cNsHcD8glN2k9SHIORw/Zj1Z4EbHMgP5f2JWg3NMDWzai6c2f+8RIAioqpqtzYh//W2Jxjp55q3ibeefhKC4jTh4DmkS3W6I+OixoQnBe6eZ0BAfYG10jqlGX2tv2uBei9SpYawXStB3dn2pCRPbcuYLLiaqQG1kiDNKHTT/6dC97cBYzLVVI+sj7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185de76b-401d-405a-a40e-08db2095b790
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:59:20.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17bPAAPD0ZMQBRuQtQcVbgkxNhdeOwZeaMLzLwWtgC+zNKDQUoZN85Y7bLT8NTvQ4MF8C8niIfri7PQrn+qusOpiMIcE+SK9T8pvdLYE8UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7505
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
