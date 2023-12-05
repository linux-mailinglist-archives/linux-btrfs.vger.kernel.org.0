Return-Path: <linux-btrfs+bounces-643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976780581A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A516C1F2178A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97D67E85;
	Tue,  5 Dec 2023 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRCu6qgc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096D58101
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 15:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA620C433C9
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701788526;
	bh=IVzbQXFHkjJtwNsEf+2kFLhcA8HrXKfMdA2GUOIAInU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MRCu6qgcqmtd1ix8SEWlLEbfPOfkhnzPC4elQDcHU96nnUxzQex6HpFPpnF/VF/JZ
	 cKGzEqQEFLBev8l3oFWojBSlf8wAnujcZUsXVl81mA0GslteKZaDoLHlwtaJzNUmpc
	 XhfhZ1RcUZVnOg2P63kQffILV9okG1A1j51eIdo46HqKC3QNZcA/EFaRYs/RMNwl6P
	 REOMJXZo8/uKkPMe6RCHZHx7OHHYHFbhchMr2p/R0Rf9QMioJ0SCbqxXpA12rj24/4
	 dV5pCwwfvl09VZLqA6ITEi7I0TjJZIbHxAdkEud/7vhDqZgsympwsWXOp/P3rmphr3
	 qkPJjFX8YzSrw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54ca339ae7aso3618629a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Dec 2023 07:02:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwicJULUzXsdpqeAnCihUI5G+8BnpO94LqryEmDt8W0vT2PjLLL
	9P7Dg5x5JnNaNKoHus5Iy4WrH1/8xxAvPb/lgBw=
X-Google-Smtp-Source: AGHT+IFKlvod3Fh4HUnKlcMffq3e+TIyCaMKtFEnH+GxMZsoP1J5VSJuORcagJ2SCHo9o29xnVlXdCOPuQFbv8vRy1o=
X-Received: by 2002:a17:906:492:b0:9d3:f436:61e5 with SMTP id
 f18-20020a170906049200b009d3f43661e5mr3593874eja.29.1701788525317; Tue, 05
 Dec 2023 07:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701706418.git.fdmanana@suse.com> <64a0b8f04f170d4e1f0219bd975a6246e7b61b35.1701706418.git.fdmanana@suse.com>
 <20231205144351.GF2751@twin.jikos.cz>
In-Reply-To: <20231205144351.GF2751@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Dec 2023 15:01:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H62x2pxoQUWHTsaaEs-YvN8OGRE5aY6M7pGr5QjfpiBnA@mail.gmail.com>
Message-ID: <CAL3q7H62x2pxoQUWHTsaaEs-YvN8OGRE5aY6M7pGr5QjfpiBnA@mail.gmail.com>
Subject: Re: [PATCH 11/11] btrfs: use the flags of an extent map to identify
 the compression type
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:50=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Mon, Dec 04, 2023 at 04:20:33PM +0000, fdmanana@kernel.org wrote:
> > +     else if (type =3D=3D BTRFS_COMPRESS_LZO)
> > +             em->flags |=3D EXTENT_FLAG_COMPRESS_LZO;
> > +     else if (type =3D=3D BTRFS_COMPRESS_ZSTD)
> > +             em->flags |=3D EXTENT_FLAG_COMPRESS_ZSTD;
> > +}
> > +
> > +static inline enum btrfs_compression_type extent_map_compression(const=
 struct extent_map *em)
> > +{
> > +     if (em->flags & EXTENT_FLAG_COMPRESS_ZLIB)
> > +             return BTRFS_COMPRESS_ZLIB;
> > +
> > +     if (em->flags & EXTENT_FLAG_COMPRESS_LZO)
> > +             return BTRFS_COMPRESS_LZO;
> > +
> > +     if (em->flags & EXTENT_FLAG_COMPRESS_ZSTD)
> > +             return BTRFS_COMPRESS_ZSTD;
> > +
> > +     return BTRFS_COMPRESS_NONE;
> > +}
> > +
> > +/*
> > + * More efficient way to determine if extent is compressed, instead of=
 using
> > + * 'extent_map_compression() !=3D BTRFS_COMPRESS_NONE'.
> > + */
> > +static inline bool extent_map_is_compressed(const struct extent_map *e=
m)
> > +{
> > +     return (em->flags & (EXTENT_FLAG_COMPRESS_ZLIB |
> > +                          EXTENT_FLAG_COMPRESS_LZO |
> > +                          EXTENT_FLAG_COMPRESS_ZSTD)) !=3D 0;
>
> As a minor optimizations, you could add another bit flag when any of the
> zlib/lzo/std is set and test just that.

How is that an optimization? The compiler ORs those compression flags
at compile time, it would be equivalent.

>
> Otherwise, I like the changes and space savings.

