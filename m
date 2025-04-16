Return-Path: <linux-btrfs+bounces-13072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F211BA90478
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE707A5AAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CBC19AD89;
	Wed, 16 Apr 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIa4u2EX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1B158538;
	Wed, 16 Apr 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810692; cv=none; b=mu5TzuRq7egxT7nUTXtmqpfjHe4g/0CxdNFRq4uDGBbeANwJvzMSNFO6YWejU73NJ3hXeKM0WKpH9qxcTg9lRnGeliXoKFc279qkV0i7sPAPntgHWKhDoR1JHTJXfA9SOrt0Xwl3GtA4akhRt/+bqsAVdfAA6mA9k0L1bSM5ZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810692; c=relaxed/simple;
	bh=xHlwENv1WHd4Cvsnw8N2ZeDhmnmW0Die7bvlYPzo1qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut0CeBe6TFyO3VcViPsKc3gXGIF7V7/l/T9GJi2P65aa6TdGQO3czq0IHspL9uGbi+XgvB/AF0mtA6E7r7qQ9cJGJjImYR78MOuz6u+avBe++5LzYbY6QZU4spb/PkoQ8ku/HhHEbneSEGtQeW2qP9OtV3kyXcdkkMauWMnc5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIa4u2EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DA9C4CEEA;
	Wed, 16 Apr 2025 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744810691;
	bh=xHlwENv1WHd4Cvsnw8N2ZeDhmnmW0Die7bvlYPzo1qY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qIa4u2EXgcrPdfL5GHtQ5D/cGiGbQzEGpwRLFlm29h1qTDyLEgmMyhKqFTj11MFcw
	 xIEe/DFOe4s0fviRo0Zd3NEZcLFQatqNaD8d2WjIEXDm8P2lzxhiU9KMMUtnGSq6LZ
	 q35X1YT0QTp7/4EPMp6lr9KKAB6kBXDqF8PMZn9bbrYVFqONop8oLCdGPiSswr3N15
	 ExycomJxalKySAjy2ljJ/KXBHn7TeMXNE5bB0SxtlSVJrwf4E7rIk+BU21FwfNqSK2
	 CoNsuB3Lqcg75qoc4GuYdG6ZUouRAJ67wIQ8jt4wbN4+ihFxaYBIr8pJsAX1KM8e0J
	 5+ifwbasy3d4A==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac339f53df9so48730266b.1;
        Wed, 16 Apr 2025 06:38:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9wmcwooJKWy/afT+mGvPBCAJtsdd6MBKAD3ejZh0F5nKnc1Z8fprW5Yjo36QVc099VXfew/hKx0syZ065@vger.kernel.org, AJvYcCXYAMQWs0fTfKIlkVzlxWE+6uLZasS0bj7ZvtXl3kR7dtifcWc4RMYaTvk8jyTjeTFGKEnTTGP9v/TNjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWC913eMBLJztSbkw0AxyyP6odn4ZWYYUJRy4Gxnc0v0hapaI5
	hjjfGjBFXmXNap6YwEtOzWxCsTZ8d0F7/Mob1eAHA0k3jojmCK/s3YiV10JPnXeIW+cNT2Nx+F+
	w5PcMksRnG2+e+baKHQQxzLxZxpQ=
X-Google-Smtp-Source: AGHT+IHw2vmicFPa0dbQb1PUlildWGu5Q1aMAVDVNU78RfJgUAlRa8VsVKef3OoXEL3rDwCAt1cwtn6xoe90qq7AnJE=
X-Received: by 2002:a17:907:1c84:b0:ac7:e366:1eab with SMTP id
 a640c23a62f3a-acb42c4f60dmr151505866b.48.1744810690044; Wed, 16 Apr 2025
 06:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415033854.848776-1-frank.li@vivo.com> <3353953.aeNJFYEL58@saltykitkat>
 <20250415155637.GG16750@suse.cz> <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB5269DCFA737F179B0F552B01E8BD2@SEZPR06MB5269.apcprd06.prod.outlook.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 16 Apr 2025 14:37:33 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
X-Gm-Features: ATxdqUGVYnTd0DCa5H_2IkT-BknHibe0igsTaNI4ImOV5pSQxcDGOqYeCv20Qm8
Message-ID: <CAL3q7H7z_iVmeuRNXQvvZseB9ntSDz9_tUTXB0KvrcsSQVJb9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: get rid of path allocation in btrfs_del_inode_extref()
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Sun YangKai <sunk67188@gmail.com>, "clm@fb.com" <clm@fb.com>, 
	"dsterba@suse.com" <dsterba@suse.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "neelx@suse.com" <neelx@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:24=E2=80=AFPM =E6=9D=8E=E6=89=AC=E9=9F=AC <frank.=
li@vivo.com> wrote:
>
>
>
> > Also a good point, the path should be in a pristine state, as if it wer=
e just allocated. Releasing paths in other functions may want to keep the b=
its but in this case we're crossing a function boundary and the same assump=
tions may not be the same.
>
> > Release resets the ->nodes, so what's left is from ->slots until the th=
e end of the structure. And a helper for that would be desirable rather tha=
n opencoding that.
>
> IIUC, use btrfs_reset_path instead of btrfs_release_path?
>
> noinline void btrfs_reset_path(struct btrfs_path *p)
> {
>         int i;
>
>         for (i =3D 0; i < BTRFS_MAX_LEVEL; i++) {
>                 if (!p->nodes[i])
>                         continue;
>                 if (p->locks[i])
>                         btrfs_tree_unlock_rw(p->nodes[i], p->locks[i]);
>                 free_extent_buffer(p->nodes[i]);
>         }
>         memset(p, 0, sizeof(struct btrfs_path));
> }
>
> BTW, I have seen released paths being passed across functions in some oth=
er paths.
>
> Should these also be changed to reset paths, or should these flags be cle=
ared in the release path?

Please don't complicate things unnecessarily.
The patch is fine, all that needs to be done is to call
btrfs_release_path() before passing the path to
btrfs_del_inode_extref(), which resets nodes, slots and locks.

>
> Thx,
> Yangtao

