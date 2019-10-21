Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC7DE7C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJUJRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:17:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbfJUJRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:17:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4281BB721;
        Mon, 21 Oct 2019 09:17:20 +0000 (UTC)
Subject: Re: "BUG: kernel NULL pointer dereference," when unmounting
 filesystem hitted by enospc error
To:     Peter Hjalmarsson <kanelxake@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CALpSwpjVz=F_hb9DbVanECsfWOYog2B7SLY=Dy0NvQx=w9voDA@mail.gmail.com>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f4037f43-97fb-5a25-52db-2d69ec69f6ee@suse.de>
Date:   Mon, 21 Oct 2019 11:17:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALpSwpjVz=F_hb9DbVanECsfWOYog2B7SLY=Dy0NvQx=w9voDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2019 21:29, Peter Hjalmarsson wrote:

Hi Peter,

Thanks for the report.

> While trying to reproduce another problem I have seen with BTRFS while
> running balance and raid6 I hit an issue resulting in:
> BUG: kernel NULL pointer dereference, address: 00000000000002ce
> 
> I created a script trying to pinpoint the problem utilizing zram, and
> the run goes like this:
> 
> 1. run the scripts which sets up a "SINGEL" filesystem on two larger
> devices, fills it with an adequate amount of data, and then tries to
> convert it to raid6
> 2. the filesystem will fail to convert due to not enough space to
> convert all data to raid6 (not enough space on at least 3 devices at
> the same time), hitting an enospc-error
> * Up until this point stuff still seems to work without crashing, and
> the system seems stable, just with two different profiles fot the data
> 3. issue the umount command which will be "Killed", and a backtrace
> will be written to dmesg
> 
> This results in a filesystem that cannot be synced, unmounted, and in
> all just seems crashed.
> I have ran the script 6 times. 1 time it passed, 5 times it has
> crashed, and I have rebooted the computer, since that is the only way
> it seems to get rid of the filesysem, so the issue seems pretty
> reproducable.
> 
> The system is a laptop running Fedora 31 Beta with the latest updates,
> and the latest kernel (5.3.6-300.fc31.x86_64)
> 
> Do you have any input, or any other questions or stuff you want me to test?
> 
> The script looks as follow:
> -----
> $ cat run-btrfs-test
> modprobe -iv zram num_devices=8
> udevadm trigger
> sync
> zramctl /dev/zram0 -s 8G && \
> zramctl /dev/zram1 -s 8G && \
> zramctl /dev/zram2 -s 4G && \
> zramctl /dev/zram3 -s 4G && \
> zramctl /dev/zram4 -s 4G && \
> zramctl /dev/zram5 -s 2G && \
> zramctl /dev/zram6 -s 2G && \
> zramctl /dev/zram7 -s 4G && \
> mkfs.btrfs /dev/zram0 && \
> mkdir -p /mnt/btrfs-test && \
> mount /dev/zram0 /mnt/btrfs-test && \
> echo "FS Mounted" && \
> btrfs dev add /dev/zram1 /mnt/btrfs-test && \
> echo "Devices added" && \
> for int in {1..500} ; do dd if=/dev/zero of=/mnt/btrfs-test/file${int}
> bs=32M count=1 && sync ; done
> btrfs dev add /dev/zram[2-7] /mnt/btrfs-test && \
> btrfs fi sh /mnt/btrfs-test && \
> btrfs fi df /mnt/btrfs-test && \
> btrfs bal star -mconvert=raid6 /mnt/btrfs-test && \
> btrfs bal star -dconvert=raid6 /mnt/btrfs-test
> btrfs fi sh /mnt/btrfs-test && \
> btrfs fi df /mnt/btrfs-test
> =====
> 
> The output from the script, I will trim the output down to after the for-loop:
> ------
> Label: none  uuid: 87150918-e487-4f59-994b-ccb13ee05446
> Total devices 8 FS bytes used 15.64GiB
> devid    1 size 8.00GiB used 8.00GiB path /dev/zram0
> devid    2 size 8.00GiB used 8.00GiB path /dev/zram1
> devid    3 size 4.00GiB used 0.00B path /dev/zram2
> devid    4 size 4.00GiB used 0.00B path /dev/zram3
> devid    5 size 4.00GiB used 0.00B path /dev/zram4
> devid    6 size 2.00GiB used 0.00B path /dev/zram5
> devid    7 size 2.00GiB used 0.00B path /dev/zram6
> devid    8 size 4.00GiB used 0.00B path /dev/zram7
> 
> Data, single: total=15.74GiB, used=15.63GiB
> System, single: total=4.00MiB, used=16.00KiB
> Metadata, single: total=264.00MiB, used=17.06MiB
> GlobalReserve, single: total=16.70MiB, used=0.00B
> Done, had to relocate 3 out of 20 chunks
> ERROR: error during balancing '/mnt/btrfs-test': No space left on device
> There may be more info in syslog - try dmesg | tail
> Label: none  uuid: 87150918-e487-4f59-994b-ccb13ee05446
> Total devices 8 FS bytes used 15.65GiB
> devid    1 size 8.00GiB used 2.99GiB path /dev/zram0
> devid    2 size 8.00GiB used 2.00GiB path /dev/zram1
> devid    3 size 4.00GiB used 4.00GiB path /dev/zram2
> devid    4 size 4.00GiB used 4.00GiB path /dev/zram3
> devid    5 size 4.00GiB used 4.00GiB path /dev/zram4
> devid    6 size 2.00GiB used 2.00GiB path /dev/zram5
> devid    7 size 2.00GiB used 2.00GiB path /dev/zram6
> devid    8 size 4.00GiB used 4.00GiB path /dev/zram7
> 
> Data, single: total=2.00GiB, used=1.97GiB
> Data, RAID6: total=14.41GiB, used=13.66GiB
> System, RAID6: total=80.00MiB, used=16.00KiB
> Metadata, RAID6: total=512.00MiB, used=17.52MiB
> GlobalReserve, single: total=17.16MiB, used=0.00B
> ===
> 
> Issueing the umount:
> ----
> # umount /mnt/btrfs-test && modprobe -rv zram

OK, I couldn't reproduce it in my environment (5.4-rc3+ based
btrfs-devel/misc-next form David) with this script. I'll dig deeper.


> Killed
> ===
> 
> And last but not least: the output in dmesg:
> ---
> [  205.960233] BTRFS info (device zram0): 2 enospc errors during balance
> [  205.960235] BTRFS info (device zram0): balance: ended with status: -28

Here balance ended with -ENOSPC (28).

> [  235.774821] BUG: kernel NULL pointer dereference, address: 00000000000002ce

That's a NULL pointer deference with an offset of 0x2ce (718).

> [  235.774826] #PF: supervisor read access in kernel mode
> [  235.774828] #PF: error_code(0x0000) - not-present page
> [  235.774830] PGD 0 P4D 0
> [  235.774834] Oops: 0000 [#1] SMP PTI
> [  235.774838] CPU: 3 PID: 5421 Comm: umount Not tainted
> 5.3.6-300.fc31.x86_64 #1
> [  235.774840] Hardware name: LENOVO 80JV/Lenovo U41-70, BIOS BDCN71WW
> 08/03/2016
> [  235.774847] RIP: 0010:__free_pages+0x5/0x30
> [  235.774850] Code: 00 48 89 c3 fa 66 0f 1f 44 00 00 48 89 ef 4c 89
> e6 e8 2f ef ff ff 48 89 df 57 9d 0f 1f 44 00 00 5b 5d 41 5c c3 0f 1f
> 44 00 00 <8b> 47 34 85 c0 74 12 f0 ff 4f 34 75 06 85 f6 75 03 eb 88 c3
> e9 82
> [  235.774852] RSP: 0018:ffffc3cf0ffb7db0 EFLAGS: 00010046
> [  235.774854] RAX: ffffa0ad0ffa0118 RBX: 0000000000000045 RCX: 0000000000000000
> [  235.774856] RDX: ffffa0aeceaee2f0 RSI: 0000000000000000 RDI: 000000000000029a
> [  235.774858] RBP: ffffa0ad0ffa0000 R08: fffffb06c23fd108 R09: fffffb06c23fd108
> [  235.774860] R10: 0000000000068879 R11: fffffb06c02cf820 R12: 0000000000000045
> [  235.774861] R13: ffffa0ade5c00010 R14: ffffa0ae0d19e5ac R15: ffffa0ae0d19e578
> [  235.774864] FS:  00007f3b40f6cc80(0000) GS:ffffa0aeceac0000(0000)
> knlGS:0000000000000000
> [  235.774866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  235.774867] CR2: 00000000000002ce CR3: 000000004c1f0004 CR4: 00000000003606e0

CR2 has it as well, so we're page faulting on an access to 0x2ce.

Let's look at __free_pages():

(gdb) l *(__free_pages+0x5)
0xffffffff81179e45 is in __free_pages (mm/page_alloc.c:4818).
4813			__free_pages_ok(page, order);
4814	}
4815	
4816	void __free_pages(struct page *page, unsigned int order)
4817	{
4818		if (put_page_testzero(page))
4819			free_the_page(page, order);
4820	}
4821	EXPORT_SYMBOL(__free_pages);
4822	
(gdb)

We're getting called by __free_page() so we know order is 0. So
something must have passed in a NULL page (somehow).

Looking at __free_raid_bio() one step further up the call-chain I see this:

for (i = 0; i < rbio->nr_pages; i++) {
         if (rbio->stripe_pages[i]) {
                 __free_page(rbio->stripe_pages[i]);
                 rbio->stripe_pages[i] = NULL;
         }
}

> [  235.774869] Call Trace:
> [  235.774920]  __free_raid_bio+0x72/0xb0 [btrfs]
> [  235.774961]  btrfs_free_stripe_hash_table+0x3d/0x70 [btrfs]
> [  235.774992]  close_ctree+0x1ea/0x2f0 [btrfs]
> [  235.774998]  generic_shutdown_super+0x6c/0x100
> [  235.775001]  kill_anon_super+0x14/0x30
> [  235.775024]  btrfs_kill_super+0x12/0xa0 [btrfs]
> [  235.775029]  deactivate_locked_super+0x36/0x70
> [  235.775033]  cleanup_mnt+0x104/0x150
> [  235.775038]  task_work_run+0x87/0xa0
> [  235.775043]  exit_to_usermode_loop+0xda/0x100
> [  235.775047]  do_syscall_64+0x183/0x1a0
> [  235.775053]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  235.775056] RIP: 0033:0x7f3b411b767b
> [  235.775060] Code: 08 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 90 f3
> 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 07 0c 00 f7 d8 64 89
> 01 48

This decodes to:

All code
========
   0:	08 0c 00             	or     %cl,(%rax,%rax,1)
   3:	f7 d8                	neg    %eax
   5:	64 89 01             	mov    %eax,%fs:(%rcx)
   8:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
   c:	c3                   	retq
   d:	66 90                	xchg   %ax,%ax
   f:	f3 0f 1e fa          	endbr64
  13:	31 f6                	xor    %esi,%esi
  15:	e9 05 00 00 00       	jmpq   0x1f
  1a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1f:	f3 0f 1e fa          	endbr64
  23:	b8 a6 00 00 00       	mov    $0xa6,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<--
trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq
  33:	48 8b 0d dd 07 0c 00 	mov    0xc07dd(%rip),%rcx        # 0xc0817
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq
   9:	48 8b 0d dd 07 0c 00 	mov    0xc07dd(%rip),%rcx        # 0xc07ed
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W

This doesn't look like __free_pages

(gdb) disassemble __free_pages
Dump of assembler code for function __free_pages:
   0xffffffff81179e40 <+0>:	lock decl 0x34(%rdi)
   0xffffffff81179e44 <+4>:	jne    0xffffffff81179e51 <__free_pages+17>
   0xffffffff81179e46 <+6>:	test   %esi,%esi
   0xffffffff81179e48 <+8>:	je     0xffffffff81179e4f <__free_pages+15>
   0xffffffff81179e4a <+10>:	jmpq   0xffffffff81178500 <__free_pages_ok>
   0xffffffff81179e4f <+15>:	jmp    0xffffffff81179de0 <free_unref_page>
   0xffffffff81179e51 <+17>:	repz retq
End of assembler dump.
(gdb)

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
