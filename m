Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A13F6D9C28
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbjDFPY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjDFPYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 11:24:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364787EEF
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Apr 2023 08:24:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8A86220C2;
        Thu,  6 Apr 2023 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680794660;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDXgpzvy+ojjHPtKgbLPkd959OZwhGSxU+rLOgghj5Q=;
        b=S6EQQXzDJvhyzPnCXzGDJtS9ySAgmLqpCzV3Hk8VdIVPAlwg+opO4bEGh8Xu43QwPgP0rL
        zUQBvYRNqmoCSrx0ob/HoQVV1yinRWAj5l7PCATETMG0kCnh7RT2sjlyGxZ4ZOraeyOCVQ
        DPCDCUM68ImiSk1V7ReCIZ+7k432GmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680794660;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDXgpzvy+ojjHPtKgbLPkd959OZwhGSxU+rLOgghj5Q=;
        b=DgyE8xs/iZ2v5EJPNRcnWZMqwPhoOv3eKJOFWcbO784RH8CSxLpiPSS5vjzZBKQCY8w/Hl
        uyKw1lNLABsUwQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B465E133E5;
        Thu,  6 Apr 2023 15:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t1zVKSTkLmRpSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 06 Apr 2023 15:24:20 +0000
Date:   Thu, 6 Apr 2023 17:24:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: avoid iterating over all indexes when logging
 directory
Message-ID: <20230406152417.GU19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680716778.git.fdmanana@suse.com>
 <2ec7d969f48957e97799a4526b7e2ff3737cd2c5.1680716778.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec7d969f48957e97799a4526b7e2ff3737cd2c5.1680716778.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 06:51:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 9ab793b638a7..c2a467276071 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3648,6 +3648,9 @@ static int flush_dir_items_batch(struct btrfs_trans_handle *trans,
>  		ret = BTRFS_LOG_FORCE_COMMIT;
>  	else
>  		inode->last_dir_index_offset = last_index;
> +
> +	if (btrfs_get_first_dir_index_to_log(inode) == 0)
> +		btrfs_set_first_dir_index_to_log(inode, batch.keys[0].offset);
>  out:
>  	kfree(ins_data);
>  
> @@ -5406,6 +5409,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  	LIST_HEAD(dir_list);
>  	struct btrfs_dir_list *dir_elem;
>  	u64 ino = btrfs_ino(start_inode);
> +	struct btrfs_inode *curr_inode = start_inode;
>  	int ret = 0;
>  
>  	/*
> @@ -5420,18 +5424,22 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  	if (!path)
>  		return -ENOMEM;
>  
> +	ihold(&curr_inode->vfs_inode);

I'll add comment why ther ref is needed, we don't have any other
instance of ihold/btrfs_add_delayed_iput pattern, all other ihold()
calls are commented.
