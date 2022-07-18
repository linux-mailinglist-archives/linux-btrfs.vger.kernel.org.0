Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14757868F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 17:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiGRPnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiGRPjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 11:39:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233C1BF62
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 08:39:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0DC41FF14;
        Mon, 18 Jul 2022 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658158743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSd6u2tLPuFd4onoqvdKnCtCLx1WHRmFOEKc8OMGnkA=;
        b=wKVX1cQ7RqcxtLrca1X9zM1pAETt9Z0sNH6Z/nLExMJIeYsN24V1cLwjzY4M7kdmYWIB0b
        ykdY/SZ9Si0xqHv3aaDzHZvCZlEOAfkKg7Q8N1lyy29OmFsc6HW8To8zi4l/M1YBYoyyYL
        QhLLDza1M0l63iKG9OYcJoWncfgaNUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658158743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSd6u2tLPuFd4onoqvdKnCtCLx1WHRmFOEKc8OMGnkA=;
        b=0E8sYZkhO7ub2QJ84ozTub962EvOh1o1xw2buUr1+PFQpYtnfw4MjzQMi3Jy0cQ0fYhGob
        vJuQ9mooCrGPBjCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A886613754;
        Mon, 18 Jul 2022 15:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CWflJ5d+1WK9YQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 15:39:03 +0000
Date:   Mon, 18 Jul 2022 17:34:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: make btrfs_super_block::log_root_transid
 deprecated
Message-ID: <20220718153410.GF13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <ad5b8dbe66567eddd09025cf46114cc9412d1add.1654603274.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5b8dbe66567eddd09025cf46114cc9412d1add.1654603274.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 08:01:17PM +0800, Qu Wenruo wrote:
> This is the same on-disk format update synchronized from the kernel
> code.
> 
> Unlike kernel, there are two callers reading this member:
> 
> - btrfs inspect dump-super
>   It's just outputting the value, since it's always 0 we can skip
>   that output.
> 
> - btrfs-find-root
>   In that case, since we always got 0, the root search for log root
>   should never find a perfect match.
> 
>   Use btrfs_super_geneartion() + 1 to provide a better result.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -2014,8 +2014,6 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
>  	       (unsigned long long)btrfs_super_chunk_root_level(sb));
>  	printf("log_root\t\t%llu\n",
>  	       (unsigned long long)btrfs_super_log_root(sb));
> -	printf("log_root_transid\t%llu\n",
> -	       (unsigned long long)btrfs_super_log_root_transid(sb));

For dump super I'd like to keep it there, same as we print the value of
leafsize even if it's deprecated.

>  	printf("log_root_level\t\t%llu\n",
>  	       (unsigned long long)btrfs_super_log_root_level(sb));
>  	printf("total_bytes\t\t%llu\n",
> -- 
> 2.36.1
