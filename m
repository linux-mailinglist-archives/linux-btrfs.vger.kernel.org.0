Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41D50603E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiDRXeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 19:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiDRXd7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 19:33:59 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9AD245A4
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 16:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650324676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKBzs9C0ygntQAaZNScCqRy3GIYMYwiEEJ1XkaT+bFA=;
        b=MrkoA7VrdhEGHITffmOmRS0HLQJReXGNnakBK8b5xoqe/KBtVeqC7mQx3tCwXZcu1epD3F
        ky8d6GPhk1hCOexpLm9iUnMOalblk/BDcuGMTP/LS1d95TvAXz/91QU4QXh9CbXwL9vxCc
        qjaP9mezzAcNzjJWG5SR5qkDLVLcevQ=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-dy5HbBf0PxKTkCUfeWti2w-1; Tue, 19 Apr 2022 01:31:15 +0200
X-MC-Unique: dy5HbBf0PxKTkCUfeWti2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFBF91IgdbNYOWWXh8t47IT8x8TH1a+FgA4ydhrw5q/bZcYeukO/g+4xJ26rN6wX0np4bytvoBnXMUuvMUaPmI544QM1En8xVX8VGxe4Sw/QwOHCooatpTN0oO8jQsukBSWSle6V8KMWe0q+hswenyobBxyRyftZao2pWLvcCSNXm6KLUBng3hXzPrirojR6MFBZ8/F3JhJ6quNVj3bEDbtoOEdwlrvLIX2yWTn04ND2f4duGIA/kIatReRz+Uppk99KqykYxduXW+EmmHaZox/oHJs/wp0XrXSQ6LzuOb+odUv33R64LN8+U9PmiLoWqYKZhTfIwpIWFDXYtG5JkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKBzs9C0ygntQAaZNScCqRy3GIYMYwiEEJ1XkaT+bFA=;
 b=Ah7iu2CIGtNLlqyjNjgj6MMKrK4GQQyDRDsKsOTmV5BckDNmIQyASEc95SIWrk05Ff14eCilB7k08aGbvvEHPtaQHVCqJfWrPAHzztJhch302Y4wXpfEoMqD8eqs8f2h0OZrw0rG0gduf8k25etaLTeHyyO0Mj/wR2iRjXILXhuxXJohKSx/ecr0eJhEn6AZELEiaC1pbfVXnnK8Ki1epIH281Vc+mT2QmgEiiCvn2oizipTsHeL9j8XemhRHo5O3oj07vZhyOs2xfE4kerfo6jcCeah0lpFNJpIdI9ev1Vg5jLaIlX/F5TA12gUbTiqyz2RwtX6usvYdGFw3SKTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB7PR04MB4249.eurprd04.prod.outlook.com (2603:10a6:5:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 23:31:14 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%6]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 23:31:14 +0000
Message-ID: <61956f0e-9ae0-144f-e4f9-bff5dc85ec31@suse.com>
Date:   Tue, 19 Apr 2022 07:31:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs-progs: do not allow setting seed flag on fs with
 dirty log
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
References: <4022d9f87067124c26bb83d4bba1970c954cdf50.1650022504.git.wqu@suse.com>
 <Yl2ELwGRRE1OTj3E@localhost.localdomain>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <Yl2ELwGRRE1OTj3E@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::11) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6789bb-4d34-4a16-5cd1-08da21938747
X-MS-TrafficTypeDiagnostic: DB7PR04MB4249:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB42499F21368FCF35EFBE29EAD6F39@DB7PR04MB4249.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1qj62LxYoVJXoRuI/s98hajpMmrI4LuzUsU6nEZ2X157Pq/eWw6SbvjqboQCzlb9nDccHkzUtgCgl1tmmrI/nq8MaRQWjGFoKdgVyEaciPgDfI+AJz3VYY4WU8VbX/ij2mN6QSvmFcwMToawGd4w7QWrVBecwDkQPtZflK63hdltmqatjZjIX5mKHfn5QlF5UzXAnlK4GeSmzOf/aaZ/kZOeLPengp75xpKohx5uHNdwdQf/8wAzzYhPeN/YZcRgU/bjAF3YVJnQIqJMr8fksrKpycgjrTsQWzXY19ThWhfXch3gjzcQ9IuFWt0BarXbAiQv6mgF8cRD253jd4XdbB0N8s5mvI1zmxdFFjZWC/IIiRsYUyryufcMwhii7sQI6+36+gLX808r5x6il9hmZKSR8To/2qM7S+6Hw5GkWSxfmJeAtWT97x1I8/Y1X9IAc1cMRjwuLLPC4S1L0bcsZyiC21ZH+q2/LtT09mBs7sm1ofEk25baGUwo8cb0NxpqOUCgGu3UP0snj4iMfhiBBO9I3O3VKtECDbZ2FRZ9oJlQQHO1HRLZVrHafES6lYOfKFt+gEa6Y9w79gJibEhzO1Jpj+qyie42eRNdLQQW2LfgPAz33tXxoCQpOmmbEHB2meX2GQ4pcAJ5aJY3VAz1ybq/4Ld3Bt3STCX/slcQs0lY5xab/vZ8Wahi+pJm7xTReaE17xEOf7dcb4di7zPmxHD90iJkVi6U+lv+9kWFKt+2K7sD1Vpm6EejowXvJjD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(31696002)(66476007)(86362001)(83380400001)(66556008)(66946007)(6916009)(316002)(53546011)(6506007)(6666004)(4326008)(26005)(38100700002)(6512007)(186003)(6486002)(5660300002)(508600001)(2616005)(2906002)(8936002)(31686004)(36756003)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWtqQ2hSbGhrcXRTcFFhK3B6NmR4a2VVQ2pJR0s0MEFSelpndC85ZEcwMU9B?=
 =?utf-8?B?REFESGltamRzVUlVaU1JY0dDMkxWMjZncE5hWWFhU3UwekxRRnZQVEFBWWw3?=
 =?utf-8?B?ZGoyUGlnSU9Wc1hsdUk3a1hMR2xZeFlmdVplQVh5NDRTNFNPSm9LMS9DU1gr?=
 =?utf-8?B?aHR4aUQwVDluODFEejh6UU1GZXNESjhaZ2RWYVdpWExmenZGU3pHT3Vobm1Q?=
 =?utf-8?B?VGJTdXBCN1JnQmViVmxpQ1JHNGMzTlc3OC9ySWVPd1EwKzZsVU5EWXd5aFJS?=
 =?utf-8?B?MTFPMXJYTEhnZUF4RUpZN3d5SzhwVi9LWnpBaXBWcEhGYUFSOWFLUVorN2ZH?=
 =?utf-8?B?eThnQmdMTnZJY3Q0ZzRwZmpjWGNHQjhTRHZhdGIyVkVXNjNOZzVDY050LzBV?=
 =?utf-8?B?aEJRdkprdnVwTU9GdzkyTVNSQzg4RjlveXRkelFEak9MVGJLY3JaK0x1VlpJ?=
 =?utf-8?B?M210MkxSMTNZS0s4V3hjK0JUemlqM24rTjh5aGtmekc3dU5idHZoaDBtNFo5?=
 =?utf-8?B?bjlsNGFqU3R2eElpU3dHMVF1Wmo0Wi84WjFaVENlV3d6VTlSTkxLTlJGZVF6?=
 =?utf-8?B?WXo0OUdpNm9yUHBJNlN6WkJkR2FTazVET1BJcDEzbHVlNnlWelU4M1BoakE4?=
 =?utf-8?B?WkIyK3dPeWZsaVRvU2U3VCs3NWdtcE85aTBYZVdTckN3QWN3cjFqdUVIQlF0?=
 =?utf-8?B?ZStlRlIwMC9UUnc0bEh6UzRITVN6b0Nxd1crUTdGMFBYMUNYUkdIRC8xcjJj?=
 =?utf-8?B?L2doUmVQbFlxWjFzb01Rakd1bFZwcklHNURFcmJ5QXo0dDYzQzl0YTQ2cENZ?=
 =?utf-8?B?V05tT0Y4ZEVBMW10QmZnSVJ4M2NhNGpONXRNV0RqZ0RYYks2cnY1Q2c2cDBY?=
 =?utf-8?B?VVZQSzlMU3A1TEwva0RXSzFQQ3REdlFRK2ZObGxsRC9NVWE0ZlhoTTB1VmZq?=
 =?utf-8?B?N1J0UWJTSTZtZENZQUgyUkhKNEplT3FpTXhPWTcveUVWd3d1ektpRWg2ZkFw?=
 =?utf-8?B?S01CYWgzYW5KUnI5TUdhYnBSRzZhdGhOWVRPbTJEWmFlelFmV2orR0dldDdD?=
 =?utf-8?B?YytubEUzbm9YRjh2VTlEWm5XUWlXaUxSUVR3RmdSR2RUclBpVlMzMEt2dmpo?=
 =?utf-8?B?bHRBWURHcG41RS9RTVUxcjFqcjlhRjBET0txVnRDUGV4UC8zZktURXlCYVFD?=
 =?utf-8?B?RlNsWUZDdUdpQnhuazFsOUdUWEROS0NxQVV1RE5RWmRaKy9NWDVHTjI3MWNi?=
 =?utf-8?B?Z0Jvd2Znc1FUdjNiWWxtZWhWbGVGMWtrRWNPM2J3VVdaV25EZ1Z2Tm9GVGJ0?=
 =?utf-8?B?cjVFM1I1WVdrNzhleXppK2VEY0N4MjgzZ25QNW5peUowRTVNTDloRitlQlN0?=
 =?utf-8?B?c3dTRVE1YzRkWlk4WEJzNnJEOUwxSTd2eUhNNFRvbTE2QWFWM3ZXSGRuS3lO?=
 =?utf-8?B?V2RxaG9jd0IrSlpFSVJoNmwxb3g5NkkxOFFiV0Q3MDFCeGY3cFBIUlJpd1FV?=
 =?utf-8?B?aXIrM2VCQXY0a0s3d01sOFBYWE45QW8rY0I3R0t1UkRBZnFkclFGU05qVEl4?=
 =?utf-8?B?Y3Z6RU5WMjlJNDlSU1JXME5mQnJaZGJRSEpxSHR0MW83cmM4aVREc0J2ZUlJ?=
 =?utf-8?B?bGZSZ3l3SHVsbzZNL2h1cGJrb3V6elFuTnIyZWF3RGUvQldZM3o2cTRvUVZX?=
 =?utf-8?B?Ny9PWW1VeUZScWc2eW1UWGg1SWNYWFFrQ21ianJZQ3FNRmFOeERaYUdvRmdr?=
 =?utf-8?B?ei9yR0FBSzFyTDczM1F6V0toRTlTQnJEb2NnN2N0Q2hXZ3J5ZWc5cUNXVks1?=
 =?utf-8?B?a09Ba3VNUkJpS1hKV2JLUW1KRktSQzM4ZkpZcHJINjM1a01kYzZUL3ZOR1By?=
 =?utf-8?B?d0FSVm8rdUNPVHcyRHU0bk5NaUs3SFRxbXRITThsdWtWYU9sTUt4bU56Zloz?=
 =?utf-8?B?M2FDbU1PSFFhRTVVOFg2dHhxRk9DeSs1WEhRYTR5V21la2tXN0JMelNvRk9s?=
 =?utf-8?B?dzBxQzZzUi9xUnhTWkU3a0srNW5IYU5kS0hEdGpaK3l5TWVQbEY3QUlvMjgy?=
 =?utf-8?B?cWVMaHdicXBaUzZ2N3pYZS83RHhmSWVReC8zRURHTTFRUGVSd1dDbXlMRzlj?=
 =?utf-8?B?cEJ4bDZBQkJpdHh2Y3JmVWRXWjF6N0NMM0JIU0VEbHhBVFJ6VFQwSk92WWZl?=
 =?utf-8?B?NEhWb1VKMWdMT3l6djJHSEJLVmdncXJzQm12Y3ZiZ25LQnRXV0tsWTJNUlF1?=
 =?utf-8?B?MVRwbjVSbVJCdlBnaUtFT2dmeVJKZnV5OFJ5alJ6eDRLdTNpNnNVRG9wNWJl?=
 =?utf-8?Q?+IJxDjSCA+M23JBjCN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6789bb-4d34-4a16-5cd1-08da21938747
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 23:31:14.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1S+doypzN03t7H0n0TMQqlLuhnUxpnALirK4AvXcsxeu6NPXhhFPDmvnN5vDr1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4249
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/18 23:30, Josef Bacik wrote:
> On Fri, Apr 15, 2022 at 07:37:43PM +0800, Qu Wenruo wrote:
>> [BUG]
>> The following sequence operation can lead to a seed fs rejected by
>> kernel:
>>
>>   # Generate a fs with dirty log
>>   mkfs.btrfs -f $file
>>   mount $dev $mnt
>>   xfs_io -f -c "pwrite 0 16k" -c fsync $mnt/file
>>   cp $file $file.backup
>>   umount $mnt
>>   mv $file.backup $file
>>
>>   # now $file has dirty log, set seed flag on it
>>   btrfstune -S1 $file
>>
>>   # mount will fail
>>   mount $file $mnt
>>
>> The mount failure with the following dmesg:
>>
>> [  980.363667] loop0: detected capacity change from 0 to 262144
>> [  980.371177] BTRFS info (device loop0): flagging fs with big metadata feature
>> [  980.372229] BTRFS info (device loop0): using free space tree
>> [  980.372639] BTRFS info (device loop0): has skinny extents
>> [  980.375075] BTRFS info (device loop0): start tree-log replay
>> [  980.375513] BTRFS warning (device loop0): log replay required on RO media
>> [  980.381652] BTRFS error (device loop0): open_ctree failed
>>
>> [CAUSE]
>> Although btrfs will replay its dirty log even with RO mount, but kernel
>> will treat seed device as RO device, and dirty log can not be replayed
>> on RO device.
>>
>> This rejection is already the better end, just imagine if we don't treat
>> seed device as RO, and replayed the dirty log.
>> The filesystem relying on the seed device will be completely screwed up.
>>
>> [FIX]
>> Just add extra check on log tree in btrfstune to reject setting seed
>> flag on filesystems with dirty log.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Can we get a progs test for this as well?

Thanks to the suggestion from Nik, I finally remember we can use raw 
image for fs with dirty journal.

Test case will come soon.

Thanks,
Qu
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef
> 

