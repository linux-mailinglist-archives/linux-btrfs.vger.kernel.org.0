Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633FA31DB87
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhBQOhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 09:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhBQOhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 09:37:36 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE489C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:36:56 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d3so9612581qtr.10
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuK0pw/ptbBBppqZJgWKfb9L36RfTR2RXo3P1SwaIr4=;
        b=hnRZveMA+4okdAYyvnfx+9nCc0OPVK3HgXKKjmvSTZ7y22bAmGwrkn5hcYotXuXXsF
         FStBsGh1VJLIM8oJVUIotoNo980JxddX2GljOYoxrY9zvAT8IWLO6i4JuCYK8XawBXIk
         5XmtBWtcqEFqFo2vlJS+wpf+1sU0DueKJzwn2Rc74WvO1zS+zi9Q1nOIrpkuS73H+39T
         Tn4MPca2PupKTtElMchV3wnSaMtLNqguENj/Zxf8h+e3GbS5dguj0vYaJs8SHTAvI5BT
         EsxVHb/9tKT4AZH79a++Fgt2EDIfjGfVejkH0R9CUdjSt18nxDUDRzJviCUJfOlEbx0J
         wsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuK0pw/ptbBBppqZJgWKfb9L36RfTR2RXo3P1SwaIr4=;
        b=beQqxbMDNAMkS96xedauk+ADvt9nwq7E9BNKiFoniQw5L8kFjV6fCgnk/aTtgG8U6p
         5xbrVjPVpdEK4Zbu8y28kgNXGSsN0zcEE5moaYD0LxQVparI9u42OEGznQZMoZtlt3jv
         HGBYwRF1agvgMHlpHa+3w/QpGn6LOKJ7yQe18Ps3sjPrCkVXf0UglT/WYAEEElQLRtZT
         70DTSxMz7MvC3s8UcwF6MorCvbLRnaS0BeijjgWaMZ5f8Zrj4eLBlmwb3sPGI7dLylS+
         sL9WISPUfxA96t0DPWbtsLUPpUH8zDrU6qSvR/39Hpo8WA110dYtDbimV9VrVBLBGX+r
         N4Xg==
X-Gm-Message-State: AOAM530AUQxsWkP76oXw2nJ2zwh5z5xqQxBJfz1z0iTo2riSsBRChPwa
        92+6i4q6Tu2cNkQh5oqDDEHurpTFvQhEE4aX
X-Google-Smtp-Source: ABdhPJztqDQ9seHZOkBP0pspRKHzbmfda+rgZRamd3XnvFCbKF3F9pCGhxIKCBl5vqA53JZlciN7Pw==
X-Received: by 2002:ac8:6915:: with SMTP id e21mr17311941qtr.120.1613572615000;
        Wed, 17 Feb 2021 06:36:55 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r2sm1270997qti.4.2021.02.17.06.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:36:54 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com>
 <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
 <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com>
 <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com>
Date:   Wed, 17 Feb 2021 09:36:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/16/21 9:05 PM, Neal Gompa wrote:
> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/16/21 3:29 PM, Neal Gompa wrote:
>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>>>> Hey all,
>>>>>>>
>>>>>>> So one of my main computers recently had a disk controller failure
>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>>>> journal:
>>>>>>>
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>
>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>>>> seem to find any reasonably good information on how to do recovery in
>>>>>>> this scenario, even to just recover enough to copy data off.
>>>>>>>
>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>>>> using btrfs-progs v5.10.
>>>>>>>
>>>>>>> Can anyone help?
>>>>>>
>>>>>> Can you try
>>>>>>
>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>>>
>>>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>>>> other magic.  Thanks,
>>>>>>
>>>>>> Josef
>>>>>
>>>>> I got the same error as I did with btrfs-check --readonly...
>>>>>
>>>>
>>>> Oh lovely, what does btrfs check --readonly --backup do?
>>>>
>>>
>>> No dice...
>>>
>>> # btrfs check --readonly --backup /dev/sda3
>>>> Opening filesystem to check...
>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>
>> Hey look the block we're looking for, I wrote you some magic, just pull
>>
>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>>
>> build, and then run
>>
>> btrfs-neal-magic /dev/sda3 791281664 888895
>>
>> This will force us to point at the old root with (hopefully) the right bytenr
>> and gen, and then hopefully you'll be able to recover from there.  This is kind
>> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>>
> 
> # btrfs check --readonly /dev/sda3
>> Opening filesystem to check...
>> ERROR: could not setup extent tree
>> ERROR: cannot open file system
> # btrfs check --clear-space-cache v1 /dev/sda3
>> Opening filesystem to check...
>> ERROR: could not setup extent tree
>> ERROR: cannot open file system
> 
> It's better, but still no dice... :(
> 
> 

Hmm it's not telling us what's wrong with the extent tree, which is annoying. 
Does mount -o rescue=all,ro work now that the root tree is normal?  Thanks,

Josef
