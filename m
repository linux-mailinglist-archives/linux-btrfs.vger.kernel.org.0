Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFD157B8A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgBJNah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 08:30:37 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39250 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbgBJNad (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 08:30:33 -0500
Received: by mail-vs1-f43.google.com with SMTP id p14so4090024vsq.6
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2020 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cqSR5i88tRjDQklOUokObYXi81pse2mIcHkoD3hzU40=;
        b=eF7zY+MHqHANO2kqM14uwGKU78NMIczlrbqSAQbDMNQDyONZEJVYgwXx0YvsmwQiPW
         KEGwWlhlIU8IHMWQHNL5q9Y9NRTj8+0pLLEBNgbyd4zOvFxQ/Ocw29jcYHKXnsQ0m3du
         2TWS5fVthQO0Qdm1aq/djAGuKSY1vGrPO88QnmRi3ht+EAIIRwvuZZFejxDJBDd6IZYR
         qsBd/HcGYwP2ZjH7hn1dmkAnjcoQSFMou9yakbeT6DKslZKx/ckUDonfsblGoqCGInkp
         qdbulAuqPjk7s0MOFLPT54UjEeEcbQaXtj6J8r4yb8F74fD+kb2+tvu8551BRl6gVtvg
         F/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cqSR5i88tRjDQklOUokObYXi81pse2mIcHkoD3hzU40=;
        b=APKRqyM4qEE/6KQjOMiQ4szCI018D1rN7TBi8HVhYujatW7GCSJMMXwMj1vW+R+Q0P
         rpfJ1in0uql2RWeG/CanwJIoofCf9nQUlaIfLQO5qytp4iE5E10Dug2jotHRI53jDxjO
         PB9cZjPNlbwlBXeV+5JmNr2YGJdr3ZJ0j8i26x/LFwilAdZnHgkGnn7K8IhwOeR/SSBk
         svSJ1/JwdH/VLTwa63t1HlvmbIhLDQH/LExMjc2TTJKSXl0tFhGQL45gcsHDKeesEX/H
         yONJ1gjK6ddZUcFsCK1ipT8Mi7znpPIDSnqdZPHMnWTjISM/lTlgu4+Eqq6wCJXrOUua
         JPdw==
X-Gm-Message-State: APjAAAXF3EIsQN+o8euVoH4MMeggmmU4wrqfO67tPyc7LHorN61x6evz
        Jx7T4aTq0+Ov8DHKKUuUY6QOgv1XYnRdsYJ6B9lmwwqa
X-Google-Smtp-Source: APXvYqyff0RAngtCvolltGsazEBMpRXHqzjaDY4PQnnKnYDCb6cV+I1QH/CYuWv8cMqRfLLXqo7aXG9EB3QuGt6Fz2U=
X-Received: by 2002:a05:6102:303a:: with SMTP id v26mr6818526vsa.119.1581341432218;
 Mon, 10 Feb 2020 05:30:32 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_R=C3=A4del?= <christian.raedel@gmail.com>
Date:   Mon, 10 Feb 2020 14:29:56 +0100
Message-ID: <CAH6ZjHqkPN9vdXHoneTeYA4xejZMLkVffu=cUnxcQvQrSx+R1Q@mail.gmail.com>
Subject: Restore almost all files from non-mountable filesystem
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

$> uname -a

Linux core 5.5.2-arch1-1 #1 SMP PREEMPT Tue, 04 Feb 2020 18:56:18
+0000 x86_64 GNU/Linux

$> btrfs --version

btrfs-progs v5.4.1

$> btrfs fi show /dev/sdd1

Label: 'data'  uuid: 5bdd91dd-8a61-408d-9a22-f2f10293c36e
Total devices 1 FS bytes used 2.92TiB
devid    1 size 3.64TiB used 3.15TiB path /dev/sdd1

$> mount -o compress=lzo,clear_cache,nospace_cache,ro -L data /media/data

mount: /media/data: wrong fs type, bad option, bad superblock on
/dev/sdd1, missing                            codepage or helper
program, or other error.

$> dmesg | grep -i btrfs

[    2.846524] Btrfs loaded, crc32c=crc32c-intel
[    2.851902] BTRFS: device label data devid 1 transid 45682
/dev/sdd1 scanned by systemd-udevd (232)
[ 3704.305920] BTRFS info (device sdd1): use lzo compression, level 0
[ 3704.305923] BTRFS info (device sdd1): force clearing of disk cache
[ 3704.305925] BTRFS info (device sdd1): disabling disk space caching
[ 3704.305926] BTRFS info (device sdd1): has skinny extents
[ 3704.989970] BTRFS error (device sdd1): parent transid verify failed
on 33357824 wanted 45668 found 45681
[ 3704.990327] BTRFS error (device sdd1): parent transid verify failed
on 33357824 wanted 45668 found 45681
[ 3704.990336] BTRFS warning (device sdd1): failed to read root (objectid=4): -5
[ 3705.042892] BTRFS error (device sdd1): open_ctree failed

Hi,

I've done a

$> btrfs restore -m -S /dev/sdd1 /media/backup
parent transid verify failed on 33357824 wanted 45668 found 45681
parent transid verify failed on 33357824 wanted 45668 found 45681
parent transid verify failed on 33357824 wanted 45668 found 45681
Ignoring transid failure
parent transid verify failed on 31899648 wanted 45662 found 45680
parent transid verify failed on 31899648 wanted 45662 found 45680
parent transid verify failed on 31899648 wanted 45662 found 45680
Ignoring transid failure

but it has found nothing. After experimenting with the parameters -d
and --path-regex, it has found some deleted files, maybe from the root
directory. So my question: How to restore almost all files that can be
restored with the btrfs restore command without a knowledge of the
directory structure? By the way: There exists an application called
Reclaime (for Windows) that can scan and find all my files, and is
able to show/play them. But since it is only an evaluation version, I
cannot save anything.

Sincerly,
Christian
