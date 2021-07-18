Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B43CC700
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 02:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhGRATZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jul 2021 20:19:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:43041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhGRATY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jul 2021 20:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626567383;
        bh=Fm8L/PfE/DZD+7ND6BNrg4pr1ojSZCyDIvtYdtmN4YE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=RQfbxTgrUd70mhpexuvgbawfS7/0Nx3olzD/K86AYo38ayq0J7L5sMbCprrmYr2fj
         MkXywmG2Iqhnx92LEIRYZ8KHUn5K+yuI6oxijIdlR+uZuuVYJ8atsKEbXT4sndis3e
         v8kj7j/am9T2pn00pCLlptpIP9Z4sRHybuCjoNh0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1m77PC1dxg-002HkG; Sun, 18
 Jul 2021 02:16:23 +0200
Subject: Re: Corruption errors on Samsung 980 Pro (FIXED for now)
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, dennis@kernel.org
References: <2729231.WZja5ltl65@ananda> <4728303.pjhilp7EXf@ananda>
 <2078476.5JW8h9ZS4m@ananda>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <92baa2b1-88ce-492f-f206-39b1dafc573a@gmx.com>
Date:   Sun, 18 Jul 2021 08:16:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2078476.5JW8h9ZS4m@ananda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aksx+3aya6XpEWInUUyHx1qWT++GGcxu5gmhNPKvUoYES+Pq8FS
 1ejMNm3qmh0GaUM09orOXWa+brK0oO3Xtprwr7LOr1likuloMEhwF4kSyOY43N9lwvV6CKl
 K8PV7GOr5y3ZjCXJ77SS3hdXadl8yN3YHw81JILrX/v88kEy3X+axMxVR+seHbctDFXZe/b
 FkN7Prx9AuSCTN0aJI2dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xETMCIdmhGU=:jRftvTvbMi42bJsjnq4PaN
 j3dEPux7Bv91wlWXHn+wyuqtgo8/F96AkrFvAZAIJODRfo3yRi4V802M1ZFHcQLOwgqdzKNJM
 1FTxykGEIG0/N5h3C6Zq6dACSg1qIRf2wu9lm5uHsvaXqloD8YoIk6DFfYjiy8GqWD4vyboXJ
 c+BU1ThNlho18it9MQxaPR/wbc3tkSlZ8Ai8gcZPIzRUfHkhSML45TyhOWSvrD9NC2n2BwI7M
 55IEGR5ptuMO+5pUwE96hHR5u5ZYa9dC9ryGudpX7XUKdTcxTgNNcgC/QZbLZdBLF9IyHxija
 iGAAEeF1fqJBgSrGVrUWp4DRNWRrb1ByyErkY1iO5Sj47wWdX7XxITCT9a6m8v3oRX1uintz7
 OFRhv7G1md03cVFALIp/rKn00eT3ISd/Tuq15piWWh+oa+Tj3GLw2t//FcYY4+BK77em/lDjU
 C5NISwp8SjFIwsb/1LNPlu95CVtrn6CfklC2c5W63ZRtCQvMKX2LiM9p5Pt9tcF2Tk3Ntmk6g
 q2GRb0NYN2+cFuuJyOy8IXNlQxIPm1UBNunlRl4pClZUSU5YMEaS7/r0CAV4JZ28GGFx41ZXh
 pp8fqqWqQ76h9LNwShFi7xcHO7dftHjIPt8EAAQsWXfk+6fyZHwKkBKITXYMjkq20psBT2SeK
 wV21sZIPzgrmL2KL/N41Nh7NAw/zlDarm7TsUFSKVRiKh8R77pX7ntKag/MEQp3Sw/Z2Mminb
 C1KScjsmJfKjskhXRKL1mz3GtJDuodGcNJORiYTe0vBom5nBpdmjf7hiE67XE1LEpav7zSUVt
 P0uRe6BzjZ5atX8QWlJEGCQMZRNQ0Z+A+yaX9siJnjm/7kmWOMGFMfEHg6Lt5ucpmQNd7KkNs
 5+zAMptWELvvwtbxBRO4zo4rItB0OsAOoWCtSi36+bWRRyPzxFlvFwlzKQXDBcW1Lt+PTvMiZ
 oD5k0MtzYqDTq5OR9KFPm6P71/I7pIeeqMjM9qVFyMleyYQuu/YZ91sALBKtX6w2dLPTqlOMh
 9fIY0Y3/oeOdxkqhY/W3utddO29HEU882plwfyLNco9b/GtqjMte+aT/uOlCcAyTjm69euiSh
 JXzK/F9R8ujnOkKXm/kxDtgaa3ne26yQ4lUCRrsRs06GT07WZttFNhR2A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8B=E5=8D=884:31, Martin Steigerwald wrote:
> Martin Steigerwald - 16.07.21, 17:19:55 CEST:
>> Martin Steigerwald - 16.07.21, 17:05:59 CEST:
>>> I migrated to a different laptop and this one has a 2TB Samsung 980 Pr=
o drive
>>> (not a 2TB Samsung 870 Evo Plus which previously had problems).
>>
>> Kernel is:
>>
>> % cat /proc/version
>> Linux version 5.13.1-t14 (martin@[=E2=80=A6]) (gcc (Debian 10.2.1-6) 10=
.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #14 SMP PREEMPT Mo=
n Jul 12 10:36:54 CEST 2021
>
> Another addition that might be important. I am using xxhash.
>
> I created the filesystem like that:
>
> % mkfs.btrfs -L home --csum xxhash /dev/nvme/home
>
> So it is xxhash, discard=3Dasync and space cache v2.

My educiated guess is async.

The reason is that all affected tree blocks are showing a fixed pattern:
have 0x48be03222606a29d expected csum 0x0100000026004000

This pretty much means those tree blocks have been discarded.

But I'm not familiar with that part.

Dennis is more familiar with this, maybe he could provide some idea on thi=
s.

Thanks,
Qu
>
> Maybe something in this combination is not yet fully stable?
>
> https://btrfs.wiki.kernel.org/index.php/Status says additional checksum
> algorithms are stable. It also states free space cache is stable. And it
> states that asynchronous discards are stable. It does not explicitly
> mention xxhash or free space v2 are stable too. I bet it may be included
> in the general statement, but I am not completely sure.
>
> However what I just did is:
>
> % mount -o remount,clear_cache,space_cache=3Dv2 /home
>
> And I now get:
>
> % btrfs scrub status /home
> UUID:             [=E2=80=A6]
> Scrub started:    Sat Jul 17 10:24:54 2021
> Status:           finished
> Duration:         0:01:43
> Total to scrub:   178.39GiB
> Rate:             1.73GiB/s
> Error summary:    no errors found
>
> Hopefully it will stay this way. Fingers crossed.
>
> So a good trick in case there is no file mentioned in kernal log may be =
to clear
> free space tree and see whether the checksum errors go away.
>
> If anyone can make any additional sense out of this, please go ahead.
>
>>> I thought this time I would be fine, but I just got:
>>>
>>> [63168.287911] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63168.287925] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>> [63168.346552] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63168.346567] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>> [63168.346685] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63168.346708] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>> [63168.346859] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63168.346873] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>> [63299.490367] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63299.490384] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>>> [63299.572849] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63299.572866] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 6, gen 0
>>> [63299.573151] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63299.573168] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>> [63299.573286] BTRFS warning (device dm-3): csum failed root 1372 ino =
2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x01000000260=
04000 mirror 1
>>> [63299.573295] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>> [63588.902631] BTRFS warning (device dm-3): csum failed root 1372 ino =
4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701=
000000 mirror 1
>>> [63588.902647] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 13, gen 0
>>> [63588.949614] BTRFS warning (device dm-3): csum failed root 1372 ino =
4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701=
000000 mirror 1
>>> [63588.949628] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 14, gen 0
>>> [63588.949849] BTRFS warning (device dm-3): csum failed root 1372 ino =
4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701=
000000 mirror 1
>>> [63588.949855] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 15, gen 0
>>> [63588.950087] BTRFS warning (device dm-3): csum failed root 1372 ino =
4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701=
000000 mirror 1
>>> [63588.950099] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home e=
rrs: wr 0, rd 0, flush 0, corrupt 16, gen 0
>>
>> Additional errors revealed through scrubbing =E2=80=93 will test the ot=
her
>> filesystems as well:
>>
>> % btrfs scrub status /home
>> UUID:             [=E2=80=A6]
>> Scrub started:    Fri Jul 16 17:08:49 2021
>> Status:           finished
>> Duration:         0:02:05
>> Total to scrub:   203.54GiB
>> Rate:             1.63GiB/s
>> Error summary:    csum=3D5
>>    Corrected:      0
>>    Uncorrectable:  5
>>    Unverified:     0
>>
>> Now totalling to 21 errors:
>>
>> % btrfs device stats /home
>> [/dev/mapper/nvme-home].write_io_errs    0
>> [/dev/mapper/nvme-home].read_io_errs     0
>> [/dev/mapper/nvme-home].flush_io_errs    0
>> [/dev/mapper/nvme-home].corruption_errs  21
>> [/dev/mapper/nvme-home].generation_errs  0
>>
>> Log:
>>
>> [64707.979036] BTRFS info (device dm-3): scrub: started on devid 1
>> [64730.009687] BTRFS warning (device dm-3): checksum error at logical 3=
6997591040 on dev /dev/mapper/nvme-home, physical 34850107392, root 1054, =
inode 2295743, offset 2718461952: path resolving failed with ret=3D-2
>> [64730.009710] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home er=
rs: wr 0, rd 0, flush 0, corrupt 17, gen 0
>> [64730.009721] BTRFS error (device dm-3): unable to fixup (regular) err=
or at logical 36997591040 on dev /dev/mapper/nvme-home
>> [64730.010996] BTRFS warning (device dm-3): checksum error at logical 3=
6997595136 on dev /dev/mapper/nvme-home, physical 34850111488, root 1054, =
inode 4895964, offset 7676579840: path resolving failed with ret=3D-2
>> [64730.011014] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home er=
rs: wr 0, rd 0, flush 0, corrupt 18, gen 0
>> [64730.011024] BTRFS error (device dm-3): unable to fixup (regular) err=
or at logical 36997595136 on dev /dev/mapper/nvme-home
>> [64730.011298] BTRFS warning (device dm-3): checksum error at logical 3=
6997599232 on dev /dev/mapper/nvme-home, physical 34850115584, root 1054, =
inode 4895964, offset 7676579840: path resolving failed with ret=3D-2
>> [64730.011312] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home er=
rs: wr 0, rd 0, flush 0, corrupt 19, gen 0
>> [64730.011319] BTRFS error (device dm-3): unable to fixup (regular) err=
or at logical 36997599232 on dev /dev/mapper/nvme-home
>> [64730.011603] BTRFS warning (device dm-3): checksum error at logical 3=
6997603328 on dev /dev/mapper/nvme-home, physical 34850119680, root 1054, =
inode 4895964, offset 7676579840: path resolving failed with ret=3D-2
>> [64730.011616] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home er=
rs: wr 0, rd 0, flush 0, corrupt 20, gen 0
>> [64730.011623] BTRFS error (device dm-3): unable to fixup (regular) err=
or at logical 36997603328 on dev /dev/mapper/nvme-home
>> [64730.011905] BTRFS warning (device dm-3): checksum error at logical 3=
6997607424 on dev /dev/mapper/nvme-home, physical 34850123776, root 1054, =
inode 4895964, offset 7676579840: path resolving failed with ret=3D-2
>> [64730.011921] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home er=
rs: wr 0, rd 0, flush 0, corrupt 21, gen 0
>> [64730.011928] BTRFS error (device dm-3): unable to fixup (regular) err=
or at logical 36997607424 on dev /dev/mapper/nvme-home
>> [64832.447560] BTRFS info (device dm-3): scrub: finished on devid 1 wit=
h status: 0
>>
>> Why is BTRFS unable to determine a path?
>>
>> How would I fix those when BTRFS does not tell me what file is affected=
?
>>
>>> during a backup.
>>>
>>> According to rsync this is related (why does BTRFS does not report the
>>> affected file?)
>>>
>>> Create a snapshot of '/home' in '/zeit/home/backup-2021-07-16-16:40:13=
'
>>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:4=
0:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/ou=
tput error (5)
>>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:4=
0:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/ou=
tput error (5)
>>> ERROR: martin/.local/share/akonadi/search_db/email/postlist.glass fail=
ed verification -- update discarded.
>>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:4=
0:13/martin/.local/share/baloo/index": Input/output error (5)
>>> rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:4=
0:13/martin/.local/share/baloo/index": Input/output error (5)
>>> ERROR: martin/.local/share/baloo/index failed verification -- update d=
iscarded.
>>>
>>> Both are frequently written to files (both Baloo and Akonadi have very=
 crazy
>>> I/O patterns that, I would not have thought so, can even satisfy an NV=
Me SSD).
>>>
>>> I thought that a Samsung 980 Pro can easily handle "discard=3Dasync" s=
o I
>>> used it.
>>>
>>> This is on a ThinkPad T14 Gen1 with AMD Ryzen 7 PRO 4750U and 32 GiB o=
f RAM.
>>>
>>> It is BTRFS single profile on LVM on LUKS. Mount options are:
>>>
>>> rw,relatime,lazytime,compress=3Dzstd:3,ssd,space_cache=3Dv2,subvolid=
=3D1054,subvol=3D/home
>>>
>>> Smartctl has no errors.
>>>
>>> I only use a few (less than 10) subvolumes.
>>>
>>> I do not have any other errors in kernel log, so I bet this may not be
>>> "discard=3Dasync" related. Any idea?
>>
>> Maybe I still remove "discard=3Dasync" for now. Maybe it is not yet ful=
ly reliable.
>>
>>> Could it have to do with a sudden switching off the laptop (there had
>>> been quite some reasons cause at least with a AMD model of this laptop
>>> in combination with an USB-C dock by Lenovo there are quite some stabi=
lity
>>> issues)? I would have hoped that the Samsung 980 Pro would still be
>>> equipped to complete the outstanding write operation, but maybe it has
>>> no capacitor for this.
>>>
>>> I am really surprised by the what I experienced about the reliability =
of
>>> SSDs I recently bought. I did not see a failure within a month with an=
y
>>> of the older SSDs. I hope this does not point at a severe worsening of
>>> the quality. Probably I have to fit another SSD in there and use BTRFS
>>> RAID 1 again to protect at least part of the data from errors like thi=
s.
>>>
>>> Any idea about this? I bet you may not have any, as there is not block
>>> I/O related errors in the log, but if you have, by all means share you=
r
>>> thoughts. Thank you.
>>>
>>> Both files can be recreated. So I bet I will just remove them.
>>>
>>> Best,
>>
>
>
