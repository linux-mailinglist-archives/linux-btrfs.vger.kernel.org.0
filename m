Return-Path: <linux-btrfs+bounces-17417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D74D3BB74A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610B14E5A8C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A032836BE;
	Fri,  3 Oct 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYII0nTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFE1F3FF8
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504307; cv=none; b=Fz8QiknkjpS4IWmGPnK/X5i/l2+l4pidHHS24qFWmeDHiRQiX9Q17qPIFvnbCEMPxbmdc5EK/y/6T2vdzGrlJR3Aim0qpRvb8cTCY/mhtDc8Qfws32g0O9iwaUVb1qa4E1qcZTRT4ocKZZWz393OWJU671tBhUoUrxXhul54pVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504307; c=relaxed/simple;
	bh=LY3PvXBP3zGIEn1YgDbcXBjB77bFCBNqz29jcmUiBd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9vb9eIr03a52JgBX2UDT19nDmcr3ob6xh7eLf6kunur9jPQUZxHS1y/OMgR7qJ9naL9Uqy3IYsXM/zcT4CYX0rAGZIZAz1KbFwpggKzMjnXO4ot5NZSDCHNa9M2jihtaU/1+TuCVkZxhIjwKKg9wpZG9Mftw7tqFVHdgoVlxQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYII0nTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08045C4CEFC
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759504307;
	bh=LY3PvXBP3zGIEn1YgDbcXBjB77bFCBNqz29jcmUiBd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DYII0nTM/CPcXmbLt9i5iXQDBCcTXcDiMz0vsrFxae4ZxfKzppNu7Fzhi4E9bC4F5
	 s8tNYMP7Y1pZv9BnPih08uCHg2fDgzKsA0FZanpjdAWkmekNZxKmgzzf/Xkj/3aaV/
	 vD1tuDcLgZenwxn//N8ZyvChM7owZnIU4K2/4fDGK8zPs4QjrKW3ommAEkV32vsHMH
	 P7bxT4izgcaQPNyITvdi2vzIViTDvvdqLHkj/mnY7bvwRMERcNKLOj/8nFfitE2Moz
	 6EumFMqtopmhqOmTYE41blFSGHI/fzt0A96v8sF6X5NvgPhQ3vu83M/cx7IXwl287y
	 f0cYgUG8QliBw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78ead12so442964166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 08:11:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjT54pt+qcCCnN+JK8NqRFhJJy4Rv7Fau0sCKPNoNvVDWFoGPeaVgkd0C23E2bhSTqsa+Yj+aykuNwtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmR5o9Xh8Is5B9/nhQOYrP85V6BZQNIj4D9ftdVzn+bnh1XTLt
	9E+NN1VrwBMctx/7VrHb5OX8fah2VPSp2q6c3MQwEtJ8GD+SLcJUrMBSI/RYgtokbrbw09jBcAJ
	fvMLtfn4gEO3oYbr56EE6WqdmrXWqCa0=
X-Google-Smtp-Source: AGHT+IETuMWMxTDVJzk9wfD2XJioIGxW7pV9rF33Arl5/N+2t9VGcvR+bzQqzrf9RiZ+XQ3eJBquUFxQCCOno5F7Tjc=
X-Received: by 2002:a17:907:7f8a:b0:b45:27e0:7f35 with SMTP id
 a640c23a62f3a-b49c43930a2mr474332866b.46.1759504305581; Fri, 03 Oct 2025
 08:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003133001.45052-2-rtapadia730@gmail.com>
In-Reply-To: <20251003133001.45052-2-rtapadia730@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 3 Oct 2025 16:11:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7kLUGtqnc7bBSrTZ70Gx1z-ijeWQfPx=TiN+2PCoe_ug@mail.gmail.com>
X-Gm-Features: AS18NWD3WZ4EBVCxvGU7fRzOjZoeBfxCqIReN2M8TD26-OSBtf4BA2ypHjjUZ70
Message-ID: <CAL3q7H7kLUGtqnc7bBSrTZ70Gx1z-ijeWQfPx=TiN+2PCoe_ug@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix comment in alloc_bitmap() and drop stale TODO
To: rtapadia730@gmail.com
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, khalid@kernel.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:31=E2=80=AFPM <rtapadia730@gmail.com> wrote:
>
> From: Rajeev Tapadia <rtapadia730@gmail.com>
>
> All callers of alloc_bitmap() hold a transaction handle, so GFP_NOFS is
> needed to avoid deadlocks on recursion. Update the comment and drop the
> stale TODO.
>
> Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.
I pushed it to the for-next branch:

https://github.com/btrfs/linux/commits/for-next/

> ---
> Change log:
> As per previous review the change is not required. So just removing the
> stale TODO.
>
>  fs/btrfs/free-space-tree.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index dad0b492a663..bb8ca7b679be 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -165,11 +165,9 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
>
>         /*
>          * GFP_NOFS doesn't work with kvmalloc(), but we really can't rec=
urse
> -        * into the filesystem as the free space bitmap can be modified i=
n the
> -        * critical section of a transaction commit.
> -        *
> -        * TODO: push the memalloc_nofs_{save,restore}() to the caller wh=
ere we
> -        * know that recursion is unsafe.
> +        * into the filesystem here. All callers hold a transaction handl=
e
> +        * open, so if a GFP_KERNEL allocation recurses into the filesyst=
em
> +        * and triggers a transaction commit, we would deadlock.
>          */
>         nofs_flag =3D memalloc_nofs_save();
>         ret =3D kvzalloc(bitmap_rounded_size, GFP_KERNEL);
> --
> 2.51.0
>

