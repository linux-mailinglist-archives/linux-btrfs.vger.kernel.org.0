Return-Path: <linux-btrfs+bounces-15671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF6B11D4C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 13:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B021C80B80
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503792E5B14;
	Fri, 25 Jul 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLBwhNnW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E04217F33
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441812; cv=none; b=Bpg+mPZk4hbCUw5sbhPKYwqHumCwm/Ts1VuNgYfdG6YLoEuEfts/1zwFvRHdt7Q3b7w59JMODPJTtMTsxUSoQlm/hK4LY7Ety531DblvZzHPSQbp+w/qc521WdE4bhKMM1MKosFdeC8CwtiRSfQeA6JY6kHEiD9hlUxyUCI3yG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441812; c=relaxed/simple;
	bh=JOV6xffi9LFWR3tMeTB3a8ENwDuBRrAwC0Xj++dyCnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY3T6piA3WI5ME4T4DPcHP+Jc1FYn2+2vVBbIwkxvAYAr97e7jH/rUKj0nB/Gb34IxIWnVAd/4sG41DX89mE/XtjLzfbm1FZN0IiZvjQy2OkekBA7D9angDnXr+pDlBmeP/qS32/SrfaDPzscDG+ZuAZr9FK/qIVE08nFCZg3fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLBwhNnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23138C4CEEF
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753441812;
	bh=JOV6xffi9LFWR3tMeTB3a8ENwDuBRrAwC0Xj++dyCnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XLBwhNnWhfmr3M3Fawkx33/P7RFlaAPKjn5hQmb80QO8OjYyIlLLa6MpFhlmJWo0s
	 T1lDlRCRjGCuUYvyf7SVZ3oOuo2/f6+b0jIWk8NF4oF+cjZ2kxzCMpDI2kLy+Wn0na
	 mEB2Y7M6UeYC1QQf5q/a8fG9YprrmybQ275MFCnLWLP8n2pQbjhtv0zNNcIpBeDSuJ
	 LFkXAWGXC6En9PbFBh82lFT1l7CgZOgy1uAq01QTUXG9Zc+aTLyj8eXxaqv/gTjHWT
	 y5SC+/LkjapACPf23ciQMoxNGpoFjkjOK9YLvueaumTEpOQQCsdR/kS6CAq53aC4HG
	 /WJUfCISL14bg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so3954788a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 04:10:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfopWVgS/d+OYS4wKqewL5dvCrHtTGSXBQOrAHVj119XdkgXbO
	6+377D7ZqMdJL59pUDgk6tXmUXhywHQv+CfRw5+pVBNNHJxx77Ur06KTvtmWrRUymcWIkzzp0qU
	AR/eqHuWtQNKdisdQP3nfeQFkifd8QF0=
X-Google-Smtp-Source: AGHT+IGDGOMi4Mc2qspig6Ye2z/WAsuN/N3c7aSbONUlEOBRH4xtEx/I/iKIAwIgEf4Vf7lRST6EFwfrLBBBA/ZBgN8=
X-Received: by 2002:a17:906:f596:b0:ae9:8dc8:4f32 with SMTP id
 a640c23a62f3a-af617904ec2mr198963966b.27.1753441810728; Fri, 25 Jul 2025
 04:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bbc7c6af95f7628d4d0a517358e7e9c2e421ccc5.1753441296.git.wqu@suse.com>
In-Reply-To: <bbc7c6af95f7628d4d0a517358e7e9c2e421ccc5.1753441296.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 25 Jul 2025 12:09:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5yk9PWo3JD-fLM5UZ=2E8CNrW6hJ+8OB4bFiYfKjBMVA@mail.gmail.com>
X-Gm-Features: Ac12FXyai5-suSQ0U1qJkOsV9O8f4tiWMDQKdYCrGsTxT9mMBsWrqaPP3qCS4I8
Message-ID: <CAL3q7H5yk9PWo3JD-fLM5UZ=2E8CNrW6hJ+8OB4bFiYfKjBMVA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: do not allow relocation of partially dropped subvolumes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:05=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> There is an internal report that balance triggered transaction abort,
> with the following call trace:
>
>   item 85 key (594509824 169 0) itemoff 12599 itemsize 33
>           extent refs 1 gen 197740 flags 2
>           ref#0: tree block backref root 7
>   item 86 key (594558976 169 0) itemoff 12566 itemsize 33
>           extent refs 1 gen 197522 flags 2
>           ref#0: tree block backref root 7
>  ...
>  BTRFS error (device loop0): extent item not found for insert, bytenr 594=
526208 num_bytes 16384 parent 449921024 root_objectid 934 owner 1 offset 0
>  BTRFS error (device loop0): failed to run delayed ref for logical 594526=
208 num_bytes 16384 type 182 action 1 ref_mod 1: -117
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -117)
>  WARNING: CPU: 1 PID: 6963 at ../fs/btrfs/extent-tree.c:2168 btrfs_run_de=
layed_refs+0xfa/0x110 [btrfs]
>
> And btrfs check doesn't report anything wrong related to the extent
> tree.
>
> [CAUSE]
> The cause is a little complex, firstly the extent tree indeed doesn't
> have the backref for 594526208.
>
> The extent tree only have the following two backrefs around that bytenr
> on-disk:
>
>         item 65 key (594509824 METADATA_ITEM 0) itemoff 13880 itemsize 33
>                 refs 1 gen 197740 flags TREE_BLOCK
>                 tree block skinny level 0
>                 (176 0x7) tree block backref root CSUM_TREE
>         item 66 key (594558976 METADATA_ITEM 0) itemoff 13847 itemsize 33
>                 refs 1 gen 197522 flags TREE_BLOCK
>                 tree block skinny level 0
>                 (176 0x7) tree block backref root CSUM_TREE
>
> But the such missing backref item is not an corruption on disk, as the
> offending delayed ref belongs to subvolume 934, and that subvolume is
> being dropped:
>
>         item 0 key (934 ROOT_ITEM 198229) itemoff 15844 itemsize 439
>                 generation 198229 root_dirid 256 bytenr 10741039104 byte_=
limit 0 bytes_used 345571328
>                 last_snapshot 198229 flags 0x1000000000001(RDONLY) refs 0
>                 drop_progress key (206324 EXTENT_DATA 2711650304) drop_le=
vel 2
>                 level 2 generation_v2 198229
>
> And that offending tree block 594526208 is inside the dropped range of
> that subvolume.
> That explains why there is no backref item for that bytenr and why btrfs
> check is not reporting anything wrong.
>
> But this also shows another problem, as btrfs will do all the orphan
> subvolume cleanup at a read-write mount.
>
> So half-dropped subvolume should not exist after an RW mount, and
> balance itself is also exclusive to subvolume cleanup, meaning we
> shouldn't hit a subvolume half-dropped during relocation.
>
> The root cause is, there is no orphan item for this subvolume.
> In fact there are 5 subvolumes around 2021 that have the same problem.
>
> It looks like the original report has some older kernels running, and
> caused those zombie subvolumes.
>
> Thankfully upstream commit 8d488a8c7ba2 ("btrfs: fix subvolume/snapshot
> deletion not triggered on mount") has long fixed the bug.
>
> [ENHANCEMENT]
> For repairing such old fs, btrfs-progs will be enhanced.
>
> Considering how delayed the problem will show up (at run delayed ref
> time) and at that time we have to abort transaction already, it is too
> late.
>
> Instead here we reject any half-dropped subvolume for reloc tree at the
> earliest time, preventing confusion and extra time wasted on debugging
> similar bugs.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Update the subject to reflect the change better
> - Fix a memory leak when the check is triggered
> - Make the error message less confusing
>   All thanks to Filipe.
> ---
>  fs/btrfs/relocation.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 60dd3971c3ae..c33c591b23f2 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -602,6 +602,25 @@ static struct btrfs_root *create_reloc_root(struct b=
trfs_trans_handle *trans,
>         if (btrfs_root_id(root) =3D=3D objectid) {
>                 u64 commit_root_gen;
>
> +               /*
> +                * Relocation will wait for cleaner thread, and any half-=
dropped
> +                * subvolume will be fully cleaned up at mount time.
> +                * So here we shouldn't hit a subvolume with non-zero dro=
p_progress.
> +                *
> +                * If this isn't the case, error out since it can make us=
 attempt to
> +                * drop references for extents that were already dropped =
before.
> +                */
> +               if (unlikely(btrfs_disk_key_objectid(&root->root_item.dro=
p_progress))) {
> +                       struct btrfs_key cpu_key;
> +
> +                       btrfs_disk_key_to_cpu(&cpu_key, &root->root_item.=
drop_progress);
> +                       btrfs_err(fs_info,
> +       "can not relocate partially dropped subvolume %llu, drop progress=
 key (%llu %u %llu)",
> +                                 objectid, cpu_key.objectid, cpu_key.typ=
e, cpu_key.offset);
> +                       ret =3D -EUCLEAN;
> +                       goto fail;
> +               }

Sorry I forgot to point this out before, but why isn't this placed
outside the if statement?
I.e., before the "if (btrfs_root_id(root) =3D=3D objectid)" and even
before allocating the root_item?

I don't see a reason why not.

Thanks.

> +
>                 /* called by btrfs_init_reloc_root */
>                 ret =3D btrfs_copy_root(trans, root, root->commit_root, &=
eb,
>                                       BTRFS_TREE_RELOC_OBJECTID);
> --
> 2.50.1
>
>

