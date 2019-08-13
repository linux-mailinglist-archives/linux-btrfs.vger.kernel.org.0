Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2B8B32B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfHMI67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 04:58:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfHMI67 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 04:58:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55914AE34;
        Tue, 13 Aug 2019 08:58:56 +0000 (UTC)
Subject: Re: No Space left / Transaction aborted error -28 (4.19.59 kernel)
To:     David Goodwin <david@codepoets.co.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <22ec62e7-8456-0b1c-cca2-1e9ab8f1aa4f@codepoets.co.uk>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9a209f49-ead5-94b5-325e-1f1dc838105d@suse.com>
Date:   Tue, 13 Aug 2019 11:58:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <22ec62e7-8456-0b1c-cca2-1e9ab8f1aa4f@codepoets.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.08.19 г. 11:33 ч., David Goodwin wrote:
> Hi,
> 
> Kernel 4.19.59.
> 
> 
> % btrfs fi us /backups/
> Overall:
>     Device size:           4.00TiB
>     Device allocated:           3.44TiB
> *    Device unallocated:         572.95GiB*
>     Device missing:             0.00B
>     Used:               3.43TiB
> *    Free (estimated):         576.36GiB    (min: 576.36GiB)*
>     Data ratio:                  1.00
>     Metadata ratio:              1.00
>     Global reserve:         512.00MiB    (used: 0.00B)
> 
> Data,single: Size:3.30TiB, Used:3.29TiB
>    /dev/xvdg       3.30TiB
> 
> Metadata,single: Size:148.01GiB, Used:141.79GiB
>    /dev/xvdg     148.01GiB
> 
> System,single: Size:32.00MiB, Used:384.00KiB
>    /dev/xvdg      32.00MiB
> 
> Unallocated:
>    /dev/xvdg     572.95GiB
> 
> 
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -28)
> WARNING: CPU: 0 PID: 1013 at fs/btrfs/extent-tree.c:6803
> __btrfs_free_extent.isra.70+0x23d/0xb70
> Modules linked in: dm_mod dax ipt_REJECT nf_reject_ipv4 ipt_MASQUERADE
> iptable_nat nf_nat_ipv4 nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nfsv3 xt_multiport iptable_filter
> ip_tables x_tables autofs4 nfsd auth_rpcgss nfs_acl nfs lockd grace
> fscache sunrpc intel_rapl crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel pcbc evdev snd_pcsp snd_pcm aesni_intel aes_x86_64
> snd_timer crypto_simd snd cryptd soundcore glue_helper xen_netfront
> xen_blkfront
> CPU: 0 PID: 1013 Comm: btrfs-transacti Tainted: G        W 4.19.59-dg1 #1
> RIP: e030:__btrfs_free_extent.isra.70+0x23d/0xb70
> Code: 24 48 8b 40 50 f0 48 0f ba a8 08 17 00 00 02 72 1b 41 83 fd fb 0f
> 84 7c 03 00 00 44 89 ee 48 c7 c7 e0 91 d9 81 e8 23 e3 d3 ff <0f> 0b 48
> 8b 3c 24 44 89 e9 ba 93 1a 00 00 48 c7 c6 c0 16 c3 81 e8
> RSP: e02b:ffffc9004333bc80 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 000002f601a84000 RCX: 0000000000000006
> RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff88839a8165d0
> RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000008e4
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880744b7690
> R13: 00000000ffffffe4 R14: 0000000000000000 R15: 0000000000000002
> FS:  0000000000000000(0000) GS:ffff88839a800000(0000)
> knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f34c6100330 CR3: 0000000317972000 CR4: 0000000000000660
> Call Trace:
>  ? btrfs_merge_delayed_refs+0xa7/0x360
>  __btrfs_run_delayed_refs+0x81d/0x11b0
>  ? __btrfs_run_delayed_items+0x5b1/0x650
>  btrfs_run_delayed_refs+0xed/0x1b0
>  btrfs_commit_transaction+0x2e7/0x840
>  ? wait_woken+0x80/0x80
>  transaction_kthread+0x157/0x180
>  kthread+0xf8/0x130
>  ? btrfs_cleanup_transaction+0x580/0x580
>  ? kthread_create_worker_on_cpu+0x70/0x70
>  ret_from_fork+0x35/0x40
> ---[ end trace 1924458bab785ce7 ]---
> 
> BTRFS: error (device xvdg) in __btrfs_free_extent:6803: errno=-28 No
> space left
> BTRFS info (device xvdg): forced readonly
> BTRFS: error (device xvdg) in btrfs_run_delayed_refs:2935: errno=-28 No
> space left
> BTRFS warning (device xvdg): Skipping commit of aborted transaction.
> BTRFS: error (device xvdg) in cleanup_transaction:1846: errno=-28 No
> space left
> BTRFS error (device xvdg): parent transid verify failed on 3785613344768
> wanted 463116 found 463109
> BTRFS info (device xvdg): no csum found for inode 31686701 start 0
> BTRFS warning (device xvdg): csum failed root 258 ino 31686701 off 0
> csum 0x6c824720 expected csum 0x00000000 mirror 1
> BTRFS error (device xvdg): parent transid verify failed on 3785613344768
> wanted 463116 found 463109
> BTRFS info (device xvdg): no csum found for inode 31686701 start 4096
> BTRFS error (device xvdg): parent transid verify failed on 3785613344768
> wanted 463116 found 463109
> BTRFS info (device xvdg): no csum found for inode 31686701 start 8192
> BTRFS error (device xvdg): parent transid verify failed on 3785613344768
> wanted 463116 found 463109
> BTRFS info (device xvdg): no csum found for inode 31686701 start 12288
> BTRFS error (device xvdg): parent transid verify failed on 3785613344768
> wanted 463116 found 463109
> ....

This has likely been fixed in 5.0 by Josef's introduction of delayed
refs reservation rework.


> 
> 
> 
> Hope it's of use to someone.
> 
> David.
> 
> 
> (Hopefully Thunderbird behaved and sent this as plain text)
> 
> 
