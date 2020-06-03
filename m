Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B391ED0FD
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCNhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCNhe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 09:37:34 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6EC08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 06:37:33 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y123so1392696vsb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=B6kU6YsH8+v6lRnrEBnjU77lMQrxZSMuDt4AvqFz+4A=;
        b=INtW4yapCobcpH/ZP4a0kNd6h6SOtZlwY0RT5XdZmoCMfB1KIOh1m/FPXOWtrvww7U
         qR4qrdX071+o9XlrTG/ILF8gy6KpuTPZ4stjBEnydtG0emCLKR35yYWqEpm1avTy/1tx
         J+5/Au3PCsBbH5m+moizBR8zFpdjcHgypxW2L4V6xmkTONaKZdEYbVKp7odmmS/kRwl7
         gJSQa102VUNRxi0fLLqmBdJH/7qHeE/UZ1EUZYbmBJNu2VIHATMZhOouJqph8lvT/iTB
         VY978abOh+FjJQBE290m08iaGrVF5vkHqLz+JiampYC5Tc9acK7lXX054asnaqR16ueZ
         8ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=B6kU6YsH8+v6lRnrEBnjU77lMQrxZSMuDt4AvqFz+4A=;
        b=RtH7he3vLyvckPRE1AyL1tvuwMm4/KNLQyqa0r9RCmm0wRtvhySN9oy9BCDyk8u6ff
         BwHtHefcMK6yZHBzZki9ksY3Ly1mAMpMXyv7c9oRVflXYJROvFk4gzL2Nve5gLSnCo2E
         AsuENLrl0OHYWOp5g3oATJbkbNczWJexNb7UkLkHzbblWj6lDwVRGSN0SJQakLw8pN8/
         I4YeMYjeSABc17bLZZV1NO331qKXsOt7huBZ0DbPHpwPE1m6kdIy9RUDUDiDKKGRhJTl
         drXvNrF6YNtYrsPlTBrtEkrxjVdNDJHYL5zzG8f6IBFvyhEkCOk0gKA29IftRPCvsQTf
         qBfA==
X-Gm-Message-State: AOAM531wqYnpKmGazZ7wra7KTFFR0+S2sUE5nCq8FhuXjX7yAL5uq89n
        EhDdgDcr8YugrkmyozP2+eUlzgAyxA2rw9smbfzcr4YP
X-Google-Smtp-Source: ABdhPJxe+ct1ZsQv9Yp3UezUNYFQJLxHk0tj/djmxrAQ5iziC7Y9thU5RPlY+PIeyTl92ZmmAzUMJ67AzJIzV8xvY1A=
X-Received: by 2002:a67:1c04:: with SMTP id c4mr23018632vsc.133.1591191452525;
 Wed, 03 Jun 2020 06:37:32 -0700 (PDT)
MIME-Version: 1.0
From:   Thorsten Rehm <thorsten.rehm@gmail.com>
Date:   Wed, 3 Jun 2020 15:37:21 +0200
Message-ID: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
Subject: corrupt leaf; invalid root item size
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I've updated my system (Debian testing) [1] several months ago (~
December) and I noticed a lot of corrupt leaf messages flooding my
kern.log [2]. Furthermore my system had some trouble, e.g.
applications were terminated after some uptime, due to the btrfs
filesystem errors. This was with kernel 5.3.
The last time I tried was with Kernel 5.6.0-1-amd64 and the problem persists.

I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
release and with this kernel there aren't any corrupt leaf messages
and the problem is gone. IMHO, it must be something coming with kernel
5.3 (or 5.x).

My harddisk is a SSD which is responsible for the root partition. I've
encrypted my filesystem with LUKS and just right after I entered my
password at the boot, the first corrupt leaf errors appear.

An error message looks like this:
May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=35799040 slot=32, invalid root item
size, have 239 expect 439

"root=1", "slot=32", "have 239 expect 439" is always the same at every
error line. Only the block number changes.

Interestingly it's the very same as reported to the ML here [3]. I've
contacted the reporter, but he didn't have a solution for me, because
he changed to a different filesystem.

I've already tried "btrfs scrub" and "btrfs check --readonly /" in
rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
values of the SSD, which are fine. Furthermore I've tested my RAM, but
again, w/o any errors.

So, I have no more ideas what I can do. Could you please help me to
investigate this further? Could it be a bug?

Thank you very much.

Best regards,
Thorsten



1:
$ cat /etc/debian_version
bullseye/sid

$ uname -a
[no problem with this kernel]
Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.6

$ sudo btrfs fi show
Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
        Total devices 1 FS bytes used 7.33GiB
        devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sda5_crypt

$ btrfs fi df /
Data, single: total=22.01GiB, used=7.16GiB
System, DUP: total=32.00MiB, used=4.00KiB
System, single: total=4.00MiB, used=0.00B
Metadata, DUP: total=2.00GiB, used=168.19MiB
Metadata, single: total=8.00MiB, used=0.00B
GlobalReserve, single: total=25.42MiB, used=0.00B


2:
[several messages per second]
May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=35799040 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=35885056 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=35926016 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=35995648 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36184064 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36319232 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36380672 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36487168 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36597760 slot=32, invalid root item
size, have 239 expect 439
May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
dm-0): corrupt leaf: root=1 block=36626432 slot=32, invalid root item
size, have 239 expect 439

3:
https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c6496035c@web.de/
