Return-Path: <linux-btrfs+bounces-12799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF99FA7C1A5
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 18:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02213B80C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E320D4E4;
	Fri,  4 Apr 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzxbeShO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466027702
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784771; cv=none; b=g0++fFp9805EqwOuOcAAPEYBpU7z4UoPPR3pVPKdU1gyCsFDX+XW9nn9xJ9JOkrXQPu/wsxyqVajcXFSdKyLufoYFrVlXXt++XyWUdTw2Le967Ncwbeu6W67rbVlpLM3F1/FcMAxbct/jQc7UhX8asajPyoxAVB71ud+1nlbY1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784771; c=relaxed/simple;
	bh=H9uEksCqG3nBenhtINbX3q8pPbUTFKn89BJaJJRhNfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAifP8y5tjNlYPmX0hkBiIK+uxQzmvKXzjAKgdSr/nUYC69KwTFwDRO+c6FmO1KLtoQLi3JhVDWslBUW9AnaHG/So6kTqVToTDuanHYHPVlp3d6eIBdizUgZLEuxDx9WSvaYqVWeC/io5LN1Qoke1V8QOTHk1mcubAuf2mxnhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzxbeShO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E76C4CEE9
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743784770;
	bh=H9uEksCqG3nBenhtINbX3q8pPbUTFKn89BJaJJRhNfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MzxbeShO0bttdFsNl/WFkm6QXV9bBH+CMtSWuXg9OyVmAjQO/6Hhdmnb1eG16/KFk
	 /7VCLpohTZ2Wq0k3IYMt0gRNKjEwHnILjg+Pcw8KWvvSMfd5jZb27lutsnfIyvn67R
	 yk+qEeiHW4l17OdTJWNx7kQ0QaBifFqb83s1oTPyNDSHWwlY21Bq6EzT7X8R1/mvKI
	 mvVCpWqkWIcUedmWeeyofhqV4M2+NIgvPCkIhNOzsdjWI7iWZqjjj32/CKN0tU7IT3
	 8H7Iu6xn710B/6ZiRJQKK/DvngWUtJlEqzLdVFSZ+xDvgvxcuRsgbSjcxu9FD+gC+W
	 jDf5/9wfvaQiA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso354997566b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 09:39:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YyMWDvlXwixtMcX9766tAH4kQEuMbSg+Era7SgFY3MV1MZyvWta
	mzjwkdLZKnZ+hbiK63dzZETzjzeYVV67JaE51K55TMcaYlUKZnUxuCmK7XaJeOfjFk7cJQ1+3wS
	zjWuvIqBDZ1WL7JMu5u0FujhJd+o=
X-Google-Smtp-Source: AGHT+IGiD/QC8mW4LZZSoEsLnhVKEK5epM9xWTKHf+RB58IGnURVqVfCjzozfwU4kp/Cuje6Ou3f97y+7T74htnnSH8=
X-Received: by 2002:a17:907:3f9d:b0:ac7:18c9:2975 with SMTP id
 a640c23a62f3a-ac7e7771f7bmr21146766b.48.1743784769435; Fri, 04 Apr 2025
 09:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743731232.git.wqu@suse.com> <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
In-Reply-To: <577429c985d01407c27141db4015c50d8ba7c746.1743731232.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 4 Apr 2025 16:38:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4AZZtCe6FXwAwaoKL7JNtnoLfu3BimKQ1KRZUNuezkwQ@mail.gmail.com>
X-Gm-Features: ATxdqUHhc82fPsInkQpOrUaqvsvjjemXY1q87XJAgqbrxlAtntWZFYwpKGELSoY
Message-ID: <CAL3q7H4AZZtCe6FXwAwaoKL7JNtnoLfu3BimKQ1KRZUNuezkwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: get rid of filemap_get_folios_contig() calls
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> With large folios, filemap_get_folios_contig() can return duplicated
> folios, for example:
>
>         704K                     768K                             1M
>         |<-- 64K sized folio --->|<------- 256K sized folio ----->|
>                               |          |
>                               764K       800K
>
> If we call lock_delalloc_folios() with range [762K, 800K) on above
> layout with locked folio at 704K, we will hit the following sequence:
>
> 1. filemap_get_folios_contig() returned 1 for range [764K, 768K)
>    As this is a folio boundary.
>
>    The returned folio will be folio at 704K.
>
>    Since the folio is already locked, we will not lock the folio.
>
> 2. filemap_get_folios_contig() returned 8 for range [768K, 800K)
>    All the entries are the same folio at 768K.
>
> 3. We lock folio 768K for the slot 0 of the fbatch
>
> 4. We lock folio 768K for the slot 1 of the fbatch
>    We deadlock, as we have already locked the same folio at step 3.
>
> The filemap_get_folios_contig() behavior is definitely not ideal, but on
> the other hand, we do not really need the filemap_get_folios_contig()
> call either.
>
> The current filemap_get_folios() is already good enough, and we require
> no strong contiguous requirement either, we only need the returned folios
> contiguous at file map level (aka, their folio file offsets are contiguou=
s).

This paragraph is confusing.
This says filemap_get_folios() provides contiguous results in the
sense that the file offset of each folio is greater than the previous
ones (the folios in the batch are ordered by file offsets).
But then what is the kind of contiguous results that
filemap_get_folios_contig() provides? How different is it? Is it that
the batch doesn't get "holes" - i.e. a folio's start always matches
the end of the previous one +1?

>
> So get rid of the cursed filemap_get_folios_contig() and use regular
> filemap_get_folios() instead, this will fix the above deadlock for large
> folios.

I think it's worth adding in this changelog that it is known that
filemap_get_folios_contig() has a bug and there's a pending fix for
it, adding links to the thread you started and the respective fix:

https://lore.kernel.org/linux-btrfs/b714e4de-2583-4035-b829-72cfb5eb6fc6@gm=
x.com/
https://lore.kernel.org/linux-btrfs/Z-8s1-kiIDkzgRbc@fedora/

Anyway, it seems good, so with those small changes:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c             | 6 ++----
>  fs/btrfs/tests/extent-io-tests.c | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f0d51f6ed951..986bda2eff1c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -207,8 +207,7 @@ static void __process_folios_contig(struct address_sp=
ace *mapping,
>         while (index <=3D end_index) {
>                 int found_folios;
>
> -               found_folios =3D filemap_get_folios_contig(mapping, &inde=
x,
> -                               end_index, &fbatch);
> +               found_folios =3D filemap_get_folios(mapping, &index, end_=
index, &fbatch);
>                 for (i =3D 0; i < found_folios; i++) {
>                         struct folio *folio =3D fbatch.folios[i];
>
> @@ -245,8 +244,7 @@ static noinline int lock_delalloc_folios(struct inode=
 *inode,
>         while (index <=3D end_index) {
>                 unsigned int found_folios, i;
>
> -               found_folios =3D filemap_get_folios_contig(mapping, &inde=
x,
> -                               end_index, &fbatch);
> +               found_folios =3D filemap_get_folios(mapping, &index, end_=
index, &fbatch);
>                 if (found_folios =3D=3D 0)
>                         goto out;
>
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-=
tests.c
> index 74aca7180a5a..e762eca8a99f 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -32,8 +32,7 @@ static noinline int process_page_range(struct inode *in=
ode, u64 start, u64 end,
>         folio_batch_init(&fbatch);
>
>         while (index <=3D end_index) {
> -               ret =3D filemap_get_folios_contig(inode->i_mapping, &inde=
x,
> -                               end_index, &fbatch);
> +               ret =3D filemap_get_folios(inode->i_mapping, &index, end_=
index, &fbatch);
>                 for (i =3D 0; i < ret; i++) {
>                         struct folio *folio =3D fbatch.folios[i];
>
> --
> 2.49.0
>
>

