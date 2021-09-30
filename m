Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1143D41DAA2
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbhI3NIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 09:08:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351313AbhI3NH7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 09:07:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D351F22032;
        Thu, 30 Sep 2021 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633007174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMLBqjRLd1oPHuHfs3/3/lnmu3alhPlwdtU7oQIm9As=;
        b=jMhUZ6sr6KXBJnsaG8kng5CGiZUwawNHiVAFHDMkOgQDVFyCC8kyUSxgpRQC/oQFoS2b0r
        zeNYfTnd7TXEIgLwlXq0gEvGqaSYeB3WrmnC6BkS5TDephkJAn3PetbWb6eC5JK3jjuU0k
        4kFdZrXg8RNtKFjLiwodqnGpQYkaPR4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F74513AF5;
        Thu, 30 Sep 2021 13:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9i41JEa2VWG7UwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 30 Sep 2021 13:06:14 +0000
Subject: Re: [PATCH v2] btrfs: index free space entries on size
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <a012c6719317617e9ea00f7df05f5be56029bcbb.1632928572.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <948a9d5f-a401-46e8-3dd6-9d272450544a@suse.com>
Date:   Thu, 30 Sep 2021 16:06:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a012c6719317617e9ea00f7df05f5be56029bcbb.1632928572.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 18:17, Josef Bacik wrote:

<snip>

> @@ -1887,15 +1928,37 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
>  	if (!ctl->free_space_offset.rb_node)
>  		goto out;
>  
> -	entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset), 0, 1);
> -	if (!entry)
> -		goto out;
> +	if (use_bytes_index) {
> +		node = rb_first_cached(&ctl->free_space_bytes);
> +	} else {
> +		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
> +					   0, 1);
> +		if (!entry)
> +			goto out;
> +		node = &entry->offset_index;
> +	}
>  
> -	for (node = &entry->offset_index; node; node = rb_next(node)) {
> -		entry = rb_entry(node, struct btrfs_free_space, offset_index);
> +	for (; node; node = rb_next(node)) {
> +		if (use_bytes_index)
> +			entry = rb_entry(node, struct btrfs_free_space,
> +					 bytes_index);
> +		else
> +			entry = rb_entry(node, struct btrfs_free_space,
> +					 offset_index);
> +
> +		/*
> +		 * If we are using the bytes index then all subsequent entries
> +		 * in this tree are going to be < bytes, so simply set the max
> +		 * extent size and exit the loop.
> +		 *
> +		 * If we're using the offset index then we need to keep going
> +		 * through the rest of the tree.
> +		 */
>  		if (entry->bytes < *bytes) {
>  			*max_extent_size = max(get_max_extent_size(entry),
>  					       *max_extent_size);
> +			if (use_bytes_index)
> +				break;

I think we also need this check further then in the: 

 if (entry->bytes < *bytes + align_off) {

branch, because we can very well have the largest entry satisfy the 
requested byte size, but adding the alignment might make it insufficient, 
in this case we are going to loop again with the next smaller entry 
which might still be larger than the requested bytes but insufficient 
when factoring in the alignment. This isn't a correctness issue so 
much as it causes some needless work depending on what we've cached. 

Furthermore, the correct way to fix this is to simply eliminate 
initial 'if (entry->bytes < *bytes)' check, calculate the offset 
or set it to 0 and really leave the 2nd one i.e : 

@@ -1946,22 +1954,6 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
                        entry = rb_entry(node, struct btrfs_free_space,
                                         offset_index);
 
-               /*
-                * If we are using the bytes index then all subsequent entries
-                * in this tree are going to be < bytes, so simply set the max
-                * extent size and exit the loop.
-                *
-                * If we're using the offset index then we need to keep going
-                * through the rest of the tree.
-                */W
-               if (entry->bytes < *bytes) {
-                       *max_extent_size = max(get_max_extent_size(entry),
-                                              *max_extent_size);
-                       if (use_bytes_index)
-                               break;
-                       continue;
-               }
-
                /* make sure the space returned is big enough
                 * to match our requested alignment
                 */
@@ -1975,9 +1967,20 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
                        tmp = entry->offset;
                }
 
+               /*
+                * If we are using the bytes index then all subsequent entries
+                * in this tree are going to be < bytes, so simply set the max
+                * extent size and exit the loop.
+                *
+                * If we're using the offset index then we need to keep going
+                * through the rest of the tree.
+                */
+
                if (entry->bytes < *bytes + align_off) {
                        *max_extent_size = max(get_max_extent_size(entry),
                                               *max_extent_size);
+                       if (use_bytes_index)
+                               break;
                        continue;
                }
 


<snip>
