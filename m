Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F2332EAE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCITEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 14:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCITEW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Mar 2021 14:04:22 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC79C06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Mar 2021 11:04:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h26so6710823qtm.5
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Mar 2021 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V0Cxu/sPMq013+7gY68mzMjvwO0sZBtY6kcjjuIaTBc=;
        b=ZVfeauUvJjZhmhWejWdhWH2EzufBfIMiks3Lx8YWZ9gqaBw8J4sOpGz/lUT9XvZQoR
         3MRW/GToyfq8HKY/bKdzM2ey08wLk7uI7ckeqF6UAI7oBfUM+P3jGMO51CyndiQ5BWWC
         yZpm+kNKCfCTScrLrIJnTds0NTUnc2keWY4IvkJtirt1e/G/eNIVUjv+k/xlVzV120wg
         NDgn1xzrrMJSWlq+xlXTjp2gGpx8nYqOvGmxf6MEaWdyxFMG3NOcpXTv25c23UHJ2UH7
         lsyOO0Y4aDh07p/KZUCbFluXISsSOtXeCJ6Zg6oEaOXod2gV73P6XaNz148kAZZHKhGE
         Bw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V0Cxu/sPMq013+7gY68mzMjvwO0sZBtY6kcjjuIaTBc=;
        b=fJuyM7U/dWay8fHMPBwmpgGGR8EZDoRRdgRpeiT/s5oVZx7UrmhCI6kGLeXdWY65P3
         YfA/CmcncVv7Q+An78bbpG+ULSagEYlYV6/Fkls+b1aSMiQdYkcrovUkM9HNuwq7fevg
         NdDksqpfsDHTcAc2/RyVTmPcNQIx6kvjfOhf8dNZTeOyTya7C0kTSRwoijPu9B8rsIWN
         lIQfUgVKhhBJkw2HWJWoHcORNqhUrn1UH+c4R2U4ri/TKI+GIJVfGzh+BvSmohPigNAI
         proeCh9HGXq0VF7useJIx92s6Yz/BOqaGl2Sc3poK5F+9E5IZubGm+iOcovnFxKnQEDK
         5ggg==
X-Gm-Message-State: AOAM530cWBx8EOIax+Oe3f9kqdrwDehRH5opw5olkG1LXP3AS2MuKCkd
        iyxwl9zwWyn0oDAPFyNEoKnHEgSECmHP6qWZ
X-Google-Smtp-Source: ABdhPJz/5RHWV0HsPWe0K9nxxPcZ4iLaIcZ2T16tF1YVFZpo5th+FbWOC/9Hp1v3oPgwDiZ9Vt8K4g==
X-Received: by 2002:ac8:ace:: with SMTP id g14mr25771836qti.156.1615316660650;
        Tue, 09 Mar 2021 11:04:20 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e21sm10323201qtw.63.2021.03.09.11.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 11:04:19 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com>
 <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com>
 <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com>
 <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
 <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com>
 <CAEg-Je-oOnnCd=Vc65yTam6-jxHr2rEr9yrzi_xv79ziys0TjA@mail.gmail.com>
 <346098b8-3d89-1497-ada3-e8317888ee61@toxicpanda.com>
 <CAEg-Je9-88GOrHqqwsvAhxR_1BB-6nFLVd3r-kidCP4APLEEFw@mail.gmail.com>
 <c71ba7e4-28d5-1307-c8d7-4e1bb398ef08@toxicpanda.com>
 <CAEg-Je9dvb5d7nh=pS=_uR5dWe1YBNJTyzzBX=H2_NY=L7DZ9Q@mail.gmail.com>
 <36af1204-bd8a-ebb6-ca21-a469780ed147@toxicpanda.com>
 <CAEg-Je8XM1zfrvu9m61_rrmnRftsksKdQZ_Lz_Km=0vhsfwj4A@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ad9bbba6-5630-ce66-a8e3-344215d9478f@toxicpanda.com>
Date:   Tue, 9 Mar 2021 14:04:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8XM1zfrvu9m61_rrmnRftsksKdQZ_Lz_Km=0vhsfwj4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/8/21 8:12 PM, Neal Gompa wrote:
> On Mon, Mar 8, 2021 at 5:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 3/8/21 3:01 PM, Neal Gompa wrote:
>>> On Mon, Mar 8, 2021 at 1:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 3/5/21 8:03 PM, Neal Gompa wrote:
>>>>> On Fri, Mar 5, 2021 at 5:01 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On 3/5/21 9:41 AM, Neal Gompa wrote:
>>>>>>> On Fri, Mar 5, 2021 at 9:12 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>
>>>>>>>> On 3/4/21 6:54 PM, Neal Gompa wrote:
>>>>>>>>> On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 3/3/21 2:38 PM, Neal Gompa wrote:
>>>>>>>>>>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
>>>>>>>>>>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Hey all,
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk controller failure
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> journal:
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on how to do recovery in
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy data off.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Can you try
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Josef
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --readonly...
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> No dice...
>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some magic, just pull
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> build, and then run
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>> This will force us to point at the old root with (hopefully) the right bytenr
>>>>>>>>>>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover from there.  This is kind
>>>>>>>>>>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
>>>>>>>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> It's better, but still no dice... :(
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree, which is annoying.
>>>>>>>>>>>>>>>>>>>>>>>> Does mount -o rescue=all,ro work now that the root tree is normal?  Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Nope, I see this in the journal:
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabling all of the rescue options
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring data csums
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring bad roots
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disabling log replay at mount time
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> I thought of this yesterday but in my head was like "naaahhhh, whats the chances
>>>>>>>>>>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Tried rescue mount again after running that and got a stack trace in
>>>>>>>>>>>>>>>>>>>>> the kernel, detailed in the following attached log.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I must have only tested with
>>>>>>>>>>>>>>>>>>>> zero'ing the extent root and the csum root.  You're going to have to build a
>>>>>>>>>>>>>>>>>>>> kernel with a fix for this
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> and see if that gets you further.  Thanks,
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I built a kernel build as an RPM with your patch[1] and tried it.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sdb3 /mnt
>>>>>>>>>>>>>>>>>>> Killed
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The log from the journal is attached.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Ahh crud my bad, this should do it
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> https://paste.centos.org/view/ac2e61ef
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Patch doesn't apply (note it is patch 667 below):
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Ah sorry, should have just sent you an iterative patch.  You can take the above
>>>>>>>>>>>>>>>> patch and just delete the hunk from volumes.c as you already have that applied
>>>>>>>>>>>>>>>> and then it'll work.  Thanks,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Failed with a weird error...?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sda3 /mnt
>>>>>>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or directory.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Journal log with traceback attached.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Last one maybe?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://paste.centos.org/view/80edd6fd
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Similar weird failure:
>>>>>>>>>>>>>
>>>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sdb3 /mnt
>>>>>>>>>>>>> mount: /mnt: mount(2) system call failed: No such file or directory.
>>>>>>>>>>>>>
>>>>>>>>>>>>> No crash in the journal this time, though:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling all of the rescue options
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring data csums
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring bad roots
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling log replay at mount time
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk space caching is enabled
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinny extents
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed to read fs tree: -2
>>>>>>>>>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctree failed
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Sorry Neal, you replied when I was in the middle of something and promptly
>>>>>>>>>>>> forgot about it.  I figured the fs root was fine, can you do the following so I
>>>>>>>>>>>> can figure out from the error messages what might be wrong
>>>>>>>>>>>>
>>>>>>>>>>>> btrfs check --readonly
>>>>>>>>>>>> btrfs restore -D
>>>>>>>>>>>> btrfs restore -l
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It didn't work.. Here's the output:
>>>>>>>>>>>
>>>>>>>>>>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
>>>>>>>>>>> Couldn't setup device tree
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> Ignoring transid failure
>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
>>>>>>>>>>> Couldn't setup device tree
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device size 263132807168
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
>>>>>>>>>>> Couldn't setup device tree
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>>>>>>>>>> Ignoring transid failure
>>>>>>>>>>> WARNING: could not setup extent tree, skipping it
>>>>>>>>>>> Couldn't setup device tree
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>> ERROR: superblock bytenr 274877906944 is larger than device size 263132807168
>>>>>>>>>>> Could not open root, trying backup super
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hmm OK I think we want the neal magic for this one too, but before we go doing
>>>>>>>>>> that can I get a
>>>>>>>>>>
>>>>>>>>>> btrfs inspect-internal -f /dev/whatever
>>>>>>>>>>
>>>>>>>>>> so I can make sure I'm not just blindly clobbering something.  Thanks,
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Doesn't work, did you mean some other command?
>>>>>>>>>
>>>>>>>>> [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
>>>>>>>>> btrfs inspect-internal: unknown token '-f'
>>>>>>>>
>>>>>>>> Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Ok I've pushed to the for-neal branch in my btrfs-progs, can you pull and make
>>>>>> and then run
>>>>>>
>>>>>> ./btrfs-print-block /dev/sdb3 791281664
>>>>>>
>>>>>> and capture everything it prints out?  Thanks,
>>>>>>
>>>>>
>>>>> Here's the output from the command.
>>>>>
>>>>>
>>>>
>>>> Hmm looks like the fs is offset a bit, can you do
>>>>
>>>> ./btrfs-print-block /dev/sdb3 799670272
>>>>
>>>
>>> This command caused my session to crash, but I do have a log of what
>>> was captured before it crashed and attached it.
>>>
>>>> also while we're here can I get
>>>>
>>>> btrfs-find-root /dev/sdb3
>>>>
>>>
>>> This ran successfully and I've attached the output.
>>>
>>
>> Ok we're going to try this again, and if it doesn't work it looks like your
>> chunk root is ok, so I'll rig something up to make the translation work right,
>> but for now lets do
>>
>> ./btrfs-print-block /dev/sdb3 792395776
>>
> 
> I've attached the output from that command, which did run successfully.
> 

Definitely need the translation, I pushed a new patch to the btrfs-progs branch 
for-neal.  Pull, rebuild, and then run the same command again, hopefully this 
gives me what I want.  Thanks,

Josef

