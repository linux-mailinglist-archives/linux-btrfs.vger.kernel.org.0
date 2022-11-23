Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE4635326
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 09:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiKWIsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 03:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiKWIso (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 03:48:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DD14D0A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669193323; x=1700729323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bZi2ZxU7vIGoVjBCNJ4ythpWIGx3uiXhkbtdA3MYPnc=;
  b=Q5m1gbNj7icdxgYz8GY0GNULigMwZCrs6Ear2ZfqqELw/D06pcpBfBC9
   7jzjqc63HdmI9NQ5nnK73YDXtK4XclFgA1kj/LBaeKlBlJV5reBmtSiT3
   2Re+WALspa5rygXHzLIN2c3zIpSx1CPPa5ZVoi1b/WGmVoZBXG8Mav/P6
   CpogGhLHwOjpHRY2GsTE7l3D3w2XnuKEfUEBv1yS2wm5/AyCK0bFKadtw
   wJZxrJ3NvOO7tBJoRH5ILCONSe3cxp0Resaxth98PBbkqQ67+n9nXiN9k
   6hfmKbSdP3hXGxc2jQ0Ro1OCT/+9fC+lH8MBQbgYp5e/MGwt5/4R4q+G+
   A==;
X-IronPort-AV: E=Sophos;i="5.96,186,1665417600"; 
   d="scan'208";a="321320685"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2022 16:48:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt2vOxrjiHU5lc1kAhcgrcolZEkXJo4JDBf8AgbJnfsDPzpxGf1Y83jTTn+G7xCa13xHC8jSYKA9tW7FWG3/1nFKj3rJ5TeWa1oiNwEOaRD6snPTX7aoIMdvhB32IudbAWfu7WgFrr8NpNqD+SU0gz1r6kN7WwwqNJ+yd2F93tTfudT4cUsyPmDyhQo8JsFyEVsZxrxDkV8u+P6oW+DOfuAEbtH8VQa5ZDvOZV23za0t2mRMpq01eQs1kEtaTwtr6R+ZhGMvQORoQ2jl2tsdjygPplP1F8TIQAtXvzBKGLn8JjjvUPfhBEtlbMqsmCyyd9bLpD/8XYGa6AgDcyquvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZi2ZxU7vIGoVjBCNJ4ythpWIGx3uiXhkbtdA3MYPnc=;
 b=LbST1ejQ551grHUSOkHqA/YVbCmALYmsOouK1PxfjqRGDIVMpsRwoCOJyVWajXD2aLcLlxYjjUMFmRuqfBDdGyenwRoQXe6rfOtJnK8j5+P+izNoEsjowmq4C/mavGjb173utnm4Fb981uMAbBgKxOeKcFu2bLlNqmn10yJqr6+/+NtONyhDn5yYZSj4o7GooWBeZ45gHfjSsew1PYTOvOazZNKDdGx7CwlLcGHU4vdi5LQ2IVIHWuHBVOA7+0e1jRkTX4CKzNxiAKhrUjhscwsyUknsxAs94GfMepiM4wOzl+QMHScOBHS0gUBnB6wB2tS4XSwZlxTfsPEY7BQ2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZi2ZxU7vIGoVjBCNJ4ythpWIGx3uiXhkbtdA3MYPnc=;
 b=RuiBKNoauXJ9ZdiTikibJ35hjt2yY78NMEm/X/TEXzvx7rsN5OPHasPdeOETnz6R4wu25em6Kdu78ZfU4yFv235uIxohCQz/UpsI3vsO4iinWKVOKDpiVtSwLnA7XthMy62dL2ohFdsShW2Dlf+g2d8r/Nqmcb73NSuWB8O/440=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4938.namprd04.prod.outlook.com (2603:10b6:5:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 23 Nov
 2022 08:48:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:48:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking or
 setting extent bits
Thread-Topic: [PATCH 01/16] btrfs: check for range correctness while locking
 or setting extent bits
Thread-Index: AQHY+RxqyvVykLyy+U6hLqEzftgSk65C980AgAhCoYCAAQQdAA==
Date:   Wed, 23 Nov 2022 08:48:40 +0000
Message-ID: <36dc49f4-e702-7a4f-2240-81a8026f168f@wdc.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
 <563d005f-613e-5f15-4f84-82f170050635@wdc.com>
 <20221122171741.gzhjijznbffo6eg2@fiona>
In-Reply-To: <20221122171741.gzhjijznbffo6eg2@fiona>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4938:EE_
x-ms-office365-filtering-correlation-id: 6699be51-06b5-4dfe-423e-08dacd2f8542
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+H+Z4yLgDDSksJbr1wYVrOqpE/5njyt/2MRBE6hgcWe1InPX9MpK+zZr+TS655hg0Cy1RO+n7hEoIjB7b4GAW5dkBOiAnNIBmTqKfucfEEu7FOdCDY0TOhiWV/ytXQ5hLWMlW08HG5PsF6PI4sXvEh+Wk/SOGHbAw9coUysXkR3Vkt0FDsU6JIuyVtEAYc5yqlBGmL9+s5gN7TAZmVhF8GLhkt2+KAhFWvsfl4jXZRcw+eLUcqXPGavrHGAk/gW6gNuC4pU1LHX89HRW82Ec9YnDHwfeIc2sja+1IxHWtkcpIXEMHX6N/ip38COoB45hJHai5ji9kjNbtglOnHNQuwbqvrYKdlhZRxo83ZTktGNsgqUqiypkgRouH5vraPDJUSstw5SK87CtXTnvulLrSvVq029LdD9bSaJLit+Gf02sQ/LsI2i6okjizPNN2qAtUM2AfrKps/lzhSQZKAZPQhX2PmCGyPEZEkGHBTaVHX0NCHw7imKN4sP2gM3oEcSFG0s8PXUU0vPhXD+QoM66ZKM/wS4E5x14m9jGlXUrQzWYGweHCMfHVRtcs8+l3QUnzimmsMGAtxbB3qFGSWWlAJzKdMU2C2l1nYa1Q+UjUpSDeDLyDFCw9cKwLo/ZZ49+JQ6/b0ACIvvlBiRBQA6/fJlPbmy06AV/vrF3k38dD8r8OYRb1kYjPsy40OEeTTNvHFZjpzDtMrB0JR6GE/QcqjtJlhi9pr/a/aTk2US6ovFQTrwUJss8n0Jz+JZQM6PFz0r8rmUiwC56hQtogMI5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(186003)(31686004)(53546011)(71200400001)(82960400001)(6916009)(38100700002)(36756003)(38070700005)(6512007)(478600001)(2616005)(31696002)(4326008)(122000001)(66946007)(6486002)(41300700001)(76116006)(66556008)(8936002)(4744005)(8676002)(6506007)(66446008)(5660300002)(2906002)(316002)(91956017)(66476007)(86362001)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNzUklaRHNUTHpUR1JPOHZJQktIdXhiUnlDZTR0YUJHK3NLc3hYYTZhK2Rh?=
 =?utf-8?B?K3czVGd4aEpqMjhHdHl3MHlHdnZUc0UwSERDbjdRai82R0NZdjJBTzkwYi9R?=
 =?utf-8?B?TTVJNHhCelE1ZTdOUU5pQjlpeG5wV1M1Y3FQYzZaQStJTXQ4QnovYm56OStN?=
 =?utf-8?B?WVd5c2tqNktNaFhoRWVJMzlvaFI2N0VsSVRWWk5yczB5dzM5dHhXYUp6Tk9q?=
 =?utf-8?B?K210SFk5UTkzWmZGTTVvY1Y3NENVOXRUaWwvRm4yL0VpdGVuL1MzQ3duRmhl?=
 =?utf-8?B?VjFwZUpxdjNqY09TenNxMDZURFJNVXBSSGh6d1hWLzgva2lLcGsybzY0QmlV?=
 =?utf-8?B?MEw5aEhmdmxjT1I0ZFZzc0JYa1hpMHpyeXdjNG4rY0xORGlzREROOHpXeTlq?=
 =?utf-8?B?OHBtVUNwdm5tRURxSGh2TWtnZ0lzTXlYcHpvcmd1TVJOek9UZFY4cHU5a3N2?=
 =?utf-8?B?YkRHM0gwb040YkFGTkw4Vy8zVzg0SWtXYUNRNkZtRjB1N3M0UnZ5dU5BS3Jm?=
 =?utf-8?B?bHJ6Z3g1VExxanc4Q2ZPT3dhaVlnaUpYSkRiNXRnUFdBZGN3WENyT1BNL3Nk?=
 =?utf-8?B?ck40Rlh4ckdMYTlVMjl5a2QrTklHdnBhcXFURE9RM1BJK3dORHlVY1ZtSFhr?=
 =?utf-8?B?anRxbGxxbVJHcThsNmo1ZDJ6WGdjblpqYktHTU1LbzZlSzJiT0szMnNObWd0?=
 =?utf-8?B?bTcrMEJ1NUhjcUtsVm9IakFaMWZzYkdOSHdCbEQwQVl6WDhaaUNFYW1mYi93?=
 =?utf-8?B?c1BYTVo1dVFPaHM1azNzaUdrVGNxNkQ5Qml6NVZlSHlreWtGMEpxNG0wcDNl?=
 =?utf-8?B?bHZMUU50QUdTVmdLZHNsR2JRekNGYjZxckRIbS9uem5JckhnZWZjbE5Sc3pj?=
 =?utf-8?B?Ym42VFVIK1JZVE9tMUlyNml6LzdENVArc2NzTDIyeVFPQVh2YjlGdDVReFRF?=
 =?utf-8?B?UHJIMStzbDZuVzhDUWw3ZlBqMDFMT2F6YktOekFQSDNIMEYvUGxQbnN2WnA1?=
 =?utf-8?B?ZjRlellXMkNreS90SXNXM0NSemZhdjhrdWlxRi9ic2U1REk0T2pWOHQ1VXR6?=
 =?utf-8?B?Nlp5TmZiK1o0bTJTMlpOUjRCRW1ZNGdtQm44QlZTM0RxN0tsaTR5WnBwb1ZI?=
 =?utf-8?B?V25SbHk0YXBML1Fwb3U5ejE5SHVmMjFjdmJqRFJkNHQwMzB6TEhlbTJKMTV1?=
 =?utf-8?B?OC9rZndGb0d1Qi80RXM1MmFyVG1oOE11bkNjbERhQXV3VFpTcWVzQzJsRDc0?=
 =?utf-8?B?cGEvd3RhSjVBM1JzWTNSQkd0VlQrMjZxYVJ4LyszeTVUY3RNVVFoU2VGQ2JI?=
 =?utf-8?B?dnpxV1JhaitubTlYRmFrTW1OVU1UNnZ3eWEyNS9TWUIyU3lvMWRvbk1HRDhL?=
 =?utf-8?B?L1VxNS9OVXlRNGJka2NNd2JnT1lrNmVCQVlrbUY5T29ISTF4V1NTcWp0cnVp?=
 =?utf-8?B?SzB1UWRLZDU1RDVyazJ4V29nVDUyMVZKSUhjczJHT080RW4wQjB5UENRUnpZ?=
 =?utf-8?B?cFpKTTRDemRtMXdoQlVrLzU0a25RY3FRRjZmeGJUYWNUTm1mbXVtVmFBbjI0?=
 =?utf-8?B?ZXNJaEU5NUorRXVrY0NBczJpR0J1V1Y1VnoxU3h6Z0Nhd2VHODVHZ21MN1Zw?=
 =?utf-8?B?MDVrbHE4dFQzWEUzK0VjUHp5RWM4N2F1T1QwZ3lSbkJ5a0FXNFZ4V2hUUUph?=
 =?utf-8?B?NGpDUWkwcmprV2hWTENGaEZLTnBDTlhqejZZN2xVcmhieWIycnVrajl6cVhB?=
 =?utf-8?B?RTBLZFJGdllYOVJmTTZpV1NhM1pHS2Y3Y1cvWEIwY1NreW9VeWxESjd3NGs4?=
 =?utf-8?B?QTNSN2JvRWE1MG9nNXdqZkJvUUVYZVhjNTFjVkR6bjBLQUNSTS9OM3JPZHN6?=
 =?utf-8?B?UmFPbzRYQXJYeVJ0NGYyanpMTDdMYysxM1dzamZjYmI3enFqeG56elpEam9P?=
 =?utf-8?B?SFZxdEFqVUVaTjJGUGMxRTJBVElVS05HeE1DWkR2anR0eU85VlozQUdGb1hM?=
 =?utf-8?B?a1BaVWgxemJkalE4Nis0TjlvdDJkbnJFV3BTK2tELzF1VnhDbzFzRDgyam9o?=
 =?utf-8?B?eERVd3B3YkdzMk5CZ1YwNGtYUGtFcXdSWG95Q2hURXU0eUdnT3JVQ2k3cFMr?=
 =?utf-8?B?R252aXJISmRPR0NjVFVmeHN0VlZmaEJKNStEYlFWZWtBWkNCT21kbXdLME5V?=
 =?utf-8?B?WGxta01rRUtRNjRsYlR6cXhnQ0IrOGhyNkE2Zmw2QVNxS3RjMXVUY1RPenZt?=
 =?utf-8?B?cVRoeUR1L0pwUXRUdmJUL1ZMTWp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A452F2FF7C40D441BDD304A9AF93919F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: miLApJYxPZbnZ4TbE64tFDXnjT26LbXaKk1hr0FVosIsmXqud1kmEPkFLFKmNw0V/Aqz9xj2f7Xdr7f0LWDTyfWzW6C+nDmx3TK8OgQwZa/pXXPf4fh7v22rUeHkdFdfca2XVS9t6a23aOFoYsLdhKXhmYYLwK3byKXkzQ4dMTGJ71hrGgVZ62UOoYQVnQjsBpw5tG3dYdjmm9PyYe9a/qk38cqk1hybs34qSQlhLuiuJu5al6HwTr4yczRe5VOxfXMHx3rcigmoX6ZZdMQ+7tb3BfTUObR1lkCZBFx+DNt22USK8UKMu20t+lkmJGSMgarUL+mr9vxTd88GO7VDWuisKqWJ6d75ahH6TEYKvw4EMBy9XRnrYhWx8LSXBUdEYl+9Cj1Rs9w0F05B4mVKIaV7qdsGmeipWvpel2IhxJ2hd8RhmINsN6FhDe0bLE49ZYZ6FPOGS6Jtoyxp24T4tD5CYObHEIIK2oEdm7pvY/lFvJARrXi78lV977bQOTHMywS8Xh7wWef+19fTpdJSAEiLY8YsCZuqcV2jaXNyBQpWo714Tv4DRFUQSB08qvSjV559m8yH17Uybzt4yozzSANOqXKJyw1R1e2DmIcLQpyvltbQV6ImcLQ7zaGb5/szAWg+Vva4xGA3YijDZhUs51+1Uz9k0gik7kqvmnJ5UMRrRiRW7Hk3xmQnILj9Btf8MQJplEumDK0syjAnqfw0DG+TpioWlSxN5ff5sPQIrXz+VryBzQ5AVs1pPYyCzEGN5YfdofYPsPQ1OGQxAE9nuNvkU2RwziTXRx2iY+aXmBlGKWgMAmd96xCekGXgzuCq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6699be51-06b5-4dfe-423e-08dacd2f8542
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 08:48:40.8590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1rIoBVV5hRkZcEiaZQ1nDlrTia/UbZQ/MtseYe+fUgrXrgRcLL+373z1RkCYufacD+ZXyymtUDxkShIh82jvQw7k0EKkm4HaJDG7HwpybHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4938
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjIuMTEuMjIgMTg6MTcsIEdvbGR3eW4gUm9kcmlndWVzIHdyb3RlOg0KPiBPbiAxMTowOSAx
Ny8xMSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMTUuMTEuMjIgMTk6MDIsIEdv
bGR3eW4gUm9kcmlndWVzIHdyb3RlOg0KPj4+ICsJaWYgKHVubGlrZWx5KHN0YXJ0ID4gZW5kKSkN
Cj4+PiArCQlyZXR1cm4gMDsNCj4+DQo+PiBJIHdvbmRlciBpZiByZXR1cm5pbmcgMCByZWFsbHkg
aXMgdGhlIGJlc3QgdmFsdWUgaGVyZSwNCj4+IGluc3RlYWQgb2YgLUVJTlZBTCBvciBzaW1pbGFy
Pw0KPiANCj4gb3IgRVJBTkdFIHRvIGJlIG1vcmUgcHJlY2lzZT8NCg0KWXVwLg0KDQoNCg==
