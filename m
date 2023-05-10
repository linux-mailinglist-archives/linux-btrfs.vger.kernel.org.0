Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11C6FE286
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjEJQbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEJQbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 12:31:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D51993
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 09:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDC2C1F461;
        Wed, 10 May 2023 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683736294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7J4IxvNxIqphvvaYH1yv5WNeaykZJOQBOFFJ2Yd/tKA=;
        b=C90mdC6knLOlxLAbgH2dBZrxevNfuJ6WHkqss+SDf6vvX8CwA0JmY1fjgc/BOrffK9Ccct
        sST+YIwq8APmI51yP/5C5d84oWGWZyPivhlnKEWKxW/5do92PtXV/OEcb0jdF/rHV0yA4B
        +rjHKXUMSOvStEFB4Bo7I7Z7iePmTtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683736294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7J4IxvNxIqphvvaYH1yv5WNeaykZJOQBOFFJ2Yd/tKA=;
        b=PL3iY3hjUnpDlQKTv0m97kK4U54Jd3GSb08RWu8QBcizxSKdxEBLoc6U0wf54Hqv+Gbx1H
        tF4FmZ2SLvpcO1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6561138E5;
        Wed, 10 May 2023 16:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NNF5L+bGW2SicgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 10 May 2023 16:31:34 +0000
Date:   Wed, 10 May 2023 18:25:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: write_and_map_eb() cleanup
Message-ID: <20230510162535.GS32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1683632614.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683632614.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 09, 2023 at 07:48:37PM +0800, Qu Wenruo wrote:
> During my convert fixes, I found a lot of locations allocating a dummy
> extent buffer with a size which is not nodesize.
> 
> Then just read data into that dummy eb, and later call
> write_and_map_eb() to write it back.
> 
> This behavior is a historic workaround, at a time where we only do
> proper RAID56 writeback for metadata, but not data.
> 
> But now we have all raid56 handling done properly, and has proper
> function to read/write any logical bytenr, read_data_from_disk() and
> write_data_to_disk().
> 
> Thus there is no longer any need to use write_and_map_eb() as a
> workaround.
> 
> This patchset would completely remove write_and_map_eb(), most call
> sites are just abuse, only 3 call sites are valid but can easily be
> converted to call write_data_to_disk().
> 
> Qu Wenruo (3):
>   btrfs-progs: split btrfs_direct_pio() functions into two
>   btrfs-progs: constify the buffer pointer for write functions
>   btrfs-progs: remove write_and_map_eb()

Added to devel, thanks.
