Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCF76B476
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjHAMOB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHAMOA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 08:14:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB519A1
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 05:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690892037; x=1722428037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=CQJ0xTLHrCPdWdayQZXlF4UDGMt8PO9TY7VS0HxaTVkuDZlTUkCFJ8X1
   Y1dExFpzI224D5yWDhO3YZXmjNvABKEzRzhGimNNXQW7VBF+EiyPMCk+j
   6vIhQKr3Tl3wQniHflKD8tQT7AKO9OafO+L7ACclodFceD8uNX80Hs/o4
   utPMbKPdWf777+SZMdRf6x0NSmzkIWkOc2wFqyhEXhxnOl4HIbE3oJmFf
   fs8Sz29doN8O6j5ymXvJnIF5kJxETDhFzyZ0QOBErsUMdsf0JoDGkPL2X
   aS8sD3xf52s2GxMPn5dz1Li/n6Fg/jfZsNhDgq1N0PpVzqs0GZGWdInRs
   g==;
X-IronPort-AV: E=Sophos;i="6.01,247,1684771200"; 
   d="scan'208";a="240137535"
Received: from mail-mw2nam04lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 20:13:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE5ChcyY+nlEBL8SXGDfkU/DgAmTU7RL0iflbEJPwPjQB32wnrVdzWxXQ083djYCYd5NJ3/z4bpVbbjmoZZjNC9odRz9zZvx60rGcfC9ftSFGO73VBj3EG1KEANfR1DsgbPvIUzki8CYxscLm4iXFwE8FpB/GNDWyvPDnAkA2hD9vbuqzej7peP8H3aMvoGDZr9NKMFIIFcAKk9B9+J/BovS8AstL/uPyXo7BHpfHCrlM9PksWTy+gEXC1xPMQKjCdZ9D3to/Lexkz7YhIMg2mv2Y2MesHmf/KWUM/yrb+wF3HfS916NW42aOgtgha1m7JCtRw6ilUVzY9BGFwrC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=axkejAZXd3y/ew51jWQfuWuwJpmr2T6bAjnvW4QE6qTz37JSfpyUk3wVXENWQi0iIaXOa/Eug/y/uoRilpPqphlVT7UkxCytcpQsFDKFi2KY1buQwM2EpiVuEzQ4P9xI2aYa15i4fjT1p+yfikvvFDLjo9kPViWTZgUl/lFbmBGRnkeFZSLVW1S8UErw0CzBaix/kRsNgg9iqBk6Aa+vQadXUUsTviO5+TjtK18GAQ6vqjbld7ggOLUQNh7WOKmv6rlfbgKUBZUwbFCkL0f4ibraxNhxxAEZtpur/mAIH3tMiEY6yhXtbP5cGHd4OZH/paZheOWs2Nx5ao7M0URQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=oaD3/6vGxx4gW0JNYAZ2b49DGUn5qRwBw01RZrRsghwa3KvFfw5+f6iUZl82VGeLAu2UmdmCsuhHrFcu1ZBNG2qKp0ePOxnTohPIo2AZnn4BdTr1ahVlrAHdDQnQltppz5F2inV1kl0pZKikk8lKiUBn9grmKiAVkEn4WsQYAfk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6510.namprd04.prod.outlook.com (2603:10b6:5:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 12:13:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::c91f:4f3e:5075:e7a8%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 12:13:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 04/10] btrfs: zoned: defer advancing meta_write_pointer
Thread-Topic: [PATCH v2 04/10] btrfs: zoned: defer advancing
 meta_write_pointer
Thread-Index: AQHZw9NUdLhZLHr5OEafihOjNDWtu6/VW5+A
Date:   Tue, 1 Aug 2023 12:13:54 +0000
Message-ID: <ebbb0e31-d69b-f2e5-c45e-a147125266ec@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <b33f5b9b41cf80665f8df12c7094e260a38938bb.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <b33f5b9b41cf80665f8df12c7094e260a38938bb.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6510:EE_
x-ms-office365-filtering-correlation-id: 3c4af562-fbfd-4000-836b-08db9288c629
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtntajcKMrSmQ9xAvBoJDxSb8j1H8p++STps/WkhnzX+i+sqm40GyH6MxDRHw+VJro0nZ1Sm6cfqlPD5EQ5EvvIaisMv/lAdq9okrNQGt/c14Zq/hj45M8BQmuQUy20SQpDDrirWhvMcmLyMgm6/JLPl/7yiejcyRu+16gylvCltB69HAhj3IqZKBzHkVH7nfGpzHg/9yx3Uv/firf5ouaQP9y5FyQg3CN6IHkBPMn7uAjXpfwMb6k7NoRXaqKG8yX6oNpLd/+PxehUH7tgkBhqR2nBl1V4DWXlxaGroCFl3heNcyLxplXiR8kVRWcX57L49Js6804qwpPfiOs1Bzg0YiNdHTvaEyAt/XmyPG9Ujr9UvikY9/bJJADwTb33uclHw3RZ+/7nq5mrAAka5bVCnSXHtmCgpvUqaSliXL+lNiidbiB4qFwSgBEgDsXcVwl+KfrFtg/zFPg/6Bt0AZkC4EpBD8dxeqg1qMcqFR3KmVeZ/+9KhBeWyt9MdCBaWV30bxqH8j6FU0PtdoOTvh115UwXZe2Y/099rZ0GZ5EEXB3pedS6m2oz5H+YkOtHOxPAr0w3rGMoMCdpub5iA0S26LCgf27xyuYRwRG8PuHaQ3hhMMSebLuysKbFylsFidV0DAOltuTCaKpq/Mo3rT55gEE4i8fp5FW5C5904dxGWWhXqNwnHNVDFLt/q4vuh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(38070700005)(478600001)(38100700002)(82960400001)(122000001)(36756003)(31696002)(86362001)(558084003)(6512007)(6486002)(71200400001)(4270600006)(186003)(2616005)(26005)(6506007)(8936002)(8676002)(91956017)(76116006)(5660300002)(4326008)(19618925003)(31686004)(66556008)(66476007)(66446008)(64756008)(2906002)(66946007)(54906003)(41300700001)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXMrY0VMcDMrTFljNWI1Ym9TVlVaayswbG1MRE92TFNnQ0N0OHBrc2kvT2Zr?=
 =?utf-8?B?TFQvTHp2T3hWMVI3MHlTUjMzbzRBUGZPYnBRRUFISUxGc0lVRG5LUVBNbjBm?=
 =?utf-8?B?L3F3NkJ5UzJobnRkVzROYjVMNVJyZnRtYW16VktsRER3R1RmS2xwWG54NGVS?=
 =?utf-8?B?akRFZTMrc0JQa05CbTF1TmwzejhtYWNZeHJ0RksrQ0RiTVdna1pwYmpKNGF4?=
 =?utf-8?B?QjhjbS9oMFZmcWxKOGN2bHhvWHBVNnNEOXZ3Snc2cWo2VFpMWUgrYXFFOGta?=
 =?utf-8?B?RTh1Z0Vqek90d3hPUGZqTUx4Vm9DbHhOWW5lVHZXelU5UTVXQUNxenIyTHhG?=
 =?utf-8?B?QkZJMlU1U3RyaTQ2eXlsNVI3VE5RcVNBSnVHeXBnbUxXdkd2cmJrQnpDOFFN?=
 =?utf-8?B?ZWV6TExJRHVvMHlrS3NzcktaNC9EQ2Z4c0RwZ3VUbXd4MUVTRVB5a1c2UGdB?=
 =?utf-8?B?VzdSL2YxS3hDZVVIYVVKVlJoajFHVkw5SUpobVBHNVp4djFNTHVDdUp3T1NV?=
 =?utf-8?B?cnZINmZrV1c4UTBPRUt4OGNUVzg2TEt0eVZWd1dYL2c0UXBvRjAwbDF2RzVx?=
 =?utf-8?B?VEk0WmFHTlJzT3dpQkxTeU0vT1dpTW1BUW1sU1pYK2JuRHNGZlJhQ2U1MzBI?=
 =?utf-8?B?b085ZVNOTTFvTDJZd2hFUERQenJEOVBlZGhVNUtOajNWVkNuZzJ5eUZwV0ll?=
 =?utf-8?B?Y1hkTlJzNVRBR2VqVVVUZmRqREFIUWtHcm4rbWZVaVRzcmlibEQvMWplK25m?=
 =?utf-8?B?aHdyUGlVVnJpYVFkYys1RzliOHc0ZmFndXZEWEQ4QTdCbG45aDFiaVNSWEVU?=
 =?utf-8?B?RjhUVGdRQkNVNmx5UHV2QlRqTE02N3N6ZW9CVGFFdTBxYTNuUmFxenljSEJU?=
 =?utf-8?B?eFVOWnpCaGlVclBzajljZmVjR3paL3Q4YzN3dDFFa0x2cTIxZXplWTgrVzdI?=
 =?utf-8?B?Wm1oZXhQak82YWw3ZExIbENsMzY4QUtkTVlVM3BaZEZrN2prODJINThuakp5?=
 =?utf-8?B?WFZsSjluQ3NsY1hMQjA5a0tERkRiMlVZK3ZaM3hPbkg4M2VETjNDcHNhZXJy?=
 =?utf-8?B?MU9SanJtNXVONHhGd2xxUzVnQ3JHaVB6bjVoeTk1YkNIYjRwT0FHYUVQSHNS?=
 =?utf-8?B?K0djV3l3VVRqdE9aelBlc0JHOVpuajU5MEZaZ1NVMGNxL2JqbTcyQzhpY1RO?=
 =?utf-8?B?cTBDNmtMbW12YjZhTExOeXlIS3FmWTJ6anpzSjNsNmRsTWtmZyt6UURPK1Ix?=
 =?utf-8?B?K1NvbzN0UlY0NGRXSDNYcW0vVU9JejYvbmczeFFMUS9pM0tjaE13eW5BbzVC?=
 =?utf-8?B?OGIwZVBiSSsyNXQ2c1ZhZ3o3QXkrMTFXMFliSUgwcm9wYUxmVFBzSGxldXFi?=
 =?utf-8?B?My8xWld0RlVKYzRFOVNTY2JaZVlFdUlIbmJKUWpWdmZaSDI0LzBXQUhjUW53?=
 =?utf-8?B?c1pGby9UckNJQ1ZDeVRKNi80UEVrTkhqejF6VGVlMTRGSTFsQk5KZnZXSGVZ?=
 =?utf-8?B?TnR0K1JFZTVQVVArK2dVYjNsejk1MXNIUkZPSW9pUEpkNnk4dzJTNVJrUGpH?=
 =?utf-8?B?WGZ3dDU1V1dxS0NYakVocUxtMDhwSjgxSTdMWjBjL3YxajhXdllqT0YzOXEv?=
 =?utf-8?B?dEZFWWhwUzYzdkJqay8zWXRkSVlyMFNmSy9vcVQ1bjVyenc1RjN6SjFPUWZs?=
 =?utf-8?B?MnY0SWZXTi9vM3RUZEh4Z09LK0pOcExQTzRQK1graUtkWXZSdzBoTlFRNjIw?=
 =?utf-8?B?RWhwZlJWQTg5a1Bzb0tOZjRFSUVtTkRSS0ZvUUdVb3RUbmpQV241L1R3VHNI?=
 =?utf-8?B?Skl0c0RkTEkzclpFaGR1cEp2emFEdmRKd3RqcWtSTms3bk9veTZqTGVROTNF?=
 =?utf-8?B?TkRWU0FlZW4wVjRibFVNRHNoUlUwNkJ2QmNVOWZsRVh2QjJSZjVuWmVsazh2?=
 =?utf-8?B?K3R0d25HN1pvYVc1NDlNWTBZaWZsTWVkM0R1YlRJYTNUMU16M21kNy8wbDV6?=
 =?utf-8?B?VS9laUQvWUh4WFBKNHBJRmV5YzNJbXhlWkpUd3VUenpscldoUUQzYmM0aS80?=
 =?utf-8?B?anllVDJaNHorOHVMWW83VjMxTVJsRlMzNW1zQVpMVGN0UHUwa3FDQ1kzOE9X?=
 =?utf-8?B?NjFjMVJYSmd2VTVMc0tXdHNjalFDTTN4MlhsYXBpTmQ4OWdnQXJDTjRSbVdv?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB63CCB6F2A73440A45A66DA49C2EB7D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AkhhiElUY0ZDNAXHz86a01rJHYtzNdk7wQ2Xsg2R+KdBpXW6ijLmwa0i4ElLfP5Q+Z2/YLZkbzDIE85OyiYJ2EBV9rk2tlYKqZB/xwjRBQv3EuHKeBfXKNJj7KOdc/FTJgNLkSURAelKVQHxEzwMFSLWBtj10cscE46MnqT6rviHHzpAV/L2vdCPND5Lrda1GsITLxA7O84vnjqY8SUn5uBWfrZ14qSB7R4HIa7ph8k+Otc1VcfZ/Wijr2Gr9IV63QMcxgiX0T2drK9njeNrZNYBaw0emW4gk/OWfEiII7wpyBmIcztIxHJH7QD4PIDd1RJQbqPFh6iKjnKzVBk62PGglrJF9t6IK30Do4L6tn13oucpN4FCU+z3gdaJ4SEB8c/oHWKURlNyA1pKuY4xBdf3tY0qyKg3aPMNDPh4xEwqwDhAIqWR9JW/qIo6M5MP6CV38RByzdQ2W4OtqIVkCw8mZRwVqHFSc5NiBlCEae4yOPKu2OetCStO0KSKQpf4xQdr/Q7s0/S9qnRg6ubaWm6/JObnj3D8zGIZD6W9g//icuRZ1DvXl/8mGTtg+KT4XUgypjFs7IgQp/conDiXkY+c9NvF7TrOQPj7MK1QOI9SpBBsr8W4FmLnok01m2qqmCbE7nMK/4qykvyiA+loUjtCukBw2tgPauyeR3dm5BCGuAFhMgGZ0z6ix3/if43ypJiENAQNZMDGOMgxxZiFtIHi6G6eIxUYVMm33Gr0MAnRh6Fpr02MrTkez7TvgmwDK/WbfIsChIvf9LvmkPUs2Bs9+qWL+QbGa8kA8B2XC/xpB0yhax2oNjHbLf8pv7XWv863UpsAdWOx7Im0jCFn3uw1FfmcReA0eQAFP1qzLXMZwG6uXKqriYehDsq7nIVz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4af562-fbfd-4000-836b-08db9288c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 12:13:54.0436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N8ktze4VP/a/BFgztbttfRHGooWrQ6kz2ONGf/nICMNsXF/zHgy2irricwvJqQ0vB1zAX9UQ1tO+lQjVuobA4c0IDG7AvgXfWnbLqGkP2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6510
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
