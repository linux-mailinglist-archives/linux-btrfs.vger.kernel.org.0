Return-Path: <linux-btrfs+bounces-591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048F8040B5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2604B2812D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAED364A5;
	Mon,  4 Dec 2023 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Jo5vMUKQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA73AA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701724049; x=1702328849; i=quwenruo.btrfs@gmx.com;
	bh=JJhmQmcx1oTf4PfLTPLTgkU4ZfCqqcU07ZQW99DmfIA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Jo5vMUKQD3PskzP9OCFEg1J3w0gQ9vCAANmspi0xesMha4fsdtXxYFAYYgEm0Pug
	 BbWsLnRD/SUWmKuKPkhnsIaWKaoe3ItwPDIRsl6T9RYojI5LRhS7Oy8/69u+QgPbl
	 uILr/rjOy8d7EbAIfJNd3HBDdR3nYMyjEXbUmcv+nueb/wgymTp9qKF7y6t6K899y
	 81e/pPJ/DOqCMzGo3gA2Q8XHo+hcykl+F0Mklq1KTH2YxidU5ygEGm0mWspi5a819
	 8EoGSeDf5zqftAi6qzBTIl3GLSZLJzySuc37xb/CPCZipLu4XQxPWAb9sUBfPqcWe
	 CG65lHSqKMtE3y/e0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1rBKUd3gtw-007mxp; Mon, 04
 Dec 2023 22:07:28 +0100
Message-ID: <de707933-b800-4bc2-8da5-44a99bcd6e83@gmx.com>
Date: Tue, 5 Dec 2023 07:37:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: fix qgroup_free_reserved_data int overflow
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1701464169.git.boris@bur.io>
 <98d6609df5dc669df4025c257c28077f44b21e04.1701464169.git.boris@bur.io>
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
In-Reply-To: <98d6609df5dc669df4025c257c28077f44b21e04.1701464169.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O8IDuBEd6u/IY/S5hsZjfshoX96+0ZUNv0/lOqgHE/juo47RhXb
 qxzSiU+9pwKBZ2/ItLlKkhDZK1etUIuRDfDLH986DiAyKEOqVcAq+rclU/rE14GQiaB+EmW
 UrcukKrZ801BQ1V31+TzNzyTEYNS02CufzykAQwN9MmyRk5HuQgX5q0YkWXNfqI3QnHUqzp
 b4PkCFsuW9z9K5dbyT9LA==
UI-OutboundReport: notjunk:1;M01:P0:eDqzmBkLhnk=;nUHKJZigYND7w8DHoH1nJZMY8Ht
 zIPCykV2XYSBw98QrkL24sU22K0IRmnsOseBRQ+ULr+xfXz+AdtR2N/BNPa9wlDKSQ0wkge2Y
 BfxGaSqzlI0OlhOprhdQsqvoQE7R6uHXkf8440Wx6SkUiRluAZG1OhWZcEUeRvg54Mv6KmrBf
 wbbuZzJ9yEgedlXUzd4knqlKv7h4+Sn3/jxgk9P5g8RSc0h7fga10OESDFz63+3A2LCg6enGu
 SOxzuuq9+2a8QRxVOFZU8Zx4zGbsSn8c/oitwxQ8/B0a/ykgXxQCY8Py44al2fQfmS4gASCtX
 CxosJfKRtc306wDyest+NOrDjyvFRq5PneocHOn6r2VsDjkDIR+oJsbUnv6mmsdFz1fcit/OJ
 AtmnWgYAh/tw5RY1AM9y4q7hnXHLFNlXTN7TaxUcm0cmjYhxX7jY+SRogxNDt/lTp2suvWo9z
 GwhUmMur96+GtbqzmuI+PFiaPv3ad4IXAEpdAnnVni2GZnIdhctOcSL9e5DAMpe6HrpKBRjii
 5RENhIbxsCbiIDQNhPmLSfKC843Bafd8fLOFVLAn+sT39EO84LoPAxadfaEZXNBfq8arzz2YQ
 YSJEup7RbrrDi2H0ZfWxE/FMLCnfS/PKx9oLs428O1kFuOZkZ93SrQCc5URGC2GNczTJIb3oQ
 vdkBjr0Qht8k9l1icmUTnF6k2qQvlNdp2upBaz0OW0/CBHWJVCTB8aQGdLY5ZhEMOt5TuGpUo
 tqTGfTa/DJw+TA4sPkgWTAxI4QMftkXt7rfnYNA0sNNB3T/Ts5t1/f7V1PHHhBt04XWJsFfm2
 dng2uQ+mvs/duyY+Vf5oc8MvCoiomWaQcxuUeORxZA2yWcDKVpqylM7seMA4h+Nsqza564CNw
 D1ZI9AwBnbyoquNhRYJPMIxUE3DGeHMTfYwEIwlj4/8dhW0b2oJjyhKbuZOVriRNrSPtG8lZ8
 qtGBkMx0ztFqTCdhOSVUW3vjm3U=



On 2023/12/2 07:30, Boris Burkov wrote:
> The reserved data counter and input parameter is a u64, but we
> inadvertantly accumulate it in an int. Overflowing that int results in
> freeing the wrong amount of data and breaking rsv accounting.
>
> Unfortunately, this overflow rot spreads from there, as the qgroup
> release/free functions rely on returning an int to take advantage of
> negative values for error codes.

Indeed, reusing int for both released bytes and error number is the root
cause of the overflow.

>
> Therefore, the full fix is to return the "released" or "freed" amount by
> a u64* argument and to return 0 or negative error code via the return
> value.
>
> Most of the callsites simply ignore the return value, though some
> of them handle the error and count the returned bytes. Change all of
> them accordingly.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/delalloc-space.c |  2 +-
>   fs/btrfs/file.c           |  2 +-
>   fs/btrfs/inode.c          | 16 ++++++++--------
>   fs/btrfs/ordered-data.c   |  7 ++++---
>   fs/btrfs/qgroup.c         | 25 +++++++++++++++----------
>   fs/btrfs/qgroup.h         |  4 ++--
>   6 files changed, 31 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index 51453d4928fa..2833e8ef4c09 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -199,7 +199,7 @@ void btrfs_free_reserved_data_space(struct btrfs_ino=
de *inode,
>   	start =3D round_down(start, fs_info->sectorsize);
>
>   	btrfs_free_reserved_data_space_noquota(fs_info, len);
> -	btrfs_qgroup_free_data(inode, reserved, start, len);
> +	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
>   }
>
>   /*
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e9c4b947a5aa..7a71720aaed2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3192,7 +3192,7 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>   			qgroup_reserved -=3D range->len;
>   		} else if (qgroup_reserved > 0) {
>   			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
> -					       range->start, range->len);
> +					       range->start, range->len, NULL);
>   			qgroup_reserved -=3D range->len;
>   		}
>   		list_del(&range->list);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f8647d8271b7..e79a047aa5d1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -697,7 +697,7 @@ static noinline int cow_file_range_inline(struct btr=
fs_inode *inode, u64 size,
>   	 * And at reserve time, it's always aligned to page size, so
>   	 * just free one page here.
>   	 */
> -	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
> +	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
>   	btrfs_free_path(path);
>   	btrfs_end_transaction(trans);
>   	return ret;
> @@ -5141,7 +5141,7 @@ static void evict_inode_truncate_pages(struct inod=
e *inode)
>   		 */
>   		if (state_flags & EXTENT_DELALLOC)
>   			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
> -					       end - start + 1);
> +					       end - start + 1, NULL);
>
>   		clear_extent_bit(io_tree, start, end,
>   				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
> @@ -8076,7 +8076,7 @@ static void btrfs_invalidate_folio(struct folio *f=
olio, size_t offset,
>   		 *    reserved data space.
>   		 *    Since the IO will never happen for this page.
>   		 */
> -		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
> +		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
>   		if (!inode_evicting) {
>   			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
>   				 EXTENT_DELALLOC | EXTENT_UPTODATE |
> @@ -9513,7 +9513,7 @@ static struct btrfs_trans_handle *insert_prealloc_=
file_extent(
>   	struct btrfs_path *path;
>   	u64 start =3D ins->objectid;
>   	u64 len =3D ins->offset;
> -	int qgroup_released;
> +	u64 qgroup_released =3D 0;
>   	int ret;
>
>   	memset(&stack_fi, 0, sizeof(stack_fi));
> @@ -9526,9 +9526,9 @@ static struct btrfs_trans_handle *insert_prealloc_=
file_extent(
>   	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NON=
E);
>   	/* Encryption and other encoding is reserved and all 0 */
>
> -	qgroup_released =3D btrfs_qgroup_release_data(inode, file_offset, len)=
;
> -	if (qgroup_released < 0)
> -		return ERR_PTR(qgroup_released);
> +	ret =3D btrfs_qgroup_release_data(inode, file_offset, len, &qgroup_rel=
eased);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
>
>   	if (trans) {
>   		ret =3D insert_reserved_file_extent(trans, inode,
> @@ -10423,7 +10423,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *ioc=
b, struct iov_iter *from,
>   	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
>   out_qgroup_free_data:
>   	if (ret < 0)
> -		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
> +		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes, NULL);
>   out_free_data_space:
>   	/*
>   	 * If btrfs_reserve_extent() succeeded, then we already decremented
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 8d4ab5ecfa5d..c68fb78b7454 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -152,11 +152,12 @@ static struct btrfs_ordered_extent *alloc_ordered_=
extent(
>   {
>   	struct btrfs_ordered_extent *entry;
>   	int ret;
> +	u64 qgroup_rsv =3D 0;
>
>   	if (flags &
>   	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
>   		/* For nocow write, we can release the qgroup rsv right now */
> -		ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
> +		ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &=
qgroup_rsv);
>   		if (ret < 0)
>   			return ERR_PTR(ret);
>   	} else {
> @@ -164,7 +165,7 @@ static struct btrfs_ordered_extent *alloc_ordered_ex=
tent(
>   		 * The ordered extent has reserved qgroup space, release now
>   		 * and pass the reserved number for qgroup_record to free.
>   		 */
> -		ret =3D btrfs_qgroup_release_data(inode, file_offset, num_bytes);
> +		ret =3D btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgr=
oup_rsv);
>   		if (ret < 0)
>   			return ERR_PTR(ret);
>   	}
> @@ -182,7 +183,7 @@ static struct btrfs_ordered_extent *alloc_ordered_ex=
tent(
>   	entry->inode =3D igrab(&inode->vfs_inode);
>   	entry->compress_type =3D compress_type;
>   	entry->truncated_len =3D (u64)-1;
> -	entry->qgroup_rsv =3D ret;
> +	entry->qgroup_rsv =3D qgroup_rsv;
>   	entry->flags =3D flags;
>   	refcount_set(&entry->refs, 1);
>   	init_waitqueue_head(&entry->wait);
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ce446d9d7f23..a953c16c7eb8 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4057,13 +4057,14 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode=
 *inode,
>
>   /* Free ranges specified by @reserved, normally in error path */
>   static int qgroup_free_reserved_data(struct btrfs_inode *inode,
> -			struct extent_changeset *reserved, u64 start, u64 len)
> +				     struct extent_changeset *reserved,
> +				     u64 start, u64 len, u64 *freed_ret)
>   {
>   	struct btrfs_root *root =3D inode->root;
>   	struct ulist_node *unode;
>   	struct ulist_iterator uiter;
>   	struct extent_changeset changeset;
> -	int freed =3D 0;
> +	u64 freed =3D 0;
>   	int ret;
>
>   	extent_changeset_init(&changeset);
> @@ -4104,7 +4105,9 @@ static int qgroup_free_reserved_data(struct btrfs_=
inode *inode,
>   	}
>   	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid, fre=
ed,
>   				  BTRFS_QGROUP_RSV_DATA);
> -	ret =3D freed;
> +	if (freed_ret)
> +		*freed_ret =3D freed;
> +	ret =3D 0;
>   out:
>   	extent_changeset_release(&changeset);
>   	return ret;
> @@ -4112,7 +4115,7 @@ static int qgroup_free_reserved_data(struct btrfs_=
inode *inode,
>
>   static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
>   			struct extent_changeset *reserved, u64 start, u64 len,
> -			int free)
> +			u64 *released, int free)
>   {
>   	struct extent_changeset changeset;
>   	int trace_op =3D QGROUP_RELEASE;
> @@ -4128,7 +4131,7 @@ static int __btrfs_qgroup_release_data(struct btrf=
s_inode *inode,
>   	/* In release case, we shouldn't have @reserved */
>   	WARN_ON(!free && reserved);
>   	if (free && reserved)
> -		return qgroup_free_reserved_data(inode, reserved, start, len);
> +		return qgroup_free_reserved_data(inode, reserved, start, len, release=
d);
>   	extent_changeset_init(&changeset);
>   	ret =3D clear_record_extent_bits(&inode->io_tree, start, start + len =
-1,
>   				       EXTENT_QGROUP_RESERVED, &changeset);
> @@ -4143,7 +4146,8 @@ static int __btrfs_qgroup_release_data(struct btrf=
s_inode *inode,
>   		btrfs_qgroup_free_refroot(inode->root->fs_info,
>   				inode->root->root_key.objectid,
>   				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
> -	ret =3D changeset.bytes_changed;
> +	if (released)
> +		*released =3D changeset.bytes_changed;
>   out:
>   	extent_changeset_release(&changeset);
>   	return ret;
> @@ -4162,9 +4166,10 @@ static int __btrfs_qgroup_release_data(struct btr=
fs_inode *inode,
>    * NOTE: This function may sleep for memory allocation.
>    */
>   int btrfs_qgroup_free_data(struct btrfs_inode *inode,
> -			struct extent_changeset *reserved, u64 start, u64 len)
> +			   struct extent_changeset *reserved,
> +			   u64 start, u64 len, u64 *freed)
>   {
> -	return __btrfs_qgroup_release_data(inode, reserved, start, len, 1);
> +	return __btrfs_qgroup_release_data(inode, reserved, start, len, freed,=
 1);
>   }
>
>   /*
> @@ -4182,9 +4187,9 @@ int btrfs_qgroup_free_data(struct btrfs_inode *ino=
de,
>    *
>    * NOTE: This function may sleep for memory allocation.
>    */
> -int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64=
 len)
> +int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64=
 len, u64 *released)
>   {
> -	return __btrfs_qgroup_release_data(inode, NULL, start, len, 0);
> +	return __btrfs_qgroup_release_data(inode, NULL, start, len, released, =
0);
>   }
>
>   static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 855a4f978761..15b485506104 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -358,10 +358,10 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_inf=
o *fs_info, u64 qgroupid,
>   /* New io_tree based accurate qgroup reserve API */
>   int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
>   			struct extent_changeset **reserved, u64 start, u64 len);
> -int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64=
 len);
> +int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64=
 len, u64 *released);
>   int btrfs_qgroup_free_data(struct btrfs_inode *inode,
>   			   struct extent_changeset *reserved, u64 start,
> -			   u64 len);
> +			   u64 len, u64 *freed);
>   int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
>   			      enum btrfs_qgroup_rsv_type type, bool enforce);
>   int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes=
,

