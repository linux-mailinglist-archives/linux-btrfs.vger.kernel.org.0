Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E711710A31
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjEYKez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:34:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663612E
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685010890; i=quwenruo.btrfs@gmx.com;
        bh=8JTuob3c9qV1KMySzxZQaXmSaKg0X2UjsfGYNwYG/eg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fKyvfYWk45tWBtQvbTBWd40PLMwfKeOf9ZLYAe4L0sErMIvIRkqviEh3j53jqCn55
         j1+NBfwNTIhpqO7/o1sPAR1jVxkMQykfB40PMx2je9q2K5+qysxGatGgcW/YLywAY/
         qhGKKpEpgkazSqjH34AyFbxjoPXH+YoFYqHJLjiapQKN4LhjWAfD8eA2cT9dHG3bnz
         vySFuQ50C/31oSaTtMJ4586CMFHOKbYDjlMf6Hk53Bi2bOzcrd/oEbb9ONS+Ge+/8J
         N4Y8Jv7OrBQ1TlzWIhYjWKmkQVyoHDSJ4XY5cdOpbe4nOurn6Ie7d+uBv8GkD6aZ3X
         kClmfBAsvvblQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1qI1AE2Glr-00srIe; Thu, 25
 May 2023 12:34:50 +0200
Message-ID: <eea29b4b-3c0f-0c3e-67a4-b37813bfbc8a@gmx.com>
Date:   Thu, 25 May 2023 18:34:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6/9] btrfs: open code set_extent_bits
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <016d0db9c71e15f4c39ea866ce82a425db55cf07.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <016d0db9c71e15f4c39ea866ce82a425db55cf07.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hgYuImzmBQHmZFc28S86Xn/ncNfuzpELnuM1omryw+doglMTaj9
 /OIaFpxUsT8nhGqjUITO29WOoKT9EZgwd3rwBm5ykq/KbWLMfTGfsOA7jr3D7G243MHDAc7
 PZ7nCqgNlIs7XUOuE6t9tf522rPKVRnOozhVs6Io2B5tMJvWEycvA3119pLw/Typc1DcwIC
 eZCBjwYLV46GYBZ/gjMcA==
UI-OutboundReport: notjunk:1;M01:P0:K551SrtHkcI=;28qGSvcy8CQh/VXqTULwx53bX6T
 rGkXerFrwPs1GXDV/z4ksmRD9yXIbOMt/6DvUx9o5ASgIU12RpxsKaUUNYpqyXAByvPmhtgoe
 pTpiXwfCeZkKYj0p5VzfSOLE6rA9NBNV11osp2OaKxEAysTFn7I5qD/WJ/klMmo634O5+Ej5x
 dsdaT3evH2LDoIPji/JtivrEZC2arZqKw5hqT+ugRf0DiSyCOIBaUIfHVtvPlBN+adhwWTg99
 yPnVmtLRaV/wqhL3k1EMJnmbymeZ3U60Qyb0EPLOUyDuk/lB2gKx87wjakdluLElZKE3FHaoO
 J83zYIq++9omnq8s1JJ1Bjo7qkiFUhISuSCvls6zbo9cK46MnZg2S/+fq2IDARPruZwxtY0y4
 gqit3udDpg5s+QaWU4nlWkJCG4Aaz/Itv5U+GLnqN6WjWkhbZj99mA/HLRWHEpxG2WPBeXCul
 q1kbYhi7ZlpYVoEQS7c3/iXeo1M3XIdAaWaTarFwGO4f11sDpEa5xUE5tntIgr0Kcggotbapm
 TztWSEjv577vUqCy9xNaDEp4YA+Z2dUw/pr+mHl9oLlsARs2SJD1QD6wIafgv3qUT/RNGAzfF
 PU2aPV/XQsyDoVIKGoh7DlOsWwltPcJVPczscE4w7zmWZcFv5qFQD8nsv3fgtSVgIAy6mec6k
 kVSTBEFRekY3UiMTCrFIjJD3UiprL6Wkjg9u7FkqoWfw1zLI9D7bhYSo5twtPAaSIuFDYpBfO
 X6yS8kpXXvQUMkDivgvJjkdnwBFv/gqkt24pCFXO6Zx8YZXGLdPp93Fx6OsbeYnKET6ZCNXi1
 1sZX7AAbdjyzaIW5Vjm+1IFPbhdP2R/82k6apHkCEfltHF6CwFjo/9I2mBuY+KPw3EsYjXNX0
 LynvUmeg8SwoGtmRZ2Pj3D7VajupqTLt++uyr0lU/JqC+emWAkREK42he2THQDgLN7BwJR+1k
 kayRcGony4D27Y5j8G1dNjRzr4o=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> This helper calls set_extent_bit with two more parameters set to default
> values, but otherwise it's purpose is not clear.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/dev-replace.c           |  4 ++--
>   fs/btrfs/extent-io-tree.h        |  6 ------
>   fs/btrfs/extent-tree.c           | 10 +++++-----
>   fs/btrfs/file-item.c             | 10 +++++-----
>   fs/btrfs/relocation.c            | 11 ++++++-----
>   fs/btrfs/tests/extent-io-tests.c | 11 ++++++-----
>   6 files changed, 24 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 78696d331639..3a0fc57d5db9 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -795,8 +795,8 @@ static int btrfs_set_target_alloc_state(struct btrfs=
_device *srcdev,
>   	while (!find_first_extent_bit(&srcdev->alloc_state, start,
>   				      &found_start, &found_end,
>   				      CHUNK_ALLOCATED, &cached_state)) {
> -		ret =3D set_extent_bits(&tgtdev->alloc_state, found_start,
> -				      found_end, CHUNK_ALLOCATED);
> +		ret =3D set_extent_bit(&tgtdev->alloc_state, found_start,
> +				     found_end, CHUNK_ALLOCATED, NULL, GFP_NOFS);
>   		if (ret)
>   			break;
>   		start =3D found_end + 1;
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index ef9d54cdee5c..5a53a4558366 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -156,12 +156,6 @@ int set_record_extent_bits(struct extent_io_tree *t=
ree, u64 start, u64 end,
>   int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
>   		   u32 bits, struct extent_state **cached_state, gfp_t mask);
>
> -static inline int set_extent_bits(struct extent_io_tree *tree, u64 star=
t,
> -		u64 end, u32 bits)
> -{
> -	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
> -}
> -
>   static inline int clear_extent_uptodate(struct extent_io_tree *tree, u=
64 start,
>   		u64 end, struct extent_state **cached_state)
>   {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 47cfb694cdbf..03b2a7c508b9 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -73,8 +73,8 @@ int btrfs_add_excluded_extent(struct btrfs_fs_info *fs=
_info,
>   			      u64 start, u64 num_bytes)
>   {
>   	u64 end =3D start + num_bytes - 1;
> -	set_extent_bits(&fs_info->excluded_extents, start, end,
> -			EXTENT_UPTODATE);
> +	set_extent_bit(&fs_info->excluded_extents, start, end,
> +		       EXTENT_UPTODATE, NULL, GFP_NOFS);
>   	return 0;
>   }
>
> @@ -5981,9 +5981,9 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>   		ret =3D btrfs_issue_discard(device->bdev, start, len,
>   					  &bytes);
>   		if (!ret)
> -			set_extent_bits(&device->alloc_state, start,
> -					start + bytes - 1,
> -					CHUNK_TRIMMED);
> +			set_extent_bit(&device->alloc_state, start,
> +				       start + bytes - 1,
> +				       CHUNK_TRIMMED, NULL, GFP_NOFS);
>   		mutex_unlock(&fs_info->chunk_mutex);
>
>   		if (ret)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index e74b9804bcde..1e364a7b74aa 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -94,8 +94,8 @@ int btrfs_inode_set_file_extent_range(struct btrfs_ino=
de *inode, u64 start,
>
>   	if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
>   		return 0;
> -	return set_extent_bits(&inode->file_extent_tree, start, start + len - =
1,
> -			       EXTENT_DIRTY);
> +	return set_extent_bit(&inode->file_extent_tree, start, start + len - 1=
,
> +			      EXTENT_DIRTY, NULL, GFP_NOFS);
>   }
>
>   /*
> @@ -438,9 +438,9 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio =
*bbio)
>   			    BTRFS_DATA_RELOC_TREE_OBJECTID) {
>   				u64 file_offset =3D bbio->file_offset + bio_offset;
>
> -				set_extent_bits(&inode->io_tree, file_offset,
> -						file_offset + sectorsize - 1,
> -						EXTENT_NODATASUM);
> +				set_extent_bit(&inode->io_tree, file_offset,
> +					       file_offset + sectorsize - 1,
> +					       EXTENT_NODATASUM, NULL, GFP_NOFS);
>   			} else {
>   				btrfs_warn_rl(fs_info,
>   			"csum hole found for disk bytenr range [%llu, %llu)",
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 38cfbd38a819..1ed8b132fe2a 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -174,8 +174,9 @@ static void mark_block_processed(struct reloc_contro=
l *rc,
>   	    in_range(node->bytenr, rc->block_group->start,
>   		     rc->block_group->length)) {
>   		blocksize =3D rc->extent_root->fs_info->nodesize;
> -		set_extent_bits(&rc->processed_blocks, node->bytenr,
> -				node->bytenr + blocksize - 1, EXTENT_DIRTY);
> +		set_extent_bit(&rc->processed_blocks, node->bytenr,
> +			       node->bytenr + blocksize - 1, EXTENT_DIRTY,
> +			       NULL, GFP_NOFS);
>   	}
>   	node->processed =3D 1;
>   }
> @@ -3051,9 +3052,9 @@ static int relocate_one_page(struct inode *inode, =
struct file_ra_state *ra,
>   			u64 boundary_end =3D boundary_start +
>   					   fs_info->sectorsize - 1;
>
> -			set_extent_bits(&BTRFS_I(inode)->io_tree,
> -					boundary_start, boundary_end,
> -					EXTENT_BOUNDARY);
> +			set_extent_bit(&BTRFS_I(inode)->io_tree,
> +				       boundary_start, boundary_end,
> +				       EXTENT_BOUNDARY, NULL, GFP_NOFS);
>   		}
>   		unlock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
>   			      &cached_state);
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io=
-tests.c
> index b9de94a50868..acaaddf7181a 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -503,8 +503,8 @@ static int test_find_first_clear_extent_bit(void)
>   	 * Set 1M-4M alloc/discard and 32M-64M thus leaving a hole between
>   	 * 4M-32M
>   	 */
> -	set_extent_bits(&tree, SZ_1M, SZ_4M - 1,
> -			CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +	set_extent_bit(&tree, SZ_1M, SZ_4M - 1,
> +		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
>
>   	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
>   				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
> @@ -516,8 +516,8 @@ static int test_find_first_clear_extent_bit(void)
>   	}
>
>   	/* Now add 32M-64M so that we have a hole between 4M-32M */
> -	set_extent_bits(&tree, SZ_32M, SZ_64M - 1,
> -			CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +	set_extent_bit(&tree, SZ_32M, SZ_64M - 1,
> +		       CHUNK_TRIMMED | CHUNK_ALLOCATED, NULL, GFP_NOFS);
>
>   	/*
>   	 * Request first hole starting at 12M, we should get 4M-32M
> @@ -548,7 +548,8 @@ static int test_find_first_clear_extent_bit(void)
>   	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED f=
lag
>   	 * being unset in this range, we should get the entry in range 64M-72=
M
>   	 */
> -	set_extent_bits(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED);
> +	set_extent_bit(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED, NUL=
L,
> +		       GFP_NOFS);
>   	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
>   				    CHUNK_TRIMMED);
>
