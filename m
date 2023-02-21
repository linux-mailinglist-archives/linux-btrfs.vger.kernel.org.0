Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6EF69E41A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjBUQAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 11:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjBUQAv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 11:00:51 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69482A6C6
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676995249; x=1708531249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xytx5cmqWMnIcvQJV3b7bJGBjR6rYU6cGzPp3U9B02E=;
  b=kU2P6zCG29qwM7MHsPKv412/oVXc1kGGGr0ipXpyhaPnBMpQt34CZsaX
   w81+5zzzOJdD1uimh20kscS/M6h6iUkjsGHeiFz6sfdHcFAI3nlMjfO//
   +nVUU1D8gmXEvsIPCgeaDYcoyNkdX4gShPZGsbRQSzlsft9zuvXPBd15z
   oLiHMn/ZQA65OSvtDHa4eUOD68dmCDhFgYr3gQYa5bH3olQbKsgQjO0GY
   MeKV/eBFE2h56eCZ5W4bXMSKjxernFff90Fk7dGTQEnK3KQ5fuIvrQfng
   FPh76EA17wkClqv/YWN3kVC8Oc49z93Ll14i7eqogtTrzt6FHbFvk95hz
   g==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669046400"; 
   d="scan'208";a="335794339"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 00:00:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYOjTKEiIlRJs9b6hzMUOi28eq/rvfOmC29A0xuqW8JoDBYcIG0OgYvPO5aYjudnOD4YeggTiaA+WzFfrHKoZAPyaXSQC7OkLOLZGp8RAqwwSXtlBuUqD4oci26YRZC8B4xF4McyyB53GLOfAcLUn48+Ml8hNkgp6EyU+7w4g2mNlHJFi509H6BHeibUjmYa2Kx/lFjlP/xU5Uju1XIx8Q4toLr0XaxJ5F1LMzloCeK9f4Z3Fo29wHSD6shjJu3YOd7eVFs27Bch7oyVbLPJOH+9+pjcVGwd6ueifJyOjAA3wg2nDAWNW4OIuPUvvsjQMzkW9fLdk+Doma17jhBDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xytx5cmqWMnIcvQJV3b7bJGBjR6rYU6cGzPp3U9B02E=;
 b=M1b33YoFD2S7cW9HuKHBI1YFdOToJfPWIJEvHWbG4Vv7GIaBwEDZvJZhyrtkKSAXWOuezroTGwSot5QsFkZFYyWHFGUL8ozQqrWqrFab7M9zIV5E9iSTyoIqJHhMxxBv0VtKNAoMCQsn4M4yZ4GXNPZ5vdLb7WWJRUMFqcenavvCuAHRJc84aQthfxLwSgmuRBClY42S6DxOhS/Hz0B7MVWGwdh7Yt9DhHjqQgSVjE5gqTD52JubNxnoOkfzhQYVPcEcPYHJq7yeiIdTRMi4VfaexOtrg6ozjO//Z0P+77ZiR7SWCNnTMQFNN0FTvlB9iEDW/rQ764eOMFC9OWn46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xytx5cmqWMnIcvQJV3b7bJGBjR6rYU6cGzPp3U9B02E=;
 b=n927+gyluXjISl9goDdonYZZpgJoebjlg3Xd2QAR8c6O3JfNdaGc/sVTSPjoQiFeUp/cgANgU7qkOIxLHMpCliD4CSoLiW8sn9SWJV6COAem3OgjYZCAcTfRBIDyIMlJFQ45BkwsgX/ij2oJzQIpJ0WUDSVbzd3+BuEGyOg+up4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0284.namprd04.prod.outlook.com (2603:10b6:3:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 16:00:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 16:00:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflow calc_bio_boundaries
Thread-Topic: [PATCH] btrfs: reflow calc_bio_boundaries
Thread-Index: AQHZRfgBNxHFIz3UPEmFC4mXxpniHK7ZdQKAgAAaWYA=
Date:   Tue, 21 Feb 2023 16:00:41 +0000
Message-ID: <99957e0d-674b-5799-2f12-d2986c6ef669@wdc.com>
References: <9509878ff5631eb2563855c0de694f296e23e0f2.1676985912.git.johannes.thumshirn@wdc.com>
 <Y/TUjwJCkzcoAEac@infradead.org>
In-Reply-To: <Y/TUjwJCkzcoAEac@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0284:EE_
x-ms-office365-filtering-correlation-id: c55f22ad-b24c-4526-0607-08db1424c86a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ab/OHz6DfI990/D8qcvX+8BK5MShiopIhCcylrl4D/W1ETZYtErb1x/iJaiGhATDLx9SztXNiKS6zLukATLSewzjEi0ib9la4vtlkvbABJTZ+P9jNqWmN8GaOBDilRktgOxcZN5HY6P+4VeIHS6ZDHDWinRiyuilS2j8GP0OY2wZXQxAFAqQ6oXAMX0p4VLb72ZsB+Rc5+3Ow85VyvjAxxM/5hgXs1PAbS+KDY1Q0bDczxjWfCFyg3xh3K3iRAu8Ze/59lD1LHj753Nw7o81L+B/18DlOK/nsPyXzdHDS/hWszGx35EisLzHCHkXBLScc0OCIIreKA/YGxwWMAU8tIWyoc/h4GmvbHhTJzcn3CoXTlCAKw5xu+BctDbdr7J3KT2UTWxydXjLpVR/JQKhMEPnOOeaHKpxtYFaMn0N/7PuvtD5gK3DbpRinxquVYbrRoUe6ONTFdtmr/zbEOEBhbvBn4ZmPd7bMQSqqlxULx00veD6IWz8FQ2GYVL3yafelhtxG7tSZWpQIzpXugbrPPGd3ABfaDxu0KPVWg2zFXuKpDw4/ZipjGuZJs11Xt8hPzB1gJjfPcYTph8d8wMUCgC6AKfjOwu+TN05n+y9ShXTM36NLy0Ve5ZoFACI+TYpDoqw7J/3uCs0t74IbjVhGWIdsh+kQr9dkjE8mNcfvaY10P3eLloKlMvIF/rMHvJrrbGGoiT9v0vNxSkvhlxEINsYkIr7bWWcmJRCWoe294+Z4jmpn1Kid9x6/YDHw19fRAr6Z51Vfb1XvTJ+sdFk8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199018)(38100700002)(66946007)(66446008)(66476007)(66556008)(8676002)(4326008)(6916009)(64756008)(76116006)(83380400001)(53546011)(6506007)(6512007)(186003)(26005)(2616005)(31696002)(86362001)(82960400001)(478600001)(122000001)(316002)(6486002)(71200400001)(38070700005)(36756003)(5660300002)(2906002)(8936002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRJci9JNmxyaUJwN0p0T3hzeS9FdDJMNUZoL1QwSld2eWd4dHpNTURrTEpH?=
 =?utf-8?B?MWRUcllsUGdsbjNrZ1JDVU1HTmttQkt0WVlPVDBacVlBeTdLY2FPVGVRVnVy?=
 =?utf-8?B?bEt0VEowQ1FCOHorS1JmdDdWdXRsdnorbk9UcUNXeVk1cW9LbXhJSFZYNkxm?=
 =?utf-8?B?UlJKOWZpbCtaZ1pJV3hXUm9sbnc4U1NXVkQyMXRtNThqUy8yNHJyQ1NCSTBt?=
 =?utf-8?B?SE1mRFZHZHhxblZMZ2xPM004dDc3dTl1Y3RycHBiK1pkVVBnY0ZzTGppTXBp?=
 =?utf-8?B?VHM5bDZUdkN2N05kU3Q5MzJ5VkxrNmxBN0hCZnJMTnJiWk5NWldjdUFvTUUw?=
 =?utf-8?B?aFlyR0F4TWtPZ2IwbGxzbUk1RHBvNHljZEFYS1B3V2RWTGd4d2RYRHpTamN4?=
 =?utf-8?B?NldnWE1OYlh1WEgyOFZTdU1MQ1BOSDBzOTgzSkFidVdIWGxCenhMaFBUUDJo?=
 =?utf-8?B?OGtrYlQvQ0VSREQvVitYZms2REs5Q0t5TXZ0TGFqZkp0N1JVdjFaYmY2QVIz?=
 =?utf-8?B?Zm55aE9HL01NL2R4K3ZNSHEvaDB1MUl3dlg0S1VxSEt1dHpoN2lFSkNqb2lG?=
 =?utf-8?B?UXVIRU9iNTlSSk9nM3h0YmozTFpkTzF2ZE9ONjBSZ09ScDR4aEZwOWpGSDVm?=
 =?utf-8?B?a29ZcFE3RGl0T3NucS9sWXlZMFFLRzlTNnk0NmtYakdZMkJNdFRseWZCWkNv?=
 =?utf-8?B?UDFPRTgwakJDMEtEd0VKWjVVSFZ2cDk1blBGa1I4M0xsK2VYQXozSXRLSU1Z?=
 =?utf-8?B?MG52TS9BK3FYa2lMSWc1dytuamhMZStCdnppelpnTnphVEM2N2xyb25qQU5s?=
 =?utf-8?B?Vk1VdGx1SWlZbWJnYUI5clJKS2oxdmk1eVNWZFlhMjVEa0NlbkxzdkNBaTZn?=
 =?utf-8?B?VVdKZkpYQjRVTW9Gc1VjbGlRUEttRndsRlJ5ZlJGVXdnSXVCOHRadzdJcTgz?=
 =?utf-8?B?cDJHWnJZZitKYmNZU2k2U1FsSTRrOU80Z0YwRHBBM09SbklJVTBWRWJUTWpP?=
 =?utf-8?B?ejgxQmlYcEFBeXoxekJLQUxlcDU1VmFFMkxSeUtmUHM2WUhmNUxpcWVEc0VZ?=
 =?utf-8?B?Z05PTlZGUnNmck9YWVBCbFVEVTBOYU91TzlxdWpOaGFmRlVjZ0NtQklkdmg0?=
 =?utf-8?B?N3FxdGlWQjZmbGRjTkFuMW5xM3RLRGFJeTMvTmVzeWZYRzZ0YzcrU2xEdXVK?=
 =?utf-8?B?RG4rVTBaMTU5N3Nobkp5ZTNsVDgwM3N1MmRLWEhoMUh0M3VGUGpiUGE5dmxT?=
 =?utf-8?B?Q09SOWpUVmpZN0U5NnN1dHkzTitjQUR4Z25ZVnRNU1Rja3Z5aVZtL2hOajFO?=
 =?utf-8?B?R1ZjMmgwMXRLMnVZMGQxU1dCa2JBSEJ4US9CRFFBb1ZmTFFJL0l3VFp4MjJ3?=
 =?utf-8?B?dS83TmVxTHA4d2hYeFZ1VG1xWEdiaFArWXhGRVVHcHFKaHg3b1Q1MlNXdlZi?=
 =?utf-8?B?bkpuMDhzSnJyM3NJWksvb1hMK3BIUWFjWjlta0FsN3lDMkVHY1VmUmt4Q1dE?=
 =?utf-8?B?Tm1pNUkxdnN4VmlEamNvMnhha0ZKZXpBdmcrTnN1QnZkYWxWV2tCcmpsZWJ1?=
 =?utf-8?B?Qy83Z2pjemdJT3RmUmpaVEUyV1BvNWJLajBrRzl2WVRtWGtiZ3BIeVVlTXZw?=
 =?utf-8?B?SFphajJaaHoxQ3VRRzhSWENxK2ZYR0o3UFhFNU5RaTY0UExHZThFKzFMYkpN?=
 =?utf-8?B?WDRVeFhackFpZ1B4Q3ZjcUN6aXh3UHhDOU0zQnlRUDJBQ2twd2tDRStCL08w?=
 =?utf-8?B?T0NQNnhZaENDNHVXcjcyTUZYUkppdnAyRHNSalZHNHZDQUEvNWhoNnhqU3pY?=
 =?utf-8?B?VzdRNkVuSG9aK2xPZFg3azM4TFBSdVpGcjRYNlRnRUlLWU9jNSt5SWRQc1Bx?=
 =?utf-8?B?MWxkKzFlTWQxYStrZVVUSWdyTXVMR3l3a1FBc29PSmpibS9YTllqNDQ1cGtx?=
 =?utf-8?B?K1NkNitxbjFRVTdWWVBWTUkreDQrK0NhdGFObTk4azhvR20remNJREVwRUdm?=
 =?utf-8?B?T2tab2xYTEY3cy9OZGVXbk40TjVHeC9RVW1ZY0dveUh6TFRYclBWVzl6Y3Vw?=
 =?utf-8?B?YnRGNWxyMFk2WENHNHhyWjFKRmhRbUE2NkN3TElNOE5obFBJMzg3Q3BjOEhI?=
 =?utf-8?B?dWdzNUYzMEFST3orSlVBaGdZWXpCcDZheXU2aXBGSTlLbVdZOHJWY2hPc2JM?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C0A73A796F7F649A95EF48978BBC1F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BEwslLq6lZXEkNlvcVscqCapaupgnBWIibqIA3s7rSNDXnoC7srC+tFb5kRT62jBPxNINZziNeMwj0cuv6GhvgiXrYpn5YrGG92gzmeXKM11aNA9iej3vfLOL3O33U86erA+xlHg58eQO6gHD7kdckn6JM7b++e4AuRligVB/mDNLKPHeha6VdxfKX2/xTFeKh9A+Xe/hMmgnsNP3mAi1nR7wXHx8sssvz2YC2ZFqSxigHy0Geq+xmAVMpynVsftkUteBl1lYlmSPpvBOHsWc5FWbI5YhYAFx2LyJq8WNii+IpdjgUKTP4QdQhrP9HnHO2Tnc0f31q8rA0KVqbjb9tCbizpvMyMEfRXcvWhr8LC/xVqaPC2S8j+es1I94t0XGXAaXBUxMhkclLPA8iPAWxd9t5+aUg7bNNElcGDoRl7t3rb6vkTe+/BhagnIsoCtlSO8Ukvil6peAfLnHnqHNaK0l2NoyzE/NG2Vle5zVeQd2ivNxBIMOqXKTDs3chsTZwTG0iGFlKo0yo2vPfaJPpbLEf1w6Xmr3SKHnjQIHEvSL7Z5RJKyCl3S1ZMZ27j38ddU9i/wDEMI4cPr1F2SZVOLgq1mHtXT95S9If/Xcs5K/5bb1gI/wc6HW77OrqfWV5Y4rWav7vHmxUJGkyFoer2TIuj42vxrg8y3JRUu8ZZmx/fll0tpZjApz7GmgbSjknyHbmSBe3xcgII78cGVgy3TTUcPKsSyyvXLx8u6DTAhKV9aJWWg4Tzc4Sgq34DSPX19h4ahDRkY0IJiqw8rLc17LsbfaVILvqQde7ST0AoorFGJ3QtZpLJGw2cy9zvE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f22ad-b24c-4526-0607-08db1424c86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 16:00:41.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0Qml8tNAipv5IVbdqaD30txVWFW4KJY3xKRkI/eEo5riHeVockBiNfhOutoxYnxiKvTaXdKDCqL1suFlnXFu/q8j99QRRv5njWDHrp4xtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0284
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEuMDIuMjMgMTU6MjYsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIEZl
YiAyMSwgMjAyMyBhdCAwNToyNTozNkFNIC0wODAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBjYWxjX2Jpb19ib3VuZGFyaWVzKCkgaXMgb25seSB1c2VkIGZvciBndWFyYW50ZWVpbmcg
dGhlIG9uZSBiaW8gZXF1YWxzIHRvIG9uZQ0KPj4gb3JkZXJlZCBleHRlbnQgcnVsZSBmb3IgdW5j
b21wcmVzc2VkIFpvbmUgQXBwZW5kIGJpb3MuDQo+Pg0KPj4gUmUtZmxvdyB0aGUgZnVuY3Rpb24g
dG8gZXhpdCBlYXJseSBpbiBjYXNlIHdlJ3JlIG5vdCBvcGVyYXRpbmcgb24gYW4NCj4+IHVuY29t
cHJlc3NlZCBab25lIEFwcGVuZCBhbmQgdGhlbiBjYWxjdWxhdGUgdGhlIGJvdW5kYXJ5Lg0KPj4N
Cj4+IFRoaXMgaW1wb3NlcyBubyBmdW5jdGlvbmFsIGNoYW5nZXMgYnV0IGltcHJvdmVzIHJlYWRh
YmlsaXR5Lg0KPiANCj4gVGhpcyBsb29rcyBjb3JyZWN0IGJ1dCBkb2Vzbid0IHJlYWxseSByZWFk
IG11Y2ggYmV0dGVyIHRvIG1lLg0KPiANCg0KSSBrbmV3IHRoaXMgd2FzIGNvbnRyb3ZlcnNpYWwu
IElNSE8gaXQgcmVhZHMgYSBsb3QgYmV0dGVyIGFzIHdlJ3JlDQpub3QgY3JhbXBpbmcgOTUlIG9m
IHRoZSBmdW5jdGlvbidzIGJvZHkgb24gdGhlIHJpZ2h0IHNpZGUgb2YgdGhlIGVkaXRvcg0Kd2lu
ZG93Lg0KDQoNCj4gTXkgbWlkLXRlcm0gcGxhbiBoZXJlIGlzIHRvIGluc3RlYWQga2VlcCBhIHJl
ZnJlbmNlIHRvIHRoZSBvcmRlcmVkDQo+IGV4dGVudCBpbiB0aGUgYmlvX2N0cmwgYW5kIGdldCBy
aWQgb2YgdGhlIGxlbl90b19vZV9ib3VuZGFyeSB2YWx1ZSwNCj4gaW4gd2hpY2ggY2FzZSB0aGlz
IGlzIGp1c3QgYSBiaXQgbW9yZSBjaHVybi4gIEJ1dCBJJ20gbm90IHN1cmUgSSdtDQo+IGdvaW5n
IHRvIGdldCB0byB0aGF0IHlldCBmb3IgdGhlIDYuNCBtZXJnZSB3aW5kb3cuDQo+IA0KDQpBbm90
aGVyIGFwcHJvYWNoIHdvdWxkIGJlIHNpbmtpbmcgY2FsY19iaW9fYm91bmRhcmllcyBpbnRvIA0K
YWxsb2NfbmV3X2JpbygpIGFsdG9nZXRoZXI6DQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy9leHRl
bnRfaW8uYyBiL2ZzL2J0cmZzL2V4dGVudF9pby5jDQppbmRleCBjMjVmYTc0ZDc2MTUuLmVjMDI3
MDk3YWEwNSAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL2V4dGVudF9pby5jDQorKysgYi9mcy9idHJm
cy9leHRlbnRfaW8uYw0KQEAgLTk0NiwzMSArOTQ2LDYgQEAgc3RhdGljIGludCBidHJmc19iaW9f
YWRkX3BhZ2Uoc3RydWN0IGJ0cmZzX2Jpb19jdHJsICpiaW9fY3RybCwNCiAgICAgICAgcmV0dXJu
IGJpb19hZGRfcGFnZShiaW8sIHBhZ2UsIHJlYWxfc2l6ZSwgcGdfb2Zmc2V0KTsNCiB9DQogDQot
c3RhdGljIHZvaWQgY2FsY19iaW9fYm91bmRhcmllcyhzdHJ1Y3QgYnRyZnNfYmlvX2N0cmwgKmJp
b19jdHJsLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnRyZnNfaW5v
ZGUgKmlub2RlLCB1NjQgZmlsZV9vZmZzZXQpDQotew0KLSAgICAgICBzdHJ1Y3QgYnRyZnNfb3Jk
ZXJlZF9leHRlbnQgKm9yZGVyZWQ7DQotDQotICAgICAgIC8qDQotICAgICAgICAqIExpbWl0IHRo
ZSBleHRlbnQgdG8gdGhlIG9yZGVyZWQgYm91bmRhcnkgZm9yIFpvbmUgQXBwZW5kLg0KLSAgICAg
ICAgKiBDb21wcmVzc2VkIGJpb3MgYXJlbid0IHN1Ym1pdHRlZCBkaXJlY3RseSwgc28gaXQgZG9l
c24ndCBhcHBseSB0bw0KLSAgICAgICAgKiB0aGVtLg0KLSAgICAgICAgKi8NCi0gICAgICAgaWYg
KGJpb19jdHJsLT5jb21wcmVzc190eXBlID09IEJUUkZTX0NPTVBSRVNTX05PTkUgJiYNCi0gICAg
ICAgICAgIGJ0cmZzX3VzZV96b25lX2FwcGVuZChidHJmc19iaW8oYmlvX2N0cmwtPmJpbykpKSB7
DQotICAgICAgICAgICAgICAgb3JkZXJlZCA9IGJ0cmZzX2xvb2t1cF9vcmRlcmVkX2V4dGVudChp
bm9kZSwgZmlsZV9vZmZzZXQpOw0KLSAgICAgICAgICAgICAgIGlmIChvcmRlcmVkKSB7DQotICAg
ICAgICAgICAgICAgICAgICAgICBiaW9fY3RybC0+bGVuX3RvX29lX2JvdW5kYXJ5ID0gbWluX3Qo
dTMyLCBVMzJfTUFYLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9y
ZGVyZWQtPmZpbGVfb2Zmc2V0ICsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvcmRlcmVkLT5kaXNrX251bV9ieXRlcyAtIGZpbGVfb2Zmc2V0KTsNCi0gICAgICAgICAg
ICAgICAgICAgICAgIGJ0cmZzX3B1dF9vcmRlcmVkX2V4dGVudChvcmRlcmVkKTsNCi0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybjsNCi0gICAgICAgICAgICAgICB9DQotICAgICAgIH0NCi0N
Ci0gICAgICAgYmlvX2N0cmwtPmxlbl90b19vZV9ib3VuZGFyeSA9IFUzMl9NQVg7DQotfQ0KLQ0K
IHN0YXRpYyB2b2lkIGFsbG9jX25ld19iaW8oc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGJ0cmZzX2Jpb19jdHJsICpiaW9fY3RybCwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMs
IGJsa19vcGZfdCBvcGYsDQpAQCAtOTkzLDcgKzk2OCwyNCBAQCBzdGF0aWMgdm9pZCBhbGxvY19u
ZXdfYmlvKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQogICAgICAgIGJ0cmZzX2JpbyhiaW8p
LT5maWxlX29mZnNldCA9IGZpbGVfb2Zmc2V0Ow0KICAgICAgICBiaW9fY3RybC0+YmlvID0gYmlv
Ow0KICAgICAgICBiaW9fY3RybC0+Y29tcHJlc3NfdHlwZSA9IGNvbXByZXNzX3R5cGU7DQotICAg
ICAgIGNhbGNfYmlvX2JvdW5kYXJpZXMoYmlvX2N0cmwsIGlub2RlLCBmaWxlX29mZnNldCk7DQor
ICAgICAgIGJpb19jdHJsLT5sZW5fdG9fb2VfYm91bmRhcnkgPSBVMzJfTUFYOw0KKw0KKyAgICAg
ICAvKg0KKyAgICAgICAgKiBMaW1pdCB0aGUgZXh0ZW50IHRvIHRoZSBvcmRlcmVkIGJvdW5kYXJ5
IGZvciBab25lIEFwcGVuZC4NCisgICAgICAgICogQ29tcHJlc3NlZCBiaW9zIGFyZW4ndCBzdWJt
aXR0ZWQgZGlyZWN0bHksIHNvIGl0IGRvZXNuJ3QgYXBwbHkgdG8NCisgICAgICAgICogdGhlbS4N
CisgICAgICAgICovDQorICAgICAgIGlmIChiaW9fY3RybC0+Y29tcHJlc3NfdHlwZSA9PSBCVFJG
U19DT01QUkVTU19OT05FICYmDQorICAgICAgICAgICBidHJmc191c2Vfem9uZV9hcHBlbmQoYmlv
KSkgew0KKyAgICAgICAgICAgICAgIHN0cnVjdCBidHJmc19vcmRlcmVkX2V4dGVudCAqb3JkZXJl
ZCA9DQorICAgICAgICAgICAgICAgICAgICAgICBidHJmc19sb29rdXBfb3JkZXJlZF9leHRlbnQo
aW5vZGUsIGZpbGVfb2Zmc2V0KTsNCisgICAgICAgICAgICAgICBpZiAob3JkZXJlZCkgew0KKyAg
ICAgICAgICAgICAgICAgICAgICAgYmlvX2N0cmwtPmxlbl90b19vZV9ib3VuZGFyeSA9IG1pbl90
KHUzMiwgVTMyX01BWCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBv
cmRlcmVkLT5maWxlX29mZnNldCArDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgb3JkZXJlZC0+ZGlza19udW1fYnl0ZXMgLSBmaWxlX29mZnNldCk7DQorICAgICAgICAg
ICAgICAgICAgICAgICBidHJmc19wdXRfb3JkZXJlZF9leHRlbnQob3JkZXJlZCk7DQorICAgICAg
ICAgICAgICAgfQ0KKyAgICAgICB9DQogDQogICAgICAgIGlmICh3YmMpIHsNCiAgICAgICAgICAg
ICAgICAvKg0KDQo=
