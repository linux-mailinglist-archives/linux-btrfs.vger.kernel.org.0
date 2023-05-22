Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE50F70BBFB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjEVLgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjEVLgV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 07:36:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15591100
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 04:36:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A76F421B5A;
        Mon, 22 May 2023 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684755365;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ph1W6icmm/CeO8ZhiSjbS1oEm8kJXIxqcFuj8lKrTi8=;
        b=psJDnKTa9UOkChguJysmlySt1v9aI1cdv4SaHPFXQZjYqpXYMZUG9ORaSUuKkHOVUVMKyD
        NehqjTjdNTgayVGtY2JCZDnljwpGY+vYXMnVZr/w7GajD7NXzJoqU2Q8ZK1kd7ZSaajQUq
        nghZW3Q+jei/VbVTrzu3FQDEnqGAVNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684755365;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ph1W6icmm/CeO8ZhiSjbS1oEm8kJXIxqcFuj8lKrTi8=;
        b=iIEmVkWF8z6XD1s32H6Sl6PdgF1U/E209uedbHjNM2A597QthRqjz4YXhlPY0uG5PjhAxk
        L5ThStqPnqs6d3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EAAF13336;
        Mon, 22 May 2023 11:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EzEeIqVTa2SKPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 11:36:05 +0000
Date:   Mon, 22 May 2023 13:29:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix comment referring to no longer existing
 btrfs_clean_tree_block()
Message-ID: <20230522112959.GJ32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fc211eab020f42f28eec496aca5bbc4e58bc262a.1684320937.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc211eab020f42f28eec496aca5bbc4e58bc262a.1684320937.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 12:03:44PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's a comment at btrfs_init_new_buffer() that refers to a function
> named btrfs_clean_tree_block(), however the function was renamed to
> btrfs_clear_buffer_dirty() in commit 190a83391bc4 ("btrfs: rename
> btrfs_clean_tree_block to btrfs_clear_buffer_dirty"). So update the
> comment to refer to the current name.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
