Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB24E76B464
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHAMGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjHAMGG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:06:06 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962B1999
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690891555; x=1722427555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=PUtmsQ2LWccTOllTClFu1Rf2TYRDH0Mxa5OyUIbSIxK1BrwFpZxzPt0o
   VEeb89wKjlrp5CBDFCnrmGaqez1BuoivDSQeIwlcsDtA0uwtmfQfK3rSF
   jHpLw56eaqTyPn6Kns1VHiG0XYcfnGR49kJnixt4Gr9wfp2vzMtdsK+x0
   17NqxQPKEeDlOs8YzaLQzXHYmJV8H1WzglT6bNYwHcTSAJz+KQA308vXe
   jfWxweZN6Opfm2wwCXuNw8OReTo87lcPabOIbwK8x3JGhwCrtIihrqETa
   G6iRTUfuRNSSJkIPu+lO4brkR87W8vafiF/LdpNFJJcPmYHzLUuEDld7l
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="244374243"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:05:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWivJ47QjCK5z7zBm+0fB1L8pmve7ZJe7HNw1cBWiFOcgjQQToqvk8c4Oao57IPJFcvYnC9HkdKdt0TCFUGVRa1OqKgk5Tsd5imJpgh87PK3D8qAUG95JxQIdaODVzNnh2M0/cuqTwJtwTYj3Ul7wPh4FEWPeQEQWCJRg6GNPn/fgKS1t6yANfl6MbJdRVN4gwikYA+mtQVNtb033pdGwrjvR2HRmj7esvUQ+Q+lMU6gFGRtKus3NhN5AcdJ9mgNqth3FERejHSdCzXlvcOUePtaotoUdGKxqxq11u/UJlf9KnDCHdoX50HRgO4PmbffdM6ujWjgLwD+hygQAZZXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=WcREZ2BIUKnGn4hMUnWOaxrB2Znb1wC8Xh6hhyFpBzvz/AGZfNRxkm11qbwjRQojdCRAKN7Gj9XpDZpUdOwr0ZzpWeeRaOlpwTz2zAZFn4uml2MPZFCCFwa9BSwrWYcwCNye7IBN22QdLFJhf+bCXVxKmpZGhE4vVECTrtiBTUw6CduvV9BZFtnJDrh7FfQ6oguallbiSaXqi4zwgihUXG0QCZpOIotV94vFcb8/2VDzCs2ScFs8FxR6fHAFrGii4edkaCvyPgJZGQV9ZGCmZmZwpZQOgcmJs+86mgBEPZ32MrCgh4KKGpi2CU2MhgJw0p/tPxEuh+p+wGqsQvGP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=juwYpuibEQQsirrhWuaCg22z/oFS5ni7jVZp3445AxOQpBsIiQ4hyqy9KAWl2ErYA14TdOxO1mA/d4jG5PAQWGLke+Ux6hH5Ritn63l/MpZASf/pFNZ+WWHNae+4WdIfO1AbwU4P352jCzcyn+Oz583snfjWnAuYbQf6EATG1Ys=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 12:05:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:05:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 02/10] btrfs: zoned: introduce block_group context to
 btrfs_eb_write_context
Thread-Topic: [PATCH v2 02/10] btrfs: zoned: introduce block_group context to
 btrfs_eb_write_context
Thread-Index: AQHZw9NPp32OpI1Vp0m+/YucINQox6/VWWIA
Date:   Tue, 1 Aug 2023 12:05:52 +0000
Message-ID: <84919e37-6a31-15c2-3d9a-c7d459b421c2@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <31cfb11cd71edc3513f0d65d1da6a2b6d3b959e7.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <31cfb11cd71edc3513f0d65d1da6a2b6d3b959e7.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7278:EE_
x-ms-office365-filtering-correlation-id: f8e31134-8d98-4054-99f4-08db9287a762
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LXvhUPlzTtSeFWMzI2HyGV1FvcxmtoPTiTCsCLsXeKlaeez60ITk2PAYOp1sg4Za7GXxXU/x0CCU2l9N+MyqQriDDnQEVgTHuRAiDthyHz6nSO2FMz64TJ3ROz91sasbwJmqMaaiiZfmSytoICNky0FsZcKz8Gvt8Y1Tdh5/5pnIwBQyuejfkStxlV8dgAPEnF2Yznk+imq/O9LARbILLWktVlGfnLC8fNB86Ral/M6gGaQmZyT2X+unYi4WCXqW6J7zEodbMbO7yN+i+DRwUrHYe0mG6I6QZJZkfBET4R6wNVr6/pzAVZORlirsF0BrjMZ3kdYGYGGE4v+Dv70r1xZyu8SHZuQE5DNyO0DOKtntVlujthSeVq8ndEZqiNBqV2NrTyRUVUv5RjzI2O+MRc1lr2FWdRITwHQ+r7HrdHIXzQAsnIC/1H39RvyoRzfFE2Or5T5WmP2DpONpysZPifzOWm0+okK185x6MsMd7MgeaEEcencd8c6+1zibb5lPvSGlCvv6Ka3DQeXJF+7qwMgvGbsSM2MkWugdvlJ0YtbDpYy2bwwW9NDEZLkXDwh+U/d/O+cDXDW1rann9O/BtLJVo1gNXR5eqlMV7U1M1Iyz3BhKf/BRQmAxio8xggnSHRuzx9BAVYzA436mrlwMMSLstTmJ17/XsNyj5YCK+22Xgiq6XsKjaSWy/4QgnhWA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(2616005)(5660300002)(4270600006)(6506007)(8936002)(8676002)(186003)(76116006)(41300700001)(316002)(26005)(4326008)(478600001)(54906003)(91956017)(66446008)(66556008)(110136005)(66946007)(66476007)(64756008)(86362001)(6486002)(6512007)(71200400001)(558084003)(38070700005)(19618925003)(36756003)(2906002)(31696002)(38100700002)(82960400001)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlyaU1MZG1pdlZ2YldEcFlDMUZMTC9NcHlJT04rYmRoZDVIK3hSdXFoeEEy?=
 =?utf-8?B?ZlZIVCt4Wmp0OWY1WlM3d2NNQ3VXTTJTTGlCU1NEQlFLNDlVUG15ZS9lL0sz?=
 =?utf-8?B?bE0rbStzVzROZFZONVVObVVnZWs3bklYU3AybDA3MFlYTjhxamJ0Q1VqcUdk?=
 =?utf-8?B?V3hKVlpuYzh6dm9OVVhxMmM1aWFNWnlISEJON0o0aUtOelpDQTVVc1NSSG1p?=
 =?utf-8?B?d3RPL0xsU2hpODIzSHJBdUxNc2p4K1lHTWpJcTk3YnY5VGQ3TmdwckFPOHd0?=
 =?utf-8?B?bG5RVE81b3RCL0FCdmUrUVNNVm1BMXcremZRYUdmRTBtb01TL2dwVnhUYXZT?=
 =?utf-8?B?QkU4YWE0Um01QU9hTTVxRFVkcDZaMDdFZmdBcVVWWjRWVSsrRkppa1pPaW9I?=
 =?utf-8?B?bGFHR05uZkIvdnNwL2lCN0RVTnZjcDNpUXMxVzYybG9BN1NQdmJtcWJYcG5a?=
 =?utf-8?B?Rk1KQnMyZ0FjVUh3b0VPSVVSVHczblVWQ04wVXp0MnBYNC9RY1RqS3lXVlEx?=
 =?utf-8?B?eTl6d1F6SDd6RE5ORHZuNUV3TWovVCs5RXUwUnVGVHNEd1hCeUswRXJNVG0w?=
 =?utf-8?B?MU5kL2VDRkFsaEh4QUE0NGo5Syt1R1U1N1JlSjczMFJqOEpEVE5ERC80Mllx?=
 =?utf-8?B?OXhRSldnalhDTjQwTFo2RGZXQ0ozQnVySTFkcFRLZlE2Q1I5eENlcTIvdjU2?=
 =?utf-8?B?L2xKN21GV3BzZk9SYjNnbzc1WlVGdHQrSDFOTVhqQ0RyN0VURWlJRHZuY3lM?=
 =?utf-8?B?WW8wRWFhY3lPbUp5Q3RBdCszRkRuMzV5Z3pVK2Y5am1RNHBucWJVeXhURk1l?=
 =?utf-8?B?akx4ZG1TTG00a1FuMk1yTnlaNVN5NWJiVzFEWHIvQmJLekdLc0p1ZTNUM2Mv?=
 =?utf-8?B?OHluUW5VbXFPazR5Z1BlOEdrQmRzWW5wNVdITE1GcEo2b1FadkhpNDFObmtm?=
 =?utf-8?B?K2wveEMzNXZERGwrWUlqTWpaMnlQSkJ2K0cvMXl3b08wV1RvVnRTRU55WWhZ?=
 =?utf-8?B?S0s5UzlVaDNXMFdUck5PSkJTaGpOcThSR21XSlJDMTZhRGZnc0t1ZzcvN1dZ?=
 =?utf-8?B?ZlQvNDd0aU9lVW4vVE1EOHJuSEtiK3pFckp4WUVWUVhsZzdlaUNYU2dvNGQ4?=
 =?utf-8?B?NGVBb0ZFejlpUEszclNPM21zblpKNE52S3ppbk5jTk1yVGlTaXY1d1N2enJP?=
 =?utf-8?B?SGhKbTdOWXlHaE1TdnprNjQwSVNMSi9VMkc5Tm9ZZTIvbGpEZVZvZWhHcEdO?=
 =?utf-8?B?UDB2a2FIQVRQaTh3WmFGZXE4d2h0QnErL3I2RExRY3ZVb1Z5NHJ1K1pERURO?=
 =?utf-8?B?S051SVFnck1xc3ZQVWtMUml1bkdOMHEvMUQzT05TREx4aEpMMzVleElMOWQz?=
 =?utf-8?B?TEJpa295RittN3pkanVNUXZQWmN5bUVSZ1BQRlc3WDRxUkZDdTN3VTd3d1Y1?=
 =?utf-8?B?dHJRRk56SGN2akgzNjBueHZQemFqc3FGdjhUSXg5QVpNUmtpbDRWYks5cTU3?=
 =?utf-8?B?UExHZS9Hd3UvSjNZNGpnSFhaSmJqbXZhK3p0RzJrMXY4MkRDNTBQazQ0eEJE?=
 =?utf-8?B?S2xPL1o1MGM0UkZpUlhKZ1ZIV2thaGhoellNS0xrL1A4c1dGWUdVVmw5NG45?=
 =?utf-8?B?S2ZxN1hhRXZRRHd2dmVabUN2UWIvbkpwN3ZTd0srazhsQncydWZDNC81eEVq?=
 =?utf-8?B?c202N1grUVRWc0sxMzVrQnpzNDhWQjNMYkJXcGdaV0RhNzB2R0VJaUl0Zi9i?=
 =?utf-8?B?Z1IyMXVHUFNIdE1vbXJpV1RWdVg5UmtaUUNRWmlEOFRVNzMwWXg1ZjRvdUNS?=
 =?utf-8?B?UU52bmtiK2VBdGxMd04raFp0dmowZzNoaU8zaEJoODJ4MGxLV2l0Nis1WE91?=
 =?utf-8?B?RGhyUHRNa003WFZISUpBemxxUS9zWnpZWGNDeWY4SEJ5K2s0VDRHekwyQUVq?=
 =?utf-8?B?RzRheXYrbldaeUEyY0VYVEdYcTlWb00zZHBGS282QTRqUzVrSlY4YklQdzhC?=
 =?utf-8?B?NWpzVDZTRE85R1dPWUMzb3NYaFR5cUlJWDg0b1hta0dTaU1oTERLSGF0OXo1?=
 =?utf-8?B?YVlZb1RhK21RWUxBMXE3bmxVRnZiQUlTb1NLNmpGeFcrcnFIYjc4RU5ORW11?=
 =?utf-8?B?RVl5eHYvcjhnOS9zZVJpbEduY203ME9XSHl6UDVjRXVTamc0MXN2dmZGYUhw?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D8C10CCA33D3409AC0B01E043F3280@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t/vnHkP7dJ2/SzsqwwGLkz9g/JcapOvXIQtrYJQz/DcvzAcTGv/fJKlQ3/S1yUsH00Y/WBfCnr0vRFxRS1qkA/x/99eplvsul+ww5AcVdRMbwq+qV7UcjFuyoazrJoMmYCzP3H+eyMiIO/GPZFyCV8n3pBhmGCiUcyojI+U/HB5FgVBEqiFENr+0fNxOK2vgb6YN0jfhk4r0N6A7EnQ5z7uOTpzCXQk+5LIWlXj2zMQK5Xn403YlRcO8wUJexV3+9ZrxtvLJgBCjDprAlL81vsqyUI/jpIIJxw/Sj7z9CiMSLanAqJe8gjSsEz+UpxBKHL/pz7SHk1nBZhTXc4dxtpABl53ItRaFwXhg+bhyj2bhqMJjRuTsMEFPh/Ti8+olbzXT8nWlXSfxSQzuseKS8S//cXVXVPlowq8KXXC4CSuZrCSaTkl/U0ihy6754TSQDq0AgNi2LWOlw6KU30WrYa3pLARD4yEhbpPoGPpE3nWwwY/ZluSB0KaqvQIApXXtsWLiTn5QE1i6KNnOPM3J0DK2vC6QcNbwbjFxO3t1VJYsvfuIPuW6aIwXckCbIbwYyiYXZ8YgZRJNBH39RHaQQK9Bw6EU8shTCs8okX4cAp6R0rwwIjoR2ZMSJd7Osuhz5I/zeat2g/MAT+s3PKN6P483dh1rezEuDiG0hO2ze8jVR8vtYmPohBbq4RgjYNf/AiPwKI04tXxGOgQrZPpDjq+CLMHFvw/XNiVTwyOOvm1409CVMm119viJI0D0bY7EGssL+6ketabR76Cu12CfIEC2so6meDWRhmPLhR46LDRulj7xqA58XSC3DTuglw28rAaivVIEPTI0JoPJgMCsJnHUDlvUS8danp2PFupg2jYv/aAkP25avV51YtleEEga
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e31134-8d98-4054-99f4-08db9287a762
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:05:52.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hojtwFDdERXF4ffLOTItRj7U1NlB5kRsE6pUsD0fjw132l4jDPZuHlNEfqdwIj2map6BQar6tfNTvH6ZsDgpChoE5WD2piv3XdEWK+F/NPc=
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
