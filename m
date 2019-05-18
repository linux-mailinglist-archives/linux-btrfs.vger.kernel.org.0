Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51C22245
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfERI1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 04:27:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:53010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbfERI1t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 04:27:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E4ECAE6D;
        Sat, 18 May 2019 08:27:48 +0000 (UTC)
Subject: Re: storm-of-soft-lockups: spinlocks running on all cores, preventing
 forward progress (4.14- to 5.0+)
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <20190515213650.GG20359@hungrycats.org>
 <0480104e-db25-4e2f-08e5-0236ffd5c1c2@suse.com>
 <20190518044411.GH20359@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <349ec27f-7eb4-45be-7cd4-29c2cd56d05b@suse.com>
Date:   Sat, 18 May 2019 11:27:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518044411.GH20359@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.05.19 г. 7:44 ч., Zygo Blaxell wrote:
> On Thu, May 16, 2019 at 09:57:01AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 16.05.19 г. 0:36 ч., Zygo Blaxell wrote:
>>> "Storm-of-soft-lockups" is a failure mode where btrfs puts all of the
>>> CPU cores in kernel functions that are unable to make forward progress,
>>> but also unwilling to release their respective CPU cores.  This is
>>> usually accompanied by a lot of CPU usage (detectable as either kvm CPU
>>> usage or just a lot of CPU fan noise) though I don't know if all cores
>>> are spinning or only some of them.
>>>
>>> The kernel console presents a continual stream of "BUG: soft lockup"
>>> warnings for some days.  None of the call traces change during this time.
>>> The only way out is to reboot.
>>>
>>> You can reproduce this by writing a bunch of data to a filesystem while
>>> bees is running on all cores.  It takes a few days to occur naturally.
>>> It can probably be sped up by just doing a bunch of random LOGICAL_INO
>>> ioctls in a tight loop on each core.
>>>
>>> Here's an instance on a 4-CPU VM where CPU#0 is running btrfs-transaction
>>> (btrfs_try_tree_write_lock) and CPU#1-3 are running the LOGICAL_INO
>>> ioctl (btrfs_tree_read_lock_atomic):
>>
>>
>> Provide output of all sleeping threads when this occur via
>>  echo w > /proc/sysrq-trigger.
> 
> I fixed my SysRq configuration.  The results are...kind of interesting.
> I guess the four threads that are running loops on all cores don't count
> as "blocked"...
> 
<snip>

> 
> All the blocked threads are waiting for a snapshot, which is here:
> 
> 	[42829.412010] btrfs           R  running task        0 11306   6447 0x00000000
> 	[42829.413392] Call Trace:
> 	[42829.413895]  __schedule+0x3d4/0xb70
> 	[42829.414598]  preempt_schedule_common+0x1f/0x30
> 	[42829.415480]  _cond_resched+0x22/0x30
> 	[42829.416198]  wait_for_common_io.constprop.2+0x47/0x1b0
> 	[42829.417212]  ? submit_bio+0x73/0x140
> 	[42829.417932]  wait_for_completion_io+0x18/0x20
> 	[42829.418791]  submit_bio_wait+0x68/0x90
> 	[42829.419546]  blkdev_issue_discard+0x80/0xd0
> 	[42829.420381]  btrfs_issue_discard+0xc7/0x160
> 	[42829.421215]  ? btrfs_issue_discard+0xc7/0x160
> 	[42829.422088]  btrfs_discard_extent+0xcc/0x160
> 	[42829.423191]  btrfs_finish_extent_commit+0x118/0x280
> 	[42829.424310]  btrfs_commit_transaction+0x7f9/0xab0
> 	[42829.425231]  ? wait_woken+0xa0/0xa0
> 	[42829.425907]  btrfs_mksubvol+0x5b4/0x630
> 	[42829.426766]  ? mnt_want_write_file+0x28/0x60
> 	[42829.427597]  btrfs_ioctl_snap_create_transid+0x16b/0x1a0
> 	[42829.428614]  btrfs_ioctl_snap_create_v2+0x125/0x180
> 	[42829.429548]  btrfs_ioctl+0x1351/0x2cb0
> 	[42829.430272]  ? __handle_mm_fault+0x110c/0x1950
> 	[42829.431124]  ? do_raw_spin_unlock+0x4d/0xc0
> 	[42829.431934]  ? _raw_spin_unlock+0x27/0x40
> 	[42829.432704]  ? __handle_mm_fault+0x110c/0x1950
> 	[42829.433556]  ? kvm_sched_clock_read+0x18/0x30
> 	[42829.434437]  do_vfs_ioctl+0xa6/0x6e0
> 	[42829.435345]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> 	[42829.436803]  ? do_vfs_ioctl+0xa6/0x6e0
> 	[42829.437528]  ? up_read+0x1f/0xa0
> 	[42829.438159]  ksys_ioctl+0x75/0x80
> 	[42829.438798]  __x64_sys_ioctl+0x1a/0x20
> 	[42829.439565]  do_syscall_64+0x65/0x1a0
> 	[42829.440510]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 	[42829.441463] RIP: 0033:0x7f1faa8f5777
> 	[42829.442133] Code: Bad RIP value.
> 	[42829.442736] RSP: 002b:00007ffec1520458 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
> 	[42829.444352] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1faa8f5777
> 	[42829.445710] RDX: 00007ffec1520498 RSI: 0000000050009417 RDI: 0000000000000003
> 	[42829.447030] RBP: 00005621c22ef260 R08: 0000000000000008 R09: 00007f1faa97fe80
> 	[42829.448372] R10: fffffffffffffa4a R11: 0000000000000202 R12: 00005621c22ef290
> 	[42829.449723] R13: 00005621c22ef290 R14: 0000000000000003 R15: 0000000000000004

So you are discards are hung or there is a lost wakeup (which is rather
unlikely, since this is the block layer). What is the underlying block
device i.e model/make

> 
> Also I just noticed there's sometimes (but not always!) a BUG in
> fs/btrfs/ctree.c just before all the soft lockups start:
> 
> 	[26101.008546] ------------[ cut here ]------------
> 	[26101.016090] kernel BUG at fs/btrfs/ctree.c:1227!
> 	[26101.018285] irq event stamp: 36913
> 	[26101.018287] invalid opcode: 0000 [#1] SMP PTI
> 	[26101.018293] CPU: 1 PID: 4823 Comm: crawl_5268 Not tainted 5.0.16-zb64-9b948ea3083a+ #1
> 	[26101.019115] hardirqs last  enabled at (36913): [<ffffffffbb25b02c>] get_page_from_freelist+0x40c/0x19e0
> 	[26101.019118] hardirqs last disabled at (36912): [<ffffffffbb25af70>] get_page_from_freelist+0x350/0x19e0
> 	[26101.020820] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> 	[26101.022456] softirqs last  enabled at (36478): [<ffffffffbc0003a0>] __do_softirq+0x3a0/0x45a
> 	[26101.022461] softirqs last disabled at (36459): [<ffffffffbb0a9949>] irq_exit+0xe9/0xf0
> 	[26101.024212] RIP: 0010:__tree_mod_log_rewind+0x239/0x240
> 	[26101.039031] Code: c0 48 89 df 48 89 d6 48 c1 e6 05 48 8d 74 32 65 ba 19 00 00 00 e8 87 02 05 00 e9 88 fe ff ff 49 63 57 2c e9 16 ff ff ff 0f 0b <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 55 83 c2 01 48 63 d2 48 89 e5
> 	[26101.042382] RSP: 0018:ffffb3f401613820 EFLAGS: 00010206
> 	[26101.043512] RAX: ffff9f8068690180 RBX: ffff9f7ebf2ba660 RCX: ffff9f8003b1eb80
> 	[26101.044719] RDX: 000000000000015d RSI: 000000000000007e RDI: 0000018aff0a8000
> 	[26101.046157] RBP: ffffb3f401613850 R08: ffffb3f4016137c8 R09: ffffb3f4016137d0
> 	[26101.047474] R10: 0000000000007af3 R11: 000000000000007e R12: 0000000000000008
> 	[26101.048779] R13: ffff9f7ea7d77d00 R14: 0000000000000a49 R15: ffff9f8068690180
> 	[26101.049939] FS:  00007f9064d7a700(0000) GS:ffff9f80b6000000(0000) knlGS:0000000000000000
> 	[26101.051415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[26101.052330] CR2: 00007fcc462fd8a0 CR3: 000000020e002006 CR4: 00000000001606e0
> 	[26101.053615] Call Trace:
> 	[26101.054103]  btrfs_search_old_slot+0xfe/0x800
> 	[26101.054900]  resolve_indirect_refs+0x1c5/0x910
> 	[26101.055734]  ? prelim_ref_insert+0x10a/0x320
> 	[26101.056474]  find_parent_nodes+0x443/0x1340
> 	[26101.057153]  btrfs_find_all_roots_safe+0xc5/0x140
> 	[26101.057890]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[26101.058813]  iterate_extent_inodes+0x198/0x3e0
> 	[26101.059608]  iterate_inodes_from_logical+0xa1/0xd0
> 	[26101.060377]  ? iterate_inodes_from_logical+0xa1/0xd0
> 	[26101.061142]  ? btrfs_inode_flags_to_fsflags+0x90/0x90
> 	[26101.061975]  btrfs_ioctl_logical_to_ino+0xf3/0x1a0
> 	[26101.062710]  btrfs_ioctl+0xcf7/0x2cb0
> 	[26101.063318]  ? __lock_acquire+0x477/0x1b50
> 	[26101.063988]  ? kvm_sched_clock_read+0x18/0x30
> 	[26101.065010]  ? kvm_sched_clock_read+0x18/0x30
> 	[26101.065781]  ? sched_clock+0x9/0x10
> 	[26101.066402]  do_vfs_ioctl+0xa6/0x6e0
> 	[26101.067072]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> 	[26101.068102]  ? do_vfs_ioctl+0xa6/0x6e0
> 	[26101.068765]  ? __fget+0x119/0x200
> 	[26101.069381]  ksys_ioctl+0x75/0x80
> 	[26101.069937]  __x64_sys_ioctl+0x1a/0x20
> 	[26101.070627]  do_syscall_64+0x65/0x1a0
> 	[26101.071299]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 	[26101.072125] RIP: 0033:0x7f9067675777
> 	[26101.072732] Code: 00 00 90 48 8b 05 19 a7 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 a6 0c 00 f7 d8 64 89 01 48
> 	[26101.075884] RSP: 002b:00007f9064d77458 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> 	[26101.077193] RAX: ffffffffffffffda RBX: 00007f9064d77780 RCX: 00007f9067675777
> 	[26101.078362] RDX: 00007f9064d77788 RSI: 00000000c038943b RDI: 0000000000000004
> 	[26101.079543] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007f9064d77960
> 	[26101.080837] R10: 0000565444959c40 R11: 0000000000000246 R12: 0000000000000004
> 	[26101.082724] R13: 00007f9064d77788 R14: 00007f9064d77668 R15: 00007f9064d77890
> 	[26101.084083] Modules linked in: mq_deadline bfq dm_cache_smq dm_cache dm_persistent_data snd_pcm crct10dif_pclmul crc32_pclmul dm_bio_prison crc32c_intel ghash_clmulni_intel dm_bufio sr_mod snd_timer cdrom snd sg aesni_intel ppdev joydev aes_x86_64 dm_mod soundcore crypto_simd ide_pci_generic cryptd piix glue_helper psmouse input_leds parport_pc ide_core rtc_cmos pcspkr serio_raw bochs_drm evbug parport evdev floppy i2c_piix4 qemu_fw_cfg ip_tables x_tables ipv6 crc_ccitt autofs4
> 	[26101.091346] ---[ end trace d327561dc44a663d ]---

That looks like genuine bug, first I've ever seen the rewind code
hitting it. The rest that follows doesn't seem relevant.

<snip>

> 
> This doesn't quite match the traces I previously posted.  Maybe the
> storm-of-soft-lockups is a symptom of multiple bugs (at least one which
> happens after a bug in ctree.c and one that happens at other times)?
> I'll run this a few more times and see if different cases come up.
> 
> The one thing that is common to all the storm-of-soft-lockups I've seen
> so far is the involvement of multiple crawl_* threads, and those spend
> ~60% of their time running logical_to_ino.
> 
>> Also do you have this patch on the affected machine:
>>
>> 38e3eebff643 ("btrfs: honor path->skip_locking in backref code") can you
>> try and test with it applied ?
>>
>>
>> <SNIP>
