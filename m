Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1887AB22A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjIVMcB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIVMcA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:32:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CA92
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695385914; x=1726921914;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=PUkBWf0CRjaCfzOojpgc0cyOrUvoZ5QfYBLOx/AfiBN1jx9t+mspPs5M
   YM8ufZHrI1+AUyYZ2u5aeLMibzMJvfbN66x5tsC8IPf3zK/qvCnVzsd8U
   yu2xZ6mA1SvPleKw2vPK5yUkRlecewdN2Bg2Uzclout73hBLViHIF7igA
   KMzLPkPCYOjJmvD1kL0uOkLgddEeGK70q9JMpf1VI1SpgmmB87Vt5cxw8
   cm0j61QspEnP678NsqlLdDXevaw4XvwAHzZILJzgWV2mAd/W4JJ5byOfK
   zq4JOaliXMXImn9l8AI6Qp10P7C42isstXGvEj09OwZVc7D89AtvSVov2
   Q==;
X-CSE-ConnectionGUID: Ta7ke5hAT9GxXVEgpEFy/g==
X-CSE-MsgGUID: CaKBmClJR262MXOLyAYQ4A==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="242821972"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2SZSv+j5FSdKcPcDDwjKIf/5ol30VeqclLMqInkowQsafSzKzp9RIDbimu2CDDdyRRXsLX5pN3dBiGq9HaMdbx15uxB1AmXFQyuYx4Qjwq+tsM9n/Li3baxiH39m3o0AA/uYJCu/TG94dHD2HSGyJ+eboq9USoTTclf0ZOaTt3HMKtb1fsfrSrv2/3IjUSWbqnvB57OT7P9gFVkmaV438zlI5f2+exn9ICHE8T4CMi3jKqPqVNtWz2z2EYfyFcCyx5CPHXBhHjYgA3ObcNk7SSeypaz8aXixHW4yvji9SIhbhdRF00dIcuf0WP3OMumDf3zWNVRRIEFu2RYgYN2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=mU0vp42FIn8T+BXhn6VPckCrh9/0WCGG1ShJW2rcnRj4YBju+0pQ6YVbZk3x306oSU+gS7441ezeHm6eFLusR2Qv7kecOLUig6iL6BZFWjeHx4y6MsgHz7yIJMmA6X8JnivZoHlp2MDKlvXVg/XAojWl9lYmZPfVwY2KffEGZ6PMSmh0F/7J7lS2lBH6dydHSirzEzChUWGKFo4JnTzwoCuP0NgdV/8szZefDZVnftIMjHW1SgqthsVKxPpzYnd6NCwFQDJvbvW/2teoASiKCM8VyrMWoaQWnWpPy4I3BJ0t8FycoJnRdS7lTPPiHBBziLmT4PvoG14AD/3SJshpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=LiG7pJ/hINKLSz55HNPtsaZy9aMFVux7EB8xzpt7eHrQ5y1kh4tKdc3gB9+k6UEtj9x1ZdlR/p3BKKxdKUwhJ24lfOnxtqaSqhN0SpoIxaM0orXiLEuThDlY16fAv3+Zbk5bntLQK6ry4qJPoYBedjM5/RtQDzElIosOuMda5+A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Fri, 22 Sep
 2023 12:31:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:31:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] btrfs: switch btrfs_backref_cache::is_reloc to bool
Thread-Topic: [PATCH 5/8] btrfs: switch btrfs_backref_cache::is_reloc to bool
Thread-Index: AQHZ7UXm6Uw1KQ/hO0i2zIYaCH0QLLAmxvqA
Date:   Fri, 22 Sep 2023 12:31:51 +0000
Message-ID: <efc7f081-61d1-4c73-9cbf-fb5a4e6aafe0@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <a6570ecf163983ecc3b057aab71dd3d76d8a5307.1695380646.git.dsterba@suse.com>
In-Reply-To: <a6570ecf163983ecc3b057aab71dd3d76d8a5307.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: 72bf3d24-a98e-4de7-7f79-08dbbb67e5eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1R4LSmZ5XmUqnLly2R4YGwhRS3rMyIxvr+ng2gvcJ8ImAMkdXlGfP69D3f5ks7MTVzWcF945zi87jfCVS2zI578Jlr7bNdpplW3tprjpwNnajOi02zS8hZX0rf30aHzONdF9xB+tSv6MMz/ct88Sy6eP9rn+1lRG3hp1WOc3TsqCxtFBvI6WKN6o/aBc8x67zlbL7KTUBL18Jz/w85Fb0I61U7WKUzicItsvei5q4mFo5NGZG+1eRChTyBSOiArdlT6Tot/VnEz3xkI9C4orSCXlIKZHO13iltNjXDWpmtFhUweb7/CvXkDnnfaF56UBpLQfrMtQ4mLi//D32XAyefUivm4RXrf9fDLk2tUiVPVVkb8zMawXNto/L/wHhavE1lXm7eWvGiEv1DDHQczteEQnUwnolB3tXYmO7MtT0mZQe5psVg3lCw+QLG9X178MR7OQu3CywDVrWHeKk0t4mdssjVjvmQV+D1ai7HGWn4Kn34/0kbcPhniRFOqjWzQoYOlGXrcFr/ltnTumVj/lem4wGAdPiEO7lhPQ1UKLbyROZw1g/5odTh+tKWqotAUip2x4pilB0DPD8sXbBODDakBUJaxuP2Kd+O+X0xoxhsxhMK6bYnZFkjvkLv1C88JIAVlufgjqQ29imUutKWJAxuDS0snAisC+pkCoaLTUDJIsf5A1DnWBmtwpimFi3Mv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(31686004)(4270600006)(6506007)(86362001)(38100700002)(6512007)(66446008)(66556008)(76116006)(66946007)(41300700001)(38070700005)(66476007)(64756008)(91956017)(71200400001)(110136005)(478600001)(316002)(5660300002)(82960400001)(2616005)(8676002)(19618925003)(8936002)(26005)(558084003)(2906002)(31696002)(36756003)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHFRTFgxbHJCU0hFTzhxQm5KbXFCQkJFVHFLOW1ncjlVUlExMXRUK211SkxY?=
 =?utf-8?B?Z2c1Q2lWNTdzNENtS3JFU0lJdDBFbzNHTWM0TjFIb2kwV0M0Sy8yYXM2U1Z1?=
 =?utf-8?B?Tm1vTGs2Mlg1REgyR3VTNmlWcUZtQStlbHc2NGpyVUJjZHRjNG9RQ2ZxbDFH?=
 =?utf-8?B?VzN2NzhXWHRFMDVqTEJoN2wyTG9qTmFWUXkrZlo4Yll1ZTZIMkhOV0hmOVVp?=
 =?utf-8?B?aHhLSEZGUkNidzQzVGhzNjlMaFJTMERFZ1JNTU1jVmU5WjNTazdmVS94c0Zw?=
 =?utf-8?B?SzlZdTJpVmtmREJTMEZFb2tOUkpvUGRzMU53YkZmRGQzY0NnR1BtNDRlUkdL?=
 =?utf-8?B?ek1lYVJ2ajVEcEFvWnBvZ013dVBtVTA4eXNhaUZvUW1SVTI3TkRhK215RVRK?=
 =?utf-8?B?M0RackpLSjAvU3JteHlpV2pxMHdvWjRQSEtrNFZ6OFVQNVVtNTV6MXpXODgy?=
 =?utf-8?B?L0RxalpqMkFlVFBmaVdwQ2IxRzNGWUs1TnlCa0p4SS9GRWk1NHV2MndkYkxk?=
 =?utf-8?B?TnNVWGgwYkxuQ1p2YnppcENVWThwNUkyQ2ZwZDl1OEFESUFQWGR4V0Uyc2gw?=
 =?utf-8?B?TXdMcW9EMnR4Y042SXFoN2swYlhscVNoNUtmVzkybzA1WUZBWWpmRWdvUHBk?=
 =?utf-8?B?MXExcmQ5RWl4OUN1RTE1YlhkZElhVXNDQjkxOEpsNjdJSitwdEx5eFRNYStP?=
 =?utf-8?B?YVNLdzlKZEg5bGQwUjFzOFlOa1YzSmV2anlRWVU0SVp3Tk5JdG15RWhQLzJD?=
 =?utf-8?B?SVdJbTZKV2ZHOE5NZnBxM0M1dHBuUmpCeWxDeWpINkF4WlB6RjgzaEFydWhJ?=
 =?utf-8?B?QkNiNU96L3B0cy9iaHpyak5NVkw2T3JaSENIU2lTdWZmS1BIWENCREFhVFRu?=
 =?utf-8?B?L2lQMUMwTlB1NjYralhsUSt2TlUrUWtPd1NOdnpQN2xlNW5acDNiaFZVeTZ3?=
 =?utf-8?B?VFBreFpHYXU2bnVtRFgzWTVkWmxqNlZZdlhLcUdZNlpDKzNFYXUwMkxkbHd5?=
 =?utf-8?B?eVVmdWZpYVpRelpBV3JCMUpBMTg2WDc4b0lIeC9YTWEydEJuYVhsRUZiSDdl?=
 =?utf-8?B?WjNYWmRpM2wwWC8zSlFGT1EzSWJuajVlVjJLZEY4TzlocDV6bFY5RUFaUk83?=
 =?utf-8?B?SEJaNThBcXphMnNqUVZkMU01ZXNUUnY5UTl3a251djA1Mjh0bmJielkvNEhV?=
 =?utf-8?B?dGxRSzVvVGZrV2J5ZHFNdHhobjFobFdLVTY5TFhwank2NTE5MWMxUVNlTzJk?=
 =?utf-8?B?QWsyWWpvelB1VmRVSjg2Vm5UbnFhbVBuMEpJcmhkRW02N29IMytqZm1JVzBr?=
 =?utf-8?B?MTVZWFNYUWIyODZxMDJNaWYyajRNRDE5Z1J2Uk9WRHd1MWpIMVpsZGVkeE1p?=
 =?utf-8?B?cjAxRjRBclg0VkQwSHZlU09hNVUvNnVCTHRiYnR5dnljTmswZ1h2dmpHbjBJ?=
 =?utf-8?B?eXBwdmxHWW9TRDdTUzlUTlo3NXEzQ2JBUTI1Q0dmMk0vdHdCVFJFbWRORFZi?=
 =?utf-8?B?ei90OTI4WnIrcVoyVkNCWjQ0Q3pBUTE1M0VHbnJ3Y0ZWblR4QUY1Ykd6Uk5s?=
 =?utf-8?B?aVorMHpiYXhwNUphQWIrRTJDV2pIRmNBN09Yak05TnpOaDNGcnNXcU5KTEZk?=
 =?utf-8?B?ekxaL0d2bGF2TE5Ta2cyMjVYaTQvZnZ1Sm8wSU1aVUlwZ0R3Y1hnc1Jqc0Y1?=
 =?utf-8?B?VGc0RDc3aHU1Q3ljVHc0NVJBK2s1N1cweDJkYkp3L0FEQVZUYkYrSnhhaTNh?=
 =?utf-8?B?c05nZGlwUFNuZ0pMa3pSWCs1dExqNm5wMTdzME9EY1lNTHdLSUdQaHNXc2pR?=
 =?utf-8?B?TjVHdHUwVVBFMGV5WnZyNkpQR0ZvMnZkWkxucXJpenFic3h5eGJLOWJibzc5?=
 =?utf-8?B?bE4yVFFSNVQyWjFYYXpNZXJoTHdJUXB2cXlsVVpkL3Vtc3VLbGhZZzkrSi9r?=
 =?utf-8?B?TExoeTYreGtDellYYVpCamM3OHM2YVhJamFJbVVaamdaSlAyQ1lNVCtSTDZT?=
 =?utf-8?B?OXA1SGZldTBWV2pCakd4RmZtQTFxR3hqYmd6VUdLOFNXaXpvYjAxc0pLRjZp?=
 =?utf-8?B?M2lEOUl2UFU4aU1UaDNGREZQQi9XdGJvVm9XVkZvSVQ5bGp6NWtsRTJZSERm?=
 =?utf-8?B?OU9pVmNISmc5YVZ0Ti85TEhDbEcvenBVOUJiMHd5bzh0Ym9ON2d1aWFXaUFU?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EB8FF9549C3B4BAD6B44812489A358@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KzaxXNIG6Bxv+NmxNAzBGM98MN8hLp0cN1rq3SUO7pjrXUpVc7yswHl8+1wtVgwW4oWljghwScrTBQGGUYY7om8WuDJA5qoru0ygBT1fACh9x0sBg49c2TiPQxEFcnYct6wv0fqauk9J9L2hfmNFoLZ3zy1XzZ6OdqvKv9W77KbENLtbA1QnVyuqtUVPFIvufyybnCTIkyjczhI4kOt0xY3nW3MJz+cQHW8+mvoDsq6df4ZPnf06gngGQ6tt2P0BgNGcm/70S22H9G62OQNiqS4G+8pJJoQuKzLkIgLpOHHL2dWpxuUWUHq5Bq4J0xKepGrZpAlC9gNAuzPBpsMZyJN8AW28hOKK46BoflKvyjSRSIN/bhdkmrdrDV2SFXhLZHxAAuRZLXRK+tt9MkAKD6pPqIg62x2d1WbpupJPvt/da5wu1NT13C9YLDvyK0mvkiZxsZ0CXO+2oIvMxs4HQJM+NAYJeBz9lxxo/mpkfjSNILhcC0e+aleQTAGi69nQm8DL028KIP07qiMEXD2993GU3fpJjsmTIzcDnMaMOZ3I7Q6YF/b6Q+whD8F060WTfqfGw4zUhFqkb8psJ6pmysY1Hy2NM5bYtucrAjPY8PRTkS7EGJbXWtDpRy3fhI8Yg0ZwK+BjpS53gSb/9KNfQzOxeioTIWm3M5G0lo7pLtBAwg1vULtP6Wg+W1yuGAtR+rMECnL3ctzlHYXFJFPYTFKvvIT+6G0TRRZbDSc9zn6Z63L5szOStx+oZ8bjd+3KLDl45CnbTlUq/pHw2Ep6+Uj0I9kUFMYF5iQsCLUxHmPGvHtcww5y4yY7l7IVW+UC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bf3d24-a98e-4de7-7f79-08dbbb67e5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:31:51.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saYhhT+VLKuRaKdXHyMDL/VM4ND2O5LmMY3YeSbp2RiB8J8HzhWP40ULnA7nY1jUEzLRq8Vu4G6aFhrkdcGaFsw6KW6Owxku5lvoe8XJAv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
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
