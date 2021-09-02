Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA63FEC8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhIBLAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 07:00:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhIBLAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 07:00:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C89812033D;
        Thu,  2 Sep 2021 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630580395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Voq13bJjsgpeJ0SdR+yVZ2rarCXf0+o1wYiEQ+7t6a8=;
        b=JU2tkDjUucwxUT/bdXmQevWoytKiM9YroeFn9h8uPhUweAx3qsGGXpzXGIASLEx24ODvas
        FPunKcKyxDiFaz4ndewZ1DxLewPWaYeQtxXRWWnPGQn+khZKIUcsRbp4MRxscZ/vD5H7lW
        uB9gPVqzG9cNdQVJgU11n4qNzItvxfI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A17B413424;
        Thu,  2 Sep 2021 10:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cVLdJKuuMGHdbQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 10:59:55 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
 <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
 <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4da2f41d-c1e0-1da9-e4c9-bfe87067a6af@suse.com>
Date:   Thu, 2 Sep 2021 13:59:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5030bc35-fdda-b297-94e4-d484f8aee444@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 13:46, Qu Wenruo wrote:
> 
> 
> On 2021/9/2 下午6:41, Nikolay Borisov wrote:
>>
>>
>> On 2.09.21 г. 13:27, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/9/2 下午6:06, Nikolay Borisov wrote:
>>>> Currently when a device is missing for a mounted filesystem the output
>>>> that is produced is unhelpful:
>>>>
>>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>>      Total devices 2 FS bytes used 128.00KiB
>>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>      *** Some devices missing
>>>>
>>>> While the context which prints this is perfectly capable of showing
>>>> which device exactly is missing, like so:
>>>>
>>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>>      Total devices 2 FS bytes used 128.00KiB
>>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>>      devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>>>>
>>>> This is a lot more usable output as it presents the user with the id
>>>> of the missing device and its path.
>>>
>>> The idea is pretty awesome.
>>>
>>> Just one question, if one device is missing, how could we know its path?
>>> Thus does the device path output make any sense?
>>
>> The path is not canonicalized but otherwise the paths comes from
>> btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info where
>> we call get_device_info for every device in the fs_info.
>>
>> So the path is really dev->name from kernel space or if we don't have a
>> dev->name it will be 0. In either case it's useful that we get the devid
>> so that the user can do :
>>
>> btrfs device remove 2 (if we take the above example), alternatively the
>> path would be a NULL-terminated string which aka empty. I guess that's
>> still better than simply saying *some devices are missing*
> 
> Definitely the devid output is way better than the existing output.
> 
> I just wonder can we skip the path completely since it's missing (and
> under most case its NULL anyway).
> 
> Despite that, I'm completely fine with the patch.

As you can see form the test I have added this was tested rather
synthetically by simply moving a loop device, in this case the device's
record was still in the fs_devices and had the name, though the name
itself couldn't be acted on. So omitting the path entirely is definitely
something we could do, but I'd rather try and be a bit cleverer, simply
checking if the name is null or not and if not just print it?

> 
> Thanks,
> Qu
> 
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>>> ---
>>>>    cmds/filesystem.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>>>> index db8433ba3542..ff13de6ac990 100644
>>>> --- a/cmds/filesystem.c
>>>> +++ b/cmds/filesystem.c
>>>> @@ -295,7 +295,6 @@ static int print_one_fs(struct
>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>    {
>>>>        int i;
>>>>        int fd;
>>>> -    int missing = 0;
>>>>        char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>>>>        struct btrfs_ioctl_dev_info_args *tmp_dev_info;
>>>>        int ret;
>>>> @@ -325,8 +324,10 @@ static int print_one_fs(struct
>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>            /* Add check for missing devices even mounted */
>>>>            fd = open((char *)tmp_dev_info->path, O_RDONLY);
>>>>            if (fd < 0) {
>>>> -            missing = 1;
>>>> +            printf("\tdevid %4llu size 0 used 0 path %s
>>>> ***MISSING***\n",
>>>> +                    tmp_dev_info->devid,tmp_dev_info->path);
>>>>                continue;
>>>> +
>>>>            }
>>>>            close(fd);
>>>>            canonical_path = path_canonicalize((char
>>>> *)tmp_dev_info->path);
>>>> @@ -339,8 +340,6 @@ static int print_one_fs(struct
>>>> btrfs_ioctl_fs_info_args *fs_info,
>>>>            free(canonical_path);
>>>>        }
>>>>
>>>> -    if (missing)
>>>> -        printf("\t*** Some devices missing\n");
>>>>        printf("\n");
>>>>        return 0;
>>>>    }
>>>>
>>>
> 
