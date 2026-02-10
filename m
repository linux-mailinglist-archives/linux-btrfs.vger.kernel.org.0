Return-Path: <linux-btrfs+bounces-21608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAjINnk7i2neRgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21608-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:06:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7E11BB39
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C77F7301AF76
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F736681B;
	Tue, 10 Feb 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjK/m0Ut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C61B0439
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732399; cv=none; b=ihAALrck7sHglA/noAKshB2PMbu3EMpk0AFVPY4ZQi6WAtoCZ9paZgS436ObDe8AWbsWtUjsd17RH5ZO9XODRtcl7UYgASJjDGt9TRgFrS9HuArT8ASpU2G3VSiCzv1F+O9v2nnlYwrh/NQvyw+MktOTkVxjP4SnYrkg4VDgBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732399; c=relaxed/simple;
	bh=vkB9uf31Aojj8wbKRuyxeDaUpngbaVA/kgOX2djObhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWDnLuUxmKSxiPZ9rYv07DlkdYae04shBYSM3FYZe3RSqvIE1QBa7sGFTzyrFEU9kIl404lb7x66YX+/ba20Ye8lG1XFshmNLO9ohGbzkutuHeBndCqcog0tKlkEGor8qX13LYs5e+nUJIelHXqrXEHtif5mmC2zBQSfTqRd3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjK/m0Ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1853C19423
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732398;
	bh=vkB9uf31Aojj8wbKRuyxeDaUpngbaVA/kgOX2djObhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjK/m0UtZPfMpp5aybvoFZ1F/mRd6Yfwmww2pVXfO14a/oTiCLj5IFLUuSByWrVCT
	 d9lBP3T0cCT1/krfLgdxCbd1OS6ohNEI94QgT2WXD7aVAIgBprq4K0VJaDTEjDX9A+
	 1UvjqlNDxMEfY6EN3e/L1qcQingTY3qMjVL6e/QJznrOQ9qJCfO4HUbb8gv7DrXgN1
	 lLg+tsB9/Zoueh9KucbxiJQa7idUlVhGoPoc9fGnHLSsYiL0Geh4/AfPXspvjuN73M
	 IV7x/nCwcwed6ZVTyjopSzo33f/PaAjcAMQ6gA/hFPVK0TsgKsezenat6mlU3AiCXA
	 oLAlaeORbtgfA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8eafb515aeso113651066b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 06:06:38 -0800 (PST)
X-Gm-Message-State: AOJu0Yy92ePdicPy7rir9HuqJzhKLIZry4uFOVqW0TxCJiwfNjumNIdX
	6/XduSDta1rRhINIrE/HKK1ZBqKHHs2QXOJvi5QKELel2b7q3RCgnhVXWscBxWGyt9KTzveLv7d
	Sn4J9Bbh9ZMTTfSwKUPmNj2t04mez1u8=
X-Received: by 2002:a17:907:d94:b0:b88:73ea:a1d5 with SMTP id
 a640c23a62f3a-b8edf3ea285mr885220066b.51.1770732397480; Tue, 10 Feb 2026
 06:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210131946.286557-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210131946.286557-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 14:06:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ZLe9gE4rYsPQr47-3rg5ozA29nXEN4CQ0q5D+WyY3Aw@mail.gmail.com>
X-Gm-Features: AZwV_QhyIJdOupQltygxkGTBziD1wVjP1X9oP2Sk6xrHthlpmmG7Vy_JOc-GJ30
Message-ID: <CAL3q7H7ZLe9gE4rYsPQr47-3rg5ozA29nXEN4CQ0q5D+WyY3Aw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: change return type of cache_save_setup to void
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-21608-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 3FE7E11BB39
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 1:20=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> None of the callers of `cache_save_setup` care about the return type as
> the space cache is purely and optimization.
> Also the free space cache is a deprecated feature that is being phased
> out.
>
> Change the return type of `cache_save_setup` to void to reflect this.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e3e7852dd3e0..0857b720667f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3288,9 +3288,9 @@ static int update_block_group_item(struct btrfs_tra=
ns_handle *trans,
>
>  }
>
> -static int cache_save_setup(struct btrfs_block_group *block_group,
> -                           struct btrfs_trans_handle *trans,
> -                           struct btrfs_path *path)
> +static void cache_save_setup(struct btrfs_block_group *block_group,
> +                            struct btrfs_trans_handle *trans,
> +                            struct btrfs_path *path)
>  {
>         struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>         struct inode *inode =3D NULL;
> @@ -3302,7 +3302,7 @@ static int cache_save_setup(struct btrfs_block_grou=
p *block_group,
>         int ret =3D 0;
>
>         if (!btrfs_test_opt(fs_info, SPACE_CACHE))
> -               return 0;
> +               return;
>
>         /*
>          * If this block group is smaller than 100 megs don't bother cach=
ing the
> @@ -3312,11 +3312,11 @@ static int cache_save_setup(struct btrfs_block_gr=
oup *block_group,
>                 spin_lock(&block_group->lock);
>                 block_group->disk_cache_state =3D BTRFS_DC_WRITTEN;
>                 spin_unlock(&block_group->lock);
> -               return 0;
> +               return;
>         }
>
>         if (TRANS_ABORTED(trans))
> -               return 0;
> +               return;
>  again:
>         inode =3D lookup_free_space_inode(block_group, path);
>         if (IS_ERR(inode) && PTR_ERR(inode) !=3D -ENOENT) {
> @@ -3398,10 +3398,8 @@ static int cache_save_setup(struct btrfs_block_gro=
up *block_group,
>          * We hit an ENOSPC when setting up the cache in this transaction=
, just
>          * skip doing the setup, we've already cleared the cache so we're=
 safe.
>          */
> -       if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags=
)) {
> -               ret =3D -ENOSPC;
> +       if (test_bit(BTRFS_TRANS_CACHE_ENOSPC, &trans->transaction->flags=
))
>                 goto out_put;
> -       }
>
>         /*
>          * Try to preallocate enough space based on how big the block gro=
up is.
> @@ -3449,7 +3447,7 @@ static int cache_save_setup(struct btrfs_block_grou=
p *block_group,
>         spin_unlock(&block_group->lock);
>
>         extent_changeset_free(data_reserved);
> -       return ret;
> +       return;

This return is pointless, as it's a void function.

Otherwise:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>  }
>
>  int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
> --
> 2.53.0
>
>

