Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3148B6983C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBOSqV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 13:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjBOSqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 13:46:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF23E639
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 10:45:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43E9A1FD99;
        Wed, 15 Feb 2023 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676486708;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7kWWR92W/hGMZWrwmCgr2WkRMpLjbmHe9ba6LJBLhMk=;
        b=c3sMLqLkCi0tJKd+B17vPvauVqJOH2E3blTyCEzeNcVbdgY6lah8luMvkge2q7ZegdjXmR
        CmvvnvR7DxOyZjA/da7CovPtrNyn7ryob23+WulwNquRlBcFnnrHO3HxXBrk6JQzh1/Tn2
        JEjhB/VWGSdWqbzvMassGq2IcvrnIX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676486708;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7kWWR92W/hGMZWrwmCgr2WkRMpLjbmHe9ba6LJBLhMk=;
        b=kFzPScB8rsWwLE1jtQ2/ZD9ORVibf/C6RjhYoXzCzT5PVkyAFVDv4R/a6ddUmsrSgZQ+xz
        aItmgQi4PQ4VHPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2741413483;
        Wed, 15 Feb 2023 18:45:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NNSpCDQo7WPIdwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 18:45:08 +0000
Date:   Wed, 15 Feb 2023 19:39:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix emission of invalid paths when issuing
 utimes commands
Message-ID: <20230215183915.GT28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1a3cca74c6033ba5312e68bda061eac3019848d4.1676031737.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3cca74c6033ba5312e68bda061eac3019848d4.1676031737.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 10, 2023 at 12:29:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During an incremental send, when processing the new reference for a
> directory that was renamed/moved to another directory, we need to cache
> an utimes operation for the old parent directory. However if the utimes
> cache is full, we remove the LRU entry and issue a utimes command for the
> inode associated with that entry. It may happen that the full path for
> the inode that the entry refers to, contains the directory that we are
> processing and have just renamed, in which case we generate a path for
> the utimes operation that contains the old name/location of the directory,
> resulting in the receiver to fail.
> 
> So fix this by never removing an entry from the utimes cache when it's
> full and we are adding a new entry to it. Instead trim the cache only
> after finishing processing an inode, after the current send progress is
> updated.
> 
> The issue was introduced by the following patch:
> 
>    "btrfs: send: cache utimes operations for directories if possible"

Folded to the patch, thanks.
