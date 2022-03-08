Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D644D1EDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiCHRYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349297AbiCHRW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 12:22:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146E25549B
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 09:21:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 18543210F3;
        Tue,  8 Mar 2022 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646760055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cy3HNMPxrZXM1/1kvxHRjqQz9AiwUugVErPrDV7urpI=;
        b=eZhYXHIYuPRj6AU8bwKPajQth7CEiHU+VYDhYZ6195zO24W2F4ak/7JVN80V5cKAyhfZu1
        2fc8ysrA6KVBI3Jc9Gctpxc1OSrltROWHsSdGKLtrM/9V4h2U+1puml4NnvAtw+cRdmFmU
        zijKuUwUIwdi+Z9asmrYm9qNEscqcYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646760055;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cy3HNMPxrZXM1/1kvxHRjqQz9AiwUugVErPrDV7urpI=;
        b=LE966oJbH+dAkY09hmJBXCUu1CBuz+XqrmHMO41ARUUMcliwqD9k2MvnnEPhWbTxeui3JU
        vEiQ6pMhH5/EeuBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E4A1A3B90;
        Tue,  8 Mar 2022 17:20:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED920DA7B4; Tue,  8 Mar 2022 18:16:59 +0100 (CET)
Date:   Tue, 8 Mar 2022 18:16:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/7] btrfs-progs: check: fix check_global_roots_uptodate
Message-ID: <20220308171659.GP12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1645567860.git.josef@toxicpanda.com>
 <d62401f4e8b5294e589cd8be1ecac0082ccac56b.1645567860.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62401f4e8b5294e589cd8be1ecac0082ccac56b.1645567860.git.josef@toxicpanda.com>
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

On Tue, Feb 22, 2022 at 05:22:36PM -0500, Josef Bacik wrote:
> While running make test on other patches I noticed we are now
> segfaulting on the fuzz tests.  This is because when I converted us to a
> rb tree for the global roots we lost the ability to catch that there's
> no extent root at all.  Before we'd populate a dummy
> fs_info->extent_root with a not uptodate node, but now you simply don't
> get an extent root in the rb_tree.  Fix the check_global_roots_uptodate
> helper to count how many roots we find and make sure it matches the
> number we expect.  If it doesn't then we can return -EIO.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check/main.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 8ccba447..abe208df 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -10207,6 +10207,8 @@ static int check_global_roots_uptodate(void)
>  {
>  	struct btrfs_root *root;
>  	struct rb_node *n;
> +	int found_csum = 0, found_extent = 0, found_fst = 0;
> +	int ret = 0;
>  
>  	for (n = rb_first(&gfs_info->global_roots_tree); n; n = rb_next(n)) {
>  		root = rb_entry(n, struct btrfs_root, rb_node);
> @@ -10215,9 +10217,39 @@ static int check_global_roots_uptodate(void)
>  			      root->root_key.objectid, root->root_key.offset);
>  			return -EIO;
>  		}
> +		switch(root->root_key.objectid) {
> +		case BTRFS_EXTENT_TREE_OBJECTID:
> +			found_extent++;
> +			break;
> +		case BTRFS_CSUM_TREE_OBJECTID:
> +			found_csum++;
> +			break;
> +		case BTRFS_FREE_SPACE_TREE_OBJECTID:
> +			found_fst++;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
> -	return 0;
> +	if (found_extent != gfs_info->nr_global_roots) {
> +		error("found %d extent roots, expected %llu\n", found_extent,

Reminder for the future, the strings for error() a warning() helpers do
not need the trailing \n.
