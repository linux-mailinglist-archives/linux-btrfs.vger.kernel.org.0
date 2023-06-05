Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2D72232B
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFEKPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjFEKPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 06:15:17 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E512A
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685960115; x=1717496115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=IfYogkk0VatwP3R/uVD0Zh6b1UZgi/PpLZQNPn2GQKB8RrecHf+4NXOz
   wqBHdQXvpCLj8I6EiAFc3EIScFKFBa2Fz3Rp+1AnJRWmLMNIzUvVFM+JA
   Zgbyj2wih+NDw4XNmniPhqVgxxkqGvcUvfMjEGvNXv86GW+OMgrjb51Xc
   9L7tlfHwLXjNrSngqQW4SQFnudYAyekGCTVpn7MJyqA+rqcUt5ZFv/aOl
   aLmoHz4Z7Rtz7T98a3rNhhz8/6oANnY/zsKEfWxQFRnE+YN7DChGe7nj8
   Hzgw0mgUtnoyta2pHb8VCltQ/WY9wOPZ14bmCg1EtpD6jiqTjl/n9hPb0
   w==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="230642434"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 18:15:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+esTXBKfqN/AO4SZu6z9Xt1HcO04PYSUzFRCjUSnf6qei69w8UEVlbxwl9TNZgZQSKydPIqO+w5tg7kgtoQODHsFydEx/OHmxZt5g1IWKll3UqX/pqRJ4fwuwZ2GEQAAq3Z47+aCiAKi0lgHm0KMH7lIvIwI7pz72If186GBlnvsDBLvSCQlHC7AlYYYa0RbpTDq4k/0X2af48a0kXcB4FN/43CWQ5PKknejLRS5qgk4dOxSK8MmFcySWbIQv/hSKAnhYxQxxthcg0IQNl2XIBDhUrHMO7hrr1pbvUexO0+bsPKi1CgiB9nvJiL0Awg/M+k78zjUivwmUarqrSzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=eY0RPp14IWiBdJ/MrfVTvXeodUq7YrfISiaNvlhFCvMQ44VPkLP9A7TByubK6t70TFeeFAYehoWgvyU0X8Td7mWgK8e5phcre432Uefi/A+zjmWXHITG25DWn1LImqC6z7qTLYh+3DbCBaoQW3gl2hhU54pkXx/Mb5RCDaNxpe/hulKIb4aIs/fmJS9mzcwFZo8a2lECxrZZax5dndn71I9fqsMxgnOER7fZJkpeptoFctOAdUuZ5j8tJKeU141EkEJ2h0QfDVWlCqeKHfas/yEp/B6ThPSRQhGgEzpeMoPRi1/TVCoa4wOfGae6CRJrEskA+vNN3DNj1um/qoDjLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VauHoKcCCixxKpNZCG5hwsR9XUv1FQRqPkCBoeXzfCJHQ8SRBpS9ehGGCVhQy6rsD16EsjouGLE4xO4LJsO5D82zpLs+bynYL9ZhzVCXyNHbGCCpcFk1GQYh8TOeqKtf/CGfJ+D2UlsnzWk8aL4yEppT7qF4HrcT75YhaI5upRs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7700.namprd04.prod.outlook.com (2603:10b6:303:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:15:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:15:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/4] btrfs: factor out the per-zone logic from
 btrfs_load_block_group_zone_info
Thread-Topic: [PATCH 2/4] btrfs: factor out the per-zone logic from
 btrfs_load_block_group_zone_info
Thread-Index: AQHZl4rrXfYUVyljW0GrrCasFuoFTa97/iQA
Date:   Mon, 5 Jun 2023 10:15:12 +0000
Message-ID: <48d39982-c0fe-a0df-c60a-b2709b0f2c58@wdc.com>
References: <20230605085108.580976-1-hch@lst.de>
 <20230605085108.580976-3-hch@lst.de>
In-Reply-To: <20230605085108.580976-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7700:EE_
x-ms-office365-filtering-correlation-id: 16a9b320-4f20-49b9-d145-08db65adbfcc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31VtlEsp3LEkzz4DxWK/S2m3QFVcUh6ZVI0OScizKfWSGNn0labA7lqPMvACI+8PO+sFO6ab2Q8oDjJl00tTqFTKOF9l4lgmpC/iJTvfAezm+zJ/p9Amh++oBn9lNZ3aFyUfhdbOnh4pZipVK6cpwmReoZW9JQ7woJ5l25vlBZa1inRiCWCCqWG1wMAs7lGl7oTDnNRDDSctuWXt1L2GVyYgmWLLZjnjNbwf5/qMzahBdn5DOWCmxSRMkA9CitEnwFtobV34YEpvg/4OFA0v4sO9sYSIbDZoIVe2krMZKdY/eZeSVxtSjJB5/Cgfc8WZNMlCpibnIaNw/1JC/lVCs39M7hXtKH8sh8RIv1piJ5W530Tbc6hzpPHnA1TeOb+R+mKftaR434vlmj92DAkBRx4TroMjIjE+odyRPMdu120Dh8P7yWJ2DWN3SK4gwMNQNIcql0RIP0htuGPvI/c3f1/dJY8D6hLMmhR/NCNId2i7Wt8ahmLudFuzsqLfpqqMY3DX0QSULlKhm7W3GWDNFLAci1JwcBVwB58iTotYMsOk5En8OcZJxN1RGtTBIEsrZIzT3SIj+WkXBCSer35uc+NOo3OlMRFMKI1XJv1Xs2JuOGjAaxNqpx6nMgcmD0hds2DoOMSmubXGnWIT0/UEMYx4dOH0vKX/rKRtrAQV0THYKFi/J0L743jTMMgqG9Qg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(478600001)(2906002)(36756003)(19618925003)(6486002)(71200400001)(558084003)(2616005)(38070700005)(186003)(6512007)(6506007)(4270600006)(31696002)(86362001)(122000001)(82960400001)(38100700002)(316002)(31686004)(8676002)(8936002)(66946007)(91956017)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(5660300002)(110136005)(54906003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTU3bURmVjViaEtreDBOMnMvYis3Q0hoUFRNeUxHdmF4S2dJWkJTMThUVFY1?=
 =?utf-8?B?cGk4YmFjRkJZYUdCZkhqcWVIWWRKamV6Sy9MWGlSZkVOaDlIRW5SRkVrWXlB?=
 =?utf-8?B?QnRsWEErc2pHR0JqOGxCQmtwYjdDWmFIYW1hRG5tYStWTmJSNkkyakQ2dzM0?=
 =?utf-8?B?bTVMMTh2aTBXYlp1dzVqNUR3bHlqOEw5ZkR3cDV2bWc5ZFJWaFlhWm9RQXVl?=
 =?utf-8?B?czBsZ3BQbHZhOGFtb25oZkp5Qk03d2I0ZlJZQVdSK1ZVbzJ5akVnWEdlWFR4?=
 =?utf-8?B?VlgwbzlHaHJVNzNZZmxvamhjSXFnNG02WHNGMllnTmVucWJkL1lUdDBYTEJX?=
 =?utf-8?B?cXYxNDJHQ3dpY3FjVDBuVytjcjVhRm1ERDNFQnAzUFhId3NIQVVKM0RHemc3?=
 =?utf-8?B?ZUZ4b1dMZytCcFhobVl1Wk50dUlqYkFob1piL3NmR0xtVXlwUW9NNExIVDVn?=
 =?utf-8?B?WVBPZ01rY0RscHhwcWpQUTZNUFI5ZEJsTDNBalcwVENTTXZJdUloNWJDZmxw?=
 =?utf-8?B?amVOVnpHMGNQWldXZFM0Qkk1cmtOc0ZrLzUwZGdSSkFVQVRXYnJrL1VRYlBC?=
 =?utf-8?B?M01YUTBqVG1QaFp4cmFEVnBvTTVJWjFNVFVlcnlISnhTaFlSNnFqcW1BaTdC?=
 =?utf-8?B?OWhPMGRBQW0vWEl6TEF3d1VRbWVaWENSdGlOWC84djQwaUNLd09QSWZHamht?=
 =?utf-8?B?Vit3eXNERDZONnl1ek9uRDQ4Yk16NG1CNWROd0poWGYrY0E1MXVKZUZKM2pU?=
 =?utf-8?B?TzFuK1pqcndYdUphWll5ekcwVTZCNitaTmZRckphamJTY1M5ZU9xcUJDdGxW?=
 =?utf-8?B?KzF6TmZSVjhqSldIWHV3cG0rZGl5Z1Noa3k3Z05EYjg3L0NyV2RFa1VUazVG?=
 =?utf-8?B?aVdLTm1EcVpySXlOVjg1VTVuc1Q0NFNwY0FhRnRldU8xWVJBRjhQZTBJNmVE?=
 =?utf-8?B?ZWtLL0ZBRlVtN25yblJQdW82QzBBWU5UeXlRT2dmODRyOEUrSFhzTFFlNEdQ?=
 =?utf-8?B?QUNvajlOMlJhZmE4NTRRSkhpWW1sMDNzQjNMeVlTcitQUUwvYWxERjFEbDNq?=
 =?utf-8?B?cm5RV2ZQN0dENXFlcW9oaU1jaXloc2FQRDlnQ094UnBhcUUrQ01tQklIMmlw?=
 =?utf-8?B?MHhhalBWNzJvZU51TURLYWRaMytMT3dyM1dGMmdZMkhGcGRUbmMzNFB4MXpz?=
 =?utf-8?B?ZmtvS2dZc1NVK2UyR0JVcEJSNTIrL0xtZ3FwRS9ib1NvanNuVC9EeU5GNW5v?=
 =?utf-8?B?OEVoQTNUS3JYcmFXMWVYcDAyb2wwdStGeGhhYm0xbjNLM3hQZndNcXZ1b2lK?=
 =?utf-8?B?VEhrYTdoblZQaU5wdW16dGlsZXQzWXVOMGZ0cGd0UHdIU09iTjRNdUY1Z2FF?=
 =?utf-8?B?WU5VdlgvRUpUd0pYUlVwTWdWTFF5TEk0OUN1dHp0Q2ZScFpVcHdqUFcxcisx?=
 =?utf-8?B?b3VRNEl5WXoxM0d6Uzc3Z0doUTdEY3psa1VOb1VpME9kYkpHcUliS21YNi9o?=
 =?utf-8?B?Y3RNSm0xWTlEVlJoWmJ6QXc3U25NeEsxclJuYndsVFQrOWpIRlFSVGthd2py?=
 =?utf-8?B?MGNiVFRadTV4c0YwWE1ZbVNScmZkTytQbGZlcnVIeHJKL0thYUFEZG1kdldS?=
 =?utf-8?B?WUJ0UTY2WU1iYzRJc210RVN0dUhPNVhaeURteVFVK2FQMXZMcjluYVdOdDhw?=
 =?utf-8?B?Y0JMMWo1aFpUN0V4NzBCM0hGVGt5blltcW5lbHg5YjBsU0VPUDF1TWI0b1hk?=
 =?utf-8?B?cHlza0xMZE5JWVZ5c3JEK2lwS1pkVEx1cTFJSFZpMGF6ZDlsdFF6UnhwcFdB?=
 =?utf-8?B?MGNWaTkvVDNWOGx6Ukp1VERqaHgwR2NNUGpGMjJpaXFGd2tSbS9UVVFZS2J5?=
 =?utf-8?B?OVNvWCt1OUsxK1dPQWpUYlJrV0xvTm1YSnNZM3g1Vkg2bkNoMEFPRWd5Vk5S?=
 =?utf-8?B?NGNCMzFPa21VM3A4czl5ZW9HSUVDU0RjaVgwSXpqaU5KbHp1MkJRVEtSQ0lm?=
 =?utf-8?B?OE1wRjNlRm9sZnM2c3JCL1FtOW9FL3VhZnF3aGdpTVg2Si8rSnFmWEFsbmJv?=
 =?utf-8?B?NUl4MlRZRkY2V25HNzdtWG95Y2dNbk5uc2dEVjB3OEpUUzhHZXJ2dWtjcGhq?=
 =?utf-8?B?YXN0OHNHUGNyMnZNMlZnbFUwNHdSVWxBUmlGUE1pUUZ1NDVaMW0xbjRsRnI0?=
 =?utf-8?B?RVhlMEVJMVAxUjFCUFpnWndFVHl5eUZodnVTWWZTNHNhdG1PNFhLWTNwMGxE?=
 =?utf-8?B?ZkROV0t4UENSY0FmN3pLU3cva1NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB9BA13C1DE3B9499C3083C9D58CDCDB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eEwkQbIq7RHV7jHIWnkn5ZLgQitDZtEZjYVHSLa2c6cauVYMFkivvJVb/S9MBnv2YPm8f11eHndqV/5QaI78UA4EnGDlEqLrgHTiou4cTIRTg1fQIqUOtj8vvepwpYSNoCgZsl577X65d0Dw5pTBHmUSl4ESiQLg4sUjQFX7LcAtRQm0IifxOJa7O3izUt/CONEZ+9RismR/oabSUFcT/T1hp4Fqy/i/XFUgSCbvv1F/dSJS6N39B4DBtdPhRFPzoIf8FQsD46xaMDnuMP7pApzM0Agdkuuq4fkr58mCXHRGEbL+/HvsJfFGcRYAjAhsJCfY8BiNpCFEIfHBKMwW1ztcvkeoP6OQdjy1+nsq9Fi6DmgYc7Y1Wb7ccUtEqsDR0dn6vTrX+cJ2eATaX+TKwc1e+XV8REzAgyYJRHXbRyGTUwSG1EiEHTZYSS+Q28u3GfEKMzWtSeFjeG6xb3jZAlIxM+/7U3t0gtCLq7cYJg/3XZdYhCWNvSF2TxwW6CXmusJUX9VElhUDItaY6FE7dJ3CSl8qaMtT1Yj+TITeGdRDksLz/2ztEMeAdp32aklzlU35lGahtBYEjUGRCJc8XNpq4jzmnOdYXs5NwGg+jF1xhUGmRoINV4JTFoMJZeKIPjpqJ99Dq9xI0wDW2jpuhUsPrKPjY3ETSLoAqgw7KM1OkRqgnq55m+tIVbnrI6H8ahOG2MgQADtCzvauhzaea7cRr8J2+0v7vftw0S12eV1bQEFdiyJy+/UqW8nVNoVStbKqGYV6OCRjTbT8pIbxqgqle0/NZdr4PTcyE885zydrBkl3Idk0TxsXsZtLLaupy/mjU6HpP4qEBsab/215XLBy6pT1yVBTce/IVGEjQYB1UuvYD1nTkOowz7FFx0E2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a9b320-4f20-49b9-d145-08db65adbfcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:15:12.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A40dVeneh708AhV+J+jnKkDYKY3OqvaR9TxkCgGjXB4ygVsMhZ+bhvMeLoHnE6tRJc5zIqdandMmS6H3JULyDGMPrS6u0MrGL6hSchzIzvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7700
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
