Return-Path: <linux-btrfs+bounces-3161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9B8777E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 19:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF9B0B20CDA
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BF39AEC;
	Sun, 10 Mar 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNFvxQSs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC91383AA;
	Sun, 10 Mar 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094275; cv=none; b=n6QYiflvU4flzeg++rCRxnm4X1P/jQawDYEg01uqj7ret8drTtGoCYRc14NYJkgmzOye65Lb5QbFtzmd7O23Xy1XATkSXh1l9QM8HLuppGzLcz4umq4h1OIH8Ke7295hmJUj1iLN4mjPvP3fow5YNBkYlkOmAJADIPUQs8d10ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094275; c=relaxed/simple;
	bh=XN1a6+HBLhW5BU/9FsxOQ5YYAtcfzFgEnYY55GqLggs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9r9LXXPbao2I65Bu8k49gpyETZ8bkV7J406utojV9dhBGQ2UZZXX0HJ26bXyB/ewlJTMLw1jpDmqYty6bGJfHTIlFm1G9uZDUAN9WIKh7XG9I3C41v+epIJsLFz6ooYq/s09lz3RkLXsz/SWfx4AhIzL7tjFLNq9GKxTRz/j2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNFvxQSs; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d382a78c38so42982031fa.1;
        Sun, 10 Mar 2024 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710094271; x=1710699071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mqrw6Q+LFP8qXMK/DUxJEU5Q3nQYogfywNL5K+4/HXU=;
        b=YNFvxQSsbPRAt0LWqYfsVQEFLXWVEQ1L4R4Splt3OoODjxh1+nvMF+S2V54W482ME4
         Udb08emty+gsshtqbI/Yz8imibwvB56bGl3h5raBg/EW+0rnGE1caisEY5HS6kC0Rclh
         l6HFA8PgS+yYTWWbTzSKTC8nq8tJ3L7Zh09tT6VkZpWN0d6VGmJp7EESZZYefzRJZ90Q
         hXzXtfhlTR8UOa4KV6BExKpAQT/Dteqd1V3UlKGPSNIpaNqiN4Cc5Q4QjnuWelX2S/+g
         XotjRNelI433LcqpzorAdGhsfPz0b63CMVjgHSeTYDWw+nZ2sCDHCoOoKjt9baWFY2aj
         yM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710094271; x=1710699071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqrw6Q+LFP8qXMK/DUxJEU5Q3nQYogfywNL5K+4/HXU=;
        b=hMgHSaryqtlrXeWoeM00wWdSWW68uzqJZKKGFJy0zTiUBg9ZnkM0QohsS/MeBDTGDq
         0oUfbA3MN2Hx7XqLZWeDB7FzXqodubuFepXzFsa0wLt465N90uZIm+nGdTRBCrETb2pu
         Lpo2mvd7mejDTOUCW6QtjpiPQtnla29m/qW8/R7TFtufudKpg2Lmvz8uV0UzGhTL6rJG
         pWbIpJE1ZnweoX+K4o4ZZv+JBD8AzxseJ9QZSPXZsq5fw+sOZtbNmJjnExdIKrAH47yM
         gsA2zgWcJxyx1TzJQebRnhF5r6azM2gfzQLOVpYfDAumHXRHt2gCD+rv8NR5Dmxr2d4B
         cNHg==
X-Forwarded-Encrypted: i=1; AJvYcCXVW6UHCAscdCUD5bl5UdkLJsS70ObKsNMXMCeLYGTHNHGx2D9RtAZZ1I5B54Vbm6qdQYV2jBjgaT5Eke/sYYw2NPuk6Rd+PrA8muuuykLoGZ1qo7Zo7IIfF2utOPtntl6Cke0TnYgfEIc=
X-Gm-Message-State: AOJu0YxwsvOloj0nYXkWJRzeTIgMh/Umj6KjOY/qEcUSOk1L++sw8wZR
	BCTtjKBhFE5Lsg+EcVLP0/ueiYnHRvEkCwWkgoaMKuRD2Cm/CabmqgGwVY9CEerHPpYkWCw32QD
	gtYvC750myRDXNlKLGflK+el/Wrw=
X-Google-Smtp-Source: AGHT+IEIV0xUkOPS6tZdzQzmgx8f0OZxJOoFaYY2bCEmdZ32mGDXIZGZwPSEl+WSlQ+yGh5T4SzF7X1yNf/9cUrG7dM=
X-Received: by 2002:a2e:300b:0:b0:2d3:f866:fdc6 with SMTP id
 w11-20020a2e300b000000b002d3f866fdc6mr2759565ljw.5.1710094270859; Sun, 10 Mar
 2024 11:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCpoWeNYsMfzh8TSnFqwAG1BhAYnNt_J+AcUNqRLF7zmJGEFA@mail.gmail.com>
 <672e88f2-8ac3-45fe-a2e9-730800017f53@libero.it> <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it> <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it> <ZedaKUge-EBo4CuT@redhat.com>
 <ZeiS/bjJaRcrerWW@fedora> <CAOCpoWeoQMh_-MxzxGBnK2Kf5EhvTLs=GrGwJ5XcfGVRTp73Eg@mail.gmail.com>
 <Ze2azGlb1WxVFv7Z@fedora> <Ze3RWqLvG18cQ4dz@redhat.com>
In-Reply-To: <Ze3RWqLvG18cQ4dz@redhat.com>
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Sun, 10 Mar 2024 14:11:11 -0400
Message-ID: <CAOCpoWf7C=B1sdeUL46sVVtVUDH8+o_T9LGJNTOYqA317uMdmA@mail.gmail.com>
Subject: Re: LVM-on-LVM: error while submitting device barriers
To: Mike Snitzer <snitzer@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Goffredo Baroncelli <kreijack@inwind.it>, 
	linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, regressions@lists.linux.dev, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 11:27=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> On Sun, Mar 10 2024 at  7:34P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
>
> > On Sat, Mar 09, 2024 at 03:39:02PM -0500, Patrick Plenefisch wrote:
> > > On Wed, Mar 6, 2024 at 11:00=E2=80=AFAM Ming Lei <ming.lei@redhat.com=
> wrote:
> > > >
> > > > #!/usr/bin/bpftrace
> > > >
> > > > #ifndef BPFTRACE_HAVE_BTF
> > > > #include <linux/blkdev.h>
> > > > #endif
> > > >
> > > > kprobe:submit_bio_noacct,
> > > > kprobe:submit_bio
> > > > / (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) !=3D 0 /
> > > > {
> > > >         $bio =3D (struct bio *)arg0;
> > > >         @submit_stack[arg0] =3D kstack;
> > > >         @tracked[arg0] =3D 1;
> > > > }
> > > >
> > > > kprobe:bio_endio
> > > > /@tracked[arg0] !=3D 0/
> > > > {
> > > >         $bio =3D (struct bio *)arg0;
> > > >
> > > >         if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_remai=
ning.counter > 1) {
> > > >                 return;
> > > >         }
> > > >
> > > >         if ($bio->bi_status !=3D 0) {
> > > >                 printf("dev %s bio failed %d, submitter %s completi=
on %s\n",
> > > >                         $bio->bi_bdev->bd_disk->disk_name,
> > > >                         $bio->bi_status, @submit_stack[arg0], kstac=
k);
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
> > > For context, dm-86 is /dev/lvm/brokenDisk and dm-77 is /dev/lowerVG/l=
vmPool
> >
> > io_status is 10(BLK_STS_IOERR), which is produced in submission code pa=
th on
> > /dev/dm-77(/dev/lowerVG/lvmPool) first, so looks it is one device mappe=
r issue.
> >
> > The error should be from the following code only:
> >
> > static void __map_bio(struct bio *clone)
> >
> >       ...
> >       if (r =3D=3D DM_MAPIO_KILL)
> >               dm_io_dec_pending(io, BLK_STS_IOERR);
> >       else
> >               dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
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
>
> > Patrick, you mentioned lvmPool is raid1, can you explain how lvmPool is
> > built? It is dm-raid1 target or over plain raid1 device which is
> > build over /dev/lowerVG?

LVM raid1:
lvcreate --type raid1 -m 1 ...

I had previously added raidintegrity and caching like
"lowerVG/single", but I had removed them in trying to root cause this
bug

>
> In my earlier reply I asked Patrick for both:
> lsblk
> dmsetup table

Oops, here they are, trimmed for relevance:


NAME
sdb
=E2=94=94=E2=94=80sdb2
  =E2=94=9C=E2=94=80lowerVG-single_corig_rmeta_1
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single
  =E2=94=9C=E2=94=80lowerVG-single_corig_rimage_1_imeta
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig_rimage_1
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82     =E2=94=94=E2=94=80lowerVG-single
  =E2=94=9C=E2=94=80lowerVG-single_corig_rimage_1_iorig
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig_rimage_1
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82     =E2=94=94=E2=94=80lowerVG-single
  =E2=94=9C=E2=94=80lowerVG-lvmPool_rmeta_0
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-lvmPool
  =E2=94=82   =E2=94=9C=E2=94=80lvm-a
  =E2=94=82   =E2=94=94=E2=94=80lvm-brokenDisk
  =E2=94=9C=E2=94=80lowerVG-lvmPool_rimage_0
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-lvmPool
  =E2=94=82   =E2=94=9C=E2=94=80lvm-a
  =E2=94=82   =E2=94=94=E2=94=80lvm-brokenDisk
sdc
=E2=94=94=E2=94=80sdc3
  =E2=94=9C=E2=94=80lowerVG-single_corig_rmeta_0
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single
  =E2=94=9C=E2=94=80lowerVG-single_corig_rimage_0_imeta
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig_rimage_0
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82     =E2=94=94=E2=94=80lowerVG-single
  =E2=94=9C=E2=94=80lowerVG-single_corig_rimage_0_iorig
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-single_corig_rimage_0
  =E2=94=82   =E2=94=94=E2=94=80lowerVG-single_corig
  =E2=94=82     =E2=94=94=E2=94=80lowerVG-single
sdd
=E2=94=94=E2=94=80sdd3
  =E2=94=9C=E2=94=80lowerVG-lvmPool_rmeta_1
  =E2=94=82 =E2=94=94=E2=94=80lowerVG-lvmPool
  =E2=94=82   =E2=94=9C=E2=94=80lvm-a
  =E2=94=82   =E2=94=94=E2=94=80lvm-brokenDisk
  =E2=94=94=E2=94=80lowerVG-lvmPool_rimage_1
    =E2=94=94=E2=94=80lowerVG-lvmPool
      =E2=94=9C=E2=94=80lvm-a
      =E2=94=94=E2=94=80lvm-brokenDisk
sdf
=E2=94=9C=E2=94=80sdf2
=E2=94=82 =E2=94=9C=E2=94=80lowerVG-lvmPool_rimage_1
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80lowerVG-lvmPool
=E2=94=82 =E2=94=82   =E2=94=9C=E2=94=80lvm-a
=E2=94=82 =E2=94=82   =E2=94=94=E2=94=80lvm-brokenDisk



lowerVG-single: 0 5583462400 cache 254:32 254:31 254:71 128 2
metadata2 writethrough mq 0
lowerVG-singleCache_cvol: 0 104857600 linear 259:13 104859648
lowerVG-singleCache_cvol-cdata: 0 104775680 linear 254:30 81920
lowerVG-singleCache_cvol-cmeta: 0 81920 linear 254:30 0
lowerVG-single_corig: 0 5583462400 raid raid1 3 0 region_size 4096 2
254:33 254:36 254:67 254:70
lowerVG-single_corig_rimage_0: 0 5583462400 integrity 254:35 0 4 J 8
meta_device:254:34 recalculate journal_sectors:130944
interleave_sectors:1 buffer_sectors:128 journal_watermark:50
commit_time:10000 internal_hash:crc32c
lowerVG-single_corig_rimage_0_imeta: 0 44802048 linear 8:35 5152466944
lowerVG-single_corig_rimage_0_iorig: 0 4724465664 linear 8:35 427821056
lowerVG-single_corig_rimage_0_iorig: 4724465664 431005696 linear 8:35 53620=
01920
lowerVG-single_corig_rimage_0_iorig: 5155471360 427819008 linear 8:35 2048
lowerVG-single_corig_rimage_0_iorig: 5583290368 172032 linear 8:35 51522949=
12
lowerVG-single_corig_rimage_1: 0 5583462400 integrity 254:69 0 4 J 8
meta_device:254:68 recalculate journal_sectors:130944
interleave_sectors:1 buffer_sectors:128 journal_watermark:50
commit_time:10000 internal_hash:crc32c
lowerVG-single_corig_rimage_1_imeta: 0 44802048 linear 8:18 5583472640
lowerVG-single_corig_rimage_1_iorig: 0 5583462400 linear 8:18 10240
lowerVG-single_corig_rmeta_0: 0 8192 linear 8:35 5152286720
lowerVG-single_corig_rmeta_1: 0 8192 linear 8:18 2048
lowerVG-lvmPool: 0 6442450944 raid raid1 3 0 region_size 4096 2 254:73
254:74 254:75 254:76
lowerVG-lvmPool_rimage_0: 0 2967117824 linear 8:18 5628282880
lowerVG-lvmPool_rimage_0: 2967117824 59875328 linear 8:18 12070733824
lowerVG-lvmPool_rimage_0: 3026993152 3415457792 linear 8:18 8655276032
lowerVG-lvmPool_rimage_1: 0 2862260224 linear 8:51 10240
lowerVG-lvmPool_rimage_1: 2862260224 164732928 linear 8:82 3415459840
lowerVG-lvmPool_rimage_1: 3026993152 3415457792 linear 8:82 2048
lowerVG-lvmPool_rmeta_0: 0 8192 linear 8:18 5628274688
lowerVG-lvmPool_rmeta_1: 0 8192 linear 8:51 2048
lvm-a: 0 1468006400 linear 254:77 1310722048
lvm-brokenDisk: 0 1310720000 linear 254:77 2048
lvm-brokenDisk: 1310720000 83886080 linear 254:77 2778728448
lvm-brokenDisk: 1394606080 2015404032 linear 254:77 4427040768
lvm-brokenDisk: 3410010112 884957184 linear 254:77 2883586048



As a side note, is there a way to make lsblk only show things the
first time they come up?

>
> Picking over the described IO stacks provided earlier (or Goffredo's
> interpretation of it, via ascii art) isn't really a great way to see
> the IO stacks that are in use/question.
>
> > Mike, the logic in the following code doesn't change from v5.18-rc2 to
> > v5.19, but I still can't understand why STS_IOERR is set in
> > dm_io_complete() in case of BLK_STS_DM_REQUEUE && !__noflush_suspending=
(),
> > since DMF_NOFLUSH_SUSPENDING is only set in __dm_suspend() which
> > is supposed to not happen in Patrick's case.
> >
> > dm_io_complete()
> >       ...
> >       if (io->status =3D=3D BLK_STS_DM_REQUEUE) {
> >               unsigned long flags;
> >               /*
> >                * Target requested pushing back the I/O.
> >                */
> >               spin_lock_irqsave(&md->deferred_lock, flags);
> >               if (__noflush_suspending(md) &&
> >                   !WARN_ON_ONCE(dm_is_zone_write(md, bio))) {
> >                       /* NOTE early return due to BLK_STS_DM_REQUEUE be=
low */
> >                       bio_list_add_head(&md->deferred, bio);
> >               } else {
> >                       /*
> >                        * noflush suspend was interrupted or this is
> >                        * a write to a zoned target.
> >                        */
> >                       io->status =3D BLK_STS_IOERR;
> >               }
> >               spin_unlock_irqrestore(&md->deferred_lock, flags);
> >       }
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
>
> Mike

