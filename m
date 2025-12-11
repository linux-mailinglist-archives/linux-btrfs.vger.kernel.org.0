Return-Path: <linux-btrfs+bounces-19654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B631BCB5A07
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21B4300F8AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2E3081B8;
	Thu, 11 Dec 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI6od+4f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195929C351
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765452066; cv=none; b=XyhvNaq7+/7I08yULDZXrhKJPzOShfs1oQV2JyxAoIHvr4BjaT7NjMZQqQSf5D5bOKiiF2Kkij6f7f7gpzqWHKokIRakZgtrbXr4y4y2XHwAdZLq8MsmI88OJxkIAc7RT6hU9NiawKp0s+VKeDoPW/3EI1gxVmlXwvIzK3d9V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765452066; c=relaxed/simple;
	bh=C+6+mKeGbWCdjgDP4U216qeEfeWcb5QHwnI76EQVctU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxvbfCPTEtAablF2rQjCRqeJRs6nGJnutUw/ZEKboSqQHu22jZ1Q+uXxQEoq21H/Xj7zD/Lp/to1YrPyb0MitKKCv0qQz59K2PqF3V4QD8ZajVA3vF/iEdtaFrw1lK6CFyGCbChfjpRCmKVWBEgKnx+QJsDuxyU9sOkiI8bU8I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI6od+4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C2AC113D0
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765452064;
	bh=C+6+mKeGbWCdjgDP4U216qeEfeWcb5QHwnI76EQVctU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bI6od+4fZLRIVdKyMOEdR/KN6FMJYb3bVxjatB+BB+o7FL93YYAaLiFGOKWw8Hgon
	 7dyKOpMySyC2DNnkkbxgbd3T4O8+2OUAq8/z1w7fBu3FV9yt3KJshIWuLRyHCB81Q+
	 F9A8Zo/9d9OqXarBiBikXHbWsP8jBUbTJU12pahM7tlyByqCcqrXvcUhiGMjb6B3Cf
	 udsdvvQPUc5a0IKCj6HueU001ue+PZMBYHSpoMQfMgMUYH2uoLIj+eHEPYwv4ZzFed
	 fcJ1UbRyFQt3ttXWpoVEDX83Cb05h6qKpFgRu1GjITY3eqopnNjG7FA+E5Z33wWfUg
	 h5gB1gt5iftmA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79d0a0537bso108275166b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 03:21:04 -0800 (PST)
X-Gm-Message-State: AOJu0YyK2LcEZ5o4qnWr0XbZOO0DsHhWZEGJOAynTeZElaEQfqzqeaW1
	JdFrcfX8ofT4DhHoC+6gi6jI0rd2FvbEZfH4dwezZqe5sum7owMQk+1E3D1mdOafBDd3XSDtiqI
	3waDfPKGeuLeIa2k1rgRpIO5kS8DQTbk=
X-Google-Smtp-Source: AGHT+IG1+eUZWEE+yejeo9HK36T4kyV8tGQ+uFm7/LzldcoDofMfBn4h5TgHv9XB9IL5sHcU+GPilu1GPPXKNSW24iU=
X-Received: by 2002:a17:907:3da8:b0:b79:f753:68fb with SMTP id
 a640c23a62f3a-b7ce823b1f0mr574530966b.4.1765452062725; Thu, 11 Dec 2025
 03:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211082926.36989-1-johannes.thumshirn@wdc.com> <20251211082926.36989-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251211082926.36989-2-johannes.thumshirn@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 11 Dec 2025 11:20:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7yki0Fw+1CLVzqWMo4UdNxnRvRRz9NPaGNUkFO79uZ6w@mail.gmail.com>
X-Gm-Features: AQt7F2rc42RW2nz_8QuEdZNMU2Xb6GqifXkJIxqb_ZuOhopy-uRuEiiDlC_gzcY
Message-ID: <CAL3q7H7yki0Fw+1CLVzqWMo4UdNxnRvRRz9NPaGNUkFO79uZ6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: Rename space_info_flag_to_str() to btrfs_bg_type_to_str()
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 8:29=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Rename space_info_flag_to_str() to btrfs_bg_type_to_str() and move to
> block-group.h.
>
> This way in can be re-used in other places.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.h | 16 ++++++++++++++++
>  fs/btrfs/space-info.c  | 18 +-----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 5f933455118c..5185af49d6bc 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -396,4 +396,20 @@ int btrfs_use_block_group_size_class(struct btrfs_bl=
ock_group *bg,
>                                      bool force_wrong_size_class);
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_gr=
oup *bg);
>
> +static inline const char *btrfs_bg_type_to_str(u64 type)
> +{
> +       switch (type) {

I think this is a bit confusing and error prone.

First, the existing caller passes the flags of a space_info and not a
block group.
Second, the new caller in the second patch has to bitwise the block
group's flags with BTRFS_BLOCK_GROUP_TYPE_MASK.
Third, the name type is confusing, since what we actually pass are
flags from either a space_info or a block_group (with that bitwise and
need mentioned before for block group flags).

This makes it easy for future callers to get it wrong (forgetting to
bitwise and with BTRFS_BLOCK_GROUP_TYPE_MASK) and get the "UNKNOWN"
string.

I would make the following changes:

1) Instead of passing a u64 type argument, pass a const struct btrfs_fs_inf=
o *
2) Rename the function to btrfs_space_info_type_str() and move it to
space_info.h
3) The existing caller just passes the space_info to it
4) The new caller, in the second patch, just passes bg->space_info
(every block group has a pointer to the space_info it belongs to).

This makes it less error prone.

Thanks.


> +       case BTRFS_BLOCK_GROUP_SYSTEM:
> +               return "SYSTEM";
> +       case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
> +               return "DATA+METADATA";
> +       case BTRFS_BLOCK_GROUP_DATA:
> +               return "DATA";
> +       case BTRFS_BLOCK_GROUP_METADATA:
> +               return "METADATA";
> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
>  #endif /* BTRFS_BLOCK_GROUP_H */
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..427756c5138b 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -602,22 +602,6 @@ do {                                                =
                       \
>         spin_unlock(&__rsv->lock);                                      \
>  } while (0)
>
> -static const char *space_info_flag_to_str(const struct btrfs_space_info =
*space_info)
> -{
> -       switch (space_info->flags) {
> -       case BTRFS_BLOCK_GROUP_SYSTEM:
> -               return "SYSTEM";
> -       case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
> -               return "DATA+METADATA";
> -       case BTRFS_BLOCK_GROUP_DATA:
> -               return "DATA";
> -       case BTRFS_BLOCK_GROUP_METADATA:
> -               return "METADATA";
> -       default:
> -               return "UNKNOWN";
> -       }
> -}
> -
>  static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
>  {
>         DUMP_BLOCK_RSV(fs_info, global_block_rsv);
> @@ -630,7 +614,7 @@ static void dump_global_block_rsv(struct btrfs_fs_inf=
o *fs_info)
>  static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
>  {
>         const struct btrfs_fs_info *fs_info =3D info->fs_info;
> -       const char *flag_str =3D space_info_flag_to_str(info);
> +       const char *flag_str =3D btrfs_bg_type_to_str(info->flags);
>         lockdep_assert_held(&info->lock);
>
>         /* The free space could be negative in case of overcommit */
> --
> 2.52.0
>
>

