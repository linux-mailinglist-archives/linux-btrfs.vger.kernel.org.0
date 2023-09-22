Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E97AB226
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjIVMbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjIVMbV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 08:31:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40892
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695385876; x=1726921876;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=FESa/c7AUFymI0h9gZtLJzLkW4m+Dwm8w/YJiQLcLU98QPGqYK6QdFBf
   ePfIsjF66hshAL8O63SRwOLXC3HPYStUtkxSRZs0NbE7EUkssP1SOxNmt
   /qj9ucZpWMR8rwR8Sa6yP/9RIEBlW6IEkcVMQJG1oRoC0Vkl1acsWdsd0
   gLjx5hTcdRSkSycjF2Oe1ZVWbICjH8y23n4feJZo8A63hKS6NhxtCmk9y
   PtmryJOonPjLj2BiblFkuXQdFhIcBLI/smdQ7mKbgCiBhoLFYGhowvFfx
   2L4vWGz0ZJj271c8Y5s9Bf/OVpdKl2bgDskFpWoGR3VjJPyyYrmp9rqVj
   A==;
X-CSE-ConnectionGUID: 4VVTboChQU6de76gkBnXPw==
X-CSE-MsgGUID: YZ0qgw6BSQ+gKijo/b69QA==
X-IronPort-AV: E=Sophos;i="6.03,167,1694707200"; 
   d="scan'208";a="244642636"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2023 20:31:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfmsJtLnRdSoJVUiYVuaYJVcvXr0VnO3eZDOBoKRGemOsLix531Q8tGOCenHdqKqaOil9gxhuZTkVtciAzcTZefKKEXAb0FuPmymGMTpZn8RtE5Fr9MuLKOR2t1jw7TjCPjI8uxeWWXB5Y4D9uZ5akaKGv8E/7KZeZ6CHlufS6VPaUS68ZBHvGiqXLnb3h5oBTrRqGhsDuAy6AxC0CO3Kf8SlD8t0FmU7jd26AsCu+xlHHCEI208X9Kwwmkxqy/Sdg2iOzCqCA0UW4sbV4kc7X5fO5UjQF+csI0JtIWcekWT30mWDiN2pc/+4qTMHxnamnBKLH7+bUI3MJyVBEHAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=e3CEEHJzast62lqlNs6HNynu04bhe8jsVno4pfhhV4Q6/22+KcDlAp2tn2Qyv0dfrJTfbnypeyfEhDYCC1CwwxhM4LOwGPxNmMkpUD9NzyDtjvTZGJKAA0ngp0vQcabxlxQTSVLLaR+Ag5g99IFyh7ik9QfgIlnfKnczAKrjxNS6oQ8RIHxyzOZE7+vj5a+Bsm3s9WVlFo6TmOwXWhwxPPi4l8bP9mm5VDxw4ACJR3IKS8Zxs3gqpJJAnzZwmv4rSMnN1949doj8T0/zyQD04tJPUOrYQECAAe4UWzRZ5BxFDM6j/Z0316bZiIleXayEKthm2wNUPHUS/qUejd9Ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=nFtR9uBiv5W4HGUUYtukuYUKombsoQL5p0KXVmcWVhcfac3d665on9cCAUPnUxS0Yb0xucgd2zEeUPB0QfFw60jZ5u1ZAF/Uy4Mr83AfJtcXF+hrT+55MXYyvM0jzlxp6ePjLf3AWvY4hRschqwOFTYtT9UIUnQv6vVPqPiKLZw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Fri, 22 Sep
 2023 12:31:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 12:31:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] btrfs: relocation: open code mapping_tree_init
Thread-Topic: [PATCH 4/8] btrfs: relocation: open code mapping_tree_init
Thread-Index: AQHZ7UXm55W/2QD+Hkqh9HzzSt1ctrAmxssA
Date:   Fri, 22 Sep 2023 12:31:12 +0000
Message-ID: <770511b8-7e43-4339-bbd1-dfd9569e50e9@wdc.com>
References: <cover.1695380646.git.dsterba@suse.com>
 <90521cf5613540330ffde6ec78dc0210aa05d146.1695380646.git.dsterba@suse.com>
In-Reply-To: <90521cf5613540330ffde6ec78dc0210aa05d146.1695380646.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: e7fa45c7-52a1-450d-4cec-08dbbb67cea7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLVZQk0nr77/oPapnhmewmhXGMAvCnneK8lxtv+jH6FmtVnboSGz1hYYTKaZjuZPt5bmjz0A5Hi6INCFn9/Axoe4Xry3GSjvVKirQI6V2S6ALgBr872fyHgVRmRtl2r42Gxo1atsPrjneovsvCWSAYmInsqx5qhT2ggTr1WruKxvucT5o3CjIVYAyl50MDr96CwtCkCmj7AS2701IXv9M/Ox+6fhq6+oitMJA3CbJgm7L0J9jL9dvXfkN38l9zJ0fCs+OpExd6CTvHluzCcUhs65UhpYaRA/zSM7J5b+gD5KZl9KwcvzD7bsCPnT86BUC8YFekwjvVnautsLCzxgb6RbI+Ou+iYh/rB5MsG2ytxcc9+nJjZ5xRNr/PvgXzGJwzLaybhh4QvYHuGFrGFcizYbWOTibX+OhI7ukwO1NzP7Wcs45MsHlXPEpB8lJaMjinJieEXWDsvt7TbzpgkYpVQvo3pBcPTZjuVWMqdBYwFn1M7wI2bZe7WeVuMoEM3FlAo13O9wB8SOumLhDIpZt9yr+jSSDiBodJx39LmXpPJryROKY9A/SKH2LKmnwlRlEd2YGIG37lpxV5RLXhAYBn3Jmzk+5iR+pttVvyko3d3CjefS05Wx9xIA5ZHaVI3x3Y/EstJuFt2zDR9OMkA/R1Qj9raC6Xo2XHJH4hygvTq7RpxfberTNkO0aE1fYA+w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199024)(186009)(1800799009)(6486002)(31686004)(4270600006)(6506007)(86362001)(38100700002)(6512007)(66446008)(66556008)(76116006)(66946007)(41300700001)(38070700005)(66476007)(64756008)(91956017)(71200400001)(110136005)(478600001)(316002)(5660300002)(82960400001)(2616005)(8676002)(19618925003)(8936002)(26005)(558084003)(2906002)(31696002)(36756003)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDB6Uk0wTXVaV1owam9JVU1ocnZuWC80cjFOVG9lcGtaOEtBOHpCc0RZSDIr?=
 =?utf-8?B?SzY4SlU0clh5cmV6MGpwUytnRmh5bnVidHdXVk5pVTB4bVo4VzhKRmgvK3RP?=
 =?utf-8?B?QkVRQjNjMStyYm1zbEdFZi8wVi9LcEhEamdpcVZRS3dROXZLbWNQaXdPV1Vt?=
 =?utf-8?B?eUJ3OHExVVhVeVFZY1pheXg3MVdXYTl5eFB1NXNMM0JMV1FBcGErQVpRSSta?=
 =?utf-8?B?eWJpczZnSENwemZUK1hSb203R1BqSSs5WjdmbUYvd3hDQ1BWNTdkelJ6eVpt?=
 =?utf-8?B?K09EeURiTkgyUVp5UWdIREJEWkFvV040dWZRejdRcCtBVDBZaXZ0Wnh1REJx?=
 =?utf-8?B?QUdaVDBaVGdEMDQ5T29qL0hyeVNYdms1czBZL3BvN2MwVE5nNEx6KzBWVXk2?=
 =?utf-8?B?SFJteWJEZmxiU0d0MFlURGsvQ3hCZ2VoNmJjeGRSY09vbGh3S1hwTldrMjFa?=
 =?utf-8?B?SEVlVnZHeE02eHVwSm5yOVR6Y2JqLzFPRHl0QUZDZitSeTZCYi9QbTlCTFBq?=
 =?utf-8?B?ZUlZTFVJaHo2Q3o3U2dXNlRaR3NnU3Q1OGVGcVFoU3NNQWZtdXdoOGtwYjcr?=
 =?utf-8?B?VWZjcm5TSXFoRFBmYjdXa1c1Smp0S05wVWJpZW1zdVovN0gyTnJPVmVoL1dF?=
 =?utf-8?B?dEpTVlNIVFRxN0ViQWRhbkdBZTJxU0ZoZnNWZXdUSUZqRzN1ZEVVcDRhK0NH?=
 =?utf-8?B?bkhDL0lJYit1NFhzam05dzZSQ0MxTGhOVDVzRlZuSVdNVnBhMnVvQnBpa2dW?=
 =?utf-8?B?VVlLa3ovTmd0VXdoYWZMbC9LY2pneUZMa2ZraEZLN0UyZDFNd3FRMEVzbnpj?=
 =?utf-8?B?SGM0UEd2ZXFrQmh2MUsxaWFWUEdmSmd4NFhPdFNYd244SS9SK0ZaR0l6Ti80?=
 =?utf-8?B?a1VyUXl6czFGcGNmNUp0a2doSHNpYytYUVlycmRkY0ZEMUlPNndPRklEYUUv?=
 =?utf-8?B?ZitvenljSGdBOE5UTkN4VndBa3JPbFBqNW4rN2ZydmlaU2JIM1lPYW8rR0l4?=
 =?utf-8?B?NWtmOVJPMHRLVHBrL0Ria25HR1ZCZC9adllqR3FOdXNnSitZVlgwZE9FYnc2?=
 =?utf-8?B?VHM1WHFFTlV4b21TcVc4SlRvNzBSd2RwUk1uc25NcE5UUFdFSVhpMno2czVZ?=
 =?utf-8?B?L3ZocEpoZXU5cmUxWjJEbWs2TGNodmFnU2tJRG1DVjhNemNDNlpVWVIzYXMw?=
 =?utf-8?B?eUhkVm5JS0hNeTJYYVBDbXBuVTJDeE1LQTI5K3I3bTAvVmE2emtQREFva1pl?=
 =?utf-8?B?Nm43bVZ2ak85QTc2SnN0OXNOUlAzN1ZubEVMalUxU1FHNFpRaFg1UEpTRUh4?=
 =?utf-8?B?RWtoUitVSGIvaUNWbktRMUZFU2lGUkoyZlBPTjN2QUxmT1JxemN6NVFjZGFL?=
 =?utf-8?B?dzdxM3BVNFdERm9WNjNHdEhYcCtTZGxmZEI4WVBGY3pIQXdCK0hzV3lvc2gz?=
 =?utf-8?B?Sm01ZXlIdTJjNnVnRitpUDdkbGFkUG9Bbmc2UEoyeGord1RsOTFBRmZVTzk2?=
 =?utf-8?B?Q2pxZW1GYXVGQXAwOUZYa2puc2dUWDNSU1lWQWVZWFFmMGYybW9NUWpnd1I0?=
 =?utf-8?B?STl3a0dYdjJ1b1NXVjZkczg5WUtMVEpTbnJzTGRxZlZmUE0vSU03aFJNN2Y5?=
 =?utf-8?B?L3hUQmZ3dXpHM1oxWkNIa1QvcDlBN3hBZWFXTkZ0M00ydTI5TFE4V01icDV3?=
 =?utf-8?B?MFVzL01WYXV4dGowV3A0MGF6L2JwSERyWDB0MjYvQXU0YXZYV2ExdGJCRmR0?=
 =?utf-8?B?TzBGVk56Y3prdDJxWE55VXZ3aHJGQVpsS0k3ZTl5RzBLd0hVNkpKQTRiOUFJ?=
 =?utf-8?B?S2YzZ1dwMTkzbXlSWXE5SGdNd0Z3cEc2dUJQVHFESVlkaUJPVlRrWjNSQjBV?=
 =?utf-8?B?R0J6RVU0RXF2UlQ0c2xDY3VXcW9ZMTI1alAyWEdmSEt6R2Y4V1VvUGZKcVZN?=
 =?utf-8?B?WXMwSjl3S0hEbWpBSFJJYkxhNDl1S2lJRXRnZW9YaG5uYWFCaEEwaW1oMTk3?=
 =?utf-8?B?NVJYYmFGV1BMSmhRNzRDZzFkbEN3Y09lYiszQ0phenpvWVY3TERFZGozNWxL?=
 =?utf-8?B?cXRLZ0JiUDZhM2RTMGZ6M2d4eWp3UFBVckI0Q1hGQjE1K1VEOXNLZ2p4dStW?=
 =?utf-8?B?SWpHN1lBRkFiYm16bjJTZnhDRzRtOWpublR5ZnlmMVpvY25DMWFlbTdZMXI3?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EBC0F7B3FDF3C479C654B138175E213@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zGInuY845nRLcKQwuLVC+guMcxN5yhp9RiPKvVGh41ICbHrMejq6tIaUb4vhmeVUNkEncLLm218dZlH5XPd4MKrDOecXWqvWNiMzpw6AW8hJdazjI6p2YpYwp8981Xcr1+e32ZlUYQ79OIatjDWNEeiPc3AIjQq5uX9ALN5ttAETmvw/FpcEPXtlhz12C+H0FVQz93MNnCk+ab2JDcTzR/Er95o9Eq0rsf/to5cKJ00VNDxPN+MQcg9v1l1D028dvN7L2l1t9r0L6o3a/6ivRc7n+YDrOjGq/kA9E97MxYVebqKQ9+ndVmuTkpXUhECkclzC1zr80vjiRkkV21T9vGZTAh+RuDAYr0JnZE8mYn4pjP8uimLmfnBaGA6aMK3S/OjEb2Tnqzic8IdUBSqqdfZHRrO6U+GRmTPQMd9WmP4rbFU1aHWm+q4NGsnoG4cICKGX8JjM2IVpI7F3BnKhdy4yPPFBQk7F/wPBJo2+I3oS6XhCOIpHE8v05IKghZXFIuS1ZBsULE3ag8N7jLHca0Cqv4Vm9IRqCxRjTny2e23SPgZir6bu9zc93vtwEaNcfbFK6npYDja+ucFJvwmlPNQqvTCMnxqs9wJL8KinqP5muJBpm7rbERqSzMdL43+Gdh+gawraNmcvreUrS60z3LXAn8r3AT53trT/gR85QRzibZAhIEalQnWLnroEEvAGZ+FwfYCT/SP08UcqJe9hFPlDQBoTJDRWIVaVyA9XfG449lknP1rs3+bwYaN4tHc16wZC3ChSwTEYS6iWgI449BZOibGCewsP33z3wDEvnMwv4s6hMiNcgbTj40NRvztT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa45c7-52a1-450d-4cec-08dbbb67cea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 12:31:12.5871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVwJxuZzi/jTmEHh2P355ZwpS9LN4przG+ZTMUKOxMWpZNH5SIm36gddtXO7B2KS2cbRu4vUj5ZE+NZe3gDyKDd+wzLlJC5LXa/1sdg3l1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=
