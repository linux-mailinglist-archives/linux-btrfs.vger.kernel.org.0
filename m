Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D677A73D791
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 08:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjFZGIe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 02:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFZGIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 02:08:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09673FE;
        Sun, 25 Jun 2023 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687759711; x=1719295711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=X8HD7wRs6ZNgtxvjz3nzA+9Xbp8iQSnae3hEYmT5XGVDJNt2JUU4nwKZ
   YfmHYBQz3E3z5/lByEc75/cINeUgzSBZrxY33erVRavTEr8Ipufe10v/t
   KWFvFCIxq/x7qV0Fp+75AD/C301G3+lgrdOhkKh02sTloSmDcjp/uI0Sm
   Aphu15+dYAOERSbB2fZnt46tgcZFTd0LyeWz+N8cf5iy9ANUkHSdAHRvM
   sL/Ia5LP3iaXFg5UVITo5vLOjH2WWJ2PIYK9BbGdS9WndE76g5371TLVs
   G21MrvgkEY6+7nuJOwPm5bb48euKI5Uov+vB+ayd0wKCZbpslUtyOUOMU
   g==;
X-IronPort-AV: E=Sophos;i="6.01,158,1684771200"; 
   d="scan'208";a="236843948"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2023 14:08:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSeJ93ftlSIldwHlIft5AyunZIAfC7pTaf18FQJMABJQnQP9w7s9m2xq+i+mKMeVNclvb4zxdSbj+is5p6BVNRFEJ34jg4it/G+oeA6UYrkojSxWeLvDxm17yPbaIIHRnA9IEeeLKrzceWOjF1hJl3Y8nsbzCnkX5ORc5HyeZirptn4GPf5nmCttFwkyRRAl+8+sbwUlHnM2BN08nAWY2Z7Si49cSlvrWs3O14QmWmQhL/A9kuYm+uQYbnNc9DpCuClqf+iGod1bL/BbsA0TfCtOeEudn9p4FMlw4/Ywm0zmmXNLfbvuggWAALqIOwU/GsN/Gg1lMe3U58Fa4PbxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=iJj2xsbvBqQZumqU7/d8Q73SbJzomxZBjSjY1kc2FnIMHJNQ8/S6PcNcL8Www4lHpKS1im8FnvcE/mgN7GV2JZcpS7IKiWRhouKDfGeFVvliSv+YZkqdncv4Q2TqMwn2nfffp9wMGkv+gygutAI6gzp3GKIYlyxrg5X2kZxkXP6U+DlRKNI6qQ+DqkZeZ9B/bvsl0GVX4gDcIjOPhtnslA7vmABeE2o8SvXi1isJiU61mbHbbXX+AfUU1XCa7HNCGB2E2JGTKNAH4GYjPr6Fj21IuirdwV8cG+eg5LHCORBehdYls3SJyl8NEzYOiv8g6mcJZsjpQul/KA9WpLHXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OCJeQmwGGCA0d3XA/nPGKClBeeGS1MG3rraQVzRNzkQSc44J0785OYUIvKXssmb3Wt483kYBkEQntjI8sF6+/Nmlyc317dmfhu5I8MftkYUik4L4XhYPeO58xVe61sa3E42b9VSVCJf4mb0CAXK08cQSF4vO/gJJTtdilvWOxDU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6408.namprd04.prod.outlook.com (2603:10b6:a03:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 06:08:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 06:08:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, Chris Mason <clm@fb.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/26] btrfs: zoned: use array_size
Thread-Topic: [PATCH 12/26] btrfs: zoned: use array_size
Thread-Index: AQHZphizCN6K6BOXDUG2wzKVyK67Wq+cnQqA
Date:   Mon, 26 Jun 2023 06:08:25 +0000
Message-ID: <6a8354a4-bf7b-e3b2-3b86-bf19875842c4@wdc.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-13-Julia.Lawall@inria.fr>
In-Reply-To: <20230623211457.102544-13-Julia.Lawall@inria.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6408:EE_
x-ms-office365-filtering-correlation-id: c40d22f8-3202-4572-a210-08db760bc0d5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RMQ5H0K9VaUAy2LRjXCD3YpG1Y8A0v5TOZL04G0QP6mXYN191k2DbUCCJYftGis67YfbgtFYa4W8UnPuvpiEgmXun8pUdLyf/MPWz/TF+CEJHdaNg8m67/oNo11GkZXOxVs2UI/gMDcNDW96LKNuf1jrB1OXZZvo91Xdbxg8csP9vicNuLLMHussRtUw61W5XM6E53ParGWhil6arFdJjBC3CLmXyef/uJdUECtH3FIpfKxdNflJx14Cm7O7okOw9VuSPsOWlUwvnjPdu4irUHZMy6UcLSxdLqR9E8/EFHuoONan2ike57dN3dOOAOOrYIpq+b+F2LLGWMZMg222Fo9XR+vRTNUk66P/NXoteMBaON9yy3Hmpz5g+KU2egabib6DBrdpxrAuQKMD+WL57bI5bG7iAIT+LP2jDR0gBHquiVLX+DhGhXk4POUpfvrC+FuDzXPYWjPQNRz8fPH8eIcCw2iXxn3mCxbOof3novNU2kcsVe3fInrphGJ38A9nin5sdyW3uz5+4vOq1bOhgfQVbrcgEg0aDfyPzNRPwfaHzZjZVBdkRE+I+OqsDYcBVBI2If8MAXBbC8H2BcbDBWhejSv+AV7Q4K9TO9vG29qGBYE9vcdmQI3pUss/HWnQNFHpduBU1NCaMxG7CSj+E6S8mtH3IVufFuvk2l8ymSKtiQ6g5its1UVD6CtLlEnM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(451199021)(6512007)(31686004)(19618925003)(66946007)(66556008)(66476007)(66446008)(64756008)(316002)(76116006)(558084003)(4326008)(91956017)(478600001)(38070700005)(8936002)(36756003)(8676002)(5660300002)(2906002)(31696002)(86362001)(110136005)(54906003)(41300700001)(6486002)(186003)(6506007)(26005)(71200400001)(4270600006)(38100700002)(82960400001)(122000001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d243WUw2NDFvVHAvRjJVbHhyMVZQajhndllReVV2U0JOWFQ3QnJYKzFZUmdp?=
 =?utf-8?B?RE5tTnQyZTJ4U0FabHBmZlVVQnROalBSN2RwUzh4S2NRTGxFYW1oMHZVUGNO?=
 =?utf-8?B?UFgwTVNtam5OUGRDcHE0c29ubFZtOVhMVTd6cDJiZnk2SzdwVjMybjhsVGFF?=
 =?utf-8?B?RmxuRFBEY3Vjc01PQTYxWHhEK1BtSjc5LzEvTkhKNWZaSStKSGZXRU1WSmhL?=
 =?utf-8?B?MGdIK09yZUx2cWdKSFgzYnJaNHFJY3N3NDcreHoyY2V4Mnc0b2x2aUVINEw2?=
 =?utf-8?B?d3Qzc2lZNEFwaE91cUlqS1JmUUtvNUY1QXliZFZkUFQyTzk5WG8zU0lFSWMw?=
 =?utf-8?B?VWZjVlU2OUdoUHVKTkpNWnZqcFJZaUdxRE12ZVNIOVZ0V1IzK0xSSjg3NFFT?=
 =?utf-8?B?YTVhOHVMLzlmYmNOaXd5OXBtenFwTVk0eTRVVWEzY2lReTZzN2hrQkJOTlkz?=
 =?utf-8?B?WXIxUm5LNXpkZ1JTVWIxZDh0OFFHM29TVHlrWmJMM3lwbGRvc2R0d0Z1U2c1?=
 =?utf-8?B?Sk1CYVQyUkFObjA3eUFYOEFlK290K1Y3VEJHMG9JTFZ6d1NHWFlMQmRUSURX?=
 =?utf-8?B?b2dhVmlqMDNZNXJGZEZIQkwvanplcDRDVUYyQ01JaXRxRkhCSzd4SjhDU1Yr?=
 =?utf-8?B?VlRDTWFrZG9hQU01TEdRbE5KVnlXa0VhYzBMRkMxK2o1c3JlcFp6bWR3YTlK?=
 =?utf-8?B?RStCTU85UW9kc0dyMlBJZVZWbGdyeC9KV1g3Vkp4dnNhT0Irdk9pdnVKZGR4?=
 =?utf-8?B?U0JBZWI5NUF2YUdQNUhIVFpqRjFuc1hieitFZlduaTZnUzJhdEx4T0lFUkt3?=
 =?utf-8?B?RjVUUXVyc016N0wzNUZYNDBLUHg2dkhkMmdDQXd3ZFNaMkZ0UU05cmp5akd6?=
 =?utf-8?B?aHI4SWhSeXlCMk04TUd4THdOY3FscmV4Y3VsdXE0cnVwUUZGdHorRS8reUM3?=
 =?utf-8?B?aVdMK3Rza3RpckliSlUveGFkN1JVc0xML2dYUmMrbWt1ZjJiSHNwRlZMNS85?=
 =?utf-8?B?a05FNWVXaS9yanpwaCtxVC9OOUNpUFlmUG5JNDdnRXZ5MmR5MEMvZWE0VjM4?=
 =?utf-8?B?bkR6MXhXQ3JJVXFSKy9LVTBYVDR3U1R3ODlIeDFONG02SEpPUU5peDc3ak5R?=
 =?utf-8?B?Q0F0cWxVU1Z5aWtiZlhWV3RJcXFLVEFaTDdPdVFzU2pNcmw2em9ncGcrY0Iy?=
 =?utf-8?B?SG9qWXY1dWl6NURFcGtaNnFMUWUvMWl2K0NiRzlvZjBEbnJySjAxcVo3YTZs?=
 =?utf-8?B?NVF5bEVFUWpPeHd0MEJ2eWl3ZDAzQmFBdmFSakc0MWMwYnpnZ3JmRXk2cURp?=
 =?utf-8?B?TEtrakJ5WjRYQktLdUFiTzNKRHNGNGhlQjRXOVhvUEFUWldteGNBZVpFUitp?=
 =?utf-8?B?Yy9QY2N6YU9haEpDV21oa0FlYnE5cnFwd214cFZrd2JRdHB3d2ZlMXdBUlNN?=
 =?utf-8?B?QUVOKzl3MHZhUkNnT0hvZG0xdFNHMUxhSm04SDA3T2hMakpUblBEU3JueTFr?=
 =?utf-8?B?Ulg3Y01uTU1mdThjMzU4ZTB0S3RqaVJTLzRoNnNZRHlDZ0hNOEkxSnVxWlIw?=
 =?utf-8?B?YXVORW1uRFBhOWtWWjBZQnNtV3RTeGpFNExCSDBCVnpReGdBMDVPS09wU1Vm?=
 =?utf-8?B?d3BDYUFXelVFMVQ5R1FNZkM3aVJ5d2dkZ3VPanpXYi9sVG9IVzN3d3NRMGxC?=
 =?utf-8?B?ZnBVZ20vVk9yZjFoNmZhTkVYUnFUVjd5RjViczFDRkM5a2tQZVJTenRxWjY5?=
 =?utf-8?B?MkREa3FJbG5kNVFDcWdBYmVCakllM2ZLNkR5M1h6NTNvcm1QR2tER0R0WnVC?=
 =?utf-8?B?MmFKK1FNc29OZWdwN1RVM1NHeWUwM3FtcGJpOEJvYlUzZ1Q0VHNkVDdkQ25v?=
 =?utf-8?B?TGlNaVRHT213OWZoSGVFZ0tyK0VFWFFQeE0yaGVVQmYwTEVkUzRJL3hlazY4?=
 =?utf-8?B?WEhnTFNMN2tIOGdQcnVodnlCcExibzU3am5jWXMxR1JIYnBBUktZd1gwaWk4?=
 =?utf-8?B?bjY0LzNkc1pHRUtKQ2R3MmR0VkZ6Q01udm0wcWVRRWNYVFYzNStoamhOaWcr?=
 =?utf-8?B?SVFiblo2Ri9xa3hKSE1udXpsbG0wYmNyT29zVVlSTFVkbjFBZkxORGJRbGU3?=
 =?utf-8?B?aXdSR2dGc05jNEFnbFdldFVFRjM2Y25lblhwYjlQWFZoYnAxZEFqdlVnUDhp?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <545231263280F04F83F4EA821B14F408@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r7mwjPKCM9dKnRmIAd3+JlyZy4B1L5OjFTU3OqwejQjRC+a1nDW9/sjzPEv73VOqNszpPzZFXw7kCW4rN1Q6GtPEqHzhVsbr+gg3eiNXmlnZz1tlcv/pBr91au1G/p47yDB75AKX6+QdPiq23pLM5JHEvqtUtjgaH+yvMqUJ52nJGXTQrfwF+f6OQfIFUZdJ9YuQ8PJFVH5YMNFKSbHeu7uX1bmgkVhZ0W8UgHL/kb2uz6lr1FOKXAdBGeltLEREYQGmfle0lHbZNy281idm/9bivQndUzQbULakwuL77yqO9uxG8F9sShQHOxz2JeZZfhVAR2+u5DCxcG9Zs+1xY/LQyxKrZmyc98cxIlTi29AZ3HnEbWtgH4iPTznrKDsR4VWMWsxiIuHS1qKN4anpYHtRRFn5Pekzt+CatEeRR9VxEV+gUvloJztp81gvgICarQX/H4XMPZSZrmdomytbJp1YK0j0W42GACLCpX6bp400gPm+hZVJlGvmjtGMu+ROaMizmbJMyfsCa0Ea75ko0v69N8bASdimN1LwqvWXPM4gGR5YE9gH4LvyZmBW7YnpG+q/KvDY66kbWi+QBfutXZrQGbZm1ZRtINWUApcG2fo+qY8b5iUcz1ew5zMwwZnG28Bcnm0nOg4RHlDMoAV1296PWS5/EEBUFu/7Ly7tVyAzWHK16QusEDHfwsWvQQHF9CLKvL1un7eey13Rz2sKcVjowH0R3yE3RxT6iQ6MD8ytBejDobO+XHEK93eZQSaQ0E+sZ+GNmM5CDYLf5aTK80l3unaYFzaFF8rLQMGs3XJAlVr1gdI5SPa0V5nEIwC0F7gf53RiyhVVQdF1qZ2LgQ/xle7JdC8dR+M2r+46eAs44fFxUfJuOAI0lYDLKeNPUsMcsn0zxQL2owblvCdszjoPddlKTzUeHSRLi+fU6hI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40d22f8-3202-4572-a210-08db760bc0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 06:08:25.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g3RJVDQWguo+7U+WlWMHMecU1DYUhJwmy9+NijYKnDWSdKy3QCa43JgPVh9zvY+97NZtj44bolY38udJMCgFZ0HpDmXtojMnd/3TySysO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6408
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
