Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8D60F083
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiJ0Gnt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiJ0Gnr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:43:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB207165509
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 23:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666853025; x=1698389025;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LMofIspvS3tryd8UpRmXyANzfIzXSLUdv4la7AK4czQ=;
  b=IycQKQZ2C0W7FJdcKJOueMBjar63wtFh9fZckenzd4pflhvlF/USIbNG
   fskkA72IvaCiCGrpgft8ZTE2pMhTKnqbMukG4bHyH6YJdTtsRf/YfIZ6w
   NSthr7mGlgedRGN/eKNoLM2E++BDaoQ/IDKO1/2YFntDkL9KB2NOYXhmE
   qsITBL8PSLG1h6Uexb5tnwc7PRJI0EDoCSVIi7nwaaHnwr8L2IjtCm5UL
   LtsnEclbRi8L8dGwFPzo2jRYsYtpAJCkMM2BiwKUOLrh1XFvM5pUqS6gf
   EY3NzxppkxJ8hOUvnpUlI5qFtKjicAbVUwmETC1mhV4Fr4YOyaQNvH3nF
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="213147439"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDR3lB4nQUuDwvsRxcKgyYL6JandL46wY4eEte8Ec+ETpSEXxmBxt0+rtPXhrY5d6fLCH0QZunuq8+6tvr6Kp0LkP5RQSx2IgJSahN+IZY4cVJFUTqvKPXh9neS2TBhcNBqkjfct9qhzKIMT27ZpKESbC3R3BuJKPhCRPbPCeKQ9+otcPlhvBOQBknfbwBiomnKaD7PfK7yGuBFo+qXxtZrpvcHSm1HG8nAi9bPEjDWl0M5B4kgx2mJg01w8cwq3WS1IuJW/6W5y/u06RRn0YV7snLjJcebtlr4ryqNVgDbA9X1hdOFb3BU3CX52Iaod02x2zEECYQt4KIAP7g2R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMofIspvS3tryd8UpRmXyANzfIzXSLUdv4la7AK4czQ=;
 b=lkVuS4WvEOyeauhFJQVAvZESOxewkDFJVwDdLPCCRKJWMPbUheCj0pU2vKTPblRHsHiiUrF7mzpcklkHhr+nqoOn92g3tUQqTYEJrnl/qFX8hZTNSDm1Nu8B1yp6PYuAE5S6gdE3c2MHgO+8ZCJFtw6UZJEFa9TA493kL9Am+5B1c4e7f/en8ltPrzC928KiI1D2qxzARzqnCg0lyDQ6hW7OPbykhVRieuIdpjjLdl9CRKKDNRQcfRVCkpgHCJCIZtnUYhvD3R8Zennw9D6+zpYkYmmysZw7NDlExQqKIXaLrfIQAYwQKIFGOh7+xPbxbK8EHC1rZ0bAUJNX5uw7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMofIspvS3tryd8UpRmXyANzfIzXSLUdv4la7AK4czQ=;
 b=H20i4qR80V6mRw9LwID+mIr4y5dcqr5m37jBpvE4QVKEYDv6NUS/e8Bmy35rmBqo0F/Gi497zepxYh+mGrFg9AEec5UpskB/tcTFBDZAqa0O/lF9Me9/feTIGvhC9mHYyKKQBzhm3LKhQgyuOMp15hur4g8vgfpCjAy18qs/kG4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4034.namprd04.prod.outlook.com (2603:10b6:406:c2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Thu, 27 Oct
 2022 06:43:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:43:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/26] btrfs: move btrfs_chunk_item_size out of ctree.h
Thread-Topic: [PATCH 02/26] btrfs: move btrfs_chunk_item_size out of ctree.h
Thread-Index: AQHY6W7OUhxBBY0MZkedhrFgQL2A2K4hzAoA
Date:   Thu, 27 Oct 2022 06:43:42 +0000
Message-ID: <70564ebd-96ed-c8d1-d1d7-e133a7a60dc0@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <e1ec74ccbcedc5c9dc9cb8d82b3ffba387075afa.1666811038.git.josef@toxicpanda.com>
In-Reply-To: <e1ec74ccbcedc5c9dc9cb8d82b3ffba387075afa.1666811038.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4034:EE_
x-ms-office365-filtering-correlation-id: 4bdc0b26-63a9-41af-c979-08dab7e696f3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvGmTPGddiJo/mSyNEhx1/93fRR7sl4bnBhj22VIlHEzeAEMo4wKa+RCuKKiOr++OdCWRlhYFQLDs81UyCRhbhcA5lYld+NtspnVq+K+fUa6RhE8cu7wxZnxd0j6rL1COBumNRrpg0oBaAR6o08QBaweRrmOFY7y77WsOTv8Xwla2aQx9gQh4DCf5slWfdC6LCG7h7IAG2aKL4d6Yjg+Zd3qbcu4Ka/Bqp+mnFPoh0oiMisVHQLHhrq7K/HqDgvYVKsoY8ymzQZ0wB2ni8v/JWCOiMpjvFEvMG6LrsvnHO6JLsx2D+dfG2W5bPkACrldGUgc3SOFpFH5uV0dZNhO4jmUcTA+uaWZh6JjdWppOY/EGG2UpFSBLBifVjeYSjFFAY0MyKxWWe4rbtLqlcCSL41/Dj1fr/C3SSDEa4MyAmO/lnrgTEPg0MjjnXGKVoX0zkUjFvVzNPtD4/VZ3OWhNMFO2uMWtB97YqsPSRnN69UdTuDWu5CDoTKoh9su0Y91Pgt11GVo53TImnuPmduK3xLD92BqZXL7JCOoQYB9otaTeaS0htYaVQJXXiQkBqvATI8iUJKPphRShNbCjFDoBLhoCrt/E0gQtprvGpp0Cjwu3n5uQXMeFe0O95KrCULipP/QcasJDusyIgW3PnZRrY77qo1mUb51F1K1SUT2sj6yNq8qoz9VcnRXCH24NWqymC8ubnq1oiDW1CNzsl81SzD1wwsCipgf6JqQPqLFSqJ5oaclgORX3CBJ8nsO7nASeeVvoV3jPgvGQdAFDLm6NDl3/x3AvffpWaKJ7vj+iGx/ye3/nwqK8b6pgTgImelu9PXoIBeppt3GkxSkuN4zmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(26005)(38070700005)(6512007)(186003)(66556008)(41300700001)(64756008)(66946007)(66446008)(91956017)(66476007)(8936002)(76116006)(6506007)(83380400001)(2616005)(53546011)(122000001)(38100700002)(71200400001)(82960400001)(5660300002)(2906002)(36756003)(478600001)(6486002)(31696002)(8676002)(110136005)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFtN0JXT2RKV1VEcDQrcDRVdWw4ZzJ5RzBKc0ZHSU9tbWxHcGovREZSYVNR?=
 =?utf-8?B?L2tscUVSNG5NeWRnT1NvSnZzL1B2Tit0WEN3S2ljYlA2dWdKNkUxTXJSOVpD?=
 =?utf-8?B?K0Q5OXVielJWZW40RFp4U3RMVis2U2xWV3o2cEkwR054SUJoWVJUYzZNNEMv?=
 =?utf-8?B?ZEVWTGwzMW5MTkFPejQ3KzJOb1pmWTZwRXd4NVJhM3hYVnpHMXhvUC9hT2Vq?=
 =?utf-8?B?YTVGNHluQ2g5U0lQSXpNOFV5Rlp5UGRQeWhBZytJWStrcDA2RDhLLzV6Rkwx?=
 =?utf-8?B?ajFYd3lnbHNyOUdwY3JtRkc1NGJaQ1ovNWxRNnRnKzV4eTdPQzBra2Zueisy?=
 =?utf-8?B?OVJURE1GSlU0emtYQ2hYUitRRnAwcmhmSjZVOTZjNHNXWWVHS1hBZyt0OTlj?=
 =?utf-8?B?ak9kb2s1NzVZWElxZGd6K3lyYytFN3NDaExTeGs1aEZHVjRrbW5JWDBaWkgv?=
 =?utf-8?B?WUZzVzAyZDJ4NDNseTFiZ3FGN3JaSkRuWDJDeFNtcUExVEZUa2N4YUhKYmtG?=
 =?utf-8?B?SHBSdFJpZDdDU1AzUEsvMXBlSGxnOFZvZFM2dDY3VEtsMVhHY0hIeEtlWlB0?=
 =?utf-8?B?UGdsN2RST1RxZEMzUWZhc1RKUkNUQzExS1BnYXJyQ1N6U1FrbnRoRW96Y0FY?=
 =?utf-8?B?WkhYRDJRUklmMWNtTy9mUDlFQS9zbzQrYlo5bUlWVkkzTWs0dkJObVBEcisx?=
 =?utf-8?B?Q3o3OHVpKzVtZHF6OUZmK0dEWVFJcTRZcmNYR1RLdE56dDdLckgxVjh3b0Y5?=
 =?utf-8?B?VjhkVzIxT21FR0VzQUw1a0VWNEZvVFNsOG5iMnVvREFMekZvYTBuK3RzZTVF?=
 =?utf-8?B?YnVuYjJJV2ZzOUM5bHVYVzc4dExVckM5bkw2NlRsTExPNk1UaGFtZVlZYlVo?=
 =?utf-8?B?WEdnYjNWYkFRV3REd2xER3l5enptU3JjOU9HZVFNamRtZlJJLzIyWmhJWmpy?=
 =?utf-8?B?dEZsdm5HbDlCcjZlN0RQcjdtZGphbjJLNkRGSW5sbFlsekRGcnFWYUgrMnB0?=
 =?utf-8?B?RzdZUDh1aHZPMnk0Nk94OHV4RnBWenNqekpoMjZQQ0l2N1JGdlVWS04zUkF0?=
 =?utf-8?B?TUJrL3JLSWpLWjNjbkNSZ2FUL0tnTDl1YStOcm9zS3E5djZUL0RtVGRTVFFq?=
 =?utf-8?B?aUdLenp6YkVuMXRUOXh4UDVRQ2tlczV2RkwwcldiOWRKTTEvWkFrcWdSdnMz?=
 =?utf-8?B?Qm5wVXdxblQyNUNDTDA0eVd1SnNrbExRaG11dS9SMk5TOW15UHpIb3BoUjZk?=
 =?utf-8?B?UldMR3lEbC9OUXV5U3pzTjhHaFYwQVZzYW12NEN3R05lODhEQ01FZmlLWXFw?=
 =?utf-8?B?WUR4TzZjcDNRQnYvMzJndVp0MU94cE1tZ2txcU5BQ0t1SkZFM1lhcTZrU1Q2?=
 =?utf-8?B?YkJoZW00UjVseEZJdU5BeCtNUElLdWRKT1pudTIzWTNLWVY2UVY2YlZrejFY?=
 =?utf-8?B?SGhOQnFUaEY5enFaUzIwZlhNeU53S2hpRUFDbEFSUVIvUVB6ZWZEaG9nMWYx?=
 =?utf-8?B?ZHpwZ2xiS0FyR04zSHNtSHZGakFtSFlrNG9KcERNRDJGMzhIRWlzdjhpb2lz?=
 =?utf-8?B?M1E0QVBnQmtQQVZvVUtxZ1Jhc3RXdmd3bEdmWTV6QVV3QlRlRlQ4djQySG5G?=
 =?utf-8?B?UzRtM0dWTHFubWhtNmZZTDB2c0RzNVZZOGpJcDd4SVhscFpVWFBzNXFaeENS?=
 =?utf-8?B?MnRIajZLM0NOdlR5S3pGdFk1SmErWm5oRkhXOStIeEdFZXR2Z1BRT1BWOXB2?=
 =?utf-8?B?NmpGWHMrbU1JNDdCclFuTFBBa3pUV1ZFdVluNmpIK2F1S3dseVAzZFNxMlJY?=
 =?utf-8?B?ZlV1VnhtLzJXUnJUbEtWdCtkTnlSY0pxVis5SFRzTGF4V0FWcXhPYS9Rdytq?=
 =?utf-8?B?UzJBWXFCOTBNeU5acnVLMjkyVFJteEJFK0htcXhWZHNzUVRMdzhDL2Nndkoy?=
 =?utf-8?B?VWdFbDZhdmFNUzFia3d4ZlJxMVVrZGNkRFFZN2NGdDhTMFBzVU1ONXRiR1l2?=
 =?utf-8?B?cklIYlVBQ09wdis3ekZSWi8ySWtkdURKd2ZuVGcyb0s5RG54d3N4WEZDd0Rv?=
 =?utf-8?B?Q2hYa1RKcVlNRVRSNWdHM3lNOTJxaTJzTXQvbFVlbFd0UzhreEJVWnJuZ0Nr?=
 =?utf-8?B?V1pDcFQvVmRBeE5xcnJ2QytzYkgyZ0VYMGV2R010VVk0Nm1rZHhRVDJ6aG1l?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A8A6EADFF22234C8C47F6A88AA0D35A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdc0b26-63a9-41af-c979-08dab7e696f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:43:42.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRrXeXRJigl2wpnuoFwvtICCLNNCxQGIVX+MLHNhpobZ6C3a5UpT8IkLy56eudpmw/sT3dMZf6k8UbmRFrdXrAAGIAvHYR5NFtA6xn97n1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4034
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjYuMTAuMjIgMjE6MTEsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvdm9sdW1lcy5oIGIvZnMvYnRyZnMvdm9sdW1lcy5oDQo+IGluZGV4IGQ3ZjcyYjBhMjI3
Yy4uY2FiMWJhOGY2MjUyIDEwMDY0NA0KPiAtLS0gYS9mcy9idHJmcy92b2x1bWVzLmgNCj4gKysr
IGIvZnMvYnRyZnMvdm9sdW1lcy5oDQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+ICAjaW5jbHVkZSA8
bGludXgvc29ydC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2J0cmZzLmg+DQo+ICAjaW5jbHVkZSAi
YXN5bmMtdGhyZWFkLmgiDQo+ICsjaW5jbHVkZSAibWVzc2FnZXMuaCINCj4gIA0KPiAgI2RlZmlu
ZSBCVFJGU19NQVhfREFUQV9DSFVOS19TSVpFCSgxMFVMTCAqIFNaXzFHKQ0KPiAgDQo+IEBAIC02
MDUsNiArNjA2LDEzIEBAIHN0YXRpYyBpbmxpbmUgZW51bSBidHJmc19tYXBfb3AgYnRyZnNfb3Ao
c3RydWN0IGJpbyAqYmlvKQ0KPiAgCX0NCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB1bnNp
Z25lZCBsb25nIGJ0cmZzX2NodW5rX2l0ZW1fc2l6ZShpbnQgbnVtX3N0cmlwZXMpDQo+ICt7DQo+
ICsJQVNTRVJUKG51bV9zdHJpcGVzKTsNCj4gKwlyZXR1cm4gc2l6ZW9mKHN0cnVjdCBidHJmc19j
aHVuaykgKw0KPiArCQlzaXplb2Yoc3RydWN0IGJ0cmZzX3N0cmlwZSkgKiAobnVtX3N0cmlwZXMg
LSAxKTsNCj4gK30NCj4gKw0KPiAgdm9pZCBidHJmc19nZXRfYmlvYyhzdHJ1Y3QgYnRyZnNfaW9f
Y29udGV4dCAqYmlvYyk7DQo+ICB2b2lkIGJ0cmZzX3B1dF9iaW9jKHN0cnVjdCBidHJmc19pb19j
b250ZXh0ICpiaW9jKTsNCj4gIGludCBidHJmc19tYXBfYmxvY2soc3RydWN0IGJ0cmZzX2ZzX2lu
Zm8gKmZzX2luZm8sIGVudW0gYnRyZnNfbWFwX29wIG9wLA0KPiBAQCAtNzU5LDUgKzc2Nyw2IEBA
IGludCBidHJmc192ZXJpZnlfZGV2X2V4dGVudHMoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2lu
Zm8pOw0KPiAgYm9vbCBidHJmc19yZXBhaXJfb25lX3pvbmUoc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8sIHU2NCBsb2dpY2FsKTsNCj4gIA0KPiAgYm9vbCBidHJmc19waW5uZWRfYnlfc3dh
cGZpbGUoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIHZvaWQgKnB0cik7DQo+ICt1bnNp
Z25lZCBsb25nIGJ0cmZzX2NodW5rX2l0ZW1fc2l6ZShpbnQgbnVtX3N0cmlwZXMpOw0KDQpNYXli
ZSBJIGRvbid0IGhhdmUgZW5vdWdoIGNvZmZlZSB5ZXQsIGJ1dCB0aGF0IGNoYW5nZSBJIGRvbid0
IGdldC4gV2h5IGFyZSB5b3UNCmNyZWF0aW5nIGJvdGggYSAnc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIGJ0cmZzX2NodW5rX2l0ZW1fc2l6ZSgpJyBhbmQNCid1bnNpZ25lZCBsb25nIGJ0cmZz
X2NodW5rX2l0ZW1fc2l6ZSgpJyBpbiB2b2x1bWVzLmg/DQoNCg==
