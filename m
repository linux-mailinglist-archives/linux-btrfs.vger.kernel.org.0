Return-Path: <linux-btrfs+bounces-21842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOrWK95vnGmcGAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21842-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:18:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCD178A1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5151D30FAB2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B0364E89;
	Mon, 23 Feb 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHn/zcYi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0442571DD
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859665; cv=none; b=M7TVsugdZF5+ZOYKaDgf2L+BKHJlpzkgATRRtZjPYtbIx3YVBrB2MErT7onSKoRqwXCPff0t3uS91dWefgRji812XTqT8og6ha87aJnXasM/tcFlkpcNQWRjKI6vcaexVmhvlAaOFjPhh56Y7UUchucUjlkCEIFWBXZiFl7Eajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859665; c=relaxed/simple;
	bh=J5jwGYb1E7st7oZMZq6RrUxpVCb+bNCrke0rGOMqk5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Je3CBFL+m5mUM/OOFbVGzInV9ugPGUMip4DuCpZWynjw74C2AkB0LHqR8QpXDY+ML/re4y+gUDaiJDk04ZLpuGMu9ohz9pp+rEjduv0S5CUpraniNSryURgf7sfEZKHlNuNEYrW5zrJqr7s+K12D+lOSBXnZSF+ywM2dxrRDvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHn/zcYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C54C116D0
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771859665;
	bh=J5jwGYb1E7st7oZMZq6RrUxpVCb+bNCrke0rGOMqk5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qHn/zcYiiR0IKZkUdHjCIe/MS51CEs2Oe/pKLCxbZN5BaA5SWhj7SBl3SmObXIsmG
	 8Bb1H+12PZNc6TSEWi414FQW5Mi7KIaKOqSExH8ltSONAPmO8z5Xt0XLnHPSSewqMj
	 hX4f4edkI1jC0oyTxWiAqrMVZKmwcg/KTD4gwxnCUMjqZvHPw2YqQPcApiZ8/f7LZx
	 qNErwourx8q71iJXK9jzoI5S+Zmt8CsVTQUwpa8pbE7ofWrjBY0QQMkl2s5IRQtn+S
	 WIn4p1ZhVRfc41hBFGBwGFAYt2oSdkxeYKW1CdYr9MlBhwMljucsCRbuNR47Gd0LlS
	 51mZEj32GgNSA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so7212525a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 07:14:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyGSEBsItl7BpFpiriT6xRHNZGnV7wClyCuuTDkBov/FMz40sk5
	ozcd/37GnMs1U2lNEviAjnkBjtndyrmUot/QxXOG5+udPYdtLiI7RocEQI/bk1Vh/nBDAkaD8y0
	a0SMVW5kllaRS22TBxH1ciKag6+efivo=
X-Received: by 2002:a17:906:eec7:b0:b90:771b:ceb7 with SMTP id
 a640c23a62f3a-b9081a53c72mr561141566b.27.1771859663760; Mon, 23 Feb 2026
 07:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223143820.89931-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260223143820.89931-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 23 Feb 2026 15:13:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fg12yM+RUsDsKbEsr7-Fdk_Fs2gr6=qG-E1uR0YU-Kw@mail.gmail.com>
X-Gm-Features: AaiRm50_hQ8duQ3_hI8HcAJ6_EAKVVog6zpX7wA-1jRPW4GKuzPaKJkHTH2_yRA
Message-ID: <CAL3q7H5fg12yM+RUsDsKbEsr7-Fdk_Fs2gr6=qG-E1uR0YU-Kw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zoned: catch aborted trans in btrfs_zoned_reserve_data_reloc_bg
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21842-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 22CCD178A1C
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:39=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> btrfs_zoned_reserve_data_reloc_bg() is called on each mount of a file
> system and allocates a new block-group, to assign it to be the dedicated
> relocation target, if no pre-existing usable block-group for this task is
> found.
>
> If for some reason the transaction was aborted during the call to
> btrfs_chunk_alloc() and btrfs_end_transaction() is executed, a
> NULL-pointer dereference happens in btrfs_end_transaction().

How does that happen?
Do you have the stack trace?

We are supposed to be able to call btrfs_end_transaction() even if the
transaction was aborted.
In fact we have to, otherwise we leak memory. We do this everywhere in
the code base in fact.

>
> Check if the transaction was aborted before calling into
> btrfs_end_transaction() and if it was aborted return early.

This is wrong... it will leak memory.

Thanks.


>
> Fixes: 694ce5e143d6 ("btrfs: zoned: reserve data_reloc block group on mou=
nt")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f64b872d53ce..265947fde727 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2842,6 +2842,9 @@ void btrfs_zoned_reserve_data_reloc_bg(struct btrfs=
_fs_info *fs_info)
>         ASSERT(space_info->subgroup_id =3D=3D BTRFS_SUB_GROUP_DATA_RELOC,
>                "space_info->subgroup_id=3D%d", space_info->subgroup_id);
>         ret =3D btrfs_chunk_alloc(trans, space_info, alloc_flags, CHUNK_A=
LLOC_FORCE);
> +       if (TRANS_ABORTED(trans))
> +               return;
> +
>         btrfs_end_transaction(trans);
>         if (ret =3D=3D 1) {
>                 /*
> --
> 2.53.0
>
>

