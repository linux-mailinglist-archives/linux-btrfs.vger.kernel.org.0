Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10DD295212
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503981AbgJUSTL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 14:19:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409748AbgJUSTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 14:19:11 -0400
Received: from [192.168.177.20] ([91.63.161.114]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1Mnac7-1k6Nor49Ez-00jaLk; Wed, 21 Oct 2020 20:19:05 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[2]: parent transid verify failed: Fixed but re-appearing
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Wed, 21 Oct 2020 18:19:02 +0000
Message-Id: <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
In-Reply-To: <20201021134635.GT5890@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.37929.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ltUKUsnk3gcnY195hUCwJdOtGd3pBGfsnKP5xwG3ttfvcvJdwGL
 t3gtU/o8Swn2NIDv5lacBBdwtMC3yckJHX3MJ+BQ7oFP12RVyzNpw9rcAeOocwUa31vb2l4
 bbipU/cS/9laYxjheTWJD0p5P7mn/7YjXQhZanRj6rcBcsrqprV6AMiM01zCzcwOSUaNOMu
 jowE9ujtZ2CBGqNbt2vhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9thkXC9sShs=:O5lptJWMXUUWYtmsEiDjQs
 Hm3ixNnaIBBMMCj2vbU+9cy+DWf7xGq8hO3rYJH90yt8bF91q7JZ54f1YvKyKiU8SUC4cCr93
 u0rr3eaEGUBV82FnIZozGRLJAS728O2dwNgBZ3rddsFVCk92WObVuRuvRhwkJAGv9PoTZ/+g5
 zNt4Ae8loWy0UJJPwkUSqdXaXJoY0aRNqLhlndZ55J3YnUTCxcH09yfMOwCsbprGBEXhib3ri
 RGjoyTaFfRiZ4HHT3MOn41T/UYpd38XqlPMGhmF0EjisF4zrS9ct6wlwDYjSvgcYpoH14cQuF
 T9xFp69KAHMRBHSymO1jvJtytO6J7Hlg0owT0fTFF2aNnt6UUOd3rPSEsvg1looO2gsitnegH
 PTPnMKM8S4JBAoK00V7Q1f3k/dXBNuv89uDbJ4oLS0XD58NKtpMQT/r37Y4UsarSJ/P6FR8Cy
 yYGNWzGSow==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Zygo,

thanks for your reply.

>Were there any other symptoms?  IO errors?  Inaccessible files?  Filesystem
>remounted read-only?
>
No, not at all.


>
>>  I cured that by unmounting and
>>    mount -t btrfs -o nospace_cache,clear_cache /dev/sda1 /mnt/test
>
>That command normally won't cure a parent transid verify failure if it
>has been persisted on disk.  The only command that can fix ptvf is 'btrfs
>check --repair --init-extent-tree', i.e. a full rebuild of btrfs metadata.

Hm, it would be good to document that somewhere.
I found
https://askubuntu.com/questions/157917/how-do-i-recover-a-btrfs-partition-that-will-not-mount
(there I found that recommendation)
https://stackoverflow.com/questions/46472439/fix-btrfs-btrfs-parent-transid-verify-failed-on/46472522#46472522
Here the selected answer says:

"Surfing the web I found a lot of answers recommending to clear btrfs' 
internal log by using btrfs-zero-log. I thought btrfsck could help but 
eventually I discovered the official recommendation which is to first 
just start a btrfs scrub before taking other actions!"


>
>>  After that, I was able to run that dduper command without a failure.
>>  But some days later, the same command resulted in:
>>    parent transid verify failed on 16465691033600 wanted 352083 found 352085
>>
>>  again.
>>
>>  A scrub showed no error
>>   btrfs scrub status /dev/sda1
>>  scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>          scrub started at Mon Oct 19 21:07:13 2020 and finished after
>>  15:11:10
>>          total bytes scrubbed: 6.56TiB with 0 errors
>
>Scrub iterates over all metadata pages and should hit ptvf if it's
>on disk.

But apparently it did not?!

>>  Filesystem info:
>>   btrfs fi show /dev/sda1
>>  Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>          Total devices 2 FS bytes used 6.56TiB
>>          devid    1 size 7.28TiB used 6.75TiB path /dev/sda1
>>          devid    2 size 7.28TiB used 6.75TiB path /dev/sdj1
>
>If you have raid1 metadata (see 'btrfs fi usage') then it's possible

  btrfs fi usage /srv/dev-disk-by-label-DataPool1
Overall:
     Device size:                  14.55TiB
     Device allocated:             13.51TiB
     Device unallocated:            1.04TiB
     Device missing:                  0.00B
     Used:                         13.12TiB
     Free (estimated):            731.48GiB      (min: 731.48GiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)

Data,RAID1: Size:6.74TiB, Used:6.55TiB
    /dev/sda1       6.74TiB
    /dev/sdj1       6.74TiB

Metadata,RAID1: Size:15.00GiB, Used:9.91GiB
    /dev/sda1      15.00GiB
    /dev/sdj1      15.00GiB

System,RAID1: Size:32.00MiB, Used:992.00KiB
    /dev/sda1      32.00MiB
    /dev/sdj1      32.00MiB

Unallocated:
    /dev/sda1     535.00GiB
    /dev/sdj1     535.00GiB

So it looks like it is raid1 metadata

>only one of your disks is silently dropping writes.  In that case
>btrfs will recover from ptvf by replacing the missing block from the
>other drive.  But there are no scrub errors or kernel messages related
>to this, so there aren't any symptoms of that happening, so it seems
>these ptvf are not coming from the disk.
And can this be confirmed somehow? Would be good to replace that disk 
then...

>
>>  The system has a USV. Consequently, it should not experience any power
>>  interruptions during writes.
>>
>>  I did not find any indications of it in /var/log/*
>>  (grep  -i btrfs /var/log/* | grep -v snapper |grep sda)
>>
>>  What could be the reason for this re-appearing issue?
>
>What kernel are you running?
5.6.12 since May 11th. Before that, (since Jan 5th) I ran 5.4.8.


>  Until early 2020 there was a UAF bug in tree
>mod log code that could occasionally spit out harmless ptvf messages and
>a few other verification messages like "bad tree block start" because
>it was essentially verifying garbage from kernel RAM.
Of course I did use older kernels in the past. But as I understand this 
bug, it would only give spurious error messages but not have caused any 
errors on the disk that would be now hit?

Regards,
Hendrik

