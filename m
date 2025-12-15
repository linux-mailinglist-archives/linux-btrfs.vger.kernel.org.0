Return-Path: <linux-btrfs+bounces-19740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC84CBD5E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 11:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A953022AB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B331579B;
	Mon, 15 Dec 2025 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwEinBBc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848F3164D6
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765794658; cv=none; b=WWTza/c2hkmJ7clfiqWS7nKkFeR9dzkhfyDXcdOf8U8ldL5ohlKqBzdT87SfzXkfD+tDiCJYu1RRRpC1EKsm+BrE1/7mkDhqAPEHX7Asr05FGPAGewzQJ1p9k0+EPdCbLVUq02rKy5qICLXc5KWyZR0DgIVmR7Ap5YCG5qKoe6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765794658; c=relaxed/simple;
	bh=+r2w1ecQLoZPkZjVkkgUEkPMN72cyX+DP7bG8vMJJos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7XZwl5bp7dEXC1M38k9Qh6B7u+GjCuILT65Y9lMS5u5biZUbcAaN45F9KfPVBPK7qk3/gg9sTA1vi4dzc//yMklFL91HEYDBpuhmWlz3NaBqpbCypOChNZMnSkEhgLUkz6Ultx33Tp3prfLZQ1f5aNWNllldtfJHmEltg5lSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwEinBBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E491DC4CEF5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765794657;
	bh=+r2w1ecQLoZPkZjVkkgUEkPMN72cyX+DP7bG8vMJJos=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cwEinBBc4h/zWLBEcpdkncwAN+jTJ3yeyl2IUHWAnNTVa1NGh5NtqaQBo+kvcK46q
	 1kypIWFr7jmdm1nQ65+VyUxxyq4SA9Ieqnr9q4NS86CIjADuSXlbHmSqMRFJVEP3cn
	 J2HhwAcv7Epasp2ODi7JQoszjtD5/Dpw311ZeNOFvZb3W0TtSsYHK62OfW0iHdXA+U
	 QGBTbjfkYzfFKG9En9jgDl8m+tDnUEg9b6xbYGWOxrJKt15KsnsGyENf+G+SMs8YK7
	 Q5fg40tedanyFsJz5Et6TJ3Pgkw2a8ZKNlmw3XHKXRMY8nIGI+ZX86bxnJK4N/z82a
	 PIazwyjgIqa7w==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so5144292a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 02:30:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyOWDLbWOSzhdEEz4KDidy9AyY3Dix2QZnTxzZM55gNePUhQnGU
	ToPXgERHrCBGTLFOQN4hQV6iPAjlI96G540wZCT8Vaw4bwfQ8yTqIFw9TpoblGW0sf3ObVfWUPw
	F+ZjYhflA0oI22WWLZoLMMRJSPSCzM1o=
X-Google-Smtp-Source: AGHT+IF/i6RcCtVzz2hH97nzOeqf+OTGfAy4NTG0WR7smtJxXq9YCv6Q6zQNRyt58+QsKRt0LuiLC9YrLLg2fYqyeLc=
X-Received: by 2002:a17:907:2d11:b0:b73:70db:49ab with SMTP id
 a640c23a62f3a-b7d237743f2mr990500966b.35.1765794656500; Mon, 15 Dec 2025
 02:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9ce1fd6cf3ef17a4d4b24a71d51792c6979fe68.1765744373.git.wqu@suse.com>
In-Reply-To: <b9ce1fd6cf3ef17a4d4b24a71d51792c6979fe68.1765744373.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Dec 2025 10:30:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ThZf4NmB_VAXbhbf_YumC79KwE9VzAVyW16HDCa7HZQ@mail.gmail.com>
X-Gm-Features: AQt7F2ohkRanfEm-nsHyoElrXcFioNz_gFdh-aJIvc8YI_eVrkpF8kEa8K1gZCQ
Message-ID: <CAL3q7H5ThZf4NmB_VAXbhbf_YumC79KwE9VzAVyW16HDCa7HZQ@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: add an ASSERT() to catch ordered extents with
 incorrect csums
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 8:33=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Inspired by recent bug fix like 18de34daa7c6 ("btrfs: truncate ordered
> extent when skipping writeback past i_size"), and the patch "btrfs: fix
> beyond-EOF write handling", if we can catch ordered extents with
> incorrect checksums, the above bugs will be caught much easier.

So reading "incorrect checksums", both in this paragraph and in the
subject, gives the idea that the checksums don't match the data...
I find it very misleading.

I would phrase it as "ordered extents missing checksum ranges" or just
"ordered extents missing checksums".

>
> Introduce the following extra checks for an ordered extent at
> btrfs_finish_one_ordered(), before inserting an file extent item:
>
> - Skip data reloc inodes first
>   A data reloc inode represents a block group during relocation, which
>   can have ranges that have csum but some without.
>   So we can not easily check them.
>
> - NODATACOW OEs, NODATASUM inodes must have no csums
>   NODATACOW implies NODATASUM, and it's pretty obvious that NODATASUM
>   inode should not have ordered extents with csums.
>
> - Compressed file extents must have csum covering the on-disk range
>   Even if a compressed file extents is truncated, the csum is calculated
>   using the on-disk extent, thus the csum must still cover the on-disk
>   length.
>
> - Truncated regular file extents must have csum for the truncated length
>
> - The remaining regular file extents must have csum for the whole length
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Fix a compiler warning when CONFIG_BTRFS_ASSERT is not selected
>   By hiding the oe_csum_bytes() and the main part of assert_oe_csums()
>   behind that config.
>
> v2:
> - Updated to check all possible combinations
>   Previously version can only detect the OEs in patch "btrfs: fix
>   beyond-EOF write handling" where the OE has no csum at all, but can
>   not detect OEs that has partial csums.
> ---
>  fs/btrfs/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 461725c8ccd7..28227d43b082 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3090,6 +3090,72 @@ static int insert_ordered_extent_file_extent(struc=
t btrfs_trans_handle *trans,
>                                            update_inode_bytes, oe->qgroup=
_rsv);
>  }
>
> +#ifdef CONFIG_BTRFS_ASSERT
> +static u64 oe_csum_bytes(struct btrfs_ordered_extent *oe)
> +{
> +       struct btrfs_ordered_sum *sum;
> +       u64 ret =3D 0;
> +
> +       list_for_each_entry(sum, &oe->list, list)
> +               ret +=3D sum->len;
> +       return ret;
> +}
> +#endif
> +
> +#define ASSERT_OE(cond, oe)                            \
> +       ASSERT(cond,                                    \
> +"root=3D%lld ino=3D%llu file_pos=3D%llu num_bytes=3D%llu ram_bytes=3D%ll=
u truncated_len=3D%lld csum_bytes=3D%llu disk_bytenr=3D%llu disk_num_bytes=
=3D%llu flags=3D0x%lx", \
> +              btrfs_root_id((oe)->inode->root),        \
> +              btrfs_ino((oe)->inode),                  \
> +              (oe)->file_offset, (oe)->num_bytes,      \
> +              (oe)->ram_bytes, (oe)->truncated_len,    \
> +              oe_csum_bytes(oe),                       \
> +              (oe)->disk_bytenr, (oe)->disk_num_bytes, \
> +              (oe)->flags);
> +
> +static void assert_oe_csums(struct btrfs_ordered_extent *oe)

Both here and in oe_csum_bytes(), the oe can be made const.

> +{
> +#ifdef CONFIG_BTRFS_ASSERT
> +       struct btrfs_inode *inode =3D oe->inode;
> +       const u64 csum_bytes =3D oe_csum_bytes(oe);
> +
> +       /*
> +        * Skip data reloc inodes. They are for relocation and they
> +        * can have ranges with csum and ranges without.
> +        */
> +       if (btrfs_is_data_reloc_root(inode->root))
> +               return;
> +
> +       /*
> +        * There should be no csum for NODATACOW (implies NOCSUM),
> +        * NODATASUM inode.

A bit confusing, especially because NOCSUM does not exist, it's NODATASUM.
Just say "There are no checksums for NODATACOW and NODATASUM".
Or say nothing at all, as it's pretty obvious and doesn't add any
value as the code below is trivial to read.

> +        */
> +       if (test_bit(BTRFS_ORDERED_NOCOW, &oe->flags) ||
> +           inode->flags & BTRFS_INODE_NODATASUM) {
> +               ASSERT_OE(csum_bytes =3D=3D 0, oe);
> +               return;
> +       }
> +       /* For compressed OE, csum must cover the on-disk range. */
> +       if (test_bit(BTRFS_ORDERED_COMPRESSED, &oe->flags)) {
> +               ASSERT_OE(oe->disk_num_bytes =3D=3D csum_bytes, oe);
> +               return;
> +       }
> +
> +       /* For truncated uncompressed OE, the csum must cover the truncat=
ed length. */
> +       if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
> +               ASSERT_OE(oe->truncated_len =3D=3D csum_bytes, oe);
> +               return;
> +       }
> +
> +       /*
> +        * The remaining case is untruncated regular extents.
> +        *
> +        * The csum must cover the whole range.

csum -> csums, since we can have several csum items in the ordered
extent's list.
Also the new line seems superfluous.

Thanks.

> +        */
> +       ASSERT_OE(oe->num_bytes =3D=3D csum_bytes, oe);
> +#endif
> +}
> +
>  /*
>   * As ordered data IO finishes, this gets called so we can finish
>   * an ordered extent if the range of bytes in the file it covers are
> @@ -3170,6 +3236,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_e=
xtent *ordered_extent)
>
>         trans->block_rsv =3D &inode->block_rsv;
>
> +       assert_oe_csums(ordered_extent);
> +
>         ret =3D btrfs_insert_raid_extent(trans, ordered_extent);
>         if (unlikely(ret)) {
>                 btrfs_abort_transaction(trans, ret);
> --
> 2.52.0
>
>

