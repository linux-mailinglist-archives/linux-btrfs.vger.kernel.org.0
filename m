Return-Path: <linux-btrfs+bounces-19152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD286C6F62F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34FF35002B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABCD31ED96;
	Wed, 19 Nov 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lj7Mwrp9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7235FF4D
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562606; cv=none; b=fyYLNabknln3JhpTZHp9xMUUrusoUUgDdAKWTj9Z6cwVzdSHrpQ1t316362HLJptUa8/ECsqb7BD8m+CmljY70/dOPE0QI44Ai1hWnEBP35nhYpa4b/G4LjYjDiJnw1vNiMwIly7pjGay/36C4gQc2N9PMDPJjNCf8JlWINjhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562606; c=relaxed/simple;
	bh=VN5l4hufeqpjWJ+oNzuHvh43Gmt1aUgmzLFnvTdhCC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5ko3yNJWHSpI7WvTWjTxOX+aMOQIaJL6nwA31sJEE1oNAf4gm8fHL9Zg5KZEFCUahXn89jDt+irVp9VkqkKNDzEtltJIz9wMz+3WTBAvDnOBkLzJBw4en7k1iKUcMMmKj/erZ0n50yAEwe3lb5f8ymV7lx0amRJ9SBY2DkU6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lj7Mwrp9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so3528981f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763562602; x=1764167402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6uoqOe94qQPvojuPFd3b8YKiVD7Nk2xIf+A7J/FPlA8=;
        b=Lj7Mwrp9IfvV/Kv00LPmWd8cnZaPJhI6I30ZcuD8Q3k5mii54xXxAOzD021nj3TjMe
         w4jQKG9bHQX348oNgMLmE57UST/FHK3+p8rqUxM9OyO2lWOKOzizIIYBYqP05ZSTFdr6
         A/8AOwr4Z+s/j1qm8B74LXkWfMcCuJybaJNZUBy26OybrmH3V0HUsF6rYs/7NKAYtk+8
         DINPjUrDmiKsgSLTJgN4WmFijawXhOc34NsxPkGPQT2FL7IjwxjIYsTAaKBwUi3ztWr4
         ELE/jAcq9zV/pxwHghnnQ9j1lzeZysYV5k58LvwccCnXASAry54RUhj1jkYDiTelGP1B
         zHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562602; x=1764167402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uoqOe94qQPvojuPFd3b8YKiVD7Nk2xIf+A7J/FPlA8=;
        b=CShp5oUbLBUvkvIweQA6Khjz0HFkVG+tch79zKdHpgTUPoaQ4desAIjBBfmRaPGu6Q
         I0C+P161FQbFT4pDzgtX2r0uC73DhWE6UoSwNGSHsMFQj5KLgdRtJlLC+06Jv7cm5GEe
         /fat3bbU0GQfMP8fMzarIyu2sv1JMTm91j2/GsNi1EBZbe4pQMHwDfsfoZH4TPxqkrvK
         Uk35i+uEnNmk/kD5buDQVpmWXIXMr6iz6MxUenT0kQzddchjLQKfSkrA0H6GH5x8et+9
         Wcw634/rxgRDhL3AtMGwTquSSUMo6kwgknUplUQ/NB6XRoBzSZ61t5Rp+LkTrvKS/rKf
         +byQ==
X-Gm-Message-State: AOJu0Yz61XZjEb4NOMfrTfUNgZJ/Vh7ygSHFzT1Lpk7brbqNtX1R5V7a
	cO5AL8hEbuBtAHP+YNY1yWR230JHpAwJEKQLNjmo/6Pk7QyYOODVNvtDuF6P4MO9F8aQtUH7tSd
	hyculjtqYW4aMm9DygMd3GdeLArhTdWaWJzezvKkxbuHt9phjjpk/
X-Gm-Gg: ASbGnctp2aLEeiN5Fw8Xk18/G56juRGis38/Q0AriPO1q/VJWyHerpqOA3jg4ZbWOPQ
	uijmIJJEYyKE8VFLIC7vGqgtdIlKpYF+xYo/4/QnXljGInEINeCn/d9FAjCFbvsirwxS7piyyHj
	N+UMwtCX0+ZB3QxtkzbKE9s3sX98t6hpdmtxljMWpT6RuyZeelG/8MRxk99EhFhAj9LtTGPQq8C
	c/5q2ORAqtMXnDCZdTJZwAlqXAlhWTgBE5SfhpvAWwqWVyPSBEzACVvvWOyYETHMcTIQ/ebuivz
	HGszcq4ckjy3n+Tho4sWARK0olyXO0Br2r3+leMZiJFCr2UGJSPlBJBsiR3z/P8CvG/9
X-Google-Smtp-Source: AGHT+IFL1Ixh6f+9kc2r4zCvUkSXjM2495peT695EdCS4suF4bEag140w+/MYwuhZP3PTZT65QZspxcdLd1BSQHFUkA=
X-Received: by 2002:a05:6000:1447:b0:429:cf88:f7ac with SMTP id
 ffacd0b85a97d-42cb1fb9a67mr3020470f8f.44.1763562602021; Wed, 19 Nov 2025
 06:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
In-Reply-To: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Nov 2025 15:29:49 +0100
X-Gm-Features: AWmQ_blnmPJoALiG-TNPiZ_tT2ZdMygPMreDcsoRVuf8bQ2xWzW2ev465PDDj_4
Message-ID: <CAPjX3Fe8ya88UCPv9=eyV6F0hTiNg80zFrptDWjFoWs3Cn1+8Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use test_and_set_bit() in btrfs_delayed_delete_inode_ref()
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 13:50, <fdmanana@kernel.org> wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Instead of testing and setting the BTRFS_DELAYED_NODE_DEL_IREF bit in the
> delayed node's flags, use test_and_set_bit() which makes the code shorter
> without compromising readability and getting rid of the label and goto.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/delayed-inode.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index e77a597580c5..ce6e9f8812e0 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -2008,13 +2008,10 @@ int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
>          *   It is very rare.
>          */
>         mutex_lock(&delayed_node->mutex);
> -       if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
> -               goto release_node;
> -
> -       set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
> -       delayed_node->count++;
> -       atomic_inc(&fs_info->delayed_root->items);
> -release_node:
> +       if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags)) {
> +               delayed_node->count++;
> +               atomic_inc(&fs_info->delayed_root->items);
> +       }
>         mutex_unlock(&delayed_node->mutex);
>         btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
>         return 0;
> --
> 2.47.2
>
>

