Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554EF2D664
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2019 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfE2HcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 May 2019 03:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbfE2HcK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 May 2019 03:32:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A20DDAF86
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2019 07:32:08 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: Cleanup BTRFS_COMPAT_EXTENT_TREE_V0
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190529072723.31027-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <369a0318-a70d-8a1a-43cc-e7e69b10bce3@suse.com>
Date:   Wed, 29 May 2019 10:32:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529072723.31027-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.05.19 г. 10:27 ч., Qu Wenruo wrote:
> BTRFS_COMPAT_EXTENT_TREE_V0 is introduced for a short time in kernel,
> and it's over 10 years ago.
> 
> Nowadays there should be no user for that feature, and kernel has remove
> this support in Jun, 2018. There is no need for btrfs-progs to support
> it.
> 
> This patch will remove EXTENT_TREE_V0 related code and replace those
> BUG_ON() to a more graceful error message.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Kernel support for v0 was dropped so it was high time v0 support in
progs is also removed. So:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  check/main.c  |  59 ++-------------
>  ctree.c       |   5 --
>  ctree.h       |   2 -
>  extent-tree.c | 202 +++-----------------------------------------------
>  image/main.c  |  59 +--------------
>  print-tree.c  |  33 +--------
>  6 files changed, 20 insertions(+), 340 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index f6d908e99b51..731c21d364d7 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5048,27 +5048,6 @@ void free_device_extent_tree(struct device_extent_tree *tree)
>  	cache_tree_free_extents(&tree->tree, free_device_extent_record);
>  }
>  
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -static int process_extent_ref_v0(struct cache_tree *extent_cache,
> -				 struct extent_buffer *leaf, int slot)
> -{
> -	struct btrfs_extent_ref_v0 *ref0;
> -	struct btrfs_key key;
> -	int ret;
> -
> -	btrfs_item_key_to_cpu(leaf, &key, slot);
> -	ref0 = btrfs_item_ptr(leaf, slot, struct btrfs_extent_ref_v0);
> -	if (btrfs_ref_objectid_v0(leaf, ref0) < BTRFS_FIRST_FREE_OBJECTID) {
> -		ret = add_tree_backref(extent_cache, key.objectid, key.offset,
> -				0, 0);
> -	} else {
> -		ret = add_data_backref(extent_cache, key.objectid, key.offset,
> -				0, 0, 0, btrfs_ref_count_v0(leaf, ref0), 0, 0);
> -	}
> -	return ret;
> -}
> -#endif
> -
>  struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
>  					    struct btrfs_key *key,
>  					    int slot)
> @@ -5331,30 +5310,10 @@ static int process_extent_item(struct btrfs_root *root,
>  		return -EIO;
>  	}
>  	if (item_size < sizeof(*ei)) {
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -		struct btrfs_extent_item_v0 *ei0;
> -
> -		if (item_size != sizeof(*ei0)) {
> -			error(
> -	"invalid extent item format: ITEM[%llu %u %llu] leaf: %llu slot: %d",
> -				key.objectid, key.type, key.offset,
> -				btrfs_header_bytenr(eb), slot);
> -			BUG();
> -		}
> -		ei0 = btrfs_item_ptr(eb, slot, struct btrfs_extent_item_v0);
> -		refs = btrfs_extent_refs_v0(eb, ei0);
> -#else
> -		BUG();
> -#endif
> -		memset(&tmpl, 0, sizeof(tmpl));
> -		tmpl.start = key.objectid;
> -		tmpl.nr = num_bytes;
> -		tmpl.extent_item_refs = refs;
> -		tmpl.metadata = metadata;
> -		tmpl.found_rec = 1;
> -		tmpl.max_size = num_bytes;
> -
> -		return add_extent_rec(extent_cache, &tmpl);
> +		error(
> +"corrupted or unsupported extent item found, item size=%u expect minimal size=%lu",
> +		      item_size, sizeof(*ei));
> +		return -EIO;
>  	}
>  
>  	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
> @@ -6334,14 +6293,10 @@ static int run_next_block(struct btrfs_root *root,
>  				continue;
>  
>  			}
> -			if (key.type == BTRFS_EXTENT_REF_V0_KEY) {
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -				process_extent_ref_v0(extent_cache, buf, i);
> -#else
> -				BUG();
> -#endif
> +
> +			/* Skip deprecated extent ref */
> +			if (key.type == BTRFS_EXTENT_REF_V0_KEY)
>  				continue;
> -			}
>  
>  			if (key.type == BTRFS_TREE_BLOCK_REF_KEY) {
>  				ret = add_tree_backref(extent_cache,
> diff --git a/ctree.c b/ctree.c
> index f93a60e42b65..1b101c21c52d 100644
> --- a/ctree.c
> +++ b/ctree.c
> @@ -168,11 +168,6 @@ static int btrfs_block_can_be_shared(struct btrfs_root *root,
>  	     btrfs_root_last_snapshot(&root->root_item) ||
>  	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC)))
>  		return 1;
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -        if (root->ref_cows &&
> -            btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
> -                return 1;
> -#endif
>  	return 0;
>  }
>  
> diff --git a/ctree.h b/ctree.h
> index 76f52b1c9b08..9156ca4de6fd 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -56,8 +56,6 @@ struct btrfs_free_space_ctl;
>  
>  #define BTRFS_MAX_LEVEL 8
>  
> -#define BTRFS_COMPAT_EXTENT_TREE_V0
> -
>  /* holds pointers to all of the tree roots */
>  #define BTRFS_ROOT_TREE_OBJECTID 1ULL
>  
> diff --git a/extent-tree.c b/extent-tree.c
> index e62ee8c2ba13..526108cdb9f0 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -505,88 +505,6 @@ found:
>   * tree block info structure.
>   */
>  
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -static int convert_extent_item_v0(struct btrfs_trans_handle *trans,
> -				  struct btrfs_root *root,
> -				  struct btrfs_path *path,
> -				  u64 owner, u32 extra_size)
> -{
> -	struct btrfs_extent_item *item;
> -	struct btrfs_extent_item_v0 *ei0;
> -	struct btrfs_extent_ref_v0 *ref0;
> -	struct btrfs_tree_block_info *bi;
> -	struct extent_buffer *leaf;
> -	struct btrfs_key key;
> -	struct btrfs_key found_key;
> -	u32 new_size = sizeof(*item);
> -	u64 refs;
> -	int ret;
> -
> -	leaf = path->nodes[0];
> -	BUG_ON(btrfs_item_size_nr(leaf, path->slots[0]) != sizeof(*ei0));
> -
> -	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -	ei0 = btrfs_item_ptr(leaf, path->slots[0],
> -			     struct btrfs_extent_item_v0);
> -	refs = btrfs_extent_refs_v0(leaf, ei0);
> -
> -	if (owner == (u64)-1) {
> -		while (1) {
> -			if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> -				ret = btrfs_next_leaf(root, path);
> -				if (ret < 0)
> -					return ret;
> -				BUG_ON(ret > 0);
> -				leaf = path->nodes[0];
> -			}
> -			btrfs_item_key_to_cpu(leaf, &found_key,
> -					      path->slots[0]);
> -			BUG_ON(key.objectid != found_key.objectid);
> -			if (found_key.type != BTRFS_EXTENT_REF_V0_KEY) {
> -				path->slots[0]++;
> -				continue;
> -			}
> -			ref0 = btrfs_item_ptr(leaf, path->slots[0],
> -					      struct btrfs_extent_ref_v0);
> -			owner = btrfs_ref_objectid_v0(leaf, ref0);
> -			break;
> -		}
> -	}
> -	btrfs_release_path(path);
> -
> -	if (owner < BTRFS_FIRST_FREE_OBJECTID)
> -		new_size += sizeof(*bi);
> -
> -	new_size -= sizeof(*ei0);
> -	ret = btrfs_search_slot(trans, root, &key, path, new_size, 1);
> -	if (ret < 0)
> -		return ret;
> -	BUG_ON(ret);
> -
> -	ret = btrfs_extend_item(root, path, new_size);
> -	BUG_ON(ret);
> -
> -	leaf = path->nodes[0];
> -	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
> -	btrfs_set_extent_refs(leaf, item, refs);
> -	/* FIXME: get real generation */
> -	btrfs_set_extent_generation(leaf, item, 0);
> -	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
> -		btrfs_set_extent_flags(leaf, item,
> -				       BTRFS_EXTENT_FLAG_TREE_BLOCK |
> -				       BTRFS_BLOCK_FLAG_FULL_BACKREF);
> -		bi = (struct btrfs_tree_block_info *)(item + 1);
> -		/* FIXME: get first key of the block */
> -		memset_extent_buffer(leaf, 0, (unsigned long)bi, sizeof(*bi));
> -		btrfs_set_tree_block_level(leaf, bi, (int)owner);
> -	} else {
> -		btrfs_set_extent_flags(leaf, item, BTRFS_EXTENT_FLAG_DATA);
> -	}
> -	btrfs_mark_buffer_dirty(leaf);
> -	return 0;
> -}
> -#endif
> -
>  u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
>  {
>  	u32 high_crc = ~(u32)0;
> @@ -657,17 +575,6 @@ again:
>  	if (parent) {
>  		if (!ret)
>  			return 0;
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -		key.type = BTRFS_EXTENT_REF_V0_KEY;
> -		btrfs_release_path(path);
> -		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> -		if (ret < 0) {
> -			err = ret;
> -			goto fail;
> -		}
> -		if (!ret)
> -			return 0;
> -#endif
>  		goto fail;
>  	}
>  
> @@ -812,13 +719,6 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
>  		ref2 = btrfs_item_ptr(leaf, path->slots[0],
>  				      struct btrfs_shared_data_ref);
>  		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -	} else if (key.type == BTRFS_EXTENT_REF_V0_KEY) {
> -		struct btrfs_extent_ref_v0 *ref0;
> -		ref0 = btrfs_item_ptr(leaf, path->slots[0],
> -				      struct btrfs_extent_ref_v0);
> -		num_refs = btrfs_ref_count_v0(leaf, ref0);
> -#endif
>  	} else {
>  		BUG();
>  	}
> @@ -833,14 +733,6 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
>  			btrfs_set_extent_data_ref_count(leaf, ref1, num_refs);
>  		else if (key.type == BTRFS_SHARED_DATA_REF_KEY)
>  			btrfs_set_shared_data_ref_count(leaf, ref2, num_refs);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -		else {
> -			struct btrfs_extent_ref_v0 *ref0;
> -			ref0 = btrfs_item_ptr(leaf, path->slots[0],
> -					struct btrfs_extent_ref_v0);
> -			btrfs_set_ref_count_v0(leaf, ref0, num_refs);
> -		}
> -#endif
>  		btrfs_mark_buffer_dirty(leaf);
>  	}
>  	return ret;
> @@ -874,13 +766,6 @@ static noinline u32 extent_data_ref_count(struct btrfs_path *path,
>  		ref2 = btrfs_item_ptr(leaf, path->slots[0],
>  				      struct btrfs_shared_data_ref);
>  		num_refs = btrfs_shared_data_ref_count(leaf, ref2);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -	} else if (key.type == BTRFS_EXTENT_REF_V0_KEY) {
> -		struct btrfs_extent_ref_v0 *ref0;
> -		ref0 = btrfs_item_ptr(leaf, path->slots[0],
> -				      struct btrfs_extent_ref_v0);
> -		num_refs = btrfs_ref_count_v0(leaf, ref0);
> -#endif
>  	} else {
>  		BUG();
>  	}
> @@ -908,15 +793,6 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
>  	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
>  	if (ret > 0)
>  		ret = -ENOENT;
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -	if (ret == -ENOENT && parent) {
> -		btrfs_release_path(path);
> -		key.type = BTRFS_EXTENT_REF_V0_KEY;
> -		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> -		if (ret > 0)
> -			ret = -ENOENT;
> -	}
> -#endif
>  	return ret;
>  }
>  
> @@ -1041,22 +917,6 @@ again:
>  
>  	leaf = path->nodes[0];
>  	item_size = btrfs_item_size_nr(leaf, path->slots[0]);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -	if (item_size < sizeof(*ei)) {
> -		if (!insert) {
> -			err = -ENOENT;
> -			goto out;
> -		}
> -		ret = convert_extent_item_v0(trans, root, path, owner,
> -					     extra_size);
> -		if (ret < 0) {
> -			err = ret;
> -			goto out;
> -		}
> -		leaf = path->nodes[0];
> -		item_size = btrfs_item_size_nr(leaf, path->slots[0]);
> -	}
> -#endif
>  	if (item_size < sizeof(*ei)) {
>  		printf("Size is %u, needs to be %u, slot %d\n",
>  		       (unsigned)item_size,
> @@ -1064,7 +924,6 @@ again:
>  		btrfs_print_leaf(leaf);
>  		return -EINVAL;
>  	}
> -	BUG_ON(item_size < sizeof(*ei));
>  
>  	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
>  	flags = btrfs_extent_flags(leaf, ei);
> @@ -1491,17 +1350,7 @@ again:
>  		num_refs = btrfs_extent_refs(l, item);
>  		extent_flags = btrfs_extent_flags(l, item);
>  	} else {
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -			struct btrfs_extent_item_v0 *ei0;
> -			BUG_ON(item_size != sizeof(*ei0));
> -			ei0 = btrfs_item_ptr(l, path->slots[0],
> -					     struct btrfs_extent_item_v0);
> -			num_refs = btrfs_extent_refs_v0(l, ei0);
> -			/* FIXME: this isn't correct for data */
> -			extent_flags = BTRFS_BLOCK_FLAG_FULL_BACKREF;
> -#else
>  			BUG();
> -#endif
>  	}
>  	item = btrfs_item_ptr(l, path->slots[0], struct btrfs_extent_item);
>  	if (refs)
> @@ -1571,18 +1420,13 @@ again:
>  	}
>  	l = path->nodes[0];
>  	item_size = btrfs_item_size_nr(l, path->slots[0]);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
>  	if (item_size < sizeof(*item)) {
> -		ret = convert_extent_item_v0(trans, fs_info->extent_root, path,
> -					     (u64)-1, 0);
> -		if (ret < 0)
> -			goto out;
> -
> -		l = path->nodes[0];
> -		item_size = btrfs_item_size_nr(l, path->slots[0]);
> +		error(
> +"unsupported or corrupted extent item, item size=%u expect minimal size=%lu",
> +			item_size, sizeof(*item));
> +		ret = -EUCLEAN;
> +		goto out;
>  	}
> -#endif
> -	BUG_ON(item_size < sizeof(*item));
>  	item = btrfs_item_ptr(l, path->slots[0], struct btrfs_extent_item);
>  	flags |= btrfs_extent_flags(l, item);
>  	btrfs_set_extent_flags(l, item, flags);
> @@ -2114,11 +1958,6 @@ static int __free_extent(struct btrfs_trans_handle *trans,
>  				break;
>  			extent_slot--;
>  		}
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -		item_size = btrfs_item_size_nr(path->nodes[0], extent_slot);
> -		if (found_extent && item_size < sizeof(*ei))
> -			found_extent = 0;
> -#endif
>  		if (!found_extent) {
>  			BUG_ON(iref);
>  			ret = remove_extent_backref(trans, extent_root, path,
> @@ -2182,34 +2021,13 @@ static int __free_extent(struct btrfs_trans_handle *trans,
>  
>  	leaf = path->nodes[0];
>  	item_size = btrfs_item_size_nr(leaf, extent_slot);
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
>  	if (item_size < sizeof(*ei)) {
> -		BUG_ON(found_extent || extent_slot != path->slots[0]);
> -		ret = convert_extent_item_v0(trans, extent_root, path,
> -					     owner_objectid, 0);
> -		BUG_ON(ret < 0);
> -
> -		btrfs_release_path(path);
> -
> -		key.objectid = bytenr;
> -		key.type = BTRFS_EXTENT_ITEM_KEY;
> -		key.offset = num_bytes;
> -
> -		ret = btrfs_search_slot(trans, extent_root, &key, path,
> -					-1, 1);
> -		if (ret) {
> -			printk(KERN_ERR "umm, got %d back from search"
> -			       ", was looking for %llu\n", ret,
> -			       (unsigned long long)bytenr);
> -			btrfs_print_leaf(path->nodes[0]);
> -		}
> -		BUG_ON(ret);
> -		extent_slot = path->slots[0];
> -		leaf = path->nodes[0];
> -		item_size = btrfs_item_size_nr(leaf, extent_slot);
> +		error(
> +"unsupported or corrupted extent item, item size=%u expect minimal size=%lu",
> +			item_size, sizeof(*ei));
> +		ret = -EUCLEAN;
> +		goto fail;
>  	}
> -#endif
> -	BUG_ON(item_size < sizeof(*ei));
>  	ei = btrfs_item_ptr(leaf, extent_slot,
>  			    struct btrfs_extent_item);
>  	if (owner_objectid < BTRFS_FIRST_FREE_OBJECTID &&
> diff --git a/image/main.c b/image/main.c
> index 4fba8283cec7..86845dadc958 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -720,43 +720,6 @@ static int add_extent(u64 start, u64 size, struct metadump_struct *md,
>  	return 0;
>  }
>  
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -static int is_tree_block(struct btrfs_root *extent_root,
> -			 struct btrfs_path *path, u64 bytenr)
> -{
> -	struct extent_buffer *leaf;
> -	struct btrfs_key key;
> -	u64 ref_objectid;
> -	int ret;
> -
> -	leaf = path->nodes[0];
> -	while (1) {
> -		struct btrfs_extent_ref_v0 *ref_item;
> -		path->slots[0]++;
> -		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> -			ret = btrfs_next_leaf(extent_root, path);
> -			if (ret < 0)
> -				return ret;
> -			if (ret > 0)
> -				break;
> -			leaf = path->nodes[0];
> -		}
> -		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> -		if (key.objectid != bytenr)
> -			break;
> -		if (key.type != BTRFS_EXTENT_REF_V0_KEY)
> -			continue;
> -		ref_item = btrfs_item_ptr(leaf, path->slots[0],
> -					  struct btrfs_extent_ref_v0);
> -		ref_objectid = btrfs_ref_objectid_v0(leaf, ref_item);
> -		if (ref_objectid < BTRFS_FIRST_FREE_OBJECTID)
> -			return 1;
> -		break;
> -	}
> -	return 0;
> -}
> -#endif
> -
>  static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
>  			    struct metadump_struct *metadump, int root_tree)
>  {
> @@ -974,30 +937,10 @@ static int copy_from_extent_tree(struct metadump_struct *metadump,
>  				}
>  			}
>  		} else {
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -			ret = is_tree_block(extent_root, path, bytenr);
> -			if (ret < 0) {
> -				error("failed to check tree block %llu: %d",
> -					(unsigned long long)bytenr, ret);
> -				break;
> -			}
> -
> -			if (ret) {
> -				ret = add_extent(bytenr, num_bytes, metadump,
> -						 0);
> -				if (ret) {
> -					error("unable to add block %llu: %d",
> -						(unsigned long long)bytenr, ret);
> -					break;
> -				}
> -			}
> -			ret = 0;
> -#else
>  			error(
> -	"either extent tree is corrupted or you haven't built with V0 support");
> +	"either extent tree is corrupted or deprecated extent ref format");
>  			ret = -EIO;
>  			break;
> -#endif
>  		}
>  		bytenr += num_bytes;
>  	}
> diff --git a/print-tree.c b/print-tree.c
> index ab77463706c1..0d0bb5109207 100644
> --- a/print-tree.c
> +++ b/print-tree.c
> @@ -422,18 +422,8 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
>  	u64 offset;
>  	char flags_str[32] = {0};
>  
> -	if (item_size < sizeof(*ei)) {
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -		struct btrfs_extent_item_v0 *ei0;
> -		BUG_ON(item_size != sizeof(*ei0));
> -		ei0 = btrfs_item_ptr(eb, slot, struct btrfs_extent_item_v0);
> -		printf("\t\trefs %u\n",
> -		       btrfs_extent_refs_v0(eb, ei0));
> +	if (item_size < sizeof(*ei))
>  		return;
> -#else
> -		BUG();
> -#endif
> -	}
>  
>  	ei = btrfs_item_ptr(eb, slot, struct btrfs_extent_item);
>  	flags = btrfs_extent_flags(eb, ei);
> @@ -502,21 +492,6 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata)
>  	WARN_ON(ptr > end);
>  }
>  
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -static void print_extent_ref_v0(struct extent_buffer *eb, int slot)
> -{
> -	struct btrfs_extent_ref_v0 *ref0;
> -
> -	ref0 = btrfs_item_ptr(eb, slot, struct btrfs_extent_ref_v0);
> -	printf("\t\textent back ref root %llu gen %llu "
> -		"owner %llu num_refs %lu\n",
> -		(unsigned long long)btrfs_ref_root_v0(eb, ref0),
> -		(unsigned long long)btrfs_ref_generation_v0(eb, ref0),
> -		(unsigned long long)btrfs_ref_objectid_v0(eb, ref0),
> -		(unsigned long)btrfs_ref_count_v0(eb, ref0));
> -}
> -#endif
> -
>  static void print_root_ref(struct extent_buffer *leaf, int slot, const char *tag)
>  {
>  	struct btrfs_root_ref *ref;
> @@ -1310,11 +1285,7 @@ void btrfs_print_leaf(struct extent_buffer *eb)
>  			print_shared_data_ref(eb, i);
>  			break;
>  		case BTRFS_EXTENT_REF_V0_KEY:
> -#ifdef BTRFS_COMPAT_EXTENT_TREE_V0
> -			print_extent_ref_v0(eb, i);
> -#else
> -			BUG();
> -#endif
> +			printf("\t\textent ref v0 (deprecated)\n");
>  			break;
>  		case BTRFS_CSUM_ITEM_KEY:
>  			printf("\t\tcsum item\n");
> 
