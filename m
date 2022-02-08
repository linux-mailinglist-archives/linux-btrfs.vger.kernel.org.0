Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FC4AE535
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 00:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiBHXIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 18:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiBHXID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 18:08:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA861C061577;
        Tue,  8 Feb 2022 15:08:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74F8221107;
        Tue,  8 Feb 2022 23:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644361681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiS+i+Yi/MMxlJxriyCYJVbMBk32ERqDOJ25GJCQbRc=;
        b=UklAC60NoSQMJKh2xX5ZaEu0/SBWz31YETthCnXLKA9ZjOXV0UZpwyXG4hdVC0T/DHIzB7
        WN/9ww9x5VUiBRwUuuPQRubP72Jrd01RUHszuF4p+rODIQtNE5NDJxsbhSimU1dyobqX1f
        xv5ihVkzMgfmqvE1mJ9KRH1aA+iYVjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644361681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiS+i+Yi/MMxlJxriyCYJVbMBk32ERqDOJ25GJCQbRc=;
        b=ClYkgGbTQO0gh5nT0MhzEyJxDDF62O4PGlIzebj9vaM86LezgE3BGvjubR+ZbyQ3yFSCfa
        T9ccYw19FeZ+KeDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6BD3AA3B88;
        Tue,  8 Feb 2022 23:08:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DFEB4DAB3E; Wed,  9 Feb 2022 00:04:20 +0100 (CET)
Date:   Wed, 9 Feb 2022 00:04:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: send: in case of IO error log it
Message-ID: <20220208230420.GJ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <20220202201437.7718-1-davispuh@gmail.com>
 <20220205184822.2968-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220205184822.2968-1-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 05, 2022 at 08:48:23PM +0200, Dāvis Mosāns wrote:
> Currently if we get IO error while doing send then we abort without
> logging information about which file caused issue.
> So log it to help with debugging.
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/send.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index d8ccb62aa7d2..b1f75fde4a19 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4999,6 +4999,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  			lock_page(page);
>  			if (!PageUptodate(page)) {
>  				unlock_page(page);
> +				btrfs_err(fs_info, "send: IO error at offset=%llu for inode=%llu root=%llu",
> +					page_offset(page), sctx->cur_ino, sctx->send_root->root_key.objectid);
>  				put_page(page);

Good point in v2, using page must be before put_page. I've slightly
reformatted the message so the lines fit to the limit.
