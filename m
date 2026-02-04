Return-Path: <linux-btrfs+bounces-21354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NxLHfgSg2kPhQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21354-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 10:35:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D620AE3EA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 10:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91823068F35
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFBC3ACEF6;
	Wed,  4 Feb 2026 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="KDFvcgOw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904443ACEF7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197434; cv=pass; b=duHsjaTKpzCMzrkBhToVRH9rdDxj77E03fL3oSP+6WavG23S+AYgo3lreF5eFtMePcj0LY9VdRoCbI/9On2fizO07B6RrJnfgXeKpXC/zWylcNFCJDOqZqMS4YxAaNr+4r/7eA8JsROc0YkqgRonMEuwWvJTYookuqFD/YkX+DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197434; c=relaxed/simple;
	bh=6Z1RiQ0Cpga6YFX9r8t2+NGr7R+nzq09WnuU53LTUoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgyjwwPAt50xP2LS778olqbi2w1ANYRZRrhoFEaiLzsu/hIMP29EN0dRcLIwDGLklKM1h4XlkVIKxqI1ravfr0qf3SJ9+t2Mr71sGPu9ZLeWDx7FwAC5pMQhlNFyueYzvNBOgUYVHEdD3rRO3jkKq7cqChdvs87STA87gNl+ZRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=KDFvcgOw; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso4283224a91.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 01:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770197434; cv=none;
        d=google.com; s=arc-20240605;
        b=INRlqNMfzI3jgqwaKGz/8Axefjxj48yZAi7EoHG8RmegObTAAL203kfrEGskMJDVVg
         M1yEHPW8TbytvmSaSMFHkroEKJv9ZdbURdQGHgOZmvsL5NwHq2ALtUu0pOdQ1clZdxV6
         uA58KSYlBUeXONc0g3Qxw3hJAhFz/hEfToGrJeZACjg8p8Qaw73otC07QEBqRbDnuNZT
         F0TSPSK9gjbCygF/41maSoECsWX1Pj1Vr/dkvA3dy7HlHYrB24xZaz3vPMTFz3NRGhXl
         Zajn5zA+6hXkmgUxRVGT30Rr9lzAKWFNSodH2vC7pdjCxyCy4Z8uTpQYG3nmwdDjxbQ6
         WcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qYyhnCQ1TzFwfOSnd8PQNwkT8zDM1ZF8rgIpAuzrLNc=;
        fh=RhFuKwp73/x8KksFPnzjZEYxDQ9t3rFtnoJ8q5GIsWE=;
        b=cvdqB3x2yuL9PjUeIbAstt6n9d1M+wx40c0OI/gO4RNTNL50o6CtzQMwKWdii+BrZ6
         y1yGFxsXnw17KqbeHLoUemH3R1b20Kd2KiiSSG9DiSb8iwr0/JdQThvnomeqzZ+/xUbP
         smyQDS7qDdSgmfDWlRQKJxnvOBxVDu2bD1yNPrI7MVQHDr4fPPZbYbyIPkEGc699VPK9
         66K/etDeG4dxqoPOdYX7Mg2sLoi8WcDWn6gJi5hHwBpCqSCDaLh9G3MV33icqINA4L+T
         c6hA/Oo+1J5nemH42fEcljd2ejBGJo0OGPeiDOze1ae5oEOdWkwK0qXf/5HpE2dC4t2o
         F0+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1770197434; x=1770802234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYyhnCQ1TzFwfOSnd8PQNwkT8zDM1ZF8rgIpAuzrLNc=;
        b=KDFvcgOwiA1Latsay3L0Y0Kjj0wekM5lWmGNZGACG44Imi8IunoeRcNa/J0DJIM+sb
         7AH8ML3PuS+TkTzil7OypSroeHY1cjsYtfZitYhzbjl+sR0XzasmNwvF59hfeMSG8vQk
         RyZPStPBZrppZn32Syug+rMDBbxcTslETjYcOKyrv1Ok0Wd2DeCjUfzICyt2D9s8QBTJ
         DSyt3qZQ59fSst2+roAYm/u//ah7VbMY9UlqIMsdAMtVgU+5X0n4qcitxoOujenW0kEK
         UOVwHZE8lypUqq97qx4jti52/k5OXHDEY8cOvKWHtFTBx8BMn/QnZWf46xA3EEPepOnS
         f7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197434; x=1770802234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYyhnCQ1TzFwfOSnd8PQNwkT8zDM1ZF8rgIpAuzrLNc=;
        b=BYk5zwKhzQKZGZnfE5zcrKbIJyXYJIlcjdT7Fywcj2KH5RrkReUd/Abj5lmDiyldEW
         gvuaadxJGtEGx/nHX2jIohsAJ6vl4VOAGG3f7hZKE2aWrF3trBy4lFs+3s3I4ttuHThI
         mV7VKF8ibcFCoFrmekSUU9jlM/OslzNAtCsj9lpbAZiqKyCfR8BgCLDjpwhMS0ORCJRA
         eVkaVW4/27QDGzwmaJhsBlSdlkb12b5BE8egqEEtecHzmSP4oAXA29sojt5XDRwap0DX
         A6wjpsfuG5SO+R48Po44G5UMVUOUqpikds5a1SBSkRuiJaUmdoU2tf9hII9n/8XX4dUw
         vFgw==
X-Gm-Message-State: AOJu0YwYZytUISh94yrLiurORlexN8BJHe4nOSoYb4TS8CFYSx7QJOrr
	lNUxPCFff3tXTKRQWdG8kIk0IU2ZNcs6Nl+Kjjd5RU+BzvHpwcGGgrGtudHugy2Glv95UihAt7j
	qs6wTg2HutrLmdaD2R+SHQj1V7jjNVrdc7yytU/S804FhMT3QdsbyKFk=
X-Gm-Gg: AZuq6aI2eLW7q1ry8NLwBfTs2jJvUS5pad5pnEUs3CRnN5fD9VotgLUmRrrplh7lYKM
	Px+ZCKvRj7vmXFyzsAO2IjLOycym0U0xVXCtcIa3xqyDi47BepkKS7enV/Gcd9WtIZR/vrmOQG8
	MS+bChYt6yeiJHs0PNfvad0M2FziHfTGLnlOfmXdUD9ZfhghimHvgabPQ4hbHHD1w2nrKcz/X/e
	6dZImnyEA7/5W8zJmtgCkHZTIrs7XibKgU341soafSRvL9o4SPKg8xTzLo7Zip6BcXB5g==
X-Received: by 2002:a17:90b:4b8c:b0:352:d168:fc4 with SMTP id
 98e67ed59e1d1-35487207d86mr1798648a91.32.1770197433805; Wed, 04 Feb 2026
 01:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
In-Reply-To: <c16363c678a392fafd249223228c6c75985e4a59.1770141624.git.fdmanana@suse.com>
From: Alex Lyakas <alex.lyakas@zadara.com>
Date: Wed, 4 Feb 2026 11:30:24 +0200
X-Gm-Features: AZwV_Qgwc-T6CVUvxqVgtlSIAoBj4RN_Gwh1DgAsDl219b3aXt_yqkrzO2mIwSA
Message-ID: <CAOcd+r3gdt8Q3ghkqDdo=YYeH_R2uS7QdZD7eUGtsAy-uH0e9w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use the correct type to initialize block reserve
 for delayed refs
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zadara.com,none];
	R_DKIM_ALLOW(-0.20)[zadara.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21354-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[zadara.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.lyakas@zadara.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zadara.com:email,zadara.com:dkim,mail.gmail.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D620AE3EA5
X-Rspamd-Action: no action

Hi Filipe,

On Tue, Feb 3, 2026 at 8:03=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> When initializing the delayed refs block reserve for a transaction handle
> we are passing a type of BTRFS_BLOCK_RSV_DELOPS, which is meant for
> delayed items and not for delayed refs. The correct type for delayed refs
> is BTRFS_BLOCK_RSV_DELREFS.
>
> The consequence here is that when releasing unused space from that local
> block reserve, instead of transferring it to the global delayed refs
> block reserve we transfer it to global block reserve. If the global block
> reserve is full, we just return that space to the metadata space info.
> There's no harm in that, but ideally we should transfer the excess
> reserved space to the delayed refs block reserve.
>
> Reported-by: Alex Lyakas <alex.lyakas@zadara.com>
> Link: https://lore.kernel.org/linux-btrfs/CAOcd+r0FHG5LWzTSu=3DLknwSoqxfw=
+C00gFAW7fuX71+Z5AfEew@mail.gmail.com/
> Fixes: 28270e25c69a ("btrfs: always reserve space for delayed refs when s=
tarting transaction")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 87a3f746cecc..08f691661874 100644
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

As I mentioned in my email, I think btrfs_block_rsv_release() should
also be addressed. Perhaps:

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 96cf7a162987..9e2caa7909db 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -276,10 +276,10 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_=
info,
        struct btrfs_block_rsv *target =3D NULL;

        /*
-        * If we are a delayed block reserve then push to the global rsv,
-        * otherwise dump into the global delayed reserve if it is not full=
.
+        * If we are a delayed refs block reserve then push to the global r=
sv,
+        * otherwise dump into the global delayed refs reserve if it
is not full.
         */
-       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELOPS)
+       if (block_rsv->type =3D=3D BTRFS_BLOCK_RSV_DELREFS)
                target =3D global_rsv;
        else if (block_rsv !=3D global_rsv && !btrfs_block_rsv_full(delayed=
_rsv))
                target =3D delayed_rsv;


Thanks,
Alex.


> 2.47.2
>
>

