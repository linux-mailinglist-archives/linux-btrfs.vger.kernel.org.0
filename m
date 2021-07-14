Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413673C8255
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhGNKFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 06:05:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:32915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238638AbhGNKFd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 06:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626256959;
        bh=+oH1UelG3e6nOtwH4QaBCdn3YIZCP25eShHRMq6Ea2I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=co4X3jut1xj1Go4YjHgF1cHnMlRunHo97z6Awpu4eLDVw4kJZbJZZ0ywnWFuSqhzY
         S3ji78PHmzq9Ozb9DnLV1O5Hlva4+Ade99tJ4QMqTK97Wa9tCcaIRkBeeoMZ9NrJtr
         QIqKXX6DcJgRjQ0Hpinxf6Dud0Sc8V/CCaUFo57k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVN6t-1lbrad1f7P-00SSTn; Wed, 14
 Jul 2021 12:02:39 +0200
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
Date:   Wed, 14 Jul 2021 18:01:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sq5PvGnJ0MuCjMlirViU8KyLzZZ4wGLjXc1OAH4JFnAAfNHYu6p
 iBOAIeUmgkXYLpY6zXtTB0jBaKy9XuvcrP3JykwnIuGAIZg5frYhtfkAfdMzSqesoktonDi
 SvBuMtNRgqEsx64wgY1Sb9TQwchQ5rOybdR39wBC3cUdDdilMTrwujg066ediFTlItQkdc2
 JUVUQVvZNxCaAnsKFp90g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7NASQ903b8=:rfXOwAoDO05PfrzWy9tGmO
 Makg2Ra7k5DMyCNejkl9+yz5a1gWzkpDWW/e8wcmh4Wu47paXWwlUFzZvusbxgHjsmiar+yJA
 LVNURqZpsrmSt90b8SwDr+XCGaQq2E+MwfmM8wq+fEeIpPigZjX29rCo/3D9eLK2233RkbzL9
 25jdMTZA+Bo5iNy9Ox7QZv35fjfbIkmAX2iisxDVZMtz0OBCnTxel11643z3OwaYHjNmT6p/g
 RMbsC3x3ggUZ+EYjyXQVXjplNNxjzGmQQ4RrhWXL0yj+d2MIfONqLdIlz6Iot0iFYzqs/x0HY
 /DhnnSZHsxUR6jIlqP9uVHXsI87YEiGH6E2RqU15kQiXWgOgNVYzLj1hYCEiERSAuRnlgCE6f
 06ZErtwJgFlUhlDdbi+NvNSm8Z76lKhwd8tc/thvF5aB2WNZ0/kiK4EQvfO4FeDUy7X48aNRp
 YdyrZDYJWS1Plsm7cHbakqxyayiuRqRBuV9NS1GIG99VbyzZOW85J7W3zyU8WCOmY2IJ4WEbF
 tazXfsPodOWzrfKVD546KkOc3BlOvWWjjjl/waFTyHHKkUasYV1PcUU1aHPKU42tBe9a/H5Gb
 JyCTVbOQBmLx/DPcPR6mhsDL5gKNMug/PACYMCFgOLPmMnNIjY0WZKnujP1f9dnLg94ucCWdv
 OtJAX2G1wqQZEZbUV1ygeVhMjZ8MdBbDo3miu4ltNOnYjxXaEQSkFy55Qy6C/WLbZeako+ZzA
 LahhJMNCfUL5nWk+1m9WowvNNkA90j0yXdHVKgYkyV4RVe7sEc15Ww6qrYL0bMKqjclh5aiEV
 7+14GA7y1nfEA+Xeax06qmI7Ti7Qq9kzRXN3HenkwEaWJ3s9+0Nzc3syAZejtOBIRfrLvMzJt
 Qz/gqQoMK1+IK3mF/u0GQD1251jGr0rMu2plPlh+d2UPvkNDuJGj8PcTDpOF/XZGimWDMU1Ke
 fWhYFUv63INI7OUP9/HoPlOJnMW1zgyiMhSeXAHS0dXG4m0tzUGX9WMrZe8Cl0XVl5aNrr4Ps
 liR37i2Ajiw2q9FbAe70PATiNKcT8ricl0qpBjYc88+dYs452Ib93jhBGdc3ezXMtbosXdWkV
 YkPxMyZpdnyzbEmiv+qSbmFmWaSr+kQHl4DOmg9oHnWFFAOmagnc8O7lA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
> ```
> [  301.533172] BTRFS info (device sda2): unrecognized rescue option 'iba=
droots'
> [  301.533209] BTRFS error (device sda2): open_ctree failed
> ```
>
> Does ibadroots need a newer version of btrfs? My btrfs version is 5.10.1=
.

Oh, that support is added in v5.11...

You may want to grab a liveCD from some rolling release.

But even with v5.11, it may not help much, as that option won't help if
your extent tree is still intact.

You may want to use "btrfs ins dump-tree" to locate your extent tree,
then corrupt the extent tree root completely (using btrfs-map-logical to
get the physical offset, then dd to destory the first 4 bytes of both
copy), then the option would properly work.

Thanks,
Qu
>
> Thanks!
>
> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>> sorry for late:(
>>>
>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks sa=
me
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
>>>    setting drive write-caching to 0 (off)
>>>    write-caching =3D  0 (off)
>>> ```
>>>
>>> But now the btrfs partition still cannot be mounted.
>>>
>>> when I try to mount it with `usebackuproot`, it will output the same
>>> error message. And dmesg will output
>>> ```
>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>> [250062.064788] BTRFS info (device sda2): trying to use backup root at
>>> mount time
>>> [250062.064789] BTRFS info (device sda2): disk space caching is enable=
d
>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>> rd 0, flush 0, corrupt 5, gen 0
>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824,=
 invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>
>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs th=
en.
>>
>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if it
>> can be mounted RO, then rescue your data.
>>
>> Thanks,
>> Qu
>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read time
>>> tree block corruption detected
>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824,=
 invalid
>>> block group used, have 1073754112 expect [0, 1073741824)
>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read time
>>> tree block corruption detected
>>> [250062.291943] BTRFS error (device sda2): failed to read block groups=
:
>>> -5
>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>> ```
>>>
>>> If don't usebackuproot, dmesg will output the same log except the firs=
t 2
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
>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>
>>>>>
>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>> Sorry for my disturbance.
>>>>>> After a dirty reboot because of a computer crash, my btrfs partitio=
n
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
>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_a_=
.22parent_transid_verify_failed.22_error.3F
>>>>>
>>>>>
>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy? Y=
ou
>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>
>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>> transid
>>>>> failed can happen when the disk re-orders writes in its write cache
>>>>> before flushing to disk. This violates barriers, but it is unfortate=
ly
>>>>> common. If you have a crash, SATA bus reset or other issues, unwritt=
en
>>>>> content is lost. The problem here is the re-ordering. The superblock=
 is
>>>>> written out before other metadata (which is now lost due to the cras=
h).
>>>>
>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>> consideration.
>>>> Thus we have flush (or called barrier) command to force the disk to
>>>> write all its cache back to disk or at least non-volatile cache.
>>>>
>>>> Combined with mandatory metadata CoW, it means, no matter what the di=
sk
>>>> re-order or not, we should only see either the newer data after the
>>>> flush, or the older data before the flush.
>>>>
>>>> But unfortunately, hardware is unreliable, sometimes even lies about =
its
>>>> flush command.
>>>> Thus it's possible some disks, especially some cheap RAID cards, tend=
 to
>>>> just ignore such flush commands, thus leaves the data corrupted after=
 a
>>>> power loss.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be wort=
h
>>>>> adding this to a cron-job every 5 minutes or so, as the setting is n=
ot
>>>>> persistent and can get reset if the disk looses power, goes to sleep=
,
>>>>> etc.
>>>>
>>
>>
