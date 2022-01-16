Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6548FBFD
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 10:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiAPJbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 04:31:36 -0500
Received: from mout01.posteo.de ([185.67.36.65]:41099 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbiAPJbf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 04:31:35 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5ED65240026
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 10:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1642325494; bh=60k5TUfkH2Q5KRT5poLsevPxIQ1jK5qJ9yHkrWDPPmg=;
        h=Subject:To:Cc:From:Date:From;
        b=K0rFIsqUnkTHeVXE4vFrcbu1ijMcjop4/WviYF7KtZdZGU9x4Os1c83yGsbLkRNC8
         W9sjUu56QbHsBZ5vaX+7gCeJ38AZ0pvAvGWf1AeHUfQTa1EXZdBrF/I+yBdl5Twotq
         iEHcxyBayjmSa6cTM4RhcQar+G/E3d6G55S4K4N/HSklmxu7DaeAOEVcBVt4+kbee3
         jJDvQbps1GUyhrKnXpQ/9SKO4TjAjWCpTSR+I8GhVrW3atu+YkJzkiQcYhzmD/rgLP
         l08wgTIIzvfHskvrQ7voQaxxoTKm/A8oDlMEKLZ5pZqUpEQ+s540n4dGDh5akgy9OO
         yGvDL6QTT1VrQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Jc8tY0wj6z6tpL;
        Sun, 16 Jan 2022 10:31:33 +0100 (CET)
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
To:     lists@colorremedies.com, linux-btrfs@vger.kernel.org
Cc:     quwenruo.btrfs@gmx.com
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
 <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
From:   Stickstoff <stickstoff@posteo.de>
Message-ID: <13d3ebcb-f261-35eb-0675-3cb199ad3643@posteo.de>
Date:   Sun, 16 Jan 2022 09:31:30 +0000
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/22 9:45 PM, Chris Murphy wrote:
[..]
> 
> Take advantage of the fact you can mount the file system, and freshen
> backups to prepare to abandon this file system. Depending on the
> problem, it might be fixable with current btrfs-progs' btrfs check but
> ... if it's extent tree damage it's going to take a really long time
> to find out, and then only at the end when it either fails or makes
> things worse do you find out.

Yes, that would be the safest way. If I can still get all data off the fs, that is.
I would remove one of the two drives from the raid, create a new btrfs, then btrfs-send
the volume and its snapshots to the new fs. And eventually format and add the other
drive to form a raid again.
Would in this procedure btrfs-send detect any data corruption, and hopefully continue to send?
Scrub did abort, and force the fs read-only, but didn't unmount it.
Also, my backupscheme depends on btrfs-send and the IDs of snapshots. Migrating from the
old corrupted fs to a fresh one with btrfs-send should keep all the IDs as they were,
so my backupscheme would not see any difference when picking up with the new fs?

> Interesting that btrfs check doesn't see any problem, while the tree
> checker does. That's its own bug somewhere...
> 
> Can you provide a complete dmesg of the read time tree checker error?
> Ideally everything from mount to going read-only.

I will gladly help with dissecting this if I can before deleting the corrupt fs.

I didn't touch the machine or fs since yesterday, and it still sits there as I left it. A minute
after mounting it the error was thrown in syslog, no new entry shows up since then in dmesg. The
fs still seems to be rw. I'm a bit uneasy to leave it in rw and to trip the fallback to ro with scrub.
Would that give new insights? I'll keep it in ro for now.

Thank you,

Stickstoff


dmesg -T
[..]
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): flagging fs with big metadata feature
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): disk space caching is enabled
[Sat Jan 15 13:34:44 2022] BTRFS info (device dm-1): has skinny extents
[Sat Jan 15 13:34:45 2022] BTRFS info (device dm-1): bdev /dev/mapper/123 errs: wr 0, rd 77, flush 0, corrupt 0, gen 0
[Sat Jan 15 13:34:50 2022] BTRFS info (device dm-1): checking UUID tree
[Sat Jan 15 13:35:31 2022] BTRFS critical (device dm-1): corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]
[Sat Jan 15 13:35:31 2022] BTRFS error (device dm-1): block=934474399744 read time tree block corruption detected
[Sat Jan 15 13:35:31 2022] BTRFS critical (device dm-1): corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]
[Sat Jan 15 13:35:31 2022] BTRFS error (device dm-1): block=934474399744 read time tree block corruption detected
[EOF]


mount | grep raid
/dev/mapper/123 on /media/raid type btrfs (rw,noatime,nodiratime,space_cache,subvolid=5,subvol=/)

