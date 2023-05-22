Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085970BBC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjEVL1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjEVL1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 07:27:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B4184
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 04:26:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C18B621B2E;
        Mon, 22 May 2023 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684754782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HghX5bYs/pwMBy2z9i9y6UGfyMCNjOLY8bmsqFEenz4=;
        b=R5IEVTAYO92HLtckrqNJK1laR1JqurnIToZRveW69baEVpwVYq+ucGlTZI3hFwRSqNJjka
        HygFg4vWxBwTV7MALZS+8iVmS+ok7A9JvfWl2ARWRMJcf1n1i1eihMxUs0xa4QYpnQDBkU
        NTq7vI/C3qxvFtOgKpV06HGI/T31YpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684754782;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HghX5bYs/pwMBy2z9i9y6UGfyMCNjOLY8bmsqFEenz4=;
        b=tYGqHr7YBFEQITSkaViG8oZXptDOoRSPIpXWEd7UfuSq6R2ooSS1pUo0+2ySWSdeqEsCM1
        qe0oguGMqbbe1CCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6E1E139F5;
        Mon, 22 May 2023 11:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zAyCJ15Ra2QQOAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 11:26:22 +0000
Date:   Mon, 22 May 2023 13:20:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: some minor log tree updates
Message-ID: <20230522112016.GI32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1684320689.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684320689.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 12:02:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add two optimizations to avoid falling back to transaction commits after
> an inode is evicted and some cleanups. More details on the changelogs.
> 
> Filipe Manana (5):
>   btrfs: use inode_logged() at need_log_inode()
>   btrfs: use inode_logged() at btrfs_record_unlink_dir()
>   btrfs: update comments at btrfs_record_unlink_dir() to be more clear
>   btrfs: remove pointless label and goto at btrfs_record_unlink_dir()
>   btrfs: change for_rename argument of btrfs_record_unlink_dir() to bool

Added to misc-next, thanks.
