Return-Path: <linux-btrfs+bounces-20333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 657FDD0A084
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 13:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6E73070D55
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA335B135;
	Fri,  9 Jan 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMJneKoR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B935971B
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962646; cv=none; b=HBvmnEQMoD6EUoGjnHbELf7IPbhNNZzJto04zy0eIV45u3zIU2cQ6GG089sodznyD977r5BSRK3ZG13b6NGFiI2qaTlshBcrMbsUAZ012uTbP9mTKA4P03oJIsD1/JE9Rk6wLFmSE+9jvTc2+CvVzCy789Z0/B7IDS7ll4OTFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962646; c=relaxed/simple;
	bh=SlmfbfOFVqgiwP1tknewbGeXJ4yuK3hRRFmp7kTnMtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL/0101m8d3ueY9XYM05W8xAGeCUvP8/ooNmdlIdqLBK4gpCNcSZgGMgV+Lgc1fKxCc8xnfk9b0uJwSWRn/H7o9qbIvRIjMJq4cZNs+KNefE0e1iE9skS6U1USMQIO+GtpM0CUELdMzYQCE/AFqWIMTj9/GBTx8oIyfgSfjlJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMJneKoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56846C19425
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767962646;
	bh=SlmfbfOFVqgiwP1tknewbGeXJ4yuK3hRRFmp7kTnMtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DMJneKoRLPJSOMUql6Ldya57xZewZ2GMFfPCdip+A0xfWQfQW+NcDz2oKqf1olsEh
	 U6yInBPgoeXw4XnUgOVBVEpK20Qanw3nhJ9j0d9bdRLE/J39j7DOeawC9hkk9mIKK9
	 +01WKKC0Bu81WJmwT4EtXi0vZI8IC650Qd1RqftB8oyPqu8udJDenrh5tOJrzxl8WQ
	 +gfqT4d+F1lzyYtaAA5MPKbNNP9Wz1Jn1WmRWZuMcNIBJ7umSMqdXmqG9Y4I80CUX5
	 7niZ+rkvQXVcB91HM6F46cC39fdHEJCYQu+YCJFzbRTR+Ip1c5EzR+J6QkLBpkDbNF
	 qZR+0sq5RYkJA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so5843066a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jan 2026 04:44:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOrWQvZhXzVWqZt7Efa1D0N67cCF3yqT0o8Ldtnjxsh7JkuBNtNnSnGtL56J2PxJxbfsbpX0TvOFtFwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1nElUZdPsFctWL10uA2orRQNHzb9PcRpgV1Kh0otfA5lSRRB
	Nctv5n9hfkZKzhswxfEATcEv/XgVRCRRr9QqyoOQ9VV5ekS6j2ibbb+42j0DLn1UfxI5gi6iBfC
	Jw7b4CDrRHy6drxOc3pbBLYlKrqrbyJY=
X-Google-Smtp-Source: AGHT+IEoSNrPou/FENjiw/zzrqsb7nz86hUHqzDlozeTtnZfTR1GU9a+nj7ousYQTsa4E3KfNy+Zutn30dFJY6JGqm4=
X-Received: by 2002:a17:907:7245:b0:b73:572d:3aff with SMTP id
 a640c23a62f3a-b8445345f19mr902295066b.35.1767962644884; Fri, 09 Jan 2026
 04:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <695faa63.050a0220.1c677c.039b.GAE@google.com> <tencent_7744F7621777A6DDB366E374C97F83BEE405@qq.com>
In-Reply-To: <tencent_7744F7621777A6DDB366E374C97F83BEE405@qq.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 9 Jan 2026 12:43:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
X-Gm-Features: AQt7F2rRfXMyUVPd4Oa3Kd2Ih41A7T9Hg-uNgo5oLoqwXWOuPYyni5fHsXM0BtE
Message-ID: <CAL3q7H4k3Dj9gQQhBz_eadnRUaWaNPaf7+MYucshY6cis2by5Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Sync read disk supper and set block size
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 11:42=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
>
> When the user performs a btrfs mount, the block device is not set
> correctly. The user sets the block size of the block device to 0x4000
> by executing the BLKBSZSET command.
> Since the block size change also changes the mapping->flags value, this
> further affects the result of the mapping_min_folio_order() calculation.
>
> Let's analyze the following two scenarios:
> Scenario 1: Without executing the BLKBSZSET command, the block size is
> 0x1000, and mapping_min_folio_order() returns 0;
>
> Scenario 2: After executing the BLKBSZSET command, the block size is
> 0x4000, and mapping_min_folio_order() returns 2.
>
> do_read_cache_folio() allocates a folio before the BLKBSZSET command
> is executed. This results in the allocated folio having an order value
> of 0. Later, after BLKBSZSET is executed, the block size increases to
> 0x4000, and the mapping_min_folio_order() calculation result becomes 2.
> This leads to two undesirable consequences:
> 1. filemap_add_folio() triggers a VM_BUG_ON_FOLIO(folio_order(folio) <
> mapping_min_folio_order(mapping)) assertion.
> 2. The syzbot report [1] shows a null pointer dereference in
> create_empty_buffers() due to a buffer head allocation failure.
>
> Synchronization should be established based on the inode between the
> BLKBSZSET command and read cache page to prevent inconsistencies in
> block size or mapping flags before and after folio allocation.

While that fixes the problem, I'd rather lock the invalidation lock
instead of the inode:

filemap_invalidate_lock(mapping);
page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
filemap_invalidate_unlock(mapping);

Because that's what the documentation for read_cache_page_gfp() asks for:

/**
 (...)
 *
 * The function expects mapping->invalidate_lock to be already held.
 (...)
 */
struct page *read_cache_page_gfp(struct address_space *mapping,
pgoff_t index,
gfp_t gfp)
{
return do_read_cache_page(mapping, index, NULL, NULL, gfp);
}

That will fix the race with set_blocksize() too.

Thanks.


>
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> RIP: 0010:create_empty_buffers+0x4d/0x480 fs/buffer.c:1694
> Call Trace:
>  folio_create_buffers+0x109/0x150 fs/buffer.c:1802
>  block_read_full_folio+0x14c/0x850 fs/buffer.c:2403
>  filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2496
>  do_read_cache_folio+0x266/0x5c0 mm/filemap.c:4096
>  do_read_cache_page mm/filemap.c:4162 [inline]
>  read_cache_page_gfp+0x29/0x120 mm/filemap.c:4195
>  btrfs_read_disk_super+0x192/0x500 fs/btrfs/volumes.c:1367
>
> Reported-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db4a2af3000eaa84d95d5
> Tested-by: syzbot+b4a2af3000eaa84d95d5@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/btrfs/volumes.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 13c514684cfb..eee7471a3e03 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1339,6 +1339,7 @@ struct btrfs_super_block *btrfs_read_disk_super(str=
uct block_device *bdev,
>         struct page *page;
>         u64 bytenr, bytenr_orig;
>         struct address_space *mapping =3D bdev->bd_mapping;
> +       struct inode *inode =3D mapping->host;
>         int ret;
>
>         bytenr_orig =3D btrfs_sb_offset(copy_num);
> @@ -1364,7 +1365,9 @@ struct btrfs_super_block *btrfs_read_disk_super(str=
uct block_device *bdev,
>                                       (bytenr + BTRFS_SUPER_INFO_SIZE) >>=
 PAGE_SHIFT);
>         }
>
> +       inode_lock(inode);
>         page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_N=
OFS);
> +       inode_unlock(inode);
>         if (IS_ERR(page))
>                 return ERR_CAST(page);
>
> --
> 2.43.0
>
>

