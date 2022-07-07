Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7997656ADCC
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 23:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiGGVgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 17:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbiGGVgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 17:36:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FD380;
        Thu,  7 Jul 2022 14:36:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C17F92205A;
        Thu,  7 Jul 2022 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657229808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mYgLYJaMlifJ7x7wmAVpKrfTMPScwKzKzbkVAjdwQw=;
        b=rHz/F22uoJXemg9/opH/Esb+D3hU8dXK6UYpll1C384EhonvRqIpEoXc4LVMeWhFFBCQNy
        vkaifr+nbyiSgaYeN9b5f1sz7oU/KgO5xG390m77kPX9kunihw6uAq4MvDJYmKL2iFwm9x
        rGhneOiPQ1OasxckuRM82CKSWjOQDKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657229808;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mYgLYJaMlifJ7x7wmAVpKrfTMPScwKzKzbkVAjdwQw=;
        b=6R0BC3/dmLg+VyXxo56M722XT/i/EPqwuTUfafZT78IDbvoJfP1LJks0clHGkbp9gl1Iuy
        DC6Zo9GDQyGiolCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C92A13461;
        Thu,  7 Jul 2022 21:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /z94GfBRx2KLUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 21:36:48 +0000
Date:   Thu, 7 Jul 2022 23:32:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: Replace kmap_atomic() with kmap_local_page()
Message-ID: <20220707213201.GR15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Gabriel Niebler <gniebler@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
References: <20220627174849.29962-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627174849.29962-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 27, 2022 at 07:48:49PM +0200, Fabio M. De Francesco wrote:
> kmap_atomic() is being deprecated in favor of kmap_local_page() where it
> is feasible. With kmap_local_page() mappings are per thread, CPU local,
> and not globally visible.
> 
> As far as I can see, the kmap_atomic() calls in compression.c and in
> inode.c can be safely converted.
> 
> Above all else, David Sterba has confirmed that "The context in
> check_compressed_csum is atomic [...]" and that "kmap_atomic() in inode.c
> [...] also can be replaced by kmap_local_page().".[1]
> 
> Therefore, convert all kmap_atomic() calls currently still left in fs/btrfs
> to kmap_local_page().
> 
> Tested with xfstests on a QEMU + KVM 32-bits VM with 4GB RAM and booting a
> kernel with HIGHMEM64GB enabled.
> 
> [1] https://lore.kernel.org/linux-btrfs/20220601132545.GM20
> 633@twin.jikos.cz/
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Added to the kmap patches, thanks.

> ---
> 
> Tests of groups "quick" and "compress" output several errors largely due
> to memory leaks and shift-out-of-bounds. However, these errors are exactly
> the same which are output without this and other conversions of mine to use
> kmap_local_page(). Therefore, it looks like these changes don't introduce
> regressions.
> 
> The previous RFC PATCH can be ignored:
> https://lore.kernel.org/lkml/20220624084215.7287-1-fmdefrancesco@gmail.com/
> 
> With this patch, in fs/btrfs there are no longer call sites of kmap() and
> kmap_atomic().
> 
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -332,9 +332,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  			cur_size = min_t(unsigned long, compressed_size,
>  				       PAGE_SIZE);
>  
> -			kaddr = kmap_atomic(cpage);
> +			kaddr = kmap_local_page(cpage);

After some cleanups and simplifications in checksumming functions (that
mapped the buffers) only kmap_atomic in insert_inline_extent remains, so
the final patch will be a bit shorter.

>  			write_extent_buffer(leaf, kaddr, ptr, cur_size);
> -			kunmap_atomic(kaddr);
> +			kunmap_local(kaddr);
>  
>  			i++;
>  			ptr += cur_size;
> @@ -345,9 +345,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	} else {
>  		page = find_get_page(inode->vfs_inode.i_mapping, 0);
>  		btrfs_set_file_extent_compression(leaf, ei, 0);
> -		kaddr = kmap_atomic(page);
> +		kaddr = kmap_local_page(page);
>  		write_extent_buffer(leaf, kaddr, ptr, size);
> -		kunmap_atomic(kaddr);
> +		kunmap_local(kaddr);
>  		put_page(page);
>  	}
>  	btrfs_mark_buffer_dirty(leaf);
