Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499297C88E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjJMPkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPkJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 11:40:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F18B7
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 08:40:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6A7321A11;
        Fri, 13 Oct 2023 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697211605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yolwvWY/RqlZK+htKKETp/DSXyLozUiRyUJnXtJyQHs=;
        b=2kjBTF+6/Em0pMbDeTMSIg51Al4eGYkFYKzepegRMAB7njMrx7sU1uKydKptRxfcjnXq0T
        rZtQNbe0tkuzLRW0DPLiOjNeGyoxozY41TowniRXwprtc3gHOktlR/i/S1hg+YeGtanfPc
        ZlGl6wavUF97GTRr+wO6G4WkZ4xlywQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697211605;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yolwvWY/RqlZK+htKKETp/DSXyLozUiRyUJnXtJyQHs=;
        b=JlleoEw7a3sBl6t8H1bJhDfiMjQ3dz2cPeVNEtLgpTenMNWPOkVKdZwdsvAIpwX54qTGUy
        T6y/r4C2+ScoR/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990DF138EF;
        Fri, 13 Oct 2023 15:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9L+UI9VkKWUzVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Oct 2023 15:40:05 +0000
Date:   Fri, 13 Oct 2023 17:33:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use u64 for buffer sizes in the tree search ioctls
Message-ID: <20231013153317.GN2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <44cfbc3f3ee2465d776ce6926c6f1cece2511325.1697187887.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44cfbc3f3ee2465d776ce6926c6f1cece2511325.1697187887.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.96
X-Spamd-Result: default: False [-3.96 / 50.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.30)[dsterba@suse.cz];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.16)[69.19%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 13, 2023 at 10:05:48AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the tree search v2 ioctl we use the type size_t, which is an unsigned
> long, to track the buffer size in the local variable 'buf_size'. An
> unsigned long is 32 bits wide on a 32 bits architecture. The buffer size
> defined in struct btrfs_ioctl_search_args_v2 is a u64, so when we later
> try to copy the local variable 'buf_size' to the argument struct, when
> the search returns -EOVERFLOW, we copy only 32 bits which will be a
> problem on big endian systems.
> 
> Fix this by using a u64 type for the buffer sizes, not only at
> btrfs_ioctl_tree_search_v2(), but also everywhere down the call chain
> so that we can use the u64 at btrfs_ioctl_tree_search_v2().
> 
> Fixes: cc68a8a5a433 ("btrfs: new ioctl TREE_SEARCH_V2")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-btrfs/ce6f4bd6-9453-4ffe-ba00-cee35495e10f@moroto.mountain/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
