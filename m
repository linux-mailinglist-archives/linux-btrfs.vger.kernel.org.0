Return-Path: <linux-btrfs+bounces-14251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13EAC4CAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6B217BC94
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA242253F2D;
	Tue, 27 May 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cj+LUWJs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0B192D87
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 11:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748343748; cv=none; b=MH2VDWc6Sx2ooX9b/s2cYVXe2tsbdtLPFRf480MDEqPzOeGRLbLGuSrIEKZzZaBlvNEVzsDpqE6tCt4ztzonz9AXFyTJFU5yceG2zL6knUiltZEZLa5CqHz3m+sTgR7GJf49uKo8kPBbkRMO72CxLsi3GNC+jD3NxzkYZR7QY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748343748; c=relaxed/simple;
	bh=efi+DaSqln6l95iOZ2wR/HPM19FBkWbDfqPXgpIWLnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5gT1zTR4mxhXrqEgWRzi8DrjP41eKxYIhBFvxawGiNaTM2S453kauTVk/FUB216KfzS/Nl/MvRuzBM0bp80bT+lqJayEHdtUUgr6PWsG89J6e1V+oIL4U2Sg4QkPfAKx+jWcVPjKeg+jUL2BpJDgprtXjRemh4A/g+9m/WAXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cj+LUWJs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso5213805a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748343744; x=1748948544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5rzGsR2tUjDt/k6AfQcoOXOxZeqAM7rSC0iZ6mus+hM=;
        b=Cj+LUWJsWw+seutxGiypeZMz68hA13lGjMWGCUueKC9Y9jSMqtVDRQvjJI4NTu3KFD
         npyMuSRAmQWOmQV5Si5PXh289PzGz0ctge1J80HdCIYSa8ElLfeMk31+RDBHLnTNasFh
         i7utxtnvDxz7TST0MJCXGQ+ULUYdMhQIW7fifx8X/jzjp6SME7pSPE5uH7JQqpFWbwjJ
         UlVhsETDoE2XZd4MkNaeX9oAl6Ii1mLTKfX+0hSdbVFPtnwp/kx9xl/qmepkTueRbMS8
         sJf1x6c2JbcYh5LTyfRygJxEXolDwBd0i7NMlOYpnprQsSPeyyzuICNhZYUlZtLrXiYH
         wJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748343744; x=1748948544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rzGsR2tUjDt/k6AfQcoOXOxZeqAM7rSC0iZ6mus+hM=;
        b=nut0seumvr+eIVcnTNDwpPEOzPoOg8UIoylvdv6aqpCIBKWQkR0uEPMMDw8ag3d5eR
         wsXzv31RT/xVapO5UYu7dT8e7NA93BdIjlVRR/j/U/IwAAh2YSvVKjV8J3NyTq8TCdIF
         o7rZ5utAVssJhSSDR0cppt6AJv4DGjw+X0B1eqS3UmLgM/knNwKpoBO5etTrzOZqG+/a
         vxor73gPLF4ZSTZAdXHzbF8CvboetwkrAoMGcPk/WFIs7RzJWndzMUMBvDZqe51SG96B
         L03raQo2Uhanml8XLYxgKqLACSSt3WoByn5SrOEDC0CbWi490VkqVKhZlCDJIbdcML1y
         bXYg==
X-Gm-Message-State: AOJu0YzcaUxtHHtTaxIwgk8kq7TA+G5dlYq+eZHynD3yiKivN9ASPJbp
	UkfJvjHhukxVLs+/vKsjhnyn639FuiNKshDz2aVXO62gRs5jX/pTmjdXXF2inJccdLoMupGK7xy
	xK78uZ5Ys/V4CzSNTN2Iy795hhicl0SUB03GWZNE+4g==
X-Gm-Gg: ASbGncslbMyWqMwIj3hl0C3numV2zr3dak77O2/rPQRg5kSXAFuBYrII7GvNH9VoUUP
	Blyx40uTR5QpiVepPEh9mXFMhxbHyAUaXFmu0O6Cr0j+6lWXn7CUlM0WfRDgftHVYfeDt/0jP2A
	3VPOvEF0A36CEVwp3ormYRQ2per5M0UeY=
X-Google-Smtp-Source: AGHT+IFoLC3otcTMBAlMJNQmO30xhpz0kzfnBIWoOZh7jOyFKxrYSICA5vYswwRpLYwa7ndJ8hAeeLDYSqE1j94twmE=
X-Received: by 2002:a17:907:7f1f:b0:ad8:959c:c55d with SMTP id
 a640c23a62f3a-ad8959cc7d5mr80128566b.2.1748343744262; Tue, 27 May 2025
 04:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6bf92c79d644323883eb18bbde8f45dde8e6476.1747652848.git.fdmanana@suse.com>
In-Reply-To: <a6bf92c79d644323883eb18bbde8f45dde8e6476.1747652848.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 27 May 2025 13:02:12 +0200
X-Gm-Features: AX0GCFuOU4XiGAgoxH6nXN8903zVRlffJXXz-wi9094uprB_Qan88yxTQm-X4e0
Message-ID: <CAPjX3Feh=RsR_a-+qgKnf8_dsVgDjcaz+NZea-F9k=LEU3fsig@mail.gmail.com>
Subject: Re: [PATCH] btrfs: unfold transaction abort at __btrfs_update_delayed_inode()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 13:08, <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> We have a common error path where we abort the transaction, but like this
> in case we get a transaction abort stack trace we don't know exactly which
> previous function call failed. Instead abort the transaction after any
> function call that returns an error, so that we can easily indentify which
> function failed.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good. Thanks

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/delayed-inode.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c7cc24a5dd5e..3d25510db388 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1008,8 +1008,16 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>         ret = btrfs_lookup_inode(trans, root, path, &key, mod);
>         if (ret > 0)
>                 ret = -ENOENT;
> -       if (ret < 0)
> +       if (ret < 0) {
> +               /*
> +                * If we fail to update the delayed inode we need to abort the
> +                * transaction, because we could leave the inode with the
> +                * improper counts behind.
> +                */
> +               if (ret != -ENOENT)
> +                       btrfs_abort_transaction(trans, ret);
>                 goto out;
> +       }
>
>         leaf = path->nodes[0];
>         inode_item = btrfs_item_ptr(leaf, path->slots[0],
> @@ -1034,8 +1042,10 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>
>                 btrfs_release_path(path);
>                 ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       btrfs_abort_transaction(trans, ret);
>                         goto err_out;
> +               }
>                 ASSERT(ret > 0);
>                 ASSERT(path->slots[0] > 0);
>                 ret = 0;
> @@ -1057,21 +1067,14 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>          * in the same item doesn't exist.
>          */
>         ret = btrfs_del_item(trans, root, path);
> +       if (ret < 0)
> +               btrfs_abort_transaction(trans, ret);
>  out:
>         btrfs_release_delayed_iref(node);
>         btrfs_release_path(path);
>  err_out:
>         btrfs_delayed_inode_release_metadata(fs_info, node, (ret < 0));
>         btrfs_release_delayed_inode(node);
> -
> -       /*
> -        * If we fail to update the delayed inode we need to abort the
> -        * transaction, because we could leave the inode with the improper
> -        * counts behind.
> -        */
> -       if (ret && ret != -ENOENT)
> -               btrfs_abort_transaction(trans, ret);
> -
>         return ret;
>  }
>
> --
> 2.47.2
>
>

