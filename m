Return-Path: <linux-btrfs+bounces-18891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1881C51BF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CD21891FE5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39343054F0;
	Wed, 12 Nov 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xbp+LTRC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55E283FC8
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944386; cv=none; b=JCSVyQHsNJY36dGJ6tBpVjsEbsJsLkkBdvsAR13h8kUs6/AQHopeUetUvbxU187mAZ8A30cxV499jNLnXaOnzKXBR2bqm/5M46RlDCOjshmFfyjZutnvcszBHxmpp8TCRMMOm9K5uS0oeDKLpVFu4c9fFTMszWz/fcHmH1hIm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944386; c=relaxed/simple;
	bh=iAXLEf2KONU7wipnDgUv2QDbydQrYLVO4nzVULNLE3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZsBByDC5U2ltxhl5Dcycbpf8m19Mk6WYwpZshc3fPWYHcYNM4KidrMGVI+uckKPSMZjnE5hgHqCWoq7RPIZUHvQc+KapljBsfyY949uBrJD5WiTmQtMDYYsEunwj88JkKEfiEJAyWOt4D+xdg0isLA6M+JTdyVpuihivuv+SEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xbp+LTRC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b31507ed8so539376f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762944383; x=1763549183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sELBzzgBJhbl02XdfylT2+DRwcAyHP22ijYke7oVctY=;
        b=Xbp+LTRCQbmI4mmQ25UIR9tQRxNr2yiDyn42wRm4cw2CDRCa5YEZbJVozewik/2Eer
         AGnuoRcfJAaMqTcZUNHDDd5/6fg/DPqv1DHU4KgOenzGdnc8l4OkeLkxAHgjAy1xm4kd
         UmMPq5XQiRyh0oUOQgFNFcOwhjtFfoxNIDtzbEK6O3IN5/LePAowmvwhOhWHbywpu6LS
         2YEaq7bco/ZTaOmSStJiyMBtU7bg2vSqmrUN5Yv65xqjelGoF+r0X4EJi8WrnhFYwj7K
         eC3ZmpH8xlbKLEYN8jaUNm9N2vkT5KbUNNFWRR4QyZe1BtLptT9hus6ypZ9EaFmqmy8y
         NX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944383; x=1763549183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sELBzzgBJhbl02XdfylT2+DRwcAyHP22ijYke7oVctY=;
        b=HJoo7Tvr9Ya1i8tBTL3KKQthe7qjf1RmNHW4speHdz8hC0rGAWAsQ2y4BRDq6/qrfu
         n9Tk9erTVZ8kIXOakjWeBzkQLRTcxKSmBzxPcKHOG6Wed+m8otzY6hdzWwL4ca6EydyM
         dj2T91suIcgmlgUsbCR6Tzlo8Me82UD118hxtn137uwPwx4rNyRMsecfTbjyByLvc14k
         IzvcpmQbbt+UNI/XdF3YT9wJ6jrJQqAg9eTxDIuZb10C7qZRhH9TJLFcRhiq/EEtdUBx
         iAJf8LD++kGmy+dzOJTzn4U+qI0Nea3jdT8XVFtumwbJvlse/3lKHj5gYwyBOaOIXq6F
         9BhQ==
X-Gm-Message-State: AOJu0YxXBNp/kJ6YPmjB45W8WuDgR9ewPFbbRt3dja01/P6r+kAmYuuc
	sKCaQkxuW1KpJaiHqUrK75PiwGXJlOCJRiozp24sH34gV2DvfQjTlxbnAWXkEg93jVEJCVdygIW
	LWAlTjwQwhKtzRah4ExCr3MqDSKIho2fVob2rbf//yM8j/I4i5E78DBg=
X-Gm-Gg: ASbGnctSTQfvLaAbm53ydOCyaZa4JhdlfYmUr0NVyWNqaw+tYm725wYxnXeGx+3p652
	ZdmjzHN1/SK72EfQ9sgme+C5sINW7WGjhV39yc5zpasDEP7VgYMjp713fBDkvI+exHy/4DHZwaq
	a0wGH56GNCWdijMBshHJ1sGu8KFqD0ACef4aHKUOE/FTzPs91XUApY8QIvNnaeS0m37odRdvNk2
	uNXqqnrurqer2rSCvcHFlaAjswHzUNkgoi1I0pqTz62AXRTo92U8BTswxZi4gcByhn1k/FZlPI0
	iDSZTblCRO9DklBxECZUoo23vucqUzEqujO4AqfYGOoATVmy3CizHAV9PQ==
X-Google-Smtp-Source: AGHT+IG9OJlqKv3aYXDaWVw3dJYjqy/ZoCnUCvdfxYFizg1ljWnisBOjG8cQTqDqkJHpEXWzpys6UL45v9sktoN+I98=
X-Received: by 2002:a05:6000:144c:b0:429:c851:69b3 with SMTP id
 ffacd0b85a97d-42b4bdaed87mr2073383f8f.30.1762944382651; Wed, 12 Nov 2025
 02:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com> <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
 <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
In-Reply-To: <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 12 Nov 2025 11:46:10 +0100
X-Gm-Features: AWmQ_bkF15alX0Q6Qijiiuy091tY2m3OLO7YrJzZUiYcdK_SAEyuAWHQ_sSuEbs
Message-ID: <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2025 at 21:33, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/11 23:08, Daniel Vacek =E5=86=99=E9=81=93:
> > On Mon, 10 Nov 2025 at 22:05, Qu Wenruo <wqu@suse.com> wrote:
> >> =E5=9C=A8 2025/11/11 05:10, Daniel Vacek =E5=86=99=E9=81=93:
> >>> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>> [ENHANCEMENT]
> >>>> Btrfs currently calculate its data checksum then submit the bio.
> >>>>
> >>>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered w=
rite
> >>>> if the inode requires checksum"), any writes with data checksum will
> >>>> fallback to buffered IO, meaning the content will not change during
> >>>> writeback.
> >>>>
> >>>> This means we're safe to calculate the data checksum and submit the =
bio
> >>>> in parallel, and only need the following new behaviors:
> >>>>
> >>>> - Wait the csum generation to finish before calling btrfs_bio::end_i=
o()
> >>>>     Or we can lead to use-after-free for the csum generation worker.
> >>>>
> >>>> - Save the current bi_iter for csum_one_bio()
> >>>>     As the submission part can advance btrfs_bio::bio.bi_iter, if no=
t
> >>>>     saved csum_one_bio() may got an empty bi_iter and do not generat=
e any
> >>>>     checksum.
> >>>>
> >>>>     Unfortunately this means we have to increase the size of btrfs_b=
io for
> >>>>     16 bytes.
> >>>>
> >>>> As usual, such new feature is hidden behind the experimental flag.
> >>>>
> >>>> [THEORETIC ANALYZE]
> >>>> Consider the following theoretic hardware performance, which should =
be
> >>>> more or less close to modern mainstream hardware:
> >>>>
> >>>>           Memory bandwidth:       50GiB/s
> >>>>           CRC32C bandwidth:       45GiB/s
> >>>>           SSD bandwidth:          8GiB/s
> >>>>
> >>>> Then btrfs write bandwidth with data checksum before the patch would=
 be
> >>>>
> >>>>           1 / ( 1 / 50 + 1 / 45 + 1 / 8) =3D 5.98 GiB/s
> >>>>
> >>>> After the patch, the bandwidth would be:
> >>>>
> >>>>           1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) =3D 6.90 GiB/s
> >>>>
> >>>> The difference would be 15.32 % improvement.
> >>>>
> >>>> [REAL WORLD BENCHMARK]
> >>>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vC=
PUs, the
> >>>> storage is backed by a PCIE gen3 x4 NVME SSD.
> >>>>
> >>>> The test is a direct IO write, with 1MiB block size, write 7GiB data
> >>>> into a btrfs mount with data checksum. Thus the direct write will fa=
llback
> >>>> to buffered one:
> >>>>
> >>>> Vanilla Datasum:        1619.97 GiB/s
> >>>> Patched Datasum:        1792.26 GiB/s
> >>>> Diff                    +10.6 %
> >>>>
> >>>> In my case, the bottleneck is the storage, thus the improvement is n=
ot
> >>>> reaching the theoretic one, but still some observable improvement.
> >>>>
> >>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>> ---
> >>>>    fs/btrfs/bio.c       | 21 +++++++++++----
> >>>>    fs/btrfs/bio.h       |  7 +++++
> >>>>    fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++--------=
-----
> >>>>    fs/btrfs/file-item.h |  2 +-
> >>>>    4 files changed, 69 insertions(+), 25 deletions(-)
> >>>>
> >>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >>>> index 5a5f23332c2e..8af2b68c2d53 100644
> >>>> --- a/fs/btrfs/bio.c
> >>>> +++ b/fs/btrfs/bio.c
> >>>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, bl=
k_status_t status)
> >>>>           /* Make sure we're already in task context. */
> >>>>           ASSERT(in_task());
> >>>>
> >>>> +       if (bbio->async_csum)
> >>>> +               wait_for_completion(&bbio->csum_done);
> >>>
> >>> Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
> >>> the completion? I believe it is not needed at all.
> >>
> >> I tried this idea, unfortunately causing kernel warnings.
> >>
> >> It will trigger a warning inside __flush_work(), triggering the warnin=
g
> >> from check_flush_dependency().
> >>
> >> It looks like the workqueue we're in (btrfs-endio) has a different
> >> WQ_MEM_RECLAIM flag for csum_one_bio_work().
> >
> > If I read the code correctly that would be solved using the
> > btrfs_end_io_wq instead of system wq (ie. queue_work() instead of
> > schedule_work()).
>
> That will cause dependency problems. The endio work now depends on the
> csum work, which are both executed on the same workqueue.
> If the max_active is 1, endio work will deadlock waiting for the csum one=
.

When the csum work is being queued the bio was not even submitted yet.
The chances are the csum work will be done even before the bio ends
and the end io work is queued. But even if csum work is not done yet
(or even started due to scheduling delays or previous (unrelated)
worker still being blocked), it's always serialized before the end io
work. So IIUC, there should be no deadlock possible. Unless I'm still
missing something, workqueues could be tricky.

> >> +       init_completion(&bbio->csum_done);
> >> +       bbio->async_csum =3D true;
> >> +       bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> >> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> >> +       schedule_work(&bbio->csum_work);
> >
> > queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
>
> Nope, I even created a new workqueue for the csum work, and it doesn't
> workaround the workqueue dependency check.

Did you create it with the WQ_MEM_RECLAIM flag? As like:

alloc_workqueue("btrfs-async-csum", ... | WQ_MEM_RECLAIM, ...);

I don't see how that would trigger the warning. See below for a
detailed explanation.

> The check inside check_flush_dependency() is:
>
>          WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
>                                (WQ_MEM_RECLAIM | __WQ_LEGACY)) =3D=3D
> WQ_MEM_RECLAIM),
>
> It means the worker can not have WQ_MEM_RECLAIM flag at all. (unless it
> also has the LEGACY flag)

I understand that if the work is queued on a wq with WQ_MEM_RECLAIM,
the check_flush_dependency() returns early. Hence no need to worry
about the warning's condition as it's no longer of any concern.

> So nope, the flush_work() idea won't work inside any current btrfs
> workqueue, which all have WQ_MEM_RECLAIM flag set.

With the above being said, I still see two possible solutions.
Either using the btrfs_end_io_wq() as suggested before. It should be safe, =
IMO.
Or, if you're still worried about possible deadlocks, creating a new
dedicated wq which also has the WQ_MEM_RECLAIM set (which is needed
for compatibility with the context where we want to call the
flush_work()).

Both ways could help getting rid of the completion in btrfs_bio, which
is 32 bytes by itself.

What do I miss?

Out of curiosity, flush_work() internally also uses completion in
pretty much exactly the same way as in this patch, but it's on the
caller's stack (in this case on the stack which would call the
btrfs_bio_end_io() modified with flush_work()). So in the end the
effect would be like moving the completion from btrfs_bio to a stack.

> What we need is to make endio_workers and rmw_workers to get rid of
> WQ_MEM_RECLAIM, but that is a huge change and may not even work.
>
> Thanks,
> Qu
>
> >
> >> I'll keep digging to try to use flush_work() to remove the csum_done, =
as
> >> that will keep the size of btrfs_bio unchanged.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> --nX
> >>>
> >>
> >>>>
> >>
>

