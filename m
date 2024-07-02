Return-Path: <linux-btrfs+bounces-6141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF632924111
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBDA284C7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E11BA084;
	Tue,  2 Jul 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+ZjTwEw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296E1B5831
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931319; cv=none; b=cBAYzjL90voV7lQoolGN2DZRRW0JSXYCjZyjEiR9GgD5FtUp/NiHGJr/7c3xL6u7P2AtCR1cGYatGPX2XQK+6p19lgfcOK+Y/+xaXyvzIbBgqlUs2kfP2ugdgcHC4/NRO+SHff95S6xyRJ14HWY3yb1D99E1R7mWCVtAg9abDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931319; c=relaxed/simple;
	bh=bfv9p2dlzJjbsYy8G91cA4SgOU/w1GomhkJPmgg1tiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EImVcF49EXj7IW8/PR7yM1x7RL4sv9gbgrmWy449t5btdeXdnsaGQAPXzxBWV4WcTqtd/z/d9z+tvcXbLF8qCbLEMEZeq0yyC+vwwABmm/JUhHTYwquGHooKrMwndW3cTrxITsYWyT7J15gLETt0xPhz+Wz3R4Ir+raduerZDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+ZjTwEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5CEC4AF07
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719931318;
	bh=bfv9p2dlzJjbsYy8G91cA4SgOU/w1GomhkJPmgg1tiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G+ZjTwEwvQHQv6Ds0nzSKxCpiT977i0KVQtgwblYYjrHYO790jXCtwPAX319an9hj
	 s+SdM5EvQVVR2bfSHPOr4mSmziqPykhutAV9CJLZiYaFov04eEzUWLT3wjSQzXKMOS
	 9q7xaWqenTd+CAEod/ezrHcIdFyn2hVYXwDX+7b9uF3TwLBPrrSFl6ZJox8CN+KgEG
	 AGTmnVfppKinkg1aSC/lZDou2UDSvh31vMhF3nCUbiCNi6+qSg2IzkgkXTpZfQEdiR
	 LV2j0wqKlG61DLmHcJdGGyNBKxh2/r7QMXcFSn7eJQv3A884z2rtSm9Mk/+XVwRU7W
	 X7jT+byuXk1Sw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a751ed17b1eso448469166b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Jul 2024 07:41:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFaCBBE6grpEaAe+h2EVr04J+sOiM85z/QKB23x3Jt9h543nSN
	uPAFmeiu7YNwvloZyy+8smfhxVrhmIgKmhXe4B29vqAj8pYCP8mmCoWirNphHTHdXRg1uzLM1fx
	DgauXn5NU5/3XlcAesI9Id2vtY+s=
X-Google-Smtp-Source: AGHT+IGp+vWzqdpZvxjwNCPZ7LLV4L8juem1tjbUiBkzUP1Jqe6EvSDBuvLRFmRZqkkihqAHvjS3ZPovCWhu2BmdvD4=
X-Received: by 2002:a17:906:494a:b0:a6f:7707:b846 with SMTP id
 a640c23a62f3a-a72aee66c4dmr885940666b.15.1719931317137; Tue, 02 Jul 2024
 07:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719930430.git.boris@bur.io>
In-Reply-To: <cover.1719930430.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Jul 2024 15:41:19 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7Gu2SQV+V1WMuVsuMmffAyKVTC5miagZVeitVQps6YuA@mail.gmail.com>
Message-ID: <CAL3q7H7Gu2SQV+V1WMuVsuMmffAyKVTC5miagZVeitVQps6YuA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] btrfs: fix __folio_put refcount errors
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:32=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> Switching from __free_page to __folio_put introduced a bug because
> __free_page called put_page_testzero while __folio_put does not. Fix the
> two affected callers by changing to folio_put which does call
> put_folio_testzero.
> --
> Changelog:
> v3:
> - split up patches for backporting
> v2:
> - add second callsite
>
> Boris Burkov (2):
>   btrfs: fix __folio_put refcount in btrfs_do_encoded_write
>   btrfs: fix __folio_put refcount in __alloc_dummy_extent_buffer
>
>  fs/btrfs/extent_io.c | 2 +-
>  fs/btrfs/inode.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For both patches:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.
>
> --
> 2.45.2
>
>

