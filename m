Return-Path: <linux-btrfs+bounces-22060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLd2CJdmoWkJsgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22060-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 10:40:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C031B5774
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 10:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA6F30B2CB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28742396B7F;
	Fri, 27 Feb 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSfqL6ck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB43B8D65
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185161; cv=none; b=auUJcS4ttJk7m5wZoSyyQ4T8UaXVyGu8q3lrO30/6e2i4rzajjlXF/6UzcpwZW38Ip7bL1u8db4vaNEYhsNMAefNe3+PLko1UQjsvG7MG9KNGbs1ZH+hI6Vp3Z1EXlOXVPbHzLYVkuu5jCLHArurlr0j+x36my4i3RqQfBzfbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185161; c=relaxed/simple;
	bh=8k3zVKuYWr1D4alrByz8TWIaSbsIrF2SwlF+wbajuuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLGXpxX5f4uSGUM395PacmkefHJ13TZHjs5g0fvwQR7f0CbDsFSfMZReyjx1/g3SepQOVqUTUWAXpEii/+Q9d3RRtkna4xIl/T1BG91+eyomTpUKKyVbAKYeQO7ng29+ggnUc/kPnBEp3qHggKW1pLWcwZFMIjQ8qCn0I/KmD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSfqL6ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A50AC116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772185161;
	bh=8k3zVKuYWr1D4alrByz8TWIaSbsIrF2SwlF+wbajuuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VSfqL6ckA7CvqzEAzwRtOkLDXxGU+zHfNHy+KRqblEU+E04JgH7CZtYFXMa7bKGF1
	 RhjV8X+V6YraBZ6972zYz6wuau1bb5gWOGukmzXMXtnwAKaMKVXoTuwWVgBNEUdyYv
	 mH+LzD9+q3LGKo8JRJ3iXovx69IYuntsJXU6G1I0QrZ6SpCz6UNog5tRl4PcCowdPp
	 nyCvlJK4NIPZDZpXQu11hA1qp8Q07XH6q+qyj/VkB8EBEiD/XUTdudK1lXXpgb0L3I
	 vm/FnJWe11CyDbp5a+eW4cmvFN3Xy9gu1htu18Bif+FhF4Vvh7aziIzWfH17VXlVGy
	 DgxOMosJWMrTQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so3803556a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 01:39:20 -0800 (PST)
X-Gm-Message-State: AOJu0YweZULc0MmpKOvXe9AsCquZw84kDl9Bot2oV3D8BrPUNuJahch8
	lQDXaO2AaJ2DMuuLC/GfvJxhsUvK2QU67asf3itP3U8cDfrnfU3SlTvnFKnB6ZKXmtjUJwH9TME
	mVnDRdlIRP5NhROtMaKGElhNEyjBFTyE=
X-Received: by 2002:a17:907:608c:b0:b87:368a:2bf7 with SMTP id
 a640c23a62f3a-b9376389da1mr140993666b.13.1772185159466; Fri, 27 Feb 2026
 01:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdeb2bf487d20620a0823d30da0b97f9b25dc5a1.1772160339.git.wqu@suse.com>
In-Reply-To: <fdeb2bf487d20620a0823d30da0b97f9b25dc5a1.1772160339.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Feb 2026 09:38:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H50icvNtDqWdZe4yxh4Y9cXdSyNH=RWbvWTBPeR1fnNjQ@mail.gmail.com>
X-Gm-Features: AaiRm51OkEImc0LyFhfon4S85eekcbBY1eylwSWnW0SbANBFd5Uc3w3DqSobRbI
Message-ID: <CAL3q7H50icvNtDqWdZe4yxh4Y9cXdSyNH=RWbvWTBPeR1fnNjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: extract the max compression chunk size into a macro
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22060-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 89C031B5774
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 2:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> We have two locations using open-coded 512K size, as the async chunk
> size.
>
> For compression we have not only the max size a compressed extent can
> represent (128K), but also how large an async chunk can be (512K).
>
> Although we have a macro for the maximum compressed extent size, we do
> not have any macro for the async chunk size.
>
> Add such macro and replace the two open-coded SZ_512K.

Missing an "a" between such and macro.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.h | 3 +++
>  fs/btrfs/inode.c       | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 84600b284e1e..973530e9ce6c 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -36,6 +36,9 @@ struct btrfs_ordered_extent;
>  #define BTRFS_MAX_COMPRESSED_PAGES     (BTRFS_MAX_COMPRESSED / PAGE_SIZE=
)
>  static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) =3D=3D 0);
>
> +/* The max size for a single worker to compress. */
> +#define BTRFS_COMPRESSION_CHUNK_SIZE   (SZ_512K)
> +
>  /* Maximum size of data before compression */
>  #define BTRFS_MAX_UNCOMPRESSED         (SZ_128K)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9148ec4a1d19..acfef903ac8b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1587,7 +1587,7 @@ static bool run_delalloc_compressed(struct btrfs_in=
ode *inode,
>         struct async_cow *ctx;
>         struct async_chunk *async_chunk;
>         unsigned long nr_pages;
> -       u64 num_chunks =3D DIV_ROUND_UP(end - start, SZ_512K);
> +       u64 num_chunks =3D DIV_ROUND_UP(end - start, BTRFS_COMPRESSION_CH=
UNK_SIZE);
>         int i;
>         unsigned nofs_flag;
>         const blk_opf_t write_flags =3D wbc_to_write_flags(wbc);
> @@ -1604,7 +1604,7 @@ static bool run_delalloc_compressed(struct btrfs_in=
ode *inode,
>         atomic_set(&ctx->num_chunks, num_chunks);
>
>         for (i =3D 0; i < num_chunks; i++) {
> -               u64 cur_end =3D min(end, start + SZ_512K - 1);
> +               u64 cur_end =3D min(end, start + BTRFS_COMPRESSION_CHUNK_=
SIZE - 1);
>
>                 /*
>                  * igrab is called higher up in the call chain, take only=
 the
> --
> 2.53.0
>
>

