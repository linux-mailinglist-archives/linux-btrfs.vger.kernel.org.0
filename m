Return-Path: <linux-btrfs+bounces-17331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEBBB25A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 04:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CFF3A26F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 02:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5845232785;
	Thu,  2 Oct 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="U7EPR1Gx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBwvPcHr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F741218AB9
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759371611; cv=none; b=q6BCTSl82t6o5BFwxiDq7BGt0HXEksTeW9qN8pVHtYsDpKTMkrKTI22v0HQFUQOaBuoDPBmP3D0USjt9MOrM646KcQGsNfe4hYAqiKyPm/KctcqZeY46j2s62oQ9ivVpVdN6IscUknIhr9NmE2w4UxugJWVIrAnYOCfNeII+uC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759371611; c=relaxed/simple;
	bh=WaOuGrxQWBW/khbIyjNKdZrNYkBbwkfe0isxDEptgYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pccpWbbjq5kN3o6xgk+kprsjWgyjbC05DuIrU917M2LqobIvQv0YU5IzE0j/BCgdbo8vzKK+sMZ3zZ13OQwNxeo7k50iDRo5r8gsE6G9j9+YQlV5cWHPwguHaShabQoOA1+epvKA5Vc//F35Xa/IbeY3AD6JjzGw0bGnHLF9Nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=U7EPR1Gx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBwvPcHr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AF981D001C9;
	Wed,  1 Oct 2025 22:20:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 22:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759371608;
	 x=1759458008; bh=UStywN7gDRu61+OIGoRMEElk6OJZnyNz4uOgF2vHE5M=; b=
	U7EPR1GxDRli0reCHxPTE+p3bK68CtU6TjxwxHI5zcw2JrUSRueHMIbeOzBrNHtv
	yEJuluhesa2bEcMBRXf1FVq7sPpPh5QZiouLDIgK8pNdF+krsAq841AkIi+1a/yh
	y5QZVHErqvUERhFQ9afn05m1YFfxjokoBlSRv2d4/zWB+JyB5mRkCLEZl2iHc7s+
	afSv3iFQXZoYDdum89BM0XlS8lh0/8KRFrdA6AjFiPssZPs6+mOMjmQRZMoqd6fW
	hPIA0UJpU5GU7G6tbHUsC5f2kHErbCCiPIBME0R/8KdNWfhZMlX8LPxXwA9DGUGe
	ZryKUPqBP26EJ/XU5fPJLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759371608; x=
	1759458008; bh=UStywN7gDRu61+OIGoRMEElk6OJZnyNz4uOgF2vHE5M=; b=P
	BwvPcHrqTq65K2g/5KT8xtZzk6Sj9K3YCW0cicacVbnbPTu/jirvPqm/QWkX4Tj0
	UyN02iUlLsMeOUROImqTtnK2k8wE9HXVF99fzlwMslMP4EAQrNTpvBBWQ/H42r2f
	2dbjAzqb1A3jvdngZTLTVe3yfyNTj4RvqC89sBGKr8aF79ygSjRqtlzkfaN7ySmM
	hGQIwIW7+1JxJyg4LhU9qREQAManZmK/1rC0NQnoNO4/QjPE8Y5i78z+iDQyL1Tt
	7UAZ7eanhgXixiS34PRFnxggKchmE35uVIkdZ3pHqnKihwCF/N5/rnCP2QVdq0V5
	EaoG0qfZ8XosE72SmWIvQ==
X-ME-Sender: <xms:V-HdaIIC4dzZBFxRlQLDth9PufhyGLtmT135muemWwV0QWzSukBzpQ>
    <xme:V-HdaPnUuPHmv08x6-E6pRuwv-tiIFsStggTzUpgIJMg-taRR2Tr55Cvp1WwRq88_
    70QHaWEClV2VvPPQhsc_0sX-E2N-aqTfDbnYesE_ZGviwP83Pq8FdM>
X-ME-Received: <xmr:V-HdaGFsFHMLi6Xc5HxTXliTA3Hrcaa2d3bVVr5LFKalGevJPRzVg7iRawLQkdimLCqe_iGiHvk9YIuAiGGrCOFT2Bk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpedule
    fhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehf
    sgdrtghomh
X-ME-Proxy: <xmx:V-HdaPHOR0kQTDL-ITu4ipgJmtHZl0KzApAC3tnk0AmZDFuYsAHY7w>
    <xmx:V-HdaDMeDeYHY9CgkoGCzKg4-GNh52NYpNdVyF8JLdWt0iUzrS4ZRQ>
    <xmx:V-HdaOEuTdgYitRUl6IbGeIJ1oJK_4D3jkG2x8b6tnZ7DU2MCsnACw>
    <xmx:V-HdaKMlOjTUa71E1G2HiUAmp3NJSmPECx0A96a0o-9mYT8SJU6Zhg>
    <xmx:WOHdaItX_nmC2m7DuAd0jptum3eC46sfOkNti6Rwlyb0VjlGnYWlm39i>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 22:20:07 -0400 (EDT)
Date: Wed, 1 Oct 2025 19:20:05 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
Message-ID: <20251002022005.GA3549334@zen.localdomain>
References: <0d1622fd106eeefff16ae7f2d1b75a3058c3fa66.1759367390.git.boris@bur.io>
 <4a575172-4984-46b3-a82c-c3e3ba42819a@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a575172-4984-46b3-a82c-c3e3ba42819a@suse.com>

On Thu, Oct 02, 2025 at 11:19:42AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/10/2 10:40, Boris Burkov 写道:
> >  From the memory-barriers.txt document regarding memory barrier ordering
> > guarantees:
> > 
> >   (*) These guarantees do not apply to bitfields, because compilers often
> >       generate code to modify these using non-atomic read-modify-write
> >       sequences.  Do not attempt to use bitfields to synchronize parallel
> >       algorithms.
> > 
> >   (*) Even in cases where bitfields are protected by locks, all fields
> >       in a given bitfield must be protected by one lock.  If two fields
> >       in a given bitfield are protected by different locks, the compiler's
> >       non-atomic read-modify-write sequences can cause an update to one
> >       field to corrupt the value of an adjacent field.
> > 
> > btrfs_space_info has a bitfield sharing an underlying word consisting of
> > the fields full, chunk_alloc, and flush:
> > 
> > struct btrfs_space_info {
> >          struct btrfs_fs_info *     fs_info;              /*     0     8 */
> >          struct btrfs_space_info *  parent;               /*     8     8 */
> >          ...
> >          int                        clamp;                /*   172     4 */
> >          unsigned int               full:1;               /*   176: 0  4 */
> >          unsigned int               chunk_alloc:1;        /*   176: 1  4 */
> >          unsigned int               flush:1;              /*   176: 2  4 */
> >          ...
> > 
> > Therefore, to be safe from parallel read-modify-writes losing a write to
> > one of the bitfield members protected by a lock, all writes to all the
> > bitfields must use the lock. They almost universally do, except for
> > btrfs_clear_space_info_full() which iterates over the space_infos and
> > writes out found->full = 0 without a lock.
> > 
> > Imagine that we have one thread completing a transaction in which we
> > finished deleting a block_group and are thus calling
> > btrfs_clear_space_info_full() while simultaneously the data reclaim
> > ticket infrastructure is running do_async_reclaim_data_space():
> > 
> >            T1                                             T2
> > btrfs_commit_transaction
> >    btrfs_clear_space_info_full
> >    data_sinfo->full = 0
> >    READ: full:0, chunk_alloc:0, flush:1
> >                                                do_async_reclaim_data_space(data_sinfo)
> >                                                spin_lock(&space_info->lock);
> >                                                if(list_empty(tickets))
> >                                                  space_info->flush = 0;
> >                                                  READ: full: 0, chunk_alloc:0, flush:1
> >                                                  MOD/WRITE: full: 0, chunk_alloc:0, flush:0
> >                                                  spin_unlock(&space_info->lock);
> >                                                  return;
> >    MOD/WRITE: full:0, chunk_alloc:0, flush:1
> > 
> > and now data_sinfo->flush is 1 but the reclaim worker has exited. This
> > breaks the invariant that flush is 0 iff there is no work queued or
> > running. Once this invariant is violated, future allocations that go
> > into __reserve_bytes() will add tickets to space_info->tickets but will
> > see space_info->flush is set to 1 and not queue the work. After this,
> > they will block forever on the resulting ticket, as it is now impossible
> > to kick the worker again.
> > 
> > I also confirmed by looking at the assembly of the affected kernel that
> > it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
> > the assembly is:
> >    andb    $0xfb,0x60(%rbx)
> > and similarly for setting the full (1st) bit to 0:
> >    andb    $0xfe,-0x20(%rax)
> > 
> > So I think this is really a bug on practical systems.  I have observed
> > a number of systems in this exact state, but am currently unable to
> > reproduce it.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/space-info.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 0e5c0c80e0fe..5c2e567f3e9a 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -192,7 +192,11 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
> >   	struct btrfs_space_info *found;
> >   	list_for_each_entry(found, head, list)
> > +	{
> > +		spin_lock(&found->lock);
> >   		found->full = 0;
> > +		spin_unlock(&found->lock);
> > +	}
> 
> Using spin lock for a bitfield member looks overkilled to me.

We've already bought into doing it by having space_info->flush=0 under
space_info->lock be semantically important for the correct operation of
queueing the flushing work.

> 
> And it also means all accesses to that bit needs the lock, which looks
> impractical to acquire the lock.

All writes to any of the bits in the bitfield need the lock. Reads from
bit A can't harm bit B, as far as I know. All other writes to any of the
three bits already take the lock.

> 
> Can't we put all the 3 bits into a bitmap so that we can use all those
> atomic bit helpers instead?
> (Still a lot of change, but more practical)

We can of course do that, but I do believe that this change is
sufficient. If we do go this way, I will also document it in struct
btrfs_space_info.

Alternatively, there is a 29 bit gap in the struct after the bitfield
anyway, so we can just make them bools and not make the struct bigger.

If people prefer, I can of course refactor them all into using a bitmap
and atomic bit helpers, but I just wanted to send the minimal change
first.

> 
> Thanks,
> Qu

Thanks,
Boris

> 
> >   }
> >   /*
> 

