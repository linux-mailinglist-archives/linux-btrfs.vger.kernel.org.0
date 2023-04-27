Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFEE6F0EC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Apr 2023 01:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbjD0XNc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 19:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0XNb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 19:13:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193512701
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 16:13:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4FB01FEF1;
        Thu, 27 Apr 2023 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682637208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9W83B52F4eTr+ds8Wx3F0MOwXV0CQXr2OA6s1HWPKBk=;
        b=A+/vLtb7bJgqVqjPVcW8wd81PK6By0SfKNnURhwhxGdm05eLQXX2DQCAK27lWDhQFpELn6
        z2uY4vKpIOz9sA41LARLaNOIRmNgRjTLn3EZKLNGmQE0eSxPpdXxAg0NcfdXpUYUNaVMSF
        BSpWB5MadMCjS1ukrEZYBBcycHzeTPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682637208;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9W83B52F4eTr+ds8Wx3F0MOwXV0CQXr2OA6s1HWPKBk=;
        b=2D7htKH4y+Yyc6ZpUTYh1KsHx/L9tZPFH/3lqNS7CrZUUj6jvI4ZYzQUIsZm6KwimGePXI
        OW5T3RW/lEQH1uCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C940138F9;
        Thu, 27 Apr 2023 23:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34BfJZgBS2RgCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Apr 2023 23:13:28 +0000
Date:   Fri, 28 Apr 2023 01:13:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: tag as unlikely the key comparison when
 checking sibling keys
Message-ID: <20230427231314.GI19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1682505780.git.fdmanana@suse.com>
 <8e323961434327423faeea50a3c6a09ff82a364b.1682505780.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e323961434327423faeea50a3c6a09ff82a364b.1682505780.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023 at 11:51:37AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When checking siblings keys, before moving keys from one node/leaf to a
> sibling node/leaf, it's very unexpected to have the last key of the left
> sibling greater than or equals to the first key of the right sibling, as
> that means we have a (serious) corruption that breaks the key ordering
> properties of a b+tree. Since this is unexpected, surround the comparison
> with the unlikely macro, which helps the compiler generate better code
> for the most expected case (no existing b+tree corruption). This is also
> what we do for other unexpected cases of invalid key ordering (like at
> btrfs_set_item_key_safe()).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a061d7092369..c315fb793b30 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2707,7 +2707,7 @@ static bool check_sibling_keys(struct extent_buffer *left,
>  		btrfs_item_key_to_cpu(right, &right_first, 0);
>  	}
>  
> -	if (btrfs_comp_cpu_keys(&left_last, &right_first) >= 0) {
> +	if (unlikely(btrfs_comp_cpu_keys(&left_last, &right_first) >= 0)) {
>  		btrfs_crit(left->fs_info, "left extent buffer:");
>  		btrfs_print_tree(left, false);
>  		btrfs_crit(left->fs_info, "right extent buffer:");

Yeah, this is the pattern for unlikely(), compiler unfortunately does
not recognize the cold functions like printk in the statement block so
the manual annotations are needed. There's a minor effect on assembly,
some of the instructions are reordered.
