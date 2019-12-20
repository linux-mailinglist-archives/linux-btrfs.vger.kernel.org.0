Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D380A1280F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 17:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTQxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 20 Dec 2019 11:53:19 -0500
Received: from mail.nethype.de ([5.9.56.24]:43335 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTQxT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 11:53:19 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLWd-003czK-BC; Fri, 20 Dec 2019 16:53:15 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLWd-0002hX-4s; Fri, 20 Dec 2019 16:53:15 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiLWd-0001PE-3w; Fri, 20 Dec 2019 17:53:15 +0100
Date:   Fri, 20 Dec 2019 17:53:15 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220165008.GA1603@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 09:41:15PM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> BTW, that chunk number is very small, and since it has 0 tolerance, it
> looks like to be SINGLE chunk.
> 
> In that case, it looks like a temporary chunk from older mkfs, and it
> should contain no data/metadata at all, thus brings no data loss.

Well, there indeed should not have been any data or metadata left as the
btrfs dev del succeeded after lengthy copying.

> BTW, "btrfs ins dump-tree -t chunk <dev>" would help a lot.
> That would directly tell us if the devid 1 device is in chunk tree.

Apologies if I wasn't too clear about it - I already had to mkfs and
redo the filesystem. I understand that makes tracking this down hard or
impossible, but I did need that machine and filesystem.

> > And if you want to hear more "insane" things, after I hard-reset
> > my desktop machine (5.2.21) two days ago I had to "btrfs rescue
> > fix-device-size" to be able to mount (can't find the kernel error atm.).
> 
> Consider all these insane things, I tend to believe there is some
> FUA/FLUSH related hardware problem.

Please don't - I honestly think btrfs developers are way to fast to blame
hardware for problems. I currently lose btrfs filesystems about once every
6 months, and other than the occasional user error, it's always the kernel
(e.g. 4.11 corrupting data, dmcache and/or bcache corrupting things,
low-memory situations etc. - none of these seem to be centric to btrfs,
but none of those are hardware errors either). I know its the kernel in
most cases because in those cases, I can identify the fix in a later
kernel, or the mitigating circumstances don't appear (e.g. freezes).

In any case if it is a hardware problem, then linux and/or btrfs has
to work around them, because it affects many different controllers on
different boards:

- dell perc h740 on "doom" and "cerebro"
- intel series 9 controller on "doom'" and "cerebro".
- samsung nvme controller on "yoyo" and "yuna".
- marvell sata controller on "doom".

Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs
filesystem I restored to went into readonly mode with ENOSPC. Another
hardware problem?

[41801.618772] ------------[ cut here ]------------
[41801.618776] BTRFS: Transaction aborted (error -28)
[41801.618843] WARNING: CPU: 2 PID: 5713 at fs/btrfs/inode.c:3159 btrfs_finish_ordered_io+0x730/0x820 [btrfs]
[41801.618844] Modules linked in: nfsv3 nfs fscache nvidia_modeset(POE) nvidia(POE) btusb algif_skcipher af_alg dm_crypt nfsd auth_rpcgss nfs_acl lockd grace cls_fw sch_htb sit tunnel4 ip_tunnel hidp act_police cls_u32 sch_ingress sch_tbf 8021q garp mrp stp llc ip6t_REJECT nf_reject_ipv6 xt_CT xt_MASQUERADE xt_nat xt_REDIRECT nft_chain_nat nf_nat xt_owner xt_TCPMSS xt_DSCP xt_mark nf_log_ipv4 nf_log_common xt_LOG xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_length xt_mac xt_tcpudp nft_compat nft_counter nf_tables xfrm_user xfrm_algo nfnetlink cmac uhid bnep tda10021 snd_hda_codec_hdmi binfmt_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass tda827x tda10023 crct10dif_pclmul mei_hdcp crc32_pclmul btrtl btbcm rc_tt_1500 ghash_clmulni_intel snd_emu10k1 btintel snd_util_mem snd_ac97_codec aesni_intel bluetooth snd_hda_intel budget_av snd_rawmidi snd_intel_nhlt crypto_simd saa7146_vv
[41801.618864]  snd_hda_codec videobuf_dma_sg budget_ci videobuf_core snd_seq_device budget_core cryptd ttpci_eeprom glue_helper snd_hda_core saa7146 dvb_core intel_cstate ac97_bus snd_hwdep rc_core snd_pcm intel_rapl_perf mxm_wmi cdc_acm pcspkr videodev snd_timer ecdh_generic snd emu10k1_gp ecc mc gameport soundcore mei_me mei mac_hid acpi_pad tcp_bbr drm_kms_helper drm fb_sys_fops syscopyarea sysfillrect sysimgblt ipmi_devintf ipmi_msghandler hid_generic usbhid hid usbkbd coretemp nct6775 hwmon_vid sunrpc parport_pc ppdev lp parport msr ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 multipath linear dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio libcrc32c ahci megaraid_sas i2c_i801 libahci lpc_ich r8169 realtek wmi video [last unloaded: nvidia]
[41801.618887] CPU: 2 PID: 5713 Comm: kworker/u8:15 Tainted: P           OE     5.4.5-050405-generic #201912181630
[41801.618888] Hardware name: MSI MS-7816/Z97-G43 (MS-7816), BIOS V17.8 12/24/2014
[41801.618903] Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
[41801.618916] RIP: 0010:btrfs_finish_ordered_io+0x730/0x820 [btrfs]
[41801.618917] Code: 49 8b 46 50 f0 48 0f ba a8 40 ce 00 00 02 72 1c 8b 45 b0 83 f8 fb 0f 84 d4 00 00 00 89 c6 48 c7 c7 48 33 62 c0 e8 eb 9c 91 d5 <0f> 0b 8b 4d b0 ba 57 0c 00 00 48 c7 c6 40 67 61 c0 4c 89 f7 bb 01
[41801.618918] RSP: 0018:ffffc18b40edfd80 EFLAGS: 00010282
[41801.618921] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3159: errno=-28 No space left
[41801.618922] RAX: 0000000000000000 RBX: ffff9f8b7b2e3800 RCX: 0000000000000006
[41801.618922] BTRFS info (device dm-35): forced readonly
[41801.618924] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9f8bbeb17440
[41801.618924] RBP: ffffc18b40edfdf8 R08: 00000000000005a6 R09: ffffffff979a4d90
[41801.618925] R10: ffffffff97983fa8 R11: ffffc18b40edfbe8 R12: ffff9f8ad8b4ab60
[41801.618926] R13: ffff9f867ddb53c0 R14: ffff9f8bbb0446e8 R15: 0000000000000000
[41801.618927] FS:  0000000000000000(0000) GS:ffff9f8bbeb00000(0000) knlGS:0000000000000000
[41801.618928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[41801.618929] CR2: 00007f8ab728fc30 CR3: 000000049080a002 CR4: 00000000001606e0
[41801.618930] Call Trace:
[41801.618943]  finish_ordered_fn+0x15/0x20 [btrfs]
[41801.618957]  normal_work_helper+0xbd/0x2f0 [btrfs]
[41801.618959]  ? __schedule+0x2eb/0x740
[41801.618973]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
[41801.618975]  process_one_work+0x1ec/0x3a0
[41801.618977]  worker_thread+0x4d/0x400
[41801.618979]  kthread+0x104/0x140
[41801.618980]  ? process_one_work+0x3a0/0x3a0
[41801.618982]  ? kthread_park+0x90/0x90
[41801.618984]  ret_from_fork+0x1f/0x40
[41801.618985] ---[ end trace 35086266bf39c897 ]---
[41801.618987] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3159: errno=-28 No space left

unmount/remount seems to make it work again, and it is full (df) yet has
3TB of unallocated space left. No clue what to do now, do I have to start
over restoring again?

   Filesystem               Size  Used Avail Use% Mounted on
   /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1

   Overall:
       Device size:                       24216.49GiB
       Device allocated:                  20894.89GiB
       Device unallocated:                 3321.60GiB
       Device missing:                        0.00GiB
       Used:                              20893.68GiB
       Free (estimated):                   3322.73GiB      (min: 1661.93GiB)
       Data ratio:                               1.00
       Metadata ratio:                           2.00
       Global reserve:                        0.50GiB      (used: 0.00GiB)

   Data,single: Size:20839.01GiB, Used:20837.88GiB (99.99%)
      /dev/mapper/xmnt-cold15      9288.01GiB
      /dev/mapper/xmnt-cold12      7427.00GiB
      /dev/mapper/xmnt-cold13      4124.00GiB

   Metadata,RAID1: Size:27.91GiB, Used:27.90GiB (99.97%)
      /dev/mapper/xmnt-cold15        25.44GiB
      /dev/mapper/xmnt-cold12        24.46GiB
      /dev/mapper/xmnt-cold13         5.91GiB

   System,RAID1: Size:0.03GiB, Used:0.00GiB (6.69%)
      /dev/mapper/xmnt-cold15         0.03GiB
      /dev/mapper/xmnt-cold12         0.03GiB

   Unallocated:
      /dev/mapper/xmnt-cold15         0.01GiB
      /dev/mapper/xmnt-cold12         0.00GiB
      /dev/mapper/xmnt-cold13      3321.59GiB

Please, don't always chalk it up to hardware problems - btrfs is a
wonderful filesystem for many reasons, one reason I like is that it can
detect corruption much earlier than other filesystems. This featire alone
makes it impossible for me to go back to xfs. However, I had corruption
on ext4, xfs, reiserfs over the years, but btrfs *is* simply way buggier
still than those - before btrfs (and even now) I kept md5sums of all
archived files (~200TB), and xfs and ext4 _do_ a much better job at not
corrupting data than btrfs on the same hardware - while I get filesystem
problems about every half a year with btrfs, I had (silent) corruption
problems maybe once every three to four years with xfs or ext4 (and not
yet on the bxoes I use currently).

Please take these issues seriously - the trend of "it's a hardware
problem" will not remove the "unstable" stigma from btrfs as long as btrfs
is clearly more buggy then other filesystems.

Sorry to be so blunt, but I am a bit sensitive with always being told
"it's probably a hardware problem" when it clearly affects practically any
server and any laptop I administrate. I believe in btrfs, and detecting
corruption early is a feature to me.

I understand it can be frustrating to be confronted with hard to explain
accidents, and I understand if you can't find the bug with the sparse info
I gave, especially as the bug might not even be in btrfs. But keep in mind
that the people who boldly/dumbly use btrfs in production and restore
dozens of terabytes from backup every so and so many months are also being
frustrated if they present evidence from multiple machines and get told
"its probably a hardware problem".

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
