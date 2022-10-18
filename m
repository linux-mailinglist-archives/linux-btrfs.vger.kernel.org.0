Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B3602C4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 15:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJRNCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 09:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJRNCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 09:02:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB1DB44BA
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666098156; x=1697634156;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=hQlh0Z203n4LmSIjmKTJZT51eKSCAT62mF916nbnvu0i6pqp/u91TSqO
   Htw67Vp3USxjiyLuLpBu/QK4IFx9USihPyYPQpds+BlGfGrxV95Vncg1r
   OBAGu1/XauK9r6DFCsF1O99LFHYAuCSVaSrN9NpUzEe67/H5nyfMtibLa
   hQ/c94CM/+ps2jX/YSch+jZmM7MofQDPdVsRGCvJd/XseAh6Ft+IxYaro
   ogAInTcToWoERcwYLQn6+DUB3I0QzzarCWCNFvLSf5rpgQhz2BbU0LnqD
   HBBLzeUZfljgF08sFkG7P7TQ47NCpNP/voSc9VjtplhuR3I+M5eSLBJ99
   g==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661788800"; 
   d="scan'208";a="326227511"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2022 21:02:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsKSYv1DfR5yqLO0kfsExlOpyEu+t93zvldBjYRibXgO3AX9u4vN6mxBuRCj2zIbYQSlwApeSkFTAciYoLoDA9Fy2iJ6nJeDFFj1LDOG/Y9kKMONSGd7CLZJPSZXlb4syks/a4bVEKTE5MDxExlYI840SPZ7sibRIZpQxUprT6GedBlylGGNSIRcPWEaUDvfKLmAW/igP76T+qvxga3PeLfeIBC3ucNbCK7Z0IbXX54hfoFJ5VWPFr9p5U716b9mUTBw3k845/tUNveSIc2IAugY9+fWvM1w2/L/en//PYa3JzbvVsF1zc6Sbc8emDdacNGX+vup/1zyrCldwHeslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=cIjc2lOhtoqMncbb3DXfNVvYbWniEDubvgRGRo4ObT8JKxELbTVyowF/o3AXMbOYV6MZHv+DrZwVAo9m35jqZ+1+c0B/tzvacl14dlmpGfnvMHkehDKpKgdhoSUEnK8Ke7qz5t453kUlJCfV95nzr7qvZWvG3jzbqn1Zg0J2/QgsqRrQn3YWYfKSq2jtD9L2hxwjdhF9kGquo4zLNmZYyWlPC5mVyxcNeiIRO7tF7iwl+2Ur08Jy1U0woZw/Vbkxtln6Oa5Qa1CkUVIYS5DuxiSqupw0oQmRWVt2VOhQQy1gaL+/Ky6Re4mj9kz/5pKSZc1PlPTncC8FA80QHRc4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RAh3bwT4ExcoQvk+CR+GW2RlU55YmTcDg40JwcoRcfOG6Y8HaB6GTuOl5VEhUnvjnR869LYoRCiV83mUMSDtdHWgCiBQEMdeE2zvB9ovI8SQBwPicqOR0SUteP2ppzeTtzqMsj254cSx5aStBEnl3H7YSqgp6IC0xYqK4OU6e2o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3602.namprd04.prod.outlook.com (2603:10b6:910:91::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:02:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 13:02:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 06/16] btrfs: move BTRFS_FS_STATE* defs and helpers to
 fs.h
Thread-Topic: [PATCH v2 06/16] btrfs: move BTRFS_FS_STATE* defs and helpers to
 fs.h
Thread-Index: AQHY4lwOiZ5nwAhUIUC54/Si+s5m+64UHw4A
Date:   Tue, 18 Oct 2022 13:02:34 +0000
Message-ID: <9f3a8471-d364-34c7-1fc6-5162e77fa549@wdc.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
 <49eb8ddf7ed81dfad378f73b290a2f6c1e332feb.1666033501.git.josef@toxicpanda.com>
In-Reply-To: <49eb8ddf7ed81dfad378f73b290a2f6c1e332feb.1666033501.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3602:EE_
x-ms-office365-filtering-correlation-id: 67843833-a12d-4cf9-6d97-08dab109065c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uD8r2VMGLi+YflsB+kkbu4Ef01LP9jVpzFT0BkLVbsc2POoXWX6t9hBZ76axlKpcwHNvtPN836N2R8vJGjvILlqEyPYx+ayU4z9I7Fuc20yZfp1BT+jC7oMYoh8NAkeWyn5qZL6bVznGAugHh4zkw1dZLA4tBm8+26L8TXB7CX9Pf3zlpMEh3g1yZNYw6OtLdFI3t1/qTW/FmsTJCpcle9NsuOWzTUp5aBWu5tGpuQL7jFtN7Dh7LhCSq+kN3uoSYi6iUZv/x6zdAmUD3J+KA2mOWEY6yru3K/8l0ZvyFJVQiR9RcwIBoVusg8PKev/YFcPmdXqSCLDecxUeg0ORCR4PPafTJGl/0s6Hyrim0O/Rkzs/TIDvi8FuiiqxXLr0sZfLesLBpO2gslh8b49bxptRkaqo3QRgL7jp6fMTwgW5XsqWsKCCovAHka5gIJvFmLxB8ySb/AdFbD/gisa8wxdq/ZfvO/mPUHJivSmlC/ifTNq2EcKLltRTDpguYtp7wOzux1uPRN1pWa7cAsXXNdQn9E7kpOZ5y7ahCDkKYMrEU0gt8GYqXfZ4WDny/AoQNv+c+qThyLGZ4EoAFtFvH7TwXqNVktzZs7lLQTzfef/VJRgoAbYdKoTTBcdXa3AQFeVzEKoiDjDtWieMRrrm5YR8KC1OxDKREw8G5RLqe8MyG+n1rh7awQgnk6U59xjYNlmlv3eivejlbsuhVZgeMJz+FUxmPPpUl53wGZOS5aM3cCnAzkyKdwE6rqYXgmbASdCGP+9iwMXksAVnKOYzcDI4ihIEpdRwBSGZ8rjTnOhBXi3PNHsHLUq+iZ1cZYZQSGUUDLkz6rMn73gt+Et/uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(31696002)(4270600006)(5660300002)(41300700001)(558084003)(2616005)(86362001)(8936002)(6506007)(82960400001)(26005)(38070700005)(6512007)(122000001)(38100700002)(19618925003)(36756003)(186003)(2906002)(110136005)(316002)(478600001)(31686004)(66476007)(66556008)(66446008)(6486002)(71200400001)(64756008)(76116006)(91956017)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzVhZUgxZVA2NGo5NkRKbE9sVXhmTnRZMDI3MlphRTd2NUhKWlU2Y2ZwbHV6?=
 =?utf-8?B?eGVvMDdXMThiUSs2VFIva09SdG9PTnk5cXZjNW45Y1J3a3V0NzZJalVMOGJL?=
 =?utf-8?B?dk1QSzgyRGVUYmY1K2wyS3hibHp5eGlGSVRKK0xDY0VCZVBoeUgrd1lRQ3Yr?=
 =?utf-8?B?SzJRZC8vUEFhZTNJZzNVS3V6VGhqWVozd3VxcmpNazlCVWNWa3RkTExjRDlI?=
 =?utf-8?B?T2lrODExeDRhWmxJbldpWldZOGpPczNOeEVKSUNqRWZjME1tRU0zNi95SUNS?=
 =?utf-8?B?dmV5aFpqZE00bEhyWUhvZ2J1bUUrUDRnbFFrbmQ3ZTVQMlArbU9QT3VRSXA5?=
 =?utf-8?B?dXJ3SW1vZjJreEdDbkNYSEcxbW1tc0Y4M0hyTElieDJFVWFHQ3BIM3FiTjVn?=
 =?utf-8?B?L1BLQlNWSFhjNmVXSGtPc21RL2RIYXVWZHVNam1JbmFjNCtRakc1TWhLcDVs?=
 =?utf-8?B?ZmxubFhGZFZ6M3BMSTZEeVZZdnhNOE9SNzBzdyt2Um1JSnZWcDU2OERlS3kv?=
 =?utf-8?B?T1RvbTBmOUZ5SWhJcDdsQnhHc2hkRFNwK3MxTXJJWUdLVkhZSVNEYWtZZHVl?=
 =?utf-8?B?MDRCbmJ2NmtFZUp5M25pbXRBZGg3Q3ZwOEMxWU1tVWxFL2ROYnlMeWVJSzNo?=
 =?utf-8?B?cTZHQ2o5TDV4MmZLTmZZbkFrSGxVTXU5SkJVT3FPSU5nNkxIOE1ZU3NtTzBs?=
 =?utf-8?B?Syt6blBxQWs1WmZrZ2ZEd2lvVnV4TmNlMnVITVlWVTZQNzFwaVRZZGNFRTNQ?=
 =?utf-8?B?K3Fwdk9PUGNrMFlOQVFvcHhOS2pYaDVOQk5Tc1JaRkpsT0lzUEg0dGZCWVJO?=
 =?utf-8?B?d3Z2VDdlbVByc2hOZUtyWmVKVzZVSUVwZWRJTHBXbWtDVWtJN2dwZ2xDbjRu?=
 =?utf-8?B?K3d1NXpuS3hOYkUwczh4UjByaFZOU2pZZXJTY0J0eXBGellydnJjWjRBOHpC?=
 =?utf-8?B?Mmg1QTVFb1F1QmoyeHZzWUlvdU9MR2ZFTkJMTGJLcThuSWxTdEw5bXQxM0pK?=
 =?utf-8?B?bGpPd21lUFY5YzFnMVNpOXYrWTJ1eEVKcGVmZzAwWTJHdnZENXJKTTFhdlBy?=
 =?utf-8?B?RGJXM2Q0L3Axem11ZHp2T2N1cmFJQWZBRmt2Ri9TRXduVVNraVFGZUhodEhO?=
 =?utf-8?B?NEM4aVFyMHJmSGNVRURMajRZcDBaT2NzcnJ0dTNiRk9OZUtqTU9udnU2SXVG?=
 =?utf-8?B?bU9RbEFRbTRnWVVOdzFJVndQRSs0a1YvNXFvVTRjSmpNdDRtRmJicC9tNFAx?=
 =?utf-8?B?ZzJocG5BeXRjMmY4Vk1vOGR2U0lyZjVYK3NTL1hpQjlWbmlSWmgzZXBMSlpX?=
 =?utf-8?B?eGVUak9HdVgrQmhDeEJQSjdCNnh0VHBJUGE3VjFXM29RWWowdjdndnR6Sk5s?=
 =?utf-8?B?NHJKc0pmUG9GQ2t4cVhvZEhGVWc5QzhuSDNHb3J1TUV5dkFRWUprRll3Zmwz?=
 =?utf-8?B?QVBIbGJ0RHNMUENGdXVwMTJ6NldaNDg0b3dnRndnL0FXZVM3WXFieDdIcno0?=
 =?utf-8?B?OGIrVlRhdjRUQ2toTWpidVNONjFTKzZZZWhvdnYzQUlGcGozalVUaHUrcllS?=
 =?utf-8?B?QVhiQjlZVDVtcFBwV1ZoUWxzYm5CTGx1dUwvd3BsSU1HQnBXcnlxdE9BYlpT?=
 =?utf-8?B?eVRNT3ovdEdhdXlBSHZLWFFGT01qd0pLbXpZbG9LT1F2eVZMR3NPbzh1d05C?=
 =?utf-8?B?TjYxNmJKTk8xanFJR21ZSzB4YnZUOFhxNXVrTmZNWkRFVHJ6a25wOEMrYkVQ?=
 =?utf-8?B?UXpsTi9ST3gyVmg5cUFJMUIwN3ZQejY2YjhmSFc0QmEvVVZjM1hreTZFTTY3?=
 =?utf-8?B?VjJWWklvMmJmZWNVSGcvazJGOTRidlVGY2xEbUMrNmVyc1lKY3hETitiYU9i?=
 =?utf-8?B?aFE4NEY3Skh0MWJhZXRiUGVEY3pUeVh3TXJkTlV4WDdHVFArekJMcGZKUklW?=
 =?utf-8?B?V0U1S1pHeS9adFJtOW1pRmpFd2ZqNE9FWXU2ek16K2lWdXZJc2JUVVZjY1NH?=
 =?utf-8?B?alVmckhYWUwwbVpPQThjZFFKd1VxWi9rNkVoWVRLTDVxK25HWk94RzdpYnZK?=
 =?utf-8?B?dkFQeVd5WTNwV3A5TXVYL0pqL0g2RDFwWHpzS0UzRDd3eEhCdlN6TUVRU2kr?=
 =?utf-8?B?UytGUXFjcWFsY0s2SXprK21zUG53Ky82ZUJNWHFWVlU5Mlpza2xORmJQaVRL?=
 =?utf-8?Q?qHssuAVos8s02sQaPix+TaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EA970B9BC8A0B45A917A276D647A564@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67843833-a12d-4cf9-6d97-08dab109065c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 13:02:34.5264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngMN0UjmYifBwgH7k1+bGqV8Qctv1ASdTMg79eVGTvPqfV2LzUTVnRWjGBNr3tVoQ8yM2Auhy7clO46ZatR4CScVFJGVEXyyRwxWbisG5wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3602
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
