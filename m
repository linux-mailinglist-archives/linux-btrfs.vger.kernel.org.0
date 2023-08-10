Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1DD7777DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHJML3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHJML2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 08:11:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048501728;
        Thu, 10 Aug 2023 05:11:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B870C2186C;
        Thu, 10 Aug 2023 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691669486;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDvuR+NQ1qVplfsadcGTsAoWABUbAgZ+gfxz0UYjYE4=;
        b=b6plZceF5/buApDDE3RkclzMQbAiTSuZ+uJbuQqy7JTyjTuO+XW0+D0YHAwBoPL8re6798
        Z908KolgfD8Dugl4TutOhf1KEU4z8Tdh3/z7jGblqPkQOFiXcHh/i1BRnV5aPccynbArCH
        Lkc0sHMVTSyd/zH+iHs0jxLA7qbSDGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691669486;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDvuR+NQ1qVplfsadcGTsAoWABUbAgZ+gfxz0UYjYE4=;
        b=neSpOmR1eK+Ef2Jj6ogOofwnaHdwG9++SWxZR7ASgEgK2MDb2+Q86Hp/HjauKJDm0L0sJ/
        My7uwMNMfRjAXqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74D1D138E0;
        Thu, 10 Aug 2023 12:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UOFxG+7T1GTxSAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 12:11:26 +0000
Date:   Thu, 10 Aug 2023 14:05:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     josef@toxicpanda.com, dsterba@suse.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoshoukui <xiaoshoukui@ruijie.com.cn>
Subject: Re: [PATCH] btrfs: fix return value when race occur between balance
 and cancel/pause
Message-ID: <20230810120501.GA2420@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230810034810.23934-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810034810.23934-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 09, 2023 at 11:48:10PM -0400, xiaoshoukui wrote:
> Issue a pause or cancel IOCTL request after judging that there is no
> pause or cancel request on the path of __btrfs_balance to return 0,
> which will mislead the user that the pause or cancel requests are
> successful.In fact, the balance request has not been paused or canceled.
> 
> On that race condition, a non-zero errno should be returned to the user.
> 
> Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> ---
>  fs/btrfs/fs.h      |  6 ++++++
>  fs/btrfs/volumes.c | 14 +++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..c27def881922 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -93,6 +93,12 @@ enum {
>  	 */
>  	BTRFS_FS_BALANCE_RUNNING,
>  
> +	/* Indicate that balance has been paused. */
> +	BTRFS_FS_BALANCE_PAUSED,
> +
> +	/* Indicate that balance has been canceled. */
> +	BTRFS_FS_BALANCE_CANCELED,

I don't like that the status is tracked in several bits like that, in
addition to the already complicated locking and state transitions of
restarted balance. I think this is a hint that some things can be
simplified or combined together, though it could be difficult
