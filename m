Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF23F328C
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhHTRyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 13:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhHTRyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 13:54:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D4CC061575;
        Fri, 20 Aug 2021 10:53:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso7813217pjb.1;
        Fri, 20 Aug 2021 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wGEmsQipr5gzuljiPseq2A0Fn1otMeloCg6zZW6nEZM=;
        b=Z7iolNUcZI7SC3hr+wJwvmRBysaz9H/26a5BtromWHnFojn2eMmJX7iO+ARXKVgNRo
         P26oAv6NLCeH2FS7F5rk3ovdhh5nOJbsgoXdt8y0ZwoWM5Z7dS+ObBGpySxUuO9/mPM2
         +kVF4Cd0On7pNvyIv58CBmKNMGvOl2/fypV67NpUYt9p2bvHbAdBb/ypvTs9n2QHozJY
         zXGIZo7Wq082AqdIqvmKIaUEXad6z114VT+WUYOJ7z6SNuDMDz4BbF99h2eFE3IIefyg
         8xfH34vDfYbbeBC3VzQu+pB1x1svtypQql7yl7dvjNC7GCFDTtpyLWo2UA7qHVqZZJSn
         jDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGEmsQipr5gzuljiPseq2A0Fn1otMeloCg6zZW6nEZM=;
        b=DN8IPe1jxibtSw5yzUrH9EkDCMNMVRfley7GSFqXBziyLsCOK6VLRLdTVDmFRSsMol
         U3srrWyXJYMf1UT8Nlx3yLt4DsCgkloG8SMX0mFNJRmPoajGCW9vHUd+JsBPmhXsjKgY
         TC+dri5koXaZmsk87wl+Y1gVWVfnBQ99/NRqaZLVK3iXoZataUflHl11qF7vf0aR8trF
         tgmoRWIpQacLbfLVyFbkyn2z5cVUwdHVZbrXrBdFJDhrnqt7zNLkE5lGn2nCQpFuELVE
         8N69ItkLNFZQ/TSAKxjMyvfpSe8nwV6kPZZq47u7jiSMQb9d5gVZBQCh+ANzbcRxuo43
         af8w==
X-Gm-Message-State: AOAM532ZD+KVbPkdZgPO1nzw6i+KGj90B77gYtwA7XfVZm8unLY+0Huu
        fu/f3wy8Oa4IYx4GarqwpEQ=
X-Google-Smtp-Source: ABdhPJycAHJDcAUXZIxndEcPoSl619LFgLTgEMLLDpnLHIsB4NecSA18q3/B2VgxNkvcnM5UX5E4uQ==
X-Received: by 2002:a17:902:8506:b029:12c:76a8:d1b8 with SMTP id bj6-20020a1709028506b029012c76a8d1b8mr17413188plb.14.1629482032699;
        Fri, 20 Aug 2021 10:53:52 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id m2sm8883434pgu.15.2021.08.20.10.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:53:52 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, anand.jain@oracle.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210812103851.GC5047@twin.jikos.cz>
 <3c48eec9-590c-4974-4026-f74cafa5ac48@gmail.com>
 <20210812155032.GL5047@twin.jikos.cz>
 <1e0aafb2-9e55-5f64-d347-1765de0560c5@gmail.com>
 <20210813085137.GQ5047@twin.jikos.cz>
 <a5690ae1-28ba-a933-6473-e9c1e5480f0c@gmail.com>
 <20210813103032.GR5047@twin.jikos.cz>
 <89172356-335f-1ca3-d3a2-78fac7ef93fb@gmail.com>
 <20210819173403.GI5047@twin.jikos.cz>
 <e9c5bb00-b609-aff9-fc95-ca1c5b9c2899@gmail.com>
 <20210820105828.GN5047@twin.jikos.cz>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <e1bce692-b233-2d74-f366-dc0ec43ead84@gmail.com>
Date:   Sat, 21 Aug 2021 01:53:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820105828.GN5047@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/8/21 6:58 pm, David Sterba wrote:
> On Fri, Aug 20, 2021 at 11:09:05AM +0800, Desmond Cheong Zhi Xi wrote:
>> On 20/8/21 1:34 am, David Sterba wrote:
>>> On Fri, Aug 20, 2021 at 01:11:58AM +0800, Desmond Cheong Zhi Xi wrote:
>>>>>>> The option #2 does not sound safe because the TGT bit is checked in
>>>>>>> several places where device list is queried for various reasons, even
>>>>>>> without a mounted filesystem.
>>>>>>>
>>>>>>> Removing the assertion makes more sense but I'm still not convinced that
>>>>>>> the this is expected/allowed state of a closed device.
>>>>>>>
>>>>>>
>>>>>> Would it be better if we cleared the REPLACE_TGT bit only when closing
>>>>>> the device where device->devid == BTRFS_DEV_REPLACE_DEVID?
>>>>>>
>>>>>> The first conditional in btrfs_close_one_device assumes that we can come
>>>>>> across such a device. If we come across it, we should properly reset it.
>>>>>>
>>>>>> If other devices has this bit set, the ASSERT will still catch it and
>>>>>> let us know something is wrong.
>>>>>
>>>>> That sounds great.
>>>>>
>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>> index 70f94b75f25a..a5afebb78ecf 100644
>>>>>> --- a/fs/btrfs/volumes.c
>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>> @@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>>>>>                     fs_devices->rw_devices--;
>>>>>>             }
>>>>>>      
>>>>>> +       if (device->devid == BTRFS_DEV_REPLACE_DEVID)
>>>>>> +               clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>>>>>> +
>>>>>>             if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>>>>>                     fs_devices->missing_devices--;
>>>>>
>>>>> I'll do a few test rounds, thanks.
>>>>
>>>> Just following up. Did that resolve the issue or is further
>>>> investigation needed?
>>>
>>> The fix seems to work, I haven't seen the assertion fail anymore,
>>> incidentally the crash also stopped to show up on an unpatched branch.
>>>
>>
>> Sounds good, thanks for the update. If there's anything else I can help
>> with, please let me know.
> 
> So are you going to send the patch with the fix?
> 

Right, just sent. For some reason I thought it was already patched.
