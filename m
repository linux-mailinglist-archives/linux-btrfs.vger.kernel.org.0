Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A306079E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJUOtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 10:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJUOsv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 10:48:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091628080C
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 07:48:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d24so2570625pls.4
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWV3P+UkbZ0hL1qOKpomHYL94vdESMOjwFqzbaWSAm4=;
        b=U1e20G2MhVy069dLBwkAC/c6dow+1t0iCq8OxkHZYTDXaJhH5obDKyvyl4frq6XOaR
         HebGqLHOgY1DAU/sJdgIW+J9NneDN5r8JieBrnAxQzDqZ1nauHsvoyzu+AXOjKCQvaqb
         Xq7oNm0dsHq3DVjOAt92XvHxUKDBco8UvBjCusnipDaEhv3FDdhuYzkNCKIxube6B+Jd
         WFAS0TjsJ/kiIWD6fndsLJV8g31vzz1mUX7pngs83zJrDKph2JRGOuY7Do49diyn5LZ6
         jQLGVvbHHGyOT10B3TuH0j0U6DTg6W8eyvZJec0hFJN3guQQYsOH/YLjvOyD8UZsQbr3
         H+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWV3P+UkbZ0hL1qOKpomHYL94vdESMOjwFqzbaWSAm4=;
        b=ndtsfAY6qAQaaFZmNiA9aMxig3s2nUw8ZZkAZLTH4JrhcAQF3xnSpIJPSTpDTuAY7c
         Io3oLV6TSDWq9X4A0VC4inOzOE3iTZG5ZUbc5124IBUVnW4oUJ89uIkvpccD+e0D0fuo
         KVr0tc+jq8rmv/xI7hISK1ktewnffmaDxKXML63uCUs6dWiMb6UV78+nbU9bgK3UDsdU
         DET5B3EmBMuljHYaFA56qpyqFbRelnvUmVKIjAe8R3byvsojvzYcDkFktavzcrXv//9i
         mT3xUQg1iBbbrQbE9+CCQ+2GfLSDZ6i3HAeDRTzIzdE+Iix8WCPSDuKUYwCL1j4JC/SC
         QOIA==
X-Gm-Message-State: ACrzQf1qg3ICOQ6bdOsnvdnRUIZLrtCBs/g9fHVnS6bKjkUnnkS0PDM+
        lFRTpjX6i8PFksEXnpej6hJe/nM2lUV46/95iCDEFjY07IM=
X-Google-Smtp-Source: AMsMyM72dojxFh17Es41UBHDRdeJnl5gTVogXb14TkV9vHAjrPdUF6WF+hNrEr5MlZ9X3ygDTwHLwxEcG6JnteYbVdI=
X-Received: by 2002:a17:903:240d:b0:183:9bab:9c3 with SMTP id
 e13-20020a170903240d00b001839bab09c3mr19813439plo.48.1666363730161; Fri, 21
 Oct 2022 07:48:50 -0700 (PDT)
MIME-Version: 1.0
From:   Marko 123 <mailmeornot75@gmail.com>
Date:   Fri, 21 Oct 2022 16:48:39 +0200
Message-ID: <CAGpX_xKaL6RPNrSUJXkPNyERDyBNmW_f2AMa1dMHLRR+mvDeZA@mail.gmail.com>
Subject: Problem with mounting btrfs partition after free space ended
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

After the space was ended and system restart I have a problem with
mounting partition.

I want add the device /dev/sdb1 into the /dev/sda2 but I don't know
how to that without mount the /dev/sda2 and the mount  command is
frozen

# mount /dev/sda2 /mnt/btrfs

Log from dmsqg
[  735.192697] BTRFS error (device sda2): qgroup generation mismatch,
marked as inconsistent
[  767.661342] general protection fault: 0000 [#1] SMP PTI
[  767.666253] Modules linked in: ipt_MASQUERADE
nf_nat_masquerade_ipv4 xt_CHECKSUM iptable_mangle xt_multiport xt_nat
iptable_nat nf_nat_ipv4 nf_nat xt_limit xt_recent xt_comment
ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4
xt_conntrack nf_conntrack iptable_filter kvm_intel kvm irqbypass
input_leds joydev serio_raw sch_fq_codel ib_iser rdma_cm iw_cm ib_cm
ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables
x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
raid0 multipath linear hid_generic usbhid hid crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64
crypto_simd glue_helper cryptd psmouse virtio_scsi virtio_net floppy
[  767.681767] CPU: 0 PID: 3175 Comm: btrfs-transacti Not tainted
4.15.0-123-generic #126-Ubuntu
[  767.683792] Hardware name: OpenStack Foundation OpenStack Nova,
BIOS 2:1.10.2-58953eb7 04/01/2014
[  767.685932] RIP: 0010:resolve_indirect_refs+0x290/0x8b0 [btrfs]
[  767.687378] RSP: 0018:ffffba76c1587b18 EFLAGS: 00010246
[  767.688675] RAX: c568872eb19d43a6 RBX: ffff92a5da8e0428 RCX: 0000000000000000
[  767.690383] RDX: ffff92a4c0000000 RSI: 0000000000007cab RDI: ffff92a5da8e0078
[  767.692096] RBP: ffffba76c1587bf0 R08: ffff92a69318b918 R09: ffff92a5fa332800
[  767.693912] R10: 0000000000000040 R11: 0000000000000000 R12: ffff92a602b27460
[  767.695723] R13: ffff92a5d2fcc4d0 R14: ffffba76c1587cc0 R15: 0000000000000002
[  767.697544] FS:  0000000000000000(0000) GS:ffff92a6b5400000(0000)
knlGS:0000000000000000
[  767.699693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  767.701205] CR2: 000000c000230000 CR3: 0000000166a0a001 CR4: 00000000001606f0
[  767.703022] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  767.704857] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  767.706670] Call Trace:
[  767.707470]  find_parent_nodes+0x8c8/0xf90 [btrfs]
[  767.708784]  ? __slab_free+0x153/0x2d0
[  767.709857]  btrfs_find_all_roots_safe+0xb0/0x130 [btrfs]
[  767.711310]  ? btrfs_find_all_roots_safe+0xb0/0x130 [btrfs]
[  767.712799]  btrfs_find_all_roots+0x1c/0x80 [btrfs]
[  767.714119]  ? kfree+0x168/0x180
[  767.715061]  ? kfree+0x168/0x180
[  767.716033]  btrfs_qgroup_account_extents+0x87/0x1e0 [btrfs]
[  767.717538]  btrfs_commit_transaction+0x46f/0x910 [btrfs]
[  767.718965]  ? wait_woken+0x80/0x80
[  767.719987]  transaction_kthread+0x18d/0x1b0 [btrfs]
[  767.721329]  kthread+0x121/0x140
[  767.722277]  ? btrfs_cleanup_transaction+0x570/0x570 [btrfs]
[  767.723762]  ? kthread_create_worker_on_cpu+0x70/0x70
[  767.725123]  ret_from_fork+0x35/0x40
[  767.726132] Code: 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3
48 83 bd 70 ff ff ff ff 75 5d 48 8b 85 68 ff ff ff 48 8b 15 cb 94 6b
e2 48 8b 00 <48> 8b 80 98 00 00 00 48 2b 05 aa 94 6b e2 48 c1 f8 06 48
c1 e0
[  767.730822] RIP: resolve_indirect_refs+0x290/0x8b0 [btrfs] RSP:
ffffba76c1587b18
[  767.732821] ---[ end trace 10e975e8f58b0b44 ]---


# uname -a
Linux hs13 4.15.0-123-generic #126-Ubuntu SMP Wed Oct 21 09:40:11 UTC
2020 x86_64 x86_64 x86_64 GNU/Linux

# btrfs --version
btrfs-progs v4.15.1

# btrfs fi show

Label: 'btrfs'  uuid: 690ee84e-69fd-4b9c-9941-9dbfba717949
Total devices 2 FS bytes used 56.99GiB
devid    1 size 40.00GiB used 40.00GiB path /dev/sda2
devid    2 size 20.00GiB used 20.00GiB path /dev/sdc1

Label: 'hs13.btrfs.2'  uuid: 3783b87d-2095-44b6-a40e-c2a2dd051c21
Total devices 1 FS bytes used 112.00KiB
devid    1 size 10.00GiB used 1.02GiB path /dev/sdb1

Label: 'trial'  uuid: d8e3aee5-7bfa-4b6a-8da7-5e59e281d4eb
Total devices 1 FS bytes used 7.54GiB
devid    1 size 50.00GiB used 10.02GiB path /dev/sdd1

# btrfs check /dev/sda2

Checking filesystem on /dev/sda2
UUID: 690ee84e-69fd-4b9c-9941-9dbfba717949
checking extents
checking free space cache
checking fs roots
warning line 3392
checking csums
checking root refs
checking quota groups
Qgroup are marked as inconsistent.
found 61188112384 bytes used, no error found
total csum bytes: 58175296
total tree bytes: 1616543744
total fs tree bytes: 1480048640
total extent tree bytes: 66174976
btree space waste bytes: 346388377
file data blocks allocated: 144686911488
referenced 139457302528

# btrfs check /dev/sdc1
Checking filesystem on /dev/sdc1
UUID: 690ee84e-69fd-4b9c-9941-9dbfba717949
checking extents
checking free space cache
checking fs roots
warning line 3392
checking csums
checking root refs
checking quota groups
Qgroup are marked as inconsistent.
found 61188112384 bytes used, no error found
total csum bytes: 58175296
total tree bytes: 1616543744
total fs tree bytes: 1480048640
total extent tree bytes: 66174976
btree space waste bytes: 346388377
file data blocks allocated: 144686911488
referenced 139457302528

Could you help, give some advice ?

--
Best reagards
Marek
