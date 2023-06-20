Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753B73679F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjFTJY3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjFTJYM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 05:24:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12A199
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687253048; x=1718789048;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=0FKFRXGXBv9pVilvXaZKoNJa8vzcpwr7rgOaA8RG4fk=;
  b=AZ7cACPWVhS+I87hrTiv1dKdXMdz4sC5Ux6yOL9JIH1NDHaKwBl8A1hT
   sXIiGPQUoWHKb2u3GZR8s4BKXKwApd5BOJSdgAGpSkbD1KKcr8anGhDK1
   C6Fk4kz6UVL8s1jokT/4zQYM9fVkJrFFVJn62KWhO2RgV5SVI8MmjTMdH
   xOU+X8FEmrBR0+Jbb/9Bnvm+tKLTx2XQ77HLku06jOZm278Ichhs6Di6V
   x5b8QZSsH5s8wmXF7HkFXx1W8MkHajqegD71LeGhL/WsR85Df5Vp2+huY
   R2zO+SwDTCw9ZVS/boxjmkfBLJSSeoAanEij5of/qvFcXgpI+7jJma6lh
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681142400"; 
   d="scan'208";a="236368186"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2023 17:24:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aONbtB/xxCX6QjyaFW3AO6AgbR0NPBY1mxGbhIQ/ItlkRAUafoSo8Z0U8qhxu2vvKTxkXyZSl6qbSOXqtIOQt1NuuYqgdQLwv/7PSpkel0NapJXL1aF6+/ZEJRxZXg4HxiGCAk4aXQ8j/OOjj8iFmQrfyvNQy/78rid1FZbnTzFZXbJ8I7f/WxSmFFjkp/k35p2IgQQpXT3cK/aZiekFQDvAg0zi4ECbVRlMyMnAl1LHStzog+6FnZKOxjp0djPFFNpGiCEpFsoBknkvfHvXgMSzEY6E0qXmrRDOMmK7oJigVRmMxs3DdKoWRRQ4sRSxMLAuq+j0JBtinzZjDX32qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FKFRXGXBv9pVilvXaZKoNJa8vzcpwr7rgOaA8RG4fk=;
 b=JVwjtzSROW8UblQ/hgwWP0tATCGbtXeooMy7Uc7apgjvPnkunMTPZfnbZo2X6eHPypG2M7CjUNE0aaiwwpdxA7kFeUjCGHvJh+FqMA0AF5b1GkZkgRmLIMHnSKg8566IOw2P94mkZo/U8mjRGqx3uD+VVCLBUS8fkl3AoreofcVPA6W6Au8ec7dzDvoSc53DujtWYZ2RVr8Q8TwYkvxNBzw8Ydc7JNSBGHa7SPdb5JfEfJu8CzV5ZIgcNolSEdYR19t1uWiEiOZUyUR30Cz8gHwcKdhHOpuTJXrt79x9u6p/2W9AnO9MLIvUxRGm3hdnRwb+k8I3wCNqBaPxj2x3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FKFRXGXBv9pVilvXaZKoNJa8vzcpwr7rgOaA8RG4fk=;
 b=LZpvh/1h+oxWK2luIhkSBH3jBUA5Rbzc/fQYtjo1Bh44fVx36w2uW20/bqrfuMsUG1b3zQb+TM026l4MBVU5fPXcP30WJlPabkHoXLgsLRBAktwOYXQ+OO6xTRIVmtJfWO0yj6n82UrUpbToC0D14NXaU1w0wT3umN2WV+k2eRE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7522.namprd04.prod.outlook.com (2603:10b6:303:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 09:24:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 09:24:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] btrfs: scrub: implement the repair part of scrub
 logical
Thread-Topic: [PATCH RFC 5/5] btrfs: scrub: implement the repair part of scrub
 logical
Thread-Index: AQHZoNm1faKVrSeTBkaUlODwceNaQK+TcDUA
Date:   Tue, 20 Jun 2023 09:24:02 +0000
Message-ID: <fab9eeaa-f5a4-6a9c-99e0-a89e8c464fbe@wdc.com>
References: <cover.1686977659.git.wqu@suse.com>
 <7142c08a9a4fe142abe5f77641cdaf26a4da55c1.1686977659.git.wqu@suse.com>
In-Reply-To: <7142c08a9a4fe142abe5f77641cdaf26a4da55c1.1686977659.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7522:EE_
x-ms-office365-filtering-correlation-id: 71efbe4b-bbd9-4e2c-6f6c-08db71701654
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTdLl80nYrbnBTeLnpYMl2gE8AhIdl1ugD1kXJRfRWmV7ur7UAi4O6KdqdlOdnVcPVYqkJsjc9bhDxf+RXY1xjz3Q7Oh64LuECwlbgNY0ZuBe0O+lcW51igRBN5u7Rb1As+oQBUp12IvwfoNVYhSSDD3ywSKK7TSxh4scsx7zMah6iljRq5tH0QPjDpYV13chcs/i4F1fxyEnmUfntuzSTWxx7DWKH3aoFlSCYHZbiRgwdoG8MdEPLf6S2hB+CdEzygEx7LdC4efgMlV4zipZuR+81FHVRitqmXsURM22S/QwRUalwadMZvOGrozFJRENO7SakkBvpYyJXIk73C5swIhCSCUxN1IF9jLc+e9Dj11gA/fRMXJvvAprFLVwooq4eukpzJ+XmLVC02a5HQs8l7cwOBqRngyDVTm6Tf0vHPdS9LhaH6xBEzpoG4Ivcf9U+G8bFaZYOW49sMQ5n/7IdNk8U8pkOHrJVDwZ34Qt8e3F6ederJBGveDYm8qy3V2Y2aguqWxra7NOODKdmSecShgSmydKssRK0OJiWpvEoMDNVS/FyL29NdeyDtpcMSWkjgSm03GljKFdQqHktVrtIcXPQUI7K5dMISe0EdgpTeyBQagNM1aB0ECo7EDqQJVt1zCIobbSV9gkuG6RuOgifbuNoqimAQYWwhQCAeFrQgz1CWP7AJGStLsRVbxXL7D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(2906002)(5660300002)(38070700005)(8936002)(558084003)(36756003)(8676002)(41300700001)(86362001)(31696002)(53546011)(478600001)(6506007)(6512007)(110136005)(186003)(6486002)(71200400001)(122000001)(66446008)(76116006)(66946007)(66476007)(64756008)(66556008)(91956017)(316002)(38100700002)(82960400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MC90L2FwbXlKT040UEhRdlBBTXJMOG9GcVc1bXpYSm1XaXNjcEswS3lFZ2Fv?=
 =?utf-8?B?Rkl0Q21nT08vMGVScFdlaVdDa1k4MnhzUmE5Y2dXaUNjZ3pGU1Z3dUxxQXBx?=
 =?utf-8?B?UzBXNFFaZW9yeEpvbzVqV1VsdjRrb2hzeWk0bHRxVWVHS0kwdE82MkxGdjU4?=
 =?utf-8?B?YVV2aVhoc24xaVdLMGE5WjRFcTBMVE9hUGpqaWtVdGJYRTJYK0NMelJ2R1c2?=
 =?utf-8?B?dlFqSERwVVRPTUFIOWZmY1IyQlR1cHNuWThhSGxKbzVjaFFNb01wenUwcVg5?=
 =?utf-8?B?cDJNb0hqU09KZTNxMjc4TERiZjkwbmlxL0owMkRGdGhXN3c1Q3ZNeFgwbkJO?=
 =?utf-8?B?emdhTzdmV2NmL3pvajRhMjBSVHVVMTcvY0w2M3FibjR5KzIzS2kxZlp6UmRT?=
 =?utf-8?B?eXNvTFVTb1ZOWXZrOUdBaTFJODMzWnA4Y0pKclV1SVMxb0xJRzFiNng3NUQy?=
 =?utf-8?B?VEVzNlRqWWxqa3NMeUZNU05kc05penM1cGF2dXhnRmhrTWtidkhSRmUrTXV0?=
 =?utf-8?B?M01Gb3hpMXlRUmVnTnNvS1JYcnNaY3pRRHByNUU5SUg3RlRXVnZiZEhQU1li?=
 =?utf-8?B?SSt6Skt5UUdEQ1VCdFRZSEMxdk5QSWN1andRQlNDbDRJV0xBVVBwejlVZW1W?=
 =?utf-8?B?WHZ1Vnd5dkNua2VoSHhaWnRBUVVBWmZHRzM3N015QXZPZ1A0M3RTMjMzZkg5?=
 =?utf-8?B?TGdreTlnVk4yd2grQ3p6SW1CalFIUnpnSkVwSW80OUZJa3NDblRraGdRWGhs?=
 =?utf-8?B?OVpMbDlIYStyeEhTRDl2NWFVMWlRbWg1VUhwY3NBakFHcHQ4VlRjdWF4VEFG?=
 =?utf-8?B?K0wrRE4zUno4T0hHTzZsanRsQVZSNjRqdDJTQVAvY0twbGRNZHFhVk9EVC9P?=
 =?utf-8?B?amhlOGNHTDRQUVBGTGhCY0pzaUc5cFhPWGc1RE5pd3ZmdzB0ZmkwMTNib0xr?=
 =?utf-8?B?dk4vaGw0RXF4aThqa01na0RUR2o1WEpEcHo2VC8ramt1TXFTVnpwTWFKRmtG?=
 =?utf-8?B?VkV0a1h4dXBWNmQ5T2VHeDRGNzdPSWFLY0F0a2J3MldDYXZQcmdQdHgrTFNI?=
 =?utf-8?B?WWk5NFdqU3ZyUm13TGl4MVZydTQ2WVhLYVRCSnVYeE55eFJZSmI1cDZ2ZjFt?=
 =?utf-8?B?ODV5dWF0a0RsOFJIckVzeTE3MUJsTUMrZDBkcWZWQ3FOYVNJSEJveDU5S2wx?=
 =?utf-8?B?QlpKeXMxdXhHd00vRGhWY0JiU0JULzlveUs3RE02cU1IZVF6Y2dJSmUwOHlM?=
 =?utf-8?B?aThTQTFkUFNsSWlTSmZFMDl6ZG1QNkxTeVFPUkpyS2gxR2NGeUx6aWQ2UVRl?=
 =?utf-8?B?UVRwRWlFdHZhQzJGcXJKS3Fpc0daQkZUV2VXQXVmU00zcUh6eHgxRmVJS0d6?=
 =?utf-8?B?Vkd2bUVwaGYrajExNFprQUN2L0gzZmFUelB6dGg4OHdDNDMyRFJ0MitPd3Bu?=
 =?utf-8?B?Z0tKdVkvTlpmUG45azVQaWdmSVRlTW9GeGJ6RUNaZzZQMFJjRlhUVUprckN6?=
 =?utf-8?B?T2pCcnM0aHJDU0NnV0daWkFRZWxxenFueUxTa1hDNTFvbXdGdmROQkJ0amZu?=
 =?utf-8?B?aDg2OE5sb01aNjBVT1hsejUva3E4NzFtK3RteTNOdlRRQU5GQ0UzY1RqeXUx?=
 =?utf-8?B?VmRWdXVFRVdWcVdvUTZmL1p5QVVmYVA0NEpIenlUMlMzaHNTdW4xTjQ5Rlky?=
 =?utf-8?B?bUVya1YxbGVqRm9XREREVG1ubmJYL283cnFYSlVMdXZRMXA2K2hFRGUvRWli?=
 =?utf-8?B?d1E3djREeVp6WDFWOThZU2czRUxETGlaN1FncFBMVkZmTjY2dm4rV3dSWjZM?=
 =?utf-8?B?bzVlM1hlOWx0bUVnRy96TlRUdWhsaitBdnFYM2tGK080a1BHQ1h4ZmNscS9U?=
 =?utf-8?B?OHNQbi9Ec1VCSTdwbndPU2lycWJuOWdvVGZMK2Z4L3JraEFmZTZHdFFrQk9I?=
 =?utf-8?B?RXJGNUJIK3oycnM4T3pmL3VLaUpna0xkVlcyV1dGdG1RTkc5VFlxcGwzWUFP?=
 =?utf-8?B?cVdPMTlEcERSSWRBdVRtYTFXenRXaVplcjVjcUdXZWpFKzFPNytJaHpGMDJI?=
 =?utf-8?B?MTc4S0Exalkvd3ZSNURsY2tkR2RuK0xrVzRjMEZ5U2FCcnZzRnRjaU5iZk1I?=
 =?utf-8?B?V0pBT1o0UWhSYU9YcjJrL1hpa0FvOWNDdzZaOTJoS1pxd2VkbjFiMEExTXQ3?=
 =?utf-8?B?d1lFUGhreEg2cmNteFpMMGd5R0Y1cXJjbk9OYVFVd1ozdTE3K0ZyblZLUGI2?=
 =?utf-8?B?Vno2UWlFcDJFR04vNDBqN05VV2xRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF8B38324815E44387D0DD7EFFBA8A5C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SoVYdnixOuXefh5t901UK2YGcTF9FvmoAoF8A2PsL5QjHpDbgq2djQwtfaiHO7nBr33VqCBo9ulFeK2LkPvWLT0bPHk37JOXdmZmLabwNY8h2nEhYMrHGw6n8RNKTvhm9E7P/9ENbGu96Uupkf1TJYAXoJJ4HLmVO6v9bs63LIer4XBIpErt8AbW+izTXXWTZzdZ5rv6A/9VKeqknN+9hfiIxPwWG0N9b44TOtm3n0dQVaOMgVnLjrk4IMvUdg2yPyFp7ps2D4B7sd3cE9rVMZzMWA7oVmThC7tWH6RsVFbNRV2VnG/bUYSJqORrshP9LNFpIM7CNYKCvfGjdnGYfy/UnNLeRHSk4h5mBD9gY4PO04NuYTZ9gXWgi8A9GA99g6G/Do7g7ATKjrme0MiehOnSXBFjVubBy4JlzJhU6CHk5UxY+bSg55YIAwq6IdI7/gjS42nv7+Ogp4dvxBBmSkxZe1ffgCA9w4sRANKO6AehqF8mtm0Od8r0xre3dTs58wd2liKq7f1uyS8ESAnwVx6hiSEyCXMxOyljPuKRkX0kZGD7ycoNEp6ieOb3uCcBTH+T9t0JzAg7Ah3beRYIwKJ2HlV5ihRxH8MU7P0AEzbP54hPG8YsYaySTN1L2dmzrc3qZj2MmkyVK5bCrXui+4tyZR1Cv9v2bM6qqnhBkH6/tMsS+G32l158jWrZofDw1nnEpOPHqw7FOyfT7YZQUVW5kfglov69tJ+WxzKNXoF4j2pwUKgsz8CXLv4pzSRWLsfKa78axPulJdcKdbNoiNPEQx3QSK25LaPNsQObZM6GL4PVhfmONBsY8Qt3/oCx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efbe4b-bbd9-4e2c-6f6c-08db71701654
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 09:24:02.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/6nNf47FcN8KIsawDFi2pKeihQAe48n+fLxYK0Wbr7dyBFZkxg6JVAhHPO34T0txV6ZUPTppijhrYT7H6Tsch6Z48UXQ8NSTJP+HHbN58M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7522
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTcuMDYuMjMgMDc6MDgsIFF1IFdlbnJ1byB3cm90ZToNCj4gKwljb25zdCBpbnQgcmFpZF9p
bmRleCA9IGJ0cmZzX2JnX2ZsYWdzX3RvX3JhaWRfaW5kZXgoYmctPmZsYWdzKTsNCj4gKwljb25z
dCBpbnQgbmNvcGllcyA9IGJ0cmZzX3JhaWRfYXJyYXlbcmFpZF9pbmRleF0ubmNvcGllczsNCg0K
CWNvbnN0IGludCBuY29waWVzID0gYnRyZnNfYmdfdHlwZV90b19mYWN0b3IoYmctPmZsYWdzKTsN
Cg==
