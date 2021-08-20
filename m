Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37C83F2528
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhHTDJs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbhHTDJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 23:09:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F72BC061575;
        Thu, 19 Aug 2021 20:09:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c17so7821165pgc.0;
        Thu, 19 Aug 2021 20:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qCF4/seF7RLY1q6lnR93coNbkwtTN6+2XurjY+dQfE4=;
        b=MpVDd8OIwStYu3cwSGBo2H4zWmi0UVtlkW5aK8+VgORn6NI4Jn/bj283M3cOC9nBTL
         Ry0gyxlkP0H+tVd1gsA9ZN2R9UK1OZe6I0XaH470Y2gfrt0V/8CFQK39bgAeVPN3GL16
         OYcGkL9GliahrPQ9w9MdyCdgzEnjoePEJqe1W6kS5zIwsuL5oe1vwXdt4rdPewCHc4//
         Wwurxy18x2zbd+QcUR0iL7UlFiouhCQeMhB3ahGpEGvSFJPr+OgjbcyuWZ/L/ZtzuQ4N
         LNNlOSnnY0P6znJy7gO6AccrReFLTT9hyL1OqEIMh/thTJ+YLuuv7I9axmClvSUq+OmN
         sluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qCF4/seF7RLY1q6lnR93coNbkwtTN6+2XurjY+dQfE4=;
        b=MsSQmDvl6tljcX/KYilDicFVqRVGp/p6+e0gWmfVQDJyIjUh+j92bqBUOnTjG9Rb3W
         PO8jwJIXjVfyCp5rTXDewWf/pb3ynULAQ0TZv9wSwP1b83GyF+eHu0uSYEUPd7/m5fiU
         JseJVx8nkiX6KnVb8CWr26bPiifbqw6bv7rOL1RgHJ+ukqebBN2YPVKdaui7oRvhXHUs
         FEJv/iNP8JpIG4HR07yh4h8EmUmzL+LfqqUnusDXxv+YMqeHCW1EQASuCgpFs6/rUNjS
         TygklrIBjIM//z1aDZ3CiwPddhwUw8Tc7qvqvKVkkkXPe4E8+i1SzouzKd/0HWAOsWqx
         Z4vg==
X-Gm-Message-State: AOAM530OZ7h8SBTNOYrTO+Nps1UnDjtvFxHy1XzuZLRY/jhoLBKXQkVv
        5o7WRM+NYZA5JHWO9xPugLk=
X-Google-Smtp-Source: ABdhPJwWvTRLKgPLJGt0czPA0HrZCZM/JaeHbR+IDCn0cIskZrWmoZRFUVcQBLzAI4OPfbw4Hhi6eQ==
X-Received: by 2002:a62:864b:0:b029:3c7:7197:59fc with SMTP id x72-20020a62864b0000b02903c7719759fcmr17470644pfd.59.1629428950608;
        Thu, 19 Aug 2021 20:09:10 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id f5sm5365847pfe.128.2021.08.19.20.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 20:09:09 -0700 (PDT)
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
 <89172356-335f-1ca3-d3a2-78fac7ef93fb@gmail.com>
 <20210819173403.GI5047@twin.jikos.cz>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <e9c5bb00-b609-aff9-fc95-ca1c5b9c2899@gmail.com>
Date:   Fri, 20 Aug 2021 11:09:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819173403.GI5047@twin.jikos.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/8/21 1:34 am, David Sterba wrote:
> On Fri, Aug 20, 2021 at 01:11:58AM +0800, Desmond Cheong Zhi Xi wrote:
>>>>> The option #2 does not sound safe because the TGT bit is checked in
>>>>> several places where device list is queried for various reasons, even
>>>>> without a mounted filesystem.
>>>>>
>>>>> Removing the assertion makes more sense but I'm still not convinced that
>>>>> the this is expected/allowed state of a closed device.
>>>>>
>>>>
>>>> Would it be better if we cleared the REPLACE_TGT bit only when closing
>>>> the device where device->devid == BTRFS_DEV_REPLACE_DEVID?
>>>>
>>>> The first conditional in btrfs_close_one_device assumes that we can come
>>>> across such a device. If we come across it, we should properly reset it.
>>>>
>>>> If other devices has this bit set, the ASSERT will still catch it and
>>>> let us know something is wrong.
>>>
>>> That sounds great.
>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 70f94b75f25a..a5afebb78ecf 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>>>>                    fs_devices->rw_devices--;
>>>>            }
>>>>     
>>>> +       if (device->devid == BTRFS_DEV_REPLACE_DEVID)
>>>> +               clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
>>>> +
>>>>            if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>>>                    fs_devices->missing_devices--;
>>>
>>> I'll do a few test rounds, thanks.
>>
>> Just following up. Did that resolve the issue or is further
>> investigation needed?
> 
> The fix seems to work, I haven't seen the assertion fail anymore,
> incidentally the crash also stopped to show up on an unpatched branch.
> 

Sounds good, thanks for the update. If there's anything else I can help 
with, please let me know.
