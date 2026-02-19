Return-Path: <linux-btrfs+bounces-21788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIUdNBlEl2kiwQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21788-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:10:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36912160F7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707F8304C0BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574334DB4C;
	Thu, 19 Feb 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH46DB4L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912C34E745
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521005; cv=none; b=Tp5MB0ucfU558j4hEawIhKvm7lgqfjBzXgxVs1Qy1gAORG48FyGPcHuVDAP6nG4x0l7qJp9zIiMlmPiQS3LXkyLVzFzhh/t9UskFvQshikbXlN/tx5Uss1A6B7L/eGF902HZLRrqXjJjw0b/Wmp6EMq20I17zBT0YUMMJNIPKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521005; c=relaxed/simple;
	bh=ck9K804QNP/rwwJBaOmHTlNlqPGP2lJLDxfXoyKREDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtDPXHkfUWmpGJiTObbFhT6LIx1nyWlXGgbsrJS8xwmDk0izWzvy5Rl3BP4OdmILHjUFDD0OFNaVlOchH1KtkvEKD/rijAmLirsWN3klUGZo/wQbA3TChiHO7ZjtMF0bJiYufN4noSJKTwZuGhTsw2ZGLzdBUQ5pPSR61AD9mOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH46DB4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E46C4AF0B
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771521005;
	bh=ck9K804QNP/rwwJBaOmHTlNlqPGP2lJLDxfXoyKREDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IH46DB4LbJ4JqlbLoO379Cg4Aw3AcHMEFisIR0seEshG++E6tFa92V1r3CTSDeU2L
	 DiGgX4dpEGd6iTz+OASLd6YHHOrVAoss4UBfKTscipm5xBP6ktEQPSswvWj8mfceTR
	 H3WBaV3Ddm258FzE+QoI3qssWY9IYn1k0oQTfoGQ2TBh83rJ/lAwgp7523kmpskXRF
	 +vcbiFb1DHe3vbflIvgpMgfqeyEKl3TzXF3kxYB3mEigPuJNclmQk/GaQ3RyZqZRAS
	 q+vBKiW/YjoPdFOdhCmJlbEfUQv7xQJM1SlhyXE9800ApU7ySFlT88Y1EvbLZKzPcV
	 l7tdrIrHVhndQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so2172716a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 09:10:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yzlh6MtGg78m4UOeQUmir8/HFtsruhcchwjAL17d99vNf5y66X3
	bC3WSUWtaiNXsFosvofMCwso0h4o7aKExIFUbXr1VxDOSzy2qpGVYVakBS0Fwad7VSRitowJz8K
	V+4/t5cgKFl/yGj+92fC8Afx/941ORsc=
X-Received: by 2002:a17:907:e158:b0:b90:45:e236 with SMTP id
 a640c23a62f3a-b9000460348mr514155966b.26.1771521003398; Thu, 19 Feb 2026
 09:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219162151.5567-1-mark@harmstone.com>
In-Reply-To: <20260219162151.5567-1-mark@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 17:09:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6rdJLMgMFG3gMtN2ngPjXZm-gpJ-iV=yiXNDQ2N95hJw@mail.gmail.com>
X-Gm-Features: AZwV_QhZq1xka_N_GGQlTbOhOLgpVIK_3rjesieow0g1H3GF-DTmsSNUOHcEUlg
Message-ID: <CAL3q7H6rdJLMgMFG3gMtN2ngPjXZm-gpJ-iV=yiXNDQ2N95hJw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix transaction handle leaks in btrfs_last_identity_remap_gone()
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
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
	TAGGED_FROM(0.00)[bounces-21788-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email,harmstone.com:email]
X-Rspamd-Queue-Id: 36912160F7D
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 4:24=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> btrfs_abort_transaction(), unlike btrfs_commit_transaction(), doesn't
> also free the transaction handle. Fix the instances in
> btrfs_last_identity_remap_gone() where we're also leaking the
> transaction on abort.
>
> This fixes a bug introduced in "btrfs: handle deletions from remapped
> block group" in for-next.

In for-next and in Linus' tree already, commit
979e1dc3d69e4c825eec05d05d9567b251f6ec23.
Once you see David's pull request to Linus, you can assume the commit
ID is stable and it will match the commit ID in Linus' tree once
merged.

So we can, and should, add here:

Fixes: 979e1dc3d69e ("btrfs: handle deletions from remapped block group")

With that added:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Suggested-by: Chris Mason <clm@fb.com>
> Link: https://lore.kernel.org/linux-btrfs/20260125125129.2245240-1-clm@me=
ta.com/
> ---
>  fs/btrfs/relocation.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8a8a66112d42..f2abc5d625c1 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4715,6 +4715,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_chu=
nk_map *chunk_map,
>         ret =3D btrfs_remove_dev_extents(trans, chunk_map);
>         if (unlikely(ret)) {
>                 btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);
>                 return ret;
>         }
>
> @@ -4724,6 +4725,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_chu=
nk_map *chunk_map,
>                 if (unlikely(ret)) {
>                         mutex_unlock(&trans->fs_info->chunk_mutex);
>                         btrfs_abort_transaction(trans, ret);
> +                       btrfs_end_transaction(trans);
>                         return ret;
>                 }
>         }
> @@ -4742,6 +4744,7 @@ int btrfs_last_identity_remap_gone(struct btrfs_chu=
nk_map *chunk_map,
>         ret =3D remove_chunk_stripes(trans, chunk_map, path);
>         if (unlikely(ret)) {
>                 btrfs_abort_transaction(trans, ret);
> +               btrfs_end_transaction(trans);
>                 return ret;
>         }
>
> --
> 2.52.0
>
>

