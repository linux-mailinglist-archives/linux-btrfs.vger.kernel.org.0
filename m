Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8E69E11C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjBUNOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 08:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjBUNOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 08:14:52 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA49628D2D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676985288; x=1708521288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WMa1vLLzO6eJZylOSOjQnhwVU1/sOKFCBfd6t+6izcQ=;
  b=mmLzLF9RXCp3SsGASc7CraLtaxpnuBQC9fCEh1B1lSo+u4Vgc0IKJalb
   fMoBLBmHyOq8bbG35aUJbaqiZaW0iXBGWKFmC4zbnJYJNUj1DjxTaFVS/
   +36LdcoXO/2EgFSjq5bDcu0FmuRTgz5dplaAqqjgwzzAp3gM8GlFTAfU2
   KqvaA7M5rsLu4q9YsjOVDQxfH9RLVC7qBb+X8biYVWvi7B/96aWekfMTX
   f33Yl0tw3N82OS1KcXLYHikTB/gLCeohTl0y+DLpZyas20q0bFgl8+He0
   58cefpbACPXcZ5sRhQnSXXxILPOa6OXrctbDKfbyvuLQRpSb5zjVNlDZi
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="335782321"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2023 21:14:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcVOEXdpmDkc8aL3E+T34lRrZj4AKgQBi6lI4GUqn987Gepsvj7tgk4WOfbXDn2OJpaLNm9JnySR5l3l0VGiGSrkDzhEG4AF/4ZUkKC9vGZbD7J7bGBz+8LnY2J4sp8ngFOZasSLfLbzNGoN3pBdhLOp6zomWpjThIJS6R2Sfw9bTI/fLdth9Fbds+xiRW4cMg9y7phWl5AjjM02gOxS+17MyU2xjU/Xze/kI0g7nGR935zpQQS0rychH0TkdeWDdf2HMGwePbL6MRUzi0UOmnI9o6dRo4jPQRAj0MlKNO6av6Xy2nUDRyRcR3WczKUMlANoZI0Thr2tvJEMMPNAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMa1vLLzO6eJZylOSOjQnhwVU1/sOKFCBfd6t+6izcQ=;
 b=AXq7fjxWRshiY83SoKifIidrL87LiLI7aiC0qKXEXs+B6vr5L9mWmr6KlMWNzY7qe+z1mRqsE51DvHW29GpOUJv84KZLFnQSoLheoPf12GkYvGWH9bBnPEVcdUvNpV1pceouaz7b5iSFdYL7xf9lveQaRSFQ7IV0KIaUqTXteEG2uRlefLqV4zdzdlLHHbq26qyEVzCkOL+X7lwRb9fYl0Hpvrv+3VzAyo/4i4u6C96+QXfuxkwm6BFYs1iyuyCPbewdetp4gvh7BX10YglhnFA54MKd3bk/fNmA/ChN2yfnYRHXTUbFUVrSpdpi17pN7rs/AQfY6K7Y9KE+M2SR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMa1vLLzO6eJZylOSOjQnhwVU1/sOKFCBfd6t+6izcQ=;
 b=vXxLv4rYyN5r50DEPeJX0qFr0SRn+p5TZENXsY9/+eaW6fF/bbQhSVe/XbL/+kU/dML8lQM+AFdJCON3TJTU7R+eyDFt5bS4C4w8tmlcMDsd0AR7lOuN+KzhVINMUNYivFVFHLqdvga8N5IAiarUr8PSMkIM7nwii6jP46sw8rQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0225.namprd04.prod.outlook.com (2603:10b6:300:a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 13:14:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:14:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/12] btrfs: simplify submit_extent_page
Thread-Topic: [PATCH 12/12] btrfs: simplify submit_extent_page
Thread-Index: AQHZQiSsW6aM8HnKPkqaySPcwYr+L67ZaKQA
Date:   Tue, 21 Feb 2023 13:14:44 +0000
Message-ID: <0af54f4b-34ff-3216-0503-51c8915b2aea@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-13-hch@lst.de>
In-Reply-To: <20230216163437.2370948-13-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0225:EE_
x-ms-office365-filtering-correlation-id: 270fb4e0-4db1-4425-1a99-08db140d99c7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MCiXGLV1hUHtLACpMsqnqSf+Ahb1a/WAmj+7SwD2mKU8GScFXEhfV6euctYo+gjw60qTKHB33Po576ygQnpHieilCNepqVWSJ3PRIT/eold19T4jteEq7eTwXYmZL45JC4oBM8ATE8UUE/Sj75x5T0JNRFwK4hxNp5sQydWtnAvPpz4lrszUb2Jt7LwM6UhxP91xqbecANfRybEBzk9S5Cp2t9cXoRH1ZRhJOmLyrBq+/4MkyN0EzzldHU+2yimYej31+hdtADPa2tlDYAfJDQn+o9nRL4PXmyPnB3wT03RMrs1uhVp+6NGS23fbhCEEVW+ePVhCJ4FvWWBD/9gVrBwBbrNq37vy86r+JAMgcQGipJE3yc/2hh3HKyfOrlrGxjXphFB7iQ+vEIu4SB1BYdxz9QRVTe1OgLhUoSvQfP9iuC+6KPWJm0kwae2dJSC8RqOYN7PZywmRlwdD+swNwsS5QryL2bNgx3/VxyHiHojhauH4rQusHz1Vi9L58DiaEmZf4NxPbp9i30sl3w3wmN0bR1oFhFPlzsm/HIpUtClMKcA74+JIb1RdXnaL1fiWz8dimXUQ7BDcpo4Kk+BetTlULJnexJpgAM3tiaUqcfLvcUnCBOfQ2+z9jDcL+onKhFrNgaz1of9JSN+d7kUD0EoNHZF0MJOfvuCAGBG7S5UeGF6dS7FGkbNg2eiq8sZBcSJpEwlnVKaeF7Bv0+d84ajTe5LhIaa0C0Y3ym9W/Hn54uO/2e+J1RiQTkD8SHgqYfAxPZxuIVSAwXn5NYDg0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199018)(38100700002)(2906002)(6512007)(26005)(186003)(41300700001)(38070700005)(122000001)(82960400001)(6506007)(53546011)(5660300002)(2616005)(31686004)(8936002)(558084003)(316002)(6486002)(66476007)(8676002)(76116006)(66446008)(66556008)(66946007)(4326008)(64756008)(31696002)(478600001)(86362001)(91956017)(36756003)(110136005)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTlvdUJodGtRL25TT0dzZTdwUVVraFJPS003dzdKZ3lkTlZxNEpDZ1JPWnMx?=
 =?utf-8?B?ZC9xRkNhWjFVL21KcFNtWSsxVm1TbUFIM2o0QXZBd0N0cU51YXlVQitjMUUx?=
 =?utf-8?B?Y0x3a0prWVNUaGlRajkzV0JndlhHQklWMWtid2orME9mYmw2S0p3b3pud3Vv?=
 =?utf-8?B?bzFwa1hOdFFwR21seHk2R1ZEZnZlQm1KMGZFRi9LMS9ucUowMVlrbzRZQ1ov?=
 =?utf-8?B?YXVWVEEvN2I0UTJ5RWhNaXhUSVlDRmJnWGpzempHbGVuZzViTnVqajh1R013?=
 =?utf-8?B?NWh3ZVhTRUp3azVuZnNaUDZwOVZNM3FucWwwcWtidUFnRE0zdW40ZnFJbXRH?=
 =?utf-8?B?UXdDYVU4b0crYmVERE0wb1VmOWdWSWRKOVlkNmF2UURSbDJkd1VGSmZDWXJ1?=
 =?utf-8?B?Z3ZOUHRCblY0SkRYZnNZakZxZDRMaTNQMm1uMWZ3K0lhTnhrZzhXZEJPeHNY?=
 =?utf-8?B?WEFhVEtCNktIQW9UQ1grb3REV0tQdUVlbVQwa3NKZkRJWFJxSWFpcVpDb0Rp?=
 =?utf-8?B?YmNZMnRlbG05K1ZOSzlXTUZkandaRUkyS2FSQVFrZWROYTlYZFhQUUJkTG1X?=
 =?utf-8?B?eVFBSm04TUI2SGhNWE1vZXEyNkZkUW16N01IcWFPM3V6em5IaWFaQTV4Rkti?=
 =?utf-8?B?eCtLbDRwa1BxWkJPWHc0bElJaE1ic1dsdVNIQS8xakNaQkpIQk1SclNKeTQ0?=
 =?utf-8?B?bitkakNhekZCMld4S2hIK1FoaDRFeGJ4VWZ4MzJObXNnZmZrcGlJVzhJMGgy?=
 =?utf-8?B?YTVBNWczN2I1WnMwZkJxeFNLSEJteHJ4dWtqbnA5N2xEQ0pDZ1lmWkZLN1hm?=
 =?utf-8?B?WUNsbjdLQzVrQm9pOEozaWVoVHE4Nnd5anhsV2puVzJCK0U2QnZ6Mnhhd1hG?=
 =?utf-8?B?QUJQdXc4eFpZQ3ZVRGpwTnlIc1c1TXdRNzM3cHpMcXQyVElzcDVyNkR2ZC9s?=
 =?utf-8?B?cFpLV2oyTUM3UWxGc2pFNm9GNnI5VGhsbXQ2Y3RNbmJCaFhRU3NQb2NQODNw?=
 =?utf-8?B?TmxYdFZYMXhEdGtTUkZNVjVaUkZyRE8xcHdvVElmMzNWSXRlNkVPWUJzSXlv?=
 =?utf-8?B?SnFoVjAzbk1JeEk1MmJGbXQ2T1JaQy9NTWxmWGpCMDI3ZGk2VzBtRnY3VEJ4?=
 =?utf-8?B?YXBUTVJoUTlWcHVpcnVKSzZaK3pVRWhOaVYyQWZkVE1xOHFUbVkvMmFmTmZx?=
 =?utf-8?B?Nk9zNDhoa0FEOXJ1UEJuU04rNS93UkZYb2pxbmlMUWJJSSthVUg0b3YxN3pj?=
 =?utf-8?B?S1dDbDhyb2hnbTFhQ3B5cUdwOUlHdXN1WTBqVUNIMi9KS1Q0WlRndHh4MnZJ?=
 =?utf-8?B?SVVQY3d2Qk4yVDV4MVorc3dZU25Bd1h1Yms3NjhJejdjMUo2aGFqRHZTRDhl?=
 =?utf-8?B?cmxBZk5ZMUZURFRVYThaU0ZXK29iZnpaQkRla3RyK1pSeGVmdGNncHVpb1FN?=
 =?utf-8?B?cE9yVFhEZ0R6d0RIa1k2KzJZOHdnVXk1K2UzL09CNnJLRGJjSGVnVGJXTzJB?=
 =?utf-8?B?bVBveTVUaUxPRE1ySllRZ2NMZlNlc2d5TW5NNFh0L2V0eVFIMFhkVEx0S0ky?=
 =?utf-8?B?QUxYcllTcWZ0MHB4OFZzS1VKZVp3cG1HcW15WjFTbjBRVHMxWWVTV25HelVq?=
 =?utf-8?B?WnVDbmRlcktqRU05RHQvYW1PYXMwb3dWdW5hazdaaG5HMDk2YjhJcEtVOHpY?=
 =?utf-8?B?amxycWkvRVVIdTBSYlBoTGZ1QVYyVjhXMm1lVUI5UDk3T1dPRGFPbG56NTI0?=
 =?utf-8?B?azhlKzVIOURvZkpwa2JkQkI0dXA4NzJxQi8veHUyRFJqWDJtZW1YYUFYaUhv?=
 =?utf-8?B?NzhlWGt0WWE0a0x4UGJOUmdnUXprc29aYmtpNzFudkJhOVYvWTZDQlByaS9t?=
 =?utf-8?B?RGFkU2Y0bHlMODhjQzMzTWUxMXNBWlBDVXZnSjBCUW9mY1NkTm5WbHNVY0hp?=
 =?utf-8?B?OWppbkcvYjNrb3JZcmJUcTlsMHpUTWlUZGE4T0h4TFRpa2JTMzBCQmZ2aHlx?=
 =?utf-8?B?aTZ0OTJKelBFNll2WXQ4RGtBZTJ3dWdqbURLODdXM1Y0TVNIQnNFUnIrbWFV?=
 =?utf-8?B?TWpxNXRaMVdQMFUrMHpVTVlZNTNJaFc4ZWo5Y3BSQjN0VTZOaDRnQ0FFSTlB?=
 =?utf-8?B?ZlMwNS8zRUt4MjIxV0xZaU1LZUZjV1B0dXVaUVRrcTBEUUhNM014c3dOc2dW?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA3D923ABACBC4381E0F74F09BDCB4F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EYMbgigUhFbWKGLyJfjiaCwuv6RUY/sh1xPInp2CCxRHaQcH+zIK2KNTPC+Ir9fLHJKwdRj+cyGT64bF4Jiz8Toez8ICAKb7AJv/rKSyVHem3/AHyl+lhr9ZMAmYS0LMJx0pENZLmN8HnzQmDTtRzlH8l2TWeQD0dYZdFuDJzMLRUseqOpsP5YyQFqtm2Y55qUOyvUyoVpeioOD9k93m2gonV6eVGaU/P4TgY7ndzlIQBOdGUAqeLqpOn/jbSMBGhfZNVAsqKVweBWX7a01jkU7UICmWYmHxygHWXXbcTjpd7xzBXryiB7Mdr8KkgRCi2hQoIlYNXn9F/WLJ6LmWsS65MA91AF6Svq9o+pFbcwEaWOCV0QAgBtdF5BsZDPAAQTHiy+u+f8qqvJfpVBXetNEuQ/UiUylV3/urUUpdzJgLQmVLidyeKjFvCuhN8jYlE5SrBJMzww9FLpSCX1Eqj68zpsK6DcxAwdW/hl+LFx02ycOxUS6KvBEN1T4nl1zYenKMNQc3akTuLUTq/iFLZf3zXaOKFt5A78wDwtKmeefHqn8DCx0XQx2If95j4f2ZfvgWnXBKfDYfzjZepARAVl7dSxE7wVIZCd+a/T+BoVt0u64k3j/TphGJq+7Iaur9DV5/Pi3IxkAKaE89tGK6NX97ffBGkQ9kMSFF0vd0qdhO+sRFYvnnunr85Edzev0iZ23ds3+DYTbD9mKztRWURI+vlTxbruIEP4qN/NuGS/6Tx5BqouFyCdHm7lEYdFazz7XHCpvPTAIL5TxAOWd0KV77Yl6RhMvA3rN+1EHLtJMJYSfF4c/pWdbScu3oBouAtDqk9MPsDXVL+R33v58Q3pRHKSzDAwyj0I5nkLo3KFTbIjfGj4P1oSraTsxaDxR2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270fb4e0-4db1-4425-1a99-08db140d99c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 13:14:44.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DNOiqvDHrV9PVyksLwajnFwKWqqD3bEonYdmtopbYoVd+asKhU2zbbVhB9TAf61sarRVE4oGyMDY5PtDBRx+Tp9uYgYZBZwcPk2sSyVd+z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0225
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTYuMDIuMjMgMTc6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArDQo+ICsJCWlm
IChiaW9fYWRkX3BhZ2UoYmlvX2N0cmwtPmJpbywgcGFnZSwgbGVuLCBwZ19vZmZzZXQpICE9IGxl
bikgew0KPiArCQkJLyogYmlvIGZ1bGw6IG1vdmUgb24gdG8gYSBvbmUgKi8NCg0KICAgICAgICAg
ICAgICAgICAgICAgICAgICB0byBhICJuZXciIG9uZT8NCg0KPiAgCQkJc3VibWl0X29uZV9iaW8o
YmlvX2N0cmwpOw0KPiArCQkJY29udGludWU7DQoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
