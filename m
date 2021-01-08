Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737A12EF827
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbhAHTaj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 14:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbhAHTaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 14:30:39 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D21C061380
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Jan 2021 11:29:59 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id r14so623788qvr.13
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Jan 2021 11:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LS9a8SZnezWObWA4gbLN4aj2SjwW+kHKnO3pKvWj0/I=;
        b=Tx+gLGZR7BbaRvM4AR5M3H/75DwJZsX1amHOpfwmdRGPlaDurH2cggkGRMq+NResAL
         EmD+b/nj0dv79v9QM4rjilWmgni/izDI2e32T1fWnSfvVggVB+kX7TCL8yOJ0cMrOZ9j
         w9EiBVZtB38OJJv1hclrAjwaxEnuZX5X3UbmJ/GUPOi5g5pxbGQsttJt/c1x4FIsWruY
         yYAYXW3JjHMPYwe5TQ+ZAqLkIg7wQw7aBA+VO0HTjQo4T1pcEEmDGLxxTl0TmaKiE/r1
         /45hJ5/2Yp5OfknmPV9h7XMiT8LmS/xHEg7hpknh7vyOnKwucQvDnmqBFnpTSUbqoIQi
         6n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LS9a8SZnezWObWA4gbLN4aj2SjwW+kHKnO3pKvWj0/I=;
        b=qOYO2TVMd+qfFasjgJkIVIuNaPg9PoBBKFd4s/oW9H/BSG7XnM5Ld5RuZT37m3Qws2
         axJK5E96sh+Q0DiITKUPbiwNqQMXA0650e6e+I5kRyEWEZPNxUAyCxXbe251LkDlNe7A
         1VDzmBEU3RoMyydcNjChnl2nqB38q0g1zaYiYsGahBEp6uwG/0PFHpYzvl5eS767rj23
         LkBnLboEkqiRPq5uKahZ05qMrS5HHZ9p8spkKEq2t7VfTUMX0TZrV7dKMXEv/yYVecuB
         SZCHl7uvyOC8onIrNfqIwRqbZRBXhNNp+GN3h4hOcjsWa3tOsneWBe96qjCn4+Itp4eT
         oLtQ==
X-Gm-Message-State: AOAM532kkl4HV2q23418IKdsIhT43BemQLJpa0dNYpJEgqCyyODzP2YN
        Mrh67WCQ7OsbsU0SMGVKN4lpMHZ45nPRgDVPRgc=
X-Google-Smtp-Source: ABdhPJwapYbq0slmelIZ4p29iSqn3WAtxCJhRfK6ccU37wDJcfGjPJutv+Un12rovOoxGk3J4lRUFB8Sd6dF9x2cwno=
X-Received: by 2002:ad4:5188:: with SMTP id b8mr8251717qvp.55.1610134198295;
 Fri, 08 Jan 2021 11:29:58 -0800 (PST)
MIME-Version: 1.0
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com> <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
In-Reply-To: <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Fri, 8 Jan 2021 20:29:45 +0100
Message-ID: <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
To:     Cedric.dewijs@eclipso.eu
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno ven 8 gen 2021 alle ore 09:36 <Cedric.dewijs@eclipso.eu> ha scritto:
> What happens when I poison one of the drives in the mdadm array using this command? Will all data come out OK?
> dd if=/dev/urandom of=/dev/dev/sdb1 bs=1M count = 100?

<smiling>
Well, (happens) the same thing when your laptop is stolen or you read
"open_ctree failed"...You restore backup...
</smiling>

I have a few idea, but it's much more quicker to try it. Let's see:

truncate -s 5G dev1
truncate -s 5G dev2
losetup /dev/loop31 dev1
losetup /dev/loop32 dev2
mdadm --create --verbose --assume-clean /dev/md0 --level=1
--raid-devices=2 /dev/loop31 --write-mostly /dev/loop32
mkfs.btrfs /dev/md0
mount -o compress=lzo /dev/md0 /mnt/sg10/
cd /mnt/sg10/
cp -af /home/gelma/dev/kernel/ .
root@glet:/mnt/sg10# dmesg -T
[Fri Jan  8 19:51:33 2021] md/raid1:md0: active with 2 out of 2 mirrors
[Fri Jan  8 19:51:33 2021] md0: detected capacity change from 0 to 5363466240
[Fri Jan  8 19:51:53 2021] BTRFS: device fsid
2fe43610-20e5-48de-873d-d1a6c2db2a6a devid 1 transid 5 /dev/md0
scanned by mkfs.btrfs (512004)
[Fri Jan  8 19:51:53 2021] md: data-check of RAID array md0
[Fri Jan  8 19:52:19 2021] md: md0: data-check done.
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): setting incompat
feature flag for COMPRESS_LZO (0x8)
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): use lzo compression, level 0
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): disk space caching
is enabled
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): has skinny extents
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): flagging fs with
big metadata feature
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): enabling ssd optimizations
[Fri Jan  8 19:53:13 2021] BTRFS info (device md0): checking UUID tree

root@glet:/mnt/sg10# btrfs scrub start -B .
scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
Scrub started:    Fri Jan  8 20:01:59 2021
Status:           finished
Duration:         0:00:04
Total to scrub:   4.99GiB
Rate:             1.23GiB/s
Error summary:    no errors found

We check the array is in sync:

root@glet:/mnt/sg10# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5]
[raid4] [raid10]
md0 : active raid1 loop32[1](W) loop31[0]
     5237760 blocks super 1.2 [2/2] [UU]

unused devices: <none>

Now we wipe the storage;
root@glet:/mnt/sg10# dd if=/dev/urandom of=/dev/loop32 bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.919025 s, 114 MB/s

sync

echo 3 > /proc/sys/vm/drop_caches

I do rm to force write i/o:

root@glet:/mnt/sg10# rm kernel/v5.11/ -rf

root@glet:/mnt/sg10# btrfs scrub start -B .
scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
Scrub started:    Fri Jan  8 20:11:21 2021
Status:           finished
Duration:         0:00:03
Total to scrub:   4.77GiB
Rate:             1.54GiB/s
Error summary:    no errors found

Now, I stop the array and re-assembly:
mdadm -Ss

root@glet:/# mdadm --assemble /dev/md0 /dev/loop31 /dev/loop32
mdadm: /dev/md0 has been started with 2 drives.

root@glet:/# mount /dev/md0 /mnt/sg10/
root@glet:/# btrfs scrub start -B  /mnt/sg10/
scrub done for 2fe43610-20e5-48de-873d-d1a6c2db2a6a
Scrub started:    Fri Jan  8 20:15:16 2021
Status:           finished
Duration:         0:00:03
Total to scrub:   4.77GiB
Rate:             1.54GiB/s
Error summary:    no errors found

Ciao,
Gelma
