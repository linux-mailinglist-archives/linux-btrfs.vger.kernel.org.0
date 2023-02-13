Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06005694E4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBMRox (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 12:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMRow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 12:44:52 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC61CF60
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 09:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676310287; x=1707846287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E0PGxmrN48nHPXvs4SeyzKG06euN00QNar0rBjXATtw=;
  b=FjicrEFzdy82d34ndJiI+wx3w8P3ZYkkyi/SW2euIeDwip/cclUzI6rY
   ZZ2AhnxQl+cSiKbdvZofAGC7dwhy7ce5kH6eF70FpwjSl69aomxrXmWUO
   Pws1Z2VpTo3grz3q10vPdjMWKCUE1n1+kLH80rUjyWrHM2tLMIE0p1V58
   QNRmU0Fg/PleuJ4yGexXVgU3y7WQc/SuBFa+O0TGL2glvubzrHt6LPz2E
   Av7Xst7YA+BulM+xFxLI0km1E0ijMemTIx2ekIuyo3MLU4opaM5SHKije
   OKEu4yuDgdeiaasvL9RZejSGTC50/ezjfsBn2p/DWmPVcvf4oPrZU04vl
   g==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="228168756"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 01:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKxKxC18lub4QFmij6D+UVf3Yf2K/o+azhJeyt5I6bcRzwnpQ3NoI9A1aiPiQfvNvC/5EySfPKZ1l3soofvJrTB2GKK0T9tWB/25P5GG1TBUuQKxt7zEeuQsS0Lx6RfxSFraPaH7ceUsGa00G8wkNPQSgIMm85JbrKAz/pYY3ut5UrZDKjMnjerT0/1coLc4IWzG3pf8X4uxmwQMCm3NXUdU2oy4zA4vcDtrkQNIsAao1Rtr98dwF9RXZvlQbL1yz4UpL9OzDk2Awrj3QLQjvPDUOqXze1KmLhGbxoFpBTZJaxv0do1pvE0krSE4+AFHpimFrYWY6Jze+XcjXALRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0PGxmrN48nHPXvs4SeyzKG06euN00QNar0rBjXATtw=;
 b=HeGSB+Bs8rsqPRlmxTUWZuBddnw2E2w/7maldGfn56/ue6nV/VQlAY1eWeqo19Z/MR86PGqWrgJNfL2YScZ7A+RWFQfWmmWHX7SHNEaeWrRfpnyW+5QfzrjG4xXt3Om7xzQAGaC/TjbYsYDmmhJxK/sJB+fODk8Z0rGCEIlS8/H3SzLAwMv/RLPZrQOg9rKlzEEa91vJJuDR5UNks4z4sBFN7HsKAbgASMjTUrSI1Pwit06VbDWVh2S/h7Xqp3hJRb98CJfg6MKyyRInsMEXhDxv69fyzRn+40pn+D82AsMTNhHdObXM0zEi58ASMucdM2v4qRkH9XvBofADt1I20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0PGxmrN48nHPXvs4SeyzKG06euN00QNar0rBjXATtw=;
 b=xeRtQkL4xHhglHiB1iNNo7quGorTsyZLW94SIwvd78b58xkesNf45CMkFUwhZeTyP8JbjbKSpXqzCImQxX/gzqAU5zAbhQ9j6/H3VKyn70R4i5hqiyi1FomdRIDaX7pfIxcl23yFkK0RpZLZ8iU4lEFK2e9Sk5AM9b0Q1XD6VNQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB3823.namprd04.prod.outlook.com (2603:10b6:805:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 17:44:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 17:44:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Phillip Susi <phill@thesusis.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Topic: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Index: AQHZO6w01UFWKaz32kSJ4ybjKHGu4q7GxvEAgAEZcYCABTyTgIAAEWCA
Date:   Mon, 13 Feb 2023 17:44:38 +0000
Message-ID: <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
 <873579y0kr.fsf@vps.thesusis.net>
In-Reply-To: <873579y0kr.fsf@vps.thesusis.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB3823:EE_
x-ms-office365-filtering-correlation-id: 9d915982-58fc-406d-422c-08db0de9fa72
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ENFJLYmgASjM71T6NzYEMZpywCQPjilr5IKygrLkrrmqajzDovoU8GFSKwogVs9sa7UFcuHQz5zhM9Wumg0Hylk2v9tpbKj1HXsEUaMOwlAT4tnxGQMGfkUv8oDcezzoE18ZqxFhL/Cw08LWuTJXqhWnhKyo05hJzumzhhM0H43VkPSi56BbIKZIhQUAiytaaawuOxffLz6i/ay3AuUprvt9zWxm9zxyuk7FDa2S8RjwChSqGN9DYY/fqP8sVNAwBys9vfJ3Vc4uVYKkjABM1dy7H9W/+H3IWvGhQzFxiORVTPD/gz9s++l4oDnHk1gHPjrO0zZd/AH/Zck4cebKKqBAHCfWPiR/25zQ9PG9aM5y59ceohRq9EiWMeQBkcgXF6c7pEil4kL7FqDg6Vzv4uVRa5OWrrD6MjdAanKaHruA6ohNhxtk45zQV8w0lCkyGIGDiodEFUXP+lsd0iiKxp3sLcQVaRWLLa3jU1Mhus6FaKLp2WWCklkYyjniHYfhkwRXZED0/nt29znl29Rkfsbp/hL+yRl8F1l9klb6D/TR68wlDzOL/v8YonKF+Hccf3Fvp1xbqmbPljK6SAazR2Vr5b3lZFX3bmsd+ngeJIUuRY2uPU+SWO4uQ04OmuCok3t76ZRfRwWUeXMmwhjsARlsXiReuo7ezhFgG6Ep77hNG0RqVJREThxKcAfc+mvEiM0fCaZ7DCDucvcH+FNUYeZNNDhyKbjU6W2xH9liprspNPky0JzX/DM/2LFroglPcs0EVgn8klAlCK2rJ6gxcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199018)(31686004)(2616005)(83380400001)(31696002)(86362001)(2906002)(6486002)(478600001)(71200400001)(6506007)(6512007)(53546011)(186003)(122000001)(38100700002)(82960400001)(38070700005)(8936002)(36756003)(5660300002)(41300700001)(4326008)(6916009)(8676002)(64756008)(66946007)(76116006)(66556008)(91956017)(66476007)(66446008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWd3VDZ2VSt2Y05vQllpZE15TjZZZHlFY3djREZPNFZ2OTVQaER3YzVaaUVR?=
 =?utf-8?B?dHZzcEh4VVcra1UwQVVUdDhKZ0NqdU5hMVVBTTFkMGE3ais4QW56ZHJyc1ZM?=
 =?utf-8?B?RTlnSFhrV3lrYkNMbDAxcE5EYnVpQ1A5Y2tkTC96dUFwVnNrN1ZxZE9UNWpC?=
 =?utf-8?B?UFpxV3lNcVFzOXd6VTlmVnovS2ZLdDFERlBnSDVNN09jWU5iVjVFcFExUjZs?=
 =?utf-8?B?MTJKMGtrZ0NPK1p6TUFwK1ozQnFHNEZpL0FpOWpUa0JoWU9POCsvQytVejJR?=
 =?utf-8?B?WlBhZ04yaktSNVl3RHRDN0o5Z0dVdVJodWpCWWozbDU1WG5Bc1FYRUNIemcx?=
 =?utf-8?B?N3B6RHZZNURPc2JsY2hseGNUMFBlYzdIOVhERTFqUFB1RGpwYUlxOFlSWDRK?=
 =?utf-8?B?bUg2Z0tGc3RvZ0U5aVFkRTFIZEc4dHZPSVNOaXlKK2g4L05QbHk5NnhpbGla?=
 =?utf-8?B?OS8yM3B6YmVIYjZxMzZodGw2dGYwdHlQTVVuQWx3ZjRZeDU3WGVFS2JiM3lH?=
 =?utf-8?B?UzNjejZuMTIzNXJjSFVkRG1uMjVDKy9TU0psa1RSOWx6R3JxaFBITnd2dkxS?=
 =?utf-8?B?ZFppRXNOdjJMMUNsTzZPdjNHZlh4OUZVUVNJWUxSM1M1Ty9ZQnJ3Z1NHNDNI?=
 =?utf-8?B?R05zdkhHMzRIUUg2VnFLb1pNWmgzVUZ5ZDZKVHBTZCtMaGt2TmoyWmVZWGhD?=
 =?utf-8?B?L3g4bkd1R0twVTJEblpiL1cranJrRmFZdFQyZzE4Z1Zqa2VwbTlqV1p3VVRG?=
 =?utf-8?B?UXdWVDluZTZTb3hhaFk2a083MTZXSFRHMTB4c1BRVzB2SGxCc1lLWUlnQnRo?=
 =?utf-8?B?TGZHYmN3aXlqOWJHS003cHNwNWMxZTZXNzFMUzJzdnBvVWVVSnVVdG5la0E5?=
 =?utf-8?B?cTlzb01wb09helErWkNNWDNlRVVDdlZtS1dFRDM2Z1hPSUZwUk9jMUN4UGlY?=
 =?utf-8?B?UkZjOHN2MUlwSE1uN2swVDE0Y0RkT0txcEFFR1ZaRWR2MUxZT3FvRC9FMExK?=
 =?utf-8?B?MmhWdVdHSU13ZE9iSlU1ZlVubGNSRmZlaENNRDdYN2xRNlRySjRyMDZxRUtR?=
 =?utf-8?B?WStQdFc5NGdXSlFLRVJ6YVp6RHZMTmxoVVVzV3c1MTI3MExvQTVLL2JTdExS?=
 =?utf-8?B?SGtqNUZXNTRUZDVVbWQrdlJVbXAzNkRnOU1PYUh3MEEzV29vV0ovQnhlOE44?=
 =?utf-8?B?VG1WcERLSkJVOFEzQktVbXFxeXNMUExGWTkwNDAyMnI3RlZIcCtjOERrcXpt?=
 =?utf-8?B?QUpUMGw5SjMyandqVjRsQ3FvRkVKeFZWd3VCbWxBWDRLOWkzbE9Ock5TK2F3?=
 =?utf-8?B?QXBZYjNRaUYxNmxVbi8zTExjUzZhMFZQa3JWc2dqUE13Z3lydjlGU2o5QXFW?=
 =?utf-8?B?TWk0bVJTNWd6Z3p5M2d0K2wzbytOWm1VV1NYYUFGRWZRUzZ6VkQwd2lkQWJv?=
 =?utf-8?B?QXFiRTFUTnRGYVhYeUhHcldqUGNVVG80ME93NUFUYlVGdzFsWTJFU1g0bUdF?=
 =?utf-8?B?Z3hBcmV0dmUrVmMrZ1REVXNRcVZTR3RBaEdkdG9tVC9hTU4vL2xETW9pZnBP?=
 =?utf-8?B?MHoxanArZDFaY25PZzZwR243UHlGTnArYkU4MHZCZE1WSEcvZlVsT3FHQ3Az?=
 =?utf-8?B?a01qZ09HZitPUklZcVVVSzdmMjV1SVg3alpEZG82eHJaT2xidEN4SXJkTk8x?=
 =?utf-8?B?RXNpL3dya052dkNwV25RNVQwTTRSM0RhSklhZHc2M2VNYmN5NUNrT0duVDgx?=
 =?utf-8?B?cVlkdGxpNG9oVC9UZU1xemZ1UDVsYXFJSE9Ca0dSSE9qLy9DOGkvcmF1R0R1?=
 =?utf-8?B?RkwvNXl0V0xYMitaZnc3WFFtdjlZS0RuL0xSUkxDSEpjNVlUOTk0d1VmajA5?=
 =?utf-8?B?TlkrR0o4azF3TUtVWFpZSlBTb0FFcndtd2dxK2lCbC9aNCszWkxnMlkyREdh?=
 =?utf-8?B?Q1V6V1l0aHJ6Y0ZhcWNmVXhUMWdFejgvdVE2cWw1eXFJUHlteWxmaHBkeE1J?=
 =?utf-8?B?Si9ETVZYc3BodXB2eFQvQm5KRHplR01xNXZUWHViK2F6em91VVdYZ01QR3JW?=
 =?utf-8?B?eHZRaXhRb3QreHZZbDZSWXZUZnlVODQxTXpmVTBxU2Qzd2tOdWVSL2J2UjQ1?=
 =?utf-8?B?bS9KK3czU2huVFd2dDk5MmNqYTBESFZFTXY5ZDgySkh1K3I4Y3I4Tk8zbXA1?=
 =?utf-8?B?ZlBuRlhoeFNwSGpXQ0dCSldDbFl0MnA5U0IyZ3pZL2o1TTNtYXNtcG1mSHRU?=
 =?utf-8?Q?PEJdD6hgjroCAGHVSbqswFpqBXzS2jCJZYhRbw2TEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C881BC6FB534E14CB060238628A3F8D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tAckcLQiXsZX36/vvY/9zi50Em074yYYiE/UW+nncF3toU5+0Axwsk+H/yKwzktDEMq/SKUR4Wkko7J08DZnVTZOVqswCQihvkJ5mZFVHNRS42gpgNrta9+PXEjU5WgMI5TpWtPtWPYzM6rrpZskfc2nU5zyMaQgj0UKgnIxdxOAtPAGKahGmfOzVsTpcROQnCeShTnyCUG63mD7+ytfYq2nZsC6Aninl4WHK4objAEV/ZYT1sN+9vZ+AteDe5KFwDz/p8xgSFHtbEjxwQM5dQO1KF/AG4iSX8CrUbH934z2HOVQ1TkIPbMmIE+mcd+QY7jJmT2duSVhA1obwSTUgTrTWQXcOKuHTK3xlQoMIk/XWJ8BUX7LWLV9l22JtxbwTLIbsppIcg85KSqAkP5kjZ9CqWxp48+YO0s0JiZlynedSK+0PGF1J0UJ2YLWJn8oUCppk/DlbCUjOJuIgB3SBoWUSZSkpvjUPHpgCLp/ey+xiWqlQ8QR2ctDBcGowmZOtdmmuCzZWLfLkHXt21HZj7lRd+vnLm6dWTC2CbuD9fvTVEq7Al2abu/1qUV0m2kkO1lSFV8GeOlAG0pQ4CP5ZhBuhQhJDsKXtZlRwC/AEsKO8EF0AWew2rk9hd17eA/FUd2TdmtXkqNgPSCcHLwteoi4oiNYz5LVSzoeNV4fMqBlQK2Fd491PcZsbxZtNNJ9nqYPOLFeMLTU0HhkInM1JekhApzLnnE3/rcJs70oM6zfIs5wY3Qu6KCNckZo5Gux0WkZ9jJI5gmkjKwyaBV4+iIm8rw/0yNAPdC6lITQTK5VrX1hZa/WcBJQykDhcI5i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d915982-58fc-406d-422c-08db0de9fa72
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 17:44:38.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PH07ZpDFQojG28PlY52R+bwOd7NyRKIvcm1U4qgDXU/Ws7bGKRga0O4mYwCksE+fkRHreShAbnTkLowDYGNdpzfxmyJyBQ8nDEZngl+P7as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3823
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMTc6NDcsIFBoaWxsaXAgU3VzaSB3cm90ZToNCj4gDQo+IEpvaGFubmVzIFRo
dW1zaGlybiA8Sm9oYW5uZXMuVGh1bXNoaXJuQHdkYy5jb20+IHdyaXRlczoNCj4gDQo+PiBOby4g
V2l0aCB6b25lZCBkcml2ZXMgd2UncmUgd3JpdGluZyB1c2luZyB0aGUgWm9uZSBBcHBlbmQgY29t
bWFuZCBbMV0uDQo+PiBUaGlzIGhhcyBzZXZlcmFsIGFkdmFudGFnZXMsIG9uZSBiZWluZyB0aGF0
IHlvdSBjYW4gaXNzdWUgSU8gYXQgYSBoaWdoDQo+PiBxdWV1ZSBkZXB0aCBhbmQgZG9uJ3QgbmVl
ZCBhbnkgbG9ja2luZyB0by4gQnV0IGl0IGhhcyBvbmUgZG93bnNpZGUgZm9yDQo+PiB0aGUgUkFJ
RCBhcHBsaWNhdGlvbiwgdGhhdCBpcywgdGhhdCB5b3UgZG9uJ3QgaGF2ZSBhbnkgY29udHJvbCBv
ZiB0aGUgDQo+PiBMQkEgd2hlcmUgdGhlIGRhdGEgbGFuZHMsIG9ubHkgdGhlIHpvbmUuDQo+IA0K
PiBDYW4gdGhleSBiZSByZW9yZGVyZWQgaW4gdGhlIHF1ZXVlPyAgQXMgbG9uZyBhcyB0aGV5IGFy
ZSBpc3N1ZWQgaW4gdGhlDQo+IHNhbWUgb3JkZXIgb24gYm90aCBkcml2ZXMgYW5kIGNhbid0IGdl
dCByZW9yZGVyZWQsIEkgd291bGQgdGhpbmsgdGhhdA0KPiB0aGUgd3JpdGUgcG9pbnRlciBvbiBi
b3RoIGRyaXZlcyB3b3VsZCByZW1haW4gaW4gc3luYy4NCj4gDQoNClRoZXJlIGlzIG5vIGd1YXJh
bnRlZSBmb3IgdGhhdCwgbm8uIFRoZSBibG9jayBsYXllciBjYW4gdGhlb3JldGljYWxseQ0KcmUt
b3JkZXIgYWxsIFdSSVRFcy4gVGhpcyBpcyB3aHkgYnRyZnMgYWxzbyBuZWVkcyB0aGUgbXEtZGVh
ZGxpbmUgSU8gDQpzY2hlZHVsZXIgYXMgbWV0YWRhdGEgaXMgd3JpdHRlbiBhcyBXUklURSB3aXRo
IFFEPTEgKHByb3RlY3RlZCBieSB0aGUNCmJ0cmZzX21ldGFfaW9fbG9jaygpIGluc2lkZSBidHJm
cyBhbmQgdGhlIHpvbmUgd3JpdGUgbG9jayBpbiB0aGUgDQpJTyBzY2hlZHVsZXIuDQoNCkkgdW5m
b3J0dW5hdGVseSBjYW4ndCByZW1lbWJlciB0aGUgZXhhY3QgcmVhc29ucyB3aHkgdGhlIGJsb2Nr
IGxheWVyDQpjYW5ub3QgYmUgbWFkZSBpbiBhIHdheSB0aGF0IGl0IGNhbid0IHJlLW9yZGVyIHRo
ZSBJTy4gSSdkIGhhdmUgdG8gZGVmZXINCnRoYXQgcXVlc3Rpb24gdG8gQ2hyaXN0b3BoLg0K
