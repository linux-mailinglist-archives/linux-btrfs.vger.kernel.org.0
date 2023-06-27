Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029373F5E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 09:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjF0HlS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjF0HlO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 03:41:14 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD801FC4
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687851670; x=1719387670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=nQORMyCMRI1/Mob7Z618vCHapt4b2LhIxwBNAekGQi0tPAX0+PbWSxlY
   F9C/rjvWyABz02GM0CnSkPfO+cYOH8tcOV9BAx3qcSoOnaWj+bTX7HbA1
   i5Im9UaJs4cx+iypH+eS+bnXl47DRIM21RBXsM5a321zT7TjbhMMv/TQI
   l6WDzZ4ZrVKfZ8dxaQpHXEHZxB5pVV7DPmw9RjfiN4FrCmCRUpFPHmmnH
   u7e0+HhDnn0FbuU8H7CM44OKofJN4dfro91o/ryubsMhkbrpJbyxYQ/wl
   +fmVPM6xdtig36X5n7CxY/1MRsrEuen5qGBOpHvG6DF1jV1BsgsSAxXp/
   w==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684771200"; 
   d="scan'208";a="235002478"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 15:41:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwvIU/u6cUJft+IRQ/uZT68YAF91lL5c0nK1zy7qg82qckVcYyd1W/nXgIzGumhY0Lp3UJKVuTt8GGXX5RRR0+vKDw1FQ4a+UXopZNcKCX8H/OuVQkEkBNHzrrjSgsPoTBZ4pOFYrKXv+X+veVscARtHaSkt2jE2jQWrYHrAaha/C1octQu/1rOfQGryoTfZ/vmL4J7jP6ArFeN/q8u3/ofYVu0A0RdEhCrhnxk2hjnwGPf1YLH5xCkh/+SeS5B5WAcYD9P3p9cp1SQ7Vtez2BIQ3obFswyyaM4x+UyXJyp1Llq1TkHLWFslgC+zeghCjIyAXjq+hUzuI6NlxpAgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CIrZcaCCT6BD7J4hd7eR6s2Args5H21vUQBVbWtRFQcalM8jbmNNI5brIvvik8yViuQV/r/h9R20436WdmCEIjA67WIN5iexCHXrQ57Wko5N+cHJ/1fNMo4PiC3I8Nf9+8fiVowCu9AXotqJupeJexZauavh37kb+8ZI0uZpB+tTkjoELUcnjfffybXbqBVSUwl0GK1uRs/TIRhzjsYR6lmiya1P2o7o/OpJwBXrXwOsdg0oxhD0y6D4yoFPIEDbfx4E1JI1CCWUUl3V8LZkBPOx6eul3LiSN8e+NANyB0LSKD7e6EdLL9PnaSzCv3oYDnIZ+DMLcly5Yy6K8VeLaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uvI0zbOHfm3BZkZ58jzVxnTOS1rSAV4mv4xN6RWsaVK5wlmbLSV0mvH4yUGxhREwJRZEcW9braMNr2j6/TL9U/UCRHEo4T9FOs1TzPQzaKxBqOPmXAWlI3iyEHP1vSaPM6ipnLWKyeDZMzqWPW3jYFGSDL6/9OI+p4W95Q1lnRc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8067.namprd04.prod.outlook.com (2603:10b6:610:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 07:41:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:41:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 1/2] btrfs: be a bit more careful when setting
 mirror_num_ret in btrfs_map_block
Thread-Topic: [PATCH 1/2] btrfs: be a bit more careful when setting
 mirror_num_ret in btrfs_map_block
Thread-Index: AQHZqL6GrUCVA6Rd/EWEIm6VP/gziq+eQ/eA
Date:   Tue, 27 Jun 2023 07:41:06 +0000
Message-ID: <0bb0eb76-86b8-51b5-5d43-af68a51f2bf4@wdc.com>
References: <20230627061324.85216-1-hch@lst.de>
 <20230627061324.85216-2-hch@lst.de>
In-Reply-To: <20230627061324.85216-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8067:EE_
x-ms-office365-filtering-correlation-id: 14d94fb2-6757-4a4f-b8f6-08db76e1ddb7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PkXJSMoODwwDYfBTdwt3c2z++QsQgjwcp/+JahgIQtLYwf3uNwNeBm6oTbNijey7nd0smZW0FAp9CYAYinly16gKhbsfrB35KQKaaBky+KXwSp9igA2EfKGvu7PIrIqDN9hyUpB7za3EqzUz6OfvSUNkAHzyFBP5bj7vZF969MypOCXr0ElipzMong9Agm42HH8hA2kwsY5bEdnOxYegqWGc2KZ3nIhCEqt5Cl2yAn15aKMzhuwd3qmVtUU12Co7yqCXJ+uvDWASyaBOVYthi8NHthrLMH7uw/cBz4a4y61hih++YzJGldLHunNZLkH3eMBKeh9FTrw8XT5vHHmsQENmdZ4hbbdbIw3hMgNXbmOnf5AnZnvd60R9aES9kWLxGBioM3d9Omy7hV9zS2pr0nc4V+WEzD9AQUGt0IWqCa3fwX5KXN8xgKOxCB6yzFFKueGsIdmMtNdg6hiM9O2NOw1nyvJ/wS5tJhUcaphyFrsn7ApxPrqTSS4nYV63xDYSX632fswNyKzUXPgmTadgbw+wEmPQ4EPOn7VqYXwz8lpgJMXM13u+kBPVHkW8SZN8WIbcqbq21OlU8cURkE79SpTbg27MP4Qwn6kdWt5naHhF3c1e5wo+O7n5TzUTSNtfqMd/0z/TRVMyXrkpRwVjHil0rsgXNuhYHxYUz8Sc+ViIVQyjqBuHyJJ9N3LsNzfE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(31686004)(2906002)(186003)(31696002)(38070700005)(558084003)(82960400001)(8676002)(36756003)(19618925003)(478600001)(110136005)(54906003)(316002)(86362001)(6486002)(4326008)(122000001)(2616005)(38100700002)(4270600006)(71200400001)(41300700001)(91956017)(5660300002)(8936002)(66556008)(64756008)(66476007)(66946007)(66446008)(76116006)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1o5c0NHcGErS3dnbFFMcFFyU0NEai9YWHhJaTlLUjlnZ2JiSytSTkVlN3pI?=
 =?utf-8?B?VHlxak1BTGxVbEMya3JUNGhZOW9ITGI5M0dIZGNVNmNVVUw2NzVVK0xzNU8v?=
 =?utf-8?B?TGt4diswdTVOK2dEUDRjVVdhR3VOdEpFWC9iZlhrUnN6RVcxc1QwdjZ1cXlV?=
 =?utf-8?B?UXhLQXVLNTNLR0hlV2FFVzYrcU1ReElyaHh1cDh2SGNnNVFhTFZxcEJxM1Ra?=
 =?utf-8?B?VVVEV1ZtaGsrQ1p0NkRFc0M2dTJEQW1tdW5PUEMzWC9tTGJ5eFdmb3k4M0tO?=
 =?utf-8?B?WkNtTjVONlBVRmtJbUkrb3FaZ1ZOTTU0YlRMa2pZTXNsc2pPbm5OWXRLZlFW?=
 =?utf-8?B?NVc5NnNhMFZ2T25LUWUzYU9mTk5KckZmVGllQmt1alBTMjNZZjN1VGRpWFk2?=
 =?utf-8?B?NkpJUk1sYmJGY2RhbnNHT29EaElaelVnRW1nR2E2eFVmeVdUOGtZN0FqUVhI?=
 =?utf-8?B?N3VFUDBjNFNGUWlGL1luN2R4QVlOWUVxWEFWYklFZHFUbStpMnhZNTZrMTRs?=
 =?utf-8?B?OTNPWkZvbjZoamlPbkdqc1pkR3phRktnS1poZHJhVldvNFdwcWdnODFnem53?=
 =?utf-8?B?Tk5FMGJrdUp3bVdvcGpFNFVWQlJjblpvTitVR2xVVzl1bkE1bmpibXJOaXFo?=
 =?utf-8?B?ek16b3JTYmM0eFhzeUxibUFDc3FTcE54dndBTDFONndaY3BzV3M5MHpydld3?=
 =?utf-8?B?M3dRUTZwVWpqbENqcTFoNDhPekRuWklyekt3UHkvSkVJYXEvd0kzNU5KZ3Az?=
 =?utf-8?B?NnZwc1g1OEFST25Ud3RwNjZsS1diZkd6YXNCL0xqMlk0djUzaEwzTGY3RzlW?=
 =?utf-8?B?VFhFaTVoNFpHL1NKbzRjeXNLUnkxSEJSN0lHUUJoaS83bVRSSTE4WUlqc3Bq?=
 =?utf-8?B?cXlnNkZVTTh3Q0VhWDlmSnNHdTdjNHV5SHgvdVltQnl0aFQyd3NJSHk3MUU4?=
 =?utf-8?B?WnY0RDVPT0JjdmNFWUUxY0xGSDRIK29BRFR6NVkwK3dzMkRmY25YcE5XN2Qx?=
 =?utf-8?B?MTR4MjljQmg2WS9pSitJSXNnZW83VklwK3ZzS2J5dlFGNndKMWxmTFZuM1J4?=
 =?utf-8?B?WWk1RE1mWHFQVDRhaC9tWkl4OWpSeDlMb2tYbUk3Rmw5eDdkMVJSajhrZ3ov?=
 =?utf-8?B?eCtwY2N1eXEwOEd5WFZRd3Y5eDNkdDFWbG5OZ0twbFVPaXI0cTc3QXFQUkwx?=
 =?utf-8?B?cDVlNFB4K1BXV0FMSkJ1eG9NTXFyQ2RFczJDOGVYNmdhV3J6aWxIWTZ1ckxX?=
 =?utf-8?B?OW1rUEJhaWkvUWNBZVc0ZXRuNy9FOGd4WkZFNktjcUxzcysvWmtGbGZFV0dh?=
 =?utf-8?B?Q0JFalF2VUU5TjFKNVNKb1U0cmdpZjgraTdxSjdWL051SFcrQnJaV1Jpd2ZN?=
 =?utf-8?B?bkJDYWdrOXZ0RGYzTzNiMGZTOVEydnJHRFVhYm5iNTM4WmIvUVBsWnRraWo5?=
 =?utf-8?B?Q1lvMUxybjJDWHFqYjlzcGFKM1Q5Z0VGZERtbE13UVByd25Ed1lJeXo5Q1ZY?=
 =?utf-8?B?cGFENlJiZTBoaEpiZDJCY2hxYWUzbzRTN0xLMmdJaHhwZFBmUlZURTV5bnY4?=
 =?utf-8?B?dDVJVEFjVTFFajl3aXR2MHljZ1JsSGw5UHM1azY4cEZibDFYRXNUeUFwYnht?=
 =?utf-8?B?TEYwWXp1U0N4L0FQc3V1NkdMSVYxRUhhTUFpeHJmeENUTVRyd0ltWE5hbzEy?=
 =?utf-8?B?WXZIVlJsRGdaRkpRMEkxYk5SOVZkS21TdUtWWDlOVnEzZWNkSHVNQjZjZWR6?=
 =?utf-8?B?d3NseUVKTGh2Umd6dmdtVW1FTWxqblUxYTUxSnkxVGhXTW1ER0E1ZnVCbVRK?=
 =?utf-8?B?TFBFdFJ5QW9YMmlpYWJzb3NGOHRZdDVwckJPTE9LUUU3cDNCVzM2S0tXdlNN?=
 =?utf-8?B?cmZYaGtKVnY4NW1KSmJDSU0yd3hybldhd3VyUWJYbkNzM3YrV0V6YW5VaUNP?=
 =?utf-8?B?d3lTbXUwa0JDcWFrZ2VYSHkvT2JjTHdnOXJTUEhqNFpaNnRlVzJyVTB2N1ZX?=
 =?utf-8?B?MGRpYkUrM1dNZk9XR0JYNXNvMTBEZUpGVlJ2NEtGSHlnWmVGVWFVczA3SmZu?=
 =?utf-8?B?Y281SU9rTzlhR1pCcmVFVVd4SUpZVGhJYVJQR3VWM1FCYmNqQmNwbVg5N043?=
 =?utf-8?B?UTRMSzFIMjUxblp2SjNEb2J4emR5dVBJSnV3My9ua0FrSmxkTUE1akZQS1pv?=
 =?utf-8?B?WDU5UGNmcE01RmRDcEoyWkpTK3JyZy9SRHhudlN6WFlQZ2VHblc4a2FoNlJC?=
 =?utf-8?B?bjlBSDAxdC9WMWJaZkhUQTM5WGl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39175AB0587C6E448060FCA5470C9012@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SHGIU98Wcku08HpTZo+53J3reFRQefrUX+yTAtnJlfjSp9EFOFj2YoAlA4s8IVwRhUjvxeDFjWo2BrF/ohHfiBpo7ULapa1mv6gRIi68CrFHy8ZSed3ey90qHHJVMe6QsAN3Nzv+TUVOrNxuFM1jxVSkLUYTL/p9jD4XF5pHWu3YqdySmD5YkfspNoTgnXPxRhiokGNYEXUyL4dAM5sdM4pu8/OwjcfkrUTWUuStdWFh8QfoSwjB2wjypPK4Bj6i7rhlRFqQZpcrn7o1Dn6woCGqFrmVEGafYEzfuo8/aU0vy2cW58KNdTvwXYUz04J8FB8kiqGVUgb8zvhmH4Jhs1azF+sgUTtq0G86q72ULE8Q93hR3xr42LiFNQsT+TYQ9BinmlpriZHI9ZsDBP7nbRqHewIdu02Ll6CCR/q370ifvk7ytol7ERTqMwU4MhhosUwyFddPBg7uyNqozb6yH1kU1eOI2f87Ps//Gkep1kjQpyZ4MMACYgExDIVzOYSvHdiC3v4633oy01aw/T7NEYg3n3Z+8CWewxOWPnQRFdk5Rc371+/fO1a31/lIS+J+YugptPlw+q175UDqmCLFZcwGO2/qGA3m9I/KNR8CgXaIz7f0I5+Mn+YV4IiUja3n8vznM+eikqKbYPYShPzMUjhVjGdLv89qMWft//RRmgi9xCS+/SBOR5JEd3poY8T3UEAc+oauqdyLlEm8V0Hvc9zkSLiiV3meTF5wpV0S+WO1nlgj3cyi0RoolKyd/IuM+nGXicZdLFtbjjgLAPYUoDSJvCx6VnAWud0dVDl05iLG8KkfRtnWgyG4mkA5nT4utQG0lmGgrbMOqa9YAr6AujY/+0enIRC9OZLDFPBV5P6iDFZ5myf+uA/RXbBZChjJXCdvbNmDiuPjEC0sQ+PWcgJvd1IUibExjx35Bd50sEE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d94fb2-6757-4a4f-b8f6-08db76e1ddb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 07:41:06.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIVLJvdZ1lZtbLYX3QN+f7BzRpfMFHVSar04DBMsTQDUHa6kGWT74UWAQKJ2oRjDGN1V+JnrWoTteu16ihNsshHg5pdt63BNCOIAEVOJwuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8067
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
