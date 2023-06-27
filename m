Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320D373F5E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 09:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjF0Hlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjF0Hlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 03:41:52 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F62E74
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 00:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687851710; x=1719387710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rutLSxaZ+hv7MHZ0U9CvsIvY2FB/0QAP2OvK3S7qlBxYSRVKnUA78uBl
   QtST72Ny5RflUSuAnALKHYKRzUucamqzaMrIVVfcDLgULgyS4CAETHRhE
   /L97Zf5sTb+5xuoL3BagSV4Taw/1fYckWDFPGzE7T1Q4fCkS9DIAqhACs
   tGi7GHcheCpGklWNtfGCnCelUuP1s+qnlLIcGn5IpHBJbLMYp4PiHkDaW
   9Kxgo0hM9QfYbe10dAN9H7uTtMmKJVE/n09byCoR9jUJ9hGGoe6uuE0dA
   mLZjVJ6kULKhDqWYXFncL3aw+3AH9ZKa1uQMNUYyQfCcf2v9pzRNBnUnZ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684771200"; 
   d="scan'208";a="236310399"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 15:41:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvAi1eYqja+3kMUjqSnZW99+qWZZvJLPW4y48bQywLF+AqNR7iruBb3JsvMFhm6m21Nz8zUy+HJhXlqjRK8lJhDIAVXGc45jbkz9LtpXo10e0bWCzOSSYeg4V0xZ7PqpSdtqzWWuLgizOiGD5NGbIegiyVkyqE3XP5UfVy4iQhwHWhbsdm9J4aHZOjlz91HT30NvL71kHy++qiognwUzRx1bq43bCC5E9q2r0tIAdXXkD1sEKwjeQy5Te+BwMDy6eGvBh8DM3Gs9yhnCjH4y/aJuAe/Gjam8OCeKY+RthnFP+DYshFnYcc1j/Ev8su2i0AZ6oLKoK7HnAzopaF9zDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=e+52+1XB5Eh/yG7zTUddlfy7Z/diVkqqM5vEgB2DpggR15JN96AWb5k3Rsugu7MHcxIoaTc2GhLhuvArbvWsoxEiJtsmeEiCc5t9mQKx7tibCo7llifUJAu8hKOiX3YFbFCowIRNq3v9AZ/Cx1MPOHi6/WDqWico5pX1XUXu0JA2/khTyw1l5VvFsZWfYXxxsjc0+zK0r9KciWn+ct69dXZmS5R6o1UM5wLFPJZeCv/19+HbhDc/p/w0U5bUrpiFXMN2sZvZPHMRhHaIzyKJHL0ZKXgOGGeeCM7KXRgAo32W/DmMh+2GqYAIZ5fCLoR1roDI8kW7JCSLw5f2OxkZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uB+zcWmOMUIihk+HBs9YYjYjOEXVfQiUxALivTuuJQ/xKes5uP05Zc4mJOUf7BspPu1B5t0vMD1AXFtUtUCW4artAwv7l0K0AeZ1boisxnjklp7j4MKxCF+NaKBJ2c2AKo7MgAYkRWeUl20IrTrSxzIbOyakDSfnfahrIy7ZJOc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8067.namprd04.prod.outlook.com (2603:10b6:610:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 07:41:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:41:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: simplify the no-bioc fast path condition in
 btrfs_map_block
Thread-Topic: [PATCH 2/2] btrfs: simplify the no-bioc fast path condition in
 btrfs_map_block
Thread-Index: AQHZqL6GTtZ82e9B0Uq+SE0/qiBuGK+eRCeA
Date:   Tue, 27 Jun 2023 07:41:46 +0000
Message-ID: <67a71d62-4184-251b-6ef5-c552adefbaf4@wdc.com>
References: <20230627061324.85216-1-hch@lst.de>
 <20230627061324.85216-3-hch@lst.de>
In-Reply-To: <20230627061324.85216-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8067:EE_
x-ms-office365-filtering-correlation-id: 534570bd-380c-4810-6f6b-08db76e1f56a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2SIX/Un4/qv1xG1KbHdKKBbe2ZnnyrkJbO674Fs4ft0Ira+rna0yLGwWl8ffUqhVL1sMheO96grbYi3JG0gcAOxC8rCLZN50vyzNFUs+ZG1Xr1HgUK6V5WQNU0eL0Zr4Rs0f8ORv3spjAFFWrwQ7WYBbvYgsagwCKXEm8F/pUt9xqBKcAT5xeBX9Ogi73T78dWGs7SMIXT1fmCnHKGuXgkBEsvQhVwzWfkNPocEW9SPI83UCFvKQUXc8/LsIzDBTS8ebMfDqglsqe+yxJneaS75svWhKpiZ50mtE5jCUqFQ2sBU2eZLskTSjy7GsiwLQzKSVaaa0q4Cw2tunw5f2+SfG90LmZ919ubaM8rt/vSsUayJie3LCfbzDvdYl6HLLfVg3EOfBa77hKos5eZcF1FgxRyJeeH/YBhQOWWgGgEixkaxgq9AqzRyYezEDvJBoZKxl4P/PoxZ1pdhueRHRewKBzeDJ731CxbyaLnZn9pWAc3sh18xn4ResybyrRejWjIv/qsfatgIiYOzqbmD1F3tsoZYjXw/MwAgMdMgkP+QEw+DkczPq5hsh/Boe814Phq77q2QKfgpdnr0J3le0zIfjEA9BDip+TZOpngFBeQ4YWelqXLr3U7gT0+MZZs+iJkxmuYh5TzMMjxi1OhgDLvYf3se2selAmERh8rA5X6POfc4e7jyO+yTHkntvQLz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(31686004)(2906002)(186003)(31696002)(38070700005)(558084003)(82960400001)(8676002)(36756003)(19618925003)(478600001)(110136005)(316002)(86362001)(6486002)(4326008)(122000001)(2616005)(38100700002)(4270600006)(71200400001)(41300700001)(91956017)(5660300002)(8936002)(66556008)(64756008)(66476007)(66946007)(66446008)(76116006)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2VmY0dWQ2w1aDFpM21EQVBOTm1nakh6MlBLQzdLN2FhNHBTUmlybEdSRnVa?=
 =?utf-8?B?MDNiSHZjNm9hVFFBM21oa0NCdWlXckxNUk81WVJDN2VOOEgwTEVEVFFNQ01Q?=
 =?utf-8?B?eDlZS0NueFVucDBpZUFoUlpuckhuYTVzOVdYRXZJSmZvR0Nqbms4ZSt3TkhF?=
 =?utf-8?B?Y0tTTjJSS2t6WWpURjRBdGkvSWpmbUFvWUdRU3pyS2NYWFlQZXI5MHNSdW5m?=
 =?utf-8?B?dUUxNXhXeW9sQTlJN3FPaTJ2dWptOUR1MllPWFhnb3JISUczWHhXYzFwMm1y?=
 =?utf-8?B?STJzVndkT2U1MGhCWE1heUU2RHJVaWRyMlJzN0pCWStoVGlHN3BYanp2Q29P?=
 =?utf-8?B?d2pMelJZa3M4bVFSekk1dDlYYUdkVVpTYVZIVnFDSktGSVk1eGNXdUJva2pN?=
 =?utf-8?B?cUlNWGtRTXhuSFArQlBDUUZmS1RwRnhmcGhUUXVLR0JZL09ialRJN0ZFcTJx?=
 =?utf-8?B?dWE3Zk1CTmt4WU9sVk5FYTRyUW9xVFhRQlYzZDFUdGpuaGVRenBZNDNET2hV?=
 =?utf-8?B?SUxIeERpZTNQQ2RnbEt3SlFwRm5xNlhkYjcwaGdqNkxIMTlNNXliL0dqVk9I?=
 =?utf-8?B?MjBMa0VFVDgyL25yVVludVRqaDRJQXJwcVhDa1RvUjc1N1ppRm9jZjZrT016?=
 =?utf-8?B?cXlUUmpuT1IyczFOelZGUGRNZEdFbUJIOEsrQ2daa0dHYUJVV2lVUnh3Mm82?=
 =?utf-8?B?b2NSUVYvRVJkT1BjS3lEYUtodlNyQmgzdThWUUQzVmY3NkcrTEZ3b1pQNlpm?=
 =?utf-8?B?dU5QQm00dWFTTDk2emUyZnFsZVRFeTlra2o5RWhTZlNGYzBhNzhmaVFsVzdj?=
 =?utf-8?B?bjRWTmZFOVNJa2hld3BlQk8vUW9XTXlhVm1EdXpieGV1Mmd4QkdOSStQL1F5?=
 =?utf-8?B?WkNuWURJT1NzTnRCb3lPcUthV0ZnY0lTbE5nbjVIa1hseDF2Qm9aS09JQlpZ?=
 =?utf-8?B?WnoyVVNNYisyWCtFVzNaL3MxVy9HSC9rK2N6R240WDdPT0NhMUtrSkJUMEZ5?=
 =?utf-8?B?N1hwRHN5aG93MUxMVGh1UjJjZTBWbzNWMHUweWlIeE8xem04V2lJMGNNTWdM?=
 =?utf-8?B?emNhU0l0RldiZEtZS1IzWFEzQWUvNTFSYmgybUU4TEp6Rk55ZVBwVWJhOUZm?=
 =?utf-8?B?WFd4TUtMa2t4UkwwSnY2ai9vQWpwbjdmN0ZSdEZRL2ZnazJLbWZOR3NDVDFn?=
 =?utf-8?B?VEdxZUhEY3YxdnBxTGdhTzFBTUN4MkFKM3UreTdTTWh0UTZobFpPM3NUZnZy?=
 =?utf-8?B?aWdiaWsrRzNLYXRJaWVDZUpZQWdMQ3l2Z2NXUnRvVWpwOVE4ZjNNMEEyUVhv?=
 =?utf-8?B?L1Q5b3I0QTJDOXdCOFRwR0QxMk5HU0VyalJsd3ZvK3o2dUFtVDJ4T1dpbWZl?=
 =?utf-8?B?VEs0WFJPdzRhM3NvcEdTZ1BRc2lGQTRTK1Y5UjVxTkZuSzNVMDdlRjVxcWRO?=
 =?utf-8?B?V21NK0FYYjFkckZFcGIvY1pac2tmdjZVRlBhYUcrNTVwZ1NkdUo4VXAyWENT?=
 =?utf-8?B?Ni84NWJ0Z2ptMVNHeTZySWFCTlpGaEFYWEdYcTNabHVWT05Eb2NCRytkaDdZ?=
 =?utf-8?B?ZWtsdDRkZUtFS1dSUUhxQnZDdmUxTlZYOU5GSmVnYW54SzF1WEloaDBQclhV?=
 =?utf-8?B?TE83SXBCL24xeGhja0E0RWo3ek1FSGFRRHNYWm1WYTJqbDJMYlMxeUk2Z3NC?=
 =?utf-8?B?bExXYU5WQjZHWTNpVWJ3VG1KazdtMWt4YnN1aFVEdzhXT1VYL213VVlQTmNx?=
 =?utf-8?B?TEdHYmZMNkhFeSsrK2FIQWI3c3pqOGhIRWFkYVRmVVdtOUFDeEdQS3pDaSs0?=
 =?utf-8?B?UWoxaDR3QlNLZXFDaTkzQ01yUW1RQWxNb1hOdEo2dWxDR0MxVnRwMTk0anlF?=
 =?utf-8?B?RkFWeEdzREwwdzNDenVsaTd4UUJnUnBLcU5DcmZQUnUyOUMzS3dlMVZNVzZS?=
 =?utf-8?B?bWhZdjMwOG51YVVQamV6QjFzY3hsMG9tWTh1NDNGZ1pUQ2dNMUozb3RwUnRl?=
 =?utf-8?B?Vk9kZnRGbmpRVksxTTR1R0V4UXRmT1RpdGhtQUppdWdGVm1sb0phUXVrd3Nk?=
 =?utf-8?B?ZU1mbUVlMytvRGdDbHh3aXQxeGlwMnBjc3ZYdlZnQllHdUJJNVYwSTJtQjBx?=
 =?utf-8?B?U1NpVHVJSzF4cCt3eHFJVk1JWDRhOGZRUlprVVlwSjd3OGxBbmpvVG1XYXBR?=
 =?utf-8?B?UmtXWmg0LzNrc0xXYXBoSjM1YlpoYk1SMmljakY0RDJITzVSUlhwbng3UFdU?=
 =?utf-8?B?eDlZUXlJbzEzRkVHWGhQaS9tYVZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3B844C69A778F41A8347E5ACD2331D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IYENsmYNfR3dlj0zle+9Nk/8l18tbTPJ+Jx5BBnolcIYg0X+ULwVor306dfiXAmYYPqnGsmLL843BDCL8qSwck0anetx4d2CXHgiCKSb6uMIXSJZFrOfKjHoX06iZa1QB3O/VKL9DHYQfIH0wt8Ajre9OGtgDL/p4s4SdNvZiLDSG2hwxTOqx6BifdTgvpUOsRqLYaveEvCEvI6N9e0HJRty/sXg+l3CzKvnXcB7D0IBFF0COui/pH4edAc9YcnMHcGp5eObJ5jZpciIASctV6v7XezUxzcovNI/LjiCOrW1N+zNStTPFDM43HFDW+FRlBZ0FQkImMJpibpAm3B8l5tRKKA5D0gwhxNfglYWRO/3C7X1v6HBB5P6XwYbjrzlukQiOxFaYT4N188RdWYbx3C5XK4x/Wfcx5dTKG9gcXdnC3NaakUYFDz/wwoZ4C6td0VKywObk5CGOfBFNwoueQZCz0bltm5fDo5SwALZnOwpxtksfg75ei3aZNzEQg0lEUAbEsSbqK47QMLNmcU7DOX4+5hTgDtWIcRsP6uwr92INGz6bT70mjrtU7G77vjCJUS3KEKNX0JFKOq9dL924Qq78CBOVm+6L/ePQwLW4TfjjtYzNtfrwdph9/mMSRoa+V9wz2g63vheFj6s7M9k1OYP9lwtwjHUuuPeUGMEPdeANVDWHrkBn3VmJAlsStljOH8JsWVK7iI/3oiDfhhLzTWYyQht377ZLzkJ13lMmtvyJDPkTtTBlFS+Qij8CSgPKZqPjIUnvoGuKKAb5SNYmFQyzOQyyyHF7dsctHTfL12N/SSUQNFsPaBjcKKnSGnonO1GwtcbiSkCWEgHNq2b/igVC1IMofdAZWaQXMwMObPR5rKqwafY/ec9n87UP0vg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534570bd-380c-4810-6f6b-08db76e1f56a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 07:41:46.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jVaOdJEkQDR1wnGUYuaERp+KO2A3p5FLatOWR26G8hh4yR9eSBDZicc4LPgx7e833SYT+IvpcQY3CiK2l8h5U43LniMzwNX3WEJ47vwf3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8067
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
