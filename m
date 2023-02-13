Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349FF6943E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBMLKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBMLKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:30 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281EE3B4
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676286628; x=1707822628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=A2gscN2YNrNISWr2ptLoMBDkuKmsJoaq/XEVHQ7DZWo=;
  b=Ywh5Vz0M1pxC7cfkJ6PVOxqriAWTKK44STkYFd6b1NhC7LjazaDYY4hY
   sbEed3FvLtB9RY6x7GAVWQzkDFuN6dRZAWMnyDwuXEvuR1odeKjXgzpoD
   /Zjms5+VbG7/A7CxgC2Lw9WfT7LMhkRe740Wk8vrWJ2/Mc7M5qvmA3YOL
   pwbvA3La8ItifCa1guFlo/Ra3baw0zVkTsC1HTLBWbrCWMWQeIiV2NSo4
   8eldDM7i6VdjR5qabvFRj6StCNfZ65p8D3cnKasnNFmJuHHN1TwFwuKtv
   91cPHUHyNvzp+T5S6ecmcu0Hp3zk3x6jTgaoD9eJ52OiiOeU2RNjYmWvj
   w==;
X-IronPort-AV: E=Sophos;i="5.97,293,1669046400"; 
   d="scan'208";a="222967396"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 19:10:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gklhjIm6TQYDr8lEvl6nJcWy90EF8d7Pj7qYxSb3EtQH2ytO0ZvJ77rl8WrP7yEh027LgQW0EDci0SL9NrLiD/rCcvbNG/AehIGpGVPv+8ST7KCeotiIkzbcNzrvM+KLcu17hc6jeNfGm6kIJkAOB/iW/FgHdUL4100MBejq/JlbOI7W/NsbZ8nRzLy5mG8QBuSXzei2KJ412JNF8p4w2HBK337d/O7yYJcnuI6tC0aMJmWpo2FUbefzqGCF4sYPQtnPNPar1O/KwWaMJX/PHzZaYv1YTawr3bVpeTA8N9TKdnBSth3HO160sOIa/5F4DNtBmnxDcSPj5F+W8fkUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2gscN2YNrNISWr2ptLoMBDkuKmsJoaq/XEVHQ7DZWo=;
 b=MEksC1s/omkyr0b4NHpV80h52Y0iQ/Pq7buThZFZp9xtt8MzItBkzMDObNgy28RrHH2tD9ZULaSUb9IG/vvnTHJbEYjtYu8Tk7VnC6Ygw+Wt1XJ7CJo9UgrtMZQcVaChFiMaWLLASImSs2joe/p7AiONtOJf+wbmgavP2bg4sk54j+qKEIXGiD8XCaYetkxJIhB55xEh4c6MHXJHZxDoySxBTwAouiGoIJ6dsZ7vz62AALcDDfsUck5LLEnR4pYT6eKIa1tzse6EJ39+8Lbc3+OpODqJggIisZ+BVecaAooXQmrAmOJ8pntw5H8A4Zs9jDLtu9DCVu7rodaaAM1JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2gscN2YNrNISWr2ptLoMBDkuKmsJoaq/XEVHQ7DZWo=;
 b=D3+ruHB7U0BkLMIQvVppfwy59M+ohmyB0/qUSyeZSSYxpAo6lXedqZpEfL6NAazXJau5vU282w6QQuX2HEfAF4z67aq6alMVTmWrUFEOqxLP1A6hgBR6RycSJuO3czPhcq1HrHQdaSaT4dY4loo1GvfDWm6zDM6uYl5oHVgo4ao=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4453.namprd04.prod.outlook.com (2603:10b6:a03:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 11:10:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 11:10:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Thread-Index: AQHZO6xAtTy7s08RWkWGkRErIc3piq7Md5MAgABIngA=
Date:   Mon, 13 Feb 2023 11:10:25 +0000
Message-ID: <ccc93888-cf12-5963-9741-7c63aa86e0de@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
 <Y+ndtmQuRsLLm7Ke@infradead.org>
In-Reply-To: <Y+ndtmQuRsLLm7Ke@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4453:EE_
x-ms-office365-filtering-correlation-id: d10002d7-cc25-439b-3b56-08db0db2e81a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xHnKBvE/113VyzNEDxRXkzyaiDHewg4/eY8fr7NW5IVVidzEr9JytQ88ZQRczMPkIfPqalkLIJHRrWPP9MF0nHknINBnJbaRPR09QLtbt+YXO9Wj6p6sEg/giIOjdZExudyQo/rX0ygPfH4GtbNCmvWnt1j0uUrOFov9fv5OaG5y2Ojex0imrHUF6OjHYKRUhScY9c6eqfSFsH7SSj3eZ9eJEIqblTcQDwoAqOnBCf0MUNCpxUcJrhYekRMB+L5YOYN3mTgJ19BmTPweyH+07VTFR3y41MtmLEXkkyNQKrbGg1QlLY9u9ZKvoXipTPwensrReYIWF2cVvpYFfBNvlf0CSveFJ8+x1s9olm5A32HKmwg4CF8VZ6KNrfr1cA9U6+1aoKHS4urABxzL0IWq9g7ZPK0PKr64hpvjawBbRqmJ7yg8jttLIoL9guSCtO9Lcr3dQ6Ji4jZY/mA5m5B+ju/c6c/t1mD1sLV2sPAoVphkxBCxpSpwQZ7cQZ/JFLz2RKRWohy/VZz5Z0c35wbsGX5P2R0RwFEv2Nd9r2ZYnvInzy9g2dd3wb6QGoqm24csp+oUAsOivFGrK5ScYhTLuS/QDXGBX6NDGMZcvDq7kWVkwKhgwdweA6fYZ9Za8vSp1iDNO4VVLHmlQN0NnKs1YhI2T1Ujn6xGGL3gI/RyVWKEqfEo+FJIFyXGdIeduXwYR2YkVeMgRqFR6oBeGkcFhkfuigj5V/CBxYWXFwT/eFoMIbHtxndb5Mul+eMiE/DAHn9rmI9n15R3deMvxu9iMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(38070700005)(76116006)(66556008)(316002)(66946007)(66446008)(66476007)(91956017)(8936002)(4326008)(478600001)(41300700001)(64756008)(83380400001)(5660300002)(8676002)(53546011)(6512007)(186003)(2616005)(6486002)(110136005)(36756003)(6506007)(86362001)(31696002)(2906002)(122000001)(38100700002)(82960400001)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ty9sZHdlZU9UbzRRdjUrYkJHd1BJVjhGamFNL2ZWUmNCa1ZMbGdGOGxWMjJU?=
 =?utf-8?B?VDhhM1llZEpEVjZVSGJYNGRtRHROcmhhMEZ5TGFTdzNjNnhhcFFSRVNTTFZn?=
 =?utf-8?B?RE5MVDI3UlMwRnBPTy9welRtd0cwUmltYUU5RUNIY0VLQnBsZkJwZjJkd084?=
 =?utf-8?B?b0h4ZTZONHJhaG5lMGwxVitxdnN2YU4yU1NOL1ZHNDRnNktIZzlnQXlBUUdt?=
 =?utf-8?B?d1lqdFI3NUFYeEpLS2llSlNRbzhsWGhLeTlZbmg5SURZSzBLcVBLWERybkgv?=
 =?utf-8?B?T01Fa2JQVjJhZy9DT1g3VzlEb0tIa2lPdWFQZlMzbnN5M29zTzN0WWwwUzVk?=
 =?utf-8?B?NGhubTFDM2xPb010R2NxMWF6Qmt6UUU1bGRuVElCTU1aalFnUjB2NGdFbTdS?=
 =?utf-8?B?RUVIQUl2ZFFOd25XdjBuNTNiUXBlSE1mVk1TRXRVaThUdVB3ckNCaWxHc1JN?=
 =?utf-8?B?OXkvcGFySDhsSXV5ZkJ2TzNsaXVJZlpSZDBmTHNSSGNoL014UVF0UnB1SXpk?=
 =?utf-8?B?SGxRME9XQk5MWkkwUlBnVXNIZEpYTHRKZkVvMG16NVhDQmh0SzVFL2tMTlJJ?=
 =?utf-8?B?aVJJNHBEQklqSm1EYXVTbkRxdmpYV1FQVmFBUGRwbjlucG84NWpYVVlydlgz?=
 =?utf-8?B?ZkF0NHoyS1VDMWpIVFk1NndrRWpRTENtakFraDJDeWFHMUZMQXppUXhYdDdU?=
 =?utf-8?B?S0lIY1V0b05nNDdTV3RIT2lWd2RVY3pmempPNi9uYjkwT3VyM2VjS1RDOU1y?=
 =?utf-8?B?eW5FdzJGc21ZNjZjazlkUUF3ZmRscjN2bTRUVUhRUVBEeWlYQ0Q4NnBKZU5Z?=
 =?utf-8?B?MzFTRGk1dFJmekRtTC9DS0pVT01Lc0oxR1BXTzV3dmpMb2JsNW5CK0NnTTlo?=
 =?utf-8?B?OVNySHhLbnZNQW9KaFExYWl0Q0lsbWlwaFBOclN1dERRYnd1bVNwRzBuaUMw?=
 =?utf-8?B?SjY2VHMwZkJZR0VnUjIrZVlEZ3Q3STRIL2o4K2d3RDZxNExIKytQT01rc05H?=
 =?utf-8?B?ck1EY21Md0hiRGRvVnFIaHlBZnp1VmFJbWVtWnphcWpDQW5sSHpIT2hGTlFU?=
 =?utf-8?B?N0sxN005Q1hjQ0NOVUE0cStpNUYwYllYOWxqcjJpSzBpdzd0R3dTbzVWeGZ1?=
 =?utf-8?B?UjdYM1N0ZEtZd1kvdFJsL1dEclIvZHNPSUZpUUJ5bTdCNUFlczJiWWZtT2Jy?=
 =?utf-8?B?NWxsaVdIVE9lTm1zZ09GS0gvS2JWOGZoZ1liVHU0azJhejBNZHBtc1FjUkxl?=
 =?utf-8?B?T0NhTkJYMDBOZEh2QVJyM2I2TWZpNmtvbnJUbmZNZFdDRmd0ZElLOVlNSnYv?=
 =?utf-8?B?RFhHK2ROenpiUDFWSHBjSDNmYXM5UGJOM0VGMEo2QnVOK0FMRmhIejRpeUZh?=
 =?utf-8?B?MzNxMFVSbGEyT050SEhTQUxQMXdtQmRZNWVMOHJmcUJISmZNOHNwSGdsTnVz?=
 =?utf-8?B?VWo0WnFXWEswemhnRlV6dm1LeWVORmRLa1RBd3VEcmZqWkE5VGZGMlc3VkJ1?=
 =?utf-8?B?WVFqNTFQekNReXlpcWtjaE10RVlsRDFhMjV5bVEzTktCc1N4RUdXdFdXczNN?=
 =?utf-8?B?OVF3Q09DN2IzcnA4WWNIYmxZY1FPdXlQZlpoVUdhNlFYWk1iYVBKOE55NVVx?=
 =?utf-8?B?UnY4bXUzbHc3MHN6akpKK0tSRzBqcjlyOGlOTm1DcHAwNTcxN2RGR2dkZWJF?=
 =?utf-8?B?WkhqZmZ2bkJRc0J1UFA2NFplNEVLNDBlVUhxNFIyMTV4WXZoSTlqN0d5TU1h?=
 =?utf-8?B?ak04NWZSalJRTXRrMmtZRW02aWhrVm1qVGZoUUtGQWdTUld1QWpFRWxwdlVF?=
 =?utf-8?B?UkZlNEdLNmN2N21ueGVtZ2V0emR0cFMvZHFUY1FxVG5BR0Z1enM0dnlFNG9O?=
 =?utf-8?B?TEtQQkpoQmZOeXBpUmI4NUx3Tmd2b3dZSDNFWHFNdXU4cmc2YUs1MHp6OHN2?=
 =?utf-8?B?ZlRoRWF6YXR4OUFLd1JFY0FnYnVkZGF5eFdRVk1FQmNpV2owZSt0WlR1N1J4?=
 =?utf-8?B?SlFpbjVMbWMwWjVFT1JKTmRyRzdyc0p5S3VubHRzNUdlMEQxNGpHY1RKNUV0?=
 =?utf-8?B?ZWU3R1N4ZXA0TUc3RFU3R1BKYStSNTVkRktxc1MxVVVOQXduVUhCUk4wejdq?=
 =?utf-8?B?OXB1WWFPeEN5eXc3UWNjdW42Z3lUVFF6NDM1Snd5OXFuV21RczdybGw2U1RC?=
 =?utf-8?B?NjFTbWVrNW1iSVhFcnovaFJJMjBpVFlZeWg3VFJhK0dGUUdFSVdWRGVEYjF1?=
 =?utf-8?Q?8QDHio3wvnlbNPDy3kehvP7U/EfO9JNIl0USD1o8gk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C004C922F095A142925C610E2D2FA097@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jHK9nvvSGL64L4YKsb2iP5tPKAeMCyF8ZZ4ASmHZD/vcinOzxLNbtPCYK+9xUWHZDBYNHiJNQD9Be37Xu4jtwUwZxgoBy7QKcee0aEZODv7h6fERjklLU4I4Q7r8ajqmmIxiqaqxR4ss8kBuUWYXfS0ZSoFc+WZDHCl49cI27dTtRC4ydkN/rRP/erU8LwDwAHPEvp9G3FzY5qK+pr21BGc7g66YpPQddn/d5Qek9IxWv0HL4rzELqUpKBCyqS5VjEEK8As/9YpoFMV1SSOzx1hBABLZSRaPhZR5elg3l/vseBT2puDvHNWur3dD1U8rbG4WMIlZacvrvWbiCh7IXyYAyuwR0husShMaK9rCTQw9dBxVMCZVCitw5/xnySrxVTGEyNonvm8YPKjF7KgP6hgQKCb2kvMIEZE1kddp7GQ5swhG6hHL4KMoEAwOvQp5JulKGY+5696x+4gFqmN5UVcC1KccQIHzsWOJFrR8s5fez5GrTbPzalwJhMMmEX0tC7vxufDnExTx4Mgdhs/iHO1c23zOc76zwzoSGyAiwoEaUw9ua61I3BPa2yhr/BBOOd/fVuouC1uuQE8/gSp8xSBVWO9LLuTf9/D6AqHsc4RGJXE8Qrd2HH5SXtf5QCac0R5633ZedhJCm16QTwl6v4gA3sSAo/mUvcPpN6CvGbDcPmKW/d5FFnRzhHMtXoTe+w9VAtZYfk+9CZfRMWZaSUWAy0BOzrG5mpn+cy4YsK1FhsuDUycmVUbnPpzkobjYYNu+k04qBTfnzAktzUldicV7Skw/YvgNLA3Zug3gPzTIamrpFpseugICRzFQF+2PPmBa0VWlE8AjcbVyTbNv7pA6uS//+goTWjWiwcXFBch7lNGIRAl1Ovz78X1tY7ig
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10002d7-cc25-439b-3b56-08db0db2e81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 11:10:25.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VV1JiGwjeGhOgTle2HTUfAQl33kms1vmsaqvZi45PIeE5WQZ9IDWWkhpL9v8eXdV/T2lNJZPBYZrCGiEDSaVyI/jFnZVd6FjsT4KD8SXpP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4453
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMDc6NTAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIEZl
YiAwOCwgMjAyMyBhdCAwMjo1NzozOUFNIC0wODAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBBZGQgZGVmaW5pdGlvbnMgZm9yIHRoZSByYWlkIHN0cmlwZSB0cmVlLiBUaGlzIHRyZWUg
d2lsbCBob2xkIGluZm9ybWF0aW9uDQo+PiBhYm91dCB0aGUgb24tZGlzayBsYXlvdXQgb2YgdGhl
IHN0cmlwZXMgaW4gYSBSQUlEIHNldC4NCj4+DQo+PiBFYWNoIHN0cmlwZSBleHRlbnQgaGFzIGEg
MToxIHJlbGF0aW9uc2hpcCB3aXRoIGFuIG9uLWRpc2sgZXh0ZW50IGl0ZW0gYW5kDQo+PiBpcyBk
b2luZyB0aGUgbG9naWNhbCB0byBwZXItZHJpdmUgcGh5c2ljYWwgYWRkcmVzcyB0cmFuc2xhdGlv
biBmb3IgdGhlDQo+PiBleHRlbnQgaXRlbSBpbiBxdWVzdGlvbi4NCj4gDQo+IFNvIHRoaXMgYmFz
aWFsbHkgcmVtb3ZlcyB0aGUgbmVlZCB0byB0cmFrIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGluDQo+
IHRoZSBjaHVuayB0cmVlLiAgSXMgdGhlcmUgYW55IHdheSB0byBzdG9wIG1haW50YWluaW5nIGl0
IGF0IGFsbD8NCj4gSWYgbm90LCB3aHk/ICANCj4gDQo+IA0KDQpJc24ndCB0aGUgY2h1bmsgdHJl
ZSBvbmx5IHN0b3JpbmcgdGhlIHBoeXNpY2FsIHN0YXJ0IG9mIGEgDQpjaHVuay9ibG9jay1ncm91
cD8gDQoNCldoYXQgd2UgL2NvdWxkLyBkbyBpcyBjaGFuZ2UgdGhlIGFic29sdXRlIHBoeXNpY2Fs
IGFkZHJlc3NlcyBpbiB0aGUgc3RyaXBlDQp0cmVlIHRvIG9mZnNldHMgZnJvbSB0aGUgY2h1bmsg
c3RhcnQuIE9uIHRoZSB1cHNpZGUgdGhhdCB3b3VsZCBnaXZlIHVzIHRoZQ0KYWJpbGl0eSB0byB1
c2UgdTMyIGluc3RlYWQgb2YgdTY0IGFuZCB0aHVzIHNocmluayB0aGUgb24tZGlzayBmb3JtYXQs
IGJ1dA0Kb24gdGhlIGZsaXAtc2lkZSB3ZSdkIG5lZWQgdG8gb2J0YWluIHRoZSBjaHVuayBzdGFy
dCBhZGRyZXNzZXMgYW5kIGNhbGN1bGF0ZQ0KdGhlIG9mZnNldHMgb24gZWFjaCBlbmRpby4gQ2xh
c3NpYyB0aW1lLW1lbW9yeSB0cmFkZW9mZiBJIGd1ZXNzLg0KDQpCdXQgdGhlbiB0aGUgY2h1bmsg
dHJlZSBpcyBuZWVkZWQgdG8gYm9vdHN0cmFwIHRoZSBGUyBhcyB3ZWxsLiBBbmQgdGhlIFJTVA0K
aXMgYW4gb3B0aW9uYWwgaW5jb21wYXRpYmxlIGZlYXR1cmUgc28gdGhhdCdsbCBtYWtlIHRoZSBj
b2RlIG1vcmUgdWdseSBpZiB3ZSdkDQpoYXZlIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlc2Ug
dHdvIGNhc2VzLg0KDQpKb3NlZiwgRGF2aWQ/IFdoYXQncyB5b3VyIHRob3VnaHRzIG9uIHRoaXM/
DQo=
