Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6699B7A0C1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjINSAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbjINSAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 14:00:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44051FFA;
        Thu, 14 Sep 2023 11:00:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A71F1F7AB;
        Thu, 14 Sep 2023 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694714402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+cFQ75Xsfc/y54rJKJbzF5p6/frJkSr0NvE88HD4UA=;
        b=kvQhAmNiCLCILxAM325ISuNhdwiCfX0sVqip6k8SbMC8BzlO1OGP+7YDIA0l55aClSDUcT
        rRtQtR64jSOl081FhP1/qGVc7/YtebQQZvegI2xFczpdXg0bYDfH9xM5CwQtaarBxvmUDb
        L2AJp/DHWGpPRkBM5qA9Z3sKYNKQDf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694714402;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+cFQ75Xsfc/y54rJKJbzF5p6/frJkSr0NvE88HD4UA=;
        b=DoRpJ6IiGIj5zrcqIm48JbbFa0HxokrxtyNkH30MHUoDkWw3CCJM38b7jhnIPQix46b1di
        OISxcTxTokZ1a/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BF1013580;
        Thu, 14 Sep 2023 18:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCDZESJKA2WsWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Sep 2023 18:00:02 +0000
Date:   Thu, 14 Sep 2023 19:59:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/11] btrfs: zoned: allow zoned RAID
Message-ID: <20230914175959.GA20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-7-15d423829637@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-raid-stripe-tree-v9-7-15d423829637@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 09:07:02AM -0700, Johannes Thumshirn wrote:
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1397,9 +1397,11 @@ static int btrfs_load_block_group_dup(struct btrfs_block_group *bg,
>  				      struct zone_info *zone_info,
>  				      unsigned long *active)
>  {
> -	if (map->type & BTRFS_BLOCK_GROUP_DATA) {
> -		btrfs_err(bg->fs_info,
> -			  "zoned: profile DUP not yet supported on data bg");
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +
> +	if (map->type & BTRFS_BLOCK_GROUP_DATA &&
> +	    !fs_info->stripe_root) {
> +		btrfs_err(fs_info, "zoned: data DUP profile needs stripe_root");

Using stripe_root for identifier is ok so we don't have overly long ones
but for user messages please use raid-stripe-tree. Fixed.
