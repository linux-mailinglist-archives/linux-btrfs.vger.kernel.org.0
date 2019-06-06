Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E123731C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfFFLkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:40:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFFLkD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:40:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99C54AE67;
        Thu,  6 Jun 2019 11:40:00 +0000 (UTC)
Subject: Re: [PATCH v2] btrfs: correctly validate compression type
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20190606100715.14429-1-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc6335ab-d138-5a31-3ccd-bb5d8fe17ce9@suse.com>
Date:   Thu, 6 Jun 2019 14:39:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606100715.14429-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 6.06.19 г. 13:07 ч., Johannes Thumshirn wrote:
> Nikolay reported the following KASAN splat when running btrfs/048:
> 
> [ 1843.470920] ==================================================================
> [ 1843.471971] BUG: KASAN: slab-out-of-bounds in strncmp+0x66/0xb0
> [ 1843.472775] Read of size 1 at addr ffff888111e369e2 by task btrfs/3979
> 
> [ 1843.473904] CPU: 3 PID: 3979 Comm: btrfs Not tainted 5.2.0-rc3-default #536
> [ 1843.475009] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
> [ 1843.476322] Call Trace:
> [ 1843.476674]  dump_stack+0x7c/0xbb
> [ 1843.477132]  ? strncmp+0x66/0xb0
> [ 1843.477587]  print_address_description+0x114/0x320
> [ 1843.478256]  ? strncmp+0x66/0xb0
> [ 1843.478740]  ? strncmp+0x66/0xb0
> [ 1843.479185]  __kasan_report+0x14e/0x192
> [ 1843.479759]  ? strncmp+0x66/0xb0
> [ 1843.480209]  kasan_report+0xe/0x20
> [ 1843.480679]  strncmp+0x66/0xb0
> [ 1843.481105]  prop_compression_validate+0x24/0x70
> [ 1843.481798]  btrfs_xattr_handler_set_prop+0x65/0x160
> [ 1843.482509]  __vfs_setxattr+0x71/0x90
> [ 1843.483012]  __vfs_setxattr_noperm+0x84/0x130
> [ 1843.483606]  vfs_setxattr+0xac/0xb0
> [ 1843.484085]  setxattr+0x18c/0x230
> [ 1843.484546]  ? vfs_setxattr+0xb0/0xb0
> [ 1843.485048]  ? __mod_node_page_state+0x1f/0xa0
> [ 1843.485672]  ? _raw_spin_unlock+0x24/0x40
> [ 1843.486233]  ? __handle_mm_fault+0x988/0x1290
> [ 1843.486823]  ? lock_acquire+0xb4/0x1e0
> [ 1843.487330]  ? lock_acquire+0xb4/0x1e0
> [ 1843.487842]  ? mnt_want_write_file+0x3c/0x80
> [ 1843.488442]  ? debug_lockdep_rcu_enabled+0x22/0x40
> [ 1843.489089]  ? rcu_sync_lockdep_assert+0xe/0x70
> [ 1843.489707]  ? __sb_start_write+0x158/0x200
> [ 1843.490278]  ? mnt_want_write_file+0x3c/0x80
> [ 1843.490855]  ? __mnt_want_write+0x98/0xe0
> [ 1843.491397]  __x64_sys_fsetxattr+0xba/0xe0
> [ 1843.492201]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [ 1843.493201]  do_syscall_64+0x6c/0x230
> [ 1843.493988]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 1843.495041] RIP: 0033:0x7fa7a8a7707a
> [ 1843.495819] Code: 48 8b 0d 21 de 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 be 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ee dd 2b 00 f7 d8 64 89 01 48
> [ 1843.499203] RSP: 002b:00007ffcb73bca38 EFLAGS: 00000202 ORIG_RAX: 00000000000000be
> [ 1843.500210] RAX: ffffffffffffffda RBX: 00007ffcb73bda9d RCX: 00007fa7a8a7707a
> [ 1843.501170] RDX: 00007ffcb73bda9d RSI: 00000000006dc050 RDI: 0000000000000003
> [ 1843.502152] RBP: 00000000006dc050 R08: 0000000000000000 R09: 0000000000000000
> [ 1843.503109] R10: 0000000000000002 R11: 0000000000000202 R12: 00007ffcb73bda91
> [ 1843.504055] R13: 0000000000000003 R14: 00007ffcb73bda82 R15: ffffffffffffffff
> 
> [ 1843.505268] Allocated by task 3979:
> [ 1843.505771]  save_stack+0x19/0x80
> [ 1843.506211]  __kasan_kmalloc.constprop.5+0xa0/0xd0
> [ 1843.506836]  setxattr+0xeb/0x230
> [ 1843.507264]  __x64_sys_fsetxattr+0xba/0xe0
> [ 1843.507886]  do_syscall_64+0x6c/0x230
> [ 1843.508429]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> [ 1843.509558] Freed by task 0:
> [ 1843.510188] (stack is not available)
> 
> [ 1843.511309] The buggy address belongs to the object at ffff888111e369e0
>                 which belongs to the cache kmalloc-8 of size 8
> [ 1843.514095] The buggy address is located 2 bytes inside of
>                 8-byte region [ffff888111e369e0, ffff888111e369e8)
> [ 1843.516524] The buggy address belongs to the page:
> [ 1843.517561] page:ffff88813f478d80 refcount:1 mapcount:0 mapping:ffff88811940c300 index:0xffff888111e373b8 compound_mapcount: 0
> [ 1843.519993] flags: 0x4404000010200(slab|head)
> [ 1843.520951] raw: 0004404000010200 ffff88813f48b008 ffff888119403d50 ffff88811940c300
> [ 1843.522616] raw: ffff888111e373b8 000000000016000f 00000001ffffffff 0000000000000000
> [ 1843.524281] page dumped because: kasan: bad access detected
> 
> [ 1843.525936] Memory state around the buggy address:
> [ 1843.526975]  ffff888111e36880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1843.528479]  ffff888111e36900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1843.530138] >ffff888111e36980: fc fc fc fc fc fc fc fc fc fc fc fc 02 fc fc fc
> [ 1843.531877]                                                        ^
> [ 1843.533287]  ffff888111e36a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1843.534874]  ffff888111e36a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [ 1843.536468] ==================================================================
> 
> This is caused by supplying a too short compression value ('lz') in the
> test-case and comparing it to 'lzo' with strncmp() and a length of 3.
> strncmp() read past the 'lz' when looking for the 'o' and thus caused an
> out-of-bounds read.
> 
> Introduce a new check 'btrfs_compress_is_valid_type()' which not only
> checks the user-supplied value against known compression types, but also
> employs checks for too short values.
> 
> Fixes: 272e5326c783 ("btrfs: prop: fix vanished compression property after failed set")
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


<snip>
