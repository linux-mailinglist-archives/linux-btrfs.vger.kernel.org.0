Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC31460F10F
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiJ0HSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJ0HSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 03:18:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979515DB35
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666855081; x=1698391081;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=diuinPk7Km59igMJmZsomofGQxhqx/8X9Ir45a81vw1WE4KC5tNWEQJ5
   1UKrSIII5w2vUPo6t2krJCTJyqkoQZ/XJNmt2b7stOmIfUqttjHa28/wf
   AjG1B22l4nJqgg65LXKKUg/PB7/I8wQjO9f8NDTgl55gMhRJ7oB3JguBO
   C2p0FXupOvCVAvAI6BKh53x0CNa02lv7rFHma3s5s9NzpTAfDQAGLyc2w
   AuIGZ7lKYxCHVdoniaSiZ+BgeVyA8f299Cp9+sRCQkGRKYdOrA0djAzKS
   qwjbM3NAWJAePvp7LUbxy6gTzseB8Zt+w5HIBf0nkWL+hXrHOOit0/Ux8
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214851320"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:17:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwE1nFYcNS/VEEdl6mzwr6VUyerXQPbYZCDQJpcXWLILx3dhKV6cOd1DdO5qWLmdXjxvHOUionGiDj163vHHHmB9IZ+lE5RfM4/FCFh1TXb+0ixj609Qdoo1qHxPqDtgq/3B/1uCtLFFW0DgzYdlZL7E+XC4dP4ZV5+pP11CQNansvxrtoi3M+Wk8QXvh2PIfJLRDkNaZ/R5+jodrd628Aib0UnBgIYBCrhgtpbpFp0ee8pB0dL1qKz8+vEvSvPuqJM1nG/XOl1arhERKXx0pVgqL0zaVbT7KKtoIbZPioMmUtT7t9tUdSv3YkyxYElrjdgJgQOS+5ZX3/oOhCXhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ePiJJZyegWYSsWxRZ9aaBX0KKrdjJNeFAI8UWINNA0qnEpxtf9/IYAyzJfESa5lt9kxeONMQ8cGU9bxqp1jxrdENlSS9oaGRT2xTph+H260xLV53CT/I9gJx534l+1Q5EORtGQ54d8tw320bcJkgrfR6iQOqodj1aflaA6FvQqUTSoDe3ehiJHW+ClTso+dq2mAFI8LQCFXt1fFF9eRNxWoqwcSi+AgRg528sz/gjrX4xSzPO6mzs8+zD32EaWKfWwpsti3H/r98dqT+nB3SQcM8s0Q7iz/VHyTkFFW38WS/jdZ6b3dtOUsioKhS+NwWpqfzZMd6my7IHO+zByoTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=vfDWrcz1PQu6b1mfwgPzR2/xMwAGnKeAHUP6HHLUjJfL1SHxQU1u0CPNaaUnbPTZLYzTBCX7LvSWIoYb7/0NTgafOJxbRhAdU656ixjnsd2w/JS781ADKcnIJTj9hor8N3/+yvkBQbAFX5DrKDgRC9nFVYOugq+Akpdv0XZoGLQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1048.namprd04.prod.outlook.com (2603:10b6:910:54::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Thu, 27 Oct
 2022 07:17:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 07:17:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 11/26] btrfs: move dir-item prototypes into dir-item.h
Thread-Topic: [PATCH 11/26] btrfs: move dir-item prototypes into dir-item.h
Thread-Index: AQHY6W7bhxplYzZYhkaVQS6zANr1oK4h1Z0A
Date:   Thu, 27 Oct 2022 07:17:58 +0000
Message-ID: <4c5f9650-eecf-186f-4477-d9a591a7f3a2@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <538b284da3a43e4ffa11f057e4db2ffe3119a6e0.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <538b284da3a43e4ffa11f057e4db2ffe3119a6e0.1666811038.git.josef@toxicpanda.com>
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
x-ms-office365-filtering-correlation-id: 8cf6c09a-0afd-4f22-8373-08dab7eb6033
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKaHBz0harMpflUSlxMUrEZdKGqOPOSWvCC5SxPhy5fscTWaVLwb5+t1W3kDVT26llGPSZvJtNaefb4XMUALT1nX1r2MW7wzNTpjG8KBimOHTHtWboKoxoJtrNe1C/VWPgsMiFfZwVoG3SVq3pf/9TF451xo7ZSXsu3RxW6ILTyy9pRZvSWNELfuPpf0Blw3zPDWhuKcoRFAUbbfC4ZbcHza16JE6kQerrGD9GmoeG1qM450+mzJHD+DoluXfdqtpR0YFtG8tooIkNWcQ3UXB5SnalCDJAFoJ9QrjgH4Qe+FA/McBLvp9zdx9UgpT97RDvGNY6dFREiiF+3d1WWuJk1bScP9dkIl9yJLfwQS94rb1S4SH3PqxyCtLraLn2zfAYSv+nKy7dZkDzvfsngXugYo6HsGVJUB9WLix6MlrtTi6V62jyzX4Cgtr0Kw6Aizs4aI6c1JYJAgNj5XbVOFk2RL0Jit8bi0Wb/NBIZ6STLMXXbh1Yk6qa/sPIsk98SkI2egy39rldWcQSzXemDbfOJnIGz+Umcgm1auXZJUEVPmQVj90KFi4Bd7Qk+UfVlFkOm3jOCQTJq686bsGa66jTEplJ/p9+mTZIMfbwXoVj1VZUASo73d1UN79W2MrP8I7buKfObXndndEP2Rle0vAENeHcJx/qSV3MowMMoTr5K2WxTKVy5vwWCaRpExYFLEPl7yMkFbODzYvwm+QB1yy+0zkdhfaBGDBzvSoqSpp0g1Rbg8dN8T6duQLB92WU6RJxlnhAICaVLSddb58l0g7nY9Af0w3YsBj5+utC7whKtRr9LGk/q8geKfzwxACPfi4n3bo3Ae06iqh41cl1CB6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(66476007)(82960400001)(6506007)(2906002)(31686004)(26005)(6512007)(8936002)(5660300002)(4270600006)(36756003)(8676002)(91956017)(38100700002)(122000001)(64756008)(66946007)(66556008)(66446008)(2616005)(76116006)(558084003)(41300700001)(186003)(38070700005)(478600001)(19618925003)(316002)(71200400001)(6486002)(31696002)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXVpZ0NKczFzM2c2T1ZlRGRXcEIyRmJuY0E4aUZmd1laaWgvWVc3Zm9jSVdr?=
 =?utf-8?B?eHAwMWNoemFxaWJRTjk2SDNmZUN5cUNYUDZZa1I2d213VGt2emhLTXRNZGU4?=
 =?utf-8?B?djdISUh0V0xTbGt5R3ZiVXFUTkxOZ3lraWJ4OU5VRGFHaFdxSjh2TVNwR001?=
 =?utf-8?B?Nno3TzFXNU84Y2Z2bUY5MlNvaW8yUTFPVHFnaTJ6dWI0VEVjSVJCREswbkRo?=
 =?utf-8?B?VjhNUnJjREJYUjBtVFBRMUk2cmJWRnpMTEpSa2NQaG0rSEhqcWM1SURydkVY?=
 =?utf-8?B?eXgydnlEazFsVDJDRERmc01Wc1hpT3pPeGVMMEk0STdDMUZqWkExSi9YZGtG?=
 =?utf-8?B?bWtCSDhTeHB3cDhzNEJJUm9ITE9YR0Nhc0J0VkY2WklJc2pUVEVodDl4OEZO?=
 =?utf-8?B?S1liWmlTVzM1YU13QUM4bW50NVVaaEhXM2ZUQkg1eFM0TS91cVpvQ3dZQXhS?=
 =?utf-8?B?ZWY5NVVzWnZZN25GeVFZSUlsQnMwR1Nibnd0UEtvUVdJSGY3L3ZYV250dlB0?=
 =?utf-8?B?VlBxbmFJN3JaNXJmLytZeUwwaTlSNnZlLzQ1K1p3TFFUNTE2R2xIcHFPN3Z0?=
 =?utf-8?B?TEJKS0lNSXJIdU1EVjNCK2RoR1UxQjZHdXFVUVA5WmQ2ajRkcXRmUm45Rm1u?=
 =?utf-8?B?OG5qR1JjSHAwa21UcWVZVEtZOG5JdXd4VVZtMExFYnBwdGx4SkRnWkU1N3ZG?=
 =?utf-8?B?enRNR0xySTFXcDVWejRvbEhBcWkwTHFEY3NZU0sxeGxqc1I1aHlHWUVHWUFr?=
 =?utf-8?B?Y2VRZTVxci9QcmNqZ1R0Y0J6L2dROTgrcFlMc3RoRW5lNW9DNnkzTmRrQ1Mx?=
 =?utf-8?B?NFNJeWZ1a1VLSHBNVU9JQ0xDT1AxSHRzaTRQWEphVHlPSURWNGNJVGhvRVRT?=
 =?utf-8?B?RGoyVHhXWDYwTHRCYTlDcTdna2dGR0hnMzN0ckZuaTA3THVsNmh4WE1VQkZi?=
 =?utf-8?B?b1U1Sjc5NmZ0c3k0UXUvVktpVVcxRDR0YlRET1F1cVk2cEc4WC83OWNxa1Bl?=
 =?utf-8?B?QTFRRXhIdkg3SHg3WCswZ3RkOElDRTBjdUw3WDBYUUlYQjdrTUVEaFBjUEkx?=
 =?utf-8?B?N3FqQ0o5ekkrcGVXcUpoSW50V3J3cjBud0xLRmh5TVZkd1BUbDUwakxTRUls?=
 =?utf-8?B?SnpJL1Z6dGNNbkRGRmhvL2t0QnQ1Mm9tMHdXQ3Z6M29HZ3JxbVc4R1J1QWlo?=
 =?utf-8?B?cS8xK0JLRVJ0SzR1ZXhpVEd5S0hmaHdUUkVYeFdrNDZ5N0pPOEwwZXkzdFo4?=
 =?utf-8?B?dHVzcUVha0NQN1FoRWhORUNmN2JSU25IelVuWjVmaVJ0bmNMdVFKK290c05z?=
 =?utf-8?B?NmpKRVNNalFRLytTaTYrK3dnRDJSa01GQlI0Nys0dFVuOUlyWnJvR2VxU3Ir?=
 =?utf-8?B?cTBVWTBrU1hLOTVoUzVjejZXMm03ZWFKblY2TGpqbDZoR2ZNS3R1VnFCdGtB?=
 =?utf-8?B?ZUJqRzVSalJGY0pwZGFYSVVreTdFWXZJZzk0QVYxNVhERUc4UzZrMlFOdm1o?=
 =?utf-8?B?eW1Eb2pHbEZSSjNRc0R4Ym9TRHBjTGVGMHVXQ3ovUm9wWWNna1RoQ1BmcjZW?=
 =?utf-8?B?QnJBNmEzZ284MUIxbXVQUGZlVkxzbE55WXl5U292c2VrblZzdmJsSFhCeEp4?=
 =?utf-8?B?RnEwRTJTRWxnQ2l4RVhva2RRamUyQlJocFFFektka3lCSUREd3NFM2dlWEdX?=
 =?utf-8?B?YWxXZk5xRjBqVFR1cmtZNnJaaWFyMjM1WnZvdi9GdkFkdzRDVEhXZWhzbTBC?=
 =?utf-8?B?THR2OHljMzF5Mng4VEs4OVBwYi94WlNiQkJGYnJtK2x6QmQyTXpaQlBNOWJj?=
 =?utf-8?B?NjdXaXR3MTFzbnFZNGhLOW1XazFIczA1UnhFaXZRVVFaQ29Fd1hUYmpma092?=
 =?utf-8?B?NTVEWGJwQTRMRDBOenY4c0pPOHp0Nk95ZHNGNGRwWnQ5bXkzaEFPWVRBUUdu?=
 =?utf-8?B?ZVFiNnUxQnJHVWtuRGxla2tscnJVVmZUREVDdi9DU01XZkxPN2lCTnI1MS83?=
 =?utf-8?B?M0dMbTArQzE5TG1rWWUxRTQrU09OYS9YaTJCQlFaRjBmRjFaQTdGbXlQRFA5?=
 =?utf-8?B?OEJxRndzV3FRa2ZYMHF4SFN1NndRa1ZHL1dDZTI1Wlh1K3ZDdml1OHlOYWNG?=
 =?utf-8?B?T2FVUFJ2b2hJV2NDS1FCaUhBWk1KUjNtUHNXTkJKc05BaXc2L29EdWJGY1Jt?=
 =?utf-8?Q?V1u7UqagPrFnFeNXbyrThIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A84DF315E85FF4883354B055C67B7E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf6c09a-0afd-4f22-8373-08dab7eb6033
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 07:17:58.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LY76PT63pSAu0HHZmcr9o+kP8ZsFP/gWHnCDO496o5e0Nxgr+fFl/t8CEW0jobOsmVekMaWsHXReNuxukGmcgq0W4/5zFF6Zp9FPcpKwXEc=
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
