Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E19869F3CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 12:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBVL50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 06:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjBVL5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 06:57:25 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9337B4E
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677067040; x=1708603040;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tEQ6vjBDVaned3v7agz8fbcihlVGX4DyyBjMlckND4c=;
  b=VUHgWERwrgMUJyz5UIkk2LDSCXE6G98QfcZStJdStTyV/EGBll7FoKwW
   77Lp6U/I9mR1tmFzh2kzjJVVZdQyBQS2LOSLlUfY0X9z5lTrwSDK59IKL
   b4FORydpcQWDPbsfq9Q8uzSQzRyqfGRORJjEQKqt+ri5/4uvVxHdEvONf
   kI+dSuUNav8qRQCw1tX69XzjuV7VHcj0N5QH34GcFXNrUs3Wy+l12Goxr
   8E9LQGgXqLm0Xa46lsclZWXrCCl+qvdjIAKjC5om3RN/aKxY0Am50VVMd
   K+RiH/yBVoX3LmS+ES8GfFmmysFX2MSsmlGOZvk2jfe9hMlFNuFSqc10J
   g==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669046400"; 
   d="scan'208";a="222189418"
Received: from mail-dm6nam04lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 19:57:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9uBImXywTrftq/YPaCZ61SG8H97FQTre34dVe2V35/WNs9UiCOuiPzCpErnc8PwpOy8GbvOda6GOm9mqMb1SPA3h+4I8hLhAwktlOh0FFWtZmVp+iQmQAns2A5dwsyk3cEpWuJC2oAqebqU+kdPRTTA0sRacY2RRQU36Eb6Pi3DRi7JtoI2ji7tapNUdgInBfG/ml3TvpByTT6wLYWxXUD9XpqwXZx4CYQPIB9a7VHEVJdyjiVxkoYxYdnV7Awbm1kS0DcxCwOZfOFJa4wlT6R1zow4rAkVPyPftVgIY9wxFk+Fvol6gTIHzXwogoJp+bkJoRmOaTEVASwpw/IPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEQ6vjBDVaned3v7agz8fbcihlVGX4DyyBjMlckND4c=;
 b=gQq53HbP7QG8k8dNuVNOj6AQOjeBqjL4FmS1Jhd5ldnWoYAdOfQE2+ESfkR3mT/MxxGpWO6CaQ5aoVSP7NeWJ9r23KqGBCvr1KZTT3TkwTOcvGRSw9a+ShODSDA/wXLvStUDI3GhvgwMIZcGCOVZ6xBlmy09TdATHIZiJaZ2c+Kvz1nq5Ckoghv2Ileobr1UhBNmaWsxF6wsW3XWkab5JSYpZ73e68WWkA8h4tfWDT9pwr43OSJslU8Xe1IPqcpU6jZ1O5x9s8+WisWlc0pmHPuuuGn+D0D1mzsTnPo9khQ00FZITbKJOSHSF8KyobRYULnTEB3/VEOO2QyvLteGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEQ6vjBDVaned3v7agz8fbcihlVGX4DyyBjMlckND4c=;
 b=elhywGscK/aQ5nvVE2O0jebct5u7icNHgjPG0I8mx6Q2I71q70do2/Ui8nmlScc3iYi+9nA8offhsI8g9HybPaDVK04Z++xrYCPkySE5oNIASL251w3rzCzQUJXOguVGvPXKjqnuC5RRtECywVotSsFkdx0SUDRo6BnGoSBLsfY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0368.namprd04.prod.outlook.com (2603:10b6:300:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 11:57:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 11:57:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Thread-Topic: [PATCH 2/2] btrfs: cleanup btrfs_lookup_bio_sums
Thread-Index: AQHZRjcSlWik/dsZtEybEE2RV8drz67Z4aWAgAD7hIA=
Date:   Wed, 22 Feb 2023 11:57:12 +0000
Message-ID: <06bc019e-96d2-b372-3db2-34fe45226ee8@wdc.com>
References: <20230221205659.530284-1-hch@lst.de>
 <20230221205659.530284-3-hch@lst.de>
In-Reply-To: <20230221205659.530284-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0368:EE_
x-ms-office365-filtering-correlation-id: c588b0c5-ba92-481d-78ad-08db14cbef50
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yn+wzNd/UmaquN7YQ+nnRzxUxVQ1s/KBkuCsbtuAfhDkzCwNyZsgxR4MZGTG1cb2zyJyNs4cOe3iExuUUc0pt4yiMeON+chpJgsM2m+qApJLZ36yCjAchNqjomviAFU0cLcg19CunQBmTK2qgFYbOd893iK0Rbp2oN+fwNbpAlE6LwDX/d82Z8lh7Ko1TLInz13YnbxThqYG7hVPI7YRyT10Io/oOIKhZ9PhE3/4BSALyNKY7BTkIs8vKJGObnd5gUkb55Uu+CW4wvCfLS3GGurhlI3QdgpqnbH83TlH9+u5jcnaqnbV9TMPNubYokOAzF3a3QD28TivzPWGJHvEwoawtJ59BYo92jqGxtOtMRqkzoI6BFgbFMdzOY+jntFTHDgZAnoxgBl9cm0EbD+KKsCxNRtjiCQEzN9C8ikCVt3rqdZFO6ij8RwZM21eujbfQswq/MKOw5dI4x+wCIUCpccjsgSFPtlerge6y6kR/buVuOUNW4N5Edvglhi3DPOqvgWBg6mqCVyut/okreOA5SDNiTb9pBNMtgJJzXwWXmLuRz0MwW1u3icMQamvlwRNf/PbnTbMoUJ8RRRqC4EUoO/XGcduq0EUfcyiwIRM/GFncR+M3VQYmBHQ0S4hb9LIzJtW/eGiW17xFrHmwkdrhQ3k+KjMA426ePHAfp2/xg6HscDMEbRFJKNH9wD7O+O0RGbKbTPYHVDs1Jt+fB5NRrAlwM24AtSWn6p+T1KrbTFukkMBHe4F8GG94IY/N+uJVJ9Q+DzVmlrWtmtPYe8e7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(31686004)(36756003)(8936002)(41300700001)(316002)(8676002)(2616005)(5660300002)(64756008)(66446008)(186003)(6512007)(66476007)(4326008)(26005)(31696002)(86362001)(66556008)(2906002)(6486002)(76116006)(66946007)(53546011)(110136005)(6506007)(478600001)(71200400001)(122000001)(91956017)(82960400001)(4744005)(38100700002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUh2K0IvZ1RaY3JRdGVDb1dKck9oOHlhS0E0SzByb0dLMy8xeUJIaHM1Wkw1?=
 =?utf-8?B?R0hRV2RFMWhHb1UyRCtqMkg3NGRKWFY3Qk9QZG9zVm4wUDJMSGZlMmJMUEtE?=
 =?utf-8?B?TGRyb2dTV3hvVzYzbkc0dE00UThEeEU4Qm9SRDNUaWo1NTdscCs0R1ZsWVIv?=
 =?utf-8?B?YlBNaGpjMTJVWGd2YTJqb2Q0UjZndUZkVERHZEU0eDFpTy80Yy9QTTRDK29J?=
 =?utf-8?B?VlJjYlU5TFhyQXA0Sm1PTng0emhTNzRlVmlxUHBnTmpZcGVNWjBGSjBzVjFo?=
 =?utf-8?B?N0syV1lJNkhUaS9GY1BHbmluNXJzYUJZV3RmSnNyZ2hZT1JUMkdNK21odXVF?=
 =?utf-8?B?aDB0RkxWNjdEczFYeXdzbkttOXV0T1dBdUtqV0ZjWHhGUFZmY2xnSCtzUzgw?=
 =?utf-8?B?QWhqWnlZdm0rQmxjMXZUWnZkTmVDM1FQSjRPd0k3UVduZ1BXRDdWNkdQSXlK?=
 =?utf-8?B?T0trblFDeUd5K2xKalZGY0l4ZDdhTnFlZ243V3VUc0x2NFRobjExcEhyUmwv?=
 =?utf-8?B?TUw3RHQrUFZYTXBzZUQ1YmlGZjZhL3JDcGs2Q0lnQXU0NHdOQ042bER6akRL?=
 =?utf-8?B?bkNBZ1dvYStVWW11WXNQVU5RREpzVWpXVFZ4SXZ0WkQxOFhENHNaT0w0Qk9l?=
 =?utf-8?B?S1RFRXpEbVRnUER4MHYrTWRyQk83clJ0RHhSeWtlM2xIWDFCVDNYT1dzRCtk?=
 =?utf-8?B?dnlkZDV3QTB3MjlkVktpNWM3eDcyNGtnbXdiRzVscGhyc1VFbjFXK2VTSkty?=
 =?utf-8?B?cDlxUjRXOURFblBDQmlUamNsV3dOV0M0UWhmQ0ViVHp3eG1PTEsyaVNUbTFy?=
 =?utf-8?B?ZC9mR3ZqSVFBSjZ4V3RHQ1oxby85V1NNL1g5a3pBMkZJRmI0SUhFdmZmYVFo?=
 =?utf-8?B?aGkrOGFXY0VZM0pxVmx0b2dEVnhSSnpEQUlOdkc4U3ZTamRHeXI0b3ZjUzdM?=
 =?utf-8?B?TzJ4ZTdMbENuMENKcEJFSU5DRnkyZXBsQ25zVDNSdm56OW0xREM0ZDdHcjB1?=
 =?utf-8?B?eFJ2WmNWQkFBbXhMSFJHQ0pYQ1g2OFJZQTRSSkhsM0lOelFWRVpiQnFFL0tR?=
 =?utf-8?B?V0VzZjV4N3BUQk4rbTREblRncGtBdU1NdTZaOS96KytVWGttUGNsVnVsd2F6?=
 =?utf-8?B?OE9rcjk0enlVMFkrS3dOQUZvZ01TY09MSy9ZL0lqZEhJSXFwV05yanV6aHRt?=
 =?utf-8?B?QmhrRWRsOERaRmVJU1kxdzNlYVBPR0NKeFJXdlc2d1oxWGdQZkI1TjdpcnNZ?=
 =?utf-8?B?NVFmQ2FWeXNIeDZRTHdoMllNb2JtcEJUTzBwQUNlbDdaanZQUHpSS1AxMDVq?=
 =?utf-8?B?czRuMUVXUlI2TUhjdjl2MGNCcm9RUjZncEhTdVNaNW4zSGhSS0s3WitQdlh1?=
 =?utf-8?B?b1JqNmd5dXVnWkNzYktZOFVpZlk3ays2WlFMZFVad242U3UvMlVQemw4Z2Fv?=
 =?utf-8?B?UXhHRW5MblNBblNSRDVuWHBUNmRMOHhCTFM2ZElMQ09qN01oc0ZselMzSTNG?=
 =?utf-8?B?c1FjUTA2YzEvTENXWC9lV3JUbWJYb2VTbExxZHh4bW4wRmNqRnVyR0o2TnJU?=
 =?utf-8?B?aUkwK05jdjU4bUIzbVdGYmsrUE9KSDFXN1U2bjlWTXlPT3phQ21JZHl4TFhN?=
 =?utf-8?B?OE9nK1pnN3F2RHBjMUVYTTJXNlA1N0toSk5MZEZOTGl4NVh2QXgyNFlORlRB?=
 =?utf-8?B?SEEwWFAxZm50TGE5Skt3N3NGQ1puU1ZuSyt3KzJIUDlqc244OUcxK2twMWJt?=
 =?utf-8?B?a0xmMXRtcXlzWURUeEZLQVNkd3pOclZEYi9rRTA4ejhJcVoza1pVa1grNG01?=
 =?utf-8?B?TlB5ZEx4T1lOblY1dDF1TzlLZ1B0OE1MNGE1MkZybzQ1U1BJWTd6SnBjejJL?=
 =?utf-8?B?N20ranhSeHdiQmMrUkFyVEtBa1FDYkROckM2QURLV0I0cHI3YlRXR1B0VElS?=
 =?utf-8?B?QmxIbmpMNUZhZVdkVkFqTllOVG45UHRHVzljSFAwc1ZMY1VIZTdVRjBIM3Jx?=
 =?utf-8?B?Ly95VW83QTVrOUQ1V2RsdWpMWVh2aTAzb0dCdDhVc2ZLb0RlVitkUGdaRWpy?=
 =?utf-8?B?RjFCL3l0QkxkZm1XTlBmUnF6OXlCYmFoZWI0SnJ1UWhCekU4RFYzRFJsb0ds?=
 =?utf-8?B?WmJIUlhiOWQzTkd4YnJVNndpQkVPU3dxV1g1Y3MwQW9NUjFDZXNrdk5KNUpl?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F9F9F863AABB42894F2DEED6BAF422@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GqmbQGtLTTDCvwmvEAZ+4mxXhv5MKHgTzeN0P/WsIyBhps5T9dpTaarYdbvM94eevOliRfhD2OoHBjOQGJxlVmWNZpmgb1PlHT1YEviTUQHwNaWXgFGJquI/wsLDeHF07kmfNsfzgyfOfXtj0igatB9J9y8Yq68D/hy4gbhi0iFjA2rtOHj9jI9Omb9qG1oAV2mLpt5JlWtUHwm1o0UIaWyu0AieuHIK/9P4yjF8jtVFibk2c1SF/3V+pWevcDachecRhs4VdhlKgroq6L1aoSBY6lPz5xs/SN3HdnJV/X1SkZdL0WdfGFQrZWhgYBwT1ylqVGUQ8habl+2IHsn6s8JNPukasL/c9FEn5GRjiufSuKmwp0UhsEAibbdvMgugYNvpBqPcQnwU/aZn7a3MX+am0pBeFilsp3LBG0yQYt4BcpiWh1kO3PfsAQPQIlgUF2LSGxsn0xrD1jAutwxmUCq4e6wL2kha8rKBlpCEJynSSQ+y2KrPxDYthACYzF0QIrpPN6P+Q0IIrFB0BmJT5ofN1y7zgYLM0FTratqAdvDR2ImV0rC2I3Nc67y+6LnSdDiaVrAfDhtrp7aKUfFj/caBKS2lhu+sm4wIRHJQBR2TsDMr8bs1gAoLPFs1BAPmMzJjmScbv+77jOXiAlgCSTc7CRq7UyetaBdu5Q6f/Ojk+n2Yf2PuaZrddmWWVgm8+betryh9AN4gEpi5C2mU2XOQQG4Imax9c7eOZ+vWbhNnT2MjnXdxD5T0LsHCn422HaG+2XG0jyB3DwsCPPeaCVS7C0L9ahbnrLNwpiHgK7RqGUmgRqTH7MsgQUg3momL2M+uYrt2/msNe7SquEanSk51KmCov8zxaSIHIjpC2zKZwbtWlIaX7vpKz9+R2/RS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c588b0c5-ba92-481d-78ad-08db14cbef50
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 11:57:12.8845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IEURAcFdBTWhg8bZYNXgUCMJcJold09F0Rd1/znPnGe3MottfoRHb4/zzk7V+52VKCo1Hv6GCtdtDRfC4gQvMU2Smf5J0Lcpg+ZvguQnp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0368
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjEuMDIuMjMgMjE6NTcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCXdoaWxlIChi
aW9fb2Zmc2V0IDwgb3JpZ19sZW4pIHsNCj4gKwkJdTY0IGN1cl9kaXNrX2J5dGVuciA9IG9yaWdf
ZGlza19ieXRlbnIgKyBiaW9fb2Zmc2V0Ow0KPiArCQl1NjQgc2VhcmNoX2xlbiA9IG9yaWdfbGVu
IC0gYmlvX29mZnNldDsNCj4gKwkJdTggKmNzdW1fZHN0ID0gYmJpby0+Y3N1bSArDQo+ICsJCQko
YmlvX29mZnNldCA+PiBmc19pbmZvLT5zZWN0b3JzaXplX2JpdHMpICogY3N1bV9zaXplOw0KPiAr
CQl1MzIgY291bnQgPSAwOw0KPiAgDQo+ICAJCWNvdW50ID0gc2VhcmNoX2NzdW1fdHJlZShmc19p
bmZvLCBwYXRoLCBjdXJfZGlza19ieXRlbnIsDQo+ICAJCQkJCSBzZWFyY2hfbGVuLCBjc3VtX2Rz
dCk7DQoNClRoYXQgd29udCB3b3JrLCBhcyBhKSBzZWFyY2hfY3N1bV90cmVlKCkgcmV0dXJucyBh
biAnaW50JyBhbmQgYikNCmNvdW50IGlzIGNoZWNrZWQgdG8gYmUgPCAwIChha2EgZXJyb3IpIHRo
ZSBsaW5lIGJlbG93IHRoaXMgZGlmZjoNCg0KDQogICAgICAgICAgICAgICAgY291bnQgPSBzZWFy
Y2hfY3N1bV90cmVlKGZzX2luZm8sIHBhdGgsIGN1cl9kaXNrX2J5dGVuciwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VhcmNoX2xlbiwgY3N1bV9kc3Qp
OyAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICBpZiAoY291bnQgPCAwKSB7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IGVycm5vX3RvX2Jsa19zdGF0dXMoY291bnQpOyAgICAgICAgICAgICAg
ICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChiYmlvLT5jc3VtICE9IGJiaW8t
PmNzdW1faW5saW5lKSAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAga2ZyZWUoYmJpby0+Y3N1bSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
CiAgICAgICAgICAgICAgICAgICAgICAgIGJiaW8tPmNzdW0gPSBOVUxMOyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAg
ICAgICAgICB9ICAgICAgICAgICANCg0KDQpTbyBjb3VudCBoYXMgdG8gc3RheSAnaW50Jy4NCg0K
VGhhbmtzLA0KCUpvaGFubmVzDQo=
