Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443F96F42DB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEBLcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjEBLcu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:32:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB521998
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683027153; x=1714563153;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mSydtMwklvKI9/FM6RLp3LTCQibVLGGBERTyvFcQ9Ym3Afdq/9VgTJ0T
   BF4IVegZgHW39SBrQQsJ0RBwlnrLfug700ulQxbqD2+zwD9c/iYk7lzmF
   nQRXaduvhWGjxPKPHvTN+dGG+ivMBE4TwKZ4nzloIoSQMhvpTujy9PNAE
   byn3U6Tl9U7mTvUxEN1rpDW36TXdd8eOBO03iaQsTp18G7jtFfBCR81QC
   dtPBxKoe9BQAmNQVAveQBIH36fFMMK82ivFdVQ5/oR1ufOFFyp94p06NQ
   ytgWpJFrWtwL3Up7MKthk4fVioLhXnmrW3b7f4zgPaSB86iH/vm1hPrCb
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="227920711"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 19:32:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KthBSwQ3KfRXDHPDFSEC+ZA2vwP9pXjUNPS7UIYefmgJTILld7crEom6KWUs8erC3qrv4BS7dTKZPaK1NLhesxLmA0IBtgftAMSkzaRRd64Yxu96gZIyg4kPY4InOfxQYhqQGiJ9xMfwhcDsXoonLARiaHNhZ+crPd+wJiJjB8UHi2PBPIYK/ddTmlNXvRm0QVLquwvEPsFXRm4P/VK4HfzHTP3yrxJLO1H/y0LPjtE1Y9Ujbmw75Xf4YB2Px4LlHMP5nj1pxyBNLsuvMTsh71bCASBu79RPak+Pb6YIJRbs/XQAy5zdN4IGzwRrvTFo7BELDfO2zOeSbWgh3gkyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nfNuMY1sSgr/tveExPXRDmCwRSjMFHniuDsI57dS7eaGAniE+1PSkilaFXLWZxpzQML/8V5Dqzgfe277XzVUZmuOu6Bu6X1mKHOKdvnwqXNlEObPZMIcyFVvq+/Ef3lFM+kZu+mR0hnfoY64NYzOtbGnqoMvtNSaOY2bmCbBy4LfrJYgHbKQrH39xPV1AOUVKFO+EJWrPtXlLtZ+AQ8i5IKhnRogf554um9iLmAUV1ZjR4rpfTMsExusF5VzGETDsoRicu4CB0ZoIIWHJQi6QhRGkMGeUM8I8Evso+OngATYAsoFloBDyrNA5B7mYFM9TdYCtvweR3CdtKThpUysHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=tyugXVD7IiNe8pQRk/rObdZuEqXMXN91i9Vv3/QwZtNSC0DVjVnyKFcZrSdzGE+tY9p5SiJZBrE39qFiDRQ/zdiflLvBNqtuAp02hmYsdtEClA86B9rZ/0c42/Qf5XHwP2zP3D3bV3aF5mN6N/nCfQDaY9x1LTI2oWT9xLZr06U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7110.namprd04.prod.outlook.com (2603:10b6:610:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:32:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:32:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/12] btrfs: add btrfs_tree_block_status definitions to
 tree-checker.h
Thread-Topic: [PATCH 04/12] btrfs: add btrfs_tree_block_status definitions to
 tree-checker.h
Thread-Index: AQHZetZHqGub2gnJS0yRLJuN9w9dnK9G3eGA
Date:   Tue, 2 May 2023 11:32:29 +0000
Message-ID: <147b7967-9714-9812-bb94-50334f2dd4d9@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <d748a7c5d28648aafbe1e24b81b6db0e0ed4647c.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <d748a7c5d28648aafbe1e24b81b6db0e0ed4647c.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7110:EE_
x-ms-office365-filtering-correlation-id: 7660558a-3b85-44f0-0286-08db4b00e9ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ea3gPej6NKEJmtbOImxryL2aGJqGdKUTi83pjafe4Xujf4zig8Oc7nwWfPIHR8slMwzNsjd1Q0XGrAnN8MMJarWsFHfiGsbBg+zB9Ls/JM3ywma849dHOpu4eifQWG2DFO6elAVuEjUHYjsNyUFRnP3jVjpo3/n1ax/a2anbtDuvjCRjC+GDDl3J7Ne9g/bAmJ0vrZORoIxDQPgrGLNWyLFnsaOCfMkMQs2paRMRZc0xE+q9KQmH+ksFuTxbSveeVcW1CbDpsnOfN0Wzm36JmWkFYQfJYKBfvWUKnOr3OyJRJWL8CEPKs1i4KrVHHLVY0EeEwAep4/ViviOADFZoGDXQ1VnFwLmyDOnzaHHsbJvesLWwC6AKftEEYFD8g64VBWppjs/KMdBdc4IZf2OAjVhmFIUoBUppjbG8btV+sAcokLt6niQOCz5sLKKn7BAJZxJoxbOzV4OsHMKdDGqDRMR6Ow83JU+EDIlgJ2CoJ5vXCBs4kW49c1hhk6ZdIeTvBEktmirboj9s52RqGpP28bgEHuU3wo4cxsLIVWjQ2D3QI6UE7KPvHxVw/GwHMH16qNvo7hHRzRclJLEgpId3FSmDCd1yey7eR09WUIz61lKsgiIfyQPUQmbPkmKz394CZVxAW/vowiIN49uPBYmhp8xTTWHBiPQLxBOq65GOGLnoJdaujQC/uNzdXRY3rkJi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(5660300002)(86362001)(38100700002)(8936002)(8676002)(64756008)(66446008)(66476007)(41300700001)(66556008)(66946007)(76116006)(91956017)(122000001)(316002)(82960400001)(31696002)(38070700005)(19618925003)(2906002)(558084003)(4270600006)(6512007)(6506007)(6486002)(71200400001)(186003)(36756003)(2616005)(31686004)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpVeUhZVTlsRWVEdGtQc3dFRGM4VGxGZUNsN1NRSXJ5TXNFMUZFQVJJZ3Zw?=
 =?utf-8?B?T1A1NTdhOWFLdlBSSmp1cEY1RmM2SUwyWEZXQzlpL3dYUld5amNYOVJUY0gw?=
 =?utf-8?B?Q0tNMzBpTHNYa3hLbmYrbW4yekRnMXJCMHAxTXMxMFBRdFhaZXd0a2ZVUHh1?=
 =?utf-8?B?MWNQYjdGcEhhZHJETlkrUzRTNDZ1TEVWbzJES1UzUXlGa0xseXBqTmpqV3ow?=
 =?utf-8?B?WU0zU0lHYllTZmxnYUdMcGQyK1gxOWhONDZySlVIVWlod3k0Z09sbHRTN25r?=
 =?utf-8?B?NmZETWlEZDNNVzFHWllxMlRjNm4vS0ord1NWTTI3d3JxY2VDTVRvV1FnQ1Fh?=
 =?utf-8?B?ZmJwTjBzRENRRm5yeGdPcmt2WVFFRXA1UzA5Z044M09HVlc0SzRjZnQrd0Jq?=
 =?utf-8?B?blVhS280eTFuL1ovK0hpei80L0Jhdkl4MWd3S2dVb3lIL2Z4UktYeHRPcnRh?=
 =?utf-8?B?RW9RYTRGL0pORFNIN3YrSE1Qd2tUNXM5OVUwVFlzK1ZucUk0TWh6YTFDcy9r?=
 =?utf-8?B?UzVVMXo3dVpYMWhpT1hOSkVhRlNjMVp2Ky9zL3l5MEJ2Zi85dGRFRUMySnYy?=
 =?utf-8?B?dkdxT3RpUzNwRDJYdHB2ZzRjSlp6MUVRRTBoRWdKdzZQRTJJbHk5MmgyWUlp?=
 =?utf-8?B?dGRzM3BwOG9jMEw0RlhJdFphSHM3S1V1blZTOWxrZXE1REN0U0hhcEpuQjBp?=
 =?utf-8?B?WTEzZm5XSllrSDIra0ZnWUtkV1BieWtQQ2RuTkFhU044eG5wbFg3THIwaGRJ?=
 =?utf-8?B?dWF1VmpLWFF3ZjY3ekxEaVRtZzJTRnJkREREOVJhREdCYXBvNEE1djFseEF2?=
 =?utf-8?B?YXRqS21SL0g5bUVyTlJVcFNrcTk0dFJDS0k2dzRnWEVQbWRqd0VtUlk5d2lv?=
 =?utf-8?B?Uk9QaysrUHQveEZiaHF1a2V3bkpDRUJIREM5RE5DeFlzbHMxSGNmNWpRUlNU?=
 =?utf-8?B?MHJ3M2d2aHhIYXpyWUR4K0F4UVJBM3pxTzV5a2NvMG1RQW5PMTRMYVRqWFhm?=
 =?utf-8?B?NDNjbXIrUkdlejkxcWpqWE13NTZlQ0VYZk5oODZ6bVpmNGdOQngzSms5RTVF?=
 =?utf-8?B?Y2RkRzhzVlJRcjNiVUlIUzRPem0vMmtZL2dmWjdBaHVobFQydnE5a1JZNmdm?=
 =?utf-8?B?S3NHOFFjRVBNUmdSbVNvRE9IcSs0aXZXVk5tcklPZFlFZmp1QTVVV2VlSSs4?=
 =?utf-8?B?UFV3RXhXOEY0SWhjRzNsVE52NG55anNaOERFSDJBbDZUcVJ5TkxiMDVCcXMy?=
 =?utf-8?B?bkJZWFRpUFZBbHVuM3dwdFdsWElUbkdhVXJRZlNJZ01JZ29iWER4dTJBbklz?=
 =?utf-8?B?MHdIS1AvMTBRU0E1RmJwQTlpNTJZQjJmQ3hNNks3anVGQm9PRHExTUZWdWov?=
 =?utf-8?B?ZmNSRExIZTBrZ21LU0V1NTA2bXpreFE0cjFwS1NCUmxTb0lOM09OOEJ1dFQz?=
 =?utf-8?B?QUs5ZjN1TGVaM2RzK2dzNSt6ZGpxVWJubk02MDFxU01MVGJ1YUovU1JEZjM3?=
 =?utf-8?B?Q3Y4bGhYRERnUFFuSUFnYUorbUoyQmIvcXBRaVk0aFNSYW9wUG1GdlpTSElh?=
 =?utf-8?B?bjNrKys3OE5oQjVuV3I3U2JpclRZMjFRbGJuOGh0UThwR0NGa1dIWGtrdlNN?=
 =?utf-8?B?enNVb1QrZFpGaGxxTWVDTDF5dSt3WDFRWmxtanhaNUlLY2V6d2xVMEVWQVE1?=
 =?utf-8?B?eFNSMjBVbUVZOEFwOUd1R0ozUktmczhuSEF0SVVZRjJLSUh3aE45NFRhN0p4?=
 =?utf-8?B?SXY0b0V2dGw2VjZ0Z3kyRDZFSE8yRGlIQTRqRFU1Y3Q5Q2YvaHZ1bm9zd1Vv?=
 =?utf-8?B?QXBrU3ZzTXFPYW5SV0V1eTNpK1ZINDNiN1FlWlR6aHhoVGdXbTB4dzk5VmJO?=
 =?utf-8?B?VjJIRmI1N2trai9JaE1yRkhXcy9RTWpBclkrdjkrUFduQStDTEQwREJDMTAr?=
 =?utf-8?B?WmpjZVVndUhvdEw1bTB2UlhvcytrZStNSDQzc25MUTNFcGhKS2NVOVNmUER6?=
 =?utf-8?B?YThDVmFGWmR5SmFuYnR4THBua1J1eGNYb3BuenBuL29MeDFLUDlvM3ZVc3JB?=
 =?utf-8?B?SU5ZUFB5dDhqMEUyRkxkQ2xJYzUzVVhLYTZhaUZQZkNMVkNaamNrWmxBbzIy?=
 =?utf-8?B?SkRpbnNSZUtVRjdvVFJEZytqbnRxQlhmaXY3V0hoR1pqWndxSDdUWi9oa2RC?=
 =?utf-8?B?d1lkV2xTZ2ZSY0FDU2tGbmUzNXpmYnJEK2pVbWJ1NXJOOVcyeVRVT0NQazNk?=
 =?utf-8?B?M3VUa2tNbDE1ZjNETWtHQnBrVUh3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C53F3AA9D3D04789DFE3A6505DBD3C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 027Xi2tDyobHPGJ6ywwrnPwSM5BWbwBsjlzRB+k3UqEaRLlf7l8OCBNpCADUVM88qZWkgloeyUUHYSQm/OxCiif+D4JTA9VO8GxVYU0/FeNUSukXtQAtMvM57Rm1ifWhY4KPEoCvfJSmjeSp5GL5KMl2SPwcAKOs4iAy2i1e+xkuPZei9eXUJolplsgkWAMoc8rJGWbW/RfilwgVYaxHxgosd78iJc69r8cd+D+ksglusW4MANSoTDlzyGTrPLbiwkULgm7vLTwuBeIsRchMgSwlmZDGIv+YY+XXXL4YpHBwEiKkS+f32Gjx2Kdao/A6CfRuTfHBwfrhDw5szv66c3pjgpV9hCsJDNWvfKtO/CflrUG8/1d7xMd01ACOJgP5tTwGRpJbomxIN6P0yWbif6/1wTvXB4t0LxSO+MQfTCps3PFy5KtAfHtBkb0orMlSApaJZ0Qi9Ky1hYyR9IpEA06WBAAJMJGE2rGDHuAMCpft+RICJWG3q5x2PA5CEsSeZwo+g+qpY2aKt3iZLwPqd/56vrx/E3ny+Gxutg0Zy3C0oLt0hodec3Z/36Z2POiJYRRyE6zpnWOhLwYnkzWJu2lHTVM7naoh023xOp8l0e07izbrfgDD55361Ps696zXe7hLiTQSFGBsI9FqgFfkT37/6xRwMWJeQYAXZUGu/Z4V3ouL88Fh0fnq2+qxR6ue4EQTM2fgPRZZi5s7r/iHOUhOdfGPx7B6Tgwvk6aZVUe8SIcYSQpBE3fkhZdNGcIPK+SO10R/3JCdFrC+9OFa/wjzRM1pR6guBD+xu7gH9ZAzKu1Pvnvarsye7w+8opa0lseMeVlqOOLw0s85a/NfZA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7660558a-3b85-44f0-0286-08db4b00e9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:32:29.5803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2if1PC7reA60b7uZltXzw+KksoYhGKYcIpaCiBMJA+hQrrUlhCSVzOWdGYC4yIGPRXaLBk8/T+8rhnKRZ4vLxXRI9kLnXYZzeOjXEOc65M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7110
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
