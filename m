Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207763EB3B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhHMJ6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Aug 2021 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhHMJ56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Aug 2021 05:57:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47DC0617AE;
        Fri, 13 Aug 2021 02:57:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso915346pjh.5;
        Fri, 13 Aug 2021 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9xa/or2zxfta9oIL9kxRKvoHo2J2T3dhJfuhqbaXIeo=;
        b=TnRnbwEDqi2Z7C11syAIEg2i18vdZU6bq60UAK6ruk07i6PR8MZzRObxH3GvEp6D0d
         PDaxSLu0CJHNjdw90AnYSyv/wthRIb4yULF5a9AMn6pE8v+2xhOU4NExcZVdaXWPs911
         fdaoMX8dGkf+bdMrtIyTShDKpkUA8q3Wn7bFsbnOTw1An/GwNTE3728ODs7ojmBiK1te
         8Hf8Ud8VnQNh1LnqH7yBrKegx+qrKWbrVHf2lZZhvVMtiWp9a79hAxbxkdUtQ4aqpAZi
         0dN733nLYoTqVbUVhCL1vsod038817+SVFeqF80C1yO6Zoy2VPtOPVadlADdqYx+VPbh
         6FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9xa/or2zxfta9oIL9kxRKvoHo2J2T3dhJfuhqbaXIeo=;
        b=GCsyddfoFMUTt83VhvdiUqLKnnXDgGZxnx5rqNgSmOO9lyTuuH0+VtNp0mrXDKk+ZI
         vBFnh+Dp2Tztn+zIkJmX89jvBYCJ+o4yQKrocrKASxf17FOZnFDek63WSRN/9bPIc++L
         VtiQCvyCUfozLDbkMOoce4CVnpTHFXWsoo61p3MukT+86GyDOsLcGGcSSwD1zfQvLb4q
         TVK2q+afejmK2GBXdr3Cy25s9nWgv64tzAvUB9NjfHHkV71JWbPUDZZsVYqAqxqtfUqP
         gTYjZzBtDbRU73UGZ66gfAZCkp+ILUKbm1v5Vn0xMkcALEB3yN/WbfOkqBng8/drRg9O
         JZBg==
X-Gm-Message-State: AOAM532/tEVe9Q/bJ6a5lShApDEX8WGSdSYIAdCURanoJjTmS5d6uIqt
        gFU3WVharIRvybaEiaBaqXY=
X-Google-Smtp-Source: ABdhPJzKdbgaBb4P2cq2gHPEJDTB6yvGo84XdpAE/xhurXpQVdOord4XeZd1DoDZUFDmq96kkg5knQ==
X-Received: by 2002:a17:903:1d1:b029:12d:55d4:5ef7 with SMTP id e17-20020a17090301d1b029012d55d45ef7mr1452552plh.76.1628848650362;
        Fri, 13 Aug 2021 02:57:30 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id n32sm2022806pgl.69.2021.08.13.02.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:57:29 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210727071303.113876-1-desmondcheongzx@gmail.com>
 <20210812103851.GC5047@twin.jikos.cz>
 <3c48eec9-590c-4974-4026-f74cafa5ac48@gmail.com>
 <20210812155032.GL5047@twin.jikos.cz>
 <1e0aafb2-9e55-5f64-d347-1765de0560c5@gmail.com>
 <20210813085137.GQ5047@twin.jikos.cz>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <a5690ae1-28ba-a933-6473-e9c1e5480f0c@gmail.com>
Date:   Fri, 13 Aug 2021 17:57:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210813085137.GQ5047@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/8/21 4:51 pm, David Sterba wrote:
> On Fri, Aug 13, 2021 at 01:31:25AM +0800, Desmond Cheong Zhi Xi wrote:
>> On 12/8/21 11:50 pm, David Sterba wrote:
>>> On Thu, Aug 12, 2021 at 11:43:16PM +0800, Desmond Cheong Zhi Xi wrote:
>>>> On 12/8/21 6:38 pm, David Sterba wrote:
>>>>> On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
>>>>>> --- a/fs/btrfs/volumes.c
>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>>>>>     		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>>>>>     			list_del_init(&device->dev_alloc_list);
>>>>>>     			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>>>>>> +			fs_devices->rw_devices--;
>>>>>>     		}
>>>>>>     		list_del_init(&device->dev_list);
>>>>>>     		fs_devices->num_devices--;
>>>>>
>>>>> I've hit a crash on master branch with stacktrace very similar to one
>>>>> this bug was supposed to fix. It's a failed assertion on device close.
>>>>> This patch was the last one to touch it and it matches some of the
>>>>> keywords, namely the BTRFS_DEV_STATE_REPLACE_TGT bit that used to be in
>>>>> the original patch but was not reinstated in your fix.
>>>>>
>>>>> I'm not sure how reproducible it is, right now I have only one instance
>>>>> and am hunting another strange problem. They could be related.
>>>>>
>>>>> assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
>>>>>
>>>>> https://susepaste.org/view/raw/18223056 full log with other stacktraces,
>>>>> possibly relatedg
>>>>>
>>>>
>>>> Looking at the logs, it seems that a dev_replace was started, then
>>>> suspended. But it wasn't canceled or resumed before the fs devices were
>>>> closed.
>>>>
>>>> I'll investigate further, just throwing some observations out there.
>>>
>>> Thanks. I'm testing the patch revert, no crash after first loop, I'll
>>> run a few more to be sure as it's not entirely reliable.
>>>
>>> Sending the revert is option of last resort as we're approaching end of
>>> 5.14 dev cycle and the crash prevents testing (unlike the fuzzer
>>> warning).
>>>
>>
>> I might be missing something, so any thoughts would be appreciated. But
>> I don't think the assertion in btrfs_close_one_device is correct.
>>
>>   From what I see, this crash happens when close_ctree is called while a
>> dev_replace hasn't completed. In close_ctree, we suspend the
>> dev_replace, but keep the replace target around so that we can resume
>> the dev_replace procedure when we mount the root again. This is the call
>> trace:
>>
>>     close_ctree():
>>       btrfs_dev_replace_suspend_for_unmount();
>>       btrfs_close_devices():
>>         btrfs_close_fs_devices():
>>           btrfs_close_one_device():
>>             ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
>> &device->dev_state));
>>
>> However, since the replace target sticks around, there is a device with
>> BTRFS_DEV_STATE_REPLACE_TGT set, and we fail the assertion in
>> btrfs_close_one_device.
>>
>> Two options I can think of:
>>
>> - We could remove the assertion.
>>
>> - Or we could clear the BTRFS_DEV_STATE_REPLACE_TGT bit in
>> btrfs_dev_replace_suspend_for_unmount. This is fine since the bit is set
>> again in btrfs_init_dev_replace if the dev_replace->replace_state is
>> BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED. But this approach strikes me as
>> a little odd because the device is still the replace target when
>> mounting in the future.
> 
> The option #2 does not sound safe because the TGT bit is checked in
> several places where device list is queried for various reasons, even
> without a mounted filesystem.
> 
> Removing the assertion makes more sense but I'm still not convinced that
> the this is expected/allowed state of a closed device.
> 

Would it be better if we cleared the REPLACE_TGT bit only when closing
the device where device->devid == BTRFS_DEV_REPLACE_DEVID?

The first conditional in btrfs_close_one_device assumes that we can come
across such a device. If we come across it, we should properly reset it.

If other devices has this bit set, the ASSERT will still catch it and
let us know something is wrong.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70f94b75f25a..a5afebb78ecf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
                 fs_devices->rw_devices--;
         }
  
+       if (device->devid == BTRFS_DEV_REPLACE_DEVID)
+               clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
+
         if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
                 fs_devices->missing_devices--;

