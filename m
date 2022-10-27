Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1105660F064
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 08:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiJ0GiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiJ0GiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 02:38:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DC12740A;
        Wed, 26 Oct 2022 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666852691; x=1698388691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Z0TRqnIqiNRp+s0WbT97OkgozOYzIodxWp281Bsl42/eAKyQpkCKWWsp
   ZdFHtyEoZwFq3ddLnDID+kZG8paxoCVboEm+Jd51fiFfSfaXaXRi4EByA
   X7Vv3dYDkVuRyXGjUZOcojteQQjT6hv1P+FeajCevdCRbltkoOj10+NIb
   WO4G49zAdAaAV9y2hc7TKAWCFxUxN3e45LEJ9Yx8JMPHh8KNJQQrwymKq
   CJrRAo/mWVls3oI+eRv9qX7XTRKXD+k5bYiW3PRXIe65qaqa2mk6MxKvW
   wv0nodtJ6M091Lr/j78Xe7/w/s6q9bGVHuPSpliQpTMRI7boNtVcDOGBm
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="220018466"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 14:38:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlCs9pYk77L8dvo07ePS2WCt8TISvYERcsL3bru7tAxRUYTtwTiS4poXdt8Ad5kRgiBkT8igvsH7+Lfa6JN9ljci/PyGEpr7qMD5wfD3t1eaoZnTlmCwRRvEJq7V9khMobxnXg8EpLi801tsPgBN17+EO7tA+JOQRK1+34RcKPT3sSBNfCzMFoWrNyfcUWSsAvK9cr3QLTzFQvE6zdlcxq0NQf0IK/ePTAQ79MKDhCFaAcBEFkdZpD1a5fHm6sQNFQVthDdZQrKojoB+7JvxC4k+xP/cKsJ1gW34HGGlSoauWtQSZXwy9aEJlzNe9JWPRYmO1xy+ota6jiynuD/ymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ghnFdklpbM+hOLrFD9JJgur4e9afhGsrmyhWYTdyxf9w0zkXQmvlePUskRfSnWxSQRp/5SBPtONGrai97R6k6b5ggiqH0RxQxuweHBMHN6ptYc3uZDQO7Vkpc54WTwv+ks5dYv4aeDSWQOiddMxHmlWJCwEtE3cUbPFuxRvkytWuny4Rr89oNklFwBKAc/u2P+OjiaezkgiRhrxB2aFjy4uL/wxp0WlXOF4P70W3BlqUNyyVTYT0d4mvnhsFlFzFn4EQNg8lgpv4HFcf5ozN/oV+iZHk+mrjXwskMdrQaYbkmnMYwn/gyrvFwPjn+ackxRlU4kg1Oyg2irl60wra3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=xJM9kzYIOOLt2T0+tMcsYRtZKHogb5ZJbMtsTgHc8QvAsneGYjdZ81y1lgCQRmQ91lVN3zig+ZIm3cdtBa/G6enNa3WNgEEsYdG4tebdQYtYSqqpQLqj749LJukst0Cnpmu7t8khuWGPatiw/xhMzxRzQeqcg7QTSmatcrsn2Es=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0509.namprd04.prod.outlook.com (2603:10b6:3:a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 06:38:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 06:38:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, "clm@fb.com" <clm@fb.com>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/3] btrfs: Remove duplicated include in root-tree.c
Thread-Topic: [PATCH -next 1/3] btrfs: Remove duplicated include in
 root-tree.c
Thread-Index: AQHY6ccfZ1sAiUZQb06svZNNlEGQs64hycqA
Date:   Thu, 27 Oct 2022 06:38:08 +0000
Message-ID: <695b5218-7cfe-5222-d132-93f9f48e033e@wdc.com>
References: <20221027054343.9709-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20221027054343.9709-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM5PR04MB0509:EE_
x-ms-office365-filtering-correlation-id: 3a840150-2761-4439-b680-08dab7e5cf93
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vb2BSXQ1dV1ZFBMVWLz/mQAAprrgchChShwiAiXY050S/UTcPO8Huc8W3E4z0ES+2ACO2yzy9BiPjkE/MlAd4OnaqYHwjBTLmb0iG5UVTD9auWHYBz4g1SU1Oi0OdPVbYiGBBBGabNGgBcoycBMD4/88e+5nXGocd85/sc79NgNmvrIf8TO9MTAE+3VhBgsTUTWqAr93epC9fx2xHmeURoJxnqdaud35enWzmPE1vjQI1HtPWx1L8ke20PMFjehzF8ozIDSzM0R3+NXmKPeDOaNzntkXjMc5Y8yGp4YJPwDVOCZD5NQnUad5ws/JeQMXcLxYrEJlrDA/BMZbkAhlNbXd6RJ7N+zVcIzKHkVAHz/rLvHa/Cyw8kqnk5iLQ31MJlmKCioJkrG+HjZbKOOZ6WafQ/W9PaO0oqLxiuWt36qmbFFx3+fIUUPjqOFqEA1+/O+31cHz5qRoNJmc7hkBd643wQpIgTc0ts2iLVmyHQvm1xl7mVncBl7/bOJxaSJdb9IMD07+Qra6EcdE6wCjQq7YUtvsExbmc2fI1lajrA8F8oWUtN9iXbrvoWk92PZgaA7rIqpssDX++MCw2EiIra+N/WZyBi1lX6DidFj2zKUFVZnzyWTsRQjBHcXlrQz3YANCrqhnE6zRQ4muP2bY0mugUhIxT7BZrCfCSw1nK76712UYNsjwqHg4wxp6ZHysJqCCNX2VsC4BA4pX5AGNyGboqcNB0p6Q/ZTRLiyzvdtDhg5RyqWqM4auFNi2w4pXnQ34yNYjsJl87q2fiVPOQ7/q2VHK4/12MBK+uDo6fotOPHxAt93ew4miMDionZTjxC+i/KbPlIa1G7lXxQ7pCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(54906003)(5660300002)(558084003)(478600001)(8936002)(110136005)(2906002)(6486002)(38070700005)(4326008)(38100700002)(41300700001)(71200400001)(66946007)(122000001)(66556008)(19618925003)(36756003)(76116006)(8676002)(66446008)(64756008)(66476007)(4270600006)(91956017)(186003)(6512007)(316002)(31686004)(2616005)(31696002)(82960400001)(86362001)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjZBc3k0NlZpNnFqMm5XeFBOUFZiaVI5d0J1TGpQQkswM2FaRUhaU3p5aHNm?=
 =?utf-8?B?VUx6KzhHQW9Rd3VreSt6YWFFZDhuNWlQejBnSnczcmQwRElTVzFoZEtjaEVt?=
 =?utf-8?B?WjZ1S3JjY1kvWlhEcmtoNGh4K2NMVHA0MHpOUkxUTFRQcFE1bk5HQm1obGdW?=
 =?utf-8?B?KzdrUG1rNWFleEMrek9CU2thaGdRZ2o4eGVXY1Eyc3RIN3pJWVNiaFBKWU9G?=
 =?utf-8?B?NVR0YS95Z0d5Mm1pTVBZVjl5MFdCV1RReUZ2Vk1IQkZvaW0rNkJIcWR3bm0y?=
 =?utf-8?B?a1ZoVGxUV1ZKUDc0U0pZc0wwU0ZRaVNmRWw1VHB3aTdkSDh4Tk01NTFYQm1P?=
 =?utf-8?B?QWRQN3laY2QxWnYvdTg5WFpjU0praHBRS2pGcUM2aXhSN2hxUVMxTytvK2VU?=
 =?utf-8?B?NVBBTXAvVm5GZ1NzSjgyMXdZNThMZytIYW9iSHdDQlRPUjBjcXFRb2JIQjNk?=
 =?utf-8?B?SWVKNjR4ZnA4d3krUzBMbXdzeCtOSy9rV0lxbW93RzA0NFA2Wk40WVhuN3No?=
 =?utf-8?B?SHBmdXBFTkp6OS9RQktVS2VHWmNmLzFJa3FYTnZzam1SWlRwRVBPLzFyUkNK?=
 =?utf-8?B?a0k5L3pvcjI3bElUYkd0czVMUlpsOE9qS252YzczRzgxQmxCdStSbm1UeTRp?=
 =?utf-8?B?ZnpwblZQdFYxYkc5UlNuckhiRXZNR2hIRUxjYlRFZit3SUY3S1owM1ljc2U2?=
 =?utf-8?B?MVhCUHAzMFVMWjArbHBDSTRSWmUxVkJkY21qamRzMzZBNjdVUS91K3VvZ1Za?=
 =?utf-8?B?ZFZjVVVzU0IyT04rZTkwOUl4MnhUR2hVWFNWTlZiTzV4dW9ESkx2OVkxUmRl?=
 =?utf-8?B?WFRPb09Od0NSQnpDUmJEYk1kRlV3WVhCa2FSREJBUXFMMjNXVXVGMUVaOXk3?=
 =?utf-8?B?VEpGOGhWNnBhUU9TMXFzbStiUy9zb3pDRmNBTXpLZG81dmd2NDcvZWpRVktT?=
 =?utf-8?B?WUlvV3lLOHExdXB2enhDVFdrUDNRaFRwYUtZWVlSeFh2UG53bUgxUTNmWVR4?=
 =?utf-8?B?dGx1TnhNZ0h0ZGVBNjJlMGwyeTNTdmFBZWpFc0NBa2NabTEwVTBqeVJWeVBp?=
 =?utf-8?B?Zkt1amN0TmFDNGpOdmQ5UkZmWndUU0crVTFHRGxJSWhYZHhIdnhQUS9Gc29x?=
 =?utf-8?B?Tlk0TjJDOFdPQlhTTnJWazI3ZkRPSm9ZWTh1dU01VEU0ZFBhN1VYS3k3d085?=
 =?utf-8?B?aWw0MGVqMG9YVEp1Z24rTHMzS3lRMmFZR3laOTZCbXFvZ0FjaWdpUzllaVVS?=
 =?utf-8?B?Z2dCb2d3NWJSUEZmL2FJcFRFS3U1b3YrbCtia1I5S0N2UkhXK1BSTUdkR2cr?=
 =?utf-8?B?bmZsYlE4S3pJTm1acHZDUXhFNnBHMkx1bktkNG11SWxENWpUcmJlNGhseXBZ?=
 =?utf-8?B?NTJEdEpybmE0QUgyUVV1dzRxb0t1RmtEbU1YVGRkMmhzWXNabzBPaG04Yyt1?=
 =?utf-8?B?NU0xWDdMcnBITmV6a2lwaS8zaHROY0hFUEE4b3YxZnFhdDRudHZqQjFwSU1Z?=
 =?utf-8?B?bXFxcHlhaDF1YWFHaXFVdUtoZGo3Rk55dFhuSXZxNDVJY0Q3N0Z3TS82cUxt?=
 =?utf-8?B?THFuWGVXeTU1cVJnOVM2RHI3bVJtbkl2UU11aGxMbnlTOGU1cDNEMlZzN3or?=
 =?utf-8?B?MFg0eUNNOVpKMERaNVVCUEN4L0oxckZ0Z002VU05dlFqQ2xtTHRFRGV0TnVS?=
 =?utf-8?B?WFc3citlMUI1dzg0bnZTOTBFQi9yd3VjS2RyczlOUXJDYWc2cnpwNXRKcDg5?=
 =?utf-8?B?UjVLcm5EQktERStVclZCL2hhRkdqTWIrMmVNSUszWDA4Z1ZaR2RPTklDZWtn?=
 =?utf-8?B?Z0dCREEyNzM0Qm1oQUh0Ujh5RDh4WVlEekxGMi9FaUt6SWtnSHlwY0gyZU1i?=
 =?utf-8?B?YnhPaDU4OEw3NFZramoxSWtVVTRESWFCVEtpczQ0Z2lxVmd4SStUbE9jRzI1?=
 =?utf-8?B?M3J0YXdKeFFUVGJURTN3ZW13ZWFsMmsydSs1UkhXNkkvOTY1QVhML0xFb1Fs?=
 =?utf-8?B?aHEzSjFIWWNhbEV4dmVYSFk1QWVwaGZWd01OOVhqaW02NHJaYmdUUFJSOXEz?=
 =?utf-8?B?dXE5SEhzTmRIU2RMbUpNQ0hKSFg0WUhobE1PcDU2L2pDNXo4Vm43L3FKaXF3?=
 =?utf-8?B?blJpaytnUm9VSlFSM1hSMldZcjVjSmJCOWkvWFpvdUFYQkRXY1Q1ZlEvemJ0?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66E883A595E52341B06BC5DDED4D551E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a840150-2761-4439-b680-08dab7e5cf93
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 06:38:08.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a788LtglN69xWmcvWdYai3VGNSbpnF2BQ5WMfbzHh1rAkVNSsJpPCABgtGfVqzlhU8WfEvNJ+cDQs/gIszJqbFpmYnF1WE9eqo+bMUOanAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0509
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
