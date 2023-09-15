Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A87A2333
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjIOQFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjIOQEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 12:04:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8397F101
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 09:04:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F33921904;
        Fri, 15 Sep 2023 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694793866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LuSUUrBCh/7dK9mpNLzp9XjQtNu1eHcIZFr5Ag8Rvg=;
        b=EjMaGM8KVfM/f0gtOwibUOqbHUjspcHLtpt4C7CpBf920Q/b6rDLJSwOrX2s8Vot0lxwXP
        E9Cv9Fn/idsxeEYE3KL/p8qIat3jcqQFUmZDqDS3tM/93yYpKzl7fiH2nA/yjkagLYtGxo
        cG3CPzK1DkHhKBP5JF6IHJ4XX1lY3FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694793866;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LuSUUrBCh/7dK9mpNLzp9XjQtNu1eHcIZFr5Ag8Rvg=;
        b=5szifuRADAbETElWcHZ8NTO7YfhLxm6vW0iRaGp0u7P6MGhRbz7KDGryoHbmU0IWVZvSny
        zCEqvX4tDTsvVtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26A841358A;
        Fri, 15 Sep 2023 16:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n86zCIqABGVsLAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 15 Sep 2023 16:04:26 +0000
Date:   Fri, 15 Sep 2023 17:57:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove useless comment from
 btrfs_pin_extent_for_log_replay()
Message-ID: <20230915155752.GG2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <46c6009d05086ab67d5f2d8c0ebe7d749f1d8cea.1694790077.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c6009d05086ab67d5f2d8c0ebe7d749f1d8cea.1694790077.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 04:03:57PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The comment on top of btrfs_pin_extent_for_log_replay() mentioning that
> the function must be called within a transaction is pointless as of
> commit 9fce5704542c ("btrfs: Make btrfs_pin_extent_for_log_replay take
> transaction handle"), since the function now takes a transaction handle
> as its first argument. So remove the comment because it's completely
> useless now.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
