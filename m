Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DC76B46B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHAMIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjHAMID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:08:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672171736
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690891681; x=1722427681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=pb77hXBLcP28BwxNCDuqk+qSSzx91KcNb3l6AiIEFg0TwIaFa1txl8CW
   mYSOBNSaOOI1StQB8yFvwrcbVANJkw0o/TrFZIuE/S641aDaPRgwjGa8S
   AkXFFYF0L+/3DWCyItx0AKSjQuERsPSo4f4AWCykQLERTFpjwol6iYL4W
   Yys29tH/gB0XAFMiX3w2W21tGeDtmOd5dHun01QdOau7sYxoeN3Jqzwb9
   uYz/vxhey7NHjKksN3BHwWiB8z9TzCPPRDpm/EEWf4RkD0xUmVFNcvfrW
   vc70CnITMOfR0WUHjrVjEXtLFPlR7fYpiOzkM3wrJDXoXYcLcrtrkc/ij
   A==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="351776101"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:07:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFMKQiQaSu9wKzpNndS3WqodxH3IQf4aySbZGcvzFWQmwZo8n/U1KwlvB++cHfD/EH2tSvSXF/C3MK8nNH3MWT5g5D/+nmnsRbEzYU4UEhA7h5HWKxUIIqIYmVCCsaSsQl6IyVO40cGErJf3wCjKf79h4z11wb3ilLcUQKHf9NKzmPiJ1x5hZE8FSlvlQArpFe0DsPqBMJ1qtYxdzDVPWs7YCh0usxEKLHZS2etvrcqAxLIsFnID488vv+lf70btSLjCW/VEyBGCeTpLlp/XluPdVwI4Bini5vGHfSMKmogo7Zl77oVWw1rkO69VtY5Nqj5GQXNQbreYHT4QlwAZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=YzNBqEDXjE7/CI7VEScY7leiU7XxdIRtYeMVzVZ8IHSZQZ8D8e/YTJaHiISl4PyECNk+QAFmTdxk/vgv8HeJw6a76UaBb+YhpVu54b1dzb514cra6ITy34cedOmSrJHoSQZ4ER/eRuqwKtUZmA402WOhXyAV0ZMO+yrZolygNsU51DhlOgbAJTHYKJsSJVohoxFyVxkT7U+g7YwoDrAf2vZ4ku1aGpTxGpWC3CGytzYztLgWUhpMNGJ5lk+SQGoKOtQ/wWqDGmaL0pfEKYxxdBfoqcZNAyMPd8odjyC5VN0iEVCOAQnlZHlvJ0VsphhDuuwBctDCodjtjozrpCHDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=jGRTkLEGfENGp5FvLJGlCEc9ObaxOQ1FHmHJHD73o9LsRZiUQH1Pn4irc7njN//X4YkUw8db0X6L7GFbMsXLTqcqDFHKJLXh/5/Q4gV8dGJC77Oe76CUueHlajqQU8BjPOldl4gmi1gzV0W2PaKbPuIU8P2IrU1U21N0XM/erFo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 12:07:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:07:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 03/10] btrfs: zoned: return int from
 btrfs_check_meta_write_pointer
Thread-Topic: [PATCH v2 03/10] btrfs: zoned: return int from
 btrfs_check_meta_write_pointer
Thread-Index: AQHZw9NV5ftvToK2RkyC1YH7NTF1Ua/VWfeA
Date:   Tue, 1 Aug 2023 12:07:58 +0000
Message-ID: <915b8e08-a757-4f64-acdb-4227ce557e96@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7278:EE_
x-ms-office365-filtering-correlation-id: e9ee01bd-ecad-4a6c-89ad-08db9287f207
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YAUX9607otyp5pn3DIxzKXuXJJQgr2qF4TuViwo02eK6peVYKuU8VFTRDZw+pBwfuI01NXSDdw/pKXx32tuHYjR1Vw6QG3hJCzGhC3DzXgh+tvUI/Lwo3RCY2wyRZWOeiTvjzw3e7DrZsbdQ9tQK31IJCwz2e0VQ2CRUy7kTX41kPT+04TU+GVTJTdW1iFIMhuvenU6Ag7NV202NAEU2ZxZEJOJuqcfQaVGcdLXoGrXFn0XZRJqYD4Zerod2qJq+IG6MEFjPuR19lAg+Q0Op6Ug7QoSXjTePZPe44EBHOmDczYbuBUXpi/jN3wd6ngD71N5udi8aS51FCi2O40Bi/05AMh6EmPcC5LPBIRxlBItqmzCyXHXc4c952kvohFT/0suTGqp5MEHaenVRQuLQXqBNs+p7RuKef3lpIHc5nSHIem2OgTZvbeI7RLW9//StOY1e17B6Nh0Uh2VOzfvqw+cIlDwhGfnsqMhUEbPOyDWkYpBlTu126XsqCSWBu9Qd1hqw9odvsIBL8F9sQBsyyy0+NWmrOlzVAZ6DC3N0HIdj20fJ4R2WVl/TE1C525P7wwvJs6eCl/SGHAFZG+rlILAgqNG/Kk7UfAdtLUwXitzw3szvOaedvEgAowHig+r3O8iFiFo3i+I/jKjiT++wtgc0AVWO7WR7Ju6HwxLKbmuBChEnJ2MzDCSxAaWaZug
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(2616005)(5660300002)(4270600006)(6506007)(8936002)(8676002)(186003)(76116006)(41300700001)(316002)(26005)(4326008)(478600001)(54906003)(91956017)(66446008)(66556008)(110136005)(66946007)(66476007)(64756008)(86362001)(6486002)(6512007)(71200400001)(558084003)(38070700005)(19618925003)(36756003)(2906002)(31696002)(38100700002)(82960400001)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmFjUzFpOUFBelg2c0NmSmM1N3NpcUc5enNTQXRsSXgyYzMrWVlBalA1SFFC?=
 =?utf-8?B?ZjA0Um9kcTIyUExzYTc3c1NtODJad1BmczdrUUZVVW4zbEwxZUdhaGxmeUV0?=
 =?utf-8?B?RVcrcktmUVdkTmVpSVM5N2dMd1FFM2E2cTQvVFVvbzJpQ3NkOHprSi9aZHJG?=
 =?utf-8?B?NlI4alJSSTlFQWxlbmd0ZmdYUkNOcVQ0SGt5Y0wva3orYm9XQ3o2YWxqNUUv?=
 =?utf-8?B?eGpBWEF3NUkrWUxIQkZORE9PMHErbWRvUzhvdWVaRitwaGdaLzlmQ1JjM2t6?=
 =?utf-8?B?YzRIclpqbld2Ly9HdU9EWGo5YkZMZ2NadFlEOGJMdmxUMXE2Y2JsWVVxMlh2?=
 =?utf-8?B?OGhscFQ2VGxiQ0Nsa0kwQ2FydThBRFRlb2JtKzFpeXczSm04NWFWL3Y1a29k?=
 =?utf-8?B?T3BPbmRYQUpjKzhKY25kQ08rdENVVDFNUG1TQy9lcTVqRmE3emdCODVwSU45?=
 =?utf-8?B?bHB0TGRTdmdnVFoyeFpFZ3FXS1JPaUpoSWNYRXdiYnRzZUIwNmZJRmVGaWlH?=
 =?utf-8?B?VHZ4TUpnTUhDTkprZkQzenNEVHRTOTRTY3A1T2NCVmNJWW1jYS9Wbm1XcW9l?=
 =?utf-8?B?WFZzUExBTzdZSllLU0ViU01HYmNpRktZeExPaUFQWGpuV3FEQTQ1bXlVdWZy?=
 =?utf-8?B?MWE4Rm5PSERzNG9JQ1hmR2VGS081RWNHbnhtS3hMR1FXdGZFYklDdXJJeG1n?=
 =?utf-8?B?SG9XVHNRbURHb3RmaHZ1RkwxZS9Sdm94eFJNY3I3bzROUlJxWVZsTXY1dERh?=
 =?utf-8?B?aUpBNUNIUTFtZTBCSjRIM2hqRmt2eWRFSmJDM0cwS1hGMlJkM01OczB2VExU?=
 =?utf-8?B?MVp6TmJ4aFg2VDU4RXpGa2UxWkxFdjlFR3VBaWs5Ty9sbit5WDFtWFcyNjhH?=
 =?utf-8?B?aEZ5ckdFRyt2a01ha0tlTnpoVWY1djFSRVNVNENLUFovcjcwdDZ3VUhCaUhh?=
 =?utf-8?B?SDdmMXowV240bmRxQVljelh4dGsvYS9zbzNpYW8vTHFINjRLZG1hTHk5ZXRD?=
 =?utf-8?B?ZXQrVEdUWnNqbmlRSDgzN2xuRjhIWk1iSlJDVEJkTGhqNTU5QlNHOGtldENm?=
 =?utf-8?B?NTA5WWZWU0hYZWtIa0ZlMzg4aU1SN0h5WXVmMHhmb0xnZklhTXdSOUVhSjVM?=
 =?utf-8?B?VE5SSys3V2h3Yy9jb2NKWTdEaHhwRTh3K2drSVJaWTRicXVXcVRiZGZpazJO?=
 =?utf-8?B?enR5T0NuSkVzbmhXejhyN0l1OFJDc2hSNys4NHd4WnhYNnh2NnJnWFZaQkRX?=
 =?utf-8?B?cmg0MEw1MlJ0VEk3TWxlN2xDODVJNE1HbkZqTWk5L1Y4N0c3RzhMU09WNnpY?=
 =?utf-8?B?N1RZSDJCM3pCZmlQQXB1Ni9IUjhUUjBxMSsrUmp0KzRyTmpQL25LVzE1V2RB?=
 =?utf-8?B?L2hlSC9kZWRMY1JyN2d5MzFNbGVLKzQ4UWphbDJ2MG9MQUJ0WGJUTnZuMmE1?=
 =?utf-8?B?QUUvMFJxVmRtZ1U3U1pwNHFhb3ZZT2pNUW9ZelVkQXFNQ2pCa3BUbi81VStM?=
 =?utf-8?B?cXRNcnFiUHJNNWNicithSXFLTFV6UHozMHBFS2JvSGI2VU5wWWp0Snh5WkQr?=
 =?utf-8?B?WjVYZkFnU3V3Z21uVEJDQ0NnK09qbEd2dFJOVkxxbW8xb3ZLY1dxYjlHN1FJ?=
 =?utf-8?B?aGtSTGdDN2dlNUY0WlJ3cjc0TStPdWRWN3ZVK2ZkQXFPcVFweXdPUHgzalEr?=
 =?utf-8?B?NmgvZXlmK0RMQUJsOVpnMitRRUpFMUVFRGdWVTlTdUdGOEYvWWMzRFZvT0Zt?=
 =?utf-8?B?MmRVL2UzaTZ4dWk4ODZlbHBQY2FPZitqTWhnQ1A3a1habzBrcU43eTBxb1BO?=
 =?utf-8?B?bS96anVIY055KzM0NjNXS1FwQ29kK05vRnBJbStuOVdua1BUeDZFSmtpODJP?=
 =?utf-8?B?ZW40UkMwNGV3NTZsV3gxN1ZzRUtSNXl6NWhRQ2JZM0hFMkgvWFdyVjIwclJV?=
 =?utf-8?B?Q3EvWk1IUzJyTWRIaHk1cGYzSTlQaGlWSU02TXZyK3c1S2VUcy92NWZ5bmVR?=
 =?utf-8?B?UzJvUzBBMmRSdm9ZZmVSQWx6aFErdFk3cGl2RjFIU0lyNXdsYUVINDRFRzNE?=
 =?utf-8?B?UExzaU80Q0N5bU9IT2NQQkFielh3REtMREIwMlRqUUxXYnA3WGdwbHNtUFRL?=
 =?utf-8?B?clpoeUtYY24wMlA2VVdJN2pocTQ5QlYyWTV0RDBtbVZqWk85WEhzNHoySER1?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3415363BD2C65F4BBE79D865D468ABEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Pz29mN9s39nmUqwCHag6tH8tL0tyktBNOMWuFisBz2FEjvl4GZYMakMoNKNHk1ozJkvSFcO+ELbgXPSNBXPZohum6hOrKHiTnf4i0zO10ifx6fH4ggAshI4NGYK1GLruILXTvc/GNgYNOay//tqDwFl5ylYo0usSzbIeOgvVhmwkAMulODieZfn/yW9yCEIBzOib8A5bd1YVk4TZpdABpLNi0JT2M74y68IUjhh7yOQkAejLPM3MHGWJHe/op6+vISEofpxwAPfZfTuS3BS8zBvBzIFK9FQCzDWOnRZPRaOsQKGnsP8uzgLgyM2XuRqvU3KdpBfQzTGSpTGHizoN7zzHfR4X+4cGjTbHr0dQIYwAqHtdbB7mSkDNdAUf/YUrDX+DbQpyknyWzOsmlU5wQYzOBEiy3o9b4JP52O+Ln8sb45gaHiNJOxms5nDfTsZBBcQzVhCPrEKC74Q2qKBF2RcggZY7FvjwV+DcxMajK2ffFTOGru5KYTBeRoJbqPQ4tBmY88NlPtx9KBJntPQ6W/6dUBioGbJ5xCrzuE/LelKiDx7oGxlo81PiLqa5ujex4ocMf/gImkFRSTsm2Fz7cKlTqMf9ixKr3a8fD8cj1HPWL1w5HvHMwKBzXHhI/zzUD610OK4KlTYGNoDn8TVA+zxNRo/bBjD+GiEi8FbeqPZboiwEDvb7hqTqrpf8adtoizVjnkI+OXNGOy3wOdnO4lCTLB6+YhkYSh/Hy/e+hwA5mdyp8Gq+p/ChjxcrWqe5rdPYiwsl7f7FFu8Z76IYlbFEslw8KraohVc/x0ZuKafCUF0amJOkKgTBXqAax2gtlNeObwdZEc1FIVOKgiOe7xIIk715P9v2QVbqQEmGjuuzET74s5hkOKM8sIGFu8k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ee01bd-ecad-4a6c-89ad-08db9287f207
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:07:58.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TVNbpLuwD2kflDDXANWNyPWQglOV6zYcDfckP6ap+LcVwyjey7pouKa2hdnbBzvBvwVZmeGc5/z3WlgYpgEPEJJkxCfhffmbL3GAGRaydE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==
