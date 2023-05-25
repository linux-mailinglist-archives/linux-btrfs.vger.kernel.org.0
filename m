Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0397C710A6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjEYK6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbjEYK6n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:58:43 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68BC5
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685012321; x=1716548321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bk1haNuTAyammCxfmHmWoZ3R+oiLk0KvdeikmSaTLWk=;
  b=ZZIWi8Xy0mSLOcAYkPuJXRmSpSPxSNnJl0807n+tU3U9Ogo8+dFDGMcj
   w+IyjUBQBZDXj8Pu0GfFwLOpa/Z2P/dl6V/R4gkypUIN+kTDZ4yAXjTbA
   xKEu/FqlZnk5mk+ym8s1bs1bewh4dUN67THGrzW8kwtAREmqthVCU+qOp
   pgP+xtNZAIpAzK5QOUCDPqoEze7EfRIoNd/bG+KfxQ1sEdDMAL3rhJQte
   mldOVhCEdn1aLHhBQNzq9YpYzWBi+MyHvgEc+Kj0+zKjURiI27YLeFom1
   gAC5OFDqtz/bPZ8GyVmrPBfruJY/VzVMYxLYLYtg6J3jC3UMGXnMwZgiZ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681142400"; 
   d="scan'208";a="336091658"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 18:58:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceAfn6HeKuni8YHse1HQOD3pvMZknPs4uZA8UCUUhcB8aa5KbuizmrvwY2OM924SkPSHW5EGsulCkdEmxgfaaXUBwbUVAZKlwQOAnJanJ/jv9Oy6deZYqTCh6EuDS4t+3njihasTK/AL1h1awst8CdUBdigQou/U5WTeoHp13BfrjwYxLxCMtnhjyZVJlx2bPQDU/Cpgi7lbUBHhFO2XBoLJFOQvykYdbPrM8j6oS654oygQEuaBXd7ghAfhO6E1UrT0AKzjDeNc5TI75lfKI6thmnnwTZjQfVTTgwPfmQ20vWCJ53hKY7m1tMaC5zUVRVEh5h2P3T6rNMcNJmvY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk1haNuTAyammCxfmHmWoZ3R+oiLk0KvdeikmSaTLWk=;
 b=fjPrrrZnGWoxXP8RTP506LkYGd767C3j9qaw7GtUb29qTpDqnpxGjEnoZuO02+QM85NXdJTrp4jOzP20ZetzzoITl/G7O1pXVr285HwQWOYIZIPwBVApEkVlTocolUJvHwAhYj83me50b049Lhol264ktSHW2pnUbOiV81bdUyD5z+CBrpFwCu5bBbvRmVj9QlCEiV9RH0xg3kM2tdeaMhDMpw00L/emgQbuE3cFyB4fp1CYiAPz244+6aeXvWfKJ2hjlYXTXWf3vfz4+Jro0fKfa2YRwO6EX3t22F7TTBE7xEzRuihakMWlEhP6kl2Jmu/7JSymHQgV1loNa5tYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk1haNuTAyammCxfmHmWoZ3R+oiLk0KvdeikmSaTLWk=;
 b=MEDuAxKf2CMzBt8mN/yIb9dqT9ycJ7CB1RPob9BbkRMbvQ5k30lYlq4Vzbqs8n7qB+wIarayWx+zee12Gox0Jc1OpFknjULumVzYgww8jyyM6Lq1XQV4M0uqA6hTJrD622SC/HrLG6o1Ftajcx4gHA4lf1JGUHo59VjwD+AMcxw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7613.namprd04.prod.outlook.com (2603:10b6:a03:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 10:58:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 10:58:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/14] btrfs: move split_extent_map to extent_map.c
Thread-Topic: [PATCH 06/14] btrfs: move split_extent_map to extent_map.c
Thread-Index: AQHZjlDwVZKpxAnbREWw2bY0zbcTRq9q0xSA
Date:   Thu, 25 May 2023 10:58:37 +0000
Message-ID: <415196ba-b6ff-6e9b-3e3f-c901ab94bd69@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-7-hch@lst.de>
In-Reply-To: <20230524150317.1767981-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7613:EE_
x-ms-office365-filtering-correlation-id: d689a59e-4c7c-42ec-b3a7-08db5d0efe16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3XydVtfgRQXbidp+WGd3vvHuI3xt5bsgamp4Pz6XEjSQTf2O5ciGBNzZiqJ1A9wl9GRNB1aihO/IyLYKEldhqlPYRwF5T7AhZ39/XCi/RlUQYb4N2JHkvVJ9GVvafYJGtXGV38v2fYyXRplGwTmdPMA9nlNxEYvzoH1DqKrzO5KNfcIIaT4uFPRWSTeFfdCsWu+TEcMPSA2AzMYrnQ7a47m1Vk1pmcbPKnA+CZWRzTRjo1RlTAPTVapwy/II6FIxUl6jNS4PV7Y+NvnUPLtGp1g8fH8SbbBmWlyuqgxOCM3Gnm8NfuzZq7A+sXDqNatFTmq8YpIuDl0tMUinaX6nnNri7ml6gxk+l1o9Mad0iirM6xxtNpUP/nh+uCVdRtX9hfKi6ET0d3z/Q/dLCt90hAZMTR9vo+TVLuu5kTHGOaYaRNE+Q2mpmn8kdplwTmXrssD4LDkX6iOQTO5dxt6TucPY8GtyjEiwfkJpnTnPIAiR4JDqTLMrV2F1hM6HlLMYqVJbcyUPvngHT2aziLGEZmHieqCxOccgL15oVrY4DsuUnwOVBsjZsru2XZhMxgKicjjMvcaQT3jkBCgmpkwDMAc4E0XczM6QX/9jboV/sCPyqZ/DqcwN/podVYhCLS6Ghkr4e8fKT1nyKaHiFsChi56CpZWCNoiaFXCqkBgeSzymu7t/dXPnZ5q2W7SlTITJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6512007)(558084003)(6506007)(82960400001)(26005)(53546011)(186003)(38100700002)(122000001)(2616005)(36756003)(2906002)(110136005)(41300700001)(54906003)(71200400001)(316002)(6486002)(31696002)(31686004)(66446008)(66556008)(91956017)(66946007)(64756008)(66476007)(4326008)(76116006)(38070700005)(86362001)(8676002)(8936002)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1c1c1JSWCtPS0Y1S2QyVHM1Y2RGVkNOV3hZVm9nd011akdGS1ozZ0dLR29Q?=
 =?utf-8?B?Y3FvUUZKVmhuR1dORlNwclpiZzZFUUEreHRPY0RpSnBIb2FBL1d0NzZNSjVJ?=
 =?utf-8?B?cDZyVjV4T1FwYkNySjRZajh2UkhvTWVINnV4TlVHaHZWTEo4all6L2tNNHA1?=
 =?utf-8?B?NFFEVEVNRGxhR0FPMEZ6OGQzU0xrbW5qT1VFVnlhKzVETWk1Ylc1ZVRYd3A5?=
 =?utf-8?B?KytUbld1WjdHRU80SEp2NHhoWm8rZnlLWGFidW9pNnplVXdXbjVsZ1p2NktD?=
 =?utf-8?B?Z3hXZkpsVUhlSmhyejEzenpoR0IveFV4bWVIaGdyWVRya09UY1l4d3VacUZL?=
 =?utf-8?B?OWhZenppTVU3bVp3UkxpWXJjTG9mMnoxeUdnRlRWQmFCL0dRelJ0cU02MzFZ?=
 =?utf-8?B?enU0STVZRVRjRFlQUTVuZFMvUmhOamN0SGdkTDJSS3lOWTR4WjFhVVN1SHY2?=
 =?utf-8?B?YURISXpMQjFUNWZoS0tMcVphTVlDY1k3dDN6dkxIN2diazEzYUZYa2h1aDU4?=
 =?utf-8?B?ajNNR1NSeitWdDV3Y21WbFZEWnYvbEY0RTltWWdKQ2ZTSElpV2hERjdiYlBl?=
 =?utf-8?B?a0ZlcHpkQ3hpQXplQlBWTjJzb2N5a3o3dDM4QlhlenB4dGZQemFNeUFrTTBq?=
 =?utf-8?B?SkdsWjUxeS85WC9xSDFvNENTWnpFcENQbzYrb0o3RjJjMjd3ZWozaEF6am5a?=
 =?utf-8?B?bFZDZWk0YnpFRjhiTkdheEdqaG03N0JBU1A3TmVlRWRtcEhiQ2IwYUJrclpy?=
 =?utf-8?B?UGRjR1kxUjNiNndrWjBBUEZWOVRQdjluSEl0cTlId1NzUXpDTVFyblBGOVpF?=
 =?utf-8?B?VGgrQlB3TkxwWlRpbk1PU2Z6TjdpUmNuOHhPaHg3WS9DV1RVenIxYjh6WUlh?=
 =?utf-8?B?UktWNmF3VmJKem9Rb2FVN1poTmZneGVsZjJiVzBFN2ZHWll3ZzNOY2lqK0NH?=
 =?utf-8?B?U2dtd1AzSFgvRUVpL01ncWtwUXMwOUhMVW9vVDFRSHUvbWphanJsWWpsU1dN?=
 =?utf-8?B?VFlwS082a1kwbGdGSjZSZDVReHZMbzdGZS9GV1NZS3YreUlQcEcwVXNnVGwv?=
 =?utf-8?B?MjBGSXlibnovcDhURkx5clRUVDcya2RCTlhmeVhhQ2MvSzNxaGpCaWVmNmgv?=
 =?utf-8?B?TWIxbWt3cU1VTmJIWXZBRHB6Z0dPbkUxY3kybC9HY1VZd292eVFPS1JQcFNw?=
 =?utf-8?B?Q01wbWxHbWZPaDFRZEJGV2xtRVh1TXpPV3p4cnp4S3RzM1EzVFpGYWc4UVoy?=
 =?utf-8?B?Q1E5SW9jK0I1WnM2QnVvUXBPZ3BtRGN0ajVISnl3VnNmQjFtajJPU1hNYWVO?=
 =?utf-8?B?b2h2cjE5ZXR1MS80S1d4ekxXeXkvVEVCeVVOTmxMM0wrVEgxbUJCOW1veVAz?=
 =?utf-8?B?YUVjSlY4RHBhSEp2Vks5L1RzZDZQdlBCbEhIWTA5RkJZZjVpdElpb0RnTGh1?=
 =?utf-8?B?WE8yU0dBVzhhMEIxSDR4Vzl2ajF2a29GUE0vVEJRcDZmUzlOTHMvdmZDcGF3?=
 =?utf-8?B?elNhRTlaemlCSE5vendjTFYzOGNBeWFUMC9KUFFZZm9Fb1diZTFzdzNxQlZJ?=
 =?utf-8?B?QU9sczZsY1pKTEp0endybEwvTHRFSEtNa29scGt6L2ZmMVpYcXNmRXhQcjF0?=
 =?utf-8?B?Q1I4Z1hoYWprQzc2L2lhcVdkK2NOUFdiWlZ1VFNxWVc4cHo2b3ZDdTNPUlpa?=
 =?utf-8?B?OEVwMWd5Q2ZhUGc1Q0lPUGJlSUxnQUwydW4xUGRKNW5iY25oQjlZLzIvR082?=
 =?utf-8?B?R3lWajQ4UC9Xc1NtSHlvTnJQYnZTbWtvR2dsd3ZtUklDeFBwUjNvQlhjNnVD?=
 =?utf-8?B?STBuckE0YzQ4T29VSlRSYXFHTFUzeTAxL0RpQVRIemxpU1VmLzdBcXZZMnRM?=
 =?utf-8?B?ZGROaGNHc1cxVGtDdTAxeWtvNHlxaEkwak0wUUowRW5mNE5uVzlSYVJ1MUxP?=
 =?utf-8?B?SW9EV3kzRFNyRHVjWW9VZldrRTZWZ1FncmRtaXBYT0QrWStFZ1Axd3UxL2RX?=
 =?utf-8?B?WUl0aGFoL2N5eWxQVnVyTWs3YnZzL0dCbmpOTUVMcGlSQkFQMjUrVGo5S1Zj?=
 =?utf-8?B?TURCSVE3SXZDUnlhMEE4aENjVkdMOTB3eVo1V1pYclNXeUxicVZScWQ5L0E0?=
 =?utf-8?B?TEZGMnE5V1I1NUhaWlMwQ2pyaDdwbjBEY3l3TStuay9nUW5CdVI4d3BWOHpT?=
 =?utf-8?Q?EMFNh6EWu8JKY2CPNGbtxwE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C57471BDD497449F9DDC642A7EB141@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AJ2PBu6mMaWnfJl3r4w32gyKr6ixXc1dT1GJ2D0h0HSzPSQoD/7bp2q1q+p0ki/rkkW+oUiyfWHeU5JLvZHK2vehUGkw/AwFV0hcODtENXYOdgnwNaskb+AP2LJydcjSvp3zBK1A2V242rXbZ7hlDrhuRU2FvQaWrAircJn8I8LFEZ6UwaxmgBEsbI9jI7+G825oCPesw6CO7MreZSMgkaP3uVkcjVRrrkAHdUmXB0KpDab0LT13IyjthMe9RWsv0k9KdF66MUE20oR5aSRCliR4amveG2j71/aosoLHkMa0h8wN2IajXdk32MOb5ui3CDO17B/4CaFKRJ1Jy8MSVaU7LyrjfghHJGZeYs/eME0jD7yXBEA0sT8lTEeEq4DlhCZKB4kOCfiZ7lFl+OallM/UtZnzC5BXmnFaGHhxh+un/fpZkdDUgV0Tmp37Imsj6Umo+798bYn7ywAPfSIpNRCScGKLDlAtn6KlWnobCVJadN6a+KO4aJnzTt9PlqiTLrNgeMA8ghDfNKHWtmPuo1PpnIw37BDPR9TpA3E7GFGybxe+X2rmy4jEX6HQdXnqPe+vvsyW/rWec4FDIQsozAJh9fQKJc7eotX3OlhSYPk0e67Llqfa9Snsaph7pfdLlfworFhjQm21fZnmy1n37x11sb9iEXqgwTM3feeKG+m5SMGNF2fCsiNy0t3Bz0XXepRcK0ruVzzIJe+7xTgA5MOV6plMlgcn6cGCNUqVakrNEcqq5ctvJ42dzSW26e+e7EZhWnP/TYiCvnN0rvkWGS1QyB3uxInxgnVaU0cemw56g4gUTfIge2mIpEmc+vh9aKh0bzPksV3keW34ky05B5XFEAHNKwX4NXAGbRw6/PRonztuN4AA4q7/C2ONsJi+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d689a59e-4c7c-42ec-b3a7-08db5d0efe16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 10:58:37.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFiwe04RapR+cnkOIzUqD3Y73VWoRPD4hD2yIRd9xHAm9RssEPI6LnvQkzrg4dzI3PR+sHYacP3dG93EZezUDd1/X/KnUOsCCeVSVOdtx80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7613
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDUuMjMgMTc6MDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArb3V0X2ZyZWVf
cHJlOg0KPiArCWZyZWVfZXh0ZW50X21hcChzcGxpdF9wcmUpOw0KPiArCXJldHVybiByZXQ7DQo+
ICt9DQo+ICsNCg0KTml0OiBhZGRpdGlvbmFsIG5ld2xpbmUNCg0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=
