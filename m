Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5D70DA0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjEWKLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjEWKLo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:11:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED62FA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684836703; x=1716372703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=E1D0LKJcj1q3XrQi6dP/2RJ4mPbSw+QZccC5RS3sJaVY1BFC06eRrxFt
   lX6DlSdLyDuUJDwgUsDyC9EmOBAwQ4VeUFGmFNadSVOAyeZtUcCjiBrn4
   Wrw5Z0D1UY8pKg4nY1Ky/fkB47XphkewVb2ovLkgmMkbrjSxwBn3T/rUL
   Sk7iSQU6HgcXFd98tQMU+qU6hu8ocGFPiy5BZmwoY+seQx5vnp14MHt/A
   lmO/aNl9Q8+X1dPUhCKftUvhUBQ1OsP++njNqq+/udq3EVM5nU5bgaHpb
   XnZw2QmmnhWP4br6E96jKzJwZTLMxXEZOVxVzY2u0LQMF00v8kylGL9vz
   g==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681142400"; 
   d="scan'208";a="236375065"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2023 18:11:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG0SoYZmy1Wq8tmpinrgR7q5nYowlZziT3XfKi3WMw92p5FhCJs8SXGthVOFSK0t4uPkvr8hMvxFSaSMGLoi8hE0KGdXjO+FteWh51BoZ9mdPNDGr1i8jQv30wl+Suy/7tnIr41fCyWfZwrYJapfI+QrhE/G2ONmF2mIGsuGAXSSNG00muD5/vbbgetMckxX7Srj6TTK0mYcDMQLXo5bwPsZlvJC8jho9/TyAbwK3ec23oWWj4JuszXcQFnzdUSjmVtgmxM5LWQEqONpXmPwNjgh+GRyfE/TY8iS5MBmq4ZODbfFSzl78zzgB53w86hggBRMPJgrq2et7+yQrAYUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=YaOYVLM+h/B9mAnzr3vSPVeYTGPqa0LJk1GjKQi/NalXgBdADekiX2sKYe3otwfz3U7CV91pYU8TH8LQ8Z2KB27sdl3SZErrVpeVjYSmbu0Pg+xXK+jymChiR8TXgE7+QB2ilsRQqE45TKXamQn93XMpfjxoalJEtFcC8Ixl9E6EdAWKLJ/YeRbedhtE/wZu6AtaNns0GUjJGVKasURS5xlw4CHLcM2IBy+DiMEF2wwmv+WxGEk5fkBcC3/yTa/74L5IyuZ4MXB/J8eOT3jY2iTQ3ojwQWFYoD+vFdmdbbUSAWHLEbFRYycjcYsKr2nkmhnkgkfzhxBY68naJJqvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Vypmdsvh7jQpFSp0emMuXN7P2q4gT0uqRU2lenSY71FH/nZbE+lzfyDpQx0Pcw6wKba47BPv/er8CSnfE3gwKVMYuSYmJLu8chaavx5/khWPlR+jC+Kfjutf4FeFrgOW+9kTH+FAGsgEo6oMD6daqgIxlc74HIp9ZQ3RNfkKHk8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7676.namprd04.prod.outlook.com (2603:10b6:806:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:11:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:11:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Thread-Topic: [PATCH 1/3] btrfs: fix the btrfs_get_global_root return value
Thread-Index: AQHZjVJ+FYrfjt+lCEey77o8L3mX1a9no0iA
Date:   Tue, 23 May 2023 10:11:40 +0000
Message-ID: <14cb729d-2b70-17e1-6a5f-92ca8d1e6778@wdc.com>
References: <20230523084020.336697-1-hch@lst.de>
In-Reply-To: <20230523084020.336697-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7676:EE_
x-ms-office365-filtering-correlation-id: 8b0d1da3-8d19-402c-742d-08db5b7619fb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAx8OE9KtXPcPa4Cgc6JlGerhxzaiP8IhxKmhlPL0X16u7pPEzGxIOED542o757VzMu3qLq2X02HUUkEt5qA07YP4b5BrQmnttI7DNl2uZQq7dSH9BIdHxxL6RayUtGpvZmQSoMp1rWmOfsU6vmhj74ZKidg0efjIZQS2KcBZExXEGxFvUlr/VC3rlSFk9dZ0zUNBXD3ukEs021kfKexd8fZW0mRQDEq6nkhvxpKq4vFg0YMti/WaJUBo5KiGWqikSfMd0UJNqARWsUpVqPfeCwtkHQz50x97GNu42kiKjxvz+4Svd+uqf9px12qYwxuIEudiB+JL3SRs2bkxgt3sAphbBL2o0wm3YinwtMem7HhWof7iUSzVHAWi1hFlBUOXOVqlR/70vxpmdDSyjRTrv+Sp/24LNirch4FQZHiMp6aiHPdta0TPgZhH7ViMdAzTrr8xNJegtqgMcKF90E/705TgTH7GTMhTm9dAeMIdmn6Np5CscWy1QjR/IVruFFsuNw3EJoYTJN76QlEGcL3+llj5pwScYcK5WNpHK/REoL2vImoueF9a5r5nBcMtvRlntL9AJRmAWfhNOc7aixe6ZyOCvvJFm/VJsu0rANs7T0ZXh5QxWWFMeeCxLHmxVfbxvss8w9iwk80TTEu4ZYfLZ1zV7ypuFG/hBCVtzfFJZlFhWOYKX9HzyyKDXB9qf+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(6486002)(41300700001)(31686004)(31696002)(478600001)(110136005)(316002)(71200400001)(91956017)(4326008)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(86362001)(5660300002)(38070700005)(8936002)(8676002)(38100700002)(122000001)(82960400001)(6506007)(6512007)(558084003)(186003)(2906002)(4270600006)(2616005)(19618925003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3RDa053aGhrbkpaVXJ2bzEwWEdVazFaT3BQMmpZZHBwdzc4MEhVY05SY01O?=
 =?utf-8?B?RmFpdHJ6b3ZrM2xVSzhuVnVwUlJoUnY1ZGlnSUNtd04zdXBsOEQ2VkNQRjZY?=
 =?utf-8?B?M2N6M0JPNmdxcThKb0h3MmZBZEtoUXAydkdQemREbWNKT2p1R0hMUkZ5MW5i?=
 =?utf-8?B?Yzd0dXgxOWRXc3R3bjNZNW0zdzAvM2kwVTVsQXFRUlJxek1aVFVrTEdDRGlE?=
 =?utf-8?B?bTgzQTI1UUlmZHgwYWlpaUFoRE9LRU1YSUQwQUc1cFpuaTJ3M3BFbjVQVHB4?=
 =?utf-8?B?Y3kzQkoySmtFWkxDeEtKMFlJL1lzVUZaNnlTdFhxejNEcngrdEczZm5PVXVu?=
 =?utf-8?B?NFpIY3kzMnJGdWt2Y0VDSTVMM0trREg4YjJBWkpjYkZwZ2dSZzhpTURMN2xj?=
 =?utf-8?B?ckMvZ0xxZXo1NGtlY0dOY0YyMGJma3NqM3FoK2JqWnBZVW16YnJGY3lSVm5s?=
 =?utf-8?B?bFZWR1RGVnYrUldjMkVQZVdUNlN5bkJyRkU5TnBEZWVzWVhrN2RpYVZJVXYv?=
 =?utf-8?B?UGpudDJBNkZ4R2VpMWk0QVNuWTRQbEVpcnpyOXBRcU1Zc1I2MlpWamhNOHZ1?=
 =?utf-8?B?ekgvTDkwOGJJeC9TN1lkQ1VNTHNrcFY3ZW51VU5pYjQ0d0doRTJGWFFNank5?=
 =?utf-8?B?Z3RqL0VZOTRabzhnN1BqNTZRaXVjS1JXaisvNnVUOXBITUNwOER5NURzaGIy?=
 =?utf-8?B?dWs2cjg4YTJqUDczVFhvSW9iVldzdE1JNmdub2hFczNBQzlvdlBGSnBVYzY1?=
 =?utf-8?B?bVdSNm9laEtBOXZyYnFFSENGeFRzdm9xNUR3ZjBvR2QrMlk5b1RVbU1WbE41?=
 =?utf-8?B?L1pEVy85c2JwbndlOVZSUlZ0VEFySmhqTVhCTFZ1MTJwU0N3V0hrZmlNbG12?=
 =?utf-8?B?YnkxaHI1WTd4ajBxeThZQ3ZMUlVPZUw5QlFYV01Kd2J5bGE5aDZmeCtUZFpz?=
 =?utf-8?B?NXFZOWtVUERSYjFud2JReGowbjJyUzB2aHJpMjBxK3BtQ2p5QTdUUFVNVURN?=
 =?utf-8?B?Uk85ei9yQzA1Znh5d29POXlKMFlWZm95dmdvamM5RzU1RVJMaUNZcFhvWUVQ?=
 =?utf-8?B?VXhtbHRCaFdPWnV5R2czY1phOFo1eCtDSjIxbjEwY2pkQThNZGJEbFpBVlpk?=
 =?utf-8?B?QXBBNFhQQzBGbXluOXVXSXAyYWR1OWQzd1Fub0Fsc0FROEpid1Q5SW01OHpj?=
 =?utf-8?B?alNzcnptR29zekUxR0Uxb1ljZzUxa0FWL2gxbTFXSFB4TmNUQW1zMWZzMnli?=
 =?utf-8?B?TnBwQWk4Tm40bzY0YnByWUszUjJOT1JwMG92OUhhL29KNkJ6ZWppMVIyQzhN?=
 =?utf-8?B?V2hYODlxQzlUaklvNUU5L1dQVEg1OC9zTzE3Y2YrMm9rL21rMEVtNk11eExV?=
 =?utf-8?B?Qkx2OEIweGdEV25MWjU2djl3VTYvcGdtVXBZNWZUZWhRVmRmWmRaZk1HK2Mz?=
 =?utf-8?B?eU1nWUxORzlmcWtlbTU0T25mTzBmSy9lWFhhbGtYS1FqTisvRDNPK1Ftcjk3?=
 =?utf-8?B?TzlXdEVrODNON3lSaThvWC9CVVplZC8vWjJ2N2xmb056MkpCazFwVDJNSzJ2?=
 =?utf-8?B?blRLUzJVbitFWHJneWx6TnQ0K0NqYnBBS2tUcFpmdys0R2wrMDloejVkRkgv?=
 =?utf-8?B?VEVaSy8zOUlPWnJUZWlURVZOQzVWMHJ6NGFsS21PN3lod0NrUVpkL3FRMWdL?=
 =?utf-8?B?a0V3a0JDMGZxRjB3QW1WdzhwYngwTDFRVXNoazlDZWg2QWQ5a3FMUkp5WkVQ?=
 =?utf-8?B?UVhudTBjeklGYXZmRDNKRk5WYUlvOE45ancyM1docHcycU9ZNi9nMEtTNklm?=
 =?utf-8?B?YW5zTlZyTW1yMHdiNTB5VEc4ZDBEL3FOb21KWHNkTUtQcjNTMysrSTNvOU5X?=
 =?utf-8?B?NkZLY2lNUVFBMTFhQzNLZjFIdmd0YW5ReHFyVmhicWhiRXVSenlGYW9KZ2Jl?=
 =?utf-8?B?c1d1anZ0empWb0lwV0FlWXRHN1hHVWdwK1g3N3VaakQvWkE5UzZsSGR0VGox?=
 =?utf-8?B?VkpacmFHZjVkdEtHSEN0bDhWZk5VRFF3Z0VxZjlXV1NnY2hIaW0rNUQwK3Ba?=
 =?utf-8?B?bzRDdnF2OUFoRFpaaU5DZHpVRGcraWVhR0hIK3pqUFl0d0NJYktLNkZKc3Ni?=
 =?utf-8?B?dGRHdGNPVUl6Si9vUVFRa29kU05UNXB3S29RV2NFMHpqK201dWl5SE9MYXFn?=
 =?utf-8?B?YngxNU5lRS8wSFREOGNvM2dFdCttVVdqOTgxNjh6QlhvbnhYRVpqR0d2bTNY?=
 =?utf-8?B?VFlmVUNncGZCNURGWFpvZUw0cG93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C521D514EDA0564097FA1CE70029F345@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vhT6vuCJha37GxlUCdhp51MSRnfLflX6oNxTAOIouLfDA+YntmzRROdLnGvZbFPFCx4fCOlT8nsXVtzTCdlBgEqylnlSdyHPeI5Akj4xPMToTbFWy7Y3kulZqoJ9Hw3BDHmksmRgS/JGoOU0WZq04zEHXHOfRG8JGrV2rvGOgTuZ7Q1IxjhbYpc6mh2xqkiMmLrg2L2GOfkyYRpxMGar+OrHBUOxbYbNSAR9M3Nkfn+hDejUAT8p2n/FVcxla5daQ/W/CUJS/YTUc5+p+5dQeSrkeEUB2t+my5yN3Z1kzy3m2KCvYNbvd80wZ2/9uxNA0h5VvXtnw0IJI/24PgFiMAiCinVfnm1zpes7mnemno95cmFp5mr2MMRG6jjWdLY2WcCYfXy2hdyq7/F5CpBG6B3DtUqni4wegwokWA7DVXW7bIT1dAxRUm3+xqsvXCBoHnVcEPpyT1xxKCd+GYAasRFFBDB1e1iK9gvrY600w4BYMnojEkL4/mgjWGYMOfapw34+NdxdljbmbG/c2f/SWmDvFrP5rhrHOcwhaPzxWhU/E3SG09aqpdbV92MD9/P5yRxC9z0+qcLZ37/7A0Ar8cWckaTGfQmL0Vnbkvd69zYyxEeK7W5ZjSOPP314DsAwNT0dSNkCgTpHTRoHs7ZHaUMZfRQ5DdmqqGTHJYSKrX54YQ8WnsZZlIETbhNqTFU4fMKfGjsnmliXKYgbWD7m54EvhCk9yG31Tg82dtutbjJDyeW4p57XwzDkQYl/fCEwRme3XD3QrzBM4uu1WG30beL+iz5HDt6lHAzgBUe5yIEyvQ5SnC/NaebGoLovjILuph42Hh4MdfStAK3G8EKJeDVxUKDXNt+CM4OkBgw+fcP5qUlSFUkF2WnSmhkZCXdI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0d1da3-8d19-402c-742d-08db5b7619fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 10:11:40.2645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGATKCMI/UZdUFzA5P7iIacXUK1exgE8mSzuzSQW8qT5ZfWxMgqPg8FX39f5YXwho+xRzprPuc+7+wOTKuclXgHN5fMbs0cxok7Wy40EnbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7676
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
