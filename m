Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C597991B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbjIHV4c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 17:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245218AbjIHV4c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 17:56:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C551FDF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 14:56:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97AEA2019E;
        Fri,  8 Sep 2023 21:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694210183;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmDtQFu+0uWjg5QA5ysfHmB3qx2xuljBhW9mHvA7AMY=;
        b=RsyRNTiydx7qeXtO6dCPj8g/+WUfwJGsNKWIUVUoGV8OEp3LPGBoETRbMNaEKTcPF9pmRr
        xU+xfkJ1CrIKp5vP2c77sf89Yi9pS8T3xxY0bQxlydIHK7uZKXdaA1QeBDCQd0mZas3KES
        iGM3ggg867gpXKUKz7ztCGtbafoyV3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694210183;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmDtQFu+0uWjg5QA5ysfHmB3qx2xuljBhW9mHvA7AMY=;
        b=EnB4lYhWgH0ovq+jwb7REGQU6oqdISxW/05iyWFRgLMQvTRcQmvS7sVrYe/PfbJ/J3HeQh
        G9C+BmY705BM6pCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8022A131FD;
        Fri,  8 Sep 2023 21:56:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gaGFHoeY+2ScJAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 21:56:23 +0000
Date:   Fri, 8 Sep 2023 23:49:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: remove check-integrity functionality
Message-ID: <20230908214950.GY3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694154699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694154699.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 02:42:13PM +0800, Qu Wenruo wrote:
> Check-integrity is already marked deprecated, and is going to be removed
> in v6.7.
> 
> Since we're already at v6.6 cycle, let's finish the cleanup.
> 
> This patchset can be fetched from github repo, just in case some patches
> are too large for the mailing list.
> 
> The removal is based on the 3 entrance functions, and the final one to
> cleanup the remaining pieces.
> The entrance functions removal is large, but doesn't touch other files.
> 
> The last one is the complete opposite, it touches quite some files but
> nothing to do with check-integrity.[ch].

I did a quick grep for 'integrity' and there's one more cleanup to do,
btrfs_map_block() can get rid of the parameter need_raid_map as it was
just for the integrity checker and all calls now pass 1. Otherwise,
patches added to misc-next, doing in smaller steps by the entry
functions is fine.  Thanks.
