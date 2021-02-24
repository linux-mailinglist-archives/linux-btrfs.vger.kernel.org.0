Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F63241B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 17:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBXQH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 11:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhBXPox (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 10:44:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40969C06178B
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 07:44:05 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b14so2570326qkk.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 07:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eMqU7IIYkloEtgmXcDaGmHfn9kLpjL0ahpYexdFo0J0=;
        b=JdK8Pg7oRwKoKH8qBUZglWjtSMhVJE6A/O4NO/nAv4CWrqznhzi440phmoAEIjQqIH
         DGhYJOFZtjFyLOm6wLnEkTppwd4lFtxUkRWte0rtQvI8gCaHdVr1p18VkGPfKkXduiVO
         6RqeBezbQWeUejBN3REdQt86Pm1aGmbeY7igBfjzAf42X9TvBkSIizGPc+cbeRpI9waH
         2EUSBoLA6YefyFgj5v3qXJt4dB81LNSpqZC3wHnHJLFCLOhvewgq3lotpcte0HmPqofJ
         jNDQ8mZs64pivFAIjI3qI+QOSzvEucEXr07UqTjD+oeGWzfCocGkf5mo8ZKwfyY+l2AY
         0V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eMqU7IIYkloEtgmXcDaGmHfn9kLpjL0ahpYexdFo0J0=;
        b=bFR8/ngsgnVAB4xuQSLufqBE4cnDhLNF5pwVbUZQaaC0ix8zXywaVvkjTuZYQKBpog
         7rq44uPtg0Hj2Hto5r4CPUqzak79TJR7o4zJRont2Nl0O3kM48zzE99CiIrceTeQxy6L
         Tzi84VtnbjClG6fjVEqrDX5aFzOcsVFEj3QlWuulkV2pCLXOmYFPrRpz/Kg7O+glOtMq
         E9ubxSZXKDi60SV6LJ/gThXPb6kk+Z9QudXHXeVK80CY+9MsNsrhdjbWMomWa2AgUbCh
         AaAc9GxaN7SKmyGXxU+sKADrYWyRe+KRkFs51StF/sKndYZBH2Ock5YkyTPovTpv0wom
         VLsg==
X-Gm-Message-State: AOAM5325AUvBXczGj1/DA/EXnLgpw1QyBZ6dWtr7hHwInvocg8aWIEU2
        KU6k3/RGmydjaiAi5vNghHtCfdUWVd6sFHpz
X-Google-Smtp-Source: ABdhPJwhibuQ84iOae1z1Tz3Cso6VlOUCJdVVrY4CSBlrTUJFXiUeCfHJJL9yL//oQIveR0OQbQB5w==
X-Received: by 2002:a05:620a:a4f:: with SMTP id j15mr30348086qka.419.1614181443815;
        Wed, 24 Feb 2021 07:44:03 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm1425317qto.28.2021.02.24.07.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:44:03 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
 <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com>
 <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com>
 <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com>
 <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com>
 <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com>
 <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com>
 <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com>
Date:   Wed, 24 Feb 2021 10:44:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/24/21 9:23 AM, Neal Gompa wrote:
> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 2/22/21 11:03 PM, Neal Gompa wrote:
>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>
>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>> Hey all,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk controller failure
>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>>>>>>>>>>>>>> journal:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>>>>>>>>>>>>>> seem to find any reasonably good information on how to do recovery in
>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy data off.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Can anyone help?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Can you try
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>>>>>>>>>>>>>> other magic.  Thanks,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Josef
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --readonly...
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> No dice...
>>>>>>>>>>>>>
>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>
>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some magic, just pull
>>>>>>>>>>>>
>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>>>>>>>>>>>>
>>>>>>>>>>>> build, and then run
>>>>>>>>>>>>
>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
>>>>>>>>>>>>
>>>>>>>>>>>> This will force us to point at the old root with (hopefully) the right bytenr
>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover from there.  This is kind
>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> # btrfs check --readonly /dev/sda3
>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>
>>>>>>>>>>> It's better, but still no dice... :(
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree, which is annoying.
>>>>>>>>>> Does mount -o rescue=all,ro work now that the root tree is normal?  Thanks,
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Nope, I see this in the journal:
>>>>>>>>>
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabling all of the rescue options
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring data csums
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring bad roots
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disabling log replay at mount time
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ok git pull for-neal, rebuild, then run
>>>>>>>>
>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
>>>>>>>>
>>>>>>>> I thought of this yesterday but in my head was like "naaahhhh, whats the chances
>>>>>>>> that the level doesn't match??".  Thanks,
>>>>>>>>
>>>>>>>
>>>>>>> Tried rescue mount again after running that and got a stack trace in
>>>>>>> the kernel, detailed in the following attached log.
>>>>>>
>>>>>> Huh I wonder how I didn't hit this when testing, I must have only tested with
>>>>>> zero'ing the extent root and the csum root.  You're going to have to build a
>>>>>> kernel with a fix for this
>>>>>>
>>>>>> https://paste.centos.org/view/7b48aaea
>>>>>>
>>>>>> and see if that gets you further.  Thanks,
>>>>>>
>>>>>
>>>>> I built a kernel build as an RPM with your patch[1] and tried it.
>>>>>
>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sdb3 /mnt
>>>>> Killed
>>>>>
>>>>> The log from the journal is attached.
>>>>
>>>>
>>>> Ahh crud my bad, this should do it
>>>>
>>>> https://paste.centos.org/view/ac2e61ef
>>>>
>>>
>>> Patch doesn't apply (note it is patch 667 below):
>>
>> Ah sorry, should have just sent you an iterative patch.  You can take the above
>> patch and just delete the hunk from volumes.c as you already have that applied
>> and then it'll work.  Thanks,
>>
> 
> Failed with a weird error...?
> 
> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sda3 /mnt
> mount: /mnt: mount(2) system call failed: No such file or directory.
> 
> Journal log with traceback attached.

Last one maybe?

https://paste.centos.org/view/80edd6fd

thanks,

Josef
