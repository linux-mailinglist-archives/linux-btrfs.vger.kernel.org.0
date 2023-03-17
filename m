Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0A76BE6F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCQKfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCQKfo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:35:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654B442DE
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049342; x=1710585342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=hrOfg1/6CHDqLp2U6c//NDvgbyLOMozsRA9m12AkE0LOZtATeKEcLexC
   eMTj307039OHKizwKkFopI3zlXr6rgzFRv4XY01V/e5rxFQb9Pdjjg+0M
   Q3dpMhLaNI4YBOa+wOUxd3IxUDnMxK57q0hFYxkQNWwEOOKBXM2Wsvg3U
   JCTc+vcwxKMUnvHGi82zz+lniLDmxkgVEkpCnIkEPYahVnGb2P6Ro/JwE
   Mohj5ssrEv48H0/DwZBlo82YHsN61Zgsh3LPxCkQf/8/6nHFPU6ey/AZk
   u36nDJHV5wV4o6PYDAJYfcG7Tq/mGVYVEe6hPOQDBPnAKjp2Hjg8HmlW0
   g==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="230817765"
Received: from mail-bn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+SsacAkJvpMfjYjPmL4YA3pSZGoJIevTx0tOMxaG9p7M9H4shTW9hXDVSy5j9GTeZdf4bF2ukNu/MI/rz1sPnwY5HMo+KSW46igld07M+xTFPViMAUcC9bMXUr1hEi5cTzdNlcIJlQdJH0VSURL5GWd6nWr4FIukAAQSpOevHg2dua9kmCdJYgCKmRn6MHzsIe5Hqku/swocFej79efM6RMqTJEFCGdvPhyS79dTaRR/S4QULKJ/CZu9ayGGKh8YXafpXXjl08H4XAxCe9cnamlYxPuFe8KE91AREE+BVJ5fyeSFgF3uuuM+M/j8m4RKc0jKakDRdFCYXbDrNJ9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=i9sCd2tYQmFUbAoKQh5vKusGhVHTzqmnOOL/KfZkz2PqPl/NFR9+ecl9N74qxI6qKcAk67pMgHVwtlo4HXNnvrH7pOLUmSzfdUoTtu+rQ8Yua66mLQ1HLzjqEX6PdkVAtHrW+htt15ip6d6NWQ+79Sv2xl9MPQBNnJRERRwJiumIDEdqAzhrJ5IqY5Z5v9iUBkKFvZ6YNIYhjNETuANQqoNOluHlrty6oa9y0fQbEo+sJfKQEiLt7/NobXyQ9NMf12RhPfDv4f7AcuOUCZqUL5iqTmDOWJCx9NkPigSyI6lx1QTMoC0a69PlGwL5MAGOIBrqqWpvKsEEqrSwTH2EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uTO2SJrPdyZwM/JJ3XI4KYaCwKwcDev+wiGZ0whI+r7i+6YsjJN+v7dJru6K2tp7Nuiz1BWqJBDFtyXPT4rHOK15lVPbVV2IIvFscclSfjBcKUGnEEl0HQXDEJLzU5cBfXr6TtZgANumINhttg/VA5ybWeOh1H5oOuDtq9QhBs0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:35:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:35:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/10] btrfs: remove irq disabling for fs_info.ebleak_lock
Thread-Topic: [PATCH 08/10] btrfs: remove irq disabling for
 fs_info.ebleak_lock
Thread-Index: AQHZVpZ0PTAplZWgXE2CzMOagRqySa7+y0GA
Date:   Fri, 17 Mar 2023 10:35:39 +0000
Message-ID: <532021eb-d41c-5117-8773-25e97a92ff85@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-9-hch@lst.de>
In-Reply-To: <20230314165910.373347-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7545:EE_
x-ms-office365-filtering-correlation-id: 1022755c-c6dc-428a-eb0e-08db26d35a59
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKHhMSOhoXAOnJdpqGF7hky5mS78nfLP5ul4gMWBAFTeZ6colv3Om2CZ17UBJn5F1z/VStWSfT4CSXTAJcIjgleI/I2lU4ETX9g7VQyZX8MHxSn18uC1uOZfrUblEy7hVBCKo32lGEgDC3++WgixlhGXkolKPjF4Vqu2MXC9XVxTT5nLZF0XMIQ8RfRKBw2IH25WqY1NeUAQdsY9yfcU7m9UKK++YiEk6fgZOdiqc8olzxF0Tui2pHadZAHCrODaMqqDPVPf2ywlwQ4h1Ph9TV9KSm4SWF+FZlffmm0BHLKxbrkY0jnpVtj7GLIEHNA+DCGlVvNf3ovRPuLtxGeczLCJ8a1wUsKaQhRC7t1cE6zhTCTdvKgIjSvZRHi+QtUAtIreJqPLWVSkNgkj5CgddbcoQCYETiu92sB9iSiCuYMXF3hcy9eAfG+Ds0lw/cm8yiEkwVIaaqswXpi8/+cBJBvVHIbaS+chqM9+6BHRnzFVmQhFw4puqjhEfUy/bGKzt5tkx0etWC9UqmP2pRwPAkq0eAtnMAyYp0yYxLTYjLGf4s7al2A5R35Dt0mtB4/4crsJagD6PaQ+Qaq35v7IJb1Nl3CERoTZCpvLN1LVmtYMEwtgJmXOnlB+V7Gv2TedU3KXPKz5M4jz5qIs4mM463rlwibbF+p53eSxQ+vV3UjjwU9iGXyLBTJSbhXYWGu11/usKUhi+CcLgE1d2ZBiys2swQV4Qf2AliLIfUOKDNjHCxhh7ghhzAnQtnoc/7bPY27NAjzWmeZswdUpq2mWbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(558084003)(6506007)(66556008)(4326008)(6512007)(82960400001)(66446008)(122000001)(4270600006)(2616005)(19618925003)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjFlYVI2Umc3TzZzVjgxOXFrS0xvejJvYldYTVM4NGFZVzZxRkJIVThJT0ln?=
 =?utf-8?B?NXNycC9TQ055Wmh1a3J0ZThoK1Q4SHk4WEw3Tkp1c1crS0Q4b2M2TGFwMFRC?=
 =?utf-8?B?ZDEwWUU3UTJIWFdJQ1FLNU5hOWl6NnIrMWpnMno2VytJaW4wei9FUEdPdEtG?=
 =?utf-8?B?Y3JXRFBpdU1aNzZ1TGJGaUtoTVlOdytyOWNoeGNQYlp5dmMrQzJvSENUMDFI?=
 =?utf-8?B?aEJkMkF6aVNBY3B1dUFuOStlS0F0WmNqb0xmcjBYTDlOL1JrSXpuR011TkQ1?=
 =?utf-8?B?UnlFYXBmTVpCbXRDdUdBZURjUi92UldoejF0Z0FtRVBWMWtYSDZ3dk82d202?=
 =?utf-8?B?WXp1TDludHhERlc5MUJYdnJhUUV0MEs0dkhVRjBDRnlIbWxVY25ENjY3cGlw?=
 =?utf-8?B?c05jS3hkaVVEK1htdVpZWWIzRERDenJIQnkxYXphZVIzSnlHSVdGM2hPckZk?=
 =?utf-8?B?ckRDT1lHOXp2S2Rjcld4aThmekk4ZGs3c1g3cm5TMk5KNWVkQkxidzdNb0o1?=
 =?utf-8?B?clBPMTlmaUdod1hDUi9WREFtN3l5cTMwbHpQM0lBekJpNStrTG1uY3k4M21R?=
 =?utf-8?B?SnBjcFhMbkhtcDRhVTJ1VTdmbmZnVVhGU3oySjhhMmhuSENPOUZ0dURzcWZh?=
 =?utf-8?B?TG5OKzBUeDdQZW12bEdRRkFiUkZYV0xHTmQwRnlwb2p4Z1orYnFUeE1lL3Jp?=
 =?utf-8?B?STExNXBKcEh6VktGeFM4VHZSTkl0YkFxb1Nlb1R6em1ZQVM2WWQ2VzM3ZXd0?=
 =?utf-8?B?cG15QVpXcFNITjg5S0ZSVVJZQzBrSGErenh2UDg4aDNwdUhyK3MxL0NXVkFj?=
 =?utf-8?B?UFRzcnFpU1RnVWNEM1hnaHJVM0lSeVY0K3QwZDY3allBQkJFUmxQN3NEeWdu?=
 =?utf-8?B?TTNXOHlvUXRNbEhLY1VnVWYzOFkxVzZyWjdFdG04VXhJcjlTTUVONUY3WHVV?=
 =?utf-8?B?azQxK1RnZ2RZa2NkL3RtRUdrRklWRk51Y3QwSkp5YzIwUjd5aWhMVHdvRGlO?=
 =?utf-8?B?OStkNCtBYWVmMUVwajhrRXUvaXFuWmhnUkx6Z1JWOTF1citaZmE0WHYzeVdK?=
 =?utf-8?B?cE5ZaHpMVzJiaGFEWDQvRFFsUU15TkVHNTltcVB1MXNhWmw3bXJ3YUhuS3RC?=
 =?utf-8?B?bHFVK0FnYVVLM3MrR2pkWk1YVUpPWmJjZnV3Q1I3Lzk0eTI2T05nS3REMm54?=
 =?utf-8?B?Skl2Z05Hd3M4UDNHUWdvRUQ3VXd6T1VzcDlUM21VT3lpckdDNmlDUmJCMFRJ?=
 =?utf-8?B?by9LNms4aCtBQ1ZlWk1qTFZZZWpEaUM0alliU2k5Tm1rTXJpUEhCSGVmUi9u?=
 =?utf-8?B?QjI1WDUzSWlscXJKN2FVaGpJN0x4SVdNdFdlZVpvdytOV3l2MXNYcUkwazlt?=
 =?utf-8?B?bzNnbHZGeWx3WUVSK01HbGZFOTMrd1dpNm4vSUpUY1diaXppcndUOVVXdEtI?=
 =?utf-8?B?Qno3RGh4eTBDUmZBZG9RdGtFc3FQWXhXdjF6bk1FVDJPVFJndEk4Tm5PYk50?=
 =?utf-8?B?K1hxUDEzRlNyZC9wUDJxMTl5djkxVk14UGZYcFNoYm1nbTRUNjZ5ZnNwL3Iy?=
 =?utf-8?B?cjhZR0ZqeW0zTWxPVWRyaUZjd2NUZUttZktwaG4yR2E0RzJMZDVIa2NqOU1m?=
 =?utf-8?B?Yy9XY3pUU1ExWnZOaDBpcWpqVGM2aU5FdjlibmxHV00yU2laY0ZIaFFCTFRW?=
 =?utf-8?B?dTYvWStUd0RQRGFaVFExL01hVVY5MGh2Rk9XUS9nY2d6MS94QkI1OXVhd2pW?=
 =?utf-8?B?Y2FXYnYrNElGVEpEdmY3bllOL2xyZnZnZ2VrcnRodVJkcXpZSUxXZ3FNNzVX?=
 =?utf-8?B?eEEzUzAyWERJalpWTzRGcjVhUmZOamZCTWpiUFFURmp2MlNadjlWUGN6aUt3?=
 =?utf-8?B?TGxvakx6YXY2RmFEMHpKV05mVFF6TWpnWlM1bDdoSWVoWmpaOGRobzY2bWJY?=
 =?utf-8?B?OGVPMThPRUcwY2lwY1UxbFlEZlpZd2RQNU0xeC8ydzFVQk5LZ3dISEh0dEZG?=
 =?utf-8?B?VUlMN0dqWnhGNWJ3TWR5SkVtQjdod1pNais4UVVBaFZZL05LR2ZiZDhTTHN0?=
 =?utf-8?B?WnhYbCtyWFY1WEFJRGcxQkNhWDdmTXJFRHNZZXlURXFpMTRYOVBmTXVPRGF4?=
 =?utf-8?B?dHhpWTJzYzVNSlllU3J6Ynd0aUgwTVdmcWkwYlYrVzlhOGlaT05LUENPV2ty?=
 =?utf-8?B?TElYc1NGdnBKL2Ywd3NiTm9IaXdzem05eGZZNU45aGFFVEhyZnZSVTZIT01y?=
 =?utf-8?Q?Kwrea3l2D9isrjRH1sJXwwNxpzHpY/eF9fIZyAl31M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B477293F7D42943B33BDEF0EE2436A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xKLWXTJygSAcgjRj9nSeywzr771Sw2jqyp639mI0vDGvvIFEjPzirC08Dg6wLd8nh7zIlWmItofdJBw03ZNLy6WGrM9iLLlFeGBHwVs5POjCWY1gOUJMP4DLyaMftDfsPSTuDvVwdeuYxSEvZG792XYndkNLVPyjzRH1guzsmTIw90+rAN49AXqhJ01GwB5zvbDp1+cg7SJf4ge3qX6m3gnvEnGIQenyKiFfQ7ZpLxDOtaNWkKsfAcimLBk33TDI78OU7m0cqFYnpm8YwMpw6ZjdTDi6UkG9dRmevL4gy0Mos8pjvagNt6RPBf8Yk/g9k8CZ8UfSN6gKgRHFA2ndLftuOCBh6z0Tp+5wXI9JaMVqCKy5xclIpugjoXtW6znjzrnYVxE3o7w9ZzMxx1sEpuHbPHwKqBFizS9Qy2tzS/izQDhKEdsXYIlwNV02tp+dRW1FY0LcdWZYNQzJpzSqxPvwW5GZsFuKBp5VVI7gjn1DU5xbUZVEzDWzYRwj3Ds10Z2h6jEXVmNTkgeUS3GOOmuYNSP2S/lN7OiRsbpJ8P7hGUjijAdzawfbMDDGwutye0H8pfokp2yLoiBEu/kpJIXYHsPnpAxRbwFdLnf7AVSHMDwNOk9tboX1N4yQBhS1z/e60VdHgu2DMcSHPhf84QfSmkB4M/Ch5kFg+AXuv/mrbUWX6wGiN8uvxYaMa/IKpRCwAuxMBpFsXekD21KiLiGg1GyDtFOB5KdjjRzzlUNxVnWFS4pSjRiL9Z5PaGqJGxRR1zJSQ1KqSL0mvEsCP43X8QDAfOYvzAx6TqRliSitujJDcYbtV/ZKR/HAsNELHHD6UENtU+0VCcC/wLL8alB+q9xsqNmFPh7WyK2+TfiTpjxQQgVB7eGPm9aMlonFY2WvJq/ysqMzFe07goQbHrPdchQXje1uGrRYosYAAQs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1022755c-c6dc-428a-eb0e-08db26d35a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:35:39.8698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOFSvL4avwwuNgEDVrJFKjgc3FZszEFRNFQVxjeb5ANE90xCUblk3Y3I5Re7QskqGQJta6VMlml4NNI7l9BPCtEHQThIvb0zYap37AXao7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7545
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
