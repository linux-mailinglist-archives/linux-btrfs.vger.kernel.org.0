Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE886071A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJUIFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJUIFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:05:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D2B185418
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666339534; x=1697875534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mkMHnqQqD50MiYFzV6Lnqvl0+BMIHWkTdXIZrL9fz/LzsZcdeFw++PNC
   2rdlOkX20GfzrVtzNMDzrpGcPc1fV9CEqjmNJmB6qq5dtw6gF+TgtWXRg
   b6QFeABtmWE/XL9cjkKfrp0wRDI/gGkSgz4Jo5qK7yLumAt6+p4cg35BD
   y6WE0HN9qBwlNiHZaBRnf7UclSHsQNndmZlsRn8O2ojXEf6hMC3WBhHHF
   5SRavVTrGr/WRzrIxkdIWGlkfFcs9B8V/hnbpSYJ4m+Ot6ozH/wVO/pTp
   WHaNebry6CdO3DD3zOA6M0OTiLBwBmHjjsqFxYGBcBzW/LQrxiPFo9Vcn
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661788800"; 
   d="scan'208";a="212728523"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2022 16:05:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFzVHSKxRUnygbFweTzkJw9UulqDehvzFiB+B+lIhlfzZ2KsQ9k2vONZBJoKbl1L88g3vAHeNU1pECnn0bxXOL2NWqGDbTzcIOlUd1jq7JcA8GG6Bc0jay4VxMnLAyRe6RMCm5xNm7OeQWpwrtFIcI7L+y3uUy2uv8QzytwfFFYwyoM4QFgatfnEmYRmCABEg1itQFUkisTy2jaTUH4aNGwbrvQ9MK+P8cGYglIjOjirjmbv2neA6ZmxKPhdmDVAaAocQd8njUAsTDTsL7hLwXo4wFZO7UeNCXgeV0hl4NM/pd85ot3JT06JTVmyZtS44yRnEWS4jpkBRbehZiMv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=i4oh1UWb6wkRytpygQCZrdzQ4z94rWlaECN6eKuQFOMBt9sBncblbwvClGtAL/gf7q4H5mzeGF7/OQZZg3XnEPowJ2erV4+JbRKYd7cSKl0pho1cZGL9eJL6RN0l2Wdov93s2p6OVIBUTgApfRNsgGsMRZWvHdsZ97Pf3VNmK9tQIElL/vgCLde53Y0n2lOe/Gtp3udKD7Kj3WUgSc+EheOmPi+ePUMHrnwNMIHxul4sHetLgajUuF8D9orRsmcZ0s5SXgVDtG0z0Byu23J9xc5uc8YFNgocuoJzXzLD0AOYZC13MK/eGVk9iiQDP2Vpv4NScFFznA/pLcqScy1E+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PO/U3KRJm2y0J9h6Yi9nlJ0Wg2tuJMeVAshdL07T34linFY61c16f8W6oUsD6/qPZe6FJGGl1R/cjyLNRRLFVWrw7Gkihfhw+IoMLRaDUCxMQiwpJ5GHfUhk21NDVRoLXvw+Me6JT7lRmRDYGp+eRw86UcFNHhwmLkOYTd7WG+c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5674.namprd04.prod.outlook.com (2603:10b6:5:162::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 08:05:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:05:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
Thread-Topic: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
Thread-Index: AQHY5OY4oUmSKVBj/kGNf2rbamLDZq4YffkA
Date:   Fri, 21 Oct 2022 08:05:30 +0000
Message-ID: <b2013a1e-0fcf-5da7-a944-7485455702c7@wdc.com>
References: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
In-Reply-To: <90e84962486d7ab5a8bca92e329fe3ee6864680f.1666312963.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5674:EE_
x-ms-office365-filtering-correlation-id: 0a5f84c4-fe35-457f-b2a3-08dab33b05ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY85GSNRdX3BmSH8YnMyDxagMSrbkxa1+1bt/TP1d/hX/551spsPi6ONoMB88vFJxWbXcc+jpyXkf1TKQc2OXiQ4n6Piq1Mi1hjEawvKG220+vBFZiOICcRlfAgCEGWva6bhu+ktPwfOur+wyHREZVbkZutGJLJ6rELNBgmSWgMeUx03GEvSdtxcW3yoeo9LNwvFRdUl18aseGTjNaFX02fktIqXFJQM9usYFu7N6i/VJh/8llZsWZXuJziBjNsDLiRnC0ubPMeK6s1zo5Us38IVevSamBuC2aDt8sCN3V3Mt82dfJmYUMsRVIx4K3/BtZdBCd31iiLk2UPY8bPnIsx6Bnjo/ae9+EzjHZK3kmaccYSdjyewgxuEkY4hKuuO/5fW3uEU9goj1NLv7UhYP2rxkbaAJaUEfM5+UMmXxkXiBIzZbeGcQklg78S5hdgT5xn9FzRP11sqQYvjYou4XzT9XMPmSfZLZXjYJdrpnXwAncG6fBe6mmRA+ovr6t7r1sVWO3kqyxoie34v4vC/24ylttMrlLxxoxjl/TDYnYcn1Mu/tllWNHGTPIl3S76oMBoaz2hTAAZjFPtVpUSvsnfzvkj4K4UkTQuLAVYPfngPXiSa9InSasvHVV3JlZBdz0dEu0QkI5eOlaVXu2TscB2X4DbZ6cOtJHKUoef8S9hPDmGXWKjLDG2IGw0xTe6OWEl0t1pQUwsvtrg1V5J4eD2inqnLATGXXLg6S796dSdRlGTDyC7kJl50nvvmHpTxUzXAhsYl6q3nCNdSHV6oQzt0HaTuXxwqJhzfPiAtvJfOEa1OhLavZJx7qABPQzHxi/KgNn4mHd6uZ94Imbl+qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(478600001)(110136005)(6506007)(66556008)(31686004)(54906003)(71200400001)(66446008)(76116006)(66476007)(2616005)(8936002)(91956017)(4326008)(64756008)(5660300002)(41300700001)(4270600006)(6512007)(26005)(8676002)(66946007)(38070700005)(82960400001)(2906002)(38100700002)(122000001)(6486002)(19618925003)(186003)(316002)(558084003)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlRNN3VQY3N4bHhodFpCZ3VoTWNGVE5xM0ZqemRYOW1vVVc1MlBFenhhZFlr?=
 =?utf-8?B?cVZ2OW8zVjVpU2pqcEFOSUUrcG1pSUhEWUpKUDJKNUJsZi9ZYXVvTDZOZTV6?=
 =?utf-8?B?ZWhsdm1XWk91LzBiUjF5QjdTdVVGeHJyS0lRZW1WMTBOR3hCUElyTkIxQXBJ?=
 =?utf-8?B?Zy9vUWFaWmsvejZHZnh4bTFGWHA4QVNRS0ZlSWtoQVNTbHVwTmZpcDFFZ0NT?=
 =?utf-8?B?M1pRN1ZDYXpPTExHY2lYcTNMVVBFWEsxc2dadXJvT2F6U2hJREMvc25hMHZ1?=
 =?utf-8?B?elhydFZZSHhaUk12OGdtb2lHU0s5V2VER09Sc2s4TnJFY2dPS3hpNzB5YXVs?=
 =?utf-8?B?NHZUT2ZhYXNia3BOajhTMFVKL3VLTUI4MzVFdnlWWi81czFWT0J1VjlIQXB0?=
 =?utf-8?B?elYyVWthTHp0WXhvcUdpSDJqTCtUU3BWSW1NSDVFMnZBUGZZZVpvQ1RnM05p?=
 =?utf-8?B?KzFGaVlCV1RkR3NrdFFJakRDVTVLSE40NkpiL01YakdwMTFrelhZZW5NU1lt?=
 =?utf-8?B?U0pOR29YTlBvV2xoU0RHK3BsRjlBT3lBRnFMYnBWcDJONFFkTTUvR1NMYlkr?=
 =?utf-8?B?RVlwcmdJVTNKcnBzaFdjK0lpNnBCSkRoalp4K2FqemNyVFNoS2hDa29POWt4?=
 =?utf-8?B?VHd1c1R5bzZwaGRkYzd1bTNLaVZGYjVGK2xveTV2TTMyYkZKSXhLM1NRYlE0?=
 =?utf-8?B?TmJ3VkNKTWVUQ1VZYnEyc1J2YThoc2Y0K2IxUEVKVFQ2WkVBa3hlcHBITkZC?=
 =?utf-8?B?VHFpalhOVlZUa3VycnBwUm9NVkZWZDRSb1NmS3FLNDVZU2YyQ3lBRTJCdHdM?=
 =?utf-8?B?OGlZNWdzQTBiZVI3K1FWK25lRjFKNXRNVi9mcTBLQ0lpdjY4VEgzN0xJVnZC?=
 =?utf-8?B?bTBvYnVleWtZTkQxbm9SRUJMRmFaRFA0emFRK3BmR1lSSll6WUZ3QmNVNXpo?=
 =?utf-8?B?ZFdJUS8rbXR4dVM1b1UvUlYwMUtHZEJSMTVzejIzUXdXemFZUjNVd2p6bUJh?=
 =?utf-8?B?ZUNKOTJpSjUxTmZ0U2JYMVk0eGR3ZFdQYUdkRUUvWHo1SFJtVkFSY2tqcmdn?=
 =?utf-8?B?K0crdEErTmVwVy9jU0FRcnpiVHdCMW1ybGZNOHRuOHZqMFZzYmdQeG41WEVV?=
 =?utf-8?B?VkVpdjlpU3R4NThUOU4wcnhXV3YyenUzRTNoRS83YWZjeGlGejEzRVNad0pY?=
 =?utf-8?B?bCt3L2xoVThFeWR0VEY2eFZ5Z2puY3RnUVkxTi9McVRYejF2cFVtcjFlNjBw?=
 =?utf-8?B?RkkvUndmc3Y5MWpUQkVqdmg4ZzR3QTZVaTVQK0M2YWdMYWdKWHl6Zy9tR002?=
 =?utf-8?B?M3dXS253ZVNWWStQRDdXdzQrQmoyenNrVS96eEVqTjgvOXpENTZIa25QS1lZ?=
 =?utf-8?B?RkN3ckkyQkpXRnRCdWphZTNyZHpXWlp1QURCT2RLWWdrMDBrU3VERkpnR2tT?=
 =?utf-8?B?Uyt4V1RjZTcxZDFMVHFITWNybzgrTUpZL0VDNEpDVC9RQWcwOEZMRWRpRnY2?=
 =?utf-8?B?cy9WSzJMamFUekNMNDlsUjhENXhiWStwWWc3Y1A2M2s4Y3NPZjE1WXExVjRT?=
 =?utf-8?B?Q1IrTjdHK3FualZqNnFqRy9ZSk5lcERsYUQ3ZkZ1R3BJb1dzREZmRkNkK2hP?=
 =?utf-8?B?Y1V3aDhKQlZvbUYzcnNRY29zRTQ1eHUraEYyN21GUXp2M3BjMHJ1cmpwUS9O?=
 =?utf-8?B?ZUcxdGFkZjRSVG5SSFZTQUZicXhqK09xSlU0Y1BnWmxDOCsrSDZXYm0zNE93?=
 =?utf-8?B?WDFucTFaYXdJd2g4a3pHdkYrVC9OTHZMamtHVW1GUjhyMjFZTEZyVDViaWZN?=
 =?utf-8?B?ZWRkN09zcVN0dEJzT1lZeFk5NllLVExmOWV6cHlnSGRISzFHeFdpeGwwRU85?=
 =?utf-8?B?SnRGaW1HS0I3K0t1NnBTaXoyRWxNdDhlQXhNcFUvNEk5MDRQb2sxeDVpV3Fk?=
 =?utf-8?B?OUZHZEpkeEFrdEIzaGV0QkFGUUhqQXhLZXdpS3hxb0JoWlRYb3p1Y25oSVp6?=
 =?utf-8?B?c01sc3ZmNVorTE5Bam53UTFLRzA0SWRHZERsTHNZQ0xDeEhMQUk4OHQ0SE1t?=
 =?utf-8?B?QVJCREN5dnNXZnJOWlo5ZzhQVnFPZHcyTC9tRzF0Qnk5STVDMGl5aG1kK1Uz?=
 =?utf-8?B?NW42MTVuV3J1YUpKVGFTTWNGVkVaT0swZU5DU050clhHU29VcHh2dXlNeGU2?=
 =?utf-8?Q?Fe5bjx8bXtPFuJfR7jscfZc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <117475217238FD40ABB096B0F8B28BF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5f84c4-fe35-457f-b2a3-08dab33b05ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:05:30.6285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6ALCZUGzErmWYDyjeGCaFmmHsEkPU0K1DBNFqIx7Glaj6AnBhu5EDHLfYi1PKrrXfoYAWYfU4e0iHaYpf5Y2UOq2z2c7JFH3Z2ehfc25Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5674
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
