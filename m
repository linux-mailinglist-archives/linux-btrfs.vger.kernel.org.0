Return-Path: <linux-btrfs+bounces-8382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FF98BB04
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD94E1F228F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3141BFDE2;
	Tue,  1 Oct 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwXKMEU9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262031BF802
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782080; cv=none; b=LE+JzZsiLs/52kcSd+zdX4EHpGSyEMBEz9pY5Ui66IpzbYlvoiop9woQtaFHLR6RGmNQogyapq67QeccmI1OphvXP6Ify/hUawQIRrU5lB47A7AtAA9iBcvJ+U4nf7c2QpCDqQf8ED26pl7fLpSSkGDhHJpEEGpphBfdpRQvQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782080; c=relaxed/simple;
	bh=j2YN0E4875eCkH7MYr1uX8kw4DS9u7XxWwd+gLhD69Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIpneXB3uOvEbCCdSzkDHvnsRSL7f9bg81JdVCS8yGhdBTNiX2fQugNw4UNCaRVbFyNtGsALn3IDaRmIi10Uot6MZsotD/7dhAJms87Mqg1CjIfTH69Pw8ki5x61ME45rf+cWpLbBC35XjjDIdEqkOoyYjP7by9QOKIJlBTd/4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwXKMEU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AA5C4CED1
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727782079;
	bh=j2YN0E4875eCkH7MYr1uX8kw4DS9u7XxWwd+gLhD69Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NwXKMEU9Ny5yj646uiE3cA31Um0M7k3m77Q/+Y7Orh2KS9UEzGeX77Lp8qwdHX7u/
	 c1sokHRyqrGflcMjvDzElp/ESBj6j+oYoRdX4Ns30D4TTa0uzlGNsJfXXnsTIwpbOX
	 MWdYvAzh25nbdK0Cr7C9je8pCF6dFsPxGLUAulCP4S6ab35L6+AmXvCPV3UeIXeeZO
	 WQBJAMOIwWDKPsmG/KORUAtx+/anC/ZfL1/589z1k7PVp4kocvDwyNdIyvPwWBJm0y
	 Az03KC7BxX0j1qf+NVdu0OZsHghrjLGZjNN6gTRA8WTn80k+JUuKtHzmMKNLyS0som
	 0hYo8iKNR/AGw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso825159366b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Oct 2024 04:27:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyBSIyOCyYCeRjLflRAmbyv2yNJbb5HdozYaWtKso8cOqN2dkfM
	ITGnHIBydadGsNJRhVJRzs/SJEX9aZt3sFOXFgLaWgPFbRhyuy8wDhp+uiO87urNWkSLZQKXi6R
	Y9WnbQKdCf6bTtEyyWKN7oZJhHaY=
X-Google-Smtp-Source: AGHT+IHKQ6wIaS3Q1t6vrBDKUu7vpz2KWddz23BbShKe+n398Gus/IOW4ig4Syqj+A1jooYAjHJJVnEfl0ehbeStTCA=
X-Received: by 2002:a17:907:a08:b0:a8d:55ce:fb97 with SMTP id
 a640c23a62f3a-a93c48f33c3mr1892637366b.11.1727782078494; Tue, 01 Oct 2024
 04:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOcd+r1Cwaa9SG=ND4RtuT0CBP4gmCE1tvj0uW-VybD2hry_uQ@mail.gmail.com>
In-Reply-To: <CAOcd+r1Cwaa9SG=ND4RtuT0CBP4gmCE1tvj0uW-VybD2hry_uQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 1 Oct 2024 12:27:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6xcBs20+O5T5yOkJ4KYnPjZjgzU2JsFpo29MDvb6_yEw@mail.gmail.com>
Message-ID: <CAL3q7H6xcBs20+O5T5yOkJ4KYnPjZjgzU2JsFpo29MDvb6_yEw@mail.gmail.com>
Subject: Re: assertion failed: ctl->total_bitmaps <= max_bitmaps
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <quwenruo@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:09=E2=80=AFPM Alex Lyakas <alex.lyakas@zadara.com=
> wrote:
>
> Greetings,
>
> We have hit the above assert a few times in kernel 4.14 LTS with
> stacks [1] [2] [3]. In all times it happens on a METADATA block group.
> We are not using free space caching - not v1 and not v2 (free space
> tree).
>
> I looked over the free space cache code in kernel 6.6 which is the
> latest LTS kernel. However, I did not see a fix related to this issue.
>
> I did see a patch that prints some information about the block group
> in case the above assert is fired
> (https://www.spinics.net/lists/linux-btrfs/msg127072.html). We will
> apply that patch.
>
> Is there any other way to move forward with this issue?

With a 4.4 kernel, which is no longer supported, and supposing it's a
zadara storage fork, you are on your own.

We had a fix for a bug that matches what you are experiencing, but it
didn't end up merged to 4.4 stable:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D3c17916510428dbccdf657de050c34e208347089



>
> Thanks,
> Alex.
>
> [1]
> Call Trace:
>  dump_stack+0x5c/0x85
>  panic+0xe4/0x252
>  assfail.constprop.18+0x50/0x50 [btrfs]
>  recalculate_thresholds+0xa5/0xb0 [btrfs]
>  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
>  ? _raw_spin_unlock+0xa/0x20
>  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
>  btrfs_del_leaf+0xa5/0xd0 [btrfs]
>  btrfs_del_items+0x3f9/0x470 [btrfs]
>  ? btrfs_get_token_64+0x103/0x120 [btrfs]
>  __btrfs_free_extent.isra.63+0x626/0xf60 [btrfs]
>  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
>  ? walk_up_proc+0xa2/0x600 [btrfs]
>  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
>  btrfs_should_end_transaction+0x3e/0x60 [btrfs]
>  btrfs_drop_snapshot+0x3db/0xf70 [btrfs]
>  ? __schedule+0x298/0x8a0
>  ? __btree_submit_bio_start+0x10/0x10 [btrfs]
>  btrfs_clean_one_deleted_snapshot+0xb6/0xf0 [btrfs]
>  cleaner_kthread+0x330/0x3b0 [btrfs]
>  kthread+0x11a/0x130
>  ? kthread_create_on_node+0x70/0x70
>  ret_from_fork+0x1f/0x40
>
> [2]
> [2512545.669387]  dump_stack+0x5c/0x85
> [2512545.670047]  panic+0xe4/0x252
> [2512545.670660]  assfail.constprop.18+0x50/0x50 [btrfs]
> [2512545.671612]  recalculate_thresholds+0xa5/0xb0 [btrfs]
> [2512545.672622]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
> [2512545.673629]  ? _raw_spin_unlock+0xa/0x20
> [2512545.674405]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
> [2512545.675401]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
> [2512545.676259]  btrfs_del_items+0x3f9/0x470 [btrfs]
> [2512545.677165]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
> [2512545.678156]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
> [2512545.679245]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
> [2512545.680285]  ? finish_task_switch+0x74/0x210
> [2512545.681112]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
>
> [3]
> [1272566.513241] Call Trace:
> [1272566.513764]  dump_stack+0x5c/0x85
> [1272566.514442]  panic+0xe4/0x252
> [1272566.515080]  assfail.constprop.18+0x50/0x50 [btrfs]
> [1272566.516071]  recalculate_thresholds+0xa5/0xb0 [btrfs]
> [1272566.517119]  __btrfs_add_free_space+0x2d2/0x430 [btrfs]
> [1272566.518155]  ? _raw_spin_unlock+0xa/0x20
> [1272566.518963]  btrfs_free_tree_block+0x19a/0x2e0 [btrfs]
> [1272566.519993]  btrfs_del_leaf+0xa5/0xd0 [btrfs]
> [1272566.520891]  btrfs_del_items+0x3f9/0x470 [btrfs]
> [1272566.521833]  ? btrfs_get_token_64+0x103/0x120 [btrfs]
> [1272566.522847]  __btrfs_free_extent.isra.63+0x626/0xfa0 [btrfs]
> [1272566.523975]  __btrfs_run_delayed_refs+0x74d/0x1cf0 [btrfs]
> [1272566.525082]  ? btrfs_add_delayed_data_ref+0x251/0x2b0 [btrfs]
> [1272566.526235]  btrfs_run_delayed_refs+0x62/0x270 [btrfs]
> [1272566.527283]  __btrfs_end_transaction+0x2fd/0x520 [btrfs]
>

