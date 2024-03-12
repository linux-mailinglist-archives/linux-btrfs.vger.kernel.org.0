Return-Path: <linux-btrfs+bounces-3237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E35879F28
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A48B2251D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568E46551;
	Tue, 12 Mar 2024 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFtwX40D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9A446AC;
	Tue, 12 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284114; cv=none; b=ZbEY1vAsomZ1Ot3XHN5EgV/HFswMCnHjJqK/ByU/JwT/FHNQTkj5Rb5LioPTz+u0nqQUprWc2P2TbHMr0kW1OwmoTp2EHG37OPG4on9lToRGIJqeVjaOQNAfgrEQSYvgJe+Gfx8RREnkgL5maDF6V93sGHZwCTVqqS1AapAGecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284114; c=relaxed/simple;
	bh=pqB0kQNo2lOrlfpuu3b2oAK++B35JKyT39mKFe8+dtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV+FImfA5AB90WxsnXeBZWwRMkrD6Z68NxzGvqETJFPTtSqhYFd3GegddOR1TfAzWS5Qnsp+0sjZEVIr8RKlpIiCQUzFFGzZiFJ03T7F9oB3uI3aUjFmHVRkvtkhJxlkCGZi1aTjRECeDRc892IjsDouaejlrXLc2GoTCcXfHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFtwX40D; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d29111272eso101575581fa.0;
        Tue, 12 Mar 2024 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710284110; x=1710888910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn4o2EhSzw/dPcbf0I+GhuZZGnLjYr0VW9p4Ognw3lA=;
        b=DFtwX40DTpA1ESUPV8sJR56EUf0c9+qNJjP8KPyPS2NknXIl8JKqC2NOjRk3GBOfnK
         iLT6My59Je3s9OBwaiCO/IprHf8YrVs30QSn60dAmMqT+0pVlO3b/DBT8VrBcn/jdxQ6
         gWZk9LLXV2BAdKYPsI+8/WuNu/1/8KlsE/Bg9vTUeFVR65zWNi9ZrA9EATpRbYJoUGYf
         Z54BA/OxLGfFzUue+yZihS0USuMCATXW4j8nNBEIrvo7QdLXyymmLlXlUc0uzZ6bA2nY
         iDgFOI87H+NFqddsERgg9nvyty4enf6KnwNkz/LaOKtYQHy5VJampv6oHavbYwljlXr1
         ssxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284110; x=1710888910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn4o2EhSzw/dPcbf0I+GhuZZGnLjYr0VW9p4Ognw3lA=;
        b=ExrLFIbDyxj4RQgFsz3xa7h0a3nxbpZMhmzpiMt2AHV+0WLP4qzZvqIrUkmCFTcrWy
         tPFiDejlTtounSpnezYeZ2Qhk6st+bPA0iyDOhBH94IyysuqXMq2RbK3zOlp8kA3VYEI
         dvvh0f0BO09wTx10YVzoum2WG7Ahz3ubjagv4eujHE0R0s7DU5j2wAwSlYP/xN6Li+TL
         P9K5OTaMIpo8Hdr9raa8STJY7TssTvlF9fg5CbKS/mroT+r4gFlB6XFzscc6f1p0mpJJ
         HkLzQ7VGqmvk4pibtDIA0cJDbkjOKATGMNk/m9OH1fKXFmbfky98rsHJZlDOeUwto5kM
         1WNA==
X-Forwarded-Encrypted: i=1; AJvYcCXFs99Hznk+FI3Y0v2tcVmkwJ76vgVKErB9LXwbxDZKCmmIuaK3j2YB85v7Xo9uTjuiDGQmX8cLAvls3tA/7X1o8S487lUz7KNHzz1EFvIzNnpK1Wk688hFMI/94eQPNg0cU2lG/jGCmGQ=
X-Gm-Message-State: AOJu0YxjnARnZpY5snCOcf+1CYEiKd4Zn2dkv8zWvZH0AndnEdu1Hmno
	iFm4wt5dD5OsO73iyg60Hxl27N4ywgJDH1QxRAPF3QBUQPb3eMhxysyGEu5Wvj2WlW5oA4Qw9Yk
	3k7KgkdN7e+gdODaShp54/f5BFJ1YKeaq
X-Google-Smtp-Source: AGHT+IFbWul1azbb7FTg9EddCY7T7oYsUqF6TE3i9r9b9TycKD6mwZxOcnZoYoeU6Y0yDRibf8dC3NEMMFfQCe9VDFo=
X-Received: by 2002:a05:651c:222b:b0:2d2:751f:abb2 with SMTP id
 y43-20020a05651c222b00b002d2751fabb2mr2507208ljq.3.1710284110049; Tue, 12 Mar
 2024 15:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOCpoWexiuYLu0fpPr71+Uzxw_tw3q4HGF9tKgx5FM4xMx9fWA@mail.gmail.com>
 <a1e30dab-dfde-418e-a0dd-3e294838e839@inwind.it> <CAOCpoWeB=2j+n+5K5ytj2maZxdrV80cxJcM5CL=z1bZKgpXPWQ@mail.gmail.com>
 <a783e5ed-db56-4100-956a-353170b1b7ed@inwind.it> <ZedaKUge-EBo4CuT@redhat.com>
 <ZeiS/bjJaRcrerWW@fedora> <CAOCpoWeoQMh_-MxzxGBnK2Kf5EhvTLs=GrGwJ5XcfGVRTp73Eg@mail.gmail.com>
 <Ze2azGlb1WxVFv7Z@fedora> <Ze3RWqLvG18cQ4dz@redhat.com> <CAOCpoWf7C=B1sdeUL46sVVtVUDH8+o_T9LGJNTOYqA317uMdmA@mail.gmail.com>
 <Ze8DZLBHhCxgzc+r@fedora>
In-Reply-To: <Ze8DZLBHhCxgzc+r@fedora>
From: Patrick Plenefisch <simonpatp@gmail.com>
Date: Tue, 12 Mar 2024 18:54:59 -0400
Message-ID: <CAOCpoWd5VWZnAaYvkFDYo736ZXDK0bExC9NkwVGfLv_CATj9Rw@mail.gmail.com>
Subject: Re: LVM-on-LVM: error while submitting device barriers
To: Ming Lei <ming.lei@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Goffredo Baroncelli <kreijack@inwind.it>, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, regressions@lists.linux.dev, 
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 9:13=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Sun, Mar 10, 2024 at 02:11:11PM -0400, Patrick Plenefisch wrote:
> > On Sun, Mar 10, 2024 at 11:27=E2=80=AFAM Mike Snitzer <snitzer@kernel.o=
rg> wrote:
> > >
> > > On Sun, Mar 10 2024 at  7:34P -0400,
> > > Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > > On Sat, Mar 09, 2024 at 03:39:02PM -0500, Patrick Plenefisch wrote:
> > > > > On Wed, Mar 6, 2024 at 11:00=E2=80=AFAM Ming Lei <ming.lei@redhat=
.com> wrote:
> > > > > >
> > > > > > #!/usr/bin/bpftrace
> > > > > >
> > > > > > #ifndef BPFTRACE_HAVE_BTF
> > > > > > #include <linux/blkdev.h>
> > > > > > #endif
> > > > > >
> > > > > > kprobe:submit_bio_noacct,
> > > > > > kprobe:submit_bio
> > > > > > / (((struct bio *)arg0)->bi_opf & (1 << __REQ_PREFLUSH)) !=3D 0=
 /
> > > > > > {
> > > > > >         $bio =3D (struct bio *)arg0;
> > > > > >         @submit_stack[arg0] =3D kstack;
> > > > > >         @tracked[arg0] =3D 1;
> > > > > > }
> > > > > >
> > > > > > kprobe:bio_endio
> > > > > > /@tracked[arg0] !=3D 0/
> > > > > > {
> > > > > >         $bio =3D (struct bio *)arg0;
> > > > > >
> > > > > >         if (($bio->bi_flags & (1 << BIO_CHAIN)) && $bio->__bi_r=
emaining.counter > 1) {
> > > > > >                 return;
> > > > > >         }
> > > > > >
> > > > > >         if ($bio->bi_status !=3D 0) {
> > > > > >                 printf("dev %s bio failed %d, submitter %s comp=
letion %s\n",
> > > > > >                         $bio->bi_bdev->bd_disk->disk_name,
> > > > > >                         $bio->bi_status, @submit_stack[arg0], k=
stack);
> > > > > >         }
> > > > > >         delete(@submit_stack[arg0]);
> > > > > >         delete(@tracked[arg0]);
> > > > > > }
> > > > > >
> > > > > > END {
> > > > > >         clear(@submit_stack);
> > > > > >         clear(@tracked);
> > > > > > }
> > > > > >
> > > > >
> > > > > Attaching 4 probes...
> > > > > dev dm-77 bio failed 10, submitter
> > > > >        submit_bio_noacct+5
> > > > >        __send_duplicate_bios+358
> > > > >        __send_empty_flush+179
> > > > >        dm_submit_bio+857
> > > > >        __submit_bio+132
> > > > >        submit_bio_noacct_nocheck+345
> > > > >        write_all_supers+1718
> > > > >        btrfs_commit_transaction+2342
> > > > >        transaction_kthread+345
> > > > >        kthread+229
> > > > >        ret_from_fork+49
> > > > >        ret_from_fork_asm+27
> > > > > completion
> > > > >        bio_endio+5
> > > > >        dm_submit_bio+955
> > > > >        __submit_bio+132
> > > > >        submit_bio_noacct_nocheck+345
> > > > >        write_all_supers+1718
> > > > >        btrfs_commit_transaction+2342
> > > > >        transaction_kthread+345
> > > > >        kthread+229
> > > > >        ret_from_fork+49
> > > > >        ret_from_fork_asm+27
> > > > >
> > > > > dev dm-86 bio failed 10, submitter
> > > > >        submit_bio_noacct+5
> > > > >        write_all_supers+1718
> > > > >        btrfs_commit_transaction+2342
> > > > >        transaction_kthread+345
> > > > >        kthread+229
> > > > >        ret_from_fork+49
> > > > >        ret_from_fork_asm+27
> > > > > completion
> > > > >        bio_endio+5
> > > > >        clone_endio+295
> > > > >        clone_endio+295
> > > > >        process_one_work+369
> > > > >        worker_thread+635
> > > > >        kthread+229
> > > > >        ret_from_fork+49
> > > > >        ret_from_fork_asm+27
> > > > >
> > > > >
> > > > > For context, dm-86 is /dev/lvm/brokenDisk and dm-77 is /dev/lower=
VG/lvmPool
> > > >
> > > > io_status is 10(BLK_STS_IOERR), which is produced in submission cod=
e path on
> > > > /dev/dm-77(/dev/lowerVG/lvmPool) first, so looks it is one device m=
apper issue.
> > > >
> > > > The error should be from the following code only:
> > > >
> > > > static void __map_bio(struct bio *clone)
> > > >
> > > >       ...
> > > >       if (r =3D=3D DM_MAPIO_KILL)
> > > >               dm_io_dec_pending(io, BLK_STS_IOERR);
> > > >       else
> > > >               dm_io_dec_pending(io, BLK_STS_DM_REQUEUE);
> > > >     break;
> > >
> > > I agree that the above bpf stack traces for dm-77 indicate that
> > > dm_submit_bio failed, which would end up in the above branch if the
> > > target's ->map() returned DM_MAPIO_KILL or DM_MAPIO_REQUEUE.
> > >
> > > But such an early failure speaks to the flush bio never being
> > > submitted to the underlying storage. No?
> > >
> > > dm-raid.c:raid_map does return DM_MAPIO_REQUEUE with:
> > >
> > >         /*
> > >          * If we're reshaping to add disk(s)), ti->len and
> > >          * mddev->array_sectors will differ during the process
> > >          * (ti->len > mddev->array_sectors), so we have to requeue
> > >          * bios with addresses > mddev->array_sectors here or
> > >          * there will occur accesses past EOD of the component
> > >          * data images thus erroring the raid set.
> > >          */
> > >         if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
> > >                 return DM_MAPIO_REQUEUE;
> > >
> > > But a flush doesn't have an end_sector (it'd be 0 afaik).. so it seem=
s
> > > weird relative to a flush.
> > >
> > > > Patrick, you mentioned lvmPool is raid1, can you explain how lvmPoo=
l is
> > > > built? It is dm-raid1 target or over plain raid1 device which is
> > > > build over /dev/lowerVG?
> >
> > LVM raid1:
> > lvcreate --type raid1 -m 1 ...
>
> OK, that is the reason, as Mike mentioned.
>
> dm-raid.c:raid_map returns DM_MAPIO_REQUEUE, which is translated into
> BLK_STS_IOERR in dm_io_complete().
>
> Empty flush bio is sent from btrfs, both .bi_size and .bi_sector are set
> as zero, but the top dm is linear, which(linear_map()) maps new
> bio->bi_iter.bi_sector, and the mapped bio is sent to dm-raid(raid_map())=
,
> then DM_MAPIO_REQUEUE is returned.
>
> The one-line patch I sent in last email should solve this issue.
>
> https://lore.kernel.org/dm-devel/a783e5ed-db56-4100-956a-353170b1b7ed@inw=
ind.it/T/#m8fce3ecb2f98370b7d7ce8db6714bbf644af5459

With this patch on a 6.6.13 base, I can modify files and the BTRFS
volume stays RW, while no errors are logged in dmesg!


>
> But DM_MAPIO_REQUEUE misuse needs close look, and I believe Mike is worki=
ng
> on that bigger problem.
>
> I guess most of dm targets don't deal with empty bio well, at least
> linear & dm-raid, not look into others yet, :-(
>
>
> Thanks,
> Ming
>

