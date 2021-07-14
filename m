Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9863C8260
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhGNKHP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 06:07:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49766 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhGNKHM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 06:07:12 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1E7A228DC;
        Wed, 14 Jul 2021 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626257060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZdJtWeJlyNpWXVaOGOMp9dTR51UVsq5B0LiDkQdMEs=;
        b=UkStpPt+iBZ5u1ahqPlMxwDG/RsbEMuRnD21ug4IJIEdoL47SAZwo17J7561CIMGDv/U29
        tKRMMphfAir6wx0EKJOsos5IsulfjSmF9MzzjTIBYGzTmQcheWsG+yhEE0g2pcnGyQc/jj
        1zu3gW53zxzU79MohLYX7AalfYmj6GM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 755B213A85;
        Wed, 14 Jul 2021 10:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nm+WGaS27mCLGAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 14 Jul 2021 10:04:20 +0000
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ac40ef7d-0d3f-1a1f-57eb-df83927a9efd@suse.com>
Date:   Wed, 14 Jul 2021 13:04:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.07.21 г. 12:58, Zhenyu Wu wrote:
> ```
> [  301.533172] BTRFS info (device sda2): unrecognized rescue option 'ibadroots'
> [  301.533209] BTRFS error (device sda2): open_ctree failed
> ```
> 
> Does ibadroots need a newer version of btrfs? My btrfs version is 5.10.1.

That options landed in kernel 5.11

> 
> Thanks!
> 
> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>> On 2021/7/14 下午4:49, Zhenyu Wu wrote:
>>> sorry for late:(
>>>
>>> I found <https://bbs.archlinux.org/viewtopic.php?id=233724> looks same
>>> as my situation. But in my computer (boot from live usb) `btrfs check
>>> --init-extent-tree` output a lot of non-ascii character (maybe because
>>> ansi escape code mess the terminal)
>>> after several days it outputs `7/7`and `killed`. The solution looks
>>> failed.
>>>
>>> I'm sorry because my live usb don't have smartctl :(
>>>
>>> ```
>>> $ hdparm -W0 /dev/sda
>>> /dev/sda:
>>>   setting drive write-caching to 0 (off)
>>>   write-caching =  0 (off)
>>> ```
>>>
>>> But now the btrfs partition still cannot be mounted.
>>>
>>> when I try to mount it with `usebackuproot`, it will output the same
>>> error message. And dmesg will output
>>> ```
>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>> deprecated, use 'rescue=usebackuproot' instead
>>> [250062.064788] BTRFS info (device sda2): trying to use backup root at
>>> mount time
>>> [250062.064789] BTRFS info (device sda2): disk space caching is enabled
>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>> rd 0, flush 0, corrupt 5, gen 0
>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=2
>>> block=273006592 slot=17 bg_start=1104150528 bg_len=1073741824, invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>
>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs then.
>>
>> For now, you can try to mount with "ro,rescue=ibadroots" to see if it
>> can be mounted RO, then rescue your data.
>>
>> Thanks,
>> Qu
>>> [250062.277048] BTRFS error (device sda2): block=273006592 read time
>>> tree block corruption detected
>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=2
>>> block=273006592 slot=17 bg_start=1104150528 bg_len=1073741824, invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>> [250062.291927] BTRFS error (device sda2): block=273006592 read time
>>> tree block corruption detected
>>> [250062.291943] BTRFS error (device sda2): failed to read block groups:
>>> -5
>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>> ```
>>>
>>> If don't usebackuproot, dmesg will output the same log except the first 2
>>> lines.
>>>
>>> Now btrfs check can check this partition:
>>>
>>> ```
>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>> # see attachment
>>> ```
>>>
>>> Does my disk have any hope to be rescued?
>>> thanks!
>>>
>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>> On 2021/7/11 下午7:37, Forza wrote:
>>>>>
>>>>>
>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>> Sorry for my disturbance.
>>>>>> After a dirty reboot because of a computer crash, my btrfs partition
>>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>>> rescue zero-log` cannot work.
>>>>>> ```
>>>>>> $ uname -r
>>>>>> 5.10.27-gentoo-x86_64
>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>> $ btrfs check /dev/sda2
>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>>> Ignoring transid failure
>>>>>> leaf parent key incorrect 34308096
>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>> ERROR: cannot open file system
>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>> # see attachment
>>>>>> ```
>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>
>>>>>> Thanks for any help!
>>>>>>
>>>>>
>>>>>
>>>>> Hi!
>>>>>
>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.22parent_transid_verify_failed.22_error.3F
>>>>>
>>>>>
>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? You
>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>
>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>> transid
>>>>> failed can happen when the disk re-orders writes in its write cache
>>>>> before flushing to disk. This violates barriers, but it is unfortately
>>>>> common. If you have a crash, SATA bus reset or other issues, unwritten
>>>>> content is lost. The problem here is the re-ordering. The superblock is
>>>>> written out before other metadata (which is now lost due to the crash).
>>>>
>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>> consideration.
>>>> Thus we have flush (or called barrier) command to force the disk to
>>>> write all its cache back to disk or at least non-volatile cache.
>>>>
>>>> Combined with mandatory metadata CoW, it means, no matter what the disk
>>>> re-order or not, we should only see either the newer data after the
>>>> flush, or the older data before the flush.
>>>>
>>>> But unfortunately, hardware is unreliable, sometimes even lies about its
>>>> flush command.
>>>> Thus it's possible some disks, especially some cheap RAID cards, tend to
>>>> just ignore such flush commands, thus leaves the data corrupted after a
>>>> power loss.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be worth
>>>>> adding this to a cron-job every 5 minutes or so, as the setting is not
>>>>> persistent and can get reset if the disk looses power, goes to sleep,
>>>>> etc.
>>>>
>>
>>
> 
