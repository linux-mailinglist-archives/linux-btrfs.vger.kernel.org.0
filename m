Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E0B5F7BB7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJGQnD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJGQm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 12:42:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA7012BBB3;
        Fri,  7 Oct 2022 09:42:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B94471F8B8;
        Fri,  7 Oct 2022 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665160972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaccSeUGZu2fvON00lDt3tYKp6gt1Hbc3QbH4jnVy4o=;
        b=oeuK6ZjFLeBc8JAYHAay2Fo4Q6BqWXItBqzVcHAsLo3DhVLLXb4yY4cM0nlS8T8kPq81Zq
        m/C3CLhmmeac5IFpNMFSOTATpKCJ6IelXfaWX7vhzX772Qsw/woVDYU6Oa2raPuzGZm2VT
        iKZFvoSEfgkKA5NhAsSWr0ZhXPDrv/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665160972;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HaccSeUGZu2fvON00lDt3tYKp6gt1Hbc3QbH4jnVy4o=;
        b=cYg8Z88QEHxpqrwCwiND9kX05dehEkONGP/NoSQ9SDO+UkL/3IqxHZ044aXwRrGaWzlJCm
        nBGlvRGUL3hKrzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A59313A3D;
        Fri,  7 Oct 2022 16:42:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HQr6HAxXQGMZSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 07 Oct 2022 16:42:52 +0000
Date:   Fri, 7 Oct 2022 18:42:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     liujing <liujing@cmss.chinamobile.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fixed an incorrect variable assignment
Message-ID: <20221007164249.GU13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220916031149.6140-1-liujing@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916031149.6140-1-liujing@cmss.chinamobile.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 15, 2022 at 11:11:49PM -0400, liujing wrote:
> In the btrfs_reclaim_bgs_work function, 
> there is an assignment of int ret =0, 
> but this assignment is not used in the following code, 
> so it can be defined as int ret.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>  fs/btrfs/block-group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c52b6e245b9a..a4c7fb423244 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1571,7 +1571,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>  		u64 zone_unusable;
> -		int ret = 0;
> +		int ret;

I'm not sure we need to fix that, is it fixing some warning? Also please
rephrase the subject, it's not 'incorrect', the code works as expected
but the initial value is not used.
