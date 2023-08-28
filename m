Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBB78AE58
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjH1LBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjH1LAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 07:00:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26439E1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220435; x=1724756435;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
  b=mX2QHOw0/psPnP9nFhQSauQHX6MelLp5sX8fnM1l17gKAag1q0m5sR7A
   PppbfVj8XozFHQnCZ+jPg+OraMXzmmI5Xh0DAESWjPWqVUBQwcTzz2SJA
   vTptxygVr1mRiT5SKhIJ/Gegms4pVLVYg38Wf/QUrytu56nWAy6hkd1nI
   nvSzAMh7AESNa1BMGRNVB75NufY+wLBKI6GTq7Vx/U+56YTnQCmuwnmAp
   k0f8vewe1EqSOsvr2jDS59E3RfMTUhghDx4GEqft0Xes2ZHBTMNzXiP2X
   LRELsBuJxFNDR5wW7gvmR+KtcoXs/6T7PKwk59xPaCjSxxo7URXs78Z0X
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="347561557"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 19:00:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd40jcLoNMDSvGKaSv+1oaF/rgVf7Y8c9ZQl9I+Bl1U+PHHieutcsip85HJ9Qd5MF3krg3HFYMe72Yyq98V0qPQpKNIc2QCkXUUrBt3+pnvkhoRlxsy3vx644RYNQXCUPlFcQMJA5L6m6uQxdMc5tfS3cKojAil5qfnIdPqtWAuWHc19GvFthSJtnAVravMj6mYXQ8B3v54m3rko3ZpIpgrE1VhT9h8KjXnBRvPOh43NR1rFfZ8axxPDe5BAfmIbC+rqqoSgKLxW6kktyBMGMmwynHq0whz+XJm42ESFnpy00ZFYezBPKdFZnPb2JprPTzgHvGdkdcilaWr3pT30FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=UxGGVDw2a1/xxjKvM+/ZrrQqHaGlLm9BGjdPZSv2fqwWPMDY3Wx4sphq9mRocxWF5by06Y87BPsZ8bUltB4XVqM9VBjamFw2tPi+aGoF4kahxE88qZfmgb/R4QvmkDgqnD2T4wWhUMqU8iPv6m1/jVvxY5qyOnvPRX4iCTBbuDZ4IjbFGkZqNdvgQzITpl7dKsyI+GHfsYaVu9DDR+mTlFDadUzUQlCrZ4IRXjEFluBd3uTfAnUIEeNKP/o0eq/xI+SHgznI4nDQPwxroWjZLwDEo49zpyP0vdewOoYSrKHemmvY6uzp3aBOVD8Kj5wTMRkWfHO6T3H6TBrEt2Qjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b6lswKJDTqczH6TL1ZVeKmjwp1dYJ9qM1C097ndCHs=;
 b=carMk31LiYJdgrZd4CxXW+6ow4yf6YgFpNCoBlhPbSLhgIEtc/f7NPIhtcQh0QqWzcBchRU2KdBZ63lfunHgeZvIkRSqTh/8ctxxEQbfiRiFAmeI/Rn3zQrV3kvxAoiFoz3+Xi+o4rh/ejvkmpVWLub1zCZYIA3aDYoNJvoYkPc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6649.namprd04.prod.outlook.com (2603:10b6:5:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Mon, 28 Aug
 2023 11:00:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 11:00:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 04/11] btrfs: move btrfs_name_hash to dir-item.h
Thread-Topic: [PATCH 04/11] btrfs: move btrfs_name_hash to dir-item.h
Thread-Index: AQHZ1cj/LhJk3TJqS0mmI7lCjfDZ2q//kimA
Date:   Mon, 28 Aug 2023 11:00:33 +0000
Message-ID: <62085982-9c07-42bb-bdf0-a400733821ff@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <0739f7926fe01f0861a0f69da55f080fd7f464e4.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6649:EE_
x-ms-office365-filtering-correlation-id: 70a89849-21f9-414d-275a-08dba7b60070
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8csJgKfwuA2kFvsfARxPtOmr1x8zFbcPWBTJC8oCkNV9TRETlUJZAcdZFcvJGNgZIXcxbnEyImDgR5lF5ZZxkMzjWssIXrnTO5JpS9Pf8EqkrB6Nx/1gxqor1spf3PoG69LB3y/Cy+wY9V2xkHx25wj7pAgdrt3K1TZ8CzeZ0MsevgdPL8Oqk5XT1skgnSTg/NrWsRnW2JeyUmnuAyZviSwu0zHQ+W3Js2vqlVga2zUzdVnkC0vkW4HGJ86ev09vNuWpuYe5mSrqykJ9tFm0Rj8GLKgNlKLz2Qnp7uHFdh7ZX0V+b44YvUpCKI9HiaqU6/XYJlFHtT4YK5WVmT6hoaqShwB5Ah6p7gekqRC8nFXVCXIdrmtcL62bj9HryAD7ggMY0OS+bFyA73uxg9KH8mekBF38WRS1ECGfq8MREm0KkZqiT+HMds77gjxl1u7CnAEVrJ2QtRyF2t8989C7cV21KRHiVMygEIziBEf8kNFk2wB+qpxEpY9hlmTC4rcN/NYNkn/H++La/0hc8uH7O6zE+F1Gt3MOVBnNXHCMwjjvIP9/bexBqT0EBBRcSsE1QaVzQP7JyIuc/+qf8d5t3yGpBTKpJ4MFPd8ENyJZSdB+6qYMdomn28FZZV3mC4vUAABrDXlueqNNe/ZxtEAKtMQiIl+FNwLJxG0qqMKLNhQmT9CQVu3umDoIqxUwnHzZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(6486002)(86362001)(19618925003)(31696002)(26005)(36756003)(2616005)(4270600006)(6512007)(558084003)(38070700005)(316002)(5660300002)(110136005)(76116006)(91956017)(66946007)(66556008)(38100700002)(64756008)(66446008)(66476007)(41300700001)(31686004)(2906002)(122000001)(82960400001)(478600001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q01NQURlQkpMRU9HbXAyQ1lxSks0WVVTMlJXWThBZ0s5NVpMd0Z0ZDdjb2Jw?=
 =?utf-8?B?a1NBS3c2Mm9iZThGSEZ1d3BiNll2SjRXbGl3Qno3cWE2L2Nra3oray91clFy?=
 =?utf-8?B?cmNQcmFySHlMam5IcXpiNXYxTExoRnlSM0YxNjUxZjNxNkNXcnhCT0FDUEhy?=
 =?utf-8?B?S0VKaTF4Y0xCOWtQYXBuYVBnTW1QSFJva1AyRi9adnFqWlRoWG5WMHRSTzQw?=
 =?utf-8?B?aUJQQ1prNTVWY2NSSUFRd2NlVUU2SVZJWndHZHo0QVVDOEtIa2FMeWIzUDJF?=
 =?utf-8?B?cExjUEpPbEJEQXByWWg5UXB2TkxKK0xrNG9hd2ROZ3VDa0RMTWxDWXVtVlJP?=
 =?utf-8?B?Y201d1ZCZWNVeWsxU1U1L2pXcTk1UksvY1dMSTNDR2o5cS9NcnhIMGdUVllO?=
 =?utf-8?B?Y1VTVzQrb20xdmU4b21jYnFUZ3VKRzNOTHYwMnFDeFBzcEw2K3NmdlpnWVBz?=
 =?utf-8?B?azVyTjFwU3FzbzY5K21pSUQ2Uy9iUVZZdmhLNGZ1VWowMDFyMEhaSE5QMHNy?=
 =?utf-8?B?b1BvY2diOER0aVN6dTRsZFE0Qm9rTUIrWVNoRHV2YWtRTlFRRXZ3ZjEzMFFV?=
 =?utf-8?B?dWpJUjAwZ3NrcDRCZVVkM3BwSW04VEhLUCtYS28wU2VOUU5rTTYrUlVOMkY2?=
 =?utf-8?B?dkVRNWpVWTRQUWg2U1JwVzVjcHJDdnRBR1lFWWdlc3JqVGNjajEyMGJLNVM0?=
 =?utf-8?B?Vk1NV2x4UVBETVBqT1dYQW93VlJRSnN4a0thb3VUcklEQUFEakpjdDc4aEVj?=
 =?utf-8?B?dUlmaSs0U3hYRGN6cFJaOGhFVGExbnFOR2ZHemZlMlNJdDNTS2p5b0FRNDI2?=
 =?utf-8?B?Z2pBOHZ2SkNwcGtZTCs2SXBWNVNCdzlxT1BvMkFPWE00Nk9aRmx4dDZ3VFMy?=
 =?utf-8?B?eTVXS3BpSkNJWGZ0eFNOSDVoWkpENGtIL0k4cHNlV2tPT1Vhb2Z2QU54NWxu?=
 =?utf-8?B?cHMrNkx2MlhJUWE0ZnJpQzZoM3FJQXY4T0d0eCtheWIrYWdVTDRrTHpNMWgx?=
 =?utf-8?B?VXNiR3FXUnlZSGVabW80RDBSdmQwM1BXNFJDem9vcGNoQVJ0L2xEUkIvNkVn?=
 =?utf-8?B?QUwwVjBrT0N2eHk0UFdpcUg2WFVDMTdIMlNWQW0yVUFGQ3lseTNJM3RYN3Ey?=
 =?utf-8?B?Zk1CenNvbWV3TkhzUHVwRGlSL1F2eFNOQitRL0RsQ3JwMm9NRG9NQlc0em5S?=
 =?utf-8?B?RVZqbGxmVEJBbzd5NktNaTRqaWxWTnlUSkRCdERody8xVWpoYkZDYUpXMDV0?=
 =?utf-8?B?VHdrMXVMQ1hOejM0SXJwdVRHVmZaRGVTbVM1QWdvZXNsU0RrMTlxZjYxTmtw?=
 =?utf-8?B?R2trc2FxOTB6YlU5SGtOVW5OMlJRdHgrdjhnV2tTc1JLQ1VLdzlzcTFwN2Vt?=
 =?utf-8?B?eFhScVhxdXBlNzI3SlFJUlJxak5FaHlYc2ovRFE1RXROLytlbWF6WnlMQUNx?=
 =?utf-8?B?UU9sQm1TTm9qeDdEMnJHb0NDNWpTT3l0VXhjcVF3UVl6blR2cFNqNC96WlVW?=
 =?utf-8?B?cExGK1ZRTkkwRS9Vd2ZsSDJFMnlJL01kbzRsVEp1elNqT2dsN0xUaDJuS1ZU?=
 =?utf-8?B?eEhkUCtYTGFnYU9TZmE5MjZpTEVsOEtGQUlOVjYzZ01aTWRqZHdCWWZxcUxi?=
 =?utf-8?B?ZlNtNTYxQWJHZk9NS0c3ZFhtWmZSalVFS3FxT0ZjUUxDWlVVRjVHK2ZWZm9O?=
 =?utf-8?B?NS9TTHJnTDlXdnlzREVTMFBhbzBGMzFPYzVaUTR4djNqRVloVGhDRE1ZNHpz?=
 =?utf-8?B?WU9MbW90N0JiSkQwbzczbG1zOFg4ZTZyS2dVSlhpTG1KYnlkZXdCWEpqbnJG?=
 =?utf-8?B?cDNBL3VQbE82elliWGZBQmx5MUZWS3NyUm5vSFpFYlQ1OVhxcmV2ZUdVU2d1?=
 =?utf-8?B?QVdKQi9CeTFSN3k2eG1CTHNINGpDQmRuUEJ3bDRvSWpsTkxIeEdSakpXZ21B?=
 =?utf-8?B?cFEzazcvZTExcllIc3duc05nSFcrRGFMTWUwZFAvczBMVUFQODZCcGJqT04x?=
 =?utf-8?B?WFhZQXNHZ3NyMVFwZDQ1R3ZvRlhadGs4MUFGb0VsOGU2M3h2SnU4bUNmQXdY?=
 =?utf-8?B?TkdhbVl5eG5FZU8zT2lhM0xQaDdIY1I4MHlGckhMczdVc3crRUhGcFBNRG5Y?=
 =?utf-8?B?cmNuYTZmc1hxQnhyZnRUWXBWMXROSVZ3R1kvQk1uQXpKNjNlaThINmsvVi85?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <663C05B6C264B24A962C193D824BD16B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9fI3BqU5b7di7rBY3c2LTf1Pd174jD45G7UTs5lmxY0CJLcHCp5rM6aUjhYDzgwwaAwal4DDAkT0cET3uQDwFlkd7JJrxVDVcMd06yphjomtmNSFEh0waK3xHXioh8MukGmthxExgOCpjxl/v4+RGVCcTbIe2MUCYJBUdomAciRx7q+2Eo2STO9g/AOnZPs3I6kXg7J40J+QcShYf2CAYSBmOKMSuo5khGZ3g0k56ZsZ9YPRUn0R4rLoremKK8TNGye8b2FPZ6tLZu5iFyLZJz0mnQ+27IvP7H2CRVE8AMI83oaVnZi2Z+2xcsvezcA/jX8fDXnGi/bu+nm1UBeSKMak+GttkRuwkx0Yae+3Q1OoBFDVtQ/1yvdxv3FhgqfmbaHLRZERfnecux4J8FWUQuOzPW3QqcxjYtJt97qTLnwz7jIBtzwthY2TOr3EprtyIWi2RqmSvy/ZyprHjahAnO4ynTEXADrYmaYSEz8wcCPhUORgvYibdH9emz56hpGVJh8Z3blNuQJkmJmqqEAKf511uLS369SLbn2AqHlo0Zf6BcpW4nKKrwsOeHTySR4Fz5csfy1pzn+FjOk7D1nNJHkA/qRdHZCh96jc05OMdMtERk6PUgrbMfhWuS3k8jlEiHaMQzSOXGqH/KzuO/cBbSbzw4wKJprl7IoojX8GPtY1Aawlnxvh+kPvSzSe2Cz7I9jtJPUpfKRWvp7oidU++elBmb/YNTRyAcokxqPFAY7fBSt8YFyX3UDHV3S1SzR/0ylIwH7SRDQczrCzMK395Se3v8I22nGnu1UY9CA1hngqg0I5CPAHeaco1dCfBKRSta2htCqW21fUuny3jHKl/g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a89849-21f9-414d-275a-08dba7b60070
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 11:00:33.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/ZxQnw1LhmM0sDDt0oiFZAZGRCYH1OJ2MqaJ+IXn82yVZALeB9vIgOu/pDWARpa6KBRcvRMr8ixM105HggCYhslfJ1cu0NCpT3Nb7NxB/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6649
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0KDQo=
