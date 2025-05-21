Return-Path: <linux-btrfs+bounces-14158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7811DABED6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C23B754F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C723535A;
	Wed, 21 May 2025 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J+WbbvED"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59478191F66
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814501; cv=none; b=iCVkz1/Y4OThAK1ewYHyI7liCITFJShUjxAzx0xCqaQCPORZtWN9XXTQhHkvl6OwQ3pFIP51c06Hc2bTNhC/R7TyUhTHk7AjLArDWV4h3JqVkzUWnRjgOeQLQh4hZoqpjXV4ya63ZQ9lYm1WSIkyJGPDQlw0N2hkWcrZE5eA37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814501; c=relaxed/simple;
	bh=OBwhallrpVpnxybBjLbMgC4DTUG+cz8t44SVl4mVlCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WByhZqaRkOXIQ65tywgKa18FgoKBSRrk/w7utSL/5OZajbvJikvgYGpQS91EzxbCpM3/VQVSaU0BuHTM+wrXzGSnBgbSb5kV1XepvbNbssGr+Vju90l21D6wEfTRSArutN1VJIyNwELR5m/Z0rHeOkWObmYnfNxJFpVaPrEtWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J+WbbvED; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad5a11c2942so188943066b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747814497; x=1748419297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f4IIoGLB0OqnLBpdxWZnxe+Ft0w0iNZSmapTOdLSYw8=;
        b=J+WbbvEDyglpHhWDCR7yZo3xfwqaXEEYSRvUo5dHAgPkA93yE9REyurS+e96ErkU6T
         lVdBUC26zKVG+ZqJbL461LiDNXaoTbJxid3dSjkchDg9FrIGQRbappAySuidZSreDWhG
         eGqHKJckwNeexKqwJ6K622wy8Hp8Q+rTiqP+4HRZjZG06ZHd/sLAG+AbGIj4wvPdk+gP
         WhB/tTC9OyjlYadZT/d5eT4B8DtlVyMsgTXTQlbi3IEARHkveTr08wBkmp1pOKT7cRFT
         Y4eoXwlLaK9/a0fM8LC0CC7gTFpIV32sZw38YAtNOiHIVQ/MQJQspUASs4vaePa1smNw
         FofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747814497; x=1748419297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4IIoGLB0OqnLBpdxWZnxe+Ft0w0iNZSmapTOdLSYw8=;
        b=nJkwKjNqzsnL2T3uxZDQkiYrzeboDp0PXtx3p1yBDFxoLWv0Q/j1zDcJ+iamyD230F
         PUrHwzUYaX2MGU2Gnu47O5bLkWv3d7y1zi1HeV0rkZH2zCa7YeV8cq42citkHCwyvMFB
         d3/UkBu+Vdm1y/pHO6HS8+LTs2HPuemu4aL0mvFP4lG0XdYifrW1HSCfq8uPrA2LuM9P
         lqvaYIKEZUF30SdfJCUk4S5cAbxKPTQ60tkC7xjyITbKpE27vIUQjsp+/778WJxX87IO
         qZFXKyYwQc4agG/hqwNKpPeWWjSa0wL7HJlMuxvXYIXa6yAZoGBIKqllBwGgI+M5JaMk
         o6cw==
X-Gm-Message-State: AOJu0YzYHFdCrQVOy0ZWpYBRS6yUj0bJh7TRyikflA99lHNv7Mzp9eRE
	zbp4K76f4S6y4529RKRXLR6q5ux+0iAEOJLnBDblFW6bveEZBJKWmKnNJAvPWFe2m/78Ht0JoR6
	RYoJ7TnmylH5tJC96mPzteavRxZFXm9AqZ+Tsjm+bLHWpEkh6Ckjx4ro=
X-Gm-Gg: ASbGncsPArh9Un/Fm0I8+nRQolSF8V5SYr+Ilzd0ffvelNoFOgXyjjsIyBx7fCV8cpo
	goQKkMSZdGObFfHLdYq+8mTW1u96dc1fSDloeG2XtWdeWPn/E7KImO7kAlgZawRSczpNa663I/C
	xW3MdllOtZRCBsDm1W9l3jmrI9ZowZ55WoAtG563l6GjNjHbarMYJZt/bhCgDO5/EZhg==
X-Google-Smtp-Source: AGHT+IGiMgFnnYiQXongtxWd13ZcUExzgaPdO+8RRw00YS2eLBRkjBAIGE0p5EMdAQA4/Alq9iZtm3XfFBPDorVq7jI=
X-Received: by 2002:a17:907:3d10:b0:acb:33c6:5c71 with SMTP id
 a640c23a62f3a-ad536c1a834mr1600048266b.29.1747814497622; Wed, 21 May 2025
 01:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af31c7ae4ba5c76d57527f5a774f3816f69b54d8.1747695628.git.wqu@suse.com>
In-Reply-To: <af31c7ae4ba5c76d57527f5a774f3816f69b54d8.1747695628.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 21 May 2025 10:01:27 +0200
X-Gm-Features: AX0GCFtNjOxN34ZezP_cf9wo9u9D5JnsPCyQXc2HUGTrXRUkh3OdbglT2qMMkac
Message-ID: <CAPjX3FfVS3g8qBRXbRh8qUtZPxj2DEjVz8Ha5sFzTvyzBFPCRA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add root id output for direct IO error messages
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 01:00, Qu Wenruo <wqu@suse.com> wrote:
>
> When debugging a kernel warning caused by generic/475, the error
> messages from direct IO lacks the subvolume id, meanwhile th error
> messages from buffered IO contains both subvolume id and inode number.
>
> This makes debugging much harder to grasp which inode (and its
> subvolume) is causing the problem.
>
> Add the subvolume id for direct IO failure message.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Daniel Vacek <neelx@suse.com>


> ---
>  fs/btrfs/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index fe9a4bd7e6e6..983b8cb9f688 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -649,8 +649,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
>
>         if (bio->bi_status) {
>                 btrfs_warn(inode->root->fs_info,
> -               "direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
> -                          btrfs_ino(inode), bio->bi_opf,
> +               "direct IO failed root %llu ino %llu op 0x%0x offset %#llx len %u err no %d",
> +                          btrfs_root_id(inode->root), btrfs_ino(inode), bio->bi_opf,
>                            dip->file_offset, dip->bytes, bio->bi_status);
>         }
>
> --
> 2.49.0
>
>

