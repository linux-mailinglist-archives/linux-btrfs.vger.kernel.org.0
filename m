Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE0BD043
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbfIXRJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730515AbfIXRJC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB590AD5F;
        Tue, 24 Sep 2019 17:08:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 68295DA835; Tue, 24 Sep 2019 19:09:20 +0200 (CEST)
Date:   Tue, 24 Sep 2019 19:09:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Properly handle backref_in_log retval
Message-ID: <20190924170920.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190830144449.23882-1-nborisov@suse.com>
 <20190830144449.23882-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830144449.23882-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 30, 2019 at 05:44:48PM +0300, Nikolay Borisov wrote:
> This function can return a negative error value if btrfs_search_slot
> errors for whatever reason or if btrfs_alloc_path runs out of memory.
> This is currently problemattic because backref_in_log is treated by its
> callers as if it returns boolean.
> 
> Fix this by adding proper error handling in callers. That also enables
> the function to return the direct error code from btrfs_search_slot.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/tree-log.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 369046a754b0..ca294ff463de 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -952,10 +952,8 @@ static noinline int backref_in_log(struct btrfs_root *log,
>  		return -ENOMEM;
>  
>  	ret = btrfs_search_slot(NULL, log, key, path, 0, 0);
> -	if (ret != 0) {
> -		ret = 0;
> +	if (ret != 0)
>  		goto out;
> -	}

Is this correct? Before: nonzero -> zero, after the nonzero value is
returned from the function. The return value is checked by the callers
but this obscures the fact that it comes from btrfs_search_slot and is
not just 0 or < 0.

Because search slot returns 1 in case it does not find the key, which
is translated to ENOENT in some contexts. Here it would be "false", as
the reference is not found. So logically the return code of search slot
and find backref is inverted.

Due to this inverted logic I'd rather avoid propagating the semantics of
search slot error value and always make it obvious that it follows the
natural expectations after reading the code like:

	ret = backref_in_log()
	if (ret < 0)
		return ...;
	if (ret == 0)
		/* no, backref is not in log */
	if (ret > 0)
		/* yes, backref is in the log */

>  	if (key->type == BTRFS_INODE_EXTREF_KEY)
>  		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
> @@ -1026,10 +1024,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
>  					   (unsigned long)(victim_ref + 1),
>  					   victim_name_len);
>  
> -			if (!backref_in_log(log_root, &search_key,
> -					    parent_objectid,
> -					    victim_name,
> -					    victim_name_len)) {
> +			ret = backref_in_log(log_root, &search_key,
> +					     parent_objectid, victim_name,
> +					     victim_name_len);
> +			if (ret < 0) {
> +				kfree(victim_name);
> +				return ret;
> +			} else if (!ret) {
>  				inc_nlink(&inode->vfs_inode);
>  				btrfs_release_path(path);
>  
> @@ -1091,10 +1092,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
>  			search_key.offset = btrfs_extref_hash(parent_objectid,
>  							      victim_name,
>  							      victim_name_len);
> -			ret = 0;
> -			if (!backref_in_log(log_root, &search_key,
> -					    parent_objectid, victim_name,
> -					    victim_name_len)) {
> +			ret = backref_in_log(log_root, &search_key,
> +					     parent_objectid, victim_name,
> +					     victim_name_len);
> +			if (ret < 0) {
> +				return ret;
> +			} else if (!ret) {
>  				ret = -ENOENT;
>  				victim_parent = read_one_inode(root,
>  						parent_objectid);
> @@ -1869,16 +1872,19 @@ static bool name_in_log_ref(struct btrfs_root *log_root,
>  			    const u64 dirid, const u64 ino)
>  {
>  	struct btrfs_key search_key;
> +	int ret;
>  
>  	search_key.objectid = ino;
>  	search_key.type = BTRFS_INODE_REF_KEY;
>  	search_key.offset = dirid;
> -	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
> +	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
> +	if (ret == 1)
>  		return true;
>  
>  	search_key.type = BTRFS_INODE_EXTREF_KEY;
>  	search_key.offset = btrfs_extref_hash(dirid, name, name_len);
> -	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
> +	ret = backref_in_log(log_root, &search_key, dirid, name, name_len);
> +	if (ret == 1)
>  		return true;

The error handling in the code snippets above seems to follow the
exptected logic but I don't see that it's correct due to the search slot
value inversion.
