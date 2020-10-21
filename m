Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF282952AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502441AbgJUTDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 15:03:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:60140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502390AbgJUTDw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 15:03:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9E70AE95;
        Wed, 21 Oct 2020 19:03:50 +0000 (UTC)
Date:   Wed, 21 Oct 2020 14:03:48 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] btrfs: skip call to generic_file_buffered_read if we
 don't need to
Message-ID: <20201021190348.vqc6jtmppel63ltc@fiona>
References: <e9b1d098cd97cf275009a80d0ce087ba39267dcf.1603300854.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b1d098cd97cf275009a80d0ce087ba39267dcf.1603300854.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On  2:22 22/10, Johannes Thumshirn wrote:
> Since we switched to the iomap infrastructure in b5ff9f1a96e8f ("btrfs:
> switch to iomap for direct IO") we're calling generic_file_buffered_read()
> directly and not via generic_file_read_iter() anymore.
> 
> If the read could read everything there is no need to bother calling
> generic_file_buffered_read(), like it is handled in
> generic_file_read_iter().
> 
> If we call generic_file_buffered_read() in this case we can hit a
> situation where we do an invalid readahead and cause this UBSAN splat:
> johannes@redsun60:linux(btrfs-misc-next)$ kasan_symbolize.py < ubsan.txt
> rapido1:/home/johannes/src/xfstests-dev# cat results/generic/091.dmesg
> run fstests generic/091 at 2020-10-21 10:52:32
> ================================================================================
> UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
> shift exponent 64 is too large for 64-bit type 'long unsigned int'
> CPU: 0 PID: 656 Comm: fsx Not tainted 5.9.0-rc7+ #821
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77
>  dump_stack+0x57/0x70 lib/dump_stack.c:118
>  ubsan_epilogue+0x5/0x40 lib/ubsan.c:148
>  __ubsan_handle_shift_out_of_bounds.cold+0x61/0xe9 lib/ubsan.c:395
>  __roundup_pow_of_two ./include/linux/log2.h:57
>  get_init_ra_size mm/readahead.c:318
>  ondemand_readahead.cold+0x16/0x2c mm/readahead.c:530
>  generic_file_buffered_read+0x3ac/0x840 mm/filemap.c:2199
>  call_read_iter ./include/linux/fs.h:1876
>  new_sync_read+0x102/0x180 fs/read_write.c:415
>  vfs_read+0x11c/0x1a0 fs/read_write.c:481
>  ksys_read+0x4f/0xc0 fs/read_write.c:615
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9 arch/x86/entry/entry_64.S:118
> RIP: 0033:0x7fe87fee992e
> Code: 0f 1f 40 00 48 8b 15 a1 96 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> RSP: 002b:00007ffe01605278 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000000000004f000 RCX: 00007fe87fee992e
> RDX: 0000000000004000 RSI: 0000000001677000 RDI: 0000000000000003
> RBP: 000000000004f000 R08: 0000000000004000 R09: 000000000004f000
> R10: 0000000000053000 R11: 0000000000000246 R12: 0000000000004000
> R13: 0000000000000000 R14: 000000000007a120 R15: 0000000000000000
> ================================================================================
> BTRFS info (device nullb0): has skinny extents
> BTRFS info (device nullb0): ZONED mode enabled, zone size 268435456 B
> BTRFS info (device nullb0): enabling ssd optimizations
> 
> Fixes: b5ff9f1a96e8f ("btrfs: switch to iomap for direct IO")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 6f5ecba74f54..8e6def2c463d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3612,7 +3612,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		inode_lock_shared(inode);
>  		ret = btrfs_direct_IO(iocb, to);
>  		inode_unlock_shared(inode);
> -		if (ret < 0)
> +		if (ret < 0 || (ret > 0 && iov_iter_count(to) == 0))
>  			return ret;
>  	}
>  

You can also include the check (iocb->ki_pos >=
i_size_read(file_inode(iocb->ki_filp))

-- 
Goldwyn
