Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9534ACDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCZQwQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZQvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 12:51:52 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA8CC0613AA;
        Fri, 26 Mar 2021 09:51:52 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id g5so1809687uan.8;
        Fri, 26 Mar 2021 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2D8fKe1kJmw+FqMP6GSfjkKnsl+eOZTz7WSG9AS6Ffo=;
        b=pABaX4UEl9W8qQyUvGc5sV7j+b7QBbKN4OI8CqgMCuOLI3PJ9RF3Dw4KUmcloMqcFl
         +zzzvin+q7ewM2VkBvZt2enXBP4Os2eUIMWMPsblwdhCUnBjTg9DRfV49G5EsPlYpu8W
         g7+mRhWV/nXdcrZBlFIIaGnfDelV7QoGlKQgr3VaVDTyB8Nofmw6SA5tR/VvSXeRJQQ0
         wdMmsRe+ZbZOw49xpPAD4al0iHcRIG+QY4XtcAuRchXWf4az9ZwzHM6Ummbq+kKWHmHv
         /2vQBvl69S/RiozUHeGIbQ8Zd0bkuEgVRqN1GqoSMzvCxm3lYN7yPLpnSW/3mfVCANT3
         nTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2D8fKe1kJmw+FqMP6GSfjkKnsl+eOZTz7WSG9AS6Ffo=;
        b=GaVlLdILTryOSP+DScdj18n50f9r/WBjlVGzI1lIDJJgTHVmXaHDBbJNuCA4hPHf1j
         lajK1Ty0uh4C7cx02gNcH4ZykMn0FXFuKeIpkE9lTUhfPRR/OMAS/bxi30szDRdm2iF9
         3XR3kDYOr/PnEpYpJx1RLby/QTwLiHBfDFA2zaj/7hp7kiBYNR4WrNLqn9P1+NK3+0gx
         m/ItJXzBHlrzja2X1DuRod2zqFEw1C96pNqvWtrGUWPDZtqVrx0gRf3cBPbsmnHMxTCs
         VPd5t/rKXyefZzvURrzsDu833Xa22XVCwYFvdRUwB/Qf/EZxTLJerx3o3d7BR/siZj2t
         lhhw==
X-Gm-Message-State: AOAM533r3Mhk31hT/6I7D0blC0wUgSLP00TLG8pHuBE3/9z4XO8Rdzfc
        bBiGuiGnzDwT1quKIDDkBPnZBxsTpb1WMbyjV/M=
X-Google-Smtp-Source: ABdhPJyxGLF8mF7Ms9BXiw8q6alUi3XVkTnCbTDpARXnbS9SC9YJOrSBzKMEmd6ktO8475x3nBR5H09CBHx7RqA3AYU=
X-Received: by 2002:ab0:7254:: with SMTP id d20mr8851582uap.98.1616777511557;
 Fri, 26 Mar 2021 09:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALaQ_hrZZmAi2AKtmCm2QUXeg9VWuyeWmmk__OFEG1ycHMiX8A@mail.gmail.com>
In-Reply-To: <CALaQ_hrZZmAi2AKtmCm2QUXeg9VWuyeWmmk__OFEG1ycHMiX8A@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Fri, 26 Mar 2021 11:51:40 -0500
Message-ID: <CALaQ_hoXDSP7Fe4SWFArHbv2ppmoKKPVEXTkO-Ex0FsjKaYd=w@mail.gmail.com>
Subject: Re: BTRFS Balance Hard System Crash (Blinking LEDs)
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oh man, I'm hoping things aren't starting to fall apart here.
I was doing my normal routine (tv, browsing, ... (no filesystem
manipulations)) and out of the blue "kodi" just crashes. It's actually
not all that uncommon, and I fired up "iotop" to make sure "coredump"
was happening, and it was.
I then did something else in the terminal, maybe an "ls", and that came up with:
*****
error while loading shared libraries: /usr/lib/libutil.so.1: ELF file
version does not match current one
*****
Again, it was just out of the blue. Same with other commands like
"coredumpctl" or "sync". Even "pacman -Qo /usr/lib/libutil.so.1"
caused SEGV.
Everything seemed fine after I had last booted (minus what I wrote in
my last email).
And the oddest thing is that, like I said before, my system/root stuff
(eg, /usr/lib/libutil.so.1) is being run from my sd-card (F2FS, not
BTRFS).

I see the coredumps were written out ~11:05, and journalctl started
showing issues arise ~10:56 (typically takes a long time to write out
on a slow sd-card):
*****
...
Mar 26 11:05:13 computerName systemd-coredump[70088]: Process 70078
(pacman) of user 1000 dumped core.

                                                Stack trace of thread 70078:
                                                #0  0x000075cf62ee58a5
do_lookup_x (ld-linux-x86-64.so.2 + 0xa8a5)
                                                #1  0x000075cf62ee6231
_dl_lookup_symbol_x (ld-linux-x86-64.so.2 + 0xb231)
                                                #2  0x000075cf62ee7dc7
_dl_relocate_object (ld-linux-x86-64.so.2 + 0xcdc7)
                                                #3  0x000075cf62edfcdd
dl_main (ld-linux-x86-64.so.2 + 0x4cdd)
                                                #4  0x000075cf62ef769f
_dl_sysdep_start (ld-linux-x86-64.so.2 + 0x1c69f)
                                                #5  0x000075cf62edd063
_dl_start (ld-linux-x86-64.so.2 + 0x2063)
                                                #6  0x000075cf62edc098
_start (ld-linux-x86-64.so.2 + 0x1098)
...
Mar 26 11:05:10 computerName kernel: Code: b4 24 d0 00 00 00 49 89 df
48 89 44 24 38 48 89 fb 4c 89 5c 24 60 eb 12 0f 1f 44 00 00 49 83 c4
04 83 e2 01 0f 85 f3 05 00 00 <41> 8b 04 24 48 89 c2 48 31 d8 48 d1 e8
75 e4 48 83 ec 08 4c 89 e0
Mar 26 11:05:09 computerName kernel: pacman[70078]: segfault at
75d29d0d5640 ip 000075cf62ee58a5 sp 00007ffffad0e460 error 4 in
ld-2.33.so[75cf62edc000+24000]
...
Mar 26 10:58:59 computerName kernel: Code: 84 e7 05 00 00 44 8b 33 45
85 f5 74 e4 66 0f ef ff 66 0f ef f6 66 0f ef e4 48 89 ef f3 0f 10 44
24 48 66 0f ef db 66 0f ef d2 <66> 0f 42 a0 61 72 70 cb ee 33 bb 14 5f
79 1d 76 e5 28 0f 11 44 24
Mar 26 10:58:59 computerName kernel: chrome[41222]: segfault at
ffffffffcb707262 ip 000077cb36b101ae sp 00007fff250007c0 error 5 in
i965_dri.so[77cb36aa9000+8fa000]
...
Mar 26 10:58:25 computerName plasmashell[43148]: KCrash: Application
Name = kate path = /usr/bin pid = 43148
Mar 26 10:58:25 computerName plasmashell[43148]: KCrash: crashing...
crashRecursionCounter = 2
Mar 26 10:58:07 computerName systemd[1424]: Started Kate - Advanced Text Editor.
...
Mar 26 10:56:51 computerName sudo[69237]:    userName : TTY=pts/3 ;
PWD=/<path> ; USER=root ; COMMAND=/usr/bin/iotop
...
Mar 26 10:56:32 computerName kernel: audit: type=1701
audit(1616774192.320:455): auid=1000 uid=1000 gid=1000 ses=3 pid=54221
comm="VideoPlayer" exe="/usr/local/lib/kodi/kodi.bin" sig=11 res=1
Mar 26 10:56:32 computerName kernel: Code: 00 00 01 00 00 00 00 00 00
00 02 04 00 00 48 7b 00 00 10 49 4a d0 48 7b 00 00 00 00 00 00 01 00
00 00 55 00 00 00 00 00 00 00 <d9> d8 8f 34 4f 7b 00 00 00 39 10 d0 48
7b 00 00 00 00 fa 00 00 fa
Mar 26 10:56:32 computerName kernel: VideoPlayer[61823]: segfault at
7b48d0579730 ip 00007b48d0579730 sp 00007b48ff043248 error 15
...
*****
As you can see, pretty much everything was crashing (probably not
surprising if glibc is involved).
Now, like I said, I don't believe it's related to my BTRFS drive since
glibc was referenced which is located on my F2FS drive.
I ended up rebooting (again) and everything seems fine (so far) as I
write this and have the recorded DVR playing (kodi).
I don't know what those "kernel: Code:" is supposed to be/mean to me.

On Fri, Mar 26, 2021 at 8:29 AM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> *****
> ...I "think" this is where the "emergency" drop out of boot occurred,
> and I just did a "systemctl reboot" which had the next boot succeed.
> Nope, I'm wrong. For whatever reason, this appears to be the boot that
> ended up working (searching for the first "microcode" reference
> indicating the start of a boot).
> Mar 25 21:44:17 computerName kernel: BTRFS critical (device dm-3):
> unable to add free space :-17
...
