Return-Path: <linux-btrfs+bounces-21357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ocqpED5Hg2mMkwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21357-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 14:18:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE06E6508
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35755301C909
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFA622A4D8;
	Wed,  4 Feb 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="NjLchUfr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F612248A5
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211032; cv=pass; b=gTiJ+e+2hLz7WANiQ4LZX7bvPGWYjcUzkxKTYfx8EN5NTwdFX8n35mckpVzZ73DT0IrwOTsxRPcSUiWTegVOSWZO8Rv9bgOUpjrFbtbXrVMhEwK15muFO20fteAjo189Fb4X2XWqZSfLGA5yk9zqHCiV4vA8dVfhYOKK0SCM1+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211032; c=relaxed/simple;
	bh=C6cXbNn40hY7L8vUSKB3nc3L9R/nz2ULsEMFQrKLZ8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi4epumAXh+ILK81JPAXRi0OWamfYOwQHFiYXqycdQNg+kBg86cuvCVx8MaOa2Gz+K0Mz753ECl3EWZImrw8gAsnVng3VrIXQe6cfnZiWOCUf8t6/TBEtYUeUy5LrRwCn14Lr8lhUDpsAXt+EYz/m5t+quGn7BfV+CgDeTHuYxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=NjLchUfr; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c868b197eso5043017a91.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 05:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770211031; cv=none;
        d=google.com; s=arc-20240605;
        b=SUVlFBKW47gwHuDxwGMO43Ht9B/dEjuIwzZvwgGcmav8iCkK5eZinzSOskO3riJpcY
         QNpzNvWKreBifbfe0WytixCU9wJT8gomKnmt+2WB+OWwFYsBlDwVyfqXykPIYipX5I6m
         g8ril2v7BSx67s7NQgNdDJYjsr84Aj8JFpNuRYglzP+/mFQGfCm02mEbCXNI8K2C+kI+
         H94z27rhYM0I2vdhJEwXEWPLZFAugRqqtYZfQpoEsR5klcGxdmlWa5fiPcx8/JofI3ho
         a3F1qgFP+HefAhjNGa9lHeSKpZ6tepnSmurO2U4Xcj0wzRqB1aKPz2v/YfZFYfVIRsdu
         PQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xirPTITepdiCIIhFTcNbF/9W4+4Qc7wHUwCNA4ubBAo=;
        fh=RhFuKwp73/x8KksFPnzjZEYxDQ9t3rFtnoJ8q5GIsWE=;
        b=F4lJWK3iD6f63XeD60qjzDov9oTuF46mLXLmWoSKzY/FIvBgp0QIIQ4c9vPtwNBqvQ
         pQxlceA6+vyNhuVJLv45RdtsSO1tLhUl82IVG0xzZoRwFzzNc/9/iTQhtFkxgEhbnWF7
         NuNU8gKG/UoSDoXuHF9TA7vhy9+j/HPBTGg7GlJAEYkPg67V8IeA8sDjqu6Sj+n3fhC1
         TC65x+tKbqCfz//nZKG7qxGduTQ1iE2GoQRF3IdF9RCu3+S5JuRpizXpbJJYtByuTsbL
         DpgwNy1E1UXOj7poKpPFAa/APWovonInICRpQWMsaR1fNZ1kalwzGOtfBSk6Lfi8hoBL
         zLZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1770211031; x=1770815831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xirPTITepdiCIIhFTcNbF/9W4+4Qc7wHUwCNA4ubBAo=;
        b=NjLchUfrEzRA3JwJdfpx6XEOQdmQERz3p0Jf5mC1NsMROKXNkf0ILNKh7IlWeWsSoE
         i5/Q7n/2PUgnbSTUPTGg5bmS+zR7NRA1O3NXB0UfkVJ8K2T0lQH4QeYYcsp0r0EwG14d
         R9PpnVnEr1ecmYxE3g5CUToFS9io8V0pb2meURU8F+y8kVuSmY9Dpe6tDILAcENOit3e
         nNlz8b6/YTUHOwpQPF9ytq93eA2cR8+SANxDolq8ov1tKEAExbYvLnzbvHkZlimaVGV3
         cfqGmYAsvKPQ5gkZISblE20uMGVdZsPJ92e4G7ePNMAWcwbrEDOY8Eu7tHbtySwfK/N7
         IRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770211031; x=1770815831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xirPTITepdiCIIhFTcNbF/9W4+4Qc7wHUwCNA4ubBAo=;
        b=xT3LTs289G8bu2TMocF7Bjiur8z+W17wbGZVoJGAIT8zx0U+I8GgF1dYnnZ0Q3LR1g
         bW3lWMS3xSOdqGnqBZVKicKKXjDhxHb5OFn1av4JjommwTzLclkqbvZYIhfru2G17lJi
         w2IWWTaKcUmVd0js8nqulsqAwSr1MrF7Kllm2fwiC2J1IwgufUom7xl05buSmLI1uruB
         au14TK1CPFXRzQ8pmJn5y+iO83xqxjSyrsFSKFCBH1VlG4BYPRgZF8mDTOALsr3ggc/E
         Mjo/BB9DJQpDX4QVwlSKnSMz2QD0OWKdQLzrAF7KOLLUiVCazqS0AG7Ct1njWXz0UVQM
         n+WA==
X-Gm-Message-State: AOJu0YzZxRc5gLUEZnIcVJNekZ9qvXnUODNjJQpCcB5q5hXOHqSSG7Lo
	a6hRBXA9msOIjnjRZt7WjvFqsfKzYrYMzRw6kelT8fy8ul9kLBPIctTw74RpIyF+Mi/41L3YfA0
	kwNHt8CnfP8XRNsg/SI075eEgBvEui1FtS3dwuCkSBA==
X-Gm-Gg: AZuq6aLeIjlWaQ2jn/VV/8P6WT/oEpWjOhgugAPS0BHPfgAFZW2loWvog/VY/RWgdau
	8hlKdvf9kVR2XCYd5xK89R/LH86pS2iEZihomafRTe/ICT5/vFSXLuNME1TpflqyCCNlME+DWhR
	yS2EaQgShNWnJS6gsG7TclEeDpMlp+ZF1u6FDH96NeOs2PzSEMduATLx0uzSZ3Rfpdeq2g7+/Do
	xlDyB37Os0XYrT6NcCoisAW0xH/TYEJtMTgxOvdqNaJdHOCGZ2Uh77YE6lFRS0OpyXZvw==
X-Received: by 2002:a17:90b:2fc8:b0:343:7714:4c9e with SMTP id
 98e67ed59e1d1-3548709e649mr2593032a91.2.1770211031049; Wed, 04 Feb 2026
 05:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
 <45801be3be6d71e6e75020ae8d31c9dafca8c1a4.1770209077.git.fdmanana@suse.com>
In-Reply-To: <45801be3be6d71e6e75020ae8d31c9dafca8c1a4.1770209077.git.fdmanana@suse.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Wed, 4 Feb 2026 15:17:01 +0200
X-Gm-Features: AZwV_QiYQW_X-TqFwyQabhl3j2sgrnpuJNozNKp7w77hZAhK8ik6Tvu_HRfm-qk
Message-ID: <CAOcd+r2A1_qKokQn7Hx9X90y8SCQden-y8o60COs7rpFj2XLWA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: use the correct type to initialize block
 reserve for delayed refs
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zadara.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zadara.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[alex.lyakas@zadara.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21357-lists,linux-btrfs=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zadara.com:+]
X-Rspamd-Queue-Id: ABE06E6508
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 2:49=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When initializing the delayed refs block reserve for a transaction handle
> we are passing a type of BTRFS_BLOCK_RSV_DELOPS, which is meant for
> delayed items and not for delayed refs. The correct type for delayed refs
> is BTRFS_BLOCK_RSV_DELREFS.
>
> On release of any excess space reserved in a local delayed refs reserve,
> we also should transfer that excess space to the global block reserve
> (it it's full, we return to the space info for general availability).
>
> By initializing a transaction's local delayed refs block reserve with a
> type of BTRFS_BLOCK_RSV_DELOPS, we were also causing any excess space
> released from the delayed block reserve (fs_info->delayed_block_rsv, used
> for delayed inodes and items) to be transferred to the global block
> reserve instead of the global delayed refs block reserve. This was an
> unintentional change in commit 28270e25c69a ("btrfs: always reserve space
> for delayed refs when starting transaction"), but it's not particularly
> serious as things tend to cancel out each other most of the time and it's
> relatively rare to be anywhere near exhaustion of the global reserve.
>
> Fix this by initializing a transaction's local delayed refs reserve with
> a type of BTRFS_BLOCK_RSV_DELREFS and making btrfs_block_rsv_release()
> attempt to transfer unused space from such a reserve into the global bloc=
k
> reserve, just as we did before that commit for when the block reserve is
> a delayed refs rsv.
>
> Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
> Link: https://lore.kernel.org/linux-btrfs/CAOcd+r0FHG5LWzTSu=3DLknwSoqxfw=
+C00gFAW7fuX71+Z5AfEew@mail.gmail.com/
> Fixes: 28270e25c69a ("btrfs: always reserve space for delayed refs when s=
tarting transaction")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>
> V2: Add the missing change to btrfs_block_rsv_release().
>
>  fs/btrfs/block-rsv.c   | 7 ++++---
>  fs/btrfs/transaction.c | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index fe81d9e9f08c..7eeb205870d3 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -276,10 +276,11 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *f=
s_info,
>         struct btrfs_block_rsv *target =3D NULL;
>
>         /*
> -        * If we are a delayed block reserve then push to the global rsv,
> -        * otherwise dump into the global delayed reserve if it is not fu=
ll.
> +        * If we are a delayed refs block reserve then push to the global
> +        * reserve, otherwise dump into the global delayed refs reserve i=
f it is
> +        * not full.
>          */
> -       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
> +       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELREFS)
>                 target =3D global_rsv;
>         else if (block_rsv !=3D global_rsv && !btrfs_block_rsv_full(delay=
ed_rsv))
>                 target =3D delayed_rsv;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index da50fbd68853..aea84ac65ea7 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -726,7 +726,7 @@ start_transaction(struct btrfs_root *root, unsigned i=
nt num_items,
>
>         h->type =3D type;
>         INIT_LIST_HEAD(&h->new_bgs);
> -       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLO=
CK_RSV_DELOPS);
> +       btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLO=
CK_RSV_DELREFS);
>
>         smp_mb();
>         if (cur_trans->state >=3D TRANS_STATE_COMMIT_START &&
> --
> 2.47.2
>
>
Reviewed-by: Alex Lyakas <alex.lyakas@zadara.com>

