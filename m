Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED302AFF60
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfIKO7R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 10:59:17 -0400
Received: from mail-vk1-f174.google.com ([209.85.221.174]:37288 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfIKO7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 10:59:17 -0400
Received: by mail-vk1-f174.google.com with SMTP id v78so4416136vke.4
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3fTyGdFByFGOJDex/SaRWBpEsAuW2YRh3sPadegHYZg=;
        b=jP9ZC/yZx10OJU3EIj7fXFuPLwb2t2+FjDd0ghBRiQIhVSCoDNYZWdBRK0bIwETBYh
         S+u8pTR9KDsoKqk7PCK+azN59Dm9sLyNLhogDclCJy/oTMPr884z1jiCHwGXc3Z7oX5R
         64Y61Mj0Pb6wSm++xSIyzGaCGqwx8hsluidHTkSWEBlNaGZ31ntbo16omzlApQOjYiPH
         xA4FsPVCgkjTCBKnxCZ8DO5uC3P908G/6O4ZHrIP87DwMY4m2rxfxqaUlrr+wjG0LNNg
         jp+9jpzU6aaJBeIVJqBU23bqKVOyx8TEMdxBYCF1GrEcRsCjiEDGsj6r/MQQZ+te+7Kq
         70HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3fTyGdFByFGOJDex/SaRWBpEsAuW2YRh3sPadegHYZg=;
        b=W2y+/We+kkIqDeqemmpBwy27GFIoTqVVvUh1CkR65ICjh09kae4AUYg7t3nXL14P0q
         HklNc+RPciJElwo2IodixtuS7J5vHw432z9Dja+McCH7BY+UaKJ8+1yNkfEJivzfSW0I
         cqP8MukkCPpcKbWV9uL/FfXqK5qLl8sEczX9EroI5YNMyMFtpcEaOjsp3gNg8Z50JE4i
         WlT8s/sKJhxE8+ca+3Oe8VIVj6yLSG3ph+YzgmeO/FCUeDm2N2WB2rttZCyWdcCivMBi
         xkeMJslwUrPQlLhBKN+IdoOiWgj/4NiL0ZCqImkc9ryQsi15RH33N95X/oJxIN+5SqrM
         ih+A==
X-Gm-Message-State: APjAAAVX8pyXJz+o3udvEb0K0zwWzbwy7cPrxwysNBC5Kp5xpFTS+bxD
        mRPnyDE8BJycv3vRTLtHxB12qRnBpIOH096hvkUtQiKx
X-Google-Smtp-Source: APXvYqwsGrF7ZiwW1yTGd0pWtIz31rFt7HVyExp/hMy9gonNGdHpiWhQHfUFOGDTkaWkztiBcuNXw4/ShBDzDei1ilw=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr6590929vkb.4.1568213955959;
 Wed, 11 Sep 2019 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <DB8PR03MB56287A9E527898E5727BB41599C80@DB8PR03MB5628.eurprd03.prod.outlook.com>
 <DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com>
In-Reply-To: <DB8PR03MB562876ECE2319B3E579590F799C80@DB8PR03MB5628.eurprd03.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Sep 2019 15:59:05 +0100
Message-ID: <CAL3q7H4sB=usrcGwwHa3jkVjsWBnNxNjLYaYJSo2tMsY0t6zRQ@mail.gmail.com>
Subject: Re: Deadlock between btrfs-transacti and userland on 5.2.1
To:     Drazen Kacar <drazen.kacar@oradian.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 18, 2019 at 1:25 PM Drazen Kacar <drazen.kacar@oradian.com> wro=
te:
>
> Hello,
>
> I think I've encountered a deadlock between btrfs-transacti and postgres
> process(es). This is system information (btrfs fi usage obtained after
> poweroff and boot):
>
> # cat /etc/redhat-release
> CentOS Linux release 7.6.1810 (Core)
>
> # uname -a
> Linux prod-dbsnap-01 5.2.1-1.el7.elrepo.x86_64 #1 SMP Sun Jul 14 08:15:04=
 EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.2
>
> # btrfs filesystem usage /data/pg_data
>  Overall:
>      Device size:                   2.00TiB
>      Device allocated:            345.03GiB
>      Device unallocated:            1.66TiB
>      Device missing:                  0.00B
>      Used:                        338.07GiB
>      Free (estimated):              1.67TiB      (min: 854.27GiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>
>  Data,RAID0: Size:332.00GiB, Used:329.22GiB
>     /dev/sdb       83.00GiB
>     /dev/sdc       83.00GiB
>     /dev/sdd       83.00GiB
>     /dev/sde       83.00GiB
>
>  Metadata,RAID10: Size:6.50GiB, Used:4.42GiB
>     /dev/sdb        3.25GiB
>     /dev/sdc        3.25GiB
>     /dev/sdd        3.25GiB
>     /dev/sde        3.25GiB
>
>  System,RAID10: Size:16.00MiB, Used:48.00KiB
>     /dev/sdb        8.00MiB
>     /dev/sdc        8.00MiB
>     /dev/sdd        8.00MiB
>     /dev/sde        8.00MiB
>
>  Unallocated:
>     /dev/sdb      425.74GiB
>     /dev/sdc      425.74GiB
>     /dev/sdd      425.74GiB
>     /dev/sde      425.74GiB
>
> There were three btrfs subvolumes and on each one there was a Postgres
> database slave doing recovery (single threaded writing). But there was a
> lot of writing. And prior to starting Postgres slaves I was restoring bas=
e
> backup from the backup server, which was being done by a number of
> parallel rsync processes (12 at most, I think).
>
> The file system is mounted with:
>
> # grep btrfs /proc/mounts
> /dev/sdd /data/pg_data btrfs rw,noatime,compress-force=3Dzstd:3,space_cac=
he,subvolid=3D5,subvol=3D/ 0 0
>
> After several hours I got this in /var/log/messages:
>
> # grep 'INFO: task .*blocked for more than' messages
>  Jul 17 16:47:09 prod-dbsnap-01 kernel: INFO: task btrfs-transacti:1361 b=
locked for more than 122 seconds.
>  Jul 17 16:47:09 prod-dbsnap-01 kernel: INFO: task postgres:62682 blocked=
 for more than 122 seconds.
>  Jul 17 16:47:09 prod-dbsnap-01 kernel: INFO: task postgres:80145 blocked=
 for more than 122 seconds.
>  Jul 17 16:47:09 prod-dbsnap-01 kernel: INFO: task postgres:87299 blocked=
 for more than 122 seconds.
>  Jul 17 16:47:09 prod-dbsnap-01 kernel: INFO: task postgres:93108 blocked=
 for more than 122 seconds.
>  Jul 17 16:49:12 prod-dbsnap-01 kernel: INFO: task btrfs-transacti:1361 b=
locked for more than 245 seconds.
>  Jul 17 16:49:12 prod-dbsnap-01 kernel: INFO: task postgres:62682 blocked=
 for more than 245 seconds.
>  Jul 17 16:49:12 prod-dbsnap-01 kernel: INFO: task postgres:80145 blocked=
 for more than 245 seconds.
>  Jul 17 16:49:12 prod-dbsnap-01 kernel: INFO: task postgres:87299 blocked=
 for more than 245 seconds.
>  Jul 17 16:49:12 prod-dbsnap-01 kernel: INFO: task postgres:93108 blocked=
 for more than 245 seconds.
>
> Full log is in the attachment. It seems to me that there is a deadlock
> between btrfs-transacti and any process which is trying to write
> something (not sure about reading). While this was going on the cpu
> usage (according to top) was non-existant. There are 4 cpus (it's a virtu=
al
> machine in VmWare) and 3 were 100% idle. The 4th was 100% in
> waiting. (I didn't find out which process was on that cpu, unfortunately.=
)
>
> I powered off the machine (yesterday), booted this morning and things
> are working without errors. I stopped postgres clusters, though.
>
> I have a few questions:
>
> 1.  After something like this happens and the machine is rebooted is ther=
e
> a procedure which would lower the probablity of encountering the deadlock
> again (maybe btrfs scrub or btrfs defragment or something like that)? Thi=
s
> happened after a heavy write activity,  so maybe fragmentation had
> something to do with it.
>
> 2. Should I run btrfsck (or something else) to verify on-disk integrity a=
fter a
> problem like this? Or it's just an in-memory problem, so I can assume tha=
t
> nothing bad happened to the data on disks.
>
> 3. I'd like to write a watchdog program to catch deadlocks and reboot
> (probably power-cycle) the VM, but I'm not sure what would the appropriat=
e
> check be. Does it have to write something to the disk or reading would be
> sufficient? And how to bypass the OS  buffer cache (fsync() or O_DIRECT
> should do it for writing, but I'm not sure about reading)?
>
> What would the appropriate timeout be? (If the operation doesn't
> complete in xx seconds a reboot should be triggered, but I don't know how
> many seconds to wait when there's  a heavy load and things are just slow,
> but there's no deadlock.)
>
> Should I put watchdog process in real-time class (or however the equivale=
nt
> is called on Linux)? Since this is a mainline kernel, I'm not sure if I c=
ould assume
> that real-time support won't have  bugs of its own.
>
> And last, but not least, is there additional data that could help with de=
bugging
> issues like this? (If possible, something that could be programmed into
> watchdog service.)

It's a regression introduced in 5.2
Fix just sent: https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fd=
manana@kernel.org/T/#u

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
