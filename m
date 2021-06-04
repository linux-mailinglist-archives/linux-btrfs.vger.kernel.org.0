Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0FA39B5F7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFDJad (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 05:30:33 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44938 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhFDJac (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 05:30:32 -0400
Received: by mail-ed1-f42.google.com with SMTP id u24so10316777edy.11
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DVDOVdJkvgvh+1QrCeXZlxaqMVDosQZNthV0/1dlgsw=;
        b=tR5HT5YcjmYqNPZR0cFog8TWPyVrW0mIbpfF54Bos+fbTa3yPfjmuNQ6N6ih+mgGXp
         m44GO+FQODtxteTVGyFm4URax74dgLjpU0l5EjLyBfVpbh4VDECw6AWdzQORbZVUEsYx
         37gdZh1rQJ34XAXwpUHdgDoDXWTuMXo6f/7T4imiAaWtjuh52neNFyinlxyq2wmhpiNW
         aH/ZpwRbesMePjJ4dpv6gSpYoSPY8GPNHAn2geWxA/KolTUtkD9dAbbBLNMm9r+qV/xk
         vhYekOeKFcGtdFYsmYaAfqRGPi9ExcZAFEIrjyXwTs3T+YCV3LVep+ieuzGKtQZeZwAS
         xnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DVDOVdJkvgvh+1QrCeXZlxaqMVDosQZNthV0/1dlgsw=;
        b=GMNyfwRx4tpcj9SMMBvtzgkXOwgS9G545/dgbUtDb1djo+2W5Y5vBOle7D+zk26jTb
         v3dkq1uPkoP8P2Luz2JQiL0ibE4hLrhGMbuS1ubwRQSFO9vG0gX8hGu8M50LRSYyCVUA
         TZv4PRGNR2f6o3P7Q80XNkB/I4u3dtAp8ewOjNKRfA8Q6/tPMsQHNlmBSSmRp5vPM48B
         KuenPDaLpMc0NUcspQkvH9apgQ8uTBppwuZ6cU/Ytru/3YMoU1VFKVefNQnIDr5fnOT2
         xz0EuBV42BmZC9Mx9eJJd6SyuTP3MzuBJXxJjdNnOVuF54cO3rPY9SM9ZOde78jC7TXf
         /85Q==
X-Gm-Message-State: AOAM533TVdIgqZjicaZgjvBWQm4wTFIkw74ZrcuuoKuKYYT1OikRc7Iz
        ABCCyHbJlhMMJfWj7toTIx+a72xxfQE1dA==
X-Google-Smtp-Source: ABdhPJy5bELOccCuIp9RHDdKWoYvc5frdSOHq9ulRS9/8HBNu/Orl3odUbVO/FPtCRx9qGV9LnR5hg==
X-Received: by 2002:aa7:d64f:: with SMTP id v15mr3615856edr.255.1622798866145;
        Fri, 04 Jun 2021 02:27:46 -0700 (PDT)
Received: from ?IPv6:2001:984:3171:0:e9c3:434a:4798:3f72? ([2001:984:3171:0:e9c3:434a:4798:3f72])
        by smtp.gmail.com with ESMTPSA id n15sm2904392eds.28.2021.06.04.02.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 02:27:45 -0700 (PDT)
Subject: Re: Corrupted data, failed drive(s)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
 <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com>
From:   Gaardiolor <gaardiolor@gmail.com>
Message-ID: <5272b826-ec8e-f3a3-6fc1-bb863b698c83@gmail.com>
Date:   Fri, 4 Jun 2021 11:27:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris,

Thanks for your reply. Just noticed I forgot to mention I'm running 
kernel 5.12.8-300.fc34.x86_64 with btrfs-progs-5.12.1-1.fc34.x86_64 .


>> I have a couple of questions:
>>
>> 1) Unpacking some .tar.gz files from /storage resulted in files with
>> weird names, data was unusable. But, it's raid1. Why is my data corrupt,
>> I've read that BTRFS checks the checksum on read ?
> 
> It suggests an additional problem, but we kinda need full dmesg to
> figure it out I think. If it were just one device having either
> partial or full failure, you'd get a bunch of messages indicating
> those failure or csum mismatches as  well as fixup attempts which then
> either succeed or fail. But no EIO. That there's EIO  suggests both
> copies are somehow bad, so it could be two independent problems. That
> there's four drives with a small number of reported corruptions could
> mean some common problem affecting all of them: cabling or power
> supply.
> 

First try on unpacking the .tar.gz worked. Second try on the same 
.tar.gz now results in:

gzip: stdin: Input/output error
tar: Unexpected EOF in archive
tar: Unexpected EOF in archive
tar: Error is not recoverable: exiting now

dmesg:
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247860736 csum 0x545eef4e expected csum 0x2cd08f83 
mirror 1
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs: 
wr 0, rd 0, flush 0, corrupt 323, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5 
mirror 1
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs: 
wr 0, rd 0, flush 0, corrupt 324, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5 
mirror 2
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs: 
wr 0, rd 0, flush 0, corrupt 409, gen 0
[Fri Jun  4 09:53:03 2021] repair_io_failure: 326 callbacks suppressed
[Fri Jun  4 09:53:03 2021] BTRFS info (device sdc): read error 
corrected: ino 5114941 off 5247860736 (dev /dev/sdb sector 6674359360)
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5 
mirror 1
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs: 
wr 0, rd 0, flush 0, corrupt 325, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5 
mirror 2
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs: 
wr 0, rd 0, flush 0, corrupt 410, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5 
mirror 1
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs: 
wr 0, rd 0, flush 0, corrupt 326, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5 
mirror 2
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs: 
wr 0, rd 0, flush 0, corrupt 411, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x79b50174 expected csum 0xa744e4f5 
mirror 1
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sdb errs: 
wr 0, rd 0, flush 0, corrupt 327, gen 0
[Fri Jun  4 09:53:03 2021] BTRFS warning (device sdc): csum failed root 
5 ino 5114941 off 5247864832 csum 0x81568248 expected csum 0xa744e4f5 
mirror 2
[Fri Jun  4 09:53:03 2021] BTRFS error (device sdc): bdev /dev/sda errs: 
wr 0, rd 0, flush 0, corrupt 412, gen 0

No weird filenames though, and no sdd errors this time. I also see these 
errors in /var/log/messages (on a different filesystem), but I don't see 
any "csum failed" errors in the messages log of yesterday, when the 
strange filenames appeared..

> 
>> 2) Are all my 4 drives faulty because of the corruption_errs ? If so, 4
>> faulty drives is somewhat unusual. Any other possibilities ?
>> 3) Given that
>> - I can't 'btrfs device remove' the device
>> - I do not have a free SATA port
>> - I'd prefer a method that doesn't unnecessarily take a very long time
> 
> You really don't want to remove a drive unless it's on fire. Partial
> failures, you're better off leaving it in, until ready to be replaced.
> And even then it is officially left in until replace completes. Btrfs
> is AOK with partially failing drives, it can unambiguously determine
> when any block is untrustworthy. But the partial failure case also
> means possibly quite a lot of *good* blocks that you might need in
> order to recover from this situation, so you don't want to throw the
> baby out with the bath water, so to speak.
>
I think we're mixing 'btrfs device remove' with physically remove. I did 
not plan on physically remove, but I might be forced because the 
graceful 'btrfs device remove' results in an I/O error. Or is there a 
better way ? Can 'btrfs device remove' ignore errors and continue with 
the good blocks?

My guess was that btrfs remove would take a very long time, I'd have a 
new drive before it would be finished. I had enough free space available 
to remove this device without adding a new drive. Did at the time not 
realize the other 3 drives had issues as well though.

>>
>> What's the best way to migrate to a different device ? I'm guessing,
>> after doing some reading:
>> - shutdown
>> - physically remove faulty disk
>> - boot
>> - verify /dev/sdd is missing, and that I've removed the correct disk
>> - shutdown
>> - connect new disk, it will also be /dev/sdd, because I have no other
>> free SATA port
>> - boot
>> - check that the new disk is /dev/sdd
>> - mount -o degraded /dev/sda /storage
>> - btrfs replace start 4 /dev/sdd /storage
>> - btrfs balance /storage
> 
> You can but again this throws away quite a lot of good blocks, both
> data and metadata. Only if all three of the other drives are perfect
> is this a good idea and there's some evidence it isn't.
> 
> I'd say your top priority is freshen the backups of most important
> things you cannot stand to lose from this file system in case it gets
> much worse. Then try to figure out what's wrong and fix that. The
> direct causes need to be discovered and fixed, and the above sequence
> doesn't identify multiple problems; it just assumes it's this one
> drive. And the available evidence suggests more than one thing is
> going on. If this is cable or dirty/noisy power supply related, the
> recovery process itself can be negatively affected and make things
> worse (more corruptions).
> 
> I think a better approach, as finicky as they can be, is a USB SATA
> enclosure connected to an externally powered hub. Really you want a
> fifth SATA port, even if it's eSATA. But barring that, I think it's
> less risky to keep all four drives together, to do the replacement.
> 

Yes, a fifth SATA port is a good idea. I did plan for this too, I 
actually have 6 SATA ports. What I didn't realize though is that 2 are 
disabled because I I installed 2 NVME drives. Should have read the fm :)

Apart from the general problem I might have (PSU for example), I might 
be able to hook up the new drive temporary via USB3 ? But, what would be 
the approach then ? I'd still need to 'btrfs device remove' sdd right, 
to evict data gracefully and replace it with the new one. But, btrfs 
remove results in an I/O error.

Turns out my drives aren't very cool though. 2 have >45k hours, 2 have 
 >12k which should be kinda ok, but are SMR. Just might be that they are 
all failing.. any idea how plausible that scenario could be ?

sda
   Model Family:     Seagate Barracuda 7200.14 (AF)
   Device Model:     ST2000DM001-1ER164
   TBR: 1350.26 TB
   TBW: 30.4776 TB
   Power_On_Hours 47582

sdb
   Model Family:     Seagate BarraCuda 3.5 (SMR)
   Device Model:     ST4000DM004-2CV104
   TBR: 6.71538 TB
   TBW: 32.5086 TB
   Power_On_Hours 12079

sdc
   Model Family:     Seagate BarraCuda 3.5 (SMR)
   Device Model:     ST4000DM004-2CV104
   TBR: 9.48872 TB
   TBW: 34.1534 TB
   Power_On_Hours 12079

sdd
   Model Family:     Seagate Barracuda 7200.14 (AF)
   Device Model:     ST2000DM001-1ER164
   TBR: 863.043 TB
   TBW: 28.6935 TB
   Power_On_Hours 47583

Thanks
