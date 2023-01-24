Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9971679351
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jan 2023 09:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjAXIny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 03:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXInx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 03:43:53 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4A32533
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 00:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674549832; x=1706085832;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3RwmexKqyX/dzcsxZbAIElvFIOH1CsyG/8nDqfXhONE=;
  b=LC07i4pqXonuEp5voA1+rd9pFC4ezcvwo0ve9Ad8h3NkDbA9KB4xuUlU
   U6m7+zDXNp3HQsyZz0xl5Is6+xOctonTm9onJmh417YiU6gT2d3W4WQAE
   H2V4P1GScvGimWlDQ8iXHd8BwMCE2K4XtOGe6tC3vTBd6Fw3RGfs65jz2
   psT1XhV92OqpJ8mg9Otm9vPTdUPrv/ctOWttw2priOKaV+D6c/6RMXYjd
   Z6ku5f8Aa+Ce/vmmK6xc6ENU2CtDSWUW/NDjHuPEAcSOIscyH3C63qMyB
   QGENNFoI7vy+4ibgl0gBgxMDcDA2iXKnbBUyWNGgwQcUKBwWfW8g0wXxh
   w==;
X-IronPort-AV: E=Sophos;i="5.97,241,1669046400"; 
   d="scan'208";a="221431041"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 16:43:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVFVxCykeOKiqEfMWE66eMeotzJMHgnSf5kTaqf5fr4gsA2BizaFs431SRJv7PF1uQRKl8tExnFlAaaWvFe0an5l5Bc4N1+jPXUwi7HKqx6hKYTNBgM7EjjoI6q1zTT446yQaR1wenz0YcliQxugo2B15mArWbppTw+Pxfn4q0vD5YowMdYWi0rF5OsKQ0tO0vHdrm+HIuqT51dpatyuny1UVJJ4rIKBvmbnKWLrDkAkVOfu4+jK3C5Gjtge/+/2zDxgM+tqLdqvGF7FFTGTihcdZo+un4x9Fl2uQ6RcVzLoabN8CbLaV/i7tjG3clTZeNmP2tGA+DWBgPBkIwHufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RwmexKqyX/dzcsxZbAIElvFIOH1CsyG/8nDqfXhONE=;
 b=EvzRIZe9wTR5VcnScMMCBYHESKz2f1u0mflbv1fTlRjXl2ijY+o7lI5944yDpe/5xt9/wWYPMxB4UhU3KcaRWZmBGBveQRRAw64TLtLw401fZVIymSvfylwxJL7SFyWV6qVMNpiLt/bTlAmORKkCVHOFeOZ5SE8nPXowSxviCDgvglNYlJv/ZV6UAuRttF00+drRclF38EvEr5v169/wXX9TjgVHCZ4m3nP3YTxJvq+Jna9Acf7aFuyf5z8Lx8wZPk5mIiUEqfX4zoC3tl+RHGYSu4HvJ9YwUBiixLcugPlGWdJJKc+5zzWxnc8zPorofKXJZpvXA2/J0rUgg3lWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RwmexKqyX/dzcsxZbAIElvFIOH1CsyG/8nDqfXhONE=;
 b=KReQqPmvsIyKdS1itbPJ3zSzdrtaBWXK/aLOtmerYtnHwqN/r7U2KAW4jkDRgO4S7SWoFe+Db1KJ34rbU9bQWNtFNimOmIfq58frlJoXFh858U+VZ8QDoyH/+13iJIq/nCZWcEk7qqad1wSzma6+BAbcLudqoZp30ICwrE0NqCc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7855.namprd04.prod.outlook.com (2603:10b6:a03:301::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 08:43:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 08:43:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Thread-Topic: [PATCH] btrfs: separate single stripe optimization into a
 dedicate branch
Thread-Index: AQHZL8n+ZeIG//Bu1USkLvsQZHprCK6tQF6A
Date:   Tue, 24 Jan 2023 08:43:48 +0000
Message-ID: <8cb1628a-bf0f-57c5-551c-21ed3fe5a035@wdc.com>
References: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
In-Reply-To: <4e4d6e0aab34ab40fd0ac69874141bb02a559f10.1674546545.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7855:EE_
x-ms-office365-filtering-correlation-id: 0ac96c5e-5e43-46f0-00c6-08dafde71c9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bE/2Sr7k+xzSGODFNi6jckNOf/YWOmSWXj+63mWWz6HseFb2t3Fuj4pb9QjiUqnLXBG7gxNBmvnNjEl0964btqgc2MWMUbyHqbRY/ROWi8UuzWDwAZnOkhYC1qQShdYoExs8a3+PfxWIU6hkHF5yFXLPLfKd/G7xkmBrfoVu/fU761XiLfs94UEqVMFUmvpY4rp6ZMjcQ9eKaHwCMybkatvvMcVF8xtv68zqOd1hPegO+vh0psBJzkPyk/9w0OfQs5aQ7ZwvLKBe1P40Xp/FpG/GKKluMAeyNoIQI9G+XjF6FESxrmHuuT+oQpmofqEnEv7BK2Be+6oNORFNxRskv8kSBwDDOs/I5gHt5EZRC73Hs5saiNnyGZ/MQVqzbsBWwgt5jTqt7joFhMmREUQAh1v4mLw6mda2MiY7YWQ16BFCz9SSiF8J9NQR8QFi8hkL8bGJqEOzTUuNqdeRzA+IBfZP8bX+PdBC5hNoIY2IoR1LLQf098fIZtI+h15XtmUHiSUqTMX036qVHFti8d5wQyb300qSaxThAJtrjSc1G6Q8SF4R0JRkrITnbS9PvqObhGvpeBYRRNNugwC/3SYmOrjdFPY+tzO/Da78AykhxhVRjx9bCt3xZg+dlNOe8y7yWLxryO6ma5/4H2v7edl6LnOyQU6vxH6JmSKoUG4l0DZCMpt1ELtUumB1E3CQdLt4FQg6ADm0s85gNcLAFuQ7CA3qLKyRJcIrztJKSbPuQaQzDaZfmVKSb2XZphKx0eMz2bH9E+qmmP5ZbNnBRWnJHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(86362001)(31696002)(36756003)(82960400001)(316002)(110136005)(71200400001)(6506007)(6486002)(478600001)(5660300002)(2906002)(66556008)(8676002)(66946007)(76116006)(66476007)(66446008)(64756008)(41300700001)(8936002)(122000001)(91956017)(38100700002)(38070700005)(2616005)(53546011)(6512007)(186003)(83380400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNBV0UrUDBUcitwS3laS28yN244NlFvcC9BSWlqL2ZFWWQwQ28vUWs5NjN2?=
 =?utf-8?B?RU0ya3NoSXFla3I0THo3UmtVczA3RW9XeDRXRk5DRXA0VVliSU0vNU1TQ0F4?=
 =?utf-8?B?dGp3cHBlR1ZiZ0xKN011eFEzRnd4TlkvWkQrUG5qVXhTUXZCOG1pTjhxaU1H?=
 =?utf-8?B?ZUNmVXl4ZmtGQzdxUmFCcGlhRW92Q3d1OGR0TlpnalVmcE1jb0hoMDNtRjFt?=
 =?utf-8?B?MzY1SGtndXdvNWtMcXJlMjZva2xwR2g0dDlzOTcvZHVMM1BZMzE4TERyWHVs?=
 =?utf-8?B?QVEyZHhwMzloZ29BUmJoNWNZZ1lNWkZLUSt3bWpYRVhiVXRGZ09uWHRwUHdj?=
 =?utf-8?B?Z3E5M1FJajB1bXNUcy9xeVlmNG5sbEYyM0xFcHB1ODNkdkhBMnQzUkF3RGpS?=
 =?utf-8?B?MmRoOEVCWk5TTUx6Yk40RkpDa2tYU3g1c2ZrZ0RKcFpuUlF2QWJTWUVJQUM5?=
 =?utf-8?B?Q0J6TXcrVUpUYTQySFJ4bDBLMVVOeXJBODRsODErbFJWeVQ5SmVJdGREK1pa?=
 =?utf-8?B?MURXajMzRFByb2tSdXFBdVJNMERyRmZndUJuTWhsbUtzeUVRWi9uMmE1d0pa?=
 =?utf-8?B?NVNYZjQ1Y3IzdmNKR2xwdDVHeTZvRk1Qd0pUZWhaSWtvaGZzL29KWnJGNDh2?=
 =?utf-8?B?Z0NJWldPS2cxWFNUeUF3d0Jkb0k3eWMxTlZHWGUwOUF0cSsra3NVNzMwRHVD?=
 =?utf-8?B?aDh3UGoxMjhkMnMwRFNIdGtsZXVENU51cGhmd3Bsbmk4QVZVanE0R0dvUlB2?=
 =?utf-8?B?eVN6VDlHQ0V1TmpCbzdjRHBxSVBSOVhWOWRnVnFYY0lWR0VVa21lVm9hcHM0?=
 =?utf-8?B?ZmpaWjJZZ2E3WklJUlUrOWd5ZnN3Vy9ELy9KSzI3aTZYM25KNGZ1VXAvckNo?=
 =?utf-8?B?ZTRpMS8rSFk2SnU1SHF0TkRjNzJJVmFBR250ZUExZW9EdWNWb2FlNnNlR0R2?=
 =?utf-8?B?a1hQWmFocThpWFlja1U4UXBTb1pLZDVHanpzMnRJRW4xU1dHaDR4bDFIWitX?=
 =?utf-8?B?VzRaQ3FJS1l4d0NJTmNYV2gvZVlhUlhhVXgxeXN0RXd5d0N6aFBBK2FEU3pi?=
 =?utf-8?B?U0ZJRmZta2ZPeElrSGtSamdlWGJxSXhpcmpXZVF1Q3RKZ3dMeHRhZFlhTXZ3?=
 =?utf-8?B?MGtsMzVyUFV3eDB3U2tmQUdvcGIwWXBMWVBkU1RpQ0kxZlJNMFp2WE04NGky?=
 =?utf-8?B?dE9lSDdBTVRZcm9nS2YvYm9VZmFIbTk3NkdXRUtvUkE2MXJqb3FCOEFMY0Zw?=
 =?utf-8?B?SGlQak9rRDhuczVjSU9Uc1JsU1BnTTdSYU1JMmlmSFNFdkJ3ZFoyYk16YSty?=
 =?utf-8?B?SmEyVFg5Z1hvYTJ3NUJUdm9Xcm1BemY2RlZtSStDcGtuYWZtN0luVEh0SEx4?=
 =?utf-8?B?VlJzVXNFNjZOZkd4d1BCcjBaSDNRQ0dZOXZFUlBMZS80bEhGVGp2c2RPbWU2?=
 =?utf-8?B?TTdyV3pkMjRJMHlISUdTMXBZdXNXOENTeXF5c3JkMW1YS0JqTWhQbXYxM1pz?=
 =?utf-8?B?NE5HSm5KTUt5aGZLYjd2MlZBSit1c0ZDVzlYUU1YTnIrSTlSc3BzTXR2Y1Zn?=
 =?utf-8?B?SzJwMWFIaFJDRVh4N0lMTjlzaEpBc1FIRW91N1dONnJVeDl6UEsrcEhEdzcv?=
 =?utf-8?B?K1VjSlhGL0JSV3FiVDdBc2x3ajlMUllzeW1BMmg4QmdndGxZaEhad1kzM3E4?=
 =?utf-8?B?bTBxYk9FT1RNTUNGUlIxZ2xsQ1NmYTdvMVRuZ1o1Y1BUK1k0b2FCdklxTXZa?=
 =?utf-8?B?WmZhUjE0NUtPNGIwUHJFSExoZVZqRE8rV2gyNXZKTnFaV1VTcld1UHdTc0ND?=
 =?utf-8?B?U3pQYXhKQUJhdFZlU0pBOWc1SXdXbHhPbkdtYVdzOE1YNVZ4M1RxcnJqeWdl?=
 =?utf-8?B?c25NMzZxVnRaWjZEZFZ1TkxmYnVDU21hMlVWbnowaU1IUXpyNDk2b3NqUnhk?=
 =?utf-8?B?Uk1DTlVZZU5qRjlLSGhnZDZHSWpwMTM0LzluWGxwNk9lOXpiVkdSaDZTc09R?=
 =?utf-8?B?Y1lFOGEraVEzR3AxL1M1cUJUQXllcHB1Q0xPdGhqNFlMR0dQdlBPcjdZdVFG?=
 =?utf-8?B?NVZHNnNFT2QrWE9mWS9tVVduZXp5K29hUERWUzk0MHZyRkdqeEpOV0JxZlRm?=
 =?utf-8?B?a1A4N2k1K0ZHY2FNOVhiSUtuUzROZGx6b1doU0VFMjBnTXM2RTJUWTJLa2kz?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60BEF6765B29D47893767AAAA572BDC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7E84eq4aGWheLAE9L/bWmye7QeEbnzWt+cr6pNl0xNwbSxpc595VmMG8LTM5iR2vNe+DKWn4n2eENpdQsvtzGJzLVmReoZ/YzkWCN2GzAy6gRA2IPqTV1jwHhSXraFlQs0KsX3u+Uc5EtFpPKpY5TvNRPtUHm81PMtCZ16ta4N+y70M2Z7vkFO27PQef5Vej7FbM3fDFNwTMy03cqHP8D1Xobd7ixYZreuIBS5Mkhy/4sCd/D0eOECw61A3+/roKiIRmiK1JaLlfF21EWR0180fxW3DQZrZRIg3EAgRbsj4CTOx4uTeWRNVbs1V3tYnemI62Ls6ZwPUPyCcFKhbMc3FhujWE+oqIyBOr+LnKz+3MldLMw0yTp37Q0r27ieFNL37//Ee7UXXC9rrkzWbW1gLyel7dlT1tOuJAApUeNnMx+pm565xPJHC44EAfouW6aWxwHXwz6O6Rs1cWu+4dTJXrr43z6BNZYjSIlxLU3pQy+ugEftda0GnJwaRErud9tqqFYoi3YcQxtnDcf6D78zhZ/n3ZCxsBfRBjVDp4jLooqbJLzKFK/kJZMYHvatknog5Zf6PozcnbPEaV+f2HEl4wH5qTVWV50CIsisqfCqlltW7EgRkEFvkxB6d6Lm7z3Nw5yPDLsjjhhkqmCz30/4sHcsTukZ2M4rMxyvMxVkOHkS+dctZ8xwz2ktUxtUZs+bdnCeTjFx89uymrT5n2ApRR5Tmyu5Zs8tRJgwsLZlscWOu4AkYAN8H+80hlu9ZgV2k5mGDEyrhiGMDkaqRWw/B+iImmhWxlEu2JAqbc6vv6Zc4KzLrbSClffq0cSX4N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac96c5e-5e43-46f0-00c6-08dafde71c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 08:43:48.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIU7Z0grSsrhLKrVo+9bws7s/Yrv9KbFH+TBoKVQGC+e5NXiTF/H/KWU+n3ygNoTTbi1ic8FnM5l57SjrvprXmaYJRJAWq4LajhRrYa191w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7855
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDEuMjMgMDk6MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4gK3N0YXRpYyBpbnQgcGF0Y2hf
c2luZ2xlX3N0cmlwZV9mb3JfcmVwbGFjZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywN
Cj4gKwkJCQkJICAgc3RydWN0IGJ0cmZzX2lvX3N0cmlwZSAqc21hcCwNCj4gKwkJCQkJICAgaW50
IG1pcnJvcl9udW0sIGludCBuY29waWVzKQ0KPiArew0KPiArCWlmIChtaXJyb3JfbnVtID4gbmNv
cGllcykgew0KPiArCQlpZiAobWlycm9yX251bSA9PSBuY29waWVzICsgMSAmJg0KPiArCQkgICAg
YnRyZnNfZGV2X3JlcGxhY2VfaXNfb25nb2luZygmZnNfaW5mby0+ZGV2X3JlcGxhY2UpICYmDQo+
ICsJCSAgICBmc19pbmZvLT5kZXZfcmVwbGFjZS5zcmNkZXYgPT0gc21hcC0+ZGV2ICYmDQo+ICsJ
CSAgICBmc19pbmZvLT5kZXZfcmVwbGFjZS50Z3RkZXYpDQo+ICsJCQlzbWFwLT5kZXYgPSBmc19p
bmZvLT5kZXZfcmVwbGFjZS50Z3RkZXY7DQo+ICsJCWVsc2UNCj4gKwkJCXJldHVybiAtRUlOVkFM
Ow0KPiArCX0NCg0KSWYgeW91J2QgcmV2ZXJzZSB0aGUgYWJvdmUgaWYgc3RhdGVtZW50IGFuZCBy
ZXR1cm4gZWFybHksIHlvdSBjYW4gc2F2ZSBvbmUNCmxldmVsIG9mIGluZGVudGF0aW9uLg0KDQo+
ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbWFwX3NpbmdsZV9zdHJpcGUo
c3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sDQo+ICsJCQkgICAgIHN0cnVjdCBidHJmc19p
b19zdHJpcGUgKnNtYXAsDQo+ICsJCQkgICAgIHN0cnVjdCBtYXBfbG9va3VwICptYXAsDQo+ICsJ
CQkgICAgIHN0cnVjdCBidHJmc19pb19nZW9tZXRyeSAqZ2VvbSwNCj4gKwkJCSAgICAgZW51bSBi
dHJmc19tYXBfb3Agb3AsDQo+ICsJCQkgICAgIGludCBtaXJyb3JfbnVtKQ0KPiArew0KPiArCWVu
dW0gYnRyZnNfcmFpZF90eXBlcyByYWlkX2luZGV4ID0gYnRyZnNfYmdfZmxhZ3NfdG9fcmFpZF9p
bmRleChtYXAtPnR5cGUpOw0KPiArCWJvb2wgaXNfcmFpZDU2ID0gbWFwLT50eXBlICYgQlRSRlNf
QkxPQ0tfR1JPVVBfUkFJRDU2X01BU0s7DQo+ICsJaW50IGRhdGFfc3RyaXBlcyA9IG5yX2RhdGFf
c3RyaXBlcyhtYXApOw0KPiArCWludCBuY29waWVzOw0KPiArCWludCB0YXJnZXQ7DQo+ICsJaW50
IHJvdDsNCj4gKw0KPiArCS8qIEZvciBub24tUkFJRDU2LCBqdXN0IHNlbGVjdCB0aGUgdGFyZ2V0
IHN0cmlwZS4qLw0KDQpXaHkgbm90IGhhdmUgYSBSQUlENTYgZnVuY3Rpb24gYW5kIGEgbm9uLVJB
SUQ1NiB2ZXJzaW9uPw0KDQo+ICsJaWYgKCFpc19yYWlkNTYpIHsNCj4gKwkJLyoNCj4gKwkJICog
QWZ0ZXIgQlRSRlNfU1RSSVBFX0xFTiBieXRlcywgd2UgbmVlZCB0byBmb3J3YXJkIEBzdHJpcGVf
aW5jDQo+ICsJCSAqIHN0cmlwZXMsIGFuZCBpbmNyZWFzZSBwaHlzaWNhbCBieSAoc3RyaXBlX25y
IC8gQHN0cmlwZV9kaXYpICoNCj4gKwkJICogQlRSRlNfU1RSSVBFX0xFTiBieXRlcy4NCj4gKwkJ
ICoNCj4gKwkJICogVGhlIGRlZmF1bHQgdmFsdWVzIHdvdWxkIGhhbmRsZSBTSU5HTEUvRFVQL1JB
SUQxKi4NCj4gKwkJICogT25seSBuZWVkIHRvIHVwZGF0ZSB0byBoYW5kbGUgUkFJRDAgYW5kIFJB
SUQxMC4NCj4gKwkJICovDQoNCg==
