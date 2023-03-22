Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8702A6C5519
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Mar 2023 20:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCVTmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCVTmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 15:42:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698664271
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 12:42:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92B435BDD6;
        Wed, 22 Mar 2023 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679514133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRX7Ik4JOaiuZDyp9oz2K0PSbRy7x/BKJ02dW7QkCtc=;
        b=bRnSJARJ+/3guJChdVTKcUXNoR/ssNTbTrF3vVHcSC6JMztCaUKz+MF1Ni2ntgNaT5rWCT
        rgv7DpiZXmXjM2jDXiEmsDf2sGIp2z0swt563VY2pcFLybxEGwmjpUYwJP9GuJzHjTR+li
        toAVFolPmUeEmdoOg5ZXD6TKPKXfr+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679514133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRX7Ik4JOaiuZDyp9oz2K0PSbRy7x/BKJ02dW7QkCtc=;
        b=5JBG2iWrqC7WBaZ+WXzAh5Xmku8qDolKIlFK1e3VgT0WwSHhDjBQV7bcTycHIeptIYiflS
        wH52h9sRqh+xLECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7782F138E9;
        Wed, 22 Mar 2023 19:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IYU6HBVaG2QQWAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 22 Mar 2023 19:42:13 +0000
Date:   Wed, 22 Mar 2023 20:36:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_lru_cache_is_full() inline function
Message-ID: <20230322193602.GT10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aa7f733f40ef92199f6130e83e4d88ca861d92f7.1679398596.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7f733f40ef92199f6130e83e4d88ca861d92f7.1679398596.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 21, 2023 at 11:37:04AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> It's not used anywhere at the moment, but it was used in earlier version
> of a patch that removed its use in the second version. So just remove
> btrfs_lru_cache_is_full().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
