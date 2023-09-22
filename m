Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A557AB25D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjIVMnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjIVMnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:43:18 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099EFB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695386591; x=1726922591;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=jV2xYMxleJ9lcA7Y1yWNjTmyryU/nZjNUJ+CP4dKmoakRD7N/fR6iEJU
   d1fTKBYshJOUhCZzf6qVffgr28ZtwSXOTWYjuRT9J0QvKY9lL4xp2ua7K
   9gMGOb7GuT2mAGzFH1gfsgYfbbRKISkrn3egeE5//7PYR1gMn2owUe1mZ
   RTi2qIBOSs8SBJo8GGNwwrzka9rrerad+5R1Nl8wqT77eAKV5EFD8YATD
   MlmJKw2pDEHzGsrpFV43aV6hR05pGHl/2b2asu9BtdUVBwhjb4UOqp/v3
   PbNJUsUiXB/SV3CaNX1UsPQgPvNZ5e1iplsoDODItqdaCptokd6zfe69o
   w==;
X-CSE-ConnectionGUID: Rv+3TH+uQzOZyySu3ZIVEQ==
X-CSE-MsgGUID: nOGTNo4fRAqLTz8tewuYjQ==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="349941960"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:43:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyFDdaFRVcHZcw68EAYO6/7N9l4nRHQBC4DSJ73p33hkARoS/4ngJM+AM+ptjNcoGl6nrcZIaxDe3VjWF0gxsMMtgJl4BfODOK+4n6shjNKxcDwSJCBu0sCo6pOWPjvCJwdgPOzDa/S0vUCsbrg3a347uPlFiHAd58eSlLMlYh6bx/et98yyDPDRA25n39HyQrUvnYJX0X6HFu8etMenwcO0uari02T0I1s7MkTqNf/gnFVQMyh7IhgoJuMgH8nH0pEVTvUEgQwSp21MVcxzQF5p4Q5RJU1pA9F5yXvQBvcI+p+dKVk6xUpbzoPDpbvlkVbPDz1Xm+GGw4ueAsk7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=MGnz6ZayRnJd4dhWvIair+qsO+DQXSLBgH4IgS+ts6Ps084FSWa+txcC/xolTIbVQWm+nUxXqb3QqRzrMeObtbjk4qa6qpyc2R1eyX6pEW9Ozgcst9cavi/Bpgnqd4Dn+CundacrRyWx+4bheA6FrbSwlRXulNxjqQS+LYWm40bIMTzP1TtMdqUe0OfkAX6s3lCmTT3FX2sqL+X4DYZqU19maJE+CpZOeyb2gW0lknGtYdYHkBH4STq9Z17GZuBFjjmctmMDjtgO5mnow29o4DBvkFnD8JlCl2RDPL8M0K6pJuPFMV4Bwj2UljlBwhNHRoWArbT/WFxODhfu7mOZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=hVvkOiDnK5Gq99WD7UO7F+mSBNN01vqS8IFVFeMPfSsSzg7jVwM+O354sJBFpGhcIioH0qNlsczAm3VJNPuP4rWxaHjO+2ukBZx52jifeaQxI1ycnwFC01UPQq89ZNSyvCvCR74xiZaVEEqMMcHpGI4fgw0G0wlgy7h1edJ0I+g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8319.namprd04.prod.outlook.com (2603:10b6:806:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Fri, 22 Sep
 2023 12:43:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:43:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 8/8] btrfs: relocation: constify parameters where possible
Thread-Topic: [PATCH 8/8] btrfs: relocation: constify parameters where
 possible
Thread-Index: AQHZ7UXrJNur3bLiqE2STrduwb7jarAmyiEA
Date:   Fri, 22 Sep 2023 12:43:08 +0000
Message-ID: <7e40049f-f82d-40b8-9e23-84b71a0a3f8a@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <0b1645424c12abc4bcd04c14779f2618645867ba.1695380646.git.dsterba@suse.com>
In-Reply-To: <0b1645424c12abc4bcd04c14779f2618645867ba.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8319:EE_
x-ms-office365-filtering-correlation-id: db09feb0-d067-4f81-9684-08dbbb697983
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: II4YPmMVSJKwP3MOVuftFwoFJWNBfpUSg3dqlb7C7H6ufeSedfDoSibM6uucAV2twbfUPpLZjspCMVEUxjA90hzTm9fkCYgW/jamwlhKi67BDDJkRgSegArQFMHhPe+j0wPJz4y+vRg1Nwmw9b1MDl1vJLRTDNXxnXgUcthqtYf1TVYRBcp7E1OVzBMfREPSsvAyogwHbrMsiXusWauf7AHq81M/Jy3GNS42uolcEJjhXYq36DRuR2jP32qvGOxLQoi0SRh0LPp2giJwzOrUFNCPrqozb5Hc+iJ4I4R7gbY4QZIJgF7im+wbrsUxl/oyB+efnO/CuFrBCn4a/ja519HFrsb03zTO97i0ji6a1FRf2c5oiUoJicwPSUJDOAWjEdY7LFZREhBG29Rts+emfwdyF1jRRWV1W5Ct6kl3DUUqQGDajrVSPw2UPSkN0I/eEGS/OJa7skl9yQwpBlfZUxKDOSwQV7NPyUC+M5H2OVqNXKmrmp5Bx9JgEe5TzmpD9trOMaGi2Ky3ZpRobLAWPGm7eiUW775TULS9ZpFonnbEPlydM+b9pQVKeTjuEowclm1l/p/CaXY3HEDYwFFBiESINK6UcbOZU9EzFVozUcDQB2V7UCjQkjWBLzjMKyVOZ00PSHmxRm/2OSEY+A+Q6+nqxwjYnWaJd9od7g9MszAXfgY9B7hT3XlIx3imQQ4B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(19618925003)(71200400001)(478600001)(86362001)(4270600006)(31686004)(31696002)(36756003)(2906002)(6512007)(2616005)(76116006)(26005)(82960400001)(6486002)(316002)(6506007)(66476007)(66556008)(110136005)(41300700001)(558084003)(66446008)(66946007)(8936002)(91956017)(122000001)(5660300002)(64756008)(38100700002)(8676002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWxXUVBuQksreC9KNGVva2NJVzErRHArNDZZajZlVHhrTG1UczJXblBmVGkz?=
 =?utf-8?B?OTFJcXlxRkJ4RGU5eUNUK0xjSENGK2lWd3l0cFphczVBNTdFZTQwbHI5czZq?=
 =?utf-8?B?NUg2aDhtNXo3SmIwMy9YZDF2amZOalB0d3NZbzI4U21QU2JhdkF4TytUTm5Q?=
 =?utf-8?B?SEUzdWVyN2l1ZEplNnhYMnEwWEZac2lPV1MvaU8rVWVJYmpaV1BYQ2FZVlJm?=
 =?utf-8?B?SS9NaXBjKzBubWRJeUJjOUs1NWQ4SnpoaEhlKy8zS3FWUCt6bkRITnVBUnVr?=
 =?utf-8?B?bzVDRmo3MUxzRytDL3RBUFNFRnN6ZDZpVlhGK2c3QjBaM2c0a1RCbFR3dEZ2?=
 =?utf-8?B?eWZ0czZOdnVqQ1NrTTFXSk5OMVFVMytTY2VEaTdjanZCODZpSDkrazVObklp?=
 =?utf-8?B?RC9YSDVRU2xHUTlITEZpMXZFTVduN2xuS0xtNTlhelhjVmc5NGVELzh5Ungr?=
 =?utf-8?B?MHZpUUdKL2prNEZuWUxtSWRtUTY4SWFadVZtZEE2OTVsWEVOSXZwNlJ6L3Ur?=
 =?utf-8?B?Q2Jwc2w0ZVpsaWYvNFh5YjF1dkZWeGUyZytQMVQzdUdvM0VuTHVITUw4UUtU?=
 =?utf-8?B?NU1mS2pGbCtVa29HRzJHTWN0TE1uOEJpazBtMkh2NUZlaWtzUXVNUEJob0ND?=
 =?utf-8?B?TExnSFAxSlB5M1REdWVFbGpzUERON3RiU01OVHpGdEM4ZXpyK0wvQUFhcjBG?=
 =?utf-8?B?VHlmS0cwSzRXdGxYSTRQM3c3YmRLRkdBckdKK0V2VmFpVWRzRzAxbXBRNENC?=
 =?utf-8?B?SWZUZkFIMFdIMlZQNzRjbVJ4ckdETm5DQmRCNHp2cG55aFZZNERFcTUxNDc2?=
 =?utf-8?B?OU82ZmIzRGh6Vno3Um5ybGFONjFiVStWOGduc08xaFJuQmpnL1Yzdnh4dW50?=
 =?utf-8?B?dlYvdElQZ082cWdKSHg2UlgyNForV2Z5emNPOW9tTG5JUTBDUkVKa3hlVzkx?=
 =?utf-8?B?d1NLMXpTem4xVVQrTExSU0JvcHA3ZHB4OXY3YTk4ZlZmbDNyTnEySDk5T0Z5?=
 =?utf-8?B?ZFRpU0FMQ1Zod3M1VVlTdGFBVWp1MExaVE9CNXlzczY4aUVYZVYvZzEySkIv?=
 =?utf-8?B?MHI2bkNnWXgwV0NXRTR6c1pRdGpSZzJGMnIxUU5oY1JEbm1jVXhqVm1iZzQ2?=
 =?utf-8?B?a1NZdnBiRUlHcDNtV0xYN3NMM25Xa0JQeFJQbCtMME9idlFyY2RlcGxvRVpG?=
 =?utf-8?B?Y05lZFViVWU0eUNxSlRNSE95YjJLckpBT29qWXp5RS9qUWhVNVhRM21CenNj?=
 =?utf-8?B?Yk1jWCs5Wk0zZU1JTVBBVTNPbTN5MC9iOTNkNm8yTGtvbXA3cUpQV1l4TGhB?=
 =?utf-8?B?T3kwK0hlM3ZPd2JGUCs2eGNVZkEvRlAxYzhXUVNTMERRNEUraWhVbkxKL3ln?=
 =?utf-8?B?ZnAyUVlFbnpkTjBUTlVxV2Y5Y2RkQkdQbk53MUhUOUdSLzJpUlhEMjFKQUR0?=
 =?utf-8?B?WTdMZ1N3c1lzTVh6eUdDNjA1MnpObzM3QWJybTZKOWRrdUpvL0QxOWV2VzVV?=
 =?utf-8?B?VGxVZ2RqM0dBSmxNak1KSkQ3d1NJelJYQndFWHJoMFpYREVyLy9UY3plbERv?=
 =?utf-8?B?TlRHeWF3YWRvcjl3c1ZjSGREWXBTT2VLcjlzUUFvTFVDOGs5K1hvMFhZNDJB?=
 =?utf-8?B?b3RUVEJYeHZaUE84dlZib3JwK3BnYzFVeFBYTms0WVBkYUhWTHUxNWhOckNl?=
 =?utf-8?B?R3BwTS9PellOcVhRaTVkRjZaRTl2Z2QyTFdDUXgyazFBWDU4MnVjaDVISVZT?=
 =?utf-8?B?NDhWVXZwRXptNTgxN2QwelJMWUdaU0NCV2ZmVnJLOVBVU3pkTm9wM2dMZ1Va?=
 =?utf-8?B?ZTViKzJLZXJVQ3ptZllzSjBOM2pBN0lrb005YkpERkZNZmZ3UmsxckEvQnlX?=
 =?utf-8?B?UXpTL3BScE5QcUluemJYTmJEK1pmekJzK3dWRVJMRVV1UE9rV2dYNGxwRU5T?=
 =?utf-8?B?WE9ZVHd5ZFExMlJ6YkFod2F6bDc5bWRDUHJPa0ZNd1dvVG4vZ3FOOGhMTkxH?=
 =?utf-8?B?T2ZtSzhrTWtiM0xWbVBtN1d0S3RvTjdHT095anpHK3ZVemVqWEJRSFFYdEty?=
 =?utf-8?B?dS9JS3laMlhyRUN5NFhGTGlqT0tSTEZhMzFwVStpZ1EvNVF3NElBaytjeGtr?=
 =?utf-8?B?WG4rQWlhTnNqa0t6Y0E4aTJyQURwM3N3aGhnYUw2aERtVFNKTllTMmFIemRX?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE4C26616C31004881CE813EA13D3B5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k4JIy4HM8EzctisU7og5+VJSiiuGKQ8fQndusAovczaZfgTtB6a7bX4seO5Rk9E7j2APIIOVMjovT5wcXpB1yZYxiIDgF2E7buqj8+q6hCaOcMzgN33aUbKXfop6cp1CSwRU66TpL75lw6TcL1HSYzsf4lwLJfWl+GZrru5H4ehFPot3ItGIcrQGrSdFEyaciR59ge9OzwbpwJy0N2eyP7DRuzoCMG9PYjIyY65TYqjccnuCN7IzoIpUktGbGh4EF7nuq1PIG4l0L4jg7YWBkKcz/C9H4DLp9KFFTY/iWk1UdGjwsW+duuZ7yp59IMWRlxAwTcqPrD3SnNpKFSzZtnZFJfhDQUT/DpbB6c7NfBtdV60IEG723dhAdQ7wfuI1riceI13DoXj+uiZJ5ASsvY2+IuDUgo0HLl4e7sjfPUh8aoVFiUnjxkMQme3Cr4Oq8KjiUXrro5dSPkoc4w78yeatuBGd/JH5lvD3QDqXR3xt0DTfMjs29ItzDIzEZ79x6dslsFMZHxL6s+fvJVhiAgCEi+P3kdx+2CmzGqWgZ5Mts3KwQHFAzQk4GPDhT6A5/86nqc8WE3sfohemrP8wJWamVgeHzpkugFWq+vMXkSNiXchY/TkgZFpfaPLBR56RruzA64hTjXbdQssKavGHnuP/kAUuc1UuxRRY7cM/SUnmbQRMbZ3Jb6ehRz5t/1Ht9tMRcE7aol/MA6cVKkinwyxRa/6A/t1W1kn5dxJ0bapRD8+w4wQnXnwSN1+RuyzdGr5XBeSSuagWxUyT9NxUnRNArfGahXfsMpya0L0GjMnzY3ldhDak3Fw/G8RshCpl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09feb0-d067-4f81-9684-08dbbb697983
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:43:08.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRRCJlwV9jFIg8/rndzrOF2tZS5L8/FP/uKTkMz25ZtqM1IBvAZPekPlWmwVOWdkVWkM2UrgaN5OQhJ85QAaErdd5OaXN2w/S8Kgj5zfA7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8319
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
