Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E7750D9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjGLQKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLQKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:10:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F6134
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:10:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E880322074;
        Wed, 12 Jul 2023 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689178245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1OUXA26EyObA+7TyNZLF02F0lBiP64/N8fxh+A1kVk=;
        b=hi2/42LjRHM22Epf8DjkSM5asUmfrchQiCexXRCRyZ4VpjqQv5yBec/1WzZJqVJ54yGXP7
        eO+SGfgzvXleRUq8jAzuaBtNsvDvc+q4MUr9h8FYYJTpqlc+BAH/pHxPfAEAVjA+rkAnHG
        A0DvXx0AhtjQ+3yo7tp8Pp6c8oQ99ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689178245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1OUXA26EyObA+7TyNZLF02F0lBiP64/N8fxh+A1kVk=;
        b=68VJ27mFm8svA3aANzaz4ea3N4fNWfkKMupaw8kylFReNi5VinsJPxa2V5hifZfE7EFkkw
        sJPXjFjljXJ8q+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C82D5133DD;
        Wed, 12 Jul 2023 16:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B8ydL4XQrmSBYwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 12 Jul 2023 16:10:45 +0000
Date:   Wed, 12 Jul 2023 18:04:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: remove a couple BUG_ON()s and cleanups
Message-ID: <20230712160409.GK30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1688137155.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 30, 2023 at 04:03:43PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The first patch removes  a couple unnecessary BUG_ON()'s, since all
> callers are able to properly deal with errors, which are triggered by
> syzbot with error injection (-ENOMEM). The rest are just some followup
> cleanups. More details in the changelogs.
> 
> Filipe Manana (8):
>   btrfs: remove BUG_ON()'s in add_new_free_space()
>   btrfs: update documentation for add_new_free_space()
>   btrfs: rename add_new_free_space() to btrfs_add_new_free_space()
>   btrfs: make btrfs_destroy_marked_extents() return void
>   btrfs: make btrfs_destroy_pinned_extent() return void
>   btrfs: make find_first_extent_bit() return a boolean
>   btrfs: open code trivial btrfs_add_excluded_extent()
>   btrfs: move btrfs_free_excluded_extents() into block-group.c

Nice cleanups, added to misc-next, thanks.
