Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F070A64F12A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 19:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiLPSlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 13:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiLPSk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 13:40:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FF6598C
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 10:40:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8ED5A34867;
        Fri, 16 Dec 2022 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671216024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCi3TXGGG0PIkLZEAxSeOfLqSowkzLGPAhwF1Z++8rc=;
        b=lwPguoA3PuyBH40d4leYTbN3m3Es/ikaiQ637AWP1QZpCtBzpV8yQTJFplvHNfuEKA84nE
        zTHFXGD/bfkddTo3V2t4ngr2WtmZ3WO3UcJqyalE3fXHpVe07GzwO4Gu1G0WZl7XDNC9RU
        noyj+iL5mEmZoHYsSasksoAsz9pjasw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671216024;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCi3TXGGG0PIkLZEAxSeOfLqSowkzLGPAhwF1Z++8rc=;
        b=ocdqTWz0dQWp3MJF5/xuFwZ/fTQGAwrSDZzTI36334KX5CqcEu5gzgNGFQ5tyru/I2dxoT
        vBUNXYE/7rse8vAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F47A138F0;
        Fri, 16 Dec 2022 18:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x8spGpi7nGNfXwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 16 Dec 2022 18:40:24 +0000
Date:   Fri, 16 Dec 2022 19:39:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix uninitialized return value in raid56 scrub
 code
Message-ID: <20221216183940.GJ10499@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df5b246d7aa5c8eb382b1e06c7bcf7a7f2fd9d59.1671209272.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 11:48:00AM -0500, Josef Bacik wrote:
> Fixes: 75b470332965 ("btrfs: raid56: migrate recovery and scrub recovery
> path to use error_bitmap") introduced an uninitialized return variable.
> I'm not entirely sure why this wasn't caught by the compiler, but I
> can't get any combination of compiler flags to catch it for us.

My gcc 12.1 catches that and a few more with -Wmaybe-uninitialized

  CC [M]  fs/btrfs/raid56.o
fs/btrfs/raid56.c: In function ‘scrub_rbio’:
fs/btrfs/raid56.c:2801:15: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
 2801 |         ret = recover_scrub_rbio(rbio);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/raid56.c:2649:13: note: ‘ret’ was declared here
 2649 |         int ret;

So once we fix them all we can add -Wmaybe-uninitialized to our Makefile
but we may see new warnings with older compilers.
