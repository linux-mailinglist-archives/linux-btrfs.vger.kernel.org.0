Return-Path: <linux-btrfs+bounces-21528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPpiIrOqiWlZAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21528-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:36:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E310DA1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C43630069B0
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0B364E8D;
	Mon,  9 Feb 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1erP7sU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7F3644CA
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629796; cv=none; b=T/x0oG0x2N0st9ZIdY2ZomFxhqbHqUDQvT3H/BNiJ1q7vQP6yKaUxKIXj5AeAmEvY8tTFt5bYBLpW9JrhgE3yCr2q0Jq0nlwGXNyE4t9b3gxSJNwnAaa22ROQWrvup+Ph2y8Lz5GMjUN9YVjgzZg+w84j5BTVW/3QTQWqL2NgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629796; c=relaxed/simple;
	bh=HO7m5WWWQTO9lTPD3OKtwNwfBPK+62inGQDCyp1DeFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXoTvANgKuJNPZkMK6GyvkjpSY0ZsKb2CDbVrGm2GNel3UCZNK8puEW1yV1er9etk2WheEK22SuDHizkz+FeoYIyYMh+qnkgRUSjYzFKbc0ba8IxY9kwsj1pvh9c5Ji/xydBgCX29v+aH8XTufhJXJoqQ7rLQ+1LGcaorYz6pT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1erP7sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5055C19425
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770629795;
	bh=HO7m5WWWQTO9lTPD3OKtwNwfBPK+62inGQDCyp1DeFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k1erP7sUsFYARvii7ZtVB7hRcO+/Jws/9gkfeTZCyJxov3tnhgfnJbZeE/jD15P1u
	 pgivi6teAiUDgHv+SrcbfovT2anwKFs5IzmHHFGDtQuOzqXDngkrllNSBegdmDb5BK
	 4G8sq/F4L4L2Z/7aiZ2905ULUHQLfD/kougZ1Z2djSiYX4GrLmjnplN7oOk5xxemy8
	 84CSPrX4b3AhmkwtwTVfUfPglfa6X2l6idcmMA5/kZa5SSUFcBrl5gnMBhmHy3d34q
	 ZTBf8NMO7tUhKvU3M4OcOJJyvvk4UwLHY0QVA2/N63A0F7XnYbe8l5CWC67LJGeGav
	 +dbQ9DmhTH9fA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso7055968a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 01:36:35 -0800 (PST)
X-Gm-Message-State: AOJu0YyHGhP1hE4DerYHweh34djI5HxSvIq0Tyu8vyzJA2H2nqQtoaIa
	8hKzw0Kps7guDLSTFBTfnofD3nISJNyanqegb9ei2VWV5Yx7pFC+QFTi95DVN86hP54Ban1qz8i
	hEwADUUXaGHq7GkHSmcqMam+zj7B/2S4=
X-Received: by 2002:a17:907:a4c:b0:b88:637d:aa75 with SMTP id
 a640c23a62f3a-b8edf378326mr648748266b.30.1770629794181; Mon, 09 Feb 2026
 01:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09b588005eec0809898978728261fff1a7b23d35.1770608707.git.wqu@suse.com>
In-Reply-To: <09b588005eec0809898978728261fff1a7b23d35.1770608707.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 09:35:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6HYzOK1YNWv0wPy46DqjLn6LF7TK8r8m=t-+eZCG-g=g@mail.gmail.com>
X-Gm-Features: AZwV_QifXvQ5EW5vzaLdz8AVHEXWmDQpZFHA__LnAlnHBCF1pTdmFFZaOVDkEEI
Message-ID: <CAL3q7H6HYzOK1YNWv0wPy46DqjLn6LF7TK8r8m=t-+eZCG-g=g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a double release on reserved extents in cow_one_range()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21528-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D32E310DA1B
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 3:45=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Commit c28214bde6da ("btrfs: refactor the main loop of
> cow_file_range()") refactored the handling of COWing one range.
>
> However it changed the error handling of the reserved extent.
>
> The old cleanup looks like this:
>
> out_drop_extent_cache:
>         btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size =
- 1, false);
> out_reserve:
>         btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>         btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, tru=
e);
>         [...]
>         clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_=
NEW |
>                      EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
>         page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEB=
ACK;
>         /*
>          * For the range (2). If we reserved an extent for our delalloc r=
ange
>          * (or a subrange) and failed to create the respective ordered ex=
tent,
>          * then it means that when we reserved the extent we decremented =
the
>          * extent's size from the data space_info's bytes_may_use counter=
 and
>          * incremented the space_info's bytes_reserved counter by the sam=
e
>          * amount. We must make sure extent_clear_unlock_delalloc() does =
not try
>          * to decrement again the data space_info's bytes_may_use counter=
,
>          * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
>          */
>         if (cur_alloc_size) {
>                 extent_clear_unlock_delalloc(inode, start,
>                                              start + cur_alloc_size - 1,
>                                              locked_folio, &cached, clear=
_bits,
>                                              page_ops);
>                 btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size=
, NULL);
>         }
>
> Which only calls EXTENT_CLEAR_META_RESV.
> As the reserved extent is properly handled by
> btrfs_free_reserved_extent().
>
> However the new cleanup is:
>
>         extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_=
folio, cached,
>                                      EXTENT_LOCKED | EXTENT_DELALLOC |
>                                      EXTENT_DELALLOC_NEW |
>                                      EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING=
,
>                                      PAGE_UNLOCK | PAGE_START_WRITEBACK |
>                                      PAGE_END_WRITEBACK);
>         btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
>         btrfs_dec_block_group_reservations(fs_info, ins->objectid);
>         btrfs_free_reserved_extent(fs_info, ins->objectid, ins->offset, t=
rue);
>
> The flag EXTENT_DO_ACCOUNTING implies both EXTENT_CLEAR_META_RESV and
> EXTENT_CLEAR_DATA_RESV, which will release the bytes_may_use, which
> later btrfs_free_reserved_extent() will do again, causing incorrect
> double release (and may underflow bytes_may_use).
>
> [FIX]
> Use EXTENT_CLEAR_META_RESV to replace EXTENT_DO_ACCOUNTING, and add back
> the comments on why we only use EXTENT_CLEAR_META_RESV.
>
> Fixes: c28214bde6da ("btrfs: refactor the main loop of cow_file_range()")
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208184920.1102719-1-clm@me=
ta.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7b23ae6872fc..4ba38ec22610 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1393,10 +1393,25 @@ static int cow_one_range(struct btrfs_inode *inod=
e, struct folio *locked_folio,
>         return ret;
>
>  free_reserved:
> +       /*
> +        * If we have reserved an extent for the current range and failed=
 to
> +        * create the respectiv extent map or ordered extent, it means th=
at

respectiv -> respective

Otherwise, it looks good, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +        * when we reserved the extent we decremented the extent's size f=
rom
> +        * the data space_info's bytes_may_use counter and
> +        * incremented the space_info's bytes_reserved counter by the sam=
e
> +        * amount.
> +        *
> +        * We must make sure extent_clear_unlock_delalloc() does not try
> +        * to decrement again the data space_info's bytes_may_use counter=
, which
> +        * will be handled by btrfs_free_reserved_extent().
> +        *
> +        * Therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV, b=
ut only
> +        * EXTENT_CLEAR_META_RESV.
> +        */
>         extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_=
folio, cached,
>                                      EXTENT_LOCKED | EXTENT_DELALLOC |
>                                      EXTENT_DELALLOC_NEW |
> -                                    EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING=
,
> +                                    EXTENT_DEFRAG | EXTENT_CLEAR_META_RE=
SV,
>                                      PAGE_UNLOCK | PAGE_START_WRITEBACK |
>                                      PAGE_END_WRITEBACK);
>         btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
> --
> 2.52.0
>
>

