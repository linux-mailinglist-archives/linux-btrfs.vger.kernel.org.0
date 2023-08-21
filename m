Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3686A782A00
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 15:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjHUNJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjHUNJ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 09:09:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2A68F
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692623395; x=1724159395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=R69I1j1yl3fBHwcOW1DTxIHZtUzQ8bbcIFqqJ2ljz8Cz6FaT/oHg8PA2
   Npw2/3ZjOi5OdgheknxKSZVxlKH38qf81ihLiwRZE+IKpnoYpIbrXzOxK
   AyHXQOLLQl9UI6+9yWvcQxJHRRbybCUKidfvK4kkpLnh15Re1Uy0pEPCf
   2NFV1tSVSHJ9xxUl+2ojbGo8MIESZDe1M4AO6Kf/v4wBGQz29hZlTjPLo
   v5EfKd0XkCnDJCZC6mQJwtjKTnv6+ORobLtQ/GhjiMRwwIWFHmoJz5+s6
   YGMALZtMABn/iikX2rQd98DNQSW0lYeB7kowfDyyT3TX5l2l0rHv9uptx
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,190,1684771200"; 
   d="scan'208";a="246282170"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 21:09:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uhukx5mvBWVL4I+PALGmRmQchHPiNhmkWo+edgAwrHJG2UOH+AZxeJQ/NMnJcPTwAtsug08kU00Jc8plqde1SfXSBbrKrtoivlvnDQLeJUXtxWA5ndX73uo4mQRXAX5h4XUZd6w0l9t7WpTLKn1pS65kWPdZjXQZhgvnUWQOzGrP12q+dT/L4qyhOYRgf3hleL8TALBzTxz8pwwo9QErj9aczgqgoPHxynxhsiZg+GzrO0uOnlbSU6RcopO/ZMW5hnkxMksBDTLdqNVObWVCqOUsHZs6WHZ9xUUv+Yc3x7r6a30JZO4ruOcaV8sf2qr5/NyxUvTZNFE+fFfGSKQ+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=f6XiD7W51miAyppXc12LoLGup9SrZMgfiS2VdvjVMpxxgkFl5GFmrsJkThN+eBF8KJf4U194o5+zTh8K7RY4b5UkZIvwZ5u2pdEKcfgBYXB/IWoyoHoxcE65zfYxA7+ipjlmSPRzMovcV9X9OFe7ohCGYvb7lWAmY07AjnWZ1rJDrd8An0k+qPNS4zf5uiCPRGVywHkIZrElJ+hPwMSwWesz/hHj6UaDf+MBsALYZwQasA5CUoDGhEzObv5vRtFihNAe02VTgThR8q9mhd+DAcPjFQhEfEdtipHlNI6KoKOijMpcrxdirPBEatoZL3vWVIo6UwQc8evSK/SATgIEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hmm779DrxQGXeePSuTqKHMZMIfUIOkzPM/v4zzyXll++/xw85r0ZmRVR3bmsSvxa3VsDVb/xSm1AyECZA2UwUf+kRvq5Zql/kX2CmTA00vg7Z8rKHi+MyBBT4gfoI6KzjyPluB6PoyX/Z6a0I377yNbSkugTEuQrCO4srYP7H0Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8954.namprd04.prod.outlook.com (2603:10b6:806:395::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Mon, 21 Aug
 2023 13:09:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6723.013; Mon, 21 Aug 2023
 13:09:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: skip splitting and logical rewriting on
 pre-alloc write
Thread-Topic: [PATCH] btrfs: zoned: skip splitting and logical rewriting on
 pre-alloc write
Thread-Index: AQHZ0fC4ma9g2ecy+kCmZEWgAxrBq6/0vacA
Date:   Mon, 21 Aug 2023 13:09:52 +0000
Message-ID: <05bf2504-f541-4c37-b86e-23ea8ea21424@wdc.com>
References: <b9fec5bebe9d5be20c51bf0934a95609830d04d4.1692375606.git.naohiro.aota@wdc.com>
In-Reply-To: <b9fec5bebe9d5be20c51bf0934a95609830d04d4.1692375606.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8954:EE_
x-ms-office365-filtering-correlation-id: 70e1ed4b-1a48-409c-4f4d-08dba247e7ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoX0/A9EjttxjaAYzsfn0XlQuPCRUx559svVBHoSYTe8cJg7ru/5ugm2KpmbUvcXXYbk6tG/NTk6W45B2dsZn1GO4OUyo0aJCVhgre2sMR3gsW2wNhrFBLqx05jLGHD2+2+yQXvumfG89hSt3OEvXH8gXtrYHAsUu0JY8puQJevqiNpGwWV5NEat1rf0ZnrMy7hTpBp61EFvRceL4L/wHWMCXqGiAeoqVwfeYxBgJhhZ9Z0rnroelhs05EtzGP3EGxTag+9VkX+lP9F0iVUDclp35BATtb6RDRHxKScXS2XRuV//Ys/SEgPB0FGgAeDNOmF4/zfAfoy/RDokWmhSQ/bflBDOepKVV71yg6dyu7dD2I6ZvTz2qRTA2IStNMMdPX1+4S6a5aCJ0GhxILHW0uVZv1p73MvqMSw5IyNwkk4FZeFeTNUNMXGJq17i95T8vwZBALSrmPKdjTlL8MwIWc1JAYI6lGzmqlqrnJdz2E4jiHG7m1Kq3yjXxt9R26+jQ/a+uIi/VEtT03wS1dLOATzYy4Au7WL5D8yIWKli9t1k7i1SPQdOEZAPLAQbwGhexvwAqxB2dWb3IIBBUIQAgSWEdU3D3at9VgBYg1uNM+80r9N/8bdKOBB4LLGRdxc07hdkjp4pNF42+8m8Jsr/wb8pbn6FINdPZbiJgs4imyz3UQ+eilmnBPPL4QXePLGS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(2906002)(4270600006)(19618925003)(64756008)(66446008)(66946007)(66556008)(76116006)(71200400001)(478600001)(6506007)(54906003)(91956017)(66476007)(316002)(6486002)(2616005)(110136005)(6512007)(8936002)(4326008)(26005)(41300700001)(8676002)(5660300002)(86362001)(31696002)(558084003)(36756003)(38070700005)(38100700002)(122000001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTZWQnpmbEJYN3pJUDJQeW1pclZ2N2pDTXVtZEpPZGJIN2RjL3dpYzhQR05I?=
 =?utf-8?B?ODFGYys4WENYTVJJYTJ1NGRQOXlra1YyLzhxRG54WWJJQU95OVZzZkhXM0VW?=
 =?utf-8?B?TFZ0cnFqbm9PU2VhMERRVWJOeGpDemozeVZmQWhDOEl6L282UjF3dURFeGRv?=
 =?utf-8?B?Umdidmh5NEVrN0duWUdreGFmVEdPREs1SzFEMU92bVRFTWJ4aFNpdisrTjZw?=
 =?utf-8?B?eWxid3VVUzJQeGlBVWxDRXJnbkZwNVhHTnRvekh0ZjB0SHA4dXhIMlFiUi9m?=
 =?utf-8?B?eDhpd244TlFOeWVWTW8xZUdjMTFhdDVJT3RvTDc4dUZ0K1BJTlEvbkRJcXZN?=
 =?utf-8?B?Z1N0QTJpRUI0aVJFMUJjazBXaFdmOU9jbXVKNHZaOElFTm1uNG8ra1pkZFJu?=
 =?utf-8?B?UlhhMndqR1RlN3JxSVZsaE14Q1Ewc0ZKS1dnMVpaaGtWSzhHYWg2Ylg1TUlh?=
 =?utf-8?B?MGhxVDNtVUR1eVBNT1V2UXFGY05qNFdNa2p1REJkTC96blBRWm1Vbk9iWm95?=
 =?utf-8?B?TFY4SEdyV3JRaDNqRVd4cEpHVWcxSlBIT0t5Z2wrMFV6OFpxT2kydFpUV2I0?=
 =?utf-8?B?MTNQRnlxazJQWXE0VGNwenowc3FxUkZVNzlzOWlBTThiVktIUVBGUW1lSnBh?=
 =?utf-8?B?UTk0cHQxMkpiYjNmanVLMndGand0M1hYTGUrZXQ2SHRtcFJObjBla2E0d29L?=
 =?utf-8?B?NHNwRGxxY1RyV1E1U3B1ZWFFRnlGQWxEMW5hUjN3RnF3OEYzei9ONHpYaG93?=
 =?utf-8?B?MGRKK0ZEdnREMG5tY0R1bzhEVllDeXh2KzRJRW4rT204QWZFUGtpKytSWmFF?=
 =?utf-8?B?ZzhmK1Vhc0dQY2RISW16UnQvUlI2eEFVYWdXR1FSNjJ4VE5URXdkV3NqSUgy?=
 =?utf-8?B?MXRreDdIWG9POTdKMCtoWE1nZmhSMUROaUxYWXVSOUh2cElITnVNeHg1MjNN?=
 =?utf-8?B?Q09jN2IxZjBVSjdMaCtPZ1Z3TmNDRmJPUlhlbkdlazBEb0VnTS9ZZDhOOG02?=
 =?utf-8?B?OGo2dUlLcGxPMWZPQldaZjgrbjl3NWF4YjJQZXN2dHd5Z0VTWWg3M3RYSDNM?=
 =?utf-8?B?NnVvOHdTWWdxd2lYMFlEaVpHSHlLelA0Y0tzcEQ3eUVSZ0xybllwMzFzL2RD?=
 =?utf-8?B?UDFCRVl1VXliQ0lVN2M5RGUySmk4c3FxUkJ1cmFjQ1M3RFQvMGdmNzdBQ3JV?=
 =?utf-8?B?WUVsdnNHbUNaWHN5Q3AxeGFmRFBzRFR6Q2hmVFBhL3RMbXBJQXFEbnFlaE1H?=
 =?utf-8?B?V21FbjZJRCtDMTZmRTB2dW1WZTZOSTdFRHFoekcrVitYM1VOSzhLc25LUi9z?=
 =?utf-8?B?ajZUNVY2OFRkWHBHT3dOMG9LTzhHbVFRSGdLZ0M4T0Z3YzRlZ3gvWkhhcmp3?=
 =?utf-8?B?dU13RzhmYmpxQkpGeDdCN2dtcmExTjJlRXM1MEVCZExZSU1DTE1GOFpYTEJj?=
 =?utf-8?B?SFR5Zmdqa25Lb25IYzFCTWdaRGg1VWtsVkVpT0ZuNnU5QSs0bWRaOUUzdDN3?=
 =?utf-8?B?aFUra1VUcHo1VnRFc3pyMjdiV2dBQ00rcVAyWnJaVzBGU1YwTktENTNtN1pV?=
 =?utf-8?B?dGcwS3RicEhoUzJxQy9JWVBqbnhpYzk3cGdUbEhHN3ZDc0c2K3FOSFFaZ1Iw?=
 =?utf-8?B?Zm11WTF2UE1RRVhkekgvNUYyNmVTTVlTRE1MTWUyNVdLUjc1WDRVS0FsUk50?=
 =?utf-8?B?Tk5GTHpVNlg2NHU4RjRHTXF3NnVsUjJCZDRuK1AwSFlYakU3Z1hLbnh6MTlL?=
 =?utf-8?B?aDRRTlU5TVhzdWRNMkJLaW1wSEF6L2tSNVpUenNJSnBmQ2JZV0RYZEo2ZlNt?=
 =?utf-8?B?TXl0ZGpDTDlxWU9rMDJKeUNDalo5bmxrbUpwcU1xbGUxVVZKbEZkWFhZMWR2?=
 =?utf-8?B?OTE3YWtlZWF6TnlIbUhtR2RPeThQVlM4TGF5b1R4MHN2T3dxTURZYnd6VENY?=
 =?utf-8?B?UWZZQjhjME9oWEJTTkM3dzNjSTViR3ZXdkwzeWxKWS94Nm4rUVpNNjFqOWRp?=
 =?utf-8?B?MzNhc2J4WDd3UWdpS2MvQlNMUUlVNWpvTWVpT1hCOVB3WkZSSVpSeEhjUTBV?=
 =?utf-8?B?Y1dLL2d5cGtueTZEa3A2ejg5aWx6Z3NtVXlGTml3bUhsSjRkdUFMYVFtcGd5?=
 =?utf-8?B?TnpoR0VONjZEVENkdjNOcG0wc3I5ZWFqZldGVkV6MUF2cUFDLzBDYWFGTDVF?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F5839D3B2441340B03E3B1A0F8F2D41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ktx9Tk++3uNub0oqgeCRr5czwRa5BBEi+Ccam2hm7akdDMYo8CtGfTIpaszDTxabtVSS/hpQlUVYJ84CSc3ZlzG0AuwrIEnrOvwJDe706kOfF5sWGelkeX5p8zeEIX2rTFCj8dt4QWqf5RPUWNh52Bi7rEK3YlJlPEddmiHJC1MiQ3yFKwH1GrzIvP6iSum50rThU9sW4WmM0r0E9Y25EX3vinCDSFs2JLLRNPPQ0YIWUjVgxgbtpGKQP26k2TJ3TXnHTv5/YxbFPKCa+w3dEvdqWz2DLkbysi5TuRZ9gv6YCuQUN/aU35WkGcqOhwyfMkaI+g50lLMrY93hbVn3z7Ok7IXs9HEtLp8ruZZZVM+YrfboBWxEO8lqSIozhKpA+MHSnIyqjGZGmMM9dpJjHAZem2MeuuUB8OsfIBJXc5fxV0D3JvWzb6GQNLADonNfQ8duFPhnFpBiD7klvYcwnxwlgCN4wwfvYv1vHzvSpA1Bybpnj7bXgSXcM0Xgu7SDg0FPX0rHwtuuZIFx9n9WnR+ihCdTU2wJUzxomqHBEzA7H6xT6DWifpa8oH05rIpssyAofFZou+w2lmJeZECocNYtTc41RaRwEWlZ+BmmNGIb8a9UCDfcIbQJhjB7H33WSp+/oYvjqul2EYn95EQ+Dw7eNOx27gVinKP1+578McXPR8BChTGylfCYFwrt6LLsmNpygg+7rspf+VH/hPriW3x4YhLOrs7i6SYeH0bfC5KG0YSe4jHUfftZxFB3IisREEUXepUU6kV/3Dq22Q1QhgIXA63X/cfVflltaeTkayA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e1ed4b-1a48-409c-4f4d-08dba247e7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 13:09:52.0259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZoFqC4MgNmzuEQr1ppHEACtPFIvgLuhFvEZJTLqIxPjreAVbKX3QoOyAEiLGsOBVaYB6EvHNDc0iLEPOJCtAoC+THXddpYa4JeoGCqgmgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8954
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
