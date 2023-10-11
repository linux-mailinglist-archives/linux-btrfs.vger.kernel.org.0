Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427DD7C4BB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbjJKH1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjJKH1X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 03:27:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D21C6;
        Wed, 11 Oct 2023 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697009242; x=1728545242;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TlbbUDT8qvjpGoAa5eXHzKcorW2G7eoQwXdh8j0Fsuc=;
  b=hjaoMcQ4/2gnQYjHfzk1pAubjqAw2HtnV7ZyDVMrBPlEGM18nrWIXZRV
   5Ma9tHBC1PH/n695ltuwfWff17uC7aVnsKC14elYCMFjC8IYOIEkaVGPi
   kx1NipfLtE1r380RJyllL6K8vmcd798xoF6VD6CV4A6SmtSVL63DJ/A5l
   RiLRaMqZ29FJdX0Lc9LCjpAwKP8HFP6y4PP7TWmiR1dVlS/4aJ/79igRF
   BjFOUHtF/r2UfCowpCtSzKTOgL/+76WEELcgo0PJ2GeAgZ59s7jy13iWy
   lMb6Z8gOwOqKnaSru2U3yCQmV1KSaBvB6N4x8/VjD/9OQ0fZ/r/FSCyBc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383461880"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="383461880"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="783157193"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="783157193"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 00:27:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 00:27:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 00:27:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 00:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPHCA8q0yAUVE4jFte2yCCsPzxP7rResqNQ4k+7GCg6lAR2DRL9Z33X8tDNwG6avg+Cb2imFR1ReHf6ns5snP5C6PVAN3HgOIe5nS0VTgKEPwhgZcVSMW9yVYj0XNC3mscKQEtowjnBnq4zrn4XfXox34AnuiGIcvf+o5Ny1fSn8ANmGIOrRjcQ6uyIEmZNZMpEwL6lCIP29g/9vlPKaFDXOkFx15zwb9k1d79GUG17W/NqGn5spJOKNVdVs/2gxRUqhGxLH+etR69MMMV4DtN+1PmRM02zSMhQIE4q9HK8odc47NiXaYUbr2BDU8Lo3P93gmqDBzzKFXYc50nrkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LZFNykvZGAD9jx0CNP+spbQIL+ivZj+YhKO6XKDAPs=;
 b=OTTdOUd1sMjho0rACVDyoKnot6TrBtGtyn1nhqFnxc1rBu0glT9dGQftHlEsf0354bcYmI2htsWrjSHU3j9BD7fK7+Y4q/wMZGPXOqpmZW5yt8s0jFeo1HeBjcfBlI2T5gYQw3n4xuXgyHtefqwqUzEuY7bTGDl3J4sDzdhF3D4xLnx4hS5/X0h0hHufMo99mJEEo71ZcYpG3mia8ERlFSK/DgcvG5cmFwfxdTELZYIkIbdKxOmXnN0K7Cb06s3xRX+UQhjCYHE8OzvXTTiIS2H28UcP5yGrAloFlHwtt8ijeVudXDishzVh3tNknWToZwSrF/W9tfJWYL1Hj3HwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 07:27:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:27:05 +0000
Message-ID: <2924b09c-bf19-4de2-aae4-55752dab24a6@intel.com>
Date:   Wed, 11 Oct 2023 09:25:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] bitops: let the compiler optimize __assign_bit()
To:     Yury Norov <yury.norov@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "Simon Horman" <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <dm-devel@redhat.com>, <ntfs3@lists.linux.dev>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-4-aleksander.lobakin@intel.com>
 <ZSQn4Mppz9aJgFib@yury-ThinkPad>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZSQn4Mppz9aJgFib@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5167bc-1fa1-45be-b3b3-08dbca2b7813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6xHHUCUkeW/YM4py9cbJBsk1lqSzZufftsUjAtPzQGEvZ540+xWvuyfsqxs26ms4bTS7XOFco6q7oXOZzuuUDtgO9J0ZHu3l/FMZcUHtoPx3BNGyxzQZCf6086AvP/fR6u9y2IcfK/fOYN97Xv+Cif4i2VEz6nxh1C546dea7zQPsOgqpWtJdeaNNDEqMOpLhquo0AZahrx/I9ghWCgOKFeN3cm83TvxBDcnGnB9CraX51+TGEG52X8tYKoFWFm8nt8WZJaaKBMG6NQRNSojH1evGfEm2oYVtL7GiNr+XBylOwhcvOogGhMgie6bt3IXoyajtFU9Pvx9wDedigGms5ygbPnMrrSo/ql/fDpc5mpXviZa4O6jW/G9ncyjOd7+xynbuhJFyaXD1bCqE9HKCxzD2OE4XaaDasIeQBe8pDF8yAS2jUXAh9MJIe/SQodkZP08ra06Ghvj+YL0wQLIyb33Sk+1xOYmlFE7Lwzwc4Pvb1Svy2GIAV+jfXhToqQIoZ+OOkzDy0ibTbzChqgS9e8oEcp75VTY+yFq13vuEtrkh1eJWHbhBm0G3eZ3Qsitda8WKE3SZUIK6wYLEPW2Nd53g/64orBzJNvFL7cdf5OpyUX19LPgyA7cP3L36UZWUhk0CCPq85nSeCKexPajA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(2616005)(26005)(66476007)(7416002)(316002)(54906003)(66946007)(6916009)(4744005)(41300700001)(66556008)(38100700002)(8936002)(8676002)(4326008)(82960400001)(5660300002)(2906002)(6666004)(86362001)(31696002)(6512007)(6506007)(36756003)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpiRmtqUkt3MXpHMEtrM2kyZktHclRzVFRLNHdtME5Jbk1vNkhhbEFrcTIz?=
 =?utf-8?B?amNnRmNIYXRtcHVmM1VxaGJDeTZOWW1lcXk0MWdFZmpYc3NEVkVpaThXd0tN?=
 =?utf-8?B?cHQ0Q2VaaXNYWGx0d3k1M1ZYWk90TmFjMmdTMXpneHByRW1LQk5YUTZBbjBE?=
 =?utf-8?B?UUxLK1R1UTYxSlVpRGlzUDgyZUhkVGplai95cmxtZmpPQnRqdjM3TGkrNnpH?=
 =?utf-8?B?VEhxUnNlSS92VUNPM3c0ZzNWTGhFa0EzQlNhcVJBQUE4cU1rWWRpZzliT2d1?=
 =?utf-8?B?ZkZJdFptOGEwYkR6cWxOVy9LYWNDZno5WnpuMEJJUjhEbmpjYVR1N3J4ZTBX?=
 =?utf-8?B?citWSjFNbUdmZ3FFak43UG1tcHlzWkZHanU1azNmOXJiZ1NubWV2YzB1RGZa?=
 =?utf-8?B?L2JqclFTdU9EYnNVckkyTUp4WERSZlQwODUzSGY4ZFpCZXFlVDlvM2RhWGIz?=
 =?utf-8?B?ZTFsU0ZhNkFualRRbVlmbm1Tdkp5OEhQOHFkTmpOUU5PVXVwVEVPNmRaQ0g1?=
 =?utf-8?B?bnh4QkY3alpWa2l3amZWV1dHREl3MnVpOGd6OVNjaVdOZjU0emYzMU9Sdzgz?=
 =?utf-8?B?U2FQcDlUVnFFdkt5MVdTT2d2eTltNWJHZ3JFQzFMMHBzamFoU1Fpb2hIS2dm?=
 =?utf-8?B?K1pyT0hMUGcyOFB3Y2ZJRVlGWWdzRjV6amdiSDVTYnQ2VXRFUjByYStTaEwz?=
 =?utf-8?B?a3ozOGxZcjNMcnZnMmtlKzhkRVdCRHppKzNRWWFFSXVTaHMydXFwQjM1SS8w?=
 =?utf-8?B?SjdOaUJJWUYwYTlNS3F3Z1F6K3pzakd2aXVBMW43V1VWb0dMZnFqVFNpdXY5?=
 =?utf-8?B?ckU4bEk0ZURyWDhDK1JkSWxBN3gyUEFxVVNhY0diZ0Vob1ZqdGRGRmpiZWZE?=
 =?utf-8?B?clBpZkozcTZHalk0cVpSV09WWWtGVDNMbmxoU3M5OVQrRW5oVXY2ZTQrUmJm?=
 =?utf-8?B?WnVuY2dQRTNvM2ZXSlJRV0VWS3dkblMyL2VOYzdmQjVqSHFjK3EwRWU3OFBx?=
 =?utf-8?B?bXdvRS9Qc0dXZzZYZGFyUnJZU0VwaUEvVmh6MmF3aFU2cCtDUUpkK0Uzemx0?=
 =?utf-8?B?TW55K2dqbVZiNHJmRElZRmJjRHpDK3VFSW1DSVpVZkZOdmc5Z3A1TThCanFq?=
 =?utf-8?B?YnlQS3c0S2pNWWpFekZCMXhvd2NNWEJJY3ZJZnVYOWRUU1BlcW9taFpMdS9G?=
 =?utf-8?B?bEZOSjVzblpXL0hzUHYxenI5cVhKL1ROckR0WGVyeWVzNkljUkYvQTgzcWdW?=
 =?utf-8?B?UVBEUlIwOVIwOE5SblFWOTRxMVhTOWNRWmVpTXRZUWdoREJvamI4TVVlTEtw?=
 =?utf-8?B?Zkt6amEzMTZZVTVVYTZBZWUrWFh1RVdnQUs0K2lpVmF5WnYxK2tYR1ZYcFRJ?=
 =?utf-8?B?ai9yaHlIcUlndW5yT0xORlUyZ3p3QkhpY3FHL2h4ajc0OWQ5ejRGZk5MODhF?=
 =?utf-8?B?RE16Z3cvaWUxUmVUN3ZTM0YzQ21iT2NBUzhaVVBjbFNGbkczVjk4QjVaRVpW?=
 =?utf-8?B?VDduZXZrVEZqWXR5c3lqNWg1VWR4MGdOS0pUZ3FXS0ZlN0ZEdGVOR2dPTVM0?=
 =?utf-8?B?TXp5NzJaczJEbFRnSzJhZE5VUFhFV3hZcHdUSWIyMkZSM1hEMWZDZkZwZi9h?=
 =?utf-8?B?eGtleDVqdW5OL1dmWnpEV3k4bFN3SzRjSWovNjUvb21NVEtLRURiQXQxdGg3?=
 =?utf-8?B?SnhGL1lRc2QrSGc0VEhITUt4dlNoR3JpOGJUUXR4bXJuaXBGUXBTWFMzNStH?=
 =?utf-8?B?TlMrRUUwWWo3RHBXUUM0QkE2bE54QTNCekNURkQwWUJpODhCTFZiM1AvY1py?=
 =?utf-8?B?NnBJRFVwWmJxeW5KMzFTcUpmUmNVMlRXdUZGMWtZRy9NVHNCOXg0cVJJSFA5?=
 =?utf-8?B?VENDeEpqNmljT0p4dkE2a0NPSVJPd3pSSEorLzQwS1BGZk5KeWtxSXNFSWtW?=
 =?utf-8?B?QjljeVByZGlsYVFydkQ1YzlpTXcxUVFwcDlXZUhpeC9LaUdzckZjNGZCSDEz?=
 =?utf-8?B?L0U0Skg4ZEVJZktxeG1rNmRERGJVRzM5Zjk2dDJMdFF4WXZnNEFPU0pQOTB3?=
 =?utf-8?B?MW0xTDJnUXB3b1JxbW5iM3ZYNUY5ZTB5NnlGUHZ2dTJ5bGdnait6aW81akFH?=
 =?utf-8?B?UlhmdFZnM3JPSHNMZUZDSDhhcHliMlA0Mkd5UjRnSG1oRmIyU09ON1BVZXhH?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5167bc-1fa1-45be-b3b3-08dbca2b7813
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:27:05.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct/F3ureqZIh0WVYcXzq8ApUio2uiZv2O1II2eCbO+TureHBkoH6quA3lCI9MV7kH80p0dFV78ZgBk9pRfelhiMtAZd1MxukpiiG5Tknehk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Mon, 9 Oct 2023 09:18:40 -0700

> On Mon, Oct 09, 2023 at 05:10:15PM +0200, Alexander Lobakin wrote:

[...]

>> -static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>> -					 bool value)
>> -{
>> -	if (value)
>> -		__set_bit(nr, addr);
>> -	else
>> -		__clear_bit(nr, addr);
>> -}
>> +#define __assign_bit(nr, addr, value)				\
>> +	((value) ? __set_bit(nr, addr) : __clear_bit(nr, addr))
> 
> Can you protect nr and addr with braces just as well?
> Can you convert the atomic version too, to keep them synchronized ?

+ for both. I didn't convert assign_bit() as I thought it wouldn't give
any optimization improvements, but yeah, let the compiler decide.

> 
>>  
>>  /**
>>   * __ptr_set_bit - Set bit in a pointer's value
>> -- 
>> 2.41.0

Thanks,
Olek
