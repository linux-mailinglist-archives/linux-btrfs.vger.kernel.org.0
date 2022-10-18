Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF675602C41
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJRM67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJRM64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 08:58:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB4DC512C
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666097930; x=1697633930;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=kRS0pGaD2k4Xve8MKixBXNee3rgaGvnFYPoaLLrizo4=;
  b=e8ryOATSR/EIvptKP4gDUEdSONudVxGZwjGaSB3tlqTYtVcQzEJbSt/J
   ggosvRdtO96Anc+EOMF1j3pCKK0czdU00hzjOZl0zvL8IlJJBdDiFTzAx
   V2xgwPlUmQlW02EpkwgQkeDdCJuT1HhSqNdPRqtYOuOgi8uPrMi3QXeCC
   zpwtwv/LtV+I8gSIv+9NNZLucK5f21G8I30G9R8za+/dcmDffAgwNDLCl
   L68vohKrn0CnqwTMWqw2ABxr6saUPLVMaE1dLGo4dCkBD0WUkzrZDkpXi
   RLDjgCfB500sETnjORCbRaspgs5JPaXYgLAqc4SDSXYUSymEs7YE70qrR
   g==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="318442350"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 20:58:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnQpT+Yn2aoI5ARn9wFIgbbay9DKH7zJty2qyzJSC2STIhY4quYxLTZKCwom4bhe/BxGh9oHfQuJlNZik2FzpswQT5oS6DmlRewVCIpY1bhndoyQ1SHqSIK7DBtM4o/N2rpmELc/lN4x0jNPKGfDwIdW07INnDc3nXjh+vdxbS5FeO70JMIMlKe1wqK3itZcCD/n4z9EUpyk/OBmY8NkYF2j1Kp1QJOA1oSvKNhO4EFQlbkN2u+prcAEiQR2cuQ+csh72PhcFHLqelfnNGrsyl/OvaPDtW0oC3wmO6D/sueJxx90Do2aVhj8tmy6Ad2yWJF7Qunvti5YO947DY4zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRS0pGaD2k4Xve8MKixBXNee3rgaGvnFYPoaLLrizo4=;
 b=BxkrGOSp3ImyqywNb6sKsUGUjwI5ACVmlbGohURj9tu04IEtMx7gmgKkd5xvJHuszeA9RhievF4ri6bb21jSVaRyPpR2wqtOn/u1L3GYc8KwXsQ8abUwNgZ/gMWuEsOUJIqIdMdFG27W8qpWeCDJUIrMPCMAI9qyfmwyr2l/OyYtJJMHeIs2YfRuo/ChTqPzwfYOExA1CvYrgMu0q4DstwQrFH6f6bt/lH0K7Lo8/zkhdsnG7BfmIzNyK0rcwRKYM8LJcYLt1xOSF2v/bepKGWbj8UnSKpEIvU2Cta3CRkpNQOJLMzpr738SU+uPEvcMJF1hKBTG8iAxqA0MKDrCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRS0pGaD2k4Xve8MKixBXNee3rgaGvnFYPoaLLrizo4=;
 b=0IC+N8c+U8SsRvOnvw3YVKLA4hkY3ELx+b7f7DJ0GVAzUB7RzkpPPZXmfAg+OIma9U/QNeoScKrAOaieU13gJgTkmcXS5WgC2k0KaX4j89MJ+yL8cXAaHHe+ScoKHc3HgGbA5rh7a5QUN9WI/o3ehQIsYH2Oz2w8M/0ZcA1bjuo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6015.namprd04.prod.outlook.com (2603:10b6:208:d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 12:58:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 12:58:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 04/16] btrfs: move assert and error helpers out of
 messages.h
Thread-Topic: [PATCH v2 04/16] btrfs: move assert and error helpers out of
 messages.h
Thread-Index: AQHY4lwMAUp+nMsbakGT1lQJ1oFpoq4UHfuA
Date:   Tue, 18 Oct 2022 12:58:43 +0000
Message-ID: <1cb7f181-26bd-fca0-2c90-9a20ab773276@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <c2a1a41d986d76af2e25e8f3b29d7b9295bf98d6.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <c2a1a41d986d76af2e25e8f3b29d7b9295bf98d6.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6015:EE_
x-ms-office365-filtering-correlation-id: a2d6837f-f68e-4e4c-7f20-08dab1087ce5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFrFrN3z8PxGTWTTrk2JaHrrZjszK59+lRDsQ4PBZj82ezKfVYm8aDDgGliM7FvDbuSq5B+J5P1aSQKhxH+FX7Wava9BIGMFKfbTzEWyB5CCPU8NCS0WSntfDmhz4InHTM8HiXwHZ1FcjICixFisIsMw+k1e2PGG1J+BSclPfPvq+dYskt8lopDnLKO68VN7EcURp/U1gko5ZmWbnyQmVNIKRCuGXAeW5P9kzkhpVQ2F0YvThM43gU8ELN5hqHEOtGbLZNXnJQrNjbq4smWE8F6u2wNgiRvZrkxJkLWTWb4jKfYkOBRElzIKRkDHe3AwLC1gVCPcvZWHr8b2gsEBZlmB9tbuQ4iobmyJ4jFXsPRE85jmNxUqJhm4ocLBj9b8DBpu14y/sakYvvpQRZA1yG6yUCRD4YfgGD+1QCsWRpd1A8Hb4GY7VAdpnijra1qxJhklCYQ3dOC5EdFBYEsXd5M7yY7vuyf3jXZbbulpyWuTZrqaAaoexG7VGmSx1uZ5EkmmwLxR48/YVXVE0qjqrJ7jhJ1RN02e5OGzCDtiml6iLDaNkc2GaCBQmZqAfN58rFwBCnVN8r6rDmegrl5fjQpnS1gIAwA9YBwvmTjm+LKa87AUCfnFQFR+v6K18QBRFihJSUmo4c8ExSXNURaWtG9pF0gPtimh5OVAQ0xfXV4Z2TSEnfPhMbGKIXo5wQtyZ/V562SM9laFbvSAZjRGVscJ7K+3EwsM2VVTvxdn+GECGBFqzTzJSj4KSavZ4NrJe6AckwbRohcJgWEeUh3BvJOw5rGtSqlULO9kfIrtF6OePDkow+pC40wobbzU3d27TcsHsuuCvJLxDqhLo1leXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(26005)(36756003)(110136005)(64756008)(76116006)(66476007)(83380400001)(8676002)(66556008)(91956017)(66446008)(31696002)(41300700001)(6506007)(66946007)(5660300002)(316002)(86362001)(6512007)(8936002)(2616005)(31686004)(2906002)(82960400001)(558084003)(186003)(38100700002)(71200400001)(15650500001)(6486002)(38070700005)(478600001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHBtL3J4TWd3UXFkVFEyMnkwc0ZkaTBVb2Z0NC9OSmpMWUk4Vk1ZNXQ2OXBR?=
 =?utf-8?B?ZnJtcGVLRDQ0ckVXem04Y291TUxhNTVFMnBnTzBlYklHWnRsQ21TT3A3UW1Q?=
 =?utf-8?B?N2cxQ25Ld3BXWFhGbkFmYXE0SXdQa255eVd5cmVudHU5Y1FxNVJ5ZG43TXZR?=
 =?utf-8?B?NXo1N3Fnbm52S0ZMcW4xOTZTbWNjUjFMM3BLUU5RT2xVSURmRU81aFROaDZJ?=
 =?utf-8?B?THhuTFRoNkdSbkdCWEsxRE5majFqc011d01jU1M3c0R5RUdZMTlKSnFNKzAy?=
 =?utf-8?B?UUxYTWo3bSs4Skdka1lWSkx0VGZkR3A0YVdaQ1B2ZEplZUQ4RGhPNUNJZE14?=
 =?utf-8?B?N1hXQ0swTHQzdXVzZDFTZ09LTDNTY3A1cUtNYlRZa042OFIrQUQ3ZktHSU5L?=
 =?utf-8?B?eG5JcE43MkQ3aE1KNCtnK1l2UUsxTFphZmxpNUtkamx4ZmN6M3VVVzhaNUNY?=
 =?utf-8?B?YUtraC9WVUxYUWc2RUNFTHdEM3FpYTNWTC9Rb0pCU0wzNzkyek4zbWtmdURP?=
 =?utf-8?B?YjBhMjliNTRZU1Z2ZWNmcVdCREsxeXFyeXFXNW9jeFNMcWxPamZ4SjNmeHkw?=
 =?utf-8?B?NkxnYUZMU2RVTlltTEd3bGVVbmhCMm5BcjFWYjlKN1hqelRqMjNHWld1elll?=
 =?utf-8?B?eHJWbmZNWFZaVDFGT2hqU0llbFFiL1pLZHltNGQrd1pMNWdBdC9mWlJDMk9F?=
 =?utf-8?B?N2hQczh6Ti9EMUR2N2NyMUkrUzRHOWhFWGpSZTMzODR6ZXpjRnhJVVcvZkYr?=
 =?utf-8?B?Q3ZUYU1jT01OY1dVY08yVHRDN0V0S3BycWltbWhZY3luNnV1dDFaVnpMQk9K?=
 =?utf-8?B?SEVwUFQ3V0hMbWxCWVZVVmNjbGllU1IrU2RMTVlCKy9YenBqR0NDdHJIU0hC?=
 =?utf-8?B?QWthRVhpQ2J0TDZTMXRxRXQ4RllGMkliaEhlL1BYRGhnUUV4NG1RajJyK1dT?=
 =?utf-8?B?bTdjdUs1MEZQMjh6R2dvSjE1a1FybUp3aEgxMGJuemJVc05lRFU4Yk13SUF4?=
 =?utf-8?B?SFd5YlpHNXYwOW9uWCtsckVRM3V6UlVuRVEvNS9HZktBeVpubUZ5QStrMTRB?=
 =?utf-8?B?REVEWXVTOTN4ZC9uQ1VlNTV2bTllUTdvTlgySlhuOHdmTUxGbTE1cFM5Mnl1?=
 =?utf-8?B?aGF0cVBMc1RpWmp0V0lsY2hqZkMvdXYwS2VQZE0walhhV2treFo2WVNBZGlk?=
 =?utf-8?B?ZlptVEdDa2U3NmloS1JPSXN5UEJ1cmN6SmpOSC93bzB0T25yZE55dExOSXhE?=
 =?utf-8?B?eEZYTVBTWUt6SkhwM0toUWVDRnc1d3l1K1dOUXlmWm83SExRMEdOa0pyTEpL?=
 =?utf-8?B?NW9iQjRjNFo0cUFBVTNGdEd4S3dZcm1GSnBUT3d1UHY5Z1ZMRVBNNG9OUTNT?=
 =?utf-8?B?bEl3YlVpUnZ0M0wwVkZkQTNlL3cxby9nc1dHZDE2TVo1UTFqZzYzOUoraGI3?=
 =?utf-8?B?akNPT3lpbVhoeXI2N0l3VjBhbEJuMHNJOEtzb3p2eUdoODRyRjdKSnFRK3Ir?=
 =?utf-8?B?M3NIT0Z1b3JuZk1kOXJKNWR6bG9oZjVsZTM0MHBJVWRNOGUyYkY5WEtMWWVI?=
 =?utf-8?B?WmZnTjRodXhscEhsSHpTTHRtVXorWE9WeGZ0M3VXcVd5YUtIM2MyUldZMjJL?=
 =?utf-8?B?V2RMUUdkMDgwR0lvbXVnWDRnRjZxSWxScXFOQWNObTdBYVJnRVNMdWdWS0dQ?=
 =?utf-8?B?T3F4ekoyRnAvbVhxZXdORWl5bm1tN3laUzJsQzUyRGZRMzN4Y0M2SmY2SkVL?=
 =?utf-8?B?c3ZBeDMzR0wzZDJPcDFxLzk2Sml0eXBEUHhwd2dwQW82cTQ4TEhFdjI0K2Yx?=
 =?utf-8?B?Ym94citFZjhYWUZVZjVFa3ljUzlVR2x5NDErSzl2cjE3dlBVWXZEN2NaMlJy?=
 =?utf-8?B?OUwyMkZhVXF4MHhHR1MzekhEcFVkMHBoVHNVczRMYllLcFJ3UWtXbG9hM2lL?=
 =?utf-8?B?TG5VUG9SUHhSNEdxV3dUVW5EamVpS2pNVUdCdVNCbVF3VmsrajRKd0d5d210?=
 =?utf-8?B?bnNKQXNMWGsvWkpmK0p5aDdIRVF0aGRia3kzbjNscTd1NlJ3UHlkMG90OVNB?=
 =?utf-8?B?eldWa3NUSloxSVVvUGVmQWh3WFZpRTMzc0ZSTlA3VGFzWk1OZzNjTzNQTjJF?=
 =?utf-8?B?ektaclV5SFhNYmozR2pOSlZSZEtKL3lvL3djSmIyZDd5OXlYYjNIcitiTVdi?=
 =?utf-8?Q?dnPnN1XEptWCx2xdk1kaxws=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC989F86E0F5B14183A39C56D75FD28A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6837f-f68e-4e4c-7f20-08dab1087ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 12:58:43.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rNTrA1eGNTBThDGB9vW8K4viYF0Yk7+74uD9jbwUcIsquXg1NVPDSDtF0LVvEI4tfx87Kwb9Pua9b08vfB2MmjriXCuQ3/gXVqMHHMW7Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6015
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

QWdhaW4sIGxpa2UgdGhlIGZzLmggY2hhbmdlLg0KDQpDYW4ndCB0aGF0IGJlIGRvbmUgYmVmb3Jl
IG1vdmluZyB0aGUgZnVuY3Rpb25zIHRvIG1lc3NhZ2UuaCwNCnNvIHRoZXkncmUgbm90IG1vdmVk
IHR3aWNlPw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==
