Return-Path: <linux-btrfs+bounces-19893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BCFCCF7E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B84DB308A3B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F03019BE;
	Fri, 19 Dec 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQAw3C3U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089411FF1C4
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141584; cv=none; b=g5L7vcEklzfTEAiQ6Mj+6UechrXeXrO9bdXgCzRNJ+fyxQryY+hO0RlHX+GUTtSMBXpw6U/mNzD0lqF8NN0+DQ7hoZebWk5ADydZUgMzVcwWUzY2elWOhENQygc+NOD/ZBLPmeOiq1FeTXF1LF93mACxt1IvZ3jzfPrCSsby4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141584; c=relaxed/simple;
	bh=P2htuzTiuxkZEcIkM2qukJEGvzvzHJ5BQue4QvVYFYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X16m0w1F79hEAaPIZKZRyp5ZMHReVuhCTg7nI6RvgobHLC5XK65ShjWd2qA0F/HKj/YnZV7U8J8b31BJ6EyoLc7YyQIb6cGS5kIiYZ7U5Db9bSjoX6vxUJqhb3NPYUPEauXnyE8G1Jduw4loYubzVlD2qPtQbiU0gqn6cZaA80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQAw3C3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90D1C19421
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766141583;
	bh=P2htuzTiuxkZEcIkM2qukJEGvzvzHJ5BQue4QvVYFYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FQAw3C3UtoI5HsVvMx3gtWLzYiemR1vD8576t+KAleReWL+qMBhllPcckxedR70m0
	 aXUrrJCFkn5DIi7+kSl4aRp/CPFzmaNUq5GRhAQEmfEg9XkXmmsoaBwy94hnj6YkTk
	 LH9sTjAiSyp0U50X8q7EZWwQk9r29AnimhcEUS5bCETrNDlSvQ3rnu1x2GyA1CzvVL
	 jx9lG2LcbFq5UfDkrxjAGWmYnZHhv6XeuY4t+w3/KXNiJJTTXirHgc9NfKcPOtfcJx
	 XooSkRkvqYcVt3kd4WIyn0uYmTNJxw/owDjD8gTkRvfKrTw6lenG3PXW0BQhbyRauR
	 GPT2dPat5zBcA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b736d883ac4so292743866b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 02:53:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhcqr4Ppl1Pjzfmn/8ds0EBhIoXLo1rnz602oVmbJqUYlwJJyT+NyZZNzPeuKUCfUIIE7Kh15Qu9cBgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcCtc635P8KN8/M7P50r7UzkydCKAICb4dPBEv7FExeaKThMx
	+uEeym12jCqIg6OkWYa41HlJ/RfMIlbWZrs44sNsGIHiLecYm3WHImtKxTgHdf+b/8loMn8Y3i0
	ykOBkUrfLtYfnT8d59tB2+q++xvy67LM=
X-Google-Smtp-Source: AGHT+IHBbRyP0qULADeGQny2YpM4j1RdcK7iD7xeIdYsXOKHaMfamONPHD01nixQyPOtiqpU6eBH872aI3qooKLm2yA=
X-Received: by 2002:a17:906:fd84:b0:b7a:1be3:a583 with SMTP id
 a640c23a62f3a-b80372590e8mr227053066b.64.1766141582320; Fri, 19 Dec 2025
 02:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219103158.464213-1-colin.i.king@gmail.com>
In-Reply-To: <20251219103158.464213-1-colin.i.king@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 19 Dec 2025 10:52:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4_DvxRKJs1Z-o2AMQ51XTMc1ebCd4UxtX_gOBOThX6fg@mail.gmail.com>
X-Gm-Features: AQt7F2qK9LzVve5krmy0RuX0DyzSDOyHvex_3tgkrf5_jt1ZmIAUhZiPQk1imk8
Message-ID: <CAL3q7H4_DvxRKJs1Z-o2AMQ51XTMc1ebCd4UxtX_gOBOThX6fg@mail.gmail.com>
Subject: Re: [PATCH][next] btrfs: fix spelling mistake "duing" -> "during"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:37=E2=80=AFAM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There is a spelling mistake in a btrfs error message, fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/btrfs/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 206872d757c8..41e04c808d27 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1623,7 +1623,7 @@ static int qgroup_account_snapshot(struct btrfs_tra=
ns_handle *trans,
>         ret =3D btrfs_write_and_wait_transaction(trans);
>         if (unlikely(ret))
>                 btrfs_err(fs_info,
> -"error while writing out transaction duing qgroup snapshot accounting: %=
d", ret);
> +"error while writing out transaction during qgroup snapshot accounting: =
%d", ret);

As this is in a recent patch not yet in Linus' tree, I've updated the
patch in the github for-next branch (David will later update the for
branch for linux-next).

Thanks.

>
>  out:
>         /*
> --
> 2.51.0
>
>

