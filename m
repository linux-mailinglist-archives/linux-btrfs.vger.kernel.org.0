Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B96A8529
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCBPcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCBPcF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 10:32:05 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C6206AE
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677771115; x=1709307115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6IbVDT4wuH+7jt+mMys7d2yVKghD6wg2Xbz0gTms94=;
  b=MRlw/g+cgFnT/jwd4OjviVHvdtVaXcWCVe10NI9wn2W+ceZnZob4C6Kv
   3o90KGhbrv8ssQiZT9pSsimS/iDSLyf95FsKLYo+P81fzQKE95oG9UQQ1
   Ed/MRK055vLWUeuMLrpX3jQfD44gg3BzlyIiTiIHyrzjsEFOG5A2q74hL
   OL4bDITu/vT7BEiYmNjmOf/iv92KoMWuqFnIfQu7NAKXZ3LjnrAdBzL9e
   PGucmH8hnxR665Faan621ACtDAyGGFncsZLLdhXB0zvpuAVHiURg490vX
   1xtGh2ettI8NIP4Z4cQTSdPVITXleVJ16/vWeD0zzniMRO7KW2T0YIlI7
   A==;
X-IronPort-AV: E=Sophos;i="5.98,228,1673884800"; 
   d="scan'208";a="328964644"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 23:31:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIPhedH4zkQEz6pxAa8GZuqY6gqKKMtUdv+dPlQ9NWryiQ2/NHlxC3UuOZrivca8xPjtuiyLuWKacWUeyuV02VIDD/HRzVfdvyf5vdx/Vyl64seIZJ2Kf0q1fSGnOzlXT5qTjoMTNh19NCQmp8RHIQHFvNFFDUdXUh0+F0K0nv+1/VnpiHkNoPobFM2mkPUHgHtRwWyjNw/mWBtcIFYMsK+a2W02XkUtE7ymQIvxGOam3FYyNzv1lEE/dyPT8oWukLJkLsdgMbesxETUjBqLu2WwaRj2u/LNa55MVpkfECT6rcHfYO+lIC/glmkBOE4LXW13ez3NH1wMXQyREnF4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6IbVDT4wuH+7jt+mMys7d2yVKghD6wg2Xbz0gTms94=;
 b=ScL5z2MfYWfEjZuNBq7fm+Igj9pGf4UkzzQnQIkCzCFQa9ObhDOyGL/yDJ6vL3rTft2FuePdu2fkIZ/mUy97cnLqS8JxVMYUWeTk/od/rp8KdmNOMyZoDqipFf3jJmG0Izj+5NsyJZpFr3yzoh8e8VOcvGFUDqSMifqHOUo7SHYOJ2T6GbXYHFROLc7BoQQ6OCtk82ChAxyv+XXc+w0mKU816OpvbXix9GXwmu5i97gPoy7kRuKovKcVud2akkTAiXkahvaTiSnDFLpBU7+OyyOD5okoHDTJSchI1UXpKruM8ONDuFnwDXSSLZ2Ns1SAD/HpVZ3e1hdNuKcyrLkptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6IbVDT4wuH+7jt+mMys7d2yVKghD6wg2Xbz0gTms94=;
 b=lAApbFjgq1a6ra78oD3av2ZRnvvjNEpb7sQ2gMXklyZo3T0tT6Kj3YyPJibHqZd/LibxFkm8gNbWhgp4FK6+hau51CZWFl4Ipo/0VX9JqvZuozko3zZO2Ab4EzoLNv57BLuYQm1BJlT9AjQ75cbSTliNURQPCDL/Yr28vMTuIlA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5545.namprd04.prod.outlook.com (2603:10b6:5:12b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Thu, 2 Mar
 2023 15:31:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 15:31:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46AgAAikQCAABkfgA==
Date:   Thu, 2 Mar 2023 15:31:51 +0000
Message-ID: <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
In-Reply-To: <ZACsVI3mfprrj4j6@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5545:EE_
x-ms-office365-filtering-correlation-id: 2edf07bb-eac5-438c-e4c4-08db1b333f15
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhCGyDssXZ2eLdhdAkUwtdOvRDuukFvKCYWZk8NqQ+IqKmhjbDdGVFZIuGinUG0BFvdRYwqD4fE/QREiqsFNBAqO/EZcUuEbZaaabjqJQNbRdXbaPiAaixxSrvDkvm4SIeZWHPqrHSsaq05qVfQqdGZRW4VtW95amMN3J8FMaOl09Zv5+nUYIGVJLoKMPstCigVyXxux6H3j8omxFfQ7nHmoxLkhsoCbBqoLUAN+SCjpwixI0PuMwMAH8GIqUH5IPYpte3J1DvrFp8yXTxXqq39e9nl2Gz3nIpqUD+Ec8sKhEYrpajN8h7KrCRC/kBtciQjpelE3EeSF+/NgvdmHXgN+13YCoDaIRl601YGkf8cZukjAQRoepV00vfqCS4mTuchPrUvfUtNz9swNsz7nglLdBVwQSQDryOIrD2b3eBXwm8vWb//kZAyCdpwFIPYNzoWnEKIjl1B0uHegWbBw2wJSvbA9L/46JmqQn/kpBWlp5Y94MWdDOXsmDnG5O6BICUDIBEu2oL8sY6tpoi1R4je2JyfymjvSl4EfYdCxeAIyKpe6jzSY1FKpjR4tYtEW6Kzuqsv6RcyHpBN7j1hRA/UgUdwBDZu19n7dBbA2AgxOPLD+JWRxQnwKA4DILmTZb21/TuH5ERnA2SB1BIQlY7b4i+iaXsycFjJyv7M6/8RNnwtoffefI7qK62DMTA3pkFZUeRWpt/QI+Osx2YSqAg8AtBDe7cfWXxszFum1vJ9SptOY0xq8ZMvRR00DaIfNM7MHXItKLU8o1pble94p1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199018)(8936002)(82960400001)(71200400001)(478600001)(31686004)(41300700001)(38100700002)(122000001)(316002)(2906002)(86362001)(5660300002)(6506007)(6486002)(6512007)(36756003)(53546011)(54906003)(26005)(76116006)(31696002)(38070700005)(2616005)(66946007)(4326008)(6916009)(64756008)(8676002)(66476007)(186003)(66446008)(66556008)(83380400001)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3VMOHlyWWFTdStCbGtTNW5HcksxaWpRWVN1Zk9POFVlMFdWMVRsZWFUbyt3?=
 =?utf-8?B?TEtabTN5YVFIK01QZkxsZFdpazl4WGZYUVBrTXJ2S0hPYno1UXNsVFBLYTZF?=
 =?utf-8?B?eG5zckJLN3o2bno3V001bmlnRjByWllGbmJDR1ZiVjNCVXU1Q2sweFB3U2Qy?=
 =?utf-8?B?ME9vU3NPYnB1V1RJNi85d1UzUUVreDdpVXNjNmxuVUtkVC9hMUVhN1lVdWpr?=
 =?utf-8?B?L21GZ0Rxb1hOSHZraThyMFZNalBPV1dkT1ZwMWg1ci9QL29paTU4bGJaZTZO?=
 =?utf-8?B?WEFvZUVnTnNxT0NUZ3NlUkRrMVhnYXhLQlRBWm5pem95ZEM2TlNkRHdBYnRL?=
 =?utf-8?B?NElhd2xKY2ZvZXI3UmdFdTZXMk84ODZ2aGEwWW9nckdNTkZLVndqMzhWTnBB?=
 =?utf-8?B?bGxTSHkraDdJa1lvUHBoT29ZU2dRMURNSjJlRDJQN0o4YXV1ZWIzbWxhY3ll?=
 =?utf-8?B?L3dPa3ZHcCtxU2hOT3RhNGE5UjY2UHZOcW5HeXVUVDRsajJwdFRLa2pvT3dO?=
 =?utf-8?B?Y0JrdytzSE5aTFh5R2tLc2ttTEV4L2ZKMCt5OUV4WjRyOHNsak80dXF2YmVv?=
 =?utf-8?B?N0ptSlcxRUh6QlhPRFNZM0Q0SGJhaWkrWWkvcG9oaG02RGVXNFY0WTNPbjJD?=
 =?utf-8?B?cE10SEtFaTk5UDlJUWJUSGpRL0I2eHYwRXBUeHVXdk4vbnlmYXlvVklCcVQv?=
 =?utf-8?B?VkUzdXVYUnNFSzFSS2EzNUxLcTI3UXJNdE8xbzJsTVdWM2c1RWdpdjZKTGF0?=
 =?utf-8?B?UWgybFN6WWZaeUV4bXFPdG9paDFhUHB6OXp2Z05UVDU0VTAwSnlFQStmK0k4?=
 =?utf-8?B?VmlicFBrQ0N5bHJQVXBRbks2eTM3SDBpZDJPQ1pNUVBIYXJYbTI1OTQ1ZzdZ?=
 =?utf-8?B?VHgyYjhUbVNQNjYrbkt4VTFFVm5BZDdFcjVrZW9CNVlhY3lTa0YxMFlnMVY0?=
 =?utf-8?B?WkZhYUpsMkJwbDRUc0FCQWkyc0RaNEhBZExrTUZhWGpoZkJzL2VhUXY3aU1q?=
 =?utf-8?B?RER0aTF3eTNwS081d2lKRXlZZU96ei9jdzgxYndRcnpLRVFkdmNLNVhBVUtD?=
 =?utf-8?B?YkVMYy9TenpqdFdjWWsyMnRMZVdpaXcrOG1JRzlyd2NlSFF0UURlMkhDMTNB?=
 =?utf-8?B?Y28vWCtRWXJOZjI5MnErcXJtL295WTVKOVZtU2JxcEo2Sm1KTGZ5eUdnVEdm?=
 =?utf-8?B?MnBXeHVDTlp1V3FFV2dDbFExdksvUXVKcjlpZ2dJQzJ4WmtQRTJsdkh5S1BR?=
 =?utf-8?B?VU1GRFU1R0NHZkdkR2FyMzVSSUJKSlpSK2srT0diZkkrNGRRVFAwUk5IYkV4?=
 =?utf-8?B?Tk9ib0d1dzF2Q0RvZFhCVVBRMXF1QWlXQWtBMy94YmdEZ2JzMWFDSkNZcldF?=
 =?utf-8?B?TzZkNXM3SFJSSG1IWGJJdkRZNHVFR3YwMHdLNFpLRXc1NDJnNWFrRDJmYzV3?=
 =?utf-8?B?Tm1OMkIxUHBwVWRKZzd1aDhyMDdTMHZEMTZVRWd0ZnhwZGx4Z0wvL3RSZ3ZE?=
 =?utf-8?B?U0wvV2ZYSE1STE5TYmZZOGVhYXB1ZDRwMGoyVkprQS9aZ05mRjA5VGpHK3Q0?=
 =?utf-8?B?YzEramlCSGVEbVpyUWsyQUVxL0N4Qzl1K056aFdqdnNRaFgxTFRVb0QrOU1s?=
 =?utf-8?B?RkQ1eUhEYjBvRGw1cC9WNHBRY3hCSDIrTjgvd29lNVh6YXNuVWt0R3ZSWFVa?=
 =?utf-8?B?WTFScVppeWpUOWhtb3BzREJIb280Z2Myb0hQMkpva3JxcU8xR2E0dWM2Y05i?=
 =?utf-8?B?UHNZRXo5cGxMM214aXQ0aTNyYmZDQlloYkZ5K0RkYVlIRmNORU51U3lXa0xC?=
 =?utf-8?B?Z0svcnBiOElpSzVsbzMybi9sc1JFN0RLY1FOQjVadjJxK1hMS0F3bS9DemI3?=
 =?utf-8?B?WjJ5QmpoK3NvNmMxUjJWd2JEeWdsRWlDR1VGVFUwT056SEpBZGg5dmhxZE9E?=
 =?utf-8?B?MHB0SWZWVmh5ZTRDaGo2TkJva3d1aGhjVFVadHNqOUhXb2NiWTZlbFp6NzNI?=
 =?utf-8?B?VHhVUXZQQllzUXFSeEdETHVMb2VHdUN5OGg2aW4zbkNMRGw2VEVabVliSWZ6?=
 =?utf-8?B?ZkdDY3Z0MmY1V3Q1K1QwMWR5bUI5bTVVNXBnQUhrOERqcW5SOFBwNGRsOXl5?=
 =?utf-8?B?bm90bFpzdjRLTDcvWG12cmZTdDllTEJqZ21QdFN2bjVpZlJzZDEyYnlVK2kx?=
 =?utf-8?Q?BaROqfWAPAxIWTVv+Kpjtow=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22D77ED8C5A0DD478F6DEB916D2C493C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gEJz+L7dSDMEbBI04cWUOiW/iOrQNeNUOWDFLV8YSNOvirFC6etfPiAmycpC5dnJ2zOCcyFkFinFcU/ZyYHTJUOWw+Eevk4jdBbqAzpThCXM0ctURpevBTCkaA99EFV8miz61fF2FqTbzdUujlnjHmo3UbOHySvT9NWeEHIVFEqsPGo+MjExYElHb2CqJmevvBk/jkAAuuV3V3j2WsXwqtlXugFM+h9jcXWXmfzwsyWHfNDQtj0k/lJaGJL6naoNqCX0vQE9YSdt7YX+foXOG/zAmYS+Z3m+acgbge6ns5p8C5tyA28fuJnhBSIQjFZdCr31VhQmJ+2u+S9B2UpPfqRovYgnCzeYN4FHU6okjQ8Etw0Q8wtamv9k/+hBIo4O9rtgv36mFJsAEU8m7+kDWCfzMG9cwlCedrTu00Ov7Wjo6hnSWOAQ7ECJzTV/0ILIoxWo+whzBRLamt88D2aMBBqHmEAork5TicSAbefnHNOc1LczVdDXZz6ik4Iyd/RbN/uLfjHsvpFzxPqAfscOcVVQ3Eh8g7McBUJnqiIfM7kvVoli8Tb2XfgqWsBBjrO2CjDUJ3o0+szAoK/By9n0gSGFHC3t3sdw1mWLF1ACAA3WOboNxPWxf5F3AwERq06XKjVIZMGnbw+pqYhkF/zN+jisbKyeBLthC4zSuoMnfeWfEdqKt4640LjHVyJ0SeA88VNliHjTWeH4zHqFpzkV9Z/WjujzBc2iL96oZ5Y/lftBtpuIm4SktCBYHmb8FTNqmkgylYU4LS9CCRYKVSCMT32Om9+vE4lp3B2Va21s2qzVI5kVTWxxU3SXWjJvvsBx12exS34NEzJ6n2eavDM2avHDjfgnYOFalIuiR0P69RJft6NNPRKsgoFBCcmfIXmXDpX2lD1Q45Q0CHu22ZamphuC8CTYWZBNUhUQ6QGafK0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edf07bb-eac5-438c-e4c4-08db1b333f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 15:31:51.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHrd8dgAC9wNAfrqynu72zW6ntJHey4k2qvVmW1FCSsW57TbbnNyLlCPrO8s0TUm8LIyVf0IPnvipVYYrJY0jaGeYQM4R83NgD+SE72VeW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5545
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDIuMDMuMjMgMTU6MDIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUaHUsIE1h
ciAwMiwgMjAyMyBhdCAxMTo1ODoxM0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+Pj4gVGh1cyBpdCBjYW4gY2F1c2UgZGVhZGxvY2sgaWYgdGhlIHdvcmtxdWV1ZSBoYXMgb25l
IG1heF9hY3RpdmUsIGFuZCB0aGUgDQo+Pj4gcnVubmluZyBvbmUgaXMgZmluaXNoX29yZGVyZWRf
Zm4oKSwgd2hpY2ggdGhlbiBjYW4gYmUgd2FpdGluZyBmb3IgdGhlIA0KPj4+IFJTVCB3b3JrLg0K
Pj4+DQo+Pj4gQnV0IHRoZSBSU1Qgd29yayBjYW4gb25seSBiZSBleGVjdXRlZCBpZiB0aGUgZW5k
aW9fd29ya2VycyBoYXMgZmluaXNoZWQgDQo+Pj4gaXRzIGN1cnJlbnQgd29yaywgdGh1cyBsZWFk
aW5nIHRvIGEgZGVhZGxvY2suDQo+Pg0KPj4gSG93IGFib3V0IGFkZGluZyBhIG5ldyB3b3JrcXVl
dWUgZm9yIFJTVCB1cGRhdGVzPyBUaGF0IHNob3VsZCBtaXRpZ2F0ZQ0KPj4gdGhlIGRlYWRsb2Nr
Lg0KPiANCj4gVGhlIGFtb3VudCBvZiB3ZWlyZCB3b3JrcXVldWVzIGluIHRoZSBidHJmcyBlbmQg
SS9PIHBhdGggaXMgd29ycnlzb21lLg0KPiBXaGF0IEkgcGxhbiB0byBkbywgYW5kIG1pZ2h0IGJl
IHJlYWR5IHRvIHN1Ym1pdCBhYm91dCBuZXh0IHdlZWsgaXMgYQ0KPiBzZXJpZXMgdG8gYWN0dWFs
bHkgb2ZmbG9hZCB0aGUgSS9PIGNvbXBsZXRpb24gdG8gYSB3b3JrcXVldWUgb24gYQ0KPiBwZXIg
KG9yaWdpbmFsKSBidHJmc19iaW8gYmFzaXMuICBUaGlzIG1lYW5zIHRoYXQgUlNUIHVwZGF0ZXMs
DQo+IG9yZGVyZWRfZXh0ZW50IHByb2Nlc3NpbmcsIGNvbXByZXNzZWQgd3JpdGUgaGFuZGxpbmcg
ZXRjIGNhbiBhbGwNCj4gcnVuIGZyb20gdGhlIHNhbWUgZW5kIEkvTyB3b3JrZXIuICBBcyBhIGJv
bnVzIHdlIHJlbW92ZSBhbGwgaXJxc2F2ZQ0KPiBsb2NraW5nIGZyb20gYnRyZnMuDQo+IA0KDQpJ
ZiBpdCdzIGFsbCBydW5uaW5nIGZyb20gdGhlIHNhbWUgZW5kIEkvTyB3b3JrZXIgdGhlbiB3ZSBj
YW4gbWFrZSBzdXJlDQp0aGUgcmFjZSBRdSBzdXNwZWN0cyBjYW4gYmUgZWxpbWluYXRlZCwgY2Fu
J3Qgd2U/IA0K
