Return-Path: <linux-btrfs+bounces-21684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH38MnkLk2nw1AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21684-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:20:09 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4161434B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502FB301AA5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B8030C61E;
	Mon, 16 Feb 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6D6DbZh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5D2690C0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244367; cv=none; b=FR9RUJgx5FU3rQ6w5WcWrw5iU/e07QWkKZEO/3+IJKglsZXZCeflQoAFEMHfkyQ9bq5TINeScZZyjpUv6v0PqNnEzu5FRTJ04yDUDZyt+WskRKgQgknEpBT2bjdfQzkY9yRH4/JFzoY5Wa4OYP8Bs6G8HC33st3yKs79hlQ+ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244367; c=relaxed/simple;
	bh=WBDHCit4yNvVGPd9e/uNiy16TjFGggGrUjA2oRHLkAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTOjSooHRE0YdGO/nxRj5U5AitfJSLXgJzZzrQGDxtyqzD/RVf9sUw+8OygTrQK3a8Jh72HShlAdy0J8zRF7A+dLmx+bNVQsrtJENHXQHTRqEgwApAMcIf9sMF7ParIW/zCVzmK9Mo3BXMv/Oz7Y786/xofcAJKgo7ScqPp7qnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6D6DbZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E82C19423
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771244366;
	bh=WBDHCit4yNvVGPd9e/uNiy16TjFGggGrUjA2oRHLkAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R6D6DbZhYMtC/vmVRsxFXcSYQKwOKnk13SeHLislUzW2764r6oLwZTlNNff7lv1u2
	 WxRYX5YUscKNJxXUJ2DnsjNH8tG82qAhthTKCGRSHiOxXZ9+1ezwB988VnfmxyqA9J
	 Tt/d9zejDxwhfmsbfVXd7iwzbjUUivjXQCEBkVFZ+srRpvR9+t83cS76ipmvfsruge
	 dA5e2rWM/p9O27LPQPQGhcbGETzDlObFild7V0u8Hau/nHplqkfM3eM+QLAWW0H7Vz
	 6a8iABfSPuMX67uNH4Dtn1RGpQEEf63/Kjmq1V0aUKua6A2FUQuqxH5gSjIeqrT1yF
	 lSoN6rOn0fxlw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8fa7e3672eso418788066b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 04:19:26 -0800 (PST)
X-Gm-Message-State: AOJu0YzIVE+fh8sEBMrB4IdzURp1hT6SuLcC3WJuvfkqefRM6ahnGanj
	s3aYS1Jbo/wWG7fN7ZDUddcetpZ2jUD1ShHRZFZdAWoRgx8CbBTXJ02KZJOXdodlXesXQqpPptD
	V3Un1U9t6TfomF04pq/KGjQ+bltRaVp0=
X-Received: by 2002:a17:906:eec7:b0:b8e:2a8a:4325 with SMTP id
 a640c23a62f3a-b8fc3d39577mr390756066b.62.1771244365394; Mon, 16 Feb 2026
 04:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771012202.git.loemra.dev@gmail.com> <04eca407999f1db58a4af9f4d88397aa2edd2d3c.1771012202.git.loemra.dev@gmail.com>
In-Reply-To: <04eca407999f1db58a4af9f4d88397aa2edd2d3c.1771012202.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Feb 2026 12:18:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H54zGbpSiwnJXXg0pXLUQtZSwQ65X8iN716Tko0EtynRQ@mail.gmail.com>
X-Gm-Features: AaiRm53CvHPTx5T0BY9GAwJHR4gcetmIMw6vYouMITiddLSVv90w5Vg7LP8Mty8
Message-ID: <CAL3q7H54zGbpSiwnJXXg0pXLUQtZSwQ65X8iN716Tko0EtynRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: skip COW for written extent buffers
 allocated in current transaction
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21684-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4D4161434B9
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:38=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> When memory pressure causes writeback of a recently COW'd buffer,
> btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
> btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
> the buffer unnecessarily, causing COW amplification that can exhaust
> block reservations and degrade throughput.
>
> Overwriting in place is crash-safe because the committed superblock
> does not reference buffers allocated in the current (uncommitted)
> transaction, so no on-disk tree points to this block yet.
>
> When should_cow_block() encounters a WRITTEN buffer whose generation
> matches the current transaction, instead of requesting a COW, re-dirty
> the buffer and re-register its range in the transaction's dirty_pages.
>
> Both are necessary because btrfs tracks dirty metadata through two
> independent mechanisms. set_extent_buffer_dirty() sets the
> EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
> mark, which is what background writeback (btree_write_cache_pages) uses
> to find and write dirty buffers. The transaction's dirty_pages io tree
> is a separate structure used by btrfs_write_and_wait_transaction() at
> commit time to ensure all buffers allocated during the transaction are
> persisted. The dirty_pages range was originally registered in
> btrfs_init_new_buffer() when the block was first allocated, but
> background writeback may have already written and cleared it.

This is not quite correct, the dirty_pages range is never cleared on
background writeback.
We only clear it during a transaction commit, in
btrfs_write_and_wait_transaction().

Normally we shouldn't care about setting the range again in
dirty_pages, because after
we call  btrfs_write_and_wait_transaction(), no more COW should be
possible using this
transaction (which is in the unblocked state, so any new COW attempt
will be in another transaction).

The exception is if we have snapshots to create and qgroups are
enabled, since in qgroup_account_snapshot() we
call btrfs_write_and_wait_transaction() and after that we can get more
COW, due to all the stuff we need to do to
create a snapshot, before we get to the final call to
btrfs_write_and_wait_transaction() right before we write the
super blocks in btrfs_commit_transaction().

>
> Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> correctly pins the block if it is freed later.
>
> Exclude cases where in-place overwrite is not safe:
>  - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
>  - Zoned devices: require sequential writes
>  - Log trees: log blocks are immediately referenced by a committed
>    superblock via btrfs_sync_log(), so overwriting could corrupt the
>    committed log
>  - BTRFS_ROOT_FORCE_COW: snapshot in progress
>  - BTRFS_HEADER_FLAG_RELOC: block being relocated
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/ctree.c | 53 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..a345e1be24d8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -599,9 +599,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *=
trans,
>         return ret;
>  }
>
> -static inline bool should_cow_block(const struct btrfs_trans_handle *tra=
ns,
> +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>                                     const struct btrfs_root *root,
> -                                   const struct extent_buffer *buf)
> +                                   struct extent_buffer *buf)
>  {
>         if (btrfs_is_testing(root->fs_info))
>                 return false;
> @@ -621,8 +621,55 @@ static inline bool should_cow_block(const struct btr=
fs_trans_handle *trans,
>         if (btrfs_header_generation(buf) !=3D trans->transid)
>                 return true;
>
> -       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +       if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +               /*
> +                * The buffer was allocated in this transaction and has b=
een
> +                * written back to disk (WRITTEN is set). Normally we'd C=
OW
> +                * it again, but since the committed superblock doesn't
> +                * reference this buffer (it was allocated this transacti=
on),

Missing an "in" before "this transaction".

> +                * we can safely overwrite it in place.
> +                *
> +                * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has b=
een
> +                * persisted at this bytenr and will be again after the
> +                * in-place update. This is important so that
> +                * btrfs_free_tree_block() correctly pins the block if it=
 is
> +                * freed later (e.g., during tree rebalancing or FORCE_CO=
W).
> +                *
> +                * We re-dirty the buffer to ensure the in-place modifica=
tions
> +                * will be written back to disk.
> +                *
> +                * Exclusions:
> +                * - Log trees: log blocks are written and immediately
> +                *   referenced by a committed superblock via
> +                *   btrfs_sync_log(), bypassing the normal transaction
> +                *   commit. Overwriting in place could corrupt the
> +                *   committed log.
> +                * - Zoned devices: require sequential writes
> +                * - FORCE_COW: snapshot in progress
> +                * - RELOC flag: block being relocated
> +                */
> +               if (!test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags) &&
> +                   !btrfs_is_zoned(root->fs_info) &&
> +                   btrfs_root_id(root) !=3D BTRFS_TREE_LOG_OBJECTID &&
> +                   !test_bit(BTRFS_ROOT_FORCE_COW, &root->state) &&

We need a  smp_mb__before_atomic() before checking FORCE_COW, see the
existing code below.

> +                   !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)) {
> +                       /*
> +                        * Re-register this block's range in the current
> +                        * transaction's dirty_pages so that
> +                        * btrfs_write_and_wait_transaction() writes it.
> +                        * The range was originally registered when the b=
lock
> +                        * was allocated, but that transaction's dirty_pa=
ges
> +                        * may have already been released.

I think it's worth adding something like: "... already been released
if we are in a transaction that creates snapshots and we have qgroups
enabled."

Otherwise it looks good, thanks!

> +                        */
> +                       btrfs_set_extent_bit(&trans->transaction->dirty_p=
ages,
> +                                            buf->start,
> +                                            buf->start + buf->len - 1,
> +                                            EXTENT_DIRTY, NULL);
> +                       set_extent_buffer_dirty(buf);
> +                       return false;
> +               }
>                 return true;
> +       }
>
>         /* Ensure we can see the FORCE_COW bit. */
>         smp_mb__before_atomic();
> --
> 2.47.3
>
>

