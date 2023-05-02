Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652426F43DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjEBM11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBM1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:27:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B71A1
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030441; x=1714566441;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=PQOg4tpKZ9Fp3i50lCtXC7w9FsuYc6hF3bVcSml4hCihtNq+5gtOwx9e
   oDeoDQyDN5DxsxMztUP4v8alYBQsihqt7AYt3Qa8j5EFLgpaq9fAw+6KB
   dNFimvvYcUzcZ8zkbLnmOyo8O0miZY0Q9OOp6MlMhu5eZqQBjZrZoN7TR
   YctvQOK1ksHkByD5rj1UAiv9IttS/G3uMgK3+vAZ22U6m8iciM1GPJ6bz
   1qQToeWC8lJiRLo5Swklk22y8k2CK2n3FlUjfz2S4In04vSGx+EUEIjBW
   QCjsUblAlnmxIm5c6jI//n/dI/84IZFMkokXbcc+5lSLDzR4tjZJ+swCb
   g==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="341755101"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:27:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO8eupPwW6H7wUPviJo+adqZps5Iy+YWK1+6lzDkWZPbhsvhO4PYKAe9wF6H1PVutXp9DjWgRXnGz6Ux0OMAVOSPYwaYYh7jHGbGqkbCZ+M4+xe6S248fkJZcqvlTAJfubppjNJJXMCzSlzTMIt5T59LJb2FntWb8RgETcaVZwPbm/RHGqJBrLRi4Qvme9qGNCLH34Cbx1cFfS9nRJNgdFMf6E0qjLDVwYNZq7o3Z1MxvNoonmkbJynNjKgrRM2fGpoXRb2//4G02bXdWERN256DGPXgGUzbE3sKtitTdAiMEweaIGJg80NaseUVWvRzJyxLhAm9NRrEvGgS3kAXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OtOdZVhWnqpLiJssnWnfvQTnbRgnzlumtZSNDlKt6zTb8btHvtJLfG9OTNn5HR67wUK6jGzR96yVTALaMzZs/IDFDzZXLfJdHWSHJcv1Su5r/1HKWnp4IWHNg3/+gQagnH5uIRQZ10rvpyQPjp5yXDb7G/bDLDlNARytlr1r7SKg5ZtbY4EJNq8WezztxX6wzCDR+PuBRTfclmOGjXATlUI2rtJvVo66luhG0Ev9XCZMwiK25L5afZ45/xhUQKCj/MublqyzaZOvwOi6hXrPNBjMeNbGzrnhXu/fYONUbMcI0ZUR6xNpN90hU974Q0XpmkKLlQv/Y06r4PG+wkLwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=wIAv8e3uwH6MUn49hhSui1R+Qh2uiyVKixEwBCiRAfFI0JBwaag/9Nsbjnfkqoo01yPZTwY2H8z1AFrp2tbSmyAL5wR2ZtGrqHcXENQrk/SG1ul/w4BlJsy4dH2EWS2JItZaO9pdfexfvp6IkxmCSlPT5XscoEpe7uC2gonxIRs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7848.namprd04.prod.outlook.com (2603:10b6:8:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 12:27:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:27:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 09/12] btrfs: move split_flags/combine_flags helpers to
 inode-item.h
Thread-Topic: [PATCH 09/12] btrfs: move split_flags/combine_flags helpers to
 inode-item.h
Thread-Index: AQHZetZOfnU88dS9QEONB104ENRhXK9G7TEA
Date:   Tue, 2 May 2023 12:27:18 +0000
Message-ID: <3ebe0184-90a8-ba53-d975-e988d6daf715@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <5deb90b337e17e2236dc2349fdbf4fb216146551.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <5deb90b337e17e2236dc2349fdbf4fb216146551.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7848:EE_
x-ms-office365-filtering-correlation-id: d0cf8e1d-b9b5-4294-d103-08db4b08921e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VU4Z4H6o/xt3wgxwhHsSCw6Agrdc86I0uQngcI2AovX/+hMq1oVmbBK0550CiYTJLt/XFuSh0HrN2jZ20JYPm3bpTkmB90FI2snK33g1m93fn1sL8RdZ1NTKdvNQqcyRO5v1xuPBOxlRF6GrpJn9UgjDqWT7bG8qD7AmPlaGseknKIVYXvQGBCydtPby2Q39LBsQbBav3KW9YQItsla/pAtwIJWpw3NRrTXyQwgOW6ifRKyWVvukusN5rUGHw6PzHvzUSwuTVv60KPBRqFqYK2NskPZB3luguyDMb7n4yrOK91ub0AaOQLPikS1FmR34sdqTj7dNIXearvGxMeYdbHM98cxrRyy1bAX2bH6k8wDEIDwOr2IQXHfuQ6wAm2XXNWzJph9lftdWCsKjTld0yIi32AUiFFaOm2XNlCbDFtDeB01F3h1p8ATt4tu3Xm6edpaluDm0zHxDrq5ZduzSuRl5gwkq93ONxi3Rju8FbUERnAMF4LFX6MFl7l8ysr+wpOzLtKS9jvqjFrj56Hr+joHYywdbeggG+QljZ9JuT3HhEoGisPHrKJow+1DMMVlxcCt24pCT6YPgEMvDXnuqMMJLCZ8Z33BKNGZmlIotr78rsLNxU2A6nvCaev/MqKfgWxehZKaNIthROMNMydmgMM3zpMLz6HVqT1XZE+eYMH6Fsio1BWwKaI3pMNWq0ldL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(6506007)(82960400001)(186003)(4270600006)(38070700005)(38100700002)(122000001)(2616005)(8676002)(8936002)(5660300002)(558084003)(41300700001)(36756003)(2906002)(19618925003)(110136005)(31696002)(316002)(71200400001)(6486002)(478600001)(86362001)(6512007)(76116006)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZnRHRjTExXMUFRMkl3OWlpV3NZdWM5a1gyN3ZBOWVocUNBU0x0MWwvQzhj?=
 =?utf-8?B?aGkycjJLMzNNYUtCU0tXblgrbjRFdmFJTTFTelRMWG9HTm5IWkpsa2pwL1F4?=
 =?utf-8?B?RUFQRnVCemgyYXFEV0laOHRKMUhlZGRxTGZvaFFJSVNQRE83cmk3bFVOalUy?=
 =?utf-8?B?TFlvcVZxKzY0VWlxaFd2bUEwcjNlMGgvc2o3Mng1a1dZbFZXWEwzcW9odEhC?=
 =?utf-8?B?RzVvbk12YWNrU2N6ejljMVBiTmM4WVVwRHh0ZnRtYXFEaWd0TktkdmRxOUF4?=
 =?utf-8?B?OURGMFdib3M4bmVGMUg4WTRHd25DSU9Na2h0eGxnV0s3aWg1Vnh4THIvYmo5?=
 =?utf-8?B?NnZXSHVPOS9NYmlGVHBVeDRmVkt3ZVg1T2tLWUthRzN3N2FnUzFYWFBhc1pF?=
 =?utf-8?B?a2ZXcmxJN3pJcEdhYWpEQXkrMnd1L2NzK2N4OW9Oblg0L1BjQlV1Q2w1YUI2?=
 =?utf-8?B?N3YwTElxQVFycDhWeUNJNGFKa1l3dTBSS2h4cHRjam9USll0SGhNWlc5Zmcv?=
 =?utf-8?B?ZGFJMkZldnpYSWpzcEdXdG1DN0oyTGkyc004Q3VETEJFTHlkbVdNMm04RXVH?=
 =?utf-8?B?dnMrOG1xZHBsQ210Z0dxV0trQjE2WnBvTWpuYlhDSlhsTzJDNWFqSzlJczJj?=
 =?utf-8?B?YXVnS1hHRTBVR2Z4cW1ua2xNUnQ5bVdsWFNtQ2RGYWQrNEZQSWVrK29kQW9s?=
 =?utf-8?B?Tk5TSG1WM3VCZVB3UkNXc1lGZERkaHZsb0Z6T096MzFEVEo4ejB3WWtCRmZP?=
 =?utf-8?B?Y0x2WmZVUXp5SWVoTFF4V3ZZU2VIR3hUbmlyOHhYWDcvMjNDV1kzRnBBZ2p5?=
 =?utf-8?B?UjFRNVZSUVE5OXFzQ2pFOGtYZmhWNmVJZ0lZQ3IweHp0OHVHa2lGRDFHdkMy?=
 =?utf-8?B?alJKeFg5cVkvdGtTUzdYcFVVK3BlKzVZZmFyNmpPeGdyNm0vMFl0QVA5WnMz?=
 =?utf-8?B?VWJLRW5OTndLWXBLemMzWEF1UCtqZFdWWGdySTRwdWNSMk8wUFlOWFhPTlV3?=
 =?utf-8?B?VmJ4WHp2VWRBcHJFanJyTnJjenZWR0NzT1J0d1VTUU9kM25oWDM5U3dWRE9W?=
 =?utf-8?B?dWZqV3VoT1JlQXAvamk3N1lkYjl2ZmxqZUlSbG96bnlHZExnY0xXVFUwSnNk?=
 =?utf-8?B?QzM0UjZ0YkhQRHJKUFI2UXo2TDZxK294YVVPSkoxMHhiWG0zSVFiVWd1NHNO?=
 =?utf-8?B?NUcvbkZhd2p6ajEvSTlpWGdMZmxyWFhoa0Z0ZzlwKzFha1pJUlVsWUV1eC9D?=
 =?utf-8?B?SFRpRzQ5ZTQyZEI5L3dmMVQwakpGdS9xb1hXbU5WNGFuMG5wd1gvNlJKZjRi?=
 =?utf-8?B?c1duRkg0Z0QzMGowVHBlQUxMeGxOd0U2SWh2S3A0aVFFZkhHeVBSeWNuU3hF?=
 =?utf-8?B?VWtmTWE5VVMrcWZaWWowaG1DNlJMUEs0SURHNDVLVnJ1RlpGaDFCQURPbGRB?=
 =?utf-8?B?QWpOTktBRUJKSVhZY0NTWlBOK002bTNCNFU5b3E0Y2k5TllMd200WnNZQmRH?=
 =?utf-8?B?NXhKWDZlWG1VVFlURSsxOTR4ZXlqR0dET0Z6UnJ6cUR2WW1ia3JJYzRSb3NC?=
 =?utf-8?B?QjRhN0V6dG12OXROSnkvWi9pZ3dlSW1mT0t0VXRTOVllWDVXUmNKa0VYRDZz?=
 =?utf-8?B?UDNjdmt2SmFFTWpqa1RJZ2NhcmlVQ2E1Z2FHRWN4MjRndU1JdjVvcUFwMloz?=
 =?utf-8?B?MDFrV3drbDRMTHFXeHNKL2NQT3JkQzFBcVJRZDdmVElJQ3hnRDNndWtwcXZL?=
 =?utf-8?B?UmQ3eFBrNlliNDQzbVlDUjhyelh0dGZpaGx3VkdTZ2tOcS8zcmN0VDdEMFRV?=
 =?utf-8?B?a0Ivb0hic3lyamthWTdObHlZRVR1ejNzQWw2M21sOUg4WHJjQ21VTEcyZWVK?=
 =?utf-8?B?aG8xZGo2UnFSeVhvRWk2S3BNd2pXMjZQNXdoUkxhTGRpajV6dkhKcCtSMU5J?=
 =?utf-8?B?M2xNZFlnRlVWVlc1Q01salhTZmw0eHc5MFBjN3FRYUl2RmdIanVLaHl0VVR6?=
 =?utf-8?B?UGFmZkZsVEY1ZU5CLzRUMGNFck9Hb2pXb1ZrS2R6YWhPYWRHNUJkL0g4T3RY?=
 =?utf-8?B?SkNTdHkvQkJlejEyVUJES20zWTJnK0E5MHhyODllWXhpNjZTQXpBc1dUd25i?=
 =?utf-8?B?WnlURFlEVVFUR2kyZHZtZ2NJdlpLbDZPVjA1dHpPZHZxSy9lMTEzYzdOQUgy?=
 =?utf-8?B?N2QrRnRkdlA4RXlFNVRHazkxSjhZa1ZFOWRndVJzK0FnbU5ianNSWGdsN0ZM?=
 =?utf-8?Q?v1Z408GvGmnioVJwF+/zkESeGqJUnf9XQTMpDlGWDQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DF61DBBB50D2446B19726C5EC74DDAF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ozj07m62Ssxn3EwFDo157a5BN9KSBHU7R5V5LsiMXMB2QyYWPVBgWlwHd1HYqI0ohLNqIU4abKhQElRbjt8Go6m6kV6jvcJEDPbSyt6AedG2NP30xB5ytfrRhyUVea44VktT6kVktZLkhbVitNWHucYGrw2BKrFf/a+c9W6uWOclElLZoNREgQaAh9G1v5EMZSsTZtIdaI5I0XI7U7Tc1JtNmod6U4EwdItry6qM9jXEVSV1Ogs0ggNUF9IAV9GlzoiLLRMiGg7zIOTqo3dzZBudNe1jhEs587SB293BHcSwXDYwj3t/2x0FlkMekMYIn0wfROELMksVVcBQbNHUHozJSLYGyqhHstkjPWg19N6yH4mj3ugaw0frIWikdsGEa1I6tylbr1hdslFxwGGfCEetx4S9jBzkOJJQaxhX9aFAMpffg4KWOHF8T6t/cLQ+0Ws0pSBZyvIEn34YD86fc5L3AZXlMRbuv+/TO9V96lV8olZ2CcumG9/xWt395CxD73/Fn3R7Q2JhCcLjN49xnZDiHCHxNVe8CnXeZad7W7616FyAfRZd5UuG2XiQf3TWYPYSWumI1+snfR/2nsToh9lJm5hjPvwJTJo5J1lsoJvRGY5Ce7eJT3Zd2Gjum7qNFlbksRYjJi5+BNV1/NN9YJ/8Z4GVU/tqwQ1A6TwJZdexR1ie+uGe/IgcReZMy9kkTHf8qo9VUy/mKwjQ8xz9ZVo7y/cCu/IJsjIS1mgpFu534r1XMyf+iw2ZthEuGp7G+twsswP8exWfowT/1G6gLnm89p88CVuNSer4QuFcY6dK2shaBB4OKVBq6viXjHeQ6bCxdmpAHMVe6NaDyiQyLg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cf8e1d-b9b5-4294-d103-08db4b08921e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:27:18.6194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9OmbEcLsXuuyFnXv6LRDYUWGLWvIs0bG9ldViCvGqL4Rq/6BTZRsU1F8LSjl/+FfC/l7ZLuVQWdsuJhe9iT69fYg5bbJVExBToS8xjKPJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7848
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
