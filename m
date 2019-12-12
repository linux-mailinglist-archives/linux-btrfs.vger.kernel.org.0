Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B911D0CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfLLPS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 10:18:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728944AbfLLPS4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 10:18:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4312AE0C;
        Thu, 12 Dec 2019 15:18:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EE98DA82A; Thu, 12 Dec 2019 16:18:53 +0100 (CET)
Date:   Thu, 12 Dec 2019 16:18:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: fix compressed write bio attribution
Message-ID: <20191212151853.GT3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
 <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 04:07:07PM -0800, Dennis Zhou wrote:
> Bio attribution is handled at bio_set_dev() as once we have a device, we
> have a corresponding request_queue and then can derive the current css.
> In special cases, we want to attribute to bio to someone else. This can
> be done by calling bio_associate_blkg_from_css(). Btrfs does this for
> compressed writeback as they are handled by kworkers which would be of
> the root cgroup rather than the cgroup designated by the wbc.
> 
> Commit 1a41802701ec ("btrfs: drop bio_set_dev where not needed") removes
> early bio_set_dev() calls prior to submit_stripe_bio(). This breaks the
> above assumption that we'll have a request_queue when we are doing
> association. To fix this, special case passing the bio through just for
> btrfs_submit_compressed_write().
> 
> Without this, we crash in btrfs/024:
> [ 3052.093088] BUG: kernel NULL pointer dereference, address: 0000000000000510
> [ 3052.107013] #PF: supervisor read access in kernel mode
> [ 3052.107014] #PF: error_code(0x0000) - not-present page
> [ 3052.107015] PGD 0 P4D 0
> [ 3052.107021] Oops: 0000 [#1] SMP
> [ 3052.138904] CPU: 42 PID: 201270 Comm: kworker/u161:0 Kdump: loaded Not tainted 5.5.0-rc1-00062-g4852d8ac90a9 #712
> [ 3052.138905] Hardware name: Quanta Tioga Pass Single Side 01-0032211004/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
> [ 3052.138912] Workqueue: btrfs-delalloc btrfs_work_helper
> [ 3052.191375] RIP: 0010:bio_associate_blkg_from_css+0x1e/0x3c0
> [ 3052.191377] Code: ff 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 49 89 fc 55 53 48 89 f3 48 83 ec 08 48 8b 47 08 65 ff 05 ea 6e 9f 7e <48> 8b a8 10 05 00 00 45 31 c9 45 31 c0 31 d2 31 f6 b9 02 00 00 00
> [ 3052.191379] RSP: 0018:ffffc900210cfc90 EFLAGS: 00010282
> [ 3052.191380] RAX: 0000000000000000 RBX: ffff88bfe5573c00 RCX: 0000000000000000
> [ 3052.191382] RDX: ffff889db48ec2f0 RSI: ffff88bfe5573c00 RDI: ffff889db48ec2f0
> [ 3052.191386] RBP: 0000000000000800 R08: 0000000000203bb0 R09: ffff889db16b2400
> [ 3052.293364] R10: 0000000000000000 R11: ffff88a07fffde80 R12: ffff889db48ec2f0
> [ 3052.293365] R13: 0000000000001000 R14: ffff889de82bc000 R15: ffff889e2b7bdcc8
> [ 3052.293367] FS:  0000000000000000(0000) GS:ffff889ffba00000(0000) knlGS:0000000000000000
> [ 3052.293368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3052.293369] CR2: 0000000000000510 CR3: 0000000002611001 CR4: 00000000007606e0
> [ 3052.293370] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 3052.293371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 3052.293372] PKRU: 55555554
> [ 3052.293376] Call Trace:
> [ 3052.402552]  btrfs_submit_compressed_write+0x137/0x390

Isn't it the same crash that Chris Murphy reported?

https://lore.kernel.org/linux-btrfs/CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com/

> [ 3052.402558]  submit_compressed_extents+0x40f/0x4c0
> [ 3052.422401]  btrfs_work_helper+0x246/0x5a0
> [ 3052.422408]  process_one_work+0x200/0x570
> [ 3052.438601]  ? process_one_work+0x180/0x570
> [ 3052.438605]  worker_thread+0x4c/0x3e0
> [ 3052.438614]  kthread+0x103/0x140
> [ 3052.460735]  ? process_one_work+0x570/0x570
> [ 3052.460737]  ? kthread_mod_delayed_work+0xc0/0xc0
> [ 3052.460744]  ret_from_fork+0x24/0x30
> 
> Fixes: 1a41802701ec ("btrfs: drop bio_set_dev where not needed")
> Cc: David Sterba <dsterba@suse.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/compression.c | 14 +++++---------
>  fs/btrfs/volumes.c     | 18 ++++++++++++++----
>  fs/btrfs/volumes.h     |  3 +++
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4ce81571f0cd..67d604fcb606 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -444,11 +444,9 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  	bio->bi_opf = REQ_OP_WRITE | write_flags;
>  	bio->bi_private = cb;
>  	bio->bi_end_io = end_compressed_bio_write;
> -
> -	if (blkcg_css) {
> +	if (blkcg_css)
>  		bio->bi_opf |= REQ_CGROUP_PUNT;
> -		bio_associate_blkg_from_css(bio, blkcg_css);
> -	}
> +
>  	refcount_set(&cb->pending_bios, 1);
>  
>  	/* create and submit bios for the compressed pages */
> @@ -481,7 +479,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  
> -			ret = btrfs_map_bio(fs_info, bio, 0);
> +			ret = __btrfs_map_bio(fs_info, bio, 0, blkcg_css);
>  			if (ret) {
>  				bio->bi_status = ret;
>  				bio_endio(bio);
> @@ -491,10 +489,8 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  			bio->bi_opf = REQ_OP_WRITE | write_flags;
>  			bio->bi_private = cb;
>  			bio->bi_end_io = end_compressed_bio_write;
> -			if (blkcg_css) {
> +			if (blkcg_css)
>  				bio->bi_opf |= REQ_CGROUP_PUNT;
> -				bio_associate_blkg_from_css(bio, blkcg_css);
> -			}
>  			bio_add_page(bio, page, PAGE_SIZE, 0);
>  		}
>  		if (bytes_left < PAGE_SIZE) {
> @@ -515,7 +511,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> -	ret = btrfs_map_bio(fs_info, bio, 0);
> +	ret = __btrfs_map_bio(fs_info, bio, 0, blkcg_css);
>  	if (ret) {
>  		bio->bi_status = ret;
>  		bio_endio(bio);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 66377e678504..c68d93a1aae8 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6240,7 +6240,8 @@ static void btrfs_end_bio(struct bio *bio)
>  }
>  
>  static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
> -			      u64 physical, int dev_nr)
> +			      u64 physical, int dev_nr,
> +			      struct cgroup_subsys_state *blkcg_css)
>  {
>  	struct btrfs_device *dev = bbio->stripes[dev_nr].dev;
>  	struct btrfs_fs_info *fs_info = bbio->fs_info;
> @@ -6255,6 +6256,8 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
>  		(u_long)dev->bdev->bd_dev, rcu_str_deref(dev->name), dev->devid,
>  		bio->bi_iter.bi_size);
>  	bio_set_dev(bio, dev->bdev);
> +	if (blkcg_css)
> +		bio_associate_blkg_from_css(bio, blkcg_css);

At this point we know the bdev is the correct one, but is the blkcg_css
different for each device or is there one for all?

Passing the blkcg_css is one way, one single point where the bio and css
are associated and probably the cleanest. I only don't like the need to
pass the blkcg_css around but that's probably not a big deal than to
forget to set bdev somewhere.
