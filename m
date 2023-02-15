Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269316983B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBOSoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 13:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBOSoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 13:44:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24533E0AA
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 10:43:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F05233978;
        Wed, 15 Feb 2023 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676486577;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBGGPeRRl3XWs3hH+AL3wwU16JdHu7BGSLIccqekrXY=;
        b=gkL5+0x81he1yYM1egUqG4LHagw8s5Se9TWgM4bv7J4DkbCV3qe5ZNAF/hXoHDq59uloUu
        cDhpO26WBWuFzLigO7C3KwTZC6wuKNQKfwEyEFGGXvdpjGGAqV5jmwDUSciGMfhOT/xZr3
        ctY+hepKsT0GHXWbQisIkdkqEA84dc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676486577;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pBGGPeRRl3XWs3hH+AL3wwU16JdHu7BGSLIccqekrXY=;
        b=Wkhm7PBF3EaiCNM9gq8PbaHuCfei6pe73UNhp8XHBeAMydnz/YDohegnDx4Ez1F/okHe2p
        4PEFKboEjUYKEEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74BC213483;
        Wed, 15 Feb 2023 18:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L+ONG7En7WPzdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Feb 2023 18:42:57 +0000
Date:   Wed, 15 Feb 2023 19:37:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: fix cache entry leak after failure to add
 it to the name cache
Message-ID: <20230215183704.GS28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d012eb57320bc93ec45583a7ff86575060bcf51c.1676031742.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d012eb57320bc93ec45583a7ff86575060bcf51c.1676031742.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 10, 2023 at 12:27:35PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At __get_cur_name_and_parent(), if we fail to insert a name cache entry to
> the name cache, we end up returning without freeing the entry, resulting
> in a memory leak. Fix this by freeing the entry if the insertion fails.
> 
> The issue was introduced by the following patch:
> 
>   "btrfs: send: use the lru cache to implement the name cache"

Folded to the patch, thanks.
