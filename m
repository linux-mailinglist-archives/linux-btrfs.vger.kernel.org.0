Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF627C7C15
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 05:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJMDbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Oct 2023 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDba (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Oct 2023 23:31:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CF2B7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 20:31:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c76ef40e84so3178515ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Oct 2023 20:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697167887; x=1697772687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:to:references:reply-to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVkf19NhxrRjw86+24ycPr7UjoQMCZYgJ4W1AQcwIQw=;
        b=UfzScsoybHXIfzLxf8PYzo8rasqhV2rlGRhYjMwZ6SLOiWZQR6lUbNh/3LCy1RIFp7
         ag1z27FmvIhoKURUEBW3c1QlxDGs/lCbhgE8hLT2oYyPWNI0fovsKvBwMbQ9xIB8jBD9
         fcWxHZnVhLtiVi/2aURqBZzEC+Xd7y88xNsPqNODeZr0rRN3TcTn6qVOkzqRX0snOCEc
         ff18DmRZtDAwTDlq4dYSbQUXRHhTmcNxFsq1VsO2nROdz3BNeMt7EsijObRLLWBXtH27
         W+XfwvDGKzLWoWjD3zlJ9BH7/Y3RiCT5/+tTqoWpRsnTkqMx/kbEsEs6vjo4s2aRX6tc
         sa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697167887; x=1697772687;
        h=content-transfer-encoding:in-reply-to:from:to:references:reply-to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVkf19NhxrRjw86+24ycPr7UjoQMCZYgJ4W1AQcwIQw=;
        b=MXd2e36GjfegCOf5BlAUyquaOZSLyTaOh5ox6g8LmAFxkBX3EKYAJ+gpSdtG9E9tUC
         iW837JiWgFIuereNNTQk1BLZVP+W9XVHH7nUI7CRjL0cRwoZkOj4LBTUToO0y0pHl1AG
         fLvW5dMwYwjCuygVDaCrv8mWdvNM756qwGv6HlvyOmh9cp4Cl/zmgOD2lH7wUaxsOD7v
         +NQ2/K9a9KHJfb/FPlVjN+nE3qcbj6zLIaGYWezdiF+FIrjL85uBIdc1qs/HArbgxCxv
         tKQpQVDUgOiianxQOTmUXf2Lw2d3bQE2IgxRy8gUTlrV0F9BJxiGvEgdjRYHFgW5Qrjy
         uEFA==
X-Gm-Message-State: AOJu0YwsMU9Z+UiLlroL3t9ExJ/fqfAlebObwqL7Qp9DpoDwP9GU+H8w
        eXePtkdBkliJ3ePJortBH37RpjLiyEN7CQ==
X-Google-Smtp-Source: AGHT+IEEh9j4tWZP8IOgaou4DFNQVhwrU2sB8RHyC/wlaVKK5HnQAiR5lli9Q6L+t72NR5Rdv+rxAw==
X-Received: by 2002:a17:90b:17c3:b0:27c:f653:37b2 with SMTP id me3-20020a17090b17c300b0027cf65337b2mr8213161pjb.1.1697167886675;
        Thu, 12 Oct 2023 20:31:26 -0700 (PDT)
Received: from [192.168.1.2] (97-120-87-19.ptld.qwest.net. [97.120.87.19])
        by smtp.googlemail.com with ESMTPSA id mz14-20020a17090b378e00b0027722832498sm2569400pjb.52.2023.10.12.20.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 20:31:26 -0700 (PDT)
Message-ID: <8f8951c4-5574-4ff5-86c3-0cf446e17b3d@gmail.com>
Date:   Thu, 12 Oct 2023 20:30:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SanDisk Extreme Pro w/btrfs Frozen: nodiscard per Western Digital
Content-Language: en-US
Reply-To: jlpoole56@gmail.com
References: <55e96e5e-ed7d-4376-98d4-64a0d5ac7add@gmail.com>
To:     linux-btrfs@vger.kernel.org
From:   "John L. Poole" <jlpoole56@gmail.com>
In-Reply-To: <55e96e5e-ed7d-4376-98d4-64a0d5ac7add@gmail.com>
X-Forwarded-Message-Id: <55e96e5e-ed7d-4376-98d4-64a0d5ac7add@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[My replies to Damien Le Moal's reply inline below. This email is my
second attempt to respond in "text" format, my prior response was
accidentally in HTML and rejected by the mail server.]
On 10/12/2023 7:10 PM, Damien Le Moal wrote:
> On 10/13/23 05:24, John L. Poole wrote:
>> ** Issue: I have 3 SanDisk Extreme Pro micro SD cards using btrfs
>> which are readable, but not writable; they are frozen.
>>
>> ** Background:  I purchased from Amazon (1) 5 SanDisk Extreme Pro (64GB)
>> microSDXC(tm) UHS-I cards in August, 2023.  They have been used
>> to test/build-out the GenPi64 Gentoo Linux for the Raspberry Pi(2).
>> I selected the Extreme Pro series because they had faster I/O ratings.
>> This is the first time I have used the Extreme Pro series, previously,
>> I have used other cards including the SanDisk Ultra and I have not
>> experienced any problems.
>>
>> The GenPi64 image uses the btrfs file system.  /etc/fstab has:
>>
>> PARTUUID="426c28a1-02"  /       btrfs   noatime, [LINE BREAK]
>> compress=zstd,ssd,discard,x-systemd.growfs      0       0
>>
>> During my build-out I ran into the problem that my session's file
>> changes did not persist on reboots.  I'd install a Gentoo package
>> with "emerge", and/or I'd create/edit a file, and after reboot
>> those changes were missing.  Although dmesg revealed some warnings,
>> there was nothing in the start-up post or system to suggests there was
>> any problem.  So a non-technical user would not be alerted to any
>> problems and on reboot suddenly and without fanfare learn that
>> the files from the previous session are not saved.  This would be btrfs
>> doing its job: not integrating that last set of changes
>> because it detected a corruption.
>>
>> My build-out has been on a Raspberry Pi 4B with 8 MB(3) and
>> the Raspberry Pi forums suggest that the SD card I/O has a
>> limitation of 50 MBs/second.(4)
>>
>> What seemed to trigger the problem was when I emerged the package
>> sys-kernel/raspberrypi-sources.  During the processing, there are over 1 GB
>> of files that are to be staged and the emerge would fail during the final
>> transfer of those files.
>>
>> Here's a lsblk output:
>>
>> eos /tmp # date; lsblk --output
>> NAME,FSSIZE,FSUSED,FSTYPE,FSVER,LABEL,UUID,MODE,STATE,DISC-ALN
>> Thu Oct 12 10:44:29 PDT 2023
>> NAME        FSSIZE FSUSED FSTYPE FSVER LABEL
>> UUID                                 MODE       STATE DISC-ALN
>> mmcblk0 brw-rw----              0
>> +-mmcblk0p1               vfat   FAT16 932D-ABE2
>> brw-rw----        3145728
>> +-mmcblk0p2  59.2G   2.2G btrfs d15fd42d-7572-4d9f-b5fb-eadbe3d70d5c
>> brw-rw----              0
>>
>> I do not know what DISC-ALN means other than "discard alignment
>> offset" which "lsblk --help" tells me, but share the following.
>> The GenPi64 image that I burned was a 4GB file. When I boot up,
>> there is a script at boot-up which will expand the root (btrfs)
>> file system to use up any available space on the card, hence a one-time
>> expansion occurs changing the root file system from its less than
>> 4 GB size to 59.2 GB. The DISC-ALN value for the vfat system,
>> 3145728, concerns me since the vfat is suppose to be 256 MBs.
>> I'm just wondering if that 3145728 value is somewhat in interference
>> with the expanded btrfs system and may be contributing to the frozen
>> read-only mode of the card.
>>
>> I began to use the "emerge sys-kernel/raspberrypi-sources" as a test
>> which would cause the SD card to become unwritable.
>>
>> I opened a ticket with Western Digital and their response was:
>>
>>      [--- start response ---]
>>
>>      Please also refer to the following command to run BEFORE doing any
>>      major writes to card after installing OS.
>>
>>      Using the appropriate format command can avoid the Read-Only mode
>>      issue. File system format tools such as mkfs and mke2fs
>>      have the nodiscard flag.
>>
>>      Format SanDisk card with ext4 FS:
>>
>>        Linux Host is needed
>>        Native microSD/SD support.
>>        Discard feature supported on Host and card
>>        Use the nodiscard flag.
>>        Command: $ mkfs.ext4 -E nodiscard -F /dev/mmcblk0p1
>>      [--- end response ---]
>>
>> I altered my /etc/fstab on a newly burned enhanced image and changed
>> "discard" to "nodiscard" and I successfully installed
>> "sys-kernel/raspberrypi-sources".  Furthermore, subsequent activity on
>> the image seems normal and it appears the mount specification of "nodiscard"
>> has solved my problem... for a micro disk not already frozen.
>>
>> Western Digital has offered to replace whatever disks with like kind; I had
>> suggested they simply provide me Ultras and refund the price difference, but
>> they insist that they can only provide Extreme Pro replacements.
>> Therefore, I am stuck with five Extreme Pro Cards that have
>> a propensity to become unusable.
>>
>> I thought I would try to resurrect the three frozen cards before
>> resolving my open ticket with Western Digital.  To that end and
>> working with the principal developer of the GenPi64 project, we devised these
>> steps to test whether the cards could be salvaged:
>>
>>      # need to be root to write to card
>>      su
>>      # create a test file of 512 zeros
>>      date; time dd if=/dev/zero of=/tmp/1_block-512_zeros.raw count=1
>>      # write test file to card
>>      date; time dd if=/tmp/1_block-512_zeros.raw  of=/dev/mmcblk0
>>      # copy the first 512 bytes out to a file
>>      date; time dd if=/dev/mmcblk0 of=/tmp/1_block-512_from_card_A.raw count=1
>>      # view the files with hexdump abbreviate with head
>>      hexdump 1_block-512_from_card_A.raw |head -n 1
>>      hexdump 1_block-512_zeros.raw | head -n 1
>>
>>      eos /tmp #      # create a test file of 512 zeros
>>      date; time dd if=/dev/zero of=/tmp/1_block-512_zeros.raw count=1
>>      Thu Oct 12 10:26:11 PDT 2023
>>      1+0 records in
>>      1+0 records out
>>      512 bytes copied, 8.6744e-05 s, 5.9 MB/s
>>
>>      real    0m0.001s
>>      user    0m0.000s
>>      sys     0m0.001s
>>      eos /tmp #      # write test file to card
>>      date; time dd if=/tmp/1_block-512_zeros.raw  of=/dev/mmcblk0
>>      Thu Oct 12 10:26:23 PDT 2023
>>      1+0 records in
>>      1+0 records out
>>      512 bytes copied, 0.0211458 s, 24.2 kB/s
>>
>>      real    0m0.023s
>>      user    0m0.002s
>>      sys     0m0.000s
>>      eos /tmp #      # copy the first 512 bytes out to a file
>>      date; time dd if=/dev/mmcblk0 of=/tmp/1_block-512_from_card_A.raw count=1
>>      Thu Oct 12 10:26:34 PDT 2023
>>      1+0 records in
>>      1+0 records out
>>      512 bytes copied, 0.0202807 s, 25.2 kB/s
>>
>>      real    0m0.022s
>>      user    0m0.002s
>>      sys     0m0.000s
>>      eos /tmp #      # view the files with hexdump abbreviate with head
>>      hexdump 1_block-512_from_card_A.raw |head -n 1
>>      hexdump 1_block-512_zeros.raw | head -n 1
>>      0000000 b8fa 1000 d08e 00bc b8b0 0000 d88e c08e
>>      0000000 0000 0000 0000 0000 0000 0000 0000 0000
>>      eos /tmp #
>>
>> The above shows that my attempts to write to the card fail; both
>> rows should be zeros.
> Anything in dmesg ? Any IO error message showing up there ? For these tests or
> when using btrfs ?

I do not want to flood this list, but I will leave it to Mr. Le Moal to 
determine what is
appropriate for inclusion.  The URL (which probably will not work for 
the general
public) and identifier to my "incident" [Bug/ticket] with Western 
Digital is:
https://support-en.wd.com/app/account/questions/detail/i_id/7298003

In my incident at 28-Sep-2023 11:00:00 AM, I provided this pastebin URL:
https://pastebin.com/mPv4fNgH
which contains dmesg output.  See especially line 69.
I regret that I do not have the dmesg output from the
moment the problem occurred as I rebooted before I realized
this was something more than a problem with the image/build.

As you will see in the incident report, I have provided a link to
the GenPi64 system image so Western Digital can burn their own disks to
experiment with and other helpful information
to allow engineers to assess and test with.

I also posted to Gentoo's Forum:

"Help troubleshooting btrfs" at:
https://forums.gentoo.org/viewtopic-t-1165138-highlight-.html

This problem has really thrown me to the point that I am
having problem retaining all the avenues I investigated to try
and move forward with confidence.  You'll see in my incident
a substantial delay and even notice of closure which I am
guessing was AI generated -- I ended up asking for a human
being to review what I had submitted.

>> Moreover, I've tried using fdisk and deleting the partitions and
>> writing my changes and fdisk appears to execute the task without
>> error or warning, yet the partitions persist and were not deleted.
>>
>> There are currently pending 3 class action lawsuits against Western Digital
>> over their SSD drives where customers would experience lost data. (5)
> That is irrelevant information here. Not the same product nor even the same
> device class.
>
>> Western Digital has a web page "Format Using Linux, Raspberry Pi,
>> or Android Host Results in Read Only Mode on a SanDisk SD or
>> microSD Memory Card "(6).
>>
>> ** Questions:
>>
>> 1) Is there some way to write to the card, or some tools I can use
>> so I can resurrect the cards and restore them to normal use?
> This is a device bug. What (if anything) can be done about it depends on the
> device FW. For extreme problems, the card could be "bricked". So I suggest you
> accept the offer to get replacements and use nodiscard option if you get the
> exact same model, or use discard if you get a fixed version (the vendor will
> have that information).
I will request five replacements even though two currently work, one of 
these two
had "discard" specified in several sessions so my opinion is that it
could be compromised until someone from Western Digital can state with
certainty is not.  And the remaining last card did boot
initially with the "discard" in the /etc/fstab until I could change
the value to "nodiscard" in the initial session.

The GenPi64 developer believes inclusion of "discard" as a mount option 
is desirable,
so I am going to recommend in an Issue filed with that project that users
not use SanDisk Extreme Pro micro cards until word from Western Digital 
comes
forth stating that the Extreme Pro micro cards are not subject to freezing
due to the presence of "discard" in the image's /etc/fstab. Moreover, I
will suggest users using SanDisk Extreme Pro micros change the "discard" to
"nodiscard".
>> 2) It looks like the use "discard" for SanDisk Extreme Pro cards causes
>> problems?  I am told btrfs uses discard by default.
> Yes.
>
>> 3) Is there some assay anyone wants to suggest I try to see if I can trigger
>> the read-only condition such as I have stumbled upon three times?
> Given that this seems to lock the drives in read-only mode, I would not
> recommend that. You will not be able to repeat that test without a method to
> get out of the RO state. And without being able to repeat, the test value will
> be limited.
>
>> I have 2 cards that I can still write to.  I am willing to try anything someone
>> suggests that would help shed light onto this problem.  I was hoping to
>> garner the attention of an engineer from Western Digital.
> You have. But I am not developing SD card firmware, so no clue. But again, I do
> not recommend trying to trigger the issue. WD seems to be aware of the problem,
> so it is understood and being worked on.
>
>> Before I accept Western Digital's offer to replace the cards, I'd like to know
>> what is happening or what is causing them to lock up.  I do not
>> want to encounter the problem again. What is troubling is that
>> an inexperienced user will not detect anything wrong until after a reboot when
>> they
>> discover everything from the previous session did not persist. This
>> kind of media failure could discourage the use of the btrfs based image.
> The issue does not seem to be limited to btrfs but rather to the use of discard
> commands. I am not aware of the exact issue or its trigger and even if I were,
> I would likely not be able to describe it in much details without revealing
> confidential information about the device design...
>
> I will do some poking around internally to check the status of this.
>
[Footnotes to my original posting were ommitted the teply and may be 
accessed at:
https://marc.info/?l=linux-btrfs&m=169714218815709&w=2
]

Thank you,

John Poole
bcc: Damian Le Moal
