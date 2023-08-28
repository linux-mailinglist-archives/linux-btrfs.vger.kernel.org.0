Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A078AE70
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjH1LGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjH1LF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:05:57 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81145130
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220742; x=1724756742;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=VlpQOKrs3eOSz/2H3i0TWfz8uVQV7V3qzFy0dOg1fjYFcmP/kcWakfPB
   crSaGiM2LSd5emcgc8nIIgF+0aSaGM086fDQpF8CcLl8Wdh9eQEvY8KrB
   ptwGLD9d+IqtOjWOVE01c2QALHBUxHqmjC6yFqCM0p1lpql7VyRt+U6lp
   agi3fF8X7w4fVCLDVfq0PuaWSsO29yUogldJkagwvlClIleBs4Ry81NKu
   jF4P1JDEzTUECDFBasWkYSBR8gcG1Y621/hofWud7okGIoVWpaCJrcTF+
   qT5eYDxt+mQs87wC85gZYkKXR/7JspsT4e3dhArstIQ2f9KlUQhB5MDzU
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="354348380"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:05:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnVFgKyEhwv93SZsipWNdgODgQqN2MHzfwzT1ivr9ICNS8Wf8FdfKUP8+D3RNd73vX2WCLz1Yc7emRwGT3/iaTD4yHR6fU+yN50nhn4ZfqLopfwpHNmXSqk1avPowgiTWmf4ii60wS4X/6+4oLMC1etZ15AXGiGC5P26YzBigmF/s4c041w868IpTVt9oeWRlqiOWpe69YQb7cfvZZiQLjJJ2DRxBHOu4ifNrmg4wtjnHIqiu4oN6LCqPP3DjvZN63q0xKKGjYGkgKca/Ip4UJIoRRWHbmVuq6HhnmnDrydIsqfaNtEOLSc1JrZDLGf6VzkGu3NJM3RKMGT2h/R9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=LHSrXgKZBR3dH8opapkd1ryBNComKudI1zGv0RhacZnkV8RSZbVPzyTmtOta3OV2rEbwE171qylroiNXMQe3wgWEPhwmXLiKE3zRi3G8wTuClVexHeZku09cMVQFAMIeVGrVzusG507qIevkEcx0wpEzx1hbqOg/GF7CusO8CN9JANNKAUAxG0ZzSuj/9GnwplB2jHUnH/bTscmkiDjJWa6pIqmZzPltKczzdRRKsfGxwMddDJCUnAgESd0Io1w4U8/6HRkxM2eMH5IzyVDZJOI3jAqMuxcNXTKK46Xo4jsovGTdjOUCINqY0Pg7u840YumGNhC4D8nst6RL1Silcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=JkExP7OOxZR6JzTKvbzJZE9t/RZWSDNYZOp0aZ2E3acVLcJR6twirhqEa3T0Eg82a1ONcfHCYv250S2sx5zCLcmCR+W8f0oWC4O7Rb/RbHX3ojyN16+8K3HrCEIPd99bIlJOZZnbCOqrsw7hTeAaMP5GlQkP3Bh5GSmwv5exIWA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7404.namprd04.prod.outlook.com (2603:10b6:806:e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.12; Mon, 28 Aug
 2023 11:05:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:05:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/11] btrfs: include linux/iomap.h in file.c
Thread-Topic: [PATCH 07/11] btrfs: include linux/iomap.h in file.c
Thread-Index: AQHZ1cj/MeTl8HfyKUWvZRyNHHesnq//k36A
Date:   Mon, 28 Aug 2023 11:05:20 +0000
Message-ID: <12c19aa8-8d10-412f-8fa3-24cd39d89562@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <1dc135f94f5432b2c2264eda691787a3300ebea6.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <1dc135f94f5432b2c2264eda691787a3300ebea6.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7404:EE_
x-ms-office365-filtering-correlation-id: 13838409-5b9c-4392-fbca-08dba7b6ab8e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUTVehjy5lDKCQLdDoKEvaUq1ThpQ1tsn036I9VgUtda3vrLOvo03fZ2m5X0+k4Eow1r0xRrd0mBAoyguacggd6RP4fbZh/eQDp1axylR5eqFzm7TNgiVwki+0YH7ye6u83McZVS3ja3i623Ju0vhD1qX/CErxZ/ZcSrvDZ07jGbYRZZVcBued8Iixoy5t+ySke1J4xKqVqXXZvvs6wvBYHPCresuAbSckq4DaoKNbG+tM+vnE2ho8hwHMb8VEWcgOAHjTkBSQCv45hOVz5d1DNg2cWRrj3d+x8LUYz85bhFmhcVo/9Il/MbtxayGj9ElqCZZYFxuHHi6L+hWdugoKB4O/YpWk02YMg1onC6jwO3JZs/wg17/pR1NF1D21sUhUXik6ExAdcpvcSRU8zzpqCr/aEUP6NRDkyKvYLll2k1g+IS9sB2JD/by5xlV4Hvu9rcVtJ9vImL+ea+c0lGuJz+7hzgVc3k14W9lqcMuBcTEtVIugi6Z24fao2msq+zLEC0jrCUM/S3uEeDY+1M/kspkibKgCj3/TI8nqyIoSkRj8XMX8flbBd/EkqvnaV0OYMlgZ0tjoiNa+SfsLJ05kbOcfkiJb89PHVcXDj3FqS3ApEK+Sb1Vg5H3l+GKzlkH+69DO+FhJMiga6LPMkYkHKue2DOk4hsy5yjF+kKy+MCQzCeNzwk+QOkmkreKEhq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(2906002)(36756003)(91956017)(110136005)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(76116006)(5660300002)(31686004)(41300700001)(26005)(6486002)(6506007)(2616005)(6512007)(4270600006)(38070700005)(122000001)(38100700002)(82960400001)(478600001)(19618925003)(71200400001)(558084003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEhxd2ZBdnBHWk4xYmVzK2FjZkNiV2lOalJUNGJEam5MT2hmeXJuWExJL2Ny?=
 =?utf-8?B?YWNNME4vOCs2Vk12ek1LOGQ1NzZsTXhXeld1VlJuMHFmc1NURWZISkhDdzRl?=
 =?utf-8?B?di9xZ2pTQnhGS1d5WU5CSVpiamdOMDZxZUVFT3ZzMW1QK04vSHJLUEtHb1Fx?=
 =?utf-8?B?bGtJQ3JFYlc1U0luSWdlNUJhSFVlbXpJYU9COGZtd2l4bDd6YmVaSW81cDFl?=
 =?utf-8?B?cHh4TzgwU1lqZzV3QkZrRE5Relp1cDdNQXFqcXRFZHdidGk2N3ArN0RLRndR?=
 =?utf-8?B?YThtMmg2b0ozSnhBbVBaYjlWSS81ZHRCRzczbWlJNG9xS1h3bkQ5c1YxN3l3?=
 =?utf-8?B?Z1ZJRC9EbWhackdLelFwMHRCMWkwQzF2ckFyKzNvWkxOajNLR1V4NU9SaEdC?=
 =?utf-8?B?QjhlbFVuQ2daNGUxeDNTUDVYL0JLTG0wdUw2cFk3Zm00bDBtSFFSMjRoeTI3?=
 =?utf-8?B?UDREQnFuZlpMN2ZzSHhiUk9vV1hyNGtXcUQyaUZuTlFyR3FEQW9YTVo3TmdM?=
 =?utf-8?B?djc0dXFxUmlTOHMzNFpka281TVRBejAxZWR2WnJTNE10VzErS0dnd1FpTHdC?=
 =?utf-8?B?bS9EOFpHTGFVRFluSXFLL1hIR01HZHgwYnprYkppeXh5R0dUWHlubE9NL21I?=
 =?utf-8?B?bVhnbnkxNnJjYS9PY3ltdk5ITlhSU3BINUY1U2JSN0l6eExOeVRGWU9wTC91?=
 =?utf-8?B?bkFxTGYzR0EwQUZCM2RMMkg0a3IxMXFCdG9waVRrcmFsYlFMYUpHZHdRM2Zr?=
 =?utf-8?B?T0ZEYUhIN1FtNjJrWDIxWGJvdVd1MFZvT0hlUm9saGJVUmM2QkpVOGZmUEdF?=
 =?utf-8?B?eWJpZXFZbXZ1K2VCVmkyL1dPemdnZzBIM1JlR3c5RGVqc1I2Y1lOV3Q5V3U3?=
 =?utf-8?B?cDNId3lqRXdyWXdYMEg3N3Z3Yi9EZlJWSy8wRmQwMWZ2Vld2dGlKalJzL3o1?=
 =?utf-8?B?N08vSFE2bU5OSkQxK05KZEw3djVjdS9udFNlYnM0Q2Yxcjh2Q1FBV0xsSGVx?=
 =?utf-8?B?c055VitaNEwyanY3dk94OW1SSlJieEhRZ2NGM3l1QXl3bHppZlZ3M0NzaGt4?=
 =?utf-8?B?dWlhL1ZBYzAvL080Y0wra3hEZkl0c09YOW9KeTU0TXBwbHR6VmlwYUQvZllZ?=
 =?utf-8?B?TVNTS0JTMTY3WkVvb3RLZlpCUy9YQ3hiVWlEOEk3QVRzTldWY01NMU10YUpm?=
 =?utf-8?B?dWVFZ2syeXZxQ2lUYXNrYWJZUUsrQzh0TVpOZGcxbVdkclROd24yNjVXaEJD?=
 =?utf-8?B?YVBPSVNLdEdNb2s5eXo1UkdBVzNzY2VOdWxNQ2VvQktiWldkUUVibDBwRDgz?=
 =?utf-8?B?bFlRbWduVGozV3ladlQrT3RFNTJJaEtVYzN2d3haaVhudE1ZUlhtMzY3MDdq?=
 =?utf-8?B?Z0JBTFZaRnoweEVoOWdlVmthRmNjUnJqdkZwOGdxU3lQVVV0UndqT1ZSVkxp?=
 =?utf-8?B?RUZEdzBUT2c0ZUNGNzFiQUZOYzVYdE0yUXVZbG5iTllkQzhULzRweGlGNy9X?=
 =?utf-8?B?KzZ2V0VvQ3o4TmxYR3ZyQWMzcy9jSDRpMFhJYUJnZ3YyNi9QNlJPaFFxa0Zr?=
 =?utf-8?B?U2Vva08zbUVPRENKR3FqRDcvWTVtcWNZS1FrbVIvbm5La1lUT0lSRFJXRHAx?=
 =?utf-8?B?UkFXendCRFhhRzdEL3ZLMmxJV2tSdVU2Z3NMa3VBREhWMnBQazJ3c1EzUDNM?=
 =?utf-8?B?cmNVeDJnajhZeUVETEZpNjRMdG5sR2JkYUJjMmhZMndrSmtwRXQxZlp4SGJL?=
 =?utf-8?B?Nk5kT0FOcGRLaktsZ3FUSHk0NGZiMnV4TzV0OHErSFRwb2V3djBkQ0RYWFJh?=
 =?utf-8?B?Qzc0MHJJUEg5V1ZMMDg1Y2hLRERoTGYyZGFWZnozY1RSVVZmZWhNRHJSNEVx?=
 =?utf-8?B?aXdFbzZaanlxQzFvM0pYQmQ4Qk5aMHloMGdpUnB6SjVQVEpFNmpOdlN1YWRa?=
 =?utf-8?B?RWdNODZSZEJNa2JhT0RpaHROeUhTV2RXaUFmclQ5Z3N5dElaRXhxL1JxNkU2?=
 =?utf-8?B?MGtBWm5NaTYyN3hVM050UHNmUnlsMDF0cHliek5NZjJJak15dkxZYVdTQkNK?=
 =?utf-8?B?UTJDWDBtVk5vc3VFNTM4TlVsMjB1YkZ2VGdaSVhhVzk3QkhkVVZXS0xReFNQ?=
 =?utf-8?B?bFYxZ05TL3hQU0NidEg5c0F0cHV2THVWVUlvSUxsbTF6NEorNlc3ZytGcTd4?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E4B373EFCCE0E42BD5B5BB6CF18CFF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VE6b30hfQVlbw5cmb+wIuqTCeyfHNYr35cOvbgr64ubtap/HV0KnLxIdqt7HJi5jOaUvVEvglbsDgWEKOZFMnLekcgs7lCbXssBglLAG5efW9kKk58oKFr+G2I6ale3OMkMnb6xXUwaFc97glV+BaODNCWn11AJvFDNoZ81XWx35uy8CSoKAhYokT8obEzCA46YvFDydsDCCJpQfNURod42mTuBmM+ekkqwix8GO5Xhw2cdDB7XkinubbxmJz3sdI89zmpuJrjNxCd3is8Ji+8c6O3FCYx6yJyKt7Z5s7Rkvi2+XCd4gs9VqQgEzZXJSG2VOMLPLyvler54o7sWDMRcuKcj/d9wbpqhp45pB7nJAipfw6gOBt7joaftr25ELjsLpaPaURyJvnw3Rp6+Nn1C14svVz9WAlPf0ZiG4/ZvBn9foE4zt7RhUtBDpZ8aHrv7Dewd30Gj2SahvoTxDNB7siKkLZxK9bhccIiDpAlTxOiOT2x0y6ShLNuijwkeKthJgRV5DjmrJCjAKDFD+2MLLVfSqtvXu0Wrfe+jE0wyyPV1pOOiGltnmQ0yNMTWsS387RUp/nUXPHl7MEY/6v/pBYNRkWaGqWv4WSJHQde+09WhsnbRcgmL9i6yG6ui9m7m2RPnyQQiSlA842LmjLccnzP6Zjfocue/dGpsY0xp4ZtUN5Onp99DiyDlEoNN0y4odBMaOyXQdGi0a6mq8F4n8SoQSL6R6pn/bq4m+JuSxnbpDRa+BF54y37y640q1Ps1R/9W69uTtN9SAJTRh8/EV3NOaocpyGPai9MKy63010lk4rQGGfly5Q01rdZDDBnmKn1GjieidVZ1ZQXbabg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13838409-5b9c-4392-fbca-08dba7b6ab8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:05:20.6773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hl+yNeL/6q0JWIy529pVuu6GTtxLyF84+U+7vW92WvGxwqNjQC0PP0f3rO1qdJfL3lxqjK/eh/S6cix7S8PGmpkFDFggm2oT4X1JRwNT7D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7404
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
