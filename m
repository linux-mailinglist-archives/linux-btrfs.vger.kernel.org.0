Return-Path: <linux-btrfs+bounces-16866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E33B59F72
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F4F17CC02
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846F2E7F3F;
	Tue, 16 Sep 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYEmoMqO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA2279DC9
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044214; cv=none; b=RTGXJH0l+80lPunTVrI4RruhLGbJUv+3at7NAqfakvIX31Z8iyW1VUuNzNHApinQUAfpJzD5hCMukZWMqljIQQf4ka+jFzBnyS+fZuQ4Pbk9Bx7rC/qxnqCvDdUjnxGo56GTAYUnCSe6CRmQ8b+wMTqYcXERdJpTMUH8yIa7vXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044214; c=relaxed/simple;
	bh=+MJKopKiPN2pPgXR+G5XAVKYtSytuvGLaakyjVY7W2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2XAlfZ1SAR1dfwSCllV6MjKG2vsKx7Fkvsx+5rYKpRm7HnKYRPOVoqyGT3hiIZrnN2tF09CpdBYPykVVt0ut9C5V+id2VvlmmZOiBXnOkSDW9YlO2X6ZT6j6zlwpLQLCnAQ03lrojQ+MGfCV2cEye8gL1u41etGGT3IbFxUCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYEmoMqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839B2C4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758044212;
	bh=+MJKopKiPN2pPgXR+G5XAVKYtSytuvGLaakyjVY7W2U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UYEmoMqOQ6JAsf4gd593f58pSv/P8eqck+HPxs5+X3svALItSEwuFirWUUNIzfMc2
	 4HjQVy9DVHu1bHffOjYATB/kRvuziMb7brZqu6f9W5ZrYcffn7a0Tx938nF0c+xOsp
	 xrkn3Yssk8VuIBBiCQO99pbVS13F/OAH22KcNKvZMnSnyWGN08eiCq3OrWpHQWuJqP
	 O+jNr5FXUi5BtB3eB+Ri6LpBrZWl+Jw3ube6ojhrs+wslH7FnADMzAKbMTN3JqQt0w
	 GGqUKklvLqbkTnPtbHplabvXK7dytLRXKhoJSnddt+wqK7rUfiTo9tB07kvCMibntb
	 OgpHfZwM9HcoQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07e081d852so610151566b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 10:36:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YydxoschXzOEPGeJbjfRCnClMaP0vkhu6JarSsNIZYaVMTn8tQz
	uN3q/vrAPwaE/0tdT63KUvHQYlWrlGcsdj4PKZZiu0vuz3+drGKkPcFEgYmxCFxYXcoJEusOCxz
	ZozPn79AFmIQcOWl7/rdriyCFelYnrO8=
X-Google-Smtp-Source: AGHT+IGEPjCzFPqx3v+TOkAH1znxlPvwn9mS1eRJI8EYB4VYGvg4Hw3wUTxlkRcWBtJV6gWPZWqkK9QWErUzEcNCDBQ=
X-Received: by 2002:a17:907:26c3:b0:aeb:3df1:2e75 with SMTP id
 a640c23a62f3a-b07c38694d3mr1939624466b.46.1758044211068; Tue, 16 Sep 2025
 10:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
In-Reply-To: <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 16 Sep 2025 18:36:14 +0100
X-Gmail-Original-Message-ID: <CAL3q7H400uJ9Tb0VJuC+1BUg468-Q3sXjuXJF9A9i96nu2JiEw@mail.gmail.com>
X-Gm-Features: AS18NWCj-2ABOr_J69qrbKkNKMAizS9dLHzEpBrhO6Oj6yd89gEfhSQaGc1OSKc
Message-ID: <CAL3q7H400uJ9Tb0VJuC+1BUg468-Q3sXjuXJF9A9i96nu2JiEw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size check
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:29=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Inside check_inode_ref(), we need to make sure every structure,
> including the btrfs_inode_extref header, is covered by the item.
>
> But our code is incorrectly using "sizeof(iref)", where @iref is just a
> pointer.
>
> This means "sizeof(iref)" will always be "sizeof(void *)", which is much
> smaller than "sizeof(struct btrfs_inode_extref)".
>
> This will allow some bad inode extrefs to sneak in, defeating
> tree-checker.
>
> [FIX]
> Fix the typo by calling "sizeof(*iref)", which is the same as
> "sizeof(struct btrfs_inode_extref)", and will be the correct behavior we
> want.
>
> Fixes: 71bf92a9b877 ("btrfs: tree-checker: Add check for INODE_REF")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-checker.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 0b3d9d11f098..c2aac08055fb 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1756,10 +1756,10 @@ static int check_inode_ref(struct extent_buffer *=
leaf,
>         while (ptr < end) {
>                 u16 namelen;
>
> -               if (unlikely(ptr + sizeof(iref) > end)) {
> +               if (unlikely(ptr + sizeof(*iref) > end)) {
>                         inode_ref_err(leaf, slot,
>                         "inode ref overflow, ptr %lu end %lu inode_ref_si=
ze %zu",
> -                               ptr, end, sizeof(iref));
> +                               ptr, end, sizeof(*iref));
>                         return -EUCLEAN;
>                 }
>
> --
> 2.50.1
>
>

