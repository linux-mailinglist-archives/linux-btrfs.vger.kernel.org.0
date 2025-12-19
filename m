Return-Path: <linux-btrfs+bounces-19902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D461DCD15E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5119C309E312
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 18:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88F34B1A8;
	Fri, 19 Dec 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzLTJn6r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310034AB04
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168699; cv=none; b=qEap2Ts1NWv3KxRQVDZnlkKh2p9dYJmOpkw7I2p3UU/QuFDnuEWdSWaR0HUO4alsiI+vl3RiO81Pldrt7S2+9n1y01eB7U6ZLcOE5EzjwE7Md4ndEWrmYC/cZ0FVtasuF+SSyprync51eNWXnPEW2Gd4A4vz55LawIe3Xg6D99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168699; c=relaxed/simple;
	bh=JIXBn/QWtULqBKDFkYEvM9j5XiqcKHmPRZh4UqQymYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAMfl5BH0MHbIRmVtn5kBscP2HwbTGri+SDPwWK7PTWjzFxFVR8sRElyWG07YsWgKgb3FtyFnD2fhMFtzDahNeC60zH9N8B8zNLmPIoHyBu90NY7bvTOiPv3us6Hp9cRW+GSB+P1kWVheFYBS/drmfgLfWultn5Ap4mJK0GC6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzLTJn6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB173C16AAE
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766168698;
	bh=JIXBn/QWtULqBKDFkYEvM9j5XiqcKHmPRZh4UqQymYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzLTJn6rpAsEHzYIPfc4PW2apA8a9YJf4tOTA52uNPmFzc4/LE04qotD6VtAQznn1
	 vfdA3NO6Z9/SA/n8oR2RREue7mtO/8QJxHb0RqoSAtYn2AqmPfpmwjLOxQzjOd2OWl
	 0Fz3QKc1dlhOIPyFDafiMwOqIoOcjJzBhu4VbNw6fWG9zJ9m0VVj/2Uqe7fucwP1H3
	 vGGX/+QIBQFYkRLT9ScCiMzJFqreUO15HTLKr5f2jONE5XeNC99OHvXT48tW0sMlDO
	 9RLICkqKkjgmgj2jCsaiuDisPQM9kF51ubCJWSDA+eft9Kr//G5kCKbXK6+h6x74hs
	 +lXNj/ccb5IAw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735487129fso368688666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 10:24:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNDaecvzMMMvDc45XIkcBKhTlCdeU6kvv+JPkIEKR98fX0jOyi7YpG80Md1CVrvB80JryXTrysD1Vp6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q02GgUcI2CtJAOO7a7/8SDgmDY1H/5ivvg88XnFU4mL+E+fE
	Ek5JzJyby9+za3ZHNk5m6dPsSO0pUi1ji8KJ8q9IVfUKRcx2ZefR+pgt0YWf5XUUaTmHCNGqC2y
	RfE/19InugT5/x3thmLIYddOYNDTDiX0=
X-Google-Smtp-Source: AGHT+IGYSSHUV72Tq1rLiSjxXZ/QSx8umlzfL7QVNQWrugvKY4exMY6ULjxPFfGcYlcffmLwcwQPD7irNaPowvWHfZU=
X-Received: by 2002:a17:907:97c7:b0:b76:8164:88b5 with SMTP id
 a640c23a62f3a-b803719d432mr420258266b.46.1766168697382; Fri, 19 Dec 2025
 10:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219171434.46411-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20251219171434.46411-1-suchitkarunakaran@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 19 Dec 2025 18:24:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5948bcB+keLZnHOJiMBas6k_3cKBdvmReyzgWbBbZwng@mail.gmail.com>
X-Gm-Features: AQt7F2o0KpU0EbM7c4udyAx2cqqhrq4XEj8mGwFANsR1pcFaRdZ0E3aiYqzDrJo
Message-ID: <CAL3q7H5948bcB+keLZnHOJiMBas6k_3cKBdvmReyzgWbBbZwng@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference in do_abort_log_replay
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:18=E2=80=AFPM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Coverity reported a NULL pointer dereference issue (CID 1666756) in
> do_abort_log_replay(). When btrfs_alloc_path() fails in
> replay_one_buffer(), wc->subvol_path is NULL, but btrfs_abort_log_replay(=
)
> calls do_abort_log_replay() which unconditionally dereferences
> wc->subvol_path when attempting to print debug information. Fix this by
> adding a NULL check before dereferencing wc->subvol_path in
> do_abort_log_replay().
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks, I'll add it to the for-next github branch with a proper Fixes tag.

> ---
>  fs/btrfs/tree-log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 5831754bb01c..2d9d38b82daa 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -190,7 +190,7 @@ static void do_abort_log_replay(struct walk_control *=
wc, const char *function,
>
>         btrfs_abort_transaction(wc->trans, error);
>
> -       if (wc->subvol_path->nodes[0]) {
> +       if (wc->subvol_path && wc->subvol_path->nodes[0]) {
>                 btrfs_crit(fs_info,
>                            "subvolume (root %llu) leaf currently being pr=
ocessed:",
>                            btrfs_root_id(wc->root));
> --
> 2.52.0
>
>

