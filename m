Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52A32ECD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCEOMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 09:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhCEOMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 09:12:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A6C061574
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Mar 2021 06:12:16 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o1so1723148qta.13
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Mar 2021 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YIUgjQ2hOMKpxkwU3bOzjNkDJbLR8M/RM3s+Y71xr4I=;
        b=y8QSuoxao8N0hW9TZNzXtXVSZkOYszT/ovSLt4m5mSw4Hx9fIyHkrpRT9oxUFYSgo3
         AkAPwTvoVXADoZdNK2kT1z1m0zKUUxZKJlvC8s2celFtsrMvomyLcr3qRd8Vg7UMTEQr
         afQ271wbK6uReWcbpu7V87jf8K3k9peuZpOqY4qkqpq+nXqeLpnSJQU55BdtdWWMVAVs
         xfbFoBMQBnaRIEOGmB/QjrORdMfsiUcInpCX2hGoAuibU1k+NdMhzQZjt8hH/NwLfs4d
         BDaknW0vTvbY10ao4xMLCWxQ6mS86zTdufriocktloHRsZUmvwBzyx5n52MCqnNPCAwS
         94RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YIUgjQ2hOMKpxkwU3bOzjNkDJbLR8M/RM3s+Y71xr4I=;
        b=hPKoLyge9mjOAvcb5q+uOvGQ1Ey7bsvjp7U9Pum2v2e3e7u2pkoOpzMNmjUUbT1zOp
         iHzT5Xe+EDDH4R2eHzjLRwANIwwivbCvYJfeDM/1tesRGi9EeOYdzjeY8UZ2QYOL7NT8
         wTzKw8p6dd36tFTVEqDIj/EDt8ykHOQQj5xU1UDfgCThR5l9klNIKoB312ll40vPb7cJ
         d6TNQwCcZyRm+sHUI5wMG9ewC2VOEfJGYXEgk1r+qtuSxzP1oI9WPiL3JnFcVjGuO6nW
         B4XVLDV1CFFe9mlxLiaaBsH2hzlyxFL5vBSxmS0XZjW+c8x8yTqb3Ij5+3notGoH6Opf
         PFzQ==
X-Gm-Message-State: AOAM532YbJ9fxtqUNSUkzwEjIVdRYkafHzxK/fEtsqRAEMsvogslPZoU
        YcyplfQDSoNU6OLUrnmnm/qVIrm39zhdxjxe
X-Google-Smtp-Source: ABdhPJw5rBCh1Ze3z3Md8IV/3nMU2NqqvnKHIixdg1dSo+aANWzlXgqM3rrwR3zybdm2NJpme+ReJA==
X-Received: by 2002:ac8:580c:: with SMTP id g12mr8910276qtg.14.1614953534948;
        Fri, 05 Mar 2021 06:12:14 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11c1::1010? ([2620:10d:c091:480::1:98f4])
        by smtp.gmail.com with ESMTPSA id m13sm1778980qkk.16.2021.03.05.06.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 06:12:14 -0800 (PST)
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com>
 <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com>
 <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com>
 <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com>
 <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
 <95e8db7d-eff3-e694-c315-f7984b5f49e0@toxicpanda.com>
 <CAEg-Je_s6EAHwj2LWYRLdMHF_kRuY_JQoLfWMqDgcROZatnP+g@mail.gmail.com>
 <ef2ec021-52d3-2da4-f59a-fa7016c95d90@toxicpanda.com>
 <CAEg-Je_HKgGLnF6F_3dXd+9NFa9cTceWWtTUhSSjNovsze_wQg@mail.gmail.com>
 <d2c7b501-f2f1-c471-4b1b-38e6731682ba@toxicpanda.com>
 <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e5b5409b-0e34-abd5-81c9-48ef59c3fa03@toxicpanda.com>
Date:   Fri, 5 Mar 2021 09:12:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_TN04fnE2Bg46Nysm2_fG7dcni-7c6wbfZQZqXhDhbnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/4/21 6:54 PM, Neal Gompa wrote:
> On Thu, Mar 4, 2021 at 3:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On 3/3/21 2:38 PM, Neal Gompa wrote:
>>> On Wed, Mar 3, 2021 at 1:42 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On 2/24/21 10:47 PM, Neal Gompa wrote:
>>>>> On Wed, Feb 24, 2021 at 10:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On 2/24/21 9:23 AM, Neal Gompa wrote:
>>>>>>> On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>
>>>>>>>> On 2/22/21 11:03 PM, Neal Gompa wrote:
>>>>>>>>> On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 2/21/21 1:27 PM, Neal Gompa wrote:
>>>>>>>>>>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
>>>>>>>>>>>>>>>>>>>>>>> Hey all,
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> So one of my main computers recently had a disk controller failure
>>>>>>>>>>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuses to
>>>>>>>>>>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors show up in the
>>>>>>>>>>>>>>>>>>>>>>> journal:
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3): corrupt leaf: root=401 block=796082176 slot=15 ino=203657, invalid inode transid: has 888896 expect [0, 888895]
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): block=796082176 read time tree block corruption detected
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I can't
>>>>>>>>>>>>>>>>>>>>>>> seem to find any reasonably good information on how to do recovery in
>>>>>>>>>>>>>>>>>>>>>>> this scenario, even to just recover enough to copy data off.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
>>>>>>>>>>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'm
>>>>>>>>>>>>>>>>>>>>>>> using btrfs-progs v5.10.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Can anyone help?
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Can you try
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> That should fix the inode generation thing so it's sane, and then the tree
>>>>>>>>>>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not we can work out some
>>>>>>>>>>>>>>>>>>>>>> other magic.  Thanks,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Josef
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I got the same error as I did with btrfs-check --readonly...
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> No dice...
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
>>>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 888895
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Hey look the block we're looking for, I wrote you some magic, just pull
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> build, and then run
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> This will force us to point at the old root with (hopefully) the right bytenr
>>>>>>>>>>>>>>>>>> and gen, and then hopefully you'll be able to recover from there.  This is kind
>>>>>>>>>>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things worse.  Thanks,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> # btrfs check --readonly /dev/sda3
>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
>>>>>>>>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>>>>>>>>> ERROR: could not setup extent tree
>>>>>>>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> It's better, but still no dice... :(
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hmm it's not telling us what's wrong with the extent tree, which is annoying.
>>>>>>>>>>>>>>>> Does mount -o rescue=all,ro work now that the root tree is normal?  Thanks,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Nope, I see this in the journal:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabling all of the rescue options
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring data csums
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignoring bad roots
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disabling log replay at mount time
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk space caching is enabled
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has skinny extents
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree level mismatch detected, bytenr=791281664 level expected=1 has=2
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): couldn't read tree root
>>>>>>>>>>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open_ctree failed
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ok git pull for-neal, rebuild, then run
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I thought of this yesterday but in my head was like "naaahhhh, whats the chances
>>>>>>>>>>>>>> that the level doesn't match??".  Thanks,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Tried rescue mount again after running that and got a stack trace in
>>>>>>>>>>>>> the kernel, detailed in the following attached log.
>>>>>>>>>>>>
>>>>>>>>>>>> Huh I wonder how I didn't hit this when testing, I must have only tested with
>>>>>>>>>>>> zero'ing the extent root and the csum root.  You're going to have to build a
>>>>>>>>>>>> kernel with a fix for this
>>>>>>>>>>>>
>>>>>>>>>>>> https://paste.centos.org/view/7b48aaea
>>>>>>>>>>>>
>>>>>>>>>>>> and see if that gets you further.  Thanks,
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I built a kernel build as an RPM with your patch[1] and tried it.
>>>>>>>>>>>
>>>>>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sdb3 /mnt
>>>>>>>>>>> Killed
>>>>>>>>>>>
>>>>>>>>>>> The log from the journal is attached.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ahh crud my bad, this should do it
>>>>>>>>>>
>>>>>>>>>> https://paste.centos.org/view/ac2e61ef
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Patch doesn't apply (note it is patch 667 below):
>>>>>>>>
>>>>>>>> Ah sorry, should have just sent you an iterative patch.  You can take the above
>>>>>>>> patch and just delete the hunk from volumes.c as you already have that applied
>>>>>>>> and then it'll work.  Thanks,
>>>>>>>>
>>>>>>>
>>>>>>> Failed with a weird error...?
>>>>>>>
>>>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sda3 /mnt
>>>>>>> mount: /mnt: mount(2) system call failed: No such file or directory.
>>>>>>>
>>>>>>> Journal log with traceback attached.
>>>>>>
>>>>>> Last one maybe?
>>>>>>
>>>>>> https://paste.centos.org/view/80edd6fd
>>>>>>
>>>>>
>>>>> Similar weird failure:
>>>>>
>>>>> [root@fedora ~]# mount -t btrfs -o rescue=all,ro /dev/sdb3 /mnt
>>>>> mount: /mnt: mount(2) system call failed: No such file or directory.
>>>>>
>>>>> No crash in the journal this time, though:
>>>>>
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): enabling all of the rescue options
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring data csums
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): ignoring bad roots
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disabling log replay at mount time
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): disk space caching is enabled
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS info (device sdb3): has skinny extents
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS warning (device sdb3): failed to read fs tree: -2
>>>>>> Feb 24 22:43:19 fedora kernel: BTRFS error (device sdb3): open_ctree failed
>>>>>
>>>>>
>>>>
>>>> Sorry Neal, you replied when I was in the middle of something and promptly
>>>> forgot about it.  I figured the fs root was fine, can you do the following so I
>>>> can figure out from the error messages what might be wrong
>>>>
>>>> btrfs check --readonly
>>>> btrfs restore -D
>>>> btrfs restore -l
>>>>
>>>
>>> It didn't work.. Here's the output:
>>>
>>> [root@fedora ~]# btrfs check --readonly /dev/sdb3
>>> Opening filesystem to check...
>>> ERROR: could not setup extent tree
>>> ERROR: cannot open file system
>>> [root@fedora ~]# btrfs restore -D /dev/sdb3 /mnt
>>> WARNING: could not setup extent tree, skipping it
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> Ignoring transid failure
>>> WARNING: could not setup extent tree, skipping it
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> ERROR: superblock bytenr 274877906944 is larger than device size 263132807168
>>> Could not open root, trying backup super
>>> [root@fedora ~]# btrfs restore -l /dev/sdb3 /mnt
>>> WARNING: could not setup extent tree, skipping it
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> parent transid verify failed on 796082176 wanted 888894 found 888896
>>> Ignoring transid failure
>>> WARNING: could not setup extent tree, skipping it
>>> Couldn't setup device tree
>>> Could not open root, trying backup super
>>> ERROR: superblock bytenr 274877906944 is larger than device size 263132807168
>>> Could not open root, trying backup super
>>>
>>>
>>
>> Hmm OK I think we want the neal magic for this one too, but before we go doing
>> that can I get a
>>
>> btrfs inspect-internal -f /dev/whatever
>>
>> so I can make sure I'm not just blindly clobbering something.  Thanks,
>>
> 
> Doesn't work, did you mean some other command?
> 
> [root@fedora ~]#  btrfs inspect-internal -f /dev/sdb3
> btrfs inspect-internal: unknown token '-f'

Sigh, sorry, btrfs inspect-internal dump-super -f /dev/sdb3

Josef
