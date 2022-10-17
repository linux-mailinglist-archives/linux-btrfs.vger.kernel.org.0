Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9D601081
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 15:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJQNvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJQNvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 09:51:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F85192B7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 06:51:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB428205C5;
        Mon, 17 Oct 2022 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666014681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kT9I7HcxQLgTvkJfV7AJsXiXEkDB4pZ+Qcf/N8zcNWM=;
        b=YCpSpxuH47Q1t1RXhVDPDUMH4Rk6CQASWrcl0cgY2y6Dz1BnRM5Le7SrxVPKaTVN1mCHLV
        eOxJFN9v7db4oxs24+M4uAaOP5BfytJIJjZAjqE3irNPsrZkzmJHdRSkwILkp+ho4DAMdH
        mVt6n9QEyiNZZAFP/nDhpjWFeaZRHmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666014681;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kT9I7HcxQLgTvkJfV7AJsXiXEkDB4pZ+Qcf/N8zcNWM=;
        b=4nK8kudWFmOWXyg7Nsassuz/dQ8WsJGZsNI66JwNrIxtfwXD+fSlGi3fv/LyKWY3Z5c+DD
        TswGfbHn5vGeCQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD88413398;
        Mon, 17 Oct 2022 13:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lc0jLdldTWPqZQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 17 Oct 2022 13:51:21 +0000
Date:   Mon, 17 Oct 2022 15:51:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: fix tree mod log mishandling of reallocated
 nodes
Message-ID: <20221017135112.GP13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bc2187c559e2c2787a9de1423ab2d8176bd09ed5.1665751923.git.josef@toxicpanda.com>
 <20221017133144.GO13389@twin.jikos.cz>
 <20221017134347.GA2561014@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017134347.GA2561014@falcondesktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 02:43:47PM +0100, Filipe Manana wrote:
> > > Fixes: bd989ba359f2 ("Btrfs: add tree modification log functions")
> > 
> > Are you sure it's caused by this commit? 
> > 
> > The code was added in 485df7555425 ("btrfs: always pin deleted leaves
> > when there are active tree mod log users") and slightly modified in
> > 888dd183390d ("btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at
> > btrfs_free_tree_block()").
> 
> The fixes tag is correct.
> 
> Not dealing correctly with extent buffers that get freed and reallocated
> for multiple root nodes is something that exists since the tree mod log
> was added.
> 
> The commits you mentioned were for a different problem, pinning only leaves,
> while Josef's fix simply changes the logic to pin any extent buffer - it's
> the simplest way to fix the bug regarding root replacements.
> 
> If those commits didn't exist, the fix this problem would be the same (just
> pin any extent buffer if there are tree mod log users).

Ok, thanks. I'll tag it for stable 3.3 then but we'll need a backport
for <= 5.10, ideally applicable down to 4.9.
