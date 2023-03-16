Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA06BD461
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 16:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCPPxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCPPxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 11:53:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C326152F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 08:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F6FF21A10;
        Thu, 16 Mar 2023 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678981999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ljq8eRB/mVgx2pkO0r2+Sv5Ho/7viGMqjyyV+9dYzEw=;
        b=osJyNteiQGWhdXUt+Ufx3E25nY46Cd+x87QcKbq0N8dwdm4g+5UKI14tR7W7JoSSER1PXd
        C50/4u/8uouqVWkC2f50KmDtU6k9OjvwOWxJ7lVJF8/gi+iIay0mUzlYPGo3Amx+R7eCCL
        bxOE6aqzxvbJAswN1AtcU5k4gW2IkWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678981999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ljq8eRB/mVgx2pkO0r2+Sv5Ho/7viGMqjyyV+9dYzEw=;
        b=dK7yCWGxXoAjo9wYI3q7zPD10VyL6t2JSi/dYUV2I/M8h9uGTsb1SStGV0rxg7FQYdMfKy
        IJvXEa2wqjotyOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F33133E0;
        Thu, 16 Mar 2023 15:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id osEMH287E2QBGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Mar 2023 15:53:19 +0000
Date:   Thu, 16 Mar 2023 16:47:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: balance: fix some cases wrongly parsed as
 old syntax
Message-ID: <20230316154712.GB10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220914055846.52008-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914055846.52008-1-wangyugui@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 14, 2022 at 01:58:46PM +0800, Wang Yugui wrote:
> Some cases of 'btrfs balance' are wrongly parsed as old syntax.
> 
> an example:
> $ btrfs balance status
> ERROR: cannot access 'status': No such file or directory
> 
> currently, only 'start' is successfully excluded in the check of old syntax.
> fix it by adding others in the check of old syntax.
> 
> Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>

Added to devel with some minor updates, thanks.
