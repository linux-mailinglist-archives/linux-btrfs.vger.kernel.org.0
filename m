Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1288762D918
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Nov 2022 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiKQLKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Nov 2022 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiKQLJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Nov 2022 06:09:34 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE9D3FB9F
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Nov 2022 03:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668683352; x=1700219352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q79CK+57fl0Qlc8Ral/Vg8v3ZQXgDKJxr+zW3NynDfk=;
  b=AoSC2J6Z8Zfr88EnpXsyfTYkZ6qUtY7S8ms0Cd2Cfkh11zq/AAKMgx6a
   H5vuZvz7ufr5sJ+ieJvRF46V1b0Wh45RAn6xrVa5OyrL9f2U+hQt0wrGe
   cailAI0HH+ABANVHwpN684b30cX0qvJxoonHwnUY6X9V58s+4m4dyuVW7
   E/fWFSTdhzadVnN0KPkOvCpO7a7Lirmu6fMOzEb6R6Egpsv8smVBU7WiS
   572PlcczIxnrrIBMG4RtPhzW2kNRZ756pTQ7BOXm7zn/OlxJGNZAijWgj
   fqOCkXWGUgzvQHNtDp25b1kadCFqBOFiIX46jRorLIRla4m1RsYi7BVBx
   A==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665417600"; 
   d="scan'208";a="320853059"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2022 19:09:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7cTtiBMvLpcwRCOzm5DMEQ7yfXK1mY6HK6WF7w/+L7tqnYmqKZLNQTUsS6eLfgvazc3X/lpqvc2mLN6Ed+r5XvivcLEA3GxJRO/bk6tNrB6HaKZfF6DTb0UQGTMPBFMRZc0U4RKYY1rHYA1bK0644yInAi1rubp/R/2f1qF4hbqTEToUbPyKtBYj5bjM4dhrC9pTSgro7OPr5bzrjhPbV5rcEGeP84mtuj6YrFkHIjKJfqZuQD4nzUuCpr3xeqqPlgbfzH/a1EVNoZx2TeZp/3tFVskwgtCh37CuMIij8Kh/2MDIhlXfQbDwiWgHShB041Gh49PA9ZDWQf0h+iZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q79CK+57fl0Qlc8Ral/Vg8v3ZQXgDKJxr+zW3NynDfk=;
 b=caOdWWPO+Be3nO//+0BdRzr1M4z/tRSOO5TCeExneINP+0YmAQ1bHgs9VdZ3Di9jxrdMtYiEF93P0/b3cDKOAFglbrjEJoy4IKxkpV7ULHjALF7O2BtIB9w3ZFi/imcj2e6pMO9OAwfW+tDDSugf0atl0VMN+ViiAzaERY+xqdVbaBzKtI/u++e8gVw0APxpSbukr/cwndxPEvDnSGDvvR5MDno9WJlLtKupGP32XG+vH7dBIAlriwuCvMgSS/omxgu8EoVom49LKeYT65G8ewm9dCwUMvGn570H16zO5pudc5V+fpEB3z8fi07sBL9rc/hSU0h8KaUp6dpbRKbs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q79CK+57fl0Qlc8Ral/Vg8v3ZQXgDKJxr+zW3NynDfk=;
 b=XlF0l89j3XXWeEzXpNU1fPNV4uDhHgDdueR2PyEaSuy2jrbRUQad9xDJUk4HK/QtkcgSLPjXQUSJd6AbZLGlh8RUk9rVg0O+BtuNZSFiYDkQoGpeVO0YbAWFLasIyevcFv8RKkMbQsnhcIScKejemlcH/0hIHhddf1WJfakemGU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7587.namprd04.prod.outlook.com (2603:10b6:303:a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 11:09:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 11:09:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking or
 setting extent bits
Thread-Topic: [PATCH 01/16] btrfs: check for range correctness while locking
 or setting extent bits
Thread-Index: AQHY+RxqyvVykLyy+U6hLqEzftgSk65C980A
Date:   Thu, 17 Nov 2022 11:09:09 +0000
Message-ID: <563d005f-613e-5f15-4f84-82f170050635@wdc.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
In-Reply-To: <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7587:EE_
x-ms-office365-filtering-correlation-id: cfa4a09a-26b3-48d2-60d9-08dac88c2699
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdkCnsLzWrsCBu+USPjJJMO/8l0KdhF8tFEYwE1wKKLxGlA6mPZsC1zQGb2PYnTYg3QQOzzdak1hmva2n3C6IOX8+tOJCx3OB4XAgK84CpHv5wWNpasqCj4cm15GpjtdI6W/u3oxAZFfAx7N2UAEJkZPMWP75lv0Cw9OCnc+BGlLD+70ArHBE/J5vqt7P135/bP0BqVj5O1A5L+2lhNXC1U6MTcSJViVmoGVjU9P6slp9NCDlvBsbfzainN8W4xquaR8l6MgLVLPzU7bpNsmkji4o5COSj2xqdb+sn+wcrifnxSJxjkn9aCC+XyJ1d2YbeWN4MudKq/WDiO1kHr8J691UuYKh+1EiUdNOXus6zB6PZxZ48nL1+N9D28LUapv4W3xKUy8ew7r88Fb1LffCiLD/i+wtlmju/K6/7nGuL1d+L72F0mEv5j+4zuUIx5nXH3K0q16A3NauJW/+sm5GfHZNXmaDLoyRdrWo53YW60bYkORN+AAdXwYd33ZJGJWJeICAR7IoLc1mFQtAc9zQgaak1W+M5GqEqs79pz1vn3iDLsJkPLVRQCwqNmM01CIXE9yrEurSov/lOZUSU+9jgtVomGbIUfVpitxmD+wzR3LBbTDTISxp+5M9CAPKz9NTETIQbiClctqqZb27+Y+NyNhmvaEAmoIZO4CX6NuqZNMzvLp6Gz27dUbx46O5iFirr4e367hKZKbcFjia9dwTsn2BNt8g6JGMNyJpER46UqmEWBXcFn2DSrwsRud/WOpuRkZXBRecU9gg3fHG2hl8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(31696002)(86362001)(558084003)(64756008)(122000001)(38100700002)(38070700005)(478600001)(71200400001)(6486002)(6506007)(53546011)(66556008)(91956017)(82960400001)(66946007)(8676002)(66476007)(4326008)(76116006)(66446008)(41300700001)(2616005)(316002)(110136005)(186003)(6512007)(26005)(8936002)(5660300002)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjR5elIxOFl3L1ZmODI1TGJ6ZnBmb2hNS3IrRkFkT3gybXNPamkwL3RuTk9k?=
 =?utf-8?B?a1F1UlRkUGtwbEFYeTVPRzluWHNBSFNmWXRWSVlHaEc1NWZCUElxK213Yndo?=
 =?utf-8?B?dHVEOWR3cWZyNUoweU03TTB1Y0pRRHdiQTUxdzg2Y2dzaTNHV0UyL1dxaFls?=
 =?utf-8?B?aVA0MXZmUUQ5NXY3TDBSdzl6eWwvR1lycFhMYmVIeHpERUdqaWZDaWlWSmhQ?=
 =?utf-8?B?ajlRbk9BRmxSQm1tTmFYeWMxZFpaZHF3dGo0dmpYOG5TUk9YdExsc0lhK1RR?=
 =?utf-8?B?VmZqMlU2MmRQZTA2RUN2dzcwb0Zhc0UvYk93QnJRK3gyQ0EreTU4Z090VW5p?=
 =?utf-8?B?NXFhb3B2MGpFUytQM2Y2K3VTWFkvaVZlelZ3Z1NGWmxEVkVPTjd5WTlqekZ1?=
 =?utf-8?B?MStQS280Z3NTK2tVc0ZVKzNKczdPOGNJTmQ0Tk9TcXN3dXNQMWdUTXlSNk8x?=
 =?utf-8?B?bGJTMjlnL05KS0pLMS9Bays5MlZuMVg1b2d3ejR4YlkyNCt4ZThQdk1IaDZT?=
 =?utf-8?B?N2l3b3V0cWFzRHJvSUk4b3pDaENuVVlQS2JrUXF2aEEzWEpFbE10M1NmY3Ar?=
 =?utf-8?B?UWY5Qnlhc3VSNk96cjVBQkx4aXh4ekZNa1ZlQktpWWpGWjk3UktvR0wyUWhm?=
 =?utf-8?B?V1A4WTBIK2M3c1I4dFprQVNNUlc5SXVLdUlnM1VFUlAwU2tRM2xCaGNsZUZa?=
 =?utf-8?B?ZjU4dXV4Ymd6WEJ2UzlHWUJqS3NpUGdFVTEreU4wVzNrLzhJdlpOWFNoWHJj?=
 =?utf-8?B?b29oMjlHcERtZWI1QkJ0dVpFS05MbkdQZmNMbWJENk1jbnlmR2haekFsbFp1?=
 =?utf-8?B?bXVmNE01WjVjODhRYk9mbi9wWnBydU1FQWRMOGhEL3daWEwvbjlwMmtZTW5J?=
 =?utf-8?B?R3p1MzhtVEw2dVBHclUrQzNKb0xyaVNXMnNyOEMyRHNOWXR0SG9sakJVNVdh?=
 =?utf-8?B?YUt6YUZDYS9JdWUvV1dsRisvZVFBZzhvWFBLMm9QbFJwdlBJTmx0R0wrdzFE?=
 =?utf-8?B?V0EzaUMvUU5BYkRsdjZ5RmgvUEhuV0hvdTlKWFVHMWEzYXhGVXFPNHpFeC9U?=
 =?utf-8?B?TkduMUwxL09vVGhGcjFSemhRUExmZi9ORWRMZkpveDhuUUZZOGR5dWpHU2xI?=
 =?utf-8?B?UzBsSWhRNGJOT3JCZG5TSE8ya1h2c2JBU1pITWRjdVRnd1hVclZSVm1BV1Ev?=
 =?utf-8?B?dFpJQ1JYbGJURXkzR1JlTjZrN0xhMHE4TVB6a2Y0bEI3cldKN0pBdlVMa1hN?=
 =?utf-8?B?TGVGeitsdStVb1ZOTzNWYzh3ZmtDQUM1WGQxb1ViOFIvb3pkc1VFMTQ0STBk?=
 =?utf-8?B?MS8vK1Naa3pIS1VRc2djUzBHTklHNTJGOHI2ajNiRFVhaDNwZFBweCtxczRK?=
 =?utf-8?B?blNMMGRldEVNZWNrUkdYRXgyMGpzMzcvUGE3SWFXNGRFS3VMUEVEaU5tUDR0?=
 =?utf-8?B?MlphclRTTGwzT2NzTFpTTHQwV2E0U1RLYnNhamVuWFFVR2VNWm5obHcyR09a?=
 =?utf-8?B?OGZkNDA3eXpQRkovVHlreXg2UFF6M0o4SmkwaHlLeTRmNVVRRCtKbkFzNUll?=
 =?utf-8?B?Y1FvUy9OM1c3Nis3Y1J0bVpaRVhkSStkQnRNTHNzQVZCNFNnZkFLTW1xdVd0?=
 =?utf-8?B?Um9aTFhFRmdtemZNSGZtU1V0a0JiRGZOdXBuUFpXa1JTTjliWit4ZUIvVUFi?=
 =?utf-8?B?eWkzUkJTVEM1OVZaZkpmWkVTWnAwbW01dmxlM2owNGpWVkpqMy9tdTdQSXpX?=
 =?utf-8?B?MHpLNnBibTV4Q3NBNUZPZnBLUzVzQVlNZkV3QlREaXdyeU9Bc2EySHlnS1U1?=
 =?utf-8?B?Ym12MGFqOTRWMEhQUGJUcmNYZDc2dWZKM3YyV2VvQitwSldMazJyT3UwUG1X?=
 =?utf-8?B?MGpPUjBldk01NndpUkVWemhUbml3bkpJajREc2lkWjZKWlBCR0dXM21Sbjl3?=
 =?utf-8?B?Z2wzbzNlYmJxNlkxdUtRTDVYSWRUcko5bWx3QkpkMkdJYVlsaVdnd282OC9F?=
 =?utf-8?B?UDhhNDl4UzNtNnFCc1cxTkVWeU43bzRGaHNUQmxOcTdGSURxMmdtb1Jzdm9U?=
 =?utf-8?B?cGxqaXU2NFBGZE1wOTNFM055K2dHVmFtMkkzb3R5ZUJramV5REVPZkx3K2tv?=
 =?utf-8?B?dTZ6L3Nyb1RzS01odHpPaDFFczVsdFA4MzMrSTNHK2NwQ05PcTZ1eG8ySEh1?=
 =?utf-8?Q?Gp77zDjbjLAFZXjYzddug3U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <273F9D8BC5E0DE448D7DC859A8D4A634@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eFTDNm9eIeHnJw2zn4kQV/bZf9obqyDbyRQXqO2ssHstwIKW61jcFgxNuSWOhoCwe8lQgEcq5pXsjM3j6wiCdukbQimpKx2kCdOGATGhdFp+OFuiC6azHtByVwGVKfL0HguIhHmDqCU2zT4Lr6Ad7Dxn+OE/rT2JMEs9EsCbA+5p5mclcbFL3sr7EFB2a0egdz+f0Ss5tEw0wqdronP70xsWVhpjd/7fwUZuagIF78072/mLTBD5SwnBxPNUFmaublqa4u6tEiGbmqNlBIUth2egIjhZwce7H6VoPXEGjtOw1G78mUw3p0lojRg43OQxm1ODy5VYvcw62cViBmkAq31m17si2muBgEFAydKzyzSBCZaJkdgnwIf+KFRu1DqVxCDEd96ljICKydB4bisLeLQVJp32wZ2BJvEWYhYiKQ9vSEgS+yVR27aBqX7Rjv3ex0S96KWa5yj7BJRi0NH74/XSDLbAy0TBswlomKyAF96ZiLauA51tb+FWUWh63QyQZ4r3YL82HDRqoOkCWk6Qd+O2xV71nqEN9tLlw8zHDJ1bqEnKORUzf6OweRrciNZELjhchthF0G1dKKf0R+qVtdbKC0S8YBfb5qiyR8Vanoo1pruPMczLKZlFBP3nN2TSRKM51lT2PYWr9kaSTiEfxeJyDKxhAjfA3Bja0clihdDtYc9zl44wDqv3oWjuNjiEo0mbQ/pBe82mH/jNBSlXPJvwjueOH7ZFpGZymej5H3mK3JmNLBQn+gA+ENGPgu54SDxQSqYXntOTArSrmjvwCzcRw4eySvORpW0jRtLBWpo24YKkHq2n4w40DueUBgNfuYoTem5wj8Q9oiw6cD880g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa4a09a-26b3-48d2-60d9-08dac88c2699
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 11:09:09.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJbyJoX4XKSxsCWYZ926IYJOEZ7qaleKAZxRvQy3Us4yH0cLJ8oZNeU/QT5JCwCy4MLkEZir+zg4uJITVa1C13PKxxt43bPIABuCGwvXJS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7587
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMTEuMjIgMTk6MDIsIEdvbGR3eW4gUm9kcmlndWVzIHdyb3RlOg0KPiArCWlmICh1bmxp
a2VseShzdGFydCA+IGVuZCkpDQo+ICsJCXJldHVybiAwOw0KDQpJIHdvbmRlciBpZiByZXR1cm5p
bmcgMCByZWFsbHkgaXMgdGhlIGJlc3QgdmFsdWUgaGVyZSwNCmluc3RlYWQgb2YgLUVJTlZBTCBv
ciBzaW1pbGFyPw0KDQpBbHNvIGRvZXMgdW5saWtlbHkgcmVhbGx5IHByb3ZpZGUgYW55IGJlbmVm
aXQgaGVyZT8NCg==
