Return-Path: <linux-btrfs+bounces-21532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J3+ECKsiWmXAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21532-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:42:58 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB1C10DAC7
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01A03008A42
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417A363C7C;
	Mon,  9 Feb 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY1uJz8e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F12DCC1F
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630153; cv=none; b=FRplXDDuifwRJxHI0aqMw/qSW23oie1R/HixnTUl+2MnWue38tisAN/1NA4ToMJ18DFq8QbQ1vMq56euLnHBEnzftsM1NC1uJ17G/T0/TbK/cbDJTmHro24yVVPp+BnDgYp7wveHJIGuWD3OGcoRkqrW8uM4Q9sHHYhk6vjIlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630153; c=relaxed/simple;
	bh=jDE2mTm//9V8BqKt5YMTDaS9qwTYW561s5LZhr0mcI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX6BNWQAT+kgySTH2qEM1Za81hoDnj1vU9PDB3j2fuMeCBIkF1AOQBGzW3bKTwKEvFHkmEudepPUNnGkYUZPoT4FegQntHMzIEh8lh2V+ClsrnLqK2oO7HVVj+CunxtCHeFAWXvUFsZ7VRVSmoBMypE8Yz2Es9tmhwyLuGMddZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY1uJz8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1390C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770630152;
	bh=jDE2mTm//9V8BqKt5YMTDaS9qwTYW561s5LZhr0mcI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UY1uJz8eZIPb+0HmaYZk8HY8qfn8uRKzOps8sMsw2O3RXZLVnyl9eVEOiksFLGyQC
	 1a0hSAN8zltvoGMeqIPcPusbZpYkRg/fBuPvO/CWfjEMGy169Pj6VUg+AiIuOlZwqe
	 qwCc1neGEN+POYJU32pr+mJP/fRnxnIMmeUvUba87orjaM9KpEW1rrzJrrquu34oNF
	 CuyFgR+tyi3DPcn2eodqgIy9t60N/SKRuEW7JFA1A0LT1eu20n93pfBcSCT4EMwtsK
	 LCewIIjkwqvUKurL7DobFaHLCmrVH4otooxq8U4JbWBdJC2m06wzPCbSaMoizHFNnY
	 0eUztjJ+K+e5A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8ea3d15580so375802466b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:42:32 -0800 (PST)
X-Gm-Message-State: AOJu0Ywdm5P9+NwJY8mGEyX6mTP0H2BOSB/7WL+mNN1spkqcjuz/Vjk8
	QCZku8fnMqpYNfewvNrBuUFFGDBSGtVUWdULZFC5YJMFDWgrJu3SkvRGmQ1Mgrp3uC9touBNfDJ
	mUl6jPp9JD5vBRus2fIRl6yMGu1UVuI8=
X-Received: by 2002:a17:907:9723:b0:b88:6062:7078 with SMTP id
 a640c23a62f3a-b8edf2fbb71mr632140066b.30.1770630151402; Mon, 09 Feb 2026
 01:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
 <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com> <58b91c8e-6728-45f7-9de9-11c1b3e959e5@suse.com>
In-Reply-To: <58b91c8e-6728-45f7-9de9-11c1b3e959e5@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:41:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6dpXiR9dAXZ+kKXPMbrUVL9qS6E+Nx0Cfrrm2wj4Gshg@mail.gmail.com>
X-Gm-Features: AZwV_QidDmvy5LEwsyKRZ3sb2ofY36oB1xPdbBh7en8oCkBkHM8J-UoWxSimSDg
Message-ID: <CAL3q7H6dpXiR9dAXZ+kKXPMbrUVL9qS6E+Nx0Cfrrm2wj4Gshg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix the inline compressed extent check in inode_need_compress()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21532-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DFB1C10DAC7
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 9:37=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/2/9 19:55, Filipe Manana =E5=86=99=E9=81=93:
> > On Mon, Feb 9, 2026 at 3:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> Since commit 59615e2c1f63 ("btrfs: reject single block sized compressi=
on
> >> early"), the following script will result the inode to have NOCOMPRESS
> >> flag, meanwhile old kernels don't:
> >>
> >>          # mkfs.btrfs -f $dev
> >>          # mount $dev $mnt -o max_inline=3D2k,compress=3Dzstd
> >>          # truncate -s 8k $mnt/foobar
> >>          # xfs_io -f -c "pwrite 0 2k" $mnt/foobar
> >>          # sync
> >>
> >> Before that commit, the inode will not have NOCOMPRESS flag:
> >>
> >>          item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
> >>                  generation 9 transid 9 size 8192 nbytes 4096
> >>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 3 flags 0x0(none)
> >>
> >> But after that commit, the inode will have NOCOMPRESS flag:
> >>
> >>          item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
> >>                  generation 9 transid 10 size 8192 nbytes 4096
> >>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 3 flags 0x8(NOCOMPRESS)
> >>
> >> This will make a lot of files no longer to be compressed.
> >>
> >> [CAUSE]
> >> The old compressed inline check looks like this:
> >>
> >>          if (total_compressed <=3D blocksize &&
> >>             (start > 0 || end + 1 < inode->disk_i_size))
> >>                  goto cleanup_and_bail_uncompressed;
> >>
> >> That inline part check is equal to "!(start =3D=3D 0 && end + 1 >=3D
> >> inode->disk_i_size)", but the new check no longer has that disk_i_size
> >> check.
> >>
> >> Thus it means any single block sized write at file offset 0 will pass
> >> the inline check, which is wrong.
> >>
> >> Furthermore, since we have merged the old check into
> >> inode_need_compress(), there is no disk_i_size based inline check
> >> anymore, we will always try compressing that single block at file offs=
et
> >> 0, then later find out it's not a net win and go to the
> >> mark_incompressible tag.
> >>
> >> This results the inode to have NOCOMPRESS flag.
> >>
> >> [FIX]
> >> Add back the missing disk_i_size based check into inode_need_compress(=
).
> >>
> >> Now the same script will no longer cause NOCOMPRESS flag.
> >>
> >> Fixes: 59615e2c1f63 ("btrfs: reject single block sized compression ear=
ly")
> >> Reported-by: Chris Mason <clm@meta.com>
> >> Link: https://lore.kernel.org/linux-btrfs/20260208183840.975975-1-clm@=
meta.com/
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Fix a off-by-one bug in the disk_i_size check
> >> ---
> >>   fs/btrfs/inode.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index b6c763a17406..7b23ae6872fc 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrfs=
_inode *inode, u64 start,
> >>           * do not even bother try compression, as there will be no sp=
ace saving
> >>           * and will always fallback to regular write later.
> >>           */
> >> -       if (start !=3D 0 && end + 1 - start <=3D fs_info->sectorsize)
> >> +       if (end + 1 - start <=3D fs_info->sectorsize &&
> >> +           !(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size))
> >
> > Can we avoid the negated compound expression?
> >
> > Instead of
> >
> > !(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size)
> >
> > Do
> >
> > (start > 0 || end + 1 < inode->disk_i_size)
> >
> > Which is more straightforward to read, and it's what we had originally =
too.
>
> The problem is, I find the original code very hard to read.
> It takes me quite some time to understand it.
>
> The negated one is more straightforward, it shows exactly all necessary
> requirements for an inlined extent:

For me it's the opposite. When I read the negated version, I have to
convert it first to the original, non-negated version.

>
> - File offset 0
> - Covers the full file size
>
> I don't know if it will help to introduce a short helper, and make it
> more readable like:
>
>         if (end + 1 - start <=3D fs_info->sectorsize &&
>             !can_inline_range())

Adding a helper is just complicating things...

>
>
> BTW, here we can not use can_cow_file_range_inline() directly, as at
> delalloc time our end + 1 is always block aligned, which will make
> can_cow_file_range_inline() to always return false due to the max_inline
> check.
>
> Thanks,
> Qu
>
> >
> > Otherwise:
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> >>                  return 0;
> >>          /* Defrag ioctl takes precedence over mount options and prope=
rties. */
> >>          if (inode->defrag_compress =3D=3D BTRFS_DEFRAG_DONT_COMPRESS)
> >> --
> >> 2.52.0
> >>
> >>
>

