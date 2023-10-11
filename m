Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE87C4C16
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJKHi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbjJKHiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 03:38:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF310B;
        Wed, 11 Oct 2023 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697009892; x=1728545892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g879PykK8gRQ1Jxr2PSRIi/UaXvu2LsG9L8zGkQmEpw=;
  b=RR8EZ7tcG7+BAa++gKPGjKubgMSbtsJnqradzlDEQJlrzHfxrU9MOhH2
   0VGjPVQr220tkHzKLX0eD5JqG4XYClxRYnnbClruv8ZZL10KkpyqKDdQw
   xpX7Q8fQjmhMMaBdMSBu9tbsdU48QZD3KxckNdlWUAQeWhOaBDnxFoYBU
   TqjNxv6ur6ze6irwXXke8btZYKAflDTaDbnoPT6TUCC1K4WJlXmMEww1+
   ncDf7YpEi6ysW6Fw54EzJoeI72+4JfNe9lZ0DYaHUkt5V7ApsB4Ko6UEU
   7nBHJkkHaRCFEbUpoAPjPR+nWCIvQ5OpkEIgvdEifnMjW4Sd+u+rfc8pp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383464176"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="383464176"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1085120842"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1085120842"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 00:37:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 00:37:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 00:37:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 00:37:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 00:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLFTcMylzE3BDCZZFxi6oNbXfVujZc+jTanjvBU/VnEsPGHScokJOvrusuj+jFiExK47K9e8nPlifUrKBbS33nq4x5cKDOECpuvOf0yopkwL1HkKrhcR7zzkQepdblrL6UdofUXxrLjhn6nGwGpNyYaF2kC879TGG27AUeS6ttWT+Jby2Y1NT/xx19aTc89Vn686iHQHUd8Nl0sDeqN2P/cjsdUnoA6bxtnCXYssN/1y97y+e2envoH237E/yO1jz6MStiYHuU6RUyNPfdMnKsIp6enKvU4FsJDFehZPw7PdL5760Q14R7lGdUMH0NEsbHXitgRCgw129Wlw5jasgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIYMB0SGu6t3Mrj6kF7Fs0Ia9Dayout3pVdIjItYsCU=;
 b=S8OEnnJxueLz483BPkaSV09PmJaB6dbCFO44jbdadAY0+KaA/4VC0xhkRDgq9TvL2EEkZTsDnLpxpCF8Ip7E16DjtmSApdUdDG4DBp10Yh/JunhIRGzB/tg6IMzT5i5yBqDMeqxx6DcSBrkYULqbj2YKDqLxZNxkv4fTpPy0aGMUjxr1I4wuXOzUDsVkyPMiRd1X0qWNGdH6nUiYUhNnOxV3TiaIkKmeNuKJpd7nHEMwqJQgxS5818VQ6FqQhaL306TIQicspzcxjY9KdW8k9NPRbG5XtulzTx7+NtL2A73CkDy3cmKcYo5HdMRCMPogF9lfXiXUH/sKAoJ3u+kITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 07:37:38 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 07:37:38 +0000
Message-ID: <9728a6f4-96be-4f8f-9806-17413e4ffb00@intel.com>
Date:   Wed, 11 Oct 2023 09:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] fs/ntfs3: rename bitmap_size() ->
 ntfs3_bitmap_size()
Content-Language: en-US
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
 <20231009151026.66145-7-aleksander.lobakin@intel.com>
 <ZSQvR+bQ8PS9/CEa@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZSQvR+bQ8PS9/CEa@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 1197541c-c34c-4d6e-57ad-08dbca2cf13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILgeusDb4qWfeK+kok+9i9t5JKJy2gO3ESsSSq59+EijnPUtVPbPIM5rKszhOau6m47YsPmCckbxSyy0gzPjuGQA5PY85RNSoxgkenFcrG+K8XJaJP/ZKZ0GeXhvH15S+FekyKjzciHV47bM5CENYtPFJfPB/uwPZMwhsAdFu+xhH5CXxJTPhVH3x+5eBg5DADMVD3AskQOWZeB1k/srv5rDmQpUbduqJFXdDPZLAKfXPtVgdmo4e1aDaFJeuT1Q4bX8Fu2yQO3dNdMr1n53y5W+uHnRbZ//FKw3kNXYWdzB+ua+6VxXczLDvyUI5XhVGWvgwVXHb9CcOjCIMiYtiwIiWv+bav///o+K703eWUuBIjAk8RHTs5M7UP+5AkZhR8JMcbST9s4m58xLEt3lMNU9OUqN2y/yPcSbS5gS+ewYEBhtMWwhaK84tz4NKJIswnJBPljF9r7A8NfF5VJBrpPnzKvvUTF1jnqXby/upHio2MeLcFYJUQ7hOOcUefw9oLv8vuwfdtYEuO7CXCpNIobvUJgBAutMILjreoZad1DgwzOgRuUXGSK7Ib3WdJjCp9tAfBrkqzhudObKib+/rtoKeTZZzF9f9gCmLd5hCGM+QofZm6c1e+/yGi3M8W3VpSTcF0qcwdcxc0x7LkeFog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(6506007)(2616005)(478600001)(41300700001)(316002)(6486002)(7416002)(2906002)(8676002)(66556008)(5660300002)(54906003)(4326008)(66946007)(6916009)(83380400001)(26005)(8936002)(31696002)(36756003)(82960400001)(66476007)(38100700002)(86362001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdvLzhiR0NEa1QvcktOcG82QzVwNWxtQ3NvZC9aRGtsVWNvdjlMcE5QRTJX?=
 =?utf-8?B?dWVGaFFRalI5dm9RMlJmSDhUQ2lMU3pYZ2YvS1lHYXVvWXBPQk1CU1lEcmNK?=
 =?utf-8?B?YTJFd09qd3Rza3pIN1JhVTFXenA4SW5QYlBCSkMyL3AxUUtxQ0RyL2dKa042?=
 =?utf-8?B?U3ZkNStFL01PTExFbmxMNEpmS2NWSWdEV0wvRHRqVXgrQ0xTOU1kUnN2TjZ1?=
 =?utf-8?B?eU5ibUdqWXVTZHNva1Z4QWxYSlBJSituUWNmanl2RHh1UFhaeHc1SmRQSHdH?=
 =?utf-8?B?Qmw0a3MxU084eEFuNTlXUTJzNjdSUkFQaXhZODE1cUNTYTVkMTdBL1hEaGNV?=
 =?utf-8?B?YXhWTDJvYXNkWmxsQkdYSktjL1g2OWF3MG4vZzJxTzNORU5TTmU5Y1cxRE9q?=
 =?utf-8?B?Q2xzTGQ4MFVmMTJlZHhzaVUxY0hjcU5CV1dCaW5PU2xtdkdmSWd3dEgra3dx?=
 =?utf-8?B?MkRCdjlBUlp0TFQ4Y3dUdHJmMlozQmxXZFRiMHIvSUZubXJOUnhLekR1eFVi?=
 =?utf-8?B?ZjJCVkptYmM3VldOK1ZWbXBHMWJ3dVZzdDR2aUE3V2RHdGZRb2FQQzJDajUz?=
 =?utf-8?B?Yk9zWUZEN1RGbU1QbWRqVU5jajVEUEVNN3JWVEpSdzhibmFUOGlJaUQvM0hZ?=
 =?utf-8?B?d3BhaDRCMno2bXd6OFJZNWJ6ZlpWQ202dUNubW1FQ0JKZGZyUTQ1S3RkU0ZY?=
 =?utf-8?B?dWorRmY4ZFJiSFZpa3diWmRycjhyZC8vcWRhbVVBazdwZitqWHEvVDkzRllv?=
 =?utf-8?B?ZWg4cGppdjlBeGgxazRHei9wM2VibzJ4a3JPUWw5b3NqY00zbWlkWGxiRDFr?=
 =?utf-8?B?dC9vUzFieHhwOExoTEVKY1JVVzVrTjB6ZFlCV3JqRjk1MUFRd3lJcG1UY3RJ?=
 =?utf-8?B?ZWpTeWJ1YjF4NnZkUU9TRTNEaWhacHpKOFIxcmpzaDhqSnhWRGZuYVNpTGE3?=
 =?utf-8?B?d1ZKbDV0eUQyM3k3SEFwY2ppekVDL1JucVl6SDB1TnBkWWdZVVk1WUJFeGdM?=
 =?utf-8?B?VklwL0ZabjdXUDRUbTZzd3BMVEJSM1IrS0FNTCs0VGg0SzBwSDBKODRrNXl3?=
 =?utf-8?B?MXRsUjdQQ2pDYmxlK2xmaXQwcXdpNHo1RE1IKzhsdzkyWmdGVk91d05oa0ZB?=
 =?utf-8?B?eGIxcXE3N0RRL2U4SmJveHRLUmI5QmZvZ3ZKUE5qTC9xaVhHZHNHTVU2WUhX?=
 =?utf-8?B?cC9wMFVCZkZKYUNNeEFEV2l1blRvMENiVjFWVExCTkFPSU9Sak8rZW5vTldX?=
 =?utf-8?B?L2NZd2hHcG9nakxSbEFmNGFYN3c0N2VjS1p5MkVCclFseU1WbUh4Yk9lNHow?=
 =?utf-8?B?UWRxZUFucUlWaktXY0dhWGlTa3Vtdk5DUFozaHJpQlNNcnUvcjJQb2g3K0hF?=
 =?utf-8?B?RmFCUG9TTVl0bTR1cTl6bmxjNThHMnpRN0J5QWkzbHpGRDliZTdwMndUZTlz?=
 =?utf-8?B?VUxxSlB4ZVBuMnpCcjVDRDNMdVIzSzJmMWxQU295Y09uaE5QS3hHQmU5c1p6?=
 =?utf-8?B?emRvSTFOYW0xc0VPUTVWNS91bHllV3A5WWxsSm5ibDMzRHJKc3BUamVRdThX?=
 =?utf-8?B?NnZBR1dLT1B1Q0xaMC90bkFNVDQ5bG43eDFQM2Y2cUZEc0U2OWpTRkZiL0tB?=
 =?utf-8?B?anBYU3lTdDN4aDVRc0VOclV1cnBTNmZtMkFnV0xuUWtlMVJobkE4akRyTkZn?=
 =?utf-8?B?cXhtTEs5bnR4TCtZTkxOMkFCSDM2blJ3dkNnSThqY0doVEROZDI3UGt1RW5T?=
 =?utf-8?B?UXFPL09ScXEyaG1WNHU4WjYwQ0oxblFPY1NvMmsrSDQ5YWk4d3JGbHJOaFFR?=
 =?utf-8?B?c1Vnb21wY3phbVdTa1RmZksyaXhrWXY4dGZweUwybHRZTVNoc0krL3FENHhL?=
 =?utf-8?B?bER0NzZYbkI2OEF2NWNHWldTYVZWMVNLNE9Xay9INUtORmZDaWRNRkF0WGNp?=
 =?utf-8?B?RWJmNVRnUjkvRWwxWmNwbFF2U2NaU0c5RUxQSzdGZnRLak8wb21Qb2wyMDNw?=
 =?utf-8?B?V0NoV1YrUGxrbnBySGlEOVdlQzdvanFMa0ZYd1pXMDA0RHNlQnUvWUJWRk9k?=
 =?utf-8?B?aHk0QUwzOFZIMHg1OThiOWsrRnJuT3U2cXFUaHQrZGtqOEV6Y3FGeloxZzFO?=
 =?utf-8?B?YXpCSUtUZFVnaGZ4QSsvZTd0VklVNk1aQ3gzOUN3djI0cTlZdU9oNCttL0F4?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1197541c-c34c-4d6e-57ad-08dbca2cf13e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:37:38.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpF8xBZ51zhDDkxCP7cqMS+azS39wza4eSmbLEpwQ6DLtDSmYbj6GUYJDTImW35k1zYGT3idPB1IYNXjcWiRdQq7BDOeSiO4hhviOvXTEOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
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
Date: Mon, 9 Oct 2023 09:50:15 -0700

> On Mon, Oct 09, 2023 at 05:10:18PM +0200, Alexander Lobakin wrote:
>> bitmap_size() is a pretty generic name and one may want to use it for

[...]

>> @@ -961,7 +961,7 @@ static inline bool run_is_empty(struct runs_tree *run)
>>  }
>>  
>>  /* NTFS uses quad aligned bitmaps. */
>> -static inline size_t bitmap_size(size_t bits)
>> +static inline size_t ntfs3_bitmap_size(size_t bits)
>>  {
>>  	return ALIGN((bits + 7) >> 3, 8);
>>  }
> 
> This looks like duplicating BITS_TO_U64(). If so, why not just switch
> to using the macro while you're here?

I thought that this

	return BITS_TO_U64(bits) * sizeof(u64);

would give worse optimization, but actually

add/remove: 0/0 grow/shrink: 0/6 up/down: 0/-32 (-32)

Nice, makes sense to do it.

> 
>> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
>> index cfec5e0c7f66..b1fb6efe7084 100644
>> --- a/fs/ntfs3/super.c
>> +++ b/fs/ntfs3/super.c
>> @@ -1285,7 +1285,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>  
>>  	/* Check bitmap boundary. */
>>  	tt = sbi->used.bitmap.nbits;
>> -	if (inode->i_size < bitmap_size(tt)) {
>> +	if (inode->i_size < ntfs3_bitmap_size(tt)) {
>>  		ntfs_err(sb, "$Bitmap is corrupted.");
>>  		err = -EINVAL;
>>  		goto put_inode_out;
>> -- 
>> 2.41.0

Thanks,
Olek
