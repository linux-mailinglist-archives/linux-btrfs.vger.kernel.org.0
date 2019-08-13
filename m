Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE48B2B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfHMImP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 04:42:15 -0400
Received: from mail.palepurple.co.uk ([89.16.169.139]:37474 "EHLO
        mail.palepurple.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfHMImO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 04:42:14 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 04:42:12 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.palepurple.co.uk (Postfix) with ESMTP id 7FA6F8665
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codepoets.co.uk;
        s=codepoets; t=1565685240;
        bh=im4+MCTg0ZtlrLMZuMlbnMElY7DLLfG0x9/u6jCXcMo=;
        h=To:From:Subject:Date:From;
        b=V9MFzoYbDFJaYQdmuwGBHC/zafGL0nroxNsUTujuE7HFPPXNAIJGB+N5v9KVM+Ruc
         HE35XTbi+RYeOVJlrORXlEOZhl8ZWJaDi06w3eL/OEyJ4rVgQ2m79l6lFA5rb9kFnb
         BzIjjb/o0d2SfhQdxY1ZNJLYxXOMUGL0uAYtm1ic=
X-Virus-Scanned: by Amavis+SpamAssassin+ClamAV and more at palepurple.co.uk
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-99 required=6 tests=[ALL_TRUSTED=-1]
        autolearn=disabled
Received: from mail.palepurple.co.uk ([127.0.0.1])
        by localhost (mail.palepurple.co.uk [127.0.0.50]) (amavisd-new, port 10024)
        with ESMTP id oe5T6LUvI3fI for <linux-btrfs@vger.kernel.org>;
        Tue, 13 Aug 2019 08:33:54 +0000 (UTC)
Received: from [192.168.86.200] (unknown [176.255.4.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: david@palepurple.co.uk)
        by mail.palepurple.co.uk (Postfix) with ESMTPSA id C3BF28091
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 08:33:54 +0000 (UTC)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   David Goodwin <david@codepoets.co.uk>
Subject: No Space left / Transaction aborted error -28 (4.19.59 kernel)
Message-ID: <22ec62e7-8456-0b1c-cca2-1e9ab8f1aa4f@codepoets.co.uk>
Date:   Tue, 13 Aug 2019 09:33:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Kernel 4.19.59.


% btrfs fi us /backups/
Overall:
     Device size:           4.00TiB
     Device allocated:           3.44TiB
*    Device unallocated:         572.95GiB*
     Device missing:             0.00B
     Used:               3.43TiB
*    Free (estimated):         576.36GiB    (min: 576.36GiB)*
     Data ratio:                  1.00
     Metadata ratio:              1.00
     Global reserve:         512.00MiB    (used: 0.00B)

Data,single: Size:3.30TiB, Used:3.29TiB
    /dev/xvdg       3.30TiB

Metadata,single: Size:148.01GiB, Used:141.79GiB
    /dev/xvdg     148.01GiB

System,single: Size:32.00MiB, Used:384.00KiB
    /dev/xvdg      32.00MiB

Unallocated:
    /dev/xvdg     572.95GiB


------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 0 PID: 1013 at fs/btrfs/extent-tree.c:6803 
__btrfs_free_extent.isra.70+0x23d/0xb70
Modules linked in: dm_mod dax ipt_REJECT nf_reject_ipv4 ipt_MASQUERADE 
iptable_nat nf_nat_ipv4 nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 nfsv3 xt_multiport iptable_filter 
ip_tables x_tables autofs4 nfsd auth_rpcgss nfs_acl nfs lockd grace 
fscache sunrpc intel_rapl crct10dif_pclmul crc32_pclmul crc32c_intel 
ghash_clmulni_intel pcbc evdev snd_pcsp snd_pcm aesni_intel aes_x86_64 
snd_timer crypto_simd snd cryptd soundcore glue_helper xen_netfront 
xen_blkfront
CPU: 0 PID: 1013 Comm: btrfs-transacti Tainted: G        W 4.19.59-dg1 #1
RIP: e030:__btrfs_free_extent.isra.70+0x23d/0xb70
Code: 24 48 8b 40 50 f0 48 0f ba a8 08 17 00 00 02 72 1b 41 83 fd fb 0f 
84 7c 03 00 00 44 89 ee 48 c7 c7 e0 91 d9 81 e8 23 e3 d3 ff <0f> 0b 48 
8b 3c 24 44 89 e9 ba 93 1a 00 00 48 c7 c6 c0 16 c3 81 e8
RSP: e02b:ffffc9004333bc80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 000002f601a84000 RCX: 0000000000000006
RDX: 0000000000000007 RSI: 0000000000000001 RDI: ffff88839a8165d0
RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000000008e4
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880744b7690
R13: 00000000ffffffe4 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff88839a800000(0000) knlGS:0000000000000000
CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f34c6100330 CR3: 0000000317972000 CR4: 0000000000000660
Call Trace:
  ? btrfs_merge_delayed_refs+0xa7/0x360
  __btrfs_run_delayed_refs+0x81d/0x11b0
  ? __btrfs_run_delayed_items+0x5b1/0x650
  btrfs_run_delayed_refs+0xed/0x1b0
  btrfs_commit_transaction+0x2e7/0x840
  ? wait_woken+0x80/0x80
  transaction_kthread+0x157/0x180
  kthread+0xf8/0x130
  ? btrfs_cleanup_transaction+0x580/0x580
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x35/0x40
---[ end trace 1924458bab785ce7 ]---

BTRFS: error (device xvdg) in __btrfs_free_extent:6803: errno=-28 No 
space left
BTRFS info (device xvdg): forced readonly
BTRFS: error (device xvdg) in btrfs_run_delayed_refs:2935: errno=-28 No 
space left
BTRFS warning (device xvdg): Skipping commit of aborted transaction.
BTRFS: error (device xvdg) in cleanup_transaction:1846: errno=-28 No 
space left
BTRFS error (device xvdg): parent transid verify failed on 3785613344768 
wanted 463116 found 463109
BTRFS info (device xvdg): no csum found for inode 31686701 start 0
BTRFS warning (device xvdg): csum failed root 258 ino 31686701 off 0 
csum 0x6c824720 expected csum 0x00000000 mirror 1
BTRFS error (device xvdg): parent transid verify failed on 3785613344768 
wanted 463116 found 463109
BTRFS info (device xvdg): no csum found for inode 31686701 start 4096
BTRFS error (device xvdg): parent transid verify failed on 3785613344768 
wanted 463116 found 463109
BTRFS info (device xvdg): no csum found for inode 31686701 start 8192
BTRFS error (device xvdg): parent transid verify failed on 3785613344768 
wanted 463116 found 463109
BTRFS info (device xvdg): no csum found for inode 31686701 start 12288
BTRFS error (device xvdg): parent transid verify failed on 3785613344768 
wanted 463116 found 463109
....



Hope it's of use to someone.

David.


(Hopefully Thunderbird behaved and sent this as plain text)

