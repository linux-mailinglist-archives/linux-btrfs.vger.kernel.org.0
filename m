Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132416BE6EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCQKfc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCQKfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:35:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF12ED7D
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049330; x=1710585330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=YYwYPBewXwvJAachEbgn1/mjCssOUVHBFN1p0YnPprTtL+03El7zeGoG
   0bv3x5SJiyUSSpMu0Bu3wAQU3MG2o0qtjZ330VawLvSogakdJlSX01jSm
   SfXZ6mBlR9k6qYj+9mpYnv7KxsfmGgqOEuQjtxz5bDZSlZhiNkGlFfY3L
   WtX0l9zJzreY+QYhyuoBAzD8OX5rVP8yJ0Wixqm1ykPEXe7KfY1CsHkqE
   YlVJp7opNRdd6T4qlUztQ6FmeeXCFdXSvZImPyIs72RWm1rxLqYhL9FYx
   0gsmP9qwJhqz2mz3DyfHrkh8dldMaAMrMdZY01YpmKL6205VE4Ec9yuTd
   g==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="337898219"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:35:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtygyFTcGDZGqRpdE1cu+zTnLxJ/jZkzI34AcjuiEPxk2RMHRL7k0Ez5tzBTjhM3SZGBzdpiHdLiE8/ZGLo0zRp2PFQWHsAT93pfmek4u7oauFy8gCqiJJj+daqz+zLJd/wwunwi1Qkl+c/Y22wgFVaRBuSOS7HnOk0nquzuII7Djpu5xliJugZMtiCy/Ut7Qyh41eCNBcLMGiNq6bh8G1uCsx5PKJ1Nvg+d2kdvwhtV3xfGIQbfd9HVPHPje9khhtLN29Bm5Jt1JPbtyoG9784D7S//Yxo/w8qV3COkcsmKSACqF3X+il0fkh4QsmbUvGKJmgV/lLP9ew8bkyoVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gAdc1TmFMrBc86LMESEtguHWhm82taA+vA9my0s3AR1G+EtfhU/+HSY0JUjMGFDBG+ZcNtQjSjRSLU7iQ4JtA27E8o5RN4kPl8oSlHOI6zzML6Q035sGsYZs7tDfROvUPXdK4WydAm/mcM+XnJYWsH49hnbtep5aPijVZZl5JUdzFkgCUhjPr2s0oKrROD3XSYun0+WRatLStKlZzyZtUlVZ+Lw6Vx0CsJkgALqUd68MJWFDmA6EgefN1g5VGh+qAnph+hHMPBIQwJN8izwI/RP0f8gKA1BnTUKqquMMsUa8srB6vDSqlXN9A0epnYbSYFtV6FaKdCHyo5L32hTBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=A6tgwRCie6LLKEyOav8n7vb27eF1Gkuq6Q0vuXTu/76bmCrjGA6t89ii6Se0idnACPQkUhvE9TtnmD68th8TgiMeeQiLEkg1VDwYzJEGvzcYImqDzwNlD1MKxshgaTNvJF4Cc/Grt8xR10U8kuwf6ZAzxoaaGw/J7VfawciLwwk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:35:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:35:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/10] btrfs: remove irq disabling for leak_lock
Thread-Topic: [PATCH 07/10] btrfs: remove irq disabling for leak_lock
Thread-Index: AQHZVpZyRoIHUbRTAEyJPmk2hIciEK7+yzIA
Date:   Fri, 17 Mar 2023 10:35:27 +0000
Message-ID: <84a36788-3b10-d18c-2bac-a3396e1dab90@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-8-hch@lst.de>
In-Reply-To: <20230314165910.373347-8-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 654b06b3-eb25-43c9-7459-08db26d352af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yr3zbgwAVoDle769NtYXNnqzxuB+nQOtStnIRjVT53pyRAct7+9l+mCTuot/gzdYHzRe0kk9D3xRmrAc7hcWZ5XOfsF2ybNSQToc7K2FIRlLYlRENCTRpbsJTqYiMetU4a36Flpzr87aw4v/PefmYh0tftDwuruRqao+dOV9rWSz/eGDpRJ3xcrD8FSinQPdNw143+GojP7vKY07dNUOaLpLzVtsPlV2B+PnXlbVWUGBmKLY4/MtVKx7X6bFx+upfdep2vZ8nOoOSfusijxUJBPQ5BCgmwZU9QegytlfBn2DIqi/3Ca9+qkKdZlPcafRReqJtTd3/iCu00XYM4teC8+yMmMNJ2DOctDZmvQ7JM8eJqdGK3UxojxsKHMJqkm2rAxY4Qi0ni/bVAGxuYGIzVDz/AZ/tbXssEQeZXcaiFdcoMcIvrabNMt48oFb4rotQkPrFpjeuvCVx1fDAspFMG4dZnsn1Yf+7Wo6L8+qH1qnZ2QcyK2RsEL8joIs9WPjG0yVX6eDkXGN3Z6GNvczmydlIEiXi5zDYE1WtAuVPcjoBmVJuBsprBkBKOFJkPRIwj5t0AX2Uhcg0okh4SiByZN1juyRgL84XGXxIMXYD4z8KBWsfjU0+S8ewKdKV/6wQ/s1BZZmapl1JKlqNjniQGWMSXg+LFNMUUbY7PBP+S59zsKJGuwMuLVeEwLbrjeWccPdtqBUUsMb7blzWHUaDhfo+6WabFciIu1Ci2BXchURs3fBUshABbAVdhwnMx6FVoLWP21o3nv/ppY30J637Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(558084003)(6506007)(66556008)(4326008)(6512007)(82960400001)(66446008)(122000001)(4270600006)(2616005)(19618925003)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bC9wNVJvMjhDdkRBZ1hUKytORVR5ejBWcVZKc01vME5TTzc2dG5WSWpXK1Fo?=
 =?utf-8?B?b2hlaEYxMnZKWHJHdjgwOUUwcGdMM1pqNmRSL1o5MURDdC9ZS1BwTjYwV0FJ?=
 =?utf-8?B?R2M3ZzFRSkI1RndZT09wM1RTRjQ1NVpkM2Y5Wm5HVG5TVkhSYW0vMWZZcUtY?=
 =?utf-8?B?OTErUm1QYmdSK1puMkZGSG16Y3JVS1Y1QisrZEJVemF5YzFGWHdZRURKODFL?=
 =?utf-8?B?REhHT0xUbFkveWx0cDVyenZjaXJFOW9ISm1CS2JEVlg1Q0lCM2F6K1Y0aHFi?=
 =?utf-8?B?ZVhQY1BpZXIyaDk4VkE2cmsvRHJvUitnTUQyRzU3YzV3V3IrSy9wcjFScGNB?=
 =?utf-8?B?MzJaZElJUVIzOW5IT09vUDcrdVY0ZStoM3dzb3E5OXVZbHkxVC92aWd1OWY1?=
 =?utf-8?B?KzlaSDU3S3hVVWtEb3dEc1MycTdCamlMRkF6S0lheHl1L2RqV3JBUHFtM0p0?=
 =?utf-8?B?NE1sdHB2RXpwOUhWZER2R1ZyWmtoYUI3cFNmVTR2dHFxYjNrNEl4dGVzZ0dl?=
 =?utf-8?B?TmIxcHh2VExaUy90MWVqQmRVL3dHaVdjN1RrZ0liTW5nTDBGeTB1aHRJUnE0?=
 =?utf-8?B?K2ZVelZSV0d0YVA1YUIxRDZ5SWZ1RXRZNEU2MmRwRlpaanJnTkZ1R0ZaMXU3?=
 =?utf-8?B?RXZSc0R1SkUzYVp1VHRSeS9EWFFTazBPMmZVeUFma3YrK2VHdUhsWTVLTWY2?=
 =?utf-8?B?QU1xS3dUa29DbmVRcDc4WTNGZGVERzAxTHhaSjl0dWFSdmQ0Vmt3RXNOMjkv?=
 =?utf-8?B?OTZYWGYxUVlvSktvTE9rT245cnlXMEpRTkt6ZXZYNTd5RkIrckgrcXdXblpR?=
 =?utf-8?B?MFRZQzROREVrZE1mWlQyMlQxZjBkaXhBMDRMQWVRckJwQnE0NUozb3lYTjVS?=
 =?utf-8?B?RFAvRjdqOGtVWDE5M3JhVGk4SGRvQzJxREJrMGVsODkzMGxnNGV2RjZaL25o?=
 =?utf-8?B?bWNXRndDNGtRWjZ0VDBBRlo5ODFCTlJJbHh1Yndja0Jac3FoVnFRWlp0cndi?=
 =?utf-8?B?OC9aNVdmQS91cjZ6SVZ1RUsxTUlGd3F1ejZxUVhmLzdqSkYzTWx6NFh6cldN?=
 =?utf-8?B?RG9ZbjBra2NvNzBsSnE5Q1ZJUzlkd3hYL2xUWGJHY2Q3Qnpaa24rNHllLyti?=
 =?utf-8?B?YUEvZEltTk44cGkyL0hKOVREWUVaVXQ0SnczMENnUS8weGk4ZnZxTlJ6MVRX?=
 =?utf-8?B?M0NBSDVRRmNoMDQwYURDMWgrTEduRmd2NU1zYW8xdEpyM0JjcmFkdUljL1JG?=
 =?utf-8?B?V3MrRCtDb2hmYWpCTE9zZzNGV0lSMnh2QW9BYm5jdy9EZ05kUC85UWhIUy85?=
 =?utf-8?B?cnRrQ0o1T1FaYkMrTmtXQlJicTVEVFJmUG1SWHc3ZHZYbld6N2pLSUxjd0xB?=
 =?utf-8?B?VW9raHdCWm9qRmdmUm1jTzV5ekQ3R0pObDJmR3I1SW01ckxOSHBwSktibThO?=
 =?utf-8?B?TzRVK1dPVFI3bmtQTGVuRFo3dUdmQkd2aUtTNSsxMDhaT1BUWUh4ejdjaVRY?=
 =?utf-8?B?Z0RTc3FDenltaFN0OW9oOUtmSnN0YklWaHhDcDEvV21IdnQ4bWo2VCs4Z2RI?=
 =?utf-8?B?OVEwQTUxNzhLdlJrY2lweTNPVGo3U241SzBReVdkQlQ2czhBREhWbkZ4MW51?=
 =?utf-8?B?MDFiUjZTWDZqMU1DNjBYYWVWZTVpTmUyNlZZVHR1anJnNDQvZTVVNm1kS0dX?=
 =?utf-8?B?amR5RG9PTkx4VU04VEN4c3hoZzhYYWdFOEk0SjlrU0FGTFpUU29JRmZseXFm?=
 =?utf-8?B?c3hNK1krRS8xWDZoMHRlNTFGbW9UbnBBZGpReHd3cEZDYndKbmVMTkZpek4r?=
 =?utf-8?B?N205QUJZaEVsYVQ2NU9NbHpocWRlSDYrSWJwK2w5bGlONDY4VEdmd1M5Y3hC?=
 =?utf-8?B?eHFpVEdnQXVpNTlvcUlUQnpzaHVaek4zQ2lPQzkvUHlJcUpJZ2prb2dUb1JM?=
 =?utf-8?B?TVozSks4OWRxM3ErTHpGdCtYcUtCbnAyUnRJSzdCM3B2eDA1RzhReXZvRjBk?=
 =?utf-8?B?dTNCZzlsbW5OOWVMRnR3RU96L2t3UUE1S0NVdHRGUUMwU2lLQmhWMEl3Vi9X?=
 =?utf-8?B?eWl2VDFBVUdDVnVTYzJta29UcmlMR2FaTTNLSVN4dFFXNWsySEduQTFudGFa?=
 =?utf-8?B?aEdOMmp1K0RqWVcxMGV5dVdUSGxjeXlBVTRQRjVWaTlBbjc0US9kdGx6N0RV?=
 =?utf-8?B?SmhuT25EQjlrYTd5ZldGRTUwRzJ2YXRiNkFKVE1BNzloWTRqNkhVNm94SUtv?=
 =?utf-8?Q?HSOS1eU+1m5jaEs1gT5JRpYJEC9qxo3bHhRO1qFWrY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55E56B4B2162D41A5413159A8249A20@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lD60tTtcZOaKiyQQvT9Rae8N4FzkLD9nsE0SjbRVYcPO0MATIvBmXAoKN3bcJ0ncM5qtinuTYW4sePWul/Rx1X7Vl/7ZYtMAX46oo9l5iLU4Fq0RcrPacTpe/atBb9WuqkUwRbWiMCPl84VtbNRE6UC+Z54nLxx7e6Fki13HQIB2odaK/5KRgh9jd1M93qqfhw7yldq5x3GKHZMU4xoYzjDH7V2C9sbWtzMw9HvGv88BkJ9uYrnVMonFSmZsi2YkYiEzizRenVySyltsYwRcphE1KTnJzYBaCEBEESFj8BuAb6rmqsNrnd9pEP4cPf3Wu3C5oEd8T2qRrq9D8AkzHUmqDPDFC9NTzEXAG9WpuyzlZ2HLR8KWn5obPWGm2Vygj2Yf66nZWFuEjEMTaS2zqJBG3mgm/RKbxBwygaof2d1LuiclOdQNDGZgPw5v15cdXWdACTj5m+NLXPeE8G8WC5ph1gSk1EwshNdT48gbOuCfYJNhGlbtT9gCOFWx8S1FLXdS9cLLAcvkeqtP1fcSKKeFs6jAdhS8S2UC5eGSl7Fl5LMqpHrMh/Yp8ORfHKOHoPJTHc2/AhV9gDiDes1x+uiW2wrhIIVjDuEIyyd1qYrNQrc90cRhkbXK4A1x1n5qIL17i91pdPCZdmZOlC1shwZtqx0IsKsw5CLzpqHDHIq3mGXoMGjFzKVLMfnf6Ux3CtrNCwIjrfXh5rXSH1gvEjrm6puY8oi4Jil9H6XGwuBrvNO+VjKzIWYmoWRyjXqPHXzk1/L2HOhz8GfFP1MqgZU2nlTx5nAfyAOTsfYUuHrtZM6L7zSjG3OR6cQXQc0VMsM1FT5QeBQjMw8MbFditKI8IzKUG7/BF1XdbiX00A3iDey7BrieAUs4gniPB6XuE+FLbh/gWH4yvSqYwOjl+eQ5E4RXNnr/AY3aBDv5uM4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654b06b3-eb25-43c9-7459-08db26d352af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:35:27.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRG+jfTAuSaOpO/V/RmKvlQbaHWwGucnljeItVjEr79USsVkr1D+1Ie8IYl4csXmZVU4O0EmlCN+xWW3SfZ41hycnuI8xD8DfZVURopuApM=
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
