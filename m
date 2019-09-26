Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27730BFA97
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfIZU2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 16:28:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38876 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfIZU2L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 16:28:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so3907483wmi.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4E2FPRROOj19W22/3q6QhiQwPpvBbUt4Br1AA1eDOY=;
        b=ze1sWVxiQ5Csoqd9kVK4YxGfFrMJy2xkW7mRorE4P4e4RDY0SBa160lNtIew5snROC
         V6TWYXbgdTQGyqD6FgwhS30Krj7RjTdC333qTjgSUNipjC/47UWtVLgjszfRGTQ9uvSp
         P6tu+MNsdhXn3YVyPjDEgcfv/+y8HCTHUT1uG4MoPeu8QLOa0yZ+9jymU3wDEYJOqpya
         NL7IJUj6+RhAwHAw83sfol43AaIYTKnWbM0mjGnQO+ms8rLjyz+GZuLz3JzrDs8HJ9Aa
         fclZ7jWTvG6C+k+/nuBF5SC636ClFtNBXFRa2T+ZNaLnzknq/m6MCDOA1qwrboijHb6i
         bXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4E2FPRROOj19W22/3q6QhiQwPpvBbUt4Br1AA1eDOY=;
        b=eapS6fHAf5NSZra3VLs/VlJc9Z26X84vBaTd/o0TdYUUny89W5Ym/XQHceaB8s+H+Q
         1id+VjzooJeSpBrzu7Fc8P4Yy4qtaNw6N3b+6FB+0dQIf9ipSrUO1jvuHb/ODLM8w5am
         6hRlqXhx427Tu+oGvGrXWcLf7o1Y1ocBVgeOQhInbPI5Tl9nha6JZMPZ8tYZvGjFn1Z1
         gad2haFHE9D4CCXhv8xVyCCOFl+1Z+v25w++efuVznPpU9VirNYhLHtx4K+yMAhIE76F
         9Y8EPt5RDKdO4Z3Z49yz91cFMyny9YDvusLCHjn2mGtMYKvXd9UT61gCUZUqoIUAXfT8
         Hndw==
X-Gm-Message-State: APjAAAXc1aFv27gV4yGtphGQAhCmrbTno+aIYW4jUVWIb1L79LyVSWiV
        xNTb7Olv5CwMNmX99UXXRfdGXy2fXpKHW7Fv45XGZekZgQsoMg==
X-Google-Smtp-Source: APXvYqw9Vr0hxbh9S0/GvjYtc6DbWid8HctIsdi+MleAcaXAvVS6wluhA49F+Of7BFXv9Bfarc3S/WtlmRNumt1I+Zo=
X-Received: by 2002:a7b:c108:: with SMTP id w8mr4544680wmi.8.1569529688217;
 Thu, 26 Sep 2019 13:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <000f01d5723b$6e3d0f70$4ab72e50$@gmail.com> <CAJCQCtSCJTsk1oFrWObUBpw-MXArQJHoJV3BeBk0Nfv_-AoS8g@mail.gmail.com>
 <003f01d5724c$f1adae30$d5090a90$@gmail.com> <CAJCQCtTwjUok145SqnbwfBYKipVhcV7J94HX9Lx4mgaFV3FaBA@mail.gmail.com>
 <005301d572dd$e378c7a0$aa6a56e0$@gmail.com>
In-Reply-To: <005301d572dd$e378c7a0$aa6a56e0$@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 26 Sep 2019 14:27:57 -0600
Message-ID: <CAJCQCtTTqQg68HP1qkNrVsH337SQmWqk8pnf4svApA5btTnTRA@mail.gmail.com>
Subject: Re: BTRFS checksum mismatch - false positives
To:     hoegge@gmail.com
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the log offlist

2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.396165] md: invalid
raid superblock magic on sda5
2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.401816] md: sda5 does
not have a valid v0.90 superblock, not importing!

That doesn't sound good. It's not a Btrfs problem but a md/mdadm
problem. You'll have to get support for this from Synology, only they
understand the design of the storage stack layout and whether these
error messages are important or not and how to fix them. Anyone else
speculating could end up causing damage to the NAS and data to be
lost.

--------
2019-09-08T17:27:02+02:00 MHPNAS kernel: [   22.913298] md: sda2 has
different UUID to sda1

There are several messages like this. I can't tell if they're just
informational and benign or a problem. Also not related to Btrfs.

--------
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.419199] BTRFS warning
(device dm-1): BTRFS: dm-1 checksum verify failed on 375259512832
wanted EA1A10E3 found 3080B64F level 0
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.419199]
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.458453] BTRFS warning
(device dm-1): BTRFS: dm-1 checksum verify failed on 375259512832
wanted EA1A10E3 found 3080B64F level 0
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.458453]
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.528385] BTRFS: read
error corrected: ino 1 off 375259512832 (dev /dev/vg1/volume_1 sector
751819488)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.539631] BTRFS: read
error corrected: ino 1 off 375259516928 (dev /dev/vg1/volume_1 sector
751819496)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.550785] BTRFS: read
error corrected: ino 1 off 375259521024 (dev /dev/vg1/volume_1 sector
751819504)
2019-09-08T22:09:33+02:00 MHPNAS kernel: [16997.561990] BTRFS: read
error corrected: ino 1 off 375259525120 (dev /dev/vg1/volume_1 sector
751819512)

There are a bunch of messages like this. Btrfs is finding metadata
checksum errors, some kind of corruption has happened with one of the
copies, and it's been fixed up. But why are things being corrupt in
the first place? Ordinary bad sectors maybe? There's a lot of these  -
like really a lot. Hundreds of affected sectors. There are too many
for me to read through and see if all of them were corrected by DUP
metadata.

--------

2019-09-22T21:24:27+02:00 MHPNAS kernel: [1224856.764098] md2:
syno_self_heal_is_valid_md_stat(496): md's current state is not
suitable for data correction

What does that mean? Also not a Btrfs problem. There are quite a few of these.

--------

2019-09-23T11:49:20+02:00 MHPNAS kernel: [1276791.652946] BTRFS error
(device dm-1): BTRFS: dm-1 failed to repair btree csum error on
1353162506240, mirror = 1

OK and a few of these also. This means that some metadata could not be
repaired, likely because both copies are corrupt.

My recommendation is to freshen your backups now while you still can,
and prepare to rebuild the NAS. i.e. these are not likely repairable
problems. Once both copies of Btrfs metadata are bad, it's usually not
fixable you just have to recreate the file system from scratch.

You'll have to move everything off the NAS - and anything that's
really important you will want at least two independent copies of, of
course, and then you're going to obliterate the array and start from
scratch. While you're at it, you might as well make sure you've got
the latest supported version of the software for this product. Start
with that. Then follow the Synology procedure to wipe the NAS totally
and set it up again. You'll want to make sure the procedure you use
writes out all new metadata for everything: mdadm, lvm, Btrfs. Nothing
stale or old reused. And then you'll copy you data back over to the
NAS.

There's nothing in the provided log that helps me understand why this
is happening. I suspect hardware problems of some sort - maybe one of
the drives is starting to slowly die, by spitting out bad sectors. To
know more about that we'd need to see 'smartctl -x /dev/' for each
drive in the NAS and see if smart gives a clue. Somewhere around 50/50
shot that smart will predict a drive failure in advance. So my
suggestion again, without delay, is to make sure the NAS is backed up,
and keep those backups fresh. You can recreate the NAS when you have
free time - but these problems likely will get worse.



---
Chris Murphy
