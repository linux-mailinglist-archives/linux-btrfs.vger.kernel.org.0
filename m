Return-Path: <linux-btrfs+bounces-277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C87F44F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0456FB210BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40756453;
	Wed, 22 Nov 2023 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqJDTFfM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536451035
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 11:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A02C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700652792;
	bh=MIHEdJKieq7ZIKAUuMJ/6TVc497bMkNeoI1BrSJKA68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gqJDTFfM4HgGQdiD4HxDtwzjm8E/So+tgrWKvSdWg6/f8J8uqlii59leVZkc1nZtp
	 UGD0DVUjPPT980I0Ah3MNP8gFIgWH4kWsucKoiQNYh7Ab09cWImlKq1QDyaO914I8B
	 pdgJu/t7PlXNhqw/edL1gRi9mzMrxDRtrZwYzUMu+HHpgsiJFy3dXvgTnxNF+7QDTW
	 Fx/TpDNlQeIk1T1HdzAldj49Z7sG0m82nxSFiNHCh7oQwXUCqq5Ua6Wyo4PjF8YfpU
	 iY6LBuBdt3951Z4ZnsH0oAJEvdAc7MNOtbk/FLFUA/0Tn+S5upIUHOOt8P9lROGceo
	 /FEIzHz5OefhQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso910213266b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 03:33:12 -0800 (PST)
X-Gm-Message-State: AOJu0YysDYfPsfsFRgEfY94bWsIGLiiyeZyH0DykVmscujoh4T1Az8s8
	ZhsfWTWHOMPXq2fWobEBKyu2qweVkKoD6D9aR0M=
X-Google-Smtp-Source: AGHT+IFV6zjPTDZ4ArU2aYA3AS8uE/xmmZVrA7Zmx0V8+CaDd3b0b3z8GQLTvqDFBwgERjKGSn1kFZ2V7vBo0A/7poc=
X-Received: by 2002:a17:906:717:b0:a00:9860:7fa7 with SMTP id
 y23-20020a170906071700b00a0098607fa7mr68249ejb.68.1700652791010; Wed, 22 Nov
 2023 03:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700573313.git.fdmanana@suse.com> <777320fd09dfc68a89180723bf5d7368dab06299.1700573314.git.fdmanana@suse.com>
 <20231121182314.GU11264@twin.jikos.cz>
In-Reply-To: <20231121182314.GU11264@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 Nov 2023 11:32:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5-H2czrYap6XEBJeGDVkKDHJdLt3wCyD0VHFuPjEfLgQ@mail.gmail.com>
Message-ID: <CAL3q7H5-H2czrYap6XEBJeGDVkKDHJdLt3wCyD0VHFuPjEfLgQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] btrfs: use a dedicated data structure for chunk maps
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 6:30=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Nov 21, 2023 at 01:38:38PM +0000, fdmanana@kernel.org wrote:
> >  extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYP=
ES];
> >
> > -struct map_lookup {
> > +struct btrfs_chunk_map {
> > +     struct rb_node rb_node;
> > +     refcount_t refs;
> > +     u64 start;
> > +     u64 chunk_len;
> > +     u64 stripe_size;
> >       u64 type;
> >       int io_align;
> >       int io_width;
> >       int num_stripes;
> >       int sub_stripes;
> > -     int verified_stripes; /* For mount time dev extent verification *=
/
> > +     /* For mount time dev extent verification. */
> > +     int verified_stripes;
> >       struct btrfs_io_stripe stripes[];
> >  };
>
> This results in two 4 byte holes:
>
> struct btrfs_chunk_map {
>         struct rb_node             rb_node __attribute__((__aligned__(8))=
); /*     0    24 */
>         refcount_t                 refs;                 /*    24     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         u64                        start;                /*    32     8 *=
/
>         u64                        chunk_len;            /*    40     8 *=
/
>         u64                        stripe_size;          /*    48     8 *=
/
>         u64                        type;                 /*    56     8 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         int                        io_align;             /*    64     4 *=
/
>         int                        io_width;             /*    68     4 *=
/
>         int                        num_stripes;          /*    72     4 *=
/
>         int                        sub_stripes;          /*    76     4 *=
/
>         int                        verified_stripes;     /*    80     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct btrfs_io_stripe     stripes[];            /*    88     0 *=
/
>
>         /* size: 88, cachelines: 2, members: 12 */
>         /* sum members: 80, holes: 2, sum holes: 8 */
>         /* forced alignments: 1 */
>         /* last cacheline: 24 bytes */
> } __attribute__((__aligned__(8)));
>
> I could move verify_stripes after refs or move refs to start of the
> second cacheline between type and io_align. I suspect some cache
> bouncing could happen with refcount updates and tree traversal but it's
> a speculation and I don't think the effects would be measurable.

I would prefer to have verified_stripes in the first cache line, right
below refs for example, so that
everything needed for map lookups and insertions is in the same cache line.

Do you want to squash such change in this patch? Or should I send it separa=
tely?

Thanks.

