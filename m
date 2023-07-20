Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317B975AFCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGTN2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjGTN2E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:28:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E1A26AD
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689859658; x=1721395658;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=PIKh+QSIR6BGZfJLqXW9UUIeRYf8ygWyxznZq+wEY1Iq25dfFLNZnA1e
   Brbhc3l1FX7zdoMEbD5mTFiYNdVKbprjBvCnzfsAqSC7A2QjY+4KhWb3f
   un45UBBpjbWnRL395zfWn5RN132gDYS7JJhMdJSquZCYoViyOl2BR/dKv
   YJd4GWmrV3S/2lWWXopw6851+hA+0Uq4/liAe8yiJcPm3dNZieIX4GoLS
   TsKApJrL5t7mCfA5CJQUjMlbAF7JmYWxAWNzPH83E6GmoH07ZlfZNfNYS
   DffmoNGOyOAurVhrMJYKaHzYF8+M2wldi8MrwZLkHaYYEBsZma7F3MBs3
   g==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684771200"; 
   d="scan'208";a="243252840"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2023 21:27:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AORgd6rDughKvzhllekL9GjU8JXgkPZexGLAAcsYL/mG76XuUCi+kxdsICUyIv2KZRjQK0hKPqNc2b66ty349R+yB98HtsWkN+55MdZmk81YJF7Z8pTFh0vbIieozMSAMwkdnV3ICi7dxwaTeDv4uC+z1r1LoVR5nASdg8URajN9ToVrvo3hXeEK34PcANVsYGA+/Igp28ChsOuty/Q+P/pCEf17U4FM3boDaXDEJ+WrbWo2W4P7Od2lQjtTzxMV0lxtQvKTz9FwTcIQl/5i7INo+c6kHpQdvJNuZQpQD6+L7SxsnUnhVjpDu1U9ZU8sz34QbirvjVzdt6Q9JbbwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Zhc/WerNxdRO2WSZQ2rrvOvlJA19smTCAEkOnfzRpYG/Vl/IXbVg2K3ju9SwlB5xi/s3w4Zg16WdEPVchE3oeybNTze1dIP11mn6y6feLx5d3xx38gVHGPVJ3GLbbANWrictuhoEoHYxvmFtPoAyHTe3WnChI7ruvoP2J2npfo8vipwXLIBwMSUhqenxHumTMmh0fDo5KxRoNgIskVWWnn+z2A1j1JnKG/31+zGOmVHs0EEp9i3C8mHZ1VRjYT86pB0puoOjyS8pqWefRzTSjjGpy7e5kVXqx1o7qt3LsDjfpkFdkwN3DaBDkinbqgWIS4Exu6Mj8XRvWDfGIvjygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dWJub3GRcaNeowQcY4EHBqczAEWY3haN+nL9+u8z3C/ff3iycoV81Vyx41MTSOtjx006BvVZZQ04AZvtYtc3j117hJ026aPKXSXhw9B9C/bbpCVU4fydBVRgBoyrMwDYZHDwm0CsClCo0Lg+Ua+LEYHFhGNRovbE3NYGh/lBVM4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW6PR04MB9027.namprd04.prod.outlook.com (2603:10b6:303:23e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 13:27:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::64cc:161:b43c:a656%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 13:27:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] btrfs: scrub: avoid unnecessary extent tree search
 preparing stripes
Thread-Topic: [PATCH 1/5] btrfs: scrub: avoid unnecessary extent tree search
 preparing stripes
Thread-Index: AQHZuvfOejwGVdYcKEG478RRIbaMiK/CpdMA
Date:   Thu, 20 Jul 2023 13:27:09 +0000
Message-ID: <f73e58d9-04e4-4895-8f62-cbc9e178400a@wdc.com>
References: <cover.1689849582.git.wqu@suse.com>
 <a03b32b15e44b8a57e4330bf33f398f9243e7fe0.1689849582.git.wqu@suse.com>
In-Reply-To: <a03b32b15e44b8a57e4330bf33f398f9243e7fe0.1689849582.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW6PR04MB9027:EE_
x-ms-office365-filtering-correlation-id: 19f5d5e9-42c8-4a55-f96b-08db89250506
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysRLDfewDvk/hf2fsKHZKLbuI+m2202edmtgAYBU85/IhGv3YMCqKWQgKRR87Ol/Au9k6AnYlFD74l+1K7f9iU6iSy9RA29jOUCaSL2Uo33KK58AVVgdFiReswtLe6q0WRvv7JdaSo5nm28SeV4eNvvx/nszUDesWiAcHC6Z29gIqfHCEE+Ceq3pqW8R3K0aW2lYBik4x84R+ExLzvRqTzgJMl+vFiOT2qZaWmMDmJv6ATE6cQz4MgTqSxrv0MVeeNFuUWikKjLFsofZmGiADWlZO7JVWqq8Yhax5iz1u8mbJ0fhLtdoFHxibhs+EkTt3ewmeJdFM2fSOk3RccfmRBuHyUuPL72O9QIGW03Ggry4yJra7dwpaLopHxbPIHKiIq8/Ehmd+VEKbLdFdkQz2+Ke/WZcpu3Br0OHmuCdDb3UxQ7w7pQFBFo1swK3ogtPpAc4yX6oJo8kKVj/qGir7/lE35rNjemXLUKDFUlYHeS4/nRE2IEgHF7+DKpDx/gWtB1acPW4O0pLXGYY9Fr3S5kNqxf99F2S/qUY1R6MYIYyha81G2AQbfsHXM7Hk1jddNPNKMoNqpbTDiGimq5GZuIhiEJz1LRlME3nnwa75xjp6INkU/1by+SLL7hKAm1Fu520LLikf7FY+8hIF2G87fEP0xD4joXwHIusCskDF7hJurfIogIGfjaxS2/Pwr+A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(4270600006)(31686004)(86362001)(36756003)(2616005)(316002)(31696002)(82960400001)(6486002)(6512007)(38100700002)(6506007)(71200400001)(122000001)(26005)(186003)(110136005)(38070700005)(478600001)(558084003)(2906002)(19618925003)(91956017)(66476007)(5660300002)(66556008)(64756008)(76116006)(66446008)(66946007)(8936002)(8676002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1hxdkpMK2kvdkYwSHdNVG5UOE5ub3BpK0c0OEI3MWxqcDFWR2pKU0FtelZh?=
 =?utf-8?B?R0lkcHV2cTVjdFVvbWg4dkozOTJ1VW5zN0IyOUZ5dEc2VDcwd1dVQk41Yk04?=
 =?utf-8?B?THVYdlYvSVBuOXRoUVBaVjNkdjZJU2lMMHFjc3NlNExRcnRsUG8ydDFvSFJq?=
 =?utf-8?B?WTdYTk9wOWEyMzhINFdLK0R1Y2VDSTFjdnpNQm5CNGNySjl0RjNKNG5rcENs?=
 =?utf-8?B?OG04Y2hxbTV6YW5kSzZaQktKNktVdjRXVGJDWUYwalRBMVl4OTUxUmhodHgy?=
 =?utf-8?B?ZzdST2VzMTlXTk9IME1jU05WUHhqOGRYY25PRUpuN0krMnJyMTh6YkZaVmRq?=
 =?utf-8?B?WjVXcW4xQ0xicE9uUkg2Q1dacVRWUWhIQjNKWlkxaE9ZYjJsQlpOQ1UrOFhW?=
 =?utf-8?B?M2R6akFHeFdkb0xHdSs3cEdhRWNjWVNUckNGenBEeFlOSjE3UDBPdTZnY3NG?=
 =?utf-8?B?WUN0UDZIaUZPQi9zck00OVJ3VTc1MW1kK2RJQmVESUJOUUF0cnBwdVBqck9a?=
 =?utf-8?B?U0xFTXBobGVoZCt1YXRCSDBOUGRFazJ3TStTYkpxQVVLOUYzZEZqSXArOHlw?=
 =?utf-8?B?d0RxRHIvUUdFNSs0akVlUmkyRWtPZ3JxR0FGaHFYTGEvZnJQZFJoeVdvbzRz?=
 =?utf-8?B?c2lkUEJZYSt5NmRiaDhiQ2E1TTdzWDJFV0tTbExLTVBEWmxsVXVFNENVb2gx?=
 =?utf-8?B?dUs2aS9GcDQ1TDFGejhrV09UQVM4M3owTHlPZ3pxZGRUelQvb0pIS1RpeC93?=
 =?utf-8?B?QmJSaUh1UWhUU1dtbk5yM0lKRUhOTlJBaXRiVFIyNHJSTXpUNjdKWEFjZ3JS?=
 =?utf-8?B?V0xrWUhOczZnM1Y5LzlxZWpnaEoyaDdWUk84YlZvSlpQMGhyNUhVT1FtcjB5?=
 =?utf-8?B?N3kzVzRvMEgxUVI5MTNBTGU1OHpmNGpHMW9zLzJ6NUE5NjlPbTJVNWZkYTc1?=
 =?utf-8?B?OWpQa2pQMThyRnY3OVJ2Um5Bd0NsYXVpVmozbEliZjI5RE1NSktEZXJkVVY5?=
 =?utf-8?B?aWwxMHVqQWZkQXVhSmE1OGgvdGVIVlgxNjJvblRJcGVKUWFBQ1gvU3dJUlFL?=
 =?utf-8?B?ZEVHdnBFRGdVcFlMTm16RlpTZ2NaZGEyMmN4VkVTVThsUWNzdDBTd0twZjNK?=
 =?utf-8?B?VUNnNy9MT01Da1hoUTI2SGZQb1RHZlB1RjNyUlF5SURBM3RsWkx0ZmMvb1I3?=
 =?utf-8?B?QXdCL05xVk9COXRIaUVMVDh5b3RkRGxLbHA0UWwzN2oxMnBoYnJhZXc1T3lR?=
 =?utf-8?B?ODJ0RWk5M2FDcndWaDlJa3FxNjF2L1B4aUJzMk9uUmNwalAvaVhlMER1ZlUw?=
 =?utf-8?B?OWlGaXZTaFhRYmZkL3daWlJFWGMzTmJFYm5pc29TWlRYczFyNGdoYkF1RmhN?=
 =?utf-8?B?U2dHem5rcHhpOE9VK0lvS09CY3IwTU9BOXRXd3hMZmJ5ZnpieHVLSEptWkZj?=
 =?utf-8?B?NC9abUFkSW5CdXFTMk5hZEt3bHpoai8raDd3SXdiWVpvWjNCY1JLelhGZ29G?=
 =?utf-8?B?OUc3UTJOSktSd1dhVVpWazRzbkNsdlBaT2luNUxDT0ZLQWI3b0xZUy9UNWgv?=
 =?utf-8?B?Nnl1bUVqNDlIQm5JT1kwcDIzVWNaZVpRTGd3eGJkTlozZlJpVEtBZStIOTZk?=
 =?utf-8?B?cjMyOGVTQSs1WmFpNU15cStxZ2xuLy9BM3hmZG5rWlFGNktvR1NmQjJ1OEZH?=
 =?utf-8?B?M0hjclYrQUdjMCtDMFNBRHlBbkx2NS9lMTlqSnJudFlLVkoySmdoQnB6VzVm?=
 =?utf-8?B?QTc3UU1tbzZqTG9LT2NEcmwxNm1rT2dyYVNmcXFsUHluQVNJRHBzSnZzbW1R?=
 =?utf-8?B?aFdVbk1RSHI3YVZ6UUpLSVpzcWhOa0srNFpqaHRKMnZKQjcrN2NKN0JDN2g2?=
 =?utf-8?B?Q2FJNFh5OENVenYrTGt5a2d5RDU1TGhjU3VwcHF4SmtuNXFWSG9TYzRhcGJ3?=
 =?utf-8?B?QVZrOVRJOWY4dHgrUUo4ZDBoZWtYcE15UGhpWXViT3p3UGttdDlmOTVOQy81?=
 =?utf-8?B?VlZMdHJuSDhCSk9ZOXRWTWlwTmU5cGUzM0x1cVhpdDcvaG0xUisxTFVsYjZq?=
 =?utf-8?B?RTJpM1JnQ0JJTVF6VDdjeUovb2VEbUFxaGRHNitWK2x1U2JoelFKejUwSm1t?=
 =?utf-8?B?V3hLZVhDM1JLVmNzUHl0NHVQRkxlVHFsMHEyUU5MTytaVmEvT25VVHYzeG9I?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCB53A5FB1029D4C909C1AF94333B8CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E8S5b63BRvEFzx5umgLcYLo3+QdROyFFLG9H6A2w7WhjVsFsPxzSktxWJX4lUEF/QmBlUvaHN8oU6xsWtiOb3gq20lqY0Tv+vaAo3TC8SZf5sXG7037KddGLRj57kT1PPT2K4evVEeLfi0KLVjQwpKFT9v6Vl7hvKfNyhLt4kGEUPVep8rgcdnD4DXTiMoUc4/lmChHHM9t3WCKGmZZXi13kdor/yLkUn/ilnN01oviBz1M142dqBRBzaezmMSyw4cPBJZ9Jn2YSLXW+7njjtfjJqfaEo3AMMWBKiZTkx1LKQDZnm2VyqmpFrBA42VNUU2XLOqaPxSSX1nUwWlkmNLtaPGMXcLNT+qdeRQYZWz9DT5aMevfRpdSr9eD0rksvnPBmguzuhedLxcMySzDIsLVT8RFmHrSDcZKyoVPaAXhI6LFh+aABwq68Yj7phCpdk3TdB/e5TZz60ZBiHH4yBLrHZQsE1bVEUmlULpqihCiwTw+JV6anwzqZKIbw/y3w3LgwdDhKxCtPheVVrSl8uwCRdK3n1Nej4tSx4PSidt8M5hy44fk40IqSt44OHvmyKSxowGVoACSR5JEtlBaTJ43A+itCLc0ED61jsp+OVYLtQvNtXIvzXCTjcGzZasLZxV5DBiv6Ngagxe5EaEOCNCxnVhmd0aUV9iB5Gc/2VTstDrnwS3eDZKF3iJl2ppAeZVNBObf61gYA7Df6a2QoIUGjktbScHrEXowagpmiXyegpJHGfqVgJ/7twXmAOGAHtU+Z0XP7TCyPOz17iMW7W2jFrRcI8/IYKiXA3f1Pjw4JeHxs/84BsOXR1vvLMS6g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f5d5e9-42c8-4a55-f96b-08db89250506
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 13:27:09.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6S9q2gG+OPRNVpl1BhyHPaEQK7u29vX91kNV0zHnepric90/PDJfJ50VJU7ScAtAePHKcPvoAdrrtUxWoPht4LEycMw4shKLCVn7oHOAAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB9027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
