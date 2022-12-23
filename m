Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D565498C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiLWAG2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 19:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWAG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 19:06:26 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8920BC7;
        Thu, 22 Dec 2022 16:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh5xwAg5KLfffzmyZt60cPUMtTxFlLEvZEZMcVGTdiCpab47eipg3Z2R57cmGOdMpBjdkq6mZTxDhjuA0IizNgL9sfJBmB9/0/SF4/kC5UkOVE3ZFryxpNUf4wOgbKP3Zj2cuKLQrLMjxWiJmxpSGb4w6/597jvk5OVMxY4L+MYasDVkx+m+SCtjZ95JkVqpORLPOp383HQowRbrhHtXHlgraYcBGC5uZWArSEjHmLuZrUa+S7d12aGTBq+9/uWqhS/qqZaD1CfqX2aIcU/4Pqm4wh6QowADEH86htmK8rI1HdytynScGHk12XqcI8rXZm/kQ81porDfD3zZ3ozMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1BFVtDbjnkaPEQVgzqh5Vx6YnSXU0A01rn18ZCGyTk=;
 b=dWCgVmjhmw17hV2Y1i36ODsvihY7WyM9p9dqJZPmLy6ewNEuTegcCBRl3rovrQVrz0fNoVT3nBpuSc7iGcC4vQ06edK+peeVW9i5sxZeF1tS87u5x7Na1YX0lRv2PKUji2cRLkZJMK+WYhQeCI3vV+Ev2DPv+dMQ7J9mEpKbf0R52GGp3EgPPUOHOgIejqgOHKHVcZQM57ALt/Pbjrr7NBvz2APBuu0YD0Zz54E4lVPqB8puz6CU2u5/Cb+kdd8vYV8CGKkjphjCiEgio4LVss/GAQUS5XjcQxYot+5bJU1QbNahdDD4e1LP2PP9f88WxqDR2eEJ7Fdka3dVq/IYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1BFVtDbjnkaPEQVgzqh5Vx6YnSXU0A01rn18ZCGyTk=;
 b=mjsf2uAZT71RS4ST9wGqBbVYUYC+//Hudg7lgiCltEUKIv0YxDD2iCONFjwi5RxM9Dtbv6kDzpyjBrMAa96C3QiEQiELWQM+yALTogN5ZRzLLSf0HpD6nJyWKBz5N75RggR4W2NeG9OlKFBxbJWFByu0k5FZgp9hHgz+SwILXV8Fm8JNekpUKTDlmzx9Cwr/uxR0y436uRs/Xs8NBe1dKlO5fhbHDTd67BZXnMi7i9LPELUbSd7in6iLY+sE6UgO1poReF9p8HzR7vAhCCvO0iD+sdFBHnyxkkRx0gktez6cZkigwxIKh1xRP9h445LtacfhiRpwKfszR9BCc5zZAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8122.eurprd04.prod.outlook.com (2603:10a6:10:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 00:06:22 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%7]) with mapi id 15.20.5944.006; Fri, 23 Dec 2022
 00:06:22 +0000
Message-ID: <4a4db05a-7ae5-2691-c062-7b37de94c0a0@suse.com>
Date:   Fri, 23 Dec 2022 08:06:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] fstests: btrfs/220: fix the test failure due to new
 default mount option
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20221209060510.29557-1-wqu@suse.com>
Content-Language: en-US
In-Reply-To: <20221209060510.29557-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 67eec34a-12d2-4b84-58a7-08dae4798632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6ewdbxfodXygipFWM3j2PInYAAJ03EiNrhOlLLCvkUYSbWkl2eFKl/S8tqZgzXwsJC7B8OVSEFouNmwYHWWdnF4mEO+kIyYSSGkZ7yIO70+qJxQbPsU1AgnSH4RQxtdTCUA8/GN8y6pf90yh4QeC8MmUJaZk/TNFOCE8N9j+vIsOl/siwIIx4J4n5a5AK4Gsc39BxciMn+s8vJ7lEwwwK2K5P1FIP3/FZq7uyIeWkL75XC+l0+FX1zrvpNJn5Xsmle2G3X+wcs8aWqNoTjFHoecMSF36vtkOvzeWYOtcsqGxIK3T7/zeXhfQQhBLFx5l+YCkvVf29HOw746Y0XAH4LURNej527s1Uj2i+JObqWJU5P6nyqCgKvO7jssqtGxt2EdIM+GqB3Pk1q/CWnYHDMWGhReoa1hmlLy+LRZLKNXX1vOI6u5gROEza6/BmFEhrl+Tu4p4Gm3ui0Evm1Ozg55WhGYjJeXcXzu8hvpfF65sbXX/e1AULnJUKqPBIvQtWRsnJA54d7FbSzhswx+tQISZFw9PNxtmMH8T/aTIPDJKUiyIJOGuTdMul47bsA9bYwmjHq1KxfoDrvibZgprYB5nVqRiCEZfvy2vdeHOPHHwa5v3LYgJXVEilhV+mSKJPkeld/MF1k626fGp2tmh2ZpBbOFK3ofdecd+ZlQS5kn3/UJQ4XCQJJaKq3vEARXTSMz4R8Hrv483zFJ+vdiIzBBVJwZFVbkXqIXKiCprbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(316002)(2616005)(8676002)(31686004)(5660300002)(186003)(6512007)(6666004)(66476007)(66556008)(450100002)(31696002)(66946007)(86362001)(6506007)(53546011)(38100700002)(8936002)(36756003)(83380400001)(6486002)(41300700001)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0RKMjhlT2Q2UTNqZWFQOHh2cUZ0SkI3RFViN1c0RDM5ZXJLcmNrL3A3eGo2?=
 =?utf-8?B?Tks5SURGZzUwYmtrRlJxOHhtaXJQaTBpMlVPOWdlV3dCTTFjMUplUjM4VXIz?=
 =?utf-8?B?bmxCRVFXcGcrNXpjSk03TFZHQ1dFNlNuc2s3ZVh4RElZcDl0U0ZvRUhxL3NZ?=
 =?utf-8?B?NnJEZ0dsTHVidEhVdmNpV1VhWUJHZ2RjQWFNZHNaTGk5bm9DWEdCVWxRRzNo?=
 =?utf-8?B?NXV1aEJYMnpCcWovTEY1djVpYXlGYUpXZmx0b0prTE9IaFozWUtJdUhudXBh?=
 =?utf-8?B?b1N0WW1yL1J1aDhEOUpuOWZRaEVuRHNKMWcyNUh5T0k4ZVBzdGVxU3BIa3U5?=
 =?utf-8?B?bVJsM2g3bUk2OEdnU0lENW81M0V0QlRCVGpMd1FEN2FzU1ppZ1N3WlRNbnQz?=
 =?utf-8?B?RHpRREIrY2JyQm5qbnFoU1oyTnl1Sy9USlRTTkN3WFV4a1haMTJkNWNUcGow?=
 =?utf-8?B?SzFjYUxXU2wwT3hnbnhpcUZEWENaanZqSDFHUmxsbFZXTmZ5QVJkZi9MV3Fa?=
 =?utf-8?B?Nk5BT1lWbzBXZTJMY0FxamtwaVo5NWo5bmRYUEpxYWRVNzlPL1JWdXdMMUdp?=
 =?utf-8?B?UGJYS0xBOGxtSXRkdGRESXZ0UXovZXdqU1lVTTN5VHlpMENRbW9PcTVCZXJi?=
 =?utf-8?B?Zm1LRGRqTHVhODd4ODJWaEwrRHJ0ZHdEK0daOEhqVksxaXQ5OXNTaHAwWkJF?=
 =?utf-8?B?QkxaRUxiZjE2cFpEcnRoRE1Mc3UrQ3EvTFIyNDdobUpLWjZDQ2hHYjltV0Z5?=
 =?utf-8?B?RTVqMFVzOFoxSDdOTm90eUkrQlpMeE04djA2S0ZYUVFWbWlTT2QxaDN2eTRL?=
 =?utf-8?B?VzhOWFg1aDgxZGI1MUk1ZExRaHNrTkgwMExJYXF4WUYzVGhTU1d0M3VxSFNp?=
 =?utf-8?B?Vk4rNDZBaXkxWXlBUWlCQ0E5aHlGQzJNcFhZblk5TnVWNEZNbFFCc2VLQmhq?=
 =?utf-8?B?bDBFb0laWFRMZHBodTlCM2lGVnR4ZGhsKzV4OGVvNXJadWFLNEpFbHZ3OUgz?=
 =?utf-8?B?K0plUkl0bWQwSldOVU5KRWN1ZDlsOHNqZU1PYkFURDVBNW9xS1JMTUR3Wi80?=
 =?utf-8?B?eEh0OSsyVGJ0Mjl6Ky9sZTZRMDExT0VDYkRyaWZPa0s5aFNBbVlrdTBqOEJY?=
 =?utf-8?B?UlJhNDNSS1dlMk8zSEp1NlAwRlBGQXJhcGlrRFFvSm9MQm1SNEtXL1pBUFQv?=
 =?utf-8?B?em5PaXhOemV3UnJEOWhRVmtQaWlJdHRPMnRMOHZ4R0tFc3V4QUJFSFI3WXR0?=
 =?utf-8?B?SkM4bE8yNFF0cURjc216M2J4Y1NWRDgwYXZMRDBDVUszNjE1UnFKcDRMRlU2?=
 =?utf-8?B?NXFGYWNyS0haSVhVT25hREl3ak5EbFNieVRId0lJcEkyZkdCNTJzbDJWT1R3?=
 =?utf-8?B?NjJvdVpYeWREWEVIblFLUDdTVytTZXVTWEtTN3JBMUFOZjdkd3BIaXlGTk9X?=
 =?utf-8?B?L29za0w1dkc2b2oxb2VReVA4RU8vUWxzRGoxbzhFN3Q4UGV6Sk1NS1JyaHRJ?=
 =?utf-8?B?Q1ZhYzZmeGNOVEJYUVoxN3dCRmhuS24wbHFSSVkyd3dtWlczM056ZDVwQkVJ?=
 =?utf-8?B?eGlTeWxnZFdvdERkUDVsTUdad0hZR3pZbDNManpCZHJjTEhlQVJyU2pNSytX?=
 =?utf-8?B?eGlmc0g4S0lnMkViSGFqK2VuRWQzd2l5WE1oUDBaa1U4WEM3djRpdkJUZklH?=
 =?utf-8?B?bkZWNzJEeGYrbWFNN2tKNmJaMmhKZjRWSCtjR2pTa2NNdzcwOEkvdFVrYVF4?=
 =?utf-8?B?RGZRYm9rVllUbk9NWGZQODl5SEtVVW4rVmRMdDhVK0psb0lSY0ErOGphc2R1?=
 =?utf-8?B?dlVKTkt0THUzcjBzVWp0c0sxTDVFVHFEWHRwR01LSVhLaUN6ZEdSQ2xRMTFn?=
 =?utf-8?B?eHZYZXh2TmNZWDdhWHZXNzNIVFkvZ3dGRVA0aHJFbHczVkl5N2ZxdHFackdH?=
 =?utf-8?B?K3ZFZW43bDJHMVl5RGUwNGlDVXZtL3BLdEU0a0dzc1dYUnp3a0piV1J1ZGF0?=
 =?utf-8?B?SHA2dVR2NTdMVnk5TldqVXhGVFNPZGs5cm14VUhsVk9ESkplUDZlb0hoejV5?=
 =?utf-8?B?YzJFSlRXZmNaWHR3QmlzTmZMMExFckI5YnpaSzVCUUZ5c3hDMC9JVFVObVZu?=
 =?utf-8?B?YWN0clFDSi9rMHZBcHY3NFlOTUkrYjFIU3pqT2tiTXVPbEd6ODlReG92U3dB?=
 =?utf-8?Q?Ux9KevdXe8JHu9AFKDQsU+k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67eec34a-12d2-4b84-58a7-08dae4798632
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 00:06:22.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlKn22zUHoZyvBMbAnixYNwYhp3oCpN8KJ/QcYn+Wf/UqRALY+WB8OHH2B5ic0GR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8122
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?

I didn't see this merged thus it would still fail with non-zoned devices.

Thanks,
Qu

On 2022/12/9 14:05, Qu Wenruo wrote:
> [BUG]
> The latest misc-next tree will make test case btrfs/220 fail with the
> following error messages:
> 
> btrfs/220 15s ... - output mismatch (see ~/xfstests/results//btrfs/220.out.bad)
>      --- tests/btrfs/220.out	2022-05-11 09:55:30.749999997 +0800
>      +++ ~/xfstests/results//btrfs/220.out.bad	2022-12-09 13:57:23.706666671 +0800
>      @@ -1,2 +1,5 @@
>       QA output created by 220
>      +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
>      +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
>      +Unexepcted mount options, checking for 'rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/' in 'rw,relatime,space_cache=v2,subvolid=5,subvol=/' using 'nodiscard'
>       Silence is golden
>      ...
>      (Run 'diff -u ~/xfstests/tests/btrfs/220.out ~/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
> Ran: btrfs/220
> Failures: btrfs/220
> Failed 1 of 1 tests
> 
> [CAUSE]
> Since patch "btrfs: auto enable discard=async when possible", which is
> already in the maintainer's tree for next merge window, btrfs will
> automatically enable asynchronous discard for devices which supports
> discard.
> 
> This makes our $DEFAULT_OPTS to have "discard=async" in it.
> 
> While for "nodiscard" mount option, we will completely disable all
> discard, causing the above mismatch.
> 
> [FIX]
> Fix it by introducing $DEFAULT_NODISCARD_OPTS specifically for
> "nodiscard" mount option.
> 
> If async discard is not enabled by default, $DEFAULT_NODISCARD_OPTS will
> be the same as $DEFAULT_OPTS, thus everything would work as usual.
> 
> If async discard is enabled by default, $DEFAULT_NODISCARD_OPTS will
> have that removed, so for "nodiscard" we can use $DEFAULT_NODISCARD_OPTS
> as expected mount options.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/220 | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index 4d94ccd6..30ca06f6 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -280,10 +280,10 @@ test_revertible_options()
>   	if [ "$enable_discard_sync" = true ]; then
>   		test_roundtrip_mount "discard" "discard" "discard=sync" "discard"
>   		test_roundtrip_mount "discard=async" "discard=async" "discard=sync" "discard"
> -		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_OPTS"
> +		test_roundtrip_mount "discard=sync" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
>   	else
>   		test_roundtrip_mount "discard" "discard" "discard" "discard"
> -		test_roundtrip_mount "discard" "discard" "nodiscard" "$DEFAULT_OPTS"
> +		test_roundtrip_mount "discard" "discard" "nodiscard" "$DEFAULT_NODISCARD_OPTS"
>   	fi
>   
>   	test_roundtrip_mount "enospc_debug" "enospc_debug" "noenospc_debug" "$DEFAULT_OPTS"
> @@ -344,6 +344,12 @@ _scratch_mount
>   DEFAULT_OPTS=$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
>   		$AWK_PROG '{ print $4 }')
>   
> +# Since 63a7cb130718 ("btrfs: auto enable discard=async when possible"),
> +# "discard=async" will be automatically enabled if the device supports.
> +# This can screw up our test against nodiscard options, thus remove the
> +# default "discard=async" mount option for "nodiscard" tests.
> +DEFAULT_NODISCARD_OPTS=$(echo -n "$DEFAULT_OPTS" | $SED_PROG 's/,discard=async//')
> +
>   $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/vol1" > /dev/null
>   touch "$SCRATCH_MNT/vol1/file.txt"
>   _scratch_unmount
