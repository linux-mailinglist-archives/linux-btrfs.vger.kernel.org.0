Return-Path: <linux-btrfs+bounces-21687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO4NAHIQk2lh1QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21687-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:41:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6712314368E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 13:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC063022F4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BAB20296E;
	Mon, 16 Feb 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9639+Ei"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3B1DB375
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245643; cv=none; b=b/br2R4Z8mYjVeKKs0vxvD/2EoUSQ0EGCxYDvWsX/zR9jQzbRY/sAvEO9uuojKjT4Bk5CHgHPotQw238+BCpZSNlzPZ/hEwYEAGnZlaXYqnNZNyfe3DCO1J0aC5sStBxmeSgWI8ios/6GGyNWTD8blBSu1+ykdzSzhWcyeBUxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245643; c=relaxed/simple;
	bh=BA+HEh8zT5kraFkyX/Tigc6anHnxgd47/Epdoqe9S+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHlib9Vm4Cw0mU6bvH9eYIi4ApWikNvINjrOrL9R5fRMtgncNiUJJ5Z4Q8hS+Ffy4+7J5ssSJGcA5ZGXMqGQ1itw88xY90+y0A4u2yKFdWVCwf4XxDViER0LlhSAu5Gbqv5n0QCg737HWSodl+7Af9zpS5lXtb1/t2tP4nY7eUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9639+Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0BAC19423
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771245642;
	bh=BA+HEh8zT5kraFkyX/Tigc6anHnxgd47/Epdoqe9S+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l9639+Eiv5vIxiTFPjrwOoDKJk3Z3OyrTA3r71mFVlFBLFA5PEyno4Nve3VNTbsHX
	 dk1Q0C+Tzq3xnpdvLxerDUSIuysoWzR84oLvWg1ukypU2kvwOaqnYupky/sMLOx2RI
	 0g8ZESvGmf+iwPSQw41JB9rnWuh7jKsVIz2OITHczV0Vcm1fnBjdzT60qOwNEHN2yj
	 G8G/oScoO/1D88WW8L5GcOdHccsJPUkZeotdNZlRmfM3EC6cUTlKMYQfTWtdGK76bc
	 tud0vDxrPIyDF037XqrHz/0cERNVGXlOE+BeCBbhX6uIeUtHNATfsDzcGKAQamU0oZ
	 oB8pLYoliIdmQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65807298140so4724733a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 04:40:42 -0800 (PST)
X-Gm-Message-State: AOJu0YzjDnLwqJS1cvCABvx2tpyK/p2TtPNcQuUu4iOPGhsWrHKSIpUA
	/hD2RkgyyvhU7SDIbH0UHGzMf2Zcoq4NTK59TDQsqMy1UBZy85q0SNgCXU/nVLB87duvLfQGZkX
	P2fY+5tGJHB/TAY0bX26QOYHRRg5gKZA=
X-Received: by 2002:a17:906:6a1e:b0:b88:510a:59b3 with SMTP id
 a640c23a62f3a-b8fb44deec3mr630202966b.48.1771245641021; Mon, 16 Feb 2026
 04:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771012202.git.loemra.dev@gmail.com> <daa819f56fd49e190b7ed70122ab79ecef690291.1771012202.git.loemra.dev@gmail.com>
In-Reply-To: <daa819f56fd49e190b7ed70122ab79ecef690291.1771012202.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Feb 2026 12:40:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5X2JmkDX7qXxbmaHQCCtFt8f4niqhiKxERfPZyL2Cwcg@mail.gmail.com>
X-Gm-Features: AaiRm51zvcT-axGZU4TkYz5rd4tTXBO4TxXzyus1MDb2GxaiBn2UxEzYxuK9elA
Message-ID: <CAL3q7H5X2JmkDX7qXxbmaHQCCtFt8f4niqhiKxERfPZyL2Cwcg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] btrfs: add tracepoint for COW amplification tracking
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21687-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6712314368E
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:37=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> Add a btrfs_search_slot_stats tracepoint to btrfs_search_slot() for
> measuring COW amplification.
>
> The tracepoint fires when a search with at least one COW completes,
> recording the root, total cow_count, restart_count, and return value.
> cow_count and restart_count per search_slot call are useful metrics
> for tracking COW amplification.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/ctree.c             | 15 +++++++++++++--
>  include/trace/events/btrfs.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 55187ba59cc0..1971d7bb5f60 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2069,6 +2069,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>         u8 lowest_level =3D 0;
>         int min_write_lock_level;
>         int prev_cmp;
> +       int cow_count =3D 0;
> +       int restart_count =3D 0;
>
>         if (!root)
>                 return -EINVAL;
> @@ -2157,6 +2159,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                             p->nodes[level + 1])) {
>                                 write_lock_level =3D level + 1;
>                                 btrfs_release_path(p);
> +                               restart_count++;
>                                 goto again;
>                         }
>
> @@ -2172,6 +2175,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                                 ret =3D ret2;
>                                 goto done;
>                         }
> +                       cow_count++;
>                 }
>  cow_done:
>                 p->nodes[level] =3D b;
> @@ -2219,8 +2223,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>                 p->slots[level] =3D slot;
>                 ret2 =3D setup_nodes_for_search(trans, root, p, b, level,=
 ins_len,
>                                               &write_lock_level);
> -               if (ret2 =3D=3D -EAGAIN)
> +               if (ret2 =3D=3D -EAGAIN) {
> +                       restart_count++;
>                         goto again;
> +               }
>                 if (ret2) {
>                         ret =3D ret2;
>                         goto done;
> @@ -2236,6 +2242,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                 if (slot =3D=3D 0 && ins_len && write_lock_level < level =
+ 1) {
>                         write_lock_level =3D level + 1;
>                         btrfs_release_path(p);
> +                       restart_count++;
>                         goto again;
>                 }
>
> @@ -2249,8 +2256,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>                 }
>
>                 ret2 =3D read_block_for_search(root, p, &b, slot, key);
> -               if (ret2 =3D=3D -EAGAIN && !p->nowait)
> +               if (ret2 =3D=3D -EAGAIN && !p->nowait) {
> +                       restart_count++;
>                         goto again;
> +               }
>                 if (ret2) {
>                         ret =3D ret2;
>                         goto done;
> @@ -2281,6 +2290,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>         }
>         ret =3D 1;
>  done:
> +       if (cow_count > 0)
> +               trace_btrfs_search_slot_stats(root, cow_count, restart_co=
unt, ret);

So I find this way too specific, plus even if trace points are
disabled we have the overhead of the counters (and inside critical
sections).

We already have a tracepoint for COW, trace_btrfs_cow_block(), and we
could have one just for the retry thing, maybe naming it like
trace_btrfs_search_slot_restart() or something.
So we could use those two tracepoints to measure things (bpftrace
scripts could easily report a count of each trace point and such),
instead of this highly specialized tracepoint that adds some overhead
when tracepoints are disabled.

Thanks.


>         if (ret < 0 && !p->skip_release_on_error)
>                 btrfs_release_path(p);
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 125bdc166bfe..b8934938a087 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1110,6 +1110,32 @@ TRACE_EVENT(btrfs_cow_block,
>                   __entry->cow_level)
>  );
>
> +TRACE_EVENT(btrfs_search_slot_stats,
> +
> +       TP_PROTO(const struct btrfs_root *root,
> +                int cow_count, int restart_count, int ret),
> +
> +       TP_ARGS(root, cow_count, restart_count, ret),
> +
> +       TP_STRUCT__entry_btrfs(
> +               __field(        u64,    root_objectid           )
> +               __field(        int,    cow_count               )
> +               __field(        int,    restart_count           )
> +               __field(        int,    ret                     )
> +       ),
> +
> +       TP_fast_assign_btrfs(root->fs_info,
> +               __entry->root_objectid  =3D btrfs_root_id(root);
> +               __entry->cow_count      =3D cow_count;
> +               __entry->restart_count  =3D restart_count;
> +               __entry->ret            =3D ret;
> +       ),
> +
> +       TP_printk_btrfs("root=3D%llu(%s) cow_count=3D%d restarts=3D%d ret=
=3D%d",
> +                 show_root_type(__entry->root_objectid),
> +                 __entry->cow_count, __entry->restart_count, __entry->re=
t)
> +);
> +
>  TRACE_EVENT(btrfs_space_reservation,
>
>         TP_PROTO(const struct btrfs_fs_info *fs_info, const char *type, u=
64 val,
> --
> 2.47.3
>
>

