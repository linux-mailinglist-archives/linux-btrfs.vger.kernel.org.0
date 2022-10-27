Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D060F3E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiJ0Jlq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiJ0Jlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 05:41:37 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F43CBF9
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666863697; x=1698399697;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=INKo9WiAWoBZ/Nv6V7ACF3V7s9q/F+PHCNSmD3jzk2yj+BaoO4QSkXil
   lWDPKW50+0YHuE7t2gvtZRq/S3B3J+juvU1Rhi73impmG5q+/vkw7qsIt
   k8FThhMDnPGXv4OSXGW5Qul41H9X3oI/03Soa7FW6pqLK4aHtgt8bvMQe
   7Kle7+7ftAZsKntLOdQ/BpU2HDTvTxgtgm2VNTrmL1AUtju/Vpv+7cxw2
   vTAJfGvFKxdUs1D16iSy8fLaw+zZzwzJaGOgqbpyzNNLddEO8n0hDK+/k
   5J8/CYSLBQ9SLwckgv292jY5XPI29JNf67eiqaNngJIbGw+9S3bqKqI3E
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="220030429"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 17:41:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J89/ED+E0xox+DmBCb5SspYbYUqegJZgJ3dWild+R6O4WKJ9bQrpkQT8eI+enizuhHtpYdF38Riw0PYeCCvwPhwQBJvbqiua/m5pSx7BXqp3Gb/y2JKLE0WFhf3PwvJGxotXlzVFGD8WuX1odWz4IezYGZ6KV+Z5xu9lspIuZq4VNdJj50ejM9h8jAv05F+R6Jhyl5bVS33+VqbqGRvX+hxSqL43Tc8Wgsk03LalxS5XT9tyFXnicwHEMmocqaoaGl1ZxMbsKYKcOeluB3jBPXubvQqLH1bo4E5qb5eoyagjE9FOnP6FKIddKGFh0ARGQnuAxIMzupfWKpVb4nBW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CAM9wZCub/N3yTpmheiu9mArKTrsvGOVQYUk2fgI9dNOwZ25XiKgFE18iC/7cvUqvwlqH4Mso9CAHNbT3jBFdQ85pkyg/K5VPjrfegk8AXnKLntUhjl6Nm3Hwdqsk6W0VqLyoGlD8Z+62/Io0VuVyGSViuQAeCjzpPNaVI7IuhCKKM/6UK367j66oBy+SiABNE1mlkPm/VnmiHS/AxNG1perxICL6s9IsuV8DO7vM4lyJ5o+891varWH6cFx0xxkUva7mJUfVkHI6Of8fEsFTUUXrgScXr5qLRlyfVqL1kY+IKLwxmXeVjZDJQl+A1X4UUa4A/9s34XfC2BQ25KTYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QQDEUqIBQfnfnlKVsJYsyXKCojgz/3cVeZCZxDtQXai4NxyoJpyMUG2TWTpDU0AaRuM+2IiI6RYOxqREdv+rIbnUrV83bYcV6uX37m/qGJlTRUxpddOm6FppYNZRC0tlPhRpTDUYV0gJGECRJojHgUGzEGFI2xBl2LNZJ+LKE/k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5673.namprd04.prod.outlook.com (2603:10b6:5:16a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 09:41:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 09:41:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 13/26] btrfs: move uuid tree prototypes to uuid-tree.h
Thread-Topic: [PATCH 13/26] btrfs: move uuid tree prototypes to uuid-tree.h
Thread-Index: AQHY6W7anCxTfSUWzEOepci/sPxbB64h/bqA
Date:   Thu, 27 Oct 2022 09:41:33 +0000
Message-ID: <6a3421ba-734e-5c83-115d-2cae60752db0@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <5f0b2d67f001541482da9ef9067a0dcf97727dbe.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <5f0b2d67f001541482da9ef9067a0dcf97727dbe.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5673:EE_
x-ms-office365-filtering-correlation-id: 549f8159-ff59-4119-8b7a-08dab7ff6f3e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VqMmTiNHn0Yv6YTMyWzyeByNaPIPWBkLpIE6rDnXgmk2DNkUfzLjyIOE4q4mOfm76HMPIifCg8mDyPzfGvu0/pDwl0IXuyCZJK/hBwsusFm1ytbywd5Bd7uMK2LEjojcJp3GK4DkL9Gh3SdvYENh1IBUXikg9EC+wXA8cBNBrqBBGkZxu0HBcgspN5QqgYA+pOD6vA1hwkH1qbdjSV40IgHfsAByVQdqJ9S/A1WUNvCl3CDgiYjklwn1lJWESPxM34misAyjipv0yGwadoeHwIhCvqZqvv4FpZw322RGI9nfR+hI4w6/sDld5AWxbcXn3QEw4KBEzW0xesnYglfxcZ/zNHEl6p2xh78BlzyROmh4MRT5mpwBhLVVe23xtriELsQh7ijTAdGeBxqAJ3EQMbN15fFDCRGBgQbxlF0qyRxdwWLNFVaKwudWgaJfHGjhVHpKdsPZ6hjz1SMfat1uW7YU+Iz0iG1j2rASn7lxQ5A67Hs7LQDfRcA+PYIpnx7wvMqg12kxrpfqg05ZKWMbRkHmAnFdNikk07PF4xymN8LaY41Uq4j2kZOlrWfbwcHLJT1Cb2KNR4QNelvp4IEgnfSnv08n401834fWfOi7P09LNwjdISB3EtRMeK6j65kCjChxzQmrC4A2fIvL9nE97vhC1Vo4naxEemuQGqBoICgM42meV+hBgKHRZ63yq7ZLCHiwG0PV4BdJN+xACCzVd8JLqEY+ewKebtPfsgs51SlvhC2MqCIh20HOcOBeSGC/fTRAgjUWY9VHWRsYxLuiQhd4xiohyOEKMkgE+5do714USAkv4O/XyZdVea+b1TkrEIvYVpOCs6uhH4XbRgC14Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(5660300002)(8936002)(26005)(4270600006)(36756003)(6512007)(38100700002)(41300700001)(186003)(38070700005)(2616005)(122000001)(82960400001)(2906002)(19618925003)(6486002)(71200400001)(478600001)(31686004)(110136005)(316002)(66476007)(66556008)(86362001)(6506007)(66446008)(64756008)(31696002)(558084003)(91956017)(66946007)(76116006)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTBYVGFWVjRrampld3BWNE9wZUNacGR4aGk2ZDgvNk5mcHE3L2wyV2NnVERi?=
 =?utf-8?B?SGR3NnYzK3RMTFo4L2hSeWQ3NzNONHA5UkZkWWtFRGRLemNxMTVnM012cndI?=
 =?utf-8?B?aGNYejQxOGVYRDhsaXZTQXkyRDFyZjhEcEhjSXJuc3gzdEpMQmsraHhLWUla?=
 =?utf-8?B?OWtZaGVYUzBjSytGeTlnUEl4eWV5Q0k0bFFIak5ZN0ZPd1gzWERHa3MxajVB?=
 =?utf-8?B?OUV0RVBPMXZMcWxobFNwNllVM2dEVis4YkVBcSs5YlA3RHMva1gzQWNHRDZ6?=
 =?utf-8?B?THZjVkpXZDJYUFBuQlpyTHZ2RTRnY0FkSHVSQTJYSzFMTytaeHcvQ2VLK0hR?=
 =?utf-8?B?M0lKL3RjMFdTUnpIaFJ2Z0JJWnpXRFMwdmVIUXl6NFN3T0p3d25QeVJjeVRn?=
 =?utf-8?B?Smo5R3g1SGhLbVdWbWY2NUFmdWlpL05DMVNvcTQ1MmpTeTNmdHVpUDFZeWFn?=
 =?utf-8?B?cnFwbXk3NGl5eituMWkyMnRLTDVtelNFSlRUaldtRlpiTlN2Uzk0M1VLd3JT?=
 =?utf-8?B?ZHBLdWtCNkZaVGNxaG5Qd1l6Y3ZFMzgxbW9VcVAva3B1eGVpYytUQzcxMXJl?=
 =?utf-8?B?RzgwRXlUdkkvdGs2dHZjZjNncUgzQ0czSDltTVdkT0ZNRENIOWtkYjlaNGh0?=
 =?utf-8?B?alB6Qm5NNUtIOTZER2JMRTUxVm1NdkVjNlZQSTFTeWo3SjJsakl0WHU4alha?=
 =?utf-8?B?U0pueHRXRFkwaE5RZTlwamdWbG8rOHBzektLbDFib3ZKWU9HV0syN2paaDJm?=
 =?utf-8?B?TmJjMGZNRk9QNnBzaUhpamN3WEZqeEF4WXd5SU5JUXdTRE5qS0V3eGFGeU50?=
 =?utf-8?B?cWRVTEdYcmt5QnNLVUYrN3RnOW51RkdRODl0OWVPNWMvRXJoZ25UUzV6SURG?=
 =?utf-8?B?N3l5MmljMDVQbUVxUDhNNGdZV2NUcmxNVGQvMnZ3T3lCWDlCelZRZ2ZQTVNa?=
 =?utf-8?B?TnZMWHMrcCs4UVlzdFN6WEFzcFRQbm5LVjIvQmdvalVtZFJBa21VdCtIZkhy?=
 =?utf-8?B?ZmJSUmNXUFRNUmNsdzNqU0RZRmZaVTNEZ1lCZnh6ODdRZEQxVWQ2TytNcFpP?=
 =?utf-8?B?eWphOFBHejhEa1pLTEdUekovVThzck9GeFFkTDBaam9wd096SE1NTUtFNVRJ?=
 =?utf-8?B?WDFuemJueWJPUllVZUI1emkrbFFmcjlVUnFtb3RDelE2UEd5TnZGR2xwWnVQ?=
 =?utf-8?B?M3hocTROT3YzbVV0c25hYy8wOUkxVVdIV2tBbWQxa1JITXlFcmsvWXZNYVFH?=
 =?utf-8?B?M1dvNlBVTk8zdldXc2Q1cmZGeDVBR0ZSeHdPcHd2emtmWDhOQ2tkWmNVMGMr?=
 =?utf-8?B?SXRJd0d1UVFUUVkzRk1qN2tUZWR1QTVnem04cURXMEJIajNMdmJ1N2Z2VFRh?=
 =?utf-8?B?RmE5QjZGN3BlcStWODlCZWZrVjhYQkUvZjg4akRPamtlbVBrUWlsWjhOOW8x?=
 =?utf-8?B?cW9QSUFibHBTRkpRNG1hOFpnSmZ5enFRb3gvZDY1RTJJTVkrOGFEdk5QVVB2?=
 =?utf-8?B?UURzbFdraWZBTWgxRkRHa1V5L2tQZ3BETlNEK3dhaFQ2aTBFcG56dHA2aEh3?=
 =?utf-8?B?MzU3QnJBWlJLZkNmSEZ0dnFTRkg0NndWN3pSY0lab1RGM0k2SzhHWkhpREhv?=
 =?utf-8?B?ZUx3QzY3R1JsSmdzdmpqcUJjL0wwOStjMGhpL3ZJL215YmJNSTlObVNQdjUy?=
 =?utf-8?B?NGVMbXM0enZPOTB0WTZLSGZGL0JXd0k5V0x2bTdvVEtaZFpjcllpRHUybmdp?=
 =?utf-8?B?WEM5U0hXcHBlbi9VUGZZWFJlNmNnaUJHSE16eEJtZGVjdE5YQlVyVldqQ2F1?=
 =?utf-8?B?N3l3NzZuQm9aZS9lenpnb0VPMlhWM3pTckFjUGJKRmFKTG5MZnFDdS9EeWU3?=
 =?utf-8?B?M2NlZ2kwL2JVdlVITy80UkxMb0hsaTMwOGR3Vm5tY29tMWR5MnVvRkEzWXdQ?=
 =?utf-8?B?bFJKMXpNenMvV2gzd21kM0xzbUFiNDlwRmx4c2ptNlFRVTYvenVySzhnMUZ6?=
 =?utf-8?B?bklacU1kdm4vTno5WkV1ZUEyZ1pBUnVsbngzTmVvMHN0QlEyRmt5RG9YNmtK?=
 =?utf-8?B?OHJDMHA5cnh1bzZlTzNVTStZVE5nRTFxVDgwZ2NTd1ZIWVBSbnNLWlJiR0wy?=
 =?utf-8?B?eHFURlZibkYweE16c1N6dGNseDFNZytmVXM0QXN4ZjFoTmtPbjg5cHNab0FS?=
 =?utf-8?Q?afuSe6Bwthlc7eD2u0PpziU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA1281A0CF8F8945BEF7D6E6A3E8A8A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549f8159-ff59-4119-8b7a-08dab7ff6f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 09:41:33.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FomqshiJk5sCCaUw9gcSxNMGCeS1BCRHvW+oU2Sky8TmyvrAhKxeqHnVyJrtiUS6kwP+ygoHNRONSlLKM65VTEm4J7CJ4etjNBL72mtGz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5673
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
