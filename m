Return-Path: <linux-btrfs+bounces-21588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDaHA5cGi2kdPQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21588-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:21:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F709119921
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E302F3038FD6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F4353EEC;
	Tue, 10 Feb 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDixJmPK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AB352F8B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770718830; cv=none; b=RW14uUlso88JXYAK7uPd9hLkok9OYeUdLuS6RTZhMBMxpsWJhN1mLNL5/TExV/cVk4+WzZWgn9D2ImOfkUE6sXSi/Xu64greYgu6zLYBwVIiJkF7g7r/DjDf0jLrH+EKKqGpoFApxqJ7Hxv7S/Kp/iJzM8P1UswtKDFo3fJrF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770718830; c=relaxed/simple;
	bh=6yiSByRlBsWbStKvwSU8g7mdeiPzvQ0EVpgXdf1wLoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMYRbjiYCB5HuxEWcxNaBSPD2r6UWLhKYZ85kw+RYq+49Ji+tfcwqJwdj42RELccvrgaautBSeMHQnxyxVLjmGz8ORCW2yScp5T3AIW+8dsBwNmz0l7CHa9o8GTfID4bTBqo3qr1Nv52sLYp4tLmVFul6PL2Zc12USEPKxXiUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDixJmPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B70C19423
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770718829;
	bh=6yiSByRlBsWbStKvwSU8g7mdeiPzvQ0EVpgXdf1wLoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UDixJmPKpCOetiNsqDudqrIgHzP6p1N3cgPHt2P9zCIlYdOM2D4BvelPkF3Sd5y19
	 x1bAqf+x5WubJ2usY5pT3g5kAlMGjS7RftT0MZSQyWzYgcqcSq4fgVRcj6wXw9OtSm
	 kA+mhbY5vkRPVPTtuEMbI18dhgaRtZeOY2AqzC7+BKB+psiNJ9XibXvSXvFVZWRAfn
	 molXv58+STF/Txl1lePZjQdoZTpeIkyZP3u+1F4lhPHxXNjPClZ18UZeCJlY0XOtqa
	 NerGzAghTWYvPihQ/jbWsLWpDKIDpieYNTyAKPNbxZixQjWINbjBiW8jpp0vkph+Lc
	 wXrbWf61C9h0w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8860d6251bso92762566b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 02:20:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yy4/EOIQkhkRUqjtWdW5EsRY5DJMwa0+bwXPTK4QpziaYFkkBUa
	oT1lFUepD6orLVxkBqBP6nrP9TgJH7mlwTT2gX1PSKn3s8IiLhk/q7ojWiLKEyJmNT4F63gpB1f
	twHm4JvQFFO7cclcjE/6BLr/ZJyjSdJY=
X-Received: by 2002:a17:906:c112:b0:b87:2abc:4a23 with SMTP id
 a640c23a62f3a-b8edf173b7cmr816142066b.2.1770718828209; Tue, 10 Feb 2026
 02:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210100115.235406-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260210100115.235406-1-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Feb 2026 10:19:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7n+sq=ULNqx2MWCPcv4USEpd2qvwzyawC66NtVMh8rJw@mail.gmail.com>
X-Gm-Features: AZwV_QjzaS4vPM9meqvTWvXXvoNh0KdLyqWJUzfeql090ddk_TbIM5xElieNSR0
Message-ID: <CAL3q7H7n+sq=ULNqx2MWCPcv4USEpd2qvwzyawC66NtVMh8rJw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: handle errors from cache_save_setup
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21588-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F709119921
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:05=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> While looking at call sites calling `if (TRANS_ABORTED(trans))` I
> stumbled upon `cache_save_setup` and realized none of it's callers is
> performing error handling.
>
> Check if `cache_save_setup` returns an error and if yes handle it

There's a reason why we don't handle errors.
Because a space cache is an optimization, so failing to persist it is
no major deal, it just means that after a crash/power failure, when
mounting we will scan the extent tree.
Looking at the changes below, we can now trigger unnecessary transaction ab=
orts.

This is also space cache v1, which is now deprecated for a long time.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e3e7852dd3e0..47a3ca76e304 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3470,8 +3470,13 @@ int btrfs_setup_space_cache(struct btrfs_trans_han=
dle *trans)
>         /* Could add new block groups, use _safe just in case */
>         list_for_each_entry_safe(cache, tmp, &cur_trans->dirty_bgs,
>                                  dirty_list) {
> -               if (cache->disk_cache_state =3D=3D BTRFS_DC_CLEAR)
> -                       cache_save_setup(cache, trans, path);
> +               if (cache->disk_cache_state =3D=3D BTRFS_DC_CLEAR) {
> +                       int ret;
> +
> +                       ret =3D cache_save_setup(cache, trans, path);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>
>         return 0;
> @@ -3558,7 +3563,9 @@ int btrfs_start_dirty_block_groups(struct btrfs_tra=
ns_handle *trans)
>
>                 should_put =3D 1;
>
> -               cache_save_setup(cache, trans, path);
> +               ret =3D cache_save_setup(cache, trans, path);
> +               if (ret)
> +                       goto out;
>
>                 if (cache->disk_cache_state =3D=3D BTRFS_DC_SETUP) {
>                         cache->io_ctl.inode =3D NULL;
> @@ -3685,6 +3692,8 @@ int btrfs_write_dirty_block_groups(struct btrfs_tra=
ns_handle *trans)
>          */
>         spin_lock(&cur_trans->dirty_bgs_lock);
>         while (!list_empty(&cur_trans->dirty_bgs)) {
> +               int ret2;
> +
>                 cache =3D list_first_entry(&cur_trans->dirty_bgs,
>                                          struct btrfs_block_group,
>                                          dirty_list);
> @@ -3710,7 +3719,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_tr=
ans_handle *trans)
>                 spin_unlock(&cur_trans->dirty_bgs_lock);
>                 should_put =3D 1;
>
> -               cache_save_setup(cache, trans, path);
> +               ret2 =3D cache_save_setup(cache, trans, path);
> +               if (ret2) {
> +                       btrfs_abort_transaction(trans, ret2);
> +                       return ret2;
> +               }
>
>                 if (!ret)
>                         ret =3D btrfs_run_delayed_refs(trans, U64_MAX);
> --
> 2.53.0
>
>

