Return-Path: <linux-btrfs+bounces-21356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMA5EwJBg2kPkQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21356-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 13:52:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B5E6078
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2763F30135FB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90F3E95B4;
	Wed,  4 Feb 2026 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap6dNoiZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83E261B91
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209399; cv=none; b=A+ttJ4EkApeH1+pTSHOFMu9HyUimF3sFYdbm9Tvg9jkjAn/VbpqZ3U03CsZ5hsVPdiOebDlEyoGGMgseXATLIX9mAXXsLwz0MpMd2FJAi4FKls01TpDCjsSdBLb/G7U9K4ZPWF/+m2xUxJWwc4kfnwi4Hd6Fqnhrg2jJCwfs6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209399; c=relaxed/simple;
	bh=1UdeMaRMRTG3wrQg3eStDQ7MTku0yfod9ppBNdvQJOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+oETXRxAGCvk1Fs+Wc6Xn82WCNqeQCXznqgZ3aAP5/XNRaWNjraNNDCY396+3i63zQv9LcCbnTDxs3g/rU2U6AwY5VEPdfdlw9bbv9E0dq1xOmuvfyul1NblbeDcRnBkP1xwYdCOr7dUuNmRQ9yUYR4Mn++lbgs4Cyyc73jAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap6dNoiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDAEC4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770209399;
	bh=1UdeMaRMRTG3wrQg3eStDQ7MTku0yfod9ppBNdvQJOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ap6dNoiZWkHQVNpCfpK3NokdRHq+68J/ktMBz6AUtWsQpkD2u3jTnRIQKf3df8TKQ
	 FR6GZ3fL2rLajgpInMfKBN2mMDBKEEJTSUHUqZHRJSOy6RHEQDt2EQKAqS+f6UA4hj
	 49M+MCfXMU3MPouDVqr3+7NTLNdGrmFlEUFzyaCYFthKS9/pFKZYgcv8sAY9dvtBA2
	 +ooEZ0uf2uoe+is5HkJmWF2KVXf3hy5BG8sFY97aygXEKbKb6p6DiOrXRtCSdf45Lc
	 avc2PO4o+KMp+tSp0P3ENmgujj38G9B47f6fRkjw2WQfPQkMZJSu4tYgF5qeFy5GTr
	 PXC8Zs4N3qjQw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b884ad1026cso1105099066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 04:49:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzEYTBl9lm2sq8wsXAkXduRv9JbiC8YDv71AuFkRd2li/uL6mv7
	0MLuCf5izGO5iwSIEKDexyjRFYCjtJjH6wZTUULrgi7Bs/WqS2+DLFYnW6lDqTlaERssx4v56fH
	3KO87LNI0DSPDLp4dXHIWEeVES26xLPA=
X-Received: by 2002:a17:906:2083:b0:b87:d664:8601 with SMTP id
 a640c23a62f3a-b8ea6413e60mr89382366b.57.1770209398038; Wed, 04 Feb 2026
 04:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
 <CAOcd+r3gdt8Q3ghkqDdo=YYeH_R2uS7QdZD7eUGtsAy-uH0e9w@mail.gmail.com>
In-Reply-To: <CAOcd+r3gdt8Q3ghkqDdo=YYeH_R2uS7QdZD7eUGtsAy-uH0e9w@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Feb 2026 12:49:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5b2N1+xwuXzFfFzHCGWz5XWKpCv8ALejq10zmdgjbwqQ@mail.gmail.com>
X-Gm-Features: AZwV_QivG9CHsvUTdwLB612LnxjNsnDai1g6XByjdQJsD7CDc_-AW9Ia7dj9l0U
Message-ID: <CAL3q7H5b2N1+xwuXzFfFzHCGWz5XWKpCv8ALejq10zmdgjbwqQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use the correct type to initialize block reserve
 for delayed refs
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21356-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6A8B5E6078
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:30=E2=80=AFAM Alex Lyakas <alex.lyakas@zadara.com>=
 wrote:
>
> Hi Filipe,
>
> On Tue, Feb 3, 2026 at 8:03=E2=80=AFPM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When initializing the delayed refs block reserve for a transaction hand=
le
> > we are passing a type of BTRFS_BLOCK_RSV_DELOPS, which is meant for
> > delayed items and not for delayed refs. The correct type for delayed re=
fs
> > is BTRFS_BLOCK_RSV_DELREFS.
> >
> > The consequence here is that when releasing unused space from that loca=
l
> > block reserve, instead of transferring it to the global delayed refs
> > block reserve we transfer it to global block reserve. If the global blo=
ck
> > reserve is full, we just return that space to the metadata space info.
> > There's no harm in that, but ideally we should transfer the excess
> > reserved space to the delayed refs block reserve.
> >
> > Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAOcd+r0FHG5LWzTSu=3DLknwSoqx=
fw+C00gFAW7fuX71+Z5AfEew@mail.gmail.com/
> > Fixes: 28270e25c69a ("btrfs: always reserve space for delayed refs when=
 starting transaction")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/transaction.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > index 87a3f746cecc..08f691661874 100644
> > --- a/fs/btrfs/transaction.c
> > +++ b/fs/btrfs/transaction.c
> > @@ -726,7 +726,7 @@ start_transaction(struct btrfs_root *root, unsigned=
 int num_items,
> >
> >         h->type =3D type;
> >         INIT_LIST_HEAD(&h->new_bgs);
> > -       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_B=
LOCK_RSV_DELOPS);
> > +       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_B=
LOCK_RSV_DELREFS);
> >
> >         smp_mb();
> >         if (cur_trans->state >=3D TRANS_STATE_COMMIT_START &&
> > --
>
> As I mentioned in my email, I think btrfs_block_rsv_release() should
> also be addressed. Perhaps:

Oh sorry, I missed that somehow.
Updated in the v2 version I just sent to the list. Thanks.

>
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 96cf7a162987..9e2caa7909db 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -276,10 +276,10 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *f=
s_info,
>         struct btrfs_block_rsv *target =3D NULL;
>
>         /*
> -        * If we are a delayed block reserve then push to the global rsv,
> -        * otherwise dump into the global delayed reserve if it is not fu=
ll.
> +        * If we are a delayed refs block reserve then push to the global=
 rsv,
> +        * otherwise dump into the global delayed refs reserve if it
> is not full.
>          */
> -       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
> +       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELREFS)
>                 target =3D global_rsv;
>         else if (block_rsv !=3D global_rsv && !btrfs_block_rsv_full(delay=
ed_rsv))
>                 target =3D delayed_rsv;
>
>
> Thanks,
> Alex.
>
>
> > 2.47.2
> >
> >

