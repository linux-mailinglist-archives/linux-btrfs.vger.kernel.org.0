Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406E26FBBE3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjEIAQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEIAQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:16:07 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A449D6
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591366; x=1715127366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=NoqHq1vgywM3zwx400HvSS9GVRqcTbsd8aat8BK/Ce9JWMliUNP6MPGc
   Wrjdy4YQ5RkMBPzV7nOmThRlHYuYcJ8ebJD50oIa6cbaRT5CVqXMJVKzq
   DOEsdMvqikpdq4cwDQmJN18TpOLytMD7fN21ckXwsR80LPl5c5nh7IVbJ
   orb+lS6NAZ7oytQBtT/hRxQxGS6cKnAqcFLvG3wbKLtE/tcWwN+KLT++H
   YtmdM+ls2jpCKQ3NbL8qb6q46gvHhvGlVS5fP60ZAgEJbtoJkevzPOJdp
   5FGxN+C0Rru/Qm0KSVQ8dWhvzYyyogrb4OgqzcaXJWlcK7Wi0lkiXbHnw
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="342233689"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:16:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaZJRYJJXyNy/IfHLt0UICC+U0YIT8p78bWupvFNjOvMdExPIXDLBkKvfAC+6TuvceLGpsKA+rj16v0bjWcCKoaMsiq4qhP+p9NoS4aMc1VBkU2lr2uH9eHGzielmCeiLSEZRquW7N9poFjSD96097Vby25sK8yh8Y6DTQo/ajZav/RZpQt/ya+HB192K/82doAFeyXI9LaCtYGwO6ahhPQ8fyYf8pYyPdRR8U/wiJ0czkwCsdJX0ruPx/bdoFcUr6lznCDQkWOdVY9wdmDwa6ienEshTaXGn5P4E6s56ZjHSkwu4L04T5BItbbhTwSY/32eFe0opUUaqNR1CG+Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FIqtaZx5fuvKz9N9Lno48PpwxutaPqi6cuZmhCXbOspUg5dxe7ZYX3XKVKobXrDuInQDQVZ+Nwh9Ario/D2c5ROsoqw54KNjxkGMPgkzgEXsM/USbgLJo19sKlmmC/zMX7g5oMIund0gn8cCEEP/0CXxFTCSVEOV508TjtQ4uJ8rfMlQVtLOGLRs6d1LSEiUV58M7XMx3A7Tc7ToZI27zXG+JUyogR3EOhVHOXfDGw7MzoXn5WOl8/EPiV6TUHV0uLHfCkvzo4i3cD9aZryqxSEYLEZqdGB+KmAGy1gC+izAlrbmz+Ut3wth8PY1Zi/EtSE33nxtMhh7+5sFPn7Qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KSf0ogVOo3QtLZv1GV1a0u+n4QnXt366LR0EYrh8sWk3EOeLGCRJj5uYcuGEmGa7Gqsiwr1MUWFfStUBkFcKcVkA5dpmAQNBH99q0MJKPbGKo4tVXgErCcvRunE47jizAWuwbp3gyaj0blAcZHp7f3C651YR/1/a7iI23HLOMlo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:16:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:16:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/21] btrfs: use bbio->ordered for zone append
 completions
Thread-Topic: [PATCH 14/21] btrfs: use bbio->ordered for zone append
 completions
Thread-Index: AQHZgceFX3+3lvgf1kOekSMp+UMlTq9RE1KA
Date:   Tue, 9 May 2023 00:16:04 +0000
Message-ID: <5be9fb5a-e27c-13ca-cc13-383909c9e69d@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-15-hch@lst.de>
In-Reply-To: <20230508160843.133013-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8093:EE_
x-ms-office365-filtering-correlation-id: bba4e039-c271-4ffc-f648-08db502293cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StMuQ4D3tjalsTAptqVNcPC4ujHtex6AtZWNgTaGBPHQ/8J4a+VJR0fF/EAJOuOXZN0XvEwIRVk5McMwopCgnCoIbS2ofVegkAXNGG/jircW2Zwmz507wENZfFFGph5iDPODjluOkpWVY/u1XOdHkEJ0qOjg9nxYB3LBrEd/tgSXsVksMbURzZodLYA3YiYNxWIVVaE4Qj79z68MUEIakHP6pzGo4Iv29umE1QvkWY0/sAfil26oinzG+x2yo2ovwSaKbrQ1k0B6B6AE2puucygKl78KJTTmsoaftsZFOwKQqLCn9ahypFhcMr38N+1v5S55IP1Y+qI6NQ5UjWlFoOsQUfMgGiNt43aHSO7soTwSeFnOHAS9mE03v7dMUkNNh1Wzfefj0YHzJ+I6VXYnKtbiZD94I23ibcW2lJQABA7VX8obE8pPiZGnGaPIEmDn3sIfqueb5xLv/lfamcHLplrNDXmZJ1jlzc0GNH4BDsx2j+VxcJt0vxVSUb+oZ7veEiOG/gxQuXmahDfCXgnSCxv4MqWJd3ENom8rPdsnHsILIpmmg6VIR0zome/ePkTZCZaGcUL9f0b3nzccK6fc2RHmhOgwhNyFFpKMACt4MRNAd+65SwN29p0sKYD4ac+2cwsOSzn4E3fFzdM+jnPcPqCr8ZQpdnhelP6e1/i+P1eVKn+1I8BoXK08cCoKkvGR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(316002)(66446008)(86362001)(558084003)(36756003)(31696002)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(19618925003)(82960400001)(38070700005)(186003)(4270600006)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3R5djdZcTFrOXRGdVNGTjVTRE5qY0ZZTXpxOXRYc21oVElCZW1CWGttL1E3?=
 =?utf-8?B?M3FaQU1lMjRob0tsRm5wWDBZei9CUFF0ZTFaUmRGVy80bjBYM1hZYVdNS3Qz?=
 =?utf-8?B?ekpTQlZkdW5QSm9HaHhCVWJ0ZDEwYS9PWFRrR2wwTTNoVWt4THc2VW5VenpP?=
 =?utf-8?B?WFRHVUtscDFVMzlnZFNxM1BlWTRXMTk2QWhwSTFieVpvdTcyRzM5anpmZnNx?=
 =?utf-8?B?dlJrR1RCUXRSekFtNXpveGpKajJ3cWF1cjI4VWJmNkFsaCtnSjF6L2svcTli?=
 =?utf-8?B?K0tsYkdKZnJ3TUlTb1FuTkhTekhndmszT25ia3lRSlp3eXdTajUxWkJEUjVu?=
 =?utf-8?B?V25JeWZLZnNlTjdZdzZ6T3ZzbHhUSHBZWGFGaXQ0OHhRK0ZmUElxOTEzcGdv?=
 =?utf-8?B?anpWektIRWdSZWV6cnZERlgzVUtBWnFjTHkvWFd4aGYwWWtHS0RNSjA4Nnh1?=
 =?utf-8?B?ODNsOVhPQXFKQUVjMVhuVk0rUU1qOGMya3BySmRuSURtRVNoZ0tsU1pkMlNm?=
 =?utf-8?B?N2o4Tnp6TjUzTTFKck1rMCtKTDJsU005SEQ3blc2Q0UvT1loUE5veVZTUTdH?=
 =?utf-8?B?eE5YNURqUWNDSUxRTG5BQ3YrQVZtdTR3R1o2MVRvRWV0ckcrTis0MlBaWWxl?=
 =?utf-8?B?SzREWU9uQlFnTGRUeUhqdkdSRDBPdmVmbXFCQXhHb1ljZS9sckdoSm5lbmN4?=
 =?utf-8?B?YlE3RlJDU3pqSHNUOUJrb3Y3YWdxUllidlRaeW5UUENhQndXU245U1VReTla?=
 =?utf-8?B?M3U1MXQreGJuQzhHRXNVUzhoUkNzRGdaSDltcVBwT0dpM2o3dlFCc0hQSU92?=
 =?utf-8?B?RTMxcHJ3VkZybWsyVXkxMmNrSmF6OHpHajZSVXRVeUdzaVBJTmsyeHB3K1gx?=
 =?utf-8?B?V2l3L2ZpaHFMeG5hRHl0MjhvZXZUN0JJdUxlR3F6VTRiSVJZK3hBcndiamE4?=
 =?utf-8?B?aHZ3d0daUnNxeVpXUW5sQWplS2o0US9MdFN4anNqY0xVNmNMWEdtREpHdGh2?=
 =?utf-8?B?cmExY3l4bWY4aEVuUlh1WGdQeDBIVlhmL25QdXlzSGNLK2FiT2QramZ3K2ow?=
 =?utf-8?B?TEhTZlFoQVJJb1B6SjNrK0NLUmRjS1lxdXRNVGpTRmd3SkZMbVNvYXV2T1BD?=
 =?utf-8?B?SDAxZTUyMWNNQ2NHM2grZDNXVk15dHFYcExnSyttU3NtMVljQ1BqVXozQW1L?=
 =?utf-8?B?ckZ6eEp0alJjV2dOVU4vWUZZa3pWVk1VVjZkd3NhajVDQThyTUZmcU9BcnU4?=
 =?utf-8?B?dlpmUzVFWDMybHhLaklqYXpaZUpidm4rSUdUa3lqUUlwQmh1cEhSTFd0bDlQ?=
 =?utf-8?B?SW5ncEJWeTloWElvdy9LVURXMGVVSnpZbXpRdnhlWTZPbHNkTXNFWVhSM2Vp?=
 =?utf-8?B?VFYrVk5ORUJ1YXQ2WHJ3NE1TZnJkSll4MlR4RFhZaStRRmdOaTJwbDY1YnQx?=
 =?utf-8?B?MG9ILzJ0eGQ5MFdsZ0lMMDN5cGswMFV5UFhmVk5sWnVsam1wQnVkcGs3TDY2?=
 =?utf-8?B?ejdQckFBTFBXMjBIT3FHK2VxTGhUd0JxdUozb2x6MmRTWVpCNmVGa21POWgy?=
 =?utf-8?B?eG5CallhMkZUZDJBSFZLYy94SWN0L3JVUGFUR05XRUtRSGFIaE5KcmErSVRW?=
 =?utf-8?B?eXJ6bjI0aVBoN0g4NC94d3FpQno5M244dVJrQUhYRkdXbzdCSUFHVUk2WUht?=
 =?utf-8?B?WUNWN0NXb1B5djVIbXh5azNmS1pDQnpUUCtwdGYwRnlyREMzaGZSeko1cC9Q?=
 =?utf-8?B?Vm8vMHY1VW85R2hSelZrZ0pqN3Y0bHNmN3MyWjB1L2swTW9SaGVpYVRqNG5Z?=
 =?utf-8?B?N0thZHlIcGdYY285NXJLaTNxSStZSjNLQzcyblR1cERxbXRPOVd6U1hvSTBk?=
 =?utf-8?B?YmxtQ2VqOS9BOUdrT2gxUFNReDdOSFFxM2NibDdENFJyN2FDWlI2dEs1aDhV?=
 =?utf-8?B?aVNSS0VsL25BSmJXUFZIN2dtYXNiZUVxWXV2T1NWTEcvTTJCdkErcUNTWm5i?=
 =?utf-8?B?RDZaTUR6WTgvVFMvMURLRlNnT2VBOWp6RmZucDJ0UkZVLy8yemdiSXpIbWJC?=
 =?utf-8?B?bDZNZS9Wd3REYzRhTTZhdEpWaTB2VHludDk5RnJVb1doZnlHKy8rYUpVWlR4?=
 =?utf-8?B?dEdQNTdobURpZm5TWnAvZGtrZEhkbkpHTUM4a3JQU1hVdHhxQ2hCNGRwZDJ1?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DCE5745DC415146B0D99D48E87E149B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FBlKnBFPV4xyXrOB7pPj/mcuPzNbq+Kw1TJz1X7O5nuzj6KBNLtYSVsZkVF2GkLiVltf/mBQhhQ8Gyvy8nzqN0thitdOj6dQt4RZ0iEYYwGVEN8yovUNxZU65rCV4yxHhKkeAVyp56b9NmwXj9O0RZqX73LsXEGKRU0wPP2qSa8KLApqWeq81V7jEOQz7qn+A9AX5K5Ypc+UJa23M3VroS9F4W5itabx/KOPIifh3jF5dvGVxjSYppwJ7WmWIAJaRyZI1Xb3sLnUOlc6x6Rw9qf1dSUoPXnzLL46dzXW/DzcgnMWXJGBx5W8h3SqM0zF9gTUT4iACII6LaQvmDJOVWePfOzthjNnE//+Cl1MDsenLHo95jR04ohl8re2RDY0ANWHlGeWWvRa/sHoqtEhI6KSaLBEZKF6YRhHd2hnFNjilSVi2Kj7bLpUEfIPsUmqxrVAPWu01Ykyuz1fdwrX0LZV4HSagM174XSr44ZKG+URAvZ/zp1EbdSt3/mBA2PGGS1YTcO9Fe1AFu28B79t3DUshyIyFYqelnNR75SzLxt0Jg0x1MuejyDJ+PL/WLqmY6Nfqo1wKan7dg0/XmV1bKwVfodjsY9Lh1C1PPEX92pXnvhj0U5nKzL7o19+fTG/Ak72ta3dJAdghajv90p7TMBUy3DR79MKrl5vFH1BupUYSZfkgbogmsISfWPPNZg0ELIvdeRWjuM1mWRfFYsl/1CPZEVzMCiZuv1rzQVJkbfUT1oc3x0bcS1QO9Pvx/SHOgYvQYQInxpSOiAUjZ2m0kFGiLmTr9IghvCj0Kjhsjl5FWmdaV5H6bVfFBQbDIkNHrAB3KOCWY9ywWxG8ynPfQnbqrIFy+ut6olNLCgLhZnJNc1zKkqBVVQKkipJQO14
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba4e039-c271-4ffc-f648-08db502293cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:16:04.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFvhFO+5MS4R+4ocEn1IY5MuHZu05VeDV6wN1vyUSYcbOynlhfpe4yevyBweSwnUdej0bHXmDHFpMXgpo790ib6cVGWiCoLxdk0J6fFITCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8093
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
