Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061376B43D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjHAMAl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjHAMAS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:00:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0A51BD9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690891185; x=1722427185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wuEaWmHkCiSDUJsQx/y5FtZtQdFQb8bINl4WlC4WLyE=;
  b=OAVazGN2017GybORe2TgTeNBuQZRlojeSvj3+f2Zm0ED6XLYQHsaxOtN
   iESQ4sO2EulXak2Dzvp5B8VoSBG8FYlnybRDuHSLT9oHjW1TZ+M4ZS0vU
   6efSyiITrJyKBt1KPpwz44UWBE5YYcxPWDyLtzZlbiN0CIhF0SKX1Nkrh
   gRJ50JsqAYyjhHSUxCB9kq5ksrMYG8g+zcmZY6vZP4OY9GDstvT+zPMFp
   H62LbmseWyp5AHwKuW4y59WOBln8dJ11WzGuJ7ib1MrqVP78YWsvQdevW
   lTVAe3B2pQbEqPRsEV+JU5n/KJjnbxi6AsDf/B0m5qGdHQ/u44UcERp7+
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="244373608"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 19:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juFrXHmxy9OAqfYEo04FJ6iwSig7L3CAhW42VprW5Uewhe6F+ZXHh2YmlRL9Z3YZZEIM22eMZeWxCmyKFMgB1syp0HQWd7/XXTDtavvN9su6k6daBgz/I4pIMZzt9xGUKR5fW2w2UdchUpd/e25dCRumntUNfCCbPG7WLeSA8/itc4ZI21tyvDWbE3nmLJgr1hkXbuYJpMNbUKZzCd63piVeMl7RxZ12iRxGhAoUwh+f/9QMZgRvi9GgL+D0Qrk2PT14qoqZgSYF9E3lt8OEAmmq4Kt7FgNUf+jpWAWSzb+xzfew0B77SJXLnX0iO7sHFqidiJbG6sqSLyAx3ImkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuEaWmHkCiSDUJsQx/y5FtZtQdFQb8bINl4WlC4WLyE=;
 b=nGaOSrYYVOZJ0WJkyESw280sWwcQdQR5cLJXYAIrhF0cE3TrQztku2okMyzsJcqDQAiXiVMxsYKbVM0xGgIKu0DCvvC0234F38FqnVx9+8dtgv1WmMv4C1hsgHNa+Ua5j27SKu9ZqacqGdO32+ibc9Fv6v3LD49B9jCk4S+EnhawenvpUxAHYBt6LyFNp8Ekmcu8bs3/KFXq5cVQvsyNpZAm7t4aUzf4jYoY3ysM8J6WemBqWTCTF4+wfG04oAiGNz9/N1+MtzOeVJsKSFYi4jGx+DpeSPo19V53ZoKJ2qf73gt7oZeLbsk8NC4VfsDCMSrfMn7zWF9MyBocPR1N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuEaWmHkCiSDUJsQx/y5FtZtQdFQb8bINl4WlC4WLyE=;
 b=nUwQJPyM/jK5qvSjMJGe5FXffNlztNjopglyLrSqDUn+pkeJHd4kKeXiok/kRBBGoiGNhS2v50J7ywy+cvz7yC5wW5y8OmwlKvNI/yKvZUgUJH3br4SboGIfd1Ao2+CtbUC7CtbTfRYtTgnc/II2sV1pqVYxRRo+9wMrlrrHwvM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6796.namprd04.prod.outlook.com (2603:10b6:5:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 11:59:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 11:59:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 01/10] btrfs: introduce struct to consolidate extent
 buffer write context
Thread-Topic: [PATCH v2 01/10] btrfs: introduce struct to consolidate extent
 buffer write context
Thread-Index: AQHZw9NBqyYbZUxaQ0Oinvr1jSiWfq/VV5eA
Date:   Tue, 1 Aug 2023 11:59:27 +0000
Message-ID: <7d90ad75-67b5-8933-8a7f-c008c20ed3e5@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <1cc8f3a21680d196751171f09ddb77b9c14a5b9a.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <1cc8f3a21680d196751171f09ddb77b9c14a5b9a.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6796:EE_
x-ms-office365-filtering-correlation-id: 1cf035f1-9ae7-484b-72e0-08db9286c1db
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gx9MkV3YIM5b5eWMfFbVmzs1Y/D7lvAmdZzblmaZwP6ZSwl2Ha0JY3q4UvREtKtzhsJlEDS1e86XQaw6n5rk8a+irexE/cFsDw35RUi0nWujBlqtHxQAIFyIxoZrvvfAwDaoEvznrlb7Ubj5e2CORuIABG+j6QFmu3LMb4iYdFDDuKLmeKHJolpJr8x0Q+1rwKt5Dlt8LR/8/PiDPSmPvBTo1rVoKFWh7hlRApB+RblsymKRA4j2V3ZJaaMip0olCPlCVLK4QS7+2wBgkB8KUh2YjM7pQbkyVkLp44lOWFUougctgmVEk0wnOFIm5k3YnHXNAoZjfgzgdkffpDchN5OqkH1gT4nM9vVecymnTIgm3o/Yr9WnQLFas6m3Wvqyzcvl1b37R+T1IBQDMb8wnudPmJiBhNVMlSzV8RvaAz63L6iKjkPRB96d5x92f64Y0AWFiSejm6uUMXQ6bg6yqZnoL9kD1QxEptiTinEuAhIGSUu1xYDtxAcdyJnMo4VbIWhMRtAKj/8D4c7MMxhlxLjqo6uReP6ITaXx9TDxJg7Zm0IlcEht7kBWmhMrDqoZdavbZUllRU5sTZG+hk7W7HfS3AYGATzRZe9uB3ZDU7edeVgx0PZ2T75HYN63YqZrUYUt9MtTmlaeaszlvW2Nw7E7T191M/7kfay/9pDFCDpxlJTGisYZD2478EHdGwSS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(31686004)(6486002)(71200400001)(8936002)(6512007)(478600001)(36756003)(6506007)(54906003)(110136005)(2616005)(26005)(4270600006)(186003)(2906002)(558084003)(38070700005)(5660300002)(31696002)(8676002)(38100700002)(86362001)(82960400001)(122000001)(66946007)(76116006)(66556008)(91956017)(66446008)(316002)(41300700001)(66476007)(4326008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3ZpbTRxczZHeDVpeHF4NXdKSVZ5VnNhZTBVelNqU3c5QjkxakFyV0lWdTVy?=
 =?utf-8?B?SHErM0djcUorSUJTS3Y0MVAvU08wa0ZZR0hsVzdZUGZFRFZ2UmErTVRkeStv?=
 =?utf-8?B?Wk1Zby9iQ3FnN3hWK202REp2NFlZdmlueGVvaENhNUh6dkhzOTc0WFRuMWRi?=
 =?utf-8?B?K3R3ei8zcW1ncllvbWU3Ry9NYWEvTzBmOUxtT3g3emtCV0t4YmRUR1ppekp0?=
 =?utf-8?B?VzVnTldDNit5L2hMbnVBeURKWGxLbXhLWm9mdU03OVduSUtzVFJJaThqcis4?=
 =?utf-8?B?UTI3anNPZkRmam8xcmRGWEUxWDJyTW1jUmJYWmJsR0I3UHRXdlFZM0ttdmhU?=
 =?utf-8?B?SnpZdXhySU1OaEVZR1hXY0RnZFE0cEM1UzZvZG9NNXVZMzhMQ3piM3RvRGR1?=
 =?utf-8?B?L2wyOXUxbXlVSUxPKy9sUjBMSFU2blhoVTV3bGh1QlpMYit6SDNtcVFaNFFx?=
 =?utf-8?B?Q2Q2VG1mU0YxanJIL0lZWUNYZWtvZ09xVk90V3JYTTIxcU9FSzhWRDJGeE5y?=
 =?utf-8?B?dWUvSzhnRkdsOWw3TTg2QTB3MExRNG1pa1UybW5QNzFoV1pHeEE2UHgrbmhs?=
 =?utf-8?B?OXFpU2xjaUdqdGdYek9CZDh0b2tHSWJiZGFQZFFXeDJHOHZpVSsrVUdaVjZL?=
 =?utf-8?B?czc5cVh2cThQM2p6UzRPMC9iaktTc0dnUEpIaUZpUjRMOFJaczRveWVxUDdq?=
 =?utf-8?B?UzU5UzlnaEdPU1ZhWlBTZWhEWnd0YlQ5VWJ1ek1mZXpKMnFoYzBBWC9sRzdB?=
 =?utf-8?B?NDdjRGhjZ1Rxa2RxMTRCbWJPMDl4WlpLTkdSOVowd2ZEb0hHOS9hUXNXTDNN?=
 =?utf-8?B?MWcxSDZENXV6NVJKMWNBTUN5aitWVzl5NXhDUXlOc3hidUU1c04xMXYxa0dB?=
 =?utf-8?B?Wi9MNWVGYUh4VWVza0gvWlFGbFpWZDFNbkJHcHE0dXM3MkkyTlhOQ1IxNnds?=
 =?utf-8?B?T2FDYzE0aWRsSDVnRjA4N3hUSlNSMEk5QlRKSGw0dDFSTlpzTjFvbEVENWFw?=
 =?utf-8?B?M3VmQzV5MXArT1FJWER6SDZjbG5vNllOTVNnMlNUK1V2QzY1cHBmYUVVM3I4?=
 =?utf-8?B?QTFkckdNNXN4emFnLzVLK2VmbWVjYXpCRmthbG11b0xQcS9uOGdPSXN4NEFG?=
 =?utf-8?B?Nmx2WTdmSElGNVMrMytWYXVsckhaUW11K3JXQk55NU0xdlo4U0VmODRSTEY1?=
 =?utf-8?B?andPbE9sRnJ4cVBsUzE2ZWNubDQ4QXdLN0k5M09LbGJKc1pBNnJwOS9IdG03?=
 =?utf-8?B?UDg2b3ZMMTY0ZVdXR2RLWjhNdGlKL1BLeWNDZCtlL0lBTHRXTXloYlpobm5o?=
 =?utf-8?B?TEFyUjZJKzhxTDVqa3liczRVVHVnRUw4ZEgreFVkdGJHQkRobGkvYjBMdi9S?=
 =?utf-8?B?WjFXOE5BaEVsaEh3dzNET0haR3lQV0VnQ0FYYUFQcmVKVkd0QisrN0lya2xG?=
 =?utf-8?B?QnhWdXcxZTZrQXVyRElhbEkvR0xySHIwUERMc05RWG4vUjIycFdKZjFEaCtz?=
 =?utf-8?B?SDQvMzZwSjU1SmgrdVoveUFBOFBqRjQ4dmVQamdndnlOZlpaeDdBWTdWQjI5?=
 =?utf-8?B?U0REd0NLL3pUdlArb3J6WUZXTnBtNnl0aFhzVElDNHpBZTNzRU0ydHR1c0o4?=
 =?utf-8?B?V3RFcUVzSENtenJlVllxemNXUitiOWV2aGRHclVRbWQ4dTZva3RxZkJMeTVs?=
 =?utf-8?B?QVZubzFPQzQrUDNlbWNVZnp2U05ITnJFQzN2clZISjJZYmwxalZ0anJyMnhz?=
 =?utf-8?B?cFl4MktjK1l5d29RcXpyUkZxQXhoUHJHMkVFZ1drL0RtbXlGUEFkZ0IzRkZV?=
 =?utf-8?B?ZjFMaWpOdkNRTzdlVTFrU1o5QXZZb2Zid3pVTEV0YzBmZEVla2t2Qys3aUIx?=
 =?utf-8?B?a0sxNmQ3WjByajlweDFRNy9tMTE3WjcvZUgxc21pRVVoV280VGpPZFJMUGIr?=
 =?utf-8?B?aDBIbnlvRStkZThkbDhDbmRVcXJqN003V0NXR2xzOHFpYUJ4Z0wyVDZ1T3FX?=
 =?utf-8?B?REU2VmJNZkxXejgzUlF2MTd6Njh3QUdmWGdteGZXcEp0d2l6NmJqc0d4cVpE?=
 =?utf-8?B?MmtEdjhVYk5GTmlkQlI2VFJENmlEaXVGdDNJakl4ZHF5eDhyR0Q3L2Jnc3hn?=
 =?utf-8?B?VEdBTWVyNTBXUVVaR2wzM1pkRXpWUjNZV2VNaGpCWGluV3Z3elVDUGNpYTdw?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8978FD1F2EAB4E40AFB564431099E008@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 13aydfg6HwgLd3UypsBcHCvYqG9zGMhkWqPybRQS4zE76fLjHywqc06GK7LXhPuOMhlJyKCBKdckqlbtswWBmyVR9LmSsksJXrlIHNf+2ZE5SzbbLFXT4Osb9fvo3gSaG+QJKkn5QT75OnDSVtIQL/Kspug60u+TdxDX8m81OYuFQ++MC3uRigalajL3sbGapw+H9x51TiXcYpu/rn9hHFJgol8G2rlIOkJqLG7e2/qU4Bg9NEO9Wh5AvIOlOC6DALgBZRdZ8rATFXLiwFaIGky1GKFBgjtL3CG4kF+gQ1obYV6XFvEb7FQbBFekskIuLWkXRMrcuR4iA8pPWfWMavYahEgd59zWBLiSSM07g7RPp7v+hYQlqphpsnq+yk0ZzKEwDBEgLJTcJ+fhb7UO6S8V4+gBxZuc/rGbOP962zXEYH4VLR3bTsq5JYiRBwenJk0u6AdvkjpvOsMBBdKsMQcJ/hxFCnumD6G0dVHTYICQcgY1v7oMMx5hw21Ao6a1UWKEeKcUUPXeie1qDGIFSagPqdfhVPen0qzdAuqfMcm+jAlXWkZl7SZa0svc6Bxivtf0OnjGxutrxNjbURWQK9MNNj7TIcv647kVjClmATeQtuA/vUhgz9sI7g4P0jO7Z+FoPTJLyds9Bmx6z5KuNkaQTAArqIGSsCzwuZiFqlOysmYwjC6L8fF5aHk77itEMSwhDbiz94AGIW+a9geQI0hWHO2Zif4wNRrptMtIKf1Q9lCCerKKdq8whosPokDsGr+d7EMxTka7DcZd2u2Y5mCTEwpNgM4cO9aWpcGtVnRHvumfZ8y6A2x95FFyfkMRikDWewmjOtIZu7uUCipFiitAP5uPNDc3KXin1xRW1ceeV8VZFNwinCEYspTwZXJP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf035f1-9ae7-484b-72e0-08db9286c1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 11:59:27.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJ1iC7e/1TQAIjr3oKA5QrTe2fq00ceKoYbrtc2gNJiYCWfh0NOqW1N9ZhGR2TH5QGCK0Z/TFyY2chaseXB816PaPEAbk65Yz3XeUiYxt74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6796
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

V2l0aCBDaHJpc3RvcGgncyBjb21tZW50IGZpeGVkOg0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K
