Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78463C9F26
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 15:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhGONOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGONOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 09:14:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB9C06175F;
        Thu, 15 Jul 2021 06:11:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k20so6218325pgg.7;
        Thu, 15 Jul 2021 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mqqUIT6Gur6oNcZJ1XWtXgF8bqDE8LVYz2m/jR4Qhac=;
        b=mUHJFEeJ3iQSW5S3TDxP9BkECwt2+W+N5dt+izcX3VUjbVrJ3x9/fUwhP2HKX28trs
         +ymMx4/kdKhVdVxycOcUNHdAo7tbqjFKM9pCPjUe8YAf99vNkB9V8P3itd2ZF23JQxW0
         y3roMNVxfukO9SYMTNK7YB42aSb8HfMK0r4bObZ5zseJLKQrQpxeEak4EgG7QX2W12r1
         xxGmz0MXGhizFsxuxl7nMPfbYM3HzLYJiaJJ/zWH6I8ajQJonDpKgdZSyNtz7hvEUBfA
         LXqe4Z40gC64vCsG8LxrsGBh+y+VRO3KLp8S5PGzJZtcdAY2JdeeOa+kzR0ugqo8B4q/
         2uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqqUIT6Gur6oNcZJ1XWtXgF8bqDE8LVYz2m/jR4Qhac=;
        b=EC5Eq2xz6oU6HTnGK6XP6TajS4jS9Nv8wqMCj2aYWfTgTNnpBERvWDguNLfXjOF7TE
         zTscJEnByHGZOZfNFGQmEOfA1ZOy7OqzI5WH5Gld6XoNixwM0LG1zAvOG4s9OZWl/uSR
         UdRDGF3FJC+mxm5KeBFlY+sqB2LeqXq3XYh+JTPp6Dan4ppKkrGccGDANXoFlJHjzJdV
         0AlWFXSh9Py7k4Y5+cgGa9AAuUZh906e0zeB+evD+nxAWfv38m8Pa2YOI1dAYthH229E
         grw2AsY77eBrt2TmduQuCmfq7oRHIc3u6/h7NIMDxRKl/CtBZHpIU4rbkJqTBKEkKx1n
         SuZA==
X-Gm-Message-State: AOAM530sMGGJSCfeXQ5MqQQQPVRjhzzvpCsj+Yesn7ih+TF3Qmr2W5Lz
        r/ymxG6JQEv5SyOEhkyTqY0=
X-Google-Smtp-Source: ABdhPJzbQGwkKOCn3t2H9yhy5Rmtec/AnidC+GrfO1rZ7k/p/VcG736AZ8d3sHAOXDTLXUm8+XsSXg==
X-Received: by 2002:a05:6a00:1411:b029:302:d9d6:651d with SMTP id l17-20020a056a001411b0290302d9d6651dmr4618169pfu.56.1626354707982;
        Thu, 15 Jul 2021 06:11:47 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id m34sm7528228pgb.85.2021.07.15.06.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:11:47 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     anand.jain@oracle.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
 <7ae7a858-9893-c41c-ed96-10651c295087@suse.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <b8fe8fa5-c022-187f-b10d-3f73e668008a@gmail.com>
Date:   Thu, 15 Jul 2021 21:11:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7ae7a858-9893-c41c-ed96-10651c295087@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/7/21 7:55 pm, Nikolay Borisov wrote:
> 
> 
> On 15.07.21 г. 13:34, Desmond Cheong Zhi Xi wrote:
>> Syzbot reports a warning in close_fs_devices that happens because
>> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
>> on each device.
>>
>> This happens when a writeable device is removed in
>> __btrfs_free_extra_devids, but the rw device count is not decremented
>> accordingly. So when close_fs_devices is called, the removed device is
>> still counted and we get an off by 1 error.
>>
>> Here is one call trace that was observed:
>>    btrfs_mount_root():
>>      btrfs_scan_one_device():
>>        device_list_add();   <---------------- device added
>>      btrfs_open_devices():
>>        open_fs_devices():
>>          btrfs_open_one_device();   <-------- rw device count ++
>>      btrfs_fill_super():
>>        open_ctree():
>>          btrfs_free_extra_devids():
>> 	  __btrfs_free_extra_devids();  <--- device removed
>> 	  fail_tree_roots:
>> 	    btrfs_close_devices():
>> 	      close_fs_devices();   <------- rw device count off by 1
>>
>> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
>> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
>> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> 
> Is there a reliable reproducer from syzbot? Can this be turned into an
> xfstest?
> 

Syzbot has some reliable reproducers here:
https://syzkaller.appspot.com/bug?id=113d9a01cbe0af3e291633ba7a7a3e983b86c3c0

Seems like it constructs two images in-memory then mounts them. I'm not 
sure if that's amenable to be converted into an xfstest?

>> ---
>>   fs/btrfs/volumes.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 807502cd6510..916c25371658 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>   			list_del_init(&device->dev_alloc_list);
>>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>> +			fs_devices->rw_devices--;
>>   		}
>>   		list_del_init(&device->dev_list);
>>   		fs_devices->num_devices--;
>>

