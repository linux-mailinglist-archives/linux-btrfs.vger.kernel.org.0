Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE366EFFBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 05:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjD0DPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243054AbjD0DPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 23:15:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B435B3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 20:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXpks0R9HyafqCvE3mLzbY4WHQHgY1PfDZXUcuG9mUCjBkZXa9EHZWlR5RxPr4fQ3qh8XQqsqvoaDyT0v0cRvDbqD3YECwWSmDoI95FS8/9ox5MHglM6RVooVDcfoE95knTiahh7eQJE/0ZG7ttHpR4ec2H8rhA5aXF2VcPwU4ySqw62IrAH3Te0/1CthwYThVjrC/jOOWmmNzD33WHU8NL8Gty4ZAezXs/wWPOb6MLAwhRy04Z1vRGhKCPZmIXMKrfDm37aGCF5QZP4hb5uM6o2IcoOr4f5sMivWUZTmgPWWRnPRa8Dn5cWYBfpy4h7OPp0qQOSy39E5H89NccdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW6NhU5+AgjdJY7HJG92vq9ebRaletCKZlK3GCkS8K0=;
 b=aeqG3c2urIUCYwaYAPT9eqtDUhz48cziTGredAZB6GNiUcJsRYCbcQKfaXiQ82jdcTXBcztSk8IX8cUW7/faFinNwrP2Z2l6l7b99usdK9IB48vTwtQ6HLq3hA9oETf3/LVzDZCmc7yWYJnQx3hyItB9PXbp99e6vbnRQJoCv0o9HPGRuGfUgijJ64DZMo/Euz8Qjyx7vRJaYkaCnSWTjYjrnXav2cwKul8uHHhfAb01CooWPjOVjS+Ht4/vZgmx2xM1uP46IXHSzeixrHXiFQt77mCwBsXRHVojPFO9Yvr1NT1tDqM8WqkQbwzXWX7o5sCePQAHBHpHnhZryDmCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW6NhU5+AgjdJY7HJG92vq9ebRaletCKZlK3GCkS8K0=;
 b=OcbfwrA11h5bAEKzryZQQRoHHWlZxkOpOg2ZLaAkgMXVtvEcygUf0NqUvWlr7T7F36uzzijYqOdYCvpf1uXrpFrHlQBYDKRVr+rMw/1XelWiLsaGDWS6ibin5SQTxLOi6F+5mLdk9zH6pLZXP/tWkg9eEUpC7JReJ0weyRxrIzxMPz2ZtzKEkfUaQy7VMRu7mG6oem4wjrFlLSV0rGGf/UsIvAFRZ+BK0ogLj/Q1o74iYu4u+9dXTaSAGmpqiVr/bTv/fCoXTI0p5VBz/XR4TM3gzIZ5hWqE/3SSIpQd4edf2NDhqnMTRnydL/8ktkP+CEY7QGPrsislZU/9/cFQBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 03:15:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 03:15:27 +0000
Message-ID: <c43781b6-a906-ded8-34cd-91d56442a89b@suse.com>
Date:   Thu, 27 Apr 2023 11:15:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] btrfs: fix leak of source device allocation state
 after device replace
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1682528751.git.fdmanana@suse.com>
 <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <e695f292be17c831e6024a743365737372a7a7aa.1682528751.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 85aff42a-579c-4523-af9e-08db46cda661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrTU9OakpkfTyLw8I+nRMHQSZeYDPaIvcePMrFuuAB5VM0TLfi8MwKvnclBzSLyRgBKrLsSYuPa1W7JJSrVuZFrOqD6dU3ir0Ve8fnXLmng1+U5EAZY3nvadE3GeJ7DbnbGJUbZN23+TIEkzSW/eCY0gnfMJNWjuYLNweKC+WFd0f9/OQoHQtggy15uplTgiRjxTNMml5zuBtNZLa4u5mS1xJNgTUwdxmETbA5p7rB8qKFsnNGlPAVBcAfHW+R/lpSiNbywDSEURUG2yUDpNzknwsm81pJCGPcz8PXWtuPV1Lc+xxCvuv2mvhjfP5Ny+wdU//5zA9f6/w+m0bSwpk3x2C6uRpYz4NPjlQOjoq8IsTOf8uK8ck1vosDtJ7+weNupIl4CVDgmy0/SFvPHfcWuhqghGZpq6ijKPK2PcGOLgWQGD4Ll6brv2q2UyM27DbLoFZS5XFr8YmO+uEmaPIW3TWPcMQkhqRN2cJB90tJwF2QFn8Q4dn8DxkaPERJeyUJfYHmZJk2vR14mkdlcoosSx6zESVCalmG2EoErjIZmFZ3alKa3rASgjyyrBBFZpW72zX4xt5iJv8/PonLI98Z76KBSNd/e2tGHuE4JW7HiGc2x3IhMFCodBbWUvFEQgwuS3hP37z9QwXyujjQhQ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(8676002)(5660300002)(8936002)(41300700001)(31686004)(316002)(2906002)(66476007)(66556008)(66946007)(478600001)(6666004)(6486002)(186003)(53546011)(6512007)(6506007)(83380400001)(2616005)(38100700002)(31696002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkc1QWo2S2hTNG1Gd0xZN1Mzc3BBeStLbTFHRHNOQXd2cmh4d1dJQXN1cWdi?=
 =?utf-8?B?UEdYd3dlczNYUkl4clU1WjF1U2FBY1Qwc1IzV09iSW9mcEdESE10SUVBU0Zy?=
 =?utf-8?B?U0E4S1o4amwwNk9tbnl1dDNOTEVyb0hVT0ZDaysrNDA5YWtLOThhamNKVklV?=
 =?utf-8?B?MW9hTW9YZjF1cVVQMWhiQkNxRERRK0xhM3lkT1RHUGI3QTR3Qm8rd0dhSGdh?=
 =?utf-8?B?ZHplUnZVL3prTEhlRllqeVl1S0dvWHFRRnBqNXVYZjd4ejEyaXIwRTNrdDBZ?=
 =?utf-8?B?TXBqaTM0blRaWFhKTE8wWWNMU1FFYzBGUFRrTHl5ZWlvdHQ0UHRhZzJTWENa?=
 =?utf-8?B?d004YUkzQlhnWkFSbzl6Y0FaaWMxd2JwWjNGdVhpbzIvejNRSHA3YWdkQm1j?=
 =?utf-8?B?aElHVHFRVGwzRjY3UkJRelI3dytiVlpLMnc3M3U2UWMrY0RlT29wR1ZUc1hr?=
 =?utf-8?B?eFhYTHkvV1U3R3lhcjdXdHRHMjlwWmZIT29ybUNlWnZpZy9BcFhmRlJpeVc0?=
 =?utf-8?B?eTRaK0Q0dXJSU3I0bjdDWEk0QzhzbGRZQlBhQnVjanJzSWMrTnJMRG9DYkFB?=
 =?utf-8?B?M1JuTHVnWVlUdGNrS01QVDh5SDhxcXlqSjI0cjF3d2xFS1AwWDlLbUZEbUdD?=
 =?utf-8?B?MjVad1JiZE41Q3MzL2JVd1BkVHI1eTkyd0VxTjFzUjljUTZEVUFtWm1jdFpI?=
 =?utf-8?B?OTVzQkIwYk1aMStNVVE2SDBpVGxsZ2pEb2JlYVUyTjJucTk4WUdWRk5mYVR0?=
 =?utf-8?B?ZGg4NWdNY3p3K1BwbkNSdHNWWmJUWVBWRlVKZXVXMVBmRkZITVFmb3NoVDlD?=
 =?utf-8?B?RGF5QTZYeFluSE1wUEQrNDBYVzhpRTd5dWIvR3ZHQ294NEVUUTVyOTIwclB2?=
 =?utf-8?B?aURtN2hibG9xcU9YMng3NzVQZHFwc3VPMWtPdHBhVEpzUVpQckZ4bzcxcXd5?=
 =?utf-8?B?TGd6QitiR2tDSWlOT1dBbzdvSHFUTVAwNlp5YWpwUGVxeUE4NGozNlhZZUla?=
 =?utf-8?B?b0k3MCs1a3pDTEFYNXkzRit5RkFFTStDOXNwZWxEOVpQRHVTckRrWjF5Tk1l?=
 =?utf-8?B?dWkxV2FZZW0xdGU4OUJqYzF3UU9IWSt2V2VFTWx3czExRzNzczRIZmdJSGsz?=
 =?utf-8?B?UnJweTJVemVGYzNXY09CazNTVE1rRnhqSGFSdjBBZTliMzdxam5zS0xUZ240?=
 =?utf-8?B?UE5rZXJubGQwZ1VYYWZnNE1DUWNySXp2ZThNNjhOdk96Nnk1NklyZC9rYTZX?=
 =?utf-8?B?VFZQTEVWRTA1WTc0THhDQkU4eG5UVXM2WThkWEZGQ3FwcGlXY3RnanlaSk5z?=
 =?utf-8?B?MzA0cXpaYVVoL2V1V2szbU1GNTY2Zy9QNjdiSUxTNTRUUk44ZWczaytvQy9m?=
 =?utf-8?B?a1Q4SlVGTFRvV3VVOHRIdi9xYmhsLzQyYlE5bTRvT3RWZm5mTkdhMFNIU2R4?=
 =?utf-8?B?WldPT2tLQmc1ektpQUVrR2lPaGxYajFFZEpNcjFiaTJ1UHpacUFmekJoRUhv?=
 =?utf-8?B?QXRUcjJJeEJ4SUpJWHQ0cGdjTTg4MGJCNm0wSUV5K2xVN1RDMTFMTjFRVjdo?=
 =?utf-8?B?amhETy82U0J5T29kaU1wb1JPYnQ2ZzJpSzlNWHJRdFdUWVFQQ2dETERvV1VO?=
 =?utf-8?B?NE1wS1pzSVltMndCZDA3MXN6UzN6clR6clMvNVptWThQbHBzWUp5SWl2dDdz?=
 =?utf-8?B?UEt0N3I3WURLSjBMaFpyeWpEMUl4WjkvZnJVSjducGlBQXowbEloU3VJOVM5?=
 =?utf-8?B?M2N2YjhJQVh1SkhzUk00Rkk3RmJVUE02VTFId1greXdnMjhqTDUwN0w4T0tJ?=
 =?utf-8?B?b1BPdEZIV05ycWVTbHcwTXcycGt1QXliN2VQVnJGd3NLUVBINTNacE5CQUM3?=
 =?utf-8?B?YzNldnZhbGhBSmZ5QUpiOU5OQkQ5bjlhUDFTdmFIZjkySGxBNWJaQUpYa3lT?=
 =?utf-8?B?aXhrdFB1azlUNXQ4dkJpNjY4K1hnQVF1UWFHdVBpd29iTUsvWWJSR2h6V1Zu?=
 =?utf-8?B?WGI2b2ZrV0NzSHdEQUNCTGMzMkpsekhGT2lOQ0x1ejFBTklOZjRoYStFY1E5?=
 =?utf-8?B?MUtwSmdVY1E3UkZKWStHK2YvcWlpeTdFQ01IRmhxL250TFZJald6cTlaNXVq?=
 =?utf-8?B?L1hRUFptQXhOMW9iamswNVNWSFNoeFVBVXdKbmJNVmk3MnQrYy9UOUF4L2Fl?=
 =?utf-8?Q?UY4O1wMAuEWqt+l5iSDTyFQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aff42a-579c-4523-af9e-08db46cda661
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 03:15:27.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAUF3IyrI3yKx0Iz1sbw7IBMAzkm5PFHW8TjAukUHYWYwBNBMwGMS6QsWaWbksOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/27 01:13, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a device replace finishes, the source device is freed by calling
> btrfs_free_device() at btrfs_rm_dev_replace_free_srcdev(), but the
> allocation state, tracked in the device's alloc_state io tree, is never
> freed.
> 
> This is a regression recently introduced by commit f0bb5474cff0 ("btrfs:
> remove redundant release of btrfs_device::alloc_state"), which removed a
> call to extent_io_tree_release() from btrfs_free_device(), with the
> rationale that btrfs_close_one_device() already releases the allocation
> state from a device and btrfs_close_one_device() is always called before
> a device is freed with btrfs_free_device(). However that is not true for
> the device replace case, as btrfs_free_device() is called without any
> previous call to btrfs_close_one_device().
> 
> The issue is trivial to reproduce, for example, by running test btrfs/027
> from fstests:
> 
>    $ ./check btrfs/027
>    $ rmmod btrfs
>    $ dmesg
>    (...)
>    [84519.395485] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg started
>    [84519.466224] BTRFS info (device sdc): dev_replace from <missing disk> (devid 2) to /dev/sdg finished
>    [84519.552251] BTRFS info (device sdc): scrub: started on devid 1
>    [84519.552277] BTRFS info (device sdc): scrub: started on devid 2
>    [84519.552332] BTRFS info (device sdc): scrub: started on devid 3
>    [84519.552705] BTRFS info (device sdc): scrub: started on devid 4
>    [84519.604261] BTRFS info (device sdc): scrub: finished on devid 4 with status: 0
>    [84519.609374] BTRFS info (device sdc): scrub: finished on devid 3 with status: 0
>    [84519.610818] BTRFS info (device sdc): scrub: finished on devid 1 with status: 0
>    [84519.610927] BTRFS info (device sdc): scrub: finished on devid 2 with status: 0
>    [84559.503795] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
>    [84559.506764] BTRFS: state leak: start 1048576 end 1347420159 state 1 in tree 1 refs 1
>    [84559.510294] BTRFS: state leak: start 1048576 end 1351614463 state 1 in tree 1 refs 1
> 
> So fix this by adding back the call to extent_io_tree_release() at
> btrfs_free_device().
> 
> Fixes: f0bb5474cff0 ("btrfs: remove redundant release of btrfs_device::alloc_state")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 03f52e4a20aa..841e799dece5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -395,6 +395,7 @@ void btrfs_free_device(struct btrfs_device *device)
>   {
>   	WARN_ON(!list_empty(&device->post_commit_list));
>   	rcu_string_free(device->name);
> +	extent_io_tree_release(&device->alloc_state);
>   	btrfs_destroy_dev_zone_info(device);
>   	kfree(device);
>   }
