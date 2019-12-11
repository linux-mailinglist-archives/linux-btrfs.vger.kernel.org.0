Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9820F11AE0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfLKOnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 09:43:52 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42217 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKOnw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 09:43:52 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so5809136qvy.9
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2019 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QuI9+kxZJFwHhN4kU6HpVeT8NtZfoitjplqPGd48k2E=;
        b=f2cpepVOBk/aQxrQhsPLRJow7OCCSYBXzeztdHf2BV/POxx1XGnx25ewInLrJNAQ+p
         iPZB5NtjkLeNEdvSfROgUQhCz425SHXVojTsVGHvWrvaVQjGOvs3piLOUj0ZY3diPRpw
         RK4GNv5CHeYyfDQXC9CjA96a9DARF2q1xkMfNQ3LlrMqvBd+sQbBqM7OjG/bQFNfpR+z
         vUL5LU6cZaH92IDqe6YlwydFZnJ2p9reuXPKry3z4l/wuZMgSxhLMz+m3WuJBXX7SV3f
         Hy2NidnMWIURd+HX4Y7HaykkxVek1ZzQxU48qAqXfuC8Ov3RxvBgiIenJwNV0f4HgC6c
         XcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QuI9+kxZJFwHhN4kU6HpVeT8NtZfoitjplqPGd48k2E=;
        b=XQYhvpAWAitvuhbx3tXLM8pmcLA06OrkV2QLIII9ZUaxQZsWAsJWILKSwu3RasCyCU
         Mim03Gh9m0j9Z2VUjUKkOjg+2iHyO282kfdXO8zqN4SFhBTUh3COallMPgJoCW2T5wls
         8hx3hHMYWJAdITrZL3dEpqPBl4qa4hSJdKj2wZW8+96IVoGP0vBL0sfNlJGSNm8XVh4P
         7wzu0wwlAPYA+kPZbGPEtBDXVnkMYwgxVslZ0Z3kOu8iGQwgssw/CPF5uXff4kouzK/z
         cPcTucLICUR/fct6XvYuJZ7NgtAxaPGZEZ9uHdx8p07eauZc3jbr4fmWpaCzT7IW02nL
         +x/w==
X-Gm-Message-State: APjAAAW/1U9xEk+3qHCeTImgViQWv9mSPKqdYWgJ2I5jwzdKZSdjTbkZ
        z7My0+RYSvczN8jHXyWCVABlhe2N0bXq1w==
X-Google-Smtp-Source: APXvYqxkzLQNlhC/uuxO85tIvSFgymalUda3HvBrqjefJSVxZFJiFNcYuB0P61oiodOLzHqgGSPY7Q==
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr3261686qvp.167.1576075430861;
        Wed, 11 Dec 2019 06:43:50 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4149])
        by smtp.gmail.com with ESMTPSA id l33sm979376qtf.79.2019.12.11.06.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:43:50 -0800 (PST)
Subject: Re: [PATCH] Btrfs: fix infinite loop during nocow writeback due to
 race
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20191211090140.27607-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aa448f2f-59fc-ce09-e222-6a661a56f15c@toxicpanda.com>
Date:   Wed, 11 Dec 2019 09:43:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211090140.27607-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/19 4:01 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When starting writeback for a range that covers part of a preallocated
> extent, due to a race with writeback for another range that also covers
> another part of the same preallocated extent, we can end up in an infinite
> loop.
> 
> Consider the following example where for inode 280 we have two dirty
> ranges:
> 
>    range A, from 294912 to 303103, 8192 bytes
>    range B, from 348160 to 438271, 90112 bytes
> 
> and we have the following file extent item layout for our inode:
> 
>    leaf 38895616 gen 24544 total ptrs 29 free space 13820 owner 5
>        (...)
>        item 27 key (280 108 200704) itemoff 14598 itemsize 53
>            extent data disk bytenr 0 nr 0 type 1 (regular)
>            extent data offset 0 nr 94208 ram 94208
>        item 28 key (280 108 294912) itemoff 14545 itemsize 53
>            extent data disk bytenr 10433052672 nr 81920 type 2 (prealloc)
>            extent data offset 0 nr 81920 ram 81920
> 
> Then the following happens:
> 
> 1) Writeback starts for range B (from 348160 to 438271), execution of
>     run_delalloc_nocow() starts;
> 
> 2) The first iteration of run_delalloc_nocow()'s whil loop leaves us at
>     the extent item at slot 28, pointing to the prealloc extent item
>     covering the range from 294912 to 376831. This extent covers part of
>     our range;
> 
> 3) An ordered extent is created against that extent, covering the file
>     range from 348160 to 376831 (28672 bytes);
> 
> 4) We adjust 'cur_offset' to 376832 and move on to the next iteration of
>     the while loop;
> 
> 5) The call to btrfs_lookup_file_extent() leaves us at the same leaf,
>     pointing to slot 29, 1 slot after the last item (the extent item
>     we processed in the previous iteration);
> 
> 6) Because we are a slot beyond the last item, we call btrfs_next_leaf(),
>     which releases the search path before doing a another search for the
>     last key of the leaf (280 108 294912);
> 
> 7) Right after btrfs_next_leaf() released the path, and before it did
>     another search for the last key of the leaf, writeback for the range
>     A (from 294912 to 303103) completes (it was previously started at
>     some point);
> 
> 8) Upon completion of the ordered extent for range A, the prealloc extent
>     we previously found got split into two extent items, one covering the
>     range from 294912 to 303103 (8192 bytes), with a type of regular extent
>     (and no longer prealloc) and another covering the range from 303104 to
>     376831 (73728 bytes), with a type of prealloc and an offset of 8192
>     bytes. So our leaf now has the following layout:
> 
>       leaf 38895616 gen 24544 total ptrs 31 free space 13664 owner 5
>           (...)
>           item 27 key (280 108 200704) itemoff 14598 itemsize 53
>               extent data disk bytenr 0 nr 0 type 1
>               extent data offset 0 nr 8192 ram 94208
>           item 28 key (280 108 208896) itemoff 14545 itemsize 53
>               extent data disk bytenr 10433142784 nr 86016 type 1
>               extent data offset 0 nr 86016 ram 86016
>           item 29 key (280 108 294912) itemoff 14492 itemsize 53
>               extent data disk bytenr 10433052672 nr 81920 type 1
>               extent data offset 0 nr 8192 ram 81920
>           item 30 key (280 108 303104) itemoff 14439 itemsize 53
>               extent data disk bytenr 10433052672 nr 81920 type 2
>               extent data offset 8192 nr 73728 ram 81920
> 
> 9) After btrfs_next_leaf() returns, we have our path pointing to that same
>     leaf and at slot 30, since it has a key we didn't have before and it's
>     the first key greater then the key that was previously the last key of
>     the leaf (key (280 108 294912));
> 
> 10) The extent item at slot 30 covers the range from 303104 to 376831
>      which is in our target range, so we process it, despite having already
>      created an ordered extent against this extent for the file range from
>      348160 to 376831. This is because we skip to the next extent item only
>      if its end is less than or equals to the start of our delalloc range,
>      and not less than or equals to the current offset ('cur_offset');
> 
> 11) As a result we compute 'num_bytes' as:
> 
>      num_bytes = min(end + 1, extent_end) - cur_offset;
>                = min(438271 + 1, 376832) - 376832 = 0
> 
> 12) We then call create_io_em() for a 0 bytes range starting at offset
>      376832;
> 
> 13) Then create_io_em() enters an infinite loop because its calls to
>      btrfs_drop_extent_cache() do nothing due to the 0 length range
>      passed to it. So no existing extent maps that cover the offset
>      376832 get removed, and therefore calls to add_extent_mapping()
>      return -EEXIST, resulting in an infinite loop. This loop from
>      create_io_em() is the following:
> 
>      do {
>          btrfs_drop_extent_cache(BTRFS_I(inode), em->start,
>                                  em->start + em->len - 1, 0);
>          write_lock(&em_tree->lock);
>          ret = add_extent_mapping(em_tree, em, 1);
>          write_unlock(&em_tree->lock);
>          /*
>           * The caller has taken lock_extent(), who could race with us
>           * to add em?
>           */
>      } while (ret == -EEXIST);
> 
> Also, each call to btrfs_drop_extent_cache() triggers a warning because
> the start offset passed to it (376832) is smaller then the end offset
> (376832 - 1) passed to it by -1, due to the 0 length:
> 
>    [258532.052621] ------------[ cut here ]------------
>    [258532.052643] WARNING: CPU: 0 PID: 9987 at fs/btrfs/file.c:602 btrfs_drop_extent_cache+0x3f4/0x590 [btrfs]
>    (...)
>    [258532.052672] CPU: 0 PID: 9987 Comm: fsx Tainted: G        W         5.4.0-rc7-btrfs-next-64 #1
>    [258532.052673] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>    [258532.052691] RIP: 0010:btrfs_drop_extent_cache+0x3f4/0x590 [btrfs]
>    (...)
>    [258532.052695] RSP: 0018:ffffb4be0153f860 EFLAGS: 00010287
>    [258532.052700] RAX: ffff975b445ee360 RBX: ffff975b44eb3e08 RCX: 0000000000000000
>    [258532.052700] RDX: 0000000000038fff RSI: 0000000000039000 RDI: ffff975b445ee308
>    [258532.052700] RBP: 0000000000038fff R08: 0000000000000000 R09: 0000000000000001
>    [258532.052701] R10: ffff975b513c5c10 R11: 00000000e3c0cfa9 R12: 0000000000039000
>    [258532.052703] R13: ffff975b445ee360 R14: 00000000ffffffef R15: ffff975b445ee308
>    [258532.052705] FS:  00007f86a821de80(0000) GS:ffff975b76a00000(0000) knlGS:0000000000000000
>    [258532.052707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [258532.052708] CR2: 00007fdacf0f3ab4 CR3: 00000001f9d26002 CR4: 00000000003606f0
>    [258532.052712] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [258532.052717] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [258532.052717] Call Trace:
>    [258532.052718]  ? preempt_schedule_common+0x32/0x70
>    [258532.052722]  ? ___preempt_schedule+0x16/0x20
>    [258532.052741]  create_io_em+0xff/0x180 [btrfs]
>    [258532.052767]  run_delalloc_nocow+0x942/0xb10 [btrfs]
>    [258532.052791]  btrfs_run_delalloc_range+0x30b/0x520 [btrfs]
>    [258532.052812]  ? find_lock_delalloc_range+0x221/0x250 [btrfs]
>    [258532.052834]  writepage_delalloc+0xe4/0x140 [btrfs]
>    [258532.052855]  __extent_writepage+0x110/0x4e0 [btrfs]
>    [258532.052876]  extent_write_cache_pages+0x21c/0x480 [btrfs]
>    [258532.052906]  extent_writepages+0x52/0xb0 [btrfs]
>    [258532.052911]  do_writepages+0x23/0x80
>    [258532.052915]  __filemap_fdatawrite_range+0xd2/0x110
>    [258532.052938]  btrfs_fdatawrite_range+0x1b/0x50 [btrfs]
>    [258532.052954]  start_ordered_ops+0x57/0xa0 [btrfs]
>    [258532.052973]  ? btrfs_sync_file+0x225/0x490 [btrfs]
>    [258532.052988]  btrfs_sync_file+0x225/0x490 [btrfs]
>    [258532.052997]  __x64_sys_msync+0x199/0x200
>    [258532.053004]  do_syscall_64+0x5c/0x250
>    [258532.053007]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    [258532.053010] RIP: 0033:0x7f86a7dfd760
>    (...)
>    [258532.053014] RSP: 002b:00007ffd99af0368 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
>    [258532.053016] RAX: ffffffffffffffda RBX: 0000000000000ec9 RCX: 00007f86a7dfd760
>    [258532.053017] RDX: 0000000000000004 RSI: 000000000000836c RDI: 00007f86a8221000
>    [258532.053019] RBP: 0000000000021ec9 R08: 0000000000000003 R09: 00007f86a812037c
>    [258532.053020] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000074a3
>    [258532.053021] R13: 00007f86a8221000 R14: 000000000000836c R15: 0000000000000001
>    [258532.053032] irq event stamp: 1653450494
>    [258532.053035] hardirqs last  enabled at (1653450493): [<ffffffff9dec69f9>] _raw_spin_unlock_irq+0x29/0x50
>    [258532.053037] hardirqs last disabled at (1653450494): [<ffffffff9d4048ea>] trace_hardirqs_off_thunk+0x1a/0x20
>    [258532.053039] softirqs last  enabled at (1653449852): [<ffffffff9e200466>] __do_softirq+0x466/0x6bd
>    [258532.053042] softirqs last disabled at (1653449845): [<ffffffff9d4c8a0c>] irq_exit+0xec/0x120
>    [258532.053043] ---[ end trace 8476fce13d9ce20a ]---
> 
> Which results in flooding dmesg/syslog since btrfs_drop_extent_cache()
> uses WARN_ON() and not WARN_ON_ONCE().

Seems like a good followup fix as well, maybe even an ASSERT for us developers.

> 
> So fix this issue by changing run_delalloc_nocow()'s loop to move to the
> next extent item when the current extent item ends at at offset less than
> or equals to the current offset instead of the start offset.
> 
> Fixes: 80ff385665b7fc ("Btrfs: update nodatacow code v2")
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Nice catch,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
