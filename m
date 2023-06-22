Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663873A73C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjFVR3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjFVR3e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 13:29:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C519AF;
        Thu, 22 Jun 2023 10:29:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 651E81F8BE;
        Thu, 22 Jun 2023 17:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687454968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/k3FqNVe41zvfCuSCrwE3jBBoJ6kCgPi1bqjDBr5U0=;
        b=xA2uzY8jV9V6Uf/uVtqqaCShKcZDE10vEvx7R7T++jLIkRWhfphkv+S9CjuiUa4PrdteHb
        uGFtRhuOwSleTclrnn3OKdwLg2USyhtBVO0lynC0uM+yDpIRxu+D47jhwS1zxGXntg9ot7
        FJA9Fb7wnv/80Rlop9sKljuesRv/SFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687454968;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/k3FqNVe41zvfCuSCrwE3jBBoJ6kCgPi1bqjDBr5U0=;
        b=tBOnqqXUNhHpdgzoCkgYGn203tUzW2YISNGWBmqHTgcRY3kB1b4CcNOkHk9I71FK2JgteW
        gDEVluOidJ0xPwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45520132BE;
        Thu, 22 Jun 2023 17:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPbrD/iElGQKWQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 22 Jun 2023 17:29:28 +0000
Date:   Thu, 22 Jun 2023 19:23:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Message-ID: <20230622172303.GV16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230622065438.86402-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622065438.86402-1-wqu@suse.com>
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

On Thu, Jun 22, 2023 at 02:54:38PM +0800, Qu Wenruo wrote:
> There is a recent regression during v6.4 merge window, that a u32 left
> shift overflow can cause problems with large data chunks (over 4G)
> sized.
> 
> This is especially nasty for RAID56, which can lead to ASSERT() during
> regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.
> 
> This is the regression test case for it.

I am not able to reproduce the problem with the previous fix
a7299a18a179a971 applied but not the additional one so I can't validate
the fix and will have to postpone sending the pull request.
