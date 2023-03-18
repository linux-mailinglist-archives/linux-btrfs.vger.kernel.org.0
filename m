Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0927A6BF6BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 01:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCRABG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Mar 2023 20:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCRABF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Mar 2023 20:01:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AFD526
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Mar 2023 17:01:03 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hvb-1qcOZI1eQ3-011hk6; Sat, 18
 Mar 2023 01:01:00 +0100
Message-ID: <93f12c38-719c-ce15-e662-d94dc48b57a1@gmx.com>
Date:   Sat, 18 Mar 2023 08:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] btrfs-progs: sync ioctl from kernel
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1676115988.git.wqu@suse.com>
 <3b6d9333e90103336e49e0b6a52118617928e3e4.1676115988.git.wqu@suse.com>
 <20230316152714.GZ10580@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230316152714.GZ10580@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:23Z1VR52mK3MH9PjKww7VwPBw9FzBKOlWM+vCv+XgXB1FCesAlh
 SYy7VOHPx+jE6YEtO6P6blnIUCtPwi2C7l4Yq3Dv8NeElLoH8ZC6KXRrhoyohcUWhq3I5LI
 ZJVpudTMWo5roOi6Gyf/6wniBnf4Xkqqii/TCLkOLw0Ad7jlbPpBEACT3A/Eft+0nYL2u+u
 RfPTO+mo7PDOFP1otEqsA==
UI-OutboundReport: notjunk:1;M01:P0:q7fQfz/p9dc=;vKSs+56adGJf3SrCRAcfr3rFqMe
 eIdrk5D+ipfetNepIeqPG/GpSk3TeVSmwHiEKphMTsypHF2pit5vfJRK0CiuZazh6d8sEOoXE
 vfmva7Tw5SodMupkg3jF3E26hjn9aOiKBT9tmosWxhekRmdhH79lwkbfrl4kAb2WkGXcLRlpX
 5RLDhGMjvQhmmJlSJ2CYG1xAljzvJS83op27G4DWktkKzvvrtpQ3B42Ch41bSV/ELQrks7XDR
 yCVPf3SoQ3kVIcT7PR2riMHxxNROKwjNQmW3wVzUVQ6cdicTCehMAepnzxun4NDjxVunOsuE7
 Fff8P2Fov+PxQc/O88f24amoxo1zED6IzYBGZlJmei0EmhGtUODIBK2tTaPnkhRZJdT5xk2E8
 06MibVWn14zhoktl+JKyjd31S0XU30unTWW3LZM0nlG8Aybhuu4dQAfMuMjWDE6VRq1xny2YU
 lSZtkGDOA0h4cZFLXiVM5acGVCdUL5RvmGIIaQLL5EB2bSrJivWMtAqF11IKgi/+UHY9sfbQs
 Ux/gX8xl+kTjLeO0npm1s8XxwscBYN3gB9IBNG9sjixXDSYFnPZPWgd+fx3r+baaKlo4Ap5jc
 IfCTCSMjW2B98Lyg28OnR7twLbbPXe6Ri4pw97GM52tkvV2ZS6mPsCdIgfQwc+6ipHtQqWxLj
 oE5Xl/YKf67p6yxIl4173JNPD1NPWT0fBZi9xWX+Za08MQAMsfWNqdW443iPassqYltNnociX
 4vifl1jkhdYjUDefnVYSZ1unxZ8+qERWowbQ0liXFORocPsVUIOcChzwZY8epOF09DZSIx8a/
 jFkQ2EmSA2BSVsU4QvE8/GhpyRpvAzuMCs4Kvu46kFgC1t1DjO8PgkQKFfOPqYxeVVdWvyMj0
 zSCKYSxxqddyA5oUo4xDKfTjkQWWMDfRVpIVKpP/kHlf2cucKPagf61mtyE2XoQAsXKmB617g
 mxdwjjkEXOARTL14fBxtFKJB2W4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/16 23:27, David Sterba wrote:
> On Sat, Feb 11, 2023 at 07:50:31PM +0800, Qu Wenruo wrote:
>> This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   ioctl.h          | 13 ++++++++++++-
>>   libbtrfs/ioctl.h | 13 ++++++++++++-
>>   2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/ioctl.h b/ioctl.h
>> index 1af16db13241..034f38dd702a 100644
>> --- a/ioctl.h
>> +++ b/ioctl.h
>> @@ -214,7 +214,18 @@ struct btrfs_ioctl_dev_info_args {
>>   	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
>>   	__u64 bytes_used;			/* out */
>>   	__u64 total_bytes;			/* out */
>> -	__u64 unused[379];			/* pad to 4k */
>> +	/*
>> +	 * Optional, out.
>> +	 *
>> +	 * Showing the fsid of the device, allowing user space
>> +	 * to check if this device is a seed one.
>> +	 *
>> +	 * Introduced in v6.4, thus user space still needs to
>> +	 * check if kernel changed this value.
>> +	 * Older kernel will not touch the values here.
>> +	 */
>> +	__u8 fsid[BTRFS_UUID_SIZE];
>> +	__u64 unused[377];			/* pad to 4k */
>>   	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>>   };
>>   BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
>> diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
>> index f19695e30a63..0b19efde4915 100644
>> --- a/libbtrfs/ioctl.h
>> +++ b/libbtrfs/ioctl.h
>> @@ -215,7 +215,18 @@ struct btrfs_ioctl_dev_info_args {
>>   	__u8 uuid[BTRFS_UUID_SIZE];		/* in/out */
>>   	__u64 bytes_used;			/* out */
>>   	__u64 total_bytes;			/* out */
>> -	__u64 unused[379];			/* pad to 4k */
>> +	/*
>> +	 * Optional, out.
>> +	 *
>> +	 * Showing the fsid of the device, allowing user space
>> +	 * to check if this device is a seed one.
>> +	 *
>> +	 * Introduced in v6.4, thus user space still needs to
>> +	 * check if kernel changed this value.
>> +	 * Older kernel will not touch the values here.
>> +	 */
>> +	__u8 fsid[BTRFS_UUID_SIZE];
>> +	__u64 unused[377];			/* pad to 4k */
> 
> Please don't change libbtrfs interface, it's supposed to be frozen and
> not changed anymore. The libbtrfsutil/btrfs.h should be changed instead.

Got it, I'll only update this patch to sync the headers for libbtrfsutil 
instead.

Thanks,
Qu
> 
>>   	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
>>   };
>>   BUILD_ASSERT(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
>> -- 
>> 2.39.1
