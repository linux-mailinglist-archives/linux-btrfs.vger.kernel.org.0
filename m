Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D201E4C2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbgE0RmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388598AbgE0RmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 13:42:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF0FC03E97D
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:42:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w3so311309qkb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GhXGAsMtZl3K20MWPRpirWplrrOBl0JllHeghFPfpd4=;
        b=n591v19+1B6BURIomJecWr6dMNnSNcKFpz0f/tU4WzRqJwgoanB5nFF0PssGkD54hT
         h/fzqLgxdh0dGHY85FsuGkdMk+3H7YqDW8PX6y2aMyhan0jkRjFUCB2mXGBNic3oPeWi
         OR/Taw/w0N1tHHOMuPFZUA6zkpAzFp1sSLTb5vH0yqwFHTWH0HckLHfHa6pQkgQbP71z
         JHu5l7AjQZWtY1AoDH0495loyedCu5rxc5Tz7Msj4QQCtD5nilnDJxb8fK/nZEWuSErG
         WEgjOhBS6TmOaSVYge//4zaVJXyprpCpwlYCIpkCPDyp+QXsrlzHWYp4tJhOsMGHLqn0
         rXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GhXGAsMtZl3K20MWPRpirWplrrOBl0JllHeghFPfpd4=;
        b=hLfakscq9Ginm3fM5mGFwB0f3oBlhhvNaw0Cozs9/i08IOdZi0YIBXh56IYdlF3ng0
         1SAw62MLiLdoztWWh0ZXyj0xY4OqEf8swI2vNug8pRqndLo3FTDa53gxAlv+jB9hcyJf
         1Dh5YeDUl3nLx/XMLNfF/IpeFFOPTON1XB+WWzBcc0xGe2999I6wZyrsXQLLpv98WRqY
         1L9LDU2fKgd/iEGOLJVQEh+YgECLWzzI78ZFRh4NL9ztMb2cc9s9+gamODDwub+Swkb9
         MtQsxCfpNcISpu7HNRx0QDReMhWB5HY0kNT2F2JsXXCQdycI8iAxGQhvuh41o1xISSMJ
         7Z6Q==
X-Gm-Message-State: AOAM53111qeaE7KAyQlK0KM/0CWBbpkkozg7SP3NCBbb3/+sHI4hu324
        2IPw9jZxkaKQtdX4Qd3UK3b9rnKV+89BOZXGU/Fcnw==
X-Google-Smtp-Source: ABdhPJyip1M8uxHqR593YUThunKtkCNiW02A2oiYTVtpvS++fgDGPC5jJpcVZxjw0XPrCHpa1uRFvt2AFUPCWfRGQkI=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr3366488qke.128.1590601319961;
 Wed, 27 May 2020 10:41:59 -0700 (PDT)
MIME-Version: 1.0
From:   Tolga Cakir <cevelnet@gmail.com>
Date:   Wed, 27 May 2020 19:41:49 +0200
Message-ID: <CABcamCBSHbYx7akG9uzvRrdjwQtgJ4+h4Uhh2_oZUb3jw+N9Dg@mail.gmail.com>
Subject: Re: Re: Planning out new fs. Am I missing anything?
To:     Chris Murphy <lists@colorremedies.com>,
        Justin Engwer <justin@mautobu.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 27.05.2020 um 04:20 schrieb Chris Murphy:
>
> On Sun, May 24, 2020 at 7:13 PM Justin Engwer <justin@mautobu.com> wrote:
>>
>> Hi, I'm the guy who lost all his VMs due to a massive configuration oversight.
>>
>> I'm looking to implement the remaining 4 x 3tb drives into a new fs
>> and just want someone to look over things. I'm intending to use them
>> for backup storage (veeam).
>>
>> Centos 7 Kernel 5.5.2-1.el7.elrepo.x86_64
>> btrfs-progs v4.9.1
>
> I suggest updating the btrfs-progs, that's old.
>>
>> mkfs.btrfs -m raid1c4 -d raid1 /dev/disk/by-id/ata-ST3000*-part1
>> echo "UUID=whatever /mnt/btrfs/ btrfs defaults,space_cache=v2 0 2" >> /etc/fstab
>> mount /mnt/btrfs
>
> Add noatime.
> https://lwn.net/Articles/499293/
>
> I don't recommend space_cache=v2 in fstab. Use it once manually with
> clear_cache,space_cache=v2, and a feature flag will be set to use it
> from that point on. Soon v2 will be the default and you won't have to
> worry about this at all.
>
> fs_passno should be 0 for btrfs. man fsck.btrfs - it's a no op, it's
> not designed for unattended use during startup. XFS is the same.
>
>
>> RAID1 over 4 disks and RAID1C4 metadata. Mounting with space_cache=v2.
>> Any other mount switches or btrfs creation switches I should be aware
>> of? Should I consider RAID5/6 instead? 6tb should be sufficient, so
>> it's not like I'd get anything out of RAID5, but RAID6 I suppose could
>> provide a little more safety in the case of multiple drive failures at
>> once.
>
> single, dup, raid0, raid1 (all), raid10 are safe and stable. raid56
> has caveats and you need to take precautions that kinda amount to hand
> holding. If there is a crash or power fail you need to do a scrub
> (full file system scrub) when raid56. It's a good idea, but not "very
> necessary" with other profiles. If you mount raid56 degraided, you
> seriously need to consider not doing writes or being very skeptical of
> depending on those writes because there's some evidence of degraded
> writes being corrupted.
>
> You can check the archives for more information from Zygo, about
> raid56 pitfalls. It is table on stable storage. But the point of any
> raid is to withstand a non-stable situation like a device failure. And
> there's still work needed on raid56 to get to that point, without
> handholding.
>
> If you need raid5, you might consider mdadm for the raid5, and then
> format it with btrfs using defaults which will get you DUP metadata
> and single copy data. You'll get cheap snapshots. Faster scrubs. And
> warnings for any corruptions of metadata or data.

Does btrfs allow scrubbing single files? If that's the case, I think
offline healing could be possible with btrfs ontop of mdadm RAID5.
*If* the corruption is at mdadm level, it would be reported under
/sys/block/mdX/md/mismatch_cnt after an mdadm scrub.

mdadm doesn't know, which device holds the corrupt data and thus will
(afaik) randomly pick one and return it. But btrfs knows, what exactly
is corrupt. Assuming you have mdadm with N devices in RAID5 and
corrupt file "/somefile.raw", the following could identify the
corrupted drive:

1. Unmount the btrfs volume and stop mdadm device.
2. Re-assemble mdadm device as read-only (!), but with only N-1 devices.
3. Mount btrfs as read-only.
4. Let btrfs scrub the corrupt file "/somefile.raw".
5. If btrfs reports no checksum error -> congrats. You can update your
backup and recover your data.
6. If btrfs still reports checksum error, repeat the whole process,
but pick another group of N-1 devices, which you haven't scanned yet.

For further clarification: in an example of 3 devices, you would scrub
sda+sdb, sda+sdc and sdb+sdc.

This could be a simple bash script. And since btrfs scrub only needs
to be done on corrupted files (and not the whole filesystem), the
process would be fast. Furthermore, since everything is mounted as
read-only, it's worth a try and non-destructive.

Please note, I'm not an expert. This could be a very bad idea and
trash your data. Just had this idea, some time ago and wanted to
discuss it here.

The interesting part is, what happens after identifying the corrupt
device? If there are no further (mdadm) mismatches, re-adding the
"bad" device as new and resyncing might get you up and running again.
To be safe, you'd need to mdadm scrub the good pair of N-1 devices,
slowing down the whole process. And you're out of options, if
mismatches occur.

Optimally, mdadm would allow you to flag the underlying block of the
corrupted data as bad and resync it from known-good devices (which we
have identified above). In that case, even more complex corruption
scenarios could be recoverable. But I'm not aware mdadm offers such
tools.

Either way, I think this is only interesting for data recovery. Any
thoughts on this?

Cheers,
Tolga

>
> Also consider mkfs.btrfs --checksum=xxhash, but you definitely need
> btrfs-progs 5.5 or newer, and kernel 5.6 or newer. If those are too
> new for your use case, skip it. crc32c is fine, but it is intended for
> detection of casual incidental corruption and can't be  used for
> dedup. xxhash64 is about as fast, but much better collision
> resistance.
>
