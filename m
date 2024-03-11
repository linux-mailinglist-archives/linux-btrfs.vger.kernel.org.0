Return-Path: <linux-btrfs+bounces-3174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01742878054
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754FE1F22268
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A724E3D964;
	Mon, 11 Mar 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzAF3VmN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE173C493
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162805; cv=none; b=uVKKrEpIq4Q5nxbkKFhj333VQNwTBpvvKaOqMNNSV11ng2Yzonvmxhi5kx9Q2kVDJYrxOupLUGQQ5eJxcj6vgJEHAanrwUggfExnMGXUrryuikTLHlmcSEsD8ExXCeSsDlIMtyuu+9XbgIKP4+Dsq+/XwO/rhqpLq4orFKil5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162805; c=relaxed/simple;
	bh=oklUwL+uJA6fNtuusqrKD0mu1H8aZpzPS0lrskntuAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdMTVTky1DPgRBLoZHvc9ZtBJSAEn7QfNiH83jA9r+NCB1R8DwzBnnVZDArWunWJn2oFxx/V4rCdz9EH1onkcPSJBle8nWPJ9qJry2SFCvEu1IP/O4e02MwKIimt8p8rGaf0UC4AXAwK6IK8BkXMFssbvswkGieaZIZbcssZlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzAF3VmN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710162803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF+hHbhR6PmZRbNnvRDOIoP+U+GWHfuAJbw7MsIUXN0=;
	b=RzAF3VmNC8pdD51JRqQpFVROoKWgsgL43TW3xnvLJmXxTN0fBK7Olr/Abhsy2FObXnIZiW
	JWbMMS+ddX+oU5EJbN7AmxYtGHysfKB0r4RA3HwNCFAFdtlGigjOu1jgNcQ68sW/z7ThL2
	1VwEz0JZnHQ0h9eik+p0ZOoF6KxL/5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-Udhoi6WwMIqlcHlVxvW-Ng-1; Mon,
 11 Mar 2024 09:13:20 -0400
X-MC-Unique: Udhoi6WwMIqlcHlVxvW-Ng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED1538000B0;
	Mon, 11 Mar 2024 13:13:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3C7C04125;
	Mon, 11 Mar 2024 13:13:12 +0000 (UTC)
Date: Mon, 11 Mar 2024 21:13:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Patrick Plenefisch <simonpatp@gmail.com>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Goffredo Baroncelli <kreijack@inwind.it>,
	linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	regressions@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ming.lei@redhat.com
Subject: Re: LVM-on-LVM: error while submitting device barriers
Message-ID: <Ze8DZLBHhCxgzc+r@fedora>
References: <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it>
 <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it>
 <ZedaKUge-EBo4CuT@redhat.com>
 <ZeiS/bjJaRcrerWW@fedora>
 <CAOCpoWeoQMh_-MxzxGBnK2Kf5EhvTLs=GrGwJ5XcfGVRTp73Eg@mail.gmail.com>
 <Ze2azGlb1WxVFv7Z@fedora>
 <Ze3RWqLvG18cQ4dz@redhat.com>
 <CAOCpoWf7C=B1sdeUL46sVVtVUDH8+o_T9LGJNTOYqA317uMdmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOCpoWf7C=B1sdeUL46sVVtVUDH8+o_T9LGJNTOYqA317uMdmA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Sun, Mar 10, 2024 at 02:11:11PM -0400, Patrick Plenefisch wrote:
> On Sun, Mar 10, 2024 at 11:27 AM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > On Sun, Mar 10 2024 at  7:34P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> >
> > > On Sat, Mar 09, 2024 at 03:39:02PM -0500, Patrick Plenefisch wrote:
> > > > On Wed, Mar 6, 2024 at 11:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > #!/usr/bin/bpftrace
> > > > >
> > > > > #ifndef BPFTRACE_HAVE_BTF
> > > > > #include <linux/blkdev.h>
> > > > > #endif
> > > > >
> > > > > kprobe:submit_bio_noacct,
> > > > > kprobe:submit_bio
> > > > > / (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) != 0 /
> > > > > {
> > > > >         $bio = (struct bio *)arg0;
> > > > >         @submit_stack[arg0] = kstack;
> > > > >         @tracked[arg0] = 1;
> > > > > }
> > > > >
> > > > > kprobe:bio_endio
> > > > > /@tracked[arg0] != 0/
> > > > > {
> > > > >         $bio = (struct bio *)arg0;
> > > > >
> > > > >         if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_remaining.counter > 1) {
> > > > >                 return;
> > > > >         }
> > > > >
> > > > >         if ($bio->bi_status != 0) {
> > > > >                 printf("dev %s bio failed %d, submitter %s completion %s\n",
> > > > >                         $bio->bi_bdev->bd_disk->disk_name,
> > > > >                         $bio->bi_status, @submit_stack[arg0], kstack);
> > > > >         }
> > > > >         delete(@submit_stack[arg0]);
> > > > >         delete(@tracked[arg0]);
> > > > > }
> > > > >
> > > > > END {
> > > > >         clear(@submit_stack);
> > > > >         clear(@tracked);
> > > > > }
> > > > >
> > > >
> > > > Attaching 4 probes...
> > > > dev dm-77 bio failed 10, submitter
> > > >        submit_bio_noacct+5
> > > >        __send_duplicate_bios+358
> > > >        __send_empty_flush+179
> > > >        dm_submit_bio+857
> > > >        __submit_bio+132
> > > >        submit_bio_noacct_nocheck+345
> > > >        write_all_supers+1718
> > > >        btrfs_commit_transaction+2342
> > > >        transaction_kthread+345
> > > >        kthread+229
> > > >        ret_from_fork+49
> > > >        ret_from_fork_asm+27
> > > > completion
> > > >        bio_endio+5
> > > >        dm_submit_bio+955
> > > >        __submit_bio+132
> > > >        submit_bio_noacct_nocheck+345
> > > >        write_all_supers+1718
> > > >        btrfs_commit_transaction+2342
> > > >        transaction_kthread+345
> > > >        kthread+229
> > > >        ret_from_fork+49
> > > >        ret_from_fork_asm+27
> > > >
> > > > dev dm-86 bio failed 10, submitter
> > > >        submit_bio_noacct+5
> > > >        write_all_supers+1718
> > > >        btrfs_commit_transaction+2342
> > > >        transaction_kthread+345
> > > >        kthread+229
> > > >        ret_from_fork+49
> > > >        ret_from_fork_asm+27
> > > > completion
> > > >        bio_endio+5
> > > >        clone_endio+295
> > > >        clone_endio+295
> > > >        process_one_work+369
> > > >        worker_thread+635
> > > >        kthread+229
> > > >        ret_from_fork+49
> > > >        ret_from_fork_asm+27
> > > >
> > > >
> > > > For context, dm-86 is /dev/lvm/brokenDisk and dm-77 is /dev/lowerVG/lvmPool
> > >
> > > io_status is 10(BLK_STS_IOERR), which is produced in submission code path on
> > > /dev/dm-77(/dev/lowerVG/lvmPool) first, so looks it is one device mapper issue.
> > >
> > > The error should be from the following code only:
> > >
> > > static void __map_bio(struct bio *clone)
> > >
> > >       ...
> > >       if (r == DM_MAPIO_KILL)
> > >               dm_io_dec_pending(io, BLK_STS_IOERR);
> > >       else
> > >               dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
> > >     break;
> >
> > I agree that the above bpf stack traces for dm-77 indicate that
> > dm_submit_bio failed, which would end up in the above branch if the
> > target's ->map() returned DM_MAPIO_KILL or DM_MAPIO_REQUEUE.
> >
> > But such an early failure speaks to the flush bio never being
> > submitted to the underlying storage. No?
> >
> > dm-raid.c:raid_map does return DM_MAPIO_REQUEUE with:
> >
> >         /*
> >          * If we're reshaping to add disk(s)), ti->len and
> >          * mddev->array_sectors will differ during the process
> >          * (ti->len > mddev->array_sectors), so we have to requeue
> >          * bios with addresses > mddev->array_sectors here or
> >          * there will occur accesses past EOD of the component
> >          * data images thus erroring the raid set.
> >          */
> >         if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
> >                 return DM_MAPIO_REQUEUE;
> >
> > But a flush doesn't have an end_sector (it'd be 0 afaik).. so it seems
> > weird relative to a flush.
> >
> > > Patrick, you mentioned lvmPool is raid1, can you explain how lvmPool is
> > > built? It is dm-raid1 target or over plain raid1 device which is
> > > build over /dev/lowerVG?
> 
> LVM raid1:
> lvcreate --type raid1 -m 1 ...

OK, that is the reason, as Mike mentioned.

dm-raid.c:raid_map returns DM_MAPIO_REQUEUE, which is translated into
BLK_STS_IOERR in dm_io_complete().

Empty flush bio is sent from btrfs, both .bi_size and .bi_sector are set
as zero, but the top dm is linear, which(linear_map()) maps new
bio->bi_iter.bi_sector, and the mapped bio is sent to dm-raid(raid_map()),
then DM_MAPIO_REQUEUE is returned.

The one-line patch I sent in last email should solve this issue.

https://lore.kernel.org/dm-devel/a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it/T/#m8fce3ecb2f98370b7d7ce8db6714bbf644af5459

But DM_MAPIO_REQUEUE misuse needs close look, and I believe Mike is working
on that bigger problem.

I guess most of dm targets don't deal with empty bio well, at least
linear & dm-raid, not look into others yet, :-(


Thanks,
Ming


