Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03D5691161
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Feb 2023 20:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBITcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Feb 2023 14:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBITcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Feb 2023 14:32:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CCF11E9D
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 11:32:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19BAE37AB4;
        Thu,  9 Feb 2023 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675971139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwDQxJqk7LvdIELIq1Ieo/0SaakVFxntl85Wa36+TmA=;
        b=gDswNo2UlKqODqf2FV5K364+F3Eod2MLA2Dk+ox4NXrNji23litzS4sbTvqCVkFMalKcWC
        h4GGnBcy6uboepjGDqe2lpTefiu/zMIDkiDK22cig0KGn9eSj9O/kW2dRV476HG1aBP1ci
        8tZr3PvQyDwVWn/cCSS2W2sKaE0yhn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675971139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwDQxJqk7LvdIELIq1Ieo/0SaakVFxntl85Wa36+TmA=;
        b=bW5luCjA6lCbDHW48h7QN7kZF9i8iN831E6Aue1fKVTKOo7nhT9RA0CV8V8N5XFSbLCkZi
        +psTYGjKaeB+hGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEFC91339E;
        Thu,  9 Feb 2023 19:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HT1SOUJK5WPwMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Feb 2023 19:32:18 +0000
Date:   Thu, 9 Feb 2023 20:26:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs-progs: minor fixes for clang warnings
Message-ID: <20230209192629.GO28288@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1674797823.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 27, 2023 at 01:41:13PM +0800, Qu Wenruo wrote:
> Recently I'm migrating my default compiler from GCC to clang, mostly to
> get short comiling time (especially important on my aarch64 machines).
> 
> Thus I hit those (mostly false alerts) warnings in btrfs-progs, and come
> up with this patchset.
> 
> Unfortunately there is still libbtrfsutils causing warnings in
> setuptools, as it's still using the default flags from gcc no matter
> what.
> 
> Qu Wenruo (5):
>   btrfs-progs: remove an unnecessary branch to silent the clang warning
>   btrfs-progs: fix a false alert on an uninitialized variable when
>     BUG_ON() is involved.
>   btrfs-progs: fix fallthrough cases with proper attributes
>   btrfs-progs: move a union with variable sized type to the end
>   btrfs-progs: fix set but not used variables

Added to devel, thanks.
