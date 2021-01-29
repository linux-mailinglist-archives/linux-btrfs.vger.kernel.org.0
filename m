Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19E8308D00
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 20:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhA2TEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 14:04:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:57018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhA2TDb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 14:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3967EAE3C;
        Fri, 29 Jan 2021 19:02:49 +0000 (UTC)
Date:   Fri, 29 Jan 2021 19:02:41 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH v2] btrfs: Avoid calling btrfs_get_chunk_map() twice
Message-ID: <20210129190241.GA18188@wotan.suse.de>
References: <20210127135728.30276-1-mrostecki@suse.de>
 <18dab74b-aea9-0e34-1be5-39d62f44cfd2@toxicpanda.com>
 <20210129171521.GB22949@wotan.suse.de>
 <20210129174753.GL1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129174753.GL1993@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 29, 2021 at 06:47:53PM +0100, David Sterba wrote:
> On Fri, Jan 29, 2021 at 05:15:21PM +0000, Michal Rostecki wrote:
> > On Fri, Jan 29, 2021 at 11:22:48AM -0500, Josef Bacik wrote:
> > > On 1/27/21 8:57 AM, Michal Rostecki wrote:
> > > > From: Michal Rostecki <mrostecki@suse.com>
> > > > 
> > > > Before this change, the btrfs_get_io_geometry() function was calling
> > > > btrfs_get_chunk_map() to get the extent mapping, necessary for
> > > > calculating the I/O geometry. It was using that extent mapping only
> > > > internally and freeing the pointer after its execution.
> > > > 
> > > > That resulted in calling btrfs_get_chunk_map() de facto twice by the
> > > > __btrfs_map_block() function. It was calling btrfs_get_io_geometry()
> > > > first and then calling btrfs_get_chunk_map() directly to get the extent
> > > > mapping, used by the rest of the function.
> > > > 
> > > > This change fixes that by passing the extent mapping to the
> > > > btrfs_get_io_geometry() function as an argument.
> > > > 
> > > > v2:
> > > > When btrfs_get_chunk_map() returns an error in btrfs_submit_direct():
> > > > - Use errno_to_blk_status(PTR_ERR(em)) as the status
> > > > - Set em to NULL
> > > > 
> > > > Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> > > 
> > > This panic'ed all of my test vms in their overnight xfstests runs, the panic is this
> > > 
> > > [ 2449.936502] BTRFS critical (device dm-7): mapping failed logical
> > > 1113825280 bio len 40960 len 24576
> > > [ 2449.937073] ------------[ cut here ]------------
> > > [ 2449.937329] kernel BUG at fs/btrfs/volumes.c:6450!
> > > [ 2449.937604] invalid opcode: 0000 [#1] SMP NOPTI
> > > [ 2449.937855] CPU: 0 PID: 259045 Comm: kworker/u5:0 Not tainted 5.11.0-rc5+ #122
> > > [ 2449.938252] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > 1.13.0-2.fc32 04/01/2014
> > > [ 2449.938713] Workqueue: btrfs-worker-high btrfs_work_helper
> > > [ 2449.939016] RIP: 0010:btrfs_map_bio.cold+0x5a/0x5c
> > > [ 2449.939392] Code: 37 87 ff ff e8 ed d4 8a ff 48 83 c4 18 e9 b5 52 8b ff
> > > 49 89 c8 4c 89 fa 4c 89 f1 48 c7 c6 b0 c0 61 8b 48 89 ef e8 11 87 ff ff <0f>
> > > 0b 4c 89 e7 e8 42 09 86 ff e9 fd 59 8b ff 49 8b 7a 50 44 89 f2
> > > [ 2449.940402] RSP: 0000:ffff9f24c1637d90 EFLAGS: 00010282
> > > [ 2449.940689] RAX: 0000000000000057 RBX: ffff90c78ff716b8 RCX: 0000000000000000
> > > [ 2449.941080] RDX: ffff90c7fbc27ae0 RSI: ffff90c7fbc19110 RDI: ffff90c7fbc19110
> > > [ 2449.941467] RBP: ffff90c7911d4000 R08: 0000000000000000 R09: 0000000000000000
> > > [ 2449.941853] R10: ffff9f24c1637b48 R11: ffffffff8b9723e8 R12: 0000000000000000
> > > [ 2449.942243] R13: 0000000000000000 R14: 000000000000a000 R15: 000000004263a000
> > > [ 2449.942632] FS:  0000000000000000(0000) GS:ffff90c7fbc00000(0000)
> > > knlGS:0000000000000000
> > > [ 2449.943072] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 2449.943386] CR2: 00005575163c3080 CR3: 000000010ad6c004 CR4: 0000000000370ef0
> > > [ 2449.943772] Call Trace:
> > > [ 2449.943915]  ? lock_release+0x1c3/0x290
> > > [ 2449.944135]  run_one_async_done+0x3a/0x60
> > > [ 2449.944360]  btrfs_work_helper+0x136/0x520
> > > [ 2449.944588]  process_one_work+0x26e/0x570
> > > [ 2449.944812]  worker_thread+0x55/0x3c0
> > > [ 2449.945016]  ? process_one_work+0x570/0x570
> > > [ 2449.945250]  kthread+0x137/0x150
> > > [ 2449.945430]  ? __kthread_bind_mask+0x60/0x60
> > > [ 2449.945666]  ret_from_fork+0x1f/0x30
> > > 
> > > it happens when you run btrfs/060.  Please make sure to run xfstests against
> > > patches before you submit them upstream.  Thanks,
> > > 
> > > Josef
> > 
> > Umm... I ran the xftests against v1 patch and didn't get that panic.
> 
> It could have been caused by my fixups to v2 and I can reproduce the
> crash now too. I can't see any difference besides the u64/int switch and
> the 'goto out' removal in btrfs_bio_fits_in_stripe.

I was able to fix the issue by the following diff. I will send it as the
patch after confirming that all fstests are passing.

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1a160db01878..04cd95899ac8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7975,21 +7975,21 @@ static blk_qc_t btrfs_submit_direct(struct inode
*inode, struct iomap *iomap,
        }
 
        start_sector = dio_bio->bi_iter.bi_sector;
-       logical = start_sector << 9;
        submit_len = dio_bio->bi_iter.bi_size;
 
        do {
+               logical = start_sector << 9;
                em = btrfs_get_chunk_map(fs_info, logical, submit_len);
                if (IS_ERR(em)) {
                        status = errno_to_blk_status(PTR_ERR(em));
                        em = NULL;
-                       goto out_err;
+                       goto out_err_em;
                }
                ret = btrfs_get_io_geometry(fs_info, em,
btrfs_op(dio_bio),
                                            logical, submit_len, &geom);
                if (ret) {
                        status = errno_to_blk_status(ret);
-                       goto out_err;
+                       goto out_err_em;
                }
                ASSERT(geom.len <= INT_MAX);
 
@@ -8034,7 +8034,7 @@ static blk_qc_t btrfs_submit_direct(struct inode
*inode, struct iomap *iomap,
                        bio_put(bio);
                        if (submit_len > 0)
                                refcount_dec(&dip->refs);
-                       goto out_err;
+                       goto out_err_em;
                }
 
                dio_data->submitted += clone_len;
@@ -8046,10 +8046,11 @@ static blk_qc_t btrfs_submit_direct(struct inode
*inode, struct iomap *iomap,
        } while (submit_len > 0);
        return BLK_QC_T_NONE;
 
+out_err_em:
+       free_extent_map(em);
 out_err:
        dip->dio_bio->bi_status = status;
        btrfs_dio_private_put(dip);
-       free_extent_map(em);
 
        return BLK_QC_T_NONE;
 }
