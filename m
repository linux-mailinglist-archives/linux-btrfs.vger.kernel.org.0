Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF176B4D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjHAMe4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHAMez (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:34:55 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332551FC7
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690893294; x=1722429294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=k9ki7KGnSj30aGmNFtI1sQLmW2wnXgq5cseEzbFc/8swidxpL9mMbwaK
   Vkt1RjIRFdDiowPU4NyOGww6dmOSj0LGiQmQ1w9qIJg0uA3/pbA4Ti76F
   hbjDkD1W9nuUMPpcuU14sJv28+K3g+6Rl6QdjS57QMGJsnd6X1c6W9o3r
   M+SHWakVCtwI1QEKL+Qfp/UJj14Q1tHAIzCle3Slq1TjAGFRzw/3kRkuX
   fAkZpGSBlzTTGPfQX+xyhum0cr6YiRgVl5e+PIVcCHJsQtXaIsifglgOI
   RO4WEcsPwiw7P9SGdK4wL1/+ezhHKPy8XRWbFMRls5gWbFg8oh4jwbU5k
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="238108367"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:34:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLm6juDUOlw3hLdKgCP291H6WxKgBwumL/v/Z1StAhTe0OAwGj7PRATidrLXICimsh6eSal73pGRZJ16HfNoxrehKror/4uk5C1Cw3X1sqGQlLXJ2J9ywYSWiyhj7avRPDTk9C7dnQc3c9lqFjw0P67U8d4zp2o36qrZktusgDCgzLYg4Y72WijPfEqkiGTLvREseoJzkxLTU0nX1WWydYtFxyqL/ZGvneWZJcZiv9KDbORbnJT9c8yAto2m4VjurT2uEfKuuxLF9twLLxAoUZZKQi22cVH12OMwF7Voo08d6TFjTZ/lYJ/qoH5p+wLz6s4LEUvkOugqPgHI1g4hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=AdjxnncwEnKmceQrd8fBQUrMLqy8s013r3hL82AeJv38SFvfoKEnKjz4NlAiGBLEE6I/W8W+ENRU0pSzOsXqvesIk+nkp7q7guJkPS56rtltIW2W8IlZ1My6toh3Bo2+OBDtred/JuEADY7OpnjX7c6t6pvhY7m83BjoPBzVAnL2xfgaV/PmF59BzEdYuGDvDAKhHbzR+2/3jdIMpEYQIPvvOQursWwoedVjgQa+tAd3+5YFBcSTEHnRWoYhLH6B58Xz4K6Q0Nj3DKC7XR4kZC0nl2IWWAnAcogA6LkUUMxSBOOhSEMq1DonY2/8Lq4uYc4XTvsqEJYz9ODUPmPmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=tT7ETcvghHPsTKDv16hMj+o0GnhPufoSckng0SPy29bp74J3UHEF7AKaZ9Yw+14NfL5+Fi+L+aod9U/KkL8xYwzbVDYs/p+r3CjcwcvLAbDLZIAmn8MpbU2c1G5m4IpOwBsS7NGl/bI1yIh+TsW5PTBHPFnap5YqAkn3vVViSWk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8173.namprd04.prod.outlook.com (2603:10b6:408:15c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 12:34:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:34:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 09/10] btrfs: zoned: don't activate non-DATA BG on
 allocation
Thread-Topic: [PATCH v2 09/10] btrfs: zoned: don't activate non-DATA BG on
 allocation
Thread-Index: AQHZw9NgNl/FjoCBREq7HBOtVxySr6/VYXkA
Date:   Tue, 1 Aug 2023 12:34:50 +0000
Message-ID: <86424b9a-f722-ad1c-d810-8c06a167a5da@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <65989fd4940f6c936237f491fbebe9311ff8d1f4.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <65989fd4940f6c936237f491fbebe9311ff8d1f4.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8173:EE_
x-ms-office365-filtering-correlation-id: ec3b1946-c1cb-49b8-f2ca-08db928bb34f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiNKopxyaFncqkd9z+NjA3tJFRndd4tqRbeA7LuLdkWTM12AdQdUZo/69+J3Wbgrnm59NHpwxBXnD+JPch0fmM1BC4K1DUc+ZOmgtfDsYpVO5pmmlwKi/w7aOotHY0qYUXLU0CJvNqvA+772SaLW/FUT9Px6JuH+5mBK8S5oPtsBbC/xAR8+jWHgXuOsGmrxs2czKALWPr3Fl674p8ZFsWJjjwP8+CRW05akEy4SDwEAWoV286tVzT/wSlwH7xCoctNRaez3tE2tSW/wDveWNg1j07+c+e+XJ0o6hmSI7hGfAKm3SwdhKurYIkE02c4Ku32fw/ZBYZ39s2s4dMQr4PR0M43JQ7oDyvYhsP76kIA9uVhtoW7ouP7d4HWfNiNaPTZZ4H85J77MC+iiIvFZ0dodJiyJAL8IXYduue6+jt+T7dD/av124ZzDdzPPmtkitEn7VqszkuPpv0LLNlOvz6KgEziY2iu46Pev19nCFumjHM4rlz4U/JjTy7kYcby1gDf96bQ34opzvcXtQcwAnHRtuv7BH+t/va4mRedjWudD7rkgfZ8rnebd71Gypg9Clt+Qpmj4CO9nsc3A5nOnlDbQMDZ2N7C4GfiL8PWM9VctUK368U5Dx6bWYBKVyTWGLO5kQAgkNypWoiDQOMGMSavS11AQFz4VLePZNDMRvgkE0EhGo02Op2IATsrCvqGf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(38070700005)(8936002)(8676002)(31686004)(36756003)(6486002)(41300700001)(478600001)(4270600006)(2616005)(2906002)(26005)(316002)(31696002)(186003)(19618925003)(86362001)(6506007)(558084003)(76116006)(5660300002)(38100700002)(122000001)(91956017)(6512007)(54906003)(4326008)(110136005)(82960400001)(66446008)(66556008)(66476007)(64756008)(71200400001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnorNnpyUHBKNGtZbFR2NnIwUVVUdHJqQTR4MWhBZi9wVWxjaEh3b09aNkZ2?=
 =?utf-8?B?MWFiYlBoTmwxRjBmUGJlWjh0ZmJPeG5yZTlrSFV3RnlFdEp6MHM3VEtBM3lt?=
 =?utf-8?B?dHZ3clVsMWxndExORzBCUTlqZXpJYUVwMXNwTFNFTkIvK1NkZmN6N1k0U2Nl?=
 =?utf-8?B?MGJsRDVHdDNMb2QxN2FNZGd6VllDcTV3bG16dHQrR0VYSmM1eXpQZ2pOVC96?=
 =?utf-8?B?am5VUkJWa09BWUdUZnZrMGttdCtSZitiOTMvSDhKTWp4bUVKbHR3ekVURUM4?=
 =?utf-8?B?QWVUejlwTE5DeWJRUGEwblU0Ti8xV1hUZ0Q1aEE3OE9XWXgzYk0yVlFaYzVm?=
 =?utf-8?B?aXNSWTV1dkNoNEk3c2JhZFRwVkxuUDllYVJFeUhtbmxEb20rLyticHRrdkha?=
 =?utf-8?B?NXUvNEpMMjFPV2ZERnNNYmFnVDlLL3FuOTBScmNuSEtheTZXbHdhaUNPOGpp?=
 =?utf-8?B?ZUEzQTdlMTArMUxEL3VvV2ZITEYyWG96SUxRL1k2aFYrSjAxeEJoWUVxUFdF?=
 =?utf-8?B?WnVTMHJXMUJ5cFNzYThQTHgwL2JuOGh2UGlnQ1RacUdEMzZHUkxsZEVvUGtz?=
 =?utf-8?B?TjBDV0ZPQmxRU0xSMXQ0eEdGSkIwYUhBWE91cVBPaG9ncWw5TlZLU1VvaHBi?=
 =?utf-8?B?YUYrdk1mSmdoS0drS2ZWTFJ4VGdjWCtzMGhaR3ZlQnkxREx6NE9UQkVqNElk?=
 =?utf-8?B?ZXBOcU9lVnpTL01VcVg2MjAxR1pCOWNKYVJzSHZ3VXdYdm9VVjFDL2Q5a0Ev?=
 =?utf-8?B?dTRlczA0MFRpalBMa21Gd3hEdWI0VDh6TlVQYjJYRVNFMEh2VFhPZFJ4Tk9m?=
 =?utf-8?B?bFAva2lkOEoxNG9mUlpUa2x5NjRSZFk5SEMwaDRPSHhwSVJ5RjdRUFFqVDVq?=
 =?utf-8?B?SDdIUlRJREVuN3VqcllhSkpXTVZyVTBVeDY5M0FTZ20wOEhyL05NN2UrQnhH?=
 =?utf-8?B?T1J3UElUSTlaSHFlY1pNMXdDWllXaGxlYk5TNjZLaEhUSUgrR1VjNWUwcnN2?=
 =?utf-8?B?MDFwWWdacHF6SUU3VDZtNUY0K05XQ0d4RzZETFJ4clAxQVZIb25Nb0pZU0F0?=
 =?utf-8?B?YjVDZGhqbk01QXFHczVkY2hiUStKMGE4c0VVLzlyakwvMi9IVnhlTEZXdEh5?=
 =?utf-8?B?Uk80M2RPd3pjSFhHbDBjdEV2cml0UmZ6Mk9WODkvby9adEptTzFlRUFtY3Ni?=
 =?utf-8?B?Y0lSb3kzSFkzdDJubE83Wi9taUF4OVdWNUNrdEJZWmFjOGJDb1lZMm14SGFB?=
 =?utf-8?B?d1VGVmlQRldzNWN6TC9veDY1bFRQd3V2WExLTno2MjdPV3lyMUFBTW5uOXFE?=
 =?utf-8?B?MzdQMXcwOWkzU0RuWFpzSFBrNS9mOE40MllyL3dGbE02Z01OVURXREkzK2Jj?=
 =?utf-8?B?MmxsUTAzejh2OHFRRUdzL1Z5NDNwSDBhUGovS2xEWGJDdm9MTmVHN3FnZkpv?=
 =?utf-8?B?Mi9lQitBYnZneXVqR0VWbmhtOGxCenl5djlMcWpKSXovUkRTc1BSY1pFeVI5?=
 =?utf-8?B?MlpSWWVqNFdvSjdJcDZOOFpzV1RxWGJodFNmN0E2NjhCT2RRaUpaSEFaMUZM?=
 =?utf-8?B?WHpIVWlWZTFUTVloRXBEbzFPenh5R3cwWFRpZUtUVmdrTDJzdktiT2xVVlU5?=
 =?utf-8?B?a0hBTFB1eVNDdzB1RTdMNFU2YW9sc3dTUSt2Q0Raa0FLOU8rZ0hKN1M5Nnla?=
 =?utf-8?B?L1RyRTNGYWQ1dkM4UlUvQzRuSWRXcStTaEFsWHhiOXkyZlVIcC9lMFZPTWFO?=
 =?utf-8?B?dWdHTVRZb0xaZE9jQ0xKTENVdlV4aVQ1KzNFa0lLeHliNGx3QmlqNzh1amI0?=
 =?utf-8?B?VXdOTTRUdUVLRU1pMndHR1dLZGtVa3lpbDIvTnUyNzZwUHM5RTk1eFdXUmxk?=
 =?utf-8?B?RDR4TVpuY0xOTGVqSDZFQ3pTYUZNQmRja3J4bFBnQ2JzcmZ1c1JZYkZwZW5s?=
 =?utf-8?B?bnFsSXM0QTNqQ0xJMmorcU53dXVpR2RQTFY3RVBkSjE2dTRZVUhEUWRFdGJz?=
 =?utf-8?B?cUVzbEJpWUN3UXpxR045dGJCMEphWWlxWG0zVXJZZS94QUZ6UVNRVXJ6eHYv?=
 =?utf-8?B?bUdrZGI0ZGVrWmpPV0dNTlhSQXdpMXFEWGliYkYydjRBUEdSd293cXVZWXNE?=
 =?utf-8?B?OEJ0WVN5NTRHckdnSHU5OGZyaEgxTlVVeGYxTWJjM2xadGtFVzZnVFkrTUVL?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3F3227712D8B64A9A47AB569DA25501@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s8//JyTtbGnpyAnsRYmYghGpvLyuHUzv5/az0ijDlcDnNmyB3404cJQqQCYBz4LpAUNOmyN5wLOF2ic+EO799EQGICt8z/6tpTYe3hnR8EABlcUsfIiqnBp9TxSOv1Xv9JK8sROD7xgRgPwYQ+IMq4ChHKnD3bSVW1Yh/9WZT2graLFxRGPDmBW246gAdh8V/DdQS+238xzX91pjAUgr+ZI6pFIKBTfHp5Ucf/T0mhwrS7VMeKt9Un6FkKQIwEfhDUKN1j+Wm1smb28wWHU9wy8E9zMZpX8mPniP73vbeHfBiZ2oN+pYKZNXapywM3p2PrMlD2rvN3SxxT1VfdVBOv8v8HY9N/CavoXWbvGmxipEYKHhLNNrntus5N6+BDMBkWLl3qS5mpI+Iyd23E/PGB//Cn0xn0wO8AMu7JnydG6pYjJCNVCRpsysTdaMnqRXHXQoc75NfW+fabZoNBmulcVN+0Ly3c654pAX/+HBd3/1MocW0QtTEizH1sjKOi6Vj26QA/C4RuJTpSJSLhQ6dbqt/Kp82kWVme2ETjLndPqFb1RamImlF/6mnSQmI/SDFyNNQqNuwYMuxqfmf97tQMgDWRVq7dsrbkDftfu31aiBiTZ7BKeBNnZ42OUFRFY//6LYiG/2ySymcUm0IaW/wNBgJvyxMcCiyVY9YmrjzAezddQ5uJED03Uqj9Ee/amDKB5kZ+J39eRbF8f/ERvXWdBNmZATpzk0LSFrlVViepV8hLdAy8Lpe1CA3tzDDBKoW0RylWESbcWW5wKsFLu9bJC8LEn6eFfJz+f14Zptizz7O5eKlYvTeQTgo1FnwhQ7+AYj+pTLI4lwSP7JvP78j0o3QTK1Y5NONxWHXChMdjIIOMWVYXE6baX4GWGA9AQI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3b1946-c1cb-49b8-f2ca-08db928bb34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:34:50.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eDesW3fAZ0Y3cl09r9x9cHxVBBDJQ7ixFlWaks1hbw3WcUTssa+X5/H70ET1+PypEiNs7UIUGzrps4quAwAgRknJ6ABCZxwNPYtJ74lOHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8173
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
