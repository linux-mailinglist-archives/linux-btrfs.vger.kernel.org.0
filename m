Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1F2508CA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355216AbiDTQBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiDTQBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 12:01:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF3326EB
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:58:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3385821115;
        Wed, 20 Apr 2022 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650470329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cgn4qFpM41e2WqY48wAmREq9ieLN54iqgIcTYKsTs28=;
        b=bYVVbJukQ/j10VwSaJFsAfjWjgcpC5e6rAZWRH9onD1qJE5jETUyQM+O4qYrsAL2Sj46s9
        ZDLgvZ1FSkZjVQDF4cQf5eY3BRNM7oTQ0/8Bkjcn65eEEboGs+CAaJXLYcuo/2i+QG5AIw
        vgpUH6HDRiQIAgj6syTH4sDh5tkNWrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650470329;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cgn4qFpM41e2WqY48wAmREq9ieLN54iqgIcTYKsTs28=;
        b=xn7XtW3EYcpI1UShm4LzG4qqiycWDWkgIsh2F5gbVeE6cWsN+mE9w/SH9a3julJ2F2xfQi
        tbL2W81xtpF9GECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0927813AD5;
        Wed, 20 Apr 2022 15:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Ww8AbktYGL+QQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 15:58:49 +0000
Date:   Wed, 20 Apr 2022 17:54:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Improve error reporting in
 lookup_inline_extent_backref
Message-ID: <20220420155445.GH1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220420115401.186147-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115401.186147-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 02:54:00PM +0300, Nikolay Borisov wrote:
> When iterating the backrefs in an extent item if the ptr to the
> 'current' backref record goes beyond the extent item a warning is
> generated and -ENOENT is returned. However what's more appropriate to
> debug such cases would be to return EUCLEAN and also print the in-memory
> state of the offending leaf.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 963160a0c393..5a53bcfdca83 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -895,7 +895,10 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>  	err = -ENOENT;
>  	while (1) {
>  		if (ptr >= end) {
> -			WARN_ON(ptr > end);
> +			if (WARN_ON(ptr > end)) {
> +				err = -EUCLEAN;
> +				btrfs_print_leaf(path->slots[0]);

This gives a warning, the slots array does not contain the extent buffer
pointer so this should have been path->nodes[0] but this is already in
'leaf', fixed.
