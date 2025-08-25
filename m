Return-Path: <linux-btrfs+bounces-16328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C8DB339F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 10:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C2CD7AF18A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568A2BF002;
	Mon, 25 Aug 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPzW38Xk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5706629D264
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111901; cv=none; b=DIAUUdZZJJQN+s4UxpDZrytyWfxI+2uL42vco8OIYwRJwzgf/s0Rb17IOBPshwWsR0kDm15DfLxVdsuDjAWFsAM0CCqUWXHtNhGnvbqS9k5BhBzEaFkWO7adYRcCeje6IKir0OJdYdpLt6ap1PzkPy/fk4/a2QLDYjX0J02V8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111901; c=relaxed/simple;
	bh=t+jULux6u4hj2Z7SOpYHZdTYFb+J97iaZK9F3ThDiK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYxp8fcu55w5o+xerELRYodIOfkjyugeWR7z08HKPiCYMzkYqKZWF/bVELJDK5ntL2T61V1s47KhEQ4A6INXKpF1IS3ZiikiC7dqf0yHucAbeGDarL+D0eRn4SGV3rckcz6BmwQFx1+lvtKrgFrnaBrrHAgWwAUpBMntobYO7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPzW38Xk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c8fe6bd1a2so279895f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 01:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756111897; x=1756716697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+G6Bai4J1X5mL+f5JKed3Q7/QWSAcTpZk5fQFb7jN6Y=;
        b=MPzW38XklhUViCz/Vl8YRcFf5K5L6nhEJXXkmWsHcRz7LzkzEdUZzvrrGramfI0VPy
         l52dThnxf/02WKE6YjxknZncu8JklrNwz9gBB4eJA5MSEKICqub1woz4FaZWQuN6JLVL
         N6Pim7jaz4cWHT6WbEylkZRtP4DtGS2B1ESQTUsOBSZtgNF5+FQwNl/ARe6+NDHqF4wM
         NqozORAVphJyB64H5k+hViywYjnXqA3pJxRKsqtDFO136XIu0uIHKS4MTb/rkkYa3q5G
         Le1DKNMMHeUZdM4owb7X6GpV7R2uGsVtWZMEuQEyOKXO2QmQ2tQu+o8uMdaTmanf+VIG
         G/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111897; x=1756716697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G6Bai4J1X5mL+f5JKed3Q7/QWSAcTpZk5fQFb7jN6Y=;
        b=sskZkpI9/3POUPM/HvOFA0/2+BOz8toUEpzOs7QhUu+9NiBw96Op4ulRvp3TXp/B+a
         bixqVmR39wVuIkA23nTaCWJZ68/oYAJrfDsf6ZU04glN3fL2QdfGA7AU8RdhwoqOmLdG
         /Jn9313Z1Hk1poGETCmcOrZ8gPDt0E9ODweK8575KYuyTQrsrcIhbgHyytmWnTb0DV+T
         tHngIc62pxBz/KRtVz+88Ra2KydbN34PWkWrP1y94M+S+gAvR1RycD/3vaV1KCqPecxm
         nNZzyW2ufQlSgDa0iUT/5oKTBbs+CRh4NXMzSzRQg72ZmLoMrMLJCuxyvObZqNRTcOkI
         5CFw==
X-Forwarded-Encrypted: i=1; AJvYcCWYrDRx+Z8K89ZD/B3y2S+osxxwb8eVljJ3X6rK1KyRojYOfH+cq6s0eHUXSC+4ZpunxFOWzCgPMsr1tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxACSheMMgu1v9FUr0fezO8mrPYXDtMjdcW0jMwee67UGZHILlt
	8+ROK752uwOkRwtVR8Ty7kr09Y2PLsou3AC6DRK52tIbVCRxMF97+VVTMw1gFqeMJApNR4/dog1
	hZRO3fTA4RVDZAQTExW/8J4z0j8az0w38k7rgNMTyHQ==
X-Gm-Gg: ASbGncti7lHy3/zntc7CTe1K8wRGgWa9ORr30RPAhTW6PAX+QzPfzfFihggDiUi/yNS
	lzLFp+/MZAx/lTD1mEuuBdwFyFWTip3Mf2moCma/canijVIbxWTWsvt9fu/h/18nu7TtMa0wlb0
	KT46lhb2/prqaJT61/RDt7+VFZmJHWFgR+kIg2nHPOZQfz/1r2OBb0IjxkpR8mcxoEwowzghkaA
	lyVTTqZbM7Zpqrg
X-Google-Smtp-Source: AGHT+IEv76Ci6n5Rf9M/zI7dh9QA5Vj3lwnHLFhciLQjLsOlPR6Z5DYybWZ2ykt/hx7FfUyKExCvIyUWyokatFLcZUw=
X-Received: by 2002:a05:6000:1a86:b0:3c9:8600:9a6f with SMTP id
 ffacd0b85a97d-3c98600a5a0mr1778339f8f.21.1756111896568; Mon, 25 Aug 2025
 01:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2022221.PYKUYFuaPT@saltykitkat> <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
 <aKiSpTytAOXgHan5@mozart.vkv.me> <e9a4f485-3907-4f1e-8a74-2ffde87f3044@gmx.com>
 <aKj8K8IWkXr_SOk_@mozart.vkv.me> <9cacdafc-98ec-4ad2-99a8-dfb077e4a5fb@gmx.com>
 <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
In-Reply-To: <aKs2mCRjtv3Ki06Z@mozart.vkv.me>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 25 Aug 2025 10:51:24 +0200
X-Gm-Features: Ac12FXxyQFaQKPGGNp2JoO1pg1hOxueUNRXLrNHNHAxwd26o3wk1HeQRy-4SAME
Message-ID: <CAPjX3FeOEg+QhkwKWe+qDH876bp6-t1GFO0sce7a6bmhM7umpw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Sun YangKai <sunk67188@gmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Aug 2025 at 17:58, Calvin Owens <calvin@wbinvd.org> wrote:
> From: Calvin Owens <calvin@wbinvd.org>
> Subject: [PATCH v3] btrfs: Accept and ignore compression level for lzo
>
> The compression level is meaningless for lzo, but before commit
> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> it was silently ignored if passed.
>
> After that commit, passing a level with lzo fails to mount:
>
>     BTRFS error: unrecognized compression value lzo:1
>
> It seems reasonable for users to expect that lzo would permit a numeric
> level option, as all the other algos do, even though the kernel's
> implementation of LZO currently only supports a single level. Because it
> has always worked to pass a level, it seems likely to me that users in
> the real world are relying on doing so.
>
> This patch restores the old behavior, giving "lzo:N" the same semantics
> as all of the other compression algos.
>
> To be clear, silly variants like "lzo:one", "lzo:the_first_option", or
> "lzo:armageddon" also used to work. This isn't meant to suggest that
> any possible mis-interpretation of mount options that once worked must
> continue to work forever. This is an exceptional case where it makes
> sense to preserve compatibility, both because the mis-interpretation is
> reasonable, and because nothing tangible is sacrificed.
>
> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  fs/btrfs/super.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

v3 looks good to me. The original hardening was meant to gate complete
nonsense like "compress=lzoutput", etc...

Reviewed-by: Daniel Vacek <neelx@suse.com>

Thank you.

> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index a262b494a89f..18eb00b3639b 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -299,9 +299,12 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
>                 btrfs_set_opt(ctx->mount_opt, COMPRESS);
>                 btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>                 btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -       } else if (btrfs_match_compress_type(string, "lzo", false)) {
> +       } else if (btrfs_match_compress_type(string, "lzo", true)) {
>                 ctx->compress_type = BTRFS_COMPRESS_LZO;
> -               ctx->compress_level = 0;
> +               ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
> +                                                              string + 3);
> +               if (string[3] == ':' && string[4])
> +                       btrfs_warn(NULL, "Compression level ignored for LZO");
>                 btrfs_set_opt(ctx->mount_opt, COMPRESS);
>                 btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>                 btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> --
> 2.49.1
>

