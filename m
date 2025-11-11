Return-Path: <linux-btrfs+bounces-18863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A668C4DDF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB7018C1E6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECB331224;
	Tue, 11 Nov 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TKjPmcbH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1B3AA1BB
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864726; cv=none; b=HeafrvmtLusBYGEHlu46JeU5iTzHhkmNOaujwlow/x1utM9myWtgeBITgTDgmJY7wVCMtqXzY3WXCBezmk7yZoGh30ylIrm6EduTe/ITgpxBk0R8it8+AExDahjq6mGMEk2qBpp/SWnYJeoqokoEKV0tCm65tpE9D5fEFWZLNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864726; c=relaxed/simple;
	bh=oMBm6ad86TMbBobmcZZ9Ch8XqSrT2jB/Jm93uJ2y/gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKmOLZ7mY4JSn5/ruGwgQpM/KrgjtOvmhZrKjnO6f8CjyK5YcsqPBUCCojpZ30lTU3QvfAzP23XAB1PdA0w6hVBPUtS3B4R6WZNr0yFfCMfneQ/VrHJsNTrnI5iq6OTI17nvypO6RfRF/9pEWZAf2+bUkhk+n/VWgC/7bVbg+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKjPmcbH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c7869704so3119018f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 04:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762864722; x=1763469522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB43DRfHQ/+kMuDsV4wQJctwWDe1t2TNCE1UwcOJ7uU=;
        b=TKjPmcbHvIBL9pW+PYxqJMOeXRaop0ZUQYy8rqr7Lkg0EXz0zzQ2LJfwnGEUIGdUFm
         N63RNiLn2CBSQfhm55hUCFEPK6OpX5wY4Nh2UmvLI3t5DVjTZqzJ5KkLB0ELug28PDsR
         rEk9GfGinP7IX9Fi/+gt7gein3MLByrzuR7tGrDb8B6HUtpwLKYuyUCn9UmdsSx2dLpm
         vqaWO7LmKt6iK5hWUcREA+6ZOiNpuzSS5oBgU/b7g+qvtc7Ni7PwLX4ubCwFpJZBTVhC
         dWG4FpdlQjQ67d2WVK+hJWUOB3PyKDjUVj6zgRg2fUdE1BSNw/kbapPrmDb+fMxoWyIL
         1MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864722; x=1763469522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CB43DRfHQ/+kMuDsV4wQJctwWDe1t2TNCE1UwcOJ7uU=;
        b=BbXzZ0vsjMYSOxWYjfglFaCQIJlPC4ccXxfEQ6c0rXdzLn8wRKqQbGbsX46q1Boy7D
         KVjHhiQudNn4f0ft89cmfbWw6AVfocKVjixAnN2jkUyEOieCgYU0l/rsQRkUU2FVuxqb
         EcLFhLFcrf3jsuF1qORz6egNtan2ZO3rmE4ilOm1HN4RHUUEX1OIRvJkm7+XNCtSlTnF
         QqXZj/xUa+zPGYa/SruqKtwf6cpQcQfD9RHQzOeSc8WNwGNe0dmRpGV6g2pdZHUQVLUG
         RtshwY3n+aUJZ3aQ1yddBoVRng38G+SVMNO38mKhZ1zFmKokBQdUnw55KVHxWR/uBF34
         Vq0g==
X-Gm-Message-State: AOJu0Yx2p8q4rUqbCxEwS/vgQNRLxY2dZ5+C1lf2Ft2BTPvjZ63GWS2S
	gD9LMuFlM17nkNnK+yYyQ7jMiU26S5sF3J9MyzwZFnY+Q/CoByp/OGljrxJqUh1vepmkudel0bE
	B1ZdkyzD25fD1Rhp42ycPOxAHog6ejSbvHqvBe5tTXw==
X-Gm-Gg: ASbGncuHJPQrPBUc6y6xDrqBxiNnHEf5JtyGO5Q73Z3u1z0MV5uulAfTAqFc5rMOgp4
	h8NJMOe0oXUXlijwekTvIXI+WzE0vTLtdLD+MdqJx4I0itfjLwCo8B0BHFPHVgWiUeN/MeUpOtn
	Yk6DxYkYM4/50TOOEMCuDwxFtMC1496pYVGRGPYSVWkB53DtfrKpFnwaWcCBBBG2Y6XHXIRJ9iK
	pTNDVcQktvkH0xtjeCySPtBjfc5vqXvJR+aWvK0aef87b/HjYiZAaB5v4mttfLP27ubp5krG9BW
	GBdms4VNtOfhQhgO841KuRwWyHOrlJUDjZyyLZeknvjNAn+obO35epoef/pxtEGFhsmJII4XgKh
	MXro=
X-Google-Smtp-Source: AGHT+IHXpxH31z/ZypM9CCxn0u3DnwDRH+J49d9zTUD97uL99W71i+uIP1CaFyiGm8j7zUmL4b9wIbLaKvA/ldKCCUo=
X-Received: by 2002:a05:6000:4107:b0:42b:2a41:f3d with SMTP id
 ffacd0b85a97d-42b2dc2d0cbmr8651434f8f.19.1762864721722; Tue, 11 Nov 2025
 04:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com> <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
In-Reply-To: <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 11 Nov 2025 13:38:30 +0100
X-Gm-Features: AWmQ_bnHNoznHgyQNjRy2gCzJ5cpTZR9WFakhTGVeP79G9uws1ChAtAOsQ-MbJk
Message-ID: <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 at 22:05, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/11 05:10, Daniel Vacek =E5=86=99=E9=81=93:
> > On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [ENHANCEMENT]
> >> Btrfs currently calculate its data checksum then submit the bio.
> >>
> >> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered wri=
te
> >> if the inode requires checksum"), any writes with data checksum will
> >> fallback to buffered IO, meaning the content will not change during
> >> writeback.
> >>
> >> This means we're safe to calculate the data checksum and submit the bi=
o
> >> in parallel, and only need the following new behaviors:
> >>
> >> - Wait the csum generation to finish before calling btrfs_bio::end_io(=
)
> >>    Or we can lead to use-after-free for the csum generation worker.
> >>
> >> - Save the current bi_iter for csum_one_bio()
> >>    As the submission part can advance btrfs_bio::bio.bi_iter, if not
> >>    saved csum_one_bio() may got an empty bi_iter and do not generate a=
ny
> >>    checksum.
> >>
> >>    Unfortunately this means we have to increase the size of btrfs_bio =
for
> >>    16 bytes.
> >>
> >> As usual, such new feature is hidden behind the experimental flag.
> >>
> >> [THEORETIC ANALYZE]
> >> Consider the following theoretic hardware performance, which should be
> >> more or less close to modern mainstream hardware:
> >>
> >>          Memory bandwidth:       50GiB/s
> >>          CRC32C bandwidth:       45GiB/s
> >>          SSD bandwidth:          8GiB/s
> >>
> >> Then btrfs write bandwidth with data checksum before the patch would b=
e
> >>
> >>          1 / ( 1 / 50 + 1 / 45 + 1 / 8) =3D 5.98 GiB/s
> >>
> >> After the patch, the bandwidth would be:
> >>
> >>          1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) =3D 6.90 GiB/s
> >>
> >> The difference would be 15.32 % improvement.
> >>
> >> [REAL WORLD BENCHMARK]
> >> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPU=
s, the
> >> storage is backed by a PCIE gen3 x4 NVME SSD.
> >>
> >> The test is a direct IO write, with 1MiB block size, write 7GiB data
> >> into a btrfs mount with data checksum. Thus the direct write will fall=
back
> >> to buffered one:
> >>
> >> Vanilla Datasum:        1619.97 GiB/s
> >> Patched Datasum:        1792.26 GiB/s
> >> Diff                    +10.6 %
> >>
> >> In my case, the bottleneck is the storage, thus the improvement is not
> >> reaching the theoretic one, but still some observable improvement.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/bio.c       | 21 +++++++++++----
> >>   fs/btrfs/bio.h       |  7 +++++
> >>   fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-----------=
--
> >>   fs/btrfs/file-item.h |  2 +-
> >>   4 files changed, 69 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >> index 5a5f23332c2e..8af2b68c2d53 100644
> >> --- a/fs/btrfs/bio.c
> >> +++ b/fs/btrfs/bio.c
> >> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_=
status_t status)
> >>          /* Make sure we're already in task context. */
> >>          ASSERT(in_task());
> >>
> >> +       if (bbio->async_csum)
> >> +               wait_for_completion(&bbio->csum_done);
> >
> > Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
> > the completion? I believe it is not needed at all.
>
> I tried this idea, unfortunately causing kernel warnings.
>
> It will trigger a warning inside __flush_work(), triggering the warning
> from check_flush_dependency().
>
> It looks like the workqueue we're in (btrfs-endio) has a different
> WQ_MEM_RECLAIM flag for csum_one_bio_work().

If I read the code correctly that would be solved using the
btrfs_end_io_wq instead of system wq (ie. queue_work() instead of
schedule_work()).

> +       init_completion(&bbio->csum_done);
> +       bbio->async_csum =3D true;
> +       bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> +       schedule_work(&bbio->csum_work);

queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);

> I'll keep digging to try to use flush_work() to remove the csum_done, as
> that will keep the size of btrfs_bio unchanged.
>
> Thanks,
> Qu
>
> >
> > --nX
> >
>
> >>
>

