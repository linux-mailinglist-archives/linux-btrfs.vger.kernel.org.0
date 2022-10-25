Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8B60CBB6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJYMZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJYMZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 08:25:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AE114DDB
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 05:25:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 242562200E;
        Tue, 25 Oct 2022 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666700736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndgFFWq/zP18NS64nwUrPAz1h/f0955t9ZWKHDY9XwM=;
        b=eoVLqVdSJ2a9EtHlo5u65dyjhhDRTagdJOa42WRZca7XqMJab4T8O8CzbivA/Ha15ZmaDF
        Kq7LiwV8AuH9XPmkn+/zGyp9AV+fGEJxYWgMXjr9xnmQm3emNGehZJsGdIwZXQk6BT49SL
        8wFJLoGFqnp6nxhC+ZwMAzR3R61fv5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666700736;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ndgFFWq/zP18NS64nwUrPAz1h/f0955t9ZWKHDY9XwM=;
        b=J+kQsMV9nWwhW6tatdPMigBz5QsAPvvcQdUIfmdUp88RtJmwYqLDq6lsSHUcahvM1mI/za
        Yam2RZC2aUXU08AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0624113A64;
        Tue, 25 Oct 2022 12:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XVyrAMDVV2NAGQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 25 Oct 2022 12:25:36 +0000
Date:   Tue, 25 Oct 2022 14:25:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/9] btrfs: move btrfs_fs_info and some prototypes
Message-ID: <20221025122522.GH5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1666637013.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666637013.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 24, 2022 at 02:46:51PM -0400, Josef Bacik wrote:
> Hello,
> 
> This is the next batch of ctree.h cleanups, and likely the last one for a little
> bit.  The remaining prototypes in ctree.h are going to be touched by a lot of
> work that's currently happening, and I don't want to mess with peoples work now
> that we're getting into the development cycle a little bit.
> 
> The big thing I've done is moved btrfs_fs_info into fs.h.  This is relatively
> painless at this poing since I've organized everything up to now so I can just
> copy and paste the big chunk of it out of ctree.h into fs.h.
> 
> Then I've gone through and cleaned up a lot of randomm little things, and then
> moved some prototypes into their own headers.
> 
> I stopped where we got to the name stuff, as I know the fscrypt stuff is going
> to touch all of that.  I don't want to make that harder to merge, so I've
> stopped here so that code can go in when it's ready, and then we can pick back
> up cleaning up the rest of ctree.h.
> 
> The entirety of these changes are just code moving, there's been no functional
> changing.  Thanks,

Added to misc-next, thanks, there were only minor conflicts.
