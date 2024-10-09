Return-Path: <linux-btrfs+bounces-8694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8D996DCA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012B31C22A4C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA641A0BC1;
	Wed,  9 Oct 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K98usjKR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86581A00F2;
	Wed,  9 Oct 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484188; cv=none; b=uWOdXCPFvkSIS0KynJKWiux3GYzFV+OkJjm/IEhORwOQx8o45bmkO5OWlUfyKC4SUssA5KtAPLj1gNMY5U8PxN+oSV/sy0e8PQz4lEv4xOjEOuJcA8F/0OrNas93ZIBpH/q0bq3Al06L/irYZW+gjcYC9+B4c12ltYutraQ+aJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484188; c=relaxed/simple;
	bh=YBFP3vWxMFuWY63dAiFs1s+GWluV8VueDrTYLjHI/YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MObIC18jB2OK5jS6BI1vw2Xxus4XZLefTnTTiUhUnfm0K9fiVwuWWqz/VXTDB4PizKYJFk6VGpotvPuLXJl5nr1Xnn0lMNOYORb9gbD0tpAIan/7Kr74PiRBX/z2CSw/yojaFCFnBJZ7bojaIr41WfvHV3VKHAGuEbSQmshbuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K98usjKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7297CC4AF0B;
	Wed,  9 Oct 2024 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728484187;
	bh=YBFP3vWxMFuWY63dAiFs1s+GWluV8VueDrTYLjHI/YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K98usjKRMgKSyWLEqJZraxqBGlCNnr/5tJkkwyKiiXXIrTxtYZLxZ7D5WcbseVlcQ
	 hguA2cTToHh9zmkYn34nZZN40B8i4szQibALsd9JqX0Biy8+CWqJONNizMT67QUH+O
	 j5Df4rRVzdrLvPZMaVzP5DuJOcaMkcnI3Xtez5NRykYLK5p8wpa2fEha5inDaC5+Ia
	 mKjKtfXdqrk5uSXDqCASg2dHPICVAMeYsa2SsmDRZuq6rABSD4nTA6miHhdc+dKia4
	 mTMYv+eF+N2ZILW671BMwN3r8Wg5J3MjL2HQusNHCHwMrlAjnjxxr+GYzq836fdrsT
	 vg70MVUo8B1iA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99415adecaso173290966b.0;
        Wed, 09 Oct 2024 07:29:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDgy947FtAhxNO27B3X/d8tO3TgMuHIIA8jxEUfwvI9WqX9gQnuz4FEpGMDgBdq272weRHMEhGaTZL/g==@vger.kernel.org, AJvYcCXmirU26riKlBBFXUC2ARJko83Jm9+CrrpBsNXnU2d5JuHoJJ697Cu9SQteO5a0GNOKkdELHfis0JSN5C1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3uyH0ycXmh2MQkrJb/G7bh2rWAX2nf88kZ9tc5pnWWx1dxV4
	neMmIOCP5oqoLSTU8lZyxKV9zF4QnW19KzANFPv3uCGwQz6IWf8VxGBZ1ghx9wKtKub25rdqnMS
	awQJ+IgA/QzcWsG3e0xmRPV7jWaQ=
X-Google-Smtp-Source: AGHT+IE5KFlZ1gY97ECRRd9vDXSKogjlDjmkigvHlxuS5/FbGQJ6mCdhSCTFteQz/IG0Hgj9Y+A/ROukj49KnHG7R+4=
X-Received: by 2002:a17:906:f5a2:b0:a86:8f9b:ef6e with SMTP id
 a640c23a62f3a-a998b1e66b6mr301867966b.13.1728484185985; Wed, 09 Oct 2024
 07:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009080833.1355894-1-jroi.martin@gmail.com>
In-Reply-To: <20241009080833.1355894-1-jroi.martin@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 9 Oct 2024 15:29:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6v06N6fn5xyFFW=DAmHgRFi9RjAOMh_Gft6vvxYopomw@mail.gmail.com>
Message-ID: <CAL3q7H6v06N6fn5xyFFW=DAmHgRFi9RjAOMh_Gft6vvxYopomw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized pointer free on add_inode_ref
To: Roi Martin <jroi.martin@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:17=E2=80=AFAM Roi Martin <jroi.martin@gmail.com> w=
rote:
>
> The "add_inode_ref" function does not initializes the "name" struct
> when it is declared.  If any of the following calls to
> "read_one_inode" returns NULL,
>
>         dir =3D read_one_inode(root, parent_objectid);
>         if (!dir) {
>                 ret =3D -ENOENT;
>                 goto out;
>         }
>
>         inode =3D read_one_inode(root, inode_objectid);
>         if (!inode) {
>                 ret =3D -EIO;
>                 goto out;
>         }
>
> then "name.name" would be freed on "out" before being initialized.
>
> out:
>         ...
>         kfree(name.name);
>
> This issue was reported by Coverity with CID 1526744.
>
> Signed-off-by: Roi Martin <jroi.martin@gmail.com>

Fixes: e43eec81c5167b65 ("btrfs: use struct qstr instead of name and
namelen pairs")

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/tree-log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index e2ed2a791f8f..35c452bab1ca 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1374,7 +1374,7 @@ static noinline int add_inode_ref(struct btrfs_tran=
s_handle *trans,
>         struct inode *inode =3D NULL;
>         unsigned long ref_ptr;
>         unsigned long ref_end;
> -       struct fscrypt_str name;
> +       struct fscrypt_str name =3D { 0 };
>         int ret;
>         int log_ref_ver =3D 0;
>         u64 parent_objectid;
>
> base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
> --
> 2.46.0
>
>

