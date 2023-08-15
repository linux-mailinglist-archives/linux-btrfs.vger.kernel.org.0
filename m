Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164577CB0E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjHOKQZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjHOKQK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 06:16:10 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0135019B1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692094559; x=1723630559;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=l/0TW9UKpZiJitW4+yHSOf3HOPjnZFnYt50+I02kYzI=;
  b=noeQBL/TrpoSAu4IQ4baW/W+TGfprx9YImwpdQFXXEYm+a+IYsMuRZap
   pjHygZ7SbkRLAwWD96fsBvrEFFGCHswghl4dWonpeYA6KKj6EspmT+/FE
   L3hYK4qp2XwGVEtVJ4cTWwWyAZwAKTSEB/K+VSfG45zRgPj2+xIwfBxjm
   XzFTYEPQ4VqRGTim+zxz8imo8OGGR3ktD+WE25LGLe+innpWfbXauQ3SY
   ypSgtWj6YGdunjCTQol1tvHO1ZaruikqbWSYNIjeVl86dMlra40RzNZKO
   PjnRmV+D82ld1MoaLngqifNakI1Iv+6diRlobg7LKvcRt5f6hcgdpJ4mr
   w==;
X-IronPort-AV: E=Sophos;i="6.01,174,1684771200"; 
   d="scan'208";a="346340822"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2023 18:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWg84o+KS/6vMJdBuffBQ+i5vKskg+sYaudVKAJacb7X0J2WJA6fUHS7pD87pXFHeGRW2G56Fx8kKd3Di+Jb8QWw7OQHgM2s8Ag888EwLuk60TpuVs0hfxpJJ5QreKjtDJfzav3Yhs55QFL54F6zcGa5LCBqrnlThI+mnh3kIEU2RsTSfnuM4k64gMHpolM4WjDZ4DJon/qqdJKPr/SL9CHM9cFZnPA3unoNQYpzzaD95rcgzDx2AykADiQALKvsV8PXKfs7XkLOIHgkxDaN+d/78Y62QOFaRY/eo9++pAL0nvRY+7s3m4Inx0/StLFJRGbNOPfi6JAXuTS/orq37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/0TW9UKpZiJitW4+yHSOf3HOPjnZFnYt50+I02kYzI=;
 b=KQ66bfy5niANjsZ3S+iUkP1EH2R0eqDuSw97xzJfYaMZeReLJ1qBViEjtHbHTqhDBrXvP3kEi6FVC+03glUySj83mJzMk6DWPSeCmULtbF1zHUFZgZROJ7cfqCBz9B4zOWnrKOl2rn7BQzDlsUe/BdyJ3F9OvulJWBVvzsD7UqZM51YzOnWEc6vcgkx4+3SvNQMMdQ8Hsq8F9beYNNiiogPhbT6TT01zACf/maNL6zlgIggubjm8X9leNeo9VgRT1pLMLkPOJl7to4tdcg3f9X5S5H2uVGER1nH7wKo6RhMds9j9PpCiQouFNVc+WP75Rorks4PTwerWyHZrPpYhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/0TW9UKpZiJitW4+yHSOf3HOPjnZFnYt50+I02kYzI=;
 b=ClTeXtE09wqpu0pwqxk6DH444Uhb4AsI1EIQVBSKID5YHNYeI3/z8NdNVXig5S8kVwLdwymPnERNhxd4vf2jTvBhWL84/94+GfIY9zsax1j7Emo5JtP3lRCuKh2hO+HusAi6zWVRU376eIyyviBd4Q29omvsIAwaygbtky4Wes0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7181.namprd04.prod.outlook.com (2603:10b6:a03:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 10:15:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 10:15:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
Thread-Topic: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
Thread-Index: AQHZz0iVqEBem18v+0mreRdiG3rF4K/rJGCA
Date:   Tue, 15 Aug 2023 10:15:53 +0000
Message-ID: <431afc8c-683f-4767-b386-7527123084cc@wdc.com>
References: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
In-Reply-To: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7181:EE_
x-ms-office365-filtering-correlation-id: 8e2f3d4c-c718-482e-4251-08db9d789bdf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aj9n3y1EX37fBnQA/Hkdk3mlRSbTnGYi+GkUmO4xTwY2dzbXPKtl/SWyI4BreaW1Nh2s6qzOARmlNroKAuTFDZ38M6suc4OOEysrLyGBlgWlSaKQA51slYvf/SHCactXK8aoUB712zseR3AORjJWx/vy0ghereL8o0jESnqoqEcgRWcZljRO8XJjrdVcaUD5ipoiFEvxJkOHDW2rpr5aSzNKXa43MvHshyV5dE3kTVPsoF3wwt5PcaMUNSUhLVhIawLHRy1t/9VFAUVueeZVNhm8ifUUB7tVuLbvk4k1qtLEHmnPhEMmvWZeXsWxOMNltCKXDqZRTZFPJfVBpNFa0I/NAfd8lGMvfGX29clGThcyWg9Iu3xJMDfWE2dinSYcyJwQoixVCzI0ikQyxQmay5/lsZcqkdTPZIz0HK/Hj6WhUtSVuhAZCxAVagx3kzLVCoONlBXmS6U8bR51d7fr1dx3aViWZ71PbtbMf1rMGMS15tT/gQfNdEgQ8noDyvPbBiRtLVku5IazfyI0J6bgM5OzvsDu1YiL00Q9ZKn3BiduxgWhM3LMj6zKCQx1fz6edgV2wQf5Zi9XLZpaD9dmMBr7zfnjN6dYBLTDE6pa0tWqC0Ubp1CxYV2JUg3O/WRMt7JljEywGl/KqsRcm1Yad7lr+gaMavy6MvOiIFkTx5g8/kqCcxbvg6AG+Ba8Ggpq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(186006)(1800799006)(451199021)(66946007)(122000001)(478600001)(82960400001)(8676002)(71200400001)(8936002)(316002)(76116006)(66476007)(110136005)(41300700001)(64756008)(38070700005)(66556008)(38100700002)(91956017)(66446008)(53546011)(6506007)(6486002)(6512007)(2616005)(4744005)(86362001)(2906002)(5660300002)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0hObXdMM1lHamxKZ2EyaG1SVGppZFFDNUt4T21kcytDWFlocUhmdGpPdFNW?=
 =?utf-8?B?SW5CZTBOd3IzRHdTenhCbXZFYjA5bHdyZGgyWnlYZWhod0hTV0hJVDdlNnA1?=
 =?utf-8?B?QmtUT0ZZakpJU0s3a3Bqdk44eFpEcTJnMEUxbDZ6bXF3eUNCZ3paT05DS3cr?=
 =?utf-8?B?QWluT2VYQW5ITHVZOFBHZnBsNEVCUU1ucGlGdUc0a2JneERPRzlRMUtNdk5r?=
 =?utf-8?B?VUJjS3Q1bEdBc01BaTh1OVRZZytnQmRQT0lXNHk1RmxqRTcxRzVjNjlUYjE4?=
 =?utf-8?B?bGtsV1h3UEVQaGQyd2l6Z0JyS1lzeWpRK1pvU054SGZGeVBKZWcvL3ZlUlV6?=
 =?utf-8?B?WmVLc0kwSXpQZk1zaUpGVnR0YzQ3SHdrNTMrT0I1SVZrZHRPNjZaYlg0QTNM?=
 =?utf-8?B?ZmxyQ1R3TkdnZVVac3Q1aVloMGRrYzByRUljWWpCRXIxdW91d0FBb3lGZ3Mv?=
 =?utf-8?B?R3RYaEtyMlRaRjNZYStObUZvaHVDdVlvTjdlWHhlV0l3L3M2dE5zcXc0bVo4?=
 =?utf-8?B?angrTEVjZmcvdlkrZElhUWIzdEFkTlJSVkE5ZDJORVZOVkdXajZONXhRdFR0?=
 =?utf-8?B?bW9IcDNjWkU2NnpJU2NxOUtySXMvaWVQYVRQVEVPK3JlTSt4dUNkUTVUSHZr?=
 =?utf-8?B?dk5QUmhDVFpRNTVUZll6MWFiVi8wRW1KTGp1bXVMN2FNbzBOTWlOTE0ybisx?=
 =?utf-8?B?QkhiUEw4ekNxTlFOUmFJZUlDcTRQaGFieWxjUEhWOCt2Sk5STGNlVWlNeXQ2?=
 =?utf-8?B?N0Q5ZGhFazg2VlRlUTFUOTFXaityU3k2a2JWcnM3NTgycjBlQnhwenlORTk0?=
 =?utf-8?B?dVhHNGN1MXZwL1hiS0tuVzBWMEdSTW1BTVFMeThUYmx1V2UzR2VLWCsvM2dV?=
 =?utf-8?B?RWlZTUwwMkFDMElVS0J3Y2h2ODM2T0NYRkcya2tzODJUb1NCR2tIVDA2NGZR?=
 =?utf-8?B?c0p5aTZXQnJ1b0dCSXV6TnlsUXM4eTZuUDFnOGpkWjNzS0dFV2g0VHhISjUx?=
 =?utf-8?B?eXU2Nm9sK0ZxdXFnU1ZERjNtaFlhTzFJeTdSMFlpQXRub0F3d2FQYm0vZGJN?=
 =?utf-8?B?L05EY1hsUnlzUGJDa005VDRxZGtVajdYYjhhUUZMMWVtR002Ymx1TmJ0dzc4?=
 =?utf-8?B?QzhjK1BHMzFuMzA2MjFwck9rK2I1ODhLZlh2dWVxdUVLeXhwcDduNUE4dmc3?=
 =?utf-8?B?cFhieCsxbytyVjdSZlFhcGRLLzNoVVRwRW5RZDJwRWVvRDRLYlFWZExlUXJZ?=
 =?utf-8?B?RDRWS3lFc09wd25xREJPWU95QWxETlFpVXNBOC8xS29DNkxuRUI4YjJnNEVG?=
 =?utf-8?B?NFNxNE1BNEtNVDZWYzB6WFJNZGVoWnNPUnkxTEZwWE43bVFhaWhGdlRQMURT?=
 =?utf-8?B?dUtNT3JycDJqZTJWZGhTVkx2dUxpLzQ3WnVHTXNWYVFUTUQ2V0hCM29kRmcv?=
 =?utf-8?B?RHJ0TUtpSGsxMEdVcDlURU43ZDhnaXNpS0RpSUhKZGpOZENPK2MyeVlZaGlm?=
 =?utf-8?B?eWhLamkvMmJDMDhtYW5nb0JlVjZRaUtreDBWZ1M1WlhSVjBleWo3ek0rbUE5?=
 =?utf-8?B?dUhpVW56aTlVckpabExKSHpjcVhUMjlTTkVUdnA5SDdNdnRoUzZYUEZTc2tB?=
 =?utf-8?B?NTBVRFdJYm5DdVB4ZnBQSW41UUpvc21kNXZTSTZoTEJkREhTZHVjYk12NDls?=
 =?utf-8?B?dGsyR3kyak4vWS9RaS9rYzIzNld1WC9HbjlqU3M5M1FKWWhOZ3ZiVHRrWThR?=
 =?utf-8?B?MU9POExUZnkxZ2ptc2x4bXlEakJRUjB6MVhLU0YrOHVkZm8yZGpYQzczd0dP?=
 =?utf-8?B?OUlyS2RzRzk2MzBKemNla3dWOHdYeTgwczZGdHFpcmg0VXk2RHBUdGVKVFEv?=
 =?utf-8?B?ZDlTeVFBODd6TDhzdnhSNStNKzlNYXhlRUt4N05tMUtJdCtzZWRQWmRDeHJX?=
 =?utf-8?B?TFBSVkMreE5CNFRZRUl6MHVaSGtKTlNHRjlyTjJoUDJHQjY4M213TC9vRUdn?=
 =?utf-8?B?M1hSN3pGUFZWdDVtL3ZwZDJ2Nm1ZeFJZcXhER0dRL3Y1SVlUUEY3M1d0UHJI?=
 =?utf-8?B?dlkrYks5VHRyVnp1UTA3aGhaWnNpZytVWFUyNzAyWDk5SGpuUEUreTlIYUN3?=
 =?utf-8?B?ZzBEakRDZHYvL3VZUTdrSHZhNllaWlpSVklQd0lNYVp3dEJjL2krMmRra3FJ?=
 =?utf-8?B?c2lCTU4zV1Fzbk56alhaeC96UUdZNE9kVzdQU0NnalpSeUg4bTcraVZqbU0z?=
 =?utf-8?B?Q0t5aFM2eTAzR0wwQ3dRaVZDK0R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBADA789D9719C40A4816F4B6687EDD5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KFqw4/ezTPzvIjSgzrn45ZwiQ9rRn4xhu8BOPWoQypWGKZRRGVw0CQfQorO5ESahZK7X+a3gpwVx8EsnGo56rnaH38Jnzlnrp3aEJNU2JEx6A3quPkF+r3JHupMfRLm8yVYkSzh91c1T1tWUgNW4hbpzJ5LASGjtcoT3PQLMuXDaTQ5dnMdNC4yuMMpWAwVO8mOringUHiQLdAYlbXqBgFHsT4tsgd61AyNLS7UuW+w2WkJUGZd2bY9ec39GDO3f6bxo4cwJDX3IyysRPqqSEsQnfl8EZVvNzabTxF6+Zy7QZsA8lMsL+BdgBfSoCILYJGGtFfFJuouqHet0l8HuroFLQkznALYmRK5a6clyYNvUY9PWstZT3OsjSbEKXG1hCVMERgvul3/vnZ7JXUXu5nENdZe7wfmfhA1phD6ga64inwsgbn9cZUAid2NAvgeaLG2pPNnq+7yWLpl6pzm1Fn/OAWf7x1WWJN1k5kfqgiLZBQjGe8cSg3s8Ge7dgzSd3oUhUU0jP3uaUEuyVW0JbzzVNZ6Yfvu8JevMjp9qe/MnqXYcwBMn3o7ziQbibCCYvbx7Q+2uhHrFun7rwIberIkPSrh0XdmlgjvJqhz579pS4zotUfQDUpmp5JH34+5vlu1/A3Bvm+vWc7hnftsG7CIgU1mxN6G8lXEN2ssKQDcRGgY5i9eT6pLiyPXtTF5Bv5WALTjdqNGSl+tAi4Dcin/6saT91laCnFLsh0ZtzDgUyBxOtqalVApOHvLU0SW0zIkJKBwKuMBAsZuEXwBa2BSutgA4CtwPM5uhxXso4DH7SC8YsKCNL4qAPz1UJoqP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2f3d4c-c718-482e-4251-08db9d789bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 10:15:53.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y64jjLMreccVUgJSJxqFNcWQzdS2IisdJ0PX84a0cvrc3DGe031venCBx9j3WYWtLp0w06Ucoiy9/VUKWJqvWzIA1dtiog0X8MAjN5Z8ZNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7181
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMDguMjMgMDk6MTcsIFF1IFdlbnJ1byB3cm90ZToNCj4gKw0KPiArCQkvKiBObyBtb3Jl
IGV4dGVudCBpdGVtLiBhbGwgZG9uZS4gKi8NCj4gKwkJaWYgKHNjdHgtPmZvdW5kX25leHQgPj0g
YmctPnN0YXJ0ICsgYmctPmxlbmd0aCkgew0KPiArCQkJc2N0eC0+c3RhdC5sYXN0X3BoeXNpY2Fs
ID0gb3JpZ19waHlzaWNhbCArDQo+ICsJCQkJYmctPmxlbmd0aCAvIChtYXAtPm51bV9zdHJpcGVz
IC8gbWFwLT5zdWJfc3RyaXBlcyk7DQo+ICsJCQlyZXR1cm4gMDsNCj4gKwkJfQ0KDQpiZy0+bGVu
Z3RoIGlzIGEgdTY0IHNvIHlvdSdsbCBuZWVkIGRpdl91NjQoKSBoZXJlIGFzIHdlbGwuDQoNCg==
