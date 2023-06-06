Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217FF7240FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjFFLel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 07:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbjFFLej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 07:34:39 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D6E55
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686051277; x=1717587277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uggqB+s0T5AcRR6q/bpXftGZQuTCu41lx+cA1yq6LqY=;
  b=PzCG4kOv0hCjIphcx/SltYCB3ngJYFD25s548087D31YCg7MiX9Gwn9B
   8BZ/TIKpiTTeulnXb8thsRUkcZgR4MX9iFoROcMHMiFZ9P2Rrfg1FFbkX
   Z94Sichmuyyg9jE+PlWbJyuLVHvHXvNJYS/afIJR/Mq9ap5LxJsCRkSh3
   MOW/csX2E5SLFbziKLjc8PaK/WUvosa1doAGBVLrg9pdrszTe1Z6EJvqB
   Fp6/Wp1GcLkCUe0vGKY0kYL2zjoKvFYicBF5k+MXBhgP3WvGz2dj8Jeyu
   ngHipj9usht8jJbveL23UKt4dgHlJXcO6KBTcfzBO4x1BN6l5AII70EWn
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681142400"; 
   d="scan'208";a="232659954"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 19:34:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN2/iHsA5j2yMTJZ3+2kWRJk1FaNATSPhF3LCdoQrMHfGY0HbLhQ/pC+kv449MzV5BtWX9VzxclpYihYPByTjl07k+jFh/iIhZ2W37dFKkZQsY26s26TLYkExvlqoUhWVQ0p9AYey0NsVwaW1ooedR7doFYVR1k38CDD/Lp9oxxmaMVmZ20dSaN/Tm/4XG75GK1WnYO1ty/aKoFIc8RMzm2yqvFC/z7OGSHHw1faEci5M60Z2SI6KmVW8NlrTZlni9xlLVHR7d7EB5VvXlXuYc8cUrqLwTdHqBd5NaBR9yjyB1VrB0JYr3fcSylfjI77NqyX70bCqM/0eujaIsKMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uggqB+s0T5AcRR6q/bpXftGZQuTCu41lx+cA1yq6LqY=;
 b=lkK1uEEPFtkbXk17UHNHu4Bzrd4FbcXH1bOz1/OmjJ2xYPSQMbFhGK3t06BVgjUOEkiiJO1PbkVyOS2Qm6PZrlBQXrpDLa8XgtAECF0GVdVIPSFf4YAxqwH6W0TwSlZ1rzUF00SoZyKIBgwsHj81USbIVTNDJL1mJmyWmVL3fMvzg68YeSJ1YrLVlRNZ7q/1Z8xPI01IEXx5HQMw2ZaAdJHZUdHZFqFAd+3qEVMpUKiRPugSDXKrD1zcjuVKLJN+lUrqiGCCdzBkZ1+cmoTKsceOqoyvJA8OdpIOUsHXiySUnRMTZDeYsx7Y5JLahKexf3+u6oiUrqJ3K60fTgC6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uggqB+s0T5AcRR6q/bpXftGZQuTCu41lx+cA1yq6LqY=;
 b=qnHWE3mXY6AOtYktJjQZKHUng3HcosZv3SlFr8uIoj2TiQgr5ejPEz+6lJFGy/6SyWaHyFsj6K7ZX2fne8WdGna7Nqr3zwVfkAgnxiFGgY9A7KOLyjqwg1hej7v5GMetzoMAewbpYPsqFFCnOCip29/DUXm9xncpAksoAeyriyY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS0PR04MB8598.namprd04.prod.outlook.com (2603:10b6:8:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:34:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:34:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: bail out reclaim process if filesystem is
 read-only
Thread-Topic: [PATCH 3/4] btrfs: bail out reclaim process if filesystem is
 read-only
Thread-Index: AQHZmDjxekOwR7J/xUOLAki4HPIf0699pUkA
Date:   Tue, 6 Jun 2023 11:34:35 +0000
Message-ID: <baf014a3-7368-a328-3ec8-e7cfa3a7b25a@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <d0a60acec35353dd7ad535bdddec0907857f2dd6.1686028197.git.naohiro.aota@wdc.com>
In-Reply-To: <d0a60acec35353dd7ad535bdddec0907857f2dd6.1686028197.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS0PR04MB8598:EE_
x-ms-office365-filtering-correlation-id: 7f7c907f-a5b1-4eb4-c61c-08db6682010a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBs9/p4gtJqirbcmI9pj17+a1tZaErQZqsx9hAiWa9P3w4ICeWJJlHyxOsr6O9hNCC6gD/2depNf99s83fNcGzN/PcU0EP4Te4VDtZK0YC8bO0BI7d/YGwIjNJVXaI7a0rcF0U0j/LZLrjqWtBihRfs/LxDSpcYJUs1Kq9mwHQdrJghroWptuJIRMfZ7X3wBavKWpnA/ZZKgSMQvps4rkrCGW+GCty0ETggmRLeuNkxMS59tthfuIhgfH2Fj+4KynZrjAa6+ED3LokVRXPaC5b2mK1tPymHpp+uUFteRXBtKDd53XpTlBGVAAof+QjMlDeIe/BlqUAf7ePYitk9jpypz6cpR2u7+A3kL6N9oXIMnixzYpGH/XiQy7KhS2LinGo2I8Rddq1T3NEpVVcg5sjXwNHec00HECsr8Tx5BVmsjzuC9qbuZ8hySVbtok4cfGYuZUNeIs6uSV4LmSxjdVJq9hQpllPUnyYeU2oqW/LYjt7+WiPql43lFnK98r5IxDQpZoroxlGwNqSmJZ3c19QkTI++X877zH+qZUgDYYAyzmoiNL3Gs+GTg/b8gHrRjlbr0tZY4zVyV8Ev10TZ0LVNde/tjVQwP6v2ptjDDbqKKtNuQhyrtJ6btWzqaPdAPMvjBySBSBxGeF2Faq3oI0lphKRSxVUiUrMt3UfbUwJxvUOfGe0dwhagb7aWZIGVW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(478600001)(2906002)(6486002)(71200400001)(36756003)(558084003)(2616005)(38070700005)(6506007)(4270600006)(86362001)(26005)(31696002)(186003)(122000001)(82960400001)(38100700002)(6512007)(110136005)(316002)(5660300002)(31686004)(8676002)(8936002)(66946007)(91956017)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVFsTUg4QTVnRzlCZ1M5ZGdjNDR3VkhIUzlQdnJEaGJWMmNCc2FBVGxCWHRk?=
 =?utf-8?B?end6Ukcrc1hidkVsNmRDdWZ6cWJ2VlE5cnVPK1VSSHN4KzFvQUwrY0d0V2ho?=
 =?utf-8?B?QytwNktXSlo3TzkzaE8yNkpvQ2JkNXhqdDdwQ0pZT3NOVlpGMjlHOUM5WnJF?=
 =?utf-8?B?S2pYd0E4TnBGNEU0REhvbUxLQlFOVW5sS3UyWUZOSHY2N1grVUJwd2N3NjU0?=
 =?utf-8?B?VkN5V1dXRjlTMmhtRXhYTlhFOVJiR3ZoRExncjh6YXJwUWxHYW10NGNTSXdE?=
 =?utf-8?B?b0lpYzlISlFzWUJzZmpMUUplbEJyMVk0Mzd6UHVuR0dnaWQrZkRScVJMbEJh?=
 =?utf-8?B?YkpnU2ZHS1dmYUg4S05HQVZkTENrMWhJUE1jcUx0Wk84TTllODNYNTJUWnVX?=
 =?utf-8?B?bTNhSkI5K3lNWEhaTEY0QlNkVFRQMlRHSnJQUnlMcGR2b25KVEdkemVWRlNp?=
 =?utf-8?B?eWk3VTJ0QXoycXJ0OEllbWF3NURKcFN2SXF2VmZVVGtYbFNmOFFoL2djaUhE?=
 =?utf-8?B?Qk5sby9lZjY2T0ZmVVYwd2xESFA3ZnlSYXRhUkVlYXNoM2ZXa3l3YzhXYmJR?=
 =?utf-8?B?UEI4Y25aZGUxMWxBeXoyRlQra1gzV09wdEw4VDRaNzQ1T1FacXRVWDY3Sk8x?=
 =?utf-8?B?RFAzSzZHOXErU25BMXBhQklDdGE0UjU2ZjFveWJUbzlaWGJaUHpUaVlmZW5x?=
 =?utf-8?B?VzdOZTg3UTVmU2F6T3NnT1ArU2hXdEphZzZyQVYzQndRd0RVbEdsa3JLMlB3?=
 =?utf-8?B?T1BVQktDaktlY2hhaFVPMi81RUZMdjFKWDhmd1pNMnIzd3VteFRpaG41cmN4?=
 =?utf-8?B?WHRqVmwyYTB1dFAwRzFPd3NuZTBvbm9DeG5VN3RKSFhOREVoUjBNQzFZSG5O?=
 =?utf-8?B?VHd0bVBZZUR5NDMwd3crNGdLeDlFZFBsN1hnd0lOMnVoVU9pbko3TnJIVUsv?=
 =?utf-8?B?SHdNb1lIbHFxdGVWU3hyZnN0QnpCZEVST2dGYTRnKzNjUStxNmxuTERPOHIv?=
 =?utf-8?B?YTkxWUFIcFgxZkJLeEdvOG1JWFMrQkFIRElVRzZjQVlMVUFjU3dZYXJ2b2VD?=
 =?utf-8?B?dDZVOWgzTkZGNlJKNDhnOUNZK1B5SUE3ZjVCWkJENVMwamIyTFpEZnl3L1Fx?=
 =?utf-8?B?YTdPc0dVL1BnNGdLVENCamNkV3Y0NnI1RkJUMjZmbzZNOEQ0clh5STQvUGh0?=
 =?utf-8?B?blFHaCtjYjJma2EwVldFT3ZOZ0tnTW1QeUtnNFZpTnpuY3NEa0x2VVZLb3Fp?=
 =?utf-8?B?VWNzMU5aUjhIVWJLMmprUDFQMmVqS0FCakhmUElKY2lmeVRuN3BsQzIrY0ln?=
 =?utf-8?B?WTJsdElhK1JKQ2VFYnVadnJ0eHN0M1NNVVFNVGJWNGhPTEVXTlN2Y1pXdWsw?=
 =?utf-8?B?dTc0aWVYa25FUGtxVytEb0ZQOHdZcHJwUjk3WUR2RThPRzZFM2tGRnk4eHVw?=
 =?utf-8?B?K3ZxbmNxWVZ4cWNLVjlGajhxaUV6Qy9mY3MrVlgyRnN0UERGU3FWTmN4NVlC?=
 =?utf-8?B?REM5UlM0WWxaTTNXTisxcGtWYkNBV3NRay9QdVg4SFVaUUtSaDFMTExuUUUy?=
 =?utf-8?B?amx4ME9lYVM2amtFdjh0SnRtb0hlS01yUG15WVY4ZmM4Y2JTak9tQndPUFkr?=
 =?utf-8?B?bHJQanJiWlM3cWFTVVFKT29hNDVlT3N2aExoQlFDa2hEdWpSNDVjdElML253?=
 =?utf-8?B?QmRmVUlwajU5K2pVVm5aY1llTWxCMmZQVG8xQ1NtZVo0cldlTnBsd0ZkNDR4?=
 =?utf-8?B?T0FGd0ZwQmZROHQ3RW53UUV1VFlON0l3eC9TSnhvRVBORkdtdjk4aXJvMnZR?=
 =?utf-8?B?SEl3SHh4YjdqSUVjTG9raExRK3BpOUVsMUlJN2JTMmRGWVZtVS9FelQzUm1x?=
 =?utf-8?B?cG5rbW8xY1R1cWNSZFQwVzRHdWMwYnpXRFdGaEdCNVhQSFJ4UEJmdVBpTGht?=
 =?utf-8?B?K0xFU3RnKzJsM1VjTytqckpDZFZzZHgzSk93M0xTcW00bmtHbTlnd0hpc2k2?=
 =?utf-8?B?RkFXbzlkNksrWmpjTWhNN3grODZScDZIeEt6V2RZekVUZHcwdGVvTHN4WjdW?=
 =?utf-8?B?azJkYU5CVmFnVWVaaXpHN0lQZ2xYTXhJdERQV3l5Mmo4R0RIMlhQb2ZRb2tS?=
 =?utf-8?B?cUNUTm5nM1o2WDBieG05aE1kSm9uWUhjZUcxbHB6RnBkQkt5d3dsdkorQjZD?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA7B68BB21BA21429A5F46321C5FB71F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HzBEyoY7uy6RMeinYGGCVtKpcloIoxpUnuftN7dc5rX0aFDouEaT5+Buy8bWe7JrcKyG5tYYHcuo6x4EuOUBQrYPHQw0IxEbiVAOV+sFglIYehRMHqT53pC3bLFNNJqx2nv/XenjZbVKrmER1ezQ4276xzugISMTCBAaoV/jeiPlVvj5ScFKBYOeH7XbB9eKhi5OlVWfyznSUL+ckTQeHVMFQCT9IIeZFw1ml+ooPh0P/9IRwSV5bt1eWflcVf+3TK1GlVpuztPp1ntB7lIwDv1wz/Gz8w0aqT9zSmBDphVJeDVvf4lImjRWJqsmCbQ8S/+YdRhqC+PzHK1LI8COVZqZxWT0jgkthzl+saVFK/cd0THzUW+zzs+u4ORO0+3S7DddDcqlQ1EKuXNJMSFh7g92c69fYFuoCIXsdwq3pC58JKlD5vER1OOgQ7TacKbI/t29LX5eEJ4RPiN1tbim/fltnN9asqm309402k3ZlhQfo6GH1xwCFxs+TtBjOB7rzNHIw2Z+aVVByaTHtXrbhzBO1ymn6Nm6M1+SJEkirZoVBkclwKYdkSvPTZDfhKR94LC+pGtU7B9qkluUwOKswPM+RwUHjcfGwJwzMmEPV8D9hnt5UVOQdH/kTBEPHGrEPVmMVO+ekoztWNBheQ708lISwRwQxn2jtXABEO9zBEWANRtQBTeBsDHVIXJ+FUe6wCy8AjNsdfLHo18MVF3+TEfrXuQxdnFArhrdjn3qHDXc1VAWxN9hxVBqFKUerxPnSGyVgtR3/0cH3uVA9V+jpBH0QkmJX+CjLIKSaxOtB0FTihDSl0YQU4hxcPD5cUGC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7c907f-a5b1-4eb4-c61c-08db6682010a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:34:35.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0/pg1IG+aMx1T3BiW/X/OvAk7WIzLikySB1tMFXNEuEG9aTIKHNBdv1S/rVTgUZWa8i+SoVeJwlip8OFCOWxXpgTnxmQsf7woKUdg1Yijw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8598
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

V2l0aCBGaWxpcGUncyBjb21tZW50cyBpbmNvcnBvcmF0ZWQ6DQoNClJldmlld2VkLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K
