Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5E2603BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGEKBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:01:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbfGEKBL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 06:01:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8951B039;
        Fri,  5 Jul 2019 10:01:08 +0000 (UTC)
Subject: Re: [PATCH 2/5] Btrfs: fix inode cache block reserve leak on failure
 to allocate data space
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190704152419.20715-1-fdmanana@kernel.org>
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
Message-ID: <4cdbcb14-c0e6-bdf7-e542-3c7f0286c91e@suse.com>
Date:   Fri, 5 Jul 2019 13:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704152419.20715-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.07.19 г. 18:24 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we failed to allocate the data extent(s) for the inode space cache, we
> were bailing out without releasing the previously reserved metadata. This
> was triggering the following warnings when unmounting a filesystem:
> 
>   $ cat -n fs/btrfs/inode.c
>   (...)
>   9268  void btrfs_destroy_inode(struct inode *inode)
>   9269  {
>   (...)
>   9276          WARN_ON(BTRFS_I(inode)->block_rsv.reserved);
>   9277          WARN_ON(BTRFS_I(inode)->block_rsv.size);
>   (...)
>   9281          WARN_ON(BTRFS_I(inode)->csum_bytes);
>   9282          WARN_ON(BTRFS_I(inode)->defrag_bytes);
>   (...)
> 
> Several fstests test cases triggered this often, such as generic/083,
> generic/102, generic/172, generic/269 and generic/300 at least, producing
> stack traces like the following in dmesg/syslog:
> 
>   [82039.079546] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9276 btrfs_destroy_inode+0x203/0x270 [btrfs]
>   (...)
>   [82039.081543] CPU: 2 PID: 13167 Comm: umount Tainted: G        W         5.2.0-rc4-btrfs-next-50 #1
>   [82039.081912] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>   [82039.082673] RIP: 0010:btrfs_destroy_inode+0x203/0x270 [btrfs]
>   (...)
>   [82039.083913] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
>   [82039.084320] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0000000000000002
>   [82039.084736] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dde29b34660
>   [82039.085156] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0000000000000000
>   [82039.085578] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffac0b426a7db0
>   [82039.086000] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0000000000000000
>   [82039.086416] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) knlGS:0000000000000000
>   [82039.086837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [82039.087253] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000000003606e0
>   [82039.087672] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [82039.088089] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [82039.088504] Call Trace:
>   [82039.088918]  destroy_inode+0x3b/0x70
>   [82039.089340]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
>   [82039.089768]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
>   [82039.090183]  ? wait_for_completion+0x65/0x1a0
>   [82039.090607]  close_ctree+0x172/0x370 [btrfs]
>   [82039.091021]  generic_shutdown_super+0x6c/0x110
>   [82039.091427]  kill_anon_super+0xe/0x30
>   [82039.091832]  btrfs_kill_super+0x12/0xa0 [btrfs]
>   [82039.092233]  deactivate_locked_super+0x3a/0x70
>   [82039.092636]  cleanup_mnt+0x3b/0x80
>   [82039.093039]  task_work_run+0x93/0xc0
>   [82039.093457]  exit_to_usermode_loop+0xfa/0x100
>   [82039.093856]  do_syscall_64+0x162/0x1d0
>   [82039.094244]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [82039.094634] RIP: 0033:0x7f8db8fbab37
>   (...)
>   [82039.095876] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>   [82039.096290] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007f8db8fbab37
>   [82039.096700] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000560d20b00240
>   [82039.097110] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0000000000000015
>   [82039.097522] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f8db94bce64
>   [82039.097937] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdce35b6f0
>   [82039.098350] irq event stamp: 0
>   [82039.098750] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   [82039.099150] hardirqs last disabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.099545] softirqs last  enabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.099925] softirqs last disabled at (0): [<0000000000000000>] 0x0
>   [82039.100292] ---[ end trace f2521afa616ddccc ]---
>   [82039.100707] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9277 btrfs_destroy_inode+0x1ac/0x270 [btrfs]
>   (...)
>   [82039.103050] CPU: 2 PID: 13167 Comm: umount Tainted: G        W         5.2.0-rc4-btrfs-next-50 #1
>   [82039.103428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>   [82039.104203] RIP: 0010:btrfs_destroy_inode+0x1ac/0x270 [btrfs]
>   (...)
>   [82039.105461] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010206
>   [82039.105866] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0000000000000002
>   [82039.106270] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8dde29b34660
>   [82039.106673] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0000000000000000
>   [82039.107078] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffac0b426a7db0
>   [82039.107487] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0000000000000000
>   [82039.107894] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) knlGS:0000000000000000
>   [82039.108309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [82039.108723] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000000003606e0
>   [82039.109146] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [82039.109567] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [82039.109989] Call Trace:
>   [82039.110405]  destroy_inode+0x3b/0x70
>   [82039.110830]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
>   [82039.111257]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
>   [82039.111675]  ? wait_for_completion+0x65/0x1a0
>   [82039.112101]  close_ctree+0x172/0x370 [btrfs]
>   [82039.112519]  generic_shutdown_super+0x6c/0x110
>   [82039.112988]  kill_anon_super+0xe/0x30
>   [82039.113439]  btrfs_kill_super+0x12/0xa0 [btrfs]
>   [82039.113861]  deactivate_locked_super+0x3a/0x70
>   [82039.114278]  cleanup_mnt+0x3b/0x80
>   [82039.114685]  task_work_run+0x93/0xc0
>   [82039.115083]  exit_to_usermode_loop+0xfa/0x100
>   [82039.115476]  do_syscall_64+0x162/0x1d0
>   [82039.115863]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [82039.116254] RIP: 0033:0x7f8db8fbab37
>   (...)
>   [82039.117463] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>   [82039.117882] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007f8db8fbab37
>   [82039.118330] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000560d20b00240
>   [82039.118743] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0000000000000015
>   [82039.119159] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f8db94bce64
>   [82039.119574] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdce35b6f0
>   [82039.119987] irq event stamp: 0
>   [82039.120387] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   [82039.120787] hardirqs last disabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.121182] softirqs last  enabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.121563] softirqs last disabled at (0): [<0000000000000000>] 0x0
>   [82039.121933] ---[ end trace f2521afa616ddccd ]---
>   [82039.122353] WARNING: CPU: 2 PID: 13167 at fs/btrfs/inode.c:9278 btrfs_destroy_inode+0x1bc/0x270 [btrfs]
>   (...)
>   [82039.124606] CPU: 2 PID: 13167 Comm: umount Tainted: G        W         5.2.0-rc4-btrfs-next-50 #1
>   [82039.125008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>   [82039.125801] RIP: 0010:btrfs_destroy_inode+0x1bc/0x270 [btrfs]
>   (...)
>   [82039.126998] RSP: 0018:ffffac0b426a7d30 EFLAGS: 00010202
>   [82039.127399] RAX: ffff8ddf77691158 RBX: ffff8dde29b34660 RCX: 0000000000000002
>   [82039.127803] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff8dde29b34660
>   [82039.128206] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0000000000000000
>   [82039.128611] R10: ffffac0b426a7c90 R11: ffffffffb9aad768 R12: ffffac0b426a7db0
>   [82039.129020] R13: ffff8ddf5fbec0a0 R14: dead000000000100 R15: 0000000000000000
>   [82039.129428] FS:  00007f8db96d12c0(0000) GS:ffff8de036b00000(0000) knlGS:0000000000000000
>   [82039.129846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [82039.130261] CR2: 0000000001416108 CR3: 00000002315cc001 CR4: 00000000003606e0
>   [82039.130684] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [82039.131142] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [82039.131561] Call Trace:
>   [82039.131990]  destroy_inode+0x3b/0x70
>   [82039.132417]  btrfs_free_fs_root+0x16/0xa0 [btrfs]
>   [82039.132844]  btrfs_free_fs_roots+0xd8/0x160 [btrfs]
>   [82039.133262]  ? wait_for_completion+0x65/0x1a0
>   [82039.133688]  close_ctree+0x172/0x370 [btrfs]
>   [82039.134157]  generic_shutdown_super+0x6c/0x110
>   [82039.134575]  kill_anon_super+0xe/0x30
>   [82039.134997]  btrfs_kill_super+0x12/0xa0 [btrfs]
>   [82039.135415]  deactivate_locked_super+0x3a/0x70
>   [82039.135832]  cleanup_mnt+0x3b/0x80
>   [82039.136239]  task_work_run+0x93/0xc0
>   [82039.136637]  exit_to_usermode_loop+0xfa/0x100
>   [82039.137029]  do_syscall_64+0x162/0x1d0
>   [82039.137418]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [82039.137812] RIP: 0033:0x7f8db8fbab37
>   (...)
>   [82039.139059] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>   [82039.139475] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007f8db8fbab37
>   [82039.139890] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000560d20b00240
>   [82039.140302] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0000000000000015
>   [82039.140719] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f8db94bce64
>   [82039.141138] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdce35b6f0
>   [82039.141597] irq event stamp: 0
>   [82039.142043] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   [82039.142443] hardirqs last disabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.142839] softirqs last  enabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.143220] softirqs last disabled at (0): [<0000000000000000>] 0x0
>   [82039.143588] ---[ end trace f2521afa616ddcce ]---
>   [82039.167472] WARNING: CPU: 3 PID: 13167 at fs/btrfs/extent-tree.c:10120 btrfs_free_block_groups+0x30d/0x460 [btrfs]
>   (...)
>   [82039.173800] CPU: 3 PID: 13167 Comm: umount Tainted: G        W         5.2.0-rc4-btrfs-next-50 #1
>   [82039.174847] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>   [82039.177031] RIP: 0010:btrfs_free_block_groups+0x30d/0x460 [btrfs]
>   (...)
>   [82039.180397] RSP: 0018:ffffac0b426a7dd8 EFLAGS: 00010206
>   [82039.181574] RAX: ffff8de010a1db40 RBX: ffff8de010a1db40 RCX: 0000000000170014
>   [82039.182711] RDX: ffff8ddff4380040 RSI: ffff8de010a1da58 RDI: 0000000000000246
>   [82039.183817] RBP: ffff8ddf5fbec000 R08: 0000000000000000 R09: 0000000000000000
>   [82039.184925] R10: ffff8de036404380 R11: ffffffffb8a5ea00 R12: ffff8de010a1b2b8
>   [82039.186090] R13: ffff8de010a1b2b8 R14: 0000000000000000 R15: dead000000000100
>   [82039.187208] FS:  00007f8db96d12c0(0000) GS:ffff8de036b80000(0000) knlGS:0000000000000000
>   [82039.188345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [82039.189481] CR2: 00007fb044005170 CR3: 00000002315cc006 CR4: 00000000003606e0
>   [82039.190674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [82039.191829] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [82039.192978] Call Trace:
>   [82039.194160]  close_ctree+0x19a/0x370 [btrfs]
>   [82039.195315]  generic_shutdown_super+0x6c/0x110
>   [82039.196486]  kill_anon_super+0xe/0x30
>   [82039.197645]  btrfs_kill_super+0x12/0xa0 [btrfs]
>   [82039.198696]  deactivate_locked_super+0x3a/0x70
>   [82039.199619]  cleanup_mnt+0x3b/0x80
>   [82039.200559]  task_work_run+0x93/0xc0
>   [82039.201505]  exit_to_usermode_loop+0xfa/0x100
>   [82039.202436]  do_syscall_64+0x162/0x1d0
>   [82039.203339]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [82039.204091] RIP: 0033:0x7f8db8fbab37
>   (...)
>   [82039.206360] RSP: 002b:00007ffdce35b468 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>   [82039.207132] RAX: 0000000000000000 RBX: 0000560d20b00060 RCX: 00007f8db8fbab37
>   [82039.207906] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000560d20b00240
>   [82039.208621] RBP: 0000560d20b00240 R08: 0000560d20b00270 R09: 0000000000000015
>   [82039.209285] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f8db94bce64
>   [82039.209984] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffdce35b6f0
>   [82039.210642] irq event stamp: 0
>   [82039.211306] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   [82039.211971] hardirqs last disabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.212643] softirqs last  enabled at (0): [<ffffffffb7884ff2>] copy_process.part.33+0x7f2/0x1f00
>   [82039.213304] softirqs last disabled at (0): [<0000000000000000>] 0x0
>   [82039.213875] ---[ end trace f2521afa616ddccf ]---
> 
> Fix this by releasing the reserved metadata on failure to allocate data
> extent(s) for the inode cache.
> 
> Fixes: 69fe2d75dd91d0 ("btrfs: make the delalloc block rsv per inode")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>> ---
>  fs/btrfs/inode-map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> index 4a5882665f8a..b210e8929c28 100644
> --- a/fs/btrfs/inode-map.c
> +++ b/fs/btrfs/inode-map.c
> @@ -485,6 +485,7 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
>  					      prealloc, prealloc, &alloc_hint);
>  	if (ret) {
>  		btrfs_delalloc_release_extents(BTRFS_I(inode), prealloc, true);
> +		btrfs_delalloc_release_metadata(BTRFS_I(inode), prealloc, true);

I think the correct freeing function is btrfs_delalloc_release_space
here instead of just releasing the metadata.

Looking at the interface and naming of functions it could be confusing
as hell which function  needs to be used ;\


>  		goto out_put;
>  	}
>  
> 
