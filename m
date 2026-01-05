Return-Path: <linux-btrfs+bounces-20103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7141CF46BF
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B56A3065269
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DD277007;
	Mon,  5 Jan 2026 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apTd9Kbz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0F285C89
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626959; cv=none; b=ud7Jxy3Umu87DYQfbyhm4kG3oiVVko27aDVYDK4Sn2BNFhKrFcItCmeysAZPL02uFaLUjCoeoRQ9MfzNl0472dGZBHUeMR8wzNER1EMkig8/86Bv3FOd2m+KgNj9JTbCPqBzME8Sy3rwNvgKaQapenHLwnwrYluxlS7pe2z2TKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626959; c=relaxed/simple;
	bh=0E7T6/67PFQ+tfddmhuFHzPaKq3AQ35j8zM3frRMNn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9IzW8c+aOfS7iTEqob8CHdodoFz288+bK/w8iQvd/sQCe+fA0Ev0R5FWl2MntJBNTBVyFxowtmkF9bROPUEb86iwC5rUsLvTjUWAzTnueRSwXA6flk7XTlveZkKB3TGuUUb2Ew5EgFm3TdRSlZPsagvPY1Tcouxi+mPmqZt12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apTd9Kbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7DC19424
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767626958;
	bh=0E7T6/67PFQ+tfddmhuFHzPaKq3AQ35j8zM3frRMNn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=apTd9KbzJYEP2Fvhfd4ywl8DnS5kEoYxgfd1KsvO0J1NO04u1SuRpHeLkp7yZ5lIZ
	 +Zao8xk47qsCFsEfDl1AssLy2NHuLMmYwKdMpjF6SCWggyy0UkI32qb3elQqFgLko0
	 MGC9kdemZ6XJR6wgUE326gZ1M0lOWPAKSuMonLcuSD+ye3k1NldLWLhrdN0opIoJKi
	 QSQCbxbHOd2qDDlC7MH00cXZPWqHcUAG26ZpSzdaG4tBzZUir+9SlFrYOMgOOJugsY
	 YebeDD1PvlIO6a6BlBNofcUbIfIB8/vVOrwEt2sbO6l2MIQHwgVgRZA6NqIFUS2U+L
	 UwbeCB3HgrJuA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b83b72508f3so11553366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 07:29:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyLjfWRAGLFL1IqJP/P4HLnlXwrRv0hk3D+eOE6tqi5n2uFuyBH
	oIlW57aT/ZG+19wKTHjZ83p6EsMI0zP3rJUd1MVoVpQFTFsIghfcu+8M1vauBthZ9U93UkDmG8b
	rzmTWeLerOWVaNZ2nGwjbrJ4XTEvxOiM=
X-Google-Smtp-Source: AGHT+IFCE0ou/6xJ0fiBDVUjc0q++Pys1KoIj436P2KGM+rHJVS1udzT80JMDuyxI/F6YmZrJtHZ3XKlaMh3vD6rHSY=
X-Received: by 2002:a17:907:7288:b0:b84:2598:472e with SMTP id
 a640c23a62f3a-b8426aa019bmr13970766b.23.1767626957214; Mon, 05 Jan 2026
 07:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f2aef6ca0a6ec4d339a7a0ad3b197b2628c99100.1767342454.git.wqu@suse.com>
In-Reply-To: <f2aef6ca0a6ec4d339a7a0ad3b197b2628c99100.1767342454.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 15:28:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H67iy4xCDRQN+LDCvcn3xwj9_R6NXbV6c6Kr-anpDSOhg@mail.gmail.com>
X-Gm-Features: AQt7F2qx9ye_b3wRJHRa6XRRb8T-vd7rKdX-l7QXsPGfIPL_pVaUoV5MY4w1CZ0
Message-ID: <CAL3q7H67iy4xCDRQN+LDCvcn3xwj9_R6NXbV6c6Kr-anpDSOhg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reject single block sized compression early
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 8:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> Currently for an inode that needs compression, even if there is a delallo=
c
> range that is single fs block sized and can not be inlined, we will
> still go through the compression path.
>
> Then inside compress_file_range(), we have one extra check to reject
> single block sized range, and fall back to regular uncompressed write.
>
> This rejection is in fact a little too late, we have already allocated
> memory to async_chunk, delayed the submission, just to fallback to the
> same uncompressed write.
>
> Change the behavior to reject such cases earlier at
> inode_need_compress(), so for such single block sized range we won't
> even bother trying to go through compress path.

So since we are adding the condition to inode_need_compress() and
compress_file_range() calls that helper, then we could remove the
duplicated condition in compress_file_range().
With this patch we end up checking it twice when we can do it only in
inode_need_compress().

Otherwise it looks fine.

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 370dfb13d6f3..a45734d62b47 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_i=
node *inode, u64 start,
>                 return 0;
>         }
>
> +       /*
> +        * If the delalloc range is only one fs block and can not be inli=
ned,
> +        * do not even bother try compression, as there will be no space =
saving
> +        * and will always fallback to regular write later.
> +        */
> +       if (start !=3D 0 && end + 1 - start <=3D fs_info->sectorsize)
> +               return 0;
>         /* Defrag ioctl takes precedence over mount options and propertie=
s. */
>         if (inode->defrag_compress =3D=3D BTRFS_DEFRAG_DONT_COMPRESS)
>                 return 0;
> --
> 2.52.0
>
>

