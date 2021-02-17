Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779431DBD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 16:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhBQPAT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhBQPAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 10:00:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:59:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w20so9702611qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8TDfInY9iMJPA1mBmuRqRYbNcjELuWMZ7daHR0uv7/M=;
        b=JqryR0i6SPSszmGGLWUj7V0MiBx2lA4DMn4MtMs9q0ikJneGKzb95yCXPlj7lj+sNf
         6zfFHIvp1TiEpDs4ENPslHgGPcS5VzRCUUVT7HuCMKPyRZKo8lsd0vvLf/8u+HzLiSs4
         ZPwlcXSxFvjI3eezwKl8/o5SQuyJKOZjjrm7JlFrRf0nGD4NpZKTIJ2vMQPNO2h1lKDf
         onUFn8/qwzHYriuhuypKLqPtf5c0l7X3kKlV2QfO2Jkoxvs9GRCrugGiaZGQFQ2USH2F
         cqAwv4/jXcjgFmtTLVi8tsaj5tGN9zgy641CxFXuk779DQATpPdbyrlIpHS063VOecWk
         D5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8TDfInY9iMJPA1mBmuRqRYbNcjELuWMZ7daHR0uv7/M=;
        b=AqBrX76YO4bLndT3R7YXVvHVS/dnMh1XDzYc39+8wuz3UHzMA5UPpGOYTAq1XIn64r
         bBN8eZOHBlU9jSpz18a+ZfZdSp08izbgif8wZLTsTFUc4kd09APjnY5AL9FYjsIguDRl
         rZAzJ5wuG3TQuQypoSFKd40hDHg0TdKR3UvXXhd/p8UHrxQwZyiu7ywaL0Ier3pzl4g/
         kj1lg56t1IlxkZHcVW3F+zfQyQp/n0oscGd2bNNum97DIqRgsQmxCrZolgSnxe4+k24N
         LTmVV+ljY4y3gNYgnMeqP4G2zZTbXR2Mr1ZW0eObxoBnEr9bU477DhYUAR4xT8l3cM3N
         aRuQ==
X-Gm-Message-State: AOAM531W1ligxEqLlQyvDmhN5fhYIRpkOVIyjUk65xyYU2usA+4svpZ/
        dL2ZhejwipMvnoM+++T0m+nKXHldpBBgcR6+
X-Google-Smtp-Source: ABdhPJzM5+aUZ50XXJhRrMqITHFGfAmbGoN9vVgE5rYDL3XzZl8ATBnzbiPmHOLyzHwsdQNIBlMM0w==
X-Received: by 2002:ac8:6d3b:: with SMTP id r27mr23817820qtu.21.1613573966226;
        Wed, 17 Feb 2021 06:59:26 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l7sm1336101qtu.13.2021.02.17.06.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 06:59:25 -0800 (PST)
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
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com>
 <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com>
Date:   Wed, 17 Feb 2021 09:59:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/17/21 9:50 AM, Neal Gompa wrote:
> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/16/21 9:05 PM, Neal Gompa wrote:
>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>
>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>>>>>> Hey all,
>>>>>>>>>
>>>>>>>>> So one of my main computers recently had a disk controller failure
>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>>>>>> journal:
>>>>>>>>>
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>
>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>>>>>> seem to find any reasonably good information on how to do recovery in
>>>>>>>>> this scenario, even to just recover enough to copy data off.
>>>>>>>>>
>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>>>>>> using btrfs-progs v5.10.
>>>>>>>>>
>>>>>>>>> Can anyone help?
>>>>>>>>
>>>>>>>> Can you try
>>>>>>>>
>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>>>>>
>>>>>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>>>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>>>>>> other magic.  Thanks,
>>>>>>>>
>>>>>>>> Josef
>>>>>>>
>>>>>>> I got the same error as I did with btrfs-check --readonly...
>>>>>>>
>>>>>>
>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
>>>>>>
>>>>>
>>>>> No dice...
>>>>>
>>>>> # btrfs check --readonly --backup /dev/sda3
>>>>>> Opening filesystem to check...
>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>
>>>> Hey look the block we're looking for, I wrote you some magic, just pull
>>>>
>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>>>>
>>>> build, and then run
>>>>
>>>> btrfs-neal-magic /dev/sda3 791281664 888895
>>>>
>>>> This will force us to point at the old root with (hopefully) the right bytenr
>>>> and gen, and then hopefully you'll be able to recover from there.  This is kind
>>>> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>>>>
>>>
>>> # btrfs check --readonly /dev/sda3
>>>> Opening filesystem to check...
>>>> ERROR: could not setup extent tree
>>>> ERROR: cannot open file system
>>> # btrfs check --clear-space-cache v1 /dev/sda3
>>>> Opening filesystem to check...
>>>> ERROR: could not setup extent tree
>>>> ERROR: cannot open file system
>>>
>>> It's better, but still no dice... :(
>>>
>>>
>>
>> Hmm it's not telling us what's wrong with the extent tree, which is annoying.
>> Does mount -o rescue=all,ro work now that the root tree is normal?  Thanks,
>>
> 
> Nope, I see this in the journal:
> 
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabling all of the rescue options
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring data csums
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring bad roots
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disabling log replay at mount time
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
> 
> 

Ok git pull for-neal, rebuild, then run

btrfs-neal-magic /dev/sda3 791281664 888895 2

I thought of this yesterday but in my head was like "naaahhhh, whats the chances 
that the level doesn't match??".  Thanks,

Josef
