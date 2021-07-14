Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070843C823F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhGNKBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbhGNKBv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 06:01:51 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EDEC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 02:58:59 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q124so343970vka.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X4keXmUsT/YmCPEpAQiFbw+FKTMdBrSQRgnOMAd4sUE=;
        b=j795HeAmyCFE9TD9EE3p6C+0qvB9QbQrSG20De+kgkJVk4l+6wJNw7dWlh8jMgCpfC
         yLy6aq9bQ0p30GTpJacLTZWsO+X205+IezyAlBa+8L5ORSPsDwisaR2OeCHKNPm/s/yQ
         ZP2XHqvhhukGRNGMRajxHWihr8v+LzGLM7j0Cb1igQymbbSWcN0f5q1H4xTjPFBK7SfY
         ByJtuKUdo7g+u+6zoiI0bvZaUSsOtSsWXCXXGA+KikcFn+f3StV6c3qEcJ6GfJmhRuFe
         Qco/9m38Y4HpOCcdxTxCZgHdkiLfsjJj8Um0iUVhbBT/Klu3UhXgdAWKeumEoqiAUA+U
         SguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X4keXmUsT/YmCPEpAQiFbw+FKTMdBrSQRgnOMAd4sUE=;
        b=oK2cn8+sb95EUfErjaAjvneLV2OtkE4CefOnzmeA7Xf4FvdoRLDmhikcVM6qkGywIC
         ykfHDxr81pONBecSa0v8IkgyJnoDXmSPHi8zZ6LqczZ5S7pR3TvXLafHfkCfGkHJkHzg
         HWQ8JCijOpx46InE44XDi2AAHwDgMXjxpG5ze4O67Evi7zBpukWxin3zE/fQ0UTJiWKa
         XOVWHZu05oN1SAws9AzDbg6rxaKzmRKibT/hDwroNaq/uCAkp7ap+tO8p3Ihhr2uHDM9
         8NAlvVrEEC2iUmr6zKYkdgDAqreVREnsxdVihLWnT2tYUj1aE+27cSDwRHBi+rfA2ne+
         Q2hg==
X-Gm-Message-State: AOAM5339koGOz0o9TDAFrRb2/Kf9U5T22i1h+R+qelFkoWVF/cRwUeHa
        2oc0b5XpR8GlrL70kLSPC5sUqqg1+9+i+9Xpa4U=
X-Google-Smtp-Source: ABdhPJzn7EizQt8LzkCUqZTyMfufNMeAbuTdwvyltp7tJ/ERtvZ+LkMEjVxCRZUfbbcrPB0JSrJ9h7kYp5Vew7oOo3E=
X-Received: by 2002:ac5:c4c1:: with SMTP id a1mr10930983vkl.18.1626256738824;
 Wed, 14 Jul 2021 02:58:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:1447:0:0:0:0:0 with HTTP; Wed, 14 Jul 2021 02:58:58
 -0700 (PDT)
In-Reply-To: <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net> <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com> <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Wed, 14 Jul 2021 17:58:58 +0800
Message-ID: <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
Subject: Re: btrfs cannot be mounted or checked
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

```
[  301.533172] BTRFS info (device sda2): unrecognized rescue option 'ibadro=
ots'
[  301.533209] BTRFS error (device sda2): open_ctree failed
```

Does ibadroots need a newer version of btrfs? My btrfs version is 5.10.1.

Thanks!

On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>
>
> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>> sorry for late:(
>>
>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks same
>> as my situation. But in my computer (boot from live usb) `btrfs check
>> --init-extent-tree` output a lot of non-ascii character (maybe because
>> ansi escape code mess the terminal)
>> after several days it outputs `7/7`and `killed`. The solution looks
>> failed.
>>
>> I'm sorry because my live usb don't have smartctl :(
>>
>> ```
>> $ hdparm -W0 /dev/sda
>> /dev/sda:
>>   setting drive write-caching to 0 (off)
>>   write-caching =3D  0 (off)
>> ```
>>
>> But now the btrfs partition still cannot be mounted.
>>
>> when I try to mount it with `usebackuproot`, it will output the same
>> error message. And dmesg will output
>> ```
>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>> deprecated, use 'rescue=3Dusebackuproot' instead
>> [250062.064788] BTRFS info (device sda2): trying to use backup root at
>> mount time
>> [250062.064789] BTRFS info (device sda2): disk space caching is enabled
>> [250062.064790] BTRFS info (device sda2): has skinny extents
>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>> rd 0, flush 0, corrupt 5, gen 0
>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
>> block group used, have 1073754112 expect [0, 1073741824)
>
> Looks like a bad extent tree re-initialization, a bug in btrfs-progs then=
.
>
> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if it
> can be mounted RO, then rescue your data.
>
> Thanks,
> Qu
>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read time
>> tree block corruption detected
>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
>> block group used, have 1073754112 expect [0, 1073741824)
>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read time
>> tree block corruption detected
>> [250062.291943] BTRFS error (device sda2): failed to read block groups:
>> -5
>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>> ```
>>
>> If don't usebackuproot, dmesg will output the same log except the first =
2
>> lines.
>>
>> Now btrfs check can check this partition:
>>
>> ```
>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>> # see attachment
>> ```
>>
>> Does my disk have any hope to be rescued?
>> thanks!
>>
>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>
>>>>
>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>> Sorry for my disturbance.
>>>>> After a dirty reboot because of a computer crash, my btrfs partition
>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>> rescue zero-log` cannot work.
>>>>> ```
>>>>> $ uname -r
>>>>> 5.10.27-gentoo-x86_64
>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>> $ btrfs check /dev/sda2
>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>> parent transid verify failed on 34308096 wanted 962175 found 961764
>>>>> Ignoring transid failure
>>>>> leaf parent key incorrect 34308096
>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>> ERROR: cannot open file system
>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>> # see attachment
>>>>> ```
>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>
>>>>> Thanks for any help!
>>>>>
>>>>
>>>>
>>>> Hi!
>>>>
>>>> Parent transid failed is hard to recover from, as mentioned on
>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_.2=
2parent_transid_verify_failed.22_error.3F
>>>>
>>>>
>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? You
>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>
>>>> One way of avoiding this error is to disable write-cache. Parent
>>>> transid
>>>> failed can happen when the disk re-orders writes in its write cache
>>>> before flushing to disk. This violates barriers, but it is unfortately
>>>> common. If you have a crash, SATA bus reset or other issues, unwritten
>>>> content is lost. The problem here is the re-ordering. The superblock i=
s
>>>> written out before other metadata (which is now lost due to the crash)=
.
>>>
>>> To be extra accurate, all filesysmtems have taken the re-order into
>>> consideration.
>>> Thus we have flush (or called barrier) command to force the disk to
>>> write all its cache back to disk or at least non-volatile cache.
>>>
>>> Combined with mandatory metadata CoW, it means, no matter what the disk
>>> re-order or not, we should only see either the newer data after the
>>> flush, or the older data before the flush.
>>>
>>> But unfortunately, hardware is unreliable, sometimes even lies about it=
s
>>> flush command.
>>> Thus it's possible some disks, especially some cheap RAID cards, tend t=
o
>>> just ignore such flush commands, thus leaves the data corrupted after a
>>> power loss.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be worth
>>>> adding this to a cron-job every 5 minutes or so, as the setting is not
>>>> persistent and can get reset if the disk looses power, goes to sleep,
>>>> etc.
>>>
>
>
