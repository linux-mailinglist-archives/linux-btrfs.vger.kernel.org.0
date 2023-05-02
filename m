Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90E6F43DF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjEBM2Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjEBM2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:28:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B71A1
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683030492; x=1714566492;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Rg3hjB/V23GeSKO98VqFLX7MTUpHJG88O3ApaZASK8fuhn0Xdb6feDmP
   X1ihRKe0rBV0kmYQNww208TzBWGDE/g1WlfTvd4VKmmWWDgHSsXjBzQAt
   Edh4IlP9SrhzIxwoud6N/lrw2uyOd1BvMb7WVXBN/2p6XZfhbtl+etMYS
   hP8bPsmisQAKprnDZnHLd+l79rL+54nourhNu+eHWtUmrgfB8yuhFpP4u
   XjG444H6DfTnd7xB2SpX0yqTnvS0qZAsmbCOTbajADv+c2+SKX3YEw6Jj
   NkfPYfP0QrzWMl6AyPTqPrLSYNVz58OjKXpOYyqrPAgLDv9v5IXGCS7nr
   g==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229743102"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:28:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc/79ls0/PHO9tO+NojyhILwd/3Hz04dTSmViF8N1DusYlGypcq9RDJQD91EqgfVij0aHm8HAVNbNvThHjsgEbHBA/yGOfK8CiNiOR6/if0fAhT7xgja2PAhgCBNEQUYVtge/4c2phOWg1NUV8DA9K55ewBdphFGPs1cM0o368PRu0i2htRsgIpkys6LXkT8rMSJkx2ilI/Rv+uZRxlhc3KO9+B0BWKg3wT//le3wZtZE3UCzGvRxkQ3i1LOL7p09fhEj09ewWzLjelKYCaTePJy+6uZR9/s9ZfIMVLMKmOG3uK1FHHuWrKtN+dtoEFP9hXCd1iAtzuLF7PgNbyb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dThIxawyNyn8ZSuJ8dmaNHEctwOCyHCGwBht90f8BW0AQBHxiKBQrHvv/QB4QmEbn1y/bYWsLWvKvVsqwmLHyJF0+QxQzHJrEvdZCTG2Y6RXYj002S+LR5WcjnFdp8++06SkGtOGmvB/1qbM2X5GHIBKmYXTR6gWBY6ZMcEVOyav/Q8PcsB+E29gERdc5C4K5W2uSBp7JIm1cJzwm6h1sqs/Gtc77MNlKuJ4gjTQOZTkafr0I0KRC772/ot7pPmpzoqn5O2f+CZ5hRtboj6lWCI/OijaNsZj0neoKfAymy9Afxcw0VojpiQFOVqe+3FWgTlm8AUY+bS5wtqWbrIuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fEcUwqDQSgmO+JN2Rq01eZWCHPLhMr89ZhbwToVIxNGZ7JGWMDgeW2tv0EbAZ+dHU8/LyFGCidvqxdC5JNGwk1Qd95riXTFCEQ/Q2A8O8NnqYkOQX3vx4xUIp0Oqtn3YXkWvc66MbFkja2J8UUpohz7Bd+I38xCIj9QzhUIXVVE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6727.namprd04.prod.outlook.com (2603:10b6:610:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 12:28:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:28:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/12] btrfs: add __KERNEL__ check for btrfs_no_printk
Thread-Topic: [PATCH 10/12] btrfs: add __KERNEL__ check for btrfs_no_printk
Thread-Index: AQHZetZPsBVSXoTkBk6u+thKXvZJ569G7W6A
Date:   Tue, 2 May 2023 12:28:09 +0000
Message-ID: <7fcd37d6-225c-763a-1e37-ddc3f7a0a854@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <284c95473545a5e08904a691b5a7de55a3c5263f.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <284c95473545a5e08904a691b5a7de55a3c5263f.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6727:EE_
x-ms-office365-filtering-correlation-id: 0c66afca-fa80-4524-e119-08db4b08b096
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKXNc5rTenFlqmY2cz7vTv/Ki3Pr41TY5BunMpNPdMTmkwqwXsQuR/RL/bwjsjngAF/yG5U56ITWiQ6l1Vw71STq1zrG1+o7Z0CsmZcmOcWH9Sg06jGfpoxL7XWNLMFR9uvCD25Vnx2Q83+h31FTLqSJ/hHy0payNfHXzC7GuSf9l8zxgfYqAmE3+66OWB+MxAS2icKDX7OE1hFIbXtIwGoCOeXlFGuJe+j1tQdHyfvyOcXqWl6z5RjBtuY4L/o0IMxSo0HhIIdYf6KYV+6Tzs4vVG29FM79lceTwE7vpHyNYvHl55jLPU/qyYSxPBxPh/qN8GZN50wgySrOloBZjpF0H7ymnXi4FKXJtqlsooo2NjUWFNkU3JENtiDKbHNnqAhvBnw4uGAcYOyuap+cZOAq3UOuK27jwLO1k+WdREiwhv+U8MCgtMe2J+iOegPzbb1ljaawV5yVS0s2rkBQ3CIyMRs/Wg/NeG8XWXtJIR3YLv3vDzj81Dt6h2Hto0jYNl3CcpD5MCzTw5XlvfqA3biZuUd1Nj54B5fFr5wadE3O8tm/Qw6SBXiMOK1+hSpKAm7YDLd99G/+3Qc77WcHu4/TsYho/idi3//4c2mJkR/X0jyH0seI0A5OyzqitDuxq4KcHZ+RdndUXVFHWV7HGLq4TyoGWzlBxKI9buj11M4BJUHSn3vLNtrkm808/gkD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(186003)(6486002)(71200400001)(31696002)(6512007)(6506007)(558084003)(4270600006)(110136005)(2616005)(31686004)(36756003)(478600001)(66476007)(66446008)(64756008)(76116006)(66556008)(66946007)(91956017)(82960400001)(316002)(122000001)(38100700002)(8936002)(8676002)(5660300002)(41300700001)(86362001)(2906002)(38070700005)(19618925003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZob29ya0ZoOVRqenpjRHZyRXJxM01HWk9aZXB1NnJVUW5MK0h6L3gycGNv?=
 =?utf-8?B?M1pGWUFIMGpiZTI1RU9IajVqTzdVb0VzbDlqZzlhNWZaTW9TUTJSWHI3ejFI?=
 =?utf-8?B?QWRvTCthSk03S2JjcW41akcwa0QrNFpRVEh4VGVvQnEwNE00dkF6K1lWanJC?=
 =?utf-8?B?enZjTkVBdzMrTTVxWEdrZTh3YnFMZk5uTFJFeXlxRHMrR2NaLzl1ak5YNWdS?=
 =?utf-8?B?cnlXYVh4bFlSZnNZRFM3dzdqYmdQOWJPV1VuZTV2akRGMC9jMnd4dlYyaU1X?=
 =?utf-8?B?ME1RbHY5SXh1Mm1XcytRd2lzTDRxclBuVGFyZHRWUXliaENtOWJOL2VacE9t?=
 =?utf-8?B?TkcycktrT2pVTHVpc05tSUgwMVk0c2JZNFFCMmxpQmhBeUtVa0FjMjFKM3F6?=
 =?utf-8?B?OWFybUs4c2JucUZsSEZtd21RcHo1YUV0Z3dHKzdSZmRDUm43YVRSS0Y5bVVo?=
 =?utf-8?B?Mk5aNy9VZUVLLzdZOGtwcXpBWVJ2ZVRoRStzcXFobDJMK0ZkNjRKM2ZnUjVo?=
 =?utf-8?B?VXgxMmxST0t6NHdwR3F3ZDBFb2o2cWtzOUJwbHAvZHFiOVA2VzZtMkJhcUhI?=
 =?utf-8?B?UEMxUXhGQ1ZFNjZlelg0a3pwaUNNWHM4TmozQzFCdEdRM05JejlXNTFieWtm?=
 =?utf-8?B?dXVqQll2U3Q0clM2T3ljZHl2VTAwL0t6MzhnSGJwUUNvUG5OeXhWZnpSRzFP?=
 =?utf-8?B?SHphaERTZHI3RWs2dmk5OXJqdW1zdm5NRmo3N1NNR1RRN01BcTNVckExdWV3?=
 =?utf-8?B?MTloTm5VN3NTOGRicDJDdkdzWGZORmZEZXpXS25hMnRsem80TUJRRzNUajVm?=
 =?utf-8?B?N2dBMEVFWmxrdXVYTENKYlFIaUY0RjJmRUlYVzNJbGZTMDEra21yekNXMGFY?=
 =?utf-8?B?clhhdUFldU1ZYzQwVHIrWWlBSkt0YlRlLzBaWmtqRUcxYi9VTnYvNnpCa0tX?=
 =?utf-8?B?YWhvVkJHTVNSSWFuMVVpdkxRaHlacGpvSXdGU0U0WHhHeGdPdDFHZnZxUElo?=
 =?utf-8?B?dFZ2anUwWkxiMmw4dWZOLzNaVTNaMno4bThLYkV2RWJxQnNWMWxHaTByWnAx?=
 =?utf-8?B?U3BaN0ExU1RmeWxrWUFYZjlvZWwxSjA5NlBYS2h4QkVvNDU3dWtucEFaMlln?=
 =?utf-8?B?Ukt6Yzg4cnlISWpBMElJdCtwdmxlY3VtZ1NyYW1qYXc1aGVldFpJeDNPZnRr?=
 =?utf-8?B?NWxMUGNJbGNGKzYySWg3bWhScGs4R20zVWRCN1d2dTdwSEIyQ2xxNWNBUGN3?=
 =?utf-8?B?WXJUa1FCeTUreEVva2hKQmlsRlZUN0ViRlhNMncvbTB2eU9wQlZXTkJ0NURp?=
 =?utf-8?B?S0dpd0dlK3YvSFh5cXl0ejR3SHBXNHVLVWhheTJPd1RKTE81bmV1OEdLUnZS?=
 =?utf-8?B?MzkwaTllaFpvVXhsMlVsSEdKL0RkVjVySE9NalhNNlFFNG56Z0pLVjhqTnF3?=
 =?utf-8?B?L2JSUityajdQNWw0ZGV5MW5KM0kwdTMvTEpzbTF1N0hUODlZY2hMWGVPZ0Ns?=
 =?utf-8?B?UEt3bjBlZ1NpRmw5VFU4N1pzdTNIQUNyL1ZiViszTGhKRGcxd2ZmS3owVStJ?=
 =?utf-8?B?N05kVHZoazFONEdOVFM0WCtFQVhHRmRueWJRbWp0REJjQ2h0UXUzVmpEaytj?=
 =?utf-8?B?bG5BeFNnRnpGcnhUeXNoNXVrM29QYmFmazlXeW13QXUrT2FoQjZMalY4TEVk?=
 =?utf-8?B?YTBEWXk4Mlo0VmZFbzM4WG1YSXF2dld0NHB5dFFxRTQ4YTJNTE9UTWpjNXNa?=
 =?utf-8?B?S0V4THFPdU51czYyN3lia2duNU1zUVR3dkVnaGNNcnluM1RBQk9QMlgxdTFD?=
 =?utf-8?B?M3FQQnlYaTVxaWpiWERDcDNiUGpLdExXbEJ0c0xDWVppOCtVWTNZQ1dOb3Rw?=
 =?utf-8?B?QnpUY0gyN0FoQXJSbE1kNkpEVlRaUWRrcVVJeEZoZU5MbVJ3VTNiRnV5MVRN?=
 =?utf-8?B?MTBxTjVyRmw5WHB6bFZCQzZTbzFoTmRHWUdha2VHeW5nUEhNd29rbFEzVnRt?=
 =?utf-8?B?bCtwSFhkaklxYSs1TVdDdERIR0laZVBMYTVpS29HWTArUXhIdEFtVjRFV2pu?=
 =?utf-8?B?SHB5eDlVWGIyZGtUSWR0OFhhRmoyU00yNDhVTDJlanpPejJTREhMUFJjR0k5?=
 =?utf-8?B?Rk5LZTU3U3JQV0VLQkYyYUJBWjRvVys2dHpsRGUrbVF5N3d2YzNVV1RPeHNv?=
 =?utf-8?B?bHJCblBENnlJZ1A2NUhDenJMcDdFSWFQREdlUlVoYjdQOVdMRW5jd0pYNW1P?=
 =?utf-8?Q?eT+HQt1zD5u54vgXcWpA9tJ1aCJT60BY+tqvEsDgCI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39585353A106B74CBB8FEF9F7C52A962@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gk0aYIbLnYBLJ3B+ZDoGrr2noy5yQn5WhgHeh3S/8TDLfcud/vI2ZcUYnkgBIdxCfLxRHJMVbzIcHl2yqp5lbNXvHfTr/bnX5g5IrnjD2B7PwxLhECgZL7s3X3pcnal7q4Bsf6p52yojpFa+hiJYur3IdfsN5bH4fY2Y446FHoxsJx4ASg2Su0I9rdNbV+k7Tc4e+2AjMXBQZRxj9SNEY3+J1n2pLYpv/JiENIro6OyGTvrRoztF6NzgJ40oR7BzxnE0HO/D7J/Z78wxexHYUbb3wUAMZPA2GkDTUl36A/Mdm9CaHmWJYulpww8ZC7z+Qj9DoLreSzv2EMPf1xwIa6qIhe2QEiMap/Cwbm4sbNrypkwA/tRBqGzlwDsoNSscY6uL+zyP84vlieSrjsIAL6VGKcwq4d9uvvjz6sms53VNO8mRPGmWw3mdWZAlxH8MUbw76ZuTgj1U8VOf08p96hhvGngbd+ti+Yk/vPtMy0XpmeY3Y5Qoj423YdfgCTDCScxH+UOfaSGp86VjTZVwst+03CenFkAJseVpoy0f84++pMx5TJBwmHXhUId0kbe9PzPJhVz4uabNYIKhAO1tmoUNKbxH+ARfMn1iNczyAwggnBvqumsQCYhVrzFHN68YrzeVnQPdh8Sqhr+X2pznCzSAbdHcVw1rjFHm+4xdBw/63kvc2A4nX8KUYTwRK/exP5Vr+x1ZvWChVMHpqEWkyvBrfUWRAl59KhdrgbtdhCThWyg6mIRCcwRM7SbdWo2Nv3Ng8T7mCzd2im+qB9ckWnCnjcbz/wHKOmopbvA0b1kTF8Wdz9Ip/6wILsl6/oM13QgueyuY3EkxvYSefE+/tQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c66afca-fa80-4524-e119-08db4b08b096
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:28:09.7164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftWfT4CsovAuFKAUZTvgojRIRDC1flOmFojHagyyJyjeoOTyahew/m5/FugUS7tTYyx8BSsdWNLCcAhL8S3IrVAqBr6kex9kol/0hH2j7bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6727
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
