Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDE609338
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJWNGX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 23 Oct 2022 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJWNGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 09:06:19 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12C06384E
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 06:06:16 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C127501800
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 13:06:15 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 50C8B5016A9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 13:06:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666530374; a=rsa-sha256;
        cv=none;
        b=5uT+QtzcMX8q/GSJwcaZYpI0/a5acvk6BQGSau8oOGdeGBRiCvhj9RnmX67j4sbrvwOrAj
        vdELW7csHcy1fUdbhtT/gRlqnRH2P2209vkp33bjKoBy0wOzlZZ+X7Eig6D0t704YMbfrb
        ldUq3bcqZW97z6Syq9xr2L+YVhkmPOQ+yxlRo7IoYOFkt67RqAYWLt92s3fY2pd9y32gom
        5QggL0MW3pjb1p0lCrLa8EUme7g+Tdux9S6sA3UBKoAnAb8UoIBzCU2SKiG/ksGbWkvcgK
        PYUuy7/pHKSsbjQDzu37rEfVWSDtzSyxLJvij0IZ1eWs4deJk2tzEFan2oHNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666530374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rkUkhzQCDvM/1J7YndS5SH6lfanfRybdewFdrjS3W3o=;
        b=zzYFJF6iyAs27hpD5QagA37K/BTex33BHltDyhqy+pvxZEDo5stMwglSkvElqfIbz5Jov6
        8JR3EdgMPmzSDh9+vcpK4rBrx2ephxf1YzHjkjW90SywNdWpxoJVz3OfpT692eZpHbHqWU
        TZ7rYM9W45JD4wmT92FSczC67D2rOFOweJIYcgwXhfM1L1lwRmvidS0pt9TJRJ84EG0/Oq
        XdwwzpNj3u0lLkfLV+z0pF6MrqWP3+EnOnp2nz0pS1sQWMcNQhg72WIakWdIb7Emeobm0f
        NBAgh3vy40Cz6hf9OHMy69WIWEpxb1yTYz0r0Bll4xGBqz7QVPsL+2UgcgWXpA==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-wjp6w;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bitter-Bottle: 4c9ea12b572e607b_1666530374813_3667658027
X-MC-Loop-Signature: 1666530374813:3100430515
X-MC-Ingress-Time: 1666530374812
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.129.222 (trex/6.7.1);
        Sun, 23 Oct 2022 13:06:14 +0000
Received: from ppp-88-217-43-50.dynamic.mnet-online.de ([88.217.43.50]:45696 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1omag4-0007Ur-6R
        for linux-btrfs@vger.kernel.org;
        Sun, 23 Oct 2022 13:06:12 +0000
Message-ID: <2291416ef48d98059f9fdc5d865b0ff040148237.camel@scientia.org>
Subject: all(!) btrfs filesystems stuck + CPU soft lockup after btrfs mv
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Sun, 23 Oct 2022 15:06:07 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.
I just encountered a really weird issue on kernel 6.0.3.

The system's root-fs runs on btrfs and I've attached an external USB
HDD, also with btrfs.
All the filesystems are on top of dm-crypt/LUKS and all these ones
still use space cache v1.


On the latter, I had something like:
 backups/...
 snapshots/_external-fs/heisenberg.scientia.net/.../2022-03-06_1
 snapshots/_external-fs/.../2022-06-26_1
and so on, where 2022-03-06_1, were ro-snapshots (incrementally created
via send|receive).

Now I wanted to move all heisenberg.scientia.net to backups/ but the mv
gave a Read-only filesystem error, but for each of the snapshot
directories (I'm pretty sure the fs *was* mounted rw).


So without much thinking I remembered that one couldn't always mv ro-
snapshots because their .. would need to change, so I did the following
instead:
 rmdir backups/
 mv snapshots/_external-fs/ .
 mv _external-fs/ backups

That got stuck already and kernel printed out some:
 rcu: INFO: rcu_preempt self-detected stall on CPU
 ...
 (see photos)


The mv couldn't be killed (neither with SIGKILL) and seemingly forever
I got every so and so many seconds a speaker beep, followed by another
call trace to the kernel with:
 watchdog: BUG: soft lockup - CPU#2 stuck for xxs! ...


I figured just unplugging the USB HDD might help the kernel to recover
- it did not.

It seemed as if I even couldn't write (or read?) anymore on the
system's root-fs (also btrfs).
While the desktop environment and the windows/terminals I had alread
opened continued to work (to some extent), and I luckily had one open
already that did dmesg | tail -f ... anything like opening a new
terminal got stuck.
Even ssh-ing to another system didn't work anymore (tried to copy the
logs away).


So unfortunately, only photos from the error messages:
https://drive.google.com/drive/folders/1iC_LVcvXUxuZEvCU33gFXP3nEExngNKY?usp=sharing


I had to hard-power-off the system.

Next I booted it from a rescue USB (though with slightly older
kernel/btrfsprogs) and --mode=original + --mode=lowmem btrfs-checked
the systems root-fs... no error was found there.
Neither did Debian's debsums found any errors. A btrfs scrub is still
running.

Back in the system (thus kernel 6.0.3 again and progs 6.0), a
--mode=original check on the external HDD got:
# btrfs check /dev/mapper/data-b-1 ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-b-1
UUID: fb93f31e-b0e6-4254-bb2a-482d79309725
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 2130334187520 has wrong amount of free space, free space cache has 212041728 block group has 231915520
failed to load free space cache for block group 2130334187520
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 5167160913920 bytes used, no error found
total csum bytes: 5037130492
total tree bytes: 8741093376
total fs tree bytes: 2812231680
total extent tree bytes: 229113856
btree space waste bytes: 1123300531
file data blocks allocated: 8774038773760
 referenced 6790890844160
0


No idea whether the cache corruption is from that incident or just a
coincidence.

Mounting it shows a filesystem at the following state:

- empty backups/
 which is, if you closely follow my photos not quite the "original"
 state, as it previously contained a few empty directories
- _external-fs/ back in snapshots/



After that, I tried to do what I wanted originally, that is
send|receive a current backup from the system's root-fs to the external
HDD.

Nearly immediately after I ran the send | receive ... the system
completely stuck (like not even the mouse was moving anymore) and after
a while I heard the beeps again (so presumably soft CPU lockup again)?

I repeated the game with booting from the rescue USB and
original/lowmem fsck, again no errors on the system fs.


I next booted a slightly older 6.0.2, went in systemd rescue mode (so
no desktop environment running) and did the send | receive there.
That finished (seemingly) correctly.

Then I booted 6.0.3 again, also rescue mode, and tried yet another send
| receive... though I Ctrl-Ced it after a while... it seemed to run -
at least the system didn't freeze.

So no idea what has happened there.




Any ideas?

Thanks,
Chris.

