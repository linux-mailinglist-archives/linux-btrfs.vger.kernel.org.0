Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944871A1C6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 17:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjFAPDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjFAPDe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 11:03:34 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F41FEF
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685631741; x=1717167741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fKpUNYgZcGN/1iar6Jjgq86Rg5bB3DufCMYg8O8oIJA=;
  b=PeJQ6c3YeN1cBzMaVtwiWTMoO7cHlsPWKp/9GHA4E2xVvX5NPxYTAEgM
   +dMOZEfYn9RbKaPOC0U2uhsupwq2ND/aoSkErWlleQ3jjY+5vCrREnbv8
   Gh0g9xYwq5miGRhdThJZ0t20NQ9IAuyYteIT3XCyfSHAoB6JhUULn2qbL
   kWM/E/efyGB/rArkAgLMeM5p05hx/FTZ5EzRfliNtiZ26u6ork670dsjP
   YYIz8NFQWKXOmwBtE+qQRr+sHWDns499wFJO+1CsX+vgCbT5j4sQA4n/N
   yI5bgJn0JsknxsQDcsVuYe59AKJnf20A72czhU56J6WUTzfpEz3Fp66Z1
   A==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; 
   d="scan'208";a="344294641"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 23:01:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs3RolCvWJ1oaeHTv+D2ac0cI9kpLgDSKD6/U8tWnS6uiDVtEqeqbJQMwSft+XeGHTbq6LwWOwNQrga4w3PI7A9ENOgF2dGlbTTYdN6xJWDeblGTuIEYdMNyajg3ecZvHACEGw0rD3fHfumJKGZx+hsqbL8oM0ESXJbis0hMF6Idef+x9M1EW3s/iqpplI6g+xHB8uFaqB8WLZKwjYeWAfVo4NEI/aA8m2ofzsw7ZRxBdy1ppncSj+X8IAV77QykOO3gTJRvm+Uq5Am4s8lHyBwQFGSrzt/SEM1dU5O9XkUkXR/6X6FXxGiHLXwetMxEhh/bVef/tkgPndKz91ZX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKpUNYgZcGN/1iar6Jjgq86Rg5bB3DufCMYg8O8oIJA=;
 b=PUtG0JcI9wPm+3tO5jFD9HTnJPLxHEEwSEdTOv6vn5sHJqYTxGn2JDqoNLprNccyXo8VoQbgk3b9j3h6cY4csvvSLw0o/QPsovkwHMqaK6tcT58eMm9nTzsNttDxpqMarqcQoHIASlcgWSO8YfctaCFVHnBWTfY8SKUrNpd8AkLxcFeSupTGc+h3MbRWWHRrT7DptKbVlttuYHQdL+W2MtPIGvfmJvvM00MHxbYwzHXQ7Ta6FvRqgJCaSLMMG4IskUutyDq3z71v4PdnXi7KIkhCzTnF9SfrTkR9S+K1zAnbUayPymsC82aJFAIrrzWfnDVw3bKS000LZBEtGqqIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKpUNYgZcGN/1iar6Jjgq86Rg5bB3DufCMYg8O8oIJA=;
 b=a7um4HqxqpgTrMGZyXqMvlBzdfZkXOWeYVYFnqTb5oadkU/KOfoM9znfyLK1FlvPUHeUACK7yPvCfmMltujp66JsIQINaZYIhx62NN9gO+ATSSly488d1hl3UTfl0QHplE7MCJW6kjQmD04ghZJjk1Q4jFA60lN8b5sXYR9fzpM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7953.namprd04.prod.outlook.com (2603:10b6:610:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 15:01:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 15:01:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: fix dev-replace after the scrub rework
Thread-Topic: [PATCH v2] btrfs: fix dev-replace after the scrub rework
Thread-Index: AQHZlHca85P/wDKWgkG57IJZHrudVq917EyAgAAemIA=
Date:   Thu, 1 Jun 2023 15:01:15 +0000
Message-ID: <137a6f53-1832-e14b-592c-45026fb370af@wdc.com>
References: <61e46bae045ec4e5173874dc81cb178e456644ab.1685616199.git.wqu@suse.com>
 <20230601131145.GI32581@twin.jikos.cz>
In-Reply-To: <20230601131145.GI32581@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7953:EE_
x-ms-office365-filtering-correlation-id: 0d097aa7-d92d-4863-25d0-08db62b10c67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lH9QUZeZzRCzMS+J0gl5EQgTm6Q8vy+9VsnpIq47zPHzaz91Q3WWukwYS1WH9hzWqnnVB8guLGcbTYfmhyeCLZmeZ0KN1PGSZM8osYaD9enNr8Cnr1+2obTNs75Y14MaM3jV5FZSgN8nRHi4nj8Ra06skvVdn+5X/L75A8FSQ1fxs8/Z4o5YjWwgeXUFXMp4rcT0KRacNpY+J9/hVzRT3H6tQD1BvDDC1bZkoWr7e/TthNKkbpx/ZW50EjW7Pw31zbk4olJp5PEaP4a9Qe9HHXQx+VEdZaTATS5YwaCMYG/6u2CgvEKEVNWCQ7r5XKKMHYXqxz/kpCWDv4CBsR1o2i0JJJEWZgJqtzwNaF03967RiDObwOaTvyHLjw85hPn10A6lyR6ucLT20pUt0lfGQsQTQGPpMqkwhL7lOmbFBhnaQp6LBs6wQt39IjFszwlO90Da/xvzMPb0XTFLGJDiUeF+A+l7dXbSqTdTl0DEqJ+C+Vt5tvjlDoGU6O+1b+9lm7FTUurZie7EZkZIHKhBbzIm6Z+iqFrrvBgmFVpq8wbojsI9ID6HQ8t/OoFYFSta10McRJ1i8s/D1xgpEWetwr/cDte0VwiEdv1CzC2T5n6wS0+RoXD5UoNxzxz8WUuBiNSA7e9uRLrvGMmnh8iB7NaKrIfXZLTDuWj39tg8Pt/i1kTnqgQ9BejxTubCh3o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(86362001)(31696002)(38070700005)(5660300002)(8936002)(31686004)(8676002)(2906002)(4326008)(38100700002)(122000001)(316002)(76116006)(82960400001)(64756008)(66446008)(66476007)(66946007)(66556008)(110136005)(91956017)(54906003)(558084003)(478600001)(71200400001)(41300700001)(6506007)(6512007)(26005)(53546011)(2616005)(83380400001)(6486002)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhCbjRwRDBOVk81K2R3NXBLZytDTlBxUUQrMnQ1QThyK3NzQnc3bjhXZk1y?=
 =?utf-8?B?OFY5UHAzbFZVdTY0RFVtQ0xId1pWamo4REQ1S3RjV0VDUVIvN1dxOW9yak5o?=
 =?utf-8?B?V0JmSys5RDFyeC85b3dyVmFINHVQQ2dzSXZFQkNaWnpoK2FycFRGbDE1RGV5?=
 =?utf-8?B?YXhGR0NHbDh6bUJFZWNuUDd4YzJ0MDF0a0hFeEY2NGcxTytyK3VySWhmb0hk?=
 =?utf-8?B?cFpBRnVuU1EzUEo1ZTdrdU1JWXhHZGhyM25YbEpiYTZ3dUl0R21sYjJ0aTI0?=
 =?utf-8?B?ckp1Vk0vbkRkcDA1WktHMm13ZDA2MXd1Mkh6M01hTlBWc0dWL2RxczhDRE12?=
 =?utf-8?B?ZENQTS9oNjZlVXRHbXhBS3pXcy9ScTZqUUNqd1VXa1RoNUgyN1VZeUZSZDJl?=
 =?utf-8?B?N0RYT3ZNdmJtcDMzOWRMdUlMWlY0Y0w4dUwwRGorRmNvVEtqaGp4OGFSZ3Jh?=
 =?utf-8?B?aUdHM3czSXlvbTZCaUNrWld2U0kwQ2kvSlhpcDI3M1pTeC9LczJ1KytpQWhC?=
 =?utf-8?B?Q1BsbW92K1o5am9Nak5GMi9pWEdNVVpHbkFFc1R2T1VtVi9oVndQQmltUnh4?=
 =?utf-8?B?akVCQTlnRy8vbVZDUTVOWDdLY0djWnFkZmRqWDJJZHVOVnhkdEh1aENGclcr?=
 =?utf-8?B?cW94VHN4eUt5Qk9lMlRzSENSRWt6NFE5dUJkck1Wd1p1VHhpK0lCUEFZVTZp?=
 =?utf-8?B?SzRIczVSSUJDZi9mTEVBU09RMXo4UjJjeHFLM0s1NGJiaWRoOWpxdmZ2QjEr?=
 =?utf-8?B?bDQ3T3JxVzJBZzZiU0owdy9PTzM5YlhVeVpwMU5JSTFaVjZSTVZILzlkTm9n?=
 =?utf-8?B?QzVsR1U3ZDNseHpuNm04SzFDbFV2OEJSTVUybHpia3JXeHVBV0pmNEJEVDU3?=
 =?utf-8?B?MWl3eVlEaUJxOWhYZHQ3ZWRYVHozM3BlS3poRWJvYjdSNXRaUC9CUktPejRZ?=
 =?utf-8?B?bGs2RThiNDIreEE0THFWWHBuUjR0K2lYUW90TlBhWGpwZXhvUmhjd3gvSjVj?=
 =?utf-8?B?aHJZZWdmaWpSQzRtTWErMEtCeGNTWDVsNEd0a3VoWTFaMERrQUFuYVE4TWFO?=
 =?utf-8?B?R3puYmRNc3Y3VWhiNDNEOEdCMFZINE1jY1ZKdndXRnFUTGkxUXV6OHVEKzZY?=
 =?utf-8?B?REY5cGErZmV3UEdFVnVCV2lBcW41NHIvclFpZzc4SFlva0xudGw5TXRmS2tR?=
 =?utf-8?B?SGpmMFEwNy9adzN2ZVdLa2cxanV0V1hZL3pOclA0UldJbHBOYkxhNnJMNnJj?=
 =?utf-8?B?MkFNbThWNE83MnpTQ1Z0RituMzNWZVZzd1pNSHZiczlDYnZpMFlDSFI5ZTB1?=
 =?utf-8?B?REJON3dhMlRZa0dWZUhYNW9Zd0daOFJFeWFOSjlxRUM0d2NVcDRadUJlZGNB?=
 =?utf-8?B?RXpMcE1maTNCWjhBT1N3VjJTU1BnUUpUZFBiN0tTREVxSWhFOWd0NWVsd2s2?=
 =?utf-8?B?RVNmT2lzcW1ZSWpkT2ZIS29kMzlSNjRxdzFSbGsyV1l0c0I5Y1RscnlqRncz?=
 =?utf-8?B?Q0tYUVlEVU1yYnBNK0FUZWFrdm9xaURTcXRibGhTRjIwSVVwZ1F5SlR1ZTdN?=
 =?utf-8?B?QzBaK1M1a2IzWVFieHlxZXFLMzlPSmZwaUFFdGlaV1dDejZXdCt4UUxLUkZ1?=
 =?utf-8?B?N0FPa2tGWUlOQUVOMG9Za0dHbHZBM1ZNQlhnUFRRNkh3dktKTUhONGprNnlM?=
 =?utf-8?B?UFNDNEh1bldMZndKM3YrRDczaVFZR1FuQnFRN1NldHR4YTN0QTdlV0NaSitv?=
 =?utf-8?B?OWNzNHRRdFpFWE15QXNZSjZNLytWZjB5WHNkcllmU1R5OGVza0FEQWxOODBW?=
 =?utf-8?B?R0NmY3VRS0FpcmwzbVV5eDFYd0l6WXUrVWViN1IveURsdXVSUXllNlEvdkpP?=
 =?utf-8?B?RkdKbW9LN0VSUGIzVlM3bGtIT1JmY3F5TkpsRysyNDMwcEUwWmRDcjVtbE5T?=
 =?utf-8?B?bDIxdFVBeC9FTlZkeU5jTEVuYkhGVXdiNE5Bc2JDckRmR3YxTE9oYzkrdFJj?=
 =?utf-8?B?emM4RTdkY3hGbDUzL2tSVmJVZ0cyZnpWcDhMVDl3NkttNEk4K3F3NTFBY09y?=
 =?utf-8?B?VTRTUVFBODZabklLWkxDd2R5TUJMbmgxeXRWUmVQSGs5TDIzdDkwTlJuNHha?=
 =?utf-8?B?ZVZRalNHUzcxNFVBVnV5SUt1alRUS3IwL3d0Y2xyanU2Sjk5RzZjYTZzYXJB?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C033F750EB2A42839DF9862CF64A98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lKXSei9qysKfhzs8JVomPpl2ca+ILcUgeRwOA1vxlL0B+Z/2WAbr0+ElPELe2dKeP800nV0bJdh3rws9Iow6r6lErJuftMM6K/S2XBa2mZiypm2EA0dpEdZr2UqWSGWavs3kR4WWD90bNpUUW2pCy1ewolxhlFom0vzXD+wjebmArk/6WRUVvAoRGArZ0ToKiBNqxgqhKQIUGgNCQQrm16klBh2WdBT6Rt7xNNhxTwdEs4ta5adpwcRtTEbke/B5N6jc4Z2tpkCnwL1KgEJdG5dVuHXXtogQniKxiazWSjpVWDe6Unr3rfBYf/UAd79kUL+Ffoo9sv6i1EzHcn04vVyzl7gyEQ7c62Y5q3Y6ghoxXKZNaoWY+LrQ1/Gt2DDXp5Y1maXVJ2/3jRJ5cRxSyMkQKK0Wm4MRN8BloNX0/5o8/pOwNhugok69tIIiBlTdls67eT0z0hB93yzPrleK2lWwYIsiYDm2RuiO/VRR/U1Ualyboo+m2fd8YTWJipDDngj1d0PTGIsbIDF1dVe79VzM61Jx0QmpoR0sB2s0Snpz2/L4rwRwhP/OPuGmtz4BuT139HlhX6rhMP5rO6MvJ4KnqWXOGezMWsuCSPVWhwMN4yNqEv7AoFzPOBMv7Crfk56DqcTNTvNoM6/jA9j7pLmjIqbraM6bonk2qY4RbQiFvJTFKS8ub1QAW5v8yrKO5GX+z5VcdN/c/rrQCdfbn1+6Anvasp1SSt3HbCSabhkP+Xx8oMdhn73UqwXHomZoXg2UcIqZrwXyye1cshZ3uzSm0XZ1TRFm030I8aUv3+sK/uHUeNHhrV96ZxtXFKzTIeUuRAGDoCI/YaPFzH4+uA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d097aa7-d92d-4863-25d0-08db62b10c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 15:01:15.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/b0caAiwFp14NSuWI8JWLjDLrOUr8KihAIzsxshSnvQ2rKjvDQCs1xfKRCvrPu1JNs2DaJONFLyTmVoK49tjRVkE418oXbOWwtUY96Zvgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7953
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDEuMDYuMjMgMTU6MTgsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gQWRkZWQgdG8gbWlzYy1u
ZXh0LCB0aGFua3MuIEl0IHRvb2sgNCAtcmNzIHRvIG5vdGljZSBicm9rZW4gem9uZWQNCj4gc2Ny
dWIvZGV2LXJlcGxhY2UuDQoNCldlbGwgdGhlIG9ubHkgb25lcyB0ZXN0aW5nIG11bHRpIGRldmlj
ZSB6b25lZCBhcmUgYXBwYXJlbnRseSBjaHJpc3RvcGgNCmFuZCBtZSBkdWUgdG8gdGhlIFJTVCB3
b3JrIGFuZCBteSBicmFuY2hlcyBuZXZlciBtYWRlIGl0IHRoYXQgZmFyIGluDQpmc3Rlc3RzIDpE
DQo=
