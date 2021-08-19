Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9993F1ECC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhHSRMl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 13:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhHSRMk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 13:12:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AFC061575;
        Thu, 19 Aug 2021 10:12:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y190so6104459pfg.7;
        Thu, 19 Aug 2021 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yj/zQz+GWdOl4eJGN6c1sJ4eL77VG5kYhaSr24Ls5eU=;
        b=NX9pUmbOVVkAfmBezxi3gVrTJYoaISXMHlvX0dbJLqKpV5kxenLG9gZON1rOp1hR3G
         NDgcKM5hukPVKrmlAoTwv8o+OxcZb7jEuAXqaYuXSvq8kZC4PCpGtTu6/SYwfl//bKTj
         lfInPLsLf3g9OfRfJZY/+WYPq4xHZb5uUx0c3yHS078eUT0bPCtPfyECUzmKoPsNuuoB
         zxsQG7B1gLYjOHJS9iPC9+LRwGI4XTG/KbSkS7y/XtPkAcwf5Eennj4qbzeove/GU9BP
         q+CaA3Lq26NgKGtSjyD81KVXiFEoeOi1iWikYJM5l5nsBRAxqhwnE7B/1ExGT8Jywf6G
         DhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yj/zQz+GWdOl4eJGN6c1sJ4eL77VG5kYhaSr24Ls5eU=;
        b=MkV8kdgMkro1jYACqkQGiSb807f2N6q2SAJq88rMdP/v3aAbeXodCyVw1l/hlvAYZi
         UiJqhsmtZasPSZsOnRJvftep3gGBWN4clteI+oIhbPk9Ymp1dEvyc5HXzrj6kI+m4vCZ
         qAAmqjWI4w+OXRYVhVBtG2eNuN7cNl78V1wK6QmOD+i3WIvmNGO2I1Q+Q0ImIeirRyx+
         O7PGTgr9Y6bU/eYSjd0YTvyoXCRyjDSkHtDxTPSkbv6s35P5iCGuEfbs9BcJLKjrdszi
         4sRahReJa22twBQ0psEFxqpzoUAgtLqx+C/1dvbXA/swUGnn/8hJKrdaH+B+SuryyzDv
         dyaQ==
X-Gm-Message-State: AOAM5304UELQypdKR7nKJ0bB4ak0i7kXC0Gs6wFrHrc/NuBBdDM+YlWL
        geeAtojnJVR2BQLkpv1SIXI=
X-Google-Smtp-Source: ABdhPJy4YoQhO59xUM8dpISQFnQ3sptOU8FA0Rvl7BaZEextoNx5Yhuae9DA60Wan7EOkL9VsyvgPw==
X-Received: by 2002:a62:6007:0:b029:3cd:e67a:ef9e with SMTP id u7-20020a6260070000b02903cde67aef9emr15879027pfb.72.1629393123587;
        Thu, 19 Aug 2021 10:12:03 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id j23sm9035600pjn.12.2021.08.19.10.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 10:12:02 -0700 (PDT)
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
 <a5690ae1-28ba-a933-6473-e9c1e5480f0c@gmail.com>
 <20210813103032.GR5047@twin.jikos.cz>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <89172356-335f-1ca3-d3a2-78fac7ef93fb@gmail.com>
Date:   Fri, 20 Aug 2021 01:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210813103032.GR5047@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/8/21 6:30 pm, David Sterba wrote:
> On Fri, Aug 13, 2021 at 05:57:26PM +0800, Desmond Cheong Zhi Xi wrote:
>> On 13/8/21 4:51 pm, David Sterba wrote:
>>> On Fri, Aug 13, 2021 at 01:31:25AM +0800, Desmond Cheong Zhi Xi wrote:
>>>> On 12/8/21 11:50 pm, David Sterba wrote:
>>>>> On Thu, Aug 12, 2021 at 11:43:16PM +0800, Desmond Cheong Zhi Xi wrote:
>>>>>> On 12/8/21 6:38 pm, David Sterba wrote:
>>>>>>> On Tue, Jul 27, 2021 at 03:13:03PM +0800, Desmond Cheong Zhi Xi wrote:
>>>>>>>> --- a/fs/btrfs/volumes.c
>>>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>>>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>>>>>>>      		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>>>>>>>      			list_del_init(&device->dev_alloc_list);
>>>>>>>>      			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>>>>>>>> +			fs_devices->rw_devices--;
>>>>>>>>      		}
>>>>>>>>      		list_del_init(&device->dev_list);
>>>>>>>>      		fs_devices->num_devices--;
>>>>>>>
>>>>>>> I've hit a crash on master branch with stacktrace very similar to one
>>>>>>> this bug was supposed to fix. It's a failed assertion on device close.
>>>>>>> This patch was the last one to touch it and it matches some of the
>>>>>>> keywords, namely the BTRFS_DEV_STATE_REPLACE_TGT bit that used to be in
>>>>>>> the original patch but was not reinstated in your fix.
>>>>>>>
>>>>>>> I'm not sure how reproducible it is, right now I have only one instance
>>>>>>> and am hunting another strange problem. They could be related.
>>>>>>>
>>>>>>> assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
>>>>>>>
>>>>>>> https://susepaste.org/view/raw/18223056 full log with other stacktraces,
>>>>>>> possibly relatedg
>>>>>>>
>>>>>>
>>>>>> Looking at the logs, it seems that a dev_replace was started, then
>>>>>> suspended. But it wasn't canceled or resumed before the fs devices were
>>>>>> closed.
>>>>>>
>>>>>> I'll investigate further, just throwing some observations out there.
>>>>>
>>>>> Thanks. I'm testing the patch revert, no crash after first loop, I'll
>>>>> run a few more to be sure as it's not entirely reliable.
>>>>>
>>>>> Sending the revert is option of last resort as we're approaching end of
>>>>> 5.14 dev cycle and the crash prevents testing (unlike the fuzzer
>>>>> warning).
>>>>>
>>>>
>>>> I might be missing something, so any thoughts would be appreciated. But
>>>> I don't think the assertion in btrfs_close_one_device is correct.
>>>>
>>>>    From what I see, this crash happens when close_ctree is called while a
>>>> dev_replace hasn't completed. In close_ctree, we suspend the
>>>> dev_replace, but keep the replace target around so that we can resume
>>>> the dev_replace procedure when we mount the root again. This is the call
>>>> trace:
>>>>
>>>>      close_ctree():
>>>>        btrfs_dev_replace_suspend_for_unmount();
>>>>        btrfs_close_devices():
>>>>          btrfs_close_fs_devices():
>>>>            btrfs_close_one_device():
>>>>              ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
>>>> &device->dev_state));
>>>>
>>>> However, since the replace target sticks around, there is a device with
>>>> BTRFS_DEV_STATE_REPLACE_TGT set, and we fail the assertion in
>>>> btrfs_close_one_device.
>>>>
>>>> Two options I can think of:
>>>>
>>>> - We could remove the assertion.
>>>>
>>>> - Or we could clear the BTRFS_DEV_STATE_REPLACE_TGT bit in
>>>> btrfs_dev_replace_suspend_for_unmount. This is fine since the bit is set
>>>> again in btrfs_init_dev_replace if the dev_replace->replace_state is
>>>> BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED. But this approach strikes me as
>>>> a little odd because the device is still the replace target when
>>>> mounting in the future.
>>>
>>> The option #2 does not sound safe because the TGT bit is checked in
>>> several places where device list is queried for various reasons, even
>>> without a mounted filesystem.
>>>
>>> Removing the assertion makes more sense but I'm still not convinced that
>>> the this is expected/allowed state of a closed device.
>>>
>>
>> Would it be better if we cleared the REPLACE_TGT bit only when closing
>> the device where device->devid == BTRFS_DEV_REPLACE_DEVID?
>>
>> The first conditional in btrfs_close_one_device assumes that we can come
>> across such a device. If we come across it, we should properly reset it.
>>
>> If other devices has this bit set, the ASSERT will still catch it and
>> let us know something is wrong.
> 
> That sounds great.
> 
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 70f94b75f25a..a5afebb78ecf 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>                   fs_devices->rw_devices--;
>>           }
>>    
>> +       if (device->devid == BTRFS_DEV_REPLACE_DEVID)
>> +               clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>> +
>>           if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>                   fs_devices->missing_devices--;
> 
> I'll do a few test rounds, thanks.
> 

Hi David,

Just following up. Did that resolve the issue or is further 
investigation needed?
