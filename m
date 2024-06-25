Return-Path: <linux-btrfs+bounces-5977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EA9174E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B026E1F2218D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC6917994D;
	Tue, 25 Jun 2024 23:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Y8Uj68j0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0021DA58
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359358; cv=none; b=uuqRP7FQLt4x13yThzmxdE24s0p/hT2E7JxZfjxa2UKf49Lbyz6GrKHiun8lWdykTipJl2hR3hFg1cu0a6MabfenKzoYHj+Lmab4T7mVdJac2E0R8rKAGMdlfnhXu3L6UExpxVttjVnJ84OprjGJ0i95B1GYRKTmTR3y8cS/P/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359358; c=relaxed/simple;
	bh=/8Z3/r9JnBED2lr2gKNWOcZ7ArpBw4MVy3EyxI/LvIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BLgdw3E7XOcF/Gpwy2feRnZWnmFms5mjpuhUiaXu2JZrtU64EySDdHaybKv/3MPahn7QYBZGGLSLxCnUGoOZIfbmj37NpcN8cd54+eLGFbfipCeIkz1BJ04QwLrU006ggypSrbvU0Xdjypj+PugI0ABz2oYUX3bEaxH+JutGkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Y8Uj68j0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719359342; x=1719964142; i=quwenruo.btrfs@gmx.com;
	bh=gzZuNHsirx5Z2oi3Sc11ltmveO0SdMbjHjV7OPZMf6g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y8Uj68j0ryvj5xRBN8SZorTb0mpbaE+j1TYImMAokq5P7gJnWd0J+FA1kcLvM3f1
	 NIDWfkd44y83lTV0qdcFSXSpCmuLR9luSbCJihA+cYQZRCQA+givywgTJ2a9IDb08
	 JfYnhQ5IOPe9+fzuRQvtJedPGp1VuKDDXC2uRs6nIb78e0gg1bmdhmXOYezf19BHG
	 p+mibJbSupmPw7UG9lEAOtVgkULQiiQ15UKwwk4ty3H8oEaGm1j7g3SFwlRjSB5Uq
	 ExTGXZ3xlhGBwW28HWLugqEmyF1Uum8HxJYysYqPH0uVZBfBPhO+Oqjx6ynjNvTNf
	 Z1yniDZOE+7R8pnJmg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7GS-1sAkNC3dF4-00CJhd; Wed, 26
 Jun 2024 01:49:02 +0200
Message-ID: <bdb333e8-b95b-4c55-9b4e-3aa17c6d4607@gmx.com>
Date: Wed, 26 Jun 2024 09:18:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: move the direct IO code into its own file
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <107dc9437ffcbf6751d018209d037c851a890f4d.1719328515.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <107dc9437ffcbf6751d018209d037c851a890f4d.1719328515.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sgqDjswIfgbaCCoAKeNQBvGSYF44omy80ysf44v28Z01efy/a2k
 ysTlZ5xJCktAhsP8GrTVLVPFsvudTDKuBhGSRLe+vJHnbfbeG8Z1Ur6ouA55qcAPON1tYNn
 GiI9uDhLflUgrhD+oVMPZ5E6PwxeLArAM15JS6SynXJHfH18T8YcTu+QC/JqAIhnmWmMwG7
 cMT8QHNs4nWeaBxbiUXhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DYeY4nC4KIQ=;xISmR8sc5YiBe69taesJxc4lkqE
 P/zZS3fJYGy/HwKoeSFWgrQt80AF02KzI1Rza1Ve3gPDaVMbagiBYF3ZHzZUSWpTRduBDqYU8
 Et5QdFl5iPp3zwNhRfEtIy9Jt0JHkwr+d0mwxXB3j+qQelKTGehtlhZHvc/ArpgfLztUdheMf
 XiTh2R4RjV88h0eBa//ZSjVe/fj+Z3U7qnD0T4zTrklt1pCDOm09VXTxIRxVOX7HpZVrw9hku
 wQV5EM90BVA1tzGFNeXGi0BFZePETmeH+I4h/tz0juqC6/bgrqNamGA3Wd6HxdAWu/NLHmosA
 bidrnf+yr70cRQFG3qnAz7gvNb7MdUasbiVFp+rziyARDvmSHFAHzn6aRx2Mp/MvCL95mS80c
 7OszGgEcIpzuldzpY7ZuqKUTMLSWYA5siJStmwV6nt7VvrEcXa5WX5d2XFbvAKl8ihZqB4jeY
 5nn9kh89H+TrwiIIN3IBKNeBB4MPnANHR24TDTVw/LrYl6xCTDuPOfoxUEWDTSmmM/Z1vEC0R
 rHbEpxqYtEqk+e6pbwUs7wDiAghOyDVLUCixJ8vnJFQ2CFB5fwuCOzRDThlI2N27EGxe9u39Z
 nOdp0mnIWG8qclLweTMGmwTHA2Abqm22MFba9wRksG+qlxY267vmS7DDDKfDCx5v/RTpHEE9/
 roiZk8gTjNWGl04nmZTycHjRUnni7VtphQAeFxpQH98ZzmCrOGOLPiVRVWwIydzi+dmW4+k6P
 Ox+IrBZ+WR0pstGp1Yg928fT2sTl8wkjsR3OGlmoRDda74EUb1aPm8McT+ONC/WR2KSvUQcAU
 2j7w6JFjYy0PNGqi4jQzrnoq74cP8n/QW8TbednxUQB6g=



=E5=9C=A8 2024/6/26 00:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> The direct IO code is over a thousand lines and it's currently spread
> between file.c and inode.c, which makes it not easy to locate some parts
> of it sometimes. Also inode.c is about 11 thousand lines and file.c abou=
t
> 4 thousand lines, both too big. So move all the direct IO code into a
> dedicated file, so that it's easy to locate all its code and reduce the
> sizes of inode.c and file.c.
>
> This is a pure move of code without any other changes except export a
> a couple functions from inode.c (get_extent_allocation_hint() and
> create_io_em()) because they are used in inode.c and the new direct-io.c
> file, and a couple functions from file.c (btrfs_buffered_write() and
> btrfs_write_check()) because they are used both in file.c and in the new
> direct-io.c file.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/Makefile      |    2 +-
>   fs/btrfs/btrfs_inode.h |    9 +-
>   fs/btrfs/direct-io.c   | 1052 ++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/direct-io.h   |   14 +
>   fs/btrfs/file.c        |  287 +----------
>   fs/btrfs/file.h        |    2 +
>   fs/btrfs/inode.c       |  784 +-----------------------------
>   fs/btrfs/super.c       |    4 +
>   8 files changed, 1095 insertions(+), 1059 deletions(-)
>   create mode 100644 fs/btrfs/direct-io.c
>   create mode 100644 fs/btrfs/direct-io.h
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 50b19d15e956..87617f2968bc 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -33,7 +33,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \
>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o =
\
>   	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>   	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
> -	   lru_cache.o raid-stripe-tree.o fiemap.o
> +	   lru_cache.o raid-stripe-tree.o fiemap.o direct-io.o
>
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>   btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) +=3D ref-verify.o
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b0fe610d5940..b33f147f2780 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -610,10 +610,6 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, stru=
ct iov_iter *iter,
>   ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *fr=
om,
>   			       const struct btrfs_ioctl_encoded_io_args *encoded);
>
> -ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
> -		       size_t done_before);
> -struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *=
iter,
> -				  size_t done_before);
>   struct btrfs_inode *btrfs_find_first_inode(struct btrfs_root *root, u6=
4 min_ino);
>
>   extern const struct dentry_operations btrfs_dentry_operations;
> @@ -630,5 +626,10 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, =
unsigned int ilock_flags);
>   void btrfs_update_inode_bytes(struct btrfs_inode *inode, const u64 add=
_bytes,
>   			      const u64 del_bytes);
>   void btrfs_assert_inode_range_clean(struct btrfs_inode *inode, u64 sta=
rt, u64 end);
> +u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 sta=
rt,
> +				     u64 num_bytes);
> +struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 st=
art,
> +				      const struct btrfs_file_extent *file_extent,
> +				      int type);
>
>   #endif
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> new file mode 100644
> index 000000000000..f9fb2db6a1e4
> --- /dev/null
> +++ b/fs/btrfs/direct-io.c
> @@ -0,0 +1,1052 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/fsverity.h>
> +#include <linux/iomap.h>
> +#include "ctree.h"
> +#include "delalloc-space.h"
> +#include "direct-io.h"
> +#include "extent-tree.h"
> +#include "file.h"
> +#include "fs.h"
> +#include "transaction.h"
> +#include "volumes.h"
> +
> +struct btrfs_dio_data {
> +	ssize_t submitted;
> +	struct extent_changeset *data_reserved;
> +	struct btrfs_ordered_extent *ordered;
> +	bool data_space_reserved;
> +	bool nocow_done;
> +};
> +
> +struct btrfs_dio_private {
> +	/* Range of I/O */
> +	u64 file_offset;
> +	u32 bytes;
> +
> +	/* This must be last */
> +	struct btrfs_bio bbio;
> +};
> +
> +static struct bio_set btrfs_dio_bioset;
> +
> +static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 l=
ockend,
> +			      struct extent_state **cached_state,
> +			      unsigned int iomap_flags)
> +{
> +	const bool writing =3D (iomap_flags & IOMAP_WRITE);
> +	const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> +	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> +	struct btrfs_ordered_extent *ordered;
> +	int ret =3D 0;
> +
> +	while (1) {
> +		if (nowait) {
> +			if (!try_lock_extent(io_tree, lockstart, lockend,
> +					     cached_state))
> +				return -EAGAIN;
> +		} else {
> +			lock_extent(io_tree, lockstart, lockend, cached_state);
> +		}
> +		/*
> +		 * We're concerned with the entire range that we're going to be
> +		 * doing DIO to, so we need to make sure there's no ordered
> +		 * extents in this range.
> +		 */
> +		ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), lockstart,
> +						     lockend - lockstart + 1);
> +
> +		/*
> +		 * We need to make sure there are no buffered pages in this
> +		 * range either, we could have raced between the invalidate in
> +		 * generic_file_direct_write and locking the extent.  The
> +		 * invalidate needs to happen so that reads after a write do not
> +		 * get stale data.
> +		 */
> +		if (!ordered &&
> +		    (!writing || !filemap_range_has_page(inode->i_mapping,
> +							 lockstart, lockend)))
> +			break;
> +
> +		unlock_extent(io_tree, lockstart, lockend, cached_state);
> +
> +		if (ordered) {
> +			if (nowait) {
> +				btrfs_put_ordered_extent(ordered);
> +				ret =3D -EAGAIN;
> +				break;
> +			}
> +			/*
> +			 * If we are doing a DIO read and the ordered extent we
> +			 * found is for a buffered write, we can not wait for it
> +			 * to complete and retry, because if we do so we can
> +			 * deadlock with concurrent buffered writes on page
> +			 * locks. This happens only if our DIO read covers more
> +			 * than one extent map, if at this point has already
> +			 * created an ordered extent for a previous extent map
> +			 * and locked its range in the inode's io tree, and a
> +			 * concurrent write against that previous extent map's
> +			 * range and this range started (we unlock the ranges
> +			 * in the io tree only when the bios complete and
> +			 * buffered writes always lock pages before attempting
> +			 * to lock range in the io tree).
> +			 */
> +			if (writing ||
> +			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
> +				btrfs_start_ordered_extent(ordered);
> +			else
> +				ret =3D nowait ? -EAGAIN : -ENOTBLK;
> +			btrfs_put_ordered_extent(ordered);
> +		} else {
> +			/*
> +			 * We could trigger writeback for this range (and wait
> +			 * for it to complete) and then invalidate the pages for
> +			 * this range (through invalidate_inode_pages2_range()),
> +			 * but that can lead us to a deadlock with a concurrent
> +			 * call to readahead (a buffered read or a defrag call
> +			 * triggered a readahead) on a page lock due to an
> +			 * ordered dio extent we created before but did not have
> +			 * yet a corresponding bio submitted (whence it can not
> +			 * complete), which makes readahead wait for that
> +			 * ordered extent to complete while holding a lock on
> +			 * that page.
> +			 */
> +			ret =3D nowait ? -EAGAIN : -ENOTBLK;
> +		}
> +
> +		if (ret)
> +			break;
> +
> +		cond_resched();
> +	}
> +
> +	return ret;
> +}
> +
> +static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *i=
node,
> +						  struct btrfs_dio_data *dio_data,
> +						  const u64 start,
> +						  const struct btrfs_file_extent *file_extent,
> +						  const int type)
> +{
> +	struct extent_map *em =3D NULL;
> +	struct btrfs_ordered_extent *ordered;
> +
> +	if (type !=3D BTRFS_ORDERED_NOCOW) {
> +		em =3D btrfs_create_io_em(inode, start, file_extent, type);
> +		if (IS_ERR(em))
> +			goto out;
> +	}
> +
> +	ordered =3D btrfs_alloc_ordered_extent(inode, start, file_extent,
> +					     (1 << type) |
> +					     (1 << BTRFS_ORDERED_DIRECT));
> +	if (IS_ERR(ordered)) {
> +		if (em) {
> +			free_extent_map(em);
> +			btrfs_drop_extent_map_range(inode, start,
> +					start + file_extent->num_bytes - 1, false);
> +		}
> +		em =3D ERR_CAST(ordered);
> +	} else {
> +		ASSERT(!dio_data->ordered);
> +		dio_data->ordered =3D ordered;
> +	}
> + out:
> +
> +	return em;
> +}
> +
> +static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *i=
node,
> +						  struct btrfs_dio_data *dio_data,
> +						  u64 start, u64 len)
> +{
> +	struct btrfs_root *root =3D inode->root;
> +	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_file_extent file_extent;
> +	struct extent_map *em;
> +	struct btrfs_key ins;
> +	u64 alloc_hint;
> +	int ret;
> +
> +	alloc_hint =3D btrfs_get_extent_allocation_hint(inode, start, len);
> +again:
> +	ret =3D btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
> +				   0, alloc_hint, &ins, 1, 1);
> +	if (ret =3D=3D -EAGAIN) {
> +		ASSERT(btrfs_is_zoned(fs_info));
> +		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINIS=
H,
> +			       TASK_UNINTERRUPTIBLE);
> +		goto again;
> +	}
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	file_extent.disk_bytenr =3D ins.objectid;
> +	file_extent.disk_num_bytes =3D ins.offset;
> +	file_extent.num_bytes =3D ins.offset;
> +	file_extent.ram_bytes =3D ins.offset;
> +	file_extent.offset =3D 0;
> +	file_extent.compression =3D BTRFS_COMPRESS_NONE;
> +	em =3D btrfs_create_dio_extent(inode, dio_data, start, &file_extent,
> +				     BTRFS_ORDERED_REGULAR);
> +	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> +	if (IS_ERR(em))
> +		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
> +					   1);
> +
> +	return em;
> +}
> +
> +static int btrfs_get_blocks_direct_write(struct extent_map **map,
> +					 struct inode *inode,
> +					 struct btrfs_dio_data *dio_data,
> +					 u64 start, u64 *lenp,
> +					 unsigned int iomap_flags)
> +{
> +	const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> +	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +	struct btrfs_file_extent file_extent;
> +	struct extent_map *em =3D *map;
> +	int type;
> +	u64 block_start;
> +	struct btrfs_block_group *bg;
> +	bool can_nocow =3D false;
> +	bool space_reserved =3D false;
> +	u64 len =3D *lenp;
> +	u64 prev_len;
> +	int ret =3D 0;
> +
> +	/*
> +	 * We don't allocate a new extent in the following cases
> +	 *
> +	 * 1) The inode is marked as NODATACOW. In this case we'll just use th=
e
> +	 * existing extent.
> +	 * 2) The extent is marked as PREALLOC. We're good to go here and can
> +	 * just use the extent.
> +	 *
> +	 */
> +	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
> +	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
> +	     em->disk_bytenr !=3D EXTENT_MAP_HOLE)) {
> +		if (em->flags & EXTENT_FLAG_PREALLOC)
> +			type =3D BTRFS_ORDERED_PREALLOC;
> +		else
> +			type =3D BTRFS_ORDERED_NOCOW;
> +		len =3D min(len, em->len - (start - em->start));
> +		block_start =3D extent_map_block_start(em) + (start - em->start);
> +
> +		if (can_nocow_extent(inode, start, &len,
> +				     &file_extent, false, false) =3D=3D 1) {
> +			bg =3D btrfs_inc_nocow_writers(fs_info, block_start);
> +			if (bg)
> +				can_nocow =3D true;
> +		}
> +	}
> +
> +	prev_len =3D len;
> +	if (can_nocow) {
> +		struct extent_map *em2;
> +
> +		/* We can NOCOW, so only need to reserve metadata space. */
> +		ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
> +						      nowait);
> +		if (ret < 0) {
> +			/* Our caller expects us to free the input extent map. */
> +			free_extent_map(em);
> +			*map =3D NULL;
> +			btrfs_dec_nocow_writers(bg);
> +			if (nowait && (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT))
> +				ret =3D -EAGAIN;
> +			goto out;
> +		}
> +		space_reserved =3D true;
> +
> +		em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
> +					      &file_extent, type);
> +		btrfs_dec_nocow_writers(bg);
> +		if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
> +			free_extent_map(em);
> +			*map =3D em2;
> +			em =3D em2;
> +		}
> +
> +		if (IS_ERR(em2)) {
> +			ret =3D PTR_ERR(em2);
> +			goto out;
> +		}
> +
> +		dio_data->nocow_done =3D true;
> +	} else {
> +		/* Our caller expects us to free the input extent map. */
> +		free_extent_map(em);
> +		*map =3D NULL;
> +
> +		if (nowait) {
> +			ret =3D -EAGAIN;
> +			goto out;
> +		}
> +
> +		/*
> +		 * If we could not allocate data space before locking the file
> +		 * range and we can't do a NOCOW write, then we have to fail.
> +		 */
> +		if (!dio_data->data_space_reserved) {
> +			ret =3D -ENOSPC;
> +			goto out;
> +		}
> +
> +		/*
> +		 * We have to COW and we have already reserved data space before,
> +		 * so now we reserve only metadata.
> +		 */
> +		ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
> +						      false);
> +		if (ret < 0)
> +			goto out;
> +		space_reserved =3D true;
> +
> +		em =3D btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
> +		if (IS_ERR(em)) {
> +			ret =3D PTR_ERR(em);
> +			goto out;
> +		}
> +		*map =3D em;
> +		len =3D min(len, em->len - (start - em->start));
> +		if (len < prev_len)
> +			btrfs_delalloc_release_metadata(BTRFS_I(inode),
> +							prev_len - len, true);
> +	}
> +
> +	/*
> +	 * We have created our ordered extent, so we can now release our reser=
vation
> +	 * for an outstanding extent.
> +	 */
> +	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
> +
> +	/*
> +	 * Need to update the i_size under the extent lock so buffered
> +	 * readers will get the updated i_size when we unlock.
> +	 */
> +	if (start + len > i_size_read(inode))
> +		i_size_write(inode, start + len);
> +out:
> +	if (ret && space_reserved) {
> +		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
> +		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
> +	}
> +	*lenp =3D len;
> +	return ret;
> +}
> +
> +static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> +		loff_t length, unsigned int flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	struct iomap_iter *iter =3D container_of(iomap, struct iomap_iter, iom=
ap);
> +	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +	struct extent_map *em;
> +	struct extent_state *cached_state =3D NULL;
> +	struct btrfs_dio_data *dio_data =3D iter->private;
> +	u64 lockstart, lockend;
> +	const bool write =3D !!(flags & IOMAP_WRITE);
> +	int ret =3D 0;
> +	u64 len =3D length;
> +	const u64 data_alloc_len =3D length;
> +	bool unlock_extents =3D false;
> +
> +	/*
> +	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> +	 * we're NOWAIT we may submit a bio for a partial range and return
> +	 * EIOCBQUEUED, which would result in an errant short read.
> +	 *
> +	 * The best way to handle this would be to allow for partial completio=
ns
> +	 * of iocb's, so we could submit the partial bio, return and fault in
> +	 * the rest of the pages, and then submit the io for the rest of the
> +	 * range.  However we don't have that currently, so simply return
> +	 * -EAGAIN at this point so that the normal path is used.
> +	 */
> +	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
> +		return -EAGAIN;
> +
> +	/*
> +	 * Cap the size of reads to that usually seen in buffered I/O as we ne=
ed
> +	 * to allocate a contiguous array for the checksums.
> +	 */
> +	if (!write)
> +		len =3D min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
> +
> +	lockstart =3D start;
> +	lockend =3D start + len - 1;
> +
> +	/*
> +	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn'=
t
> +	 * enough if we've written compressed pages to this area, so we need t=
o
> +	 * flush the dirty pages again to make absolutely sure that any
> +	 * outstanding dirty pages are on disk - the first flush only starts
> +	 * compression on the data, while keeping the pages locked, so by the
> +	 * time the second flush returns we know bios for the compressed pages
> +	 * were submitted and finished, and the pages no longer under writebac=
k.
> +	 *
> +	 * If we have a NOWAIT request and we have any pages in the range that
> +	 * are locked, likely due to compression still in progress, we don't w=
ant
> +	 * to block on page locks. We also don't want to block on pages marked=
 as
> +	 * dirty or under writeback (same as for the non-compression case).
> +	 * iomap_dio_rw() did the same check, but after that and before we got
> +	 * here, mmap'ed writes may have happened or buffered reads started
> +	 * (readpage() and readahead(), which lock pages), as we haven't locke=
d
> +	 * the file range yet.
> +	 */
> +	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> +		     &BTRFS_I(inode)->runtime_flags)) {
> +		if (flags & IOMAP_NOWAIT) {
> +			if (filemap_range_needs_writeback(inode->i_mapping,
> +							  lockstart, lockend))
> +				return -EAGAIN;
> +		} else {
> +			ret =3D filemap_fdatawrite_range(inode->i_mapping, start,
> +						       start + length - 1);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	memset(dio_data, 0, sizeof(*dio_data));
> +
> +	/*
> +	 * We always try to allocate data space and must do it before locking
> +	 * the file range, to avoid deadlocks with concurrent writes to the sa=
me
> +	 * range if the range has several extents and the writes don't expand =
the
> +	 * current i_size (the inode lock is taken in shared mode). If we fail=
 to
> +	 * allocate data space here we continue and later, after locking the
> +	 * file range, we fail with ENOSPC only if we figure out we can not do=
 a
> +	 * NOCOW write.
> +	 */
> +	if (write && !(flags & IOMAP_NOWAIT)) {
> +		ret =3D btrfs_check_data_free_space(BTRFS_I(inode),
> +						  &dio_data->data_reserved,
> +						  start, data_alloc_len, false);
> +		if (!ret)
> +			dio_data->data_space_reserved =3D true;
> +		else if (ret && !(BTRFS_I(inode)->flags &
> +				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
> +			goto err;
> +	}
> +
> +	/*
> +	 * If this errors out it's because we couldn't invalidate pagecache fo=
r
> +	 * this range and we need to fallback to buffered IO, or we are doing =
a
> +	 * NOWAIT read/write and we need to block.
> +	 */
> +	ret =3D lock_extent_direct(inode, lockstart, lockend, &cached_state, f=
lags);
> +	if (ret < 0)
> +		goto err;
> +
> +	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
> +	if (IS_ERR(em)) {
> +		ret =3D PTR_ERR(em);
> +		goto unlock_err;
> +	}
> +
> +	/*
> +	 * Ok for INLINE and COMPRESSED extents we need to fallback on buffere=
d
> +	 * io.  INLINE is special, and we could probably kludge it in here, bu=
t
> +	 * it's still buffered so for safety lets just fall back to the generi=
c
> +	 * buffered path.
> +	 *
> +	 * For COMPRESSED we _have_ to read the entire extent in so we can
> +	 * decompress it, so there will be buffering required no matter what w=
e
> +	 * do, so go ahead and fallback to buffered.
> +	 *
> +	 * We return -ENOTBLK because that's what makes DIO go ahead and go ba=
ck
> +	 * to buffered IO.  Don't blame me, this is the price we pay for using
> +	 * the generic code.
> +	 */
> +	if (extent_map_is_compressed(em) || em->disk_bytenr =3D=3D EXTENT_MAP_=
INLINE) {
> +		free_extent_map(em);
> +		/*
> +		 * If we are in a NOWAIT context, return -EAGAIN in order to
> +		 * fallback to buffered IO. This is not only because we can
> +		 * block with buffered IO (no support for NOWAIT semantics at
> +		 * the moment) but also to avoid returning short reads to user
> +		 * space - this happens if we were able to read some data from
> +		 * previous non-compressed extents and then when we fallback to
> +		 * buffered IO, at btrfs_file_read_iter() by calling
> +		 * filemap_read(), we fail to fault in pages for the read buffer,
> +		 * in which case filemap_read() returns a short read (the number
> +		 * of bytes previously read is > 0, so it does not return -EFAULT).
> +		 */
> +		ret =3D (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
> +		goto unlock_err;
> +	}
> +
> +	len =3D min(len, em->len - (start - em->start));
> +
> +	/*
> +	 * If we have a NOWAIT request and the range contains multiple extents
> +	 * (or a mix of extents and holes), then we return -EAGAIN to make the
> +	 * caller fallback to a context where it can do a blocking (without
> +	 * NOWAIT) request. This way we avoid doing partial IO and returning
> +	 * success to the caller, which is not optimal for writes and for read=
s
> +	 * it can result in unexpected behaviour for an application.
> +	 *
> +	 * When doing a read, because we use IOMAP_DIO_PARTIAL when calling
> +	 * iomap_dio_rw(), we can end up returning less data then what the cal=
ler
> +	 * asked for, resulting in an unexpected, and incorrect, short read.
> +	 * That is, the caller asked to read N bytes and we return less than t=
hat,
> +	 * which is wrong unless we are crossing EOF. This happens if we get a
> +	 * page fault error when trying to fault in pages for the buffer that =
is
> +	 * associated to the struct iov_iter passed to iomap_dio_rw(), and we
> +	 * have previously submitted bios for other extents in the range, in
> +	 * which case iomap_dio_rw() may return us EIOCBQUEUED if not all of
> +	 * those bios have completed by the time we get the page fault error,
> +	 * which we return back to our caller - we should only return EIOCBQUE=
UED
> +	 * after we have submitted bios for all the extents in the range.
> +	 */
> +	if ((flags & IOMAP_NOWAIT) && len < length) {
> +		free_extent_map(em);
> +		ret =3D -EAGAIN;
> +		goto unlock_err;
> +	}
> +
> +	if (write) {
> +		ret =3D btrfs_get_blocks_direct_write(&em, inode, dio_data,
> +						    start, &len, flags);
> +		if (ret < 0)
> +			goto unlock_err;
> +		unlock_extents =3D true;
> +		/* Recalc len in case the new em is smaller than requested */
> +		len =3D min(len, em->len - (start - em->start));
> +		if (dio_data->data_space_reserved) {
> +			u64 release_offset;
> +			u64 release_len =3D 0;
> +
> +			if (dio_data->nocow_done) {
> +				release_offset =3D start;
> +				release_len =3D data_alloc_len;
> +			} else if (len < data_alloc_len) {
> +				release_offset =3D start + len;
> +				release_len =3D data_alloc_len - len;
> +			}
> +
> +			if (release_len > 0)
> +				btrfs_free_reserved_data_space(BTRFS_I(inode),
> +							       dio_data->data_reserved,
> +							       release_offset,
> +							       release_len);
> +		}
> +	} else {
> +		/*
> +		 * We need to unlock only the end area that we aren't using.
> +		 * The rest is going to be unlocked by the endio routine.
> +		 */
> +		lockstart =3D start + len;
> +		if (lockstart < lockend)
> +			unlock_extents =3D true;
> +	}
> +
> +	if (unlock_extents)
> +		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> +			      &cached_state);
> +	else
> +		free_extent_state(cached_state);
> +
> +	/*
> +	 * Translate extent map information to iomap.
> +	 * We trim the extents (and move the addr) even though iomap code does
> +	 * that, since we have locked only the parts we are performing I/O in.
> +	 */
> +	if ((em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) ||
> +	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
> +		iomap->addr =3D IOMAP_NULL_ADDR;
> +		iomap->type =3D IOMAP_HOLE;
> +	} else {
> +		iomap->addr =3D extent_map_block_start(em) + (start - em->start);
> +		iomap->type =3D IOMAP_MAPPED;
> +	}
> +	iomap->offset =3D start;
> +	iomap->bdev =3D fs_info->fs_devices->latest_dev->bdev;
> +	iomap->length =3D len;
> +	free_extent_map(em);
> +
> +	return 0;
> +
> +unlock_err:
> +	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> +		      &cached_state);
> +err:
> +	if (dio_data->data_space_reserved) {
> +		btrfs_free_reserved_data_space(BTRFS_I(inode),
> +					       dio_data->data_reserved,
> +					       start, data_alloc_len);
> +		extent_changeset_free(dio_data->data_reserved);
> +	}
> +
> +	return ret;
> +}
> +
> +static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t =
length,
> +		ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +	struct iomap_iter *iter =3D container_of(iomap, struct iomap_iter, iom=
ap);
> +	struct btrfs_dio_data *dio_data =3D iter->private;
> +	size_t submitted =3D dio_data->submitted;
> +	const bool write =3D !!(flags & IOMAP_WRITE);
> +	int ret =3D 0;
> +
> +	if (!write && (iomap->type =3D=3D IOMAP_HOLE)) {
> +		/* If reading from a hole, unlock and return */
> +		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
> +			      NULL);
> +		return 0;
> +	}
> +
> +	if (submitted < length) {
> +		pos +=3D submitted;
> +		length -=3D submitted;
> +		if (write)
> +			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> +						    pos, length, false);
> +		else
> +			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
> +				      pos + length - 1, NULL);
> +		ret =3D -ENOTBLK;
> +	}
> +	if (write) {
> +		btrfs_put_ordered_extent(dio_data->ordered);
> +		dio_data->ordered =3D NULL;
> +	}
> +
> +	if (write)
> +		extent_changeset_free(dio_data->data_reserved);
> +	return ret;
> +}
> +
> +static void btrfs_dio_end_io(struct btrfs_bio *bbio)
> +{
> +	struct btrfs_dio_private *dip =3D
> +		container_of(bbio, struct btrfs_dio_private, bbio);
> +	struct btrfs_inode *inode =3D bbio->inode;
> +	struct bio *bio =3D &bbio->bio;
> +
> +	if (bio->bi_status) {
> +		btrfs_warn(inode->root->fs_info,
> +		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
> +			   btrfs_ino(inode), bio->bi_opf,
> +			   dip->file_offset, dip->bytes, bio->bi_status);
> +	}
> +
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> +		btrfs_finish_ordered_extent(bbio->ordered, NULL,
> +					    dip->file_offset, dip->bytes,
> +					    !bio->bi_status);
> +	} else {
> +		unlock_extent(&inode->io_tree, dip->file_offset,
> +			      dip->file_offset + dip->bytes - 1, NULL);
> +	}
> +
> +	bbio->bio.bi_private =3D bbio->private;
> +	iomap_dio_bio_end_io(bio);
> +}
> +
> +static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
> +					struct btrfs_ordered_extent *ordered)
> +{
> +	u64 start =3D (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +	u64 len =3D bbio->bio.bi_iter.bi_size;
> +	struct btrfs_ordered_extent *new;
> +	int ret;
> +
> +	/* Must always be called for the beginning of an ordered extent. */
> +	if (WARN_ON_ONCE(start !=3D ordered->disk_bytenr))
> +		return -EINVAL;
> +
> +	/* No need to split if the ordered extent covers the entire bio. */
> +	if (ordered->disk_num_bytes =3D=3D len) {
> +		refcount_inc(&ordered->refs);
> +		bbio->ordered =3D ordered;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Don't split the extent_map for NOCOW extents, as we're writing into
> +	 * a pre-existing one.
> +	 */
> +	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
> +		ret =3D split_extent_map(bbio->inode, bbio->file_offset,
> +				       ordered->num_bytes, len,
> +				       ordered->disk_bytenr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	new =3D btrfs_split_ordered_extent(ordered, len);
> +	if (IS_ERR(new))
> +		return PTR_ERR(new);
> +	bbio->ordered =3D new;
> +	return 0;
> +}
> +
> +static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct b=
io *bio,
> +				loff_t file_offset)
> +{
> +	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> +	struct btrfs_dio_private *dip =3D
> +		container_of(bbio, struct btrfs_dio_private, bbio);
> +	struct btrfs_dio_data *dio_data =3D iter->private;
> +
> +	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
> +		       btrfs_dio_end_io, bio->bi_private);
> +	bbio->inode =3D BTRFS_I(iter->inode);
> +	bbio->file_offset =3D file_offset;
> +
> +	dip->file_offset =3D file_offset;
> +	dip->bytes =3D bio->bi_iter.bi_size;
> +
> +	dio_data->submitted +=3D bio->bi_iter.bi_size;
> +
> +	/*
> +	 * Check if we are doing a partial write.  If we are, we need to split
> +	 * the ordered extent to match the submitted bio.  Hang on to the
> +	 * remaining unfinishable ordered_extent in dio_data so that it can be
> +	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
> +	 * remaining pages is blocked on the outstanding ordered extent.
> +	 */
> +	if (iter->flags & IOMAP_WRITE) {
> +		int ret;
> +
> +		ret =3D btrfs_extract_ordered_extent(bbio, dio_data->ordered);
> +		if (ret) {
> +			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> +						    file_offset, dip->bytes,
> +						    !ret);
> +			bio->bi_status =3D errno_to_blk_status(ret);
> +			iomap_dio_bio_end_io(bio);
> +			return;
> +		}
> +	}
> +
> +	btrfs_submit_bio(bbio, 0);
> +}
> +
> +static const struct iomap_ops btrfs_dio_iomap_ops =3D {
> +	.iomap_begin            =3D btrfs_dio_iomap_begin,
> +	.iomap_end              =3D btrfs_dio_iomap_end,
> +};
> +
> +static const struct iomap_dio_ops btrfs_dio_ops =3D {
> +	.submit_io		=3D btrfs_dio_submit_io,
> +	.bio_set		=3D &btrfs_dio_bioset,
> +};
> +
> +static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter=
,
> +			      size_t done_before)
> +{
> +	struct btrfs_dio_data data =3D { 0 };
> +
> +	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> +			    IOMAP_DIO_PARTIAL, &data, done_before);
> +}
> +
> +static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov=
_iter *iter,
> +					 size_t done_before)
> +{
> +	struct btrfs_dio_data data =3D { 0 };
> +
> +	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops=
,
> +			    IOMAP_DIO_PARTIAL, &data, done_before);
> +}
> +
> +static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
> +			       const struct iov_iter *iter, loff_t offset)
> +{
> +	const u32 blocksize_mask =3D fs_info->sectorsize - 1;
> +
> +	if (offset & blocksize_mask)
> +		return -EINVAL;
> +
> +	if (iov_iter_alignment(iter) & blocksize_mask)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file =3D iocb->ki_filp;
> +	struct inode *inode =3D file_inode(file);
> +	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> +	loff_t pos;
> +	ssize_t written =3D 0;
> +	ssize_t written_buffered;
> +	size_t prev_left =3D 0;
> +	loff_t endbyte;
> +	ssize_t ret;
> +	unsigned int ilock_flags =3D 0;
> +	struct iomap_dio *dio;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		ilock_flags |=3D BTRFS_ILOCK_TRY;
> +
> +	/*
> +	 * If the write DIO is within EOF, use a shared lock and also only if
> +	 * security bits will likely not be dropped by file_remove_privs() cal=
led
> +	 * from btrfs_write_check(). Either will need to be rechecked after th=
e
> +	 * lock was acquired.
> +	 */
> +	if (iocb->ki_pos + iov_iter_count(from) <=3D i_size_read(inode) && IS_=
NOSEC(inode))
> +		ilock_flags |=3D BTRFS_ILOCK_SHARED;
> +
> +relock:
> +	ret =3D btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Shared lock cannot be used with security bits set. */
> +	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
> +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		ilock_flags &=3D ~BTRFS_ILOCK_SHARED;
> +		goto relock;
> +	}
> +
> +	ret =3D generic_write_checks(iocb, from);
> +	if (ret <=3D 0) {
> +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		return ret;
> +	}
> +
> +	ret =3D btrfs_write_check(iocb, from, ret);
> +	if (ret < 0) {
> +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		goto out;
> +	}
> +
> +	pos =3D iocb->ki_pos;
> +	/*
> +	 * Re-check since file size may have changed just before taking the
> +	 * lock or pos may have changed because of O_APPEND in generic_write_c=
heck()
> +	 */
> +	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
> +	    pos + iov_iter_count(from) > i_size_read(inode)) {
> +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		ilock_flags &=3D ~BTRFS_ILOCK_SHARED;
> +		goto relock;
> +	}
> +
> +	if (check_direct_IO(fs_info, from, pos)) {
> +		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +		goto buffered;
> +	}
> +
> +	/*
> +	 * The iov_iter can be mapped to the same file range we are writing to=
.
> +	 * If that's the case, then we will deadlock in the iomap code, becaus=
e
> +	 * it first calls our callback btrfs_dio_iomap_begin(), which will cre=
ate
> +	 * an ordered extent, and after that it will fault in the pages that t=
he
> +	 * iov_iter refers to. During the fault in we end up in the readahead
> +	 * pages code (starting at btrfs_readahead()), which will lock the ran=
ge,
> +	 * find that ordered extent and then wait for it to complete (at
> +	 * btrfs_lock_and_flush_ordered_range()), resulting in a deadlock sinc=
e
> +	 * obviously the ordered extent can never complete as we didn't submit
> +	 * yet the respective bio(s). This always happens when the buffer is
> +	 * memory mapped to the same file range, since the iomap DIO code alwa=
ys
> +	 * invalidates pages in the target file range (after starting and wait=
ing
> +	 * for any writeback).
> +	 *
> +	 * So here we disable page faults in the iov_iter and then retry if we
> +	 * got -EFAULT, faulting in the pages before the retry.
> +	 */
> +	from->nofault =3D true;
> +	dio =3D btrfs_dio_write(iocb, from, written);
> +	from->nofault =3D false;
> +
> +	/*
> +	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
> +	 * iocb, and that needs to lock the inode. So unlock it before calling
> +	 * iomap_dio_complete() to avoid a deadlock.
> +	 */
> +	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> +
> +	if (IS_ERR_OR_NULL(dio))
> +		ret =3D PTR_ERR_OR_ZERO(dio);
> +	else
> +		ret =3D iomap_dio_complete(dio);
> +
> +	/* No increment (+=3D) because iomap returns a cumulative value. */
> +	if (ret > 0)
> +		written =3D ret;
> +
> +	if (iov_iter_count(from) > 0 && (ret =3D=3D -EFAULT || ret > 0)) {
> +		const size_t left =3D iov_iter_count(from);
> +		/*
> +		 * We have more data left to write. Try to fault in as many as
> +		 * possible of the remainder pages and retry. We do this without
> +		 * releasing and locking again the inode, to prevent races with
> +		 * truncate.
> +		 *
> +		 * Also, in case the iov refers to pages in the file range of the
> +		 * file we want to write to (due to a mmap), we could enter an
> +		 * infinite loop if we retry after faulting the pages in, since
> +		 * iomap will invalidate any pages in the range early on, before
> +		 * it tries to fault in the pages of the iov. So we keep track of
> +		 * how much was left of iov in the previous EFAULT and fallback
> +		 * to buffered IO in case we haven't made any progress.
> +		 */
> +		if (left =3D=3D prev_left) {
> +			ret =3D -ENOTBLK;
> +		} else {
> +			fault_in_iov_iter_readable(from, left);
> +			prev_left =3D left;
> +			goto relock;
> +		}
> +	}
> +
> +	/*
> +	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
> +	 * we must fallback to buffered IO.
> +	 */
> +	if ((ret < 0 && ret !=3D -ENOTBLK) || !iov_iter_count(from))
> +		goto out;
> +
> +buffered:
> +	/*
> +	 * If we are in a NOWAIT context, then return -EAGAIN to signal the ca=
ller
> +	 * it must retry the operation in a context where blocking is acceptab=
le,
> +	 * because even if we end up not blocking during the buffered IO attem=
pt
> +	 * below, we will block when flushing and waiting for the IO.
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> +
> +	pos =3D iocb->ki_pos;
> +	written_buffered =3D btrfs_buffered_write(iocb, from);
> +	if (written_buffered < 0) {
> +		ret =3D written_buffered;
> +		goto out;
> +	}
> +	/*
> +	 * Ensure all data is persisted. We want the next direct IO read to be
> +	 * able to read what was just written.
> +	 */
> +	endbyte =3D pos + written_buffered - 1;
> +	ret =3D btrfs_fdatawrite_range(BTRFS_I(inode), pos, endbyte);
> +	if (ret)
> +		goto out;
> +	ret =3D filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
> +	if (ret)
> +		goto out;
> +	written +=3D written_buffered;
> +	iocb->ki_pos =3D pos + written_buffered;
> +	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
> +				 endbyte >> PAGE_SHIFT);
> +out:
> +	return ret < 0 ? ret : written;
> +}
> +
> +static int check_direct_read(struct btrfs_fs_info *fs_info,
> +			     const struct iov_iter *iter, loff_t offset)
> +{
> +	int ret;
> +	int i, seg;
> +
> +	ret =3D check_direct_IO(fs_info, iter, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!iter_is_iovec(iter))
> +		return 0;
> +
> +	for (seg =3D 0; seg < iter->nr_segs; seg++) {
> +		for (i =3D seg + 1; i < iter->nr_segs; i++) {
> +			const struct iovec *iov1 =3D iter_iov(iter) + seg;
> +			const struct iovec *iov2 =3D iter_iov(iter) + i;
> +
> +			if (iov1->iov_base =3D=3D iov2->iov_base)
> +				return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode =3D file_inode(iocb->ki_filp);
> +	size_t prev_left =3D 0;
> +	ssize_t read =3D 0;
> +	ssize_t ret;
> +
> +	if (fsverity_active(inode))
> +		return 0;
> +
> +	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
> +		return 0;
> +
> +	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
> +again:
> +	/*
> +	 * This is similar to what we do for direct IO writes, see the comment
> +	 * at btrfs_direct_write(), but we also disable page faults in additio=
n
> +	 * to disabling them only at the iov_iter level. This is because when
> +	 * reading from a hole or prealloc extent, iomap calls iov_iter_zero()=
,
> +	 * which can still trigger page fault ins despite having set ->nofault
> +	 * to true of our 'to' iov_iter.
> +	 *
> +	 * The difference to direct IO writes is that we deadlock when trying
> +	 * to lock the extent range in the inode's tree during he page reads
> +	 * triggered by the fault in (while for writes it is due to waiting fo=
r
> +	 * our own ordered extent). This is because for direct IO reads,
> +	 * btrfs_dio_iomap_begin() returns with the extent range locked, which
> +	 * is only unlocked in the endio callback (end_bio_extent_readpage()).
> +	 */
> +	pagefault_disable();
> +	to->nofault =3D true;
> +	ret =3D btrfs_dio_read(iocb, to, read);
> +	to->nofault =3D false;
> +	pagefault_enable();
> +
> +	/* No increment (+=3D) because iomap returns a cumulative value. */
> +	if (ret > 0)
> +		read =3D ret;
> +
> +	if (iov_iter_count(to) > 0 && (ret =3D=3D -EFAULT || ret > 0)) {
> +		const size_t left =3D iov_iter_count(to);
> +
> +		if (left =3D=3D prev_left) {
> +			/*
> +			 * We didn't make any progress since the last attempt,
> +			 * fallback to a buffered read for the remainder of the
> +			 * range. This is just to avoid any possibility of looping
> +			 * for too long.
> +			 */
> +			ret =3D read;
> +		} else {
> +			/*
> +			 * We made some progress since the last retry or this is
> +			 * the first time we are retrying. Fault in as many pages
> +			 * as possible and retry.
> +			 */
> +			fault_in_iov_iter_writeable(to, left);
> +			prev_left =3D left;
> +			goto again;
> +		}
> +	}
> +	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
> +	return ret < 0 ? ret : read;
> +}
> +
> +int __init btrfs_init_dio(void)
> +{
> +	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
> +			offsetof(struct btrfs_dio_private, bbio.bio),
> +			BIOSET_NEED_BVECS))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void __cold btrfs_destroy_dio(void)
> +{
> +	bioset_exit(&btrfs_dio_bioset);
> +}
> diff --git a/fs/btrfs/direct-io.h b/fs/btrfs/direct-io.h
> new file mode 100644
> index 000000000000..3dc3ea926afe
> --- /dev/null
> +++ b/fs/btrfs/direct-io.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_DIRECT_IO_H
> +#define BTRFS_DIRECT_IO_H
> +
> +#include <linux/types.h>
> +
> +int __init btrfs_init_dio(void);
> +void __cold btrfs_destroy_dio(void);
> +
> +ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from);
> +ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to);
> +
> +#endif /* BTRFS_DIRECT_IO_H */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5834d452677f..21381de906f6 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -17,8 +17,8 @@
>   #include <linux/uio.h>
>   #include <linux/iversion.h>
>   #include <linux/fsverity.h>
> -#include <linux/iomap.h>
>   #include "ctree.h"
> +#include "direct-io.h"
>   #include "disk-io.h"
>   #include "transaction.h"
>   #include "btrfs_inode.h"
> @@ -1140,8 +1140,7 @@ static void update_time_for_write(struct inode *in=
ode)
>   		inode_inc_iversion(inode);
>   }
>
> -static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
> -			     size_t count)
> +int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t=
 count)
>   {
>   	struct file *file =3D iocb->ki_filp;
>   	struct inode *inode =3D file_inode(file);
> @@ -1187,8 +1186,7 @@ static int btrfs_write_check(struct kiocb *iocb, s=
truct iov_iter *from,
>   	return 0;
>   }
>
> -static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
> -					       struct iov_iter *i)
> +ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
>   {
>   	struct file *file =3D iocb->ki_filp;
>   	loff_t pos;
> @@ -1451,194 +1449,6 @@ static noinline ssize_t btrfs_buffered_write(str=
uct kiocb *iocb,
>   	return num_written ? num_written : ret;
>   }
>
> -static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
> -			       const struct iov_iter *iter, loff_t offset)
> -{
> -	const u32 blocksize_mask =3D fs_info->sectorsize - 1;
> -
> -	if (offset & blocksize_mask)
> -		return -EINVAL;
> -
> -	if (iov_iter_alignment(iter) & blocksize_mask)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *=
from)
> -{
> -	struct file *file =3D iocb->ki_filp;
> -	struct inode *inode =3D file_inode(file);
> -	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> -	loff_t pos;
> -	ssize_t written =3D 0;
> -	ssize_t written_buffered;
> -	size_t prev_left =3D 0;
> -	loff_t endbyte;
> -	ssize_t ret;
> -	unsigned int ilock_flags =3D 0;
> -	struct iomap_dio *dio;
> -
> -	if (iocb->ki_flags & IOCB_NOWAIT)
> -		ilock_flags |=3D BTRFS_ILOCK_TRY;
> -
> -	/*
> -	 * If the write DIO is within EOF, use a shared lock and also only if
> -	 * security bits will likely not be dropped by file_remove_privs() cal=
led
> -	 * from btrfs_write_check(). Either will need to be rechecked after th=
e
> -	 * lock was acquired.
> -	 */
> -	if (iocb->ki_pos + iov_iter_count(from) <=3D i_size_read(inode) && IS_=
NOSEC(inode))
> -		ilock_flags |=3D BTRFS_ILOCK_SHARED;
> -
> -relock:
> -	ret =3D btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Shared lock cannot be used with security bits set. */
> -	if ((ilock_flags & BTRFS_ILOCK_SHARED) && !IS_NOSEC(inode)) {
> -		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -		ilock_flags &=3D ~BTRFS_ILOCK_SHARED;
> -		goto relock;
> -	}
> -
> -	ret =3D generic_write_checks(iocb, from);
> -	if (ret <=3D 0) {
> -		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -		return ret;
> -	}
> -
> -	ret =3D btrfs_write_check(iocb, from, ret);
> -	if (ret < 0) {
> -		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -		goto out;
> -	}
> -
> -	pos =3D iocb->ki_pos;
> -	/*
> -	 * Re-check since file size may have changed just before taking the
> -	 * lock or pos may have changed because of O_APPEND in generic_write_c=
heck()
> -	 */
> -	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
> -	    pos + iov_iter_count(from) > i_size_read(inode)) {
> -		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -		ilock_flags &=3D ~BTRFS_ILOCK_SHARED;
> -		goto relock;
> -	}
> -
> -	if (check_direct_IO(fs_info, from, pos)) {
> -		btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -		goto buffered;
> -	}
> -
> -	/*
> -	 * The iov_iter can be mapped to the same file range we are writing to=
.
> -	 * If that's the case, then we will deadlock in the iomap code, becaus=
e
> -	 * it first calls our callback btrfs_dio_iomap_begin(), which will cre=
ate
> -	 * an ordered extent, and after that it will fault in the pages that t=
he
> -	 * iov_iter refers to. During the fault in we end up in the readahead
> -	 * pages code (starting at btrfs_readahead()), which will lock the ran=
ge,
> -	 * find that ordered extent and then wait for it to complete (at
> -	 * btrfs_lock_and_flush_ordered_range()), resulting in a deadlock sinc=
e
> -	 * obviously the ordered extent can never complete as we didn't submit
> -	 * yet the respective bio(s). This always happens when the buffer is
> -	 * memory mapped to the same file range, since the iomap DIO code alwa=
ys
> -	 * invalidates pages in the target file range (after starting and wait=
ing
> -	 * for any writeback).
> -	 *
> -	 * So here we disable page faults in the iov_iter and then retry if we
> -	 * got -EFAULT, faulting in the pages before the retry.
> -	 */
> -	from->nofault =3D true;
> -	dio =3D btrfs_dio_write(iocb, from, written);
> -	from->nofault =3D false;
> -
> -	/*
> -	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
> -	 * iocb, and that needs to lock the inode. So unlock it before calling
> -	 * iomap_dio_complete() to avoid a deadlock.
> -	 */
> -	btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
> -
> -	if (IS_ERR_OR_NULL(dio))
> -		ret =3D PTR_ERR_OR_ZERO(dio);
> -	else
> -		ret =3D iomap_dio_complete(dio);
> -
> -	/* No increment (+=3D) because iomap returns a cumulative value. */
> -	if (ret > 0)
> -		written =3D ret;
> -
> -	if (iov_iter_count(from) > 0 && (ret =3D=3D -EFAULT || ret > 0)) {
> -		const size_t left =3D iov_iter_count(from);
> -		/*
> -		 * We have more data left to write. Try to fault in as many as
> -		 * possible of the remainder pages and retry. We do this without
> -		 * releasing and locking again the inode, to prevent races with
> -		 * truncate.
> -		 *
> -		 * Also, in case the iov refers to pages in the file range of the
> -		 * file we want to write to (due to a mmap), we could enter an
> -		 * infinite loop if we retry after faulting the pages in, since
> -		 * iomap will invalidate any pages in the range early on, before
> -		 * it tries to fault in the pages of the iov. So we keep track of
> -		 * how much was left of iov in the previous EFAULT and fallback
> -		 * to buffered IO in case we haven't made any progress.
> -		 */
> -		if (left =3D=3D prev_left) {
> -			ret =3D -ENOTBLK;
> -		} else {
> -			fault_in_iov_iter_readable(from, left);
> -			prev_left =3D left;
> -			goto relock;
> -		}
> -	}
> -
> -	/*
> -	 * If 'ret' is -ENOTBLK or we have not written all data, then it means
> -	 * we must fallback to buffered IO.
> -	 */
> -	if ((ret < 0 && ret !=3D -ENOTBLK) || !iov_iter_count(from))
> -		goto out;
> -
> -buffered:
> -	/*
> -	 * If we are in a NOWAIT context, then return -EAGAIN to signal the ca=
ller
> -	 * it must retry the operation in a context where blocking is acceptab=
le,
> -	 * because even if we end up not blocking during the buffered IO attem=
pt
> -	 * below, we will block when flushing and waiting for the IO.
> -	 */
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		ret =3D -EAGAIN;
> -		goto out;
> -	}
> -
> -	pos =3D iocb->ki_pos;
> -	written_buffered =3D btrfs_buffered_write(iocb, from);
> -	if (written_buffered < 0) {
> -		ret =3D written_buffered;
> -		goto out;
> -	}
> -	/*
> -	 * Ensure all data is persisted. We want the next direct IO read to be
> -	 * able to read what was just written.
> -	 */
> -	endbyte =3D pos + written_buffered - 1;
> -	ret =3D btrfs_fdatawrite_range(BTRFS_I(inode), pos, endbyte);
> -	if (ret)
> -		goto out;
> -	ret =3D filemap_fdatawait_range(inode->i_mapping, pos, endbyte);
> -	if (ret)
> -		goto out;
> -	written +=3D written_buffered;
> -	iocb->ki_pos =3D pos + written_buffered;
> -	invalidate_mapping_pages(file->f_mapping, pos >> PAGE_SHIFT,
> -				 endbyte >> PAGE_SHIFT);
> -out:
> -	return ret < 0 ? ret : written;
> -}
> -
>   static ssize_t btrfs_encoded_write(struct kiocb *iocb, struct iov_iter=
 *from,
>   			const struct btrfs_ioctl_encoded_io_args *encoded)
>   {
> @@ -3914,97 +3724,6 @@ static int btrfs_file_open(struct inode *inode, s=
truct file *filp)
>   	return generic_file_open(inode, filp);
>   }
>
> -static int check_direct_read(struct btrfs_fs_info *fs_info,
> -			     const struct iov_iter *iter, loff_t offset)
> -{
> -	int ret;
> -	int i, seg;
> -
> -	ret =3D check_direct_IO(fs_info, iter, offset);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (!iter_is_iovec(iter))
> -		return 0;
> -
> -	for (seg =3D 0; seg < iter->nr_segs; seg++) {
> -		for (i =3D seg + 1; i < iter->nr_segs; i++) {
> -			const struct iovec *iov1 =3D iter_iov(iter) + seg;
> -			const struct iovec *iov2 =3D iter_iov(iter) + i;
> -
> -			if (iov1->iov_base =3D=3D iov2->iov_base)
> -				return -EINVAL;
> -		}
> -	}
> -	return 0;
> -}
> -
> -static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *t=
o)
> -{
> -	struct inode *inode =3D file_inode(iocb->ki_filp);
> -	size_t prev_left =3D 0;
> -	ssize_t read =3D 0;
> -	ssize_t ret;
> -
> -	if (fsverity_active(inode))
> -		return 0;
> -
> -	if (check_direct_read(inode_to_fs_info(inode), to, iocb->ki_pos))
> -		return 0;
> -
> -	btrfs_inode_lock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
> -again:
> -	/*
> -	 * This is similar to what we do for direct IO writes, see the comment
> -	 * at btrfs_direct_write(), but we also disable page faults in additio=
n
> -	 * to disabling them only at the iov_iter level. This is because when
> -	 * reading from a hole or prealloc extent, iomap calls iov_iter_zero()=
,
> -	 * which can still trigger page fault ins despite having set ->nofault
> -	 * to true of our 'to' iov_iter.
> -	 *
> -	 * The difference to direct IO writes is that we deadlock when trying
> -	 * to lock the extent range in the inode's tree during he page reads
> -	 * triggered by the fault in (while for writes it is due to waiting fo=
r
> -	 * our own ordered extent). This is because for direct IO reads,
> -	 * btrfs_dio_iomap_begin() returns with the extent range locked, which
> -	 * is only unlocked in the endio callback (end_bio_extent_readpage()).
> -	 */
> -	pagefault_disable();
> -	to->nofault =3D true;
> -	ret =3D btrfs_dio_read(iocb, to, read);
> -	to->nofault =3D false;
> -	pagefault_enable();
> -
> -	/* No increment (+=3D) because iomap returns a cumulative value. */
> -	if (ret > 0)
> -		read =3D ret;
> -
> -	if (iov_iter_count(to) > 0 && (ret =3D=3D -EFAULT || ret > 0)) {
> -		const size_t left =3D iov_iter_count(to);
> -
> -		if (left =3D=3D prev_left) {
> -			/*
> -			 * We didn't make any progress since the last attempt,
> -			 * fallback to a buffered read for the remainder of the
> -			 * range. This is just to avoid any possibility of looping
> -			 * for too long.
> -			 */
> -			ret =3D read;
> -		} else {
> -			/*
> -			 * We made some progress since the last retry or this is
> -			 * the first time we are retrying. Fault in as many pages
> -			 * as possible and retry.
> -			 */
> -			fault_in_iov_iter_writeable(to, left);
> -			prev_left =3D left;
> -			goto again;
> -		}
> -	}
> -	btrfs_inode_unlock(BTRFS_I(inode), BTRFS_ILOCK_SHARED);
> -	return ret < 0 ? ret : read;
> -}
> -
>   static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_ite=
r *to)
>   {
>   	ssize_t ret =3D 0;
> diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
> index ce93ed7083ab..912254e653cf 100644
> --- a/fs/btrfs/file.h
> +++ b/fs/btrfs/file.h
> @@ -44,5 +44,7 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inod=
e);
>   bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start=
, u64 end,
>   				  struct extent_state **cached_state,
>   				  u64 *delalloc_start_ret, u64 *delalloc_end_ret);
> +int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from, size_t=
 count);
> +ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i);
>
>   #endif
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d6c43120c5d3..41a3e3e73623 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -77,25 +77,6 @@ struct btrfs_iget_args {
>   	struct btrfs_root *root;
>   };
>
> -struct btrfs_dio_data {
> -	ssize_t submitted;
> -	struct extent_changeset *data_reserved;
> -	struct btrfs_ordered_extent *ordered;
> -	bool data_space_reserved;
> -	bool nocow_done;
> -};
> -
> -struct btrfs_dio_private {
> -	/* Range of I/O */
> -	u64 file_offset;
> -	u32 bytes;
> -
> -	/* This must be last */
> -	struct btrfs_bio bbio;
> -};
> -
> -static struct bio_set btrfs_dio_bioset;
> -
>   struct btrfs_rename_ctx {
>   	/* Output field. Stores the index number of the old directory entry. =
*/
>   	u64 index;
> @@ -138,9 +119,6 @@ static noinline int run_delalloc_cow(struct btrfs_in=
ode *inode,
>   				     struct page *locked_page, u64 start,
>   				     u64 end, struct writeback_control *wbc,
>   				     bool pages_dirty);
> -static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 s=
tart,
> -				       const struct btrfs_file_extent *file_extent,
> -				       int type);
>
>   static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 nu=
m_bytes,
>   					  u64 root, void *warn_ctx)
> @@ -1205,7 +1183,7 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>   	file_extent.offset =3D 0;
>   	file_extent.compression =3D async_extent->compress_type;
>
> -	em =3D create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESS=
ED);
> +	em =3D btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_CO=
MPRESSED);
>   	if (IS_ERR(em)) {
>   		ret =3D PTR_ERR(em);
>   		goto out_free_reserve;
> @@ -1257,8 +1235,8 @@ static void submit_one_async_extent(struct async_c=
hunk *async_chunk,
>   	kfree(async_extent);
>   }
>
> -static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 st=
art,
> -				      u64 num_bytes)
> +u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 sta=
rt,
> +				     u64 num_bytes)
>   {
>   	struct extent_map_tree *em_tree =3D &inode->extent_tree;
>   	struct extent_map *em;
> @@ -1368,7 +1346,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		}
>   	}
>
> -	alloc_hint =3D get_extent_allocation_hint(inode, start, num_bytes);
> +	alloc_hint =3D btrfs_get_extent_allocation_hint(inode, start, num_byte=
s);
>
>   	/*
>   	 * Relocation relies on the relocated extents to have exactly the sam=
e
> @@ -1435,7 +1413,8 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		lock_extent(&inode->io_tree, start, start + ram_size - 1,
>   			    &cached);
>
> -		em =3D create_io_em(inode, start, &file_extent, BTRFS_ORDERED_REGULAR=
);
> +		em =3D btrfs_create_io_em(inode, start, &file_extent,
> +					BTRFS_ORDERED_REGULAR);
>   		if (IS_ERR(em)) {
>   			unlock_extent(&inode->io_tree, start,
>   				      start + ram_size - 1, &cached);
> @@ -2152,8 +2131,9 @@ static noinline int run_delalloc_nocow(struct btrf=
s_inode *inode,
>   		if (is_prealloc) {
>   			struct extent_map *em;
>
> -			em =3D create_io_em(inode, cur_offset, &nocow_args.file_extent,
> -					  BTRFS_ORDERED_PREALLOC);
> +			em =3D btrfs_create_io_em(inode, cur_offset,
> +						&nocow_args.file_extent,
> +						BTRFS_ORDERED_PREALLOC);
>   			if (IS_ERR(em)) {
>   				unlock_extent(&inode->io_tree, cur_offset,
>   					      nocow_end, &cached_state);
> @@ -2582,44 +2562,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_ino=
de *inode,
>   	}
>   }
>
> -static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
> -					struct btrfs_ordered_extent *ordered)
> -{
> -	u64 start =3D (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> -	u64 len =3D bbio->bio.bi_iter.bi_size;
> -	struct btrfs_ordered_extent *new;
> -	int ret;
> -
> -	/* Must always be called for the beginning of an ordered extent. */
> -	if (WARN_ON_ONCE(start !=3D ordered->disk_bytenr))
> -		return -EINVAL;
> -
> -	/* No need to split if the ordered extent covers the entire bio. */
> -	if (ordered->disk_num_bytes =3D=3D len) {
> -		refcount_inc(&ordered->refs);
> -		bbio->ordered =3D ordered;
> -		return 0;
> -	}
> -
> -	/*
> -	 * Don't split the extent_map for NOCOW extents, as we're writing into
> -	 * a pre-existing one.
> -	 */
> -	if (!test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags)) {
> -		ret =3D split_extent_map(bbio->inode, bbio->file_offset,
> -				       ordered->num_bytes, len,
> -				       ordered->disk_bytenr);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	new =3D btrfs_split_ordered_extent(ordered, len);
> -	if (IS_ERR(new))
> -		return PTR_ERR(new);
> -	bbio->ordered =3D new;
> -	return 0;
> -}
> -
>   /*
>    * given a list of ordered sums record them in the inode.  This happen=
s
>    * at IO completion time based on sums calculated at bio submission ti=
me.
> @@ -6995,81 +6937,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_=
inode *inode,
>   	return em;
>   }
>
> -static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *i=
node,
> -						  struct btrfs_dio_data *dio_data,
> -						  const u64 start,
> -						  const struct btrfs_file_extent *file_extent,
> -						  const int type)
> -{
> -	struct extent_map *em =3D NULL;
> -	struct btrfs_ordered_extent *ordered;
> -
> -	if (type !=3D BTRFS_ORDERED_NOCOW) {
> -		em =3D create_io_em(inode, start, file_extent, type);
> -		if (IS_ERR(em))
> -			goto out;
> -	}
> -
> -	ordered =3D btrfs_alloc_ordered_extent(inode, start, file_extent,
> -					     (1 << type) |
> -					     (1 << BTRFS_ORDERED_DIRECT));
> -	if (IS_ERR(ordered)) {
> -		if (em) {
> -			free_extent_map(em);
> -			btrfs_drop_extent_map_range(inode, start,
> -					start + file_extent->num_bytes - 1, false);
> -		}
> -		em =3D ERR_CAST(ordered);
> -	} else {
> -		ASSERT(!dio_data->ordered);
> -		dio_data->ordered =3D ordered;
> -	}
> - out:
> -
> -	return em;
> -}
> -
> -static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *i=
node,
> -						  struct btrfs_dio_data *dio_data,
> -						  u64 start, u64 len)
> -{
> -	struct btrfs_root *root =3D inode->root;
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
> -	struct btrfs_file_extent file_extent;
> -	struct extent_map *em;
> -	struct btrfs_key ins;
> -	u64 alloc_hint;
> -	int ret;
> -
> -	alloc_hint =3D get_extent_allocation_hint(inode, start, len);
> -again:
> -	ret =3D btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
> -				   0, alloc_hint, &ins, 1, 1);
> -	if (ret =3D=3D -EAGAIN) {
> -		ASSERT(btrfs_is_zoned(fs_info));
> -		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINIS=
H,
> -			       TASK_UNINTERRUPTIBLE);
> -		goto again;
> -	}
> -	if (ret)
> -		return ERR_PTR(ret);
> -
> -	file_extent.disk_bytenr =3D ins.objectid;
> -	file_extent.disk_num_bytes =3D ins.offset;
> -	file_extent.num_bytes =3D ins.offset;
> -	file_extent.ram_bytes =3D ins.offset;
> -	file_extent.offset =3D 0;
> -	file_extent.compression =3D BTRFS_COMPRESS_NONE;
> -	em =3D btrfs_create_dio_extent(inode, dio_data, start, &file_extent,
> -				     BTRFS_ORDERED_REGULAR);
> -	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> -	if (IS_ERR(em))
> -		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
> -					   1);
> -
> -	return em;
> -}
> -
>   static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 b=
ytenr)
>   {
>   	struct btrfs_block_group *block_group;
> @@ -7200,103 +7067,10 @@ noinline int can_nocow_extent(struct inode *ino=
de, u64 offset, u64 *len,
>   	return ret;
>   }
>
> -static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 l=
ockend,
> -			      struct extent_state **cached_state,
> -			      unsigned int iomap_flags)
> -{
> -	const bool writing =3D (iomap_flags & IOMAP_WRITE);
> -	const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> -	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> -	struct btrfs_ordered_extent *ordered;
> -	int ret =3D 0;
> -
> -	while (1) {
> -		if (nowait) {
> -			if (!try_lock_extent(io_tree, lockstart, lockend,
> -					     cached_state))
> -				return -EAGAIN;
> -		} else {
> -			lock_extent(io_tree, lockstart, lockend, cached_state);
> -		}
> -		/*
> -		 * We're concerned with the entire range that we're going to be
> -		 * doing DIO to, so we need to make sure there's no ordered
> -		 * extents in this range.
> -		 */
> -		ordered =3D btrfs_lookup_ordered_range(BTRFS_I(inode), lockstart,
> -						     lockend - lockstart + 1);
> -
> -		/*
> -		 * We need to make sure there are no buffered pages in this
> -		 * range either, we could have raced between the invalidate in
> -		 * generic_file_direct_write and locking the extent.  The
> -		 * invalidate needs to happen so that reads after a write do not
> -		 * get stale data.
> -		 */
> -		if (!ordered &&
> -		    (!writing || !filemap_range_has_page(inode->i_mapping,
> -							 lockstart, lockend)))
> -			break;
> -
> -		unlock_extent(io_tree, lockstart, lockend, cached_state);
> -
> -		if (ordered) {
> -			if (nowait) {
> -				btrfs_put_ordered_extent(ordered);
> -				ret =3D -EAGAIN;
> -				break;
> -			}
> -			/*
> -			 * If we are doing a DIO read and the ordered extent we
> -			 * found is for a buffered write, we can not wait for it
> -			 * to complete and retry, because if we do so we can
> -			 * deadlock with concurrent buffered writes on page
> -			 * locks. This happens only if our DIO read covers more
> -			 * than one extent map, if at this point has already
> -			 * created an ordered extent for a previous extent map
> -			 * and locked its range in the inode's io tree, and a
> -			 * concurrent write against that previous extent map's
> -			 * range and this range started (we unlock the ranges
> -			 * in the io tree only when the bios complete and
> -			 * buffered writes always lock pages before attempting
> -			 * to lock range in the io tree).
> -			 */
> -			if (writing ||
> -			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
> -				btrfs_start_ordered_extent(ordered);
> -			else
> -				ret =3D nowait ? -EAGAIN : -ENOTBLK;
> -			btrfs_put_ordered_extent(ordered);
> -		} else {
> -			/*
> -			 * We could trigger writeback for this range (and wait
> -			 * for it to complete) and then invalidate the pages for
> -			 * this range (through invalidate_inode_pages2_range()),
> -			 * but that can lead us to a deadlock with a concurrent
> -			 * call to readahead (a buffered read or a defrag call
> -			 * triggered a readahead) on a page lock due to an
> -			 * ordered dio extent we created before but did not have
> -			 * yet a corresponding bio submitted (whence it can not
> -			 * complete), which makes readahead wait for that
> -			 * ordered extent to complete while holding a lock on
> -			 * that page.
> -			 */
> -			ret =3D nowait ? -EAGAIN : -ENOTBLK;
> -		}
> -
> -		if (ret)
> -			break;
> -
> -		cond_resched();
> -	}
> -
> -	return ret;
> -}
> -
>   /* The callers of this must take lock_extent() */
> -static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 s=
tart,
> -				       const struct btrfs_file_extent *file_extent,
> -				       int type)
> +struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 st=
art,
> +				      const struct btrfs_file_extent *file_extent,
> +				      int type)
>   {
>   	struct extent_map *em;
>   	int ret;
> @@ -7363,527 +7137,6 @@ static struct extent_map *create_io_em(struct bt=
rfs_inode *inode, u64 start,
>   	return em;
>   }
>
> -
> -static int btrfs_get_blocks_direct_write(struct extent_map **map,
> -					 struct inode *inode,
> -					 struct btrfs_dio_data *dio_data,
> -					 u64 start, u64 *lenp,
> -					 unsigned int iomap_flags)
> -{
> -	const bool nowait =3D (iomap_flags & IOMAP_NOWAIT);
> -	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> -	struct btrfs_file_extent file_extent;
> -	struct extent_map *em =3D *map;
> -	int type;
> -	u64 block_start;
> -	struct btrfs_block_group *bg;
> -	bool can_nocow =3D false;
> -	bool space_reserved =3D false;
> -	u64 len =3D *lenp;
> -	u64 prev_len;
> -	int ret =3D 0;
> -
> -	/*
> -	 * We don't allocate a new extent in the following cases
> -	 *
> -	 * 1) The inode is marked as NODATACOW. In this case we'll just use th=
e
> -	 * existing extent.
> -	 * 2) The extent is marked as PREALLOC. We're good to go here and can
> -	 * just use the extent.
> -	 *
> -	 */
> -	if ((em->flags & EXTENT_FLAG_PREALLOC) ||
> -	    ((BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
> -	     em->disk_bytenr !=3D EXTENT_MAP_HOLE)) {
> -		if (em->flags & EXTENT_FLAG_PREALLOC)
> -			type =3D BTRFS_ORDERED_PREALLOC;
> -		else
> -			type =3D BTRFS_ORDERED_NOCOW;
> -		len =3D min(len, em->len - (start - em->start));
> -		block_start =3D extent_map_block_start(em) + (start - em->start);
> -
> -		if (can_nocow_extent(inode, start, &len,
> -				     &file_extent, false, false) =3D=3D 1) {
> -			bg =3D btrfs_inc_nocow_writers(fs_info, block_start);
> -			if (bg)
> -				can_nocow =3D true;
> -		}
> -	}
> -
> -	prev_len =3D len;
> -	if (can_nocow) {
> -		struct extent_map *em2;
> -
> -		/* We can NOCOW, so only need to reserve metadata space. */
> -		ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
> -						      nowait);
> -		if (ret < 0) {
> -			/* Our caller expects us to free the input extent map. */
> -			free_extent_map(em);
> -			*map =3D NULL;
> -			btrfs_dec_nocow_writers(bg);
> -			if (nowait && (ret =3D=3D -ENOSPC || ret =3D=3D -EDQUOT))
> -				ret =3D -EAGAIN;
> -			goto out;
> -		}
> -		space_reserved =3D true;
> -
> -		em2 =3D btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start,
> -					      &file_extent, type);
> -		btrfs_dec_nocow_writers(bg);
> -		if (type =3D=3D BTRFS_ORDERED_PREALLOC) {
> -			free_extent_map(em);
> -			*map =3D em2;
> -			em =3D em2;
> -		}
> -
> -		if (IS_ERR(em2)) {
> -			ret =3D PTR_ERR(em2);
> -			goto out;
> -		}
> -
> -		dio_data->nocow_done =3D true;
> -	} else {
> -		/* Our caller expects us to free the input extent map. */
> -		free_extent_map(em);
> -		*map =3D NULL;
> -
> -		if (nowait) {
> -			ret =3D -EAGAIN;
> -			goto out;
> -		}
> -
> -		/*
> -		 * If we could not allocate data space before locking the file
> -		 * range and we can't do a NOCOW write, then we have to fail.
> -		 */
> -		if (!dio_data->data_space_reserved) {
> -			ret =3D -ENOSPC;
> -			goto out;
> -		}
> -
> -		/*
> -		 * We have to COW and we have already reserved data space before,
> -		 * so now we reserve only metadata.
> -		 */
> -		ret =3D btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len, len,
> -						      false);
> -		if (ret < 0)
> -			goto out;
> -		space_reserved =3D true;
> -
> -		em =3D btrfs_new_extent_direct(BTRFS_I(inode), dio_data, start, len);
> -		if (IS_ERR(em)) {
> -			ret =3D PTR_ERR(em);
> -			goto out;
> -		}
> -		*map =3D em;
> -		len =3D min(len, em->len - (start - em->start));
> -		if (len < prev_len)
> -			btrfs_delalloc_release_metadata(BTRFS_I(inode),
> -							prev_len - len, true);
> -	}
> -
> -	/*
> -	 * We have created our ordered extent, so we can now release our reser=
vation
> -	 * for an outstanding extent.
> -	 */
> -	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
> -
> -	/*
> -	 * Need to update the i_size under the extent lock so buffered
> -	 * readers will get the updated i_size when we unlock.
> -	 */
> -	if (start + len > i_size_read(inode))
> -		i_size_write(inode, start + len);
> -out:
> -	if (ret && space_reserved) {
> -		btrfs_delalloc_release_extents(BTRFS_I(inode), len);
> -		btrfs_delalloc_release_metadata(BTRFS_I(inode), len, true);
> -	}
> -	*lenp =3D len;
> -	return ret;
> -}
> -
> -static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
> -		loff_t length, unsigned int flags, struct iomap *iomap,
> -		struct iomap *srcmap)
> -{
> -	struct iomap_iter *iter =3D container_of(iomap, struct iomap_iter, iom=
ap);
> -	struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
> -	struct extent_map *em;
> -	struct extent_state *cached_state =3D NULL;
> -	struct btrfs_dio_data *dio_data =3D iter->private;
> -	u64 lockstart, lockend;
> -	const bool write =3D !!(flags & IOMAP_WRITE);
> -	int ret =3D 0;
> -	u64 len =3D length;
> -	const u64 data_alloc_len =3D length;
> -	bool unlock_extents =3D false;
> -
> -	/*
> -	 * We could potentially fault if we have a buffer > PAGE_SIZE, and if
> -	 * we're NOWAIT we may submit a bio for a partial range and return
> -	 * EIOCBQUEUED, which would result in an errant short read.
> -	 *
> -	 * The best way to handle this would be to allow for partial completio=
ns
> -	 * of iocb's, so we could submit the partial bio, return and fault in
> -	 * the rest of the pages, and then submit the io for the rest of the
> -	 * range.  However we don't have that currently, so simply return
> -	 * -EAGAIN at this point so that the normal path is used.
> -	 */
> -	if (!write && (flags & IOMAP_NOWAIT) && length > PAGE_SIZE)
> -		return -EAGAIN;
> -
> -	/*
> -	 * Cap the size of reads to that usually seen in buffered I/O as we ne=
ed
> -	 * to allocate a contiguous array for the checksums.
> -	 */
> -	if (!write)
> -		len =3D min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
> -
> -	lockstart =3D start;
> -	lockend =3D start + len - 1;
> -
> -	/*
> -	 * iomap_dio_rw() only does filemap_write_and_wait_range(), which isn'=
t
> -	 * enough if we've written compressed pages to this area, so we need t=
o
> -	 * flush the dirty pages again to make absolutely sure that any
> -	 * outstanding dirty pages are on disk - the first flush only starts
> -	 * compression on the data, while keeping the pages locked, so by the
> -	 * time the second flush returns we know bios for the compressed pages
> -	 * were submitted and finished, and the pages no longer under writebac=
k.
> -	 *
> -	 * If we have a NOWAIT request and we have any pages in the range that
> -	 * are locked, likely due to compression still in progress, we don't w=
ant
> -	 * to block on page locks. We also don't want to block on pages marked=
 as
> -	 * dirty or under writeback (same as for the non-compression case).
> -	 * iomap_dio_rw() did the same check, but after that and before we got
> -	 * here, mmap'ed writes may have happened or buffered reads started
> -	 * (readpage() and readahead(), which lock pages), as we haven't locke=
d
> -	 * the file range yet.
> -	 */
> -	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> -		     &BTRFS_I(inode)->runtime_flags)) {
> -		if (flags & IOMAP_NOWAIT) {
> -			if (filemap_range_needs_writeback(inode->i_mapping,
> -							  lockstart, lockend))
> -				return -EAGAIN;
> -		} else {
> -			ret =3D filemap_fdatawrite_range(inode->i_mapping, start,
> -						       start + length - 1);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	memset(dio_data, 0, sizeof(*dio_data));
> -
> -	/*
> -	 * We always try to allocate data space and must do it before locking
> -	 * the file range, to avoid deadlocks with concurrent writes to the sa=
me
> -	 * range if the range has several extents and the writes don't expand =
the
> -	 * current i_size (the inode lock is taken in shared mode). If we fail=
 to
> -	 * allocate data space here we continue and later, after locking the
> -	 * file range, we fail with ENOSPC only if we figure out we can not do=
 a
> -	 * NOCOW write.
> -	 */
> -	if (write && !(flags & IOMAP_NOWAIT)) {
> -		ret =3D btrfs_check_data_free_space(BTRFS_I(inode),
> -						  &dio_data->data_reserved,
> -						  start, data_alloc_len, false);
> -		if (!ret)
> -			dio_data->data_space_reserved =3D true;
> -		else if (ret && !(BTRFS_I(inode)->flags &
> -				  (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
> -			goto err;
> -	}
> -
> -	/*
> -	 * If this errors out it's because we couldn't invalidate pagecache fo=
r
> -	 * this range and we need to fallback to buffered IO, or we are doing =
a
> -	 * NOWAIT read/write and we need to block.
> -	 */
> -	ret =3D lock_extent_direct(inode, lockstart, lockend, &cached_state, f=
lags);
> -	if (ret < 0)
> -		goto err;
> -
> -	em =3D btrfs_get_extent(BTRFS_I(inode), NULL, start, len);
> -	if (IS_ERR(em)) {
> -		ret =3D PTR_ERR(em);
> -		goto unlock_err;
> -	}
> -
> -	/*
> -	 * Ok for INLINE and COMPRESSED extents we need to fallback on buffere=
d
> -	 * io.  INLINE is special, and we could probably kludge it in here, bu=
t
> -	 * it's still buffered so for safety lets just fall back to the generi=
c
> -	 * buffered path.
> -	 *
> -	 * For COMPRESSED we _have_ to read the entire extent in so we can
> -	 * decompress it, so there will be buffering required no matter what w=
e
> -	 * do, so go ahead and fallback to buffered.
> -	 *
> -	 * We return -ENOTBLK because that's what makes DIO go ahead and go ba=
ck
> -	 * to buffered IO.  Don't blame me, this is the price we pay for using
> -	 * the generic code.
> -	 */
> -	if (extent_map_is_compressed(em) || em->disk_bytenr =3D=3D EXTENT_MAP_=
INLINE) {
> -		free_extent_map(em);
> -		/*
> -		 * If we are in a NOWAIT context, return -EAGAIN in order to
> -		 * fallback to buffered IO. This is not only because we can
> -		 * block with buffered IO (no support for NOWAIT semantics at
> -		 * the moment) but also to avoid returning short reads to user
> -		 * space - this happens if we were able to read some data from
> -		 * previous non-compressed extents and then when we fallback to
> -		 * buffered IO, at btrfs_file_read_iter() by calling
> -		 * filemap_read(), we fail to fault in pages for the read buffer,
> -		 * in which case filemap_read() returns a short read (the number
> -		 * of bytes previously read is > 0, so it does not return -EFAULT).
> -		 */
> -		ret =3D (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
> -		goto unlock_err;
> -	}
> -
> -	len =3D min(len, em->len - (start - em->start));
> -
> -	/*
> -	 * If we have a NOWAIT request and the range contains multiple extents
> -	 * (or a mix of extents and holes), then we return -EAGAIN to make the
> -	 * caller fallback to a context where it can do a blocking (without
> -	 * NOWAIT) request. This way we avoid doing partial IO and returning
> -	 * success to the caller, which is not optimal for writes and for read=
s
> -	 * it can result in unexpected behaviour for an application.
> -	 *
> -	 * When doing a read, because we use IOMAP_DIO_PARTIAL when calling
> -	 * iomap_dio_rw(), we can end up returning less data then what the cal=
ler
> -	 * asked for, resulting in an unexpected, and incorrect, short read.
> -	 * That is, the caller asked to read N bytes and we return less than t=
hat,
> -	 * which is wrong unless we are crossing EOF. This happens if we get a
> -	 * page fault error when trying to fault in pages for the buffer that =
is
> -	 * associated to the struct iov_iter passed to iomap_dio_rw(), and we
> -	 * have previously submitted bios for other extents in the range, in
> -	 * which case iomap_dio_rw() may return us EIOCBQUEUED if not all of
> -	 * those bios have completed by the time we get the page fault error,
> -	 * which we return back to our caller - we should only return EIOCBQUE=
UED
> -	 * after we have submitted bios for all the extents in the range.
> -	 */
> -	if ((flags & IOMAP_NOWAIT) && len < length) {
> -		free_extent_map(em);
> -		ret =3D -EAGAIN;
> -		goto unlock_err;
> -	}
> -
> -	if (write) {
> -		ret =3D btrfs_get_blocks_direct_write(&em, inode, dio_data,
> -						    start, &len, flags);
> -		if (ret < 0)
> -			goto unlock_err;
> -		unlock_extents =3D true;
> -		/* Recalc len in case the new em is smaller than requested */
> -		len =3D min(len, em->len - (start - em->start));
> -		if (dio_data->data_space_reserved) {
> -			u64 release_offset;
> -			u64 release_len =3D 0;
> -
> -			if (dio_data->nocow_done) {
> -				release_offset =3D start;
> -				release_len =3D data_alloc_len;
> -			} else if (len < data_alloc_len) {
> -				release_offset =3D start + len;
> -				release_len =3D data_alloc_len - len;
> -			}
> -
> -			if (release_len > 0)
> -				btrfs_free_reserved_data_space(BTRFS_I(inode),
> -							       dio_data->data_reserved,
> -							       release_offset,
> -							       release_len);
> -		}
> -	} else {
> -		/*
> -		 * We need to unlock only the end area that we aren't using.
> -		 * The rest is going to be unlocked by the endio routine.
> -		 */
> -		lockstart =3D start + len;
> -		if (lockstart < lockend)
> -			unlock_extents =3D true;
> -	}
> -
> -	if (unlock_extents)
> -		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> -			      &cached_state);
> -	else
> -		free_extent_state(cached_state);
> -
> -	/*
> -	 * Translate extent map information to iomap.
> -	 * We trim the extents (and move the addr) even though iomap code does
> -	 * that, since we have locked only the parts we are performing I/O in.
> -	 */
> -	if ((em->disk_bytenr =3D=3D EXTENT_MAP_HOLE) ||
> -	    ((em->flags & EXTENT_FLAG_PREALLOC) && !write)) {
> -		iomap->addr =3D IOMAP_NULL_ADDR;
> -		iomap->type =3D IOMAP_HOLE;
> -	} else {
> -		iomap->addr =3D extent_map_block_start(em) + (start - em->start);
> -		iomap->type =3D IOMAP_MAPPED;
> -	}
> -	iomap->offset =3D start;
> -	iomap->bdev =3D fs_info->fs_devices->latest_dev->bdev;
> -	iomap->length =3D len;
> -	free_extent_map(em);
> -
> -	return 0;
> -
> -unlock_err:
> -	unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
> -		      &cached_state);
> -err:
> -	if (dio_data->data_space_reserved) {
> -		btrfs_free_reserved_data_space(BTRFS_I(inode),
> -					       dio_data->data_reserved,
> -					       start, data_alloc_len);
> -		extent_changeset_free(dio_data->data_reserved);
> -	}
> -
> -	return ret;
> -}
> -
> -static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t =
length,
> -		ssize_t written, unsigned int flags, struct iomap *iomap)
> -{
> -	struct iomap_iter *iter =3D container_of(iomap, struct iomap_iter, iom=
ap);
> -	struct btrfs_dio_data *dio_data =3D iter->private;
> -	size_t submitted =3D dio_data->submitted;
> -	const bool write =3D !!(flags & IOMAP_WRITE);
> -	int ret =3D 0;
> -
> -	if (!write && (iomap->type =3D=3D IOMAP_HOLE)) {
> -		/* If reading from a hole, unlock and return */
> -		unlock_extent(&BTRFS_I(inode)->io_tree, pos, pos + length - 1,
> -			      NULL);
> -		return 0;
> -	}
> -
> -	if (submitted < length) {
> -		pos +=3D submitted;
> -		length -=3D submitted;
> -		if (write)
> -			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> -						    pos, length, false);
> -		else
> -			unlock_extent(&BTRFS_I(inode)->io_tree, pos,
> -				      pos + length - 1, NULL);
> -		ret =3D -ENOTBLK;
> -	}
> -	if (write) {
> -		btrfs_put_ordered_extent(dio_data->ordered);
> -		dio_data->ordered =3D NULL;
> -	}
> -
> -	if (write)
> -		extent_changeset_free(dio_data->data_reserved);
> -	return ret;
> -}
> -
> -static void btrfs_dio_end_io(struct btrfs_bio *bbio)
> -{
> -	struct btrfs_dio_private *dip =3D
> -		container_of(bbio, struct btrfs_dio_private, bbio);
> -	struct btrfs_inode *inode =3D bbio->inode;
> -	struct bio *bio =3D &bbio->bio;
> -
> -	if (bio->bi_status) {
> -		btrfs_warn(inode->root->fs_info,
> -		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
> -			   btrfs_ino(inode), bio->bi_opf,
> -			   dip->file_offset, dip->bytes, bio->bi_status);
> -	}
> -
> -	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
> -		btrfs_finish_ordered_extent(bbio->ordered, NULL,
> -					    dip->file_offset, dip->bytes,
> -					    !bio->bi_status);
> -	} else {
> -		unlock_extent(&inode->io_tree, dip->file_offset,
> -			      dip->file_offset + dip->bytes - 1, NULL);
> -	}
> -
> -	bbio->bio.bi_private =3D bbio->private;
> -	iomap_dio_bio_end_io(bio);
> -}
> -
> -static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct b=
io *bio,
> -				loff_t file_offset)
> -{
> -	struct btrfs_bio *bbio =3D btrfs_bio(bio);
> -	struct btrfs_dio_private *dip =3D
> -		container_of(bbio, struct btrfs_dio_private, bbio);
> -	struct btrfs_dio_data *dio_data =3D iter->private;
> -
> -	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
> -		       btrfs_dio_end_io, bio->bi_private);
> -	bbio->inode =3D BTRFS_I(iter->inode);
> -	bbio->file_offset =3D file_offset;
> -
> -	dip->file_offset =3D file_offset;
> -	dip->bytes =3D bio->bi_iter.bi_size;
> -
> -	dio_data->submitted +=3D bio->bi_iter.bi_size;
> -
> -	/*
> -	 * Check if we are doing a partial write.  If we are, we need to split
> -	 * the ordered extent to match the submitted bio.  Hang on to the
> -	 * remaining unfinishable ordered_extent in dio_data so that it can be
> -	 * cancelled in iomap_end to avoid a deadlock wherein faulting the
> -	 * remaining pages is blocked on the outstanding ordered extent.
> -	 */
> -	if (iter->flags & IOMAP_WRITE) {
> -		int ret;
> -
> -		ret =3D btrfs_extract_ordered_extent(bbio, dio_data->ordered);
> -		if (ret) {
> -			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
> -						    file_offset, dip->bytes,
> -						    !ret);
> -			bio->bi_status =3D errno_to_blk_status(ret);
> -			iomap_dio_bio_end_io(bio);
> -			return;
> -		}
> -	}
> -
> -	btrfs_submit_bio(bbio, 0);
> -}
> -
> -static const struct iomap_ops btrfs_dio_iomap_ops =3D {
> -	.iomap_begin            =3D btrfs_dio_iomap_begin,
> -	.iomap_end              =3D btrfs_dio_iomap_end,
> -};
> -
> -static const struct iomap_dio_ops btrfs_dio_ops =3D {
> -	.submit_io		=3D btrfs_dio_submit_io,
> -	.bio_set		=3D &btrfs_dio_bioset,
> -};
> -
> -ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_=
t done_before)
> -{
> -	struct btrfs_dio_data data =3D { 0 };
> -
> -	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
> -			    IOMAP_DIO_PARTIAL, &data, done_before);
> -}
> -
> -struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *=
iter,
> -				  size_t done_before)
> -{
> -	struct btrfs_dio_data data =3D { 0 };
> -
> -	return __iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops=
,
> -			    IOMAP_DIO_PARTIAL, &data, done_before);
> -}
> -
>   /*
>    * For release_folio() and invalidate_folio() we have a race window wh=
ere
>    * folio_end_writeback() is called but the subpage spinlock is not yet=
 released.
> @@ -8503,7 +7756,6 @@ void __cold btrfs_destroy_cachep(void)
>   	 * destroy cache.
>   	 */
>   	rcu_barrier();
> -	bioset_exit(&btrfs_dio_bioset);
>   	kmem_cache_destroy(btrfs_inode_cachep);
>   }
>
> @@ -8514,17 +7766,9 @@ int __init btrfs_init_cachep(void)
>   			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>   			init_once);
>   	if (!btrfs_inode_cachep)
> -		goto fail;
> -
> -	if (bioset_init(&btrfs_dio_bioset, BIO_POOL_SIZE,
> -			offsetof(struct btrfs_dio_private, bbio.bio),
> -			BIOSET_NEED_BVECS))
> -		goto fail;
> +		return -ENOMEM;
>
>   	return 0;
> -fail:
> -	btrfs_destroy_cachep();
> -	return -ENOMEM;
>   }
>
>   static int btrfs_getattr(struct mnt_idmap *idmap,
> @@ -10267,7 +9511,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb=
, struct iov_iter *from,
>   	file_extent.ram_bytes =3D ram_bytes;
>   	file_extent.offset =3D encoded->unencoded_offset;
>   	file_extent.compression =3D compression;
> -	em =3D create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESS=
ED);
> +	em =3D btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_CO=
MPRESSED);
>   	if (IS_ERR(em)) {
>   		ret =3D PTR_ERR(em);
>   		goto out_free_reserved;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 715686e8d4cb..5450a01cb69c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -34,6 +34,7 @@
>   #include "disk-io.h"
>   #include "transaction.h"
>   #include "btrfs_inode.h"
> +#include "direct-io.h"
>   #include "props.h"
>   #include "xattr.h"
>   #include "bio.h"
> @@ -2489,6 +2490,9 @@ static const struct init_sequence mod_init_seq[] =
=3D {
>   	}, {
>   		.init_func =3D btrfs_init_cachep,
>   		.exit_func =3D btrfs_destroy_cachep,
> +	}, {
> +		.init_func =3D btrfs_init_dio,
> +		.exit_func =3D btrfs_destroy_dio,
>   	}, {
>   		.init_func =3D btrfs_transaction_init,
>   		.exit_func =3D btrfs_transaction_exit,

