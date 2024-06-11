Return-Path: <linux-btrfs+bounces-5648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE790391E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268EC2875AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B5178CC1;
	Tue, 11 Jun 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZAM8SMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410D7407C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102547; cv=none; b=qureGOCR1O1vjsULIXvszkasvkGFsdhXC3wkNxWwfSjIwi33Dd9Q1rVbkWfTcZxH+ahG96QTreugi3YhvzWG+/3tqy4p+LAYlfKQ5ulDi4cuqbt8luvD19qrXrSzoPcmWNFYjbZmUHlenZCwAWUup/m+mJpbTf39TmW0yfl5fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102547; c=relaxed/simple;
	bh=h2oW2kGe1himt+kVUdFiY8vdMmG6Uj5udL9O2BxVrT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Inrea46gv+7HFph+oFZJloZR5sQDxIA6NXJf3QbYrQzciyQ+o1MAkQpbh+89ZvBzGUEtjzGijvL5ehWVQt8eVWlhAOF57uO5Awo/tTaY4v+x41L/lJxTkBFV434wPWOu5b+I5GePrq5ppI6SMh/e4mWgR8vFeO6puMI2FBMgiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZAM8SMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70885C32786
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 10:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102547;
	bh=h2oW2kGe1himt+kVUdFiY8vdMmG6Uj5udL9O2BxVrT8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BZAM8SMDoZ1PfOs9M1LoDdWRqAd0YR2jGCQ7+EL8MX4B9XP1hv+Ajf+EetmE8NZfl
	 +okuGyViJmpws+/oMYwuB6Y5qNmiZdf4F6WdJ0OOFMkc4upvqqpPOY0cAHOo+U4ivl
	 o/RB0lTNKcEh0jtncfCJy8wMS7ZeARIDo3SfleIqKcR5r/Ec0eFWwbeXo02fl0SIN3
	 yRadqidcGmm9uXEYPS4V5lUK3Zyi7J0jvmGcTIpfpMijmEtDr14653iDvpFX+L2Bt+
	 DAQc2MuUyq0zIRcpRh2chFiRNd0Mfta2d9aDVcYiZtC0dDXUy/H3/n19ub41IbKB11
	 JmaEqMH0419ew==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so11642260a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 03:42:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzbnxiE+vrmC4uxW24nAYfpAJPBiefRP9VFemDTSBQNHkBKcyY+
	Zh6LDygNaLSTiwM8+HJBG6zDEQJ2zSvzozfNP1F9d72uM2UwQUVwekka1T/EB62IZi4c3fPraAh
	8jfbRkRcu5Aa1IcOJp+44QWSR9YY=
X-Google-Smtp-Source: AGHT+IFPoFPVBDJXmdYfj8Efd2m/kmqCTMeMNzkwJppUEYhe8KI0mHbsFDDGAwkn2992lhPuu9b9V7ajqp2mDsQIIe0=
X-Received: by 2002:a17:906:7f8f:b0:a6f:3612:160 with SMTP id
 a640c23a62f3a-a6f3612032amr152895166b.14.1718102545968; Tue, 11 Jun 2024
 03:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ed106331a7ff61303c9e1c2930f8a7673b80a86.1717790627.git.boris@bur.io>
In-Reply-To: <3ed106331a7ff61303c9e1c2930f8a7673b80a86.1717790627.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 11 Jun 2024 11:41:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4OM96kcD=37KJix7Eg5jzAZ0HQaWB03OBvEGB8pEYyNA@mail.gmail.com>
Message-ID: <CAL3q7H4OM96kcD=37KJix7Eg5jzAZ0HQaWB03OBvEGB8pEYyNA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: retry bg reclaim without infinite loop
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:04=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> If inc_block_group_ro systematically fails (e.g. due to ETXTBUSY from
> swap!) or btrfs_relocate_chunk systematically fails (from lack of
> space), then this worker becomes an infinite loop.
>
> At the very least, this strands the cleaner thread, but can also result
> in hung tasks/rcu stalls on PREEMPT_NONE kernels and if the
> reclaim_bgs_lock mutex is not contended.
>
> I believe the best long term fix is to manage reclaim via work queue,
> where we queue up a relocation on the triggering condition and re-queue
> on failure. In the meantime, this is an easy fix to apply to avoid the
> immediate pain.
>
> Cc: stable@vger.kernel.org
> Fixes: 7e2718099438 ("btrfs: reinsert BGs failed to reclaim")
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9910bae89966..fe61fc2df950 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1792,6 +1792,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>                 container_of(work, struct btrfs_fs_info, reclaim_bgs_work=
);
>         struct btrfs_block_group *bg;
>         struct btrfs_space_info *space_info;
> +       LIST_HEAD(retry_list);
>
>         if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
>                 return;
> @@ -1928,8 +1929,11 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>                 }
>
>  next:
> -               if (ret)
> -                       btrfs_mark_bg_to_reclaim(bg);
> +               if (ret) {
> +                       // refcount held by the reclaim_bgs list after sp=
lice

Apart from the comment style as pointed out by Johannes before:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +                       btrfs_get_block_group(bg);
> +                       list_add_tail(&bg->bg_list, &retry_list);
> +               }
>                 btrfs_put_block_group(bg);
>
>                 mutex_unlock(&fs_info->reclaim_bgs_lock);
> @@ -1949,6 +1953,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>         spin_unlock(&fs_info->unused_bgs_lock);
>         mutex_unlock(&fs_info->reclaim_bgs_lock);
>  end:
> +       spin_lock(&fs_info->unused_bgs_lock);
> +       list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
> +       spin_unlock(&fs_info->unused_bgs_lock);
>         btrfs_exclop_finish(fs_info);
>         sb_end_write(fs_info->sb);
>  }
> --
> 2.45.2
>
>

