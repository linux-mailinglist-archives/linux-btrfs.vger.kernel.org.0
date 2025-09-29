Return-Path: <linux-btrfs+bounces-17267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A12EBAA06C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5E4165BEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4A30CD81;
	Mon, 29 Sep 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiDe7wcx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54330ACE0
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163930; cv=none; b=toOQrQXjUge+A7qQKjwVjm+yops6BfkctbLBNlQDork1bsANaHxHcqBwDP+5iA8PZPz9ohbVGUX6x4Tp4UqWcJvzSlv0FNy1CIt27Q+snNuKCpbrHAT4gTNT2Jf/BvUOtHt2eaO7Q1STdWF3tccsc/n2xcTcphIUpGM7XSgkOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163930; c=relaxed/simple;
	bh=u1VHn+UovpUEI+ZZzfC4BBk/eIZ3SYeiwo9camX33D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWipr2oEToEN8HDOyLiVz+qmtIQQ0KUFGd+1LS1o6xDBTrhYc8WPQg+e40IqEr7ffZhqUy1Pfk7LKDlEhtq6K8R33n1Gt+f+e7qm0JDkgLdZC2yDHsJuvrZ/N2K4Urkzh7EfD8vo9Vjao1d8bupZfsXKo82L0FeVJfKGLT6PbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiDe7wcx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7b97ce4fc60so392962a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759163928; x=1759768728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maHFjVh0AgZ1eyCoJI1HgQBFqa8S/pqakBNQIu3I428=;
        b=jiDe7wcxja0pVX5i1KAXX0aVqDXnVYY/+hcCaP7se2uHasKQ6pMqYMZyqjjuuniLPc
         JVGsftjxjZy8rIUQaWww3NwiCSRvIzAFkI0tUKMHHPxtja6hXCzVM47ckWxnvrBBG/fq
         a3Ye6MmA84h1L5SMN/xMQNlJarBRQDKlWfDAZSVA273FDLoVDyNbafrwWIddcctbFM3N
         TBtb1DnORNHYKeslAh1vmv2wzGJHXtiNXKv6tE9e1EnHqEqaMPJ42wKGtv06bfOC1pqp
         SbEBQYaTtA0ymVx0W1gFoRMj1go9j7+SKGFzkaDyNCMrxlxOf5a5adjnYzMFiKbBPdxa
         +60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759163928; x=1759768728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maHFjVh0AgZ1eyCoJI1HgQBFqa8S/pqakBNQIu3I428=;
        b=N3TAF7c8pYpZjXoGBYxzCmuHzfw6kbacfpnhMKPUtHeOfSUzOvH5LCdNjgNyg0NQwc
         q7mXh2EExfs+NmOKPYqw+5KddHy65ClWo1dyXcaN2yVAPCrjHHKIybxaZwnXXkntBPdc
         1l5+uCL85Mbf4hXBsdApj6Znr0FDwayDIbPU4OTiUcYC6PonZ1IfuYKm0h9FLLakIGCj
         q5kgMQcygGP5aVD6DhAsmnwbM73KcIC5/hpRk1jPu4uSe/K2g89ibznXfcc9mbZzecbF
         4Oe2bhwAQlJ0MAD5yNYGQ5db4yFaTsafECbfirOC7pQvJusaz6znbv2RZmzDu/iTDzdM
         1PRA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGWXIkAy13c2KAI1PmgDS2Zn4mHofncMyLnUt6dJ6PFwWFgxfnThF5+jKAnjncRTN80mX4mgAoY9wyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Irr7iEoG9Y1hctB5QJ+csHpik5HRhbRW9wApqLv3B48duFAa
	TV2yCa9xx/JlUih8XzxyaG+CxfVMLCmq4q4lZqvow9lm7IrW/705C0lU2vXshnphm/o59iMK0v2
	ZULvmONFZzJHVM6ILUZv8n4CAmCnQntk=
X-Gm-Gg: ASbGncsC4DPF1JPZIggCWD3EOL7RfYtfvnMqCz+GugMGzGwtQGWOdSXD2rXtu/q9/U9
	7YL0AuZeMdEoRHlX0EcKftExFFZjIsBEQp1KGs8unwRC2fgKpMaZvhU2aW4P+wjNlZqIyqHS9GQ
	5i9Vk1CEKbjLPSYz1tjXdZf3gkD2nFLIxshzOkD4lqapYAZMDQKxo7MeXn7bq+5cKcqA/7Grlcl
	SUWQQ==
X-Google-Smtp-Source: AGHT+IGEJMvATsTrsn6iU+x2uiTwg0oIMFH9PgEJZP/TvWuo8Gl5Iaer0YyznrbCEanhGWlnVmLpwCHXYEVgWG9tEdE=
X-Received: by 2002:a05:6830:264f:b0:78e:a394:ca24 with SMTP id
 46e09a7af769-7a03a3218b4mr8647304a34.8.1759163927782; Mon, 29 Sep 2025
 09:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
 <CABXGCsObwh8TfAAYhoFSrgKsC4EKdi5tryThQgTgWPG8irwf8A@mail.gmail.com> <c54510bb-601f-4180-bc36-62e494fea9bf@gmx.com>
In-Reply-To: <c54510bb-601f-4180-bc36-62e494fea9bf@gmx.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 29 Sep 2025 21:38:36 +0500
X-Gm-Features: AS18NWA0UsUMOHKIMSpTqXKGsaiM8n5Of-7zvkbTkj3HaglMK9gcahuGOqbNblE
Message-ID: <CABXGCsOOtX4+f0P0Aec=Me81bwGLaL37E9RZCyEmkQXv3qKb8A@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: remove btrfs_fs_info::leaf_data_size
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 1:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
> This is weird, just as the error message shows, chunk tree leaf should
> never be empty.
>
> Even during mkfs, the initial temporary fs never writes an empty chunk le=
af.
>
> Mind to dump the super block by:
>
>   # btrfs ins dump-super /dev/nvme1n1p1
>
>
> But still, this is not a big deal, and you can ignore that.
> Tree-checker just rejected such empty leaf, and the chunk-recovery can
> still continue without extra problems.
>
> > leaf 22020096 items 0 free space 16283 generation 1589645 owner CHUNK_T=
REE
> > leaf 22020096 flags 0x0() backref revision 1
> > fs uuid 95e074d1-833a-4d5e-bc62-66897be15556
> > chunk uuid deabd921-0650-4625-9707-e363129fb9c1
> > cmds/rescue-chunk-recover.c:2409: btrfs_recover_chunk_tree: BUG_ON
> > `ret` triggered, value -1
>
> Since this is very old code, it lacks the standard proper error handling
> nor error messages to indicate what went wrong.
>
>
> Mind to try the attached patch and rerun?
>

Hi Qu,

thanks for the quick follow-ups and the second patch.
I=E2=80=99ve rebuilt and tested it - now btrfs rescue chunk-recover complet=
es
successfully:

# btrfs rescue chunk-recover /dev/nvme0n1p1
Scanning: DONE in dev0
Check chunks successfully with no orphans

For reference, here are the additional checks afterwards:

# btrfs check /dev/nvme0n1p1
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p1
UUID: 95e074d1-833a-4d5e-bc62-66897be15556
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
We have a space info key for a block group that doesn't exist
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 17421781766144 bytes used, error(s) found
total csum bytes: 16988862144
total tree bytes: 24937299968
total fs tree bytes: 5389139968
total extent tree bytes: 737476608
btree space waste bytes: 2778325600
file data blocks allocated: 18001721421824
 referenced 17455888326656

And the superblock:

# btrfs ins dump-super /dev/nvme0n1p1
superblock: bytenr=3D65536, device=3D/dev/nvme0n1p1
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0x4e2e8c37 [match]
bytenr 65536
flags 0x1
( WRITTEN )
magic _BHRfS_M [match]
fsid 95e074d1-833a-4d5e-bc62-66897be15556
metadata_uuid 00000000-0000-0000-0000-000000000000
label
generation 1591832
root 13924626546688
sys_array_size 129
chunk_root_generation 1588108
root_level 0
chunk_root 23937024
chunk_root_level 1
log_root 0
log_root_transid (deprecated) 0
log_root_level 0
total_bytes 30725970608128
bytes_used 17421823266816
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 1
compat_flags 0x0
compat_ro_flags 0x3
( FREE_SPACE_TREE |
  FREE_SPACE_TREE_VALID )
incompat_flags 0x361
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA |
  NO_HOLES )
cache_generation 0
uuid_tree_generation 1591832
dev_item.uuid 895e1909-c683-46cd-98a3-598ed4ea0248
dev_item.fsid 95e074d1-833a-4d5e-bc62-66897be15556 [match]
dev_item.type 0
dev_item.total_bytes 30725970608128
dev_item.bytes_used 18371747774464
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0

So the crash is gone, and chunk-recover works again.
Only btrfs check still reports a =E2=80=9Cspace info key for a block group
that doesn=E2=80=99t exist=E2=80=9D, which looks unrelated to your patch.

Thanks again for the fix!


--
Best Regards,
Mike Gavrilov.

