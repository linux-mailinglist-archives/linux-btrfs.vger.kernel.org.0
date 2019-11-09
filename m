Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9505BF5E52
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 11:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIJ6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Nov 2019 04:58:31 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:56522 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKIJ6b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Nov 2019 04:58:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7052B6083247;
        Sat,  9 Nov 2019 10:58:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3zvO4UyUOj48; Sat,  9 Nov 2019 10:58:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E880F608325B;
        Sat,  9 Nov 2019 10:58:26 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U3iM-mACpSmC; Sat,  9 Nov 2019 10:58:26 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C43296083247;
        Sat,  9 Nov 2019 10:58:26 +0100 (CET)
Date:   Sat, 9 Nov 2019 10:58:26 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Message-ID: <1535877515.79035.1573293506680.JavaMail.zimbra@nod.at>
In-Reply-To: <20191108233933.GU22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org> <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at> <20191108222557.GT22121@hungrycats.org> <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at> <20191108233933.GU22121@hungrycats.org>
Subject: checksum errors in orphaned blocks on multiple systems (Was: Re:
 Decoding "unable to fixup (regular)" errors)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: checksum errors in orphaned blocks on multiple systems (Was: Re: Decoding "unable to fixup (regular)" errors)
Thread-Index: yq+wq8zVYdPbHv8Q8F5+sw/0wSbmIA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While investigating I found two more systems with the same symptoms.

Please let me share my findings:

1. Only orphaned blocks show checksum errors, no "active" inodes are affected.

2. The errors were logged first a long time ago (more than one year), checked my logs.
   I get alarms for most failure, but not for "BTRFS error" strings in dmesg.
   But this explains why I didn't notice for such a long time.
   Yes, shame on me, I need to improve my monitoring.

3. All systems run OpenSUSE 15.0 or 15.1. But the btrfs filesystems were created at times
   of OpenSUSE 42.2 or older, I do regularly distro upgrades.

4. While my hardware is not new it should be good. I have ECC-Memory,
   enterprise disks. Every disk spasses SMART checks, etc...

5. Checksum errors are only on systems with an md-RAID1, I run btrfs on most other
   servers and workstations. No such errors there.

6. All systems work. These are build servers and/or git servers. If files would turn bad
   there is a good chance that one of my developers will notice an application failure.
   e.g. git will complain, reproducible builds are not reproducible anymore, etc...
   So these are not file servers where files are written once and never read again.

Zygo Blaxell pointed out that such errors can be explained by silent failures of
my disks and the nature of md-RAID1.
But how big is the chance that this happens on *three* independent systems and only
orphaned blocks are affected?
Even if all of my disks are bad and completely lying to me, I'd still expect that
the errors are distributed across all type of blocks (used data, orphaned data, tree, ...).

A wild guess from my side:
Could it be that there was a bug in old (OpenSUSE) kernels which causes orphaned
blocks to have bad checksums? Maybe only when combined with md-RAID?
Maybe discard plays a role too...

System 1:

[10860370.764595] BTRFS error (device md1): unable to fixup (regular) error at logical 593483341824 on dev /dev/md1
[10860395.236787] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2292, gen 0
[10860395.237267] BTRFS error (device md1): unable to fixup (regular) error at logical 595304841216 on dev /dev/md1
[10860395.506085] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2293, gen 0
[10860395.506560] BTRFS error (device md1): unable to fixup (regular) error at logical 595326820352 on dev /dev/md1
[10860395.511546] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2294, gen 0
[10860395.512061] BTRFS error (device md1): unable to fixup (regular) error at logical 595327647744 on dev /dev/md1
[10860395.664956] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2295, gen 0
[10860395.664959] BTRFS error (device md1): unable to fixup (regular) error at logical 595344850944 on dev /dev/md1
[10860395.677733] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2296, gen 0
[10860395.677736] BTRFS error (device md1): unable to fixup (regular) error at logical 595346452480 on dev /dev/md1
[10860395.770918] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2297, gen 0
[10860395.771523] BTRFS error (device md1): unable to fixup (regular) error at logical 595357601792 on dev /dev/md1
[10860395.789808] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2298, gen 0
[10860395.790455] BTRFS error (device md1): unable to fixup (regular) error at logical 595359870976 on dev /dev/md1
[10860395.806699] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2299, gen 0
[10860395.807381] BTRFS error (device md1): unable to fixup (regular) error at logical 595361865728 on dev /dev/md1
[10860395.918793] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2300, gen 0
[10860395.919513] BTRFS error (device md1): unable to fixup (regular) error at logical 595372343296 on dev /dev/md1
[10860395.993817] BTRFS error (device md1): bdev /dev/md1 errs: wr 0, rd 0, flush 0, corrupt 2301, gen 0
[10860395.994574] BTRFS error (device md1): unable to fixup (regular) error at logical 595384438784 on dev /dev/md1

md1 is RAID1 of two WDC WD1003FBYX-01Y7B1

System 2:

[2126822.239616] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
[2126822.239618] BTRFS error (device md0): unable to fixup (regular) error at logical 782823940096 on dev /dev/md0
[2126822.879559] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
[2126822.879561] BTRFS error (device md0): unable to fixup (regular) error at logical 782850768896 on dev /dev/md0
[2126823.847037] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
[2126823.847039] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 16, gen 0
[2126823.847041] BTRFS error (device md0): unable to fixup (regular) error at logical 782960300032 on dev /dev/md0
[2126823.847042] BTRFS error (device md0): unable to fixup (regular) error at logical 782959267840 on dev /dev/md0
[2126837.062852] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 17, gen 0
[2126837.062855] BTRFS error (device md0): unable to fixup (regular) error at logical 784446283776 on dev /dev/md0
[2126837.071656] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 18, gen 0
[2126837.071658] BTRFS error (device md0): unable to fixup (regular) error at logical 784446230528 on dev /dev/md0

md0 is RAID1 of two WDC WD3000FYYZ-01UL1B1

System 3:

[11470830.902308] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 80, gen 0
[11470830.902315] BTRFS error (device md0): unable to fixup (regular) error at logical 467063083008 on dev /dev/md0
[11470830.967863] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 81, gen 0
[11470830.967867] BTRFS error (device md0): unable to fixup (regular) error at logical 467063087104 on dev /dev/md0
[11470831.033057] BTRFS error (device md0): bdev /dev/md0 errs: wr 0, rd 0, flush 0, corrupt 82, gen 0
[11470831.033062] BTRFS error (device md0): unable to fixup (regular) error at logical 467063091200 on dev /dev/md0

md1 is RAID1 of two WDC WD3000FYYZ-01UL1B3

Thanks,
//richard
