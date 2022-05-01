Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904F751619B
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 06:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiEAEnn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 00:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiEAEnm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 00:43:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6BF0E
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 21:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651380012;
        bh=FUEcqfOZpFi1pYbVfxb1mQgRO+OYWjycOAXTqbymnK8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QXHPFiIwkGapk4xbTcdyV27f9q8sTp/jGRW4LlP5n7PgdjMsxCg60/tMWpY/vnpV2
         FB3spM92ym7ouXET+t02daAVpBScgTtE6DXIgEL0qw9ot2QY7D5w87YCgPohFnpjYa
         tZ9V0/W/Mli4kqbBfbn6xW09566v21k3F/GmSW8o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1na30d0iIS-00B6Dd; Sun, 01
 May 2022 06:40:11 +0200
Message-ID: <4e93a857-43f2-9e67-9ef8-4db00edd2f6c@gmx.com>
Date:   Sun, 1 May 2022 12:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 05/10] btrfs: defer I/O completion based on the
 btrfs_raid_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220429143040.106889-1-hch@lst.de>
 <20220429143040.106889-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220429143040.106889-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Va+nkR0NtG4WlXeQgaTdJqeERrwTF4rg6IbUWi+jIFn022SgqR
 RU0exh24uNjqrgkh/uMA0stpkzRHBSZU3FmGTf0MhCNJtKnatwSieAqxhp0ltTk4Znat3if
 PXnBKB5PCVEmLdGpU+97tx9Uj7B1JL8/A8VC+bZZ0S2ILkWBsnPR7/yL6Ve2Ik/HAgPGqsc
 0hBX9qIrY0jlmRtNtnD2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nj02VzeFq0U=:YlnL2U/qCyOxyjCqRj8L8n
 8ZOowJEHwfg8RjFiCZGbf9lGT6dCe3+zTaLUpCoZa04tUIxftBIuSu3hs87P+z+8cHTrlV/2h
 Dn5nYCtC5Bi6rkThI8D6SyZB8uYs3MVVltS8fAm4lcf7Q/e6agU2MlgjF/IjULJvAK0u0QkNj
 d6v72Ngp+LdZXjJ0y4uphW0scL+nUum2a6CRVasTsQhWCQbQJIBw9k3CYeOFbr5IufI0M/CHS
 wjd2M8gsOmhii2uQQSY1qP51EvdXaWshHZb3Dlck8ypaCPfUo81Cfa6KXZ7J+vpnm0DXxuHEw
 gN6UUjF2uxpBkH54r/O78kH3VPfdSmcdVMK+3K421rxcwlc/CIKhZXpRl4k7KXOGPA9MjGS/7
 G5LdbASE53J0J0edX3B61Wl3rzWP5nXwgXoiED6y/dyA8FdHOin6tMt6LLR5Q6YWfkiDCcY/X
 WteuQr6tF7C9x50sDIKJDnLj52BGnjEzj/DhGsS1GE1ed6TCvpGSnrrVn0ODc5kZJ5bysr6BL
 nD9ez26E5r2pVb/RFpMRhUdvPbynrOSZS9DWMF1Bn1jHzs2NmOTlcTv45Joc39DED+aRHZtHW
 Acimy4ezgMElyEWPVWgaqjY4Xt2KhJHNkwdpUX7X9pHFTjBmtR17r3zTLkmriQ7H4wGhaHD7O
 JD8hnzLNs95vEXgZdpmhQHBH7+MX5smVXNKLTOYR5ClX7dNc0g2ksaw51eqvnzInwGh52bviJ
 PKn+LGufe7urnYjcs5eoOjvbpfdEyy4QIBqrQnc/rvUtKXN2dkIGW7zJmKcGrjYAVflRRHRxH
 aWRH5HRkRSDUUkxHIp+lCIMhol/0XhvOrVNDUJIHo+otmE8Hf4NiFuSIYNJ6iU/K7QS929DoL
 hLEOcXCPt9nIvK9qs9axsWjX7Lnr4WYShMI8hn6nNz61i3qxPSbPy1F/iRx0rGxiOs1jP5W1F
 MCBVH6obgCenHzMsGdb8PLc2WwSz2k+WiDyzcsdhSYyBp9+atguzb1mCbbGwA6pqj7eQo/Ywu
 poi0UNH+qMmAyOzOYsEJ4pH9W1hzoA3ArO8dei9l3qokyh8Maz0aOOHShVncHwkdV8el+hZ6o
 +gkic9IvP++ido=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 22:30, Christoph Hellwig wrote:
> Instead of attaching a an extra allocation an indirect call to each
> low-level bio issued by the RAID code, add a work_struct to struct
> btrfs_raid_bio and only defer the per-rbio completion action.  The
> per-bio action for all the I/Os are trivial and can be safely done
> from interrupt context.
>
> As a nice side effect this also allows sharing the boilerplate code
> for the per-bio completions
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It looks like this patch is causing test failure in btrfs/027, at least
for subapge (64K page size, 4K sectorsize) cases.

Reproducibility is 100% (4/4 tried).

The hanging sub-test case is the repalcing of a missing device in raid5.

The involved dmesg (including the hanging thread dump) is:

[  276.672541] BTRFS warning (device dm-1): read-write for sector size
4096 with page size 65536 is experimental
[  276.744316] BTRFS info (device dm-1): checking UUID tree
[  277.387701] BTRFS info (device dm-1): allowing degraded mounts
[  277.390314] BTRFS info (device dm-1): using free space tree
[  277.392108] BTRFS info (device dm-1): has skinny extents
[  277.393890] BTRFS warning (device dm-1): read-write for sector size
4096 with page size 65536 is experimental
[  277.420922] BTRFS warning (device dm-1): devid 2 uuid
4b67464d-e851-4a88-8765-67b043d4680f is missing
[  277.432694] BTRFS warning (device dm-1): devid 2 uuid
4b67464d-e851-4a88-8765-67b043d4680f is missing
[  277.648326] BTRFS info (device dm-1): dev_replace from <missing disk>
(devid 2) to /dev/mapper/test-scratch5 started
[  297.264371] task:btrfs           state:D stack:    0 pid: 7158 ppid:
  6493 flags:0x0000000c
[  297.280744] Call trace:
[  297.282351]  __switch_to+0xfc/0x160
[  297.284525]  __schedule+0x260/0x61c
[  297.286959]  schedule+0x54/0xc4
[  297.288980]  scrub_enumerate_chunks+0x610/0x760 [btrfs]
[  297.292504]  btrfs_scrub_dev+0x1a0/0x530 [btrfs]
[  297.306738]  btrfs_dev_replace_start+0x2a4/0x2d0 [btrfs]
[  297.310418]  btrfs_dev_replace_by_ioctl+0x48/0x84 [btrfs]
[  297.314026]  btrfs_ioctl_dev_replace+0x1b8/0x210 [btrfs]
[  297.328014]  btrfs_ioctl+0xa48/0x1a70 [btrfs]
[  297.330705]  __arm64_sys_ioctl+0xb4/0x100
[  297.333037]  invoke_syscall+0x50/0x120
[  297.343237]  el0_svc_common.constprop.0+0x4c/0x100
[  297.345716]  do_el0_svc+0x34/0xa0
[  297.347242]  el0_svc+0x34/0xb0
[  297.348763]  el0t_64_sync_handler+0xa8/0x130
[  297.350870]  el0t_64_sync+0x18c/0x190

Mind to take a look on that hang?

Thanks,
Qu

> ---
>   fs/btrfs/ctree.h   |   2 +-
>   fs/btrfs/disk-io.c |  12 ++---
>   fs/btrfs/disk-io.h |   1 -
>   fs/btrfs/raid56.c  | 111 ++++++++++++++++++---------------------------
>   4 files changed, 49 insertions(+), 77 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 40a6f61559348..4dd0d4a2e7757 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -853,7 +853,7 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *flush_workers;
>   	struct btrfs_workqueue *endio_workers;
>   	struct btrfs_workqueue *endio_meta_workers;
> -	struct btrfs_workqueue *endio_raid56_workers;
> +	struct workqueue_struct *endio_raid56_workers;
>   	struct workqueue_struct *rmw_workers;
>   	struct btrfs_workqueue *endio_meta_write_workers;
>   	struct btrfs_workqueue *endio_write_workers;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 73e12ecc81be1..3c6137734d28c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -753,14 +753,10 @@ static void end_workqueue_bio(struct bio *bio)
>   			wq =3D fs_info->endio_meta_write_workers;
>   		else if (end_io_wq->metadata =3D=3D BTRFS_WQ_ENDIO_FREE_SPACE)
>   			wq =3D fs_info->endio_freespace_worker;
> -		else if (end_io_wq->metadata =3D=3D BTRFS_WQ_ENDIO_RAID56)
> -			wq =3D fs_info->endio_raid56_workers;
>   		else
>   			wq =3D fs_info->endio_write_workers;
>   	} else {
> -		if (end_io_wq->metadata =3D=3D BTRFS_WQ_ENDIO_RAID56)
> -			wq =3D fs_info->endio_raid56_workers;
> -		else if (end_io_wq->metadata)
> +		if (end_io_wq->metadata)
>   			wq =3D fs_info->endio_meta_workers;
>   		else
>   			wq =3D fs_info->endio_workers;
> @@ -2274,7 +2270,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs=
_info *fs_info)
>   	btrfs_destroy_workqueue(fs_info->hipri_workers);
>   	btrfs_destroy_workqueue(fs_info->workers);
>   	btrfs_destroy_workqueue(fs_info->endio_workers);
> -	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
> +	if (fs_info->endio_raid56_workers)
> +		destroy_workqueue(fs_info->endio_raid56_workers);
>   	if (fs_info->rmw_workers)
>   		destroy_workqueue(fs_info->rmw_workers);
>   	btrfs_destroy_workqueue(fs_info->endio_write_workers);
> @@ -2477,8 +2474,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_i=
nfo *fs_info)
>   		btrfs_alloc_workqueue(fs_info, "endio-meta-write", flags,
>   				      max_active, 2);
>   	fs_info->endio_raid56_workers =3D
> -		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
> -				      max_active, 4);
> +		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
>   	fs_info->rmw_workers =3D alloc_workqueue("btrfs-rmw", flags, max_acti=
ve);
>   	fs_info->endio_write_workers =3D
>   		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 9340e3266e0ac..97255e3d7e524 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -21,7 +21,6 @@ enum btrfs_wq_endio_type {
>   	BTRFS_WQ_ENDIO_DATA,
>   	BTRFS_WQ_ENDIO_METADATA,
>   	BTRFS_WQ_ENDIO_FREE_SPACE,
> -	BTRFS_WQ_ENDIO_RAID56,
>   };
>
>   static inline u64 btrfs_sb_offset(int mirror)
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index a5b623ee6facd..1a3c1a9b10d0b 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -164,6 +164,9 @@ struct btrfs_raid_bio {
>   	atomic_t stripes_pending;
>
>   	atomic_t error;
> +
> +	struct work_struct end_io_work;
> +
>   	/*
>   	 * these are two arrays of pointers.  We allocate the
>   	 * rbio big enough to hold them both and setup their
> @@ -1552,15 +1555,7 @@ static void set_bio_pages_uptodate(struct btrfs_r=
aid_bio *rbio, struct bio *bio)
>   	}
>   }
>
> -/*
> - * end io for the read phase of the rmw cycle.  All the bios here are p=
hysical
> - * stripe bios we've read from the disk so we can recalculate the parit=
y of the
> - * stripe.
> - *
> - * This will usually kick off finish_rmw once all the bios are read in,=
 but it
> - * may trigger parity reconstruction if we had any errors along the way
> - */
> -static void raid_rmw_end_io(struct bio *bio)
> +static void raid56_bio_end_io(struct bio *bio)
>   {
>   	struct btrfs_raid_bio *rbio =3D bio->bi_private;
>
> @@ -1571,23 +1566,34 @@ static void raid_rmw_end_io(struct bio *bio)
>
>   	bio_put(bio);
>
> -	if (!atomic_dec_and_test(&rbio->stripes_pending))
> -		return;
> +	if (atomic_dec_and_test(&rbio->stripes_pending))
> +		queue_work(rbio->bioc->fs_info->endio_raid56_workers,
> +			   &rbio->end_io_work);
> +}
>
> -	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
> -		goto cleanup;
> +/*
> + * End io handler for the read phase of the rmw cycle.  All the bios he=
re are
> + * physical stripe bios we've read from the disk so we can recalculate =
the
> + * parity of the stripe.
> + *
> + * This will usually kick off finish_rmw once all the bios are read in,=
 but it
> + * may trigger parity reconstruction if we had any errors along the way
> + */
> +static void raid56_rmw_end_io_work(struct work_struct *work)
> +{
> +	struct btrfs_raid_bio *rbio =3D
> +		container_of(work, struct btrfs_raid_bio, end_io_work);
> +
> +	if (atomic_read(&rbio->error) > rbio->bioc->max_errors) {
> +		rbio_orig_end_io(rbio, BLK_STS_IOERR);
> +		return;
> +	}
>
>   	/*
> -	 * this will normally call finish_rmw to start our write
> -	 * but if there are any failed stripes we'll reconstruct
> -	 * from parity first
> +	 * This will normally call finish_rmw to start our write but if there
> +	 * are any failed stripes we'll reconstruct from parity first.
>   	 */
>   	validate_rbio_for_rmw(rbio);
> -	return;
> -
> -cleanup:
> -
> -	rbio_orig_end_io(rbio, BLK_STS_IOERR);
>   }
>
>   /*
> @@ -1662,11 +1668,9 @@ static int raid56_rmw_stripe(struct btrfs_raid_bi=
o *rbio)
>   	 * touch it after that.
>   	 */
>   	atomic_set(&rbio->stripes_pending, bios_to_read);
> +	INIT_WORK(&rbio->end_io_work, raid56_rmw_end_io_work);
>   	while ((bio =3D bio_list_pop(&bio_list))) {
> -		bio->bi_end_io =3D raid_rmw_end_io;
> -
> -		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
> -
> +		bio->bi_end_io =3D raid56_bio_end_io;
>   		submit_bio(bio);
>   	}
>   	/* the actual write will happen once the reads are done */
> @@ -2108,25 +2112,13 @@ static void __raid_recover_end_io(struct btrfs_r=
aid_bio *rbio)
>   }
>
>   /*
> - * This is called only for stripes we've read from disk to
> - * reconstruct the parity.
> + * This is called only for stripes we've read from disk to reconstruct =
the
> + * parity.
>    */
> -static void raid_recover_end_io(struct bio *bio)
> +static void raid_recover_end_io_work(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio =3D bio->bi_private;
> -
> -	/*
> -	 * we only read stripe pages off the disk, set them
> -	 * up to date if there were no errors
> -	 */
> -	if (bio->bi_status)
> -		fail_bio_stripe(rbio, bio);
> -	else
> -		set_bio_pages_uptodate(rbio, bio);
> -	bio_put(bio);
> -
> -	if (!atomic_dec_and_test(&rbio->stripes_pending))
> -		return;
> +	struct btrfs_raid_bio *rbio =3D
> +		container_of(work, struct btrfs_raid_bio, end_io_work);
>
>   	if (atomic_read(&rbio->error) > rbio->bioc->max_errors)
>   		rbio_orig_end_io(rbio, BLK_STS_IOERR);
> @@ -2209,11 +2201,9 @@ static int __raid56_parity_recover(struct btrfs_r=
aid_bio *rbio)
>   	 * touch it after that.
>   	 */
>   	atomic_set(&rbio->stripes_pending, bios_to_read);
> +	INIT_WORK(&rbio->end_io_work, raid_recover_end_io_work);
>   	while ((bio =3D bio_list_pop(&bio_list))) {
> -		bio->bi_end_io =3D raid_recover_end_io;
> -
> -		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
> -
> +		bio->bi_end_io =3D raid56_bio_end_io;
>   		submit_bio(bio);
>   	}
>
> @@ -2582,8 +2572,7 @@ static noinline void finish_parity_scrub(struct bt=
rfs_raid_bio *rbio,
>   	atomic_set(&rbio->stripes_pending, nr_data);
>
>   	while ((bio =3D bio_list_pop(&bio_list))) {
> -		bio->bi_end_io =3D raid_write_end_io;
> -
> +		bio->bi_end_io =3D raid56_bio_end_io;
>   		submit_bio(bio);
>   	}
>   	return;
> @@ -2671,24 +2660,14 @@ static void validate_rbio_for_parity_scrub(struc=
t btrfs_raid_bio *rbio)
>    * This will usually kick off finish_rmw once all the bios are read in=
, but it
>    * may trigger parity reconstruction if we had any errors along the wa=
y
>    */
> -static void raid56_parity_scrub_end_io(struct bio *bio)
> +static void raid56_parity_scrub_end_io_work(struct work_struct *work)
>   {
> -	struct btrfs_raid_bio *rbio =3D bio->bi_private;
> -
> -	if (bio->bi_status)
> -		fail_bio_stripe(rbio, bio);
> -	else
> -		set_bio_pages_uptodate(rbio, bio);
> -
> -	bio_put(bio);
> -
> -	if (!atomic_dec_and_test(&rbio->stripes_pending))
> -		return;
> +	struct btrfs_raid_bio *rbio =3D
> +		container_of(work, struct btrfs_raid_bio, end_io_work);
>
>   	/*
> -	 * this will normally call finish_rmw to start our write
> -	 * but if there are any failed stripes we'll reconstruct
> -	 * from parity first
> +	 * This will normally call finish_rmw to start our write, but if there
> +	 * are any failed stripes we'll reconstruct from parity first
>   	 */
>   	validate_rbio_for_parity_scrub(rbio);
>   }
> @@ -2758,11 +2737,9 @@ static void raid56_parity_scrub_stripe(struct btr=
fs_raid_bio *rbio)
>   	 * touch it after that.
>   	 */
>   	atomic_set(&rbio->stripes_pending, bios_to_read);
> +	INIT_WORK(&rbio->end_io_work, raid56_parity_scrub_end_io_work);
>   	while ((bio =3D bio_list_pop(&bio_list))) {
> -		bio->bi_end_io =3D raid56_parity_scrub_end_io;
> -
> -		btrfs_bio_wq_end_io(rbio->bioc->fs_info, bio, BTRFS_WQ_ENDIO_RAID56);
> -
> +		bio->bi_end_io =3D raid56_bio_end_io;
>   		submit_bio(bio);
>   	}
>   	/* the actual write will happen once the reads are done */
