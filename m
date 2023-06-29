Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE60742DC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjF2TpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF2TpR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 15:45:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168B1FE4
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 12:45:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 878021F74A;
        Thu, 29 Jun 2023 19:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688067914;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c82Oe5RQriPA7KLqNKjCgo3VKgqY6DasBq6MtAnu7KY=;
        b=FwQ4Q6mJXh1i62VYGicjUm0var/TI+pKbrEQcHBncPeNn3NnjGzWt2ON9n/5p3dJCxh/SY
        2Zx+cHaj+Bxgy+hw/nbXjTuHWWqfyMTbqMzfWairOVu0LYRkJymPLHPIsD5Cl9QHas2kZE
        RrOcWCOaVofJO52MAnjHLNe7Cu9gZeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688067914;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c82Oe5RQriPA7KLqNKjCgo3VKgqY6DasBq6MtAnu7KY=;
        b=VrwROaTuJcmiTsAePBKQUeFZPGdC6+mFVm+/KAJwkuCfa80JnkTngyS0KUrzJPLIowkhNo
        UcjWJxTR9rAvrwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60AF113905;
        Thu, 29 Jun 2023 19:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RRjMFkrfnWSDKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 19:45:14 +0000
Date:   Thu, 29 Jun 2023 21:38:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid duplicated chunk lookup during
 btrfs_map_block()
Message-ID: <20230629193845.GV16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <39b29e7b3b11bf19eb5ac4ce3276c6e218b59e21.1687927850.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b29e7b3b11bf19eb5ac4ce3276c6e218b59e21.1687927850.git.wqu@suse.com>
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

On Wed, Jun 28, 2023 at 12:52:50PM +0800, Qu Wenruo wrote:
> [INEFFICIENCY]
> Inside btrfs_map_block() we will call btrfs_get_chunk_map() twice in a
> row:
> 
>   btrfs_map_block()
>   |- btrfs_num_copies()
>   |  \- btrfs_get_chunk_map()
>   \- btrfs_get_chunk_map()
> 
> This is duplicated and has no special benefit.
> 
> [ENHANCEMENT]
> Instead of the duplicated btrfs_get_chunk_map() calls, just calculate
> the number of copies using the same extent map.
> 
> This would reduce one unnecessary rb tree lookup for the pretty hot
> btrfs_map_block().
> 
> Also to reduce the duplicated code on calculating the number of mirrors
> on RAID56, extract a helper, map_num_copies(), to do the extra RAID56
> related checks.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove @num_copies variables
>   Use map_num_copies() on @map directly.
> 
> - Add a new @out_free_em label to error out

Added to msic-next, thanks.
