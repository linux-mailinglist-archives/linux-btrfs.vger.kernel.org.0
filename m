Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2696BE6EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCQKfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCQKfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:35:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4A23D8A
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049302; x=1710585302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=B1FHGJjxLUrmnAkYwACRAbo7I2PAc1iFgYgY9JFrO3KuLFnnwM4G2Q2W
   WGqhoSkM6g7wQ8HXyFrvupDwrrHzKgDD7f5tabqzBclGjdF2CWEwCRErb
   d1Qrsb2wiHvQ1KVFQNLrVg5V18wizQ/R4TYUjG0SIi0PXOWtR4okzsb4F
   was/Gc50f6eXNsFJDaPCyyPT1UxEszSH1FxIiYHqBPMs1uGQ7wjfnpi1F
   7OwQSchixuFs1Isx0ZCwpSqW7hs8cqdlGfKL9uQr7kvEA6syJJ6JP95HN
   eyuqoiOHdsszsxNLd7CQ4v1IOfAWKCy7CEQFn4JFvTK5vn384XYjJuYlR
   A==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="330258395"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3PB3ReF3PujiE8DHoMk22e+Ih+MKrmx6IbErqAgzJIspPZW5FTYl6MoiF7nWl/XJInktMG3LEz6TLncm00UKJvtupiG/RI9yw12GGcoe8UZObaRLiIAn7orX7uOthZONTUSmKq+E6raL/VxIHl+wcLkDADEfftAq9I2VM/Y5Javx38M20TUU/FCl38mpAXWQk+eqM/R8BSuGZ5EfYzFdVJgYbX4nCjS0/Adl2a9WO3+xemPivpv1gG3UbhAoLmezwgyFixa15R4iLf/5z5k+q8qUAG73ZhufBEZY4ohSrC9Fge1rnCf+2syFEE3yk27iqBbXe3dDg3S6EUsZW87Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LL4WxhapV0xRhJCzIYKBOdSF93YLmVJAApZuLKLjzWW0w88aoj4sZ2LudTx2TzwD+kMlDfJCDRFyrzYwrgvY7GqKDEKdAgxLJ6FlzTFJk419l8orvf5hI3EtpBt9cFCke/lqzm5ILB2c6qARCZJKZwQ1A6r5cE/Ukmydc7HsPuVQcwEgHGWWFOAUhcQbTK95Mg25bkcIRlNi4cCkIlAlZ9SLO4Y/l0Cq/3n0vGUgxlQ8K7GTyEjD20x8AT3u93/On+uy0dM1LXObMZa7McFBRfbvRr0SO9GNQJUJDkhecCu7xwgzwdbD2jIMdsRaOIGFJxBJ4JCfpDU5ksA8MXiD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=P5/0dO57dTK78WM2iBguK/N+9iAODpa+vTs3VD6kZQ4wvJ9uszZqb2OEJzRImGbg7AmbKob+XVcji5ZrQwViO8S0wWUnejIlIkppafloMuUiW72kJtIv0UbtoDXGKyUwvJOKY0LAXWbS1/4za+rIUROkYNXyl6EYp52SJ3aESXQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:34:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:34:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/10] btrfs: remove irq disabling for
 btrfs_workqueue.list_lock
Thread-Topic: [PATCH 05/10] btrfs: remove irq disabling for
 btrfs_workqueue.list_lock
Thread-Index: AQHZVpZkdLlJO+Egv02tH9o/Gq7N967+yw+A
Date:   Fri, 17 Mar 2023 10:34:58 +0000
Message-ID: <21b1f1fe-363c-7967-952b-6e07dd41e7cb@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-6-hch@lst.de>
In-Reply-To: <20230314165910.373347-6-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 11119a06-d4e3-49b8-cc3a-08db26d34194
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 207QueUx6D6khnKW7YLLCepsJGv3z6kw1Zy6yZ+QTAcq2ZNuz/CJcgd51u4i8CaCw5n9Wo4xEkXm9VJ640VuI/en04Sj14yyHzRlH77osV4ohZvONuoHxEKvsnOH+WSICAJreFSceJiEXM0ysagSvxxAawZGMaUaUV7uULzc69hu+yYKmT7N8Sv0JNzq98+7sISoR0qa3eMQ5YK+lpcMN5rnUMQMyTOInhMe0g6CxbympmYFKxPrqNe3DVPnaDu5GNWCL/smvz51W9Zeg3byxeSPckZwHEBp8l4ds+Vx8L9VN5XnYApX6oKdIVcZPF9+XwllvIARr2YM+ByNq68RX36jP9q+yM93d1F6z7+TAzGSCq3QIIjZcixKcz7hvykUHz2u8eq2J210tNGJRQWGhW33+K5mXF1yXrqShB7AxFSeopR/KdWxkKTG2rWJEbAba68Om91ArPhIhVS53jU7qmrjagCgoJXcddYYh+Svvp2W/YdbbIaAnnhQ8ezjQtobamGe9EMv92b672dZu2JuB/H8pX8ZLATQQCoxWiLR+9GpzVdkdaFlsxncZKP7gydGgb27uy/C9ulC7oOK+6u8ZJgdcICZdcHSg/N2qeLqCvtpTrs2B1QYK50WWYVRsI8eCdDu0+AF7b9h2L9b305hJDTxp0sv5DpxzBPZKJyjiT54vUSsCYuMkzo+MbIYvr69SS6C2knvx+16vCyb3uuah0eVdiGfMOlQmo9hwh3ua3Q0q2Xuw3/X71w9IxF7J9gD/zG46it4l3uZJWSaQPaU/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(558084003)(6506007)(66556008)(4326008)(6512007)(82960400001)(66446008)(122000001)(4270600006)(2616005)(19618925003)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFNBdk9qSkVaZnBMM3Vma3dzMTRueUVNaDNjbWdoZGxOaEoyeEczSXZHaHFW?=
 =?utf-8?B?bG56a3BuZnRDVEt2YnhrTnpXMm1XVk1RL3VBcHVlaDBpU2xYVlI4TSt3OCt0?=
 =?utf-8?B?Tk0zZXp6d0FweEVNRlRoVFRPcG1maUErSHBNV210Mm1hRktTRGxkNWNVWUxR?=
 =?utf-8?B?Rm44V096VTFGWENtR3psVU1jSFoyODJyVU53L0hlL0VFREs2VjUxNXcxaC9S?=
 =?utf-8?B?bytsSjRibU4xZHBwWmRNYlRxVVNrd3IvNlpWbDBQMXRYT2dhUzBRdFlPQkVy?=
 =?utf-8?B?S2ZSRFhnQ1RFcXBiN2FyVDRKalNnMC92eFQ2U3NMd2N6czBTSGlYaTJNRTVV?=
 =?utf-8?B?T0N4OTZCNmphY1FrY0RIZmxzSmJGbWtSNFdLaDBGaU0xdW1rNXZHZ3hjY0cz?=
 =?utf-8?B?YWttOU5JdHNBQlN3OHZKQ3ZLWDE5TnBaeXdoMEE3bllMTlJ2b1VTaXdFRTJG?=
 =?utf-8?B?RjNscmJQTE9SKzZIbWxWSUZpendRMXg5NXBrc2x1c0FUK01TV0M5blBURDU1?=
 =?utf-8?B?Z1dVMGN4QnhoYUtENXpPZFg1Wm1yc1hNdlRqakpOOEdrUlVGWnZ3TmIwMW10?=
 =?utf-8?B?MlhZSXBIMS9NUS82WHZXb3hUYi8zT3dNeGhrK056TGFodDYramxiZmduOEtw?=
 =?utf-8?B?dFc4c3RydlhhdFJJeFo4TEoxZUxxWHlsdC90TjVtc1JnYjdJQ1VwTWxSVEUz?=
 =?utf-8?B?MkhWZ2N6NGlGdWdXNlN2c0J4S0R4b0w4MlQ1K3d1M0FreCt3K21WVlZkcHA1?=
 =?utf-8?B?MWIxMGRra3p5MVZFWUVzd28zYUwyaFVWYzduVUZhT05TZjR3ZXhmSUtjczFo?=
 =?utf-8?B?NDE5Y1QzQzVkalFxaU9RMlJFRGh6a2ZmWGhGdTgrUFkvYXVTR1Bkam03TnNa?=
 =?utf-8?B?Q0V5ZU1reHA0dE10aHYxVitiVDhXbzRYbUJrUGVhU0U1ZFdqaGFwUk9xR3Fj?=
 =?utf-8?B?akttKy9TSGs2d3RjRnV0ZzBhalM3ZDVrVEU3YlptY016UGNsWG9OVi9wMHZz?=
 =?utf-8?B?YmFORUZvVS9ZbUpFZHFGRzQxZW0yL0ZzQnl0V2ltVGUrYW81UHhxeTlHSFdk?=
 =?utf-8?B?ZGJFVzIrd1pDSDdzVDlpdlA3UUtaL3o0dFRSQU16cHlzeG9EYWNwTVYyQUZn?=
 =?utf-8?B?OCttTDZLc05RRU5XSDMrVlFabWNtd0xBbUQ3N2cxRHcrMjU0Q3p3YUp5Nkg4?=
 =?utf-8?B?RzdvSzJHc2ZNZ0V6bGUzaDNnbm05Q2RrQng0T3RKN1g4ZTBtK2pUN25lZEJH?=
 =?utf-8?B?UDJUUGttUFR4Ly9LM3ZycjFxSjdhK2pRYTN0ZVRvNWdpOXJZeGttek94Q2hN?=
 =?utf-8?B?QzFxRTc2VHhHTXgyS3hwTlY4MFI5NVRxbTlrWDVxQVlQck1GaGtab0NzYnAz?=
 =?utf-8?B?QURVRDh1Z3FJTE1DTStzVVJjc3FtU1R2bWJnTEo3cEtXRDQvOG92cVhDOVpB?=
 =?utf-8?B?UzdneUh0VEFMRG5aVUlOOUl6QXFlK2NZSmdJNDBYQTUwZnQ2U2ZNZm9GbGdB?=
 =?utf-8?B?ZjQ4YmcraXpXRHhiMlpVUlc1NERFL3lWUHJuN3h6OHhjakY5NUowbzlCRzNl?=
 =?utf-8?B?eWJuTldFSlR6MFl3bFhjTGh5djVxQzJXeDduV2ZUcERhMmJsT2xBTVAxcXk0?=
 =?utf-8?B?cUdodUgrbGpQMlFEeWd3SURCSmo5N2JScUhtN2VPVm1kU09VSFpuMkIrSmZ6?=
 =?utf-8?B?eXhKVW5qZDdTTFRsTEQxQlQ4N1RId0xpVlNlQWtkRWk3Ti9Ubzg5eFZaQjNo?=
 =?utf-8?B?NVF6OGZjelZpM2ZIUGxIc2tSVUIxTERHajhnWHRwd2xCeFpSUC93Qit2QWpx?=
 =?utf-8?B?cmJqZWxpc1UyVzFzTm13OUpXbXRMTExGQkxVTGdiMmFjd0lLRmVhZFVOMEdD?=
 =?utf-8?B?elR4TjExMjZ5WGNCRzFrL1BIUTdJYzdGNHF3YzBSTlUwY1hWMlVVdnVKMW15?=
 =?utf-8?B?WUlOZkJSa2pPNkdmQ0NXL2JXNGsyRnNiM0VCekd2YUIwbUh2UVo1RzdEV1pJ?=
 =?utf-8?B?WENOdktZUncxRTFsQmo0TXBxNVFVdjNFaHordUJvWlJSeTduMURKY1E0azZT?=
 =?utf-8?B?OFZXU3V5WWk5SitmdVBqUWE4T3UzYWkrbkYrQWtWekEwR2hQQmtiREJTaDNE?=
 =?utf-8?B?R0pSRDk1alJsMFNSaC94V09obXNIQnBIVmkxNG5pekE2bUlZZ3NJU25hOWgz?=
 =?utf-8?B?V1VQN29vNytZN05uWmIvVUVhbmlNQXNDRGVPS3B1aHV0VGwvdUpGNEExVk9V?=
 =?utf-8?Q?sc/nqrvipLMvViA+NMAX9am5W/0u0obyhgS9lgB1q0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94017A601993D34B91FC69839CE6D324@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dwk8nM4tFnWV1dhffLag5Uouka36nNjA4YSkrzSAfai8Q+21zYfPnp8LSfeuLRJ7J4vBBbtSuWRC7bpW4Ph+vk7WvQ+HOb1ZAhLi7MsrwIG4+ApEiAp0RYivylrtCfpRAO33g+YCDlrou1aIGKuzsjJh/d5VrYfMrJQPm5or8ppe8mNGDaimAbLenfn4AfsPoSLOmkqI5K6MA9e67BWdtj9jKZHl0+IgshhMyFndlzeIEWcdvRFHYYuUa+XcOt3netU6aGi7KJ/cSkEEMOzRKzlCRV4Jq6ctLzb6tfiePpFo46hKOOOM7GjPISSWekjE/wfDlBz6Mixt5oHJAQDFugaofuxCrF3f38RHPcLwByxQOIgu3dzaxkshwnOgrgAOgSPpb+jSDNKXTJNs2C9cyG9byswVhUJtKoRAjCcSYIbbdDVyxqKqZigKt6S8vYPHZTwe/5I1yanWGXPzP94+o4jP63iOJObZhnBrW71nYxQc/aGQKFhyd1JgsfaILNjTjVLv4Cg3s0GcoH11uFXJCXSMk8+aU8Iyb7KEZCBYv7raH2kFhcHnMKyYEjWUrJj1SDzq6VfHzdZZyTxdycnmtL4CrmJ1Kh0mgxuc0elzlhywZruAiGtoR0Vn+ruj/T3QjYsXVkvxeaW1KByk5btRzhqhV8r4KVPgkgWA4AtINyMHrAjeqc4kVL2qkg1kQd7JfCL/TkSb2bUXk8kA6IBq/8ux3b1Q/bKtI+GHizXDjAM2JYiq4dwizIksZjK6utAQ7txh6+nrGJufU8AuSTcAgHMFU6X7CRO5007egNyhd4rC6sDIAeEGkE4bRDAiIWbfZYKstZexGiaNvHe/Eehp65TMZsdivo5FepK+Kznc921b3thyE0Myw5MkW4PKyFSuS88guAkZFIssP9jUAMa3+Rv8+Rt5/G/ZqBqCn2zGvfU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11119a06-d4e3-49b8-cc3a-08db26d34194
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:34:58.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJsSRtaTuAGufnUP2C1fnkN9tN5taRZnPTd0+MfcKhelrWPkO+ff5SKtTgS8oZyR+J+eED2YYcXrZ9c2TOuMZBCetGaJTcKNSc0LsuCxDUg=
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
