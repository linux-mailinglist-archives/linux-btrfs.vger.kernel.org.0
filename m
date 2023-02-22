Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19769F3A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 12:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjBVLum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 06:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBVLu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 06:50:26 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1C311F8
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677066625; x=1708602625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=flsTPndWRi+TD55ydKTVBbrwZpWmjp3FMBsdj0ecw0iBuPG9EtBUqre7
   tO6tCrh5h2en2T4YFZbjjlsjwTZ0QYz40mXJyK2iCU9eXEUA2arh+NBAb
   zpCNuqY+88kGNbap7kRs93eLEoGduM8myMhBOMssbkME2PD+ysjDHnJjE
   TOrtowaXXbrsWBMaY/o+PFS4BauWE8Bm/r2ucWoar28+7f+Ug0Gy8QN0j
   lTZ9MQK0gOGiKV2YmjFDhVYL+2T7zSQchpP0pSnpdguY/BybqFiuIZ73L
   PIzujCVisy1Sd2e1Wv4HOcOelo7oaMEVf5AMeeTgOd1Vnei8AVFcVgU0S
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669046400"; 
   d="scan'208";a="335874811"
Received: from mail-sn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 19:50:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5xMxcO+gbiKgUrExJ/26ajwwsLCBeCAsbazcehsV+FKYucVbPwgdPNB1dbSkEzQtqTbjm7faqKfR/vdexJsMZtCSWapBYkN4ZetJaE3+6bWYZm2ldtVVlOrujVoSs2gJGefr3ESq/2Mnykv0NA0C0/h9f6vpE7Ohh9I2AUNCl6N1RRU7YR4KXAxw4IUyIHv0lrv1bEinS09AJGwnPcApQrKzqYzAHyLrcjsUCA/y+BeJdZ3Gx9bmNWF1XwsjR6qC8HsIKsJ4NgCb8egIKKvTzZzraHBTnTkpu2Wfyy9WVNfJdA5MWmPtWSFgKH7c7jnzvIgIeHfbcg2RydSuA0zVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Cxr5r3RHHeyNtl3Clf3tECSn9VScSBV+YVcZOob788vqjjVthRHeJ72avdYdHGqN28PSi4umOW3TaBRTC6VQjFYTrsvLWDh45st8jpCXP5CSbUqvHYQutM4UOY+mTJdvGHt4dcd6DjMEbHtwY83YYOxs3gYoT9IMB7EcNJRPZFRxwx28XxoatGcv6pMnoW4+01XLTOt0ipDA90IIjFKcXiMyoyofzfs19tM17BO1RjmbepSbGgh99fTC50EbU0jOQsMHGiIC85vuN8u3609FQUVK/zYkosGv7+JuCTBEmUFiyvLC+gq2MQLPFPt/wT/1kWVL/13cemP+uTmRO8LoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jBTrkD/uyA2HkDt97VL3bA+y08SHQ+1izhZPjhu6L6ep+Oq8kl0gVzwVPHMxxPjwtGlpDqForkhr0l5H3QVkrDJTxovqoihURaV2xmvIbmxWrQN40Au2cJqVnKYloy1My19vY7RwW35x7rRUbbSiaa7SgfnpULBa15ovCPmHgU0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6999.namprd04.prod.outlook.com (2603:10b6:610:91::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 11:50:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 11:50:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove search_file_offset_in_bio
Thread-Topic: [PATCH 1/2] btrfs: remove search_file_offset_in_bio
Thread-Index: AQHZRjcUfAWeoRHCf0eTS8k7EDsSz67a20CA
Date:   Wed, 22 Feb 2023 11:50:21 +0000
Message-ID: <210f75bb-ce42-2858-7712-991ee325385a@wdc.com>
References: <20230221205659.530284-1-hch@lst.de>
 <20230221205659.530284-2-hch@lst.de>
In-Reply-To: <20230221205659.530284-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6999:EE_
x-ms-office365-filtering-correlation-id: a027825a-e355-4510-3497-08db14cafa56
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Glu36kAzNacqy78WGFeVNxHL5IwpYwiAIeM02ls9TmW2tfbgh1D2ztTRBeGjI7UNyNWpTYMWsWrujY/w9sek5xx+kpSFF/bp5+W/WKHyF25Htez36QMcp4mWjj+5rgjJpcucP8qHLgSU4stX88QhOw9PjczlX/BYXEubmB1H5lwPh3H+Zbm0bg4GIXTxy6WK6Zfh39/SytfjEDtDt6vs9KZ0aGLOmAbllYVr4n+9pL6ANQzpr0vSKmuJQZVcgsqAk9nAkjiw4u6Tz/71Us1e8ph8/jxWqnjv+f9Ao0XHMlFKMNTDdaRWp7f9qvvQJmT3Y0AbPwIg2gLwL9Nlx2GUr4KQEjxrDRShO//pMT7igrpU6ojM/t8kZDBLc0hAbHxNWvOH+rj+d2mz1X/VI7Y1wAxRbudobJeXoe/CUfN55trzwCedUsywqOxru+LRanOLnRWUfv1Q9UJapujp8lUp88esiqRTaxMlhJIUvXiEitqH+qlSNQaeeEjjJCVCDGmcbQRughjV8TfmuxvzxnDyStUwckBs1ISmvyyNzhkhT7gNwL+Gb98+hlT8tJ56t/JmMJ46Rs1rGdaxmv/BvzW1zWe5kYjkljk1GyZ6TsIfncu8CSA2oA7Skp1mZFd3Xvjv+fmL+PZ5Goj8sGa7wgmHsU5z0uyUiTkTP7TrovYg/FikmWsVEkYQJUh6kr8yU9Z7aJGORv74hAbKuhZYsL5KVOIA6tpNagz/iTNzJZxFtwlfFvLGZ3IHKoq/eMBrNrmeldU8zXiwE2M/OIw8Kp9yow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(5660300002)(8936002)(41300700001)(38070700005)(558084003)(36756003)(31696002)(86362001)(2906002)(19618925003)(38100700002)(82960400001)(122000001)(2616005)(6486002)(478600001)(71200400001)(6512007)(186003)(26005)(6506007)(31686004)(66556008)(66946007)(66476007)(4270600006)(76116006)(66446008)(64756008)(91956017)(316002)(110136005)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEtzWXVvTnRsL0FoL1dlc1pRWHpWYnNZRTVhL2YxWStEakRzOXRUTjBMR0Z6?=
 =?utf-8?B?bVFPK3Y4RTdTRWdFRjJkNW9VcUpqbWRmYWJhUzAySFUya2Jac01mRU4ycVB4?=
 =?utf-8?B?KzlWRENtWk1RZkpReEY5MmpKWkxJZktCaDJBWHJqbmJmZzdhQnpEeTNJNnhi?=
 =?utf-8?B?QXlHS3JJOS9tWlZtZkNDemZMQjMvYjBHUHg0ZEo5K3dObUdScnc0ZkFEbmJG?=
 =?utf-8?B?cUNDMmxZTXp0VEN4dlhaeFdOM0oxelR4MTJFcUNBRUcwYzVCY0RPNWJsaHNn?=
 =?utf-8?B?OFM5OUtFNzNuMG4vRkdQbkpkNHRrRjRqUUt0OGNpVm1vbXdNa0JINUY1UUZR?=
 =?utf-8?B?emREcGowR1dYZ2k1SEVjbzFOQ0JENXhxUTVNUVR1U1VIK1djd20xZ0svSjlX?=
 =?utf-8?B?cEE4YXpwYnpXZEpya01wN3ZmWlhXaDdWVlJ5Mi84YVdiam9mdWZQUWdQMytY?=
 =?utf-8?B?VUxmdmVGY3MrNWlXa2lXcm02TWVWV0tCQjRyc2x4NWE4cEpjYzVtaThteWp1?=
 =?utf-8?B?STJUTHp3T3RJbHFNdEVJYTBScE93dWJSd3lEY0tUVE1xTjVTS0JWMytHbmhE?=
 =?utf-8?B?N3lQUjkrRUJlNDdGaGYwUW1qRGNoQXYyOGlldnJpSWJqOEJ0QVBLOWkwRkRV?=
 =?utf-8?B?L2hkTFRkNXNNNFlKdkpIcytMZlFLcHVCbXhBZEZzbE5UTnk3dlpZc0sxalNn?=
 =?utf-8?B?Y0Q4WW8rdXBZTmFoS2oyM3JuS0NvNFJPU1NWR3ltOExjZVZLNStxck1lODR3?=
 =?utf-8?B?UUV4bkt5d3FXQXhrbmYyTXQ2T0NFYVlGRzBoK01WbmFsNWpQZkh0QXI0elJP?=
 =?utf-8?B?K2JrVXBXeFpKeHIyV0s1WHErd0MxSDJuNGV6NkV5SXA5REhVOWNZYk84dmUv?=
 =?utf-8?B?Wk9sbkNEdTd5Nkd6ZXp6TXY4bUh1cVgybGQrMEhSYlNEK0lIbGpnUWkvdG03?=
 =?utf-8?B?RUZzaVVmSmdlUEhSckJhTEdHallCdXpGUWM2SUJpSWQ0dEg4eVJkWUFCdUor?=
 =?utf-8?B?dDU0aFRpNE9yK0tGVnZ2NE9hVTN6c2ZKMXRQTjYvbUs1MG9rMWpVZ2t6TDBW?=
 =?utf-8?B?YnFqSmFPYWkySFVmdmpVa0xwNWpKM2grc0ttMUxpeTdSSlNPeXJUc1R3NlFQ?=
 =?utf-8?B?THpPRlVXUUZ0R2liUU1BaGV6RmRjZFA4YnVacWp3Nzl1cVZraDcrM2JXT044?=
 =?utf-8?B?NE4va3pKbXRJc2h5a2ZWU0hDY29ib2xLRi92Q0duYzJUbmRhT1lMdkFRaUE4?=
 =?utf-8?B?M3pMUVVFNUt1WFFtMncwYkhLQnFPNFpvcGFZbFZUeitCZ2RLOXdNYjNKbHNm?=
 =?utf-8?B?WmN5ZGVXVnVpMHpyN200djFQM0dmelhLRlV1SllmcGdWVWlIUWpCM2lGTEtu?=
 =?utf-8?B?RXVmZXZtWmUwSVlDdDJ1SEdGU2ZBV3MzNDI0ayt0aCsvNFhuemNaT1dlT3Z5?=
 =?utf-8?B?bXZUUC9oTGdlYlN3RWVyMnhyMmRSQlhTTmpyOGs5bUg5S3Vud1ZIeXp1NHlI?=
 =?utf-8?B?ZTdKOHlTYkZCU0daMGJLN3NxM1lTN1I0TFIzR1ZiSUMwc0VCekNHS1JLRXVV?=
 =?utf-8?B?d1AvUG4wYjdlTHB0QUFLT093N29FZ2Y5N0xmMlUyZXNUMFc3N2xGQ1VOZ1Vz?=
 =?utf-8?B?TU9xK3JGeVJFVm9jaStFKzhRRURPMCt5cUloc212WFlwVEcrMnE2c201RmFR?=
 =?utf-8?B?dkZwK0RnNjByVmthWVRFOWdJcDB2K1gyZUVyRDArNHRwK2svZjlNa2RMYi9U?=
 =?utf-8?B?ZjZWcW01c2o4bTJPd2IvSm0vbHhLMmRPdGU5azZLa0JJWnpIVmdwRFhFdGxW?=
 =?utf-8?B?RDVydUlSeXd4K3Avb0NJY2VPbFMycWFkQTlQbU9zYTBvZU03dDFyNk82QU5u?=
 =?utf-8?B?dHZYdjRuZFM3NkJYQ2tJdlI2aU1rT2NvOXpySDBLQzZ5UkRjM2JvajJuRm95?=
 =?utf-8?B?aU1ZUjNoNFVwSnBsdklndHBlUkhJQ0dXclBNcGM4aWp0THhWYkViSmFrMzRs?=
 =?utf-8?B?dUo4UzZhdzJqK05WN3Y4OFVFemFsUVlwVDl4WVB5b3pRc29UUXdNc3l2cVMy?=
 =?utf-8?B?cXJFTUhGU2FLUTlIbnFobnZPa24xS1N4TzQ2UlNCVTdDaFFtR1NWV25BRVp6?=
 =?utf-8?B?cjNwMzhQaXFPVkZOV1dHUjY5bSttWlpHSWpZc3dpQjZFV1p4bzZXMkNwb0ZK?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA93957DEE73B440BF82FCADDF4CBF81@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YxA0Q6IROyg8S6ixTj6j0ejO1y+QyqsdZttPkcSUo1NcUERUt+ZDY1B2KPx3ctTA0PUo5mm/T6zTJxvFysg7pfYt33u4ELUsoGH2JVfpvAEcvjR6Fs2pSdpz6S5nXGxHIL6PzKE7/IWQrmV9deIEGUElKwGidVIoXbP0T/Ozwt3Aeo9TY9OPKVfCrIEnlQtUPhZHKhR8CGotDZlvp5l7Ndxrs+ofVBDDzReFHdXytZ8s+4rufVTT7G1W93foq2hXuTXfwN/VndAU3ryFADqf4PwTIo/tyZ5OS07cgccKmxk+3IWmfw3JNxk45G4UIxEsWSmn1VxulsoVDGgOLukyq74vNi7eA/9EZ8RNaPGs1jjojrTzi0YPL35xj469TPErYIaYe9tANYh0/8eHLAT7M40IFPxQ4tFwwI3n3OYsHjEjcmnYzvPMRtL8R75uhweaN9v1Y+kEykVA6GDsJqNFpsGRlLKYNAa1ZZ3qccr5e/lYqJu/OMYnn30WbTf344x0BK84O1eF1dWhxKiERQ9Y43//05itgwvN5ohVBvUc/iudXni34KghgFVTHhAKMdXaWhvrtUu+AWRVb1xAIzITrYLyX2pof9ixfYGmtc2gRCC2YiYjPXzPDC2wszlh9fhcS7T+1uAXHWX41IfzfQHYFreh0SIbYgaFtCalBVRYGrbcKNf0TWRkxA5x/GinS60wTDBbH7asPwmE2pfcty0uFa82nQKm9MW7y5R5k2w5A/TQi0wDdwbGtjElLVLdLYVf6/vSf2z6WzGmHoDElZr61emjOylEeF0zcMWdo4s64e0wobFXFtkf42fq341eL3Rz3ItANNn9ODn2w37XpZAsKuL96/zlLmRGgazCfVo0bzCrH/NYxb+dPDjytjl5SaET
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a027825a-e355-4510-3497-08db14cafa56
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 11:50:21.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBtyjpneP0QprlvoU8Oi5g10ipHakxF6AGfDMz0B+UbItCa+PDESbyimw2AOWn9s8Q+qAP3Ndww8j4bsRQjp/CPBgJ7Ajka/We17PMpNYDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6999
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
