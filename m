Return-Path: <linux-btrfs+bounces-21525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAogIQipiWnfAQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21525-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:29:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44510D8FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2973013AA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E4E36404D;
	Mon,  9 Feb 2026 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhophdR0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC5364040
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629187; cv=none; b=u8ghxlAOpmtXZNzGmKmz1b6lT1uG52+nlu3hgI4bZXn49ktROKn10zRt+6W7yyCTB+1TrW0w0SrtDCu6p2hnqMIUrsUMVyMGSwxgrDL1DQQR4rvSfPTrepIisvHVQZiknqZjmTOUBeYSxewNHqnCP+Lz46TTOLrXb2ikLfXuV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629187; c=relaxed/simple;
	bh=tr+uDrrWwKOqGGCQWqh+L90fHcnyCz87xK2fZoCly/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfYc/e5E4qkOzkIvNh8d7L+PM7kN3ZIqy3HbH8nf1L0oPHFRSvrtzplJ0PUFIieoXQ9EHSehDDVsJK1lliOjLzR0Q+W/IFgh1oZuqSN+9Gmom7qBt+kz+Q0ncxf5LrRbAPMjeSp7TNuvHWMgrMq/89pBfARF+wVPkXjXNHh52HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhophdR0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B29C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629187;
	bh=tr+uDrrWwKOqGGCQWqh+L90fHcnyCz87xK2fZoCly/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nhophdR07O1HDSFVGoequgFj90+LJsfcJphG1JLbxXZjs5CXI6dTiNRIyUCkA5CuC
	 UThyTbFdQBUOdVFupocyyQVBbOx9Zd+cdZsAXtvmqsiY5XfAVaaP+PU0bBVXYkmWot
	 ujfSqXlSzApnqdeNw55Xb2Z6VC4RK9+DDDdyAWJm99bj9EebNovcxJ6mpKjoV7K6+2
	 zZjlHyqZP/11Uhu8ePgLwrCEzc4bMk4B7CpZuhJlxWTkM1FkYoNEp3ysBxJMgmwEHe
	 CH3nv+FxlZm21THPgeHqsP153Pl7zH00iyYizrBDSnHmPok2+J8WrS64Dlhbv2W+t6
	 5AM/LfF8oVqCw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b886fc047d5so758198466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:26:27 -0800 (PST)
X-Gm-Message-State: AOJu0YwVJptvrReDQJGlsvkgAjMMbWtyQdYJpkm6PdXd95hxnmT+sol6
	N02MRmMDIpOqC3EWigrC9GfIgyTx5KwgvRNhQSNlUP+DTpSbk5cKRi3V4aFDFRqU6sKxS4DjDw6
	2xMyqqQP4jn2ILQc+kWr2npmNYsa5G/I=
X-Received: by 2002:a17:906:d542:b0:b8e:d04e:e4fb with SMTP id
 a640c23a62f3a-b8edf376150mr630389366b.48.1770629185757; Mon, 09 Feb 2026
 01:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
In-Reply-To: <3cd5a484ffc3d8a499b062cbda89793d560b85d7.1770607799.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:25:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com>
X-Gm-Features: AZwV_Qhk_X6o4viv42TjDAQYAxpZvP4mIix-qBiSUK1Uqspsli6TLc7Nm40JOlA
Message-ID: <CAL3q7H55JWn1ehjTWHg74hqd7P2pSBptcGO4XoFjkBuhqfBQCQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,mail.gmail.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD44510D8FB
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 3:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Since commit 59615e2c1f63 ("btrfs: reject single block sized compression
> early"), the following script will result the inode to have NOCOMPRESS
> flag, meanwhile old kernels don't:
>
>         # mkfs.btrfs -f $dev
>         # mount $dev $mnt -o max_inline=3D2k,compress=3Dzstd
>         # truncate -s 8k $mnt/foobar
>         # xfs_io -f -c "pwrite 0 2k" $mnt/foobar
>         # sync
>
> Before that commit, the inode will not have NOCOMPRESS flag:
>
>         item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>                 generation 9 transid 9 size 8192 nbytes 4096
>                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>                 sequence 3 flags 0x0(none)
>
> But after that commit, the inode will have NOCOMPRESS flag:
>
>         item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
>                 generation 9 transid 10 size 8192 nbytes 4096
>                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>                 sequence 3 flags 0x8(NOCOMPRESS)
>
> This will make a lot of files no longer to be compressed.
>
> [CAUSE]
> The old compressed inline check looks like this:
>
>         if (total_compressed <=3D blocksize &&
>            (start > 0 || end + 1 < inode->disk_i_size))
>                 goto cleanup_and_bail_uncompressed;
>
> That inline part check is equal to "!(start =3D=3D 0 && end + 1 >=3D
> inode->disk_i_size)", but the new check no longer has that disk_i_size
> check.
>
> Thus it means any single block sized write at file offset 0 will pass
> the inline check, which is wrong.
>
> Furthermore, since we have merged the old check into
> inode_need_compress(), there is no disk_i_size based inline check
> anymore, we will always try compressing that single block at file offset
> 0, then later find out it's not a net win and go to the
> mark_incompressible tag.
>
> This results the inode to have NOCOMPRESS flag.
>
> [FIX]
> Add back the missing disk_i_size based check into inode_need_compress().
>
> Now the same script will no longer cause NOCOMPRESS flag.
>
> Fixes: 59615e2c1f63 ("btrfs: reject single block sized compression early"=
)
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208183840.975975-1-clm@met=
a.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix a off-by-one bug in the disk_i_size check
> ---
>  fs/btrfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b6c763a17406..7b23ae6872fc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -811,7 +811,8 @@ static inline int inode_need_compress(struct btrfs_in=
ode *inode, u64 start,
>          * do not even bother try compression, as there will be no space =
saving
>          * and will always fallback to regular write later.
>          */
> -       if (start !=3D 0 && end + 1 - start <=3D fs_info->sectorsize)
> +       if (end + 1 - start <=3D fs_info->sectorsize &&
> +           !(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size))

Can we avoid the negated compound expression?

Instead of

!(start =3D=3D 0 && end + 1 >=3D inode->disk_i_size)

Do

(start > 0 || end + 1 < inode->disk_i_size)

Which is more straightforward to read, and it's what we had originally too.

Otherwise:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>                 return 0;
>         /* Defrag ioctl takes precedence over mount options and propertie=
s. */
>         if (inode->defrag_compress =3D=3D BTRFS_DEFRAG_DONT_COMPRESS)
> --
> 2.52.0
>
>

