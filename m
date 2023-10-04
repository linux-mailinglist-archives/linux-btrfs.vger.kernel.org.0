Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9D7B77A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJDGKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 02:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 02:10:49 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E89A7
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696399844; x=1727935844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=NWyJtDYXvFporM18liHUYTlt3n9m4uAiQZ7ap60vbF6dGbGbGQujPas8
   kjmG+CkS6JIh9dYRePGKw8iunY+9UkcWkXx8Z8tsk4aX/M8UrJp++kjOB
   eVb8YWH8B8yNH4nGBv+NzNQrIZdj62RO4rS82P0bMPoZY3L2cgZwF48d5
   XFrz2A7pQq7ZkqJ1fNBpvYLNUxSzWrROILlwQ5DNvBneKNPPe88RsrSnE
   ub8bY8jDfHHG/b8iA0jvf7LCY2m935PrIG7p2a1MFDSll1XbVm3nKMvhA
   t+yMaQth1bPW/8RMY4Bam+7eDW1jzPJh9fbzjL1MEL+GsbhzvqlF7NGZY
   w==;
X-CSE-ConnectionGUID: ehn0ACJWRXimRrcCHl91jw==
X-CSE-MsgGUID: bgf7Ep6PR5q71W1PVW38Hg==
X-IronPort-AV: E=Sophos;i="6.03,199,1694707200"; 
   d="scan'208";a="357719156"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 14:10:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkEyy8sn3qXK5J+peNvWuOayKun2pFtseRRns2p/FpD8LYU1LGb7h0mv4cfYHtMXIfPtMrgDrw0NDzPYK0cka2PFN49CB1rALFo0TU3aWijBSMs/XltCPzCcrsyPvJ53PDHRtbr1zwpTQpOWFnd8wik6pqOaFhru+rh6LPSmh/nWREm2KsKZm/IbYcVnYMW+tbCpVxA9Jq1oKEnMGFEaPuK2H5D3gTtyeqrqxTGSnIQrTaHKyh+lMamz2BMxL1Jl/+ZB7yyMgs52Pct7WMmAa6lHyKHffguzvcUNukfWXG3wE+GjL7amdw6vxbQBaG8KgcgXa/8bCHs4tZY99natIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=dOeZrgmqn89HCkLsiSgS3kOrvFXqwYlzCD4syDtTix0y9kGM/26szxiHo3di/f/w4hHr3d4un9okO5Yu9mOXlylIZNMC5NAy5yl5xWAErWKEy2tNJchCzbLXH8woKVBoU2/TFLA0C9yHGCKAVqh2VSmx2zfzYFySYiBbecFNCc7I+REp/rVEzRNs3rnXqiRWOqUZ8U4FZeI4AJE9qudpKm1OZhNfuWaQ+RHxl69SwbKq93zlgF+GVjEutyCwkrs2JrirFjLrTfyr2KnHY3ffVpUPX2GczmWo/8kWSbpswAJQhnyuQlRFKGyLJCi+QWo4e2L7c+aNcglMJifGPmETYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Q8M9cjioVjVgKNZO07F8ZDzA2VgScy/9fnP/pZb1wK/S+TexiaT+oKZCRnoCONkwiqo8ZYAyvHBu3h9eXt8lA/hrJW0f/pw2iZAiB/7tqTKV4+T3ivN8IDaxG8pfC6Nl7rd/+B/spJMD1CMKY7pGPeSuhYGRl3s0V1JwciKsPbk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8191.namprd04.prod.outlook.com (2603:10b6:408:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25; Wed, 4 Oct
 2023 06:10:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6863.019; Wed, 4 Oct 2023
 06:10:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: dump-tree: allow using '-' for tree ids
Thread-Topic: [PATCH] btrfs-progs: dump-tree: allow using '-' for tree ids
Thread-Index: AQHZ9oeNHe9MgG4J4UOy7TcAqBE7Q7A5Je+A
Date:   Wed, 4 Oct 2023 06:10:41 +0000
Message-ID: <08140b16-357b-4154-a473-22f6d770d307@wdc.com>
References: <a59a24349345a83c7594ea0340278061ce35a912.1696398970.git.wqu@suse.com>
In-Reply-To: <a59a24349345a83c7594ea0340278061ce35a912.1696398970.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8191:EE_
x-ms-office365-filtering-correlation-id: 3ec12365-6a9c-4c56-bc33-08dbc4a0a2ef
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsQxRFWRwWCdyFWe/ooVsCkmcR136F3e4iWJiJxlfOVr/JUhYjoGRURuyc1WAuuyU1nloCieLfxmHc/11J2WeoRJjLl0Lk5AskWuU2Ukq/rQ0FhjxWNiMjaRem5fV82dSUIlA6STGLMyNmPtAqXtXjffz4+A3J9uUuM2fZPZ0+BhHnC8T9/O5FbQjc4nfu3bX7cozmcOtIU7BZzHmBXjZwzLHHGCnVOVyomUFlbUQxET/qsccrqIw3kR7nhAsa5j9z8oCL3nxUc2iE/U/5vDRaiziWKHumLwlW9ff3LrC4qS2253oeM+H1nOcxspinqEySbPARFGYfZ3/rLRwMQyhFnd1F2crWgr/NJlgjwEugNKmiB8ZD4svLWfCmY/pVbaO28oc3HRwx7595A+cn8luxPHiAZLMSz3KGD9IYq3h+hPGKG25wG56IaeKdtQQyWHBFTMCpbQWvcpB4wqHviDeQU8Lte9WmuXypXpL/mSRUOS8AfB0kzcZYsmOykfFKwyc+K09pEl59qj+/p5xn2h8RCTQUVII4GljQBMu7Va5k+E/eoLF3ACF7rEB8959jzLjhEOuPU70aEJ4b+Gq8AeJQ7TfDIMAxC+Sm0e6M4LObN52J/8T3L60Oae+3N7fiWsXmKd6qT+3RGTq2swrJ2FcZiVNZ/mBBlUoMu/3eD15tJ8/QM/UbscAyhbEn2I+cw7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(5660300002)(19618925003)(38070700005)(38100700002)(6512007)(122000001)(82960400001)(478600001)(316002)(66556008)(66476007)(66446008)(64756008)(86362001)(558084003)(36756003)(71200400001)(110136005)(2906002)(6486002)(66946007)(91956017)(76116006)(31696002)(41300700001)(31686004)(8936002)(8676002)(4270600006)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEhRQll1TmU2MEVxTlMzMnk2V3BrYnZlZEhPdGkybGhuOGFkbW5UMmd0TzJQ?=
 =?utf-8?B?YTBJZXBmeWs1Zy92KzNJSTg3M3c4UHQzc09VOXRmZDR5Rkp5QXZ3eGIzdGJU?=
 =?utf-8?B?SXg4UjQ4SUdTeW5KTWwvaENOb3JPYURJL09HWXVob0N4bU1LcVREdU1uSU1j?=
 =?utf-8?B?Y2FScHN4OVNSMTg0MlBMNEJkalB0U2lSM1dWclN0eTB5RWNVQkdpeUFzSXor?=
 =?utf-8?B?c25zcWdHVHF6U0xHckVvYm1LQkFLTjdkSFoyYnN6UGQzOW9TRmY2MUpUdGJ6?=
 =?utf-8?B?U3VYTG9PSll0ZUdYNzA3ZENLMnBUa08waS9UQmVERmpYWHdqdnBwaFFUWmsv?=
 =?utf-8?B?Qjdab3lHMG1DdnIyN0crMklaQTlwTHFVYnhMeWJXcFdkaFhTditDVlU3RUMr?=
 =?utf-8?B?S0FUSzRZQzBVVXc3MGxORmttUzZTRy9TUzl3Tmowa2grczVYaXJTYVU1cy83?=
 =?utf-8?B?WWN3NzFySmZQQlE5SUhTM01uYjIrejNaak11SzEzekFvek9mNi9lVzNkaHVy?=
 =?utf-8?B?S00yYWkrWldNSUtPdGo1Q2xlVXh1eTlWOFJDdFFxTkovSnJYa2V5bDRLODVZ?=
 =?utf-8?B?ekZpNWFadnJRaEVueXdHSlRscDVNczJyWS8xMTJuUm1vQU9sNnZLTkNZeGRT?=
 =?utf-8?B?V3BPdHdFSVpQOWpETXAvc0JrM214QzVCZ2RnS3UwREVnanJ5TENKMm9DNHJP?=
 =?utf-8?B?cjR4TWkxQW1mQUNacUthL2I2dStrVWpsY0g5MDVjbFE4ZHR4YTVEOCsrRVFr?=
 =?utf-8?B?UlBCcjFIaDF4ZnR2RUhYQkh0dEdkWjVRR2o1UTF6c0FnRDU4K1U2TDhiRjI0?=
 =?utf-8?B?dUtBRFBwM2JsS1JSbXIyVlBhZktCNkRQYlE1bU9jSVFBdmZ1dHllVTBCQ2NS?=
 =?utf-8?B?Wk1NWTNEZ3dtNkdXbFc3NUFjTTBocDRnRnlNQk8yb3JINmFhakhzcDZ2QWdl?=
 =?utf-8?B?dnd0S3VkWEdYZEZtUkkxdzVtVVN6TlNINHpDeENvNHlvY084TnMxWmcwUmpl?=
 =?utf-8?B?VkxSZjdMZC82S3d2aU5mTk13eG43QWpYb1JHTzZPVXc2V1g3YXdraERnMGha?=
 =?utf-8?B?Y09aUUdYem8xRWp3TTJJSFZPT1pNTGo3VVA3ZkJudmw4SWw3S1lrYk5zSVht?=
 =?utf-8?B?ZjFKOElwN1g4N3BRa3RkRlhEZWhFaXVndXc3Qm5NNEJCVHpubnZ2V0pyNDE3?=
 =?utf-8?B?MWpETTM1K3g0ekgySUpnNVRjTWFPQWRCTEhlSWlXb3BMQjhGelFncTZxRHpY?=
 =?utf-8?B?SGlXa05MQTlRV0Noc2RvaVFhTjRlWElIaU5pVWgraGRreUNnT1V6M0lkMHRz?=
 =?utf-8?B?aFBlRHFFZnV4c1NxU0pRQ2pMc1U3K2hzN2IrWExTandmbndtcEdsNzVwT3lm?=
 =?utf-8?B?UE5YU3VIOTZja1ZjNy9xNjZnc2lHWkN2ZisxczFPc09KRm5mVG84T3N3STl0?=
 =?utf-8?B?RWdLclk4M0xaZVl4aW8vNmpJTTdaeWZRaUg0UU8wQ3lwbk1ZWWZjTFlGeWNo?=
 =?utf-8?B?SmN6cjUwbGI2NW8yNVV2Q3A2U21wd0xPR2VnYzJCUStWVEEvRTR2ajVtQnpQ?=
 =?utf-8?B?cmJlTjZaUlVyZFV1eFNQYnV6QVN4b2Y1REdSNjFKT3phR3pmVk9UV0hFKy9n?=
 =?utf-8?B?TjN0cm5qSlBhY2FyTVczVlpFTTJvdGhVK1YvOGErVC92enlCbGliem83elk5?=
 =?utf-8?B?dUhMUDNjdVZBS0IrREJRbjRsZGFXbUZ2ejI4MFoxNjNjTzh0OExNbytxZXJk?=
 =?utf-8?B?Y2VzdEFpMjdRUjJLN2lOekhMRlhxSnpJQ0xqRG42bENDRGFvUmNZTkNJSGtB?=
 =?utf-8?B?ZDh6N1RsY0h3TmFMcFVoWjdidVU0N2lzWko2bTlFV1RTQ3h3NDBDTlE2Ym0z?=
 =?utf-8?B?S1J3V3kxVk5LTDVnZXdHdStlRHZ4Zmt2SXRuQTBRSnF5QUxyUFVMbkNiWUxE?=
 =?utf-8?B?OWhhVGZSRDU3dGoxY2o4bXlHOEU3MFZpa3VpVTlaMzRFd0tnb2FwZjV4dzd0?=
 =?utf-8?B?VlBUc3VONjhkNEtEVktxcjZMYTlLb25ySXV2TjRMR0pDbFRST1pFQnR6aFBy?=
 =?utf-8?B?Vk9meHpRUE9hWmZockpYek84S3paTlhiSVNrSGZ2MFdqZkFQbzdtbklsQ1FC?=
 =?utf-8?B?d3JwcWFlY29GSGlPLzFFa3g1ZXRTWWc0RmhSVWs4OU1tcEhrMTg0aStTcDVX?=
 =?utf-8?B?dGhsdXEvL09TOXhIQmU4NVZBVUZRMjJiZjluUGV4ckxNUFdJRmhsd3RaN3l0?=
 =?utf-8?B?TkpqOTlhSE9pVHc1N1ZNUXJlVHpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7A972272144BF4A9C82E95E974F5ECF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xvwGq0MLkvyT2a9huIuW9WkEId1VT7wkyQ8SXX1UynHVFjnJ4wiiBKSOcayXWCtR97qEmtKnHAOa8zs5e23quSvZcqDoJsJLv2A90OuxRPuYoZPagcHL7yICmFifuZpVFK/8baY9BB1DP4x7Gm2dh9qe8YXnWkoo3GlEH3C09hVr3bEFSaSgL1B1Y0y1tJL0ekWYWwbkDWrm4Ij805Qz+6HP5ovlqCr7gHy+VCY3ZUvAIqNgyYcXiZxEEh37AKD6U9geI0mEJDg20hE5rFrdPxv/aw7G2p69X4yyu9uB3F4FwO1ywmFfgrcwS3QOSoOICHcDDdxpz3utdzsj+yGPsu+DHduWYlrlluVB2V7MDK3Py0P9qYZnpFlTAwBUzqIN/1BsrOAbCjGUvPn4lWjP2v2UAy7Z00FRuKkDKf1mBBqVRsouO9VArNXT0TwJRASglgtCW1GZEVi125eY5E5bwClitR67Y+vo+uTOVO+d1NMwSCysplVX0GhbksYFqxfc1H9zK/9nVg1GT0UucvWSMSewdZ5ab8uh5b83DcGLasKFMFQHVCY03NFY3/3IetZg6tM19uvwbEBvTTSJsoJGK+OLMq6YrthZgJKg5/XvPDnT2l8FmC5OWEV40ZTsVSgeGSGd9JHArIRjUW5dl/vuzi5ijp3mIzUn66bNRcKr/3QEwIT72vD2ARc0bq20gG27RVbFUq1UC/jQU2E3nlhJUm5e3Jxf1nESUAfGEv7YsOjplWEpGJL91DdslXVzRU7Rcq0WRSXrOqTUQ6u4loT9kSnGsCKELx9HGB7dP/D4xfXPcQWzHypa/UOQyE/vAMfJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec12365-6a9c-4c56-bc33-08dbc4a0a2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 06:10:41.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waa69BgGGnBEm1rbx8q0gHtzHGXdeLUouV69NGpxJFlOxxwz2NuELe3hoO69LXpuc8FaOn/FI8I80BqA8SdrDvgFH7CxpOf7mz3MB8enMqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8191
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
