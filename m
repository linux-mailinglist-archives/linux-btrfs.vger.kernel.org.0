Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7E710C23
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjEYMbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjEYMbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 08:31:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE641B9
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685017846; x=1716553846;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eMFPg56Ge28jYGIQxTr7zTTiSNgiEb9+9WUhDnAXS/A=;
  b=Z0sqpgdb9WWRP2/uzJpnSLEs4rpmHhYekT3trEvAoR3QFF6FH06/M4+X
   +3j3NoJE/A8JNesRrVsTxMsIh+8aZFdwViZ4Fwwvi1jF3SKzPEbHZlZad
   LrCjFKW1+bbuDJl1CT595L+Qg6eNg3tNIxLBTJj7lnsKGsOcgnZ0bpvsI
   suuadkmdj5JKXOEXMqowVzuniOtDEOMvt4vR9Dbc64LVCF9Hc19BMbOIl
   Dpuws8pwQX7DCtyklZXDFSBeh7ZyQ1kvE1ALDhcLuDvFGZZn7llWdXFul
   FrqYWNCXfQRe6h9A5f0se/0szBcvVA5Wnww1cR4qepD5CQ+iwdQqJj7we
   A==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="231549942"
Received: from mail-dm3nam02lp2045.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.45])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 20:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwLArzEkjzgcPzf6y+BrBp83LERiemYdNKwXrczKATSncgfjjQIsHmRVq1rQMGjZZH56eCO3pBopP5tjmBEFDLWCVw1x7cwbrbgpayTJcidsMMwf7Uu7lF2eudSurEAYpIcc02uXvUo2hvtzvgNKis4y8G6r+BlCP4Xqw3A8E8546zcqrh8LIYAyJgPzc9xfeOIvWnP+h1fSjGl2V9UcVAcGfqVHx3vMfC0/Fbv7Or9TuIkGSqiFWb6w5FW/la/Qx2QYUHyfxIyRcgfHrwUJCZwrMbEeP+fUTIVLHt/Krw1Cl4O9SgbqFxoHoCLW5dSIgyCsAH/xn+sCSWy9kXN97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMFPg56Ge28jYGIQxTr7zTTiSNgiEb9+9WUhDnAXS/A=;
 b=dVhU9GRaaYxbVnneJxUURJqnj79pA+dmsGyWNJqqs96+qEaj8BLIrK0lb3NdppxH+Dm3s1ARZPaFOd4LWy2ydkzqUJzM/N780Ze9wqv21ds2euC1pAewY6V4SQCwfWvXPC94v7fv/kCQ7za/vtHNRwvL4040rYwFeGroGvzNIgDSeN1Syo8p346y5MbzDsEk86VkMwbSY/wK56BS+sWjBY/AiTM0OIpELCUkhqspwjyxn05HMQhSXxNCMX33lB1Uonqh8MrsNrpCZ6isWXPvoQ74cJSg2gNoYoLHN3Pi2JEz88Sp2ZMK6izd28IUOT8a6QFUkZPgZGTpN3qpljJpYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMFPg56Ge28jYGIQxTr7zTTiSNgiEb9+9WUhDnAXS/A=;
 b=OtoPx9HT1PCgBYFVRQ1yj6Oz8HMPUXy1OGGhySbfPDTPkyw4mu6ggYl5HvF3bI29GmEiJaUUKQD7mmauEhV8jv88dNYVMO+vnpEMcsQ7jfkIVsh0053OeiPDNxqL3YntRnjCsANm0JAzdpuMVfDvwFhc8O5TI4DMOQ/UzmkTWKc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 12:30:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 12:30:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/14] btrfs: atomically insert the new extent in
 btrfs_split_ordered_extent
Thread-Topic: [PATCH 11/14] btrfs: atomically insert the new extent in
 btrfs_split_ordered_extent
Thread-Index: AQHZjlEM51jMf+vOPkKu7uA91FJcdK9q7MwA
Date:   Thu, 25 May 2023 12:30:41 +0000
Message-ID: <f574b91a-14f2-7d79-4b7f-8d625fdcde6c@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-12-hch@lst.de>
In-Reply-To: <20230524150317.1767981-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6428:EE_
x-ms-office365-filtering-correlation-id: 00c7e70b-1001-4f53-4b41-08db5d1bda80
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2psdrVJULpuxE03zx1yCvtPdb+1JdN8HK6EjfkBFhMnGre4oyeck28jnDGa4uqU5wFKQaaXNAWirCjDgEG2MfEPdCThiTAgAac3uXrW8jmDCBuIcxx2sn7pQRIHHiXhbTafADBrh53ta6FNNcdTvNf52sjMscpJMXhYpBTDNlVk/M34cW/i/cMWhJD8FWD9L3mpaHdhswZ5RDsB95uBzeviJI25HLprLD5zdIoAqvlFwqYfIQ2742w3CGzDlh9T0Lcc+rgAVRd+xaHUOMU/hZXhwUazL3zgCDhjlxkJEDGQpuP/NQhTnlMQY0EmEv6ud+7fAhl+wJi5zStAXBEQDA1CFraaM6bbQMtUWFWhbvKApLh+ZQALZiytcGGzdMbnCvh0Xc7W/J0Ff53pM01Pg/UWn5fsn0vr+eK+1JfJhhdsYAh9htlIydW3FfchlyXKt80kUjf2cgz/+CvHv1/z3dvN5LOgp0DU8h5GJfzWgK8AvJTrAMZE3a2wrLB4UX17H7pZj9BjRQYfNgVk8m1H9XnAd7ixehv1yX47yS2lMHlPeaXEF39ujudyn3byZHQdg58teOrNYXmHx/z8cxtI5O8GZiG8a6yKvlhaY3edrxQMYm2+VOe3r/5HGdFWrg0khaSIG22DOIaUjMeJnjC5iqU9ttNy0Gt4NP4KJ4kMt/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(41300700001)(6486002)(6506007)(83380400001)(6512007)(38070700005)(2906002)(53546011)(186003)(31696002)(2616005)(86362001)(38100700002)(82960400001)(26005)(122000001)(5660300002)(8676002)(36756003)(8936002)(66446008)(64756008)(91956017)(66476007)(76116006)(66556008)(66946007)(4326008)(31686004)(478600001)(110136005)(54906003)(71200400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVFSTGNMNTlQbXc4a3I1d3pGbmJTcWRwTnRkcnlsS2Q2dWZ5K05iZUhkdW1q?=
 =?utf-8?B?Tmk5V2hPaWpKWlZKU1c0eTFFRVRYdHNYc1VmL1RTYTVzSENDYkdtNmNiWlJJ?=
 =?utf-8?B?ODlyQzl0azcwZTdqZnhJQVI4SWd5Rjg1UjFKcDNkdDNyMEpoZWl1YURKVU1a?=
 =?utf-8?B?VGR1MWZyaERxUGJ5NEJvS1R5U1NXT3oxOURENFVSczFxem9zeXNlMzJFL1Bj?=
 =?utf-8?B?UExPSFN5VGtKYmtTN2xUUzVpUXNKejU2bjV2RVFkK1V4YWFhWXlCYW1FOXFE?=
 =?utf-8?B?UStmenZzMXpRT29OTnRtck10d0NaZGxlU1lmdjJDMjRmVmNvV2o1bitTZ2dE?=
 =?utf-8?B?Y05WQmdXaWdHL25iTHBoSm5tUzF3UGF2Zmp5dmtZZitsMitBa2Q5cXJ4U2xE?=
 =?utf-8?B?Lzd0cnBjN2ZNK0xHYk9Ua2lZenJQODhYbmw4WHczMHY0NGJDeklrVVh2NXY4?=
 =?utf-8?B?bTIxckdvSkdqN3g0S3BkMnFmRmx3T1lickR1Q3E1Wk9TUjQ4aXEycnZ1WDRT?=
 =?utf-8?B?THdZM3FIbnFCdjJYbEVtYlRrQXVJRFFZUzdZeHN6eTdHMU14bXRKMWJ4ejFE?=
 =?utf-8?B?aGI4bmhvaDhFSmNwZW9XeXhmb0ZFZVhHbnRWMmREdUpCY3RpMU93dW9nMWpB?=
 =?utf-8?B?QkFtelh5dmI0OHc2OGd3RE4yOS9zdnBWU3REQXgrOFdTdXFKRnBKWWF4N1Ir?=
 =?utf-8?B?WnFBL2lWNTYvZlJ2Nmk4TFY0ZktGbys0MlFBOHdINVdZMGh5WDVibHBtN1l5?=
 =?utf-8?B?OWdGNzQ2T0NLMUp0S2Y0TzMxU0h4YUJjU25YNW1xUmFkd3Z5VnBsSlBlNUdk?=
 =?utf-8?B?T0xkUUxsR2M2NHpXUzFCVy9aVkNZd29oNHdQQjYxM1lEcThXQTdEOUdaOE1J?=
 =?utf-8?B?OEMxT0srUzlQdE1ONlFOMUtqUmtWT3JVVHY3Z2RpQTJtd0ZBeWwwMG5xM3lt?=
 =?utf-8?B?OGkxVGhtRHZxSXQwRXphVThpeWRYNml4aHBGQTNrb2Y3QTg4VktyZnB5NkRD?=
 =?utf-8?B?bmdyRnBWSGZOdm1TR2YyUm9IU2Y5MktWaWRTOTVwNHlic1prL2w3QVdMY05R?=
 =?utf-8?B?ZHdNeVJLZlE4cy9mOUhHR1FybUxDbGFDbGJCNUIvTlNSUklicktNbEtIQi9N?=
 =?utf-8?B?NHlEbGlRSDhFWWRBNXJMakZqYnVDTWhpZCtXOHp1eGFHRm5pZUloazZqYjhU?=
 =?utf-8?B?djdlT011RTFaUlBrRGVLT1YrSUVFNWVwTVdjTXFHdUxYTTAwMkt0czAwRUZn?=
 =?utf-8?B?Sm9vaDBzYmpocVptQkFFN1pUMnllMEE1YjZGbW9kK2V3Z0J4emxCNWM4RSsz?=
 =?utf-8?B?S294bk1ZNkxnRE80QWw4V2FLKzRCcFhHMjllY1QySysxdzFBL3ZNL3Yxa2ww?=
 =?utf-8?B?ZTlVejlVMW5TTTc1UWdMNERMVzE3b1NiNzJrbHRDVEQ2S3hyN0V4N3p5MHRZ?=
 =?utf-8?B?ckVYOGEwWWJOeHBMb1BYZko5Q0ZGZUdzRFdRWWQ1L3l3SGVWQUgwNTVBVnhY?=
 =?utf-8?B?YWU5LzloTDVyWUl0NkFzTE5YZ09STmRsRE9XV3NsMmxBSTRYRS9Pd2hoMHNY?=
 =?utf-8?B?UUVZcnkzc3A1aTF4eXlzbXBxZDVwbURTblJ3eWVFd1lEbXBmV0pJbEZOdHox?=
 =?utf-8?B?WDV5NGhuZSt3WkVUZk5zL1dFUjRHMjVDTUY5R0MxVlJxVWZJWFdUMW9ST3RY?=
 =?utf-8?B?Mk1sajBQYWtrN0lzUnFVQlk5MEVBa2JuenpnNll0anNla1hkTS9Zam1GclJU?=
 =?utf-8?B?N1o1Wk52bkY1aTBYbmtwWHhtcnNDYWFzbDdSK1lpaUQwRUFsM3A2L0ZPUC9U?=
 =?utf-8?B?cDFsSGRQbjMxTTFDWi9vTHlPbTkwYTdVZVN5TmpzOEFTblZkTjBLTnowekZP?=
 =?utf-8?B?akpjdHZWY3RpRm9XdG5TMXZZL3VMY216bUNOTFpKZm4yL3Q2bmVDZDBMYmQy?=
 =?utf-8?B?dEIyRi81SEVpTDBRYnQ5bXF5Ui84UXpDS01Ya3k2cTFBY25iZDFpelZDMVRJ?=
 =?utf-8?B?L2QrS0FBaWZ5anF2WGJYMG5rZjJXS1F0TWtPUEUvcTFSR3V6L0laR3Z2bjNm?=
 =?utf-8?B?cTFtRmo1cUFOTm12c05mc1ZtSU1qQlZKZGJaK3lqNHVQcjJnZGk4eUV5MVFF?=
 =?utf-8?B?WVBWa1BrTGVjOVpSeERVbW94alF3dUN0ME1mYk9iZis1TE1QUU1CNnJRQ1Zw?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA6F2188139A8D4CA2FE688DAFDCE563@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +KUTy/HfmuopexvjIsrDIDMqXpmO/HQrxWboMbCX8PcbqNDYQ2cvxEnTecz/m0rqAQXLyBZDSELkZu15yTUc4UBVgOA/f/jUngTeBnAaHY0XC7zGm2AbFgBvzIluuJOG/nKn0lWAMpbJLnG8+cO1EAM9CFKvoYtSd0A//7yRb/rBGRHjmecYqBw5aW+erJAi4y/8pRUgqn1WliYazN3roOIj1NTspoOQgjNIJl+/iwYrDRgMkn2afdTbQJCyWLAbSoxVjbQkbXMjy/rrE7owO9OJmog/tVCw3h3LLaxBIYVL6cMlFKOWUm+YVynwArtOm9/Ro7MDaP5+d53QRWyKEitbLGVuo1m2989TtJIrqKKOn5pBCFvXCZB1GfrPfZLNbQc1MNsh4J0IOCjLeH1ofmA3hlfJDLY1ogQqNanas8WSl8ZPSlN3TVG2e8+2I4+ksVawiC0hd7t5NegFU9xcpyYREa5ppvbUeQQowzn0Mra5aukyqwyOytUNCzrNdDCWbYXlk00eBh7rZhrobOJb5DaiYNneg5XT0DWrX8IIFgC9fuvs1dhG7FKPvXn60BAAiE3//peCfZV9bx9SK4xpxOHrZMhjwmlWvdfQwcKJQRl4577i2J4U+60gTQRMO65ud0n/0V8k15JJyOgCUCQ4tBIkOT0LMnCZIsjAze6NU9A1Tmx97WQAYyu9Wu99dKLHh+8bXA++K1rD0wcbawTcWUNmz4LlTqia2XThqG0PWZlek3am69FDuDshYlgd6eLy/6NCSJGnlXyF+R2VROn7ABb5FtrynjejPVEFEBG1PFB8maj0p18P+59sU+L/hVNhxAZWy2DPjs5cpEprY+k4iG3IlbUHzZzIqnrX8DPhbrCLrjuGOhhoVc4ueAY5OFgi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7e70b-1001-4f53-4b41-08db5d1bda80
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 12:30:41.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGBzfYAC71s03Dvy5Wqvuegeh1YXwms7wJvkN2bYTHsE2IhdyqYeetxiwp74D5gkECtGnHqJokgYyu56plySoSA0g7V+ld871WxEOealViY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDUuMjMgMTc6MDQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBAQCAtMTE4Miwx
OSArMTE5MywxOSBAQCBidHJmc19zcGxpdF9vcmRlcmVkX2V4dGVudChzdHJ1Y3QgYnRyZnNfb3Jk
ZXJlZF9leHRlbnQgKm9yZGVyZWQsIHU2NCBsZW4pDQo+ICAJaWYgKG5vZGUpDQo+ICAJCWJ0cmZz
X3BhbmljKGZzX2luZm8sIC1FRVhJU1QsDQo+ICAJCQkiem9uZWQ6IGluY29uc2lzdGVuY3kgaW4g
b3JkZXJlZCB0cmVlIGF0IG9mZnNldCAlbGx1IiwNCj4gLQkJCSAgICBvcmRlcmVkLT5maWxlX29m
ZnNldCk7DQo+ICsJCQlvcmRlcmVkLT5maWxlX29mZnNldCk7DQo+ICANCj4gLQlzcGluX3VubG9j
a19pcnEoJnRyZWUtPmxvY2spOw0KPiAtDQo+IC0JLyoNCj4gLQkgKiBUaGUgc3BsaXR0aW5nIGV4
dGVudCBpcyBhbHJlYWR5IGNvdW50ZWQgYW5kIHdpbGwgYmUgYWRkZWQgYWdhaW4gaW4NCj4gLQkg
KiBidHJmc19hbGxvY19vcmRlcmVkX2V4dGVudCgpLiBTdWJ0cmFjdCBsZW4gdG8gYXZvaWQgZG91
YmxlIGNvdW50aW5nLg0KPiAtCSAqLw0KPiAtCXBlcmNwdV9jb3VudGVyX2FkZF9iYXRjaCgmZnNf
aW5mby0+b3JkZXJlZF9ieXRlcywgLWxlbiwgZnNfaW5mby0+ZGVsYWxsb2NfYmF0Y2gpOw0KPiAr
CW5vZGUgPSB0cmVlX2luc2VydCgmdHJlZS0+dHJlZSwgbmV3LT5maWxlX29mZnNldCwgJm5ldy0+
cmJfbm9kZSk7DQo+ICsJaWYgKG5vZGUpDQo+ICsJCWJ0cmZzX3BhbmljKGZzX2luZm8sIC1FRVhJ
U1QsDQo+ICsJCQkiem9uZWQ6IGluY29uc2lzdGVuY3kgaW4gb3JkZXJlZCB0cmVlIGF0IG9mZnNl
dCAlbGx1IiwNCj4gKwkJCW5ldy0+ZmlsZV9vZmZzZXQpOw0KPiArCXNwaW5fdW5sb2NrKCZ0cmVl
LT5sb2NrKTsNCj4gIA0KPiAtCXJldHVybiBidHJmc19hbGxvY19vcmRlcmVkX2V4dGVudChCVFJG
U19JKGlub2RlKSwgZmlsZV9vZmZzZXQsIGxlbiwgbGVuLA0KPiAtCQkJCQkgIGRpc2tfYnl0ZW5y
LCBsZW4sIDAsIGZsYWdzLA0KPiAtCQkJCQkgIG9yZGVyZWQtPmNvbXByZXNzX3R5cGUpOw0KPiAr
CWxpc3RfYWRkX3RhaWwoJm5ldy0+cm9vdF9leHRlbnRfbGlzdCwgJnJvb3QtPm9yZGVyZWRfZXh0
ZW50cyk7DQo+ICsJcm9vdC0+bnJfb3JkZXJlZF9leHRlbnRzKys7DQo+ICsJc3Bpbl91bmxvY2tf
aXJxKCZyb290LT5vcmRlcmVkX2V4dGVudF9sb2NrKTsNCj4gKwlyZXR1cm4gbmV3Ow0KPiAgfQ0K
DQpJIHdvbmRlciBpZiB3ZSBjb3VsZG4ndCByZWR1Y2UgdGhlIGNvZGUgZHVwbGljYXRpb24gYmV0
d2VlbiBidHJmc19zcGxpdF9vcmRlcmVkX2V4dGVudA0KYW5kIHRoZSBuZXcgaW5zZXJ0X29yZGVy
ZWRfZXh0ZW50IGZ1bmN0aW9uLiBUaGUgZGlmZmVyZW50IGxvY2sgb3JkZXJpbmcgY3VycmVudGx5
IG1ha2VzDQppdCBpbXBvc3NpYmxlLCB0aG91Z2guDQoNCg==
