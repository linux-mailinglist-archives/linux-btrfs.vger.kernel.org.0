Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF477C77E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Oct 2023 22:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442643AbjJLU0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 16:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442502AbjJLU0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 16:26:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960ABE
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 13:26:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c746bc3bceso3783125ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697142363; x=1697747163; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:reply-to:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nqtu2MXdMyWmDzNlMZsVHtnUFpqBZDqhmlf2cnnujo=;
        b=SIc3l/l9s4WEzZVxdrfcsVUAYg3IoGsM0XKCXtDrD5R92WZZiejdM/jFAYMBRXe28v
         rdQS1XX+W6ZiDbvr0jZCHAGSTY1rLXpGFl1KJN1VZlXV5lzYb41xAVBxqUyqzV0U31CK
         uv65JJK35u4aBm1bGs2jehYu+1Kyha3CGeg9JWK0XHn8JpJHli1M6k/mySXHKTIKpGGg
         7mnRhXBBXdzoLT1V8zJBCz4MpcIL8DXMD4r1ZSlehdET2jWBrH7YZKtMA2oikY6EgaIF
         zEfL1t4iRXLsyvfmekOW2xvsuqQq2qAdbJ9CBZBGJb0J9lkkcyv8A5wp/bTU4pyldSxx
         oDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697142363; x=1697747163;
        h=content-transfer-encoding:subject:from:content-language:reply-to:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Nqtu2MXdMyWmDzNlMZsVHtnUFpqBZDqhmlf2cnnujo=;
        b=jkwp1eSTe8N2lqacmRyYE25kGsxU1uL7rw+r6HZodY3AJaCOBp3sj523cgZ4t9IQk6
         pDoqRaApkUNUj6FcRXDRKVxWf7Kpfv8PBW0WlcvKyDQJp6kqLmiBX/J0dHyt3W74A7kw
         y/h4DGO+g6sBMdABPaVprUAkbNNbnD3NfIRiQTXizqk/OxMmRWh5DgmBQw48bPcS220g
         uPq3H2fRUsDD9xV7ftLmxRAAs7ZpGUaWrdEGhnj7LMwXcirfCn4EEl/dZojlTrOSeP3P
         vEgSRqsUAMrxUNV/8BqMfGRkByFn/1QZAPiPRZh3je5qmAPCrFNOe+Kqs1YVwF+4qRpG
         +Wsw==
X-Gm-Message-State: AOJu0YyOKl1HB6ZYNCZ4+AbuDEvQrM0jktbYJfFk6YP+CWJlDByfDFng
        U0WerueM3+jdH2ulTwQlnK4Di9K87Z5G+Q==
X-Google-Smtp-Source: AGHT+IGDiSD3tFwHpUo6q1DmSp2yjj6A5s6Y107zZUyOALIwW9RBy1P9h/fai0tF5fKSLd44n7dNIw==
X-Received: by 2002:a17:90b:4b04:b0:27d:1593:2b08 with SMTP id lx4-20020a17090b4b0400b0027d15932b08mr4295816pjb.0.1697142362472;
        Thu, 12 Oct 2023 13:26:02 -0700 (PDT)
Received: from [192.168.1.2] (97-120-87-19.ptld.qwest.net. [97.120.87.19])
        by smtp.googlemail.com with ESMTPSA id r59-20020a17090a43c100b0027476c68cc3sm2449718pjg.22.2023.10.12.13.26.02
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 13:26:02 -0700 (PDT)
Message-ID: <2a56e458-88eb-43bc-94bf-9b5a4886d90f@gmail.com>
Date:   Thu, 12 Oct 2023 13:24:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-btrfs@vger.kernel.org
Reply-To: jlpoole56@gmail.com
Content-Language: en-US
From:   "John L. Poole" <jlpoole56@gmail.com>
Subject: SanDisk Extreme Pro w/btrfs Frozen: nodiscard per Western Digital
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

** Issue: I have 3 SanDisk Extreme Pro micro SD cards using btrfs
which are readable, but not writable; they are frozen.

** Background:  I purchased from Amazon (1) 5 SanDisk Extreme Pro (64GB)
microSDXC(tm) UHS-I cards in August, 2023.  They have been used
to test/build-out the GenPi64 Gentoo Linux for the Raspberry Pi(2).
I selected the Extreme Pro series because they had faster I/O ratings.
This is the first time I have used the Extreme Pro series, previously,
I have used other cards including the SanDisk Ultra and I have not
experienced any problems.

The GenPi64 image uses the btrfs file system.  /etc/fstab has:

PARTUUID="426c28a1-02"  /       btrfs   noatime, [LINE BREAK]
compress=zstd,ssd,discard,x-systemd.growfs      0       0

During my build-out I ran into the problem that my session's file
changes did not persist on reboots.  I'd install a Gentoo package
with "emerge", and/or I'd create/edit a file, and after reboot
those changes were missing.  Although dmesg revealed some warnings,
there was nothing in the start-up post or system to suggests there was
any problem.  So a non-technical user would not be alerted to any
problems and on reboot suddenly and without fanfare learn that
the files from the previous session are not saved.  This would be btrfs
doing its job: not integrating that last set of changes
because it detected a corruption.

My build-out has been on a Raspberry Pi 4B with 8 MB(3) and
the Raspberry Pi forums suggest that the SD card I/O has a
limitation of 50 MBs/second.(4)

What seemed to trigger the problem was when I emerged the package
sys-kernel/raspberrypi-sources.  During the processing, there are over 1 GB
of files that are to be staged and the emerge would fail during the final
transfer of those files.

Here's a lsblk output:

eos /tmp # date; lsblk --output 
NAME,FSSIZE,FSUSED,FSTYPE,FSVER,LABEL,UUID,MODE,STATE,DISC-ALN
Thu Oct 12 10:44:29 PDT 2023
NAME        FSSIZE FSUSED FSTYPE FSVER LABEL 
UUID                                 MODE       STATE DISC-ALN
mmcblk0 brw-rw----              0
+-mmcblk0p1               vfat   FAT16 
932D-ABE2                            brw-rw----        3145728
+-mmcblk0p2  59.2G   2.2G btrfs d15fd42d-7572-4d9f-b5fb-eadbe3d70d5c 
brw-rw----              0

I do not know what DISC-ALN means other than "discard alignment
offset" which "lsblk --help" tells me, but share the following.
The GenPi64 image that I burned was a 4GB file. When I boot up,
there is a script at boot-up which will expand the root (btrfs)
file system to use up any available space on the card, hence a one-time
expansion occurs changing the root file system from its less than
4 GB size to 59.2 GB. The DISC-ALN value for the vfat system,
3145728, concerns me since the vfat is suppose to be 256 MBs.
I'm just wondering if that 3145728 value is somewhat in interference
with the expanded btrfs system and may be contributing to the frozen
read-only mode of the card.

I began to use the "emerge sys-kernel/raspberrypi-sources" as a test
which would cause the SD card to become unwritable.

I opened a ticket with Western Digital and their response was:

     [--- start response ---]

     Please also refer to the following command to run BEFORE doing any
     major writes to card after installing OS.

     Using the appropriate format command can avoid the Read-Only mode
     issue. File system format tools such as mkfs and mke2fs
     have the nodiscard flag.

     Format SanDisk card with ext4 FS:

       Linux Host is needed
       Native microSD/SD support.
       Discard feature supported on Host and card
       Use the nodiscard flag.
       Command: $ mkfs.ext4 -E nodiscard -F /dev/mmcblk0p1
     [--- end response ---]

I altered my /etc/fstab on a newly burned enhanced image and changed
"discard" to "nodiscard" and I successfully installed
"sys-kernel/raspberrypi-sources".  Furthermore, subsequent activity on
the image seems normal and it appears the mount specification of "nodiscard"
has solved my problem... for a micro disk not already frozen.

Western Digital has offered to replace whatever disks with like kind; I had
suggested they simply provide me Ultras and refund the price difference, but
they insist that they can only provide Extreme Pro replacements.
Therefore, I am stuck with five Extreme Pro Cards that have
a propensity to become unusable.

I thought I would try to resurrect the three frozen cards before
resolving my open ticket with Western Digital.  To that end and
working with the principal developer of the GenPi64 project, we devised 
these
steps to test whether the cards could be salvaged:

     # need to be root to write to card
     su
     # create a test file of 512 zeros
     date; time dd if=/dev/zero of=/tmp/1_block-512_zeros.raw count=1
     # write test file to card
     date; time dd if=/tmp/1_block-512_zeros.raw  of=/dev/mmcblk0
     # copy the first 512 bytes out to a file
     date; time dd if=/dev/mmcblk0 of=/tmp/1_block-512_from_card_A.raw 
count=1
     # view the files with hexdump abbreviate with head
     hexdump 1_block-512_from_card_A.raw |head -n 1
     hexdump 1_block-512_zeros.raw | head -n 1

     eos /tmp #      # create a test file of 512 zeros
     date; time dd if=/dev/zero of=/tmp/1_block-512_zeros.raw count=1
     Thu Oct 12 10:26:11 PDT 2023
     1+0 records in
     1+0 records out
     512 bytes copied, 8.6744e-05 s, 5.9 MB/s

     real    0m0.001s
     user    0m0.000s
     sys     0m0.001s
     eos /tmp #      # write test file to card
     date; time dd if=/tmp/1_block-512_zeros.raw  of=/dev/mmcblk0
     Thu Oct 12 10:26:23 PDT 2023
     1+0 records in
     1+0 records out
     512 bytes copied, 0.0211458 s, 24.2 kB/s

     real    0m0.023s
     user    0m0.002s
     sys     0m0.000s
     eos /tmp #      # copy the first 512 bytes out to a file
     date; time dd if=/dev/mmcblk0 of=/tmp/1_block-512_from_card_A.raw 
count=1
     Thu Oct 12 10:26:34 PDT 2023
     1+0 records in
     1+0 records out
     512 bytes copied, 0.0202807 s, 25.2 kB/s

     real    0m0.022s
     user    0m0.002s
     sys     0m0.000s
     eos /tmp #      # view the files with hexdump abbreviate with head
     hexdump 1_block-512_from_card_A.raw |head -n 1
     hexdump 1_block-512_zeros.raw | head -n 1
     0000000 b8fa 1000 d08e 00bc b8b0 0000 d88e c08e
     0000000 0000 0000 0000 0000 0000 0000 0000 0000
     eos /tmp #

The above shows that my attempts to write to the card fail; both
rows should be zeros.

Moreover, I've tried using fdisk and deleting the partitions and
writing my changes and fdisk appears to execute the task without
error or warning, yet the partitions persist and were not deleted.

There are currently pending 3 class action lawsuits against Western Digital
over their SSD drives where customers would experience lost data. (5)

Western Digital has a web page "Format Using Linux, Raspberry Pi,
or Android Host Results in Read Only Mode on a SanDisk SD or
microSD Memory Card "(6).

** Questions:

1) Is there some way to write to the card, or some tools I can use
so I can resurrect the cards and restore them to normal use?
2) It looks like the use "discard" for SanDisk Extreme Pro cards causes
problems?  I am told btrfs uses discard by default.
3) Is there some assay anyone wants to suggest I try to see if I can trigger
the read-only condition such as I have stumbled upon three times?
I have 2 cards that I can still write to.  I am willing to try anything 
someone
suggests that would help shed light onto this problem.  I was hoping to
garner the attention of an engineer from Western Digital.

Before I accept Western Digital's offer to replace the cards, I'd like 
to know
what is happening or what is causing them to lock up.  I do not
want to encounter the problem again. What is troubling is that
an inexperienced user will not detect anything wrong until after a 
reboot when they
discover everything from the previous session did not persist. This
kind of media failure could discourage the use of the btrfs based image.

Thank you,

John Poole

-----------------------

Footnotes
(1) 
https://www.amazon.com/SanDisk-Extreme-microSDTM-Adapter-SDSQXCU-064G-GN6MA/dp/B09X7BYSFG/ref=sr_1_2?crid=20PTT2TLYVAVM&keywords=SanDisk+Extreme+Pro+%2864GB%29+micro+sd&qid=1697127725&sprefix=sandisk+extreme+pro+64gb+micro+sd%2Caps%2C133&sr=8-2
(2) https://github.com/GenPi64
(3) Specs on Raspberry Pi 4B: 
https://www.raspberrypi.com/documentation/computers/raspberry-pi.html.
(4) "SD micro limitations in Raspberry Pi hardware?" at
https://forums.raspberrypi.com/viewtopic.php?t=356431
(5) 
https://arstechnica.com/gadgets/2023/08/sandisk-extreme-ssds-are-worthless-multiple-lawsuits-against-wd-say/
(6) 
https://support-en.wd.com/app/answers/detailweb/a_id/50076/~/format-using-linux%2C-raspberry-pi%2C-or-android-host-results-in-read-only-mode-on 


