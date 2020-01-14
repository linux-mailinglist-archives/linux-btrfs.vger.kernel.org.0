Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADEC13B12A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 18:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgANRmB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 12:42:01 -0500
Received: from smtp.mujha-vel.cz ([81.30.225.246]:49079 "EHLO
        smtp.mujha-vel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 12:42:01 -0500
Received: from [81.30.250.3] (helo=[172.16.1.2])
        by smtp.mujha-vel.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jn@forever.cz>)
        id 1irQCQ-0005xW-IW; Tue, 14 Jan 2020 18:41:56 +0100
Subject: Re: slow single -> raid1 conversion (heavy write to original LVM
 volume)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <107f8e94-78bc-f891-0e1b-2db7903e8bde@forever.cz>
 <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
From:   jakub nantl <jn@forever.cz>
Message-ID: <2e55d20c-323f-e1a2-cdde-8ba0d50270e7@forever.cz>
Date:   Tue, 14 Jan 2020 18:41:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSeq=nY7HTRjh0Y_0PRJt579HwromzS0NkdF4U6kn_wiA@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hello,

thank for reply, here is the call trace, no need to reboot it, so I am
waiting :)

[538847.101197] sysrq: Show Blocked State
[538847.101206]   task                        PC stack   pid father
[538847.101321] btrfs           D    0 16014      1 0x00004004
[538847.101324] Call Trace:
[538847.101335]  __schedule+0x2e3/0x740
[538847.101339]  ? __switch_to_asm+0x40/0x70
[538847.101342]  ? __switch_to_asm+0x34/0x70
[538847.101345]  schedule+0x42/0xb0
[538847.101348]  schedule_timeout+0x203/0x2f0
[538847.101351]  ? __schedule+0x2eb/0x740
[538847.101355]  io_schedule_timeout+0x1e/0x50
[538847.101358]  wait_for_completion_io+0xb1/0x120
[538847.101363]  ? wake_up_q+0x70/0x70
[538847.101401]  write_all_supers+0x896/0x960 [btrfs]
[538847.101426]  btrfs_commit_transaction+0x6ea/0x960 [btrfs]
[538847.101456]  prepare_to_merge+0x210/0x250 [btrfs]
[538847.101484]  relocate_block_group+0x36b/0x5f0 [btrfs]
[538847.101512]  btrfs_relocate_block_group+0x15e/0x300 [btrfs]
[538847.101539]  btrfs_relocate_chunk+0x2a/0x90 [btrfs]
[538847.101566]  __btrfs_balance+0x409/0xa50 [btrfs]
[538847.101593]  btrfs_balance+0x3ae/0x530 [btrfs]
[538847.101621]  btrfs_ioctl_balance+0x2c1/0x380 [btrfs]
[538847.101648]  btrfs_ioctl+0x836/0x20d0 [btrfs]
[538847.101652]  ? do_anonymous_page+0x2e6/0x650
[538847.101656]  ? __handle_mm_fault+0x760/0x7a0
[538847.101662]  do_vfs_ioctl+0x407/0x670
[538847.101664]  ? do_vfs_ioctl+0x407/0x670
[538847.101669]  ? do_user_addr_fault+0x216/0x450
[538847.101672]  ksys_ioctl+0x67/0x90
[538847.101675]  __x64_sys_ioctl+0x1a/0x20
[538847.101680]  do_syscall_64+0x57/0x190
[538847.101683]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[538847.101687] RIP: 0033:0x7f3cb04c85d7
[538847.101695] Code: Bad RIP value.
[538847.101697] RSP: 002b:00007ffcd4e5fe88 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[538847.101701] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007f3cb04c85d7
[538847.101704] RDX: 00007ffcd4e5ff18 RSI: 00000000c4009420 RDI:
0000000000000003
[538847.101707] RBP: 00007ffcd4e5ff18 R08: 0000000000000078 R09:
0000000000000000
[538847.101710] R10: 0000559f27675010 R11: 0000000000000246 R12:
0000000000000003
[538847.101713] R13: 00007ffcd4e62734 R14: 0000000000000001 R15:
0000000000000000
[538847.101718] btrfs           D    0 30196      1 0x00000004
[538847.101720] Call Trace:
[538847.101724]  __schedule+0x2e3/0x740
[538847.101727]  schedule+0x42/0xb0
[538847.101753]  btrfs_cancel_balance+0xf8/0x170 [btrfs]
[538847.101759]  ? wait_woken+0x80/0x80
[538847.101786]  btrfs_ioctl+0x13af/0x20d0 [btrfs]
[538847.101789]  ? do_anonymous_page+0x2e6/0x650
[538847.101793]  ? __handle_mm_fault+0x760/0x7a0
[538847.101797]  do_vfs_ioctl+0x407/0x670
[538847.101800]  ? do_vfs_ioctl+0x407/0x670
[538847.101803]  ? do_user_addr_fault+0x216/0x450
[538847.101806]  ksys_ioctl+0x67/0x90
[538847.101809]  __x64_sys_ioctl+0x1a/0x20
[538847.101813]  do_syscall_64+0x57/0x190
[538847.101856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[538847.101859] RIP: 0033:0x7fa33680c5d7
[538847.101864] Code: Bad RIP value.
[538847.101873] RSP: 002b:00007ffdbe2b9c58 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[538847.101888] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007fa33680c5d7
[538847.101897] RDX: 0000000000000002 RSI: 0000000040049421 RDI:
0000000000000003
[538847.101908] RBP: 00007ffdbe2ba1d8 R08: 0000000000000078 R09:
0000000000000000
[538847.101918] R10: 00005604500f4010 R11: 0000000000000246 R12:
00007ffdbe2ba735
[538847.101928] R13: 00007ffdbe2ba1c0 R14: 0000000000000000 R15:
0000000000000000




On 14. 01. 20 18:18, Chris Murphy wrote:
> On Tue, Jan 14, 2020 at 6:27 AM jn <jn@forever.cz> wrote:
>> Hello,
>>
>> I am experiencing very slow conversion from single disk BTRFS to raid1
>> balanced (new disk was added):
>>
>> what I have done:
>>
>> I have added new disk to nearly full (cca 85%) BTRFS filesystem on LVM
>> volume with intention to convert it into raid1:
>>
>> btrfs balance start -dconvert raid1 -mconvert raid1 /data/
>>
>>> Jan 10 08:14:04 sopa kernel: [155893.485617] BTRFS info (device dm-0):
>>> disk added /dev/sdb3
>>> Jan 10 08:15:06 sopa kernel: [155955.958561] BTRFS info (device dm-0):
>>> relocating block group 2078923554816 flags data
>>> Jan 10 08:15:07 sopa kernel: [155956.991293] BTRFS info (device dm-0):
>>> relocating block group 2077849812992 flags data
>>> Jan 10 08:15:10 sopa kernel: [155960.357846] BTRFS info (device dm-0):
>>> relocating block group 2076776071168 flags data
>>> Jan 10 08:15:13 sopa kernel: [155962.772534] BTRFS info (device dm-0):
>>> relocating block group 2075702329344 flags data
>>> Jan 10 08:15:14 sopa kernel: [155964.195237] BTRFS info (device dm-0):
>>> relocating block group 2074628587520 flags data
>>> Jan 10 08:15:45 sopa kernel: [155994.546695] BTRFS info (device dm-0):
>>> relocating block group 2062817427456 flags data
>>> Jan 10 08:15:52 sopa kernel: [156001.952247] BTRFS info (device dm-0):
>>> relocating block group 2059596201984 flags data
>>> Jan 10 08:15:58 sopa kernel: [156007.787071] BTRFS info (device dm-0):
>>> relocating block group 2057448718336 flags data
>>> Jan 10 08:16:00 sopa kernel: [156010.094565] BTRFS info (device dm-0):
>>> relocating block group 2056374976512 flags data
>>> Jan 10 08:16:06 sopa kernel: [156015.585343] BTRFS info (device dm-0):
>>> relocating block group 2054227492864 flags data
>>> Jan 10 08:16:12 sopa kernel: [156022.305629] BTRFS info (device dm-0):
>>> relocating block group 2051006267392 flags data
>>> Jan 10 08:16:23 sopa kernel: [156033.373144] BTRFS info (device dm-0):
>>> found 75 extents
>>> Jan 10 08:16:29 sopa kernel: [156038.666672] BTRFS info (device dm-0):
>>> found 75 extents
>>> Jan 10 08:16:36 sopa kernel: [156045.909270] BTRFS info (device dm-0):
>>> found 75 extents
>>> Jan 10 08:16:42 sopa kernel: [156052.292789] BTRFS info (device dm-0):
>>> found 75 extents
>>> Jan 10 08:16:46 sopa kernel: [156055.643452] BTRFS info (device dm-0):
>>> found 75 extents
>>> Jan 10 08:16:54 sopa kernel: [156063.608344] BTRFS info (device dm-0):
>>> found 75 extents
>> after 6hours of processing with 0% progress reported by balance status,
>> I decided to cancel it to empty more space and rerun balance with some
>> filters:
>>
>> btrfs balance cancel /data
>>
>>> Jan 10 14:38:11 sopa kernel: [178941.189217] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:14 sopa kernel: [178943.619787] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:20 sopa kernel: [178950.275334] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:24 sopa kernel: [178954.018770] INFO: task btrfs:30196
>>> blocked for more than 845 seconds.
> Often a developer will want to see sysrq+w output following a blocked
> task message like this.
> https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
>
> It's a bit different depending on the distribution but typical is:
>
> echo 1 >/proc/sys/kernel/sysrq   ##this enables sysrq
> echo w > /proc/sysrq-trigger     ##this is the trigger
>
> It'll dump to kernel messages; sometimes there's more than the kernel
> message buffer can hold; I personally use 'journalctl -k -o
> short-monotonic > journal.txt'  to capture all kernel messages in a
> file, and put that up somewhere. They're sometimes too big as
> attachments for the list, so I sometimes do both.
>
>
>
>>> Jan 10 14:38:24 sopa kernel: [178954.018844]
>>> btrfs_cancel_balance+0xf8/0x170 [btrfs]
>>> Jan 10 14:38:24 sopa kernel: [178954.018878]
>>> btrfs_ioctl+0x13af/0x20d0 [btrfs]
>>> Jan 10 14:38:28 sopa kernel: [178957.999108] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:29 sopa kernel: [178958.837674] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:30 sopa kernel: [178959.835118] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:38:31 sopa kernel: [178960.915305] BTRFS info (device dm-0):
>>> found 68 extents
>>> Jan 10 14:40:25 sopa kernel: [179074.851376]
>>> btrfs_cancel_balance+0xf8/0x170 [btrfs]
>>> Jan 10 14:40:25 sopa kernel: [179074.851408]
>>> btrfs_ioctl+0x13af/0x20d0 [btrfs]
>> now nearly 4 days later (and after some data deleted) both balance start
>> and balance cancel processes are still running and system reports:
> It's clearly stuck on something, not sure what. sysrq+w should help
> make it clear.
>
> Before forcing a reboot; make sure backups are current while the file
> system is still working. Balance is copy on write, so in theory it can
> be interrupted safely. But I'd do what you can to minimize the changes
> happening to the file system immediately prior to forcing the reboot:
> close out of everything, stop the GUI if you can and move to a VT, do
> a sync, and do 'reboot -f' instead of the friendlier 'reboot' because
> a systemd reboot causes a bunch of services to get quit and all of
> that does journal writes. It's really better to just force the reboot
> and cross your fingers.
>
> But yeah, if you can wait until hearing back from a dev. That's better.
>
>
>>> root@sopa:~# uname -a
>>> Linux sopa 5.4.8-050408-generic #202001041436 SMP Sat Jan 4 19:40:55
>>> UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> root@sopa:~#   btrfs --version
>>> btrfs-progs v4.15.1
> It's probably not related, but this is quite old compared to the kernel.
>
> There is a known bug in 5.4 that off hand I don't think is causing the
> problem you're seeing, but to avoid possibly strange space usage
> reporting you can optionally use metadata_ratio=1 mount option.
>
>
>
>>> root@sopa:~#   btrfs fi show
>>> Label: 'SOPADATA'  uuid: 37b8a62c-68e8-44e4-a3b2-eb572385c3e8
>>>     Total devices 2 FS bytes used 1.04TiB
>>>     devid    1 size 1.86TiB used 1.86TiB path /dev/mapper/sopa-data
>>>     devid    2 size 1.86TiB used 0.00B path /dev/sdb3
>>>
>>> root@sopa:~# btrfs subvolume list /data
>>> ID 1021 gen 7564583 top level 5 path nfs
>>> ID 1022 gen 7564590 top level 5 path motion
>>> root@sopa:~#   btrfs fi df /data
>>> Data, single: total=1.84TiB, used=1.04TiB
>>> System, DUP: total=8.00MiB, used=224.00KiB
>>> System, single: total=4.00MiB, used=0.00B
>>> Metadata, DUP: total=6.50GiB, used=2.99GiB
>>> Metadata, single: total=8.00MiB, used=0.00B
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>
>> is it normal that  it have written nearly 5TB of data to the original
>> disk ??:
>
> What I do see is there's not yet a single raid1 block group. That is
> strange. For sure it's stuck.
>
>
>
>>> root@sopa:/var/log# ps ax | grep balance
>>> 16014 ?        D    21114928:30 btrfs balance start -dconvert raid1
>>> -mconvert raid1 /data/
>>> 30196 ?        D      0:00 btrfs balance cancel /data
>>> root@sopa:/var/log# cat /proc/16014/io | grep bytes
>>> read_bytes: 1150357504
>>> write_bytes: 5812039966720
> No idea.
>
>
>>> root@sopa:/sys/block# cat  /sys/block/sdb/sdb3/stat
>>>      404        0    39352      956  4999199     1016 40001720
>>> 71701953        0 14622628 67496136        0        0        0        0
>>> [520398.089952] btrfs(16014): WRITE block 131072 on sdb3 (8 sectors)
>>> [520398.089975] btrfs(16014): WRITE block 536870912 on sdb3 (8 sectors)
>>> [520398.089995] btrfs(16014): WRITE block 128 on dm-0 (8 sectors)
>>> [520398.090021] btrfs(16014): WRITE block 131072 on dm-0 (8 sectors)
>>> [520398.090040] btrfs(16014): WRITE block 536870912 on dm-0 (8 sectors)
>>> [520398.154382] btrfs(16014): WRITE block 14629168 on dm-0 (512 sectors)
>>> [520398.155017] btrfs(16014): WRITE block 17748832 on dm-0 (512 sectors)
>>> [520398.155545] btrfs(16014): WRITE block 17909352 on dm-0 (512 sectors)
>>> [520398.156091] btrfs(16014): WRITE block 20534680 on dm-0 (512 sectors)
>>>
>> regards
>>
>> jn
>>
>>
>
> It's really confused, I'm not sure why from the available information.
>

