Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A1D78AE75
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjH1LHg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjH1LHY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:07:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C91AB
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220842; x=1724756842;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=lvLpc7fwBQDcSj2u0XYiCoAb424xZeox5OBaDQ8ffPJB2hwFXycAbBoz
   3qCBxltk+CxSrAwgxhF7WALLRFgFBFZdotlG/UsIFPeULbRQ88CEOzxps
   xcviXkR4muqAnEYjmKfVFZXAJTAbfV49R3TWisUAOT9TweY8xaxDHBUDQ
   20miygbvme2+95RcFE34amx5rUSm2FSxCk1j79t7DpAR9DA3uqHr2o802
   xuIa4ONHgBmFpU6Ygjs12nIZatNEo91wR/UskfqHKOkblM6ORsdZU0HuU
   r0KIVev0OXvXolxLZSok1HP4PYC7yDckrlhmaCodZfGJos4tBe/D8PPR/
   g==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="242248797"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:07:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egtkKxc/TAuQUwGvuTRFnTPrG5KXGsN2e5ZMe00LiTqAlGA8uRflwjvIH0jglHvPxHrg8NGuOI/QdpgLEtpkVg1S+/Ks8GD42i8VYe4u/Jm3VE1NxfZB3fwRCbUECYku6iVZvuf5k0xyYJy8u8gNMsJAa//MPNR+or92s6yMihLoYfM9Y8/DWi/BFi/c0oGXZePggSbsPX7yyIabFAcQGLUyev2vYpIyMBCEodqlPeDv9Os/Dz4GqDzQZg5lMxvl3HJe99jATxxQKKKuY28jqXxB6BOVlIPQ6b1/KgIYWG+OO2kgTAxRBVfwAWFaUzbyVFQDgeamoWc6V1yQIPKqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=mt/n/Wu9YMCgV5oykHaYFpyRKU1yyzjQC0BXzR3v2tem+9Tl8DwkTKoIiUn3TLHyXGtefMw6C/OFwm7hv8iVKyZF1vN6ZKzcC6+MSkKKbOHYQgryg8iy9vl1mlnyFrETOu97F0wN+3o7HIICEdn5UJlfMxPnAf+PxTXRlkhZHF9O/NR+4v+moB9KEw1hVdW370h+tEI4ZFSMcLGf9YrxpyNFbJSn4Qz73uM3GIXwdJw4kHslrRzq4ID6V8/36upg9CQbvQwVhrrqv6OPxX3z4UCx18uSqbUqRaJr36U/Zgl200dHlvpf9HT1d5IXYLuOcwdv3whMg6It9Xr2bPD/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=gIAIsZ63CAWdF5fZzugSBFGWCgZV7zwCFst7/eBLnpV2dxV5+orNQpKXdw6KzU8C9DR83K02FiKDx1ih2AyBPer3PurmEeXkytHF7zn4p9iBIgnKqiX5mVmC0x6hKtrGUJeKJevpqFoexpVVsj6DTxi9V3tisCQdpSSYE6r4xEo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 11:07:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:07:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 10/11] btrfs: include trace header in where necessary
Thread-Topic: [PATCH 10/11] btrfs: include trace header in where necessary
Thread-Index: AQHZ1ckCrWSqpXJR1E+kjFepvWnTYa//lAsA
Date:   Mon, 28 Aug 2023 11:07:18 +0000
Message-ID: <1b9cefb5-1e79-4ad8-901c-b5aea2104553@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <59f02409baa3a41239ff61c3cf4c62b2a26501b9.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <59f02409baa3a41239ff61c3cf4c62b2a26501b9.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 1fbe4367-f96e-468a-1d60-08dba7b6f205
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6jO0fpwEoNCi2wn+0TSosOFY4yZ2S9uDjlj/6Nfh3mO81J+Vx1WyAFMsVSizW85ji6Jwm1y+9q3BzdpaejM6noi18BYNLulOl8ohe+V8X3HwIWXvMYyqgQxVOtO4Z3FvDpYS6xbIONYYMBdZwHvnaiJMrps3WSheiJTNq2ChD1JjQQKE5kJVaF5UobWjSInjAMJNidaD3ayC/XTvfzH6fOAdkXZ9yYAYWwKv4Z5YMvOW5/vQphzdn3ex9qzK/gqxOWlx+C+KmPfv5gOKb0JAviqZ4IoJXJFlraI7cbUzrdnmVkHk6vZWmdfPvasZufrnrXzwr4MBXyJao7TC5Af86+MZ5SLz3OWxCvWd/wdKUayiSA038PX4CBLJ1FyqzqegDOZ4v+UOFnWCS9tfEVZqG75g90XhAK/O+V1V0YeWKg38GJzab9rZJ8SFVa+Evdl4cgcab4RYoY2D1fMmh1NW9IKQ3edYQ71rwT7adjx1MZi4IGtwrBhEOrh2lPudcfGDdKklVgRU7vv2DPt4n9NFg3+Bv8NaGJFqDDIyPNNZ87PMbyz6p2xJVawg11ng3RifmOO9AP44zXXgN5KhK/copY3EH3vFCFQYyFu/iAcxnQgjeq2PNIKEu9BqBs2DsLqhlVqyGL4i6Tj9pkl/l/XLpUD93E4EFLVCrplpEbY+99VWDdSu9ykekS0WJXSTkZHi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(5660300002)(31686004)(41300700001)(26005)(6486002)(6506007)(2616005)(6512007)(4270600006)(38070700005)(122000001)(38100700002)(82960400001)(478600001)(19618925003)(71200400001)(558084003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVdpNDNNWnhpUUo0aGkxdytqbFI4b1dGaVFSUnFSYmdUaktQVXQwdUNpVXJr?=
 =?utf-8?B?TytaRmVEYmNYRGpsMnFMR1RZNElLQ0g0cEJNQ0pLYmRNTklrdDk2V1BRcEI3?=
 =?utf-8?B?UTAzMC9PaWdVOW9zdHpETU1jV2VEWHhMM0gwNXdGN1pDdFVMUHJ5d2dGSEYz?=
 =?utf-8?B?VTVLbkFzTDJ1V2J0c1BGYTl0cEFUNjhCQjZLdkM0VWN2dWk5cHlSc2E5VVJG?=
 =?utf-8?B?NmdJYTF3czM1dDQ2SWN5WTJOdDBURDJOaThxcnorMTRmSkZ4SUhWZU9HN25l?=
 =?utf-8?B?WWd5Tjk4YmVWM3ZrMXNnam9yOWVZdTVZdTR2eHl2eTg4K1hiR25UM1RDa2Zu?=
 =?utf-8?B?NFk5TU1pY3hiS1VBQ3VtalhGaFNtY3F0K1VqV3JEejBMSlZTM0paeDZFR2R1?=
 =?utf-8?B?Z09zOVV3Q2pzYkM2YlNIajJQRlFmNnlWbzJSejZxQ09YRUNWVDNLRi81UjBz?=
 =?utf-8?B?TTJDQ1ZrUWZITDVHbk5sOGhoZFg1amxYNHNZcGErejRKLzRiNVFIUFN1WjlT?=
 =?utf-8?B?Vlkvb2VzSGZCRVZTWU43bXhYUlRrOHQ0NSswYnVabUZTNDRxYU85Vno0TzY0?=
 =?utf-8?B?eXN4NUdyQURaUWlxeHp3OVZSQWU1bHliSVp4Z1R3M1V4ZUx5ZWdMa2xqOEw2?=
 =?utf-8?B?dGMrNUJzUlEyUCtIUnVoM3RRMjBQa3lPUTVHWVZadVVvTjVraFM1Zm5NSU1m?=
 =?utf-8?B?TFVzNnBFUDZZeHVpT2dkUmhLM2ZjbUFkVE5aN1p5NXRiL2hIcmp5NmgyT2o5?=
 =?utf-8?B?eFFHbHlUcHo3OFJjd3pWaFQxcm5wWjlSZ1ZucVJLYy9BY3ZWNStYVU5BWWZi?=
 =?utf-8?B?aHczRkZPSkxMc29QMXNNWUthQ2dkalppMU9vMXNrOFdBMmU3eDNxRThWcVI3?=
 =?utf-8?B?ZFpVTWN1WUY1ZTZKK0FoTmNPcHg2enJhTDMvaDNVWlk3Snd3cG9pL01naG5N?=
 =?utf-8?B?ZnhNNEdnQSs3ZDQvajFYZDc0aTNyR1JWc2lTYzNPUmh1RlpsUVJ4VHRaU2h6?=
 =?utf-8?B?OHN5S2I1WnNqSFJRM1FUbC9aeUl2SlJqdUJTK1RuVUZJdXMxNzJELzRzNFZ1?=
 =?utf-8?B?V3grYjdIN2pWZXdaaVJxRmZkV0Y4bmVlOWkzRDlwUHZDcDlXd1BYb0Q3SlNi?=
 =?utf-8?B?bm5KN1QwSzFjTG5vTnVBYjRiM3dEZ05zTVA2YTZKcGxveW96YnN5WHhLMktH?=
 =?utf-8?B?M0xjbTNlWnZieHh4OXE5OGkyUGdrak9EYzF3Q3FXZk1nZTMwVjdyeFJlSDlx?=
 =?utf-8?B?RHV5UERqSEt3cmFWRldZaC9MZHUrcXA0c24rQUczQzY2ZytVcHg1Z0hxZUt3?=
 =?utf-8?B?eTM3ZmNybTVVOHJJL2duQUZiK3VBN3Z0SzBFOEVybCt2bXFRSS9mUUY1dktO?=
 =?utf-8?B?VTRnSE1mZlFsN00xWDJGNkwzUG5lUnBxUnN6UEJScStQMFhpaW1POUx1bW83?=
 =?utf-8?B?LzZUZDhQQUQ1MnRFUGdZWTdSb0JiNE1xZlN0ajlPdmZvTnJiZmtpSlRCTk1C?=
 =?utf-8?B?R1NDT0h2c0lEVkVKQ1E2T0F1djlSeTMvRVFjR1lLVmhQemZQcEt2QkI0Q05V?=
 =?utf-8?B?TTJHWEFlanFkQkNMWnVrcGViRUVUdjcwZGdHdHBmMHBBbWd5N3hDWUNOVmxB?=
 =?utf-8?B?TXBnZWhmNC9LSDJOV1h4dTBWQkFKQlRjUG9CdVFQbDJ5RFR1R0tFbTQrWndP?=
 =?utf-8?B?aWZXbFFIRkVKSnBZUm1qQk9ZNCtRc1NMSnFwYmlPOGNReE5qT1Fkbko1Ukt3?=
 =?utf-8?B?SGY1OThId1ZkUXowY2dvd091bHFxdVVINzhWeWVTSzk3Yk5GOXZoRHdaeUIw?=
 =?utf-8?B?OU94UDh0dzI0OEFCLzg2RTJvUUtTKzhCUkVRN29SSmJMWEhSKzhRNC9jS0py?=
 =?utf-8?B?bmVHZHNGditXQy9JMEJpekFkTlV6ZWw3ODEvV3NUNDRFRVM5UnJZdWVnbkZV?=
 =?utf-8?B?RkNzMmVLS2d4N0t5Z0hTVEIrekdBU0lEWFloN0dJZW5NbmJiTis2T0hIV0p5?=
 =?utf-8?B?bEE2RUJEZlN6cVdYM29iLzlPcFVrZnRiVm51OXZFVmJTMXAvdnNibVVKT0Mw?=
 =?utf-8?B?SGpmR2FCWGFrOUNBOFhTL251VWtKcHE2b0l1Zmpac0cra3ZFQmZLNnBoOVNX?=
 =?utf-8?B?ODJBNGU4Q0QrT1pJUWNNSGpxVmwzcUYxWUpIc0FnVXprS3pNY0g5WlpWTlkx?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD60B589F79F0043A84ECB15B16984B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I6WkQGDGoMsYWN49ttKcVecdVLTDYi2dppmOihq0CjemNPmKhd6vC+MAfbDQI5lFz/3i+X1h5P1TxF0kh7NsHes4ai7km6DiLI8u6Myb/ei2KuzCyiXTvk61BolM+g79ri3z9m3pNdA6uQdqRCinGydosXx8LUigrltgOfto9AlELCI9XFtN52j5wGKy3BB6y6AsvxGY+SxI20kvdpDamOI2NP5XT+aB52ehECXg2WI6wgDrOvujc3nrywI3bls0CglL1oqUsdZg44z99XiAkoWe7xZ+63xchEtcJNye24oAcXmTnGTNPOIXuLlwJo4E0HR049pohlyHEvy2qX7gSXjYFx5M42iGN0Kjt+a/ZW1s2T8ctI/ETm4ibm3G4giZwf5HDwUzXkxBr518WYSAxgPANxc5YddmpCI5mT6zPH+ITwefP3Nvasj41zeQ4F95Sa3QHK9sBWfsbLHc3BR3Xk+iFLCrIT3OGTc39Dwjaq+UdYAZb8cBSwgbMMqMoPlXQ0TVAwzeLGqrKG9S9ea+qBMLAvDwwq3pYN301SiCNkknMzz9iW9JhfWF0SbEkS6gO+2PZK7K3QjW9GTIZmQ7NZ0VuddfzEuL3LMyEunOXtu97YbiTmMyXKcwP80VuS4jruUeheN+LwHsABVJ0rIF4zarHa8BiuU4k1RhQG2FEruWZSzGRVDZIlfIEWvXAXPYZr7XUxl9y7U9XjYGGulk53/ck5ZcKHsYfIF6Ws4B3KAEjDeaqHLp8guQCC7SmN+VHZ4yO3PKCIfC7MZscGVz+eGMp6g5YnIX9gzhvm8GYvkOVu0LWkoywhtEsGLX/14bNL5/ZGiNBkIoxAdLy5UPuQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbe4367-f96e-468a-1d60-08dba7b6f205
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:07:18.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3MW9Ch7nlo+Ku3YkUfuwXtW0pToTkhlTDNQvoqdFjXoCf9sSdrZRtmPXHLj/uHLuaeo0UfecowwqR2o7pfpD2X/8XXXeHbZ4Iv1N1J+KXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
