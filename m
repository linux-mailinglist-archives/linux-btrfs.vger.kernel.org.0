Return-Path: <linux-btrfs+bounces-1208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE68239ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2698B2465D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBD4A24;
	Thu,  4 Jan 2024 00:57:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1F3FC8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so447511fa.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jan 2024 16:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329862; x=1704934662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YYPJw8d92SKaDewagAATP3R3KKLZhjMYxC8s5zej7k=;
        b=Lv12kMxbOSm/SqpcOCqsQDOvV4cSbkheaLBzGsAv5R2N1yf+pYsYIP3i/Q50tcdlys
         ct7lBUNwJCskRAUTmS1DLqrT6U/kvJZebDk8EbeACKvzwo0f3h6JUT2G7zdpA/qMun1e
         oa2cJVOtwuFZe63VloWFStFC3hQet2qJKDAed9a6ewMRE1QvC7d9/3TEWFZI6QdAayuZ
         duLnd8nJUUISsVvtiRubqmI/1tNKCxHbxzN3j1qhhKK+5NH1j7/KZbHW8QbiQ8Hrq2Xe
         lj75+k0nrfWuvDK4pBjEejdFdAFcznFu4VM9ONRqygtso/7f5NLTD+CphbC69r0asJSz
         P0Dg==
X-Gm-Message-State: AOJu0YykUFikAHZaqQ7ZA/OBnl95uMROgA8R1EfW7agVPZ6do1TynKsl
	jWPYkeg5J68vh+gPj5SBh4T5IJiAGTsnSjTH
X-Google-Smtp-Source: AGHT+IE2a61QpECyq3Q88AK4U8GoZKd4rS9M+U7I4NE6tiq+JOiDElnfcy1mM3dNUecM8iIv+X2R+w==
X-Received: by 2002:a05:651c:54c:b0:2cc:d4ae:c2ce with SMTP id q12-20020a05651c054c00b002ccd4aec2cemr7379637ljp.38.1704329861493;
        Wed, 03 Jan 2024 16:57:41 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s6-20020a2ea106000000b002cd12db0546sm713792ljl.117.2024.01.03.16.57.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:57:41 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eac018059so1325e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jan 2024 16:57:41 -0800 (PST)
X-Received: by 2002:a05:6512:1246:b0:50e:74f0:810e with SMTP id
 fb6-20020a056512124600b0050e74f0810emr8796904lfb.137.1704329861072; Wed, 03
 Jan 2024 16:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
In-Reply-To: <f94513bea5369c4ea65c8dab9a5a83403381c521.1704226673.git.josef@toxicpanda.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 3 Jan 2024 19:57:04 -0500
X-Gmail-Original-Message-ID: <CAEg-Je9Lk-LbAhgH5+yeQ+pH7F4xXz4+Tf-K5ZVktwqqZRDJNQ@mail.gmail.com>
Message-ID: <CAEg-Je9Lk-LbAhgH5+yeQ+pH7F4xXz4+Tf-K5ZVktwqqZRDJNQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: WARN_ON_ONCE() in our leak detection code
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 3:18=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> fstests looks for WARN_ON's in dmesg.  Add WARN_ON_ONCE() to our leak
> detection code so that fstests will fail if these things trip at all.
> This will allow us to easily catch problems with our reference counting
> that may otherwise go unnoticed.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c        | 1 +
>  fs/btrfs/extent-io-tree.c | 1 +
>  fs/btrfs/extent_io.c      | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c6907d533fe8..5f350702a4d9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1244,6 +1244,7 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info =
*fs_info)
>                 btrfs_err(fs_info, "leaked root %s refcount %d",
>                           btrfs_root_name(&root->root_key, buf),
>                           refcount_read(&root->refs));
> +               WARN_ON_ONCE(1);
>                 while (refcount_read(&root->refs) > 1)
>                         btrfs_put_root(root);
>                 btrfs_put_root(root);
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index e3ee5449cc4a..1544e7b1eaed 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -48,6 +48,7 @@ static inline void btrfs_extent_state_leak_debug_check(=
void)
>                        extent_state_in_tree(state),
>                        refcount_read(&state->refs));
>                 list_del(&state->leak_list);
> +               WARN_ON_ONCE(1);
>                 kmem_cache_free(extent_state_cache, state);
>         }
>  }
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a0ffd41c5cc1..a173cf08eb8f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -82,6 +82,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_=
fs_info *fs_info)
>                        eb->start, eb->len, atomic_read(&eb->refs), eb->bf=
lags,
>                        btrfs_header_owner(eb));
>                 list_del(&eb->leak_list);
> +               WARN_ON_ONCE(1);
>                 kmem_cache_free(extent_buffer_cache, eb);
>         }
>         spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
> --
> 2.43.0
>

Great, simple, and useful! A nice trifecta.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

