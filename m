Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDA3C83FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 13:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhGNLkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbhGNLku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 07:40:50 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD1C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 04:37:58 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id u14so726748vsc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uMBj07XYx4rczE24lk0Wi6paaulHJuFwJ3c9WhUpuOs=;
        b=Bey7+pl8HWenOvZlXP3Zht69FP2a6ktc0E63hsXXAzHgG2Oeh3rdL50+75kuOYDfH6
         zmCHs5TFCLPXwV+xQ5m8Nm7j9aq41KBvfxUzSqYYdGfx3f/L2c9uwA5WWyXs0MGHaQ0j
         HO6gIks/Sa/FeIS4MWorDGmsNrct+aXc8KKZv9Pr5v3yR1PxTGwjTipFD3iR28pY5K7n
         ozGCZRJ0QuDa4ax83iCRFEGsKA28umlY2hfKbTOyw8yOqnerZCvFSpBcEuR+f7MojE2n
         qE1curE0sFhCPhjn1sPptm1QzoV7/i+9AZLG7+gn0tKYTYBToYaZizPEba6StDGKZ2ud
         qWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uMBj07XYx4rczE24lk0Wi6paaulHJuFwJ3c9WhUpuOs=;
        b=NqT9a79EcHje6/8jdvu32R4BlJ8YcNtiW8I4W4gfX5MqAivPi095735CJNjKhiAIGj
         HbhxwTipHO2uw549SueR/Qfg/z9C30eLxWKC0VYjd4wDa9l/oxyv3C9RvJK2mgwj2UT5
         3pMiL11EUrj4ZyTXjh3LoVvdqUdEzw+CTilZIwEPcJplyZvklxfsUX8PlA1tffBafuZe
         U7HiX0YgAAxNF/bS4NncBixCYMW65SeCjAZ+ytVOBma9woAemtSBvu8TaAybaJ0lxe9r
         AWnV42VVse8dZYq3BmrLiAqH/Ax550Z7ilDVi01fwmLSSQZUr9oactAVqBAVSyd1dHB+
         XHKA==
X-Gm-Message-State: AOAM53275qcwBtS8mQub+GXa+3N3oetKv11s+aJxmxUYy+cchI6QFQgz
        hz8dSsw+0lkXHufU0P8Kjc6xM/aqGjwB2/IIJGM=
X-Google-Smtp-Source: ABdhPJwHoqR9fSNXpprK8Zrt/j9b0SlVHiP9FYI8czJNgBp84NmAquguxKB2pjxgjwurusj3ZFFehVCZ+tLCAw3M1jQ=
X-Received: by 2002:a67:d992:: with SMTP id u18mr10421429vsj.2.1626262677730;
 Wed, 14 Jul 2021 04:37:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:1447:0:0:0:0:0 with HTTP; Wed, 14 Jul 2021 04:37:57
 -0700 (PDT)
In-Reply-To: <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net> <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com> <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Wed, 14 Jul 2021 19:37:57 +0800
Message-ID: <CAJ9tZB82FAG5jrD-JLWGLy13OEJut+YYtVtUV8AqZNqGtFJxbw@mail.gmail.com>
Subject: Re: btrfs cannot be mounted or checked
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sorry:( can it be specific?
btrfs-map-logical looks like need an option, btrfs ins dump-tree is
outputing many text, and how to locate the extent tree?
Thanks!

On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>> ```
>> [  301.533172] BTRFS info (device sda2): unrecognized rescue option
>> 'ibadroots'
>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>> ```
>>
>> Does ibadroots need a newer version of btrfs? My btrfs version is 5.10.1=
.
>
> Oh, that support is added in v5.11...
>
> You may want to grab a liveCD from some rolling release.
>
> But even with v5.11, it may not help much, as that option won't help if
> your extent tree is still intact.
>
> You may want to use "btrfs ins dump-tree" to locate your extent tree,
> then corrupt the extent tree root completely (using btrfs-map-logical to
> get the physical offset, then dd to destory the first 4 bytes of both
> copy), then the option would properly work.
>
> Thanks,
> Qu
>>
>> Thanks!
>>
>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>
>>>
>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>> sorry for late:(
>>>>
>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks sa=
me
>>>> as my situation. But in my computer (boot from live usb) `btrfs check
>>>> --init-extent-tree` output a lot of non-ascii character (maybe because
>>>> ansi escape code mess the terminal)
>>>> after several days it outputs `7/7`and `killed`. The solution looks
>>>> failed.
>>>>
>>>> I'm sorry because my live usb don't have smartctl :(
>>>>
>>>> ```
>>>> $ hdparm -W0 /dev/sda
>>>> /dev/sda:
>>>>    setting drive write-caching to 0 (off)
>>>>    write-caching =3D  0 (off)
>>>> ```
>>>>
>>>> But now the btrfs partition still cannot be mounted.
>>>>
>>>> when I try to mount it with `usebackuproot`, it will output the same
>>>> error message. And dmesg will output
>>>> ```
>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>> [250062.064788] BTRFS info (device sda2): trying to use backup root at
>>>> mount time
>>>> [250062.064789] BTRFS info (device sda2): disk space caching is enable=
d
>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>>> rd 0, flush 0, corrupt 5, gen 0
>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824,=
 invalid
>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>
>>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs
>>> then.
>>>
>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if it
>>> can be mounted RO, then rescue your data.
>>>
>>> Thanks,
>>> Qu
>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read time
>>>> tree block corruption detected
>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824,=
 invalid
>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read time
>>>> tree block corruption detected
>>>> [250062.291943] BTRFS error (device sda2): failed to read block groups=
:
>>>> -5
>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>> ```
>>>>
>>>> If don't usebackuproot, dmesg will output the same log except the firs=
t
>>>> 2
>>>> lines.
>>>>
>>>> Now btrfs check can check this partition:
>>>>
>>>> ```
>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>> # see attachment
>>>> ```
>>>>
>>>> Does my disk have any hope to be rescued?
>>>> thanks!
>>>>
>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>
>>>>>
>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>
>>>>>>
>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>> Sorry for my disturbance.
>>>>>>> After a dirty reboot because of a computer crash, my btrfs partitio=
n
>>>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>>>> rescue zero-log` cannot work.
>>>>>>> ```
>>>>>>> $ uname -r
>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>>> $ btrfs check /dev/sda2
>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>>> Ignoring transid failure
>>>>>>> leaf parent key incorrect 34308096
>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>> ERROR: cannot open file system
>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>> # see attachment
>>>>>>> ```
>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>
>>>>>>> Thanks for any help!
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_=
.22parent_transid_verify_failed.22_error.3F
>>>>>>
>>>>>>
>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy?
>>>>>> You
>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>
>>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>>> transid
>>>>>> failed can happen when the disk re-orders writes in its write cache
>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>> unfortately
>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>> unwritten
>>>>>> content is lost. The problem here is the re-ordering. The superblock
>>>>>> is
>>>>>> written out before other metadata (which is now lost due to the
>>>>>> crash).
>>>>>
>>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>>> consideration.
>>>>> Thus we have flush (or called barrier) command to force the disk to
>>>>> write all its cache back to disk or at least non-volatile cache.
>>>>>
>>>>> Combined with mandatory metadata CoW, it means, no matter what the
>>>>> disk
>>>>> re-order or not, we should only see either the newer data after the
>>>>> flush, or the older data before the flush.
>>>>>
>>>>> But unfortunately, hardware is unreliable, sometimes even lies about
>>>>> its
>>>>> flush command.
>>>>> Thus it's possible some disks, especially some cheap RAID cards, tend
>>>>> to
>>>>> just ignore such flush commands, thus leaves the data corrupted after
>>>>> a
>>>>> power loss.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be wort=
h
>>>>>> adding this to a cron-job every 5 minutes or so, as the setting is
>>>>>> not
>>>>>> persistent and can get reset if the disk looses power, goes to sleep=
,
>>>>>> etc.
>>>>>
>>>
>>>
>
