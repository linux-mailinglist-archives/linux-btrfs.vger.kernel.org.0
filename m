Return-Path: <linux-btrfs+bounces-22127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH8dBIAipGmMYAUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22127-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 12:26:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD81CF528
	for <lists+linux-btrfs@lfdr.de>; Sun, 01 Mar 2026 12:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCD6130182B2
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2026 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDC317152;
	Sun,  1 Mar 2026 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEm46rDw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3383090CB
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364381; cv=none; b=PLRjIUfv1SvXgVfpnFHRxBy+rqPVBu7WfLN8w4EL7GVced9PqW06C7flnJEN75WgvBt4nFNetWMMc0ovic4TQUKB2eJ6lpKYRTT2jDf4ExP+qI0sP+O8YtKlTurkpvHgJ4R8CBstWrz2YtzuvEuSAV3p6zxqyAfrJjjGFPHefzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364381; c=relaxed/simple;
	bh=WFHkU7q95nEYtS2+ys7RE1yT6fUT3YeUkPki+w9CUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHfUkKMSCdh2mIRyHmVfRmNRcMBDb5Rti9iI31WjBNO842G2sFl1E6dbvm7BSJTyd+rmhE0M2S55zfAhkpAv+JX1wAZpXogDfEMm0wB4SLh2lLkZoFRdRw0Art5XBpBRWmhD4u913+t9KOKN4TRBqn5qIg/3KzrcpolOWl1Cct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEm46rDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726BFC116C6
	for <linux-btrfs@vger.kernel.org>; Sun,  1 Mar 2026 11:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772364381;
	bh=WFHkU7q95nEYtS2+ys7RE1yT6fUT3YeUkPki+w9CUOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KEm46rDwzYUr79iwSy/aZ/JDdAIYmg4gVUd+eNYhVNwobRWVVYN+VXQdYQdCaN4Pk
	 Jk12gkYgqfXTKSQPxMmBONnbL2goEPgIlKMmQR2lJcF94vIwJjhe554S91507yzC/x
	 oyIi60LSQVb4/f6qvDIFQkQbu6spkmxuR+GxhG2RnTL2YfwbmBwTORxQgfO49mHTrE
	 q8+95nlT/4pTFRqtiAvfRVgpFBMbUSp/YZTrt4uVlWYT2FyR2ROtgsbwsVEV1SLGj3
	 jvUBdrii4H7U37YDCw/1tL22/vqHlW9YXt0vZRcY9m53KIE8pWGV/7wdGOJIbwF67m
	 GrscaPItI2b2Q==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9373af81cdso415991366b.2
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2026 03:26:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5UtRIr28xpkw1x4llGRayjCzPvpIvHNZ3F/jMd8JjKCiOp4+Wg5qaiRTUW7Efffa8mAO0gVHRj9LA0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL+RcM2DN8IcwRqsuTvtVzZOo6j9FTj+6Raa/bkF+4SS6+/lzG
	c/gQcnB2Ya77wOBLZ4ndc9l9XIB1uGgd5gnDXUaHRquYzwA96YBmmexoOyaUPD4vdlqAlyaxjzO
	Q7ZwgTF7XyH0KB+ZKsZJpz5LwSrk6GDE=
X-Received: by 2002:a17:907:d05:b0:b87:965:907a with SMTP id
 a640c23a62f3a-b93765210c0mr613107166b.32.1772364379916; Sun, 01 Mar 2026
 03:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301080847.16153-1-adarshdas950@gmail.com>
In-Reply-To: <20260301080847.16153-1-adarshdas950@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 1 Mar 2026 11:25:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Cn1UQwd7J7K6hqJ16UsUMvDjTrXAmg5oTJnX6pHWk2g@mail.gmail.com>
X-Gm-Features: AaiRm53tbV3GBdtVu6dZTQhCEyI0dwE6zCRLjM1oN0j38JcOrNuxKzjBV-Om9V8
Message-ID: <CAL3q7H4Cn1UQwd7J7K6hqJ16UsUMvDjTrXAmg5oTJnX6pHWk2g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't add delayed refs to an aborted transaction
To: Adarsh Das <adarshdas950@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22127-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs,6d30e046bbd449d3f6f1];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ADD81CF528
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 8:09=E2=80=AFAM Adarsh Das <adarshdas950@gmail.com> =
wrote:
>
> When a transaction aborts, cleanup_transaction() calls
> btrfs_cleanup_one_transaction() which drains all pending delayed refs
> via btrfs_destroy_delayed_refs().
>
> But, btrfs_cleanup_one_transaction() then wakes up tasks waiting
> on transaction_blocked_wait and sets the transaction state to
> TRANS_STATE_UNBLOCKED. These woken tasks can then call btrfs_add_delayed_=
tree_ref(),

No, that's not correct.

You need to take into account transaction states.

Once a transaction is in the state TRANS_STATE_COMMIT_START, it means
no one else is holding a transaction handle for that transaction
(except the task calling btrfs_commit_transaction()).
Also no one else is able to start a new transaction until the current
transaction state is >=3D TRANS_STATE_UNBLOCKED.
Take a look at the array btrfs_blocked_trans_types, join_transaction()
and start_transaction().

We call cleanup_transaction() only in btrfs_commit_transaction(), if
some error happens, after the state is set to
TRANS_STATE_COMMIT_START.
Once we call cleanup_transaction() we call btrfs_abort_transaction()
and mark the filesystem in error state, setting fs_info->fs_error
among other things.
So after btrfs_cleanup_one_transaction() goes through the remaining
transaction states and does the wakeups, no one can start a new
transaction - join_transaction() sees that fs_info->fs_error is not 0
(through BTRFS_FS_ERROR()) and fails.

> btrfs_add_delayed_data_ref(), or btrfs_add_delayed_extent_op() on the
> already-aborted transaction, inserting new entries into the head_refs
> xarray after it was just drained.

Nop... if the transaction was aborted by cleanup_transaction(), it
means that, except for the task calling btrfs_commit_transaction(), no
one is holding a handle for that transaction.

Think about how chaotic it would be if every piece of code holding a
transaction handle had to check if the transaction was aborted before
doing anything...
We would have not only to avoid adding delayed refs but pretty much anythin=
g.

Thanks.

>
> When btrfs_put_transaction() subsequently drops the refcount to zero, it
> hits:
>
>   WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));
>
> This patch fixes this by checking TRANS_ABORTED() at the start of add_del=
ayed_ref()
> and btrfs_add_delayed_extent_op() before inserting into the xarray.
> btrfs_abort_transaction() is called at the start of cleanup_transaction()=
,
> before btrfs_destroy_delayed_refs(), so the aborted flag should always be=
 set
> before any wakeups occur.
>
> Reported-by: syzbot+6d30e046bbd449d3f6f1@syzkaller.appspotmail.com
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>  fs/btrfs/delayed-ref.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 3766ff29fbbb..b994f9702c32 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -327,7 +327,7 @@ static int cmp_refs_node(const struct rb_node *new, c=
onst struct rb_node *exist)
>         return comp_refs(new_node, exist_node, true);
>  }
>
> -static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached =
*root,
> +static struct btrfs_delayed_ref_node *tree_insert(struct rb_root_cached =
*root,
>                 struct btrfs_delayed_ref_node *ins)
>  {
>         struct rb_node *node =3D &ins->ref_node;
> @@ -1025,6 +1025,10 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>         }
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> +       if (TRANS_ABORTED(trans->transaction)) {
> +               ret =3D -EIO;
> +               goto free_head_ref;
> +       }
>
>         if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_q=
group) {
>                 record =3D kzalloc_obj(*record, GFP_NOFS);
> @@ -1153,6 +1157,10 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans=
_handle *trans,
>         head_ref->extent_op =3D extent_op;
>
>         delayed_refs =3D &trans->transaction->delayed_refs;
> +       if (TRANS_ABORTED(trans->transaction)) {
> +               kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
> +               return -EIO;
> +       }
>
>         ret =3D xa_reserve(&delayed_refs->head_refs, index, GFP_NOFS);
>         if (ret) {
> --
> 2.53.0
>
>

