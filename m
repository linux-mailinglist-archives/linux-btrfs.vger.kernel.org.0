Return-Path: <linux-btrfs+bounces-15707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E621B137A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6FD17882A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8461225785;
	Mon, 28 Jul 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNSRLfQp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E170825
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695557; cv=none; b=Wp5HL4KKSUABjJ5BMYENQyuSdpin5kdTGAIafdkPQz0CDtrHvmmnrNDhjomSYpIKm0Sk0xYuimwTJZG8sGe8hv9HC5bty3WUIHshXYo0M27wNCOTyYV5vT0dDjHJRqX+PqtllV90dyCJduT75QQ3OQVsn6jpYl1PBAZIQkSGh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695557; c=relaxed/simple;
	bh=DLnYpiGiWBmFHsOMYWwNL/ix50o1NCdWq4lAov9EzYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx6vab42I3DZ/uSy2BH8zG0I8IDTXRAu/Og2Wh7aVMVn1nqjiRKkAJyhO9vOdMw8+SF+sg4iUksbBabKH7gS5ivUIXmgyGlhp9X49TYOHdk23EP48/1dTJcsml+BUnt+1nFckuF2paBD26w+Z8p4F0ASI/WFrkl8qfmCz2yn4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNSRLfQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAF9C4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 09:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695556;
	bh=DLnYpiGiWBmFHsOMYWwNL/ix50o1NCdWq4lAov9EzYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jNSRLfQp968H8fJFvvLhqQnq9IXdI9Ua49o1pKq58INCodwcZd/i0+EiMp0jdPwDR
	 WjJHcAsYFvejFB/FhS6ON3Zbdw4vgb3ovSxrS6hr9EWD+8RdFqyhM5uTeI5qKwVCU7
	 QoG77a8TmXI/KjsFQ9K7m7dlSgwiq81aiS59W3tZiUUdRLkP9NFJjFrk4hKjor6uXF
	 Wz3N35vHWthS9CZQT1uGl/9JV75ooeUcfyA9RtUWGQgQSagezivn4mi5QNQG+/wfuw
	 O5s1RIFdCltuSoAX6f4EoFlFNnLEO8mQZu+CFJEFA71qnRscYZ6ZBSU43+RTo8dwcB
	 veK5OS0GUMx2A==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so809410a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 02:39:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YxWCtl02eIqJWDRFT/fLqnGlhwxUjOH3godQIGQ5q7m9TLm+vnt
	ow+LFmnysYIlwS1yuWs/TP/l2/uMepYgjJPk88bCDzGypldrTBnBjjCYIw0Ni03Pmy8Tx+M8GMa
	YgNR3xpAAruFlmPMRMMSk7kuXFgQf1Qk=
X-Google-Smtp-Source: AGHT+IGZS0yTSUWjA+Csg1ziZpjwI1jiwgK/LhZww6VMCFyGW+fPggnwQKII5hlYKfx9/N2SR/eZ+Mu71/zdKcNgJoY=
X-Received: by 2002:a17:907:7254:b0:ae0:b33d:2a4a with SMTP id
 a640c23a62f3a-af61e051379mr1052866966b.35.1753695555158; Mon, 28 Jul 2025
 02:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bbc7c6af95f7628d4d0a517358e7e9c2e421ccc5.1753441296.git.wqu@suse.com>
 <CAL3q7H5yk9PWo3JD-fLM5UZ=2E8CNrW6hJ+8OB4bFiYfKjBMVA@mail.gmail.com> <a765c0a9-f223-4a10-8ddb-80bb0ebff42e@suse.com>
In-Reply-To: <a765c0a9-f223-4a10-8ddb-80bb0ebff42e@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 28 Jul 2025 10:38:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6fQQiYhMq_PnhT+GwuUW_OX_p+yvC9FOmy06OKWnoMFA@mail.gmail.com>
X-Gm-Features: Ac12FXyfWw4Nmwled0HalFq4lJKQApIHfAu8KWXKnyewaERnIUq4zKix-Nh34ag
Message-ID: <CAL3q7H6fQQiYhMq_PnhT+GwuUW_OX_p+yvC9FOmy06OKWnoMFA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: do not allow relocation of partially dropped subvolumes
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:06=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/7/25 20:39, Filipe Manana =E5=86=99=E9=81=93:
> > On Fri, Jul 25, 2025 at 12:05=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote=
:
> >>
> >> [BUG]
> >> There is an internal report that balance triggered transaction abort,
> >> with the following call trace:
> >>
> >>    item 85 key (594509824 169 0) itemoff 12599 itemsize 33
> >>            extent refs 1 gen 197740 flags 2
> >>            ref#0: tree block backref root 7
> >>    item 86 key (594558976 169 0) itemoff 12566 itemsize 33
> >>            extent refs 1 gen 197522 flags 2
> >>            ref#0: tree block backref root 7
> >>   ...
> >>   BTRFS error (device loop0): extent item not found for insert, bytenr=
 594526208 num_bytes 16384 parent 449921024 root_objectid 934 owner 1 offse=
t 0
> >>   BTRFS error (device loop0): failed to run delayed ref for logical 59=
4526208 num_bytes 16384 type 182 action 1 ref_mod 1: -117
> >>   ------------[ cut here ]------------
> >>   BTRFS: Transaction aborted (error -117)
> >>   WARNING: CPU: 1 PID: 6963 at ../fs/btrfs/extent-tree.c:2168 btrfs_ru=
n_delayed_refs+0xfa/0x110 [btrfs]
> >>
> >> And btrfs check doesn't report anything wrong related to the extent
> >> tree.
> >>
> >> [CAUSE]
> >> The cause is a little complex, firstly the extent tree indeed doesn't
> >> have the backref for 594526208.
> >>
> >> The extent tree only have the following two backrefs around that byten=
r
> >> on-disk:
> >>
> >>          item 65 key (594509824 METADATA_ITEM 0) itemoff 13880 itemsiz=
e 33
> >>                  refs 1 gen 197740 flags TREE_BLOCK
> >>                  tree block skinny level 0
> >>                  (176 0x7) tree block backref root CSUM_TREE
> >>          item 66 key (594558976 METADATA_ITEM 0) itemoff 13847 itemsiz=
e 33
> >>                  refs 1 gen 197522 flags TREE_BLOCK
> >>                  tree block skinny level 0
> >>                  (176 0x7) tree block backref root CSUM_TREE
> >>
> >> But the such missing backref item is not an corruption on disk, as the
> >> offending delayed ref belongs to subvolume 934, and that subvolume is
> >> being dropped:
> >>
> >>          item 0 key (934 ROOT_ITEM 198229) itemoff 15844 itemsize 439
> >>                  generation 198229 root_dirid 256 bytenr 10741039104 b=
yte_limit 0 bytes_used 345571328
> >>                  last_snapshot 198229 flags 0x1000000000001(RDONLY) re=
fs 0
> >>                  drop_progress key (206324 EXTENT_DATA 2711650304) dro=
p_level 2
> >>                  level 2 generation_v2 198229
> >>
> >> And that offending tree block 594526208 is inside the dropped range of
> >> that subvolume.
> >> That explains why there is no backref item for that bytenr and why btr=
fs
> >> check is not reporting anything wrong.
> >>
> >> But this also shows another problem, as btrfs will do all the orphan
> >> subvolume cleanup at a read-write mount.
> >>
> >> So half-dropped subvolume should not exist after an RW mount, and
> >> balance itself is also exclusive to subvolume cleanup, meaning we
> >> shouldn't hit a subvolume half-dropped during relocation.
> >>
> >> The root cause is, there is no orphan item for this subvolume.
> >> In fact there are 5 subvolumes around 2021 that have the same problem.
> >>
> >> It looks like the original report has some older kernels running, and
> >> caused those zombie subvolumes.
> >>
> >> Thankfully upstream commit 8d488a8c7ba2 ("btrfs: fix subvolume/snapsho=
t
> >> deletion not triggered on mount") has long fixed the bug.
> >>
> >> [ENHANCEMENT]
> >> For repairing such old fs, btrfs-progs will be enhanced.
> >>
> >> Considering how delayed the problem will show up (at run delayed ref
> >> time) and at that time we have to abort transaction already, it is too
> >> late.
> >>
> >> Instead here we reject any half-dropped subvolume for reloc tree at th=
e
> >> earliest time, preventing confusion and extra time wasted on debugging
> >> similar bugs.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Update the subject to reflect the change better
> >> - Fix a memory leak when the check is triggered
> >> - Make the error message less confusing
> >>    All thanks to Filipe.
> >> ---
> >>   fs/btrfs/relocation.c | 19 +++++++++++++++++++
> >>   1 file changed, 19 insertions(+)
> >>
> >> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> >> index 60dd3971c3ae..c33c591b23f2 100644
> >> --- a/fs/btrfs/relocation.c
> >> +++ b/fs/btrfs/relocation.c
> >> @@ -602,6 +602,25 @@ static struct btrfs_root *create_reloc_root(struc=
t btrfs_trans_handle *trans,
> >>          if (btrfs_root_id(root) =3D=3D objectid) {
> >>                  u64 commit_root_gen;
> >>
> >> +               /*
> >> +                * Relocation will wait for cleaner thread, and any ha=
lf-dropped
> >> +                * subvolume will be fully cleaned up at mount time.
> >> +                * So here we shouldn't hit a subvolume with non-zero =
drop_progress.
> >> +                *
> >> +                * If this isn't the case, error out since it can make=
 us attempt to
> >> +                * drop references for extents that were already dropp=
ed before.
> >> +                */
> >> +               if (unlikely(btrfs_disk_key_objectid(&root->root_item.=
drop_progress))) {
> >> +                       struct btrfs_key cpu_key;
> >> +
> >> +                       btrfs_disk_key_to_cpu(&cpu_key, &root->root_it=
em.drop_progress);
> >> +                       btrfs_err(fs_info,
> >> +       "can not relocate partially dropped subvolume %llu, drop progr=
ess key (%llu %u %llu)",
> >> +                                 objectid, cpu_key.objectid, cpu_key.=
type, cpu_key.offset);
> >> +                       ret =3D -EUCLEAN;
> >> +                       goto fail;
> >> +               }
> >
> > Sorry I forgot to point this out before, but why isn't this placed
> > outside the if statement?
> > I.e., before the "if (btrfs_root_id(root) =3D=3D objectid)"
>
> For the root_id !=3D objectid case, it's btrfs_reloc_post_snapshot() for =
a
> reloc tree.
>
> In that case won't the reloc tree being merged thus got a non-zero drop
> progress and trigger a false alert here?

Yes, that should be right.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Thanks,
> Qu
>
> > and even
> > before allocating the root_item?
> >
> > I don't see a reason why not.
>
> >
> > Thanks.
> >
> >> +
> >>                  /* called by btrfs_init_reloc_root */
> >>                  ret =3D btrfs_copy_root(trans, root, root->commit_roo=
t, &eb,
> >>                                        BTRFS_TREE_RELOC_OBJECTID);
> >> --
> >> 2.50.1
> >>
> >>
>

