Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C460F4CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiJ0KVG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiJ0KUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:20:39 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C3117889
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666866037; x=1698402037;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=UzZfvcUQXw2nBxe7VzP8MHGXN9RlZR+9TpYNdmpey8fn9TfHsr7ybDhP
   E6ng9jK63J7GH+gSOVqJtoT5XBlXIWfmBjxxwo3dA/427EtET5+T+QV5U
   //rHyuS3GUtXvlHRUfAtEx2SVyvRxsAdZIodQh8drQQ53/vbIG9KZ0duC
   J8cCAPp3lRegemDZ9Ndl9mnBKR1a99XyLZ2Mb17/3ab9HMAvxsyGGc3Jy
   pw96L+ZAm8QEoIU4pW65hnEsh3JKBtF61/Q69XKeuJAts7AXZWhbX2gz1
   RfEIORAiRBHhYrRjbrzr3grZhXcKNS/fUxh0deA15gcDx4IhfgTrkLi00
   g==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="319191826"
Received: from mail-bn1nam07lp2043.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:20:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYPU5KNplT7Z141W4lozicj0aJi6dfh10TQSmDbLd3Rba0P8pKq2cSDewQF48x+waTM8B3sycWF+W8YklmVgjl+IA6tmy55rM9gKrgr7UeL2HBReg0loziWVdIhx2tVWWPnQ0HUk4HlRREtuw1LUmQE2J9amTgyN6slU07rM6rX1MN0xn+XaCsJ7k7uVG8NisEMpsOkVrk7kUZyeQuSJdElOG0/Gu2c6XEfHqF1zZtT6w20kdWBHKmC0ki84z4s/iHzial/1l5lmmsl2oBKvE2wU+HvAtV+LG/KwZCigdYo+hOWzUGzyo5ZrRMW6Hfp1uKBIUQjzWj7raDzMmqRtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FB1mM3QNeJcy+Q8zO7nAVFeX4vc+ko7Md1IkgJX6meTk9ot1TFy/e/m4G5Y1i1ZuseJ3AozWCR4ZzUDcTZ24s+dLN3ov0C6Sr1EbtDui3RMzcF77MEIVTqyekYVhibuF2OxwURKGK9ztvHmcdMZ7YH3HY8jtvaPbqQxA5dloYw9PCZhuMXfm9nzAvcHcLLIZhiq+gAR8hZlR23gQqCCgWpSzXYP8heMIPSzrDUA1HozuVzjqeuQt2Fp54LV3XT6AAdE4vidDTWLmsO7tiXIO4ssem40I6E7q15Coizs0yHPORe9lOXF8bz0II71EJLA7ZbvFHLg3BHClPd63kEoR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RF791Fyu1WQ6m4oG1+n7tO38ZxAcvHaDabqfe3FM5Zrve2Eq3t1O7u2cRm4S2Sdls+ntPnjVzbkUVfGEQNn9SjqUZUG+IdTu+QkUQN9AVbmjQnkyylc6gKLDu35DxuMuruGXCdQbp62188HMDm8vkIci+ztaKAz8+22hEwLXRoI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5524.namprd04.prod.outlook.com (2603:10b6:408:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 10:20:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:20:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 23/26] btrfs: move CONFIG_BTRFS_FS_RUN_SANITY_TESTS checks
 to fs.h
Thread-Topic: [PATCH 23/26] btrfs: move CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 checks to fs.h
Thread-Index: AQHY6W7q+d8wQaYa+0GaQ3nVlRONyq4iCJuA
Date:   Thu, 27 Oct 2022 10:20:29 +0000
Message-ID: <006c5f01-acf7-0475-df99-4ca1f38866c2@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <0ff1ac879d15f46afe7cbb515423a7046db1830f.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <0ff1ac879d15f46afe7cbb515423a7046db1830f.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5524:EE_
x-ms-office365-filtering-correlation-id: 00eb924a-6791-4e4d-baec-08dab804dfb4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SI68zxUQT9tKgInS3KUsFIw8Mud4UcrxUqFvkwKf+sj6MxpO8X1vFV7D9zcsxy14ED7ehtHpK5+oD/Jyn5Z/+4eDJfuSTsTmv33B6zapU76qZawtpPMpvhDTUHCGApQjfQTW3Z0cKCBwkpmHwdr5jKD+H12+xeMijInuTupaOCXlrBFzS9j5+LpCoNLnGPLVxTP3mcxQF960buciA5t1fvPONPQzp0Mryedh9PIUO5c76un5J4olWnJmpV43GAMH7jmO6phBAW9cY3pNNdycAZqfdcZx3fjiH0gcjDB8Kp4X6k1E5nX7pqwuhVUb1LxuRv+E7SLLi8OrumLy+5UouxMrC8Qp66gRmRuxhRunTjfN45Q7XlAxM85INkwF3uAGMthoAwLGfZ6coDid2WfjhkKXtKU3408ct8Z/caeukqeg1l+gHBqQMkSl7E3FQ7b/lpTgFR8FmsuxJrutHQfvE+d5PFZttYTHLKKrPIQLhYDKgwIirEDQ+YdwKMXDYEr9UDYKyxQlYh3hJMHaz9Ysw01VyMy8535SFPOQAbDxoliZggfZWEHYuDX4abEHOzfRUSA2LYzeRs7H1D1+CKeywlRKWbi/ZN3jpAulxUgjWSY3pyedcmJbBaywYtrCo8Cost19uNmRKIghqHAqEdS5fkm+/5iApKkCFPQHEO3S61sLMMKMPumk5RsL8fv/NAMJW+cWmWrVRUH0+d+av4sWcQ+5yNDDMN6jvOhxXkxeMlZSV7OuZbWSNs5Rk2GdsNfRfaWNcmIaLCdGt7GTUBW805URJZG6K4F5W7pEibPWUEhqn88wGse7u1xchxEiW7ryrowzGea1TWdSIeSo/OxjEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(31686004)(38100700002)(2906002)(122000001)(5660300002)(82960400001)(558084003)(31696002)(86362001)(38070700005)(186003)(6512007)(4270600006)(26005)(2616005)(6486002)(71200400001)(478600001)(91956017)(110136005)(316002)(41300700001)(19618925003)(64756008)(76116006)(66446008)(66946007)(8676002)(66476007)(66556008)(6506007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXFQMTMyYllWVExDL1dSbWtWajJCaktOc1R6ZEZGTnQ0YjNRelNTUGxrOW5T?=
 =?utf-8?B?UkVWQ24xRXVHeVhQQzA4eVJtNmg4bkkzOFRISFcySzE0cnh6TFd3SGVDczhs?=
 =?utf-8?B?a0ZsdGlDS3kzWkdGWjFsQ0g4NWI3dExpYjJlU2p5K0dndjZITnlkcmJrTzNq?=
 =?utf-8?B?d1N2R0NHbEFwNWQ4ZU5nc0Z0b3J5bmNjNUNFUzNmT2pVMldBRzQwWU9VanhP?=
 =?utf-8?B?V3dGM1cvMWx1dzN0ZVJsbDRLbzJuLzdRR2s3eHo0cEZXYVlNSnR0OUpDMm1p?=
 =?utf-8?B?YnFIdUpMcFhrMGZjNGpnTStFSlJZQk1BSTQyN3F4UTExcG16S0RjazV6YmMy?=
 =?utf-8?B?cmFoRkxlVWY5RXE3dTk0WjlTWHJnc1QxNXlrbnB2bEM4ZEpNYVFvSEI5WUVF?=
 =?utf-8?B?TEVXZk11VWtLSlFCaVpvSzNPaTltQmlQbTg2NjNWNlhqTm9JeVkwQ0VVQm1N?=
 =?utf-8?B?TXZRNEhrRFZtaUNPSytKMWkyRDJnSmhVdWFOQjAzVlVteTRPVjRINjlueTJO?=
 =?utf-8?B?bUdDd0tmQnhWeTBvM3YwN0lqSmsweXVmZk9DNktaWS9kcE90SzAycjhyTzdB?=
 =?utf-8?B?dXpuUDhtQlNHdGYrTkRuQ1Awc3pSRmM4SFo5RHNXNUh5TzdNMXBua2l1Tzlm?=
 =?utf-8?B?eDdJK2dXUHdTZlFSQk0xNXVGTjRta0E4QUdUMllwS1NveGVkdWJiR0RVVGZp?=
 =?utf-8?B?SkxYS2ZKcUttV3h1K3YrZTFyMnBVaUo1OXBacEV6YUg2K1JuL0EvazdOU1BQ?=
 =?utf-8?B?dlZjS1lQSXhZSVBBSGFieFBIcnNPc2pIMjhCQUJzanJsb2lSdzBxRHdFUDRx?=
 =?utf-8?B?eWZyMFpkZkFNTzBXOGVDWTVvRXFNU1hUemVUbExER1N0emVMb2pLMHY2Zk9S?=
 =?utf-8?B?TGFoVlE1YTdlcmZWemtlV1RRS0U2QjdVWjFxZ3lGZ0F2NXFQbjRIUE1aOCtj?=
 =?utf-8?B?TEU2TDFtUitkOEt1VDIyMGI0NVNVdElDSE1MdVdZOU1KNEc1RlF2NC83dkpv?=
 =?utf-8?B?bU1OQ3V1akNDelVoTWU3UEk5cVYyVDliZmlNUGlSMXdBSnV4OVVCaEEwaHc0?=
 =?utf-8?B?QVFlT0VQbThtYk4wME9zNllyVHhKYmNYVlpIK01sMEh4N0dsWFE0N3NaV09a?=
 =?utf-8?B?U1gwV21mVG5TUE1yVGk5REhudlhDTDYxUGxBNWZnU1pjSitYODBRUk15TEdC?=
 =?utf-8?B?ZHNtOWh3WWNEMWs4RkVFVEpFVFhad0RGbSt3SFptUlg2UlJiK2VseUdhM3BC?=
 =?utf-8?B?ck1xMmtFL2U5Nk1HQXpvZFFrM1hUYTFRdzdiWXc1a3NkdFZNREF4S0xsSHl0?=
 =?utf-8?B?azRNc1M0WWN1WnhIdlRSRlRSb3d2N3lqeCtWODFxT3k1SW5wWXZ4RithbHBy?=
 =?utf-8?B?MVFkeUJvUEdmR05uakIxSHFXYWRKZUNmSXpKNkkzQ2VjRVRnYVc5RGp0V09T?=
 =?utf-8?B?ak5BVWgwVDVtSVc3RmdxSXhDdTNjMVdvTGxqVEsrUUxmMGdRM21yQ2p1b1Zh?=
 =?utf-8?B?VXJoMHJ5MmtDTDQ1eTFud01YeXlWMXRnai90T3BqcW5iWlluVGl6UTE4OVN2?=
 =?utf-8?B?alBTVENub1lpZnVKai9uVkZQcHNmUGxYVmRFaVZZQndRaS9iSU1uNHdzSUdv?=
 =?utf-8?B?azRRWWYvazlaTDBlUG9FNWFjVG1hMzhnUUlib0NLdXBVM2wxZXFVY3Q2d1hs?=
 =?utf-8?B?alpjTVMyQUxpc0gvMkVQRUpod21zZVVldnl4OFQvWTlNSkEyNWRwUm8vajht?=
 =?utf-8?B?U3FzckdmeUwrWDV4QjZQTmhpY0o0MC9FY2RQWHlpMEtFRitGencxakpNTTRl?=
 =?utf-8?B?bkZrWWNFUXBqcnhUd0owVkxGTzZxUisvMlhMOWhNcVNCMFdqV1Y2YmdlaHJ3?=
 =?utf-8?B?NTdtVVY1Q2lQelExbUQxSUg3cWhORHNqV3l4V01Xbk9Sait3SkNkUzl2QmZ6?=
 =?utf-8?B?U3BTWXlHSVo2bDNUS2ZBS0JvbVYxaDhMTTJZNW01U1lRMEpJQlNVSzdjam1Q?=
 =?utf-8?B?Tm50UzJNeWU2UWhiVy9aOG8zeXhzQ1RaQ3huMnpjNFNFbUFFcWw4SmdOTGw3?=
 =?utf-8?B?OEU5Y0NobjlKSElYMTVERVR0RTNlUU8ycFFrNENoUHpnOGJhbEhyblJDNDg5?=
 =?utf-8?B?WFFSdHZ4VTBSNDRjbGk0bi90bHJ0bDRUY0hMb2p4T3Y1WEViNXNrRTI5ckFQ?=
 =?utf-8?Q?OEjFlyNyMSEyRJI/bCF5yIs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <035A50D2920D3E4185B4ED80F96AFAD8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb924a-6791-4e4d-baec-08dab804dfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:20:29.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ciVREz4PAcrf46U/P4YxkaAo7pY8pOLTpcdJJl7+1t90CMLA6BOGph8dR5EsVo/FwV23VSBPAsI/UKxSHQwp1l1fPiW4bJ/8ge8+ngnWnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5524
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
