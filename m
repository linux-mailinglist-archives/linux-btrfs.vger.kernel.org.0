Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42566BE6F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Mar 2023 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCQKhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQKhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 06:37:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31579ADC14
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679049438; x=1710585438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rzxno2mK36DHBrrhPYnqRkWMOtX/fz8ppY8t7yFqcYucpxuw/rti0tzQ
   EK2HMEWXEqoMI6poiomjJGTo7gW4bUcpXu3PWi5N41YhbS8CRNubz6OkU
   4qqQNJVXT57x7I7TftKHDaxk9dndocIVKso48eAWQmxFVNs6RLMP1y+ss
   BQ3yeus2HsS8k7uiU+ztZ5tSZIYZyOZbwKrxPQEBzjh+0IZAm+XdPi3QZ
   rZBfysAcgFqL4ggmvYjZkhK7wTAA3OMqV5SMvmjtf9iw2Gpe6HH4O89GK
   4IxX2dod2kxMgPiR6EatpkMtn6sDxUgazXcP6IZvNZiKglOPSMbe2JCJ4
   A==;
X-IronPort-AV: E=Sophos;i="5.98,268,1673884800"; 
   d="scan'208";a="330258510"
Received: from mail-bn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2023 18:37:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJKeZwRy1mlzlYc0yorGkCo0XdXDBSqFxGu8o1ef0WiTnfXMFMnKpXZUzsTuX72W0r3Tk1zbVHgHBoathmH0L15eZ4Qmw89DK97h6Fp9SnsQo30lRA8Fvw8/KSnI1wZaH/s/gG+mgQOQdjEdSo0hA2OGWX0gNjd3RayKrzrtS77sUJ5RpBL1yTI5IPSyLYKS5Lh5uX1zgYjDhPHryxHRptW0nFneehjBWkMtmslLeyOfstXY754OsrX+AQ7oozerNo0AxnBpzeXea9qtAMFrVxgF1CoBrBiieky9eImY//VPC+TPyhS+mNkMX0cqxd72fm4FTDtsWZueOMdw3Dy4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=jLfsINERs7T0dr0g8ZGw8vmzEvzWF11/N8qaUNxGi5FfPL7g0YGaTb0Oo1yAYRJbLX8VnuO2nzehCMejBCKfVd4RjBnIqxrW/YZOglc73/AAUFWJlWZf26g4REubmR4GzkOL+SpadPmMZEDR62DRJFOXeyS624tgTVzJqr3BgvtjPGWRIFZDrpRVIBBFfp3ACm97xf9NASQEDVJQJ85E9UMguO406dEUoye82QWk4+wddWV0uekvXcMQ60d6N3W1xzIDewL7dBoeWb+QJXGnZmq28XqlYncwaM9BhOlpmCx2v9fjKTcDeP1OIL6wRFvGWTYQ+4r64BhGTgE7tGNx3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=x/0l5ODfFOD7H6V0StWOelouTxTmrj0u+1SgQZwTSe5kz4HTIfkwQ0QCPzBBwOleeUvZU0/w5Wg5F9KKcUEdy/09+4jwbYMoSlwK6il7O7yKlUxg63Beue/5QbfvUXFUPrIeQ8v9TK/MqNzBCodqkkmxBfquyqKbFa4igLHJzaQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7545.namprd04.prod.outlook.com (2603:10b6:806:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 10:37:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 10:37:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Johannes Thumshirn <jth@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: remove confusing comments
Thread-Topic: [PATCH 10/10] btrfs: remove confusing comments
Thread-Index: AQHZVpZxWukMH9+p/0a1S+0Voz9qX67+y7GA
Date:   Fri, 17 Mar 2023 10:37:14 +0000
Message-ID: <f906efd6-7fb7-174b-f01e-652c9609357e@wdc.com>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-11-hch@lst.de>
In-Reply-To: <20230314165910.373347-11-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: 89b7bf37-e77b-40b9-1af1-08db26d3928d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 835DtwUD2+JceUuZEjfWvSXThc3xyTsNcWeD0AjhOKC4xBc0JqVePtCG33QJhguVmr5eNAHAtLivWz9aOEfBXmso4KB8M+ZeK+5iczXuuXG4M2hDczzo7Lcq/QhkukjMxxfacRM023FYLofTG5nsKxyaCtePBc2lMqwHuRoGWSZopab+F0zD1g8BtYudznJM32RBm9degdlzpZyErisl4V0rzWjgmx4qKXoSsw+SL7jm/xJjiYx9RUUn02dV2l4ZjXb36bRbBDyP0mcWSz+CXkWR1kRt1vcGt/CSFlrWtFTL4hWYuzvxNks6Ep+f8yK6ESSZlIPolmR7rOBDXzYbdqpIg85Oolq0RJeQdjCaUgB5yvQipxFiZUbchtknflG6HThrkO6eOU8R2ypOr2N+UUXh0Ef1qXKIzisRT6ZskIO6fFs+you0PfRg/MS0zu6S3c6/gK56SxqSHSJIr2uHlnpaNlbmUxd1EdRr4B1cdiqmQhlvY1kTYS7CJTQvSfJpX/DKm4ePUlNfe00d0ojlV6Unv3Co7Ex50p5cgolOZ6UosDTmelW6bJQEa78tldE5Y8Fy+26u6BZB77v/3BEb4zJWjZLuR97umTieRXW6RLaZnZrsoLk4hsMLqKNBsFYmESlQ5l4A1mTsUXYIXIDILNZiKgbOIDBFnQLpScHOOGlNFrJ8BeQiNtFnYhnY3iiLKKKxGjLdHlhsEZafy0vQ0rAANqzE/9HfhFm+NGk9tmliNg9NFtEZFMYqxRcnYA5GslzQBvz3wythEQLFlNCUbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(66476007)(64756008)(41300700001)(36756003)(8936002)(8676002)(558084003)(6506007)(66556008)(4326008)(6512007)(82960400001)(66446008)(122000001)(4270600006)(2616005)(19618925003)(186003)(5660300002)(54906003)(110136005)(316002)(76116006)(86362001)(66946007)(38070700005)(31696002)(91956017)(2906002)(38100700002)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDZpK3c3cGI1a2FVZ3Y3TzVvM2R0VHFiQnRHUmY2VnBNczVHd09FelJ0aHdn?=
 =?utf-8?B?T3BVTUw5b1lhY0RhaWVNdkY3UzlxQ1BhcVJJYThiaVRIbVdYL1l3alNQR1Rv?=
 =?utf-8?B?bTBZTUY0TzR0eVhuZUU0RzdXS3pWcVQ1bGdpZnBxQnEyaFFhYkx0VnZsSTRS?=
 =?utf-8?B?ZFg0OHQxVmJPUGNYaytEMFhFbElrbGR5NDRpZDhwdWZLSGVHUmNEbnNYQU9r?=
 =?utf-8?B?RFBXL3N4cm4ydnVxWDMyRlBGeHFQUXlGeEtTSmhBanA4WkZCazdRTjVMVkRN?=
 =?utf-8?B?K2JDM2NINHNNVzVkMCtRTjFmMk1xeXljdDRIcFppWExoYTUxM0VFczFnMTE0?=
 =?utf-8?B?WFRpZmFLQ0lncmJRV2VxYmJueFd1WTJoZ2J2U1Z0V0RsYjZaTks0Zi9kSWJ5?=
 =?utf-8?B?MUMwTjRYMnlXQVNkVW5HS2FKOGhGTDNvZmNHVVl6ZXdyYTBQam5pK0VUVTRV?=
 =?utf-8?B?dHdkWmlYd0JWMnQ2S0JCeTNnTkN5UVNydENjaC9FU3B2dVY1TXFKWVZlUHJp?=
 =?utf-8?B?SzNjKzFtMmRFWHhaWWQwVnB1b1lQY1FvRnhsRTIzeGFKaHdocGhaZGRDSmVy?=
 =?utf-8?B?ZjBZWW9uSEFvZnFQRFo3OFZtZERzajV0YVkvSGNHWXFBd2pWS2RML28xYm9M?=
 =?utf-8?B?aG9CYlRIVFNSZzZWVnNvUGMvb2h0T3BRaDgzRXBqMTNnZzBzTkRSMjl0Y1lh?=
 =?utf-8?B?c1RUdFRJUW0vTjFFaHZPaEJiQkhwd1RjendGVTlXdnRxN1VUc0NlSFFORWMv?=
 =?utf-8?B?OWZhZm1IYi80bGpWNjQ3YXViUHRiTU9Kd01FUm9kSVM1ZGhRSFJ4WlhsMUpS?=
 =?utf-8?B?N2JZMzBFVXkyT2tTcmdTMzI3UFdGWG5TMVk2dzVUam1oWlQrb1cvdVdUcjU5?=
 =?utf-8?B?bWhkSHFtNFR3WS9XbXFnNDNPTzJDcUFYRldGUUtsOGljNFkyYkJVUW5qcXBG?=
 =?utf-8?B?R0ZvbFcxc0dxWDVjU0EvKzdqS0VJd2dyYmJCMDNFa1VITnczcjM1ZWN6OVpk?=
 =?utf-8?B?SEN2M1JkRmlRZXNTNndtVlp1ZC9hTEtUQXh1VzRPMUllaXFYMXV2Wk9nWWIy?=
 =?utf-8?B?OHNtbzgwSVBOc3hEMWhIa1I5ZGV4N3J1dzlrU1d0N25DdFhSSjE2OXJFb29L?=
 =?utf-8?B?WEZHSVhaUGwzUTZQYy8wZTN2Z0pHaHAwekN2a2U2cmd3eHZjNFk0NVRQNHF3?=
 =?utf-8?B?c2txdk9uMS9LNjNvUm1DT0lZaTJlTUNZUytkU0VnQnJHaUZ2cmRCUmtDQ2Vj?=
 =?utf-8?B?YXllRmp3ZENkRUNwSnhyb0pPb3p5a1FKL1RCZ0hFd1Ircmk0bk9kdm1Vbnkw?=
 =?utf-8?B?WTRrakc4ZVkzRDNrZnhKU2l2Skd2V00wRTZJcUQ0TGdRWFNESHJObmhGTG1T?=
 =?utf-8?B?YXZ0dm1KdjllWTY2MkJ2WFZGZVpyUzdwZUVOQmN6QlAwVjZnOHZBeFkwaEZa?=
 =?utf-8?B?MFp4dFFhbExlRXlCczRUbGI3Vmhvcld5ME9lM3Z0czZoWE0vdDVMQXg5eXNF?=
 =?utf-8?B?QUFUUEFXSnhUMDZHaW5CYTROS2ZLc201LzJCVnNFRzZMMkV5U1laTk1mbFg2?=
 =?utf-8?B?THdXMWowWW1qRFNYeWU5MGdLQk9HUEJWZGUxZDUvSjU4YXoxL2RaRU5xdDJY?=
 =?utf-8?B?djlDYnRjQ2NWVUdoMjhuL1JmZW1jSXpJOWNsNFVCZWluc1pwbURMbkhXdWFq?=
 =?utf-8?B?UkZ3OXAreXFTc3dIc1M2V29wdTkzSDgxVXJqZkNOcW9OUzJsZnpWaW1TMlZw?=
 =?utf-8?B?RHlLYWRiSjJRcWJUVm9sN0ZCQXR3WmNkdmI4a3ZERTlMSG9MWkI1RUpnZGZI?=
 =?utf-8?B?QzhxeGlvZzQ4YXk2Qy9MdGZGR1FkU0VTQlpjdklTS1pWbkdTMTFEMS9pS3RQ?=
 =?utf-8?B?VDhKM0EyN0ptSnlQUys3cUhFbUlIenpGUUVRcmdOMHMxc0J2QkdPZUdwTzNm?=
 =?utf-8?B?VEtzTGNxRGtpVUxDMStYdHhqcnVqSjFDa29ybU0vZDdZYWVtZjRhRlpzVWJl?=
 =?utf-8?B?ekhQNmNrWTE0SEhyam9WSlNXdWtsM3ZocTNReHo3SXpZYmtud0k2T1RRYWNB?=
 =?utf-8?B?djFSMDNhbis0cHVQUjFBVDcyemxlNHh4aEprVENCSk41TVRHSXNmMkFVT25J?=
 =?utf-8?B?a0NZd3FyclRWWmFuNjNENGpNQmQ0SU1SdjZ3MG1VT0lMYXN5eGRSU28rS2R6?=
 =?utf-8?B?dzdDWW9TVGVBcDNpN2pjN0RnczB1amp6NE9aYVhpV1JpU1dDbXRPdk1sZlJP?=
 =?utf-8?Q?8QZhxisf2CYJ7iO8A3GvJyj3812yNLAdRlZdtUwbn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EB27A76ACC59743B7BF38319047FB91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RKqKZBqwVckiqnHnniraJEJoo7h0qOTe9ytEHiU/XkTu6Ve4LzbObXZz8A0aaD798OGfCXK8i3gAjDahVgXHroGdieNOGJ22s80DtNtdexW7Oota5yKYc05aOfbmdcUnrA8JaHv0xzoGEUGMFlrlc0LXom7en+WR/Bt5jtjNAYeqljj/Lgi+bNcQuLKzU2J49K1OwdZzo/OT87BTLdUFNdI9t/rJ9U5OTFptRVd5KW7IJQg6X4Z6z1pEFDutXMjVlap8ehf+Ryc6Wy+4EMIQ1/f8CYKQi9DitVpb7cPH9MT1EozlJyEHC8wtmJ+WYu35GHb755ZrtJQGS3MwKEF3qIN7qUM+6QvLxMZb6vNkLFca/iXheN3HTvIMp+MO6bDgcCBJBzMcTvabjnVcqHHd++3K6jIUiew9OtKk9kdXdIyeU/UpcMAvhRsFULTt9u5ygQkfhxT/zyk6uQgpID24HCqEK6UaoS6jv5qqN/yxJXzYA3KnLUWOHch1906EzqKYs+Y2fSMJMYV5tFOwkZ3oyYeaVAARxbNzZD59zRjEQ6V3T5LCaLo2LDLqA8wEZXhqyFbnbw9N7xlMeUEUpxIJqWHe8BDb+5vxpQncvk7lOtS6GQpzxcTQvF9m8J/aYc4ePgSzE/FsEhLjdNpJB5gyD8jd0JxfWH7+/0bddblxiK3squmr+S9WK9gFNpwaynl61HVBQ/+sB7BZKEp6SkmfpxNnmwHqDZ/OSu5Cvhk4diZhRGfTRWeZfZGluwddUoCO95Uhzgr+HpswgYxExozUayGo5ivGbXTldXyM0SCSWyHEehBkaheE4wyWjxxwsY9UnuIKNd8A/SkERcqbjcp222eWCU6ZR1V6W//mjo+HZIH1d3kWH40WTEMfV9UNzc2GU2OLH7zoroX69uV7HktQXLEoE5fatpwTAcp+U+FtN90=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b7bf37-e77b-40b9-1af1-08db26d3928d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 10:37:14.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHg5LsTTNHn5iS/c+uhnK8EOFpVdLNeHQ5pU9ewZ8wSqHAy6ROni1vjfRAL86QDFgT4JMUMoNP7+jSj49Ftn+mn4guf/P3QZAZh/7AsRt7g=
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
