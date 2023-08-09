Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85C7768BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHIT0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjHITZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 15:25:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D512706
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 12:24:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBD5821871;
        Wed,  9 Aug 2023 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691609090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O14y33n1JsZpgYjthaz8jn30mjq8LhYn8OYLMUyMZ+s=;
        b=EnnSACoKSJEPwn1Sxi7J10twbi6weExSx5UlqMCgKhUEt52cbxJ3DbTnoafDWQJCj0Llyz
        W20+L4yGQGC4UT9/7/Gyn9cYwYVhs8+SMNWYQX5OOHAj53vA5wK3ISt86OA7OjYukkDR41
        mi/IsvGIqCsBKelnk0pUMwGjBIk15gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691609090;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O14y33n1JsZpgYjthaz8jn30mjq8LhYn8OYLMUyMZ+s=;
        b=11Y672ogiMYr5TZoY42KLBKtmS+0j4+d4Q5JUa36gdJBzaHGXOx54I3r91sTlh0jTmjNpr
        Dkwkr4yoV9LopbAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1C25133B5;
        Wed,  9 Aug 2023 19:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ++hJMgLo02SALwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 19:24:50 +0000
Date:   Wed, 9 Aug 2023 21:24:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/3] btrfs: exit gracefully if reloc roots don't match
Message-ID: <ZNPoAZ6nNYdm8OOK@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
References: <cover.1691054362.git.wqu@suse.com>
 <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 05:20:42PM +0800, Qu Wenruo wrote:
> [BUG]
> Syzbot reported a crash that an ASSERT() got triggered inside
> prepare_to_merge().
> 
> [CAUSE]
> The root cause of the triggered ASSERT() is we can have a race between
> quota tree creation and relocation.
> 
> This leads us to create a duplicated quota tree in the
> btrfs_read_fs_root() path, and since it's treated as fs tree, it would
> have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.
> 
> The bug itself is fixed by a dedicated patch for it, but this already
> taught us the ASSERT() is not something straightforward for
> developers.
> 
> [ENHANCEMENT]
> Instead of using an ASSERT(), let's handle it gracefully and output
> extra info about the mismatch reloc roots to help debug.
> 
> Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
> merge_reloc_roots() later.
> Also replace those ASSERT(0)s with WARN_ON()s.
> 
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9db2e6fa2cb2..2bd97d2cb52e 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1916,7 +1916,38 @@ int prepare_to_merge(struct reloc_control *rc, int err)
>  				err = PTR_ERR(root);
>  			break;
>  		}
> -		ASSERT(root->reloc_root == reloc_root);
> +
> +		if (unlikely(root->reloc_root != reloc_root)) {
> +			if (root->reloc_root)
> +				btrfs_err(fs_info,
> +"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %llu, expect reloc root key (%lld %u %llu) gen %llu",
> +					  root->root_key.objectid,
> +					  root->reloc_root->root_key.objectid,
> +					  root->reloc_root->root_key.type,
> +					  root->reloc_root->root_key.offset,
> +					  btrfs_root_generation(
> +						  &root->reloc_root->root_item),
> +					  reloc_root->root_key.objectid,
> +					  reloc_root->root_key.type,
> +					  reloc_root->root_key.offset,
> +					  btrfs_root_generation(
> +						  &reloc_root->root_item));
> +			else
> +				btrfs_err(fs_info,
> +"reloc tree mismatch, root %lld has no reloc root, expect reloc root key (%lld %u %llu) gen %llu",
> +					  root->root_key.objectid,
> +					  reloc_root->root_key.objectid,
> +					  reloc_root->root_key.type,
> +					  reloc_root->root_key.offset,
> +					  btrfs_root_generation(
> +						  &reloc_root->root_item));
> +			list_add(&reloc_root->root_list, &reloc_roots);
> +			btrfs_put_root(root);
> +			btrfs_abort_transaction(trans, -EUCLEAN);
> +			if (!err)
> +				err = -EUCLEAN;
> +			break;
> +		}
>  
>  		/*
>  		 * set reference count to 1, so btrfs_recover_relocation
> @@ -1989,7 +2020,7 @@ void merge_reloc_roots(struct reloc_control *rc)
>  		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
>  					 false);
>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
> -			if (IS_ERR(root)) {
> +			if (WARN_ON(IS_ERR(root))) {
>  				/*
>  				 * For recovery we read the fs roots on mount,
>  				 * and if we didn't find the root then we marked
> @@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc)
>  				 * memory.  However there's no reason we can't
>  				 * handle the error properly here just in case.
>  				 */
> -				ASSERT(0);
>  				ret = PTR_ERR(root);
>  				goto out;
>  			}
> -			if (root->reloc_root != reloc_root) {
> +			if (WARN_ON(root->reloc_root != reloc_root)) {
>  				/*
> -				 * This is actually impossible without something
> -				 * going really wrong (like weird race condition
> -				 * or cosmic rays).
> +				 * This can happen if on-disk metadata has some
> +				 * corruption, e.g. bad reloc tree key offset.

Based on the comments, hitting that conditition is possible by corrupted
on-disk, so the WARN_ON should not be here. I did not like the ASSERT(0)
and I don't like the WARN_ON either. It's an anti-pattern and we should
not spread it.

Some hints and suggestions are documented here
https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#handling-unexpected-conditions
but we can make it more explicit how to them.
