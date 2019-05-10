Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD15119DC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfEJNDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 09:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:40440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727522AbfEJNDL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 09:03:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 539E4AEC6
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 13:03:09 +0000 (UTC)
Subject: Re: [PATCH 03/17] btrfs: use btrfs_crc32c() instead of
 btrfs_extref_hash()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-4-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4ec6e19d-7cd0-ab42-92b9-b6ce6ac940ce@suse.com>
Date:   Fri, 10 May 2019 16:03:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510111547.15310-4-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.05.19 г. 14:15 ч., Johannes Thumshirn wrote:
> Like btrfs_crc32c() btrfs_extref_hash() is only a shim wrapper over the
> crc32c() library function. So we can just use btrfs_crc32c() instead of
> btrfs_extref_hash().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

I agree with Chris' feedback on this and next patch, just drop them both.

> ---
>  fs/btrfs/ctree.h      | 9 ---------
>  fs/btrfs/inode-item.c | 6 +++---
>  fs/btrfs/tree-log.c   | 6 +++---
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d85541f13f65..a3479a4e4f4d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2659,15 +2659,6 @@ static inline u64 btrfs_name_hash(const char *name, int len)
>         return crc32c((u32)~1, name, len);
>  }
>  
> -/*
> - * Figure the key offset of an extended inode ref
> - */
> -static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
> -                                   int len)
> -{
> -       return (u64) crc32c(parent_objectid, name, len);
> -}
> -
>  static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
>  {
>  	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 30d62ef918b9..d2b2a64a1553 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -91,7 +91,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
>  
>  	key.objectid = inode_objectid;
>  	key.type = BTRFS_INODE_EXTREF_KEY;
> -	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
> +	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
>  
>  	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
>  	if (ret < 0)
> @@ -123,7 +123,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
>  
>  	key.objectid = inode_objectid;
>  	key.type = BTRFS_INODE_EXTREF_KEY;
> -	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
> +	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -272,7 +272,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
>  
>  	key.objectid = inode_objectid;
>  	key.type = BTRFS_INODE_EXTREF_KEY;
> -	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
> +	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6adcd8a2c5c7..f01c6e1a15ed 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1111,7 +1111,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
>  
>  			search_key.objectid = inode_objectid;
>  			search_key.type = BTRFS_INODE_EXTREF_KEY;
> -			search_key.offset = btrfs_extref_hash(parent_objectid,
> +			search_key.offset = (u64) btrfs_crc32c(parent_objectid,
>  							      victim_name,
>  							      victim_name_len);
>  			ret = 0;
> @@ -1323,7 +1323,7 @@ static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
>  	if (key.type == BTRFS_INODE_REF_KEY)
>  		key.offset = parent_id;
>  	else
> -		key.offset = btrfs_extref_hash(parent_id, name, namelen);
> +		key.offset = (u64) btrfs_crc32c(parent_id, name, namelen);
>  
>  	ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
>  	if (ret < 0)
> @@ -1901,7 +1901,7 @@ static bool name_in_log_ref(struct btrfs_root *log_root,
>  		return true;
>  
>  	search_key.type = BTRFS_INODE_EXTREF_KEY;
> -	search_key.offset = btrfs_extref_hash(dirid, name, name_len);
> +	search_key.offset = (u64) btrfs_crc32c(dirid, name, name_len);
>  	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
>  		return true;
>  
> 
