Return-Path: <linux-btrfs+bounces-21776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EyPEbbVlmmVowIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21776-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 10:19:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9C815D4B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D6E304A6D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0543382DB;
	Thu, 19 Feb 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7ICwk7J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB673324705
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492751; cv=none; b=SNRyIuspH6u3UFh0EfOurx8wMLAG8Xwxrv15IEx4BljhHo0wD70kjuhooa/wSgb9Lw9JX25pRV2oIB6A4Hpp2wXHPNFe4FTtE4O0H/MbhOcO3+cB/9wz6cL/5D+mXVU4p2LL8na5gZG8Ia13U9npb8PjzMFI3shj+vojAKOU78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492751; c=relaxed/simple;
	bh=LRsOwDBtBJm6ZBvCd9TSeC7/Apy+Vs8vYoHc4DQ5kWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5cFPmfDusgEvw/gq6Z/lbrbu+7dzzPDqVirCSR0mzxv0lwTH1mArjmSatqhJpWTwpyTdT+spNaFAZVGeue7TMjs4nfUcHr1dYEm2wqihE2rYFvY82i0Ji59QUfZor7RtkzsmM8Y79RJ3XTrqSQ6nJJb6hykskpvP4rnJOS0U2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7ICwk7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5BCC19421
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771492751;
	bh=LRsOwDBtBJm6ZBvCd9TSeC7/Apy+Vs8vYoHc4DQ5kWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7ICwk7JIJoA8gfOVnta1wzUEnQgDnUBCaBzjZOe15hXYwLYOIGiOET1fkF71IL1l
	 fvbcM5RipH2zTbvTtcF+bSJfFpCBhKdyiPd0oOcadgM+CnWkhUFGwbwJGiUkoXIZgM
	 JcluxAgeHNncG1c3xtPGOPbC66hiUuYAMak+o+jg8IQbkQZ1LMtvWcwGpDWRR1ahWV
	 cGhTKOY/ggnkBw3eSRQiGX6J1ExmreFeEhq3YxQRJZvBrqXMdYFRgabw5Ty5bdqJoB
	 iNrwCNNNGVmPfrqWTjHPH/9ooYCXjdhKaBdBh8/xWOZP4L1M9nB+FLoahyH2MX9Q33
	 0CT1nKoNvO5oQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8849dc12f6so103072966b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 01:19:11 -0800 (PST)
X-Gm-Message-State: AOJu0YwnyqAjy++k8FlMdsdOjj5x5y3DSINrwAIDtx0GgjZ5EWQuazV4
	f/3wf2Oc/UibyMw/SIzAvJtbT0UEi+RVQWdj6ZhjjMcVdelkeG6EaEacxECVcgMzeoI7g02Ptzl
	EyWC+AWeFC/VnMCTam3TFHFT6ukOcXyw=
X-Received: by 2002:a17:907:d8d:b0:b87:d3af:de68 with SMTP id
 a640c23a62f3a-b903daa335cmr263065566b.7.1771492749958; Thu, 19 Feb 2026
 01:19:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd>
In-Reply-To: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 09:18:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
X-Gm-Features: AaiRm5274pDAKUmoFrGhcQRL0jdWpLUBy9jxm1FFzXXN9O2uZLYTEvxB9V8Vn8U
Message-ID: <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: trace use file_inode(file)->i_sb to calculate fs_info
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21776-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: DC9C815D4B6
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 1:50=E2=80=AFAM Goldwyn Rodrigues <rgoldwyn@suse.de=
> wrote:
>
> If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
> super block and fsid assignment will lead to a crash.
>
> Use file_inode(file)->i_sb to always get btrfs_sb.
>
> Changes since v1:
>   Changed subject to include trace
>   Use file_inode() to get inode pointer

Information about what changes between patch versions doesn't go into
the change log, it goes below the line marked as "---", as that's
irrelevant information to have in git, it's only useful for patch
reviews.

This subject:

"btrfs: trace use file_inode(file)->i_sb to calculate fs_info"

is also odd, using a C expression, not saying where (which trace
event) and not saying what problem are we fixing but rather how are we
fixing the problem.

I suggest something much more clear and concise such as:

"btrfs: fix a crash in the trace event btrfs_sync_file()"

One further comment below.

>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  include/trace/events/btrfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 125bdc166bfe..92118df217b4 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -770,9 +770,9 @@ TRACE_EVENT(btrfs_sync_file,
>
>         TP_fast_assign(
>                 const struct dentry *dentry =3D file->f_path.dentry;

Shouldn't we also use file_dentry(file) here?

I think we should, otherwise we get the same bug that was fixed in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dde17e793b104d690e1d007dfc5cb6b4f649598ca

> -               const struct inode *inode =3D d_inode(dentry);
> +               const struct inode *inode =3D file_inode(file);
>
> -               TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
> +               TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
>                 __entry->ino            =3D btrfs_ino(BTRFS_I(inode));
>                 __entry->parent         =3D btrfs_ino(BTRFS_I(d_inode(den=
try->d_parent)));

And here, why didn't you replace d_inode() with file_inode() like above?

Thanks.

>                 __entry->datasync       =3D datasync;
> --
> 2.53.0
>
>
> --
> Goldwyn
>

