Return-Path: <linux-btrfs+bounces-3156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61C87777A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BA728155A
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D03383A9;
	Sun, 10 Mar 2024 15:27:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9D037708
	for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710084447; cv=none; b=AXSXktaAu2QdNCH5NqXgLXBbZ7ad7wMOLHMNlNq46mzkdSDMqAkxAVyeSBsHLp/qHdS56i8NZHXveg4DZy4pGbGnL0jZcsM8k1Rt9z4VbewSJ9dRts4ILRU+sMNQg9OJBq1DoW94XQmUHnHjTaW2+nWK0+dwie62JfheEzW53ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710084447; c=relaxed/simple;
	bh=Rck4rwY08vZeNb1x+s931KSI5QX6vz9bgu+V5718KSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwgBqgcQyihDQkMZo8hwezfU/1xH6zIPMlzo4Kaa0OrkAt5XEBGvTpnzXUHttNe8OBaa5/QXykza4CZCS/9c/okOzDUyVdMAbHrBVEb0fxPvMlL48lQfK9ppOLeah96j49/vkwd+bZHYtw/kd6e7NaUJgm+KRe8IbggGJv+QmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a1f24cc010so382351eaf.1
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710084444; x=1710689244;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0jH7J8SOz0u+8/iaO3ej/C+SWNNjTuhnH0u4Q10V/4=;
        b=Xb+4zjVOzvzyr+Is4581GMD3ViIRtFWE56NpMIMWH5X7WwK2NCqKUzYc8PCxW+nkrV
         pQYTdPaaSCBwbnVCwO9wLyGOjTX3Q9VxbCF3iqFtzejv/mq4IeO/C4eWVRJJiL9uPGya
         7BjPbyjUkaTmrtoUCs49zKYu0UkiO4wfyAaGoAFBqE61Vk1oNXiC/HJZiMHtWHh8jb/T
         2E/xv5I0wLuoAyMx1WlYtBMOTRqHbvYe7s6UsqujEA5slA/zyWZjRFrVLBy+RVmh5kY1
         S1gV61dCl2694fuSSOS2sBYTmZ7UP1L/zNojunaZoSAJ7qrPvnf87HnLSBSg2+ZO2+rS
         77XA==
X-Forwarded-Encrypted: i=1; AJvYcCXwzLhui0aOOoBKLgCHHJHegtJD8AZOVUUdSwSwtZlE8EzGGD7GQJ2RRozmb43SZH6WJOzngcCk/mfN1gdW8HSIZ+/PzFY513QO9zo=
X-Gm-Message-State: AOJu0YzveNy6JdEIfMUUjx1QEBVONvnKlID09otEQisPQA+oOkn/mM+L
	LL09IGSjta0pO3rZXvhIjLQ5Rp6FHqYDHWZeHw41m6BIGodMgjfrTr5Ai5r2pg==
X-Google-Smtp-Source: AGHT+IGYUkq3gxg50FkSC4WUlF8CNyihxMgMs26xBOhvmMCLc0J5UkBi4OAXO1/ieDvaAV4027kADg==
X-Received: by 2002:a05:6358:5f14:b0:17b:583c:c4b7 with SMTP id y20-20020a0563585f1400b0017b583cc4b7mr6033787rwn.3.1710084444218;
        Sun, 10 Mar 2024 08:27:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id b5-20020ac844c5000000b0042c61b99f42sm1905588qto.46.2024.03.10.08.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 08:27:23 -0700 (PDT)
Date: Sun, 10 Mar 2024 11:27:22 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Patrick Plenefisch <simonpatp@gmail.com>,
	Goffredo Baroncelli <kreijack@inwind.it>,
	linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	regressions@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org
Subject: Re: LVM-on-LVM: error while submitting device barriers
Message-ID: <Ze3RWqLvG18cQ4dz@redhat.com>
References: <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it>
 <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
 <ZedaKUge-EBo4CuT@redhat.com>
 <ZeiS/bjJaRcrerWW@fedora>
 <CAOCpoWeoQMh_-MxzxGBnK2Kf5EhvTLs=GrGwJ5XcfGVRTp73Eg@mail.gmail.com>
 <Ze2azGlb1WxVFv7Z@fedora>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze2azGlb1WxVFv7Z@fedora>

On Sun, Mar 10 2024 at  7:34P -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> On Sat, Mar 09, 2024 at 03:39:02PM -0500, Patrick Plenefisch wrote:
> > On Wed, Mar 6, 2024 at 11:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Mar 05, 2024 at 12:45:13PM -0500, Mike Snitzer wrote:
> > > > On Thu, Feb 29 2024 at  5:05P -0500,
> > > > Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > >
> > > > > On 29/02/2024 21.22, Patrick Plenefisch wrote:
> > > > > > On Thu, Feb 29, 2024 at 2:56 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> > > > > > >
> > > > > > > > Your understanding is correct. The only thing that comes to my mind to
> > > > > > > > cause the problem is asymmetry of the SATA devices. I have one 8TB
> > > > > > > > device, plus a 1.5TB, 3TB, and 3TB drives. Doing math on the actual
> > > > > > > > extents, lowerVG/single spans (3TB+3TB), and
> > > > > > > > lowerVG/lvmPool/lvm/brokenDisk spans (3TB+1.5TB). Both obviously have
> > > > > > > > the other leg of raid1 on the 8TB drive, but my thought was that the
> > > > > > > > jump across the 1.5+3TB drive gap was at least "interesting"
> > > > > > >
> > > > > > >
> > > > > > > what about lowerVG/works ?
> > > > > > >
> > > > > >
> > > > > > That one is only on two disks, it doesn't span any gaps
> > > > >
> > > > > Sorry, but re-reading the original email I found something that I missed before:
> > > > >
> > > > > > BTRFS error (device dm-75): bdev /dev/mapper/lvm-brokenDisk errs: wr
> > > > > > 0, rd 0, flush 1, corrupt 0, gen 0
> > > > > > BTRFS warning (device dm-75): chunk 13631488 missing 1 devices, max
> > > > >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > tolerance is 0 for writable mount
> > > > > > BTRFS: error (device dm-75) in write_all_supers:4379: errno=-5 IO
> > > > > > failure (errors while submitting device barriers.)
> > > > >
> > > > > Looking at the code, it seems that if a FLUSH commands fails, btrfs
> > > > > considers that the disk is missing. The it cannot mount RW the device.
> > > > >
> > > > > I would investigate with the LVM developers, if it properly passes
> > > > > the flush/barrier command through all the layers, when we have an
> > > > > lvm over lvm (raid1). The fact that the lvm is a raid1, is important because
> > > > > a flush command to be honored has to be honored by all the
> > > > > devices involved.
> > >
> > > Hello Patrick & Goffredo,
> > >
> > > I can trigger this kind of btrfs complaint by simulating one FLUSH failure.
> > >
> > > If you can reproduce this issue easily, please collect log by the
> > > following bpftrace script, which may show where the flush failure is,
> > > and maybe it can help to narrow down the issue in the whole stack.
> > >
> > >
> > > #!/usr/bin/bpftrace
> > >
> > > #ifndef BPFTRACE_HAVE_BTF
> > > #include <linux/blkdev.h>
> > > #endif
> > >
> > > kprobe:submit_bio_noacct,
> > > kprobe:submit_bio
> > > / (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) != 0 /
> > > {
> > >         $bio = (struct bio *)arg0;
> > >         @submit_stack[arg0] = kstack;
> > >         @tracked[arg0] = 1;
> > > }
> > >
> > > kprobe:bio_endio
> > > /@tracked[arg0] != 0/
> > > {
> > >         $bio = (struct bio *)arg0;
> > >
> > >         if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_remaining.counter > 1) {
> > >                 return;
> > >         }
> > >
> > >         if ($bio->bi_status != 0) {
> > >                 printf("dev %s bio failed %d, submitter %s completion %s\n",
> > >                         $bio->bi_bdev->bd_disk->disk_name,
> > >                         $bio->bi_status, @submit_stack[arg0], kstack);
> > >         }
> > >         delete(@submit_stack[arg0]);
> > >         delete(@tracked[arg0]);
> > > }
> > >
> > > END {
> > >         clear(@submit_stack);
> > >         clear(@tracked);
> > > }
> > >
> > 
> > Attaching 4 probes...
> > dev dm-77 bio failed 10, submitter
> >        submit_bio_noacct+5
> >        __send_duplicate_bios+358
> >        __send_empty_flush+179
> >        dm_submit_bio+857
> >        __submit_bio+132
> >        submit_bio_noacct_nocheck+345
> >        write_all_supers+1718
> >        btrfs_commit_transaction+2342
> >        transaction_kthread+345
> >        kthread+229
> >        ret_from_fork+49
> >        ret_from_fork_asm+27
> > completion
> >        bio_endio+5
> >        dm_submit_bio+955
> >        __submit_bio+132
> >        submit_bio_noacct_nocheck+345
> >        write_all_supers+1718
> >        btrfs_commit_transaction+2342
> >        transaction_kthread+345
> >        kthread+229
> >        ret_from_fork+49
> >        ret_from_fork_asm+27
> > 
> > dev dm-86 bio failed 10, submitter
> >        submit_bio_noacct+5
> >        write_all_supers+1718
> >        btrfs_commit_transaction+2342
> >        transaction_kthread+345
> >        kthread+229
> >        ret_from_fork+49
> >        ret_from_fork_asm+27
> > completion
> >        bio_endio+5
> >        clone_endio+295
> >        clone_endio+295
> >        process_one_work+369
> >        worker_thread+635
> >        kthread+229
> >        ret_from_fork+49
> >        ret_from_fork_asm+27
> > 
> > 
> > For context, dm-86 is /dev/lvm/brokenDisk and dm-77 is /dev/lowerVG/lvmPool
> 
> io_status is 10(BLK_STS_IOERR), which is produced in submission code path on
> /dev/dm-77(/dev/lowerVG/lvmPool) first, so looks it is one device mapper issue.
> 
> The error should be from the following code only:
> 
> static void __map_bio(struct bio *clone)
> 
> 	...
> 	if (r == DM_MAPIO_KILL)
> 		dm_io_dec_pending(io, BLK_STS_IOERR);
> 	else
> 		dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
>     break;

I agree that the above bpf stack traces for dm-77 indicate that
dm_submit_bio failed, which would end up in the above branch if the
target's ->map() returned DM_MAPIO_KILL or DM_MAPIO_REQUEUE.

But such an early failure speaks to the flush bio never being
submitted to the underlying storage. No?

dm-raid.c:raid_map does return DM_MAPIO_REQUEUE with:

        /*
         * If we're reshaping to add disk(s)), ti->len and
         * mddev->array_sectors will differ during the process
         * (ti->len > mddev->array_sectors), so we have to requeue
         * bios with addresses > mddev->array_sectors here or
         * there will occur accesses past EOD of the component
         * data images thus erroring the raid set.
         */
        if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
                return DM_MAPIO_REQUEUE;

But a flush doesn't have an end_sector (it'd be 0 afaik).. so it seems
weird relative to a flush.

> Patrick, you mentioned lvmPool is raid1, can you explain how lvmPool is
> built? It is dm-raid1 target or over plain raid1 device which is
> build over /dev/lowerVG?

In my earlier reply I asked Patrick for both:
lsblk
dmsetup table

Picking over the described IO stacks provided earlier (or Goffredo's
interpretation of it, via ascii art) isn't really a great way to see
the IO stacks that are in use/question.

> Mike, the logic in the following code doesn't change from v5.18-rc2 to
> v5.19, but I still can't understand why STS_IOERR is set in
> dm_io_complete() in case of BLK_STS_DM_REQUEUE && !__noflush_suspending(),
> since DMF_NOFLUSH_SUSPENDING is only set in __dm_suspend() which
> is supposed to not happen in Patrick's case.
> 
> dm_io_complete()
> 	...
> 	if (io->status == BLK_STS_DM_REQUEUE) {
> 	        unsigned long flags;
> 	        /*
> 	         * Target requested pushing back the I/O.
> 	         */
> 	        spin_lock_irqsave(&md->deferred_lock, flags);
> 	        if (__noflush_suspending(md) &&
> 	            !WARN_ON_ONCE(dm_is_zone_write(md, bio))) {
> 	                /* NOTE early return due to BLK_STS_DM_REQUEUE below */
> 	                bio_list_add_head(&md->deferred, bio);
> 	        } else {
> 	                /*
> 	                 * noflush suspend was interrupted or this is
> 	                 * a write to a zoned target.
> 	                 */
> 	                io->status = BLK_STS_IOERR;
> 	        }
> 	        spin_unlock_irqrestore(&md->deferred_lock, flags);
> 	}

Given the reason from dm-raid.c:raid_map returning DM_MAPIO_REQUEUE
I think the DM device could be suspending without flush.

But regardless, given you logged BLK_STS_IOERR lets assume it isn't,
the assumption that "noflush suspend was interrupted" seems like a
stale comment -- especially given that target's like dm-raid are now
using DM_MAPIO_REQUEUE without concern for the historic tight-coupling
of noflush suspend (which was always the case for the biggest historic
reason for this code: dm-multipath, see commit 2e93ccc1933d0 from
2006 -- predates my time with developing DM).

So all said, this code seems flawed for dm-raid (and possibly other
targets that return DM_MAPIO_REQUEUE).  I'll look closer this week.

Mike

