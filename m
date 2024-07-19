Return-Path: <linux-btrfs+bounces-6594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E66937704
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F328203D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD584D2C;
	Fri, 19 Jul 2024 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBp0JjAc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B09C5F876
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387514; cv=none; b=HDK094smt45x3zxQ/z0s5280XH4ZH/ZiwvS7S8UojPh/sqV+7KJ25lQZjSwu1hXNXugw6c4VkzmpqMYU0CET0ORtzBfRDPSUUPra13SBwHmwn8YSqxFXkeOM5qvBjYVdacF9swXxsY+w6pUP8A9tHFuXypu3M4KHO3m1V6lu4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387514; c=relaxed/simple;
	bh=CuVmN8Uy/uhXRwFw/OD3yspkgdzlgpcLVa9gY8W15YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCVkq/3cJmjsvUIu9D8Bw52Ls3GmNRjFQjjXNsGFaS8vkZ0bG12aS5Q/7eE2Ehzq4CccAEOChxillu/eCbgu1OTBtz8fJy6WSk44ggn/jr0yBYn6ubMBqfQ1OKc8FmXzq5YDQenAm7KroAGTgoAfTKAVfz+oZ4Dfmk9ybECg0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBp0JjAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6C5C4AF09
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721387514;
	bh=CuVmN8Uy/uhXRwFw/OD3yspkgdzlgpcLVa9gY8W15YI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mBp0JjAc5D4eIYFrrNqp4mwNlMRiK1aeAOi82ekrQDR8S03I7jcMHsLfPzFQBpK20
	 m3CLv0qaOiDv3GOEH6xZBdjmLvaCkEbFSNB+MIvO4dQ0cLNSASxeLRFUL3rjdLkqmZ
	 bwVJ4i3A+sBj3yXfKrWZUl54jXnvc+PhYcjXp8uQm5gIN1CevyOUMaQcwxrwbGNbRo
	 rpCN7CUHBcTAeuKNbfur9PxQ+I94ZWqX3bl5B8DZ8TnGeKXnkrVrSFjqh1mb08d6tZ
	 FQehRTMoDgpIpDnyUSA1gJmoktc/3J9VFODbGvnkOO0LD98QPFD67FmZK94vCOIyI+
	 v+ymZS9C0GpTQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so24843361fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 04:11:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwV/UoADX/8sEeO4vmE0Z8CsyLPMeipYX1bgaF3j+E/qZQ4GaN7
	/Usq6+eCViI2FFidqYDqVySNfkQiUHFJCn6ycmqgmQvn9/bksR4q+lzQUW+TFKGf7ONw8jwBk7B
	3id2YAdbrGd4e7Sqp+w6IxqeW5ms=
X-Google-Smtp-Source: AGHT+IH4oHu8ZUBQREx7I6jv1N2i72pMyEJah96senLprJQ0aOumi/jE6Ayq1FKCTp9gwmtU0+G/luTid7IuhgLUxwk=
X-Received: by 2002:ac2:4c4f:0:b0:52c:db22:efbf with SMTP id
 2adb3069b0e04-52ee53de329mr4243200e87.16.1721387512418; Fri, 19 Jul 2024
 04:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719110447.3211103-1-maharmstone@fb.com>
In-Reply-To: <20240719110447.3211103-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 19 Jul 2024 12:11:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4+hRchPgxFjyJg-y5F2evzNHn-xVgGS=16wRG1i_135Q@mail.gmail.com>
Message-ID: <CAL3q7H4+hRchPgxFjyJg-y5F2evzNHn-xVgGS=16wRG1i_135Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: set transid in btrfs_insert_dir_item
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 12:05=E2=80=AFPM Mark Harmstone <maharmstone@fb.com=
> wrote:
>
> btrfs_insert_dir_item wasn't setting the transid field in
> btrfs_dir_item. This field doesn't matter, so set it to 0 rather than
> writing uninitialized memory to disk.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  kernel-shared/dir-item.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
> index 4c62597b..78ad108c 100644
> --- a/kernel-shared/dir-item.c
> +++ b/kernel-shared/dir-item.c
> @@ -173,6 +173,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *=
trans, struct btrfs_root
>         btrfs_set_dir_flags(leaf, dir_item, type);
>         btrfs_set_dir_data_len(leaf, dir_item, 0);
>         btrfs_set_dir_name_len(leaf, dir_item, name_len);
> +       btrfs_set_dir_transid(leaf, dir_item, 0);
>         name_ptr =3D (unsigned long)(dir_item + 1);
>
>         write_extent_buffer(leaf, name, name_ptr, name_len);
> @@ -202,6 +203,7 @@ insert:
>         btrfs_set_dir_flags(leaf, dir_item, type);
>         btrfs_set_dir_data_len(leaf, dir_item, 0);
>         btrfs_set_dir_name_len(leaf, dir_item, name_len);
> +       btrfs_set_dir_transid(leaf, dir_item, 0);

Why set 0? 0 isn't even a valid transaction id.

The logical value here is trans->transid just like we do in the
respective kernel counterpart.

At the very least having the transaction id used to insert the item is
helpful when debugging and looking at tree dumps.

Thanks.

>         name_ptr =3D (unsigned long)(dir_item + 1);
>         write_extent_buffer(leaf, name, name_ptr, name_len);
>         btrfs_mark_buffer_dirty(leaf);
> --
> 2.44.2
>
>

