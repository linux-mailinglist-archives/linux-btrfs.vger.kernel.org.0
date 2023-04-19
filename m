Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FC6E749B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDSIEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjDSIEm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 04:04:42 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA459750
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 01:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQOxjqxdp08B08bYlWSThLmvbQVMEIb571hevMtUPpNNIuSkaRmbQKiLJiqxagW64LSTgdplIpWU32bsr5EUgQaPmqTz7fsHfndAI0hKJ++BsYLpi7rFf/P2uZhJS7cpqs6ComgMUdbFFpys/x0kpPiIVoY+ndmkSLr3NM481mMZmCeDL9Q77Ykqo6ha8VqWLodfnjWDAmAEQ78ouQboNdLAsvzTLbedCIxl26gqM4TR3sEXAzJ+2DRJtATQYqk5mEGtej4HkDmVKdt/MWQ2xE1rsoaIbXo5VPhwrdAxi8OyJC22rKtN+jqZf6EchmjHDfEIpxUB39cuVgrg9e8GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK0NI1LOOq8dPZTGWmMihhqycf4Ex3UWB/EW7ygqQ9k=;
 b=aJ24e9C8Aj4bJKBQ+yy22fULivGBhB+iNId0g17F5ifa4bz7JeEHDc+nFAxxdVSQVfB7k9Xlo3+WCM9QwUn50vSPiluEKTtuksQ8Krwm29pfh0yoySMHYy0M8im7IkHtmY+0b4ZSHZ1x8S4lcsU99+lHQqee13mnMH2W8buDN/TZNHh9WLbYc8QvapVsawjkLpYAwhh5OedOFK+IcD0cHwoxjX9fbQefYfcZMMskIe4TC8vTqMGwewksMSJbAikBuWHcTxhlXM9GbeAdXpwJAS6B7stTlYIU45/WBtgBjFSdaUGLt3DW/Hv5Juvs/rZj1gNhb7/z8sNy+7Uqornt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK0NI1LOOq8dPZTGWmMihhqycf4Ex3UWB/EW7ygqQ9k=;
 b=RxyoWSFgthZp1xgJETRDyiucJhdpY/8PPZmTFvxWbzTpWfUfNIBvQNxUegoET2hC2zp40qnBei7jdJbT4pcA8te1FXzDPt4pOODMSn1oaVFu94LlN4MyCP98Yk/cvBNNSU2ztQPY6w4YNXM6g7wXRse2SzwQ98L7WygV31fIjc+IZVIKJN+KztTvgIV2F92e2l+vb9YB/Z94sKHp7jZ4HTqsezW3REYr5xs1ATWprQvdNVN3eEa8cj+16o/ttNPoqXPc/Km4E3Qg3N3/O/msOXZyo8dzKaRAtbmEebHVusSgDNlwWAXwxWU0dIMg74/xkyy6s17mXcJsDmdhj/3yAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PR3PR04MB7387.eurprd04.prod.outlook.com (2603:10a6:102:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 08:04:24 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%4]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 08:04:24 +0000
Message-ID: <bb64fc47-af26-cc0c-0ba2-bdae5f9fe24c@suse.com>
Date:   Wed, 19 Apr 2023 16:04:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] btrfs-progs: logical-resolve: fix the subvolume path
 resolution
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Torstein Eide <torsteine@gmail.com>
References: <20230417094810.42214-1-wqu@suse.com>
 <20230418235505.GU19619@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230418235505.GU19619@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PR3PR04MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: f795833b-346d-40bd-c33e-08db40acb04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wU85TZRd4e/0JDCt1J5w7FBj91LrnsAQGUaNXmQR4pyzprWV560humPxYmW16YnKotjuo2qEfZ3sV3TQfmxMFIuZzU2jlNSjUbFziOOW6vLqpgiAM+X2Q61ebA2QFwfcoSNn8IZX/wprvBN/JW5qyq4unrgey0Zu0pam+EEA1geX4QIrm+d1JiFcUJaZsbJb8QHP0CFQ6mDfL9Uy54FnU+3Erps1GNUwTbp52++EtJJ8dTSEXqjKRK97GgQJFQPtF8M4CqTG5Q5P/ZHuwQvr4U6PPD9nqP52iQqh7jafE0fQaIkBsrejJvvL0G8s2EZld7PH0BEN1cRTJ4+dj0EmVdjG9QEkG9NZNx2kWez9HtDrIezctbKMI+4+Kn+ZZ5OqbkrFsYtboNGZBxMx3T75NvEfdKa/yW/Vbmi/613skYrJ6b/u26k3cbSGjQdAtOV0CV1zuP9Dou6obAL10qF0XNfosG34T5rT1Ebmpy7Jd5i8b1gSzUqIHx04sOcjIddJ9OedcEkWTnb8uwpbSJlg9seYoH1SqzKFuwvX9B9MNCWM4t5+PYbBuh44R5GCwqUjYsCgasyO7cgeh1ClWl+DgkJW5QOiDBC61kTKQwwwsWE3ny+SI/u1iIhkBWZ2DaXjv9FgOtPqG5FZh5NXme9AtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(8936002)(38100700002)(8676002)(2906002)(36756003)(86362001)(5660300002)(31696002)(478600001)(6486002)(6666004)(31686004)(966005)(186003)(6506007)(2616005)(66476007)(53546011)(66946007)(6512007)(316002)(83380400001)(41300700001)(4326008)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZrQ0l4NlMyRUFJK0xHUSt5UkNLa0hkR0dVL0NML1IrYktJVERrK1F6a2cw?=
 =?utf-8?B?RUtFWkczc0lCT3hXMkJMWUJwWTB6bjNvVEZlNytyZGFNem54R3hjNUhCUmhj?=
 =?utf-8?B?eFdQbUtSZWRYbXhEMFhxNTlCOThCYmZHSStIVTBsT0hSMDk2bkxud3dlM25t?=
 =?utf-8?B?V2U1TlBWem1xVHNYNjY0cURpSkdUb0pSMlVVSDJEN0dQMzRvY1F3d3FPSGF4?=
 =?utf-8?B?elFDU3RLOHRzQ3VHVHVOV3BwaTM2SzQvT3FBNm1PZ0V2VnI2N3M3ajdPVHZk?=
 =?utf-8?B?QUd1UE9QMzA1bm14aldSam1KSFl5c3hoMG8ydkFmOXhUUUxoZEJudW1vMGd6?=
 =?utf-8?B?SFVMblZGRWVTREJIZjd1dlc4dVRSdUZkVFAxUlg4cGxOdExpaVFabmZCTFRq?=
 =?utf-8?B?VllkLzhoaUhSZTRnQmJnckdVMGF3TXYyOXFOREY5QTZLYjFpaENQTFpGajVC?=
 =?utf-8?B?NjZvNGFYNk5rWmI3VXdFRnJkMkpmTzIxRjg0VUJ4Sy9kUFdQV2tTemdTeEpB?=
 =?utf-8?B?ZFhPYktYT0dwY0R0clVCQ1VkaUxZeU5hK09xNzdqNW1udmhzeWxyVzFlbzMr?=
 =?utf-8?B?QS9JdzlKR3I1MFZvRk9qUG5sbUM1elNzMTJMMmJ3K2lHN3JqbndZYUhMRGcy?=
 =?utf-8?B?M1BuUnNSOWJEeEdMejI4UUtmVmxZM25YK2N1NTZYbXpyb2taS09MN3hlbHVP?=
 =?utf-8?B?L2NxRVdTREhZaGMxQ1RvT3VLNHM3WHh2aEZLY24zb2tDUjBLK3NmK3hZTDdV?=
 =?utf-8?B?T3RyakloeVViTGpwN3hiaS85Q3BGUFlzUDhiL3lGSVplc3hlZWx6ZWptWStL?=
 =?utf-8?B?RlowSE16b0dvQzUvTGVoMXlkcnppWmFhcWRuZjlUa0JHVG1jbmRPbDU2QXZa?=
 =?utf-8?B?V2w0akcra0FSdzFGY1hqRkhxNFlVdHltTWpXS09mckJpMDA0cXAvODJQUEdO?=
 =?utf-8?B?MlRVR0hITHVDVXg1ditFMEg2MGJsZ0wzMlZnWjBKVFhpNkhqeG1GTjFQZXF1?=
 =?utf-8?B?cXROZzlhUDNpbVpsN3BHSVpOK3NKcXJKMk4wQ2dIMVBvejBWWHpydG9NTTcv?=
 =?utf-8?B?OFBNZU9HbEJQRTlWdkZrc0hRa1VJZDZWYXllVy83ZDV2WmxJNm5Qb2RvSHAr?=
 =?utf-8?B?aTlaZGZ0U1R3dHZYVnQ5b0J5NWpENEQxblc5NFVnTFhMc0VPZXZwSmpIUXZV?=
 =?utf-8?B?Y0hEdVRPVUpYbVlObnNZbGlySGhnSWFTeVc1TVBqSFlVU0JDeTVGekYzY3Nu?=
 =?utf-8?B?bm9KNDU2NXZpVGgwZkVLakdRamo5WUZtRDVHU0h3b2lpcXdVT3RPVG9lMUp4?=
 =?utf-8?B?VEJJRm9PQlhINElRVnpJUnhrRFlwTHBSWSswdTQ3dVEvRnMvRyt1VUYrYVNn?=
 =?utf-8?B?QkRhdFpIbkZlZktaYXNFaXFQaXVaanNzTzVjVGlqNVlkUnFBbElOOEhiZFpy?=
 =?utf-8?B?RGs4clVCOGhJYTlBRGYvN3VDbDAvb3MrYm1WN0R0aThRckdERXZPQSt0YXE4?=
 =?utf-8?B?aWlnSXQzVk5ySkxpSnk3UzFCbnpTWjJUVjVhd1krWCtIdFNyVy9LY2dackU1?=
 =?utf-8?B?ejJpdUJyem5HREF3YjY4dmhxTm10Z0dJdzBZTTN5bnR4Q012OXZFNWVmdXE0?=
 =?utf-8?B?ZldMTG9URm9hWStVWk5ycXVDSW1hTTl5QzlvUnR5V3o1VEg2OThzckw2UEI3?=
 =?utf-8?B?SXArQWJpb0lkeHFSSXBaekhXSGxwSGN1bDhpSFlQNkdTQ3ZQMXFLVnF2VlVS?=
 =?utf-8?B?aFhDb3p0N2Jic242OGtvRDg0dDlsbTM5WTVmRHZrRDlXeTVjWWtPWm5kU25j?=
 =?utf-8?B?SXJxN1NDenkzZE1rQVRuOUZOcUxCbzhReVJXWG1LbEh2ZnludFpwa3ZRRGY4?=
 =?utf-8?B?Ym1XOTZmNmFzRHdRUUdVU0pmd1FUUTc4SVAwNktzODIxMVRQSi9lYkdpakhD?=
 =?utf-8?B?TEN5bG5IYVkrRGxGS3d2NFg2dzRmTTN0Vk8xQytSWElkOGkxZnhDNDJaRDhD?=
 =?utf-8?B?a05LT2gzRk1MKzU4YmdxM2FicjhHYWlHOEdISTZoa2sxNEhSRkM0NS9STUpK?=
 =?utf-8?B?b3BvbC95bVExQmpGTWNUeDczK1hVZkNSQWwxSS9KVGY3VklIWUhLK1pMbXlt?=
 =?utf-8?B?QnNXMndsclYwZGFQZWNmd2VlZ1htKzlXUzB1alNGN0pRTmtISEI0RGpvamJh?=
 =?utf-8?Q?NC4171+1HD5+K/BODt56oBA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f795833b-346d-40bd-c33e-08db40acb04e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 08:04:24.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zerJO0kGKZeAP9axrPfm+cFJlcYhEPEYdYfT2h00zw8Rxyhh/xZVhUXIZMzKcjmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7387
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/19 07:55, David Sterba wrote:
> On Mon, Apr 17, 2023 at 05:48:10PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that "btrfs inspect logical-resolve" can not even
>> handle any file inside non-top-level subvolumes:
>>
>>   # mkfs.btrfs $dev
>>   # mount $dev $mnt
>>   # btrfs subvol create $mnt/subv1
>>   # xfs_io -f -c "pwrite 0 16k" $mnt/subv1/file
>>   # sync
>>   # btrfs inspect logical-resolve 13631488 $mnt
>>   inode 257 subvol subv1 could not be accessed: not mounted
>>
>> This means the command "btrfs inspect logical-resolve" is almost useless
>> for resolving logical bytenr to files.
>>
>> [CAUSE]
>> "btrfs inspect logical-resolve" firstly resolve the logical bytenr to
>> root/ino pairs, then call btrfs_subvolid_resolve() to resolve the path
>> to the subvolume.
>>
>> Then to handle cases where the subvolume is already mounted somewhere
>> else, we call find_mount_fsroot().
>>
>> But if that target subvolume is not yet mounted, we just error out, even
>> if the @path is the top-level subvolume, and we have already know the
>> path to the subvolume.
>>
>> [FIX]
>> Instead of doing unnecessary subvolume mount point check, just require
>> the @path to be the mount point of the top-level subvolume.
> 
> This is a change in the semantics of the command, can't we make it work
> on non-toplevel subvolumes instead? Access to the mounted toplevel
> subvolume is not always provided, e.g. on openSUSE the subvolume layout
> does not mount 5 and there are likely other distros following that
> scheme.

But mounting 5 is not that hard if one is trying to locate the offending 
file.

The original semantics is almost impossible to make real usage, just 
check this mail:

https://lore.kernel.org/linux-btrfs/CAL5DHTFAUCKBmW_j737j8dzRvaBnKWa9Wo5VtvoAgW8f93oR9A@mail.gmail.com/

Doing a mount point search for the subvolume is fine, but requiring each 
subvolume to be mounted while top level subvolume is already mounted is 
not user friendly at all.

Thanks,
Qu
