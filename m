Return-Path: <linux-btrfs+bounces-14260-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF6AC5AE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 21:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CD53A7E4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD828A3E2;
	Tue, 27 May 2025 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjJAYbi1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E828A3EA
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374734; cv=none; b=Uc4p05zJH0nvTCIF0XNDva0REL/n/HrpmeARYXUAUDWH+BdSB9CwVA1N6jg2UkPoj3zSfadfD3NQgmP7ZIENT5Zu3fiOGXEa7Nml2t82te9LbVmqUXr2TVXtis4/+TYoQ5rHweybXexIO++Y9SMplM7OrLX/r1gnopJdpVMfAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374734; c=relaxed/simple;
	bh=Cya3F2dXUz/n2XeAdQk9uX/gOFa69ADjio4Kw/Lh+R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqU4rJuJHJzDBsxQGIcZ8grEQyMbqGJHiBLEzNEtXxOvY7JRZOphkDwvS/wzMxS9q3JvTUtNOwIQu8I6blyCURUyoBayb3B4lh+yMIyAlQD3csPGv2qYkGRc+zHZqKkEcIrhu+Tth9zJHYU8AmS+WhwpYPXK14NggrQMVc0Auvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjJAYbi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769CFC4CEE9
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748374733;
	bh=Cya3F2dXUz/n2XeAdQk9uX/gOFa69ADjio4Kw/Lh+R8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CjJAYbi1YQTlLoOn4DWuxQBHXFvBGwOU9OcW5c0F2Gp3kDpwWNLHWTxxJDWlbFgIl
	 m5uiVpTes51HbWN0V5oTP61LXuNcehRw4pEtYr065vwraKEEVps6HOVMuO/rF4e/9S
	 9eGI6mFL6M2BkVy9GsKWtzw89d5lXwY79P4o6ugCevmyTOAKJ24UHvqZxjNLI11Eo6
	 cffh8f1qC9Cz7GFKwTWLGFSyyOEI88BNyO7Jrv/87Z9nJ67Bsv2mG7ItqYSgZINTAw
	 LMLKJ6Zzh3VOQqBiJjmmXLmnUMnR9OxwyoCDceMqKWfjVOj4PDcLqtuXhsMYDbOsAq
	 LETACL2dLGL0Q==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad1b94382b8so628935766b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 12:38:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy2lJH0anVm1Ebywt7lRi/avdyDjMZP4QyBxctx+6383l3kD3Eo
	sh5ojGC0XAG9lAxqX3StNWuNJz1ukgKQxDwzc/cGeNHvuNIXeSbm2/WniGUMs/RtXh15panHV7h
	yjRiPKqaZQ7QhJ9uAZQfpSsFYXi2OD0g=
X-Google-Smtp-Source: AGHT+IHxlMQ0/SUccjudLbDSC/IXq/o+0VORh7/mCHxY4Fo4kG3D4KdB6o7WCthFtFyLdgVMVy6q4dzGIgXuCbOqFCk=
X-Received: by 2002:a17:906:f585:b0:ad8:8b51:ddb4 with SMTP id
 a640c23a62f3a-ad88b51df34mr426853966b.25.1748374732125; Tue, 27 May 2025
 12:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748373059.git.loemra.dev@gmail.com> <023ae97cf64384f4187ff03d54f03830e904df39.1748373059.git.loemra.dev@gmail.com>
In-Reply-To: <023ae97cf64384f4187ff03d54f03830e904df39.1748373059.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 27 May 2025 20:38:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H50wbH0xipzPx6EzM_0g59EKRURKu-htuTB22z-TsRLOQ@mail.gmail.com>
X-Gm-Features: AX0GCFux5yZfdVBFWonnKvdL86sNXgymoexRrrhexE-BsfGX8YaMgzy-Fs6obrA
Message-ID: <CAL3q7H50wbH0xipzPx6EzM_0g59EKRURKu-htuTB22z-TsRLOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: warn if leaking delayed_nodes
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:29=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> Add a warning for leaked delayed_nodes when putting a root. We currently =
do this
> for inodes, but not delayed_nodes.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/disk-io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1beb9458f622..3def93016963 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1835,6 +1835,8 @@ void btrfs_put_root(struct btrfs_root *root)
>         if (refcount_dec_and_test(&root->refs)) {
>                 if (WARN_ON(!xa_empty(&root->inodes)))
>                         xa_destroy(&root->inodes);
> +               if (WARN_ON(!xa_empty(&root->delayed_nodes)))
> +                       xa_destroy(&root->delayed_nodes);
>                 WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state=
));
>                 if (root->anon_dev)
>                         free_anon_bdev(root->anon_dev);
> --
> 2.47.1
>
>

