Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925573FEC52
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbhIBKmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 06:42:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbhIBKmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 06:42:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03BB020336;
        Thu,  2 Sep 2021 10:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630579299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/RxxfX2UWcG29FpzL5o7jJYZaFHu8UM+5EeNEZqaQo=;
        b=elV1LXRkjVf9JBCXkZWiIhSExLWF7f2kP8YIdu1AGi09Snwmbs6n6G0Dgoo8LDY39ucKp0
        eIlQsIsAXdSGuqLGOMWc3r8M9xNaWwUP9NoYSB3zeLHe3iKncRKaWNzR/Tvf1Q44LzU3Hx
        yUY6fME4NlAdo1O9xl+/QjmPq/2fyTQ=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D2D4513424;
        Thu,  2 Sep 2021 10:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cAMMMWKqMGGXaQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 10:41:38 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7c4ecbc6-41a7-5375-42cc-9bf87ff35507@suse.com>
Date:   Thu, 2 Sep 2021 13:41:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 13:27, Qu Wenruo wrote:
> 
> 
> On 2021/9/2 下午6:06, Nikolay Borisov wrote:
>> Currently when a device is missing for a mounted filesystem the output
>> that is produced is unhelpful:
>>
>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>     Total devices 2 FS bytes used 128.00KiB
>>     devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>     *** Some devices missing
>>
>> While the context which prints this is perfectly capable of showing
>> which device exactly is missing, like so:
>>
>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>     Total devices 2 FS bytes used 128.00KiB
>>     devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>     devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>>
>> This is a lot more usable output as it presents the user with the id
>> of the missing device and its path.
> 
> The idea is pretty awesome.
> 
> Just one question, if one device is missing, how could we know its path?
> Thus does the device path output make any sense?

The path is not canonicalized but otherwise the paths comes from
btrfs_ioctl_dev_info_args which is filled by a call to get_fs_info where
we call get_device_info for every device in the fs_info.

So the path is really dev->name from kernel space or if we don't have a
dev->name it will be 0. In either case it's useful that we get the devid
so that the user can do :

btrfs device remove 2 (if we take the above example), alternatively the
path would be a NULL-terminated string which aka empty. I guess that's
still better than simply saying *some devices are missing*

> 
> Thanks,
> Qu
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>   cmds/filesystem.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index db8433ba3542..ff13de6ac990 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -295,7 +295,6 @@ static int print_one_fs(struct
>> btrfs_ioctl_fs_info_args *fs_info,
>>   {
>>       int i;
>>       int fd;
>> -    int missing = 0;
>>       char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>>       struct btrfs_ioctl_dev_info_args *tmp_dev_info;
>>       int ret;
>> @@ -325,8 +324,10 @@ static int print_one_fs(struct
>> btrfs_ioctl_fs_info_args *fs_info,
>>           /* Add check for missing devices even mounted */
>>           fd = open((char *)tmp_dev_info->path, O_RDONLY);
>>           if (fd < 0) {
>> -            missing = 1;
>> +            printf("\tdevid %4llu size 0 used 0 path %s
>> ***MISSING***\n",
>> +                    tmp_dev_info->devid,tmp_dev_info->path);
>>               continue;
>> +
>>           }
>>           close(fd);
>>           canonical_path = path_canonicalize((char *)tmp_dev_info->path);
>> @@ -339,8 +340,6 @@ static int print_one_fs(struct
>> btrfs_ioctl_fs_info_args *fs_info,
>>           free(canonical_path);
>>       }
>>
>> -    if (missing)
>> -        printf("\t*** Some devices missing\n");
>>       printf("\n");
>>       return 0;
>>   }
>>
> 
