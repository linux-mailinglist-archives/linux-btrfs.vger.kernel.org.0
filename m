Return-Path: <linux-btrfs+bounces-11873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10700A45CAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 12:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E523AEA31
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D824213E84;
	Wed, 26 Feb 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSpb0/nY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BC212FB0
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568100; cv=none; b=LMaGr2s3RUAgwUvRF93UEc9T98e3Bswd7GEvhGz8mRgdbl1YC4141oNzqq7ktPX3sAPu3twNAa/08D/zSUVVr/HCIB4ojHgbaLGPTR5s1XuwGVAa3Pe8AF3JcRrgTTIlPxw/M0zlCFL4ZOCr5tvdiVUD8IB3zBpFrfGU7oEZetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568100; c=relaxed/simple;
	bh=j4ngP89hgMiaCc2BJ4IxbQAgY6YwJxebhD05KEPBiDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxAcLBihySsaEMFxPTcodnHHxaaM9AnkBCHuvlQXkSQ9oWe63OQODDDLzRBbvoXrkTBooNlg3gRrZ/SOgev7umNPABeNpGjEx2xr9byB0kqf3P6Dgsorgle23z93bsqaR1+owEdiK0xVUl73nvM6Jf3jZrJR09QIugxdGUfjS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSpb0/nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DEFC4CED6
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740568100;
	bh=j4ngP89hgMiaCc2BJ4IxbQAgY6YwJxebhD05KEPBiDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YSpb0/nYldFJs//mpxl+4ZGZ1tbtearNftpBj7C92Ugmr6WPXU6yw8HNFDPoz0ErB
	 2m5OF8gjWjld7FDjWT+4GntX0Vv4xUFwF39197TBdAkRjnAfQwxhh+oEg9QmVLFrfU
	 9w8XXofhb6WB0kZDeafggencGWHmGzznkX7TpPrYG9rc/PEPI3gxIKR8GZqeXsT+Ps
	 XJt0gqTn+HSmdDgBxXnr9IZmqnIP/3JykoDBzMoE7qFX3rZav8aJu/yjOyMnivQGuq
	 GDYtOIZz4aX5lVq2Xy+nN6LwEN/4HLScxuf5hjs6nm/eRRWXhSZFq7pZdvUSGCjdej
	 63W5tFg3l+alg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso11034829a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:08:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxgsQuLIfqbysqx6B9/JpX8zIUgZBYds3oom+YOdbF0HPvyy30m
	zBE+yEg71F9cLvHAVk8URcOOSQAY5sqRedHwdOGL2JRZOpJTQ5VKAZvvFr1kvYIbzjniv8e4KoK
	hZiAi/PGZN2E31lWf8uLgB5kPUHU=
X-Google-Smtp-Source: AGHT+IExhqoJHa5EyK26vk7amCgBK2jH6s0wK98s2/kIPL/AEJA/EFeYJ0vrwGbGNG3xValpdJLJFaeH3Zl1N+UgWLM=
X-Received: by 2002:a17:907:9c05:b0:ab7:bf2f:422e with SMTP id
 a640c23a62f3a-abc09a80912mr2421515566b.27.1740568098536; Wed, 26 Feb 2025
 03:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <f8b476f39691d46b592cf264914b3837f59dcd77.1740354271.git.wqu@suse.com>
 <CAL3q7H4BCqEtwSOykWqYxjgqqiPZKqQ9K_VjAt08Vs9CAcj7yQ@mail.gmail.com>
 <e8b84e01-a56d-427e-b188-6c2539a0093b@suse.com> <40a0b543-6e43-446b-9720-1218859b1086@suse.com>
In-Reply-To: <40a0b543-6e43-446b-9720-1218859b1086@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Feb 2025 11:07:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5_hhL8GApRjVWkNOQ5WeCv5Leh0jLzyojzD99dDnipzg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq2i_nzFNRiW1U9SLeiW1sl3vj6LIYxCko-qCnkjj4y5f0U1sz8Yhj6ZUg
Message-ID: <CAL3q7H5_hhL8GApRjVWkNOQ5WeCv5Leh0jLzyojzD99dDnipzg@mail.gmail.com>
Subject: Re: [PATCH 3/7] btrfs: introduce a read path dedicated extent lock helper
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:44=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/2/26 07:42, Qu Wenruo =E5=86=99=E9=81=93:
> >
> [...]
> >>> +        *
> >>> +        * Have to wait for the OE to finish, as it may contain the
> >>> +        * to-be-inserted data checksum.
> >>> +        * Without the data checksum inserted into csum tree, read
> >>> +        * will just fail with missing csum.
> >>
> >> Well we don't need to wait if it's a NOCOW / NODATASUM write.
> >
> > That is also a valid optimization, I can enhance the check to skip
> > NODATASUM OEs.
>
> BTW, the enhancement will not be in this series.
>
> As it will introduce extra skip cases, which may further makes things
> more complex.

Sure, that's fine.
Thanks.

>
> I'll make it a dedicated patch in the future.
> Currently there are quite some patches tested based on the behavior
> without NODATASUM skip.
>
> Thanks,
> Qu
>
> >
> > Thanks a lot for reviewing the core mechanism of the patchset.
> >
> > Thanks,
> > Qu
> >
> >
>

