Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5958C13AAF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 14:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANN1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 08:27:14 -0500
Received: from smtp.mujha-vel.cz ([81.30.225.246]:57637 "EHLO
        smtp.mujha-vel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgANN1O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 08:27:14 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 08:27:12 EST
Received: from [81.30.250.3] (helo=[172.16.1.2])
        by smtp.mujha-vel.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jn@forever.cz>)
        id 1irM3p-00046p-9y
        for linux-btrfs@vger.kernel.org; Tue, 14 Jan 2020 14:16:46 +0100
To:     linux-btrfs@vger.kernel.org
From:   jn <jn@forever.cz>
Subject: slow single -> raid1 conversion (heavy write to original LVM volume)
Message-ID: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
Date:   Tue, 14 Jan 2020 14:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I am experiencing very slow conversion from single disk BTRFS to raid1
balanced (new disk was added):

what I have done:

I have added new disk to nearly full (cca 85%) BTRFS filesystem on LVM
volume with intention to convert it into raid1:

btrfs balance start -dconvert raid1 -mconvert raid1 /data/

> Jan 10 08:14:04 sopa kernel: [155893.485617] BTRFS info (device dm-0):
> disk added /dev/sdb3
> Jan 10 08:15:06 sopa kernel: [155955.958561] BTRFS info (device dm-0):
> relocating block group 2078923554816 flags data
> Jan 10 08:15:07 sopa kernel: [155956.991293] BTRFS info (device dm-0):
> relocating block group 2077849812992 flags data
> Jan 10 08:15:10 sopa kernel: [155960.357846] BTRFS info (device dm-0):
> relocating block group 2076776071168 flags data
> Jan 10 08:15:13 sopa kernel: [155962.772534] BTRFS info (device dm-0):
> relocating block group 2075702329344 flags data
> Jan 10 08:15:14 sopa kernel: [155964.195237] BTRFS info (device dm-0):
> relocating block group 2074628587520 flags data
> Jan 10 08:15:45 sopa kernel: [155994.546695] BTRFS info (device dm-0):
> relocating block group 2062817427456 flags data
> Jan 10 08:15:52 sopa kernel: [156001.952247] BTRFS info (device dm-0):
> relocating block group 2059596201984 flags data
> Jan 10 08:15:58 sopa kernel: [156007.787071] BTRFS info (device dm-0):
> relocating block group 2057448718336 flags data
> Jan 10 08:16:00 sopa kernel: [156010.094565] BTRFS info (device dm-0):
> relocating block group 2056374976512 flags data
> Jan 10 08:16:06 sopa kernel: [156015.585343] BTRFS info (device dm-0):
> relocating block group 2054227492864 flags data
> Jan 10 08:16:12 sopa kernel: [156022.305629] BTRFS info (device dm-0):
> relocating block group 2051006267392 flags data
> Jan 10 08:16:23 sopa kernel: [156033.373144] BTRFS info (device dm-0):
> found 75 extents
> Jan 10 08:16:29 sopa kernel: [156038.666672] BTRFS info (device dm-0):
> found 75 extents
> Jan 10 08:16:36 sopa kernel: [156045.909270] BTRFS info (device dm-0):
> found 75 extents
> Jan 10 08:16:42 sopa kernel: [156052.292789] BTRFS info (device dm-0):
> found 75 extents
> Jan 10 08:16:46 sopa kernel: [156055.643452] BTRFS info (device dm-0):
> found 75 extents
> Jan 10 08:16:54 sopa kernel: [156063.608344] BTRFS info (device dm-0):
> found 75 extents
after 6hours of processing with 0% progress reported by balance status,
I decided to cancel it to empty more space and rerun balance with some
filters:

btrfs balance cancel /data

> Jan 10 14:38:11 sopa kernel: [178941.189217] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:14 sopa kernel: [178943.619787] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:20 sopa kernel: [178950.275334] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:24 sopa kernel: [178954.018770] INFO: task btrfs:30196
> blocked for more than 845 seconds.
> Jan 10 14:38:24 sopa kernel: [178954.018844] 
> btrfs_cancel_balance+0xf8/0x170 [btrfs]
> Jan 10 14:38:24 sopa kernel: [178954.018878] 
> btrfs_ioctl+0x13af/0x20d0 [btrfs]
> Jan 10 14:38:28 sopa kernel: [178957.999108] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:29 sopa kernel: [178958.837674] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:30 sopa kernel: [178959.835118] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:38:31 sopa kernel: [178960.915305] BTRFS info (device dm-0):
> found 68 extents
> Jan 10 14:40:25 sopa kernel: [179074.851376] 
> btrfs_cancel_balance+0xf8/0x170 [btrfs]
> Jan 10 14:40:25 sopa kernel: [179074.851408] 
> btrfs_ioctl+0x13af/0x20d0 [btrfs]

now nearly 4 days later (and after some data deleted) both balance start
and balance cancel processes are still running and system reports:

> root@sopa:/var/log# btrfs balance status /data/
> Balance on '/data/' is running, cancel requested
> 0 out of about 1900 chunks balanced (29 considered), 100% left

> root@sopa:~# uname -a
> Linux sopa 5.4.8-050408-generic #202001041436 SMP Sat Jan 4 19:40:55
> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> root@sopa:~#   btrfs --version
> btrfs-progs v4.15.1
>
> root@sopa:~#   btrfs fi show
> Label: 'SOPADATA'  uuid: 37b8a62c-68e8-44e4-a3b2-eb572385c3e8
>     Total devices 2 FS bytes used 1.04TiB
>     devid    1 size 1.86TiB used 1.86TiB path /dev/mapper/sopa-data
>     devid    2 size 1.86TiB used 0.00B path /dev/sdb3
>
> root@sopa:~# btrfs subvolume list /data
> ID 1021 gen 7564583 top level 5 path nfs
> ID 1022 gen 7564590 top level 5 path motion

> root@sopa:~#   btrfs fi df /data
> Data, single: total=1.84TiB, used=1.04TiB
> System, DUP: total=8.00MiB, used=224.00KiB
> System, single: total=4.00MiB, used=0.00B
> Metadata, DUP: total=6.50GiB, used=2.99GiB
> Metadata, single: total=8.00MiB, used=0.00B
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
is it normal that  it have written nearly 5TB of data to the original
disk ??:

> root@sopa:/var/log# ps ax | grep balance
> 16014 ?        D    21114928:30 btrfs balance start -dconvert raid1
> -mconvert raid1 /data/
> 30196 ?        D      0:00 btrfs balance cancel /data

> root@sopa:/var/log# cat /proc/16014/io | grep bytes
> read_bytes: 1150357504
> write_bytes: 5812039966720
> root@sopa:/sys/block# cat  /sys/block/sdb/sdb3/stat
>      404        0    39352      956  4999199     1016 40001720
> 71701953        0 14622628 67496136        0        0        0        0

> [520398.089952] btrfs(16014): WRITE block 131072 on sdb3 (8 sectors)
> [520398.089975] btrfs(16014): WRITE block 536870912 on sdb3 (8 sectors)
> [520398.089995] btrfs(16014): WRITE block 128 on dm-0 (8 sectors)
> [520398.090021] btrfs(16014): WRITE block 131072 on dm-0 (8 sectors)
> [520398.090040] btrfs(16014): WRITE block 536870912 on dm-0 (8 sectors)
> [520398.154382] btrfs(16014): WRITE block 14629168 on dm-0 (512 sectors)
> [520398.155017] btrfs(16014): WRITE block 17748832 on dm-0 (512 sectors)
> [520398.155545] btrfs(16014): WRITE block 17909352 on dm-0 (512 sectors)
> [520398.156091] btrfs(16014): WRITE block 20534680 on dm-0 (512 sectors)
>
regards

jn


