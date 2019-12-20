Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B490128338
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfLTUYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 15:24:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55123 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfLTUYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 15:24:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so10174840wmj.4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 12:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47Lj0thfdn8P9AfFCyV7saehNv1YUw2MDQLli+tCoRk=;
        b=goRUZiy7tvuBhTQbYdSuC/ogXy7jcLAs4dJSJ++Yyynej7ytfRjr/V68ddHJG3Gz36
         SaghaTgEBi26VXb1pYLlF1BBhg3sZRRzYIfa5OOKLctNT83T2FcTC4xSWdc+WiSYqvPF
         LhHmBKuUQ3CdDbV9MjfTqP0U1/mSzNmxHri5L+tUxnFmy+H4kB/DPWv7IUGZF7xfoFLX
         CFGXvEk6XRkgV1ZcbmCltAa5NyXlz6MADPhnMOAZOM77+k+EFURWoUN1qUqpwZc2mG6e
         1HfqRMjWUXd5MxyI7RUteSZaOUH+gJ+JV5P0xHOOgi+5Y1nlsDmVZI6gJrzgoN6t7Zvb
         WYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47Lj0thfdn8P9AfFCyV7saehNv1YUw2MDQLli+tCoRk=;
        b=Z0gybZ9/o04UiQBN+4HxiVzGJDb0+LREksv8pQWJkUP0LRC1S3ohgaj4UH1Vykcvkp
         ddkehieWpKxNSG75CgKqN162exHQLiRPRpFwo0Tl6I/s+9UFu1JdEiUTakAfiLgBbixF
         k/5N8QudKHE57vWuagZMnxV0Bz9GJGtuwLghle7v4jALRwiC4IF7B32aVHMYtuboVEDZ
         FuF+0Vp6+0nLgFOR7ijRUQwrM+17mEBBjz+Am/hCt1pbHOqXO6ArHlGwyGwAdhKXhUQW
         k1nHUSQyjURUsW7+3EgRh62CLjjJUL/iYYP1kTi/g0ZTtlxfG2j8PtKl7vBfRBNMHcTD
         xKew==
X-Gm-Message-State: APjAAAVlXguSYQ7oNWp7EcSDDjFIdQojXzVjwvQy50n3MhNLpLvVyXsq
        su5hnN1RLiXRsJlBm9A5SR1og2YVlO38+Rb2Be9sTDYKav4=
X-Google-Smtp-Source: APXvYqzQ9Pl02rlXCAMa1Kz33A0AtW0MOiEz9J8cgC4/ap9pg9HOVspQCLjUvak+HwQUlHkMoJh+kNPsbP3CzUV8abE=
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr18021672wmc.160.1576873458554;
 Fri, 20 Dec 2019 12:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20191220040536.GA1682@schmorp.de> <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de> <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de> <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
In-Reply-To: <20191220165008.GA1603@schmorp.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 20 Dec 2019 13:24:02 -0700
Message-ID: <CAJCQCtRBTaGoAejs9Ms=EbeJJRvMH8t5xHPgXp8P==sCMZZaJQ@mail.gmail.com>
Subject: Re: btrfs dev del not transaction protected?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marc Lehmann <schmorp@schmorp.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 9:53 AM Marc Lehmann <schmorp@schmorp.de> wrote:
>
> On Fri, Dec 20, 2019 at 09:41:15PM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> > Consider all these insane things, I tend to believe there is some
> > FUA/FLUSH related hardware problem.
>
> Please don't - I honestly think btrfs developers are way to fast to blame
> hardware for problems.

That's because they have a lot of evidence of this, in a way that's
only inferable with other file systems. This has long been suspected
by, and demonstrated, well before Btrfs with ZFS development.

A reasonable criticism of Btrfs development is the state of the file
system check repair, which still has danger warnings. But it's also a
case of damned if they do, and damned if they don't provide it. It
might be the best chance of recovery, so why not provide it?
Conversely, the reality is that the file system is complicated enough,
and the file system checker too slow, that the effort needs to be on
(what I call) file system autopsy tools, to figure out why the
corruption happened, and prevent that from happening. The repair is
often too difficult.

Take, for example, the recent 5.2.0-5.2.14 corruption bug. That was
self-reported once it was discovered and fixed, which took longer than
usual, and developers apologized. What else can they do? It's not like
the developers are blaming hardware for their own bugs. They have
consistently taken responsibility for Btrfs bugs.


> I currently lose btrfs filesystems about once every
> 6 months, and other than the occasional user error, it's always the kernel
> (e.g. 4.11 corrupting data, dmcache and/or bcache corrupting things,
> low-memory situations etc. - none of these seem to be centric to btrfs,
> but none of those are hardware errors either). I know its the kernel in
> most cases because in those cases, I can identify the fix in a later
> kernel, or the mitigating circumstances don't appear (e.g. freezes).

Usually Btrfs developers do mention the possibility of other software
layers contributing to the problem, it's a valid observation that this
possibility be stated.

However, if it's exclusively a software problem, then it should be
reproducible on other systems.


> In any case if it is a hardware problem, then linux and/or btrfs has
> to work around them, because it affects many different controllers on
> different boards:

How do you propose Btrfs work around it? In particular when there are
additional software layers over which it has no control?

Have you tried disabling the (drives') write cache?


> Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs
> filesystem I restored to went into readonly mode with ENOSPC. Another
> hardware problem?

> [41801.618887] CPU: 2 PID: 5713 Comm: kworker/u8:15 Tainted: P           OE     5.4.5-050405-generic #201912181630

Why is this kernel tainted? The point of pointing this out isn't to
blame whatever it tainting the kernel, but to point out that
identifying the cause of your problems is made a lot more difficult. I
think you need to simplify the setup, a lot, in order to reduce the
surface area of possible problems. Any bug hunt is made way harder
when there's complication.



> [41801.618888] Hardware name: MSI MS-7816/Z97-G43 (MS-7816), BIOS V17.8 12/24/2014
> [41801.618903] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
> [41801.618916] RIP: 0010:btrfs_finish_ordered_io+0x730/0x820 [btrfs]
> [41801.618917] Code: 49 8b 46 50 f0 48 0f ba a8 40 ce 00 00 02 72 1c 8b 45 b0 83 f8 fb 0f 84 d4 00 00 00 89 c6 48 c7 c7 48 33 62 c0 e8 eb 9c 91 d5 <0f> 0b 8b 4d b0 ba 57 0c 00 00 48 c7 c6 40 67 61 c0 4c 89 f7 bb 01
> [41801.618918] RSP: 0018:ffffc18b40edfd80 EFLAGS: 00010282
> [41801.618921] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3159: errno=-28 No space left
> [41801.618922] RAX: 0000000000000000 RBX: ffff9f8b7b2e3800 RCX: 0000000000000006
> [41801.618922] BTRFS info (device dm-35): forced readonly
> [41801.618924] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9f8bbeb17440
> [41801.618924] RBP: ffffc18b40edfdf8 R08: 00000000000005a6 R09: ffffffff979a4d90
> [41801.618925] R10: ffffffff97983fa8 R11: ffffc18b40edfbe8 R12: ffff9f8ad8b4ab60
> [41801.618926] R13: ffff9f867ddb53c0 R14: ffff9f8bbb0446e8 R15: 0000000000000000
> [41801.618927] FS:  0000000000000000(0000) GS:ffff9f8bbeb00000(0000) knlGS:0000000000000000
> [41801.618928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [41801.618929] CR2: 00007f8ab728fc30 CR3: 000000049080a002 CR4: 00000000001606e0
> [41801.618930] Call Trace:
> [41801.618943]  finish_ordered_fn+0x15/0x20 [btrfs]
> [41801.618957]  normal_work_helper+0xbd/0x2f0 [btrfs]
> [41801.618959]  ? __schedule+0x2eb/0x740
> [41801.618973]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
> [41801.618975]  process_one_work+0x1ec/0x3a0
> [41801.618977]  worker_thread+0x4d/0x400
> [41801.618979]  kthread+0x104/0x140
> [41801.618980]  ? process_one_work+0x3a0/0x3a0
> [41801.618982]  ? kthread_park+0x90/0x90
> [41801.618984]  ret_from_fork+0x1f/0x40
> [41801.618985] ---[ end trace 35086266bf39c897 ]---
> [41801.618987] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3159: errno=-28 No space left
>
> unmount/remount seems to make it work again, and it is full (df) yet has
> 3TB of unallocated space left. No clue what to do now, do I have to start
> over restoring again?
>
>    Filesystem               Size  Used Avail Use% Mounted on
>    /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1

Clearly a bug, possibly more than one. This problem is being discussed
in other threads on df misreporting with recent kernels, and a fix is
pending.

As for the ENOSPC, also clearly a bug. But not clear why or where.


> Please, don't always chalk it up to hardware problems - btrfs is a
> wonderful filesystem for many reasons, one reason I like is that it can
> detect corruption much earlier than other filesystems. This featire alone
> makes it impossible for me to go back to xfs. However, I had corruption
> on ext4, xfs, reiserfs over the years, but btrfs *is* simply way buggier
> still than those - before btrfs (and even now) I kept md5sums of all
> archived files (~200TB), and xfs and ext4 _do_ a much better job at not
> corrupting data than btrfs on the same hardware - while I get filesystem
> problems about every half a year with btrfs, I had (silent) corruption
> problems maybe once every three to four years with xfs or ext4 (and not
> yet on the bxoes I use currently).

I can't really parse the suggestion that you are seeing md5 mismatches
(indicating data changes) on Btrfs, where Btrfs doesn't produce a csum
warning along with EIO on those files? Are these files nodatacow,
either by mount option nodatasum or nodatacow, or using chattr +C on
these files?

A mechanism explaining this anecdote isn't clear. Not even crc32c
checksum collision would explain more than maybe one instance of it.

I'm curious what Zygo thinks about this.







>
> Please take these issues seriously - the trend of "it's a hardware
> problem" will not remove the "unstable" stigma from btrfs as long as btrfs
> is clearly more buggy then other filesystems.
>
> Sorry to be so blunt, but I am a bit sensitive with always being told
> "it's probably a hardware problem" when it clearly affects practically any
> server and any laptop I administrate. I believe in btrfs, and detecting
> corruption early is a feature to me.

The problem with the anecdotal method of arguing in favor of software
bugs as the explanation? It directly goes against my own experience,
also anecdote. I've had no problems that I can attribute to Btrfs. All
were hardware or user sabotage. And I've had zero data loss, outside
of user sabotage.

I have seen device UNC read errors, corrected automatically by Btrfs.
And I have seen devices return bad data that Btrfs caught, that would
otherwise have been silent corruption of either metadata or data, and
this was corrected in the raid1 cases, and merely reported in the
non-raid cases. And I've also seen considerable corruption reported
upon SD Cards in the midst of implosion and becoming read only. But
even read only, I was able to get all the data out.

But in your case, practically ever server and laptop? That's weird and
unexpected. And it makes me wonder what's in common. Btrfs is much
fussier than other file systems because the by far largest target for
corruption, isn't file system metadata, but data. The actual payload
of a file system isn't the file system. And Btrfs is the only Linux
native file system that checksums data. The other file systems check
only metadata, and only somewhat recently, depending on the
distribution you're using.


> I understand it can be frustrating to be confronted with hard to explain
> accidents, and I understand if you can't find the bug with the sparse info
> I gave, especially as the bug might not even be in btrfs. But keep in mind
> that the people who boldly/dumbly use btrfs in production and restore
> dozens of terabytes from backup every so and so many months are also being
> frustrated if they present evidence from multiple machines and get told
> "its probably a hardware problem".

For sure. But take the contrary case that other file systems have
depended on for more than a decade: assuming the hardware is returning
valid data. This is intrinsic to their design. And go back before they
had metadata checksumming, and you'd see it stated on their lists that
they do assume this, and if your devices return any bad data, it's not
the file system's fault at all. Not even the lack of reporting any
kind of problem whatsoever. How is that better?

Well indeed, not long after Btrfs was demonstrating these are actually
more common problems that suspected, metadata checksumming started
creeping into other file systems, finally becoming the default (a
while ago on XFS, and very recently on ext4). And they are catching a
lot of these same kinds of layer and hardware bugs. Hardware does not
just mean the drive, it can be power supply, logic board, controller,
cables, drive write caches, drive firmware, and other drive internals.

And the only way any problem can be fixed, is to understand how, when
and where it happened.

--
Chris Murphy
