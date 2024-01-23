Return-Path: <linux-btrfs+bounces-1662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455F839D5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 00:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676DE1C2574B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3A54BCA;
	Tue, 23 Jan 2024 23:50:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE354BC0
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053806; cv=none; b=BruOfnUhIwSSwuLvU0Ijy1l3RA+aUEimFEp7x/gvXY+POeKZJaPnnsZnAspAGWkOyfnzSjis9Mlmlu+qywZAIT1NvwUPpr0DeNEtFj6sdP4fwUbBuLwhJc4s+kRXNeUTGCarN8/AGSM8Lg8PSRpjIFoxdA8X8uIvyg30XrcFsrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053806; c=relaxed/simple;
	bh=ireHVHhGIhpgFVZJTSyQn//zDLC4W9lhUrtLp6UgAEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD3vvapfZbA2QpimE+udovWpIArn2+ykbUnVKl0SUXJgVp3mDYj1CW5zEy0BWdwev1in0qMagaFa15n2IOlWf7BFZiVrzT0dZzK/Kw/2buzQanOO9nalCVNCdvE3ljPH+bYR0Oo1k/dz32ntembqlFISF+38M+mO/vwUsaZdFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cf1c8cc6bdso5462451fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 15:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706053802; x=1706658602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmx9a2eOQPDs+M3+uw0ziSH09YqYaiPue3Ub1TkscZ4=;
        b=b+O8KI4UKSzdKqUcaZoexrAj036MnxI6FaiXZEUEmD8F4frjJJ69QxxY+EU//rZ9Ml
         8rFJ86Opf1stArSF4Viv3NpgZbabJ9gTI6uI+yL7PcC3qQ3yJVgvA47hNC3iHuN/YOrm
         I9Tecd5Ne8WvF3uJJnG26HbOVbcYG/TsGnTLOwtKL9rHjV2EzMUQMDjuVzAN3cTAsx3z
         QOdbhq5KsRl8uc1I6Vo2hun5MA1jG+LU0DkBdLNnZvU8ya9YuvvmPDPE7qIHsWMFB2Wq
         sGQEsYciPMu72JXKhGrvvzflsL6cGI/3bNtSpAczatRBRCxdqMJ9c+GczQqMixdxB+kk
         ejYQ==
X-Gm-Message-State: AOJu0YyYOmojT6ZWr4SclqH6/piRvNsHMK7oXf5mpqhgv6baNf0CoWs2
	F2TDly56L74ZlRYfTXDbXEXW1aLgTCG89yjdczWII3HP15a83RL0lqofZ5HKEPkGtQ==
X-Google-Smtp-Source: AGHT+IHbSG6H3NGStknvt4hc6xsJcOjDvXcULi96xJJs3/UyJZpWwolM0u2y/yzcrAKQRcS9oa6RlA==
X-Received: by 2002:a05:6512:6c5:b0:50e:778b:8b36 with SMTP id u5-20020a05651206c500b0050e778b8b36mr3399934lff.120.1706053801344;
        Tue, 23 Jan 2024 15:50:01 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id k26-20020a17090666da00b00a1df4387f16sm14880931ejp.95.2024.01.23.15.50.01
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:50:01 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso22496815e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 15:50:01 -0800 (PST)
X-Received: by 2002:a05:600c:1396:b0:40d:5575:a197 with SMTP id
 u22-20020a05600c139600b0040d5575a197mr582676wmf.12.1706053800952; Tue, 23 Jan
 2024 15:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3bed652c4e20c8a446fba371d529a78dc98b827.1705978912.git.wqu@suse.com>
In-Reply-To: <c3bed652c4e20c8a446fba371d529a78dc98b827.1705978912.git.wqu@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 23 Jan 2024 18:49:24 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_OygqAdFoAV02PK8zaZm_4HhkvLz8-FQEK6ZnodYst5w@mail.gmail.com>
Message-ID: <CAEg-Je_OygqAdFoAV02PK8zaZm_4HhkvLz8-FQEK6ZnodYst5w@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: zstd: fix and simplify the inline extent decompression
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:04=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> If we have a filesystem with 4k sectorsize, and an inlined compressed
> extent created like this:
>
>         item 4 key (257 INODE_ITEM 0) itemoff 15863 itemsize 160
>                 generation 8 transid 8 size 4096 nbytes 4096
>                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                 sequence 1 flags 0x0(none)
>         item 5 key (257 INODE_REF 256) itemoff 15839 itemsize 24
>                 index 2 namelen 14 name: source_inlined
>         item 6 key (257 EXTENT_DATA 0) itemoff 15770 itemsize 69
>                 generation 8 type 0 (inline)
>                 inline extent data size 48 ram_bytes 4096 compression 3 (=
zstd)
>
> Then trying to reflink that extent in an aarch64 system with 64K page
> size, the reflink would just fail:
>
>   # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
>   XFS_IOC_CLONE_RANGE: Input/output error
>
> [CAUSE]
> In zstd_decompress(), we didn't treat @start_byte as just a page offset,
> but also use it as an indicator on whether we should error out, without
> any proper explanation (this is copied from other decompression code).
>
> In reality, for subpage cases, although @start_byte can be non-zero,
> we should never switch input/output buffer nor error out, since the whole
> input/output buffer should never exceed one sector, thus we should not
> need to do any buffer switch.
>
> Thus the current code using @start_byte as a condition to switch
> input/output buffer or finish the decompression is completely incorrect.
>
> [FIX]
> The fix involves several modification:
>
> - Rename @start_byte to @dest_pgoff to properly express its meaning
>
> - Use @sectorsize other than PAGE_SIZE to properly initialize the
>   output buffer size
>
> - Use correct destination offset inside the destination page
>
> - Simplify the main loop
>   Since the input/output buffer should never switch, we only need one
>   zstd_decompress_stream() call.
>
> - Consider early end as an error
>
> After the fix, even on 64K page sized aarch64, above reflink now
> works as expected:
>
>   # xfs_io -f -c "reflink $mnt/source_inlined 0 60k 4k" $mnt/dest
>   linked 4096/4096 bytes at offset 61440
>
> And results the correct file layout:
>
>         item 9 key (258 INODE_ITEM 0) itemoff 15542 itemsize 160
>                 generation 10 transid 10 size 65536 nbytes 4096
>                 block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                 sequence 1 flags 0x0(none)
>         item 10 key (258 INODE_REF 256) itemoff 15528 itemsize 14
>                 index 3 namelen 4 name: dest
>         item 11 key (258 XATTR_ITEM 3817753667) itemoff 15445 itemsize 83
>                 location key (0 UNKNOWN.0 0) type XATTR
>                 transid 10 data_len 37 name_len 16
>                 name: security.selinux
>                 data unconfined_u:object_r:unlabeled_t:s0
>         item 12 key (258 EXTENT_DATA 61440) itemoff 15392 itemsize 53
>                 generation 10 type 1 (regular)
>                 extent data disk byte 13631488 nr 4096
>                 extent data offset 0 nr 4096 ram 4096
>                 extent compression 0 (none)
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.h |  2 +-
>  fs/btrfs/zstd.c        | 73 ++++++++++++------------------------------
>  2 files changed, 22 insertions(+), 53 deletions(-)
> ---
> Changelog:
> v2:
> - Fix the incorrect memcpy_page() parameter:
>   Previously the pgoff is (dest_pgoff + to_copy), not just (dest_pgoff).
>   This leads to possible write beyond the current page and can lead to
>   either incorrect contents (if to_copy is smaller than 2K), or
>   triggering the VM_BUG_ON() inside memcpy_to_page() as our write
>   destination is beyond the page boundary.
>

Have we checked to see if this problem shows up in the other
compression algorithms? I know the change was reverted for btrfs-zstd
because Linus saw the issue directly[1], but I'm concerned that the
only reason he saw it is because Fedora uses zstd by default[2] and
this might be an issue in the other algorithms.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3De01a83e12604aa2f8d4ab359ec44e341a2248b4a
[2]: https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompression

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

