Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508F6BD6BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 18:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCPRLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPRLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 13:11:08 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5E968E8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678986663; x=1710522663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mHnXG4ak4YDXrXKwhcv7vh/Z0Xa9F7FKavN5XdOSLjMXwZF17+Hg7yy5
   Vw77lQWjoLR+mNawMOVf/lZOwT+n08a3QylD33x43uNU5lq9WlCqXwJzj
   NEnnbhy9HKHeoIu2Sf+W+5zWyf2WxCVr6ydWalC+FdjQuJTgYan0ArA8d
   C0Mnx0W3oEjPTkzCH4mbx3p5bf/h9DU+hGG7wa5Lr+1bThlJg/TIa2tse
   hnas5MVDNNZspArl35udkwHtcSLd0L/kJDvBdMx/8pN2EW9GxrE3UC60q
   n2GFJry4O9sHgME7QdZ0YPXGkIQOyqieVyzsw1lo2USCflxUrnkeXk3ZE
   g==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673884800"; 
   d="scan'208";a="224084431"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 01:11:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbcmZ+35rga5TekFfnO0ixdZNuypAxp5JXSKhvFpe6lnrV8ZsDYOMBRYqffWZL0NHycgCWO4DtzE5FPqQ8Std4R9o30Pij+7MD8iuk/BYbtWSOvemMfjCGlMzDhF7g7Z6eV7tHlgoeYcXPF29USCRXvrNoQbH3gBmxCbkbroGVF2HxhrnLIM8qNhtf/KzEze6dHzztAnbM5GciTuocY6c5yTwF8y0gW9LRQgB1qF8MVanUhy4Vov4yNauuKy7lhokty+P1WlAjqBPPOZHJwUtXM2jvn+JqukeL/Ig2uroCuX68wIyojYrukIKqQYk2mq7y+JIcjXa+lUGirxUHidOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=c0fH0AcsEkRZRrn8iMtfKJBik12DSe1YWAbx2NNaWN+Jtii1wGZoqPB82FKIB407ONn1eSwUl5ldEvajYJjuQTbtAVcksw6j0X6yBZabED6zLcqSFW014gHTwquZTjClw8CdhigBQN0wypjd+FEmRiqRej8RUrc78RO9nmqiTG4dZte+6tkqvKDX5NNpKq5KW0wJZ3BKMpksB4GFXpBnBpzdarbLYz+MNTWjK1++dDudq1alul4YRZl/h7D0MOyqBueUQlx3S7nfwKJX/2d4kYXDS8xGKjmKEz8Nlhn9U/owpRzZQTb4ROPW8qsbqCTa8biWjCCgV3pPc4M0DYr9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ROzxrbOnimCUJi5RuueVX3H2fH7Q+L6aWVXmsQC5QUllvCh9GLVl1EKoWqr1EVLQJhbZCYvgQxO/aHo28Az0ZkeHsaw2E+cOlzDyJqJpm/fK5RygRxV41ZwGTOZDPio9ZB8gVL4UO3ww0BVr2m7cQJOnnjQoCB/ZFRev09mHN3c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6968.namprd04.prod.outlook.com (2603:10b6:610:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 17:10:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 17:10:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Thread-Topic: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent
 processing
Thread-Index: AQHZVpZie8QzlCJBs0K6Vv6FXEQuLa79p1+A
Date:   Thu, 16 Mar 2023 17:10:58 +0000
Message-ID: <73749609-d979-e978-18cb-86e5252468c2@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-2-hch@lst.de>
In-Reply-To: <20230314165910.373347-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6968:EE_
x-ms-office365-filtering-correlation-id: 6c39cd27-d89d-4d10-bcf6-08db26416984
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aiz+DHfH6a4njvz/tMoI7zSA4tP8fCelcWCCtg3Q3ugZ32fr6HtRijd925OXngOIFsM5VjuhEFh/E13Hdu7wlThdg7fNTmbcWsAcwzYKhJmQumr04+QIFNv2gqMC3sCNfuHvS1GvXh7B+fcj7mFw8DMSrx4VEpHOBByokrsyakEXISmVpWgbAJH+zX/4Z64hQaP/ye4j+oMFr3vvyJBRHRKIvvTnI8aWJST3LRggE4pNwgIsGEQJrUNG1WqTggrZVnL4vhPvPT4wtRE2HcOsGR0taWiYiT6WuKR4S1D+HxlB2ScZx/itOyEd6lN2CE5+yWC3K75dCcdccst4QCxcsQ13SaLswqr3ONDIyH8zGXU9vdVCznnvjCH/Vfq2FOk2gdviI4rEa/GyS5VGspzvt7yA4mi9FFhF5jyHAaSlzdql++FwBv591phHubzA/DgJQOySjiyi4WN0yEYjsbDL0vWBwXJk3YCyy5ESoviWubfCNuhKpAfqRyv9/wS/kTTECdt2wiboPj6j15R6rV+8oK18znPxDMfYbrpDGKf/xyYTv6x4TskMcw1CU89JwUcxtxluRmyxzWdvvhNciRbQt59+Yq4+GCqaMaj1zGG5en5oNXvFUk81kDIf+hXvpvib6tvWeZmWw8INqXM6D0qVTR/Hv+oIBUkB2hPhwDse2jDUkMHMvcH8eWOvaEGZXpeIvNxfpnQIoKtQwOIR096u9sCzPSv926hnpPhferV62xdKA2Ona9Lp3/UgmEPyWXyUMJK/cClL+dQKbfDKBM6h4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(36756003)(76116006)(91956017)(66446008)(71200400001)(66556008)(66476007)(8676002)(64756008)(66946007)(4326008)(19618925003)(38100700002)(122000001)(82960400001)(38070700005)(2616005)(2906002)(558084003)(41300700001)(6486002)(31696002)(4270600006)(8936002)(186003)(6506007)(5660300002)(86362001)(6512007)(110136005)(54906003)(316002)(31686004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjdudmxNUTlFR2hVNVNid0RvY0hlQlAzV1VyakZPNFNlWFplcmFwZjg4TFlO?=
 =?utf-8?B?UzYyYWVGVVZ1L1VtS2hxdnQyd2VNSDBHVkp4bTJIaW0xcFJSM3JWYTBqbUxs?=
 =?utf-8?B?bHkwajZKcXdONjM2K2ZrSU1PVnl5Z2l2RXl1dWhpZlk1RTBQYmRpcDBHT1Rm?=
 =?utf-8?B?RTAzUCtjNjNxUGx0Z25mMVlhWmZYYUx0TGViM1FtbmNEVnJudHJ1Y2d5ZGYw?=
 =?utf-8?B?YlUxY1FzbUo1am1iL1Y1K3NnVWdOVUxFcXBaSWZqR2ZlalZlTDBYYzM0UWVq?=
 =?utf-8?B?YjBiTWlFQUR1NXBHZlB6MmxVeUFHREF0VXhuUTd0LzY3WVJPdDlxaFFxVmsy?=
 =?utf-8?B?ZnluTWNSR3IxcEdxMWRHYUduTzZETVo4eGpnbGQvdXF4b09YYUcyUVlOQ3FE?=
 =?utf-8?B?dzhNalNXWDRsK3BiaUtDaTVMSEd0TzdlSk92cnY1R3RpejRZcFFCQTlrUGtW?=
 =?utf-8?B?MWJHUHc5YmU0U1N1RithU1JWZlJFY05iUmx5RFQ4WFVhUVZuc1NoREVpWUVC?=
 =?utf-8?B?d1RaS0lmTm9rVFlINkhpQ0JITmR1Yk9ua0hqQ29TZXpwQkhQOExtcElPUWZX?=
 =?utf-8?B?L3lSalB3QlNZajVUV3JxL0NQWmNROEZ4VzY5d056KzBEUEdETGpWaGhEaXUx?=
 =?utf-8?B?V2JSWW5VN3ZiRTMwUWlFb2ZJNmxJOHNMeFpTK245QnJiNzhxenBWd2NkdVFt?=
 =?utf-8?B?WE9ReDViUEtXNnRWd0VnWUN4QitXQWVNbmZUM3hnaTNPZFZvd3pFT3I5WXNo?=
 =?utf-8?B?dkhXOEdxdVRlZDh6V21CMkRiT1pvU3dSMlozQnc4ajZIWGZRY1Q4Q0lVbzVZ?=
 =?utf-8?B?TmJoL01IRDVMM3Z2YkRRSXcvVmhPQ3dyWjRVTkx4Sjc5aVZmc1RQMnRwSXh5?=
 =?utf-8?B?UkdKZ2JrUTNNd2xZY3JxblFMdDc4TFh3a2p3dDYwQXlqQndyeHhveDlmcHlE?=
 =?utf-8?B?WmZvNGJGVjkvL2ZocWJQWmdaK1psV1FSci9ZYno4a3VERmUycUlSMmJ4VFRl?=
 =?utf-8?B?SXlLdnhheWNOb0pKY0xKTFRUTTZvT3BJQnZPNzc4Y3huQ2tTMTZPeG9FVmpy?=
 =?utf-8?B?T1hWWHhlZlR4K3lXME5NNlNuQXNwNFJBdTRDU2FXSllhOUk1NEIycVI2U2Fi?=
 =?utf-8?B?Qkc3a1FVTEc2NWlBVU0rVFQzeTMrRUxMRVBxMUV1cHBpdHRNcGhtL2x6bzNQ?=
 =?utf-8?B?U3pWajNaSi9iRGs0dVg2MVNqN0o5dXkwTHNjTytvSS9FMk0vTzRwcHJ5bnM1?=
 =?utf-8?B?WC9LZklXMDhSVDBIWkZJRGFqM0dCZmlaTStEQ28yMnRXc3NXdEJ1SHAxNVJp?=
 =?utf-8?B?T2NiYThNQmFESlFCcnJaSHhPTEFuYy8xa0hxME9ZUERzTVVYekowTDFRM3E1?=
 =?utf-8?B?bnJmQXBMWi84Z1A1bCswRnRGUjR6dG5YdDdnaFNPR2gwLzVjdTJJNEdVc3hD?=
 =?utf-8?B?L0dVTDZ4c2RFNjJGcmVoaThyWjVLWFFud2d3MEUxWGxWYzhuekZ0ZW9KS2hT?=
 =?utf-8?B?S0JYTk8weHhhN1EyZnpwcFdPc3dxZGdvK04ydG42czRGa1o5SzNEQytMM04v?=
 =?utf-8?B?VWp0NkRHZGttbjVDVVFzZnlQbDgrZjZZWlRYTkZNWlEzR1dNU3ozNzhHRkJh?=
 =?utf-8?B?L0xudlRsN1o1ZUx5cG91aEF2VTZnNm9rMTFCLzNxUDU5dzVpTFZqejNtTkp2?=
 =?utf-8?B?RFdSb3hvY3pZQnRQNTRKWGJwd1kzcTZYQ0dGN1NEOEFZc2dIaDMvSi82Zk1Q?=
 =?utf-8?B?SEY1WmsyMDI1T2RUOXQ1WUtHUThPVEU5ZXpVd0lJUm42ZWZZS2grQVFIK2Fl?=
 =?utf-8?B?ZHp2NUZMdGlUdk15YitOVTloQkUzWkhhR25pWncvbDljbVlhSjVBb05wZ3pQ?=
 =?utf-8?B?RElyOW1QRVRoOEVwZENVWnNoYTBqNklnTG5hdVZ0aWh6NzkrSVA3S2w1UWl3?=
 =?utf-8?B?NVVsUFU4SEFheXU4YmpkQXZYWjBjREY1eEVZSkxkTHFZN2FQclVRWUszWTl0?=
 =?utf-8?B?bEpmMDYwRmR6Yk8vQVpCY3o0Y2p0ZHlYWllHV01GMkVBVVFnS1dCRlAzTWNK?=
 =?utf-8?B?M2U5bmZ6eWdoaXBwMHlYbzBxd2R4ZFB5TTJjR2dtd1NqYzQ3eFM2U3ZudFZW?=
 =?utf-8?B?MXdDNjNLUktmMnpjZSs4ZzUzYVptYUwxeFRNaUk5ZDI1UitERm1xbUtDbTYz?=
 =?utf-8?B?eG9MLzV4WUNSTHZrRG0vU2QrSGVFZU9FY2xscXRmOXNlenVvcGlEM1lSb1lN?=
 =?utf-8?Q?HR2x4/22gazX1oTNUKzgkL9bhW4EC54WhOG+4g9MdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A887C4C2E979047ABF59FF7CE693BF0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aDkE7AIscLVP3UBttm8D6E//M3J19qGoOq9VP4bXt6WpbngyiAHT/nxdgv0DlMnvwHvTIbLWzAdyvG8ZTMqOKhMzMrKEjlowV+6xlUEcGFB3kEUpassuMSjuClwijXI3PgeveVMrhPIBDi/rGfvpaltDod/CcHVrybICtA5AsN9EYxuAc3CaaFVftXVxmv0mF3h6zVZ4K/nzDn6N0OiCAkb5AV7H/Byi2czjfoek6nUVan+2rPywjjWX/Kwr34Kr9hnjWKeZXCE7sRg1AG4PkoIWxHLGd1ZYUhMjsVOh95p/MWirebLmc9Ph3RbGF5GnCMJE2CB8vns7Ddzhlhv5RNTS0uioJeQ4DpjOyAC56mrmvylZbahNnVd2OV7/N2RN5sc28FwSGybpB3kWlObXxefkOrdGtRxnCL6fykD0JxWnRgLAPPiIu1exUvWRg7JklQ9WfoT5Gwcr5/Cp+ReGP80J572tvKpSXjsnUb+LKZQiu/16sn9f9eimZQry/6BfNXj4umFoFVpej2ZjFr6le1Ks7Qep/N1mVgdysDgGo8TFZA0e4lcajpGPSyVAXecsO1QGWoJ6HCpdFGM1dqld8WZ80bW7HNoKCNxLCsiNBcPaFEGwyJXQQTkn/8h9o+VYD+8O/BBQvRpfXQRezeVbz5bC1l1vve1KMe0O9IUhk7oC5Ln0QyJxvxkNB+MHBMNwsadPYGm27opkQILkDr050+YMk1sQny/JiTDG5u8TV5Y7ozj19+D968+18hZFvPI+Y02iTZ0Q0v4qbcFgVaDkfbKuKT8RTkj9TLMhOXRd9DroOLL9t8kMlT29sVQGmS5dnwyCHhX1QZcqohU4ydepuvpTRVJptdLwvJlPQZ7BeQzLuNcSqZhV5e2KBdguZ7cD0omOhPj/ynTLhzo6EWRcCGOXCtTgNFCSNmOyVkicjIs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c39cd27-d89d-4d10-bcf6-08db26416984
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 17:10:58.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UURlcnSD8wfrXQzwxvbdOEKNutFDt6S6wnILspOAU8W9sA2BF4F6PJeHCBZAq+40zKhjFALzK3qXFhLWQEuPpFUBxB99plw/lp3X03EaIQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6968
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
