Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54136F4308
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjEBLsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjEBLsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:48:30 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00D46A9
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683028106; x=1714564106;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GKluuc1lRWSO6kaDTsoh+RbCLVBwcFCnKXzjV++PHzFFEr+pgLC06e3a
   rFnyAJhAZHQPqF2XwBbxB8HMVxVw6cbNGHrLBeWVRy7T4evcLl4kp/lPA
   G9k4cMknh/J4rNkR4cfxESot+qP6gza5E+0t0Xy4J6mdpoqIFAAp2GWu0
   e9lPFhpZTng8Sb7Mfeib1B29CY5fYRMMUglJyBHz2AxsOae8NzO70VesJ
   3WJ9wnf76YseRvQc64Ee2LxgfXEdcv6Z+KcegwBMAMErasgxx/LHgDvGO
   7gV18G5USQXrSh5ZkQz6D3iKlsnEcBkKdSW0/jQW37IqI5n3S9i4JIr9m
   A==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229740968"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 19:48:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3W68Vs/GjTq96jpqP+QCNVc/xVEe9gx3KCiMOfeoWhoR5dJBHYvYoQGaA8Qsg9fJpNIcf3m2mWCKkHb3bvAkwy8EvkzxxPfl5mykzWOlUdbGTW/10fgr//uB1zQhN4/T27lmliCgDKUMp6znS6wF6jzcx2AXlk/xfb12NUR84P8rAR8Kov8Pym/AEnaN1r07THhTxvMynRHqwpH77/3D7oSkDPYW6y5nbRgcwz1dEJLQOIoTKbpjLo2VssLnFgUulVFexP/F1EWj96OhH0zSNG+YynEGOochgqjYO7NyFTI4KLyITeDJPeo0zfu0Lccv/nAfVaf+ZRrAJeNjk1ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Df89fS9EdatSSoQlSrnEZDvb3B5Ka8UZSsq053sbqAW8+PZkxqCOgByJB0B3KwtfLVCXbZJnMrbTg3RJ4qMiSqb9sEUtGPOT/V4fJAG2oy591O06lk3Y3u/WmbGQiy9O0mBfAiVBEZn6NuT1BK6dZd81nnwSdIZU8dcPG5sE6AQR3mDW1kHBUdYiKKekEcUcbYCKBEcdwKCdP1k92hTFikUBLo9iNJ8EGdmpKSzmCpXLO7qWyfpzMvbCKlVhNgGJeTefYYCetGtH/mFBEPxGQNwuJh95NBZoVLuIWbeJNUyXt79RyqdIWXulJ4y1OXMhyB3l2g8yqVkB4maAYnpoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=qjgGoZE0+i58JX7szgMeKtOosqCr/d2sJrSeOUBEY9ODiiebSLt5A2H6Cy9L/n4yMtg3cPaLqHcrlQHMj7aTlkLZDgQ+tc23ZbEJpVZgCHrETrZDzXsjz3duISHWkAzZgLJrKqXg2fh72bnz1a35geSGeXujv5eo1ZJBVE30mqI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6752.namprd04.prod.outlook.com (2603:10b6:208:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 11:48:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 11:48:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/12] btrfs: use btrfs_tree_block_status for leaf item
 errors
Thread-Topic: [PATCH 05/12] btrfs: use btrfs_tree_block_status for leaf item
 errors
Thread-Index: AQHZetZHAL2PFjjbPUyuku8jSC6hfK9G4k4A
Date:   Tue, 2 May 2023 11:48:20 +0000
Message-ID: <4e0d006c-ab66-6f50-8cb3-9014c6edabf8@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <6536e8136f3da8b002f00151c0a12822792e7d48.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <6536e8136f3da8b002f00151c0a12822792e7d48.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6752:EE_
x-ms-office365-filtering-correlation-id: 268c4841-76b3-4ed7-971f-08db4b0320c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2SEwxKcbmdU1Gpq0/OdZNEWPHi0zNOY2hBSlrTN+NJGwc6+MaNjAdxQHhyjqTtVGMWJ39p/YJ6CDCeTvZOrSmnTSBIr5p0Wniep3znKafrs1xRPwIYSZLyt6dqy90MZ+lopNqIsVij8/al7Apn+7QkU1yNPHpZ+AuEHn/WHElH17oK+Ej3U50Cnjm7AJnLAH7tJvPEDHXdu6RxtGOCC3RQmFZIErLih4r37iPsOMwR8oOcHkaezCweVtGWXLf+i6gTd77cplFbzSbRTBEdjIdMYlfI4qZT+VMhUCGuKIrdPUMPocGf6BZye2zOQwz7Adt5th+O7x3Mb76v/7SCY++Mh4DYLN6sN0Fr8Pt/4Oke5z4UOM4oKl05P+pq/PAACZ3DWsEhltlvHKQ0uRGDc+j0bjXZeoFjpC1j9FrGsj/Kq+IRqGNLxm5EVbXRc8STT98begMdTHofIBlucdpjJpSxrey/Os14FCk1aYGiFooPTmAmqWIbalg6lLuSliDI7ZxoJ6Zp/fZ0/MN1Hn35sG2PiSapIGcrxsK6QqmuAzrsfte2MXG7ydY5/EryYYk3a/2yRzQvAl/c51n5NUUHa1RI+4/bRN7KIA+Vcb45qYuljdb747Lo/dYWDdd3D4x6ZvnI+9Urz2njvdy0nO/c0iUNFi8/PrRbkhsmbRDNy30M8U4JaU7eLo5A/YF531AWQ2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(31686004)(82960400001)(86362001)(31696002)(558084003)(36756003)(38070700005)(122000001)(38100700002)(2616005)(6512007)(4270600006)(6506007)(186003)(110136005)(71200400001)(6486002)(478600001)(64756008)(91956017)(76116006)(8936002)(316002)(66556008)(66446008)(41300700001)(66946007)(8676002)(66476007)(5660300002)(19618925003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVGQnVZRGJIb0VlbS9CeVR4NjQ4MmhkMml2UEhENml0UklYYU8xQjNnU3N5?=
 =?utf-8?B?VjA4SlVRWGNtNEkrTnFjNlNGS0pmc1FwcnVQcDJ5RUlDaGF2aXE1dFBpWWdw?=
 =?utf-8?B?UkNQc2xQcVBSaUQ2eDJCaTRjejU4cGVVV2JBZnN6ZDhSYk9yMXhsUjhsLzhQ?=
 =?utf-8?B?aGdwU25DbmZCQ2JWV3U3UXg3VWVDS1l5TnBHSG8rVmxyaXRUS094SythemRM?=
 =?utf-8?B?M2FhNzMvL3dRd2JidnNFZk9sTmpwUllNYXN1KytFRXZtbXRsNnBmblAvK2lJ?=
 =?utf-8?B?R09ReEFtZzNqSjdkUFFiM2ZFdnlrbEw1U2FvbkNKMjF6REpCOWZCVnZ5eG8r?=
 =?utf-8?B?bTZXb1hiUG1Ia2o3TXBYTGxPck5ib05meGJ3WHcrd2dEaGJXMUhwWUtVdkpP?=
 =?utf-8?B?akxVdDhGZGcrTjJHdW92OG9zRUxzZko1K3Z1OE5RN0tSS2VjNHczaXFNeWVY?=
 =?utf-8?B?YUFwMmNGdkNUeGppRmFwZG5ldzRVMEE2U0VCVHpENXVFSDQ1cG9rTGRkLzVJ?=
 =?utf-8?B?cTRHWUt4Q3FucUJ5YzVQczNPOER6dFJ6d2RUeWVjdHN4QVpGK1lKaDE4VW1x?=
 =?utf-8?B?MGp6TUh3dk9ySG9XQkZFclpqdmE0VTBRWXRPNUkwRUlselZMRWYrSVZVR1hT?=
 =?utf-8?B?d01kWHIzaXVQR2tNOEhWNzRCaHVmWTR6cUlwUkRLNHJTN29QKzBnaXpLWE5w?=
 =?utf-8?B?NXZObFArdVJhSmY1NTJMY09XZmM2bjZGVnBCd1VTeWcvZUhvYXRLU21tZFZZ?=
 =?utf-8?B?ak15WTl4b1NScDhwdUFlSTV6NUlCandIRTltZ2NEc2NNcGx0UDFIaUxkVlZZ?=
 =?utf-8?B?S1pQNGtQRE5lYjQzSkNEMlkvVmVZTkgwZmc4UFZCSi9oUXlraTFhOVA0aExl?=
 =?utf-8?B?aXlvWGV6dkNNVmVwQTR5MzE1SUtuS0dacFUydHBaeWtlemRIT0MyU3BYRWlP?=
 =?utf-8?B?WkN2a2FoMzR5czA3TDM1aUJCblA5L1VLZGJubzY0M2JrMHFZMGE2QlViRVpS?=
 =?utf-8?B?cVRYS29WRVNLQ2ZsMlh5ekZycE95RmlpNlZmSTRlN0RaM0puOU0vc2hiTUh3?=
 =?utf-8?B?N2Z5THhTRzdlZldHQnRFVDNCd0dJOEw3R0lSTWgvaTlYVisvQ2VhYUcrRU82?=
 =?utf-8?B?eFhSeDR4eW9hckVrTk5keDlFcUN0NXFxTXdTSVlaWG9NRkMzU1oxb2gwRkFL?=
 =?utf-8?B?ZWhLaExBY0QyNTZ1d0w2bFd4a1J0YjllaU5IS3cwSnJrTkFOVFZKN1V1Y2pz?=
 =?utf-8?B?SkVRUFpRWTY4QmxjLzk5aVl4Qm03RXhFVWVZbUNaR1FyVnhEejN5VTlrRUVh?=
 =?utf-8?B?ZzlFNU10TVFXcEJRYnFYVHd0ZHNTai84M3lFUXpSR0lzWWlVbm5yVUVXZVZz?=
 =?utf-8?B?cmhxcTJoVHl2dXR3V3J3Z0RpN3ZBbTBxaHlBZy9IQmUzNWoySkxnbkg4Y0Q4?=
 =?utf-8?B?enVKMW9nM3lzbGpzQlk4Mk1QVXQyOGFjYkFKSWQ3ZWRITXhTMUZ6U2xSa2Q1?=
 =?utf-8?B?aFNCanF5QW9qeHlSQXdmZGJjQTFXRFJWWXJnQlRCYXQrWjlwc0thaXFZREt1?=
 =?utf-8?B?VzArZFhXMDRhOGFYQjVFVnAxbTFDTFJzaVVLM2FldXdzMUNmQUxzbWhNMzc4?=
 =?utf-8?B?WW5ib05aMG9PblNKT2EvOWNqMDViQVR2MUR2a01ZM21JZVM1M2RYV1Vsd1Zj?=
 =?utf-8?B?emduYnhUeThJcm1wOTIxOHBrSmxqWTVTb3YyV3pWRyswbVFHcE9LWUF1Zjdk?=
 =?utf-8?B?OEZKd1Fhc0N0T3RmY0w4MmNuR2hDRUpURUlsSm50SVBwTmZPTnBudVlYMVVh?=
 =?utf-8?B?aEJ2L3JweG9BNVB5QjU5WXpXZVVieE95a0hEaTBDWFNPcTdMd2FqSW1yQjFN?=
 =?utf-8?B?djl4Vk5GenVJaGRKbllKcERMaFgzN3Q0U3FQQTh2M0krbDNpUVV0eDFrd0pO?=
 =?utf-8?B?c0dpa3Q3aTR4cGk1QS9nRC9BK2pISnF1NW93all0SmdXR3hxc05TZUViRm01?=
 =?utf-8?B?V29PQlhpNW94TnRaT0hSMWV3dFQydTJPbVFyd2R5dFc4aXhMc21lSWJWU2gy?=
 =?utf-8?B?QkFLQmpnT3llUnd5QmNTZFVMS2tkWmNsd3RkZXAwOGRsT1VLdjNJRXltdkhl?=
 =?utf-8?B?RU9sZ0lFdUJuRTJrWWZsajR4aldtcFhHTlUxeGVoeTRvTTJySTV0UklPNmMz?=
 =?utf-8?B?aHNDYjMrSVB6ZDVQaVpEWjlTcEFkSjBFdUdBbzNCL2w3THIweWhYUFlOZWZx?=
 =?utf-8?B?OC9DZ3FoSkVITHlIUE9FTGVCbEJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5546C6C87947C4BB9BBC1A882B08F8E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b9EbvFDqSjVKgcR59sYQJQNguQnRiOUIX+ST5xM9nrNflVRRZWcvqaePoHbnaNc76bOpprobi9axLGSmye282UEwOO8ddBX5AL4pNeqfV1ouWt4+T+pm4I2nCcQm2WwkSBvpmvU8e64xqjENp39s3LV3B/Cn+e5Y/MlF7VkwEEMYUVVL7XCqTNNbCTFb0+qzp3a/5KrJ6irthoSAHNWG43lX0PmoqVdLq01YuGR9HqbUoE+WeYbZQZoc3kiZ+Q7Z10tVpkI7rY1Ga3ww0YK3AMgmCyhfAcs7bsyb5r2NrmQty1lQg1gkDoqU3s8f+79WAMcbLB2UyTSjjqD6U/zYpJTvv9SeMtSBoIEgSxFxL26CqXOcYmyH+9TxMOEWNV/NhJDgN6myHjxs1mgl1yHqFGnARhciuNlb3nVJUdD9NOgI+6yk1pbyn66RtuYmj3J1F1FslLi8J3z4OFU5N/ojKQWdHdCEvRNRIRvD2vqKGs01cPdcNFm5zbtXLD6kv7oojmZ1fWjg0xJuUiXlSx4a/BJkayZTajXG0Y5UE62CheUbiN0z6302IJQgVAsfBllHPiQA9KISUiF+oQbgdum0K5q8RtSb7H/p74ObJzJTKygmx2dldJp7r7/sk64xV5ZgMjJVnC52UF85Dx2m2+SJ3foYKXDelcrpAgQQb1V6eHcX4ZQi1BtyIwqHfZmmoKut6HcgXR3CVDzLIqcKyuxBpvYlD+NtnTANxsgtSVCTygU37Z2rIH002yPqfQEJWqQK4a+dpqyye/Flhovm+SbRL054LR3reaKsfZsPRsgRIPUb9z3XZgDYj/bw8StVVvTcYzvbWCG5qwwvMNvUrN7E1g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268c4841-76b3-4ed7-971f-08db4b0320c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 11:48:20.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxKiE8+9b/g4NWd3Y569Y5ToXL5uEUmv9TxfiT1NoclojB1c9Qp5JXZEe1Nn+wZhjaw/Z11RpxfqUtQ2HCJMYVepLVpYe43KoPUVOigkGvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6752
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
