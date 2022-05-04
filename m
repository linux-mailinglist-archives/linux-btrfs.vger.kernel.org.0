Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0B519957
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiEDIOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbiEDIOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 04:14:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E322530
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 01:11:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2417D1F745;
        Wed,  4 May 2022 08:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651651872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOe6C9Iu1AVI0fjfmrodBcT76hOKNtvrzljY5ks45Es=;
        b=Xn9SiT5tgtMLI5+WhU3wO2S2M3L4X/Ac+pPtX5BUaiINAORag9FB4+H27rD8WjKit1nkPd
        3SFcDt46HKUKwz6phg2wVVKdNHq1M7ZpveyKmw6NKNGF0+YSPwNAc10yCfyL7fNUvIJmYo
        +zl1hTbk5Dxi4IROyTTijaIsAU9Nr1A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3AE1132C4;
        Wed,  4 May 2022 08:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZCrXNB81cmLAZQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 04 May 2022 08:11:11 +0000
Message-ID: <b6c63093-9e5f-b8a0-39a3-3ba9af46005f@suse.com>
Date:   Wed, 4 May 2022 11:11:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] btrfs: Turn fs_roots_radix in btrfs_fs_info into an
 XArray
Content-Language: en-US
To:     Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <20220503104443.24758-1-gniebler@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <20220503104443.24758-1-gniebler@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.05.22 г. 13:44 ч., Gabriel Niebler wrote:
> … rename it to simply fs_roots and adjust all usages of this object to use
> the XArray API, because it is notionally easier to use and understand, as
> it provides array semantics, and also takes care of locking for us,
> further simplifying the code.
> 
> Also do some refactoring, esp. where the API change requires largely
> rewriting some functions, anyway.
> 
> Signed-off-by: Gabriel Niebler <gniebler@suse.com>
> ---

LGTM, one nit below but I'd like David to say what he thinks of the style.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> 
> Changes from v1:
>   - Removed unnecessary enclosing while-loops around XArray iterators (Nikolay)
>   - Renamed BTRFS_ROOT_IN_RADIX to BTRFS_ROOT_REGISTERED (Nikolay & me)
>   - Moved variable declaration into the one loop that uses it (Nikolay)
>   - Removed some unnecessary linebreaks (Nikolay)
> 
> ---
>   fs/btrfs/ctree.h             |   7 +-
>   fs/btrfs/disk-io.c           | 179 +++++++++++++++++------------------
>   fs/btrfs/extent-tree.c       |   2 +-
>   fs/btrfs/inode.c             |  13 +--
>   fs/btrfs/tests/btrfs-tests.c |   2 +-
>   fs/btrfs/transaction.c       | 113 ++++++++++------------
>   6 files changed, 149 insertions(+), 167 deletions(-)
> 

<snip>

> @@ -4872,31 +4862,34 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
>   
>   static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_root *gang[8];
> -	u64 root_objectid = 0;
> -	int ret;
> -
> -	spin_lock(&fs_info->fs_roots_radix_lock);
> -	while ((ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> -					     (void **)gang, root_objectid,
> -					     ARRAY_SIZE(gang))) != 0) {
> -		int i;
> +	unsigned long index = 0;
>   
> -		for (i = 0; i < ret; i++)
> -			gang[i] = btrfs_grab_root(gang[i]);
> -		spin_unlock(&fs_info->fs_roots_radix_lock);
> +	spin_lock(&fs_info->fs_roots_lock);
> +	while (xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
> +		struct btrfs_root *root;
> +		struct btrfs_root *roots[8];
> +		int grabbed = 0;
> +
> +		xa_for_each_start(&fs_info->fs_roots, index, root,
> +				  index) {
> +			roots[grabbed] = btrfs_grab_root(root);
> +			grabbed++;
> +			if (grabbed >= ARRAY_SIZE(roots))
> +				break;
> +		}
> +		spin_unlock(&fs_info->fs_roots_lock);
>   
> -		for (i = 0; i < ret; i++) {
> -			if (!gang[i])
> +		for (int i = 0; i < grabbed; i++) {
> +			if (!roots[i])
>   				continue;
> -			root_objectid = gang[i]->root_key.objectid;
> -			btrfs_free_log(NULL, gang[i]);
> -			btrfs_put_root(gang[i]);
> +			index = roots[i]->root_key.objectid;
> +			btrfs_free_log(NULL, roots[i]);
> +			btrfs_put_root(roots[i]);
>   		}
> -		root_objectid++;
> -		spin_lock(&fs_info->fs_roots_radix_lock);
> +		index++;
> +		spin_lock(&fs_info->fs_roots_lock);
>   	}
> -	spin_unlock(&fs_info->fs_roots_radix_lock);
> +	spin_unlock(&fs_info->fs_roots_lock);
>   	btrfs_free_log_root_tree(NULL, fs_info);
>   }
>   

nit: The xa_find/xa_for_each_start as used in this loop are really open-coded xa_extract.
So the code could be simplified even further:

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 56d4d4db976b..cb1ccebfc48c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4875,23 +4875,18 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
  static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
  {
         unsigned long index = 0;
+       int grabbed = 0;
+       struct btrfs_root *roots[8];
  
         spin_lock(&fs_info->fs_roots_lock);
-       while (xa_find(&fs_info->fs_roots, &index, ULONG_MAX, XA_PRESENT)) {
-               struct btrfs_root *root;
-               struct btrfs_root *roots[8];
-               int i;
-               int grabbed = 0;
+       while ((grabbed = xa_extract(&fs_info->fs_roots, (void **)roots, index,
+                                    ULONG_MAX, 8, XA_PRESENT))) {
  
-               xa_for_each_start(&fs_info->fs_roots, index, root, index) {
-                       roots[grabbed] = btrfs_grab_root(root);
-                       grabbed++;
-                       if (grabbed >= ARRAY_SIZE(roots))
-                               break;
-               }
+               for (int i = 0; i < grabbed; i++)
+                       roots[i] = btrfs_grab_root(roots[i]);
                 spin_unlock(&fs_info->fs_roots_lock);
  
-               for (i = 0; i < grabbed; i++) {
+               for (int i = 0; i < grabbed; i++) {
                         if (!roots[i])
                                 continue;




<snip>
