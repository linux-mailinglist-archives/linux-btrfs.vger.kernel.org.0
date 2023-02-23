Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACF16A1128
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBWUZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 15:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWUZU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 15:25:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3983B5D45C
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 12:25:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB31237D42;
        Thu, 23 Feb 2023 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677183915;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6t/GIVrQWcl38wqmhyHlyhfP/Q3hlOZlpo9QgTLfis0=;
        b=3WZsUM5VCE+oKT0gEVwFDEkaoYMQomrHdzl6nhMI/8s9ocaZuzwwaylk+t1hETu4clVFZQ
        03a4v7a6uKla6Dfy4/w7RxpxjUJSSREA3KITI66CjeDFzDe/IFnzKn/HR9UrJ1cUigv2fJ
        Rb8Yk6ZCu2R96GP8zL6fG0KGGxuyC+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677183915;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6t/GIVrQWcl38wqmhyHlyhfP/Q3hlOZlpo9QgTLfis0=;
        b=2CjTN+XMnf09yWTFSGYS6sCWUTp4iSTIfQeUrz3BvW1tMqXje7I0WnWzZTazw/JuJBAkhl
        6k2K0cqLf74o5OAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A932B139B5;
        Thu, 23 Feb 2023 20:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k83fJ6vL92NhWgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 20:25:15 +0000
Date:   Thu, 23 Feb 2023 21:19:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make btrfs_bin_search a macro
Message-ID: <20230223201918.GZ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <520705d35cbfb6c21d1e89481f8a4d0343daa138.1676986303.git.anand.jain@oracle.com>
 <8b986d23bf05684ae37102993b406e4e582dec39.1676991868.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b986d23bf05684ae37102993b406e4e582dec39.1676991868.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 11:09:30PM +0800, Anand Jain wrote:
> btrfs_bin_search() is an inline function that wraps
> btrfs_generic_bin_search() and sets the second argument to 0.
> 
> The inline compiler directive is not always guaranteed to work,
> unless the __always_inline directive is used.
> 
> Further, this function is small and can be a #define macro as well.
> Make btrfs_bin_search() a macro.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: remove extra ; for define
> 
>  fs/btrfs/ctree.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 97897107fab5..1e1b8f4992a3 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -515,15 +515,9 @@ int btrfs_generic_bin_search(struct extent_buffer *eb, int first_slot,
>   * Simple binary search on an extent buffer. Works for both leaves and nodes, and
>   * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
>   */
> -static inline int btrfs_bin_search(struct extent_buffer *eb,
> -				   const struct btrfs_key *key,
> -				   int *slot)
> -{
> -	return btrfs_generic_bin_search(eb, 0, key, slot);
> -}
> +#define btrfs_bin_search(eb, key, slot) \
> +		btrfs_generic_bin_search(eb, 0, key, slot)
>  
> -int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
> -		     int *slot);

I don't see much reason to do that, the static inline defined in a header
works as expected and is inlined where used and then it's up to the
compiler to decide if it'll be combined, partitoned or optimized in
other ways.

We don't need such a simple wrapper if the only difference is the added
start offset so you can keep btrfs_bin_search and add the same
parameters as btrfs_generic_bin_search has now.

>  int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
>  int btrfs_previous_item(struct btrfs_root *root,
>  			struct btrfs_path *path, u64 min_objectid,
> -- 
> 2.38.1
