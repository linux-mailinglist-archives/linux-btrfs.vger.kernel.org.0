Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419827429CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjF2PkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 11:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjF2PkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 11:40:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE8210B;
        Thu, 29 Jun 2023 08:40:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECE1621853;
        Thu, 29 Jun 2023 15:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688053199;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPVwQYynVMCstbm0/qwNXOwQ5cL0DyzRmvEnUJWYqbg=;
        b=XLdegP4U3l6QvhLOo0Q6yOkTe6OgG/KhMQZvIr54JKQGWJRIu3qz6DnByuQikXGc6SFCTQ
        4Ou9Yx1deghPKHw/PusntFjbPKup4l9JqEQJkKPD/4gxVkt09Po7hM1nBP5RIKe3UiKKz0
        cWJE+nb6ISZHkYxf6eTBK8XefgHM5Ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688053199;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qPVwQYynVMCstbm0/qwNXOwQ5cL0DyzRmvEnUJWYqbg=;
        b=HYMOsqSj1cCooCXY6IAZ325dxEdvIDBFpwNUa4ZKii+rCN1xC8LrnrYPeSmxRLz2i0n56j
        Wa63jAR3uU3GB3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B986913905;
        Thu, 29 Jun 2023 15:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VYYGLM+lnWT+OwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 29 Jun 2023 15:39:59 +0000
Date:   Thu, 29 Jun 2023 17:33:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Lu Hongfei <luhongfei@vivo.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] fs: btrfs: Optimize code execution process to save time
Message-ID: <20230629153331.GN16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230626100716.18935-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626100716.18935-1-luhongfei@vivo.com>
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

On Mon, Jun 26, 2023 at 06:07:16PM +0800, Lu Hongfei wrote:
> Originally, the btrfs_check_data_free_space used round_down twice when
> aligning the range, which to some extent increased the execution time of
> the code.
> After optimization, round_down only needs to be executed once, which can
> improve code efficiency and increase code readability.

But the code is not equivalent, because there is dependency on the value
of start that changes when the line is moved.

> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  fs/btrfs/delalloc-space.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index 427abaf608b8..fd33b1cf1954 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -137,9 +137,8 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
>  	int ret;
>  
>  	/* align the range */
> -	len = round_up(start + len, fs_info->sectorsize) -
> -	      round_down(start, fs_info->sectorsize);

Start is used unchanged, start + len

>  	start = round_down(start, fs_info->sectorsize);
> +	len = round_up(start + len, fs_info->sectorsize) - start;

New code uses the rounded down start for round_up, then for "- start"
it's the same (that part is ok).

The changelog should explain why the code is still doing the same, not
just that it's reducing the number of round_down() calls.
