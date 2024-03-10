Return-Path: <linux-btrfs+bounces-3157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D766877785
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595D81F21BD7
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DB383BE;
	Sun, 10 Mar 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVKjjnEl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D9374C3
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710085674; cv=none; b=fvgV0YyCpp5lQsIxoNJ/PqATGnTdgCOx6fKHmGLIwUxOWXUoHAH+YkIqgKDTARkqpIUbEs6KppFG1W0tPj8PGwcC2/7LssLJqVlAtMxV2O06A/dD8MNIgkevZMmO9Y0O4Y4gTORLL35wq4DVRVPUqXm0QCAf9zB1jCxkXPlQWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710085674; c=relaxed/simple;
	bh=WGcYheCrkSFjv2fImGb0si1xdLZF/9H6Qe/RzGeZA+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqnFVQ68o4K0Novs+xInYyxKPNz/4pjM3GradBBCIXHSSmgt8+/LgfQHjTbd5ANINjxZsA6w4WZyHa1g9Tyrn6+u49ncCmEqVPVKlzOyXaZztTwLLLdbH9UjzrHBr26hn3JeQCKPHnHP0tpUpMYeMU8SC3iFnF/Mfqp08lnK3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVKjjnEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710085671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pr0jCGIrdUrAXoqQBPxPwh4IjonnOl4otme9lP7zJ4=;
	b=UVKjjnElTTKWcmPIOshsOvWVHklW/OkP9GzSZMSIGyn71YxLZsHpM/ReXzA5QdW3Lbvsds
	k1IMsMVQH0SkOvzaX1lcyzWOoN0JU9ZmBaJ7ThMR2DS3fBxs0R1xYn0LMUn98tqOvxx6OP
	cHSoydzHePAJT/A9+i/Pq7uYQORzD80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-SQXBM1lkMsmpAfNC4utWFg-1; Sun, 10 Mar 2024 11:47:43 -0400
X-MC-Unique: SQXBM1lkMsmpAfNC4utWFg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 083A5800264;
	Sun, 10 Mar 2024 15:47:43 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DEBB7C478A1;
	Sun, 10 Mar 2024 15:47:36 +0000 (UTC)
Date: Sun, 10 Mar 2024 23:47:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Patrick Plenefisch <simonpatp@gmail.com>,
	Goffredo Baroncelli <kreijack@inwind.it>,
	linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	regressions@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>
Subject: Re: LVM-on-LVM: error while submitting device barriers
Message-ID: <Ze3WFGE0je3FivlL@fedora>
References: <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
 <ZedaKUge-EBo4CuT@redhat.com>
 <ZeiS/bjJaRcrerWW@fedora>
 <CAOCpoWeoQMh_-MxzxGBnK2Kf5EhvTLs=GrGwJ5XcfGVRTp73Eg@mail.gmail.com>
 <Ze2azGlb1WxVFv7Z@fedora>
 <Ze3RWqLvG18cQ4dz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze3RWqLvG18cQ4dz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Sun, Mar 10, 2024 at 11:27:22AM -0400, Mike Snitzer wrote:
> On Sun, Mar 10 2024 at  7:34P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Sat, Mar 09, 2024 at 03:39:02PM -0500, Patrick Plenefisch wrote:
> > > On Wed, Mar 6, 2024 at 11:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > >
> > > > On Tue, Mar 05, 2024 at 12:45:13PM -0500, Mike Snitzer wrote:
> > > > > On Thu, Feb 29 2024 at  5:05P -0500,
> > > > > Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > > >
> > > > > > On 29/02/2024 21.22, Patrick Plenefisch wrote:
> > > > > > > On Thu, Feb 29, 2024 at 2:56 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > > > > > >
> > > > > > > > > Your understanding is correct. The only thing that comes to my mind to
> > > > > > > > > cause the problem is asymmetry of the SATA devices. I have one 8TB
> > > > > > > > > device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> > > > > > > > > extents, lowerVG/single spans (3TB+3TB), and
> > > > > > > > > lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> > > > > > > > > the other leg of raid1 on the 8TB drive, but my thought was that the
> > > > > > > > > jump across the 1.5+3TB drive gap was at least "interesting"
> > > > > > > >
> > > > > > > >
> > > > > > > > what about lowerVG/works ?
> > > > > > > >
> > > > > > >
> > > > > > > That one is only on two disks, it doesn't span any gaps
> > > > > >
> > > > > > Sorry, but re-reading the original email I found something that I missed before:
> > > > > >
> > > > > > > BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> > > > > > > 0, rd 0, flush 1, corrupt 0, gen 0
> > > > > > > BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> > > > > >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > > tolerance is 0 for writable mount
> > > > > > > BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> > > > > > > failure (errors while submitting device barriers.)
> > > > > >
> > > > > > Looking at the code, it seems that if a FLUSH commands fails, btrfs
> > > > > > considers that the disk is missing. The it cannot mount RW the device.
> > > > > >
> > > > > > I would investigate with the LVM developers, if it properly passes
> > > > > > the flush/barrier command through all the layers, when we have an
> > > > > > lvm over lvm (raid1). The fact that the lvm is a raid1, is important because
> > > > > > a flush command to be honored has to be honored by all the
> > > > > > devices involved.
> > > >
> > > > Hello Patrick & Goffredo,
> > > >
> > > > I can trigger this kind of btrfs complaint by simulating one FLUSH failure.
> > > >
> > > > If you can reproduce this issue easily, please collect log by the
> > > > following bpftrace script, which may show where the flush failure is,
> > > > and maybe it can help to narrow down the issue in the whole stack.
> > > >
> > > >
> > > > #!/usr/bin/bpftrace
> > > >
> > > > #ifndef BPFTRACE_HAVE_BTF
> > > > #include <linux/blkdev.h>
> > > > #endif
> > > >
> > > > kprobe:submit_bio_noacct,
> > > > kprobe:submit_bio
> > > > / (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) != 0 /
> > > > {
> > > >         $bio = (struct bio *)arg0;
> > > >         @submit_stack[arg0] = kstack;
> > > >         @tracked[arg0] = 1;
> > > > }
> > > >
> > > > kprobe:bio_endio
> > > > /@tracked[arg0] != 0/
> > > > {
> > > >         $bio = (struct bio *)arg0;
> > > >
> > > >         if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_remaining.counter > 1) {
> > > >                 return;
> > > >         }
> > > >
> > > >         if ($bio->bi_status != 0) {
> > > >                 printf("dev %s bio failed %d, submitter %s completion %s\n",
> > > >                         $bio->bi_bdev->bd_disk->disk_name,
> > > >                         $bio->bi_status, @submit_stack[arg0], kstack);
> > > >         }
> > > >         delete(@submit_stack[arg0]);
> > > >         delete(@tracked[arg0]);
> > > > }
> > > >
> > > > END {
> > > >         clear(@submit_stack);
> > > >         clear(@tracked);
> > > > }
> > > >
> > > 
> > > Attaching 4 probes...
> > > dev dm-77 bio failed 10, submitter
> > >        submit_bio_noacct+5
> > >        __send_duplicate_bios+358
> > >        __send_empty_flush+179
> > >        dm_submit_bio+857
> > >        __submit_bio+132
> > >        submit_bio_noacct_nocheck+345
> > >        write_all_supers+1718
> > >        btrfs_commit_transaction+2342
> > >        transaction_kthread+345
> > >        kthread+229
> > >        ret_from_fork+49
> > >        ret_from_fork_asm+27
> > > completion
> > >        bio_endio+5
> > >        dm_submit_bio+955
> > >        __submit_bio+132
> > >        submit_bio_noacct_nocheck+345
> > >        write_all_supers+1718
> > >        btrfs_commit_transaction+2342
> > >        transaction_kthread+345
> > >        kthread+229
> > >        ret_from_fork+49
> > >        ret_from_fork_asm+27
> > > 
> > > dev dm-86 bio failed 10, submitter
> > >        submit_bio_noacct+5
> > >        write_all_supers+1718
> > >        btrfs_commit_transaction+2342
> > >        transaction_kthread+345
> > >        kthread+229
> > >        ret_from_fork+49
> > >        ret_from_fork_asm+27
> > > completion
> > >        bio_endio+5
> > >        clone_endio+295
> > >        clone_endio+295
> > >        process_one_work+369
> > >        worker_thread+635
> > >        kthread+229
> > >        ret_from_fork+49
> > >        ret_from_fork_asm+27
> > > 
> > > 
> > > For context, dm-86 is /dev/lvm/brokenDisk and dm-77 is /dev/lowerVG/lvmPool
> > 
> > io_status is 10(BLK_STS_IOERR), which is produced in submission code path on
> > /dev/dm-77(/dev/lowerVG/lvmPool) first, so looks it is one device mapper issue.
> > 
> > The error should be from the following code only:
> > 
> > static void __map_bio(struct bio *clone)
> > 
> > 	...
> > 	if (r == DM_MAPIO_KILL)
> > 		dm_io_dec_pending(io, BLK_STS_IOERR);
> > 	else
> > 		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
> >     break;
> 
> I agree that the above bpf stack traces for dm-77 indicate that
> dm_submit_bio failed, which would end up in the above branch if the
> target's ->map() returned DM_MAPIO_KILL or DM_MAPIO_REQUEUE.
> 
> But such an early failure speaks to the flush bio never being
> submitted to the underlying storage. No?
> 
> dm-raid.c:raid_map does return DM_MAPIO_REQUEUE with:
> 
>         /*
>          * If we're reshaping to add disk(s)), ti->len and
>          * mddev->array_sectors will differ during the process
>          * (ti->len > mddev->array_sectors), so we have to requeue
>          * bios with addresses > mddev->array_sectors here or
>          * there will occur accesses past EOD of the component
>          * data images thus erroring the raid set.
>          */
>         if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
>                 return DM_MAPIO_REQUEUE;
> 
> But a flush doesn't have an end_sector (it'd be 0 afaik).. so it seems
> weird relative to a flush.

Yeah, I also found the above is weird, since DM_MAPIO_REQUEUE is
supposed to work together only with noflush_suspend, see
2e93ccc1933d ("[PATCH] dm: suspend: add noflush pushback"), looks
you already mentioned.

If that is the reason, maybe the following change can make a
difference:

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5e41fbae3f6b..07af18baa8dd 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3331,7 +3331,7 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	 * there will occur accesses past EOD of the component
 	 * data images thus erroring the raid set.
 	 */
-	if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
+	if (unlikely(bio_has_data(bio) && bio_end_sector(bio) > mddev->array_sectors))
 		return DM_MAPIO_REQUEUE;
 
 	md_handle_request(mddev, bio);


> 
> > Patrick, you mentioned lvmPool is raid1, can you explain how lvmPool is
> > built? It is dm-raid1 target or over plain raid1 device which is
> > build over /dev/lowerVG?
> 
> In my earlier reply I asked Patrick for both:
> lsblk
> dmsetup table
> 
> Picking over the described IO stacks provided earlier (or Goffredo's
> interpretation of it, via ascii art) isn't really a great way to see
> the IO stacks that are in use/question.
> 
> > Mike, the logic in the following code doesn't change from v5.18-rc2 to
> > v5.19, but I still can't understand why STS_IOERR is set in
> > dm_io_complete() in case of BLK_STS_DM_REQUEUE && !__noflush_suspending(),
> > since DMF_NOFLUSH_SUSPENDING is only set in __dm_suspend() which
> > is supposed to not happen in Patrick's case.
> > 
> > dm_io_complete()
> > 	...
> > 	if (io->status == BLK_STS_DM_REQUEUE) {
> > 	        unsigned long flags;
> > 	        /*
> > 	         * Target requested pushing back the I/O.
> > 	         */
> > 	        spin_lock_irqsave(&md->deferred_lock, flags);
> > 	        if (__noflush_suspending(md) &&
> > 	            !WARN_ON_ONCE(dm_is_zone_write(md, bio))) {
> > 	                /* NOTE early return due to BLK_STS_DM_REQUEUE below */
> > 	                bio_list_add_head(&md->deferred, bio);
> > 	        } else {
> > 	                /*
> > 	                 * noflush suspend was interrupted or this is
> > 	                 * a write to a zoned target.
> > 	                 */
> > 	                io->status = BLK_STS_IOERR;
> > 	        }
> > 	        spin_unlock_irqrestore(&md->deferred_lock, flags);
> > 	}
> 
> Given the reason from dm-raid.c:raid_map returning DM_MAPIO_REQUEUE
> I think the DM device could be suspending without flush.
> 
> But regardless, given you logged BLK_STS_IOERR lets assume it isn't,
> the assumption that "noflush suspend was interrupted" seems like a
> stale comment -- especially given that target's like dm-raid are now
> using DM_MAPIO_REQUEUE without concern for the historic tight-coupling
> of noflush suspend (which was always the case for the biggest historic
> reason for this code: dm-multipath, see commit 2e93ccc1933d0 from
> 2006 -- predates my time with developing DM).
> 
> So all said, this code seems flawed for dm-raid (and possibly other
> targets that return DM_MAPIO_REQUEUE).  I'll look closer this week.

Agree, the change is added since 9dbd1aa3a81c ("dm raid: add reshaping
support to the target"), so loop Heinz in.


Thanks,
Ming


