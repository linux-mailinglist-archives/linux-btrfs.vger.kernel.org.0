Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE11F5C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 15:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfEONpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 09:45:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfEONpr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 09:45:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A919AD70
        for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2019 13:45:44 +0000 (UTC)
Subject: Re: [PATCH] btrfs: fiemap: preallocate ulists for btrfs_check_shared
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     fdmanana@suse.com
References: <20190515133104.1364-1-dsterba@suse.com>
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
Message-ID: <aa32ffbf-256f-e988-3fb1-f440f18d6909@suse.com>
Date:   Wed, 15 May 2019 16:45:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515133104.1364-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.05.19 г. 16:31 ч., David Sterba wrote:
> btrfs_check_shared looks up parents of a given extent and uses ulists
> for that. These are allocated and freed repeatedly. Preallocation in the
> caller will avoid the overhead and also allow us to use the GFP_KERNEL
> as it is happens before the extent locks are taken.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Looks good, one minor nit worth considering below, otherwise:


Reviewed-by: Nikolay Borisov <nborisov@suse.com>


> ---
>  fs/btrfs/backref.c   | 17 ++++++-----------
>  fs/btrfs/backref.h   |  3 ++-
>  fs/btrfs/extent_io.c | 15 +++++++++++++--
>  3 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 982152d3f920..89116afda7a2 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1465,12 +1465,11 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>   *
>   * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
>   */
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
> +int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> +		struct ulist *roots, struct ulist *tmp)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct btrfs_trans_handle *trans;
> -	struct ulist *tmp = NULL;
> -	struct ulist *roots = NULL;
>  	struct ulist_iterator uiter;
>  	struct ulist_node *node;
>  	struct seq_list elem = SEQ_LIST_INIT(elem);
> @@ -1481,12 +1480,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
>  		.share_count = 0,
>  	};
>  
> -	tmp = ulist_alloc(GFP_NOFS);
> -	roots = ulist_alloc(GFP_NOFS);
> -	if (!tmp || !roots) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	ulist_init(roots);
> +	ulist_init(tmp);
>  
>  	trans = btrfs_attach_transaction(root);
>  	if (IS_ERR(trans)) {
> @@ -1527,8 +1522,8 @@ int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr)
>  		up_read(&fs_info->commit_root_sem);
>  	}
>  out:
> -	ulist_free(tmp);
> -	ulist_free(roots);
> +	ulist_release(roots);
> +	ulist_release(tmp);

nit: If we turn these into ulist_reinit there is no need to do ulit_init
at the beginning. Having said that, the only difference between
ulist_release/init is that the latter also does ulist->nnode=0 (apart
form the memory freeing). So ulist_release can really boil down to:

list_for_each_entry_safe() {
kfree}
ulist_init(ulist)


>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 54d58988483a..777f61dc081e 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -57,7 +57,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
>  			  u64 start_off, struct btrfs_path *path,
>  			  struct btrfs_inode_extref **ret_extref,
>  			  u64 *found_off);
> -int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr);
> +int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> +		struct ulist *roots, struct ulist *tmp_ulist);
>  
>  int __init btrfs_prelim_ref_init(void);
>  void __cold btrfs_prelim_ref_exit(void);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 13fca7bfc1f2..d70a602a5d48 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4557,6 +4557,13 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		return -ENOMEM;
>  	path->leave_spinning = 1;
>  
> +	roots = ulist_alloc(GFP_KERNEL);
> +	tmp_ulist = ulist_alloc(GFP_KERNEL);
> +	if (!roots || !tmp_ulist) {
> +		ret = -ENOMEM;
> +		goto out_free_ulist;
> +	}
> +
>  	start = round_down(start, btrfs_inode_sectorsize(inode));
>  	len = round_up(max, btrfs_inode_sectorsize(inode)) - start;
>  
> @@ -4568,7 +4575,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			btrfs_ino(BTRFS_I(inode)), -1, 0);
>  	if (ret < 0) {
>  		btrfs_free_path(path);
> -		return ret;
> +		goto out_free_ulist;
>  	} else {
>  		WARN_ON(!ret);
>  		if (ret == 1)
> @@ -4677,7 +4684,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			 */
>  			ret = btrfs_check_shared(root,
>  						 btrfs_ino(BTRFS_I(inode)),
> -						 bytenr);
> +						 bytenr, roots, tmp_ulist);
>  			if (ret < 0)
>  				goto out_free;
>  			if (ret)
> @@ -4723,6 +4730,10 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	btrfs_free_path(path);
>  	unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
>  			     &cached_state);
> +
> +out_free_ulist:
> +	ulist_free(roots);
> +	ulist_free(tmp_ulist);
>  	return ret;
>  }
>  
> 
