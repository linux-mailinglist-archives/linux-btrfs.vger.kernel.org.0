Return-Path: <linux-btrfs+bounces-18925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C03EC54A71
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 22:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9F5334AFAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFC2D6E76;
	Wed, 12 Nov 2025 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AhhfuNye"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805D82C21DB
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983822; cv=none; b=YgGf8r3uY3V4XfkM6/FMzlICGYQ1zFpmggsjeU9YBfkh8AxTIV21Bh1VzEePWmUGZngH+ApvhPPi4PJO6ptJ8ZFQ1IcvkDxdh1VngrD6vKxMdfkLgLlHZMiCRgFjNUENesuxlzW3HYvqsPCQqJnRG3uLBnUUX+qffKGpLHViUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983822; c=relaxed/simple;
	bh=NT5JQutJ3f/KX5X3mSWZGPElYdVmCMEe/5CrBVRU9mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UINzInKW1Y15yW7QylRn8soEs8UoF89pZ/vHeA6fRnVtSJxAiLmKpz3smJoot5FEvcj46dyrEFlHO/IAVV20DzRUiss9NNyZo0iOBkdfH8PMWxy86w1uDuG3Pn582j5fSr+1ElXpW2ghrmFo4hM7KmusuPGyjoiIVfCnAQUTbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AhhfuNye; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso120707f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 13:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762983818; x=1763588618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPBjHqzYg/Tjpda2SYgtmFSAN786krvNTjBSEi5qLw8=;
        b=AhhfuNyeHY7NfbVrrThcM3XGYRLlFQ4bBBsAEn0QC6IYNornl196CtTzh7HYteuwtj
         NnvR7kceGxVMPPeSAjZWBki4/2t5TlM0oz7JsBNyLRZBBAIuTum7eZZUdtgUAsD4wNrr
         oF5LRI+QSI6FkK+MUg5ZPW4bELldfxAxwiUQv+Y5pyEFfB1IxD+0cz0V/iG3C/ai5vdc
         OuKAhr2xxHS/4YZniPirlVKphtmZUjI7MQ0Iw6Nco7VO5oPeWEtrKc75x/j/W7G0UMMI
         g9DwwwLoEquuugzt5YwSPuWj2bkAP6mE1gukGEPkp5vyXOnY8ma63DJkdazI4c1GMCNk
         3M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983818; x=1763588618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPBjHqzYg/Tjpda2SYgtmFSAN786krvNTjBSEi5qLw8=;
        b=h8byNz/FRn8N3qrqF0zmMsGn+VF41cqeqJw8C6At0xnJQK6sXhFzIZ5rO4QcWNpk3B
         9XTbik3rO0dGzc3f1qhnbluG/sRXRGoWbIVHESUVlDkPf8r5F+r1b3Qmq8fc1Yr2+ku3
         wmRVc5D3Cc0WTTMDRItOF5RZBm/4URfnerpK7XjR1HeSZQ/+rFyaAZlx6D047Tb/BGvC
         TSKmxR4BB3+4OP/KR7GCz9zgcyzlP5BDTt4IrUwjyNCv6Mq/CnsQJIMPgdG1pKwWky6r
         V8CBcus7mxWTZwgcybt7KcMhzntSe1sYCglOm7OM6rAMQfOBEuM742v8cTaLVhJAwfH7
         hGVg==
X-Gm-Message-State: AOJu0YyiOT+xdn3subUp29NoZE2RaiHYvDVRqp4PI0rckqMtm/beDKXY
	Aqp4+pyxMN61Q9lAVLq9pVdsipDZEcFdJo8KwhGkoHEWCluhKAovtvVnuFQslVmaoIssuxbQnQn
	TTrYZ+dkmnqzdB5D4qMb8Kxt4u39lvKpNYx+63MOyt8TJz6/5nWO//cg=
X-Gm-Gg: ASbGnctSSdZyZK4cbqo7SuaScPl6AMBnBhzBcmS1PcW/azoQqO7v7Bytg+aZIOGEkMG
	3CgqmBOJ3sVrlLs457J2EHnvFh6X90wMt3J9knnujfeBRAr+5Oy8jty1RjpS1N1n6IHKBLeWN+l
	NMIAOpztVE/L73pBjb2e5yJd2X9/mmea8e7Fs4b/N33TdWn+e7zllSyAXLJLWrMEMBQM3KvWcTr
	ccnTN/x1V1iprnLH5Iq5c6DPGlnuIPnRmI8RdayrfHelvEolzZj/Fg/fVE8k2ysasozWXLog2QW
	GoCx8hD2DnjLYMP6Eip+BNnUzt10SZv0tf/VqxIjp572io5uRiY//Na0Ow==
X-Google-Smtp-Source: AGHT+IH/amZMzSpzZnW+6R+jyzyq8BG6X7cYmDknOI8zZA3E3pSf0rTwnt/Knq2L0L5KnkefU1tBtlDdjR0lyK51QUU=
X-Received: by 2002:a05:6000:2c03:b0:42b:4069:428a with SMTP id
 ffacd0b85a97d-42b4bb91251mr3998525f8f.12.1762983817618; Wed, 12 Nov 2025
 13:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com> <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
 <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com> <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
 <c4d28607-702b-4817-ad94-2d52d529e344@suse.com>
In-Reply-To: <c4d28607-702b-4817-ad94-2d52d529e344@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 12 Nov 2025 22:43:25 +0100
X-Gm-Features: AWmQ_bnVCHqEmerwFuPy6IGfmzxXtPoEnhnchfz14kRvQg6cwazNdSS1-Wl0L-c
Message-ID: <CAPjX3FewjQqUi7pW4egmN5xvpxh5_RS-tT+_d9K6OK2DMn=PBA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 at 21:11, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/12 21:16, Daniel Vacek =E5=86=99=E9=81=93:
> > On Tue, 11 Nov 2025 at 21:33, Qu Wenruo <wqu@suse.com> wrote:
> >> =E5=9C=A8 2025/11/11 23:08, Daniel Vacek =E5=86=99=E9=81=93:
> >>> On Mon, 10 Nov 2025 at 22:05, Qu Wenruo <wqu@suse.com> wrote:
> >>>> =E5=9C=A8 2025/11/11 05:10, Daniel Vacek =E5=86=99=E9=81=93:
> >>>>> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>
> >>>>>> [ENHANCEMENT]
> >>>>>> Btrfs currently calculate its data checksum then submit the bio.
> >>>>>>
> >>>>>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered=
 write
> >>>>>> if the inode requires checksum"), any writes with data checksum wi=
ll
> >>>>>> fallback to buffered IO, meaning the content will not change durin=
g
> >>>>>> writeback.
> >>>>>>
> >>>>>> This means we're safe to calculate the data checksum and submit th=
e bio
> >>>>>> in parallel, and only need the following new behaviors:
> >>>>>>
> >>>>>> - Wait the csum generation to finish before calling btrfs_bio::end=
_io()
> >>>>>>      Or we can lead to use-after-free for the csum generation work=
er.
> >>>>>>
> >>>>>> - Save the current bi_iter for csum_one_bio()
> >>>>>>      As the submission part can advance btrfs_bio::bio.bi_iter, if=
 not
> >>>>>>      saved csum_one_bio() may got an empty bi_iter and do not gene=
rate any
> >>>>>>      checksum.
> >>>>>>
> >>>>>>      Unfortunately this means we have to increase the size of btrf=
s_bio for
> >>>>>>      16 bytes.
> >>>>>>
> >>>>>> As usual, such new feature is hidden behind the experimental flag.
> >>>>>>
> >>>>>> [THEORETIC ANALYZE]
> >>>>>> Consider the following theoretic hardware performance, which shoul=
d be
> >>>>>> more or less close to modern mainstream hardware:
> >>>>>>
> >>>>>>            Memory bandwidth:       50GiB/s
> >>>>>>            CRC32C bandwidth:       45GiB/s
> >>>>>>            SSD bandwidth:          8GiB/s
> >>>>>>
> >>>>>> Then btrfs write bandwidth with data checksum before the patch wou=
ld be
> >>>>>>
> >>>>>>            1 / ( 1 / 50 + 1 / 45 + 1 / 8) =3D 5.98 GiB/s
> >>>>>>
> >>>>>> After the patch, the bandwidth would be:
> >>>>>>
> >>>>>>            1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) =3D 6.90 GiB/s
> >>>>>>
> >>>>>> The difference would be 15.32 % improvement.
> >>>>>>
> >>>>>> [REAL WORLD BENCHMARK]
> >>>>>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 =
vCPUs, the
> >>>>>> storage is backed by a PCIE gen3 x4 NVME SSD.
> >>>>>>
> >>>>>> The test is a direct IO write, with 1MiB block size, write 7GiB da=
ta
> >>>>>> into a btrfs mount with data checksum. Thus the direct write will =
fallback
> >>>>>> to buffered one:
> >>>>>>
> >>>>>> Vanilla Datasum:        1619.97 GiB/s
> >>>>>> Patched Datasum:        1792.26 GiB/s
> >>>>>> Diff                    +10.6 %
> >>>>>>
> >>>>>> In my case, the bottleneck is the storage, thus the improvement is=
 not
> >>>>>> reaching the theoretic one, but still some observable improvement.
> >>>>>>
> >>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>>> ---
> >>>>>>     fs/btrfs/bio.c       | 21 +++++++++++----
> >>>>>>     fs/btrfs/bio.h       |  7 +++++
> >>>>>>     fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-----=
--------
> >>>>>>     fs/btrfs/file-item.h |  2 +-
> >>>>>>     4 files changed, 69 insertions(+), 25 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> >>>>>> index 5a5f23332c2e..8af2b68c2d53 100644
> >>>>>> --- a/fs/btrfs/bio.c
> >>>>>> +++ b/fs/btrfs/bio.c
> >>>>>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, =
blk_status_t status)
> >>>>>>            /* Make sure we're already in task context. */
> >>>>>>            ASSERT(in_task());
> >>>>>>
> >>>>>> +       if (bbio->async_csum)
> >>>>>> +               wait_for_completion(&bbio->csum_done);
> >>>>>
> >>>>> Can we do `flush_work(&bbio->csum_work);` instead here and get rid =
of
> >>>>> the completion? I believe it is not needed at all.
> >>>>
> >>>> I tried this idea, unfortunately causing kernel warnings.
> >>>>
> >>>> It will trigger a warning inside __flush_work(), triggering the warn=
ing
> >>>> from check_flush_dependency().
> >>>>
> >>>> It looks like the workqueue we're in (btrfs-endio) has a different
> >>>> WQ_MEM_RECLAIM flag for csum_one_bio_work().
> >>>
> >>> If I read the code correctly that would be solved using the
> >>> btrfs_end_io_wq instead of system wq (ie. queue_work() instead of
> >>> schedule_work()).
> >>
> >> That will cause dependency problems. The endio work now depends on the
> >> csum work, which are both executed on the same workqueue.
> >> If the max_active is 1, endio work will deadlock waiting for the csum =
one.
> >
> > When the csum work is being queued the bio was not even submitted yet.
> > The chances are the csum work will be done even before the bio ends
> > and the end io work is queued. But even if csum work is not done yet
> > (or even started due to scheduling delays or previous (unrelated)
> > worker still being blocked), it's always serialized before the end io
> > work. So IIUC, there should be no deadlock possible. Unless I'm still
> > missing something, workqueues could be tricky.
> >
> >>>> +       init_completion(&bbio->csum_done);
> >>>> +       bbio->async_csum =3D true;
> >>>> +       bbio->csum_saved_iter =3D bbio->bio.bi_iter;
> >>>> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> >>>> +       schedule_work(&bbio->csum_work);
> >>>
> >>> queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
> >>
> >> Nope, I even created a new workqueue for the csum work, and it doesn't
> >> workaround the workqueue dependency check.
> >
> > Did you create it with the WQ_MEM_RECLAIM flag? As like:
> >
> > alloc_workqueue("btrfs-async-csum", ... | WQ_MEM_RECLAIM, ...);
>
> Yes.
>
> >
> > I don't see how that would trigger the warning. See below for a
> > detailed explanation.
>
> It's not the workqueue running the csum work, but the workqueue running
> the flush_work().

The wq running the flush_work() is in the warning condition. *But* the
early return checks the csum wq.

> >
> >> The check inside check_flush_dependency() is:
> >>
> >>           WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
> >>                                 (WQ_MEM_RECLAIM | __WQ_LEGACY)) =3D=3D
> >> WQ_MEM_RECLAIM),
> >>
> >> It means the worker can not have WQ_MEM_RECLAIM flag at all. (unless i=
t
> >> also has the LEGACY flag)
> >
> > I understand that if the work is queued on a wq with WQ_MEM_RECLAIM,
> > the check_flush_dependency() returns early. Hence no need to worry
> > about the warning's condition as it's no longer of any concern.
>
> You can just try to use flush_work() and test it by yourself.
>
> I have tried my best to explain it, but it looks like it's at my limit.
>
> Just try a patch removing the csum_wait, and use flush_work() instead of
> wait_for_completion().
>
> Then you'll see the problem I'm hitting.

No luck. With the change below all fstests pass without any warning or
deadlocks whatsoever. Just as I expected.
I don't think there would be any impact on performance, but that needs
to be tested and confirmed.

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index aba452dd9904..02b40d6fa13f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -108,7 +108,8 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio,
blk_status_t status)
        ASSERT(in_task());

        if (bbio->async_csum)
-               wait_for_completion(&bbio->csum_done);
+               flush_work(&bbio->csum_work);

        bbio->bio.bi_status =3D status;
        if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 5015e327dbd9..11eb8bcab94d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -58,7 +58,7 @@ struct btrfs_bio {
                        struct btrfs_ordered_extent *ordered;
                        struct btrfs_ordered_sum *sums;
                        struct work_struct csum_work;
-                       struct completion csum_done;
                        struct bvec_iter csum_saved_iter;
                        u64 orig_physical;
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d2ecd26727ac..f69fa943d3e0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -790,7 +790,15 @@ static void csum_one_bio_work(struct work_struct *work=
)
        ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
        ASSERT(bbio->async_csum =3D=3D true);
        csum_one_bio(bbio, &bbio->csum_saved_iter);
-       complete(&bbio->csum_done);
+}
+
+static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_fs_info *fs_i=
nfo,
+                                                struct bio *bio)
+{
+       if (bio->bi_opf & REQ_META)
+               return fs_info->endio_meta_workers;
+       return fs_info->endio_workers;
 }

 /*
@@ -823,12 +831,13 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool a=
sync)
                csum_one_bio(bbio, &bbio->bio.bi_iter);
                return 0;
        }
-       init_completion(&bbio->csum_done);
        bbio->async_csum =3D true;
        bbio->csum_saved_iter =3D bbio->bio.bi_iter;
        INIT_WORK(&bbio->csum_work, csum_one_bio_work);
-       schedule_work(&bbio->csum_work);
+       queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
        return 0;
 }

> Thanks,
> Qu
>
> >
> >> So nope, the flush_work() idea won't work inside any current btrfs
> >> workqueue, which all have WQ_MEM_RECLAIM flag set.
> >
> > With the above being said, I still see two possible solutions.
> > Either using the btrfs_end_io_wq() as suggested before. It should be sa=
fe, IMO.
> > Or, if you're still worried about possible deadlocks, creating a new
> > dedicated wq which also has the WQ_MEM_RECLAIM set (which is needed
> > for compatibility with the context where we want to call the
> > flush_work()).
> >
> > Both ways could help getting rid of the completion in btrfs_bio, which
> > is 32 bytes by itself.
> >
> > What do I miss?
> >
> > Out of curiosity, flush_work() internally also uses completion in
> > pretty much exactly the same way as in this patch, but it's on the
> > caller's stack (in this case on the stack which would call the
> > btrfs_bio_end_io() modified with flush_work()). So in the end the
> > effect would be like moving the completion from btrfs_bio to a stack.
> >
> >> What we need is to make endio_workers and rmw_workers to get rid of
> >> WQ_MEM_RECLAIM, but that is a huge change and may not even work.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>>> I'll keep digging to try to use flush_work() to remove the csum_done=
, as
> >>>> that will keep the size of btrfs_bio unchanged.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>>
> >>>>> --nX
> >>>>>
> >>>>
> >>>>>>
> >>>>
> >>
>

