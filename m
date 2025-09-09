Return-Path: <linux-btrfs+bounces-16758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9BB4FFD5
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5474E304E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Sep 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5E353342;
	Tue,  9 Sep 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JPbrVu6S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50244352FF2
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Sep 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429090; cv=none; b=EEnGG1DGmwgFO7kf8+8ywzdkCtWvL++uprBFqapoTuxHn/q0hxCWbicXDe07MdSwAgVKaLwOZ8jODjyX4VsXwFUQqmn+cYFuZuxxAeKfhNy9EmlHIRMyzC7SxySSHGbVfv40Bq59tyteL1Tia0a+EDrIrs64nLEVoK9BwdfMZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429090; c=relaxed/simple;
	bh=xCxSMAQZG/FBWhAgMZAJR9l1k74tqDAhFVw8MXPXEA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHm/TsVuGprSmasnvjy2FuptrQUvu4sGqY63HXFgB3lQ/GVmFp+XZzJAIFwfdtdFUn20u4si3ihH0Wx5MbLwUmd3CNpt2ZEmweJsYFjVg+zoYCi7zLxjB9+ux3zmI3i2FpPACksOP2+ihKPFxOoIA/Q8+9LhmG5Wd7Vdlcvt/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JPbrVu6S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df3be0e098so3135678f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757429086; x=1758033886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ng7EV+NQwWdvu+NWlnigLj/kdjK5a7clC5GV8AK5/8=;
        b=JPbrVu6SWC1sS+5HGPB5M+EsVJLBHnhqdfrwGhQYxzFF0WtAEDqV85YZLO+OhbZMYT
         91BK+6yapeibaox4N7zTeXadVzOTA6VNU0DEmGt+z566KoUfb8uVX5pRvC+axL039/eV
         IXUDDzHHZzdeHYvO7a4J6StAVSAiCkQdcjRGy0ngeb2svUEVziLuuHNsgw28q9SFWEyW
         L80BMRiOhQfKJxLq+D3rIdrPjrtCUzWPT18PjhIb/bQ5u4XrjQpCfdVndFBibsgS3YZR
         LtThSxSNTnjqkNXb456UkjLVePku5bm1aJ4C8M0JejsBm2V8440S1gYFQMkUmjAEkio0
         K9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429087; x=1758033887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ng7EV+NQwWdvu+NWlnigLj/kdjK5a7clC5GV8AK5/8=;
        b=DTJihMor01A4i7GQ3WqvT+mA0rUXiGS1AVTOgYqqZRtNy46tJyhzCCsj306Hf36+DP
         ANiyXAcz/VLHJWrZyFbd+fFf86paCrbUGiu7oxNGXi008hWEeATXH4bE1HRU391ks6iG
         G3UKZAT+HzdmyzYhQEoYDYoEEl176V8HhSgjCyr/2Cq+c6U4G5z5dIZFUNCj7ePf8EIu
         zFUUAUGzHptkkjh5WsmdYCcFO3znnxseUCEc9984rIy3+ZFbXXSKGfXJ9J3GuDctu5XZ
         dmOGW0Po47WyoV88xnLLOjoUAXL+lmMZgxK9eA3WpdmrPw7yy9GR+8IFYdEF2oO+ZHY7
         kD4Q==
X-Gm-Message-State: AOJu0YyldH4VG7lPFdmerJWWx3stoqdeARWawbGF7Li+8Xy2bP+Gms4W
	XmUckXnS2MCz26AliIGir3znl/XTVpsCZha5A98lYveI6hdLbJerKLmaPDZgYkQgsHWrvgj7IJK
	YDBtVGG6G1VgMvLX3clT4/ctm/VpC1c+gwkKNG1trMOXH5eVn5mad
X-Gm-Gg: ASbGnctSyiSVEdhLHhRgWuWpmbG1y19m+mtd0GcTFBVNt994NQQSbxoZB/T/+1oJlva
	V4mvpq04Fg4sovNNy9hDps2lidSoiLTBwiuLMaRjA9ul0hpnE9AF7ZetwJdOTLmzUbsazs15gKu
	qM5p8l9ADT0FtRxmt86/hjaPgrBGz8bxrKq0/NOHL0s9Ocxmms7Hxg7asmBleH7HcNp8Uebe2pa
	cDOJg==
X-Google-Smtp-Source: AGHT+IHm71aJaVHX47xE84d8THtsVa+mTszc2VjokwLGJfbWMxAGZRcTP+AWdkXL4DgYHZNUJgcGaCs0jVcNgAVxrZs=
X-Received: by 2002:a5d:5d0d:0:b0:3e7:431a:ebaf with SMTP id
 ffacd0b85a97d-3e7431aef29mr8624196f8f.32.1757429086588; Tue, 09 Sep 2025
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <38a42e9d2d1ebd8f94f9f68385095854bc05a086.1757332226.git.fdmanana@suse.com>
In-Reply-To: <38a42e9d2d1ebd8f94f9f68385095854bc05a086.1757332226.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 9 Sep 2025 16:44:34 +0200
X-Gm-Features: AS18NWCOXHOBayjkG3X5h5VxHxImCi2B1Xl6yOBK1gjDu_UfyFfRu1Mk3LJcSMU
Message-ID: <CAPjX3Fcsdm9keKZRy-YbTodgF98r+vAufGShTd_F2mgAfnHNQg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: send: index backref cache by node number instead
 of by sector number
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 14:05, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We now have a nodesize_bits member in fs_info so we can index an extent
> buffer in the backref cache by node number instead of by sector number.
> While this allows for a denser index space with the possibility of using
> less maple tree nodes, in practice it's unlikely to hit such benefits
> since we currently limit the maximum number of keys in the cache to 128,
> so unless all extent buffers are contiguous we are unlikely to see a
> memory usage reduction in the backing maple tree due to less nodes.
> Nevertheless it doesn't cost anything to index by node number and it's
> more logical.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

--nX

> ---
>  fs/btrfs/send.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index c5771df3a2c7..32653fc44a75 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1388,7 +1388,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
>         struct backref_ctx *bctx = ctx;
>         struct send_ctx *sctx = bctx->sctx;
>         struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
> -       const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
> +       const u64 key = leaf_bytenr >> fs_info->nodesize_bits;
>         struct btrfs_lru_cache_entry *raw_entry;
>         struct backref_cache_entry *entry;
>
> @@ -1443,7 +1443,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
>         if (!new_entry)
>                 return;
>
> -       new_entry->entry.key = leaf_bytenr >> fs_info->sectorsize_bits;
> +       new_entry->entry.key = leaf_bytenr >> fs_info->nodesize_bits;
>         new_entry->entry.gen = 0;
>         new_entry->num_roots = 0;
>         ULIST_ITER_INIT(&uiter);
> --
> 2.47.2
>
>

