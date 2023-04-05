Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9E6D8502
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjDERhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:37:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97D6198
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:37:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18CCB2017B;
        Wed,  5 Apr 2023 17:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680716249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cck2jrnEE6Yxm7+mLaqEC8ODYEyxmkdLMvY0SrKQXzY=;
        b=2u7Ejz3/XjowA+WbED2AAd2kh6srrjHWCBDGym+lzeyIGBBy8108eYWjHwrjyATgNmL+Cl
        EI/anE58ZYjHkmfPA0BzcyAAU16jMMJC1YySw2xqIk1gi0GCV17ViArJI0XiTgyZiT8lxx
        NefgSLWVouwHGzJaIOCqleTmuWdMuy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680716249;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cck2jrnEE6Yxm7+mLaqEC8ODYEyxmkdLMvY0SrKQXzY=;
        b=0Rv9J49X5rTS0smAmXyh46I4iCE+czfbGkIhwtIiOmhBThqtUrHZFwhDYmn+SKsVDa+1PG
        4xtHyuAR6vzz0ECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7B5313A10;
        Wed,  5 Apr 2023 17:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQnJN9ixLWRBbQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 05 Apr 2023 17:37:28 +0000
Date:   Wed, 5 Apr 2023 19:37:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: warn for any missed cleanup at
 btrfs_close_one_device
Message-ID: <20230405173726.GM19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680619177.git.anand.jain@oracle.com>
 <584322021db1e182838b5dc9d90459850e5fcf36.1680619177.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <584322021db1e182838b5dc9d90459850e5fcf36.1680619177.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 10:55:11PM +0800, Anand Jain wrote:
> During my recent search for the root cause of a reported bug, I realized
> that it's a good idea to issue a warning for missed cleanup instead of
> using debug-only assertions. Since most installations run with debug off,
> missed cleanups and premature calls to close could go unnoticed. However,
> these issues are serious enough to warrant reporting and fixing.

There are other WARN_ONs checking for device state so it should be ok to
add some more.

> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index eead4a1f53b7..0e3677650a78 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1150,10 +1150,10 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>  	device->last_flush_error = 0;
>  
>  	/* Verify the device is back in a pristine state  */
> -	ASSERT(!test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
> -	ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
> -	ASSERT(list_empty(&device->dev_alloc_list));
> -	ASSERT(list_empty(&device->post_commit_list));
> +	WARN_ON(test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state));
> +	WARN_ON(test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state));
> +	WARN_ON(!list_empty(&device->dev_alloc_list));
> +	WARN_ON(!list_empty(&device->post_commit_list));

I'm thinking if we can reset some of the values to a safe state too, not
keeping it until the next time the device is opened, because not
everything is reset at device open time.
