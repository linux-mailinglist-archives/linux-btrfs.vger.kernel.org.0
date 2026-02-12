Return-Path: <linux-btrfs+bounces-21644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPMZOR2mjWnu5gAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21644-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 11:06:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40F12C3E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 11:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFF6B3058DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4C271A7C;
	Thu, 12 Feb 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIQcb8FE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D920A5F3
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890617; cv=none; b=gGg1AFuuXPT2sjUEzcOKO+9eEjOzr1ub4CuLD+ytdssMXsP7fHZxg0O/xJOq9BHRtGDDuPFKHDMiq0b9fJ2W7fWNKmMLa+aELNCWcMT1ULwuCy4ysrRpUXeZwKBCcgNfg1MNPcsI6KP3Trcrc+onijE8ppb+xeNWFM6qvZazTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890617; c=relaxed/simple;
	bh=ZwVyy0Xf08Qfj4qwM9uLRHemsPiRu5RE3SpOxkgtJek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4Rlw0Bm2ysK80xW4eTLzkjeCOLy7wZEl+Uc+5bJ95BoBZgM0Fqz2RxZvWju2X5i1HXQJBcMlG7eJSG+giJNFPF/ub+3EIyqKqa7m1I9pMJp8fju5d3DNIT5ipnzcfMqNShuFUnkDkOcaLvw8jgAUgZlXaW+9gqLK7+MhwA6Jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIQcb8FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C94EC19422
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770890616;
	bh=ZwVyy0Xf08Qfj4qwM9uLRHemsPiRu5RE3SpOxkgtJek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UIQcb8FEBmcJYpY3WYzZ0Ae4oOPAbKhjYH0CEMJKSpOXxTuHyhqUjih/ZNvJo6SkV
	 Fs+FenvGm7dFZ3AliwN0kRkfGy5gUWwSF1ZYnK5/hZ8Qv8Y6b6W/wvWl+mbpX/mCuB
	 YKIdC4sPlgjvXEp/kLEsXfK2D1OUH0hqHoWRVNmp1l9wQucNSYkQ7rQqS4J1Xw7XOJ
	 T+2zZoiEOr9rIGlVGeUilqr2bgB3CDT3tXfotshpnZvd/9O9gN94IU6GDr9XDUHOp4
	 6UCzTl4+58N1mT1vbgUGzooSQ7eoeZmdsv+aAMuautczbwaDC85GbPjOfTMxj3LwQX
	 AYj/gxSAPF/fw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b88593aa4dcso1046252266b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 02:03:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yx6F3NTYk0SPOvcNLQ3zyQTU/+q4AQoHMsyVBMf4DFy9Ukm2L41
	PLApGufI6VvWQZnn1+FNWKRHFIfWAbjKChQEmTYkmlqNMTLagMXiALslrE5lKwhWypiFDK3mDih
	63cxiEnMbAt/md0NOfxoISXbdwCUD03o=
X-Received: by 2002:a17:906:f599:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b8f8f658e66mr121940666b.26.1770890615162; Thu, 12 Feb 2026
 02:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a8b542d5058110fdb0f42c1aad03f05c6439d39.1770850152.git.wqu@suse.com>
In-Reply-To: <1a8b542d5058110fdb0f42c1aad03f05c6439d39.1770850152.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 12 Feb 2026 10:02:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H51G6wQmCLoV8bqTikLxWsqUqPS_8XZJFz5=tQQ7foLEw@mail.gmail.com>
X-Gm-Features: AZwV_Qjzs423Uh4cGwArp4lm0ZHMkZkZx4Zx2N9wFC79kKS5jd2dNMuHZMkj1qQ
Message-ID: <CAL3q7H51G6wQmCLoV8bqTikLxWsqUqPS_8XZJFz5=tQQ7foLEw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove the btrfs_inode parameter from btrfs_remove_ordered_extent()
To: Qu Wenruo <wqu@suse.com>
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
	URIBL_MULTI_FAIL(0.00)[suse.com:server fail,mail.gmail.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-21644-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 5E40F12C3E9
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:49=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> We already have btrfs_ordered_extent::inode, thus there is no need to
> pass a btrfs_inode parameter to btrfs_remove_ordered_extent().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c        | 4 ++--
>  fs/btrfs/ordered-data.c | 4 ++--
>  fs/btrfs/ordered-data.h | 3 +--
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 81600abc0297..3af087c81724 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3416,7 +3416,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_e=
xtent *ordered_extent)
>          * This needs to be done to make sure anybody waiting knows we ar=
e done
>          * updating everything for this ordered extent.
>          */
> -       btrfs_remove_ordered_extent(inode, ordered_extent);
> +       btrfs_remove_ordered_extent(ordered_extent);
>
>         /* once for us */
>         btrfs_put_ordered_extent(ordered_extent);
> @@ -8141,7 +8141,7 @@ void btrfs_destroy_inode(struct inode *vfs_inode)
>                         if (!freespace_inode)
>                                 btrfs_lockdep_acquire(root->fs_info, btrf=
s_ordered_extent);
>
> -                       btrfs_remove_ordered_extent(inode, ordered);
> +                       btrfs_remove_ordered_extent(ordered);
>                         btrfs_put_ordered_extent(ordered);
>                         btrfs_put_ordered_extent(ordered);
>                 }
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index a17f18673bed..e47c3a3a619a 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -638,9 +638,9 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_ex=
tent *entry)
>   * remove an ordered extent from the tree.  No references are dropped
>   * and waiters are woken up.
>   */
> -void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
> -                                struct btrfs_ordered_extent *entry)
> +void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry)
>  {
> +       struct btrfs_inode *btrfs_inode =3D entry->inode;
>         struct btrfs_root *root =3D btrfs_inode->root;
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct rb_node *node;
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index e178d4a489af..86e69de9e9ff 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -161,8 +161,7 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_ext=
ent *ordered_extent);
>  int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)=
;
>
>  void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
> -void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
> -                               struct btrfs_ordered_extent *entry);
> +void btrfs_remove_ordered_extent(struct btrfs_ordered_extent *entry);
>  void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
>                                  struct folio *folio, u64 file_offset, u6=
4 len,
>                                  bool uptodate);
> --
> 2.52.0
>
>

